if [[ -e .python-version ]]; then
  VENV=$(cat .python-version)
elif [[ -n "$PYENV_VIRTUAL_ENV" ]]; then
  VENV=$(basename "$PYENV_VIRTUAL_ENV")
else
  VENV=""
fi

if command -v python &>/dev/null; then
  PYVER=$(basename python -V)
elif command -v python3 &>/dev/null; then
  PYVER=$(basename python3 -V)
fi
echo $PYVER $VENV
