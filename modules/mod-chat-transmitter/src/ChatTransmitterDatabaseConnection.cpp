#include "ChatTransmitterDatabaseConnection.h"
#include "MySQLConnection.h"
#include <mysql.h>
#include <mysqld_error.h>

class MySQLPreparedStatement {};

ChatTransmitterDatabaseConnection::ChatTransmitterDatabaseConnection(MySQLConnectionInfo& connInfo)
    : MySQLConnection(connInfo)
{
}

ChatTransmitterDatabaseConnection::ChatTransmitterDatabaseConnection(ProducerConsumerQueue<SQLOperation*>* q, MySQLConnectionInfo& connInfo)
    : MySQLConnection(q, connInfo)
{
}

ChatTransmitterDatabaseConnection::~ChatTransmitterDatabaseConnection()
{
}

void ChatTransmitterDatabaseConnection::DoPrepareStatements()
{
}

bool ChatTransmitterDatabaseConnection::_HandleMySQLErrno(uint32 errNo, char const* err, uint8 attempts)
{
    switch (errNo)
    {
        case ER_BAD_FIELD_ERROR:
        case ER_NO_SUCH_TABLE:
        case ER_PARSE_ERROR:
            return false;
        default:
            return MySQLConnection::_HandleMySQLErrno(errNo, err, attempts);
    }
}

std::string ChatTransmitterDatabaseConnection::GetLastErrorString()
{
    const char* err = mysql_error(reinterpret_cast<MYSQL*>(m_Mysql));
    return std::string(err);
}

uint64 ChatTransmitterDatabaseConnection::GetAffectedRows()
{
    return mysql_affected_rows(reinterpret_cast<MYSQL*>(m_Mysql));
}
