"""Integración del instalador con HOME/XDG temporales; no instala paquetes."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

REPO = Path(__file__).resolve().parents[1]


class InstallTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="dotfiles-test-")
        self.addCleanup(self.tmp.cleanup)
        self.home = Path(self.tmp.name) / "home with spaces"
        self.home.mkdir()
        self.config = self.home / "custom config"
        self.env = dict(os.environ, HOME=str(self.home), XDG_CONFIG_HOME=str(self.config),
                        XDG_DATA_HOME=str(self.home / "data"), XDG_STATE_HOME=str(self.home / "state"),
                        XDG_CACHE_HOME=str(self.home / "cache"), NVIM_LOG_FILE="/dev/null")
        self.env.pop("NVIM_APPNAME", None)

    def run_install(self, *args):
        return subprocess.run([str(REPO / "install.sh"), *args], env=self.env,
                              text=True, capture_output=True, timeout=30)

    def install(self, profile):
        result = self.run_install("--" + profile, "--link-only")
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_help_and_invalid_arguments_never_write(self):
        for args, code in [((), 0), (("--help",), 0), (("--slim", "--fat"), 2),
                           (("--link-only",), 2), (("--nope",), 2),
                           (("--doctor", "--link-only"), 2), (("--fat", "--fat"), 2),
                           (("--doctor",), 2)]:
            result = self.run_install(*args)
            self.assertEqual(result.returncode, code, result.stderr)
            self.assertEqual(list(self.home.iterdir()), [])

    def test_slim_links_and_idempotence(self):
        self.install("slim")
        self.assertEqual((self.config / "nvim").resolve(), REPO / "nvim-slim")
        self.assertEqual((self.config / "nvim-slim").resolve(), REPO / "nvim-slim")
        self.assertFalse((self.config / "starship.toml").exists())
        self.assertTrue(os.access(self.home / ".local/bin/vslim", os.X_OK))
        self.install("slim")
        self.assertEqual(list(self.home.rglob("*.backup.*")), [])

    def test_backups_broken_links_and_profile_switch(self):
        self.config.mkdir()
        (self.home / ".zshrc").write_text("keep this")
        (self.config / "nvim").mkdir()
        (self.config / "nvim/original").write_text("keep too")
        (self.config / "nvim-slim").symlink_to("/nonexistent-dotfiles-test")
        self.install("slim")
        self.assertEqual(next(self.home.glob(".zshrc.backup.*")).read_text(), "keep this")
        self.assertEqual(next(self.config.glob("nvim.backup.*")).joinpath("original").read_text(), "keep too")
        self.assertTrue(next(self.config.glob("nvim-slim.backup.*")).is_symlink())
        self.install("fat")
        self.assertEqual((self.config / "nvim").resolve(), REPO / "nvim")
        self.assertEqual((self.config / "dotfiles/profile").read_text(), "fat\n")
        self.install("slim")
        self.assertEqual((self.config / "nvim").resolve(), REPO / "nvim-slim")

    def test_doctor_is_read_only_and_reports_missing_tools(self):
        self.install("slim")
        before = sorted(str(p.relative_to(self.home)) for p in self.home.rglob("*"))
        result = self.run_install("--doctor")
        self.assertEqual(result.returncode, 1)
        self.assertIn("Diagnóstico del perfil slim", result.stdout)
        self.assertIn("Mini ausente", result.stdout)
        self.assertEqual(before, sorted(str(p.relative_to(self.home)) for p in self.home.rglob("*")))

    def test_editor_environment_when_switching_profiles(self):
        for profile, editor, appname in [("slim", "vslim", "nvim-slim"), ("fat", "nvim", "")]:
            self.install(profile)
            env = dict(self.env, NVIM_APPNAME="nvim-slim")
            result = subprocess.run(["zsh", "-c", 'printf "%s|%s" "$EDITOR" "${NVIM_APPNAME:-}"'],
                                    env=env, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout, f"{editor}|{appname}")

    def test_linux_package_selection_without_installing(self):
        mock = self.home / "mocks"
        mock.mkdir()
        scripts = {
            "uname": '#!/bin/sh\necho Linux\n',
            "apt-get": '#!/bin/sh\nexit 99\n',
            "dpkg-query": '#!/bin/sh\nexit 1\n',
            "id": '#!/bin/sh\necho 1000\n',
            "sudo": '#!/bin/sh\ncase "$*" in *install*) printf "%s\\n" "$*" > "$HOME/packages"; exit 23;; esac\n',
        }
        for name, body in scripts.items():
            path = mock / name
            path.write_text(body)
            path.chmod(0o755)
        self.env["PATH"] = str(mock) + os.pathsep + os.environ["PATH"]
        for profile in ["slim", "fat"]:
            result = self.run_install("--" + profile)
            self.assertEqual(result.returncode, 23, result.stderr)
            packages = (self.home / "packages").read_text().split()
            for name in ["zsh", "tmux", "fzf", "ripgrep", "fd-find", "direnv"]:
                self.assertIn(name, packages)
            for name in ["nodejs", "python3", "unzip", "build-essential", "cppcheck"]:
                self.assertEqual(name in packages, profile == "fat")

    def test_direnv_uses_project_venv_and_stops_on_creation_failure(self):
        project = self.home / "project"
        project.mkdir()
        (project / ".venv").mkdir()
        env = dict(self.env, VIRTUAL_ENV=str(self.home / "external"))
        (self.home / "external").mkdir()
        script = 'log_status() { :; }; PATH_add() { :; }; source "$1"; layout_uv; printf "%s" "$VIRTUAL_ENV"'
        result = subprocess.run(["bash", "-c", script, "check", str(REPO / "direnvrc")],
                                env=env, cwd=project, text=True, capture_output=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(Path(result.stdout).resolve(), (project / ".venv").resolve())
        (project / ".venv").rmdir()
        script = 'log_status() { :; }; PATH_add() { :; }; uv() { return 17; }; source "$1"; layout_uv'
        result = subprocess.run(["bash", "-c", script, "check", str(REPO / "direnvrc")],
                                env=env, cwd=project, text=True, capture_output=True)
        self.assertEqual(result.returncode, 17, result.stderr)

    def test_bootstrap_pins_revision_and_preserves_local_changes(self):
        repo = self.home / "fixture"
        (repo / "nvim-slim").mkdir(parents=True)
        plugin = self.home / "data/nvim-slim/site/pack/dotfiles/start/mini.nvim"
        plugin.mkdir(parents=True)
        def git(*args):
            result = subprocess.run(["git", "-C", str(plugin), *args], env=self.env,
                                    capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            return result.stdout.strip()
        git("init", "-q")
        git("config", "user.name", "Test")
        git("config", "user.email", "test@example.invalid")
        (plugin / "fixture").write_text("first")
        git("add", "fixture")
        git("-c", "commit.gpgsign=false", "commit", "-qm", "first")
        revision = git("rev-parse", "HEAD")
        (repo / "nvim-slim/mini.version").write_text(revision + "\n")
        (plugin / "fixture").write_text("second")
        git("add", "fixture")
        git("-c", "commit.gpgsign=false", "commit", "-qm", "second")
        for _ in range(2):
            result = subprocess.run(["sh", str(REPO / "scripts/bootstrap-slim.sh"), str(repo)],
                                    env=self.env, text=True, capture_output=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(git("rev-parse", "HEAD"), revision)
        (plugin / "fixture").write_text("private changes")
        result = subprocess.run(["sh", str(REPO / "scripts/bootstrap-slim.sh"), str(repo)],
                                env=self.env, text=True, capture_output=True)
        self.assertEqual(result.returncode, 1)
        self.assertEqual((plugin / "fixture").read_text(), "private changes")

    @unittest.skipUnless(shutil.which("nvim") and
                         (Path.home() / ".local/share/nvim/lazy/mini.nvim/lua/mini/pick.lua").exists(),
                         "Necesita una copia local de Mini para verificar sin red")
    def test_slim_with_plugins_search_preview_and_isolation(self):
        self.install("slim")
        plugin = self.home / "data/nvim-slim/site/pack/dotfiles/start/mini.nvim"
        shutil.copytree(Path.home() / ".local/share/nvim/lazy/mini.nvim", plugin,
                        ignore=shutil.ignore_patterns(".git"))
        sample = self.home / "sample.txt"
        sample.write_text("first\nsecond\n")
        script = self.home / "verify.lua"
        script.write_text("""
