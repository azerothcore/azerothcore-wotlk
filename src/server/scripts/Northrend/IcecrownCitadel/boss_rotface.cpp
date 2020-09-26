/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "GridNotifiers.h"
#include "icecrown_citadel.h"

enum Texts
{
    SAY_PRECIOUS_DIES           = 0,
    SAY_AGGRO                   = 1,
    EMOTE_SLIME_SPRAY           = 2,
    SAY_SLIME_SPRAY             = 3,
    EMOTE_UNSTABLE_EXPLOSION    = 4,
    SAY_UNSTABLE_EXPLOSION      = 5,
    SAY_KILL                    = 6,
    SAY_BERSERK                 = 7,
    SAY_DEATH                   = 8,
    EMOTE_MUTATED_INFECTION     = 9,

    SAY_ROTFACE_OOZE_FLOOD      = 2, // professor

    EMOTE_PRECIOUS_ZOMBIES      = 0,
};

enum Spells
{
    // Rotface
    SPELL_SLIME_SPRAY                       = 69508,    // every 20 seconds
    SPELL_MUTATED_INFECTION                 = 69674,    // hastens every 1:30

    SPELL_VILE_GAS_H                        = 69240,

    // Ooze Flood
    SPELL_OOZE_FLOOD_VISUAL                 = 69785,
    SPELL_OOZE_FLOOD_PERIODIC               = 69788,

    // Oozes
    SPELL_LITTLE_OOZE_COMBINE               = 69537,    // combine 2 Small Oozes
    SPELL_LARGE_OOZE_COMBINE                = 69552,    // combine 2 Large Oozes
    SPELL_LARGE_OOZE_BUFF_COMBINE           = 69611,    // combine Large and Small Ooze
    SPELL_OOZE_MERGE                        = 69889,    // 2 Small Oozes summon a Large Ooze
    SPELL_WEAK_RADIATING_OOZE               = 69750,    // passive damage aura - small
    SPELL_RADIATING_OOZE                    = 69760,    // passive damage aura - large
    SPELL_UNSTABLE_OOZE                     = 69558,    // damage boost and counter for explosion
    SPELL_GREEN_ABOMINATION_HITTIN__YA_PROC = 70001,    // prevents getting hit by infection
    SPELL_UNSTABLE_OOZE_EXPLOSION           = 69839,
    SPELL_STICKY_OOZE                       = 69774,
    SPELL_UNSTABLE_OOZE_EXPLOSION_TRIGGER   = 69832,

    // Precious
    SPELL_MORTAL_WOUND                      = 71127,
    SPELL_DECIMATE                          = 71123,
    SPELL_AWAKEN_PLAGUED_ZOMBIES            = 71159,
};

#define MUTATED_INFECTION RAID_MODE<int32>(69674, 71224, 73022, 73023)

enum Events
{
    EVENT_NONE,
    // Rotface
    EVENT_UNROOT,
    EVENT_SLIME_SPRAY,
    EVENT_HASTEN_INFECTIONS,
    EVENT_MUTATED_INFECTION,
    EVENT_ROTFACE_OOZE_FLOOD,
    EVENT_ROTFACE_VILE_GAS,

    EVENT_STICKY_OOZE,

    // Precious
    EVENT_DECIMATE,
    EVENT_MORTAL_WOUND,
    EVENT_SUMMON_ZOMBIES,
};

uint32 const oozeFloodSpells[4] = {69782, 69796, 69798, 69801};
uint32 getOozeFloodSpellIndex(uint32 id)
{
    switch (id)
    {
        case 69782: return 0;
        case 69796: return 1;
        case 69798: return 2;
        case 69801: return 3;
    }
    return 0;
}

struct RotfaceHeightCheck
{
    RotfaceHeightCheck() {}

    bool operator()(Creature* stalker) const
    {
        return stalker->GetPositionZ() < 365.0f;
    }
};

class boss_rotface : public CreatureScript
{
    public:
        boss_rotface() : CreatureScript("boss_rotface") { }

        struct boss_rotfaceAI : public BossAI
        {
            boss_rotfaceAI(Creature* creature) : BossAI(creature, DATA_ROTFACE)
            {
            }

            uint32 infectionCooldown;
            uint64 _oozeFloodDummyGUIDs[4][2];
            uint8 _oozeFloodStage;

