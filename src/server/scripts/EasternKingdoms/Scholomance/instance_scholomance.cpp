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

#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "scholomance.h"

Position KirtonosSpawn = Position(315.028, 70.5385, 102.15, 0.385971);

class instance_scholomance : public InstanceMapScript
{
public:
    instance_scholomance() : InstanceMapScript(ScholomanceScriptName, 289) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_scholomance_InstanceMapScript(map);
    }

    struct instance_scholomance_InstanceMapScript : public InstanceScript
    {
        instance_scholomance_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            _miniBosses = 0;
            _kirtonosState = 0;
            _rasHuman      = 0;
        }

        void OnCreatureCreate(Creature* cr) override
        {
            switch (cr->GetEntry())
            {
                case NPC_DARKMASTER_GANDLING:
                    GandlingGUID = cr->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_GATE_KIRTONOS:
                    GateKirtonosGUID = go->GetGUID();
                    break;
                case GO_DOOR_OPENED_WITH_KEY:
                    go->AllowSaveToDB(true);
                    break;
                case GO_GATE_GANDLING_DOWN_NORTH:
                    GandlingGatesGUID[0] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_DOWN_EAST:
                    GandlingGatesGUID[1] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_DOWN_SOUTH:
                    GandlingGatesGUID[2] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_UP_NORTH:
                    GandlingGatesGUID[3] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_UP_EAST:
                    GandlingGatesGUID[4] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_UP_SOUTH:
                    GandlingGatesGUID[5] = go->GetGUID();
                    break;
                case GO_GATE_GANDLING_ENTRANCE:
                    GandlingGatesGUID[6] = go->GetGUID();
                    break;
                case GO_BRAZIER_KIRTONOS:
                    BrazierKirtonosGUID = go->GetGUID();
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case GO_GATE_KIRTONOS:
                    return GateKirtonosGUID;
                case GO_BRAZIER_KIRTONOS:
                    return BrazierKirtonosGUID;
                case GO_GATE_GANDLING_DOWN_NORTH:
                    return GandlingGatesGUID[0];
                case GO_GATE_GANDLING_DOWN_EAST:
                    return GandlingGatesGUID[1];
                case GO_GATE_GANDLING_DOWN_SOUTH:
                    return GandlingGatesGUID[2];
                case GO_GATE_GANDLING_UP_NORTH:
                    return GandlingGatesGUID[3];
                case GO_GATE_GANDLING_UP_EAST:
                    return GandlingGatesGUID[4];
                case GO_GATE_GANDLING_UP_SOUTH:
                    return GandlingGatesGUID[5];
                case GO_GATE_GANDLING_ENTRANCE:
                    return GandlingGatesGUID[6];
                case NPC_DARKMASTER_GANDLING:
                    return GandlingGUID;
            }
            return ObjectGuid::Empty;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_KIRTONOS_THE_HERALD:
                    switch (data)
                    {
                        case IN_PROGRESS:
                            // summon kirtonos and close door
                            if (_kirtonosState == NOT_STARTED)
                            {
                                if (Creature* kirtonos = instance->SummonCreature(NPC_KIRTONOS, KirtonosSpawn))
                                {
                                    kirtonos->AI()->DoAction(IN_PROGRESS);
                                }
                                if (GameObject* gate = instance->GetGameObject(GetGuidData(GO_GATE_KIRTONOS)))
                                {
                                    gate->SetGoState(GO_STATE_READY);
                                }
                            }
                            _kirtonosState = data;
                            break;
                        case FAIL:
                            // open door and reset brazier
                            if (GameObject* gate = instance->GetGameObject(GetGuidData(GO_GATE_KIRTONOS)))
                            {
                                gate->SetGoState(GO_STATE_ACTIVE);
                            }

                            if (GameObject* brazier = instance->GetGameObject(GetGuidData(GO_BRAZIER_KIRTONOS)))
                            {
                                brazier->SetGoState(GO_STATE_READY);
                                brazier->SetLootState(GO_JUST_DEACTIVATED);
                                brazier->Respawn();
                            }
                            _kirtonosState = NOT_STARTED;
                            break;
                        case DONE:
                            // open door
                            if (GameObject* gate = instance->GetGameObject(GetGuidData(GO_GATE_KIRTONOS)))
                            {
                                gate->SetGoState(GO_STATE_ACTIVE);
                            }
                            [[fallthrough]];
                        default:
                            _kirtonosState = data;
                            break;
                    }
                    break;
                case DATA_MINI_BOSSES:
                    ++_miniBosses;
                    if (_miniBosses == 6)
                    {
                        if (Creature* Gandling = instance->GetCreature(GandlingGUID))
                        {
                            Gandling->AI()->Talk(0);
                            Gandling->AI()->Reset();
                        }
                    }
                    break;
                case DATA_DARKMASTER_GANDLING:
                    switch (data)
                    {
                        case DONE:
                        case NOT_STARTED:
                        case FAIL:
                            HandleGameObject(GandlingGatesGUID[6], true);
                            break;
                        case IN_PROGRESS:
                            HandleGameObject(GandlingGatesGUID[6], false);
                            break;
                    }
                    break;
                case DATA_RAS_HUMAN:
                    _rasHuman = data;
                    break;
            }
            SaveToDB();
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_KIRTONOS_THE_HERALD:
                    return _kirtonosState;
                case DATA_MINI_BOSSES:
                    return _miniBosses;
                case DATA_RAS_HUMAN:
                    return _rasHuman;
            }
            return 0;
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _kirtonosState;
            data >> _miniBosses;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _kirtonosState << ' ' << _miniBosses;
        }

    protected:
        ObjectGuid GateKirtonosGUID;
        ObjectGuid GateMiliciaGUID;
        ObjectGuid GateTheolenGUID;
        ObjectGuid GatePolkeltGUID;
        ObjectGuid GateRavenianGUID;
        ObjectGuid GateBarovGUID;
        ObjectGuid GateIlluciaGUID;
        ObjectGuid BrazierKirtonosGUID;

        ObjectGuid GandlingGatesGUID[7]; // 6 is the entrance
        ObjectGuid GandlingGUID; // boss

        uint32 _kirtonosState;
        uint32 _miniBosses;
        uint32 _rasHuman;
    };
};

