/*
 * Powered by DecrypteD at UnderX.org & https://sololeveling.wtf
 */

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

bool ScriptMgr::OnPlayerbotCheckLFGQueue(lfg::Lfg5Guids const& guidsList)
{
    auto ret = IsValidBoolScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        return !script->OnPlayerbotCheckLFGQueue(guidsList);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPlayerbotCheckKillTask(Player* player, Unit* victim)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotCheckKillTask(player, victim);
    });
}

void ScriptMgr::OnPlayerbotCheckPetitionAccount(Player* player, bool& found)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotCheckPetitionAccount(player, found);
    });
}

bool ScriptMgr::OnPlayerbotCheckUpdatesToSend(Player* player)
{
    auto ret = IsValidBoolScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        return !script->OnPlayerbotCheckUpdatesToSend(player);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPlayerbotPacketSent(Player* player, WorldPacket const* packet)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotPacketSent(player, packet);
    });
}

void ScriptMgr::OnPlayerbotUpdate(uint32 diff)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotUpdate(diff);
    });
}

void ScriptMgr::OnPlayerbotUpdateSessions(Player* player)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotUpdateSessions(player);
    });
}

void ScriptMgr::OnPlayerbotLogout(Player* player)
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotLogout(player);
    });
}

void ScriptMgr::OnPlayerbotLogoutBots()
{
    ExecuteScript<PlayerbotScript>([&](PlayerbotScript* script)
    {
        script->OnPlayerbotLogoutBots();
    });
}
