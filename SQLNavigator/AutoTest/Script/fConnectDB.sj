//USEUNIT vGlobalVariables 

//-------------------------------------------------------------------------------------
//Class Name    : clsConnectDB
//Author        : Micahel.luo
//Create Date   : July 25, 2013
//Last Modify   : 
//Description   : connect to database
//Parameter     : [IN]strDBType -- DataBase Type, like "SQLSERVER", "EXCEL"
//Parameter     : [IN]strDBAlias -- DataBase Name, for EXCEL will be source file
//Parameter     : [IN]strUID -- Username
//Parameter     : [IN]strPWD -- Password
//Parameter     : [IN]strIP  -- DataBase IP address
//Parameter     : [IN]strLocalHostName  -- local DataBase host name
//Return        : null
//-------------------------------------------------------------------------------------
function clsConnectDB(strDBType, strDBAlias, strUID, strPWD, strIP, strLocalHostName)
{
	var objConnection;
	var objRecordset;
	var objCommand;
	var strConnectionString;
	
	this._strDBType = strDBType;
	this._strDBAlias = strDBAlias;
	this._strUID = strUID;
	this._strPWD = strPWD;
	this._strIP = strIP;
	this._strLocalHostName = strLocalHostName;


}

clsConnectDB.prototype.ConnectDataBase = function()
{

	this.objConnection = new ActiveXObject("ADODB.Connection");

	switch (this._strDBType.toUpperCase())
	{
		case "SQLSERVER":
    
			this.strConnectionString = "DRIVER=SQL Server; SERVER=" + this._strIP + "; UID=" + this._strUID + "; PWD=" + this._strPWD + "; DATABASE=" + this._strDBAlias + ";";
            this.objConnection.Open(this.strConnectionString);
			break;
		
		case "EXCEL":
			this.strConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0; Persist Security Info=False; Data Source=" + this._strDBAlias + "; Extended Properties='Excel 8.0; hdr=yes'";
			this.objConnection.Open(this.strConnectionString);
			break;
			
		default:
			Log.Message("select the wrong DBType, only support: SQLServer, Excel");

	}
	
	if (this.objConnection.state == 0) 
	{
		Log.Message("Failed to connect to DB");
		return false;
	};
	
}; 

//-------------------------------------------------------------------------------------
//Function Name    : QueryDatabase
//Author        : Micahel.luo
//Create Date   : July 25, 2013
//Last Modify   : 
//Description   : select data from db with single column
//Parameter     : [IN]strSql -- Query string
//Parameter     : [IN]strFieldName -- column name
//Parameter     : [OUT]str_Array_QueryResult  -- query result as array
//Return        : count of dataset
//-------------------------------------------------------------------------------------
clsConnectDB.prototype.QueryDatabase = function(strSql, strFieldName, str_Array_QueryResult) 
{
	var intArrayLength;
	var i = 0;

	//var str_Array_QueryResult;
    
    switch (this._strDBType)
    {
        case "EXCEL":
            this.objRecordSet = new ActiveXObject("ADODB.RECORDSET");
            this.objRecordSet.Open(strSql, this.objConnection, 3, 3);
            break;
    
        case "SQLSERVER":
            this.objRecordSet = new ActiveXObject("ADODB.RECORDSET");
            this.objCommand = new ActiveXObject("ADODB.COMMAND"); 
            this.objCommand.ActiveConnection = this.objConnection;	
            this.objCommand.CommandText = strSql;
            this.objRecordSet.CursorLocation = 3; 
            this.objRecordSet.Open(this.objCommand);    
            break;
    
        default:
            Log.Error("Error in QueryDatabase()");
            
    }

    intArrayLength = this.objRecordSet.RecordCount;
    
    if (intArrayLength > 0)
    {
        //str_Array_QueryResult = new Array(intArrayLength-1)
        //var objActiveX = new ActiveXObject("Scripting.Dictionary");
        
        while (!this.objRecordSet.EOF)
        {   
    
            str_Array_QueryResult[i] = this.objRecordSet(strFieldName).value;
            this.objRecordSet.MoveNext; 
            i++;   
        }            
    }
    else
    {
        str_Array_QueryResult = new Array(0);
        str_Array_QueryResult[0] = "";       
    }
    
    
    return intArrayLength;  
};