class spell_scholomance_fixate_aura : public AuraScript
{
    PrepareAuraScript(spell_scholomance_fixate_aura);

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (Unit* caster = GetCaster())
            caster->TauntApply(target);
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (Unit* caster = GetCaster())
            caster->TauntFadeOut(target);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_scholomance_fixate_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_scholomance_fixate_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_scholomance_boon_of_life_aura : public AuraScript
{
    PrepareAuraScript(spell_scholomance_boon_of_life_aura);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            if (Unit* target = GetTarget())
                if (Creature* creature = target->ToCreature())
                {
                    creature->AI()->AttackStart(caster);
                    creature->AddThreat(caster, 10000.0f);
                }
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
            if (Creature* creature = target->ToCreature())
                if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_CANCEL)
                {
                    creature->AI()->Talk(TALK_RAS_HUMAN);
                    creature->SetDisplayId(MODEL_RAS_HUMAN);
                    creature->SetHealth(target->GetMaxHealth());
                    if (InstanceScript* instance = creature->GetInstanceScript())
                        instance->SetData(DATA_RAS_HUMAN, 1);
                }
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_scholomance_boon_of_life_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        AfterEffectApply += AuraEffectApplyFn(spell_scholomance_boon_of_life_aura::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

enum OccultistEntries
{
    CASTER_ENTRY      = 10472,
    DARK_SHADE_ENTRY  = 11284
};

enum OccultistSpells
{
    BONE_ARMOR_SPELL         = 16431,
    COUNTER_SPELL            = 15122,
    DRAIN_MANA_SPELL         = 17243,
    SHADOWBOLT_VOLLEY_SPELL  = 17228
};

class npc_scholomance_occultist : public CreatureScript
{
public:
    npc_scholomance_occultist() : CreatureScript("npc_scholomance_occultist") { }

    struct npc_scholomance_occultistAI: public ScriptedAI
    {
        npc_scholomance_occultistAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = me->GetInstanceScript();
        }

        uint32 originalDisplayId;
        EventMap events;
        InstanceScript* instance;

        Unit* SelectUnitCasting()
        {
          ThreatContainer::StorageType threatlist = me->GetThreatMgr().GetThreatList();
          for (ThreatContainer::StorageType::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
          {
              if (Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
              {
                  if (unit->HasUnitState(UNIT_STATE_CASTING))
                  {
                      return unit;
                  }
              }
          }
          return nullptr;
        }

        void JustReachedHome() override
        {
            events.Reset();
            if (me->GetEntry() != CASTER_ENTRY)
            {
                me->UpdateEntry(CASTER_ENTRY, nullptr, false);
                me->SetDisplayId(originalDisplayId);
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            originalDisplayId = me->GetDisplayId();

            events.Reset();
            events.RescheduleEvent(1, 1s, 7s);
            events.RescheduleEvent(2, 400ms);
            events.RescheduleEvent(3, 6s, 15s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);

            if (me->HealthBelowPct(30) && me->GetEntry() != DARK_SHADE_ENTRY)
            {
                events.Reset();
                me->InterruptNonMeleeSpells(false);
                me->UpdateEntry(DARK_SHADE_ENTRY, nullptr, false);
                events.RescheduleEvent(4, 2s, 10s);
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            switch (events.ExecuteEvent())
            {
                case 1:
                    me->CastSpell(me, BONE_ARMOR_SPELL, false);
                    events.RepeatEvent(60000);
                    break;
                case 2:
                    if (Unit* target = SelectUnitCasting())
                    {
                        me->CastSpell(target, COUNTER_SPELL, false);
                        events.RepeatEvent(urand(10000, 20000));
                    }
                    else
                    {
                        events.RepeatEvent(400);
                    }
                    break;
                case 3:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 20.0f, false)))
                    {
                        me->CastSpell(target, DRAIN_MANA_SPELL, false);
                    }
                    events.RepeatEvent(urand(13000, 20000));
                    break;
                case 4:
                    me->CastSpell(me->GetVictim(), SHADOWBOLT_VOLLEY_SPELL, true);
                    events.RepeatEvent(urand(11000, 17000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScholomanceAI<npc_scholomance_occultistAI>(creature);
    }
};

void AddSC_instance_scholomance()
{
    new instance_scholomance();
    RegisterSpellScript(spell_scholomance_fixate_aura);
    RegisterSpellScript(spell_scholomance_boon_of_life_aura);
    new npc_scholomance_occultist();
}
