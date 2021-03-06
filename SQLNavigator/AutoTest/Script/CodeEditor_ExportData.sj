//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT fConfirmations
//USEUNIT fCodeEditor

//-------------------------------------------------------------------------------------
//Function Name : checkExportData
//Author        : Alan.Yang
//Create Date   : July 9, 2015
//Last Modify   : 
//Description   : Checking the function of Export Data in Code Editor's data grid
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkExportData(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    closeCodeEditor();
    frmMain.Keys("^m");
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor != null){
        var strSqlFile = Project.Path + "AutoFiles\\CodeEditor\\ExportDataQuery.sql";
        if(aqFile.Exists(strSqlFile)){
            Sys.Clipboard = aqFile.ReadWholeTextFile(strSqlFile,22);
            edtCodeEditor.Keys("^v");
            Log.Message("Loading the text of file ["+ strSqlFile +"]  on Code Editor.");
            edtCodeEditor.Keys("[F9]");
            Log.Message("Using shortcut keys [F9] to execute the query.");
            setExportData("Table INSERTs");
            var strClipboard = Sys.Clipboard;
            Log.Message("The Clipboard content:" +strClipboard);
            var strSourceTextFile = Project.Path + "AutoFiles\\CodeEditor\\ExportDate_Clipboard.sql";
            var strSourceText = aqFile.ReadWholeTextFile(strSourceTextFile,22);
            Log.Message("The Source Text:" +strSourceText);            
            if(aqString.Compare(strClipboard,strSourceText,true) != 0){
                Log.Message("The clipboard is the same as the Source Text.");
            }
            else{
                Log.Error("The clipboard is the difference as the Source Text.",null,pmNormal,null,Sys.Desktop);
            }
        }
        else{
            Log.Error("Query file["+strSqlFile+"] is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Code Editor is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    checkDialogError();
    checkOutputError();
}

//-------------------------------------------------------------------------------------
//Function Name : setExportData
//Author        : Alan.Yang
//Create Date   : July 9, 2015
//Last Modify   : 
//Description   : select the format type and export data
//Parameter     : [IN]strFormatType -- format type
//Return        : null
//-------------------------------------------------------------------------------------
function setExportData(strFormatType){
    var objDataGrid = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlEditor.frmBrowseData.DataGrid;
    if(bObjExists(objDataGrid,1)){
        objDataGrid.Keys("^e");
        var dlgExportData = Aliases.Sqlnavigator.dlgExportData;
        if(bObjExists(dlgExportData,1)){
            var cmbFormat = dlgExportData.cmbFormat;
            var rbToClipboard = dlgExportData.rbToClipboard;
            var btnOk = dlgExportData.btnOK;
            cmbFormat.ClickItem(strFormatType);
            if(trim(cmbFormat.wText) == strFormatType){
                Log.Message("Have Selected Format item: " + strFormatType);
                if(!rbToClipboard.Checked) rbToClipboard.Click();
                Sys.Clipboard = "";
                btnOk.Click();
            }
            else{
                Log.Error("Unable to select format item: "+strFormatType,null,pmNormal,null,Sys.Desktop);
            }       
        }
        else{
            Log.Error("Export Data dialog is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Fail to use [F9] executed scripts.",null,pmNormal,null,Sys.Desktop);
    }
}