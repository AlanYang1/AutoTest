//USEUNIT fCommFun
//USEUNIT vGlobalVariables

function test(){
    var path = "C:\\Users\\ayang1\\Desktop\\PLSQL_datatypes7.bmp";
    var path2 = "\\\\zhuradnasw02.prod.quest.corp\\Store\\SQLNavigator\\Temp\\testpic\\PLSQL_datatypes7.bmp";
    
    pic1 = Utils.Picture;
    pic2 = Utils.Picture;
    pic1.LoadFromFile(path);
    pic2.LoadFromFile(path2);
    Log.Message(pic1.Compare(pic2));
    Log.Picture(pic1.Difference(pic2, false, 0, false));
}


