*** Settings ***
Library     AppiumLibrary
Resource    ${EXECDIR}/resources/db/common.resource


*** Variables ***
${ANDROID_AUTOMATION_NAME}      UIAutomator2
${ANDROID_APP}                  ${EXECDIR}/data/demo/mobile/android.apk
${ANDROID_PLATFORM_NAME}        Android
${ANDROID_PLATFORM_VERSION}     %{ANDROID_PLATFORM_VERSION=9}
${CALCULATOR_APP_PACKAGE}       com.android.calculator2
${CALCULATOR_APP_ACTIVITY}      com.android.calculator2.Calculator


*** Test Cases ***
Test Switch App
    Open Calculator Application

    Click Element    id=com.android.calculator2:id/digit_1
    Click Element    id=com.android.calculator2:id/op_add
    Click Element    id=com.android.calculator2:id/digit_3

    ${result}=    Get Text    id=com.android.calculator2:id/result
    Should Be Equal As Strings    ${result}    4

    Open My Application
    Click Element    android=new UiSelector().className("android.widget.Button")
    Wait Until Element Is Visible    accessibility_id=My Form
    Click Element    android=new UiSelector().className("android.widget.EditText")
    Input Text    android=new UiSelector().className("android.widget.EditText")    ${result}
    Hide Keyboard    key_name=Done
    Sleep    5

    [Teardown]    Close All Applications


*** Keywords ***
Open My Application
    Open Application    http://127.0.0.1:4723/wd/hub
    ...    automationName=${ANDROID_AUTOMATION_NAME}
    ...    platformName=${ANDROID_PLATFORM_NAME}
    ...    platformVersion=${ANDROID_PLATFORM_VERSION}
    ...    app=${ANDROID_APP}

Open Calculator Application
    Open Application    http://127.0.0.1:4723/wd/hub
    ...    automationName=${ANDROID_AUTOMATION_NAME}
    ...    platformName=${ANDROID_PLATFORM_NAME}
    ...    platformVersion=${ANDROID_PLATFORM_VERSION}
    ...    appPackage=${CALCULATOR_APP_PACKAGE}
    ...    appActivity=${CALCULATOR_APP_ACTIVITY}
