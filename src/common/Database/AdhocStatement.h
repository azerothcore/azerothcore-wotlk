/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _ADHOCSTATEMENT_H
#define _ADHOCSTATEMENT_H

#include "Define.h"
#include "DatabaseEnvFwd.h"
#include "SQLOperation.h"

/*! Raw, ad-hoc query. */
class BasicStatementTask : public SQLOperation
{
    public:
        BasicStatementTask(char const* sql, bool async = false);
        ~BasicStatementTask();

        bool Execute() override;
        QueryResultFuture GetFuture() const { return m_result->get_future(); }

    private:
        char const* m_sql;      //- Raw query to be executed
        bool m_has_result;
        QueryResultPromise* m_result;
};

#endif
