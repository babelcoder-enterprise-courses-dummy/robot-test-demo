*** Settings ***
Library     Collections


*** Variables ***
@{fruits}       Apple    Banana    Orange
${start}        1
${end}          5
@{names}        John    Jane    Doe
@{ages}         25    30    35
&{user}         name=John    age=30    city=New York


*** Test Cases ***
Test 1: FOR-IN - วนลูปผ่านรายการ
    FOR    ${fruit}    IN    @{fruits}
        Log    ${fruit}
    END

Test 2: FOR-IN-RANGE - วนลูปผ่านช่วงตัวเลข
    FOR    ${i}    IN RANGE    ${start}    ${end}
        Log    ${i}
    END

Test 3: FOR-IN-ENUMERATE - วนลูปพร้อมดึง index และค่า
    FOR    ${index}    ${fruit}    IN ENUMERATE    @{fruits}
        Log    Index: ${index}, Fruit: ${fruit}
    END

Test 4: FOR-IN-ZIP - วนลูปผ่านหลายรายการพร้อมกัน
    FOR    ${name}    ${age}    IN ZIP    ${names}    ${ages}
        Log    Name: ${name}, Age: ${age}
    END

Test 5: FOR-IN เพื่อทำ Dictionary Iteration
    FOR    ${key}    ${value}    IN    &{user}
        Log    Key: ${key}, Value: ${value}
    END
