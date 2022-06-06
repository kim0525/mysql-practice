

//DBconnect.h
#pragma once

#include "DBINFO.h"
#include <mysql.h>
#include <iostream>

class DBconnect
{
public:
    DBconnect();
    ~DBconnect();
    
    MYSQL* getConnectDB();
    void RealConnectDB(DBINFO info);
    void Query(std::string qry);
    void ShowSelectQuery();
    MYSQL_RES* getResult();
    MYSQL_ROW getRow();
    int getField();

    void Destroy();


private:
    MYSQL_RES* res;
    MYSQL_ROW row;
    int field;
    MYSQL* conn;
};
