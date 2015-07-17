//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT fConfirmations
//USEUNIT fCodeEditor
//USEUNIT CodeEditor_Syntax

function checkCodeEditorToolbar(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    if(frmMain.Exists && frmMain.Visible){
        closeCodeEditor();
        frmMain.Keys("^m");
        setCodeEditorLayout();
        var frmCodeEditor = getCodeEditorFrames()[0];
        var edtCodeEditor = getCurrentTab();
        if(edtCodeEditor != null){  
//            showCodeEditorToolbar("");//just selected file toolbar
//            var objFileToolbar = frmCodeEditor.CEToolbarControl.FileToolbar;
//            clickToolbarButton("Back",22,objFileToolbar,"func_Pre_Back();","closeCurrentTab();");
//            clickToolbarButton("Forward",44,objFileToolbar,"func_Pre_Forward();","closeCurrentTab();");
//            clickToolbarButton("New SQL",74,objFileToolbar,"func_Pre_NewSQL();","func_Post_NewSQL();");
//            clickToolbarButton("New Store Object",99,objFileToolbar,"func_Pre_NewStoreObject();","func_Post_NewStoredObject();");
//            clickToolbarButton("Open File",123,objFileToolbar,"func_Pre_OpenFile();","func_Post_OpenFile();");
//            clickToolbarButton("Open File",123,objFileToolbar,"func_Pre_OpenFile();","func_Post_OpenFile();");
//            clickToolbarButton("Save To File",162,objFileToolbar,"func_Pre_SaveToFile();","func_Post_SaveToFile();");
//            clickToolbarButton("Open Object",186,objFileToolbar,"func_Pre_OpenObject();","func_Post_OpenObject();");
//            clickToolbarButton("Auto Code Completion",231,objFileToolbar,"func_Pre_AutoCodeCompletion();","func_Post_AutoCodeCompletion();");
//            clickToolbarButton("Vertical Split",255,objFileToolbar,"","closeCurrentTab();");
//            
//            showCodeEditorToolbar("Edit Toolbar");
//            var objEditToolbar = frmCodeEditor.CEToolbarControl.EditToolbar;
//            clickToolbarButton("Undo",22,objEditToolbar,"func_Pre_Undo();","func_Post_Undo();");
//            clickToolbarButton("Redo",46,objEditToolbar,"func_Pre_Redo();","func_Post_Redo();");  
//            clickToolbarButton("Copy",68,objEditToolbar,"func_Pre_Copy();","func_Post_Copy();");
//            clickToolbarButton("Cut",93,objEditToolbar,"func_Pre_Cut();","func_Post_Cut();");
//            clickToolbarButton("Paste",118,objEditToolbar,"func_Pre_Paste();","func_Post_Paste();");
//            clickToolbarButton("Uncomment",140,objEditToolbar,"func_Pre_UnComment();","func_Post_UnComment();");
//            clickToolbarButton("Comment",165,objEditToolbar,"func_Pre_Comment();","func_Post_Comment();");
            
            showCodeEditorToolbar("SQL Toolbar");
            var objSQLToolbar = frmCodeEditor.CEToolbarControl.SqlToolbar;
            clickToolbarButton("Send To Session",16,objSQLToolbar,"func_Pre_SendToSession();","func_Post_SendToSession();");
            clickToolbarButton("Add Condition",61,objSQLToolbar,"func_Pre_AddCondition();","func_Post_AddCondition();");
            clickToolbarButton("Remove All Conditions",84,objSQLToolbar,"func_Pre_RemoveAllConditions();","func_Post_RemoveAllConditions();");
            clickToolbarButton("Updateable",116,objSQLToolbar,"func_Pre_TurnOff(\"Updateable\");","func_Post_TurnOn(\"Updateable\");");
            clickToolbarButton("Stop On Error",140,objSQLToolbar,"func_Pre_TurnOff(\"Stop On Error\");","func_Post_TurnOn(\"Stop On Error\");");
            clickToolbarButton("Fetch All",165,objSQLToolbar,"func_Pre_TurnOff(\"Fetch All\");","func_Post_TurnOn(\"Fetch All\");");
            clickToolbarButton("Spool To Screen",188,objSQLToolbar,"func_Pre_TurnOff(\"Spool To Screen\");","func_Post_TurnOn(\"Spool To Screen\");");
            clickToolbarButton("Scan Defines",212,objSQLToolbar,"func_Pre_TurnOff(\"Scan Defines\");","func_Post_TurnOn(\"Scan Defines\");");
            clickToolbarButton("Echo SQL",234,objSQLToolbar,"func_Pre_TurnOff(\"Echo SQL\");","func_Post_TurnOn(\"Echo SQL\");");
            
//            clickToolbarButton("SQL History",258,objSQLToolbar,"func_Pre_SQLHistory","func_Post_SQLHistory");
//            clickToolbarButton("Expand SQL Pane",291,objSQLToolbar,"func_Pre_Expand","func_Post_Expand");
//            clickToolbarButton("Skip To Top",322,objSQLToolbar,"func_Pre_SkipToTop","func_Post_SkipToTop");
//            clickToolbarButton("Skip To Previous",348,objSQLToolbar,"func_Pre_SkipToPrevious","func_Post_SkipToTop");
//            clickToolbarButton("Execute To End",371,objSQLToolbar,"func_Pre_ExcutetoEnd","func_Post_ExcutetoEnd");
//            clickToolbarButton("Execute Step",393,objSQLToolbar,"func_Pre_ExcuteStep","func_Post_ExcuteStep");
//            clickToolbarButton("Stop",419,objSQLToolbar,"func_Pre_Stop","func_Post_Stop");
//            clickToolbarButton("Skip Step",442,objSQLToolbar,"func_Pre_SkipStep","func_Post_SkipToTop");
//            clickToolbarButton("Skip To Bottom",466,objSQLToolbar,"func_Pre_SkipToBottom","func_Post_SkipToTop");
//            clickToolbarButton("PLSQL Debugger",497,objSQLToolbar,"func_Pre_Debugger","func_Post_Debugger");
              
        }
    }
    else{
        Log.Error("SQLNav aplication is not exists.",null,pmNormal,null,Sys.Desktop);
    }

}

