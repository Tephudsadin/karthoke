*** Settings ***
Resource    Firebase.robot
Resource    Grafana.robot
Resource    Sheets.robot
Suite Setup       Open Chrome
Suite Teardown    Close Chrome

*** Test Cases ***
Report10
    ${activeUser}    Get Active User
    Set Report    C    ${activeUser}

Report12
    ${activeUser}    Get Active User
    Set Report    D    ${activeUser}

Report18
    ${activeUser}    Get Active User
    Set Report    E    ${activeUser}

Report22
    ${crashlytics}     Get Crashlytics
    ${activeUser}      Get Active User
    ${events}          Get Events
    Set Report    B    ${crashlytics}
    Set Report    F    ${activeUser}
    Set Report    G    ${events[0]}
    Set Report    H    ${events[1]}
    Set Report    I    ${events[2]}
    Set Report    J    ${events[3]}
    Set Report    K    ${events[4]}
    Set Report    L    ${events[5]}
    Set Report    M    ${events[6]}
    
    Get ADMD Screen
    Get Mobile-BE Screen
    Get System Monitor D01_1 Screen
    Get System Monitor D01_2 Screen

    Cap Firebase
ReportGrafana
    Get ADMD Screen
    Get Mobile-BE Screen
    Get System Monitor D01_1 Screen
    Get System Monitor D01_2 Screen
#robot -d Result -t Report18 report.robot