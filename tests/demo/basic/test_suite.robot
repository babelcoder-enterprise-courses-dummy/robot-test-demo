*** Settings ***
Suite Setup         Log To Console    => Suite Setup
Suite Teardown      Log To Console    => Suite Teardown


*** Test Cases ***
First Test Case
    [Setup]    Log To Console    => First Setup
    Log Hello World
    [Teardown]    Log To Console    => First Teardown

Second Test Case
    [Setup]    Log To Console    => Second Setup
    Log To Console    => Second Test Case
    [Teardown]    Log To Console    => Second Teardown


*** Keywords ***
Log Hello World
    Log To Console    => Hello World
