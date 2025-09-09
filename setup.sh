#!/bin/bash

echo "🚀 Configurando ambiente para Merge Sort TypeScript Notebook..."
echo ""

# Verificar se Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "❌ Node.js não encontrado. Por favor, instale Node.js primeiro:"
    echo "   https://nodejs.org/"
    exit 1
fi

# Verificar se Python está instalado
if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    echo "❌ Python não encontrado. Por favor, instale Python primeiro:"
    echo "   https://python.org/"
    exit 1
fi

echo "✅ Node.js encontrado: $(node --version)"

if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
    PIP_CMD="pip3"
else
    PYTHON_CMD="python"
    PIP_CMD="pip"
fi

echo "✅ Python encontrado: $($PYTHON_CMD --version)"

# Instalar dependências npm
echo ""
echo "📦 Instalando dependências Node.js..."
npm install

# Verificar se pip está disponível
if ! command -v $PIP_CMD &> /dev/null; then
    echo "❌ pip não encontrado. Tentando instalar pip..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y python3-pip
    elif command -v yum &> /dev/null; then
        sudo yum install -y python3-pip
    elif command -v brew &> /dev/null; then
        brew install python
    else
        echo "Por favor, instale pip manualmente."
        exit 1
    fi
fi

# Instalar Jupyter se não estiver instalado
echo "📓 Instalando/Atualizando Jupyter..."
$PIP_CMD install --upgrade jupyter notebook jupyterlab

# Instalar kernel TypeScript
echo ""
echo "🔧 Instalando kernel TypeScript para Jupyter..."
npx tslab install || {
    echo "⚠️ Falha ao instalar tslab via npx. Tente executar 'npx tslab install' manualmente."
}

# Verificar se o kernel tslab foi registrado
echo "\n🔍 Verificando se o kernel 'tslab' foi registrado..."
python3 -m jupyter kernelspec list | grep tslab || echo "⚠️ Kernel 'tslab' não encontrado. Execute 'npx tslab install' no ambiente alvo."

# Verificar instalação
echo ""
echo "🔍 Verificando instalação..."
echo "Kernels disponíveis:"
jupyter kernelspec list

# Tornar o wrapper executável (se existir)
if [ -f "./scripts/start_jupyter.sh" ]; then
    chmod +x ./scripts/start_jupyter.sh || true
fi

echo ""
echo "🎉 Setup concluído com sucesso!"
echo ""
echo "Para iniciar o projeto:"
echo "  npm start      (Jupyter Notebook clássico)"
echo "  npm run lab    (Jupyter Lab moderno)"
echo ""
