//USEUNIT fCommFun  

//-------------------------------------------------------------------------------------
//Function Name : checkDialogError
//Author        : Alan.Yang
//Create Date   : May 19, 2015
//Last Modify   : 
//Description   : checking all type of error dialogs
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkDialogError(){
    var objError = Aliases.Sqlnavigator.dlgError;//normal error dialog
    var objErrorOccurred = Aliases.Sqlnavigator.dlgErrorOccurred;//error occurred dialog
    //var objEurekaLog = Aliases.Sqlnavigator;//EurekaLog AV dialog
    
    if(objError.Exists){//normal error
        Log.Error("Exist Error dialog.",null,pmNormal,null,Sys.Desktop);
        objError.btnOK.Click();
    }
    else if(objErrorOccurred.Exists){//Error occurred
        Log.Error("Exist Error occurred dialog.",null,pmNormal,null,Sys.Desktop);
        objErrorOccurred.btnOK.Click();
    }
//    else if(objEurekaLog.Exists){//EurekaLog AV exception
//        Log.Error("Exist EurekaLog AV error dialog.",null,pmNormal,null,Sys.Desktop);
//    }
    
}

//-------------------------------------------------------------------------------------
//Function Name : checkOutputError
//Author        : Alan.Yang
//Create Date   : May 18, 2015
//Last Modify   : 
//Description   : checking the output's error
//Parameter     : [IN]bIsClear -- is clear all output info ? default = true
//Return        : null
//-------------------------------------------------------------------------------------
function checkOutputError(bIsClear){
    var bIsClearOutput = arguments[0] == undefined ? true : bIsClear; //default = true
    var objPanelOutput = Aliases.Sqlnavigator.frmMain.BottomZone.pnlOutput;
    if(objPanelOutput.Exists){
        var objPagesOutput = objPanelOutput.pcOutput;
        if(objPagesOutput.Exists){
            var PropArray = new Array("Name");
            var ValuesArray = new Array("VCLObject(\"ts*\")");
            var arrTabs = objPagesOutput.FindAllChildren(PropArray,ValuesArray,1);
            arrTabs = (new VBArray(arrTabs)).toArray();
            for(i=0; i< objPagesOutput.wTabCount; i++){//traversing each tab
                objPagesOutput.ClickTab(i);
                if(i==0){
                    var objTabChild = objPagesOutput.tabGeneral.t_Output; //General tab
                }
                else{
                    if(arrTabs.length >0)
                        var objTabChild = arrTabs[i-1].VCLObject("vstOutput*");
                }
                if(objTabChild.Exists){
                    var intErrorNum = 0;
                    Sys.Clipboard = "";// clear clipboard
                    objTabChild.Click();
                    objTabChild.Keys("^A^C");//copy to clipboard
                    var strContents = Sys.Clipboard;
                    var strErrorTypePath = Project.Path + "AutoFiles\\ErrorType\\ErrorType.txt";
                    var arrErrorTypes = new Array();
                    
                    arrErrorTypes = aqFile.ReadWholeTextFile(strErrorTypePath,22).split(";");// use ; to separator text
                    for(j=0; j<arrErrorTypes.length; j++){
                        if(strContents.indexOf(arrErrorTypes[j])>-1){
                            intErrorNum++;
                        }
                    }
                    
                    if(intErrorNum > 0){//output errors
                        Log.Error("Output exists error info in tab ["+objPagesOutput.wTabCaption(i)+"].",null,pmNormal,null,Sys.Desktop);
                    }
                    
                    if(bIsClearOutput){//clear all oupput 
                        objTabChild.Keys("^[Del]");// ctrl + delete
                        Log.Message("Clear tab ["+objPagesOutput.wTabCaption(i)+"]'s output contents.");
                    }
                } 
            }
        }
        else{
            Log.Error("The output page control area is not exist.",null,pmNormal,null,Sys.Desktop);
            return;
        }
    }
    else{
        Log.Error("The output panel is not found.",null,pmNormal,null,Sys.Desktop);
        return;
    }  
}

//-------------------------------------------------------------------------------------
//Function Name : checkOutputByGivenString
//Author        : Alan.Yang
//Create Date   : May 23, 2015
//Last Modify   : 
//Description   : checking the output's message by given string in current session
//Parameter     : [IN]strCheckString -- the specified string of check
//Return        : null
//-------------------------------------------------------------------------------------
function checkOutputByGivenString(strCheckString){
    var objCurrentOutput =Aliases.Sqlnavigator.frmMain.BottomZone.pnlOutput.pcOutput.tabCurrent.t_currentOutput;
    if(objCurrentOutput.Exists & objCurrentOutput.wItems != null){
        var flag = 0;
        Log.Message("Start to check string \""+ strCheckString +"\" in output.")
        for(i=0; i<objCurrentOutput.wItems.Count; i++){
            Sys.Clipboard = "";
            objCurrentOutput.wItems.Item(i).Click();
            objCurrentOutput.Keys("^c");
            if(trim(Sys.Clipboard).indexOf(strCheckString)!=-1){
                Log.Message("Success to check the specified message in output.");
                flag = 1;
                break;
            }
            else if(trim(Sys.Clipboard).indexOf("ERROR")!=-1){
                Log.Message("Find some errors: "+Sys.Clipboard);
                break;
            }
        }
        if(flag == 0) Log.Error("Fail to check the specified message in output",null,pmNormal,null,Sys.Desktop);
    }
}