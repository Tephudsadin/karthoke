@echo off
cls
echo ==============================================================================
echo =                           1: Run report at 10:00                           =
echo =                           2: Run report at 12:00                           =
echo =                           3: Run report at 18:00                           =
echo =                           4: Run report at 22:00                           =
echo =                           5: Run Grafana                                   =
echo ==============================================================================

set /p cmd_num=" Command number: "

IF %cmd_num% ==1 goto report10
IF %cmd_num% ==2 goto report12
IF %cmd_num% ==3 goto report18
IF %cmd_num% ==4 goto report22
IF %cmd_num% ==5 goto Grafana
goto end

:report10
@robot -d Result -t report10 report.robot
goto end

:report12
@robot -d Result -t report12 report.robot
goto end

:report18
@robot -d Result -t report18 report.robot
goto end

:report22
@robot -d Result -t report22 report.robot
goto end

:Grafana
@robot -d Result -t ReportGrafana report.robot
goto end

:end
pause