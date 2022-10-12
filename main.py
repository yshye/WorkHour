import mysql.connector
import datetime

connection = mysql.connector.connect(
    host='124.223.35.169',
    port='3306',
    user='root',
    passwd='12345678',
    database='work_hour',
    charset='utf8',
    auth_plugin='mysql_native_password'
    # autocommit=True 开启自动提交后，增删改操作无需手动调用connection.commit()
)

# 获取游标
cur = connection.cursor()


def print_cur():
    for x in cur:
        print(x)


def show_databases():
    cur.execute("show databases")
    print_cur()


def show_tables():
    cur.execute("show tables")
    print_cur()


def select_table(table: str):
    cur.execute(f"select * from {table}")
    print_cur()


def select_where(table: str, where: str):
    cur.execute(f"select * from {table} where {where}")
    print_cur()


def select_order_limit(table: str, limit: int = 10, offset: int = 0):
    cur.execute(f"select * from {table} order by createdAt desc limit {limit} offset {offset}")
    print_cur()


def select_page(table: str, page_index: int = 1, page_size: int = 10):
    limit = page_size
    offset = (page_index - 1) * page_size
    select_order_limit(table, limit, offset)


def select_datetime(begin: datetime, end: datetime):
    where = f" date > '{begin}' and date < '{end}'"
    select_where('work_infos', where)


def select_mouth(mouth: datetime):
    begin = datetime.datetime(mouth.year - 1 if mouth.month == 1 else mouth.year,
                              12 if mouth.month == 1 else mouth.month - 1, 26)
    end = datetime.datetime(mouth.year, mouth.month, 25)
    select_datetime(begin, end)


if __name__ == '__main__':
    # print(connection)
    # show_databases()
    # show_tables()
    # select_table("_user")
    # select_where(table="work_infos", where="userCode = '27017'")
    # select_order_limit("work_infos")
    # select_page("work_infos", page_index=3, page_size=10)
    # select_datetime(begin=datetime.datetime(2022, 6, 1), end=datetime.datetime(2022, 7, 1))
    select_mouth(datetime.datetime(2022, 6, 1))
