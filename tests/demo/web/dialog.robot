*** Settings ***
Library             Browser
Library             OperatingSystem

Suite Setup         Open Browser For Test
Suite Teardown      Close Browser


*** Test Cases ***
Test Dialogs
    Promise To    Wait For Alert    action=accept    text=Hello World
    Click    [data-testid='alert']

    Promise To    Wait For Alert    action=accept    text=Press a button
    Click    [data-testid='confirm']
    Promise To    Wait For Alert    action=dismiss    text=Press a button
    Click    [data-testid='confirm']

    ${download_promise}=    Promise To Wait For Download    /images/elements-image.jpg
    Click    [data-testid='download']
    ${file_obj}=    Wait For    ${download_promise}
    File Should Exist    ${file_obj}[saveAs]
    Should Be Equal    elements-image.jpg    ${file_obj}[suggestedFilename]
    Remove File    ${file_obj}[saveAs]


*** Keywords ***
Open Browser For Test
    New Browser    chromium    headless=True
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    http://localhost:9301/dialog
