
// main.cpp
#include "DBINFO.h"
#include "DBconnect.h"
#include <iostream>
#include <Windows.h>

using namespace std;

int main()
{
    DBINFO db_info = {
        "localhost",
        "root",
        "ai123",
        "sqldb",
        0
    };

    DBconnect db;
    db.RealConnectDB(db_info);
    db.Query("use testdb");

    int select = -1;
    do
    {
        cout << "---------------------------------------------------------------- -" << endl;
        cout << "1. 주소록 조회" << endl;
        cout << "2. 주소록 추가" << endl;
        cout << "3. 주소록 수정" << endl;
        cout << "4. 주소록 삭제" << endl;
        cout << "5. 종료" << endl;
        cout << " 메뉴 : ";
        cin >> select;
        system("cls");

        switch (select)
        {
        case 1:
       cout << "ADDR_ID\t NAME\t HP\t" << endl;
            db.Query("SELECT * FROM address_book");
            cout << endl << endl;
            break;
        case 2:
        {
            string _name, _hp;
            cout << "이름을 입력해주세요. : ";
            cin >> _name;
            cout << "전화번호를 입력해주세요. : ";
            cin >> _hp;

            db.Query("INSERT INTO address_book(name, hp) VALUES('" + _name + "', '" + _hp + "')");
            break;
        }
        case 3:
        {
            string id, name, hp;
            cout << "ID를 입력해주세요. : ";
            cin >> id;
            cout << "이름을 입력해주세요. : ";
            cin >> name;
            cout << "전화번호를 입력해주세요. : ";
            cin >> hp;
            db.Query("UPDATE address_book SET name = '" + name + "', hp = '" + hp + "' WHERE addr_id = "+ id +"");
            break;
        }
        case 4:
        {
            string id;
            cout << "ID를 입력해주세요. : ";
            cin >> id;
            db.Query("DELETE FROM address_book WHERE addr_id = " + id + "");
            break;
        }
        case 5:
            select = 0;
            break;
        default:
            break;
        }
    } while (select != 0);
    

    db.Destroy();
}