            void Reset()
            {
                infectionCooldown = 14000;
                memset(&_oozeFloodDummyGUIDs, 0, sizeof(_oozeFloodDummyGUIDs));
                _oozeFloodStage = 0;
                _Reset();
                events.Reset();
            }

            void EnterCombat(Unit* who)
            {
                if (!instance->CheckRequiredBosses(DATA_ROTFACE, who->ToPlayer()))
                {
                    EnterEvadeMode();
                    instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                    return;
                }

                // schedule events
                events.Reset();
                events.ScheduleEvent(EVENT_SLIME_SPRAY, 20000);
                events.ScheduleEvent(EVENT_HASTEN_INFECTIONS, 90000);
                events.ScheduleEvent(EVENT_MUTATED_INFECTION, 14000);
                events.ScheduleEvent(EVENT_ROTFACE_OOZE_FLOOD, 8000);
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_ROTFACE_VILE_GAS, urand(15000, 20000));

                me->setActive(true);
                Talk(SAY_AGGRO);
                DoZoneInCombat();

                if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PROFESSOR_PUTRICIDE)))
                    professor->AI()->DoAction(ACTION_ROTFACE_COMBAT);

                instance->SetData(DATA_OOZE_DANCE_ACHIEVEMENT, uint32(true)); // reset

                // randomize ooze flood
                _oozeFloodStage = urand(0,3);
                std::list<Creature*> list;
                GetCreatureListWithEntryInGrid(list, me, NPC_PUDDLE_STALKER, 60.0f);
                list.remove_if(RotfaceHeightCheck()); // remove from the list all on the ground
                for (std::list<Creature*>::const_iterator itr = list.begin(); itr != list.end(); ++itr)
                {
                    uint32 index = me->GetHomePosition().GetAngle(*itr)/(M_PI/2.0f);
                    if (index>3) index = 3;
                    if (_oozeFloodDummyGUIDs[index][0])
                        _oozeFloodDummyGUIDs[index][1] = (*itr)->GetGUID();
                    else
                        _oozeFloodDummyGUIDs[index][0] = (*itr)->GetGUID();
                }
            }

            void JustDied(Unit* /*killer*/)
            {
                instance->DoRemoveAurasDueToSpellOnPlayers(MUTATED_INFECTION);
                _JustDied();
                Talk(SAY_DEATH);
                if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PROFESSOR_PUTRICIDE)))
                    professor->AI()->DoAction(ACTION_ROTFACE_DEATH);
            }

            void JustReachedHome()
            {
                _JustReachedHome();
                instance->SetBossState(DATA_ROTFACE, FAIL);
            }

            void JustSummoned(Creature* summon)
            {
                if (me->IsAlive() && me->IsInCombat() && !me->IsInEvadeMode())
                    summons.Summon(summon);
                else
                    summon->DespawnOrUnsummon(1);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_KILL);
            }

            void EnterEvadeMode()
            {
                me->SetControlled(false, UNIT_STATE_ROOT);
                me->DisableRotate(false);
                ScriptedAI::EnterEvadeMode();
                if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PROFESSOR_PUTRICIDE)))
                    professor->AI()->EnterEvadeMode();
            }

            void SpellHitTarget(Unit* target, SpellInfo const* spell)
            {
                switch (spell->Id)
                {
                    case SPELL_SLIME_SPRAY:
                        Talk(SAY_SLIME_SPRAY);
                        break;
                    case 69507: // Slime Spray damage
                    case 71213:
                    case 73189:
                    case 73190:
                        if (Player* p = target->ToPlayer())
                            if (p->GetQuestStatus(QUEST_RESIDUE_RENDEZVOUS_10) == QUEST_STATUS_INCOMPLETE || p->GetQuestStatus(QUEST_RESIDUE_RENDEZVOUS_25) == QUEST_STATUS_INCOMPLETE)
                                p->CastSpell(p, SPELL_GREEN_BLIGHT_RESIDUE, true);
                        break;
                    case 69782:
                    case 69796:
                    case 69798:
                    case 69801:
                        {
                            uint32 index = getOozeFloodSpellIndex(spell->Id);
                            if (target->GetGUID() == _oozeFloodDummyGUIDs[index][0] || target->GetGUID() == _oozeFloodDummyGUIDs[index][1])
                                target->CastSpell((Unit*)NULL, spell->Effects[0].CalcValue(), false);
                        }
                        break;
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() || !CheckInRoom())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_UNROOT:
                        me->SetControlled(false, UNIT_STATE_ROOT);
                        me->DisableRotate(false);
                        break;
                    case EVENT_SLIME_SPRAY:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, NonTankTargetSelector(me)))
                        {
                            if (Creature* c = me->SummonCreature(NPC_OOZE_SPRAY_STALKER, *target, TEMPSUMMON_TIMED_DESPAWN, 8000))
                            {
                                me->SetOrientation(me->GetAngle(c));
                                me->SetControlled(true, UNIT_STATE_ROOT);
                                me->DisableRotate(true);
                                me->SetFacingTo(me->GetAngle(c));
                                me->SendMovementFlagUpdate();
                                Talk(EMOTE_SLIME_SPRAY);
                                me->CastSpell(c, SPELL_SLIME_SPRAY, false);
                            }
                        }
                        events.DelayEvents(1);
                        events.ScheduleEvent(EVENT_SLIME_SPRAY, 20000);
                        events.ScheduleEvent(EVENT_UNROOT, 0);
                        break;
                    case EVENT_HASTEN_INFECTIONS:
                        if (infectionCooldown >= 8000)
                        {
                            infectionCooldown -= 2000;
                            events.ScheduleEvent(EVENT_HASTEN_INFECTIONS, 90000);
                        }
                        break;
                    case EVENT_MUTATED_INFECTION:
                        me->CastCustomSpell(SPELL_MUTATED_INFECTION, SPELLVALUE_MAX_TARGETS, 1, NULL, false);
                        events.ScheduleEvent(EVENT_MUTATED_INFECTION, infectionCooldown);
                        break;
                    case EVENT_ROTFACE_OOZE_FLOOD:
                        if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PROFESSOR_PUTRICIDE)))
                        {
                            professor->AI()->Talk(SAY_ROTFACE_OOZE_FLOOD);
                            me->CastSpell((Unit*)NULL, oozeFloodSpells[_oozeFloodStage], true);
                            if (++_oozeFloodStage == 4)
                                _oozeFloodStage = 0;
                        }
                        events.ScheduleEvent(EVENT_ROTFACE_OOZE_FLOOD, 25000);
                        break;
                    case EVENT_ROTFACE_VILE_GAS:
                        {
                            std::list<Unit*> targets;
                            uint32 minTargets = RAID_MODE<uint32>(3, 8, 3, 8);
                            SelectTargetList(targets, minTargets, SELECT_TARGET_RANDOM, -5.0f, true);
                            float minDist = 0.0f;
                            if (targets.size() >= minTargets)
                                minDist = -5.0f;

                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, minDist, true))
                                if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PROFESSOR_PUTRICIDE)))
                                    professor->CastSpell(target, SPELL_VILE_GAS_H, true); // triggered, to skip LoS check
                        }
                        events.ScheduleEvent(EVENT_ROTFACE_VILE_GAS, urand(15000, 20000));
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_rotfaceAI>(creature);
        }
};

