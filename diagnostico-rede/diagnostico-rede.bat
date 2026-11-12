@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title Diagnostico de Rede Wi-Fi

:menu
cls
echo ===================================================
echo               DIAGNOSTICO DE WI-FI
echo ===================================================
echo.
echo   [1] IP Configuration      [5] Flush DNS
echo   [2] Busca de Gateway      [6] Exportar Logs (XCOPY)
echo   [3] Ping Customizado      [7] Run All Tests
echo   [4] Wi-Fi / Proxy Status  [8] Exit
echo.
echo ===================================================
echo.
choice /c 12345678 /n /m " Selecione uma opcao [1-8]: "
set n=%errorlevel%

if %n%==8 exit
if %n%==7 (
    for %%a in (1 2 4 5 6) do call :test %%a
) else (
    call :test %n%
)

echo.
echo ===================================================
pause
goto menu

:test
set "gw="
echo.
echo ---------------------------------------------------
if %1==1 (
    echo [*] Executando: IP Configuration...
    echo ---------------------------------------------------
    ipconfig /all
)
if %1==2 (
    echo [*] Executando: Busca e Diagnostico de Gateway...
    echo ---------------------------------------------------
    echo [-] Buscando Gateways ativos nas adaptadores:
    ipconfig | findstr /i "Gateway"
    echo.
    for /f "tokens=3" %%g in ('route print -4 ^| findstr "0.0.0.0"') do if not defined gw set "gw=%%g"
    if defined gw (
        echo [-] Gateway principal roteado: !gw!
        echo [-] Testando resposta de conexao com Gateway...
        ping -n 4 !gw!
    ) else (
        echo [!] Nenhum Gateway padrao foi identificado.
    )
)
if %1==3 (
    echo [*] Executando: Ping Customizado...
    echo ---------------------------------------------------
    set "target_ip="
    set /p target_ip=" Digite o IP ou Dominio desejado: "
    if defined target_ip (
        echo.
        ping -n 4 !target_ip!
    ) else (
        echo [*] Nenhum IP/Dominio foi informado.
    )
)
if %1==4 (
    echo [*] Executando: Wi-Fi e Proxy Status...
    echo ---------------------------------------------------
    echo --- Interface Wi-Fi ---
    netsh wlan show interfaces
    echo.
    echo --- Configuracoes de Proxy ---
    netsh winhttp show proxy
)
if %1==5 (
    echo [*] Executando: Limpeza do Cache DNS...
    echo ---------------------------------------------------
    ipconfig /flushdns
)
if %1==6 (
    echo [*] Executando: Exportacao de Logs via XCOPY...
    echo ---------------------------------------------------
    set "log_temp=%temp%\wifi_diag_log.txt"
    set "dest_dir=%USERPROFILE%\Desktop\Logs_WiFi"
    
    echo ===== RELATORIO DE DIAGNOSTICO DE REDE ===== > "!log_temp!"
    echo Data/Hora: %date% %time% >> "!log_temp!"
    echo --------------------------------------------- >> "!log_temp!"
    echo [CONFIGURACOES DE IP] >> "!log_temp!"
    ipconfig /all >> "!log_temp!"
    echo --------------------------------------------- >> "!log_temp!"
    echo [INTERFACE WI-FI] >> "!log_temp!"
    netsh wlan show interfaces >> "!log_temp!"
    echo --------------------------------------------- >> "!log_temp!"
    echo [ROTAS E GATEWAY] >> "!log_temp!"
    route print -4 >> "!log_temp!"
    
    if not exist "!dest_dir!" mkdir "!dest_dir!"
    xcopy "!log_temp!" "!dest_dir!\" /Y /Q >nul
    
    if exist "!dest_dir!\wifi_diag_log.txt" (
        echo [*] Relatorio de rede gerado e copiado via XCOPY com sucesso!
        echo [*] Salvo na sua Area de Trabalho em: Logs_WiFi\wifi_diag_log.txt
    ) else (
        echo [!] Falha ao copiar o arquivo com XCOPY.
    )
)
exit /b