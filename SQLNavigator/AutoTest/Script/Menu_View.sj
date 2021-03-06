//USEUNIT fCommFun
//USEUNIT vGlobalVariables
//USEUNIT fCheckErrors
//USEUNIT fConfirmations
//USEUNIT fCodeEditor

//-------------------------------------------------------------------------------------
//Function Name : traverseViewMenu
//Author        : Alan.Yang
//Create Date   : June 4, 2015
//Last Modify   : 
//Description   : Traversing the "View" menu
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function traverseViewMenu(){
    var objMainMenuBar = Aliases.Sqlnavigator.frmMain.HeadZone.MainMenuBar;
    if(objMainMenuBar.Exists){
        execShortcuts(objMainMenuBar,"~VB");//View--->DB Navigator
        Log.Message("Select the MainMenu path: View--->DB Navigator");
        checkDBNavigator();
        
        closeCodeEditor();//close all CE tab
        objMainMenuBar.Keys("~V[Down][Enter]");//View--->Code Editor
        Log.Message("Select the MainMenu path: View--->Code Editor");
        var edtCodeEditor = getCurrentTab();
        if(edtCodeEditor.Exists){
            Log.Message("A new Code Editor tab has displayed. ");
        }
        else{
            Log.Error("Fail to show a new Code Editor tab.",null,pmNormal,null,Sys.Desktop);
        }
        
        checkVOE(objMainMenuBar);
        
        var frmWorkspace = Aliases.Sqlnavigator.frmMain.RightZone.RightTabContainer.frmWorkspace;
        checkObjShowOrHide(frmWorkspace,"Project Manager Window","~VP[Enter]");
        
        objMainMenuBar.Keys("~VT");//View--->Task Manager
        Log.Message("Select the MainMenu path: View--->Task Manager");
        var frmTaskManager = Aliases.Sqlnavigator.frmTaskManager;
        existAndCloseWin("Task Manager",frmTaskManager);
        
        var pnlOutput = Aliases.Sqlnavigator.frmMain.BottomZone.pnlOutput;
        checkObjShowOrHide(pnlOutput,"Output Window","~VO");
        
        objMainMenuBar.Keys("~VC");//View--->Code Assistant
        Log.Message("Select the MainMenu path: View--->Code Assistant");
        var frmCodeAssistant = Aliases.Sqlnavigator.frmCodeAssistant;
        existAndCloseWin("Code Assistant",frmCodeAssistant);
        
        var dpCodeTemplates = Aliases.Sqlnavigator.frmMain.RightZone.RightTabContainer.dpCodeTemplates;
        checkObjShowOrHide(dpCodeTemplates,"Code Templates","~V"+getNumString("[Down]",7)+"[Enter]");
        
        objMainMenuBar.Keys("~VD");//View--->Describe
        Log.Message("Select the MainMenu path: View--->Auto Describe Tool");
        var frmDescribe = Aliases.Sqlnavigator.frmDescribe;
        existAndCloseWin("Describe",frmDescribe);
        
        objMainMenuBar.Keys("~VU");//View--->Source Preview
        Log.Message("Select the MainMenu path: View--->Source Preview");
        var frmSourcePreview = Aliases.Sqlnavigator.frmSourcePreview;
        existAndCloseWin("Source Preview",frmSourcePreview);
        
        objMainMenuBar.Keys("~VPP[Enter]");//View--->Preferences
        Log.Message("Select the MainMenu path: View--->Preferences");
        var frmPreferences = Aliases.Sqlnavigator.frmPreferences;
        existAndCloseWin("Preferences",frmPreferences);
    }
    else{
        Log.Error("Main menu bar is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    checkDialogError();
    checkOutputError();
}

//-------------------------------------------------------------------------------------
//Function Name : checkVOE
//Author        : Alan.Yang
//Create Date   : June 16, 2015
//Last Modify   : 
//Description   : Traversing View ---> Visual Object Editor
//Parameter     : [IN]objMainMenuBar -- the Main Menu bar
//Return        : null
//-------------------------------------------------------------------------------------
function checkVOE(objMainMenuBar){
    objMainMenuBar.Keys("~VV[Enter]");//View--->VOE--->Cluster Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Cluster Editor");
    var frmClusterEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmClusterEditor;
    existAndCloseWin("Cluster Editor",frmClusterEditor);
    
    objMainMenuBar.Keys("~VVC");//View--->VOE--->Constraint Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Constraint Editor");
    var frmConstraintEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmConstraintEditor;
    existAndCloseWin("Constraint Editor",frmConstraintEditor);
    
    objMainMenuBar.Keys("~VVD");//View--->VOE--->Database Link Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Database Link Editor");
    var frmDBLinkEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBLinkEditor;
    existAndCloseWin("Database Link Editor",frmDBLinkEditor);
    
    objMainMenuBar.Keys("~VVI");//View--->VOE--->Index Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Index Editor");
    var frmIndexEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmIndexEditor;
    existAndCloseWin("Index Editor",frmIndexEditor);
    
    objMainMenuBar.Keys("~VV"+getNumString("[Down]",4)+"[Enter]");//View--->VOE--->Nested Table Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Nested Table Editor");
    var frmNestedTableEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmNestedTableEditor;
    existAndCloseWin("Nested Table Editor",frmNestedTableEditor);
    
    objMainMenuBar.Keys("~VVP");//View--->VOE--->Profile Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Profile Editor");
    var frmProfileEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmProfileEditor;
    existAndCloseWin("Profile Editor",frmProfileEditor);
    
    objMainMenuBar.Keys("~VV"+getNumString("[Down]",6)+"[Enter]");//View--->VOE--->Redo Log Group Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Redo Log Group Editor");
    var frmRedoLogEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmRedoLogEditor;
    existAndCloseWin("Redo Log Group Editor",frmRedoLogEditor);
    
    objMainMenuBar.Keys("~VVR");//View--->VOE--->Role Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Role Editor");
    var frmRoleEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmRoleEditor;
    existAndCloseWin("Role Editor",frmRoleEditor);
    
    objMainMenuBar.Keys("~VV"+getNumString("[Down]",8)+"[Enter]");//View--->VOE--->Materialized View Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Materialized View Editor");
    var frmMaterialViewEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmMaterialViewsEditor;
    existAndCloseWin("Materialized View Editor",frmMaterialViewEditor);
    
    objMainMenuBar.Keys("~VVS");//View--->VOE--->Sequence Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Sequence Editor");
    var frmSequenceEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSequenceEditor;
    existAndCloseWin("Sequence Editor",frmSequenceEditor);
    
    objMainMenuBar.Keys("~VVY");//View--->VOE--->Synonym Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Synonym Editor");
    var frmSynonymEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSynonymEditor;
    existAndCloseWin("Synonym Editor",frmSynonymEditor);
    
    objMainMenuBar.Keys("~VV"+getNumString("[Down]",11)+"[Enter]");//View--->VOE--->Table Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Table Editor");
    var frmTableEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmTableEditor;
    existAndCloseWin("Table Editor",frmTableEditor);
    
    objMainMenuBar.Keys("~VVU");//View--->VOE--->User Editor
    Log.Message("Select the MainMenu path: View--->VOE--->User Editor");
    var frmUserEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUserEditor;
    existAndCloseWin("User Editor",frmUserEditor);
    
    objMainMenuBar.Keys("~VV"+getNumString("[Down]",13)+"[Enter]");//View--->VOE--->Varray Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Varray Editor");
    var frmVarrayEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmVarrayEditor;
    existAndCloseWin("Varray Editor",frmVarrayEditor);
    
    objMainMenuBar.Keys("~VVV");//View--->VOE--->View Editor
    Log.Message("Select the MainMenu path: View--->VOE--->View Editor");
    var frmViewEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmViewEditor;
    existAndCloseWin("View Editor",frmViewEditor);
    
    objMainMenuBar.Keys("~VV"+getNumString("[Down]",15)+"[Enter]");//View--->VOE--->Java Source Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Java Editor");
    var frmJavaEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmJavaEditor;
    existAndCloseWin("Java Source Editor",frmJavaEditor);
    
    objMainMenuBar.Keys("~VV"+getNumString("[Down]",16)+"[Enter]");//View--->VOE--->Instance Property Editor
    Log.Message("Select the MainMenu path: View--->VOE--->Instance Property Editor");
    var frmInstance = Aliases.Sqlnavigator.frmMain.MiddleZone.frmInstance;
    existAndCloseWin("Instance Property Editor",frmInstance);
}

//-------------------------------------------------------------------------------------
//Function Name : checkDBNavigator
//Author        : Alan.Yang
//Create Date   : June 4, 2015
//Last Modify   : 
//Description   : Traversing DB Navigator
//Parameter     : null
//Return        : null
//-------------------------------------------------------------------------------------
function checkDBNavigator(){
    var frmDBNavigator = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBNavigator;
    if(frmDBNavigator.Exists){
        Log.Message("DB Navigator Frame has displayed.");
        var objDBNavTree = frmDBNavigator.pnlLeft.DBTree;
        if(objDBNavTree.Exists){
            Log.Message("DB Navigator Tree has displayed.");
            checkNodePopupMenu(objDBNavTree,"Root");//Root Node
            var intNodeCount = objDBNavTree.wItemCount;
            var arrItems = new Array(intNodeCount);
            for(i=0; i<=intNodeCount-1; i++){
                arrItems[i]= objDBNavTree.wItem(i);
            }
            var i = 0;
            while(i<arrItems.length){
                Log.Message("Start to check node: "+arrItems[i]);
                checkNodePopupMenu(objDBNavTree,arrItems[i]);
                i++;
            }
        }
        else{
            Log.Error("DB Navigator Tree is not exists.",null,pmNormal,null,Sys.Desktop);
        }
        frmDBNavigator.Close();
    }
    else{
        Log.Error("DB Navigator frame is not exists.",null,pmNormal,null,Sys.Desktop);
    }
}

//-------------------------------------------------------------------------------------
//Function Name : checkNodePopupMenu
//Author        : Alan.Yang
//Create Date   : June 5, 2015
//Last Modify   : 
//Description   : checking the selected node's popup menu
//Parameter     : [IN]objTree -- the object Tree
//Parameter     : [IN]strType -- object type name
//Return        : null
//-------------------------------------------------------------------------------------
function checkNodePopupMenu(objTree,strType){
    if(strType.indexOf("[")!=-1) strType = strType.split("[")[0];//just retain the node name
    switch (trim(strType))
    {
      case "Root" :
        PopupMenu_Root(objTree);
        break; 
      case "Session Privileges" :
        PopupMenu_Session(objTree);
        break;
      case "Enabled Roles" :
        PopupMenu_EnabledRoles(objTree);
        break;
      case "Resource Limits" :
        PopupMenu_Resource(objTree);
        break;
      case "Tablespace Quotas" :
        PopupMenu_TabQuotas(objTree);
        break;
      case "Free Space" :
        PopupMenu_FreeSpace(objTree);
        break;
      case "My Schema" :
        var objNode = gotoGivenNode(objTree,5,true);//it should be expand, otherwise get the objTree.wItem(i) very slowly
        objTree.Refresh();
        var intItemCount = objTree.wItemCount;
        var arrItems = new Array(intItemCount);
        for(i=0; i<=intItemCount-1; i++){
            arrItems[i] = objTree.wItem(i);
        }
        objNode.DblClick();//collapse the node
        for(i=0; i<arrItems.length; i++){
            Log.Message("Strat to check node: My Schema--->"+ arrItems[i]);
            PopupMenu_MySchema(objTree,arrItems[i]);
        }
        break;
      case "All Schemas" :
        PopupMenu_AllSchemas(objTree);
        break;
      case "Users" :
        PopupMenu_Users(objTree);
        break;
      case "Roles" :
        PopupMenu_Roles(objTree);
        break;
      case "Profiles" :
        PopupMenu_Profiles(objTree);
        break;
      case "Tablespaces" :
        PopupMenu_Tablespaces(objTree);
        break;
      case "Datafiles" :
        PopupMenu_Datafiles(objTree);
        break;
      case "Rollback Segments" :
        PopupMenu_Rollback(objTree);
        break;
      case "Redo Log Groups" :
        PopupMenu_RedoLog(objTree);
        break;
      case "Current Instance" :
        PopupMenu_CurrInstance(objTree);
        break;
      case "Recycle Bin" :
        PopupMenu_RecycleBin(objTree);
        break;
      default:
        break;
    }
}

//Root Node
function PopupMenu_Root(objTree){
    var objRootNode = objTree.wItems.Item(0);
    RightClickOpenObj(objTree,objRootNode,2,"setDescribe();");
    RightClickOpenObj(objTree,objRootNode,3,"setCodeRoadMap();");
    RightClickOpenObj(objTree,objRootNode,4,"setERDiagram();");
    RightClickOpenObj(objTree,objRootNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objRootNode);
    setShowOrHideDetails(objTree,objRootNode);
}

//Session Privileges
function PopupMenu_Session(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"1-1");//Session Privileges--->first node
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    collapseAllNode(objTree);
}

//Enabled Roles
function PopupMenu_EnabledRoles(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"2-1");//Enabled Roles--->first node
    RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Role\");");
    RightClickOpenObj(objTree,objCurrentNode,"o","setOpen(\"Role\");");
    RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
    RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");
    RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
    RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant role
    RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke role
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Resource Limits
function PopupMenu_Resource(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"3-1");//Resource Limits--->first node
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Tablespace Quotas
function PopupMenu_TabQuotas(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"4-1");//Tablespace Quotas--->first node
    RightClickOpenObj(objTree,objCurrentNode,2,"setDescribe();");
    RightClickOpenObj(objTree,objCurrentNode,3,"setCodeRoadMap();");
    RightClickOpenObj(objTree,objCurrentNode,4,"setERDiagram();");
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode); 
    collapseAllNode(objTree);
}

