@echo off
chcp 65001 >nul
powershell -Command "exit 0" >nul 2>&1
if errorlevel 1 (
    echo Erro: PowerShell nao encontrado. Este script requer PowerShell para funcionar.
    pause
    exit /b 1
)

set "attempts_date=0"
set "attempts_custom=0"

:date_input
echo Deseja usar a data de hoje para a pasta? (s/n)
set "use_today_date="
set /p use_today_date="Digite s ou n: "
if /i "%use_today_date%"=="s" goto date_today
if /i "%use_today_date%"=="n" goto date_manual
set /a attempts_date+=1
if %attempts_date% GEQ 3 (
    echo Limite de tentativas excedido. Encerrando script.
    goto end
)
echo Opcao invalida. Digite 's' para sim ou 'n' para nao.
goto date_input

:date_today
for /f %%i in ('powershell -command "(Get-Date).ToString('dd.MM.yy')"') do set "data_pasta=%%i"
goto create_folders

:date_manual
echo Digite a data no formato DD.MM.AA:
set "data_pasta_input="
set /p data_pasta_input="Data: "
echo Verificando data...
powershell -Command "try {$date = Get-Date '%data_pasta_input%'; exit 0} catch {Write-Output 'Erro: Data invalida. Use DD.MM.AA (ex.: 20.03.25)'; exit 1}"
if %errorlevel%==1 (
    goto date_manual
)
set "data_pasta=%data_pasta_input%"

:create_folders
if exist "%data_pasta%" (
    echo A pasta "%data_pasta%" ja existe. Deseja continuar e adicionar subpastas nela? (s/n)
    set "overwrite="
    set /p overwrite="Digite s ou n: "
    if /i not "%overwrite%"=="s" (
        echo Operacao cancelada.
        goto end
    )
    cd "%data_pasta%"
    goto create_subfolders
)
mkdir "%data_pasta%"
if errorlevel 1 (
    echo Erro: Nao foi possivel criar a pasta "%data_pasta%". Verifique permissoes ou espaco em disco.
    goto end
)
cd "%data_pasta%"

:create_subfolders
echo Criando subpastas padrao...
mkdir "Pista de Ski e Snow" 2>nul
mkdir "Tubing" 2>nul
mkdir "Vilareijo" 2>nul
mkdir "Termometro" 2>nul
mkdir "Ensaio" 2>nul

:custom_prompt
echo Deseja adicionar subpastas personalizadas? (s/n)
set "add_custom_subfolders="
set /p add_custom_subfolders="Digite s ou n: "
if /i "%add_custom_subfolders%"=="s" goto custom_subfolders
if /i "%add_custom_subfolders%"=="n" goto end_success
set /a attempts_custom+=1
if %attempts_custom% GEQ 3 (
    echo Limite de tentativas excedido. Encerrando script.
    goto end
)
echo Opcao invalida. Digite 's' para sim ou 'n' para nao.
goto custom_prompt

:custom_subfolders
echo Digite o nome da subpasta personalizada (ou 'fim' para terminar):
set "custom_subfolder_name="
set /p custom_subfolder_name="Nome: "
if /i "%custom_subfolder_name%"=="fim" goto end_success
if "%custom_subfolder_name%"=="" (
    echo Nome vazio nao permitido. Tente novamente.
    goto custom_subfolders
)
echo "%custom_subfolder_name%" | findstr /r "[\/:*?<>|]" >nul
if %errorlevel%==0 (
    echo Nome invalido. Evite caracteres como / \ : * ? " < > ou |.
    goto custom_subfolders
)
mkdir "%custom_subfolder_name%" 2>nul
if errorlevel 1 (
    echo Erro ao criar "%custom_subfolder_name%". Nome pode ser muito longo ou ja existir.
) else (
    echo Subpasta personalizada "%custom_subfolder_name%" criada.
)
goto custom_subfolders

:end_success
echo Pastas criadas com sucesso em "%data_pasta%"!
goto end

:end
pause