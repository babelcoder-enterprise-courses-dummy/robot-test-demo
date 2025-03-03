*** Settings ***
Library     AppiumLibrary
Resource    ${EXECDIR}/resources/mobile/android.robot
Resource    ${EXECDIR}/resources/db/common.resource
# Suite Setup    Run Keywords    Connect to DB
# ...    AND    Clean DB
# ...    AND    Create Records    categories
# ...    AND    Create Records    products


*** Test Cases ***
Navigate to Products Page Should Show All Products
    Open Android Application
    Element Should Be Visible    accessibility_id=Tagine
    Element Should Be Visible    accessibility_id=Venison
    Sleep    5
    [Teardown]    Close Application
