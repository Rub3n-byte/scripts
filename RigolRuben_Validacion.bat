@echo off
setlocal enabledelayedexpansion
set /p "nombre_1=Dime tu nombre jugador 1:"
set /p "nombre_2=Dime tu nombre jugador 2:"

echo El jugador 1 es $nombre_1 y el jugador 2 es $nombre_2

set puntos_jugador1=0
set puntos_jugador2=0

:inicio

echo    escoge una de las siguientes opciones:
echo    1. Piedra
echo    2. Papel
echo    3. Tijeras

set /p "opcion_jugador1=Tu opcion: "

if %opcion_jugador1% lss 1 (
    echo Esta opcion no es valida, pon otra opcion.
    goto inicio
)

if %opcion_jugador1% gtr 3 (
    echo Esta opcion no es valida, pon otra opcion.
    goto inicio
)

cls


echo    escoge una de las siguientes opciones:
echo    1. Piedra
echo    2. Papel
echo    3. Tijeras


set /p "opcion_jugador2=Tu opcion: "

if %opcion_jugador2% lss 1 (
    echo Esta opcion no es valida, pon otra opcion.
    goto inicio
)

if %opcion_jugador2% gtr 3 (
    echo Esta opcion no es valida, pon otra opcion.
    goto inicio
)

if %opcion_jugador1% == %opcion_jugador2% (
    echo Empate
    goto inicio
)

echo %nombre_1% ha escogido %opcion_jugador1% y %nombre_2% ha escogido %opcion_jugador2%

:: Piedra = 1

if %opcion_jugador1% == 1 (
    if %opcion_jugador2% == 2 (
        :: Papel
        echo Gana %nombre_2%
        set /a puntos_jugador2+=1
    )
    if %opcion_jugador2% == 3 (
        :: Tijeras
        echo Gana %nombre_1%
        set /a puntos_jugador1+=1
    )
)

:: Papel = 2

if %opcion_jugador1% == 2 (
    if %opcion_jugador2% == 1 (
        :: Piedra
        echo Gana %nombre_1%
        set /a puntos_jugador1+=1
    )
    if %opcion_jugador2% == 3 (
        :: Tijeras
        echo Gana %nombre_2%
        set /a puntos_jugador2+=1
    )
)

:: Tijeras = 3

if %opcion_jugador1% == 3 (
    if %opcion_jugador2% == 1 (
        :: Piedra
        echo Gana %nombre_2%
        set /a puntos_jugador2+=1
    )
    if %opcion_jugador2% == 2 (
        :: Papel
        echo Gana %nombre_1%
        set /a puntos_jugador1+=1
    )
)

if %puntos_jugador1% gtr 2 (
    echo El jugador 1 ha ganado
    goto end
)

if %puntos_jugador2% gtr 2 (
    echo El jugador 2 ha ganado
    goto end
)

echo Puntos %nombre_1%: %puntos_jugador1%
echo Puntos %nombre_2%: %puntos_jugador2%

echo pulsa para continuar
pause

goto inicio

:end
