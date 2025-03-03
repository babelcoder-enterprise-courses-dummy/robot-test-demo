*** Settings ***
Library     AppiumLibrary
Resource    ${EXECDIR}/resources/db/common.resource


*** Variables ***
${ANDROID_AUTOMATION_NAME}      UIAutomator2
${ANDROID_APP}                  ${EXECDIR}/data/demo/mobile/android.apk
${ANDROID_PLATFORM_NAME}        Android
${ANDROID_PLATFORM_VERSION}     %{ANDROID_PLATFORM_VERSION=9}

&{article1}=
...                             image=assets/article-image.jpg
...                             title=Lorem Ipsum is simply dummy text
...                             content=of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s
&{article2}=
...                             image=assets/article-image.jpg
...                             title=But also the leap into electronic
...                             content=typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages
&{article3}=
...                             image=assets/article-image.jpg
...                             title=When an unknown printer took
...                             content=a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries
&{article4}=
...                             image=assets/article-image.jpg
...                             title=It has roots in a piece of classical
...                             content=Latin literature from 45 BC, making it over 2000 years old. Richard McClintock
&{article5}=
...                             image=assets/article-image.jpg
...                             title=Lorem Ipsum is not simply random text
...                             content=a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words
&{article6}=
...                             image=assets/article-image.jpg
...                             title=Contrary to popular belief
...                             content=consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature
@{articles}=                    &{article1}    &{article2}    &{article3}    &{article4}    &{article5}    &{article6}


*** Test Cases ***
Navigate to Articles Page Should Show All Articles
    Open Android Application

    FOR    ${article}    IN    @{articles}
        ${locator}=    Set Variable    android=new UiSelector().resourceId("Article Item").instance(0)
        ${article_size}=    Get Element Size    ${locator}
        ${article_location}=    Get Element Location    ${locator}
        ${center_x_location}=    Evaluate    ${article_size}[width] / 2
        ${end_y_location}=    Evaluate    ${article_size}[height] + ${article_location}[y]

        Element Should Be Visible
        ...    android=new UiSelector().resourceId("Article Image").description("${article}[image]")
        Element Should Be Visible
        ...    android=new UiSelector().resourceId("Article Title").description("${article}[title]")
        Element Should Be Visible
        ...    android=new UiSelector().resourceId("Article Content").description("${article}[content]")

        Swipe
        ...    start_x=${center_x_location}
        ...    start_y=${end_y_location}
        ...    offset_x=${center_x_location}
        ...    offset_y=${article_location}[y]
    END
    [Teardown]    Close Application


*** Keywords ***
Open Android Application
    Open Application    http://127.0.0.1:4723/wd/hub
    ...    automationName=${ANDROID_AUTOMATION_NAME}
    ...    platformName=${ANDROID_PLATFORM_NAME}
    ...    platformVersion=${ANDROID_PLATFORM_VERSION}
    ...    app=${ANDROID_APP}
