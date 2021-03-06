
//-------------------------------------------------------------------------------------
//Function Name : getCodeEditorFrames
//Author        : Alan.Yang
//Create Date   : May 25, 2015
//Last Modify   : 
//Description   : get all of Code Editor Frames.
//Parameter     : null
//Return        : Object Array
//-------------------------------------------------------------------------------------
function getCodeEditorFrames(){
    var objMDI = Aliases.Sqlnavigator.frmMain.MiddleZone;
    var objCodeEditor = objMDI.frmUnifiedEditor;
    var PropArray = new Array("Name");
    var ValuesArray = new Array("VCLObject(\"frmUnifiedEditor_*\")");
    try
    {
        var arrCodeEditor = objMDI.FindAllChildren(PropArray,ValuesArray,1);
        arrCodeEditor = (new VBArray(arrCodeEditor)).toArray();
        if(arrCodeEditor.length >0){
            arrCodeEditor.unshift(objCodeEditor);//add the item into array's first position
        }
        else{
            var objCodeEditor = objMDI.frmUnifiedEditor;
            arrCodeEditor = new Array(objCodeEditor);
        }
        if(arrCodeEditor[0].Exists){
            arrCodeEditor[0].Activate();//active the namemapping Code Editor
        }
        return arrCodeEditor;
    }
    catch (e)
    {
        Log.Error(e.message);
    }
    
}

