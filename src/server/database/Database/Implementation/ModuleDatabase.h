/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _MODULEDATABASE_H
#define _MODULEDATABASE_H

#include "MySQLConnection.h"

enum ModuleDatabaseStatements : uint32
{
    /*  Naming standard for defines:
        {DB}_{SEL/INS/UPD/DEL/REP}_{Summary of data changed}
        When updating more than one field, consider looking at the calling function
        name for a suiting suffix.
    */

    MAX_MODULEDATABASE_STATEMENTS
};

class AC_DATABASE_API ModuleDatabaseConnection : public MySQLConnection
{
public:
    typedef ModuleDatabaseStatements Statements;

    //- Constructors for sync and async connections
    ModuleDatabaseConnection(MySQLConnectionInfo& connInfo);
    ModuleDatabaseConnection(ProducerConsumerQueue<SQLOperation*>* q, MySQLConnectionInfo& connInfo);
    ~ModuleDatabaseConnection() override;

    //- Loads database type specific prepared statements
    void DoPrepareStatements() override;
};

#endif
