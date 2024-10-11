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

#include "AreaTriggerScript.h"
#include "GameObjectScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "Spell.h"
#include "icecrown_citadel.h"

#define GOSSIP_SENDER_ICC_PORT 631

enum ICCTeleportOption
{
    ICC_TELEPORT_GOSSIP_OPT_LIGHTS_HAMMER = 0,
    ICC_TELEPORT_GOSSIP_OPT_ORATORY_OF_THE_DAMNED = 1,
    ICC_TELEPORT_GOSSIP_OPT_RAMPART_OF_SKULLS = 3,
    ICC_TELEPORT_GOSSIP_OPT_DEATHBRINGERS_RISE = 4,
    ICC_TELEPORT_GOSSIP_OPT_UPPER_SPIRE = 5,
    ICC_TELEPORT_GOSSIP_OPT_SINDRAGOSAS_LAIR = 6
};

class icecrown_citadel_teleport : public GameObjectScript
{
public:
    icecrown_citadel_teleport() : GameObjectScript("icecrown_citadel_teleport") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        uint32 gossipMenuId = go->GetGOInfo()->GetGossipMenuId();

        if (go->GetEntry() != GO_SCOURGE_TRANSPORTER_FIRST)
            AddGossipItemFor(
                player, gossipMenuId, ICC_TELEPORT_GOSSIP_OPT_LIGHTS_HAMMER,
                GOSSIP_SENDER_ICC_PORT, LIGHT_S_HAMMER_TELEPORT
            ); // M_PI + M_PI/6

        if (InstanceScript* instance = go->GetInstanceScript())
        {
            if (instance->GetBossState(DATA_LORD_MARROWGAR) == DONE && go->GetEntry() != 202245)
                AddGossipItemFor(
                    player, gossipMenuId, ICC_TELEPORT_GOSSIP_OPT_ORATORY_OF_THE_DAMNED,
                    GOSSIP_SENDER_ICC_PORT, ORATORY_OF_THE_DAMNED_TELEPORT
                ); // M_PI + M_PI/6
            if (instance->GetBossState(DATA_LADY_DEATHWHISPER) == DONE && go->GetEntry() != 202243)
                AddGossipItemFor(
                    player, gossipMenuId, ICC_TELEPORT_GOSSIP_OPT_RAMPART_OF_SKULLS,
                    GOSSIP_SENDER_ICC_PORT, RAMPART_OF_SKULLS_TELEPORT
                ); // M_PI/6
            if (instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == DONE && go->GetEntry() != 202244)
                AddGossipItemFor(
                    player, gossipMenuId, ICC_TELEPORT_GOSSIP_OPT_DEATHBRINGERS_RISE,
                    GOSSIP_SENDER_ICC_PORT, DEATHBRINGER_S_RISE_TELEPORT
                ); // M_PI/6
            if (instance->GetData(DATA_COLDFLAME_JETS) == DONE && go->GetEntry() != 202235)
                AddGossipItemFor(
                    player, gossipMenuId, ICC_TELEPORT_GOSSIP_OPT_UPPER_SPIRE,
                    GOSSIP_SENDER_ICC_PORT, UPPER_SPIRE_TELEPORT
                ); // M_PI/6
            if (instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) == DONE && instance->GetBossState(DATA_SINDRAGOSA_GAUNTLET) == DONE && go->GetEntry() != 202246)
                AddGossipItemFor(
                    player, gossipMenuId, ICC_TELEPORT_GOSSIP_OPT_SINDRAGOSAS_LAIR,
                    GOSSIP_SENDER_ICC_PORT, SINDRAGOSA_S_LAIR_TELEPORT
                ); // M_PI*3/2 + M_PI/6
        }

        SendGossipMenuFor(player, player->GetGossipTextId(go), go->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, GameObject* /*go*/, uint32 sender, uint32 action) override
    {
        ClearGossipMenuFor(player);
        CloseGossipMenuFor(player);
        SpellInfo const* spell = sSpellMgr->GetSpellInfo(action);
        if (!spell)
            return false;

        if (player->IsInCombat())
        {
            Spell::SendCastResult(player, spell, 0, SPELL_FAILED_AFFECTING_COMBAT);
            return true;
        }

        if (sender == GOSSIP_SENDER_ICC_PORT)
            player->CastSpell(player, spell, false);

        return true;
    }
};

class at_frozen_throne_teleport : public AreaTriggerScript
{
public:
    at_frozen_throne_teleport() : AreaTriggerScript("at_frozen_throne_teleport") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/) override
    {
        if (player->IsInCombat())
        {
            if (SpellInfo const* spell = sSpellMgr->GetSpellInfo(FROZEN_THRONE_TELEPORT))
                Spell::SendCastResult(player, spell, 0, SPELL_FAILED_AFFECTING_COMBAT);
            return true;
        }

        if (InstanceScript* instance = player->GetInstanceScript())
            if (instance->GetBossState(DATA_PROFESSOR_PUTRICIDE) == DONE &&
                    instance->GetBossState(DATA_BLOOD_QUEEN_LANA_THEL) == DONE &&
                    instance->GetBossState(DATA_SINDRAGOSA) == DONE &&
                    instance->GetBossState(DATA_THE_LICH_KING) != IN_PROGRESS)
                player->CastSpell(player, FROZEN_THRONE_TELEPORT, false);

        return true;
    }
};

void AddSC_icecrown_citadel_teleport()
{
    new icecrown_citadel_teleport();
    new at_frozen_throne_teleport();
}
