*** Settings ***
Library     DatabaseLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     RPA.Tables
Library     RPA.Excel.Files
Resource    ${EXECDIR}/resources/common/variables.resource


*** Keywords ***
Connect to DB
    Connect To Database    psycopg2    ${DB_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB_HOST}    ${DB_PORT}

Clean DB
    Execute Sql Script    ${EXECDIR}/data/sql/clean_up.sql

Create Records
    [Arguments]    ${table_name}
    Open Workbook    ${EXECDIR}/data/records.xlsx
    ${records}    Read Worksheet    ${table_name}    header=True

    FOR    ${record}    IN    @{records}
        ${field_names}    Get Dictionary Keys    ${record}
        ${field_values}    Get Dictionary Values    ${record}
        ${concat_field_names}    Catenate    SEPARATOR=,    @{field_names}
        ${concat_field_values}    Catenate    SEPARATOR=,    @{field_values}
        ${query}    Format String
        ...    INSERT INTO {table_name} ({fields}) VALUES ({values})
        ...    table_name=${table_name}
        ...    fields=${concat_field_names}
        ...    values=${concat_field_values}
        Log To Console    ${query}
        Execute Sql String    ${query}
    END

    [Teardown]    Close Workbook
