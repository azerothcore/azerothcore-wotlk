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

#include "MailScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnBeforeMailDraftSendMailTo(MailDraft* mailDraft, MailReceiver const& receiver, MailSender const& sender, MailCheckMask& checked, uint32& deliver_delay, uint32& custom_expiration, bool& deleteMailItemsFromDB, bool& sendMail)
{
    CALL_ENABLED_HOOKS(MailScript, MAILHOOK_ON_BEFORE_MAIL_DRAFT_SEND_MAIL_TO, script->OnBeforeMailDraftSendMailTo(mailDraft, receiver, sender, checked, deliver_delay, custom_expiration, deleteMailItemsFromDB, sendMail));
}

MailScript::MailScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, MAILHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < MAILHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<MailScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<MailScript>;
