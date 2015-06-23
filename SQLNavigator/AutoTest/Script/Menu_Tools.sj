//USEUNIT fCommFun
//USEUNIT fCheckErrors
//USEUNIT fCodeEditor
//USEUNIT Menu_View

//-------------------------------------------------------------------------------------
//Function Name : traverseToolsMenu
//Author        : Alan.Yang
//Create Date   : June 19, 2015
//Last Modify   : 
//Description   : Traversing the "Tools" menu
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function traverseToolsMenu(){
    var objMainMenuBar = Aliases.Sqlnavigator.frmMain.HeadZone.MainMenuBar;
    if(objMainMenuBar.Exists){
        
        objMainMenuBar.Keys("~TC");//Tools--->Code Analysis
        Log.Message("Select the MainMenu path: Tools--->Code Analysis");
        var frmCodeAnalysis = Aliases.Sqlnavigator.frmMain.MiddleZone.frmCodeAnalysis;
        existAndCloseWin("Code Analysis",frmCodeAnalysis);

        checkViewDifference();
        checkCodeFormat();
        checkSyntax();
        checkProfileCode();
        
        objMainMenuBar.Keys("~TFM");//Tools--->Formatter Tools--->Multi-File Formatting 
        Log.Message("Select the MainMenu path: Tools--->Formatter Tools--->Multi-File Formatting");
        var frmMultiFileFormat = Aliases.Sqlnavigator.frmMultiFileFormat;
        existAndCloseWin("Multi-File Formatting",frmMultiFileFormat);
        
        objMainMenuBar.Keys("~TFO");//Tools--->Formatter Tools--->Formatting Options
        Log.Message("Select the MainMenu path: Tools--->Formatter Tools--->Formatting Options");
        var frmFmtOptions = Aliases.Sqlnavigator.frmFmtOptions;
        existAndCloseWin("Formatter Options",frmFmtOptions);
        
        checkWrapCode();
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",5)+"[Enter]");//Tools--->Session Browser
        Log.Message("Select the MainMenu path: Tools--->Session Browser");
        var frmSessionBrowser = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSessionBrowser;
        existAndCloseWin("Session Browser",frmSessionBrowser);
        
        objMainMenuBar.Keys("~TK");//Tools--->Search Knowledge Xpert
        Log.Message("Select the MainMenu path: Tools--->Search Knowledge Xpert");
        var wndHome = Aliases.KnowledgeXpert.wndHome;
        existAndCloseWin("Knowledge Xpert",wndHome);
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",7)+"[Enter]");//Tools--->SQL Optimizer
        Log.Message("Select the MainMenu path: Tools--->SQL Optimizer");
        var frmSqlTuning = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSqlTuning;
        var frmSqlOptimizer = Aliases.SqlOptimizer.frmSqlOptimizer;
        if(frmSqlTuning.Exists) frmSqlTuning.Close();
        if(bObjExists(frmSqlOptimizer,2)){
            Log.Message("SQL Optimizer window has displayed.");
            frmSqlOptimizer.Close();
            killProcess("*SQL Optimizer*");
        }
        else{
            Log.Error("SQL Optimizer window is not exists.",null,pmNormal,null,Sys.Desktop);
        }
        
        objMainMenuBar.Keys("~TX");//Tools--->Explain Plan Tool
        Log.Message("Select the MainMenu path: Tools--->Explain Plan Tool");
        var frmExplainPlan = Aliases.Sqlnavigator.frmMain.MiddleZone.frmExplainPlan;
        existAndCloseWin("Explain Plan",frmExplainPlan);
        
        objMainMenuBar.Keys("~TP");//Tools--->PL/SQL Profiler
        Log.Message("Select the MainMenu path: Tools--->PL/SQL Profiler");
        var frmProfiler = Aliases.Sqlnavigator.frmMain.MiddleZone.frmProfiler;
        existAndCloseWin("Profiler",frmProfiler);
        
        objMainMenuBar.Keys("~TQ");//Tools--->SQL Modeler
        Log.Message("Select the MainMenu path: Tools--->SQL Modeler");
        setSqlModeler();
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",11)+"[Enter]");//Tools--->Code Road Map
        Log.Message("Select the MainMenu path: Tools--->Code Road Map");
        setCodeRoadMap();
        
        objMainMenuBar.Keys("~T"+getNumString("[Down]",12)+"[Enter]");//Tools--->ER Diagram
        Log.Message("Select the MainMenu path: Tools--->ER Diagram");
        setERDiagram();
        
        objMainMenuBar.Keys("~TJ");//Tools--->Job Scheduler
        Log.Message("Select the MainMenu path: Tools--->Job Scheduler");
        var frmJobScheduler = Aliases.Sqlnavigator.frmMain.MiddleZone.frmJobScheduler;
        existAndCloseWin("Job Scheduler",frmJobScheduler);
        
        objMainMenuBar.Keys("~TM");//Tools--->Java Manager
        Log.Message("Select the MainMenu path: Tools--->Java Manager");
        var frmJavaManager = Aliases.Sqlnavigator.frmMain.MiddleZone.frmJavaManager;
        existAndCloseWin("Java Manager",frmJavaManager);
        
        
    }
    else{
        Log.Error("Main menu bar is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    checkDialogError();
    checkOutputError();
}

//-------------------------------------------------------------------------------------
//Function Name : checkViewDifference
//Author        : Alan.Yang
//Create Date   : June 19, 2015
//Last Modify   : 
//Description   : Traversing the function of View Differences
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkViewDifference(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    var frmViewDifference = Aliases.Sqlnavigator.frmViewDifference;
    var strSourseFile = Project.Path + "AutoFiles\\ViewDifferences\\SourceScript.sql";
    var arrComparedFiles = new Array(2);
    arrComparedFiles[0] = Project.Path + "AutoFiles\\ViewDifferences\\ComparedScript1.sql";//no difference
    arrComparedFiles[1] = Project.Path + "AutoFiles\\ViewDifferences\\ComparedScript2.sql";//difference
    var edtSourceScript = frmViewDifference.edtScript;
    var edtComparedScript = frmViewDifference.edtComparedScript;
    var cmbObjType = frmViewDifference.cmbObjType;
    var cmbComparedObjType = frmViewDifference.cmbComparedObjType;
    var btnOK = frmViewDifference.btnOK;
    var dlgInformation = Aliases.Sqlnavigator.dlgInformation;
    var frmDifferenceViewer = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDifferenceViewer;
    //compare file
    for(i=0; i<arrComparedFiles.length; i++){
        frmMain.Keys("~TE");//Tools--->View Differences
        if(frmViewDifference.Exists){
            Log.Message("View Difference window has displayed.");
            edtSourceScript.Keys(strSourseFile);
            edtComparedScript.Keys(arrComparedFiles[i]);
            btnOK.Click();
            if(frmDifferenceViewer.Exists){
                if(dlgInformation.Exists) dlgInformation.Close();
                var pnlResult = frmDifferenceViewer.pnlResult;
                if(i==0 & trim(pnlResult.Caption) == "Files match"){
                    Log.Message("The First files's comparison result is: "+pnlResult.Caption);
                }
                else if(i==1 & trim(pnlResult.Caption).indexOf("different")!=-1){
                    Log.Message("The Second files's comparison result is: "+pnlResult.Caption);
                }
                else{
                    Log.Error("Files mismatch,the result is: "+pnlResult.Caption,null,pmNormal,null,Sys.Desktop);
                }
                frmDifferenceViewer.Close();
            }
            else{
                Log.Error("Difference Viewer window is not exists.",null,pmNormal,null,Sys.Desktop);
            }
        }
        else{
            Log.Error("View Difference window is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    //compare objects
    if(!frmViewDifference.Exists) frmMain.Keys("~TE");
    var TypeCount = cmbObjType.wItemCount;
    for(i=0; i<TypeCount; i++){
        cmbObjType.ClickItem(i);
        cmbComparedObjType.ClickItem(i);
    }
    frmViewDifference.Close();
}

//-------------------------------------------------------------------------------------
//Function Name : checkCodeFormat
//Author        : Alan.Yang
//Create Date   : June 23, 2015
//Last Modify   : 
//Description   : format code
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkCodeFormat(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    frmMain.Keys("^o");//open file
    var strFile = Project.Path + "AutoFiles\\CodeEditor\\FormatCode.sql";
    var dlgOpenFile = Aliases.Sqlnavigator.dlgOpenFile;
    if(dlgOpenFile.Exists){
        dlgOpenFile.Keys(strFile+"[Enter]");
        var edtCodeEditor = getCurrentTab();
        if(edtCodeEditor != null){
            var objCurrentOutput = frmMain.BottomZone.pnlOutput.pcOutput.tabCurrent.t_currentOutput;
            objCurrentOutput.Keys("^a^[Del]");//clear output
            frmMain.Keys("~TFF");//Tools--->Formatter Tools--->Format Code
            Log.Message("Select the MainMenu path: Tools--->Formatter Tools--->Format Code");
            Delay(1000);
            checkOutputByGivenString("Format complete");
            checkOutputError();
            closeCodeEditor();
        }
    }
    else{
        Log.Error("Open file dialog is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : checkSyntax
//Author        : Alan.Yang
//Create Date   : June 23, 2015
//Last Modify   : 
//Description   : check syntax
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkSyntax(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    if(getCurrentTab() == null) frmMain.Keys("^m");
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor!= null){
        edtCodeEditor.Keys("^a[Del]");
        edtCodeEditor.Keys("Select sysdate as Date from dual where 1 = (select cast('1') from dual) order by 1 desc;");
        var objCurrentOutput = frmMain.BottomZone.pnlOutput.pcOutput.tabCurrent.t_currentOutput;
        objCurrentOutput.Keys("^a^[Del]");//clear output
        frmMain.Keys("~TFY");//Tools--->Formatter Tools--->Check Syntax
        Log.Message("Select the MainMenu path: Tools--->Formatter Tools--->Check Syntax");
        checkOutputByGivenString("Syntax Check complete - no errors found.");
        checkOutputError();
    }
}

//-------------------------------------------------------------------------------------
//Function Name : checkProfileCode
//Author        : Alan.Yang
//Create Date   : June 23, 2015
//Last Modify   : 
//Description   : check Code Profile
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkProfileCode(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    if(getCurrentTab() == null) frmMain.Keys("^m");
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor!= null){
        frmMain.Keys("~TFC");//Tools--->Formatter Tools--->Profile Code
        Log.Message("Select the MainMenu path: Tools--->Formatter Tools--->Profile Code");
        var frmProfileCode = Aliases.Sqlnavigator.frmProfileCode;
        existAndCloseWin("Profile Code",frmProfileCode);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : checkWrapCode
//Author        : Alan.Yang
//Create Date   : June 23, 2015
//Last Modify   : 
//Description   : check Wrap Code
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkWrapCode(){
    var frmMain = Aliases.Sqlnavigator.frmMain;
    frmMain.Keys("~TA");//Tools--->Wrap Code
    Log.Message("Select the MainMenu path: Tools--->Wrap Code");
    var frmWrapCode = frmMain.MiddleZone.frmWrapCode;
    if(frmWrapCode.Exists){
        var btnFileSelect = frmWrapCode.btnFileSelect;
        btnFileSelect.Click();
        var dlgOpenFile = Aliases.Sqlnavigator.dlgOpenFile;
        if(dlgOpenFile.Exists){
            var strFile = Project.Path + "AutoFiles\\CodeEditor\\WrapCode.sql";
            dlgOpenFile.Keys(strFile+"[Enter]");
            var btnWrapCode = frmWrapCode.btnWrapCode;
            btnWrapCode.Click();
            if(aqFile.Exists(strFile.split(".")[0]+".plb")){
                Log.Message("Generate a new file: "+ strFile.split(".")[0]+".plb");
            }
            else{
                Log.Error("No file generation,Wrap Code failed.",null,pmNormal,null,Sys.Desktop);
            }
        }
        else{
            Log.Error("Open file dialog is not display.",null,pmNormal,null,Sys.Desktop);
        }
        frmWrapCode.Close();
    }
    else{
        Log.Error("Wrap Code frame is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}


