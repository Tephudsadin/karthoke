*** Settings ***
Resource   Common.robot
Library    Collections
Library    SeleniumLibrary    15s

*** Variables ***
${FIREBASE_URL}    https://console.firebase.google.com/project/onesiam-mobile
${FIREBASE_USR}    Karthoke.Tester@gmail.com
${FIREBASE_PWD}    TEPHUDSADIN99
${FIREBASE_TEL}    0949861995

*** Keywords ***
Get Today Epoch
    ${y}    ${m}    ${d}    Get Time    year,month,day
    ${epoch}    Get Time    epoch    ${y}-${m}-${d} 00:00:00
    ${begin}    Set Variable    ${epoch}000
    ${end}    Set Variable    ${epoch+86399}000
    [Return]    ${begin}    ${end}

Get Actually Text
    [Arguments]    ${locator}    ${iframe}=
    ${condition}    Evaluate    '${iframe}' != ''
    Run Keyword If    ${condition}    Select Frame    ${iframe}
    Wait Until Element Is Visible    ${locator}
    FOR    ${interval}    IN RANGE    5
    Sleep    1s
    Wait Until Element Is Visible    ${locator}
    ${text}    Get Text    ${locator}
    Run Keyword And Ignore Error    Exit For Loop If    ${text} > 0
    END
    Run Keyword If    ${condition}    Unselect Frame
    [Return]    ${text}

Redirect
    [Arguments]    ${url}
    FOR    ${interval}    IN RANGE    5
    Go To    ${url}
    ${condition}    Run Keyword And Return Status    Location Should Contain    ${url}
    Exit For Loop If    ${condition}
    END

Login Firebase
    ${loginFirebase}    Get Variable Value    ${loginFirebase}    ${false}
    Return From Keyword If    ${loginFirebase} == ${true}
    Open Chrome    ${FIREBASE_URL}
    ${locator_email}       Set Variable    xpath=//*[@id="identifierId" or @id="Email"]
    ${locator_password}    Set Variable    xpath=//*[@id="password"]//input|//*[@id="Passwd"]
    ${locator_next}        Set Variable    xpath=//*[@id="identifierNext" or @id="next"] 
    ${locator_signIn}      Set Variable    xpath=//*[@id="passwordNext" or @id="signIn"]

    Wait Until Element Is Visible    ${locator_email}
    Input Text    ${locator_email}    ${FIREBASE_USR}
    Press Keys    ${locator_email}    RETURN
    Wait Until Element Is Not Visible    ${locator_email}

    Wait Until Element Is Visible    ${locator_password}
    Input Password    ${locator_password}    ${FIREBASE_PWD}
    Press Keys    ${locator_password}    RETURN
    Wait Until Element Is Not Visible    ${locator_password}

    Wait Until Element Is Visible    css=fb-navbar    1m
    Set Global Variable    ${loginFirebase}    ${true}

Get Active User
    Login Firebase
    ${today}    Get Today Epoch
    Redirect    https://analytics.google.com/analytics/app/mobile/?authuser=0&hl=th&fpn=828751992199#/p182686739/mobile/overview?fpn=828751992199&swu=1&sgu=1&sus=not_upgraded&t=${today[0]}
    ${activeUser}    Get Actually Text    css=.counter
    Set Global Variable    ${activeUser}
    [Return]    ${activeUser}

Get Crashlytics
    Login Firebase
    ${today}    Get Today Epoch
    Redirect    ${FIREBASE_URL}/crashlytics/app/android:com.onesiam.siampiwat/issues?type=crash&state=open&time=${today[0]}:${today[1]}
    ${crashlytics}    Get Actually Text    css=.crashes .value
    Set Global Variable    ${crashlytics}
    [Return]    ${crashlytics}

Get Events
    Login Firebase
    ${today}    Get Today Epoch
    ${searchEvents}    Create List    app_remove    open_app    profile_edit_click    profile_view    profile_card_change    profile_interest_change    register_viz
    ${events}    Create List
    FOR    ${searchEvent}    IN    @{searchEvents}
    Redirect    https://analytics.google.com/analytics/app/mobile/?authuser=0&hl=th&fpn=828751992199#/p182686739/m/events/overview?t=${today[0]}&fpn=828751992199&sus=not_upgraded&sgu=1&swu=1&params=_r..layout.pageNumber%3D0%26_u..pageSize%3D25%26_u.dateOption%3Dtoday%26_r..layout.searchTerm%3D${searchEvent}
    Wait Until Element Contains    css=.event-name    ${searchEvent}
    ${event}    Get Actually Text    xpath=(//*[@class="data ng-binding"])[1]
    Append To List    ${events}    ${event}
    END
    Set Global Variable    ${events}
    [Return]    ${events}
