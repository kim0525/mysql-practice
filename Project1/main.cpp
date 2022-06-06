

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
        cout << "1. �ּҷ� ��ȸ" << endl;
        cout << "2. �ּҷ� �߰�" << endl;
        cout << "3. �ּҷ� ����" << endl;
        cout << "4. �ּҷ� ����" << endl;
        cout << "5. ����" << endl;
        cout << " �޴� : ";
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
            cout << "�̸��� �Է����ּ���. : ";
            cin >> _name;
            cout << "��ȭ��ȣ�� �Է����ּ���. : ";
            cin >> _hp;

            db.Query("INSERT INTO address_book(name, hp) VALUES('" + _name + "', '" + _hp + "')");
            break;
        }
        case 3:
        {
            string id, name, hp;
            cout << "ID�� �Է����ּ���. : ";
            cin >> id;
            cout << "�̸��� �Է����ּ���. : ";
            cin >> name;
            cout << "��ȭ��ȣ�� �Է����ּ���. : ";
            cin >> hp;
            db.Query("UPDATE address_book SET name = '" + name + "', hp = '" + hp + "' WHERE addr_id = " + id + "");
            break;
        }
        case 4:
        {
            string id;
            cout << "ID�� �Է����ּ���. : ";
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