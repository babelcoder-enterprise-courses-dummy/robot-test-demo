*** Settings ***
Library     RequestsLibrary
Resource    ${EXECDIR}/resources/common/variables.resource
Resource    db/common.resource


*** Keywords ***
Register with valid credentials should pass
    [Arguments]    ${email}    ${password}
    Connect to DB
    Clean DB

    ${credentials}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST    url=${API_URL}/auth/sign-up    json=${credentials}
    ${body}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${email}    ${body}[email]
    Should Be Equal As Numbers    0    ${body}[role]
    Dictionary Should Contain Key    ${body}    id
    Dictionary Should Not Contain Key    ${body}    password

    ${db_output}=    Query    SELECT * from users WHERE email = '${email}'    return_dict=True
    ${record}=    Set Variable    ${db_output[0]}
    Dictionary Should Contain Item    ${record}    email    ${email}
    Dictionary Should Contain Key    ${record}    password
    Should Not Be Equal As Strings    ${record['password']}    ${password}
    Dictionary Should Contain Item    ${record}    role    ${0}

    Disconnect From Database