class npc_little_ooze : public CreatureScript
{
    public:
        npc_little_ooze() : CreatureScript("npc_little_ooze") { }

        struct npc_little_oozeAI : public ScriptedAI
        {
            npc_little_oozeAI(Creature* creature) : ScriptedAI(creature), instance(creature->GetInstanceScript())
            {
                firstUpdate = true;
                if (Creature* rotface = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_ROTFACE)))
                    rotface->AI()->JustSummoned(me);
            }

            bool firstUpdate;
            EventMap events;
            InstanceScript* instance;

            void IsSummonedBy(Unit* summoner)
            {
                if (!summoner)
                    return;

                me->AddThreat(summoner, 500000.0f);
                AttackStart(summoner);
            }

            void JustDied(Unit* /*killer*/)
            {
                if (Creature* rotface = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_ROTFACE)))
                    rotface->AI()->SummonedCreatureDespawn(me);
                me->DespawnOrUnsummon(0);
            }

            void UpdateAI(uint32 diff)
            {
                if (firstUpdate)
                {
                    firstUpdate = false;
                    me->CastSpell(me, SPELL_LITTLE_OOZE_COMBINE, true);
                    me->CastSpell(me, SPELL_WEAK_RADIATING_OOZE, true);
                    events.Reset();
                    events.ScheduleEvent(EVENT_STICKY_OOZE, 5000);
                    DoResetThreat();
                    me->SetInCombatWithZone();
                    if (TempSummon* ts = me->ToTempSummon())
                        if (Unit* summoner = ts->GetSummoner())
                        {
                            me->AddThreat(summoner, 500000.0f);
                            AttackStart(summoner);
                        }
                }

                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (events.ExecuteEvent() == EVENT_STICKY_OOZE)
                {
                    me->CastSpell(me->GetVictim(), SPELL_STICKY_OOZE, false);
                    events.ScheduleEvent(EVENT_STICKY_OOZE, 15000);
                }

                DoMeleeAttackIfReady();
            }

            void EnterEvadeMode()
            {
                me->SetInCombatWithZone();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_little_oozeAI>(creature);
        }
};

