*** Settings ***
Documentation    Purchase Flow Test Cases for DemoBlaze Website
Library          SeleniumLibrary
Library          String
Test Setup       Open DemoBlaze Website
Test Teardown    Close Browser
Resource         ../resources/common_keywords.robot
Suite Setup      Generate Random Username

*** Variables ***
${URL}                  https://www.demoblaze.com/
${BROWSER}              Chrome
${LOGIN_BTN}                id:login2
${LOGIN_USERNAME}           id:loginusername
${LOGIN_PASSWORD}           id:loginpassword
${LOGIN_SUBMIT}             xpath://button[contains(text(),'Log in')]
${SIGNUP_BTN}               id:signin2
${SIGNUP_USERNAME}          id:sign-username
${SIGNUP_PASSWORD}          id:sign-password
${SIGNUP_SUBMIT}            xpath://button[contains(text(),'Sign up')]
${WELCOME_USER}             id:nameofuser
${CART_LINK}                id:cartur
${ADD_TO_CART_BTN}          xpath://a[contains(text(),'Add to cart')]
${PLACE_ORDER_BTN}          xpath://button[contains(text(),'Place Order')]
${PURCHASE_NAME}            id:name
${PURCHASE_COUNTRY}         id:country
${PURCHASE_CITY}            id:city
${PURCHASE_CARD}            id:card
${PURCHASE_MONTH}           id:month
${PURCHASE_YEAR}            id:year
${PURCHASE_SUBMIT}          xpath://button[contains(text(),'Purchase')]
${SUCCESS_MODAL}            xpath://div[@class='sweet-alert  showSweetAlert visible']
${SUCCESS_OK_BTN}           xpath://button[contains(text(),'OK')]
${PRODUCT_ITEMS}            xpath://div[@id='tbodyid']//div[@class='card h-100']
${PRODUCT_LINKS}            xpath://div[@id='tbodyid']//a[@class='hrefch']
${DELETE_CART_ITEM}         xpath://a[contains(text(),'Delete')]

*** Test Cases ***
TC01 - Purchase Random Item With Valid Payment Details
    [Documentation]    Verify user can select random item and complete purchase
    [Tags]    purchase    positive
    Click Sign Up Button
    Enter Sign Up Credentials    ${SHARED_USERNAME}    TestPass123
    Submit Sign Up Form
    Verify Sign Up Success
    Click Login Button
    Enter Login Credentials    ${SHARED_USERNAME}    TestPass123
    Submit Login Form
    Verify Login Success    ${SHARED_USERNAME}
    ${product_name}=    Select And Add Random Product To Cart
    Go To Cart
    Verify Product In Cart    ${product_name}
    Proceed To Checkout
    Fill Payment Details    John Doe    USA    New York    4111111111111111    12    2026
    Complete Purchase
    Verify Purchase Success

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

Verify Sign Up Success
    Alert Should Be Present    Sign up successful.    timeout=1s
    
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

Select And Add Random Product To Cart
    Wait Until Element Is Visible    ${PRODUCT_LINKS}    10s
    @{products}=    Get WebElements    ${PRODUCT_LINKS}
    ${product_count}=    Get Length    ${products}
    ${random_index}=    Evaluate    random.randint(0, ${product_count}-1)
    ${selected_product}=    Set Variable    ${products}[${random_index}]
    ${product_name}=    Get Text    ${selected_product}
    Log    Selected product: ${product_name}
    Click Element    ${selected_product}
    Wait Until Element Is Visible    ${ADD_TO_CART_BTN}    10s
    Click Element    ${ADD_TO_CART_BTN}
    Sleep    1s
    Handle Alert    accept
    Sleep    1s
    RETURN    ${product_name}

Go To Cart
    Click Element    ${CART_LINK}
    Wait Until Element Is Visible    ${PLACE_ORDER_BTN}    10s
    Sleep    2s

Verify Product In Cart
    [Arguments]    ${product_name}
    Wait Until Page Contains Element    xpath://tbody[@id='tbodyid']//td    10s
    Page Should Contain    ${product_name}

Proceed To Checkout
    Wait Until Element Is Visible    ${PLACE_ORDER_BTN}    5s
    Click Element    ${PLACE_ORDER_BTN}
    Wait Until Element Is Visible    ${PURCHASE_NAME}    5s

Fill Payment Details
    [Arguments]    ${name}    ${country}    ${city}    ${card}    ${month}    ${year}
    Wait Until Element Is Visible    ${PURCHASE_NAME}    5s
    Input Text    ${PURCHASE_NAME}    ${name}
    Input Text    ${PURCHASE_COUNTRY}    ${country}
    Input Text    ${PURCHASE_CITY}    ${city}
    Input Text    ${PURCHASE_CARD}    ${card}
    Input Text    ${PURCHASE_MONTH}    ${month}
    Input Text    ${PURCHASE_YEAR}    ${year}

Click Purchase Button
    Click Element    ${PURCHASE_SUBMIT}
    Sleep    1s

Complete Purchase
    Click Purchase Button

Verify Purchase Success
    Wait Until Element Is Visible    xpath=//h2[text()='Thank you for your purchase!']    10s
    Sleep    1s
    Click Element    xpath://button[text()='OK']
    Sleep    1s