//Free Space
function PopupMenu_FreeSpace(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"5-1");//Free Space--->first node
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//My Schema
function PopupMenu_MySchema(objTree,strType){
    if(strType.indexOf("[")!=-1) strType = strType.split("[")[0];//just retain the node name
    var objCurrentNode;
    Log.Message("check node------->"+strType);
    objTree.Keys("[Home]");
    objTree.Refresh();
    objTree.Keys("[F5]");//refresh
    var strSourceName = strType;
    if(strType == "Procedures"|| strType == "Functions"|| strType == "Packages") strType = "Stored Objects";
    switch (trim(strType))
    {
      case "Tables" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-1-1");//My Schame--->Tables--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Table\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Table\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"r[Enter]","setRename();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,6,"setExtractDDL();");//get metadata
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setExportTable();");      
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,"h","setDrop();");//drop with purge
        RightClickOpenObj(objTree,objCurrentNode,11,"setSqlModeler();");
        RightClickOpenObj(objTree,objCurrentNode,"q","setQuickBrowse();");//Quick Browse
        RightClickOpenObj(objTree,objCurrentNode,"e","setQuickBrowse();");//Edit Data
        RightClickOpenObj(objTree,objCurrentNode,"z","setAnalyze();");
        RightClickOpenObj(objTree,objCurrentNode,15,"setERDiagram();");
        RightClickOpenObj(objTree,objCurrentNode,"u","setTruncate(\"Table\");");
        RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant
        RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"y","setRekey();");
        RightClickOpenObj(objTree,objCurrentNode,"ooo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Constraints" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-2-1");//My Schame--->Constraints--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Constraint\");");
        RightClickOpenObj(objTree,objCurrentNode,"o","setOpen(\"Constraint\");");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop(\"Constraint\");");//drop
        RightClickOpenObj(objTree,objCurrentNode,"a","clickConfirmations(false);");//disable
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Views" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-3-1");//My Schame--->Views--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"View\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"View\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"r[Enter]","setRename();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,6,"setExtractDDL();");//get metadata
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,9,"setSqlModeler();");
        RightClickOpenObj(objTree,objCurrentNode,"q","setQuickBrowse();");//Quick Browse
        RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant
        RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,16,"setCodeAnalysis();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Indexes" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-4-1");//My Schame--->Indexes--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Index\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Index\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,5,"setExtractDDL();");//get metadata
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop(\"Index\");");//drop
        RightClickOpenObj(objTree,objCurrentNode,"z","setAnalyze();");
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Triggers" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-5-1");//My Schame--->Triggers--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Trigger\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Trigger\");");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,4,"setExtractDDL();");//get metadata
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,7,"setCodeRoadMap();");
        RightClickOpenObj(objTree,objCurrentNode,"a","clickConfirmations(false);");//disable
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,12,"setCodeAnalysis();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Stored Objects" :
        if(strSourceName == "Procedures"){
            objCurrentNode = gotoAndExpandTree(objTree,"6-6-1");//My Schame--->Procedures--->first node
        }
        else if(strSourceName == "Functions"){
            objCurrentNode = gotoAndExpandTree(objTree,"6-7-1");//My Schame--->Functions--->first node
        }
        else if(strSourceName == "Packages"){
            objCurrentNode = gotoAndExpandTree(objTree,"6-8-1");//My Schame--->Packages--->first node
        }
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,5,"setExtractDDL();");//get metadata  
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,8,"setCodeRoadMap();");
        RightClickOpenObj(objTree,objCurrentNode,"x[Enter]","setExecute();");
        RightClickOpenObj(objTree,objCurrentNode,"tt[Enter]","setCodeTest();");
        RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant
        RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke
        if(getDBVersion() > 11){
            RightClickOpenObj(objTree,objCurrentNode,13,"setCodeRoleGrant();");
            RightClickOpenObj(objTree,objCurrentNode,17,"setCodeAnalysis();");
        }
        else{
            RightClickOpenObj(objTree,objCurrentNode,16,"setCodeAnalysis();");
        }
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"ooo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseGivenNode(objTree,6);
        break;
      case "Package Bodies" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-9-1");//My Schame--->Package Bodies--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,4,"setExtractDDL();");//get metadata  
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,7,"setCodeRoadMap();");
        RightClickOpenObj(objTree,objCurrentNode,"x[Enter]","setExecute();");
        RightClickOpenObj(objTree,objCurrentNode,"tt[Enter]","setCodeTest();");
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,13,"setCodeAnalysis();");
        RightClickOpenObj(objTree,objCurrentNode,"ooo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Sequences" :
        objCurrentNode = gotoAndExpandTree(objTree,isDBExplorer ?"6-10-1":"");
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Sequence\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Sequence\");");
        RightClickOpenObj(objTree,objCurrentNode,"r[Enter]","setRename();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,5,"setExtractDDL();");//get metadata
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant
        RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Clusters" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-11-1");//My Schame--->Clusters--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Cluster\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Cluster\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,"z","setAnalyze();");
        RightClickOpenObj(objTree,objCurrentNode,"u","setTruncate();");//Truncate
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Materialized Views" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-12-1");//My Schame--->Materialized Views--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Materialized View\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Materialized View\");");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,5,"setSqlModeler();");
        RightClickOpenObj(objTree,objCurrentNode,"q","setQuickBrowse();");//Quick Browse
        RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant
        RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Synonyms" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-13-1");//My Schame--->Synonyms--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Synonym\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Synonym\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"r[Enter]","setRename();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,6,"setExtractDDL();");//get metadata  
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Database Links" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-14-1");//My Schame--->Database Links--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Database Link\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Database Link\");");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Object Types" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-15-1");//My Schame--->Object Types--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,5,"setExtractDDL();");//get metadata 
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop 
        RightClickOpenObj(objTree,objCurrentNode,"g","setGrantOrRevoke();");//grant
        RightClickOpenObj(objTree,objCurrentNode,"k","setGrantOrRevoke();");//revoke
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      case "Object Type Bodies" :
        objCurrentNode = gotoAndExpandTree(objTree,"6-16-1");//My Schame--->Object Type Bodies--->first node
        RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"o[Enter]","setOpen(\"Stored Object\");");
        RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
        RightClickOpenObj(objTree,objCurrentNode,4,"setExtractDDL();");//get metadata 
        RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop 
        RightClickOpenObj(objTree,objCurrentNode,"p[Enter]","setProperty();");
        RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
        RightClickOpenObj(objTree,objCurrentNode,"oo[Enter]","setFindObejcts();");
        RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
        setCopyText(objTree,objCurrentNode);
        setShowOrHideDetails(objTree,objCurrentNode);
        collapseAllNode(objTree);
        break;
      default:
        break;
    }
}

