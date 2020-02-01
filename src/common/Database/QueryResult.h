/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef QUERYRESULT_H
#define QUERYRESULT_H

#include "AutoPtr.h"
#include <ace/Thread_Mutex.h>

#include "Errors.h"
#include "Field.h"
#include "DatabaseEnvFwd.h"
#include <vector>

#ifdef _WIN32
  #include <winsock2.h>
#endif
#include <mysql.h>

class ResultSet
{
    public:
        ResultSet(MySQLResult* result, MySQLField* fields, uint64 rowCount, uint32 fieldCount);
        ~ResultSet();

        bool NextRow();
        uint64 GetRowCount() const { return _rowCount; }
        uint32 GetFieldCount() const { return _fieldCount; }
#ifdef ELUNA
        char* GetFieldName(uint32 index) const;
#endif

        Field* Fetch() const { return _currentRow; }
        Field const& operator[](std::size_t index) const;

    protected:
        uint64 _rowCount;
        Field* _currentRow;
        uint32 _fieldCount;

    private:
        void CleanUp();
        MySQLResult* _result;
        MySQLField* _fields;

        ResultSet(ResultSet const& right) = delete;
        ResultSet& operator=(ResultSet const& right) = delete;
};

class PreparedResultSet
{
    public:
        PreparedResultSet(MySQLStmt* stmt, MySQLResult* result, uint64 rowCount, uint32 fieldCount);
        ~PreparedResultSet();

        bool NextRow();
        uint64 GetRowCount() const { return m_rowCount; }
        uint32 GetFieldCount() const { return m_fieldCount; }

        Field* Fetch() const;
        Field const& operator[](std::size_t index) const;

    protected:
        std::vector<Field> m_rows;
        uint64 m_rowCount;
        uint64 m_rowPosition;
        uint32 m_fieldCount;

    private:
        MySQLBind* m_rBind;
        MySQLStmt* m_stmt;
        MySQLResult* m_metadataResult;    ///< Field metadata, returned by mysql_stmt_result_metadata

        void CleanUp();
        bool _NextRow();

        PreparedResultSet(PreparedResultSet const& right) = delete;
        PreparedResultSet& operator=(PreparedResultSet const& right) = delete;
};

#endif

