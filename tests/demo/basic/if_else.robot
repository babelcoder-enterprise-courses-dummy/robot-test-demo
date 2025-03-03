*** Settings ***
Library     Collections


*** Variables ***
${number}       15
${status}       Success
${age}          25
${fruit}        Apple
${score}        75


*** Test Cases ***
Test 1: ตรวจสอบว่าตัวแปร `${number}` มากกว่า 10 หรือไม่
    IF    ${number} > 10
        Log    Greater than 10
    ELSE
        Log    Less than or equal to 10
    END

Test 2: ตรวจสอบว่าตัวแปร `${status}` เป็น "Success" หรือไม่
    IF    '${status}' == 'Success'
        Log    Operation succeeded
    ELSE
        Log    Operation failed
    END

Test 3: ตรวจสอบว่าตัวแปร `${age}` อยู่ในช่วง 18 ถึง 60 หรือไม่
    IF    ${age} >= 18 and ${age} <= 60
        Log    Valid age
    ELSE
        Log    Invalid age
    END

Test 4: ตรวจสอบว่าตัวแปร `${fruit}` เป็นผลไม้ที่รู้จักหรือไม่
    IF    '${fruit}' in ['Apple', 'Banana', 'Orange']
        Log    It's a fruit
    ELSE
        Log    It's not a fruit
    END

Test 5: ตรวจสอบว่าตัวแปร `${score}` ผ่านเกณฑ์หรือไม่
    IF    ${score} >= 50    Log    Pass    ELSE    Log    Fail
