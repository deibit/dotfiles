# Automatically activates venv if ./venv/ exists in curent directory
#   Go to your project folder, run "pip virtualenv <.venv|venv>", so your project folder
#   has a <.venv|venv> folder at the top level
#   .
#   ├── <other_project_files>
#   ├── ...
#   └── <.venv|venv|.env|env>
#       ├── bin
#       ├── include
#       └── lib
#
#   The virtualenv will be activated automatically when you enter the directory.
#   To deactivate run `deactivate` and to manually activate run `activatevenv`
function activatevenv() {
  # Names of possible virtualenv directories
  VIRTUALENV_DIRS=("venv/" "env/" ".env/" ".venv/" "${PWD##*/}")

  for dir in $VIRTUALENV_DIRS; do
    if [[ -d "${dir}" ]]; then
      # Found a possible venv directory
      # Try activating the venv
      if [[ -e "./${dir}/bin/activate" ]]; then
        source ./$dir/bin/activate
        break
      fi
    fi
  done

}
activatevenv

# Extension for `cd` command in order to automatically activate virtualenv when changin directories.
function cd() {
  builtin cd $1
  # Try activating venv
  activatevenv
}
