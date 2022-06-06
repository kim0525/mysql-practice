

//DBconnect.cpp
#include "DBconnect.h"
#include <string>


DBconnect::DBconnect() : 
    field(0)
{
    conn = mysql_init(NULL);
    if (conn == NULL)
    {
        std::cout << "mysql_init() failed" << std::endl;
    }
}

DBconnect::~DBconnect()
{
    if(conn != NULL)
    {
        mysql_close(conn);
    }
    if (res != NULL)
    {
        mysql_free_result(res);
    }

}

MYSQL* DBconnect::getConnectDB()
{
    return conn;
}

void DBconnect::RealConnectDB(DBINFO info)
{
    if (mysql_real_connect(
        conn,
        info.ip,
        info.user,
        info.pwd,
        info.db_name,
        info.port,
        NULL,
        0) == NULL)
    {
        std::cout << mysql_error(conn);
        mysql_close(conn);
        exit(1);
    }
    if (mysql_query(conn, "set names euckr"))
    {
        std::cout << mysql_error(conn) << std::endl;
        mysql_close(conn);
    }
}

void DBconnect::Query(std::string qry)
{
    std::string query = qry.substr(0, 6);

    if (mysql_query(conn, qry.c_str()))
    {
        std::cout << mysql_error(conn) << std::endl;
        mysql_close(conn);
    }
    res = mysql_store_result(conn);

    if (query == "select" || query == "SELECT")
    {
        //std::cout << "query == select || query == SELECT" << std::endl;
        ShowSelectQuery();
    }

}

void DBconnect::ShowSelectQuery()
{
    MYSQL_ROW _row;
    while ((_row = getRow()) != NULL)
    {
        for (int i = 0; i < getField(); i++)
        {
            std::cout << (_row[i] ? _row[i] : NULL) << "\t";
        }
        std::cout << std::endl;
    }

}


MYSQL_RES* DBconnect::getResult()
{
    return res;
}

MYSQL_ROW DBconnect::getRow()
{
    row = mysql_fetch_row(res);
    return row;
}

int DBconnect::getField()
{
    field = mysql_num_fields(res);
    return field;
}

void DBconnect::Destroy()
{
    if (conn != NULL)
    {
        mysql_close(conn);
    }
    if (res != NULL)
    {
        mysql_free_result(res);
    }
}

