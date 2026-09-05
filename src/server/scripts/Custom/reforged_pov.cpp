// Local Reforged spectator extension. Distributed under GPL-2.0-or-later.
#include "ArenaSpectator.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "PlayerScript.h"
#include "RBAC.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "TaskScheduler.h"
#include "WorldScript.h"
#include "WorldSession.h"
#include <algorithm>
#include <map>
#include <vector>

using namespace Acore::ChatCommands;
using namespace std::chrono_literals;

namespace ReforgedPOV
{
    struct Observation
    {
        ObjectGuid target;
        WorldLocation origin;
        uint32 phase;
        bool gm;
        bool visible;
        bool gmSpectator;
        bool stopping = false;
        bool arriving = false;
        bool returning = false;
    };

    // Commands, logout and world updates run outside map worker updates.
    // Never retain pointers to players across updates.
    std::map<ObjectGuid, Observation> observations;

    std::string Field(std::string value)
    {
        for (char& character : value)
            if (character == '|' || character == '\t' || character == '\n' || character == '\r')
                character = ' ';
        return value;
    }

    void Send(Player* player, std::string const& payload)
    {
        ArenaSpectator::SendCommand(player, "RPOV\t{}", payload);
    }

    bool Allowed(Player* player)
    {
        return player->GetSession()->GetSecurity() >= SEC_GAMEMASTER &&
            player->GetSession()->HasPermission(rbac::RBAC_PERM_COMMAND_APPEAR);
    }

    bool Available(Player* observer, Player* target)
    {
        return target && target != observer && target->IsInWorld() && !target->IsBeingTeleported() &&
            !target->IsSpectator() && observations.find(target->GetGUID()) == observations.end() &&
            target->GetSession()->GetSecurity() <= observer->GetSession()->GetSecurity();
    }

    void Detach(Player* player)
    {
        player->StopCastingBindSight();
        if (WorldObject* viewpoint = player->GetViewpoint())
            player->SetViewpoint(viewpoint, false);
        if (player->IsSpectator())
            player->SetIsSpectator(false);
    }

    void Restore(Player* player, Observation const& state)
    {
        Detach(player);
        player->SetClientControl(player, true);
        player->SetGameMaster(state.gm);
        player->SetGMVisible(state.visible);
        player->SetGMSpectator(state.gmSpectator);
        player->SetPhaseMask(state.phase, true);
        Send(player, "STOP");
    }

    // Use the existing GM teleport command for instance, battleground and transport handling.
    bool Travel(Player* observer, Player* target)
    {
        Detach(observer);
        ChatHandler handler(observer->GetSession());
        handler.ParseCommands(Acore::StringFormat(".appear {}", target->GetName()));
        Observation const& state = observations.at(observer->GetGUID());
        observer->m_recallMap = state.origin.GetMapId();
        observer->m_recallX = state.origin.GetPositionX();
        observer->m_recallY = state.origin.GetPositionY();
        observer->m_recallZ = state.origin.GetPositionZ();
        observer->m_recallO = state.origin.GetOrientation();
        return observer->IsBeingTeleported();
    }

    void Snapshot(Player* observer, Player* target)
    {
        Powers power = target->getPowerType();
        Unit* selected = target->GetSelectedUnit();
        Spell* cast = target->GetCurrentSpell(CURRENT_GENERIC_SPELL);
        int32 duration = cast ? cast->GetCastTime() : 0;
        // The public Spell API exposes the remaining channel time, not its hasted total.
        // Send a countdown without inventing a total duration for the progress bar.
        if (!cast)
            cast = target->GetCurrentSpell(CURRENT_CHANNELED_SPELL);
        std::string activity = !target->IsAlive() ? "Dead" : target->GetLootGUID() ? "Looting" :
            cast ? "Casting" : target->IsInCombat() ? "In combat" : target->isMoving() ? "Moving" : "Idle";
        Send(observer, Acore::StringFormat("STATE|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}",
            target->GetName(), target->GetHealth(), target->GetMaxHealth(), uint32(power),
            target->GetPower(power), target->GetMaxPower(power), selected ? Field(selected->GetName()) : "",
            selected ? selected->GetHealth() : 0, selected ? selected->GetMaxHealth() : 0,
            cast ? cast->GetSpellInfo()->Id : 0, cast ? cast->GetCastTimeRemaining() : 0,
            duration, target->GetZoneId(), activity));
    }

