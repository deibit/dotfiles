# Neovim fat

Configuración completa para desarrollo. Se instala con `../install.sh --fat` y requiere Neovim >= 0.12. El editor ligero se abre con `vslim`; [sus atajos y límites](../nvim-slim/README.md) están documentados por separado.

## Herramientas y mantenimiento

`lua/config/tooling.lua` define las herramientas de Mason y los parsers de Tree-sitter que prepara el instalador. `lsp/` contiene las configuraciones de servidores. `lua/plugins/` configura búsqueda, Git, formato, lint y tests, entre otras funciones.

Los plugins están fijados en `lazy-lock.json`. Tras actualizar el repositorio, `:Lazy restore` aplica esas revisiones. `:Mason` permite gestionar las herramientas; el instalador prepara las que falten, pero no actualiza automáticamente las ya instaladas.

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
| `,L` / `,M` | Lazy / Mason |
| `,ld` / `,lr` | Definiciones / referencias |
| `,lx` / `,lX` | Diagnósticos del búfer / globales |
| `,gs` / `,gd` | Estado Git / diferencias |
| `,ll` | Ejecutar lint |
| `:ConformToggle` | Activar o desactivar autoformato global |
| `:LspInfo` / `:LspLog` / `:LspRestart` | Diagnóstico y mantenimiento LSP |
| `:Term` | Terminal en split |

Python y Go tienen adaptadores de Neotest. Los proyectos deben aportar sus dependencias de tests y sus configuraciones de herramientas. El formato se ejecuta después de guardar; revisa `lua/plugins/conform.lua` para los formateadores y opciones aplicados.

## Diagnóstico

Desde el repositorio ejecuta `./install.sh --doctor --fat`. Comprueba enlaces, comandos, mínimo de Neovim, presencia de plugins, herramientas Mason y parsers sin arrancar esta configuración ni iniciar descargas. Dentro del editor, `:checkhealth`, `:LspInfo` y `:ConformInfo` ofrecen más detalle sobre el funcionamiento real de cada integración.
