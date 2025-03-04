*** Settings ***
Library     AppiumLibrary
Resource    ${EXECDIR}/resources/db/common.resource


*** Variables ***
${IOS_AUTOMATION_NAME}      XCUITest
${IOS_APP}                  ${EXECDIR}/data/demo/mobile/ios.app
${IOS_PLATFORM_NAME}        iOS
${IOS_DEVICE_NAME}          iPhone SE (3rd generation)
${IOS_PLATFORM_VERSION}     %{IOS_PLATFORM_VERSION=17.2}


*** Test Cases ***
Test Form
    Open iOS Application

    Click Element    predicate=type == "XCUIElementTypeButton"
    Wait Until Element Is Visible    accessibility_id=My Form
    Click Element    accessibility_id=Name
    Input Text    accessibility_id=Name    My Name
    Hide Keyboard    key_name=Done
    Click Element    accessibility_id=Male
    Click Element
    ...    chain=**/XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[3]/XCUIElementTypeButton[1]
    Wait Until Element Is Visible    accessibility_id=Canada
    Click Element    accessibility_id=Canada
    Wait Until Element Is Visible    accessibility_id=Submit
    Click Element    accessibility_id=Submit
    Wait Until Element Is Visible    accessibility_id=Form Info
    Element Should Be Visible    accessibility_id=Your form has been saved!
    Click Element    accessibility_id=OK
    [Teardown]    Close Application


*** Keywords ***
Open iOS Application
    Open Application    http://127.0.0.1:4723/wd/hub
    ...    automationName=${IOS_AUTOMATION_NAME}
    ...    platformName=${IOS_PLATFORM_NAME}
    ...    platformVersion=${IOS_PLATFORM_VERSION}
    ...    app=${IOS_APP}
    ...    deviceName=${IOS_DEVICE_NAME}
