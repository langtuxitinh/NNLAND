@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
set "JAVA_CMD="
if defined JAVA_HOME if exist "%JAVA_HOME%\bin\java.exe" set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
if not defined JAVA_CMD for %%J in (java.exe) do set "JAVA_CMD=%%~$PATH:J"
if not defined JAVA_CMD (
  echo Chua tim thay Java. NNland can JDK 25 tro len. Hay cai JDK 25 va kiem tra JAVA trong PATH.
  pause
  exit /b 1
)
"%JAVA_CMD%" -version
if errorlevel 1 (
  echo Java khong chay duoc. Hay dat JAVA_HOME den thu muc JDK 25 hoat dong.
  pause
  exit /b 1
)
if not exist "target\NNland.war" (
  where mvn >nul 2>nul
  if errorlevel 1 (
    echo Chua co ban WAR va chua tim thay Maven. Hay mo du an trong NetBeans va chon Build.
    pause
    exit /b 1
  )
  call mvn package
  if errorlevel 1 (
    echo Build chua thanh cong. Hay xem loi phia tren.
    pause
    exit /b 1
  )
)
echo NNland se chay tai http://localhost:8081
echo Can bat SQL Server va dien application-local.properties truoc.
echo Dung Ctrl+C de dung ung dung.
"%JAVA_CMD%" -jar "target\NNland.war"
pause
