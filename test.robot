*** Settings ***
Library    QWeb     # Import library

*** Variables ***
${category} =  (For OBC Category) (Fresh)
${district} =   AGRA

*** Test Cases ***
Basic interaction
    OpenBrowser         https://scholarship.up.gov.in/      Chrome   # Open chrome and goto given url
    ClickText       STUDENT                         1s              # Click *button* with specific text
    ClickItem       Registration            Fresh Login             1s     
    ClickText       Postmatric Other Than Intermediate (Fresh)          ${category}
    DropDown        जिला           15

