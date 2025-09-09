@echo off
echo 🚀 Configurando ambient::Instalar Jupyter se não estiver instalado
echo 📓 Instalando/Atualizando Jupyter...
pip install --upgrade jupyter notebook jupyterlab Merge Sort TypeScript Notebook...
echo.

:: Verificar se Node.js está instalado
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js não encontrado. Por favor, instale Node.js primeiro:
    echo    https://nodejs.org/
    pause
    exit /b 1
)

:: Verificar se Python está instalado
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python não encontrado. Por favor, instale Python primeiro:
    echo    https://python.org/
    pause
    exit /b 1
)

echo ✅ Node.js encontrado
echo ✅ Python encontrado

:: Instalar dependências npm
echo.
echo 📦 Instalando dependências Node.js...
call npm install

:: Verificar se pip está disponível
pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ pip não encontrado. Por favor, reinstale Python com pip incluído.
    pause
    exit /b 1
)

:: Instalar Jupyter se não estiver instalado
jupyter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 📓 Instalando Jupyter...
    pip install jupyter
)

:: Instalar kernel TypeScript
echo.
echo 🔧 Instalando kernel TypeScript para Jupyter...
call npx tslab install --version

:: Verificar instalação
echo.
echo 🔍 Verificando instalação...
echo Kernels disponíveis:
jupyter kernelspec list

echo.
echo 🎉 Setup concluído com sucesso!
echo.
echo Para iniciar o projeto:
echo   npm start      (Jupyter Notebook clássico)
echo   npm run lab    (Jupyter Lab moderno)
echo.
pause
