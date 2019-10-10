*** Settings ***
Resource   Common.robot
Library    SeleniumLibrary    15s

*** Variables ***
${GRAFANA_URL}    http://grafana.siampiwat.in:3000/
${GRAFANA_USR}    siampiwat
${GRAFANA_PWD}    siampiwatview
${GRAFANA_SSPATH}    Grafana
${GRAFANA_WIDTH}     1366
${GRAFANA_HEIGHT}    768

*** Keywords ***
Set Timestamp
    ${date}    Get Time    year month day
    ${date}    Catenate    SEPARATOR=-    @{date}
    ${time}    Get Time    hour minute second
    ${time}    Catenate    SEPARATOR=-    @{time}
    Set Global Variable    ${GRAFANA_SSPATH}    ${GRAFANA_SSPATH}_${date}_${time}

Wait Until Graph And Table Are Visible
    Wait Until Element Is Visible    css=div.graph-panel__chart
    ${countGraph}    Get Element Count    css=div.graph-panel__chart
    FOR    ${interval}    IN RANGE    15
    Sleep    1s
    ${showGraph}    Get Element Count    css=div.graph-panel__chart canvas.flot-base
    Exit For Loop If    ${countGraph} == ${showGraph}
    END
    Wait Until Element Is Not Visible    css=div.table-panel-scroll.ng-hide

Get Offset Height
    ${navbar}    Execute Javascript    return document.getElementsByClassName('navbar')[0].offsetHeight
    ${container}    Execute Javascript    return document.getElementsByClassName('dashboard-container')[0].offsetHeight
    [Return]    ${${navbar} + ${container}}

Login Grafana
    ${loginGrafana}    Get Variable Value    ${loginGrafana}    ${false}
    Return From Keyword If    ${loginGrafana} == ${true}
    Set Timestamp
    Open Chrome    ${GRAFANA_URL}
    Wait Until Element Is Visible    css=#login-view button
    Input Text    name=username    ${GRAFANA_USR}
    Input Text    name=password    ${GRAFANA_PWD}
    Click Element    css=#login-view button
    Wait Until Element Is Visible    css=div.dashboard-header
    Set Global Variable    ${loginGrafana}    ${true}

Get ADMD Screen
    Login Grafana
    Set Window Size    ${GRAFANA_WIDTH}    ${GRAFANA_HEIGHT}
    Go To    http://grafana.siampiwat.in:3000/d/tgXr1X8mz/authentication-admd-dashboard?orgId=1
    Wait Until Graph And Table Are Visible
    ${height}    Get Offset Height
    Set Window Size    ${GRAFANA_WIDTH}    ${height}
    ${path}    Capture Page Screenshot    ${GRAFANA_SSPATH}/ADMD.png
    [Return]    ${path}

Get Mobile-BE Screen
    Login Grafana
    Set Window Size    ${GRAFANA_WIDTH}    ${GRAFANA_HEIGHT}
    Go To    http://grafana.siampiwat.in:3000/d/hcEfyX8iz/mobile-be-dashboard?orgId=1
    Wait Until Graph And Table Are Visible
    ${height}    Get Offset Height
    Set Window Size    ${GRAFANA_WIDTH}    ${height}
    ${path}    Capture Page Screenshot    ${GRAFANA_SSPATH}/Mobile-BE.png
    [Return]    ${path}

Get System Monitor D01_1 Screen
    Login Grafana
    Set Window Size    ${GRAFANA_WIDTH}    ${GRAFANA_HEIGHT}
    Go To    http://grafana.siampiwat.in:3000/d/000000012/zabbix-system-monitoring?orgId=1&var-group=Damocles&var-host=D01_1
    Wait Until Graph And Table Are Visible
    ${height}    Get Offset Height
    Set Window Size    ${GRAFANA_WIDTH}    ${height}
    ${path}    Capture Page Screenshot    ${GRAFANA_SSPATH}/D01_1.png
    [Return]    ${path}

Get System Monitor D01_2 Screen
    Login Grafana
    Set Window Size    ${GRAFANA_WIDTH}    ${GRAFANA_HEIGHT}
    Go To    http://grafana.siampiwat.in:3000/d/000000012/zabbix-system-monitoring?orgId=1&var-group=Damocles&var-host=D01_2
    Wait Until Graph And Table Are Visible
    ${height}    Get Offset Height
    Set Window Size    ${GRAFANA_WIDTH}    ${height}
    ${path}    Capture Page Screenshot    ${GRAFANA_SSPATH}/D01_2.png
    [Return]    ${path}
