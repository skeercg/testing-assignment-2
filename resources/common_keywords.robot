*** Settings ***
Documentation    Common
Library          SeleniumLibrary
Library          String

*** Keywords ***
Generate Random Username
    ${timestamp}=    Get Time    epoch
    ${random_user}=    Set Variable    user${timestamp}
    Set Suite Variable    ${SHARED_USERNAME}    ${random_user}