*** Settings ***
Library    Collections
Library    SeleniumLibrary    15s

*** Keywords ***
Open Chrome
    [Arguments]    ${url}=about:blank    ${width}=1366    ${height}=768
    ${openChrome}    Get Variable Value    ${openChrome}    ${false}
    Run Keyword If    ${openChrome}    Go To    ${url}
    Return From Keyword If    ${openChrome} == ${true}
    # ${headless}    Get Variable Value    ${headless}    ${true}
    # ${proxy}    Get Variable Value    ${proxy}    ${empty}
    # ${chromeOptions}    Evaluate    {'goog:chromeOptions':{'useAutomationExtension':False,'args':['no-sandbox','disable-dev-shm-usage','disable-gpu','disable-extensions','log-level=3','remote-debugging-port=9222']}}
    # Run Keyword If    ${${headless}}    Append To List    ${chromeOptions['goog:chromeOptions']['args']}    headless
    # Run Keyword If    '${proxy}' != ''    Append To List    ${chromeOptions['goog:chromeOptions']['args']}    proxy-server=${proxy}
    # Open Browser    ${url}    browser=chrome    desired_capabilities=${chromeOptions}

    Open Browser    ${url}    browser=headless firefox
    #Open Browser    ${url}    browser=firefox
    Set Window Size    ${width}    ${height}
    # Register Keyword To Run On Failure    None
    Set Global Variable    ${openChrome}    ${true}

Close Chrome
    Return From Keyword If    ${openChrome} == ${false}
    Close Browser
    Set Global Variable    ${openChrome}    ${false}
