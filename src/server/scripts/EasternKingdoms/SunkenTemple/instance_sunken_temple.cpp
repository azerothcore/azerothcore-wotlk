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
#include "CreatureAI.h"
#include "EventMap.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "MapDefines.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ThreatManager.h"
#include "Unit.h"
#include "sunken_temple.h"

static constexpr float EranikusDragonkinAggroRange = SIZE_OF_GRIDS;
static constexpr float EranikusDragonkinRallySpeed = 12.4f;
static constexpr float EranikusDragonkinRallyTolerance = 3.0f;
static constexpr float EranikusWakeDistance = 10.0f;
static Position const EranikusDragonkinRallyPosition = { -659.60144f, -32.0738f, -90.8352f };

enum Events
{
    EVENT_ERANIKUS_DRAGONKIN_RALLY = 1,
    EVENT_ERANIKUS_WAKE_CHECK
};

enum Points
{
    POINT_ERANIKUS_DRAGONKIN_RALLY = 1
};

class instance_sunken_temple : public InstanceMapScript
{
public:
    instance_sunken_temple() : InstanceMapScript("instance_sunken_temple", MAP_SUNKEN_TEMPLE) { }

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
            _calledDragonkin.clear();
            _rallyingDragonkin.clear();
            _events.Reset();
            _events.ScheduleEvent(EVENT_ERANIKUS_WAKE_CHECK, 500ms);
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
            {
                unit->setActive(false);
                _dragonkinList.remove(unit->GetGUID());
                _calledDragonkin.erase(unit->GetGUID());
                _rallyingDragonkin.erase(unit->GetGUID());
            }
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
                        gameobject->SummonGameObject(GO_IDOL_OF_HAKKAR, -476.269317626953125f, 94.4119873046875f, -189.729660034179687f, 1.588248729705810546f, 0.0f, 0.0f, 0.713250160217285156f, 0.700909554958343505f, 0); // VerifiedBuild 50250

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
                        if (Creature* jammal = instance->GetCreature(_jammalanGUID))
                            jammal->AI()->Talk(0);
                        if (GameObject* forcefield = instance->GetGameObject(_forcefieldGUID))
                            forcefield->SetGoState(GO_STATE_ACTIVE);
                    }
                    break;
                case DATA_ERANIKUS_FIGHT:
                {
                    // The northern dragonkin are beyond the default combat range and may be in unloaded grids.
                    LoadDragonkinGrids();
                    StartDragonkinRally();
                    break;
                }
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
                        instance->SummonGameObject(GO_IDOL_OF_HAKKAR, -476.269317626953125f, 94.4119873046875f, -189.729660034179687f, 1.588248729705810546f, 0.0f, 0.0f, 0.713250160217285156f, 0.700909554958343505f, 0); // VerifiedBuild 50250

                    break;
                case EVENT_ERANIKUS_DRAGONKIN_RALLY:
                    if (UpdateDragonkinRally())
                        _events.ScheduleEvent(EVENT_ERANIKUS_DRAGONKIN_RALLY, 1s);
                    break;
                case EVENT_ERANIKUS_WAKE_CHECK:
                    TryWakeEranikus();
                    _events.ScheduleEvent(EVENT_ERANIKUS_WAKE_CHECK, 500ms);
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
        GuidSet _calledDragonkin;
        GuidSet _rallyingDragonkin;
        EventMap _events;

        void LoadDragonkinGrids()
        {
            CellObjectGuidsMap const& mapSpawns = sObjectMgr->GetMapObjectGuids(instance->GetId(), instance->GetSpawnMode());
            for (auto const& mapSpawn : mapSpawns)
            {
                for (ObjectGuid::LowType const spawnId : mapSpawn.second.creatures)
                {
                    CreatureData const* data = sObjectMgr->GetCreatureData(spawnId);
                    CreatureTemplate const* creatureTemplate = data ? sObjectMgr->GetCreatureTemplate(data->id) : nullptr;
                    if (!creatureTemplate || creatureTemplate->type != CREATURE_TYPE_DRAGONKIN || creatureTemplate->Entry == NPC_SHADE_OF_ERANIKUS)
                        continue;

                    instance->LoadGrid(data->posX, data->posY);
                    break;
                }
            }
        }

        void TryWakeEranikus()
        {
            Creature* eranikus = instance->GetCreature(_shadeOfEranikusGUID);
            if (!eranikus || !eranikus->IsAlive() || eranikus->IsEngaged() || eranikus->IsInEvadeMode() || !eranikus->IsAIEnabled || eranikus->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                return;

            for (ObjectGuid const& guid : _dragonkinList)
            {
                Creature* dragonkin = instance->GetCreature(guid);
                if (!dragonkin || !dragonkin->IsAlive() || !dragonkin->IsEngaged() || dragonkin->IsInEvadeMode() || dragonkin->GetDistance(eranikus) > EranikusWakeDistance)
                    continue;

                Unit* target = dragonkin->GetVictim();
                if (!target)
                    target = dragonkin->GetThreatMgr().GetCurrentVictim();

                if (target && eranikus->IsValidAttackTarget(target))
                {
                    // In the official capture, Eranikus engages when a fighting dragonkin
                    // reaches roughly ten yards, then his existing SmartAI calls the others.
                    eranikus->AI()->AttackStart(target);
                    return;
                }
            }
        }

        void MoveDragonkinToRally(Creature* creature)
        {
            creature->GetMotionMaster()->MovePoint(POINT_ERANIKUS_DRAGONKIN_RALLY, EranikusDragonkinRallyPosition,
                FORCED_MOVEMENT_RUN, EranikusDragonkinRallySpeed, true, false);
        }

        void StartDragonkinRally()
        {
            _events.CancelEvent(EVENT_ERANIKUS_DRAGONKIN_RALLY);
            for (ObjectGuid const& guid : _dragonkinList)
            {
                Creature* creature = instance->GetCreature(guid);
                if (!creature || !creature->IsAlive() || creature->IsEngaged() || creature->IsInEvadeMode() || !creature->IsAIEnabled)
                    continue;

                // The official movement runs to this fixed point beside Eranikus rather than
                // chasing his current victim. Existing combat must still override the rally.
                creature->setActive(true);
                creature->AddUnitState(UNIT_STATE_NO_COMBAT_MOVEMENT);
                creature->AI()->DoZoneInCombat(nullptr, EranikusDragonkinAggroRange);
                MoveDragonkinToRally(creature);
                _calledDragonkin.insert(guid);
                _rallyingDragonkin.insert(guid);
            }

            if (!_calledDragonkin.empty())
                _events.ScheduleEvent(EVENT_ERANIKUS_DRAGONKIN_RALLY, 1s);
        }

        bool WasDragonkinAttacked(Creature* creature) const
        {
            if (creature->hasLootRecipient())
                return true;

            for (ThreatReference const* reference : creature->GetThreatMgr().GetUnsortedThreatList())
                if (reference->GetThreat() > 0.0f)
                    return true;

            return false;
        }

        bool UpdateDragonkinRally()
        {
            Creature const* eranikus = instance->GetCreature(_shadeOfEranikusGUID);
            bool const eranikusEngaged = eranikus && eranikus->IsEngaged();

            for (auto itr = _calledDragonkin.begin(); itr != _calledDragonkin.end();)
            {
                ObjectGuid const guid = *itr;
                Creature* creature = instance->GetCreature(guid);
                if (!creature || !creature->IsAlive())
                {
                    _rallyingDragonkin.erase(guid);
                    itr = _calledDragonkin.erase(itr);
                    continue;
                }

                bool const wasAttacked = WasDragonkinAttacked(creature);
                bool const isRallying = _rallyingDragonkin.contains(guid);

                if (wasAttacked && isRallying)
                {
                    // Damage from a player turns the scripted movement into ordinary combat.
                    creature->ClearUnitState(UNIT_STATE_NO_COMBAT_MOVEMENT);
                    _rallyingDragonkin.erase(guid);
                    if (Unit* victim = creature->GetVictim())
                        creature->GetMotionMaster()->MoveChase(victim);
                }
                else if (!eranikusEngaged && !wasAttacked)
                {
                    // Untouched dragonkin evade and resume their original movement after a wipe.
                    creature->ClearUnitState(UNIT_STATE_NO_COMBAT_MOVEMENT);
                    _rallyingDragonkin.erase(guid);
                    if (creature->IsEngaged() && !creature->IsInEvadeMode() && creature->IsAIEnabled)
                        creature->AI()->EnterEvadeMode(CreatureAI::EVADE_REASON_OTHER);
                }
                else if (isRallying)
                {
                    if (!creature->IsEngaged() || creature->IsInEvadeMode())
                    {
                        creature->ClearUnitState(UNIT_STATE_NO_COMBAT_MOVEMENT);
                        _rallyingDragonkin.erase(guid);
                    }
                    else if (creature->GetDistance(EranikusDragonkinRallyPosition) <= EranikusDragonkinRallyTolerance)
                    {
                        creature->ClearUnitState(UNIT_STATE_NO_COMBAT_MOVEMENT);
                        _rallyingDragonkin.erase(guid);
                        if (Unit* victim = creature->GetVictim())
                            creature->GetMotionMaster()->MoveChase(victim);
                    }
                    else if (creature->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE || creature->movespline->Finalized())
                    {
                        // Continue from a safe partial path instead of reproducing the looping path seen in the capture.
                        MoveDragonkinToRally(creature);
                    }
                }

                if (!_rallyingDragonkin.contains(guid) && !creature->IsEngaged() && !creature->IsInEvadeMode())
                {
                    creature->ClearUnitState(UNIT_STATE_NO_COMBAT_MOVEMENT);
                    if (creature->isActiveObject())
                        creature->setActive(false);
                    itr = _calledDragonkin.erase(itr);
                    continue;
                }

                ++itr;
            }

            return !_calledDragonkin.empty();
        }
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

    bool OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        if (player->GetInstanceScript() && !player->FindNearestCreature(NPC_MALFURION_STORMRAGE, 15.0f) &&
                player->GetQuestStatus(QUEST_THE_CHARGE_OF_DRAGONFLIGHTS) == QUEST_STATUS_REWARDED && player->GetQuestStatus(QUEST_ERANIKUS_TYRANT_OF_DREAMS) != QUEST_STATUS_REWARDED)
            player->SummonCreature(NPC_MALFURION_STORMRAGE, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), -1.52f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 100000);
        return false;
    }
};

class spell_temple_of_atal_hakkar_hex_of_jammal_an_aura : public AuraScript
{
    PrepareAuraScript(spell_temple_of_atal_hakkar_hex_of_jammal_an_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ HEX_OF_JAMMAL_AN, HEX_OF_JAMMAL_AN_CHARM });
    }

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
        OnEffectRemove += AuraEffectRemoveFn(spell_temple_of_atal_hakkar_hex_of_jammal_an_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_temple_of_atal_hakkar_awaken_the_soulflayer : public SpellScript
{
    PrepareSpellScript(spell_temple_of_atal_hakkar_awaken_the_soulflayer);

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
        OnEffectHit += SpellEffectFn(spell_temple_of_atal_hakkar_awaken_the_soulflayer::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
    }
};

void AddSC_instance_sunken_temple()
{
    new instance_sunken_temple();
    new at_malfurion_stormrage();
    RegisterSpellScript(spell_temple_of_atal_hakkar_hex_of_jammal_an_aura);
    RegisterSpellScript(spell_temple_of_atal_hakkar_awaken_the_soulflayer);
}
