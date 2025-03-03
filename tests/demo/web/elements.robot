*** Settings ***
Library             Browser
Library             Collections

Suite Setup         Open Browser For Test
Suite Teardown      Close Browser


*** Variables ***
&{article1}=
...             title=Noteworthy technology acquisitions 2021
...             desc=Here are the biggest enterprise technology acquisitions of 2021 so far, in reverse chronological order.
&{article2}=
...             title=Need a help in Claim?
...             desc=Go to this step by step guideline process on how to certify for your weekly benefits:
@{articles}=    ${article1}    ${article2}


*** Test Cases ***
Test Title
    Get Title    ==    Elements Page

Test URL Path
    Get Url    *=    /elements

Test Elements On Page By CSS
    ${articles_elements}=    Get Elements    css=article.max-w-sm.rounded-lg.border
    ${articles_length}=    Get Length    ${articles_elements}

    Should Be Equal As Numbers    ${articles_length}    2

    FOR    ${index}    ${article_element}    IN ENUMERATE    @{articles_elements}
        ${article}=    Get From List    ${articles}    ${index}

        Get Text    ${article_element} >> h3    ==    ${article['title']}
        Get Text    ${article_element} >> p    ==    ${article['desc']}
        Get Attribute    ${article_element} >>img    src    ^=    /_next/image
        Get Text    ${article_element} >> a    ==    Read more
        Get Text    ${article_element} >> button    ==    Buy
    END

Test Elements On Page By XPath
    ${articles_elements}=    Get Elements    xpath=//section/div/article
    ${articles_length}=    Get Length    ${articles_elements}

    Should Be Equal As Numbers    ${articles_length}    2

    FOR    ${index}    ${article}    IN ENUMERATE    @{articles}
        ${article_element}=    Get Element    xpath=//section/div/article[${index+1}]

        Get Text    ${article_element}/div[2]/h3    ==    ${article['title']}
        Get Text    ${article_element}/div[2]/p    ==    ${article['desc']}
        Get Attribute    ${article_element}/div[1]/img    src    ^=    /_next/image
        Get Text    ${article_element}/div[2]/div/a    ==    Read more
        Get Text    ${article_element}/div[2]/div/button    ==    Buy
    END

Test Elements On Page By Test ID
    ${articles_elements}=    Get Element By    TestID    article    all_elements=True
    ${articles_length}=    Get Length    ${articles_elements}

    Should Be Equal As Numbers    ${articles_length}    2

    FOR    ${index}    ${article_element}    IN ENUMERATE    @{articles_elements}
        ${article}=    Get From List    ${articles}    ${index}

        Get Text    ${article_element} >> [data-testid='article-title']    ==    ${article['title']}
        Get Text    ${article_element} >> [data-testid='article-desc']    ==    ${article['desc']}
        Get Attribute    ${article_element} >> [data-testid='article-image']    src    ^=    /_next/image
        Get Text    ${article_element} >> [data-testid='article-read-more']    ==    Read more
        Get Text    ${article_element} >> [data-testid='article-buy']    ==    Buy
    END

Test Elements On Page By Role
    ${articles_elements}=    Get Element By Role    ARTICLE    all_elements=True
    ${articles_length}=    Get Length    ${articles_elements}

    Should Be Equal As Numbers    ${articles_length}    2

    ${titles}=    Get Element By Role    HEADING    all_elements=True    level=3
    ${descs}=    Get Element By Role    PARAGRAPH    all_elements=True
    ${images}=    Get Element By Role    IMG    all_elements=True
    ${read_mores}=    Get Element By Role    LINK    all_elements=True
    ${buys}=    Get Element By Role    BUTTON    all_elements=True

    FOR    ${index}    ${article}    IN ENUMERATE    @{articles}
        Get Text    ${titles[${index}]}    ==    ${article['title']}
        Get Text    ${descs[${index}]}    ==    ${article['desc']}
        Get Attribute    ${images[${index}]}    src    ^=    /_next/image
        Get Text    ${read_mores[${index}]}    ==    Read more
        Get Text    ${buys[${index}]}    ==    Buy
    END


*** Keywords ***
Open Browser For Test
    New Browser    chromium    headless=True
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    http://localhost:9301/elements
