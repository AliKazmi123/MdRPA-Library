*** Settings ***
Documentation     Get Data from JSON and use that in robot.
Library    RPA.Browser.Selenium  auto_close=${FALSE}
Library    RPA.HTTP
Library    OperatingSystem
Library    BuiltIn
Library    RPA.JSON
Library    RPA.Desktop
Library    Collections

*** Variables ***
${HTTP_LOCAL_SERVER}   http://localhost:8000/error-handling
${report}     
@{error_list} 

*** Keywords ***

Create Error
    [Arguments]    ${model_name}    ${page_name}    ${element_name}    ${locator}
    &{element}    Create Dictionary     model_name=${model_name}      page_name=${page_name}    element_name=${element_name}    locator=${locator}
    Append To List    ${error_list}    ${element}

Send Report to UI Modeler
    Set Suite Variable   ${report}    ${error_list}
    ${resp}=    POST    ${HTTP_LOCAL_SERVER}    json=${report}
    Status Should Be    OK    ${resp}

