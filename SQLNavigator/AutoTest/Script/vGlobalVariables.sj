//-------------------------------------------------------------------------------------
//Unit Name     : vGlobalVariables
//Author        : Micahel.luo
//Create Date   : Mar 18, 2014
//Last Modify   : 
//Description   : this unit will defined all global variables for whole prject, 
//                pls use prefix operator "g" for each global variables, like: "gVersion",
//                and more comment if you can, thank you
//---------------------------------------------------------------------------------------

//defined for setting.ini path
var gSettingPath = aqFileSystem.IncludeTrailingBackSlash(Project.Path) + "Settings.ini";

//defined for connect database info
var gDBType = "SQLSERVER";
var gDBName = "SQLNAV";
var gUserName = "sa";
var gPassword = "sqlexp!23";
var gServerName = "ZHUVMSTAAJMSDATA";

//Installation variables
var gStrBuildPath = "\\\\zhuradnasw02.prod.quest.corp\\store\\SQLNavigator\\Installations\\BuildFolder\\current";
var gStrBuildType = "Beta";
var gStrInstallPath = "C:\\Program Files\\Dell\\SQL Navigator Beta\\";

//Authorization keys 
var gKey = "ESSHMR4MSY0SVLMYWX3A0ZLG4QXFGFKJ0F-123-456-789-D8";//Development Suite，highest level
var gMessage = "Dell <.@&\"\'> - prod\\ayang1";

//Logon variables
var gTNSname = "AUTO_ORA12CR2";

var gHost = "10.30.154.255";
var gPort = "1521";
var gServiceName = "pdb";

var gLDAPServer = "10.30.149.190";
var gLDAPDescriptor = "z2dev12c";

var gUserName = "navdev";
var gPassword = "navdev";

//Log Report Path
var gReportPath = "\\\\zhuflsw01\\HOME\\alan.yang\\Automation\\Reports\\";