//All Schemas
function PopupMenu_AllSchemas(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"7-1");//All Schemas--->first node
    RightClickOpenObj(objTree,objCurrentNode,"i","setDescribe();");
    RightClickOpenObj(objTree,objCurrentNode,3,"setCodeRoadMap();");
    RightClickOpenObj(objTree,objCurrentNode,4,"setERDiagram();");
    RightClickOpenObj(objTree,objCurrentNode,"o","setFindObejcts();");
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode); 
    collapseAllNode(objTree);
}

//Users
function PopupMenu_Users(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"8-1");//Users--->first node
    RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"User\");");
    RightClickOpenObj(objTree,objCurrentNode,"o","setOpen(\"User\");");
    RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
    RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop 
    RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Roles
function PopupMenu_Roles(){
    var objTree = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBNavigator.pnlLeft.DBTree;
    var objCurrentNode = gotoAndExpandTree(objTree,"9-1");//Roles--->first node
    RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Role\");");
    RightClickOpenObj(objTree,objCurrentNode,"o","setOpen(\"Role\");");
    RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
    RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop 
    RightClickOpenObj(objTree,objCurrentNode,"v","setViewDifference();");
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Profiles
function PopupMenu_Profiles(){
    var objTree = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBNavigator.pnlLeft.DBTree;
    var objCurrentNode = gotoAndExpandTree(objTree,"10-1");//Profiles--->first node
    RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Profile\");");
    RightClickOpenObj(objTree,objCurrentNode,"o","setOpen(\"Profile\");");
    RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop 
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Tablespaces
function PopupMenu_Tablespaces(objTree){   
    var objCurrentNode = gotoAndExpandTree(objTree,"11-1");//Tablespaces--->first node
    RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Tablespace\");");
    RightClickOpenObj(objTree,objCurrentNode,"o","setOpen(\"Tablespace\");");
    RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
    RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop 
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Datafiles
function PopupMenu_Datafiles(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"12-1");//Datafiles--->first node
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Rollback Segments
function PopupMenu_Rollback(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"13-1");//Rollback Segments--->first node
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Redo Log Groups
function PopupMenu_RedoLog(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"14-1");//Redo Log Groups--->first node
    RightClickOpenObj(objTree,objCurrentNode,"c","setCreate(\"Redo Log\");");
    RightClickOpenObj(objTree,objCurrentNode,"o","setOpen(\"Redo Log\");");
    RightClickOpenObj(objTree,objCurrentNode,"t[Enter]","setExtractDDL();");
    RightClickOpenObj(objTree,objCurrentNode,"d","setDrop();");//drop 
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Current Instance
function PopupMenu_CurrInstance(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"15-1-1");//Current Instance--->first node
    RightClickOpenObj(objTree,objCurrentNode,"o","setOpen(\"Current Instance\");");
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setCopyText(objTree,objCurrentNode);
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Recycle Bin
function PopupMenu_RecycleBin(objTree){
    var objCurrentNode = gotoAndExpandTree(objTree,"16-1");//Recycle Bin--->first node
    RightClickOpenObj(objTree,objCurrentNode,"p","clickConfirmations(false);");//purge
    RightClickOpenObj(objTree,objCurrentNode,"f","setFlashBack();");
    RightClickOpenObj(objTree,objCurrentNode,"n","setFindRecycleBinObj();");
    setShowOrHideDetails(objTree,objCurrentNode);
    collapseAllNode(objTree);
}

