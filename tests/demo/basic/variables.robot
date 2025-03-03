*** Variables ***
${species}              HOMO SAPIENS
&{person}               name=Somchai    age=24    gender=male
@{favorite_foods}       apple    papaya    banana    orange


*** Test Cases ***
Somchai Info
    Log To Console    Species = ${species}
    Log To Console    Name = ${person['name']}
    Log To Console    The first favorite food = ${favorite_foods[0]}
