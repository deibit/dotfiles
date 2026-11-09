# Neovim fat

Configuración para edición y búsqueda de archivos. Se instala con `../install.sh --fat` y requiere Neovim >= 0.12. El editor ligero se abre con `vslim`; [sus atajos y límites](../nvim-slim/README.md) están documentados por separado.

## Herramientas y mantenimiento

`lua/config/tooling.lua` define los parsers de Tree-sitter que prepara el instalador.

Los plugins están fijados en `lazy-lock.json`. Tras actualizar el repositorio, `:Lazy restore` aplica esas revisiones.

## Atajos y comandos

El líder es `,`.

| Tecla o comando | Acción |
| --- | --- |
| `,w` | Guardar |
| `,f` / `,F` | Archivos / archivos recientes |
| `Espacio` | Búferes |
| `,S` / `,sw` | Buscar texto / palabra |
| `,e` | Explorador |
| `Ctrl-h/j/k/l` | Cambiar de panel |
| `,L` | Lazy |
| `:ConformToggle` | Activar o desactivar autoformato global |

Conform formatea después de guardar. Instala con Homebrew los formateadores que necesites y asegúrate de que Neovim los vea en el `PATH`. Conform avisa al guardar si ninguno de los formateadores configurados para ese tipo de archivo está disponible. `:ConformInfo` muestra los formateadores y su disponibilidad.

## Diagnóstico

Desde el repositorio ejecuta `./install.sh --doctor --fat`. Comprueba enlaces, comandos, mínimo de Neovim, presencia de plugins y parsers sin arrancar esta configuración ni iniciar descargas. Dentro del editor, `:checkhealth` y `:ConformInfo` ofrecen más detalle sobre el funcionamiento real de cada integración.
