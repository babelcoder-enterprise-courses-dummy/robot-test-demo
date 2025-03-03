*** Settings ***
Library             DataDriver    file=${EXECDIR}/data/web/products.xlsx    sheet_name=search
Library             Browser
Resource            ${EXECDIR}/resources/db/common.resource

Suite Setup         Run Keywords    Connect to DB
...                     AND    Clean DB
...                     AND    Create Records    categories
...                     AND    Create Records    products
Test Template       Search for a Product with Specific Term


*** Test Cases ***
Search for a Product with Specific Term Should Display Matching Name, Price, and Image    None    None    None    None


*** Keywords ***
Search for a Product with Specific Term
    [Arguments]    ${term}    ${name}    ${price}    ${image}
    [Setup]    Run Keywords    New Page    ${WEB_URL}/products
    ...    AND    Wait For Load State    networkidle

    ${input}    Get Element By    Placeholder    Search products...
    Log    ${input}
    Fill Text    ${input}    ${term}
    ${button}    Get Element    css=input + div
    Click    ${button}

    Get Element Count    xpath=//*[@data-testid="product-list"]//*[@data-testid="product"]    ==    1

    ${product_element}    Get Element By    TestID    product
    ${element_name}    Get Text    ${product_element} >> role=heading
    ${element_price}    Get Text    ${product_element} >> data-testid=product-price
    ${element_image}    Get Attribute    ${product_element} >> img    src

    Should Be Equal    ${element_name}    ${name}
    Should Be Equal    ${element_price}    ${price}
    Should Be Equal    ${element_image}    ${image}
    Log To Console    Done
    [Teardown]    Close Browser
