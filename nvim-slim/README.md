# Neovim slim

Editor para administración, búsqueda y edición potente. Comparte binario con el editor completo, pero utiliza la configuración `nvim-slim` y datos separados. Ejecuta `vslim` desde cualquiera de los perfiles; en una máquina slim también es el editor predeterminado.

Mini se prepara durante `install.sh --slim` o `--fat`, en la revisión de `mini.version`. El arranque no clona plugins ni instala herramientas. Sin Mini, la edición básica y netrw siguen disponibles.

## Atajos

El líder es `,`. Las acciones de Mini necesitan que el instalador haya preparado los plugins.

| Tecla | Acción |
| --- | --- |
| `,w` | Guardar |
| `,f` | Buscar archivos |
| `,F` | Archivos recientes |
| `Espacio` | Buscar búferes |
| `,S` | Buscar texto en el directorio actual |
| `,sw` | Buscar la palabra bajo el cursor |
| `,e` | Explorar archivos; pulsa `g?` para ayuda del explorador |
| `,x` | Cerrar búfer |
| `,"` / `,%` | Split vertical / horizontal |
| `Ctrl-h/j/k/l` | Cambiar de panel |
| `,X` | Cerrar panel |
| `,P` / `,C` | Copiar ruta absoluta / contenido |
| `,T` o `:Term` | Terminal en split |
| `Esc Esc` en terminal | Volver al modo normal |
| `[q` / `]q` / `,q` | Quickfix anterior / siguiente / abrir |
| `jj` en inserción | Salir de inserción |
| `U` | Rehacer |
| `sa` / `sd` / `sr` | Añadir / borrar / reemplazar delimitadores |
| `ga` / `gA` | Alinear / alinear con previsualización |

En los selectores: escribe para filtrar, `Enter` abre, `Ctrl-n/p` navega, `Tab` muestra la previsualización, `Ctrl-s/v` abre en split y `Esc` cierra. La previsualización usa sintaxis tradicional; los archivos de más de 2 MiB se abren directamente para consultarlos.

La búsqueda de archivos respeta las exclusiones del buscador elegido por Mini. Para búsquedas concretas puedes usar `:grep patrón` y `:copen`, o ejecutar `rg` desde la terminal con tus opciones.

Mini.ai añade objetos de texto como argumentos (`ia`/`aa`) y delimitadores. Consulta `:help MiniAi-textobjects`, `:help MiniSurround` y `:help MiniAlign`.

## Límites deliberados

Sintaxis tradicional incluida en Neovim, sin configuración personalizada por lenguaje. Autocompletado nativo: `Ctrl-n/p` para palabras y `Ctrl-x Ctrl-f` para rutas. Sin LSP, parsers Tree-sitter, Mason, diagnósticos, autoformato, lint o ejecución de tests.

Se conserva el historial de deshacer. Para archivos mayores de 2 MiB se desactivan el resaltado y la persistencia de deshacer. El portapapeles usa el proveedor que Neovim encuentre; en SSH puede depender de OSC 52 y de la compatibilidad del terminal y tmux.
