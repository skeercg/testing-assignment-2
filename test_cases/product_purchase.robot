*** Settings ***
Documentation    Purchase Flow Test Cases for DemoBlaze Website
Library          SeleniumLibrary
Test Setup       Open DemoBlaze Website
Test Teardown    Close Browser
Resource         ../resources/common_keywords.robot
Resource         ../resources/base_keywords.robot
Suite Setup      Generate Random Username

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

Complete Purchase
    Click Element    ${PURCHASE_SUBMIT}
    Sleep    1s

Verify Purchase Success
    Wait Until Element Is Visible    ${SUCCESS_HEADING}    10s
    Sleep    1s
    Click Element    ${SUCCESS_OK_BTN}
    Sleep    1s