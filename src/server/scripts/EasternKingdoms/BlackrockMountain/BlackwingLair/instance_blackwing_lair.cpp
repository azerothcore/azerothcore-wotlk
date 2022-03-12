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

#include "EventMap.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "TemporarySummon.h"
#include "blackwing_lair.h"

DoorData const doorData[] =
{
    { GO_PORTCULLIS_RAZORGORE,      DATA_RAZORGORE_THE_UNTAMED,  DOOR_TYPE_PASSAGE, BOUNDARY_NONE}, // ID 175946 || GUID 7230
    { GO_PORTCULLIS_RAZORGORE_ROOM, DATA_RAZORGORE_THE_UNTAMED,  DOOR_TYPE_ROOM,    BOUNDARY_NONE}, // ID 176964 || GUID 75158
    { GO_PORTCULLIS_VAELASTRASZ,    DATA_VAELASTRAZ_THE_CORRUPT, DOOR_TYPE_PASSAGE, BOUNDARY_NONE}, // ID 175185 || GUID 7229
    { GO_PORTCULLIS_BROODLORD,      DATA_BROODLORD_LASHLAYER,    DOOR_TYPE_PASSAGE, BOUNDARY_NONE}, // ID 179365 || GUID 75159
    { GO_PORTCULLIS_THREEDRAGONS,   DATA_FIREMAW,                DOOR_TYPE_PASSAGE, BOUNDARY_NONE}, // ID 179115 || GUID 75165
    { GO_PORTCULLIS_THREEDRAGONS,   DATA_EBONROC,                DOOR_TYPE_PASSAGE, BOUNDARY_NONE}, // ID 179115 || GUID 75165
    { GO_PORTCULLIS_THREEDRAGONS,   DATA_FLAMEGOR,               DOOR_TYPE_PASSAGE, BOUNDARY_NONE}, // ID 179115 || GUID 75165
    { GO_PORTCULLIS_CHROMAGGUS,     DATA_CHROMAGGUS,             DOOR_TYPE_PASSAGE, BOUNDARY_NONE}, // ID 179116 || GUID 75161
    { GO_PORTCULLIS_NEFARIAN,       DATA_NEFARIAN,               DOOR_TYPE_ROOM,    BOUNDARY_NONE}, // ID 179117 || GUID 75164
    { 0,                            0,                           DOOR_TYPE_ROOM,    BOUNDARY_NONE}  // END
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
    instance_blackwing_lair() : InstanceMapScript(BWLScriptName, 469) { }

    struct instance_blackwing_lair_InstanceMapScript : public InstanceScript
    {
        instance_blackwing_lair_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            //SetHeaders(DataHeader);
            SetBossNumber(EncounterCount);
            LoadDoorData(doorData);
            //LoadObjectData(creatureData, gameObjectData);
        }

        void Initialize() override
        {
            // Razorgore
            EggCount = 0;
            EggEvent = 0;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                case NPC_RAZORGORE:
                    razorgoreGUID = creature->GetGUID();
                    break;
                case NPC_CHROMAGGUS:
                    chromaggusGUID = creature->GetGUID();
                    break;
                case NPC_BLACKWING_DRAGON:
                case NPC_BLACKWING_TASKMASTER:
                case NPC_BLACKWING_LEGIONAIRE:
                case NPC_BLACKWING_WARLOCK:
                case NPC_BLACKWING_MAGE:
                    if (Creature* razor = instance->GetCreature(razorgoreGUID))
                        if (CreatureAI* razorAI = razor->AI())
                            razorAI->JustSummoned(creature);
                    break;
                case NPC_NEFARIAN:
                    nefarianGUID = creature->GetGUID();
                    break;
                case NPC_VICTOR_NEFARIUS:
                    victorNefariusGUID = creature->GetGUID();
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

                case GO_PORTCULLIS_RAZORGORE:
                case GO_PORTCULLIS_VAELASTRASZ:
                case GO_PORTCULLIS_BROODLORD:
                case GO_PORTCULLIS_THREEDRAGONS:
                    AddDoor(go, true);
                    break;
                case GO_PORTCULLIS_NEFARIAN:
                    AddDoor(go, true);
                    nefarianDoorGUID = go->GetGUID();
                    if (GetBossState(DATA_CHROMAGGUS) != DONE)
                    {
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    }
                    break;
                case GO_PORTCULLIS_CHROMAGGUS:
                    AddDoor(go, true);
                    chromaggusDoorGUID = go->GetGUID();
                    go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
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

            switch (go->GetEntry())
            {
                case GO_PORTCULLIS_RAZORGORE:
                case GO_PORTCULLIS_VAELASTRASZ:
                case GO_PORTCULLIS_BROODLORD:
                case GO_PORTCULLIS_THREEDRAGONS:
                case GO_PORTCULLIS_CHROMAGGUS:
                case GO_PORTCULLIS_NEFARIAN:
                    AddDoor(go, false);
                    break;
                default:
                    break;
            }
        }

        bool CheckRequiredBosses(uint32 bossId, Player const* /* player */) const override
        {
            switch (bossId)
            {
                case DATA_BROODLORD_LASHLAYER:
                    if (GetBossState(DATA_VAELASTRAZ_THE_CORRUPT) != DONE)
                        return false;
                    break;
                case DATA_CHROMAGGUS:
                    if (GetBossState(DATA_FIREMAW) != DONE
                        || GetBossState(DATA_EBONROC) != DONE
                        || GetBossState(DATA_FLAMEGOR) != DONE)
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
                            if (GameObject* egg = instance->GetGameObject(guid))
                            {
                                egg->SetPhaseMask(2, true);
                            }
                        }
                    }
                    SetData(DATA_EGG_EVENT, NOT_STARTED);
                    break;
                case DATA_CHROMAGGUS:
                    if (state == DONE)
                    {
                        HandleGameObject(nefarianDoorGUID, true);
                    }
                    break;
                case DATA_NEFARIAN:
                    switch (state)
                    {
                        case NOT_STARTED:
                            if (Creature* nefarian = instance->GetCreature(nefarianGUID))
                                nefarian->DespawnOrUnsummon();
                            break;
                        case FAIL:
                            _events.ScheduleEvent(EVENT_RESPAWN_NEFARIUS, 15 * 60 * IN_MILLISECONDS); //15min
                            SetBossState(DATA_NEFARIAN, NOT_STARTED);
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
                    case IN_PROGRESS:
                        _events.ScheduleEvent(EVENT_RAZOR_SPAWN, 45000);
                        EggEvent = data;
                        EggCount = 0;
                        break;
                    case NOT_STARTED:
                        _events.CancelEvent(EVENT_RAZOR_SPAWN);
                        EggEvent = data;
                        EggCount = 0;
                        for (ObjectGuid const& guid : EggList)
                        {
                            if (GameObject* egg = instance->GetGameObject(guid))
                            {
                                egg->Respawn();
                            }
                        }
                        break;
                    case SPECIAL:
                        if (++EggCount >= EggList.size())
                        {
                            if (Creature* razor = instance->GetCreature(razorgoreGUID))
                            {
                                SetData(DATA_EGG_EVENT, DONE);
                                razor->RemoveAurasDueToSpell(19832); // MindControl
                                DoRemoveAurasDueToSpellOnPlayers(19832);
                            }
                            _events.ScheduleEvent(EVENT_RAZOR_PHASE_TWO, 1000);
                            _events.CancelEvent(EVENT_RAZOR_SPAWN);
                        }
                        if (EggEvent == NOT_STARTED)
                            SetData(DATA_EGG_EVENT, IN_PROGRESS);
                        break;
                }
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_RAZORGORE_THE_UNTAMED:
                    return razorgoreGUID;
                case DATA_CHROMAGGUS:
                    return chromaggusGUID;
                case DATA_GO_CHROMAGGUS_DOOR:
                    return chromaggusDoorGUID;
                default:
                    break;
            }

            return ObjectGuid::Empty;
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
                        for (uint8 i = urand(2, 5); i > 0; --i)
                            if (Creature* summon = instance->SummonCreature(Entry[urand(0, 2)], SummonPosition[urand(0, 7)]))
                                summon->AI()->DoZoneInCombat();
                        _events.ScheduleEvent(EVENT_RAZOR_SPAWN, 12000, 17000);
                        break;
                    case EVENT_RAZOR_PHASE_TWO:
                        _events.CancelEvent(EVENT_RAZOR_SPAWN);
                        if (Creature* razor = instance->GetCreature(razorgoreGUID))
                            razor->AI()->DoAction(ACTION_PHASE_TWO);
                        break;
                    case EVENT_RESPAWN_NEFARIUS:
                        if (Creature* nefarius = instance->GetCreature(victorNefariusGUID))
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

    protected:
        ObjectGuid razorgoreGUID;
        ObjectGuid chromaggusGUID;
        ObjectGuid chromaggusDoorGUID;
        ObjectGuid nefarianGUID;
        ObjectGuid nefarianDoorGUID;
        ObjectGuid victorNefariusGUID;

        // Razorgore
        uint8 EggCount;
        uint32 EggEvent;
        GuidList EggList;

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
class spell_bwl_shadowflame : public SpellScriptLoader
{
public:
    spell_bwl_shadowflame() : SpellScriptLoader("spell_bwl_shadowflame") { }

    class spell_bwl_shadowflame_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_bwl_shadowflame_SpellScript);

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
            OnEffectHitTarget += SpellEffectFn(spell_bwl_shadowflame_SpellScript::HandleEffectScriptEffect, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_bwl_shadowflame_SpellScript;
    }
};

void AddSC_instance_blackwing_lair()
{
    new instance_blackwing_lair();
    new spell_bwl_shadowflame();
}
