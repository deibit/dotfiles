# Dotfiles

Entorno de terminal coherente para macOS y Linux con `apt`. Ghostty en macOS es el terminal principal; la configuración también funciona al entrar por SSH en Linux.

## Instalar en una máquina nueva

```sh
git clone https://github.com/deibit/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

Estas son las dos operaciones: clonar y ejecutar el instalador. Se puede repetir la segunda después de actualizar el repositorio: solo instala paquetes ausentes y los enlaces ya correctos no se vuelven a crear. Repetirla no actualiza las versiones instaladas.

El instalador instala Git, zsh, Oh My Zsh, tmux, Neovim, fzf, fd, ripgrep, direnv, Starship, uv, zoxide, Node, Go, tree-sitter CLI, cppcheck y el resaltado de sintaxis de zsh. En macOS instala zsh con Homebrew, registra su ruta en `/etc/shells` y la activa como shell de inicio. En Linux instala zsh con `apt` y también la activa como shell de inicio. El cambio de shell puede pedir la contraseña del usuario. Homebrew se instala si falta.

En Linux se usa `apt` para la base y los instaladores o archivos oficiales para Neovim, Go, tree-sitter CLI, uv, Starship y zoxide. Neovim se descarga del [proyecto oficial](https://neovim.io/doc/install/) para x86_64 o arm64, sin compilarlo. El instalador también prepara los plugins, analizadores, servidores, formateadores y linters de Neovim; la primera ejecución requiere conexión a Internet y puede tardar unos minutos. Los plugins usan las revisiones guardadas en `nvim/lazy-lock.json`.

Las configuraciones se enlazan al repositorio. Si ya existe un archivo o directorio en el destino, se mueve a `*.backup.FECHA` antes de crear el enlace. El instalador respeta `XDG_CONFIG_HOME`. Para revisar solo los enlaces sin instalar paquetes: `./install.sh --link-only`.

La configuración común de Git se enlaza desde `gitconfig.common`. La identidad es personal y permanece en `~/.gitconfig`: configura el nombre y el correo con `git config --global user.name ...` y `git config --global user.email ...` antes de crear commits. Un `~/.gitconfig` existente se conserva.

## Qué se ha simplificado

- Una configuración de tmux. Conserva los atajos de navegación y división de paneles, pero utiliza `tmux-256color`, copia estilo Vim y OSC 52. Ghostty puede instalar automáticamente su entrada terminfo al conectar por SSH; si falla, Linux usa `xterm-256color` como alternativa.
- Un solo instalador. Sustituye a `infect.sh` y al script separado para instalar zsh con Homebrew. No crea enlaces a los archivos de Lazygit y Yazi que se han eliminado.
- Oh My Zsh se carga una sola vez con el plugin `git`; Starship se encarga del prompt. Se eliminaron rutas personales, plugins duplicados y la necesidad de Rust nightly para `blink.cmp`.

Docker y Ghostty son aplicaciones o servicios y quedan fuera de la instalación automática. Atuin, Yazi y Lazygit tampoco se instalan: no intervienen en el arranque de este entorno. La configuración de Ghostty sí se enlaza para quien ya lo usa.

## tmux

El prefijo es `Ctrl-a`. `Ctrl-a r` recarga la configuración; `Ctrl-h/j/k/l` cambia de panel o pasa la tecla a Vim. `Ctrl-a v` divide horizontalmente y `Ctrl-a s` verticalmente, ambos en el directorio actual. `%` y `"` mantienen la orientación tradicional de tmux. En modo copia, `v` inicia la selección, `V` selecciona la línea y `y` copia al portapapeles del terminal.
