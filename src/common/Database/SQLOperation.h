/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _SQLOPERATION_H
#define _SQLOPERATION_H

#include <ace/Method_Request.h>
#include <ace/Activation_Queue.h>

#include "QueryResult.h"

//- Forward declare (don't include header to prevent circular includes)
class PreparedStatement;

//- Union that holds element data
union SQLElementUnion
{
    PreparedStatement* stmt;
    const char* query;
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

//- For ambigious resultsets
union SQLResultSetUnion
{
    PreparedResultSet* presult;
    ResultSet* qresult;
};

class MySQLConnection;

class SQLOperation : public ACE_Method_Request
{
    public:
        SQLOperation(): m_conn(NULL) { }
        virtual int call()
        {
            Execute();
            return 0;
        }
        virtual bool Execute() = 0;
        virtual void SetConnection(MySQLConnection* con) { m_conn = con; }

        MySQLConnection* m_conn;
};

#endif
