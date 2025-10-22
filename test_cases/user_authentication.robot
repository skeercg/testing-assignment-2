*** Settings ***
Documentation    User Authentication Test Cases for DemoBlaze Website
Library          SeleniumLibrary
Test Setup       Open DemoBlaze Website
Test Teardown    Close Browser
Resource         ../resources/common_keywords.robot
Resource         ../resources/base_keywords.robot
Suite Setup      Generate Random Username

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