    void Update()
    {
        for (auto itr = observations.begin(); itr != observations.end();)
        {
            Player* observer = ObjectAccessor::FindConnectedPlayer(itr->first);
            Observation& state = itr->second;
            if (!observer)
            {
                itr = observations.erase(itr);
                continue;
            }
            if (observer->IsBeingTeleported() || !observer->IsInWorld())
            {
                ++itr;
                continue;
            }
            Player* target = ObjectAccessor::FindConnectedPlayer(state.target);
            if (!Allowed(observer) || !target)
                state.stopping = true;
            if (state.stopping)
            {
                Detach(observer);
                if (!state.returning)
                {
                    state.returning = true;
                    if (observer->TeleportTo(state.origin, TELE_TO_GM_MODE))
                    {
                        ++itr;
                        continue;
                    }
                    ChatHandler(observer->GetSession()).SendSysMessage("Return teleport failed; use .recall.");
                }
                Restore(observer, state);
                itr = observations.erase(itr);
                continue;
            }
            if (target->IsBeingTeleported() || !target->IsInWorld())
            {
                ++itr;
                continue;
            }
            if (!Available(observer, target))
            {
                state.stopping = true;
                state.arriving = false;
                ++itr;
                continue;
            }
            // Check the result of a completed transfer before trying another one.
            if (state.arriving && observer->GetMap() != target->GetMap())
            {
                Send(observer, "ERROR|Could not enter the player's instance.");
                state.stopping = true;
                state.arriving = false;
                ++itr;
                continue;
            }
            state.arriving = false;
            if (observer->GetMap() != target->GetMap() || observer->GetDistance(target) > 80.0f)
            {
                state.arriving = Travel(observer, target);
                if (!state.arriving)
                    state.stopping = true;
                ++itr;
                continue;
            }
            if (observer->GetPhaseMask() != target->GetPhaseMask())
                observer->SetPhaseMask(target->GetPhaseMask(), true);
            if (!observer->IsSpectator())
            {
                observer->SetIsSpectator(true);
                observer->SetClientControl(observer, false);
            }
            if (observer->GetViewpoint() != target)
            {
                observer->StopCastingBindSight();
                observer->CastSpell(target, SPECTATOR_SPELL_BINDSIGHT, true);
            }
            Snapshot(observer, target);
            ++itr;
        }
    }
}