class npc_big_ooze : public CreatureScript
{
    public:
        npc_big_ooze() : CreatureScript("npc_big_ooze") { }

        struct npc_big_oozeAI : public ScriptedAI
        {
            npc_big_oozeAI(Creature* creature) : ScriptedAI(creature), instance(creature->GetInstanceScript())
            {
                firstUpdate = true;
                if (Creature* rotface = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_ROTFACE)))
                    rotface->AI()->JustSummoned(me);
            }

            bool firstUpdate;
            EventMap events;
            InstanceScript* instance;

            void IsSummonedBy(Unit* /*summoner*/)
            {
                if (Player* p = me->SelectNearestPlayer(100.0f))
                    AttackStart(p);
            }

            void JustDied(Unit* /*killer*/)
            {
                if (Creature* rotface = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_ROTFACE)))
                    rotface->AI()->SummonedCreatureDespawn(me);
                me->DespawnOrUnsummon();
            }

            void DoAction(int32 action)
            {
                if (action == EVENT_STICKY_OOZE)
                    events.CancelEvent(EVENT_STICKY_OOZE);
            }

            void UpdateAI(uint32 diff)
            {
                if (firstUpdate)
                {
                    firstUpdate = false;
                    me->CastSpell(me, SPELL_LARGE_OOZE_COMBINE, true);
                    me->CastSpell(me, SPELL_LARGE_OOZE_BUFF_COMBINE, true);
                    me->CastSpell(me, SPELL_RADIATING_OOZE, true);
                    me->CastSpell(me, SPELL_UNSTABLE_OOZE, true);
                    me->CastSpell(me, SPELL_GREEN_ABOMINATION_HITTIN__YA_PROC, true);
                    events.Reset();
                    events.ScheduleEvent(EVENT_STICKY_OOZE, 5000);
                    DoResetThreat();
                    me->SetInCombatWithZone();
                    if (Player* p = me->SelectNearestPlayer(100.0f))
                        AttackStart(p);
                }

                if (!UpdateVictim())
                    return;

                events.Update(diff);

                switch (events.ExecuteEvent())
                {
                    case EVENT_STICKY_OOZE:
                        me->CastSpell(me->GetVictim(), SPELL_STICKY_OOZE, false);
                        events.ScheduleEvent(EVENT_STICKY_OOZE, 15000);
                    default:
                        break;
                }

                if (me->IsVisible())
                    DoMeleeAttackIfReady();
            }

            void EnterEvadeMode()
            {
                me->SetInCombatWithZone();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_big_oozeAI>(creature);
        }
};

class spell_rotface_mutated_infection : public SpellScriptLoader
{
    public:
        spell_rotface_mutated_infection() : SpellScriptLoader("spell_rotface_mutated_infection") { }

        class spell_rotface_mutated_infection_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_rotface_mutated_infection_SpellScript);

            bool Load()
            {
                _target = nullptr;
                return true;
            }

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                // remove targets with this aura already
                // tank is not on this list
                targets.remove_if(acore::UnitAuraCheck(true, GetSpellInfo()->Id));
                targets.remove(GetCaster()->GetVictim());
                if (targets.empty())
                    return;

                WorldObject* target = acore::Containers::SelectRandomContainerElement(targets);
                targets.clear();
                targets.push_back(target);
                _target = target;
            }

            void ReplaceTargets(std::list<WorldObject*>& targets)
            {
                targets.clear();
                if (_target)
                    targets.push_back(_target);
            }

            void NotifyTargets()
            {
                if (Creature* caster = GetCaster()->ToCreature())
                    if (Unit* target = GetHitUnit())
                        caster->AI()->Talk(EMOTE_MUTATED_INFECTION, target);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_rotface_mutated_infection_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_rotface_mutated_infection_SpellScript::ReplaceTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_rotface_mutated_infection_SpellScript::ReplaceTargets, EFFECT_2, TARGET_UNIT_SRC_AREA_ENEMY);
                AfterHit += SpellHitFn(spell_rotface_mutated_infection_SpellScript::NotifyTargets);
            }

            WorldObject* _target;
        };

        class spell_rotface_mutated_infection_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_rotface_mutated_infection_AuraScript);

            void ExtraRemoveEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetTarget()->CastSpell(GetTarget(), GetSpellInfo()->Effects[2].CalcValue(), true);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_rotface_mutated_infection_AuraScript::ExtraRemoveEffect, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_rotface_mutated_infection_SpellScript();
        }

        AuraScript* GetAuraScript() const
        {
            return new spell_rotface_mutated_infection_AuraScript();
        }
};

