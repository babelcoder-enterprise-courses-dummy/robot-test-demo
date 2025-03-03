*** Settings ***
Library             DatabaseLibrary

Suite Setup         Connect To DB
Suite Teardown      Disconnect From Database
Test Setup          Clean DB


*** Test Cases ***
Test Create
    Execute Sql String    INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com');
    ${records}=    Query    SELECT * FROM users WHERE email='alice@example.com';    return_dict=True
    Should Be Equal    Alice    ${records[0]}[name]
    Should Be Equal    alice@example.com    ${records[0]}[email]

Test Update
    Execute Sql String    INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com');
    Execute Sql String    UPDATE users SET email = 'alice.new@example.com' WHERE name = 'Alice';

    ${records}=    Query    SELECT * FROM users WHERE email='alice.new@example.com';    return_dict=True
    Should Be Equal    Alice    ${records[0]}[name]
    Should Be Equal    alice.new@example.com    ${records[0]}[email]

Test Delete
    Execute Sql String    INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com');
    Execute Sql String    DELETE FROM users;
    ${records}=    Query    SELECT * FROM users WHERE email='alice.new@example.com';    return_dict=True
    Should Be Empty    ${records}

Test Query All Records
    Execute Sql String    INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com');
    Execute Sql String    INSERT INTO users (name, email) VALUES ('Bob', 'bob@example.com');
    ${records}=    Query    SELECT * FROM users    return_dict=True
    Should Be Equal    Alice    ${records[0]}[name]
    Should Be Equal    alice@example.com    ${records[0]}[email]
    Should Be Equal    Bob    ${records[1]}[name]
    Should Be Equal    bob@example.com    ${records[1]}[email]


*** Keywords ***
Connect To DB
    Connect To Database    sqlite3    database=./my_db.db    isolation_level=${None}

Clean DB
    Execute Sql Script    ${EXECDIR}/data/demo/sql/clean_up.sql
