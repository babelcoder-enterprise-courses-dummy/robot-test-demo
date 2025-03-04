*** Settings ***
Library     AppiumLibrary
Resource    ${EXECDIR}/resources/db/common.resource


*** Variables ***
${IOS_AUTOMATION_NAME}      XCUITest
${IOS_APP}                  ${EXECDIR}/data/demo/mobile/ios.app
${IOS_PLATFORM_NAME}        iOS
${IOS_DEVICE_NAME}          iPhone SE (3rd generation)
${IOS_PLATFORM_VERSION}     %{IOS_PLATFORM_VERSION=17.2}

&{article1}=
...                         image=assets/article-image.jpg
...                         title=Lorem Ipsum is simply dummy text
...                         content=of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s
&{article2}=
...                         image=assets/article-image.jpg
...                         title=But also the leap into electronic
...                         content=typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages
&{article3}=
...                         image=assets/article-image.jpg
...                         title=When an unknown printer took
...                         content=a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries
&{article4}=
...                         image=assets/article-image.jpg
...                         title=It has roots in a piece of classical
...                         content=Latin literature from 45 BC, making it over 2000 years old. Richard McClintock
&{article5}=
...                         image=assets/article-image.jpg
...                         title=Lorem Ipsum is not simply random text
...                         content=a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words
&{article6}=
...                         image=assets/article-image.jpg
...                         title=Contrary to popular belief
...                         content=consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature
@{articles}=                &{article1}    &{article2}    &{article3}    &{article4}    &{article5}    &{article6}


*** Test Cases ***
Navigate to Articles Page Should Show All Articles
    Open iOS Application

    ${first_locator}=    Set Variable
    ...    chain=**/XCUIElementTypeOther[`name == "Article Item"`][1]
    ${article_size}=    Get Element Size    ${first_locator}
    ${article_location}=    Get Element Location    ${first_locator}
    ${center_x_location}=    Evaluate    ${article_size}[width] / 2
    ${start_y_location}=    Evaluate    ${article_size}[height] + ${article_location}[y]
    ${y_offset}=    Set Variable    ${article_location}[y]

    FOR    ${article}    IN    @{articles}
        Element Should Be Visible
        ...    predicate=name == "Article Title" AND label == "${article['title']}"
        Element Should Be Visible
        ...    predicate=name == "Article Content" AND label == "${article['content']}"

        Swipe
        ...    start_x=${center_x_location}
        ...    start_y=${start_y_location}
        ...    offset_x=${center_x_location}
        ...    offset_y=${y_offset}
        ...    duration=3000
    END
    [Teardown]    Close Application


*** Keywords ***
Open iOS Application
    Open Application    http://127.0.0.1:4723/wd/hub
    ...    automationName=${IOS_AUTOMATION_NAME}
    ...    platformName=${IOS_PLATFORM_NAME}
    ...    platformVersion=${IOS_PLATFORM_VERSION}
    ...    app=${IOS_APP}
    ...    deviceName=${IOS_DEVICE_NAME}
