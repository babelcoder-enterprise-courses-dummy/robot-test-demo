*** Settings ***
Library         Browser
Library         RPA.Excel.Files
Resource        ${EXECDIR}/resources/db/common.resource

Suite Setup     Run Keywords    Connect to DB
...                 AND    Clean DB
...                 AND    Create Records    categories
...                 AND    Create Records    products


*** Test Cases ***
Navigate to Products Page Should Show All Products
    [Setup]    Run Keywords    New Page    ${WEB_URL}/products
    ...    AND    Wait For Load State    networkidle
    Open Workbook    ${EXECDIR}/data/web/products.xlsx
    ${records}    Read Worksheet    list    header=True
    ${products}    Get Element By    TestID    product    all_elements=True
    ${records_count}    Get Length    ${records}
    Get Element Count    xpath=//*[@data-testid="product-list"]//*[@data-testid="product"]    ==    ${records_count}

    FOR    ${index}    ${product_element}    IN ENUMERATE    @{products}
        ${matched_product}    Get From List    ${records}    ${index}

        ${name}    Get Text    ${product_element} >> role=heading
        ${price}    Get Text    ${product_element} >> data-testid=product-price
        ${image}    Get Attribute    ${product_element} >> img    src

        Should Be Equal    ${name}    ${matched_product['name']}
        Should Be Equal    ${price}    ${matched_product['price']}
        Should Be Equal    ${image}    ${matched_product['image']}
    END
    [Teardown]    Close Browser
