*** Settings ***
Library             DataDriver    file=${EXECDIR}/data/demo/math.xlsx    sheet_name=add

Test Template       Add


*** Test Cases ***
Test Add    0    0    0


*** Keywords ***
Add
    [Arguments]    ${a}    ${b}    ${expected_result}
    ${result}=    Evaluate    ${a} + ${b}
    Log To Console    ${result}
    Should Be Equal As Numbers    ${expected_result}    ${result}
