*** Settings ***
Library    QWeb     # Import library
Variables    VariableFile.py

*** Variables ***
    ${districtIndx} =   ${1}
    ${instituteIndx} =   ${1}
    ${casteIndx} =      ${1}
    ${religionIndx} =      ${1}
    ${female}=      FEMALE
    ${hsbIndx}=     {1}


*** Test Cases ***
Basic interaction

    QWeb.OpenBrowser         https://scholarship.up.gov.in/      Chrome   # Open chrome and goto given url
    ClickText       STUDENT                                       # Click *button* with specific text
    ClickItem       Registration            Fresh Login             
    ClickText       ${data['subcategory']}          ${data['category']}
    

    #choose city
    ${districtOpt}=    GetDropDownValues       जिला      element_type=dropdown
    FOR     ${indx}     ${dis}      IN ENUMERATE      @{districtOpt}
        IF      "${dis}"=="${data['district']}"
            ${districtIndx}=    Set Variable    ${indx}
        END   
    END
    DropDown    जिला      [[${districtIndx}]]    
    
    
    #choose institute  
    SetConfig       SearchDirection         right
    ${instituteOpt}=    GetDropDownValues       शिक्षण संस्थान          element_type=dropdown    index=2
    FOR     ${indx}     ${ins}      IN ENUMERATE      @{instituteOpt}
        IF      "${ins}"=="${data['institute']}"
            ${instituteIndx}=    Set Variable    ${indx}
                     
        END   
    END
    DropDown        शिक्षण संस्थान      [[${instituteIndx}]]    index=2   
    ResetConfig
    

    #choose caste
    ${casteOpt}=    GetDropDownValues       वर्ग / जाति समूह    element_type=dropdown
    FOR     ${indx}     ${tempCaste}    IN ENUMERATE    @{casteOpt}
        IF      "${tempCaste}"==${data['caste']}
            ${casteIndx}=   Set Variable    ${indx}
        END
    END
    DropDown    वर्ग / जाति समूह        [[${casteIndx}]]
  

    #choose religion
    SetConfig       SearchDirection         right
    ${religionOpt}=    GetDropDownValues       धर्म    element_type=dropdown     index=2
    FOR     ${indx}     ${tempReligion}    IN ENUMERATE    @{religionOpt}
        IF      "${tempReligion}"=="${data['religion']}"
            ${religionIndx}=   Set Variable    ${indx}
        END
    END
    DropDown    धर्म        [[${religionIndx}]]      index=2
    ResetConfig 
    

    #enter student name
    QWeb.TypeText    छात्र / छात्रा का नाम      ${data['studentName']}    

    
    #enter father name
    SetConfig       SearchDirection         right
    QWeb.TypeText    पिता का नाम* :      ${data['fatherName']}     index=2
    ResetConfig

    
    #enter mother name
    QWeb.TypeText    माता का नाम* :      ${data['motherName']}

    
    #enter DOB
    SetConfig       SearchDirection         right
    QWeb.TypeText    जन्मतिथि * :      ${data['dob']}     index=2
    ResetConfig

    
    #choose gender
    DropDown    लिंग* :      ${data['gender']}

    
    #enter new name if changed after married
    IF      ${data['nameChanged']}>0 and ${data['gender']}=="${female}"
        SetConfig       SearchDirection         right
        QWeb.TypeText    विवाहिता की स्थिति में यदि नाम में परिवर्तन है * :      ${data['newName']}
        ResetConfig
    END

    
    #choose high school passed year
    DropDown        हाई-स्कूल उत्तीर्ण वर्ष *      ${data['highSchoolPassingYear']}

    
    #choose high school board
    ${hsbOpt}=    GetDropDownValues       हाई-स्कूल बोर्ड * :    element_type=dropdown   index=2
    FOR     ${indx}     ${tempHsb}    IN ENUMERATE    @{hsbOpt}
        IF      "${tempHsb}"=="${data['highSchoolBoard']}"
            ${hsbIndx}=   Set Variable    ${indx}
        END
    END
    DropDown        हाई-स्कूल बोर्ड * :      [[${hsbIndx}]]      index=2


    #enter high school roll no
    ${rollLen} =    GetLength   ${data['highSchoolAlphaRoll']}
    IF  $rollLen>1
        QWeb.TypeText    हाई-स्कूल बोर्ड का अनुक्रमांक :    ${data['highSchoolAlphaRoll']}     index=1
    END
    QWeb.TypeText        हाई-स्कूल बोर्ड का अनुक्रमांक :       ${data['highSchoolRoll']}     index=2


    #enter highschool name and Address
    QWeb.TypeText    विद्यालय / सँस्था का नाम व पता* :    ${data['highSchoolName']}+' '+${data['highSchoolAddress']}      index=3


    #enter mobile
    QWeb.TypeText    मोबाइल    ${data['mobile']}  


    #enter telephone
    SetConfig       SearchDirection     right
    IF  $tele>0
        QWeb.TypeText    दूरभाष      ${data['tele']}     index=2
    ELSE
        QWeb.TypeText    दूरभाष      ${data['mobile']}       index=2
    END
    ResetConfig


    #enter email
    QWeb.TypeText    ईमेल     ${data['email']}


    #enter password
    QWeb.TypeSecret    स्वनिर्मित पासवर्ड डाले.* :     ${data['password']}       index=2


    #confirm password
    QWeb.TypeSecret      स्वनिर्मित पासवर्ड कन्फर्म करे * :       ${data['password']}    
    
    
    #send captcha
    ${file}=    CaptureIcon     //*[@id\="Captcha"]


    #SetConfig       ScreenshotType      screenshot
    #${screenshotPath}=      LogScreenshot       fullpage=True
    #Log To Console      ${screenshotPath}
