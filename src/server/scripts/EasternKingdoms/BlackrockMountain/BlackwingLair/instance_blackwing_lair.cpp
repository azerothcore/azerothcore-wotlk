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

#include "AreaTriggerScript.h"
#include "EventMap.h"
#include "GameObject.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TemporarySummon.h"
#include "blackwing_lair.h"
#include <array>

DoorData const doorData[] =
{
    { GO_PORTCULLIS_RAZORGORE,      DATA_RAZORGORE_THE_UNTAMED,  DOOR_TYPE_PASSAGE }, // ID 175946 || GUID 7230
    { GO_PORTCULLIS_RAZORGORE_ROOM, DATA_RAZORGORE_THE_UNTAMED,  DOOR_TYPE_ROOM,   }, // ID 176964 || GUID 75158
    { GO_PORTCULLIS_VAELASTRASZ,    DATA_VAELASTRAZ_THE_CORRUPT, DOOR_TYPE_PASSAGE }, // ID 175185 || GUID 7229
    { GO_PORTCULLIS_BROODLORD,      DATA_BROODLORD_LASHLAYER,    DOOR_TYPE_PASSAGE }, // ID 179365 || GUID 75159
    { GO_PORTCULLIS_CHROMAGGUS_EXIT,DATA_CHROMAGGUS,             DOOR_TYPE_PASSAGE }, // ID 179117 || GUID 75164
    { GO_PORTCULLIS_CHROMAGGUS_EXIT,DATA_NEFARIAN,               DOOR_TYPE_ROOM    }, // ID 179117 || GUID 75164
    { GO_PORTCULLIS_NEFARIAN,       DATA_NEFARIAN,               DOOR_TYPE_ROOM    }, // ID 176966
    { 0,                            0,                           DOOR_TYPE_ROOM    }  // END
};

ObjectData const creatureData[] =
{
    { NPC_GRETHOK,         DATA_GRETHOK              },
    { NPC_NEFARIAN_TROOPS, DATA_NEFARIAN_TROOPS      },
    { NPC_VICTOR_NEFARIUS, DATA_LORD_VICTOR_NEFARIUS },
    { NPC_CHROMAGGUS,      DATA_CHROMAGGUS           },
    { 0,                   0                         }
};

ObjectData const objectData[] =
{
    { GO_PORTCULLIS_CHROMAGGUS,      DATA_GO_CHROMAGGUS_DOOR      },
    { GO_PORTCULLIS_CHROMAGGUS_EXIT, DATA_GO_CHROMAGGUS_DOOR_EXIT },
    { 0,                             0                            }
};

Position const SummonPosition[8] =
{
    {-7661.207520f, -1043.268188f, 407.199554f, 6.280452f},
    {-7644.145020f, -1065.628052f, 407.204956f, 0.501492f},
    {-7624.260742f, -1095.196899f, 407.205017f, 0.544694f},
    {-7608.501953f, -1116.077271f, 407.199921f, 0.816443f},
    {-7531.841797f, -1063.765381f, 407.199615f, 2.874187f},
    {-7547.319336f, -1040.971924f, 407.205078f, 3.789175f},
    {-7568.547852f, -1013.112488f, 407.204926f, 3.773467f},
    {-7584.175781f, -989.6691289f, 407.199585f, 4.527447f},
};

uint32 const Entry[3] = { 12422, 12416, 12420 };

class instance_blackwing_lair : public InstanceMapScript
{
public:
    instance_blackwing_lair() : InstanceMapScript(BWLScriptName, MAP_BLACKWING_LAIR) { }

