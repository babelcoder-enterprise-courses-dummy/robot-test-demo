*** Settings ***
Library     Collections


*** Variables ***
&{user_info}=       name=John    age=30    city=New York


*** Test Cases ***
Test Create Dictionary
    ${user_info2}=    Create Dictionary    name=John    age=30    city=New York
    Dictionary Should Contain Key    ${user_info2}    name
    Dictionary Should Contain Key    ${user_info2}    age
    Dictionary Should Contain Key    ${user_info2}    city

Test Set To Dictionary
    Set To Dictionary    ${user_info}    age=31    job=Engineer
    Dictionary Should Contain Key    ${user_info}    job
    Should Be Equal As Strings    ${user_info}[age]    31

Test Remove From Dictionary
    Remove From Dictionary    ${user_info}    city
    Dictionary Should Not Contain Key    ${user_info}    city

Test Get From Dictionary
    ${name}=    Get From Dictionary    ${user_info}    name
    Should Be Equal As Strings    ${name}    John

Test Copy Dictionary
    ${user_info_copy}=    Copy Dictionary    ${user_info}
    Dictionaries Should Be Equal    ${user_info}    ${user_info_copy}

Test Get Dictionary Keys
    ${keys}=    Get Dictionary Keys    ${user_info}
    Should Contain    ${keys}    name
    Should Contain    ${keys}    age
    Should Contain    ${keys}    job

Test Get Dictionary Values
    ${values}=    Get Dictionary Values    ${user_info}
    Should Contain    ${values}    John
    Should Contain    ${values}    31
    Should Contain    ${values}    Engineer

Test Dictionary Should Contain Key
    Dictionary Should Contain Key    ${user_info}    name
    Dictionary Should Contain Key    ${user_info}    age
    Dictionary Should Contain Key    ${user_info}    job
