*** Settings ***
Library  Selenium2Library
Library  String
*** Variables ***
${password}  123456
${error}  メールアドレスもしくはパスワードが違います
*** Test Cases ***
Valid account
    @{username}    Create List    company01@gmail.com     Company01@gmail.com     COMPANY01@GMAIL.COM
    :FOR    ${ELEMENT}    IN    @{username}
    \    Open by Chrome
    \    Log in    ${ELEMENT}   ${password}
    \   Verify login sucessfully
Wrong password
    Open by Chrome
    Log in  Company01@gmail.com  1234
    Error message  メールアドレスもしくはパスワードが違います
Account not registered yet
    Open by Chrome
    Log in  thuthamcompany@gmail.com  123456
    Error message  メールアドレスもしくはパスワードが違います

*** Keywords ***
Open by Chrome
    Open browser    https://web.tenshoku-dev.scrum-dev.com/    Chrome
Log in
    [Arguments]    ${username}   ${password}
    Click Element     class:log-in-btn
    Click Element  class:icon-company
    sleep  2
    Input text   username   ${username}
    Input password    password    ${password}
    Click Button    xpath://*[@id="login-page"]/div[2]/div/form/button
    SLEEP  2

Verify login sucessfully
    Element Text Should Be  class:fullname  Company01
    sleep  2
    Close browser
Error message
    [Arguments]    ${error}
    Element Text Should Be  class:system-error  ${error}
    sleep  2
    Close browser
