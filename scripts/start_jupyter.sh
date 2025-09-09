#!/bin/bash
# Wrapper para iniciar Jupyter Notebook com verificação/instalação automática do pacote "notebook"
set -euo pipefail

# argumentos passados para o módulo notebook
ARGS=()
while [[ $# -gt 0 ]]; do
  ARGS+=("$1")
  shift
done

# Escolher comando python e pip
if command -v python3 &> /dev/null; then
  PYTHON_CMD=python3
  PIP_CMD=pip3
elif command -v python &> /dev/null; then
  PYTHON_CMD=python
  PIP_CMD=pip
else
  echo "❌ Python não encontrado. Instale o Python 3.x primeiro."
  exit 1
fi

echo "🔎 Verificando se o módulo 'notebook' está disponível para $($PYTHON_CMD --version 2>&1)..."
if $PYTHON_CMD -c "import notebook" &> /dev/null; then
  echo "✅ Módulo 'notebook' encontrado. Iniciando..."
else
  echo "⚠️ Módulo 'notebook' não encontrado. Instalando (local user)..."
  # tenta instalar no escopo do usuário para evitar necessidade de sudo
  $PIP_CMD install --user --upgrade notebook jupyterlab
  # garantir que ~/.local/bin esteja no PATH para esta execução
  export PATH="$HOME/.local/bin:$PATH"
  if ! $PYTHON_CMD -c "import notebook" &> /dev/null; then
    echo "❌ Falha ao instalar 'notebook'. Verifique o pip/path e instale manualmente: 'pip install --user notebook'"
    exit 1
  fi
  echo "✅ Instalação concluída. Iniciando..."
fi

# Executar o notebook com os argumentos passados
exec $PYTHON_CMD -m notebook "${ARGS[@]}"
