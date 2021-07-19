/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef _ADHOCSTATEMENT_H
#define _ADHOCSTATEMENT_H

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include "SQLOperation.h"

/*! Raw, ad-hoc query. */
class AC_DATABASE_API BasicStatementTask : public SQLOperation
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
