/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _SQLOPERATION_H
#define _SQLOPERATION_H

#include "DatabaseEnvFwd.h"
#include "Define.h"

//- Union that holds element data
union SQLElementUnion
{
    PreparedStatementBase* stmt;
    char const* query;
};

//- Type specifier of our element data
enum SQLElementDataType
{
    SQL_ELEMENT_RAW,
    SQL_ELEMENT_PREPARED
};

//- The element
struct SQLElementData
{
    SQLElementUnion element;
    SQLElementDataType type;
};

class MySQLConnection;

class AC_DATABASE_API SQLOperation
{
public:
    SQLOperation(): m_conn(nullptr) { }
    virtual ~SQLOperation() { }

    virtual int call()
    {
        Execute();
        return 0;
    }
    virtual bool Execute() = 0;
    virtual void SetConnection(MySQLConnection* con) { m_conn = con; }

    MySQLConnection* m_conn;

private:
    SQLOperation(SQLOperation const& right) = delete;
    SQLOperation& operator=(SQLOperation const& right) = delete;
};

#endif