assert(package.loaded['mini.pick'] and package.loaded['mini.files'])
assert(package.loaded['mini.surround'] and package.loaded['mini.align'] and package.loaded['mini.ai'])
assert(not package.loaded['lazy'] and not package.loaded['mason'])
assert(#vim.lsp.get_clients() == 0)
assert(vim.fn.stdpath('data'):match('nvim%-slim$'))
vim.fn.maparg(',e', 'n', false, true).callback()
assert(MiniFiles.get_explorer_state() ~= nil)
MiniFiles.close()
local preview = vim.api.nvim_create_buf(false, true)
MiniPick.config.source.preview(preview, { path = vim.env.HOME .. '/sample.txt', lnum = 2 })
assert(vim.api.nvim_buf_get_lines(preview, 0, -1, false)[2] == 'second')
vim.defer_fn(function()
    MiniPick.set_picker_query({'sample'})
    vim.defer_fn(function() vim.api.nvim_input(vim.api.nvim_replace_termcodes('<CR>', true, false, true)) end, 100)
end, 100)
MiniPick.builtin.files({tool='fallback'})
assert(vim.api.nvim_buf_get_name(0):match('sample.txt$'))
assert(vim.bo.undofile and vim.bo.swapfile == false)
vim.cmd('qa!')
""")
        result = subprocess.run([str(REPO / "bin/vslim"), "--headless", "-i", "NONE",
                                 "--cmd", "lua vim.treesitter.start = function() error('Tree-sitter must stay off') end; vim.treesitter.get_parser = function() error('No parsers') end",
                                 "-c", "lua dofile(vim.env.HOME .. '/verify.lua')"],
                                env=self.env, capture_output=True, text=True, timeout=15, cwd=self.home)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertNotIn("Error", result.stderr)
        self.assertFalse((self.home / "data/nvim").exists())

    @unittest.skipUnless(shutil.which("nvim"), "Neovim necesario")
    def test_slim_editor_without_plugins_never_downloads(self):
        self.install("slim")
        self.env["PATH"] = str(self.home / ".local/bin") + os.pathsep + os.environ["PATH"]
        result = subprocess.run([str(REPO / "bin/vslim"), "--headless", "-i", "NONE",
                                 "-c", "lua assert(vim.fn.stdpath('data'):match('nvim%-slim$')); assert(#vim.lsp.get_clients() == 0)",
                                 "-c", "qa"], env=self.env, capture_output=True, text=True, timeout=15)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("Mini no está instalado", result.stderr)
        self.assertFalse((self.home / "data/nvim-slim/site/pack").exists())


if __name__ == "__main__":
    unittest.main()
