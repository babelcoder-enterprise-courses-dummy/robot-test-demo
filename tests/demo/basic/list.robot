*** Settings ***
Library     Collections


*** Test Cases ***
Test Create List
    @{my_list}    Create List    Apple    Banana    Cherry
    Length Should Be    ${my_list}    3
    List Should Contain Value    ${my_list}    Banana

Test Append To List
    @{my_list}    Create List    Apple    Banana
    Append To List    ${my_list}    Cherry
    List Should Contain Value    ${my_list}    Cherry

Test Insert Into List
    @{my_list}    Create List    Apple    Cherry
    Insert Into List    ${my_list}    1    Banana
    Should Be Equal    ${my_list}[1]    Banana

Test Remove From List
    @{my_list}    Create List    Apple    Banana    Cherry
    Remove From List    ${my_list}    1
    List Should Not Contain Value    ${my_list}    Banana

Test Get From List
    @{my_list}    Create List    Apple    Banana    Cherry
    ${item}    Get From List    ${my_list}    1
    Should Be Equal    ${item}    Banana

Test Get Index From List
    @{my_list}    Create List    Apple    Banana    Cherry
    ${index}    Get Index From List    ${my_list}    Banana
    Should Be Equal As Integers    ${index}    1

Test Sort List
    @{my_list}    Create List    Cherry    Apple    Banana
    Sort List    ${my_list}
    Should Be Equal    ${my_list}[0]    Apple
    Should Be Equal    ${my_list}[1]    Banana
    Should Be Equal    ${my_list}[2]    Cherry

Test List Should Contain Value
    @{my_list}    Create List    Apple    Banana    Cherry
    List Should Contain Value    ${my_list}    Banana
