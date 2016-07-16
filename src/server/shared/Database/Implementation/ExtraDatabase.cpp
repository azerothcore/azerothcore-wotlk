/*
 * Copyright (C) 2008-2010 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ExtraDatabase.h"

void ExtraDatabaseConnection::DoPrepareStatements()
{
    if (!m_reconnecting)
        m_stmts.resize(MAX_EXTRADATABASE_STATEMENTS);

	//PrepareStatement(EXTRA_ADD_ITEMSTAT, "INSERT INTO item_stats (guid, item, state, group_guid) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
	PrepareStatement(EXTRA_GET_EXTERNAL_MAIL, "SELECT id, receiver, subject, message, money, item, item_count FROM mail_external ORDER BY id ASC", CONNECTION_SYNCH);
	PrepareStatement(EXTRA_DEL_EXTERNAL_MAIL, "DELETE FROM mail_external WHERE id = ?", CONNECTION_ASYNC);
}