    struct instance_blackwing_lair_InstanceMapScript : public InstanceScript
    {
        instance_blackwing_lair_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(EncounterCount);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, objectData);
        }

        void Initialize() override
        {
            // Razorgore
            EggCount = 0;
            EggEvent = 0;
            NefarianLeftTunnel = 0;
            NefarianRightTunnel = 0;
            addsCount.fill(0);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            // This is required because the tempspawn at Vael overwrites his GUID.
            if (creature->GetEntry() == NPC_VICTOR_NEFARIUS && creature->ToTempSummon())
            {
                return;
            }

            InstanceScript::OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                case NPC_RAZORGORE:
                    razorgoreGUID = creature->GetGUID();
                    break;
                case NPC_BLACKWING_DRAGON:
                    ++addsCount[0];
                    if (Creature* razor = instance->GetCreature(razorgoreGUID))
                    {
                        if (CreatureAI* razorAI = razor->AI())
                        {
                            razorAI->JustSummoned(creature);
                        }
                    }
                    break;
                case NPC_BLACKWING_LEGIONAIRE:
                case NPC_BLACKWING_MAGE:
                    ++addsCount[1];
                    if (Creature* razor = instance->GetCreature(razorgoreGUID))
                    {
                        if (CreatureAI* razorAI = razor->AI())
                        {
                            razorAI->JustSummoned(creature);
                        }
                    }
                    break;
                case NPC_BLACKWING_GUARDSMAN:
                    guardList.push_back(creature->GetGUID());
                    break;
                case NPC_NEFARIAN:
                    nefarianGUID = creature->GetGUID();
                    break;
                case NPC_BLACK_DRAKONID:
                case NPC_BLUE_DRAKONID:
                case NPC_BRONZE_DRAKONID:
                case NPC_CHROMATIC_DRAKONID:
                case NPC_GREEN_DRAKONID:
                case NPC_RED_DRAKONID:
                    if (Creature* nefarius = GetCreature(DATA_LORD_VICTOR_NEFARIUS))
                    {
                        if (CreatureAI* nefariusAI = nefarius->AI())
                        {
                            nefariusAI->JustSummoned(creature);
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);

            switch (go->GetEntry())
            {
                case GO_BLACK_DRAGON_EGG:
                    if (GetBossState(DATA_FIREMAW) == DONE)
                    {
                        go->SetPhaseMask(2, true);
                    }
                    else
                    {
                        EggList.push_back(go->GetGUID());
                    }
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go) override
        {
            InstanceScript::OnGameObjectRemove(go);

            if (go->GetEntry() == GO_BLACK_DRAGON_EGG)
                EggList.remove(go->GetGUID());
        }

        uint32 GetData(uint32 data) const override
        {
            switch (data)
            {
                case DATA_NEFARIAN_LEFT_TUNNEL:
                    return NefarianLeftTunnel;
                case DATA_NEFARIAN_RIGHT_TUNNEL:
                    return NefarianRightTunnel;
                case DATA_EGG_EVENT:
                    return EggEvent;
                default:
                    break;
            }

            return 0;
        }

        bool CheckRequiredBosses(uint32 bossId, Player const* /* player */) const override
        {
            switch (bossId)
            {
                case DATA_BROODLORD_LASHLAYER:
                    if (GetBossState(DATA_VAELASTRAZ_THE_CORRUPT) != DONE)
                        return false;
                    break;
                default:
                    break;
            }

            return true;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_RAZORGORE_THE_UNTAMED:
                    if (state == DONE)
                    {
                        for (ObjectGuid const& guid : EggList)
                        {
                            // Eggs should be destroyed instead
                           /// @todo: after dynamic spawns
                            if (GameObject* egg = instance->GetGameObject(guid))
                            {
                                egg->SetPhaseMask(2, true);
                            }
                        }
                    }
                    break;
                case DATA_NEFARIAN:
                    switch (state)
                    {
                        case FAIL:
                            _events.ScheduleEvent(EVENT_RESPAWN_NEFARIUS, 15min);
                            [[fallthrough]];
                        case NOT_STARTED:
                            if (Creature* nefarian = instance->GetCreature(nefarianGUID))
                            {
                                nefarian->DespawnOrUnsummon();
                            }
                            break;
                        default:
                            break;
                    }
                    break;
            }
            return true;
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == DATA_EGG_EVENT)
            {
                switch (data)
                {
                    case DONE:
                        EggEvent = data;
                        break;
                    case FAIL:
                        _events.CancelEvent(EVENT_RAZOR_SPAWN);
                        break;
                    case IN_PROGRESS:
                        _events.ScheduleEvent(EVENT_RAZOR_SPAWN, 45s);
                        EggEvent = data;
                        EggCount = 0;
                        addsCount.fill(0);
                        break;
                    case NOT_STARTED:
                        _events.CancelEvent(EVENT_RAZOR_SPAWN);
                        EggEvent = data;
                        EggCount = 0;
                        addsCount.fill(0);

                        for (ObjectGuid const& guid : EggList)
                        {
                            DoRespawnGameObject(guid, 0);
                        }

                        DoRespawnCreature(DATA_GRETHOK);

                        for (ObjectGuid const& guid : guardList)
                        {
                            DoRespawnCreature(guid);
                        }

                        break;
                    case SPECIAL:
                        if (EggEvent == NOT_STARTED)
                            SetData(DATA_EGG_EVENT, IN_PROGRESS);
                        if (++EggCount >= EggList.size())
                        {
                            if (Creature* razor = instance->GetCreature(razorgoreGUID))
                            {
                                SetData(DATA_EGG_EVENT, DONE);
                                razor->RemoveAurasDueToSpell(19832); // MindControl
                                DoRemoveAurasDueToSpellOnPlayers(19832);
                            }
                            _events.ScheduleEvent(EVENT_RAZOR_PHASE_TWO, 1s);
                            _events.CancelEvent(EVENT_RAZOR_SPAWN);
                        }
                        break;
                }
            }

            if (type == DATA_NEFARIAN_LEFT_TUNNEL)
            {
                NefarianLeftTunnel = data;
            }

            if (type == DATA_NEFARIAN_RIGHT_TUNNEL)
            {
                NefarianRightTunnel = data;
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_RAZORGORE_THE_UNTAMED:
                    return razorgoreGUID;
                default:
                    break;
            }

            return ObjectGuid::Empty;
        }

        void OnUnitDeath(Unit* unit) override
        {
            switch (unit->GetEntry())
            {
                case NPC_BLACKWING_DRAGON:
                    --addsCount[0];
                    if (EggEvent != DONE && !_events.HasTimeUntilEvent(EVENT_RAZOR_SPAWN))
                    {
                        _events.ScheduleEvent(EVENT_RAZOR_SPAWN, 1s);
                    }
                    break;
                case NPC_BLACKWING_LEGIONAIRE:
                case NPC_BLACKWING_MAGE:
                    --addsCount[1];
                    if (EggEvent != DONE && !_events.HasTimeUntilEvent(EVENT_RAZOR_SPAWN))
                    {
                        _events.ScheduleEvent(EVENT_RAZOR_SPAWN, 1s);
                    }
                    break;
                default:
                    break;
            }
        }

        void Update(uint32 diff) override
        {
            if (_events.Empty())
                return;

            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_RAZOR_SPAWN:
                        if (EggEvent == IN_PROGRESS)
                        {
                            bool spawnMoreAdds = true;
                            for (uint8 i = urand(2, 5); i > 0; --i)
                            {
                                uint32 mobEntry = Entry[urand(0, 2)];
                                uint32 dragonkinsCount = addsCount[0];
                                uint32 orcsCount = addsCount[1];

                                // If more than 12 dragonkins...
                                if (dragonkinsCount >= 12)
                                {
                                    //... and more than 40 orcs - stop spawning more adds.
                                    if (orcsCount >= 40)
                                    {
                                        spawnMoreAdds = false;
                                        break;
                                    }
                                    //... - stop spawning them.
                                    else if (mobEntry == NPC_BLACKWING_DRAGON)
                                    {
                                        continue;
                                    }
                                }
                                // If more than 40 orcs - stop spawning them.
                                else if (orcsCount >= 40 && mobEntry != NPC_BLACKWING_DRAGON)
                                {
                                    continue;
                                }

                                if (Creature* summon = instance->SummonCreature(mobEntry, SummonPosition[urand(0, 7)]))
                                {
                                    summon->AI()->DoZoneInCombat();
                                }
                            }

                            if (spawnMoreAdds)
                            {
                                _events.ScheduleEvent(EVENT_RAZOR_SPAWN, 15s);
                            }
                        }
                        break;
                    case EVENT_RAZOR_PHASE_TWO:
                        _events.CancelEvent(EVENT_RAZOR_SPAWN);
                        if (Creature* razor = instance->GetCreature(razorgoreGUID))
                            razor->AI()->DoAction(ACTION_PHASE_TWO);
                        break;
                    case EVENT_RESPAWN_NEFARIUS:
                        if (Creature* nefarius = GetCreature(DATA_LORD_VICTOR_NEFARIUS))
                        {
                            nefarius->SetPhaseMask(1, true);
                            nefarius->setActive(true);
                            nefarius->Respawn();
                            nefarius->GetMotionMaster()->MoveTargetedHome();
                        }
                        break;
                }
            }
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> NefarianLeftTunnel;
            data >> NefarianRightTunnel;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << NefarianLeftTunnel << ' ' << NefarianRightTunnel;
        }

    protected:
        ObjectGuid razorgoreGUID;
        ObjectGuid nefarianGUID;
        ObjectGuid nefarianDoorGUID;

        // Razorgore
        uint8 EggCount;
        uint32 EggEvent;
        GuidList EggList;
        GuidList guardList;
        std::array<uint32, 2> addsCount;

        // Nefarian
        uint32 NefarianLeftTunnel;
        uint32 NefarianRightTunnel;

        // Misc
        EventMap _events;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_blackwing_lair_InstanceMapScript(map);
    }
};

