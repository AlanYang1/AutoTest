//USEUNIT fCommFun
//USEUNIT vGlobalVariables
//USEUNIT fCodeEditor
//USEUNIT CodeEditor_Syntax


function test(){
    var edtCodeEditor = getCurrentTab();
    if(clearTabContent()){
        setCodeEditorSyntax("SelectExtract03.sql","checkExecuteResult();");
    }
}