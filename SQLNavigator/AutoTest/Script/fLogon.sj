//USEUNIT fCommFun
//USEUNIT vGlobalVariables
//USEUNIT fCodeEditor

var strLicensesPath = aqEnvironment.GetEnvironmentVariable("UserProfile", Sys.OSInfo.Windows64bit) + "\\AppData\\Local\\{08439167-4CA5-48E9-A810-A3A7C0B80B06}";

//-------------------------------------------------------------------------------------
//Function Name : Logon
//Author        : Alan.Yang
//Create Date   : May 15, 2015
//Last Modify   : 
//Description   : log on database
//Parameter     : [IN]isFirstTime -- Is first time launch application,defaut= true
//Return        : null
//-------------------------------------------------------------------------------------
function logon(isFirstTime){
    isFirstTime = arguments[0] == undefined ? true:isFirstTime;
    if(bLaunchSQLNav(gStrInstallPath,isFirstTime)){
        initLaunch();
        var objMain = Aliases.Sqlnavigator.frmMain; 
        if(bLogin("TNS")){
            Sys.Refresh();
            setToolBarCustomize();//select all toolbars
            setCodeEditorLayout();
        }else{
            return;
        }
    }
}

//-------------------------------------------------------------------------------------
//Function Name : bLaunchSQLNav
//Author        : Alan.Yang
//Create Date   : May 13, 2015
//Last Modify   : 
//Description   : launching the application of SQLNavigator
//Parameter     : [IN]strInstallPath -- the SQLNaviagtor's installation path
//Parameter     : [IN]isFirstTime -- Is first time launch application,defaut= true
//Return        : boolean
//-------------------------------------------------------------------------------------
function bLaunchSQLNav(strInstallPath,isFirstTime){
    isFirstTime = arguments[1] == undefined ? true:isFirstTime;
    if(Aliases.Sqlnavigator.Exists) killProcess("sqlnavigator");
    if(aqFile.Exists(strInstallPath)){
        var appName = "sqlnavigator.exe";
        Log.Message("The target path: " + aqFileSystem.IncludeTrailingBackSlash(strInstallPath) + appName);
        //Win32API.WinExec(aqFileSystem.IncludeTrailingBackSlash(strInstallPath) + appName,SW_SHOW);
        new ActiveXObject("WScript.Shell").Run("\"" + aqFileSystem.IncludeTrailingBackSlash(strInstallPath) + appName + "\"" );
        
        if(isFirstTime){
            initUserData(); 
            var dlgSelectProfileVersion = Aliases.Sqlnavigator.dlgSelectProfileVersion;
            if(bObjExists(dlgSelectProfileVersion,1)) dlgSelectProfileVersion.btnCancel.Click();
            var dlgInformation = Aliases.Sqlnavigator.dlgInformation;
            if(bObjExists(dlgInformation,1)){
                dlgInformation.Close();
                Log.Message("The Current keys is a Trial Key.");
            }else{
                setAuthorization(gKey,gMessage);
            }
        }
        
        var objMain = Aliases.Sqlnavigator.frmMain; 
        if(bObjExists(objMain,10)){
            Log.Message("SQLNavigator is been opened.")
            return true;
        }else{
            Log.Error("SQLNavigator isn't been opened.",null,pmNormal,null,Sys.Desktop);
            return false;
        }
    }else{
        Log.Error("The path [ " + strInstallPath + " ] is invalid.",null,pmNormal,null,Sys.Desktop);
        return false;
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setAuthorization
//Author        : Alan.Yang
//Create Date   : May 13, 2015
//Last Modify   : 
//Description   : setting SQL Navigator Authorization key
//Parameter     : [IN]strKey -- the Authorization key
//Parameter     : [IN]strMessage -- the site message
//Return        : null
//-------------------------------------------------------------------------------------
function setAuthorization(strKey,strMessage){
    var objAuthorization = Aliases.Sqlnavigator.wnAuthorizeForm;
    var frmLicUpgrade = Aliases.Sqlnavigator.frmLicUpgrade;
    if(bObjExists(frmLicUpgrade,1)) frmLicUpgrade.btnClose.Click();//A "License Upgrade" dialog is displayed if there is only valid old key found.
    if(bObjExists(objAuthorization,1)){
        var objKey = objAuthorization.edtKey;
        var objMessage = objAuthorization.edtMesage;
        var btnOK = objAuthorization.btnOK;
        Delay(500);
        objKey.wText = strKey;
        objMessage.wText = strMessage;
        Log.Message("Setting the key is: "+ strKey);
        Log.Message("Setting the site message is: "+ strMessage);
        btnOK.Click();
        var objConfirm = Aliases.Sqlnavigator.wnAuthorizeConfirm;
        if(objConfirm.Exists){
            var btnConfirmOK = objConfirm.btnOK;
            btnConfirmOK.Click();
        }
        var foundFlie = aqFileSystem.FindFiles(strLicensesPath,"ProductLicenses.xml");
        if(foundFlie != null && foundFlie.Count == 1){
            Log.Message("The ProductLicenses.xml file is found.");
            Log.Message(aqFileSystem.IncludeTrailingBackSlash(strLicensesPath) + foundFlie.Item(0).name);
        }else{
            Log.Error("The ProductLicenses.xml file is not found.",null,pmNormal,null,Sys.Desktop);
        }
    }else{
        Log.Error("The Authorization dialog has not displayed when Nav install for the first time.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : bLogin
//Author        : Alan.Yang
//Create Date   : May 15, 2015
//Last Modify   : 
//Description   : according to type setting logon datas and logon
//Parameter     : [IN]strType -- the type of connection
//Return        : boolean
//-------------------------------------------------------------------------------------
function bLogin(strType){
    var objMain = Aliases.Sqlnavigator.frmMain;
    var objLogon = Aliases.Sqlnavigator.frmLogon;
    var objUserName = objLogon.grpConnection.edtUserName;
    var objPassword = objLogon.grpConnection.edtPassword;
    while(objLogon.Exists && !objUserName.Enabled) {objLogon.Close();}
    if(!objLogon.Exists) objMain.Keys("~SN");
    var strSelectDB;
    if(objLogon.Exists){
        var objContainer = objLogon.grpConnection.pgTypes;
        switch(strType){
            case "TNS":
                objContainer.ClickTab(0);
                if(objContainer.wFocusedTab==0){
                    var objTNS = objContainer.tabsTNS.cmbTNSList;
                    objTNS.wText = gTNSname;
                    Log.Message("Have selected database: " + gTNSname);
                    strSelectDB = gTNSname;
                }else{
                    Log.Error(strType + " tab is not been selected.",null,pmNormal,null,Sys.Desktop);
                    return false;
                }
                break;
            case "Direct":
                objContainer.ClickTab(1);
                if(objContainer.wFocusedTab==1){
                    var objHost = objContainer.tabsDirect.edtHost;
                    var objPort = objContainer.tabsDirect.edtPort;
                    var objService = objContainer.tabsDirect.edtServiceName;
                    objHost.Text = gHost;
                    objPort.Text = gPort;
                    objService.Text = gServiceName;
                    Log.Message("Have typed database: " + gHost + ":" + gPort + "/" + gServiceName);
                    strSelectDB = gServiceName;
                }else{
                    Log.Error(strType + " tab is not been selected.",null,pmNormal,null,Sys.Desktop);
                    return false;
                }
                break;
            case "LDAP":
                objContainer.ClickTab(2);
                if(objContainer.wFocusedTab==2){
                    var objServer = objContainer.tabsLDAP.cmbServer;
                    var objDescripter = objContainer.tabsLDAP.cmbDescriptor;
                    objServer.wText = gLDAPServer;
                    objDescripter.wText = gLDAPDescriptor;
                    Log.Message("Have selected LDAP: " + gLDAPServer + "/" + gLDAPDescriptor);
                    strSelectDB = gLDAPDescriptor;
                }else{
                    Log.Error(strType + " tab is not been selected.",null,pmNormal,null,Sys.Desktop);
                    return false;
                }
                break;
        }
        
        var objLogonOK = objLogon.btnOK;
        if(objUserName.Enabled && objPassword.Enabled){
            objUserName.Keys(gUserName);
            objPassword.Keys(gPassword);
            Log.Message("Username: " + gUserName + " Password: " + gPassword);
            if(objLogonOK.Enabled){
                objLogonOK.Click();
                Log.Message("Click Login's OK button.");
                var frmConfirmationDialog = Aliases.Sqlnavigator.frmConfirmationDialog;
                if(frmConfirmationDialog.Exists){
                    if(!frmConfirmationDialog.chkDontAskMeAgain.Checked)frmConfirmationDialog.chkDontAskMeAgain.Click();
                    frmConfirmationDialog.btnNo.Click();
                }
                var objCodeEditor = getCodeEditorFrames()[0];
                if(bObjExists(objCodeEditor,2)){//whether success to logon or not
                    Delay(1000);
                    if(objCodeEditor.WndCaption.indexOf(strSelectDB) != -1){//confirm the caption of main window
                        Log.Message("Success to log on database: " + strSelectDB);
                        return true;
                    }else{
                        Log.Error("Code Editor's caption \""+ objCodeEditor.WndCaption +"\" is not contain:"+strSelectDB,null,pmNormal,null,Sys.Desktop);
                        return false;
                    }
                }else{
                    Log.Error("Log on failed, Unified Editor is not show.",null,pmNormal,null,Sys.Desktop);
                    return false;
                }
            }else{
                Log.Error("OK button is disabled.",null,pmNormal,null,Sys.Desktop);
                return false;
            }
        }else{
            Log.Error("Username or Password textbox is disabled.",null,pmNormal,null,Sys.Desktop);
            return false;
        }
    }else{
        Log.Error("The Logon window is not show.",null,pmNormal,null,Sys.Desktop);
        return false; 
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setToolBarCustomize
//Author        : Alan.Yang
//Create Date   : July 15, 2015
//Last Modify   : 
//Description   : select all toolbars
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setToolBarCustomize(){
    var objHeadZone = getHeadZone();
    if(objHeadZone != null){
        Sys.Refresh();
        Delay(1000);
        var maxCount = objHeadZone.ChildCount;
        var objTaskBar = Aliases.Sqlnavigator.frmMain.TaskBarZone.TaskBar;
        if(maxCount != 6 || !objTaskBar.Exists){
            objHeadZone.ClickR();
            Log.Message("Right click the [Main Menu Bar].");
            objHeadZone.Keys("C");//customize 
            Log.Message("Click on Item---[Customize]");
            var dlgCustomize = Aliases.Sqlnavigator.dlgToolBarCustomize;
            if(dlgCustomize.Exists){
                var tabsControl = dlgCustomize.PageControl;
                tabsControl.ClickTab(0);
                if(tabsControl.wFocusedTab == 0){
                    var ToolBarList = tabsControl.ToolBarList;
                
                    for(i=1; i<ToolBarList.wItemCount; i++){
                        ToolBarList.SelectItem(i);
                        ToolBarList.DblClickItem(ToolBarList.wItem(i));
                        objHeadZone.Refresh();
                        if(objHeadZone.ChildCount < maxCount){//previous doubleclick is not select
                            Log.Message("Selected the item: "+ToolBarList.wItem(i)+" once again.");
                            ToolBarList.DblClickItem(ToolBarList.wItem(i));
                        }else{
                            Log.Message("Selected the item: "+ToolBarList.wItem(i));
                        }
                        objHeadZone.Refresh();
                        maxCount = objHeadZone.ChildCount;
                    }
                    Sys.Refresh();
                    if(objHeadZone.ChildCount == 6){
                        Aliases.Sqlnavigator.frmMain.RefreshMappingInfo();
                        if(!objTaskBar.Exists || !objTaskBar.Visible){//invisible or not exists
                            ToolBarList.SelectItem("Task Bar (List of Windows)");
                            ToolBarList.DblClickItem(ToolBarList.wSelectedItems);
                        }
                        Log.Message("Success to select all Toolbars.");
                    }else{
                        Log.Error("Fail to select all Toolbars.",null,pmNormal,null,Sys.Desktop);
                    }
                }else{
                    Log.Error("Fail to select the [Toolbars] tab.",null,pmNormal,null,Sys.Desktop);
                }
                dlgCustomize.Close();
            }else{
                Log.Error("The ToolBar Customize dialog is not show.",null,pmNormal,null,Sys.Desktop);
            }
        }else{
            Log.Message("Have selected all Toolbars.");
        }
    }else{
        Log.Error("Main Menu Bar is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : getHeadZone
//Author        : Alan.Yang
//Create Date   : May 22, 2015
//Last Modify   : 
//Description   : get the Panel of Main Menu Bar 
//Parameter     : null
//Return        : Object
//-------------------------------------------------------------------------------------
function getHeadZone(){
    var objMain = Aliases.Sqlnavigator.frmMain;
    var maxCount = 0, HeadIndex = 0;
    var PropArray = new Array("Name");
    var ValuesArray = new Array("Window(\"TdxDockControl\", \"\", *)");
    var counter = 1;
    while(!objMain.Exists || !objMain.Visible){
        Delay(1000);
        if(counter > 10) return null;
        counter++;
    }
    try
    {
        var arrDocks = objMain.FindAllChildren(PropArray,ValuesArray,1);
        arrDocks = (new VBArray(arrDocks)).toArray();
        if(arrDocks.length > 0){
            for(i=0; i<arrDocks.length; i++){
                arrDocks[i].Refresh();
                if(arrDocks[i].ChildCount > maxCount){
                    maxCount = arrDocks[i].ChildCount;
                    HeadIndex = i;
                }
            }
            return arrDocks[HeadIndex];
        }else{
            return null;
        }
    }
    catch (e)
    {
        Log.Error(e.message);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : initUserData
//Author        : Alan.Yang
//Create Date   : July 15, 2015
//Last Modify   : 
//Description   : delete the appdata and registry data about SQLNav  
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function initUserData(){
    Log.Message("This action will initialize the AppData and Registry data about SQLNav.");
    //delete appdata
    var strAppdataPath = aqEnvironment.GetEnvironmentVariable("appdata", Sys.OSInfo.Windows64bit) + "\\Dell\\";
    if(aqFile.Exists(strAppdataPath)){
        var AppFolders = aqFileSystem.FindFolders(strAppdataPath,"SQL Navigator *",false);
        if(AppFolders != null){
            while (AppFolders.HasNext())
            {
                aqFileSystem.DeleteFolder(AppFolders.Next().Path,true);
            }
        }
    }
    //delete registry info
    var wsh = new ActiveXObject("WScript.Shell");
    var strRegKey = "HKEY_CURRENT_USER\\Software\\Dell";
    try
    {
        var result = wsh.Run("%comspec% /c reg delete \"" + strRegKey + "\" /f",0);
    }
    catch (e)
    {
        Log.Warning(e.message);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : initLaunch
//Author        : Alan.Yang
//Create Date   : July 15, 2015
//Last Modify   : 
//Description   : initialize the launch setting of SQLNav 
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function initLaunch(){
    Log.Message("This action will initialize the launch setting of SQLNav.");
    var frmConfirmationDialog = Aliases.Sqlnavigator.frmConfirmationDialog;
    if(frmConfirmationDialog.Exists){
        if(!frmConfirmationDialog.chkDontAskMeAgain.Checked)frmConfirmationDialog.chkDontAskMeAgain.Click();
        frmConfirmationDialog.btnNo.Click();
    }
    
    var frmTutorMessage = Aliases.Sqlnavigator.frmTutorMessage;
    if(frmTutorMessage.Exists){
        if(!frmTutorMessage.chkNoMore.Checked)frmTutorMessage.chkNoMore.Click();
        frmTutorMessage.btnOK.Click();
    }
    
    var frmWhatisNew = Aliases.Sqlnavigator.frmWhatisNew;
    if(frmWhatisNew.Exists) frmWhatisNew.btnOK.Click();
    
}