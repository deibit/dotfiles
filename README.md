# Dotfiles

Entorno de terminal para macOS y Linux, con zsh, tmux y Neovim. Dos perfiles explícitos: **slim** para editar y ejecutar en máquinas de ejecución, y **fat** para desarrollar. Especialmente pensado para Ghostty en macOS y sesiones SSH en Linux.

## Instalación

```sh
git clone https://github.com/deibit/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh --slim  # o --fat
```

Ejecuta el instalador como usuario habitual, sin `sudo` delante. Las operaciones del sistema pedirán los permisos necesarios. Necesitas Git para clonar y conexión a Internet para instalar paquetes y plugins.

**Sin argumentos, el instalador muestra la ayuda y sale sin cambios.**

```sh
./install.sh --help
./install.sh --slim
./install.sh --fat
./install.sh --slim --link-only
./install.sh --fat --link-only
./install.sh --doctor
./install.sh --doctor --slim
./install.sh --doctor --fat
```

`--slim` y `--fat` son incompatibles. `--link-only` exige un perfil: crea enlaces y guarda la selección, sin instalar paquetes, preparar plugins ni cambiar el shell de inicio. `--doctor` (también `--check`) diagnostica sin reparar ni descargar; devuelve un código distinto de cero si falta algo. Sin perfil explícito lee la selección guardada.

## Perfiles

| Componente | slim | fat |
| --- | --- | --- |
| zsh, Oh My Zsh y resaltado de sintaxis | Sí | Sí |
| Git, tmux, Neovim, fzf, fd, ripgrep | Sí | Sí |
| Go, uv, direnv | Sí | Sí |
| Starship y zoxide | No | Sí |
| Node/npm, Python del sistema, Tree-sitter CLI y cppcheck | No se instalan expresamente | Sí |
| Herramientas de compilación en Linux | No se instalan expresamente | Sí |
| Neovim ligero para buscar y editar | Sí | Sí |
| Neovim completo con LSP, parsers, tests, linters y formateadores | No | Sí |

**slim** conserva los runtimes para ejecutar aplicaciones. uv gestiona los Python necesarios; el instalador no descarga un Python concreto ni instala las dependencias de los proyectos. Go puede ejecutar o compilar programas Go. Otros runtimes, bibliotecas nativas y servicios que necesite una aplicación se preparan por separado.

El shell slim usa el tema `robbyrussell` de Oh My Zsh. No activa Starship ni zoxide aunque estén instalados. **fat** mantiene el entorno completo anterior y añade `vslim`. Las dependencias transitivas del gestor de paquetes pueden incorporar otras herramientas.

El perfil se guarda como texto en `$XDG_CONFIG_HOME/dotfiles/profile`. Cambiar de perfil no desinstala herramientas ni borra sus datos. Al cambiarlo, abre una sesión nueva para actualizar el shell y el editor predeterminado.

## Compatibilidad y versiones

- macOS con Homebrew; el instalador lo instala si falta.
- Linux con `apt-get`, x86_64 o arm64, y acceso a `sudo`.
- Neovim >= 0.10 para slim y >= 0.12 para fat. El perfil completo usa funciones y plugins integrados de esa versión.
- tmux con soporte de `source-file -F`, `terminal-features` y `allow-passthrough` (usa una versión moderna, >= 3.3).

En Linux se descargan archivos oficiales de Neovim y Go; fat también descarga Tree-sitter CLI. Las herramientas ausentes se instalan con la versión disponible en el gestor de paquetes o con la estable publicada. Las herramientas ya instaladas no se actualizan automáticamente: el instalador comprueba el mínimo de Neovim y avisa si no se cumple.

Los plugins fat están fijados en `nvim/lazy-lock.json`; usa `:Lazy restore` para restaurarlos. Mini para slim está fijado en `nvim-slim/mini.version`: reinstalar cualquiera de los perfiles aplica esa revisión, siempre que no haya cambios locales en su copia. Mason y los parsers no tienen versiones fijadas; dos instalaciones nuevas pueden diferir en esas herramientas.

## Neovim

| Comando | Máquina slim | Máquina fat |
| --- | --- | --- |
| `nvim` / alias `vim` | Ligero | Completo |
| `vslim` | Ligero | Ligero |
| `$EDITOR` / `$VISUAL` | `vslim` | `nvim` |

`vslim` es un ejecutable en `~/.local/bin`, no solo un alias. Utiliza `NVIM_APPNAME=nvim-slim` y separa configuración, datos, caché y estado del editor completo. En slim, zsh también selecciona ese nombre para `nvim`.

El editor ligero usa sintaxis tradicional de Neovim y unos módulos de Mini para búsqueda, exploración, objetos de texto, delimitadores y alineación. No configura LSP ni Tree-sitter, formateadores, linters o tests. No descarga nada al abrirse. [Guía y atajos de slim](nvim-slim/README.md).

Si solo has usado `--link-only` y Mini no está instalado, puedes editar y usar netrw; el editor muestra cómo preparar los plugins. La búsqueda interactiva avanzada estará disponible tras la instalación completa del perfil.

## Archivos y ajustes personales

Los archivos instalados son enlaces simbólicos al repositorio. Si ya existe un archivo, directorio o enlace distinto, se conserva con el sufijo `*.backup.FECHA`. Se respetan `XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_STATE_HOME` y `XDG_CACHE_HOME` para los datos del editor. Oh My Zsh y el resaltado del shell mantienen sus ubicaciones bajo `HOME`.

Puedes añadir ajustes privados del shell en `~/.zshrc.local`. Se cargan al final, después de la configuración del perfil.

La configuración común de Git está en `gitconfig.common`; un `~/.gitconfig` existente se conserva. Configura tu identidad por separado:

```sh
git config --global user.name "Tu nombre"
git config --global user.email "tu@email.com"
```

Ghostty no se instala automáticamente; se enlaza su configuración. Tampoco se instalan Docker u otros servicios. La integración `layout uv` de direnv utiliza siempre la `.venv` del proyecto, incluso si otro entorno virtual está activo.

## tmux y SSH

Prefijo `Ctrl-a`. Después del prefijo: `r` recarga desde la ruta XDG, `v` divide horizontalmente, `s` verticalmente. Las divisiones se abren en el directorio actual. `Ctrl-h/j/k/l` cambia de panel y pasa al editor si ejecuta Vim o Neovim. En modo copia: `v` selecciona, `V` selecciona una línea e `y` copia.

La copia usa OSC 52 en terminales compatibles. Si Linux no dispone de la entrada terminfo de Ghostty, el shell de inicio por SSH utiliza `xterm-256color`. `--doctor` comprueba las entradas terminfo disponibles; no puede confirmar por sí solo que el terminal remoto acepta OSC 52.

## Comprobaciones del repositorio

```sh
python3 -m unittest discover -s tests -v
sh -n install.sh scripts/bootstrap-slim.sh scripts/doctor.sh bin/vslim
zsh -n zshrc zshenv.macos zshenv.linux zprofile.macos zprofile.linux
bash -n direnvrc
```

Las pruebas usan HOME y rutas XDG temporales. Cubren ayuda, argumentos, enlaces, backups, reinstalación, cambio de perfil, diagnóstico sin escritura y selección de paquetes Linux con comandos simulados. Las pruebas del editor necesitan Neovim; la prueba con plugins utiliza una copia local existente de Mini y se omite si no está disponible. No instalan paquetes ni cambian el shell del usuario.
