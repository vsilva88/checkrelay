@echo off
setlocal enabledelayedexpansion

:: Lista de dominios a verificar
set DOMINIOS=sophosupd.com sophos.com hydra.sophos.com sophosxl.net digicert.com google.com

echo ==========================================
echo  Verificación de conectividad Sophos Relay
echo ==========================================

for %%D in (%DOMINIOS%) do (
    echo.
    echo Verificando %%D

    ping -n 1 %%D >nul 2>&1
    if !errorlevel! neq 0 (
        echo No se pudo resolver %%D
    ) else (
        echo Resolucion correcta, probando puerto 443...

        curl -s --connect-timeout 5 https://%%D >nul 2>&1
        if !errorlevel! neq 0 (
            echo El puerto 443 no respondio en %%D
        ) else (
            echo Conexion HTTPS exitosa a %%D
        )
    )
)

echo.
echo Verificacion terminada.
pause
endlocal
