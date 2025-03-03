*** Settings ***
Resource    ${EXECDIR}/resources/api/auth/authentication.resource


*** Test Cases ***
Register with Valid Credentials
    [Template]    Register with valid credentials should pass
    admin@email.com    password
    a@a.com    12345678
    normal@user.com    normaluser
