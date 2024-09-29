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
#include "CreatureAI.h"
#include "EventMap.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Unit.h"
#include "sunken_temple.h"

class instance_sunken_temple : public InstanceMapScript
{
public:
    instance_sunken_temple() : InstanceMapScript("instance_sunken_temple", 109) { }

    struct instance_sunken_temple_InstanceMapScript : public InstanceScript
    {
        instance_sunken_temple_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
        }

        void Initialize() override
        {
            _statuePhase = 0;
            _defendersKilled = 0;
            memset(&_encounters, 0, sizeof(_encounters));
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_JAMMAL_AN_THE_PROPHET:
                    _jammalanGUID = creature->GetGUID();
                    break;
                case NPC_SHADE_OF_ERANIKUS:
                    _shadeOfEranikusGUID = creature->GetGUID();
                    creature->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    break;
            }

            if (creature->IsAlive() && creature->GetSpawnId() && creature->GetCreatureType() == CREATURE_TYPE_DRAGONKIN && creature->GetEntry() != NPC_SHADE_OF_ERANIKUS)
                _dragonkinList.push_back(creature->GetGUID());
        }

        void OnUnitDeath(Unit* unit) override
        {
            if (unit->IsCreature() && unit->GetCreatureType() == CREATURE_TYPE_DRAGONKIN && unit->GetEntry() != NPC_SHADE_OF_ERANIKUS)
                _dragonkinList.remove(unit->GetGUID());
            if (unit->GetEntry() == NPC_JAMMAL_AN_THE_PROPHET)
            {
                if (Creature* cr = instance->GetCreature(_shadeOfEranikusGUID))
                    cr->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            }

        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_ATALAI_STATUE1:
                case GO_ATALAI_STATUE2:
                case GO_ATALAI_STATUE3:
                case GO_ATALAI_STATUE4:
                case GO_ATALAI_STATUE5:
                case GO_ATALAI_STATUE6:
                    if (gameobject->GetEntry() < GO_ATALAI_STATUE1 + _statuePhase)
                    {
                        instance->SummonGameObject(GO_ATALAI_LIGHT2, gameobject->GetPositionX(), gameobject->GetPositionY(), gameobject->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
                        gameobject->ReplaceAllGameObjectFlags(GO_FLAG_NOT_SELECTABLE);
                    }
                    break;
                case GO_ATALAI_IDOL:
                    if (_statuePhase == MAX_STATUE_PHASE)
                        gameobject->SummonGameObject(GO_IDOL_OF_HAKKAR, -480.08f, 94.29f, -189.72f, 1.571f, 0.0f, 0.0f, 0.0f, 0.0f, 0);
                    break;
                case GO_IDOL_OF_HAKKAR:
                    if (_encounters[TYPE_ATAL_ALARION] == DONE)
                        gameobject->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                case GO_FORCEFIELD:
                    _forcefieldGUID = gameobject->GetGUID();
                    if (_defendersKilled == DEFENDERS_COUNT)
                        gameobject->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_STATUES:
                    _events.ScheduleEvent(DATA_STATUES, 0ms);
                    break;
                case DATA_DEFENDER_KILLED:
                    ++_defendersKilled;
                    if (_defendersKilled == DEFENDERS_COUNT)
                    {
                        instance->LoadGrid(-425.89f, -86.07f);
                        if (Creature* jammal = instance->GetCreature(_jammalanGUID))
                            jammal->AI()->Talk(0);
                        if (GameObject* forcefield = instance->GetGameObject(_forcefieldGUID))
                            forcefield->SetGoState(GO_STATE_ACTIVE);
                    }
                    break;
                case DATA_ERANIKUS_FIGHT:
                    for (ObjectGuid const& guid : _dragonkinList)
                    {
                        if (Creature* creature = instance->GetCreature(guid))
                            if (instance->IsGridLoaded(creature->GetPositionX(), creature->GetPositionY()))
                                creature->SetInCombatWithZone();
                    }
                    break;
                case TYPE_ATAL_ALARION:
                case TYPE_JAMMAL_AN:
                case TYPE_HAKKAR_EVENT:
                    _encounters[type] = data;
                    break;
            }

            SaveToDB();
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_STATUES:
                    return _statuePhase;
                case DATA_DEFENDER_KILLED:
                    return _defendersKilled;
                case TYPE_ATAL_ALARION:
                case TYPE_JAMMAL_AN:
                case TYPE_HAKKAR_EVENT:
                    return _encounters[type];
            }

            return 0;
        }

        void Update(uint32 diff) override
        {
            _events.Update(diff);
            switch (_events.ExecuteEvent())
            {
                case DATA_STATUES:
                    ++_statuePhase;
                    if (_statuePhase == MAX_STATUE_PHASE)
                        instance->SummonGameObject(GO_IDOL_OF_HAKKAR, -480.08f, 94.29f, -189.72f, 1.571f, 0.0f, 0.0f, 0.0f, 0.0f, 0);
                    break;
            }
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _encounters[0];
            data >> _encounters[1];
            data >> _encounters[2];
            data >> _statuePhase;
            data >> _defendersKilled;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _encounters[0] << ' '
                << _encounters[1] << ' '
                << _encounters[2] << ' '
                << _statuePhase << ' '
                << _defendersKilled;
        }

    private:
        uint32 _statuePhase;
        uint32 _defendersKilled;
        uint32 _encounters[MAX_ENCOUNTERS];

        ObjectGuid _forcefieldGUID;
        ObjectGuid _jammalanGUID;
        ObjectGuid _shadeOfEranikusGUID;
        GuidList _dragonkinList;
        EventMap _events;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_sunken_temple_InstanceMapScript(map);
    }
};