//-------------------------------------------------------------------------------------
//Function Name : clickToolbarButton
//Author        : Alan.Yang
//Create Date   : July 15, 2015
//Last Modify   : 
//Description   : click the button on toolbar
//Parameter     : [IN]strButtonName -- the button name
//Parameter     : [IN]objToolbar -- the toolbar object
//Parameter     : [IN]intPositionX -- the position of X
//Parameter     : [IN]funcPreRun -- if funcPreRun not equal empty, the run the funcPreRun at first
//Parameter     : [IN]funcPostRun -- if funcPostRun not equal empty, the run the funcPostRun after funcPreRun
//Return        : null
//-------------------------------------------------------------------------------------
function clickToolbarButton(strButtonName,intPositionX,objToolbar,funcPreRun,funcPostRun){
    if(objToolbar.Exists){
        if(funcPreRun != "") eval(funcPreRun);
        
        objToolbar.Click(objToolbar.Width*(intPositionX/objToolbar.Width),objToolbar.Height/2);
        Log.Message("Click Toolbar Button ["+ strButtonName +"].");
        
        if(funcPostRun != "") eval(funcPostRun);
    }
    else{
        Log.Error("Toolbar "+ strButtonName +" is not exists.",null,pmNormal,null,Sys.Desktop);
        return;
    }
}