//-------------------------------------------------------------------------------------
//Function Name : setCodeEditorLayout
//Author        : Alan.Yang
//Create Date   : May 25, 2015
//Last Modify   : 
//Description   : set all of Code Editors layout.
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setCodeEditorLayout(){
    var objMDI = Aliases.Sqlnavigator.frmMain.MiddleZone;
    var arrCodeEditor = getCodeEditorFrames();
    for(i=0; i<arrCodeEditor.length; i++){
        if(arrCodeEditor[i].Exists){
            arrCodeEditor[i].Maximize();
            arrCodeEditor[i].Position(objMDI.Left-1,objMDI.Top-100,objMDI.Width-10,objMDI.Height-20);
            //arrCodeEditor[i].Position(arrCodeEditor[i].Left+10,arrCodeEditor[i].Top+30,arrCodeEditor[i].Width-20,arrCodeEditor[i].Height-40);
        }
        else{
            Log.Error("Code Editor is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
}

//-------------------------------------------------------------------------------------
//Function Name : getCurrentTab
//Author        : Alan.Yang
//Create Date   : May 29, 2015
//Last Modify   : 
//Description   : get the current tab in Code Editor.
//Parameter     : null
//Return        : Object
//-------------------------------------------------------------------------------------
function getCurrentTab(){
    var objPane = getCodeEditorFrames()[0].pnlEditor.TAdvPane;
    var PropArray = new Array("Name");
    var ValuesArray = new Array("Window(\"TSyntaxMemo\", *)");
    if(objPane.Exists) var arrTabs = objPane.FindAllChildren(PropArray,ValuesArray,1);
    if(arrTabs != null){
        arrTabs = (new VBArray(arrTabs)).toArray();
        for(i=0; i<arrTabs.length; i++){
            if(arrTabs[i].Exists && arrTabs[i].Visible){
                return arrTabs[i];
            }
        }
    }
    else{
        return null;
    }  
}

//-------------------------------------------------------------------------------------
//Function Name : closeCodeEditor
//Author        : Alan.Yang
//Create Date   : May 20, 2015
//Last Modify   : 
//Description   : close Code Editor
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function closeCodeEditor(){
    var objCodeEditor = getCodeEditorFrames()[0];
    if(objCodeEditor.Exists){
        objCodeEditor.Close();
        var objSaveCloseConfirm = Aliases.Sqlnavigator.frmSaveCloseConfirm;
        if(objSaveCloseConfirm.Exists){
            var btnClearAll = objSaveCloseConfirm.btnClearAll;
            var btnOK = objSaveCloseConfirm.btnOK;
            btnClearAll.Click();
            Log.Message("Clear all selected files.");
            btnOK.Click();
        }
        
        if(objSaveCloseConfirm.Exists){
            closeCodeEditor();
        }
        else{
            Log.Message("Code Editor have been closed.");
        }
        
    }
}

//-------------------------------------------------------------------------------------
//Function Name : closeCurrentTab
//Author        : Alan.Yang
//Create Date   : July 1, 2015
//Last Modify   : 
//Description   : close the current tab in Code Editor
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function closeCurrentTab(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    var btnCloseTab = frmMain.MiddleZone.frmUnifiedEditor.pnlTabBar.btnCloseTab;
    if(btnCloseTab.Exists && btnCloseTab.Enabled){
        btnCloseTab.Click();
        Log.Message("Close the current active tab in Code Editor.");
        var dlgConfirm = Aliases.Sqlnavigator.dlgConfirm;
        if(dlgConfirm.Exists)  dlgConfirm.btnNo.Click();
    }else{
        closeCodeEditor();
        frmMain.Keys("^m");
    }
}

//-------------------------------------------------------------------------------------
//Function Name : closeTabsKeepOne
//Author        : Alan.Yang
//Create Date   : August 5, 2015
//Last Modify   : 
//Description   : close the current tabs in Code Editor just keep one tab
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function closeTabsKeepOne(){
    var btnCloseTab = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlTabBar.btnCloseTab;
    if(btnCloseTab.Exists){
        var count = 1;
        var dlgConfirm = Aliases.Sqlnavigator.dlgConfirm;
        while(btnCloseTab.Enabled){
            if(btnCloseTab.Enabled){
                btnCloseTab.Click();
            }else{
                break;
            }
            if(dlgConfirm.Exists)  dlgConfirm.btnNo.Click();
            if(count>100) break;//avoid endless looping 
            count ++;
            Sys.Refresh();
        }
        Log.Message("Close tabs in Code Editor just keep only one."); 
    }
}

//-------------------------------------------------------------------------------------
//Function Name : clearTabContent
//Author        : Alan.Yang
//Create Date   : August 3, 2015
//Last Modify   : 
//Description   : clear the content of current tab in Code Editor
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function clearTabContent(){
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor != null){
        var count = 1;
        while(sCopyObjText(edtCodeEditor)!=""){
            edtCodeEditor.Click(0,0);
            Delay(500);
            edtCodeEditor.Keys("^a");
            Delay(500);
            edtCodeEditor.Keys("[Del]");
            Delay(500);
            if(count >10) break;
            count ++;
        }
        if(sCopyObjText(edtCodeEditor)==""){
            Log.Message("Clear all contents in current Code Editor tab.");
            return true;
        }else{
            Log.Error("Fail to clear all contents in current Code Editor tab.");
            return false;
        }
    }else{
        return true;
    }
}

//-------------------------------------------------------------------------------------
//Function Name : getCodeEditorErrorView
//Author        : Alan.Yang
//Create Date   : July 3, 2015
//Last Modify   : 
//Description   : get the object of error view in Code Editor
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function getCodeEditorErrorView(){
    var vstErrors = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlEditor.TAdvPane.pnlErrors.vstErrors;
    var counter = 1;
    while(!vstErrors.Exists){
        Delay(1000);
        vstErrors.RefreshMappingInfo();
        if(counter > 10) break;
        counter++;
    }
    if(vstErrors.Exists){
        return vstErrors;
    }
    else{
        return null;
    }
}

//-------------------------------------------------------------------------------------
//Function Name : getCodeEditorDataGrid
//Author        : Alan.Yang
//Create Date   : July 3, 2015
//Last Modify   : 
//Description   : get the object of data grid in Code Editor
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function getCodeEditorDataGrid(){
    var objDataGrid = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlEditor.frmBrowseData.DataGrid;
    var counter = 1;
    while(!objDataGrid.Exists || !objDataGrid.Visible){
        Delay(1000);
        if(counter > 10) break;
        objDataGrid.RefreshMappingInfo();
        counter ++;
    }
    if(objDataGrid.Exists && objDataGrid.Visible){
        return objDataGrid;    
    }else{
        return null;
    }
}

//-------------------------------------------------------------------------------------
//Function Name : showCodeEditorToolbar
//Author        : Alan.Yang
//Create Date   : July 15, 2015
//Last Modify   : 
//Description   : select the specified name of toolbar
//Parameter     : [IN]strToolbarName -- the specified toolbar
//Return        : null
//-------------------------------------------------------------------------------------
function showCodeEditorToolbar(strToolbarName){
    var objCEToolbarControl = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.CEToolbarControl;
    if(objCEToolbarControl.Exists && objCEToolbarControl.Visible){
        var intChild = objCEToolbarControl.ChildCount;
        objCEToolbarControl.ClickR();
        objCEToolbarControl.Keys("c");
        var dlgToolBarCustomize = Aliases.Sqlnavigator.dlgToolBarCustomize;
        if(dlgToolBarCustomize.Exists){
            Log.Message("Toolbar Customize dialog has been displayed.");
            var tabsControl = dlgToolBarCustomize.PageControl;
            tabsControl.ClickTab(" Toolbars ");
            var toolBarList = tabsControl.ToolBarList;
            if(toolBarList.Exists){
                for(i=1; i<toolBarList.wItemCount; i++){
                    toolBarList.SelectItem(i);
                    toolBarList.DblClickItem(toolBarList.wItem(i));
                    objCEToolbarControl.Refresh();
                    if(objCEToolbarControl.ChildCount >= intChild){
                        if(toolBarList.wItem(i) != strToolbarName){
                            toolBarList.DblClickItem(toolBarList.wItem(i));
                        }
                    }
                    else{
                        if(toolBarList.wItem(i) == strToolbarName){
                            toolBarList.DblClickItem(toolBarList.wItem(i));
                        }
                    }
                    objCEToolbarControl.Refresh();
                    intChild = objCEToolbarControl.ChildCount;
                }
            }
            else{
                Log.Error("Fail to select the [Toolbars] tab.",null,pmNormal,null,Sys.Desktop);
            } 
            dlgToolBarCustomize.Close();    
        }
        else{
            Log.Error("Toolbar Customize dialog is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Code Editor Toolbar zone is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : inputStrToCodeEdtior
//Author        : Alan.Yang
//Create Date   : July 24, 2015
//Last Modify   : 
//Description   : input string into code editor
//Parameter     : [IN]strContent -- the content of need to input
//Return        : null
//-------------------------------------------------------------------------------------
function inputStrToCodeEdtior(strContent){
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor != null){
        var count = 0;
        while(sCopyObjText(edtCodeEditor)!=""){
            edtCodeEditor.Keys("^a[Del]");
            if(count >2) break;
            count ++;
        }
        Log.Message("clear all contents on Code Editor.");
        edtCodeEditor.Keys(strContent);
        Log.Message("Typing string: ["+ strContent +"] into Code Editor.");
    }
}
function sCopyObjText(edtObj){
    Sys.Clipboard="";
    edtObj.Click(0,0);
    edtObj.Keys("^a^c");//copy to clipboard
    return trim(Sys.Clipboard);
}