class spell_rotface_little_ooze_combine : public SpellScriptLoader
{
    public:
        spell_rotface_little_ooze_combine() : SpellScriptLoader("spell_rotface_little_ooze_combine") { }

        class spell_rotface_little_ooze_combine_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_rotface_little_ooze_combine_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                // little targetting little

                if (!GetHitCreature() || !GetHitCreature()->IsAlive())
                    return;

                GetCaster()->RemoveAurasDueToSpell(SPELL_LITTLE_OOZE_COMBINE);
                GetHitCreature()->RemoveAurasDueToSpell(SPELL_LITTLE_OOZE_COMBINE);
                GetHitCreature()->CastSpell(GetCaster(), SPELL_OOZE_MERGE, true);
                GetHitCreature()->DespawnOrUnsummon();
                if (GetCaster()->ToCreature())
                    GetCaster()->ToCreature()->DespawnOrUnsummon();
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_rotface_little_ooze_combine_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_rotface_little_ooze_combine_SpellScript();
        }
};

class spell_rotface_large_ooze_combine : public SpellScriptLoader
{
    public:
        spell_rotface_large_ooze_combine() : SpellScriptLoader("spell_rotface_large_ooze_combine") { }

        class spell_rotface_large_ooze_combine_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_rotface_large_ooze_combine_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                // large targetting large

                if (!GetHitCreature() || !GetHitCreature()->IsAlive())
                    return;

                uint8 casterStack = 1;
                uint8 targetStack = 1;
                Aura* casterAura = GetCaster()->GetAura(SPELL_UNSTABLE_OOZE);
                if (casterAura)
                    casterStack = casterAura->GetStackAmount();
                Aura* targetAura = GetHitCreature()->GetAura(SPELL_UNSTABLE_OOZE);
                if (targetAura)
                    targetStack = targetAura->GetStackAmount();
                uint8 newStack = casterStack+targetStack;
                if (newStack > 5)
                    newStack = 5;
                if (casterAura)
                    casterAura->SetStackAmount(newStack);
                else
                {
                    GetCaster()->CastSpell(GetCaster(), SPELL_UNSTABLE_OOZE, true);
                    if (Aura* aur = GetCaster()->GetAura(SPELL_UNSTABLE_OOZE))
                        aur->SetStackAmount(newStack);
                }

                // red color!
                if (newStack >= 4)
                    GetCaster()->CastSpell(GetCaster(), 69844, true);

                // explode!
                if (newStack >= 5)
                {
                    GetCaster()->RemoveAurasDueToSpell(SPELL_LARGE_OOZE_BUFF_COMBINE);
                    GetCaster()->RemoveAurasDueToSpell(SPELL_LARGE_OOZE_COMBINE);
                    if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                        if (Creature* rotface = ObjectAccessor::GetCreature(*GetCaster(), instance->GetData64(DATA_ROTFACE)))
                            if (rotface->IsAlive())
                            {
                                if (GetCaster()->GetTypeId() == TYPEID_UNIT)
                                    GetCaster()->ToCreature()->AI()->Talk(EMOTE_UNSTABLE_EXPLOSION);
                                rotface->AI()->Talk(SAY_UNSTABLE_EXPLOSION);
                            }

                    if (Creature* cre = GetCaster()->ToCreature())
                        cre->AI()->DoAction(EVENT_STICKY_OOZE);
                    GetCaster()->CastSpell(GetCaster(), SPELL_UNSTABLE_OOZE_EXPLOSION, false, nullptr, nullptr, GetCaster()->GetGUID());
                    if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                        instance->SetData(DATA_OOZE_DANCE_ACHIEVEMENT, uint32(false));
                }

