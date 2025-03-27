@echo off
chcp 65001 >nul

echo Script para criar pastas e subpastas
echo -----------------------------------

:ask_date
echo Deseja usar a data de hoje (ex.: 27.03.25) ou digitar uma data? (1 = hoje, 2 = manual)
set "choice="
set /p choice="Digite 1 ou 2: "
if "%choice%"=="1" (
    set "folder_date=27.03.25"
    goto create_main_folder
)
if "%choice%"=="2" (
    goto manual_date
)
echo Opcao invalida. Digite 1 ou 2.
goto ask_date

:manual_date
echo Digite a data no formato DD.MM.AA (ex.: 27.03.25):
set "folder_date="
set /p folder_date="Data: "
if "%folder_date%"=="" (
    echo Data nao pode ser vazia. Tente novamente.
    goto manual_date
)
goto create_main_folder

:create_main_folder
if exist "%folder_date%" (
    echo A pasta "%folder_date%" ja existe. Deseja adicionar subpastas nela? (s/n)
    set "continue="
    set /p continue="Digite s ou n: "
    if /i not "%continue%"=="s" (
        echo Operacao cancelada.
        goto end
    )
) else (
    mkdir "%folder_date%"
    if errorlevel 1 (
        echo Erro ao criar a pasta "%folder_date%". Verifique permissoes ou espaco.
        goto end
    )
)
cd "%folder_date%"
goto create_subfolders  :: Adicionado para direcionar o fluxo corretamente

:create_subfolders
echo Criando subpastas padrao...
mkdir "Pista de Ski e Snow" 2>nul
mkdir "Tubing" 2>nul
mkdir "Vilareijo" 2>nul
mkdir "Termometro" 2>nul
mkdir "Ensaio" 2>nul

:custom_folder
echo Deseja adicionar subpastas personalizadas? (s/n)
set "custom="
set /p custom="Digite s ou n: "
if /i "%custom%"=="n" goto success
if /i "%custom%"=="s" (
    goto add_custom_folder
)
echo Opcao invalida. Digite 's' ou 'n'.
goto custom_folder

:add_custom_folder
echo Digite o nome da subpasta (ou 'fim' para terminar):
set "custom_name="
set /p custom_name="Nome: "
if /i "%custom_name%"=="fim" goto success
if "%custom_name%"=="" (
    echo Nome nao pode ser vazio. Tente novamente.
    goto add_custom_folder
)
echo "%custom_name%" | findstr /r "[/:*?<>|]" >nul
if %errorlevel%==0 (
    echo Nome invalido. Evite caracteres como / \ : * ? " < > ou |.
    goto add_custom_folder
)
mkdir "%custom_name%" 2>nul
if errorlevel 1 (
    echo Erro ao criar "%custom_name%". Pode ja existir ou ser invalido.
) else (
    echo Subpasta "%custom_name%" criada.
)
goto add_custom_folder

:success
echo Pastas criadas com sucesso em "%folder_date%"!
goto end

:end
echo Pressione qualquer tecla para sair...
pause >nul