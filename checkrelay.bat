@echo off
setlocal enabledelayedexpansion

:: Lista de subdominios funcionales de Sophos
set SITIOS=dci.sophosupd.com cdn20.sophosupd.com cdn20-utm.sophosupd.com message-relay.sophos.com api-cloudstation-us-west-2.prod.hydra.sophos.com utm.sophos.com ocsp.digicert.com crl3.digicert.com crl4.digicert.com www.google.com

echo ================================================
echo   Verificacion de subdominios de Sophos
echo ================================================

for %%S in (%SITIOS%) do (
    echo.
    echo Verificando %%S...

    ping -n 1 %%S >nul 2>&1
    if !errorlevel! neq 0 (
        echo [ERROR] No se pudo resolver %%S
    ) else (
        echo Resolucion exitosa. Verificando puerto 443...
        curl -s --connect-timeout 5 https://%%S >nul 2>&1
        if !errorlevel! neq 0 (
            echo [ERROR] Puerto 443 inaccesible en %%S
        ) else (
            echo [OK] Conexion HTTPS exitosa a %%S
        )
    )
)

echo.
echo Verificacion completada.
pause
endlocal