                GetHitCreature()->RemoveAurasDueToSpell(SPELL_LARGE_OOZE_BUFF_COMBINE);
                GetHitCreature()->RemoveAurasDueToSpell(SPELL_LARGE_OOZE_COMBINE);
                GetHitCreature()->DespawnOrUnsummon();
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_rotface_large_ooze_combine_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_rotface_large_ooze_combine_SpellScript();
        }
};

class spell_rotface_large_ooze_buff_combine : public SpellScriptLoader
{
    public:
        spell_rotface_large_ooze_buff_combine() : SpellScriptLoader("spell_rotface_large_ooze_buff_combine") { }

        class spell_rotface_large_ooze_buff_combine_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_rotface_large_ooze_buff_combine_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                // large targetting little

                if (!GetHitCreature() || !GetHitCreature()->IsAlive())
                    return;

                if (Aura* unstable = GetCaster()->GetAura(SPELL_UNSTABLE_OOZE))
                {
                    uint8 newStack = uint8(unstable->GetStackAmount()+1);
                    unstable->SetStackAmount(newStack);

                    // red color!
                    if (newStack >= 4)
                        GetCaster()->CastSpell(GetCaster(), 69844, true);

                    // explode!
                    if (newStack >= 5)
                    {
                        GetCaster()->RemoveAurasDueToSpell(SPELL_LARGE_OOZE_BUFF_COMBINE);
                        GetCaster()->RemoveAurasDueToSpell(SPELL_LARGE_OOZE_COMBINE);
                        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                            if (Creature* rotface = ObjectAccessor::GetCreature(*GetCaster(), instance->GetData64(DATA_ROTFACE)))
                                if (rotface->IsAlive())
                                {
                                    if (GetCaster()->GetTypeId() == TYPEID_UNIT)
                                        GetCaster()->ToCreature()->AI()->Talk(EMOTE_UNSTABLE_EXPLOSION);
                                    rotface->AI()->Talk(SAY_UNSTABLE_EXPLOSION);
                                }

                        if (Creature* cre = GetCaster()->ToCreature())
                            cre->AI()->DoAction(EVENT_STICKY_OOZE);
                        GetCaster()->CastSpell(GetCaster(), SPELL_UNSTABLE_OOZE_EXPLOSION, false, nullptr, nullptr, GetCaster()->GetGUID());
                        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                            instance->SetData(DATA_OOZE_DANCE_ACHIEVEMENT, uint32(false));
                    }
                }

                GetHitCreature()->RemoveAurasDueToSpell(SPELL_LITTLE_OOZE_COMBINE);
                GetHitCreature()->DespawnOrUnsummon();
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_rotface_large_ooze_buff_combine_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_rotface_large_ooze_buff_combine_SpellScript();
        }
};

class spell_rotface_unstable_ooze_explosion_init : public SpellScriptLoader
{
    public:
        spell_rotface_unstable_ooze_explosion_init() : SpellScriptLoader("spell_rotface_unstable_ooze_explosion_init") { }

        class spell_rotface_unstable_ooze_explosion_init_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_rotface_unstable_ooze_explosion_init_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_UNSTABLE_OOZE_EXPLOSION_TRIGGER))
                    return false;
                return true;
            }

            void HandleCast(SpellEffIndex effIndex)
            {
                PreventHitEffect(effIndex);
                if (!GetHitUnit())
                    return;

                float x, y, z;
                GetHitUnit()->GetPosition(x, y, z);
                Creature* dummy = GetCaster()->SummonCreature(NPC_UNSTABLE_EXPLOSION_STALKER, x, y, z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000);
                GetCaster()->CastSpell(dummy, SPELL_UNSTABLE_OOZE_EXPLOSION_TRIGGER, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_rotface_unstable_ooze_explosion_init_SpellScript::HandleCast, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_rotface_unstable_ooze_explosion_init_SpellScript();
        }
};

class spell_rotface_unstable_ooze_explosion : public SpellScriptLoader
{
    public:
        spell_rotface_unstable_ooze_explosion() : SpellScriptLoader("spell_rotface_unstable_ooze_explosion") { }

