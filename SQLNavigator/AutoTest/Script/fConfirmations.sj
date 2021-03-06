
//-------------------------------------------------------------------------------------
//Function Name : clickConfirmations
//Author        : Alan.Yang
//Create Date   : May 20, 2015
//Last Modify   : 
//Description   : clicking all type of Confirmation dialogs to disapear it.
//Parameter     : [IN]bIsYes -- whether click the Yes button or not? default = true
//Return        : null
//-------------------------------------------------------------------------------------
function clickConfirmations(bIsYes){
    var bIsYesBtn = arguments[0] == undefined ? true : bIsYes; //default = true 
    var dlgConfirmation = Aliases.Sqlnavigator.dlgConfirmation;
    var dlgConfirm = Aliases.Sqlnavigator.dlgConfirm;
    
    var btnYes,btnNo;
    if(dlgConfirmation.Exists){// it's normal Confirmation dialog
        btnYes = dlgConfirmation.btnYes;
        btnNo = dlgConfirmation.btnNo;
        Log.Message(dlgConfirmation.WndCaption + " dialog is show.");
    }
    else if(dlgConfirm.Exists){//Confirm dialog
        btnYes = dlgConfirm.btnYes;
        btnNo = dlgConfirm.btnNo;
        Log.Message(dlgConfirm.WndCaption + " dialog is show.");
    }
    if(bIsYesBtn && btnYes != null){
        if(btnYes.Exists){
            btnYes.Click();
            Log.Message("Click Yes to close the confirmation dialog.");
        }
    }
    else if(!bIsYesBtn && btnNo != null){
        if(btnNo.Exists){
            btnNo.Click();
            Log.Message("Click No to close the confirmation dialog.");
        }
    }
}

//-------------------------------------------------------------------------------------
//Function Name : closeDialog
//Author        : Alan.Yang
//Create Date   : June 2, 2015
//Last Modify   : 
//Description   : close the given dialog fastly
//Parameter     : [IN]objNamemapping -- dialog object's namemapping
//Return        : null
//-------------------------------------------------------------------------------------
function closeDialog(objNamemapping){
    if(objNamemapping.Exists){
        Log.Message("Close the confirmation dialog: " + objNamemapping.WndCaption);
        objNamemapping.Close();
    }
}