/****************************** File Toolbar ******************************/
//Back
function func_Pre_Back(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    var bbtnBack = frmMain.MiddleZone.frmUnifiedEditor.bbtnBack;
    checkToolbarButtonStatus("Back",bbtnBack,false,false);
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("declare testing number(5) :=0; testing");
        Delay(500);
        edtCodeEdtior.Keys("^[Enter]");
    }
    Delay(500);
    checkToolbarButtonStatus("Back",bbtnBack,true,false);
}
//Forward
function func_Pre_Forward(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    var bbtnForward = frmMain.MiddleZone.frmUnifiedEditor.bbtnForward;
    var objFileToolbar = frmMain.MiddleZone.frmUnifiedEditor.CEToolbarControl.FileToolbar; 
    checkToolbarButtonStatus("Forward",bbtnForward,false,false);
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("declare testing number(5) :=0; testing");
        Delay(500);
        edtCodeEdtior.Keys("^[Enter]");
        objFileToolbar.Click(objFileToolbar.Width*(22/objFileToolbar.Width),objFileToolbar.Height/2);
        Log.Message("Click on Toolbar button---[Back].");
    }
    Delay(500);
    checkToolbarButtonStatus("Forward",bbtnForward,true,false);
}
//New SQL
function func_Pre_NewSQL(){
    var bbtnNewSQL = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnNewSQLTab;
    checkToolbarButtonStatus("New SQL",bbtnNewSQL,true,false);
}

function func_Post_NewSQL(){
    var objTabcontorl = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlTabBar.TabScripts;
    if(objTabcontorl.TabIndex>0){
        Log.Message("New Sql tab has displayed.");
    }
    else{
        Log.Error("New Sql tab has not displayed.",null,pmNormal,null,Sys.Desktop);
    }
}
//New Store Object
function func_Pre_NewStoreObject(){
    var bbtnNewStoreObject = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnNewStoredObj;
    checkToolbarButtonStatus("New Store Object",bbtnNewStoreObject,true,false);
}

function func_Post_NewStoredObject(){
    var frmNewObject = Aliases.Sqlnavigator.frmNewObject;
    existAndCloseWin("New Store Object",frmNewObject);
}
//open file
function func_Pre_OpenFile(){
    var bbtnOpenFile = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnOpenFile;
    checkToolbarButtonStatus("Open File",bbtnOpenFile,true,false);
}

function func_Post_OpenFile(){
    var dlgOpenFile = Aliases.Sqlnavigator.dlgOpenFile;
    existAndCloseWin("Open File",dlgOpenFile);
}
//Save to File
function func_Pre_SaveToFile(){
    var bbtnSaveToFile = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnSaveToFile;
    checkToolbarButtonStatus("Save to File",bbtnSaveToFile,false,false);
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("select 'Test for save to file' from dual;");
    }
    checkToolbarButtonStatus("Save to File",bbtnSaveToFile,true,false);
}

function func_Post_SaveToFile(){
    var dlgSaveAs = Aliases.Sqlnavigator.dlgSaveAs;
    existAndCloseWin("Save to File",dlgSaveAs);
}
//Open Object
function func_Pre_OpenObject(){
    var bbtnOpenObject = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnOpenObj;
    checkToolbarButtonStatus("Open Object",bbtnOpenObject,true,false);
}

function func_Post_OpenObject(){
    Delay(2000);
    var frmOpenDBObject = Aliases.Sqlnavigator.frmOpenDBObject;
    existAndCloseWin("Select DB Object",frmOpenDBObject);
}
//Auto Code Completion
function func_Pre_AutoCodeCompletion(){
    var bbtnAutoComplete = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnAutoComplete;
    checkToolbarButtonStatus("Auto Code Completion",bbtnAutoComplete,true,true);//Auto Code Completion default status is open
}

function func_Post_AutoCodeCompletion(){
    var objFileToolbar = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.CEToolbarControl.FileToolbar; 
    var bbtnAutoComplete = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnAutoComplete;
    if(!bbtnAutoComplete.Down){
        objFileToolbar.Click(objFileToolbar.Width*(231/objFileToolbar.Width),objFileToolbar.Height/2);
        Log.Message("Turn on [Auto Code Completion].");
    }
}

/****************************** Edit Toolbar ******************************/
//Undo
function func_Pre_Undo(){
    var bbtnUndo = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnUndo;
    checkToolbarButtonStatus("Undo",bbtnUndo,false,false);
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("Test Undo");
    }
    checkToolbarButtonStatus("Undo",bbtnUndo,true,false);
}

