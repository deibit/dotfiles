# Dotfiles

Configuración de terminal para macOS y Linux. Reúne zsh, tmux, Neovim y herramientas de línea de comandos con los mismos atajos y un aspecto familiar en distintas máquinas. Está pensada especialmente para usar Ghostty en macOS y trabajar por SSH en Linux.

## Compatibilidad

- macOS con Homebrew. Si falta, el instalador lo instala.
- Linux con `apt-get`, en máquinas x86_64 o arm64.
- Conexión a Internet durante la primera instalación. En Linux, hace falta poder usar `sudo` para instalar paquetes.

Ejecuta el instalador con tu usuario habitual, sin `sudo` delante. El propio script pedirá los permisos necesarios. Necesitas Git para clonar el repositorio.

## Instalación

```sh
git clone https://github.com/deibit/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

El instalador prepara zsh y Oh My Zsh, tmux, Neovim, Git, fzf, fd, ripgrep, direnv, Starship, uv, zoxide, Node, Go, Python y las herramientas que usa Neovim. En Linux utiliza `apt` para los paquetes del sistema y archivos oficiales para Neovim, Go y tree-sitter CLI. También instala los plugins, analizadores, servidores de lenguaje, formateadores y linters de Neovim; esta parte puede tardar varios minutos la primera vez.

Activa zsh como shell de inicio. Abre una nueva sesión de terminal cuando termine la instalación.

Ghostty no se instala automáticamente, aunque su configuración queda enlazada si ya lo utilizas. Tampoco se instalan aplicaciones o servicios como Docker.

## Archivos y datos personales

Las configuraciones instaladas son enlaces simbólicos a este repositorio. Los cambios que hagas aquí se reflejan en la máquina sin volver a copiar archivos. Si existe un archivo o directorio en una ruta de destino, el instalador lo conserva con el sufijo `*.backup.FECHA` antes de crear el enlace. Se respeta `XDG_CONFIG_HOME`.

La configuración común de Git está en `gitconfig.common`. Configura tu identidad por separado:

```sh
git config --global user.name "Tu nombre"
git config --global user.email "tu@email.com"
```

Un `~/.gitconfig` existente se conserva.

## Uso y mantenimiento

- Puedes ejecutar `./install.sh` de nuevo: conserva los enlaces correctos e instala lo que falte. No actualiza automáticamente las herramientas que ya estén instaladas.
- `./install.sh --link-only` crea los enlaces sin instalar paquetes ni preparar Neovim.
- Las versiones de los plugins de Neovim se guardan en `nvim/lazy-lock.json`. Tras actualizar este repositorio en otra máquina, usa `:Lazy restore` en Neovim para aplicar esas versiones.

### tmux

El prefijo es `Ctrl-a`. Después del prefijo, `r` recarga la configuración, `v` divide horizontalmente y `s` divide verticalmente; las divisiones se abren en el directorio actual. Sin prefijo, `Ctrl-h/j/k/l` cambia de panel y, si el panel ejecuta Vim o Neovim, pasa la tecla al editor. En modo copia, `v` inicia la selección, `V` selecciona una línea y `y` copia.

La copia usa OSC 52, también útil en sesiones SSH con un terminal compatible. Si Linux no dispone de la entrada terminfo de Ghostty, la sesión utiliza `xterm-256color`.
