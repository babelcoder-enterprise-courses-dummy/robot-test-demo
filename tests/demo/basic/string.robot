*** Settings ***
Library     String


*** Test Cases ***
Test Replace String
    ${result}    Replace String    Hello World    World    Robot
    Should Be Equal    ${result}    Hello Robot

Test Split String
    @{result}    Split String    apple,banana,cherry    ,
    Should Be Equal    ${result}[0]    apple
    Should Be Equal    ${result}[1]    banana
    Should Be Equal    ${result}[2]    cherry

Test Fetch From Left
    ${result}    Fetch From Left    user@example.com    @
    Should Be Equal    ${result}    user

Test Fetch From Right
    ${result}    Fetch From Right    user@example.com    @
    Should Be Equal    ${result}    example.com

Test Remove String
    ${result}    Remove String    Hello World    World
    Should Be Equal    ${result}    Hello${SPACE}

Test Should Be String
    Should Be String    12345

Test Catenate
    ${result}    Catenate    SEPARATOR=-    Robot    Framework    Test
    Should Be Equal    ${result}    Robot-Framework-Test

Test Get Length
    ${result}    Get Length    Hello
    Should Be Equal As Integers    ${result}    5

Test Should Match
    Should Match    RobotFramework    Robot*work
