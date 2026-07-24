/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _MAILMGR_H
#define _MAILMGR_H

#include "Define.h"
#include "ObjectGuid.h"

/**
 * @brief Owns the mail lifecycle bookkeeping that lives outside a single player
 * session: the per-character mail count mirrored in CharacterCache and the
 * cleanup of expired mail.
 *
 * Every code path that inserts or deletes a row in the characters `mail` table
 * must report it here, otherwise the cached count drifts until the next recount.
 */
class AC_GAME_API MailMgr
{
public:
    static MailMgr* instance();

    /**
     * @brief Reports a mail row inserted for a character.
     * @param receiverLow Low GUID of the mail receiver
     */
    void OnMailSent(ObjectGuid::LowType receiverLow);

    /**
     * @brief Reports a mail row deleted from a character's mailbox.
     * @param receiverLow Low GUID of the mail receiver
     */
    void OnMailDeleted(ObjectGuid::LowType receiverLow);

    /**
     * @brief Reports a mail row handed to a new receiver (return to sender).
     * @param oldReceiverLow Low GUID of the previous receiver
     * @param newReceiverLow Low GUID of the new receiver
     */
    void OnMailReturned(ObjectGuid::LowType oldReceiverLow, ObjectGuid::LowType newReceiverLow);

    /**
     * @brief Recounts the mail of all characters from the database.
     * Called once at startup after the character cache is filled.
     */
    void LoadMailCounts();

    /**
     * @brief Recounts one character's mail from the database, overwriting the
     * cached value.
     * @param receiverLow Low GUID of the character to recount
     */
    void RecountMailCount(ObjectGuid::LowType receiverLow);

    /**
     * @brief Deletes an expired mail row that has no items, money or COD
     * attached. Used at login for mail that would otherwise stay invisible in
     * the DB until ReturnOrDeleteOldMails catches the receiver offline.
     * @param mailId Id of the mail row to delete
     * @param receiverLow Low GUID of the mail receiver
     */
    void DeleteEmptyExpiredMail(uint32 mailId, ObjectGuid::LowType receiverLow);

    /**
     * @brief Returns expired mail with items to the sender and deletes the rest.
     * @param serverUp When true, receivers that are currently online are skipped.
     */
    void ReturnOrDeleteOldMails(bool serverUp);
};

#define sMailMgr MailMgr::instance()

#endif
