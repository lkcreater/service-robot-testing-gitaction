*** Settings ***
Library          SeleniumLibrary
Test Setup       Open Browser    ${url}    
Test Teardown    Close Browser

*** Variables ***
${url}                  https://ffd-cms-dev.automer.io/
${input_email}          id=input-username-login
${input_pass}           id=input-password-login
${btn_login}            id=btn-signIn
${valid_success}        //*[@class="ng-star-inserted"]
${message_success}      contact works!
${error_path}           //*[@class="container mx-auto text-center"]
${error_no_email}       Please input your username!
${error_no_password}    Please input your Password!
${error_wrong}          //*[@class="cdk-overlay-container"]
${error_wrong_email}    ไม่ถูกต้อง โปรดลองอีกครั้ง

*** Keywords ***
Login
    [Arguments]    ${email}    ${password}
    Wait Until Element Is Visible    ${input_email}   
    Maximize Browser Window 
    Input Text      ${input_email}    ${email}
    Input Text      ${input_pass}     ${password}
    Click Button    ${btn_login} 

Verify Login Success
    Element Should Be Visible  ${valid_success}      ${message_success}

Verify Login Fail - No Email
    Element Should Be Visible  ${error_path}      ${error_no_email}

Verify Login Fail - No Password
    Element Should Be Visible   ${error_path}      ${error_no_password}

Verify Login Fail - Wrong Email/Password
    Wait Until Element Is Visible    ${error_wrong}
    Element Should Be Visible    ${error_wrong}       ${error_wrong_email} 

*** Test cases ***
TC_001: Invalid Login - No Email
    Login    ${EMPTY}     1234
    Verify Login Fail - No Email

TC_002: Invalid Login - No Password
    Login    test@gmail.com     ${EMPTY}
    Verify Login Fail - No Password   

TC_003: Invalid Login - Wrong Email
    Login    testmail.com     1234
    Verify Login Fail - Wrong Email/Password    

TC_004: Invalid Login - Wrong Password
    Login    test@gmail.com     1111
    Verify Login Fail - Wrong Email/Password

TC_005: Valid Login - Success
    Login    test@gmail.com     1234
    Verify Login Success         