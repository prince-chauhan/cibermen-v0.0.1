*** Settings ***
Library    QWeb     # Import library
Library     SeleniumLibrary

*** Variables ***
${category} =  (For OBC Category) (Fresh)
${district} =   AGRA

*** Test Cases ***
Basic interaction
    QWeb.OpenBrowser         https://scholarship.up.gov.in/      Chrome   # Open chrome and goto given url
    QWeb.ClickText       STUDENT                         1s              # Click *button* with specific text
    QWeb.ClickItem       Registration            Fresh Login             1s     
    QWeb.ClickText       Postmatric Other Than Intermediate (Fresh)          ${category}
    ${elem}      QWeb.GetWebelement          जिला     element_type=dropdown
    SeleniumLibrary.Select From List By Label       ${elem}     'MEERUT'
  

