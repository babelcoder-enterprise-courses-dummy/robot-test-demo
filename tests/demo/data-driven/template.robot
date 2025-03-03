*** Settings ***
Test Template       Add


*** Test Cases ***    A    B    Expected Result
All Positive Numbers    1    2    3
All Negative Numbers    -1    -2    -3
Positive and Negative Numbers    -1    2    1


*** Keywords ***
Add
    [Arguments]    ${a}    ${b}    ${expected_result}
    ${result}=    Evaluate    ${a} + ${b}
    Log To Console    ${result}
    Should Be Equal As Numbers    ${expected_result}    ${result}
