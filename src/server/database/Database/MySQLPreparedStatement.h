/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef MySQLPreparedStatement_h__
#define MySQLPreparedStatement_h__

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include "MySQLWorkaround.h"
#include <string>
#include <vector>

class MySQLConnection;
class PreparedStatementBase;

//- Class of which the instances are unique per MySQLConnection
//- access to these class objects is only done when a prepared statement task
//- is executed.
class AC_DATABASE_API MySQLPreparedStatement
{
friend class MySQLConnection;
friend class PreparedStatementBase;

public:
    MySQLPreparedStatement(MySQLStmt* stmt, std::string queryString);
    ~MySQLPreparedStatement();

    void BindParameters(PreparedStatementBase* stmt);

    uint32 GetParameterCount() const { return m_paramCount; }

protected:
    void SetParameter(uint8 index, std::nullptr_t);
    void SetParameter(uint8 index, bool value);
    template<typename T>
    void SetParameter(uint8 index, T value);
    void SetParameter(uint8 index, std::string const& value);
    void SetParameter(uint8 index, std::vector<uint8> const& value);

    MySQLStmt* GetSTMT() { return m_Mstmt; }
    MySQLBind* GetBind() { return m_bind; }
    PreparedStatementBase* m_stmt;
    void ClearParameters();
    void AssertValidIndex(uint8 index);
    std::string getQueryString() const;

private:
    MySQLStmt* m_Mstmt;
    uint32 m_paramCount;
    std::vector<bool> m_paramsSet;
    MySQLBind* m_bind;
    std::string const m_queryString;

    MySQLPreparedStatement(MySQLPreparedStatement const& right) = delete;
    MySQLPreparedStatement& operator=(MySQLPreparedStatement const& right) = delete;
};

#endif // MySQLPreparedStatement_h__
