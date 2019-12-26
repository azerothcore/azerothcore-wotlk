/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#ifndef MySQLPreparedStatement_h__
#define MySQLPreparedStatement_h__

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include "MySQLWorkaround.h"
#include <string>
#include <vector>

class MySQLConnection;
class PreparedStatement;

//- Class of which the instances are unique per MySQLConnection
//- access to these class objects is only done when a prepared statement task
//- is executed.
class MySQLPreparedStatement
{
    friend class MySQLConnection;
    friend class PreparedStatement;

    public:
        MySQLPreparedStatement(MySQLStmt* stmt, std::string queryString);
        ~MySQLPreparedStatement();

        void setNull(const uint8 index);
        void setBool(const uint8 index, const bool value);
        void setUInt8(const uint8 index, const uint8 value);
        void setUInt16(const uint8 index, const uint16 value);
        void setUInt32(const uint8 index, const uint32 value);
        void setUInt64(const uint8 index, const uint64 value);
        void setInt8(const uint8 index, const int8 value);
        void setInt16(const uint8 index, const int16 value);
        void setInt32(const uint8 index, const int32 value);
        void setInt64(const uint8 index, const int64 value);
        void setFloat(const uint8 index, const float value);
        void setDouble(const uint8 index, const double value);
        void setBinary(const uint8 index, const std::vector<uint8>& value, bool isString);

        uint32 GetParameterCount() const { return m_paramCount; }

    protected:
        MySQLStmt* GetSTMT() { return m_Mstmt; }
        MySQLBind* GetBind() { return m_bind; }
        PreparedStatement* m_stmt;
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