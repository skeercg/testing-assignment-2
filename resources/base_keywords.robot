*** Settings ***
Documentation    Common UI keywords for setup, auth, and navigation.
Library          SeleniumLibrary
Resource         ./variables.robot

*** Keywords ***
Open DemoBlaze Website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${LOGIN_BTN}    10s

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

Perform Login
    [Arguments]    ${username}    ${password}
    Click Login Button
    Enter Login Credentials    ${username}    ${password}
    Submit Login Form
    Verify Login Success    ${username}

Verify Alert Message
    [Arguments]    ${expected_message}
    Alert Should Be Present    ${expected_message}    timeout=1s

Verify Sign Up Success
    Verify Alert Message    Sign up successful.

Verify Sign Up Error Message
    Verify Alert Message    This user already exist.