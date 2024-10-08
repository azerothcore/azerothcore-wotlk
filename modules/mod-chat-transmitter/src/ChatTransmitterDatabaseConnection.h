#ifndef _MOD_CHAT_TRANSMITTER_DATABASE_CONNECTION_H_
#define _MOD_CHAT_TRANSMITTER_DATABASE_CONNECTION_H_

#include "Database/MySQLConnection.h"

class ChatTransmitterDatabaseConnection : public MySQLConnection
{
public:
    enum Statements : uint32
    { };

    ChatTransmitterDatabaseConnection(MySQLConnectionInfo& connInfo);
    ChatTransmitterDatabaseConnection(ProducerConsumerQueue<SQLOperation*>* q, MySQLConnectionInfo& connInfo);

    ~ChatTransmitterDatabaseConnection() override;

    void DoPrepareStatements() override;

    std::string GetLastErrorString();
    uint64 GetAffectedRows();

protected:
    bool _HandleMySQLErrno(uint32 errNo, char const* err = "", uint8 attempts = 5) override;
};

#endif
