*** Settings ***
Library             Browser

Test Setup          Open Browser For Test
Test Teardown       Close Browser


*** Test Cases ***
Test Form
    Get Element By Role    HEADING    name=My Personal Info    level=1
    Fill Text    [placeholder='Enter your name']    My Name
    Check Checkbox    input[name='gender'][value='male']
    Check Checkbox    input[name='favoriteSocialMedias'][value='Facebook']
    Check Checkbox    input[name='favoriteSocialMedias'][value='Tiktok']
    Select Options By    select[name='country']    label    Thailand
    Upload File By Selector    input[type='file']    ${EXECDIR}/data/demo/file-upload.jpg
    Fill Text    [placeholder='Write your bio here...']    My Bio
    Click    button[type='submit']

    Get Element States    xpath=h1[text()='My Personal Info']    not contains    visible

    Get Element By Role    HEADING    name=Result    level=1
    Get Element    xpath=//table/tbody/tr[1]/th[text()='Name']
    Get Element    xpath=//table/tbody/tr[1]/td[text()='My Name']
    Get Element    xpath=//table/tbody/tr[2]/th[text()='Gender']
    Get Element    xpath=//table/tbody/tr[2]/td[text()='male']
    Get Element    xpath=//table/tbody/tr[3]/th[text()='Country']
    Get Element    xpath=//table/tbody/tr[3]/td[text()='TH']
    Get Element    xpath=//table/tbody/tr[4]/th[text()='Favorite Social Medias']
    Get Element    xpath=//table/tbody/tr[4]/td[text()='Facebook,Tiktok']
    Get Element    xpath=//table/tbody/tr[5]/th[text()='Bio']
    Get Element    xpath=//table/tbody/tr[5]/td[text()='My Bio']
    Get Element    xpath=//table/tbody/tr[6]/th[text()='Avatar']
    Get Element    xpath=//table/tbody/tr[6]/td/img[@alt='My Name']

Test Form Validation
    Click    button[type='submit']
    ${name_error}=    Get Text    [data-testid='name-error']
    ${gender_error}=    Get Text    [data-testid='gender-error']
    ${country_error}=    Get Text    [data-testid='country-error']
    ${favorite_social_medias_error}=    Get Text    [data-testid='favoriteSocialMedias-error']
    ${avatar_error}=    Get Text    [data-testid='avatar-error']
    ${bio_error}=    Get Text    [data-testid='bio-error']

    Should Be Equal    String must contain at least 1 character(s)    ${name_error}
    Should Be Equal    Expected 'male' | 'female', received null    ${gender_error}
    Should Be Equal
    ...    Invalid enum value. Expected 'TH' | 'US' | 'CA' | 'FR' | 'DE', received 'Choose a country'
    ...    ${country_error}
    Should Be Equal    Expected array, received boolean    ${favorite_social_medias_error}
    Should Be Equal    Required    ${avatar_error}
    Should Be Equal    String must contain at least 1 character(s)    ${bio_error}


*** Keywords ***
Open Browser For Test
    New Browser    chromium    headless=True
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    http://localhost:9301/form