enum MalfurionMisc
{
    QUEST_ERANIKUS_TYRANT_OF_DREAMS   = 8733,
    QUEST_THE_CHARGE_OF_DRAGONFLIGHTS = 8555,
};

class at_malfurion_stormrage : public AreaTriggerScript
{
public:
    at_malfurion_stormrage() : AreaTriggerScript("at_malfurion_stormrage") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (player->GetInstanceScript() && !player->FindNearestCreature(NPC_MALFURION_STORMRAGE, 15.0f) &&
                player->GetQuestStatus(QUEST_THE_CHARGE_OF_DRAGONFLIGHTS) == QUEST_STATUS_REWARDED && player->GetQuestStatus(QUEST_ERANIKUS_TYRANT_OF_DREAMS) != QUEST_STATUS_REWARDED)
            player->SummonCreature(NPC_MALFURION_STORMRAGE, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), -1.52f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 100000);
        return false;
    }
};

class spell_temple_of_atal_hakkar_hex_of_jammal_an : public SpellScriptLoader
{
public:
    spell_temple_of_atal_hakkar_hex_of_jammal_an() : SpellScriptLoader("spell_temple_of_atal_hakkar_hex_of_jammal_an") { }

    class spell_temple_of_atal_hakkar_hex_of_jammal_an_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_temple_of_atal_hakkar_hex_of_jammal_an_AuraScript);

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* caster = GetCaster())
                if (caster->IsAlive() && caster->IsInCombat())
                {
                    caster->CastSpell(GetTarget(), HEX_OF_JAMMAL_AN, true);
                    caster->CastSpell(GetTarget(), HEX_OF_JAMMAL_AN_CHARM, true);
                }
        }

        void Register() override
        {
            OnEffectRemove += AuraEffectRemoveFn(spell_temple_of_atal_hakkar_hex_of_jammal_an_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_temple_of_atal_hakkar_hex_of_jammal_an_AuraScript();
    }
};

class spell_temple_of_atal_hakkar_awaken_the_soulflayer : public SpellScriptLoader
{
public:
    spell_temple_of_atal_hakkar_awaken_the_soulflayer() : SpellScriptLoader("spell_temple_of_atal_hakkar_awaken_the_soulflayer") { }

    class spell_temple_of_atal_hakkar_awaken_the_soulflayer_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_temple_of_atal_hakkar_awaken_the_soulflayer_SpellScript);

        void HandleSendEvent(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            InstanceScript* instanceScript = GetCaster()->GetInstanceScript();
            Map* map = GetCaster()->FindMap();
            if (!map || !instanceScript || instanceScript->GetData(TYPE_HAKKAR_EVENT) != NOT_STARTED)
                return;

            Position pos = {-466.795f, 272.863f, -90.447f, 1.57f};
            if (TempSummon* summon = map->SummonCreature(NPC_SHADE_OF_HAKKAR, pos))
            {
                summon->SetTempSummonType(TEMPSUMMON_MANUAL_DESPAWN);
                instanceScript->SetData(TYPE_HAKKAR_EVENT, IN_PROGRESS);
            }
        }

        void Register() override
        {
            OnEffectHit += SpellEffectFn(spell_temple_of_atal_hakkar_awaken_the_soulflayer_SpellScript::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_temple_of_atal_hakkar_awaken_the_soulflayer_SpellScript();
    }
};

void AddSC_instance_sunken_temple()
{
    new instance_sunken_temple();
    new at_malfurion_stormrage();
    new spell_temple_of_atal_hakkar_hex_of_jammal_an();
    new spell_temple_of_atal_hakkar_awaken_the_soulflayer();
}