        class spell_rotface_unstable_ooze_explosion_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_rotface_unstable_ooze_explosion_SpellScript);

            void CheckTarget(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(EFFECT_0);
                if (!GetExplTargetDest())
                    return;

                uint32 triggered_spell_id = GetSpellInfo()->Effects[effIndex].TriggerSpell;

                float x, y, z;
                GetExplTargetDest()->GetPosition(x, y, z);
                // let Rotface handle the cast - caster dies before this executes
                if (InstanceScript* script = GetCaster()->GetInstanceScript())
                    if (Creature* rotface = script->instance->GetCreature(script->GetData64(DATA_ROTFACE)))
                        rotface->CastSpell(x, y, z, triggered_spell_id, true/*, nullptr, nullptr, GetCaster()->GetGUID()*/); // caster not available on clientside, no log in such case
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_rotface_unstable_ooze_explosion_SpellScript::CheckTarget, EFFECT_0, SPELL_EFFECT_TRIGGER_MISSILE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_rotface_unstable_ooze_explosion_SpellScript();
        }
};

class spell_rotface_unstable_ooze_explosion_suicide : public SpellScriptLoader
{
    public:
        spell_rotface_unstable_ooze_explosion_suicide() : SpellScriptLoader("spell_rotface_unstable_ooze_explosion_suicide") { }

        class spell_rotface_unstable_ooze_explosion_suicide_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_rotface_unstable_ooze_explosion_suicide_AuraScript);

            void DespawnSelf(AuraEffect const* /*aurEff*/)
            {
                PreventDefaultAction();
                Unit* target = GetTarget();
                if (target->GetTypeId() != TYPEID_UNIT)
                    return;

                target->SetVisible(false);
                target->RemoveAllAuras();
                //target->ToCreature()->DespawnOrUnsummon();
                target->ToCreature()->DespawnOrUnsummon(60000);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_rotface_unstable_ooze_explosion_suicide_AuraScript::DespawnSelf, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_rotface_unstable_ooze_explosion_suicide_AuraScript();
        }
};


class npc_precious_icc : public CreatureScript
{
    public:
        npc_precious_icc() : CreatureScript("npc_precious_icc") { }

        struct npc_precious_iccAI : public ScriptedAI
        {
            npc_precious_iccAI(Creature* creature) : ScriptedAI(creature), summons(me){}

            void Reset()
            {
                events.Reset();
                summons.DespawnAll();
            }

            void EnterCombat(Unit* /*target*/)
            {
                me->setActive(true);
                events.ScheduleEvent(EVENT_DECIMATE, urand(20000, 25000));
                events.ScheduleEvent(EVENT_MORTAL_WOUND, urand(1500, 2500));
                events.ScheduleEvent(EVENT_SUMMON_ZOMBIES, urand(25000, 30000));
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    summon->AI()->AttackStart(target);
            }

            void SummonedCreatureDespawn(Creature* summon)
            {
                summons.Despawn(summon);
            }

            void JustDied(Unit* /*killer*/)
            {
                summons.DespawnAll();
                if (InstanceScript* _instance = me->GetInstanceScript())
                    if (Creature* rotface = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_ROTFACE)))
                        if (rotface->IsAlive())
                            rotface->AI()->Talk(SAY_PRECIOUS_DIES);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_DECIMATE:
                            me->CastSpell(me->GetVictim(), SPELL_DECIMATE, false);
                            events.ScheduleEvent(EVENT_DECIMATE, urand(20000, 25000));
                            break;
                        case EVENT_MORTAL_WOUND:
                            me->CastSpell(me->GetVictim(), SPELL_MORTAL_WOUND, false);
                            events.ScheduleEvent(EVENT_MORTAL_WOUND, urand(1500, 2500));
                            break;
                        case EVENT_SUMMON_ZOMBIES:
                            Talk(EMOTE_PRECIOUS_ZOMBIES);
                            for (uint32 i = 0; i < 11; ++i)
                                me->CastSpell(me, SPELL_AWAKEN_PLAGUED_ZOMBIES, true);
                            events.ScheduleEvent(EVENT_SUMMON_ZOMBIES, urand(20000, 25000));
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap events;
            SummonList summons;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_precious_iccAI>(creature);
        }
};

void AddSC_boss_rotface()
{
    new boss_rotface();
    new npc_little_ooze();
    new npc_big_ooze();
    new spell_rotface_mutated_infection();
    new spell_rotface_little_ooze_combine();
    new spell_rotface_large_ooze_combine();
    new spell_rotface_large_ooze_buff_combine();
    new spell_rotface_unstable_ooze_explosion_init();
    new spell_rotface_unstable_ooze_explosion();
    new spell_rotface_unstable_ooze_explosion_suicide();

    new npc_precious_icc();
}