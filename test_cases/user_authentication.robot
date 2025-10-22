*** Settings ***
Documentation    User Authentication Test Cases for DemoBlaze Website
Library          SeleniumLibrary
Library          String
Test Setup       Open DemoBlaze Website
Test Teardown    Close Browser
Resource         ../resources/common_keywords.robot
Suite Setup      Generate Random Username

*** Variables ***
${URL}                  https://www.demoblaze.com/
${BROWSER}              Chrome
${SIGNUP_BTN}           id:signin2
${LOGIN_BTN}            id:login2
${LOGOUT_BTN}           id:logout2
${SIGNUP_USERNAME}      id:sign-username
${SIGNUP_PASSWORD}      id:sign-password
${SIGNUP_SUBMIT}        xpath://button[contains(text(),'Sign up')]
${LOGIN_USERNAME}       id:loginusername
${LOGIN_PASSWORD}       id:loginpassword
${LOGIN_SUBMIT}         xpath://button[contains(text(),'Log in')]
${WELCOME_USER}         id:nameofuser
${RANDOM_STRING}        ${EMPTY}

*** Test Cases ***
TC01 - Successful Sign Up With New User
    [Documentation]    Verify that a new user can successfully sign up
    [Tags]    signup    positive
    Click Sign Up Button
    Enter Sign Up Credentials    ${SHARED_USERNAME}    TestPass123
    Submit Sign Up Form
    Verify Sign Up Success

TC02 - Sign Up With Existing Username
    [Documentation]    Verify that signing up with existing username shows error
    [Tags]    signup    negative
    Click Sign Up Button
    Enter Sign Up Credentials    ${SHARED_USERNAME}    TestPass123
    Submit Sign Up Form
    Verify Sign Up Error Message

TC03 - Successful Login With Valid Credentials
    [Documentation]    Verify that user can login with valid credentials
    [Tags]    login    positive
    Click Login Button
    Enter Login Credentials    ${SHARED_USERNAME}    TestPass123
    Submit Login Form
    Verify Login Success    ${SHARED_USERNAME}

TC04 - Successful Logout
    [Documentation]    Verify that logged in user can successfully logout
    [Tags]    logout    positive
    Perform Login    ${SHARED_USERNAME}    TestPass123
    Click Logout Button
    Verify Logout Success

*** Keywords ***
Click Sign Up Button
    Wait Until Element Is Visible    ${SIGNUP_BTN}    1s
    Click Element    ${SIGNUP_BTN}
    Wait Until Element Is Visible    ${SIGNUP_USERNAME}    1s

Enter Sign Up Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${SIGNUP_USERNAME}    1s
    Input Text    ${SIGNUP_USERNAME}    ${username}
    Input Text    ${SIGNUP_PASSWORD}    ${password}

Submit Sign Up Form
    Click Element    ${SIGNUP_SUBMIT}
    Sleep    1s

Verify Sign Up Success
    Alert Should Be Present    Sign up successful.    timeout=1s

Verify Sign Up Error Message
    Alert Should Be Present    This user already exist.    timeout=1s

Click Login Button
    Wait Until Element Is Visible    ${LOGIN_BTN}    1s
    Click Element    ${LOGIN_BTN}
    Wait Until Element Is Visible    ${LOGIN_USERNAME}    1s

Enter Login Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${LOGIN_USERNAME}    1s
    Input Text    ${LOGIN_USERNAME}    ${username}
    Input Text    ${LOGIN_PASSWORD}    ${password}

Submit Login Form
    Click Element    ${LOGIN_SUBMIT}
    Sleep    1s

Verify Login Success
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${WELCOME_USER}    5s
    ${welcome_text}=    Get Text    ${WELCOME_USER}
    Should Contain    ${welcome_text}    Welcome ${username}

Click Logout Button
    Wait Until Element Is Visible    ${LOGOUT_BTN}    1s
    Click Element    ${LOGOUT_BTN}
    Sleep    1s

Verify Logout Success
    Wait Until Element Is Visible    ${LOGIN_BTN}    5s
    Element Should Be Visible    ${SIGNUP_BTN}
    Element Should Be Visible    ${LOGIN_BTN}

Verify Alert Message
    [Arguments]    ${expected_message}
    Alert Should Be Present    ${expected_message}    timeout=1s

Perform Login
    [Arguments]    ${username}    ${password}
    Click Login Button
    Enter Login Credentials    ${username}    ${password}
    Submit Login Form
    Verify Login Success    ${username}

Open DemoBlaze Website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${SIGNUP_BTN}    1s
