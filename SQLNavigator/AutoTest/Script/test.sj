//USEUNIT fCommFun
//USEUNIT vGlobalVariables
//USEUNIT fCodeEditor

function test(){
    var objError = getCodeEditorErrorView();// Error view panel
    if(objError != null && objError.wRootItemCount > 0){
        Log.Message(objError.wRootItemCount);
        for(var i=0; i<objError.wRootItemCount; i++){
            Log.Error(objError.wRootItem(i),null,pmNormal,null,Sys.Desktop);
        }
    }
}


