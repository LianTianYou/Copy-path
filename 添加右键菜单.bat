@echo OFF

title ����Ҽ��˵�

set exe=����·��.exe
set name=����·��
set reg-path=HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\����·��

rem HKEY_CLASSES_ROOT\AllFilesystemObjects\shell  �����ļ����ļ���
rem HKEY_CLASSES_ROOT\*\shell  �����ļ�

if not exist "%~dp0%exe%" (echo δ�ҵ�"%exe%"����ȷ�����ļ���exe����ͬһĿ¼��&&echo.&&goto :end)

net.exe session 1>NUL 2>NUL && goto :is_admin
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
:is_admin

:in
echo 1.����Ҽ��˵�
echo 2.ɾ���Ҽ��˵�
echo.
echo ��������ţ�

ver|findstr "5\.[0-9]\.[0-9][0-9]*">nul && set /p num= && goto :if_in

choice /c 12 /n
set num=%errorlevel%

:if_in
if %num%==1 (call :add) else (if %num%==2 (call :del) else echo ����������������룺 && echo. && (goto :in))
:end
timeout /t 4
exit

:add
reg add "%reg-path%" /d "%name%" /f>nul
reg add "%reg-path%\command" /d "%~dp0%exe% \"%%1\"" /f>nul
reg add "%reg-path%" /v icon /d "%~dp0%exe%" /f>nul&& echo ��ӳɹ� && echo. ||echo. && echo ���ʧ�� &&echo.
goto :end

:del
reg delete "%reg-path%" /f>nul&& echo ɾ���ɹ� && echo. ||echo. && echo ɾ��ʧ�� &&echo.
goto :end