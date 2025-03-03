*** Settings ***
Library     AppiumLibrary
Resource    ${EXECDIR}/resources/db/common.resource


*** Variables ***
${ANDROID_AUTOMATION_NAME}      UIAutomator2
${ANDROID_APP}                  ${EXECDIR}/data/demo/mobile/android.apk
${ANDROID_PLATFORM_NAME}        Android
${ANDROID_PLATFORM_VERSION}     %{ANDROID_PLATFORM_VERSION=9}


*** Test Cases ***
Test Form
    Open Android Application

    Click Element    android=new UiSelector().className("android.widget.Button")
    Wait Until Element Is Visible    accessibility_id=My Form
    Click Element    android=new UiSelector().className("android.widget.EditText")
    Input Text    android=new UiSelector().className("android.widget.EditText")    My Name
    Hide Keyboard    key_name=Done
    Click Element    accessibility_id=Male
    Click Element    android=new UiSelector().className("android.widget.Button").instance(0)
    Wait Until Element Is Visible    accessibility_id=Canada
    Click Element    accessibility_id=Canada
    Wait Until Element Is Visible    accessibility_id=Submit
    Click Element    accessibility_id=Submit
    Wait Until Element Is Visible    accessibility_id=Form Info
    Element Should Be Visible    accessibility_id=Your form has been saved!
    Click Element    accessibility_id=OK
    [Teardown]    Close Application


*** Keywords ***
Open Android Application
    Open Application    http://127.0.0.1:4723/wd/hub
    ...    automationName=${ANDROID_AUTOMATION_NAME}
    ...    platformName=${ANDROID_PLATFORM_NAME}
    ...    platformVersion=${ANDROID_PLATFORM_VERSION}
    ...    app=${ANDROID_APP}
