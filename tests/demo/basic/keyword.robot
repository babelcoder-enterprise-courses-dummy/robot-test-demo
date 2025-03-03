*** Settings ***
Library     Collections


*** Variables ***
${name}     John
${age}      30
${city}     New York


*** Test Cases ***
Test 1: ใช้ Positional Arguments
    แสดงข้อมูลผู้ใช้    ${name}    ${age}    ${city}

Test 2: ใช้ Default Values
    แสดงข้อมูลผู้ใช้ด้วยค่าเริ่มต้น
    แสดงข้อมูลผู้ใช้ด้วยค่าเริ่มต้น    ${name}    ${age}

Test 3: ใช้ Variable Number of Arguments
    แสดงผลไม้ทั้งหมด    Apple    Banana    Orange

Test 4: ใช้ Named Arguments
    แสดงข้อมูลผู้ใช้แบบระบุชื่อ    age=${age}    city=${city}    name=${name}

Test 5: ใช้ Free Named Arguments (kwargs)
    แสดงข้อมูลเพิ่มเติม    name=${name}    age=${age}    city=${city}

Test 6: ใช้ Named-Only Arguments
    แสดงข้อมูลผู้ใช้แบบระบุชื่อเท่านั้น    name=${name}    age=${age}    city=${city}


*** Keywords ***
แสดงข้อมูลผู้ใช้
    [Arguments]    ${name}    ${age}    ${city}
    Log    Name: ${name}, Age: ${age}, City: ${city}

แสดงข้อมูลผู้ใช้ด้วยค่าเริ่มต้น
    [Arguments]    ${name}=Unknown    ${age}=0    ${city}=Unknown
    Log    Name: ${name}, Age: ${age}, City: ${city}

แสดงผลไม้ทั้งหมด
    [Arguments]    @{fruits}
    FOR    ${fruit}    IN    @{fruits}
        Log    ${fruit}
    END

แสดงข้อมูลผู้ใช้แบบระบุชื่อ
    [Arguments]    ${name}=Unknown    ${age}=0    ${city}=Unknown
    Log    Name: ${name}, Age: ${age}, City: ${city}

แสดงข้อมูลเพิ่มเติม
    [Arguments]    &{kwargs}
    FOR    ${key}    ${value}    IN    &{kwargs}
        Log    Key: ${key}, Value: ${value}
    END

แสดงข้อมูลผู้ใช้แบบระบุชื่อเท่านั้น
    [Arguments]    @{}    ${name}    ${age}    ${city}
    Log    Name: ${name}, Age: ${age}, City: ${city}
