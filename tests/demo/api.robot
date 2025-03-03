*** Settings ***
Library         RequestsLibrary

Test Setup      Delete All Articles


*** Variables ***
${BASE_URL}             http://localhost:9302/api
${ARTICLE_ID}           ${1}
${CERTIFICATE_PATH}     ${EXECDIR}/data/demo/file-upload.jpg


*** Test Cases ***
Create Article
    Create New Article    title=Test Article    content=This is a test article.

Get All Articles
    ${article1}    Create Dictionary    title=Test Article1    content=This is a test article1.
    ${article2}    Create Dictionary    title=Test Article2    content=This is a test article2.
    ${articles}    Create List    ${article1}    ${article2}
    Create New Article    &{article1}
    Create New Article    &{article2}

    ${response}    GET    ${BASE_URL}/articles
    Should Be Equal As Strings    ${response.status_code}    200
    ${articles}    Set Variable    ${response.json()}
    Should Not Be Empty    ${articles}

    FOR    ${index}    ${article}    IN ENUMERATE    @{articles}
        Should Be Equal As Numbers    ${index+1}    ${article}[id]
        Should Be Equal    ${articles[${index}]}[title]    ${article}[title]
        Should Be Equal    ${articles[${index}]}[content]    ${article}[content]
    END

Get Article By ID
    ${record}    Create Dictionary    title=Test Article    content=This is a test article.
    Create New Article    &{record}

    ${response}    GET    ${BASE_URL}/articles/${ARTICLE_ID}
    Should Be Equal As Strings    ${response.status_code}    200
    ${article}    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${article["id"]}    ${ARTICLE_ID}
    Should Be Equal As Strings    ${article["title"]}    ${record}[title]
    Should Be Equal As Strings    ${article["content"]}    ${record}[content]

Update Article
    ${record}    Create Dictionary    title=Test Article    content=This is a test article.
    Create New Article    &{record}

    ${updated_body}    Create Dictionary    title=Updated Title    content=Updated Content
    ${response}    PUT    ${BASE_URL}/articles/${ARTICLE_ID}    json=${updated_body}
    Should Be Equal As Strings    ${response.status_code}    200
    ${updated_article}    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${updated_article["title"]}    ${updated_body}[title]
    Should Be Equal As Strings    ${updated_article["content"]}    ${updated_body}[content]

Upload Certificate
    ${record}    Create Dictionary    title=Test Article    content=This is a test article.
    Create New Article    &{record}

    ${certificate}    Get File For Streaming Upload    ${CERTIFICATE_PATH}
    ${files}    CREATE DICTIONARY    certificate    ${certificate}
    ${response}    POST    ${BASE_URL}/articles/${ARTICLE_ID}/certificate    files=${files}
    Should Be Equal As Strings    ${response.status_code}    200
    ${updated_article}    Set Variable    ${response.json()}
    Should Contain    ${updated_article["article"]["certificate"]}    uploads

Delete Article
    ${record}    Create Dictionary    title=Test Article    content=This is a test article.
    Create New Article    &{record}

    ${response}    DELETE    ${BASE_URL}/articles/${ARTICLE_ID}
    Should Be Equal As Strings    ${response.status_code}    204


*** Keywords ***
Create New Article
    [Arguments]    ${title}    ${content}
    ${body}    Create Dictionary    title=${title}    content=${content}
    ${response}    POST    ${BASE_URL}/articles    json=${body}
    Should Be Equal As Strings    ${response.status_code}    201
    ${article}    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${article["title"]}    ${title}
    Should Be Equal As Strings    ${article["content"]}    ${content}

Delete All Articles
    ${response}    DELETE    ${BASE_URL}/articles
    Should Be Equal As Strings    ${response.status_code}    204