enum ShadowFlame
{
    SPELL_ONYXIA_SCALE_CLOAK = 22683,
    SPELL_SHADOW_FLAME_DOT = 22682
};

// 22539 - Shadowflame (used in Blackwing Lair)
class spell_bwl_shadowflame : public SpellScript
{
    PrepareSpellScript(spell_bwl_shadowflame);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ONYXIA_SCALE_CLOAK, SPELL_SHADOW_FLAME_DOT });
    }

    void HandleEffectScriptEffect(SpellEffIndex /*effIndex*/)
    {
        // If the victim of the spell does not have "Onyxia Scale Cloak" - add the Shadow Flame DoT (22682)
        if (Unit* victim = GetHitUnit())
            if (!victim->HasAura(SPELL_ONYXIA_SCALE_CLOAK))
                victim->AddAura(SPELL_SHADOW_FLAME_DOT, victim);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_bwl_shadowflame::HandleEffectScriptEffect, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

enum orb_of_command_misc
{
    QUEST_BLACKHANDS_COMMAND = 7761
};

const Position orbOfCommandTP = { -7672.46f, -1107.19f, 396.65f, 0.59f };

class at_orb_of_command : public AreaTriggerScript
{
public:
    at_orb_of_command() : AreaTriggerScript("at_orb_of_command") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (!player->IsAlive() && player->GetQuestRewardStatus(QUEST_BLACKHANDS_COMMAND))
        {
            player->TeleportTo(MAP_BLACKWING_LAIR, orbOfCommandTP.m_positionX, orbOfCommandTP.m_positionY, orbOfCommandTP.m_positionZ, orbOfCommandTP.m_orientation);
            return true;
        }
        return false;
    }
};

void AddSC_instance_blackwing_lair()
{
    new instance_blackwing_lair();
    RegisterSpellScript(spell_bwl_shadowflame);
    new at_orb_of_command();
}
