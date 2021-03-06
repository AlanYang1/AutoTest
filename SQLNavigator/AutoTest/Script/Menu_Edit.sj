//USEUNIT fCommFun
//USEUNIT vGlobalVariables
//USEUNIT fCheckErrors
//USEUNIT fConfirmations
//USEUNIT fCodeEditor

var objCodeEditor;
//-------------------------------------------------------------------------------------
//Function Name : traverseEditMenu
//Author        : Alan.Yang
//Create Date   : May 25, 2015
//Last Modify   : 
//Description   : Traversing the "Edit" menu
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function traverseEditMenu(){
    var objMainMenuBar = Aliases.Sqlnavigator.frmMain.HeadZone.MainMenuBar;
    objCodeEditor = getCodeEditorFrames()[0];
    if(objMainMenuBar.Exists){ 
        if(objCodeEditor == null){
            objMainMenuBar.Keys("^m");//ctrl + m
            objCodeEditor = getCodeEditorFrames()[0];
        }
        var edtCodeEditor = getCurrentTab();
        if(edtCodeEditor != null){
            Log.Message("Create a new SQL script by shortcuts [Ctrl + m].");
            setUndoAndRedo();
            setCopyAndPaste();
            setIndent(4);
            setComment();
            setCaseTransform();
            setKeywordCase();
            setSelectedTextInNewTab();
            setInsertToCE();
            setGotoLine(1);
            setMathchBracket();
            setBookmark();
            openObjectAtCursor("AUTO_TAB_OPEN");
            descObjectAtCursor("AUTO_TAB_OPEN");
        }
        else{
            Log.Error("Code Editor is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Main menu bar is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    checkDialogError();
    checkOutputError();
}

//-------------------------------------------------------------------------------------
//Function Name : setUndoAndRedo
//Author        : Alan.Yang
//Create Date   : May 25, 2015
//Last Modify   : 
//Description   : checking the function of 'Edit' -->'Undo'/'Redo'
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setUndoAndRedo(){
    var edtCodeEditor = getCurrentTab();
    Sys.Clipboard="";
    edtCodeEditor.Click();
    edtCodeEditor.Keys("^a[Del]");//clear Code Editor
    edtCodeEditor.Keys("Test Undo");
    edtCodeEditor.Keys("~EU");//Edit-->Undo
    Log.Message("Select the MainMenu path: Edit--->Undo");
    var strContents = sCopyObjText(edtCodeEditor);//copy text to clipboard
    if(strContents == ""){
        Log.Message("Success to [undo] the content of Code Editor.");
        edtCodeEditor.Keys("~ED");//Edit-->Redo
        Log.Message("Select the mainmenu path: Edit--->Redo");
        strContents = sCopyObjText(edtCodeEditor);
        if(strContents == "Test Undo"){
            Log.Message("Success to [redo] the lost content to Code Editor.");
        }
        else{
            Log.Error("Fali to [redo] the lost content.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
            Log.Error("Fali to [undo] the content of Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setCopyAndPaste
//Author        : Alan.Yang
//Create Date   : May 25, 2015
//Last Modify   : 
//Description   : checking the function of 'Edit' -->'Cut'/'Copy'/'Paste'/'Select All'
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setCopyAndPaste(){
    var edtCodeEditor = getCurrentTab();
    edtCodeEditor.Click();
    edtCodeEditor.Keys("^a[Del]");//clear text on Code Editor
    edtCodeEditor.Keys("Test Cut...");
    var strContents = sCopyObjText(edtCodeEditor);//copy text to clipboard
    Sys.Clipboard = "";
    edtCodeEditor.Keys("~EC");//Edit--->Cut
    Log.Message("Select the MainMenu path: Edit--->Cut");
    if(Sys.Clipboard == strContents){
        Log.Message("Success to [cut] the text to clipboard.");
    }
    else{
        Log.Error("Fali to [cut] the text to clipboard.",null,pmNormal,null,Sys.Desktop);
    }
    edtCodeEditor.Keys("Test Copy...");
    edtCodeEditor.Keys("~EA");//Edit--->Select All
    Log.Message("Select the MainMenu path: Edit--->Select All");
    Sys.Clipboard = "";
    edtCodeEditor.Keys("~EO");//Edit--->Copy
    Log.Message("Select the MainMenu path: Edit--->Copy");
    if(Sys.Clipboard == "Test Copy..."){
        Log.Message("Success to [copy] the text from Code Editor.");
    }
    else{
        Log.Error("Fali to [copy] the text from Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
    edtCodeEditor.Keys("~EE");//Edit--->Paste
    Log.Message("Select the MainMenu path: Edit--->Paste");
    if(sCopyObjText(edtCodeEditor) == "Test Copy..."){
        Log.Message("Success to [paste] the text to Code Editor.");
    }
    else{
        Log.Error("Fali to [paste] the text to Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setIndent
//Author        : Alan.Yang
//Create Date   : May 27, 2015
//Last Modify   : 
//Description   : checking the function of 'Edit' -->'Indent'/'Unindent'
//Parameter     : [IN]intIndentSize -- the size of indent, you can setting it in perferance
//Return        : null
//-------------------------------------------------------------------------------------
function setIndent(intIndentSize){
    var edtCodeEditor = getCurrentTab();
    edtCodeEditor.Click();
    edtCodeEditor.Keys("^a[Del]");//clear text on Code Editor
    edtCodeEditor.Keys("Test Indent and Unindent");
    edtCodeEditor.Keys("~EI");//Edit--->Indent
    Log.Message("Select the MainMenu path: Edit--->Indent");
    var strContents = sCopyObjText(edtCodeEditor);
    if(strContents.substr(0,intIndentSize).length == intIndentSize){
        Log.Message("Success to [indent] text in Code Editor.");
        edtCodeEditor.Keys("~ET");//Edit--->Unindent
        Log.Message("Select the MainMenu path: Edit--->Unindent");
        if(sCopyObjText(edtCodeEditor) == "Test Indent and Unindent"){
            Log.Message("Success to [unindent] text in Code Editor.");
        }
        else{
            Log.Error("Fali to [unindent] text in Code Editor.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Fali to [indent] text in Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setComment
//Author        : Alan.Yang
//Create Date   : May 27, 2015
//Last Modify   : 
//Description   : checking the function of 'Edit' -->'Comment'/'Uncomment'
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setComment(){
    var edtCodeEditor = getCurrentTab();
    edtCodeEditor.Click();
    edtCodeEditor.Keys("^a[Del]");//clear text on Code Editor
    edtCodeEditor.Keys("select sysdate from dual;^a");
    edtCodeEditor.Keys("~EM");//Edit--->Comment
    Log.Message("Select the MainMenu path: Edit--->Comment");
    edtCodeEditor.Keys("[F8]");
    Log.Message("Using F8 execute a [comment] SQL.");
    if(getCodeEditorDataGrid() == null){//datagrid is not exists or invisible
        Log.Message("Success to [comment] SQL in Code Editor.");
        edtCodeEditor.Keys("^a~EN");//Edit--->Uncomment
        edtCodeEditor.Keys("[F8]");
        if(getCodeEditorDataGrid()!= null){
            Log.Message("Success to [Uncomment] SQL in Code Editor.");
        }
        else{
            Log.Error("Fali to [Uncomment] SQL in Code Editor.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Fali to [comment] SQL in Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setCaseTransform
//Author        : Alan.Yang
//Create Date   : May 27, 2015
//Last Modify   : 
//Description   : checking the function of 'Edit' -->'Upper Case'/'Lower Case'
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setCaseTransform(){
    var edtCodeEditor = getCurrentTab();
    edtCodeEditor.Click();
    edtCodeEditor.Keys("^a[Del]");//clear text on Code Editor
    var strText = "select 'Test Case Transform' from dual;";
    edtCodeEditor.Keys(strText + "^a");
    edtCodeEditor.Keys("~EP");//Edit--->Upper Case
    Log.Message("Select the MainMenu path: Edit--->Upper Case");
    if(sCopyObjText(edtCodeEditor) == strText.toUpperCase()){
        Log.Message("Success to transform the text into Upper Case.");
        edtCodeEditor.Keys("~EW");//Edit--->Lower Case
        Log.Message("Select the MainMenu path: Edit--->Lower Case");
        if(sCopyObjText(edtCodeEditor) == strText.toLowerCase()){
            Log.Message("Success to transform the text into Lower Case.");
        }
        else{
            Log.Error("Fali to transform the text into Lower Case.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Fali to transform the text into Upper Case.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setKeywordCase
//Author        : Alan.Yang
//Create Date   : May 29, 2015
//Last Modify   : 
//Description   : checking the function of 'Edit' -->'Convert Keywords to Uppercase'/'Convert Keywords to Lowercase'
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setKeywordCase(){
    var edtCodeEditor = getCurrentTab();
    var strKeywordsFile = gStrInstallPath + "\\PLSQL_reswords.txt";
    var arrKeywords = new Array();
    if(aqFile.Exists(strKeywordsFile)){
        Sys.Clipboard = "";
        Sys.Clipboard = aqFile.ReadWholeTextFile(strKeywordsFile,22);
        arrKeywords = aqFile.ReadWholeTextFile(strKeywordsFile,22).split("\n");//separete with LF(\n)
        edtCodeEditor.Click();
        edtCodeEditor.Keys("^a[Del]");
        edtCodeEditor.Keys("^v");//paste the clipboard contents into code editor
        edtCodeEditor.Keys("^a~EV");//Edit--->Convert Keywords to UpperCase
        Log.Message("Select the MainMenu path: Edit--->Convert Keywords to UpperCase");
        var arrUppercases = new Array();
        arrUppercases = sCopyObjText(edtCodeEditor).split("\n");//define the uppercase keywords to array
        compareArrayCase(arrKeywords,arrUppercases,true);
        
        edtCodeEditor.Keys("^a~EY");//Edit--->Convert Keywords to LowerCase
        Log.Message("Select the MainMenu path: Edit--->Convert Keywords to LowerCase");
        var arrLowercases = new Array();
        arrLowercases = sCopyObjText(edtCodeEditor).split("\n");
        compareArrayCase(arrUppercases,arrLowercases,false);
    }
    else{
        Log.Error("Not found keyword file: "+strKeywordsFile,null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setSelectedTextInNewTab
//Author        : Alan.Yang
//Create Date   : May 29, 2015
//Last Modify   : 
//Description   : open selected text in new Code Editor tab
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setSelectedTextInNewTab(){
    var edtCodeEditor = getCurrentTab();
    var objScriptTab = objCodeEditor.pnlTabBar.TabScripts;
    var tabCounts = objScriptTab.TabIndex;
    edtCodeEditor.Click();
    edtCodeEditor.Keys("^a[Del]");//clear text on Code Editor
    var strText = "Test open selected text in new code editor tab";
    edtCodeEditor.Keys(strText + "^a");
    edtCodeEditor.Keys("~E"+getNumString("[Down]",14)+"[Enter]");//Edit--->Open selected text in Code Editor
    Log.Message("Select the MainMenu path: Edit--->Open selected text in Code Editor");
    objScriptTab.RefreshMappingInfo();
    if(objScriptTab.TabIndex == tabCounts+1){
        Log.Message("Create a new tab in Code Editor.");
        edtCodeEditor = getCurrentTab();
        if(sCopyObjText(edtCodeEditor) == strText){
            Log.Message("Success to open selected text in new code editor tab.");
        }
        else{
            Log.Error("Unable to open selected text in new code editor tab.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Unable to create a new tab in Code Editor.",null,pmNormal,null,Sys.Desktop);
    }  
}

//-------------------------------------------------------------------------------------
//Function Name : setInsertToCE
//Author        : Alan.Yang
//Create Date   : May 29, 2015
//Last Modify   : 
//Description   : insert file or some specified string into Code Editor
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setInsertToCE(){ 
    var edtCodeEditor = getCurrentTab();
    edtCodeEditor.Click();
    edtCodeEditor.Keys("^a[Del]");
    edtCodeEditor.Keys("~ESF");//Edit--->Insert--->File  //insert file
    Log.Message("Select the MainMenu path: Edit--->Insert--->File");
    var objOpenFile = Aliases.Sqlnavigator.dlgOpenFile;
    if(objOpenFile.Exists){
        Log.Message("Open File dialog is displayed.");
        var strPath = Project.Path + "AutoFiles\\ErrorType\\ErrorType.txt";
        objOpenFile.Keys(strPath+"[Enter]");
        if(sCopyObjText(edtCodeEditor) == aqFile.ReadWholeTextFile(strPath,22)){
            Log.Message("Success to insert a file into current Code Editor.");
        }
        else{
            Log.Error("Unable to insert file into current Code Editor.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        Log.Error("Open File dialog is not show.",null,pmNormal,null,Sys.Desktop);
    }
    edtCodeEditor.Keys("^a[Del]");
    edtCodeEditor.Keys("~ESD");//Edit--->Insert--->DBMS_OUTPUT  //insert dbms_output
    Log.Message("Select the MainMenu path: Edit--->Insert--->DBMS_OUTPUT.PUT_LINE('')");
    if(sCopyObjText(edtCodeEditor) == "dbms_output.put_line('');"){
        Log.Message("Success to insert DBMS_OUTPUT.PUT_LINE into current Code Editor.");
    }
    else{
        Log.Error("Unable to insert DBMS_OUTPUT.PUT_LINE into current Code Editor.",null,pmNormal,null,Sys.Desktop);
    }
    edtCodeEditor.Keys("~ESC");//Edit--->Insert--->CRUD Matrix  //insert dbms_output
    Log.Message("Select the MainMenu path: Edit--->Insert--->CRUD Matrix");
    var objCrudMatrix = Aliases.Sqlnavigator.VCLObject("frmCrudUnit");
    existAndCloseWin("SQL Statement CRUD Matrix",objCrudMatrix);
}

//-------------------------------------------------------------------------------------
//Function Name : setGotoLine
//Author        : Alan.Yang
//Create Date   : June 1, 2015
//Last Modify   : 
//Description   : go to specified line
//Parameter     : [IN]intLine -- the specified line number 
//Return        : null
//-------------------------------------------------------------------------------------
function setGotoLine(intLine){
    var edtCodeEditor = getCurrentTab();
    edtCodeEditor.Keys("~EG");//Edit--->Go to Line 
    Log.Message("Select the MainMenu path: Edit--->Go to Line");
    var frmGotoLine = Aliases.Sqlnavigator.frmGotoLine;
    if(frmGotoLine.Exists){
        Log.Message("Go to Line window is show.");
        frmGotoLine.Keys(intLine);
        var btnGo = frmGotoLine.btnGo;
        btnGo.Click();
        if(!frmGotoLine.Exists){
            Log.Message("Go to Line window is been Closed.");
        }
        else{
            Log.Error("Go to Line window is still exists.",null,pmNormal,null,Sys.Desktop);
            frmGotoLine.Close();
        }
    }
    else{
        Log.Error("Go to Line window is not show.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setMathchBracket
//Author        : Alan.Yang
//Create Date   : June 1, 2015
//Last Modify   : 
//Description   : jump to mathching Bracket
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setMathchBracket(){
    var edtCodeEditor = getCurrentTab();
    edtCodeEditor.Keys("^a[Del]");
    edtCodeEditor.Keys("((()))");
    edtCodeEditor.Keys("[Home]");
    edtCodeEditor.Keys("~EH");//Edit--->Jump to mathching Bracket
    Log.Message("Select the MainMenu path: Edit--->Jump to mathching Bracket");
    Sys.Clipboard = "";
    edtCodeEditor.Keys("![Home]^c");//select the text bettween begin and current cursor position
    if(Sys.Clipboard == "((())"){
        Log.Message("Success to jump to mathching Bracket.");
    }
    else{
        Log.Error("Unable to jump to mathching Bracket.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : setBookmark
//Author        : Alan.Yang
//Create Date   : June 1, 2015
//Last Modify   : 
//Description   : toggle bookmark, and jump to specified bookmark
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function setBookmark(){  
    var edtCodeEditor = getCurrentTab();
    edtCodeEditor.Keys("^a[Del]");
    edtCodeEditor.Keys("A[Enter]B[Enter]C[Enter]D[Enter]E[Enter]F[Home]");
    for(i=6; i>0; i--){//toggle bookmark
        edtCodeEditor.Keys("~EK"+i);
        Log.Message("Have toggled bookmark [Bookmark" + i +"].");
        edtCodeEditor.Keys("[Up]");
    }
    for(i=1; i<=6; i++){//go to bookmark
        edtCodeEditor.Keys("~ER"+i);
        Log.Message("Go to bookmark [Bookmark" + i +"].");
    }
    edtCodeEditor.Keys("~EL");//Edit--->List Bookmarks
    Log.Message("Select the MainMenu path: Edit--->List Bookmarks");
    var frmBookmarkList = Aliases.Sqlnavigator.frmBookmarkList;
    if(frmBookmarkList.Exists){
        Log.Message("Bookmarks List window is show.");
        var ListTable = frmBookmarkList.TreeList;
        var btnDelete = frmBookmarkList.btnDelete;
        var btnJump = frmBookmarkList.btnJump;
        ListTable.Click(24,24);
        if(btnDelete.Enabled){
            btnDelete.Click();
            Log.Message("Delete a record in Bookmarks List.");
        }
        if(btnJump.Enabled){
            btnJump.Click();
            Log.Message("Jump to bookmark use Bookmarks List.");
        }
        else{
            frmBookmarkList.Close();
        }
    }
    else{
        Log.Error("Bookmarks List window is not show.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : openObjectAtCursor
//Author        : Alan.Yang
//Create Date   : June 1, 2015
//Last Modify   : 
//Description   : open a object at cursor
//Parameter     : [IN]strObjName -- object name
//Return        : null
//-------------------------------------------------------------------------------------
function openObjectAtCursor(strObjName){
    var edtCodeEditor = getCurrentTab();
    edtCodeEditor.Keys("^a[Del]" + strObjName);
    edtCodeEditor.Keys("~EJ");//Edit--->Open Object at Cursor
    Log.Message("Select the MainMenu path: Edit--->Open Object at Cursor");
    var frmTableEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmTableEditor;
    if(bObjExists(frmTableEditor,2)){
        Log.Message("Success to open the object use 'Open Object at Cursor'.");
        frmTableEditor.Close();
    }
    else{
        Log.Error("Unable to open the object use 'Open Object at Cursor'.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : openObjectAtCursor
//Author        : Alan.Yang
//Create Date   : June 1, 2015
//Last Modify   : 
//Description   : open a object's describe window at cursor
//Parameter     : [IN]strObjName -- object name
//Return        : null
//-------------------------------------------------------------------------------------
function descObjectAtCursor(strObjName){
    var edtCodeEditor = getCurrentTab();
    edtCodeEditor.Keys("^a[Del]" + strObjName);
    edtCodeEditor.Keys("~EB");//Edit--->Describe Object at Cursor
    Log.Message("Select the MainMenu path: Edit--->Describe Object at Cursor");
    var frmDescribe = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDescribe;
    existAndCloseWin("Describe",frmDescribe);
}