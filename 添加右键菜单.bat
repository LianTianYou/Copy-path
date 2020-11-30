@echo OFF

title 添加右键菜单

set exe=复制路径.exe
set name=复制路径
set reg-path=HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\复制路径

rem HKEY_CLASSES_ROOT\AllFilesystemObjects\shell  所有文件、文件夹
rem HKEY_CLASSES_ROOT\*\shell  所有文件

if not exist "%~dp0%exe%" (echo 未找到"%exe%"，请确保本文件和exe处于同一目录下&&echo.&&goto :end)

net.exe session 1>NUL 2>NUL && goto :is_admin
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
:is_admin

:in
echo 1.添加右键菜单
echo 2.删除右键菜单
echo.
echo 请输入序号：

ver|findstr "5\.[0-9]\.[0-9][0-9]*">nul && set /p num= && goto :if_in

choice /c 12 /n
set num=%errorlevel%

:if_in
if %num%==1 (call :add) else (if %num%==2 (call :del) else echo 输入出错，请重新输入： && echo. && (goto :in))
:end
timeout /t 4
exit

:add
reg add "%reg-path%" /d "%name%" /f>nul
reg add "%reg-path%\command" /d "%~dp0%exe% \"%%1\"" /f>nul
reg add "%reg-path%" /v icon /d "%~dp0%exe%" /f>nul&& echo 添加成功 && echo. ||echo. && echo 添加失败 &&echo.
goto :end

:del
reg delete "%reg-path%" /f>nul&& echo 删除成功 && echo. ||echo. && echo 删除失败 &&echo.
goto :end