class reforged_pov_commands : public CommandScript
{
public:
    reforged_pov_commands() : CommandScript("reforged_pov_commands") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable commands =
        {
            { "list", List, rbac::RBAC_PERM_COMMAND_GM, Console::No },
            { "watch", Watch, rbac::RBAC_PERM_COMMAND_GM, Console::No },
            { "stop", Stop, rbac::RBAC_PERM_COMMAND_GM, Console::No }
        };
        static ChatCommandTable root = { { "pov", commands } };
        return root;
    }

    static bool List(ChatHandler* handler, Optional<uint32> page)
    {
        Player* observer = handler->GetPlayer();
        if (!ReforgedPOV::Allowed(observer))
            return false;
        std::vector<Player*> players;
        for (auto const& [guid, player] : ObjectAccessor::GetPlayers())
            if (ReforgedPOV::Available(observer, player))
                players.push_back(player);
        std::sort(players.begin(), players.end(), [](Player* left, Player* right)
        {
            return left->GetName() < right->GetName();
        });
        constexpr uint32 PageSize = 50;
        uint32 current = std::min(page.value_or(0), uint32(players.size() / PageSize));
        uint32 start = current * PageSize;
        uint32 end = std::min(start + PageSize, uint32(players.size()));
        ReforgedPOV::Send(observer, Acore::StringFormat("BEGIN|{}", current));
        for (uint32 index = start; index < end; ++index)
        {
            Player* player = players[index];
            ReforgedPOV::Send(observer, Acore::StringFormat("PLAYER|{}|{}|{}|{}",
                player->GetName(), player->GetLevel(), uint32(player->getClass()), player->GetZoneId()));
        }
        ReforgedPOV::Send(observer, Acore::StringFormat("END|{}", end < players.size() ? 1 : 0));
        return true;
    }

    static bool Watch(ChatHandler* handler, std::string const& name)
    {
        Player* observer = handler->GetPlayer();
        Player* target = ObjectAccessor::FindPlayerByName(name);
        if (!ReforgedPOV::Allowed(observer) || !ReforgedPOV::Available(observer, target))
        {
            handler->SendSysMessage("POV requires a GM account and an online player you can observe.");
            return false;
        }
        if (observer->IsBeingTeleported() || !observer->IsInWorld())
            return false;
        auto itr = ReforgedPOV::observations.find(observer->GetGUID());
        if (itr == ReforgedPOV::observations.end())
        {
            if (!observer->IsAlive() || observer->IsInCombat() || observer->GetGroup() ||
                observer->GetMap()->Instanceable() || observer->IsSpectator() || observer->GetVehicle() ||
                observer->GetTransport() || observer->IsInFlight() || observer->IsMounted() ||
                observer->GetViewpoint() || observer->m_mover != observer ||
                !observer->m_Controlled.empty() || observer->InBattlegroundQueue())
            {
                handler->SendSysMessage("Start POV on a living, ungrouped observer in the open world, out of combat, "
                    "unmounted, without pets, vehicles, queues or an existing remote view.");
                return false;
            }
            ReforgedPOV::Observation state{target->GetGUID(), observer->GetWorldLocation(),
                observer->GetPhaseMask(), observer->IsGameMaster(), observer->isGMVisible(),
                observer->IsGMSpectator()};
            itr = ReforgedPOV::observations.emplace(observer->GetGUID(), state).first;
            observer->SaveRecallPosition();
            observer->SetGameMaster(true);
            observer->SetGMVisible(false);
            observer->SetGMSpectator(true);
        }
        else if (itr->second.stopping)
            return false;
        itr->second.target = target->GetGUID();
        itr->second.arriving = ReforgedPOV::Travel(observer, target);
        if (!itr->second.arriving)
            itr->second.stopping = true;
        ReforgedPOV::Send(observer, Acore::StringFormat("WATCH|{}", target->GetName()));
        return true;
    }

    static bool Stop(ChatHandler* handler)
    {
        auto itr = ReforgedPOV::observations.find(handler->GetPlayer()->GetGUID());
        if (itr != ReforgedPOV::observations.end())
        {
            itr->second.stopping = true;
            itr->second.arriving = false;
        }
        else
            ReforgedPOV::Send(handler->GetPlayer(), "STOP");
        return true;
    }
};

class reforged_pov_world : public WorldScript
{
public:
    reforged_pov_world() : WorldScript("reforged_pov_world", {WORLDHOOK_ON_UPDATE})
    {
        _scheduler.Schedule(250ms, [](TaskContext context)
        {
            ReforgedPOV::Update();
            context.Repeat();
        });
    }

    void OnUpdate(uint32 diff) override { _scheduler.Update(diff); }

private:
    TaskScheduler _scheduler;
};

class reforged_pov_player : public PlayerScript
{
public:
    reforged_pov_player() : PlayerScript("reforged_pov_player", {PLAYERHOOK_ON_BEFORE_LOGOUT}) { }

    void OnPlayerBeforeLogout(Player* player) override
    {
        auto itr = ReforgedPOV::observations.find(player->GetGUID());
        if (itr != ReforgedPOV::observations.end())
        {
            ReforgedPOV::Observation state = itr->second;
            ReforgedPOV::Detach(player);
            player->TeleportTo(state.origin, TELE_TO_GM_MODE);
            ReforgedPOV::Restore(player, state);
            ReforgedPOV::observations.erase(itr);
        }
    }
};

void AddSC_reforged_pov()
{
    new reforged_pov_commands();
    new reforged_pov_world();
    new reforged_pov_player();
}