//Describe
function setDescribe(isDBExplorer){
    var isDBExplorer = arguments[0] == undefined ? false:isDBExplorer;
    if(isDBExplorer){
        var objNavBar = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.dpToolbox.NavBar
        var vstDescribe = objNavBar.DescribeControl.vstDetails;
        if(vstDescribe.Exists && vstDescribe.Visible){
            Log.Message("Descibe window has displayed in DB Explorer Bar.");
            var frmDbExplorer = objNavBar.frmDbExplorer;
            while(!frmDbExplorer.Exists || !frmDbExplorer.Visible){
                objNavBar.Keys("~^p");//Alt+Ctrl+P, switch toolbars
            }
        }
        else{
            Log.Error("Descibe window is not show.",null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        var frmDescribe = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDescribe;
        existAndCloseWin("Describe",frmDescribe);
    }
}
//Code Road Map
function setCodeRoadMap(){
    var frmCodeRoadMap = Aliases.Sqlnavigator.frmMain.MiddleZone.frmCodeRoadMap;
    var frmModelCode = Aliases.Sqlnavigator.frmModelCode;
    if(frmModelCode.Exists) frmModelCode.Close();
    if(!frmModelCode.Exists) existAndCloseWin("Code Road Map",frmCodeRoadMap);
}
//ER Diagram
function setERDiagram(){
    var frmERDiagram = Aliases.Sqlnavigator.frmMain.MiddleZone.frmERDiagram;
    var dlgCreatERDiagram = Aliases.Sqlnavigator.dlgERDiagram;
    if(dlgCreatERDiagram.Exists){
        dlgCreatERDiagram.Close();
    }
    existAndCloseWin("ER Diagram",frmERDiagram);
}
//Find Objects
function setFindObejcts(){
    var frmFindObejcts =Aliases.Sqlnavigator.frmMain.MiddleZone.frmFindObject;
    existAndCloseWin("Find Objects",frmFindObejcts);
}
//Find Recycle Bin Objects
function setFindRecycleBinObj(){
    var frmFindRecycleBinObj = Aliases.Sqlnavigator.frmMain.MiddleZone.frmFindRecycleBinObj;
    existAndCloseWin("Find Recycle Bin Objects",frmFindRecycleBinObj);
}
//Show/Hide Detials Panel
function setShowOrHideDetails(objTree,objNode){
    var objDetailPanel = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBNavigator.pnlDetail;
    objNode.ClickR();
    objTree.Keys("s");//Hide Detials Panel
    if(objDetailPanel.Exists & objDetailPanel.Visible){
        Log.Error("Fail to use popup menu to Hide Details Panel.",null,pmNormal,null,Sys.Desktop);
    }
    else{
        Log.Message("Success to use popup menu to Hide Details Panel.");
        objNode.ClickR();
        objTree.Keys("s");//Show Detials Panel
        if(objDetailPanel.Exists & objDetailPanel.Visible){
            Log.Message("Success to use popup menu to Show Details Panel.");
        }
        else{
            Log.Error("Fail to use popup menu to Show Details Panel.",null,pmNormal,null,Sys.Desktop);
        }
    }
}
//Copy Text
function setCopyText(objTree,objNode,strKeys){
    strKeys = arguments[2] == undefined ? "x":strKeys;//default = "x"
    Sys.Clipboard = "";
    if(objNode != null){
        objNode.ClickR();
        objTree.Keys(strKeys);//Copy Text
        if(objNode.Text.indexOf(Sys.Clipboard) != -1){
            Log.Message("Success to copy the text from node: " + objNode.Text)
        }
        else{
            Log.Error("Fail to copy the text from node: " + objNode.Text,null,pmNormal,null,Sys.Desktop);
        }
    }else{
        Log.Error("Can't find the specified node.");
    }
}
//Create
function setCreate(strType,isDBExplorer){
    isDBExplorer = arguments[1] == undefined ? false:isDBExplorer;
    switch (strType)
    {
      case "Role":
        var dlgNewRole = Aliases.Sqlnavigator.frmNewRole;
        existAndCloseWin("New Role",dlgNewRole);
        if(!dlgNewRole.Exists){
            var frmRoleEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmRoleEditor;
            existAndCloseWin("Role Editor",frmRoleEditor);
        }
        break;
      case "Table":
        var dlgNewTable =  Aliases.Sqlnavigator.frmNewTable;
        existAndCloseWin("New Table",dlgNewTable);
        if(!dlgNewTable.Exists){
            var frmTableEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmTableEditor;
            existAndCloseWin("Table Editor",frmTableEditor);
        }
        break;
      case "Constraint":
        var dlgNewConstraint =  Aliases.Sqlnavigator.frmNewConstraint;
        existAndCloseWin("New Constraint",dlgNewConstraint);
        if(!dlgNewConstraint.Exists){
            var frmConstraintEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmConstraintEditor;
            existAndCloseWin("Constraint Editor",frmConstraintEditor);
        }
        break;
      case "View":
        var dlgNewView =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New View",dlgNewView);
        if(!dlgNewView.Exists){
            var frmViewEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmViewEditor;
            existAndCloseWin("View Editor",frmViewEditor);
        }
        break;
      case "Index":
        var dlgNewIndex =  Aliases.Sqlnavigator.frmNewIndex;
        existAndCloseWin("New Index",dlgNewIndex);
        if(!dlgNewIndex.Exists){
            var frmIndexEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmIndexEditor;
            existAndCloseWin("Index Editor",frmIndexEditor);
        }
        break;
      case "Trigger":
        var dlgNewTrigger =  Aliases.Sqlnavigator.frmNewTrigger;
        existAndCloseWin("New Trigger",dlgNewTrigger);
        if(!dlgNewTrigger.Exists){
            if(isDBExplorer){
                var btnCloseTab = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlTabBar.btnCloseTab;
                if(btnCloseTab.Exists && btnCloseTab.Enabled) btnCloseTab.Click();
            }
            else{
                var frmCodeEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor;
                existAndCloseWin("Code Editor",frmCodeEditor);
            }
        }
        break;
      case "Stored Object"://procedure,function,package,package body,Object Type
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Stored Object",dlgNewObject);
        if(!dlgNewObject.Exists){
            if(isDBExplorer){
                var btnCloseTab = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlTabBar.btnCloseTab;
                if(btnCloseTab.Exists && btnCloseTab.Enabled) btnCloseTab.Click();
            }
            else{
                var frmCodeEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor;
                existAndCloseWin("Code Editor",frmCodeEditor);
            }
        }
        break;
      case "Sequence":
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Sequence",dlgNewObject);
        if(!dlgNewObject.Exists){
            var frmSequenceEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSequenceEditor;
            existAndCloseWin("Sequence Editor",frmSequenceEditor);
        }
        break;
      case "Cluster":
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Cluster",dlgNewObject);
        if(!dlgNewObject.Exists){
            var frmClusterEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmClusterEditor;
            existAndCloseWin("Cluster Editor",frmClusterEditor);
        }
        break;
      case "Varray":
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Varray",dlgNewObject);
        if(!dlgNewObject.Exists){
            var frmVarrayEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmVarrayEditor;
            existAndCloseWin("Varray Editor",frmVarrayEditor);
        }
        break;
      case "Nested Table":
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Nested Table",dlgNewObject);
        if(!dlgNewObject.Exists){
            var frmNestedTableEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmNestedTableEditor;
            existAndCloseWin("Nested Table Editor",frmNestedTableEditor);
        }
        break;
      case "Java Source":
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Java Source",dlgNewObject);
        if(!dlgNewObject.Exists){
            var frmJavaEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmJavaEditor;
            existAndCloseWin("Java Source Editor",frmJavaEditor);
        }
        break;
      case "Materialized View":
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Materialized View",dlgNewObject);
        if(!dlgNewObject.Exists){
            var frmMaterialViewsEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmMaterialViewsEditor;
            existAndCloseWin("Materialized View Editor",frmMaterialViewsEditor);
        }
        break;
      case "Synonym":
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Synonym",dlgNewObject);
        if(!dlgNewObject.Exists){
            var frmSynonymEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSynonymEditor;
            existAndCloseWin("Synonym Editor",frmSynonymEditor);
        }
        break;
      case "Database Link":
        var dlgNewObject =  Aliases.Sqlnavigator.frmNewObject;
        existAndCloseWin("New Database Link",dlgNewObject);
        if(!dlgNewObject.Exists){
            var frmDBLinkEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBLinkEditor;
            existAndCloseWin("Database Link Editor",frmDBLinkEditor);
        }
        break;
      case "User":
        var dlgNewRole = Aliases.Sqlnavigator.frmNewRole;
        existAndCloseWin("New User",dlgNewRole);
        if(!dlgNewRole.Exists){
            var frmUserEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUserEditor;
            existAndCloseWin("User Editor",frmUserEditor);
        }
        break;
      case "Profile":
        var dlgNewRole = Aliases.Sqlnavigator.frmNewRole;
        existAndCloseWin("New Profile",dlgNewRole);
        if(!dlgNewRole.Exists){
            var frmProfileEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmProfileEditor;
            existAndCloseWin("Profile Editor",frmProfileEditor);
        }
        break;
      case "Tablespace":
        var dlgNewRole = Aliases.Sqlnavigator.frmNewRole;
        existAndCloseWin("New Tablespace",dlgNewRole);
        if(!dlgNewRole.Exists){
            var frmTablespaceEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmTablespaceEditor;
            existAndCloseWin("Tablespace Editor",frmTablespaceEditor);
        }
        break;
      case "Redo Log":
        var dlgNewRole = Aliases.Sqlnavigator.frmNewRole;
        existAndCloseWin("New Redo Log",dlgNewRole);
        if(!dlgNewRole.Exists){
            var frmRedoLogEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmRedoLogEditor;
            existAndCloseWin("Redo Log Editor",frmRedoLogEditor);
        }
        break;
      default:
        break;
    }
}
//Open
function setOpen(strType,isDBExplorer){
    isDBExplorer = arguments[1] == undefined ? false:isDBExplorer;
    switch (strType)
    {
      case "Role":
        var frmRoleEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmRoleEditor;
        existAndCloseWin("Role Editor",frmRoleEditor);
        break;
      case "Table":
        var frmTableEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmTableEditor;
        existAndCloseWin("Table Editor",frmTableEditor);
        break;
      case "Constraint":
        var frmConstraintEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmConstraintEditor;
        existAndCloseWin("Constraint Editor",frmConstraintEditor);
        break;
      case "View":
        var frmViewEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmViewEditor;
        existAndCloseWin("View Editor",frmViewEditor);
        break;
      case "Index":
        var frmIndexEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmIndexEditor;
        existAndCloseWin("Index Editor",frmIndexEditor);
        break;
      case "Trigger":
        if(isDBExplorer){
            var btnCloseTab = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlTabBar.btnCloseTab;
            if(btnCloseTab.Exists && btnCloseTab.Enabled) btnCloseTab.Click();
        }
        else{
            var frmCodeEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor;
            existAndCloseWin("Code Editor",frmCodeEditor);
        }
        break;
      case "Stored Object":
        if(isDBExplorer){
            Delay(1000);//if close it too fast, AV error occurred.  --SQLNAV-1944
            var btnCloseTab = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlTabBar.btnCloseTab;
            if(btnCloseTab.Exists && btnCloseTab.Enabled) btnCloseTab.Click();
        }
        else{
            var frmCodeEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor;
            existAndCloseWin("Code Editor",frmCodeEditor);
        }
        break;
      case "Cluster":
        var frmClusterEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmClusterEditor;
        existAndCloseWin("Cluster Editor",frmClusterEditor);
        break;
      case "Sequence":
        var frmSequenceEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSequenceEditor;
        existAndCloseWin("Sequence Editor",frmSequenceEditor);
        break;
      case "Materialized View":
        var frmMaterialViewsEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmMaterialViewsEditor;
        existAndCloseWin("Materialized View Editor",frmMaterialViewsEditor);
        break;
      case "Synonym":
        var frmSynonymEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSynonymEditor;
        existAndCloseWin("Synonym Editor",frmSynonymEditor);
        break;
      case "Database Link":
        var frmDBLinkEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmDBLinkEditor;
        existAndCloseWin("Database Link Editor",frmDBLinkEditor);
        break;
      case "User":
        var frmUserEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUserEditor;
        existAndCloseWin("User Editor",frmUserEditor);
        break;
      case "Profile":
        var frmProfileEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmProfileEditor;
        existAndCloseWin("Profile Editor",frmProfileEditor);
        break;
      case "Tablespace":
        var frmTablespaceEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmTablespaceEditor;
        existAndCloseWin("Tablespace Editor",frmTablespaceEditor);
        break;
      case "Redo Log":
        var frmRedoLogEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmRedoLogEditor;
        existAndCloseWin("Redo Log Editor",frmRedoLogEditor);
        break;
      case "Current Instance":
        var frmInstance = Aliases.Sqlnavigator.frmMain.MiddleZone.frmInstance;
        existAndCloseWin("Instance Property",frmInstance);
        break;
      case "Java Source":
        var frmJavaEditor = Aliases.Sqlnavigator.frmMain.MiddleZone.frmJavaEditor;
        existAndCloseWin("Java Source Editor",frmJavaEditor);
        break;
      default:
        break;
    }
}
//Drop
function setDrop(strType,isDBExplorer){
    strType = arguments[0] == undefined ? "":strType;
    isDBExplorer = arguments[1] == undefined ? false:isDBExplorer;
    if(strType == "Constraint" || strType == "Index"){
        if(getDBVersion(isDBExplorer) > 11){
            var dlgConfirmDrop = Aliases.Sqlnavigator.dlgConfirmDrop;
            existAndCloseWin("Confirm Drop ",dlgConfirmDrop);
        }
        else{
            clickConfirmations(false);
        }
    }
    else{
        clickConfirmations(false);
    }
}
//Extract DDL / Get Metadata
function setExtractDDL(){
    var frmPreference = Aliases.Sqlnavigator.frmPreferences;
    existAndCloseWin("Preferences",frmPreference);
}
//View Differences
function setViewDifference(){
    var frmViewDifference = Aliases.Sqlnavigator.frmViewDifference;
    existAndCloseWin("View Differences",frmViewDifference);
}
//Grant / Revoke
function setGrantOrRevoke(){
    var frmGrantOrRevokeRole = Aliases.Sqlnavigator.frmGrantOrRevokeRole;
    var frmGrantObject = Aliases.Sqlnavigator.frmGrantObject;
    var frmRevokeObject = Aliases.Sqlnavigator.frmRevokeObject;
    if(frmGrantOrRevokeRole.Exists){
        existAndCloseWin("Grant/Revoke Role",frmGrantOrRevokeRole);
    }
    else if(frmGrantObject.Exists){
        existAndCloseWin("Grant Object",frmGrantObject);
    }
    else if(frmRevokeObject.Exists){
        existAndCloseWin("Revoke Object",frmRevokeObject);
    }
}
//Rename
function setRename(){
    var dlgRenameObj = Aliases.Sqlnavigator.dlgRenameObj;
    existAndCloseWin("Rename Object",dlgRenameObj);
}
//Export Table
function setExportTable(){
    var dlgError = Aliases.Sqlnavigator.dlgError_NotFind;
    if(dlgError.Exists){
        Log.Message("A Can Not Find error has displayed.");
        dlgError.Close();
    }
    else{
        var frmExportData = Aliases.Sqlnavigator.frmMain.MiddleZone.frmExportData;
        existAndCloseWin("Export Table",frmExportData);
    }
}
//SQL Modeler
function setSqlModeler(){
    var frmSqlModeler = Aliases.Sqlnavigator.frmMain.MiddleZone.frmSqlModeler;
    if(bObjExists(frmSqlModeler,2)){
        Log.Message("SQL Modeler has displayed.");
        frmSqlModeler.Close();
        clickConfirmations(false);
    }
    else{
        Log.Error("SQL Modeler frame is not show.",null,pmNormal,null,Sys.Desktop);
    }
}
//Quick Browse / Edit Data
function setQuickBrowse(isDBExplorer){
    isDBExplorer = arguments[0] == undefined ? false:isDBExplorer;
    var edtCodeEditor = getCurrentTab();
    if(edtCodeEditor.Exists){
        var objDataGrid = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlEditor.frmBrowseData.DataGrid;
        Log.Message("Code Editor has displayed.");
        if(objDataGrid.Exists){
            Log.Message("Data Grid is exists.");
        }
        else{
            Log.Error("Data Grid is not exists.",null,pmNormal,null,Sys.Desktop);
        }
    }
    if(isDBExplorer){
        var btnCloseTab = Aliases.Sqlnavigator.frmMain.MiddleZone.frmUnifiedEditor.pnlTabBar.btnCloseTab;
        if(btnCloseTab.Exists && btnCloseTab.Enabled) btnCloseTab.Click();
    }
    else{
        closeCodeEditor();
    }
}
//Analyze
function setAnalyze(){
    var frmAnalyze = Aliases.Sqlnavigator.frmMain.MiddleZone.frmAnalyze;
    existAndCloseWin("Analyze",frmAnalyze);
}
//Truncate
function setTruncate(strType,isDBExplorer){
    strType = arguments[0] == undefined ? "":strType;
    isDBExplorer = arguments[1] == undefined ? false:isDBExplorer;
    switch (strType)
    {
      case "Table":
        if(getDBVersion(isDBExplorer) > 11){
            var dlgTruncateTable = Aliases.Sqlnavigator.frmTruncateTable;
            existAndCloseWin("Truncate Table",dlgTruncateTable);
        }
        else{
            clickConfirmations(false);
        }
        break;
      default:
        clickConfirmations(false);
        break;
    }
}
//Property
function setProperty(){
    var dlgProperty = Aliases.Sqlnavigator.frmObjProperty;
    existAndCloseWin("Object Properties",dlgProperty);
}
//Rekey
function setRekey(){
    var dlgRekey = Aliases.Sqlnavigator.frmRekey;
    existAndCloseWin("Rekey Table",dlgRekey);
}
//Send to Code Analyzsis
function setCodeAnalysis(){
    var frmCodeAnalysis = Aliases.Sqlnavigator.frmMain.MiddleZone.frmCodeAnalysis;
    existAndCloseWin("Code Analyzsis",frmCodeAnalysis);
}
//Execute
function setExecute(isDBExplorer){
    var isDBExplorer = arguments[0] == undefined ? false:isDBExplorer;
    var frmCodeEditor = getCodeEditorFrames()[0];
    var btnExecute = frmCodeEditor.pnlEditor.frmRun.btnRun;
    if(btnExecute.Exists){
        Log.Message("Execute button has displayed.");
        btnExecute.Click();
        var count = 1;
        while(!btnExecute.Enable){
            Delay(2000);
            if(count > 10) break;
            count ++;
            btnExecute.Refresh();
        }
    }
    else{
        Log.Error("Execute button is not exists.",null,pmNormal,null,Sys.Desktop);
    }
    if(isDBExplorer){
        closeTabsKeepOne();
    }
    else{
        closeCodeEditor();
    }
}
//Code Test
function setCodeTest(){
    var frmCodeTest = Aliases.Sqlnavigator.frmMain.MiddleZone.frmCodeTest;
    existAndCloseWin("Code Test",frmCodeTest);
}
//Code Role Grant
function setCodeRoleGrant(){
    var frmCodeRoleGrant = Aliases.Sqlnavigator.frmCodeRoleGrant;
    existAndCloseWin("Code Role Grant",frmCodeRoleGrant);
}

//Flash Back
function setFlashBack(){
    var dlgFlashBack = Aliases.Sqlnavigator.frmFlashBackRename;
    existAndCloseWin("Rename Table",dlgFlashBack);
}

//-------------------------------------------------------------------------------------
//Function Name : RightClickOpenObj
//Author        : Alan.Yang
//Create Date   : June 5, 2015
//Last Modify   : 
//Description   : Right Click Open popup menu's item object
//Parameter     : [IN]objTree -- the object Tree
//Parameter     : [IN]objNode -- the object Tree's Node
//Parameter     : [IN]keys -- the number of menu's item or shortcuts
//Parameter     : [IN]func -- need to run this function
//Return        : null
//-------------------------------------------------------------------------------------
function RightClickOpenObj(objTree,objNode,keys,func){
    if(objNode == null) {
        Log.Error("The specified node is unable to found.");
        return;
    }
    objNode.ClickR();
    if( /^\+?[1-9][0-9]*$/.test(keys)){//whether keys is number or shortcuts , /^\+?[1-9][0-9]*$/  positive integer
        objTree.Keys(getNumString("[Down]",keys)+"[Enter]");//open popup menu item by [Down]
    }
    else{
        objTree.Keys(keys);//shortcuts
    }
    eval(func);
}

//-------------------------------------------------------------------------------------
//Function Name : checkObjShowOrHide
//Author        : Alan.Yang
//Create Date   : June 16, 2015
//Last Modify   : 
//Description   : checking the Object is Show Or Hide
//Parameter     : [IN]object -- the test object
//Parameter     : [IN]strObjName -- the test object's name
//Parameter     : [IN]keys -- using the keys to show or hide the object
//Return        : null
//-------------------------------------------------------------------------------------
function checkObjShowOrHide(object,strObjName,keys){
    var objMain = Aliases.Sqlnavigator.frmMain;
    if(object.Exists){
        objMain.Keys(keys);
        if(!object.Exists || !object.Visible){
            Log.Message("success to hide the "+strObjName);
            objMain.Keys(keys);
            if(object.Exists){
                Log.Message("success to show the "+strObjName);
            }
            else{
                Log.Error("Fail to show the "+strObjName,null,pmNormal,null,Sys.Desktop);
            }
        }
        else{
            Log.Error("Fail to hide the "+strObjName,null,pmNormal,null,Sys.Desktop);
        }
    }
    else{
        objMain.Keys(keys);
        if(object.Exists){
            Log.Message("success to show the "+strObjName);
        }
        else{
            Log.Error("Fail to show the "+strObjName,null,pmNormal,null,Sys.Desktop);
        }
    }
}