function func_Post_Undo(){
    if(sCopyObjText(getCurrentTab())==""){
        Log.Message("Success to undo the content in Code Editor.");
    }
    else{
        Log.Error("Fail to undo the content in Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
    closeCurrentTab();
}
//Redo
function func_Pre_Redo(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    var bbtnRedo = frmMain.MiddleZone.frmUnifiedEditor.bbtnRedo;
    checkToolbarButtonStatus("Redo",bbtnRedo,false,false);
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("Test Redo");
    }
    frmMain.Keys("~EU");
    Log.Message("Click on MainMenu --> Edit --> Undo");
    checkToolbarButtonStatus("Redo",bbtnRedo,true,false);
}

function func_Post_Redo(){
    if(sCopyObjText(getCurrentTab())=="Test Redo"){
        Log.Message("Success to redo the content in Code Editor.");
    }
    else{
        Log.Error("Fail to redo the content in Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
}
//Copy
function func_Pre_Copy(){
    var bbtnCopy = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnCopy;
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        checkToolbarButtonStatus("Copy",bbtnCopy,false,false);
        edtCodeEdtior.Keys("Test Copy");
        edtCodeEdtior.Keys("^a");
    }
    checkToolbarButtonStatus("Copy",bbtnCopy,true,false);
}

function func_Post_Copy(){
    if(Sys.Clipboard =="Test Copy"){
        Log.Message("Success to copy the content from Code Editor.");
    }
    else{
        Log.Error("Fail to copy the content from Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
}
//Cut
function func_Pre_Cut(){
    var bbtnCut = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnCut;
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        checkToolbarButtonStatus("Cut",bbtnCut,false,false);
        edtCodeEdtior.Keys("Test Cut");
        edtCodeEdtior.Keys("^a");
        checkToolbarButtonStatus("Cut",bbtnCut,true,false);
    }
}

function func_Post_Cut(){
    if(Sys.Clipboard =="Test Cut" && sCopyObjText(getCurrentTab()) == ""){
        Log.Message("Success to cut the content from Code Editor.");
    }
    else{
        Log.Error("Fail to cut the content from Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
}
//Paste
function func_Pre_Paste(){
    Sys.Clipboard = "";
    var bbtnPaste = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnPaste;
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("Test Paste");
        edtCodeEdtior.Keys("^a^c[Del]");
        checkToolbarButtonStatus("Paste",bbtnPaste,true,false);
    }
}

function func_Post_Paste(){
    if(sCopyObjText(getCurrentTab()) == "Test Paste"){
        Log.Message("Success to paste the clipborad's content into Code Editor.");
    }
    else{
        Log.Error("Fail to paste the clipborad's content into Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
}
//Uncomment
function func_Pre_UnComment(){
    var bbtnUncomment = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnUncommentSel;
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        checkToolbarButtonStatus("Uncomment",bbtnUncomment,false,false);
        edtCodeEdtior.Keys("/*select * from dual;*/");
        edtCodeEdtior.Keys("^a");
        checkToolbarButtonStatus("Uncomment",bbtnUncomment,true,false);
    }
}

function func_Post_UnComment(){
    if(sCopyObjText(getCurrentTab()) == "select * from dual;"){
        Log.Message("Success to uncomment the content in Code Editor.");
    }
    else{
        Log.Error("Fail to uncomment the content in Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
}
//Comment
function func_Pre_Comment(){
    var bbtnComment = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnCommentSel;
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        checkToolbarButtonStatus("Comment",bbtnComment,false,false);
        edtCodeEdtior.Keys("select * from dual;");
        edtCodeEdtior.Keys("^a");
        checkToolbarButtonStatus("Comment",bbtnComment,true,false);
    }
}

function func_Post_Comment(){
    if(sCopyObjText(getCurrentTab()) == "/*select * from dual;*/"){
        Log.Message("Success to comment the content in Code Editor.");
    }
    else{
        Log.Error("Fail to comment the content in Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
}

/****************************** SQL Toolbar ******************************/
//Send to session
function func_Pre_SendToSession(){
    var bbtnSendToSession = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnSendToNewSess;
    checkToolbarButtonStatus("Send To Session",bbtnSendToSession,true,false);
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        edtCodeEdtior.Keys("Test Send to session");
    }
}

function func_Post_SendToSession(){
    var objSqlToolbar = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.CEToolbarControl.SqlToolbar;
    var bbtnSendToNewSession = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnSendToNewSess;
    checkToolbarButtonStatus("Send To New Session",bbtnSendToNewSession,true,false);
    objSqlToolbar.Keys("[Down][Down][Enter]");
    var frmLogon = Aliases.Sqlnavigator.frmLogon;
    existAndCloseWin("Logon",frmLogon); 
}
//Add condition
function func_Pre_AddCondition(){
    var bbtnAddCondition = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnAddCondition;
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        checkToolbarButtonStatus("Add Condition",bbtnAddCondition,false,false);
        edtCodeEdtior.Keys("select * from auto_tab_emp;");
        checkToolbarButtonStatus("Add Condition",bbtnAddCondition,true,false);
    }
}

function func_Post_AddCondition(){
    var frmAddFilter = Aliases.Sqlnavigator.frmAddFilter;
    if(frmAddFilter.Exists){
        Log.Message("It will add condition: ["+frmAddFilter.cmbField.wText+" "+frmAddFilter.cmbOperator.wText +"].");
        if(!frmAddFilter.ckbSubmitQuery.Checked) frmAddFilter.ckbSubmitQuery.Click();
        frmAddFilter.btnOK.Click();
        checkExecuteResult();
    }
    closeCurrentTab();
}
//Remove All Conditions
function func_Pre_RemoveAllConditions(){
    var bbtnRemoveAllCondition = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnRemoveAllCondition;
    var edtCodeEdtior = getCurrentTab();
    if(edtCodeEdtior != null){
        edtCodeEdtior.Keys("^a[Del]");
        checkToolbarButtonStatus("Remove All Conditions",bbtnRemoveAllCondition,false,false);
        edtCodeEdtior.Keys("select * from auto_tab_emp e where e.empno is not null;");
        checkToolbarButtonStatus("Remove All Conditions",bbtnRemoveAllCondition,true,false);
    }
}

function func_Post_RemoveAllConditions(){
    var dlgConfirm = Aliases.Sqlnavigator.dlgConfirm;
    if(dlgConfirm.Exists){
        Log.Message("It will remove all conditions from the current query.");
        dlgConfirm.btnYes.Click();
        if(sCopyObjText(getCurrentTab()) == "select * from auto_tab_emp e"){
            Log.Message("Success to remove all conditions from the current query.");
        }
        else{
            Log.Error("Fail to remove all conditions from the current query.",null,pmNormal,null,Sys.Desktop);
        }
    }
    closeCurrentTab();
}
//button turn off 
function func_Pre_TurnOff(strName){
    var bbtnMappedName,intPositonX;
    var objSQLToolbar = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.CEToolbarControl.SqlToolbar;
    switch (strName)
    {
      case "Updateable":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnUpdateable;
        intPositonX = 116;
        break;
    
      case "Stop On Error":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnStopOnErr;
        intPositonX = 140;
        break;
      case "Fetch All":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnFetchAll;
        intPositonX = 165;
        break;
      case "Spool To Screen":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnSpoolToScreen;
        intPositonX = 188;
        break;
      case "Scan Defines":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnScanBinds;
        intPositonX = 212;
        break;
      case "Echo SQL":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnEchoSQL;
        intPositonX = 234;
        break;
      default:
        break;
    }
    if(bbtnMappedName.Down){
        objSQLToolbar.Click(objSQLToolbar.Width*(intPositonX/objSQLToolbar.Width),objSQLToolbar.Height/2);
        Log.Message("Turn off ["+ strName +"].");
    }
    checkToolbarButtonStatus(strName,bbtnMappedName,true,false);
}
//button turn on
function func_Post_TurnOn(strName){
    var bbtnMappedName;
    switch (strName)
    {
      case "Updateable":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnUpdateable;
        break;
      case "Stop On Error":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnStopOnErr;
        break;
      case "Fetch All":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnFetchAll;
      case "Spool To Screen":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnSpoolToScreen;
      case "Scan Defines":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnScanBinds;
      case "Echo SQL":
        bbtnMappedName = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.bbtnEchoSQL;
      default:
        break;
    }
    checkToolbarButtonStatus(strName,bbtnMappedName,true,true);
}

