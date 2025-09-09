#!/bin/bash
set -euo pipefail

echo "🔧 Instalando/Reinstalando kernel TypeScript (tslab) via npx..."

if ! command -v npx &> /dev/null; then
  echo "❌ npx não encontrado. Instale o Node.js (npm) primeiro."
  exit 1
fi

# Tentar instalar o kernel com npx
npx --yes tslab install || {
  echo "⚠️ npx tslab install falhou. Tentando com npx tslab@latest install..."
  npx --yes tslab@latest install
}

echo "\n🔍 Kernels registrados (jupyter kernelspec list):"
python3 -m jupyter kernelspec list || jupyter kernelspec list

echo "\n✅ Instalação do tslab concluída (se não houve erro acima)."