//-------------------------------------------------------------------------------------
//Function Name    : UpdateDatabase
//Author        : Micahel.luo
//Create Date   : July 25, 2013
//Last Modify   : 
//Description   : update database, include "INSERT、DELETE and UPDATE"
//Parameter     : [IN]strSql -- Query string
//Return        : null
//-------------------------------------------------------------------------------------
clsConnectDB.prototype.UpdateDatabase = function(strSql)
{
    var objCommand; 
    var objField;
    
    objCommand = new ActiveXObject("ADODB.COMMAND");
    this.objRecordSet = new ActiveXObject("ADODB.RECORDSET");
    
    objCommand.CommandText = strSql;
    objCommand.ActiveConnection = this.objConnection;
    this.objRecordSet.CursorLocation = 3;
    this.objRecordSet = objCommand.Execute;
    
//    while (!this.objRecordSet.EOF)
//    {
//        for (objField in this.objRecordSet.Fields)
//        {
//            Log["Message"](objField.Name + ": " + objField.Value);
//        }
//        this.objRecordSet.MoveNext;
//    }  
    
    objCommand = null;
          
};

//-------------------------------------------------------------------------------------
//Function Name    : GetLenOfField
//Author        : Micahel.luo
//Create Date   : July 25, 2013
//Last Modify   : 
//Description   : get the length of dataset for query;
//Parameter     : [IN]strSql -- Query string
//Return        : Record Count
//-------------------------------------------------------------------------------------
clsConnectDB.prototype.GetLenOfField = function(strSql)
{
    if (strSql == "")
    {
        return 0; 
    }
    else
    {
        var objCommand = new ActiveXObject("ADODB.COMMAND");
        this.objRecordSet = new ActiveXObject("ADODB.RECORDSET");    
        objCommand.ActiveConnection = this.objConnection; 
        objCommand.CommandText = strSql;
        
        this.objRecordSet.CursorLocation = 3; 
        this.objRecordSet.Open(objCommand);  
        
        return this.objRecordSet.RecordCount;    
        
        objCommand = null;    
    }    
};

clsConnectDB.prototype.CloseDataBase = function()
{
    this.objRecordSet.Close(); 
    this.objConnection.Close();  
    
    this.objCommand = null; 
    this.objRecordSet = null; 
    this.objConnection = null;   
};
//-------------------------------------------End Class------------------------------------

//-------------------------------------------------------------------------------------
//Function Name : GetDataById
//Author        : Michael.luo
//Create Date   : July 25, 2013
//Last Modify   : 
//Description   : Get data from data base by ID
//Parameter     : [IN]strTable -- table name whcih save test data
//Parameter     : [IN]intID -- ROW ID number in table
//Parameter     : [IN]strColumn -- Column name
//Return        : string of test data
//-------------------------------------------------------------------------------------
function sGetDataFromMSSQL(strTable, intID, strColumn)
{
   
    var arrQueryResult = new Array();
    
    var strSql = "select * from " + strTable + " where DataID=" + intID + ";";
    
    var ConnDB = new clsConnectDB(gDBType, gDBName, gUserName, gPassword, gServerName, ""); 
    
    if (ConnDB.ConnectDataBase() == false)
    {
        return "";
    }
    else
    {
        if (ConnDB.QueryDatabase(strSql, strColumn, arrQueryResult) != 0)
        {
            ConnDB.CloseDataBase();
            return (arrQueryResult[0]);
        }   
        else
        {
            return "";   
        } 
    };
                 
}






function Test()
{
    Log.Message(sGetDataFromMSSQL("Logon", 1, "I_ConnectionType"))
    //Log.Message(sGetDataFromXml("D:\\test.xml", 1, "I_ConnectionType"))
} 
