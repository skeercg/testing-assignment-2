*** Settings ***
Documentation    All variables, locators, and environment settings.

*** Variables ***
${URL}                  https://www.demoblaze.com/
${BROWSER}              Chrome

# --- Common Locators ---
${SIGNUP_BTN}           id:signin2
${LOGIN_BTN}            id:login2
${LOGOUT_BTN}           id:logout2
${WELCOME_USER}         id:nameofuser
${CART_LINK}            id:cartur

# --- Sign Up Locators ---
${SIGNUP_USERNAME}      id:sign-username
${SIGNUP_PASSWORD}      id:sign-password
${SIGNUP_SUBMIT}        xpath://button[contains(text(),'Sign up')]

# --- Login Locators ---
${LOGIN_USERNAME}       id:loginusername
${LOGIN_PASSWORD}       id:loginpassword
${LOGIN_SUBMIT}         xpath://button[contains(text(),'Log in')]

# --- Product & Cart Locators ---
${PRODUCT_LINKS}        xpath://div[@id='tbodyid']//a[@class='hrefch']
${ADD_TO_CART_BTN}      xpath://a[contains(text(),'Add to cart')]
${DELETE_CART_ITEM}     xpath://a[contains(text(),'Delete')]

# --- Purchase Modal Locators ---
${PLACE_ORDER_BTN}      xpath://button[contains(text(),'Place Order')]
${PURCHASE_NAME}        id:name
${PURCHASE_COUNTRY}     id:country
${PURCHASE_CITY}        id:city
${PURCHASE_CARD}        id:card
${PURCHASE_MONTH}       id:month
${PURCHASE_YEAR}        id:year
${PURCHASE_SUBMIT}      xpath://button[contains(text(),'Purchase')]

# --- Success Modal Locators ---
${SUCCESS_MODAL}        xpath://div[@class='sweet-alert  showSweetAlert visible']
${SUCCESS_HEADING}      xpath=//h2[text()='Thank you for your purchase!']
${SUCCESS_OK_BTN}       xpath://button[contains(text(),'OK')]