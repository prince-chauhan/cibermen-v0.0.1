*** Settings ***
Library    QWeb     # Import library

*** Variables ***
${category} =   (For ST,SC,General Category) (Fresh)
${subcategory} =    Postmatric Other Than Intermediate (Fresh)
${district} =   MEERUT
${districtIndx} =   ${1}
${institute} =      'MEERUT INSTITUTE OF ENGINEERING & TECHNOLOGY, MEERUT - 250005 '
${instituteIndx} =   ${1}
${caste} =      सामान्य वर्ग
${casteIndx} =      ${1}
${religion} =      HINDU
${religionIndx} =      ${1}
${studentName}=     Student Name
${fatherName}=     Father Name
${motherName}=     Mother Name
${dob}=     12/09/2000
${gender}=     FEMALE
${female}=      FEMALE
${nameChanged}=     ${1}
${newName}=     New Name
${highSchoolPassingYear}=       2017
${highSchoolBoard}=       'CBSE'
${hsbIndx}=     1
${highSchoolAlphaRoll}=     
${highSchoolRoll}=      ${53456845}
${highSchoolName}=      Hgh School Name
${highSchoolAddress}=      Hgh School Address



*** Test Cases ***
Basic interaction
    OpenBrowser         https://scholarship.up.gov.in/      Chrome   # Open chrome and goto given url
    ClickText       STUDENT                         1s              # Click *button* with specific text
    ClickItem       Registration            Fresh Login             1s     
    ClickText       ${subcategory}          ${category}
    

    #choose city
    ${districtOpt}=    GetDropDownValues       जिला      element_type=dropdown
    FOR     ${indx}     ${dis}      IN ENUMERATE      @{districtOpt}
        IF      "${dis}"=="${district}"
            ${districtIndx}=    Set Variable    ${indx}
        END   
    END
    DropDown    जिला      [[${districtIndx}]]    
    
    
    #choose institute  
    SetConfig       SearchDirection         right
    ${instituteOpt}=    GetDropDownValues       शिक्षण संस्थान          element_type=dropdown    index=2
    FOR     ${indx}     ${ins}      IN ENUMERATE      @{instituteOpt}
        IF      '${ins}'==${institute}
            ${instituteIndx}=    Set Variable    ${indx}
                     
        END   
    END
    DropDown        शिक्षण संस्थान      [[${instituteIndx}]]    index=2   
    ResetConfig
    

    #choose caste
    ${casteOpt}=    GetDropDownValues       वर्ग / जाति समूह    element_type=dropdown
    FOR     ${indx}     ${tempCaste}    IN ENUMERATE    @{casteOpt}
        IF      "${tempCaste}"=="${caste}"
            ${casteIndx}=   Set Variable    ${indx}
        END
    END
    DropDown    वर्ग / जाति समूह        [[${casteIndx}]]
  

    #choose religion
    SetConfig       SearchDirection         right
    ${religionOpt}=    GetDropDownValues       धर्म    element_type=dropdown     index=2
    FOR     ${indx}     ${tempReligion}    IN ENUMERATE    @{religionOpt}
        IF      "${tempReligion}"=="${religion}"
            ${religionIndx}=   Set Variable    ${indx}
        END
    END
    DropDown    धर्म        [[${religionIndx}]]      index=2
    ResetConfig 
    

    #enter student name
    TypeText    छात्र / छात्रा का नाम      ${studentName}    

    
    #enter father name
    SetConfig       SearchDirection         right
    TypeText    पिता का नाम* :      ${fatherName}     index=2
    ResetConfig

    
    #enter mother name
    TypeText    माता का नाम* :      ${motherName}

    
    #enter DOB
    SetConfig       SearchDirection         right
    TypeText    जन्मतिथि * :      ${dob}     index=2
    ResetConfig

    
    #choose gender
    DropDown    लिंग* :      ${gender}

    
    #enter new name if changed after married
    IF      $nameChanged>0 and "${gender}"=="${female}"
        SetConfig       SearchDirection         right
        TypeText    विवाहिता की स्थिति में यदि नाम में परिवर्तन है * :      ${newName}
        ResetConfig
    END

    
    #choose high school passed year
    DropDown        हाई-स्कूल उत्तीर्ण वर्ष *      ${highSchoolPassingYear}

    
    #choose high school board
    ${hsbOpt}=    GetDropDownValues       हाई-स्कूल बोर्ड * :    element_type=dropdown   index=2
    FOR     ${indx}     ${tempHsb}    IN ENUMERATE    @{hsbOpt}
        IF      "${tempHsb}"==${highSchoolBoard}
            ${hsbIndx}=   Set Variable    ${indx}
        END
    END
    DropDown        हाई-स्कूल बोर्ड * :      [[${hsbIndx}]]      index=2


    #enter high school roll no
    ${rollLen} =    GetLength   ${highSchoolAlphaRoll}
    IF  $rollLen>1
        TypeText    हाई-स्कूल बोर्ड का अनुक्रमांक :    ${highSchoolAlphaRoll}     index=1
    END
    TypeText        हाई-स्कूल बोर्ड का अनुक्रमांक :       ${highSchoolRoll}     index=2


    #enter highschool name and Address
    TypeText    विद्यालय / सँस्था का नाम व पता* :    ${highSchoolName}+${highSchoolAddress}
