@echo off
chcp 65001>nul
if not "%1"=="am_admin" (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
    exit /b
)
cls
mode 90, 15
:: ====== VARIABLES. ======
set green=[0;32m
set yellow=[93m
set lime=[0;92m
set red=[0;91m
set reset=[0m
set bold=[1m
set white=[97m
set cyan=[36m
set aqua=[96m
set blue=[34m
set grey=[90m
set magenta=[40;35m
set pink=[38;5;13m
set r=[0m
:: ====== GUI ======
cls
:resetpage
set tag=mainmenu
set txt1=Check
set txt2=Customization
set txt3=Install
:page
title sow.exe
cls
echo.
echo                                          %aqua%Main Menu                    
echo                                                 _               
echo                             %white%  ___  _____      _^| ^|_ _   _ _ __  
echo                             %white% / __%aqua%^|/%white%%aqua% _ \ \ /%white%\ / / __^|%aqua% ^| ^| ^| %white%'_ \ 
echo                             %aqua% \__%white% \ ^(_^) \ V%aqua%  V /^| ^|%white%_^| %aqua%^|_^| ^| ^|_^) ^|
echo                             %aqua% ^|___/\___/ \_/\_/  \__^|\__,_^| .__/ 
echo                                                          ^|_^|    
echo.
echo.
echo         1. %txt1%                    2. %txt2%                    3. %txt3%
echo.
if %tag%==mainmenu (
  goto :choicesmenu
)
if %tag%==checkapps (
  goto :choicescheckapps
)
if %tag%==customization (
  goto :choicescustomization
)
if %tag%==install (
  goto :choicesinstall
)
:choicesmenu
choice /c 123 /n /m "     >"
if %ERRORLEVEL% equ 1 goto:checkapps
if %ERRORLEVEL% equ 2 goto:confcustomization
if %ERRORLEVEL% equ 3 goto:confinstall
pause >nul

::CHECK APPS::
:confcheckapps
cls
echo.
timeout 3 >nul
:resetpage

:confinstall
set installPath=%UserProfile%\AppData\Local\sowtup\apps
if exist %installPath% (goto :installRadmin) else (mkdir %installPath% & goto :installRadmin)
timeout /t 1 >nul


::Radmin VPN
:installradmin
set installing=Radmin Vpn
cls
ping download.radmin-vpn.com -n 1 -w 1000 >nul
if errorlevel 1 (echo. & echo ^           [%red%!^%r%] An %red%error%r% has occured. %red%Please connect to internet and try again.%r% & timeout /t 3 >nul & exit /b) else (goto :radminconnected)
:radminconnected
if exist %installPath%\radmin-installer.exe (
    echo ^%aqua%[%red%!^%aqua%]%r% The file %aqua%%installing%%r% already exists! Moving on to the next item... & timeout /t 3 >nul & goto :installSteam
) else goto :radmindownload
:radmindownload
echo ^%aqua%[%r%*^%aqua%]%r% The connection has been successfully stablished! Now downloading %aqua%%installing%%r% & timeout /t 3 >nul
curl -s -L https://download.radmin-vpn.com/download/files/Radmin_VPN_1.4.4642.1.exe > "%installPath%\radmin-installer.exe"
cls
start "" "%installPath%\radmin-installer.exe"
:checkradminopen
tasklist /FI "IMAGENAME eq radmin-installer.exe" 2>NUL | find /I /N "radmin-installer.exe">NUL
if %ERRORLEVEL%==0 (goto :checkradminopen)
if %ERRORLEVEL%==1 (cls && echo ^%aqua%[%r%*^%aqua%]%r% The file has been downloaded! Moving on to the next item... & timeout /t 3 >nul
)


::Steam
:installsteam
set installing=Steam
cls
ping cdn.cloudflare.steamstatic.com -n 1 -w 1000 >nul
if errorlevel 1 (echo. & echo ^           [%red%!^%r%] An %red%error%r% has occured. %red%Please connect to internet and try again.%r% & timeout /t 3 >nul & exit /b) else (goto :steamconnected)
:steamconnected
if exist %installPath%\steam-installer.exe (
    echo ^%aqua%[%red%!^%aqua%]%r% The file %aqua%%installing%%r% already exists! Moving on to the next item... & timeout /t 3 >nul & goto :installdiscord
) else goto :steamdownload
:steamdownload
echo ^%aqua%[%r%*^%aqua%]%r% The connection has been successfully stablished! Now downloading %aqua%%installing%%r% & timeout /t 3 >nul
curl -s -L https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe > "%installPath%\steam-installer.exe"
cls
start "" "%installPath%\steam-installer.exe"
:checksteamopen
tasklist /FI "IMAGENAME eq steam-installer.exe" 2>NUL | find /I /N "steam-installer.exe">NUL
if %ERRORLEVEL%==0 (goto :checksteamopen)
if %ERRORLEVEL%==1 (cls && echo ^%aqua%[%r%*^%aqua%]%r% The file has been downloaded! Moving on to the next item... & timeout /t 3 >nul
)


:installdiscord
set installing=Discord
cls
ping discord.com -n 1 -w 1000 >nul
if errorlevel 1 (echo. & echo ^           [%red%!^%r%] An %red%error%r% has occured. %red%Please connect to internet and try again.%r% & timeout /t 3 >nul & exit /b) else (goto :discordconnected)
:discordconnected
if exist %installPath%\discord-installer.exe (
    echo ^%aqua%[%red%!^%aqua%]%r% The file %aqua%%installing%%r% already exists! Moving on to the next item... & timeout /t 3 >nul & goto :installopera
) else goto :discorddownload
:discorddownload
echo ^%aqua%[%r%*^%aqua%]%r% The connection has been successfully stablished! Now downloading %aqua%%installing%%r% & timeout /t 3 >nul
start "" https://discord.com/download
cls
echo ^%aqua%[%r%*^%aqua%]%r% Please, download the file on the following path: && timeout /t 1 >nul
echo ^%aqua%[%r%*^%aqua%]%r% %installPath%\%aqua%discord-installer.exe%r% && timeout /t 1 >nul
echo ^%aqua%[%r%*^%aqua%]%r% Come back here when you finish downloading. && timeout /t 3 >nul
pause
if exist %installPath%\discord-installer.exe (
start "" "%installPath%\discord-installer.exe"
) else cls && echo ^%aqua%[%red%!^%aqua%]%r% The file %aqua%%installing%%r% wasn't downloaded! Moving on to the next item... & timeout /t 3 >nul & goto :installOpera
start "" "%installPath%\discord-installer.exe"
:checkdiscordopen
tasklist /FI "IMAGENAME eq discord-installer.exe" 2>NUL | find /I /N "discord-installer.exe">NUL
if %ERRORLEVEL%==0 (goto :checkdiscordopen)
if %ERRORLEVEL%==1 (cls && echo ^%aqua%[%r%*^%aqua%]%r% The file has been downloaded! Moving on to the next item... & timeout /t 3 >nul
)


:installopera
set installing=Opera
cls
ping opera.com -n 1 -w 1000 >nul
if errorlevel 1 (echo. & echo ^           [%red%!^%r%] An %red%error%r% has occured. %red%Please connect to internet and try again.%r% & timeout /t 3 >nul & exit /b) else (goto :operaconnected)
:operaconnected
if exist %installPath%\opera-installer.exe (
    echo ^%aqua%[%red%!^%aqua%]%r% The file %aqua%%installing%%r% already exists! Moving on to the next item... & timeout /t 3 >nul & goto :installOpera
) else goto :operadownload
:operadownload
echo ^%aqua%[%r%*^%aqua%]%r% The connection has been successfully stablished! Now downloading %aqua%%installing%%r% & timeout /t 3 >nul
start "" https://www.opera.com/pt-br/computer/thanks?ni=stable&os=windows&utm_campaign=%2312+-+BR+-+Search+-+PT+-+Branded&utm_content=149353177347
cls
echo ^%aqua%[%r%*^%aqua%]%r% Please, download the file on the following path: && timeout /t 1 >nul
echo ^%aqua%[%r%*^%aqua%]%r% %installPath%\%aqua%opera-installer.exe%r% && timeout /t 1 >nul
echo ^%aqua%[%r%*^%aqua%]%r% Come back here when you finish downloading. && timeout /t 3 >nul
pause
if exist %installPath%\opera-installer.exe (
start "" "%installPath%\opera-installer.exe"
) else cls && echo ^%aqua%[%red%!^%aqua%]%r% The file %aqua%%installing%%r% wasn't downloaded! Moving on to the next item... & timeout /t 3 >nul & goto :installVscode
:checkoperaopen
tasklist /FI "IMAGENAME eq opera-installer.exe" 2>NUL | find /I /N "opera-installer.exe">NUL
if %ERRORLEVEL%==0 (goto :checkoperaopen)
if %ERRORLEVEL%==1 (cls && echo ^%aqua%[%r%*^%aqua%]%r% The file has been downloaded! Moving on to the next item... & timeout /t 3 >nul
)


:installVscode
set installing=Vscode
cls
ping code.visualstudio.com -n 1 -w 1000 >nul
if errorlevel 1 (echo. & echo ^           [%red%!^%r%] An %red%error%r% has occured. %red%Please connect to internet and try again.%r% & timeout /t 3 >nul & exit /b) else (goto :vscodeconnected)
:vscodeconnected
if exist %installPath%\vscode-installer.exe (
    echo ^%aqua%[%red%!^%aqua%]%r% The file %aqua%%installing%%r% already exists! Moving on to the next item... & timeout /t 3 >nul & goto :installwhatsapp
) else goto :vscodedownload
:vscodedownload
echo ^%aqua%[%r%*^%aqua%]%r% The connection has been successfully stablished! Now downloading %aqua%%installing%%r% & timeout /t 3 >nul
start "" https://code.visualstudio.com/download
cls
echo ^%aqua%[%r%*^%aqua%]%r% Please, download the file on the following path: && timeout /t 1 >nul
echo ^%aqua%[%r%*^%aqua%]%r% %installPath%\%aqua%vscode-installer.exe%r% && timeout /t 1 >nul
echo ^%aqua%[%r%*^%aqua%]%r% Come back here when you finish downloading. && timeout /t 3 >nul
pause
if exist %installPath%\vscode-installer.exe (
start "" "%installPath%\vscode-installer.exe"
) else cls && echo ^%aqua%[%red%!^%aqua%]%r% The file %aqua%%installing%%r% wasn't downloaded! Moving on to the next item... & timeout /t 3 >nul & goto :installWhatsapp
:checkvscodeopen
tasklist /FI "IMAGENAME eq vscode-installer.exe" 2>NUL | find /I /N "vscode-installer.exe">NUL
if %ERRORLEVEL%==0 (goto :checkvscodeopen)
if %ERRORLEVEL%==1 (cls && echo ^%aqua%[%r%*^%aqua%]%r% The file has been downloaded! Moving on to the next item... & timeout /t 3 >nul


:installWhatsapp
set installing=Whatsapp
cls
ping microsoft.com -n 1 -w 1000 >nul
if errorlevel 1 (echo. & echo ^           [%red%!^%r%] An %red%error%r% has occured. %red%Please connect to internet and try again.%r% & timeout /t 3 >nul & exit /b) else (goto :whatsappconnected)
:whatsappconnected
echo ^%aqua%[%r%*^%aqua%]%r% The connection has been successfully stablished! Now downloading %aqua%%installing%%r% & timeout /t 3 >nul
start "" ms-windows-store://pdp/?productid=9NKSQGP7F2NH&mode=mini&cid=www_test
cls
echo ^%aqua%[%r%*^%aqua%]%r% The file will be downloaded through microsft store on a different location. && timeout /t 1 >nul
echo ^%aqua%[%r%*^%aqua%]%r% Come back here when you finish downloading. && timeout /t 3 >nul
pause
cls
echo ^%aqua%[%r%*^%aqua%]%r% The file has been downloaded! Moving on to the next item... && timeout /t 3 >nul && goto :endInstalling


:endInstalling
cls
echo ^%aqua%[%r%*^%aqua%]%r% All the files has been downloaded! && timeout /t 1 >nul
echo ^%aqua%[%r%*^%aqua%]%r% Now going back to main menu... && timeout /t 1 >nul
echo ^%aqua%[%r%*^%aqua%]%r% Credits: %aqua%@sowisgone%r% on discord && timeout /t 1 >nul
pause
goto :page

