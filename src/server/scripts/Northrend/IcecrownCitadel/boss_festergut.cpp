/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "icecrown_citadel.h"

enum ScriptTexts
{
    SAY_STINKY_DEAD             = 0,
    SAY_AGGRO                   = 1,
    EMOTE_GAS_SPORE             = 2,
    EMOTE_WARN_GAS_SPORE        = 3,
    SAY_PUNGENT_BLIGHT          = 4,
    EMOTE_WARN_PUNGENT_BLIGHT   = 5,
    EMOTE_PUNGENT_BLIGHT        = 6,
    SAY_KILL                    = 7,
    SAY_BERSERK                 = 8,
    SAY_DEATH                   = 9,
};

enum Spells
{
    // Festergut
    SPELL_INHALE_BLIGHT         = 69165,
    SPELL_PUNGENT_BLIGHT        = 69195,
    SPELL_GASTRIC_BLOAT         = 72219, // 72214 is the proper way (with proc) but atm procs can't have cooldown for creatures
    SPELL_GASTRIC_EXPLOSION     = 72227,
    SPELL_GAS_SPORE             = 69278,
    SPELL_VILE_GAS              = 69240,
    SPELL_INOCULATED            = 69291,
    SPELL_MALLABLE_GOO_H        = 72296,

    // Stinky
    SPELL_MORTAL_WOUND          = 71127,
    SPELL_DECIMATE              = 71123,
    SPELL_PLAGUE_STENCH         = 71805,
};

// Used for HasAura checks
#define PUNGENT_BLIGHT_HELPER RAID_MODE<uint32>(69195, 71219, 73031, 73032)
#define INOCULATED_HELPER     RAID_MODE<uint32>(69291, 72101, 72102, 72103)

uint32 const gaseousBlight[3]        = {69157, 69162, 69164};
uint32 const gaseousBlightVisual[3]  = {69126, 69152, 69154};

#define DATA_INOCULATED_STACK 69291

enum Events
{
    // Festergut
    EVENT_NONE,
    EVENT_BERSERK,
    EVENT_INHALE_BLIGHT,
    EVENT_VILE_GAS,
    EVENT_GAS_SPORE,
    EVENT_GASTRIC_BLOAT,
    EVENT_FESTERGUT_GOO,

    // Stinky
    EVENT_DECIMATE,
    EVENT_MORTAL_WOUND,
};

class boss_festergut : public CreatureScript
{
    public:
        boss_festergut() : CreatureScript("boss_festergut") { }

        struct boss_festergutAI : public BossAI
        {
            boss_festergutAI(Creature* creature) : BossAI(creature, DATA_FESTERGUT)
            {
                _gasDummyGUID = 0;
            }

            uint64 _gasDummyGUID;
            uint32 _maxInoculatedStack;
            uint32 _inhaleCounter;

            void Reset()
            {
                _maxInoculatedStack = 0;
                _inhaleCounter = 0;
                _Reset();
                events.Reset();
                if (Creature* gasDummy = me->FindNearestCreature(NPC_GAS_DUMMY, 100.0f, true))
                {
                    _gasDummyGUID = gasDummy->GetGUID();
                    for (uint8 i=0; i<3; ++i)
                        gasDummy->RemoveAurasDueToSpell(gaseousBlightVisual[i]);
                }
            }

            void EnterCombat(Unit* who)
            {
                if (!instance->CheckRequiredBosses(DATA_FESTERGUT, who->ToPlayer()))
                {
                    EnterEvadeMode();
                    instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                    return;
                }

                events.ScheduleEvent(EVENT_BERSERK, 300000);
                events.ScheduleEvent(EVENT_INHALE_BLIGHT, urand(25000, 30000));
                events.ScheduleEvent(EVENT_GAS_SPORE, urand(20000, 25000));
                events.ScheduleEvent(EVENT_VILE_GAS, urand(30000, 40000), 1);
                events.ScheduleEvent(EVENT_GASTRIC_BLOAT, urand(12500, 15000));
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_FESTERGUT_GOO, urand(15000, 20000));

                me->setActive(true);
                Talk(SAY_AGGRO);
                DoZoneInCombat();

                if (Creature* gasDummy = me->FindNearestCreature(NPC_GAS_DUMMY, 100.0f, true))
                    _gasDummyGUID = gasDummy->GetGUID();
                if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PROFESSOR_PUTRICIDE)))
                    professor->AI()->DoAction(ACTION_FESTERGUT_COMBAT);
            }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
                Talk(SAY_DEATH);
                if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PROFESSOR_PUTRICIDE)))
                    professor->AI()->DoAction(ACTION_FESTERGUT_DEATH);

                RemoveBlight();
            }

            void JustReachedHome()
            {
                _JustReachedHome();
                instance->SetBossState(DATA_FESTERGUT, FAIL);
            }

            void EnterEvadeMode()
            {
                ScriptedAI::EnterEvadeMode();
                if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PROFESSOR_PUTRICIDE)))
                    professor->AI()->EnterEvadeMode();
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_KILL);
            }

            void SpellHitTarget(Unit* target, SpellInfo const* spell)
            {
                if (spell->Id == PUNGENT_BLIGHT_HELPER)
                    target->RemoveAurasDueToSpell(INOCULATED_HELPER);
                else if (Player* p = target->ToPlayer())
                {
                    // Gaseous Blight damage
                    if (((spell->Id == 69159 || spell->Id == 70136 || spell->Id == 69161 || spell->Id == 70139 || spell->Id == 69163 || spell->Id == 70469) && p->GetQuestStatus(QUEST_RESIDUE_RENDEZVOUS_10) == QUEST_STATUS_INCOMPLETE) ||
                        ((spell->Id == 70135 || spell->Id == 70138 || spell->Id == 70468 || spell->Id == 70137 || spell->Id == 70140 || spell->Id == 70470) && p->GetQuestStatus(QUEST_RESIDUE_RENDEZVOUS_25) == QUEST_STATUS_INCOMPLETE))
                        p->CastSpell(p, SPELL_ORANGE_BLIGHT_RESIDUE, true);
                }
            }

            void RemoveBlight()
            {
                if (Creature* gasDummy = ObjectAccessor::GetCreature(*me, _gasDummyGUID))
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        me->RemoveAurasDueToSpell(gaseousBlight[i]);
                        gasDummy->RemoveAurasDueToSpell(gaseousBlightVisual[i]);
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
                    case EVENT_BERSERK:
                        me->CastSpell(me, SPELL_BERSERK2, true);
                        Talk(SAY_BERSERK);
                        break;
                    case EVENT_INHALE_BLIGHT:
                        RemoveBlight();
                        if (_inhaleCounter == 3)
                        {
                            Talk(EMOTE_WARN_PUNGENT_BLIGHT);
                            Talk(SAY_PUNGENT_BLIGHT);
                            me->CastSpell(me, SPELL_PUNGENT_BLIGHT, false);
                            _inhaleCounter = 0;
                            events.RescheduleEvent(EVENT_GAS_SPORE, urand(20000, 25000));
                        }
                        else
                        {
                            me->CastSpell(me, SPELL_INHALE_BLIGHT, false);
                            // just cast and dont bother with target, conditions will handle it
                            ++_inhaleCounter;
                            if (_inhaleCounter < 3)
                                me->CastSpell(me, gaseousBlight[_inhaleCounter], true, nullptr, nullptr, me->GetGUID());
                        }

                        events.ScheduleEvent(EVENT_INHALE_BLIGHT, 34000);
                        break;
                    case EVENT_GAS_SPORE:
                        Talk(EMOTE_WARN_GAS_SPORE);
                        Talk(EMOTE_GAS_SPORE);
                        me->CastCustomSpell(SPELL_GAS_SPORE, SPELLVALUE_MAX_TARGETS, RAID_MODE<int32>(2, 3, 2, 3), me);
                        events.ScheduleEvent(EVENT_GAS_SPORE, urand(40000, 45000));
                        events.DelayEventsToMax(20000, 1); // delay EVENT_VILE_GAS
                        break;
                    case EVENT_VILE_GAS:
                    {
                        std::list<Unit*> targets;
                        uint32 minTargets = RAID_MODE<uint32>(3, 8, 3, 8);
                        SelectTargetList(targets, minTargets, SELECT_TARGET_RANDOM, -5.0f, true);
                        float minDist = 0.0f;
                        if (targets.size() >= minTargets)
                            minDist = -5.0f;

                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, minDist, true))
                            me->CastSpell(target, SPELL_VILE_GAS, false);
                        events.ScheduleEvent(EVENT_VILE_GAS, urand(28000, 35000), 1);
                        break;
                    }
                    case EVENT_GASTRIC_BLOAT:
                        me->CastSpell(me->GetVictim(), SPELL_GASTRIC_BLOAT, false);
                        events.ScheduleEvent(EVENT_GASTRIC_BLOAT, urand(15000, 17500));
                        break;
                    case EVENT_FESTERGUT_GOO:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, NonTankTargetSelector(me)))
                            if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_PROFESSOR_PUTRICIDE)))
                                professor->CastSpell(target, SPELL_MALLABLE_GOO_H, true);
                        events.ScheduleEvent(EVENT_FESTERGUT_GOO, urand(15000, 20000));
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

            void SetData(uint32 type, uint32 data)
            {
                if (type == DATA_INOCULATED_STACK && data > _maxInoculatedStack)
                    _maxInoculatedStack = data;
            }

            uint32 GetData(uint32 type) const
            {
                if (type == DATA_INOCULATED_STACK)
                    return _maxInoculatedStack;

                return 0;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_festergutAI>(creature);
        }
};

class spell_festergut_pungent_blight : public SpellScriptLoader
{
    public:
        spell_festergut_pungent_blight() : SpellScriptLoader("spell_festergut_pungent_blight") { }

        class spell_festergut_pungent_blight_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_festergut_pungent_blight_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (caster->GetTypeId() != TYPEID_UNIT)
                    return;

                // Get Inhaled Blight id for our difficulty
                uint32 blightId = sSpellMgr->GetSpellIdForDifficulty(uint32(GetEffectValue()), caster);

                // ...and remove it
                caster->RemoveAurasDueToSpell(blightId);
                caster->ToCreature()->AI()->Talk(EMOTE_PUNGENT_BLIGHT);

                if (InstanceScript* inst = caster->GetInstanceScript())
                    if (Creature* professor = ObjectAccessor::GetCreature(*caster, inst->GetData64(DATA_PROFESSOR_PUTRICIDE)))
                        professor->AI()->DoAction(ACTION_FESTERGUT_GAS);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_festergut_pungent_blight_SpellScript::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_festergut_pungent_blight_SpellScript();
        }
};

class spell_festergut_blighted_spores : public SpellScriptLoader
{
    public:
        spell_festergut_blighted_spores() : SpellScriptLoader("spell_festergut_blighted_spores") { }

        class spell_festergut_blighted_spores_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_festergut_blighted_spores_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_INOCULATED))
                    return false;
                return true;
            }

            void ExtraEffect(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (Aura* a = aurEff->GetBase())
                    if (a->GetDuration() > a->GetMaxDuration()-1000) // this does not stack for different casters and previous is removed by new DoT, prevent it from giving inoculation in such case
                        return;
                uint32 inoculatedId = sSpellMgr->GetSpellIdForDifficulty(SPELL_INOCULATED, GetTarget());
                uint8 inoculatedStack = 1;
                if (Aura* a = GetTarget()->GetAura(inoculatedId))
                {
                    inoculatedStack += a->GetStackAmount();
                    if (a->GetDuration() > a->GetMaxDuration()-10000) // player may gain only one stack at a time, no matter how many spores explode near him
                        return;
                }
                GetTarget()->CastSpell(GetTarget(), SPELL_INOCULATED, true);
                if (InstanceScript* instance = GetTarget()->GetInstanceScript())
                    if (Creature* festergut = ObjectAccessor::GetCreature(*GetTarget(), instance->GetData64(DATA_FESTERGUT)))
                        festergut->AI()->SetData(DATA_INOCULATED_STACK, inoculatedStack);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_festergut_blighted_spores_AuraScript::ExtraEffect, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_festergut_blighted_spores_AuraScript();
        }
};

class spell_festergut_gastric_bloat : public SpellScriptLoader
{
    public:
        spell_festergut_gastric_bloat() : SpellScriptLoader("spell_festergut_gastric_bloat") { }

        class spell_festergut_gastric_bloat_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_festergut_gastric_bloat_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_GASTRIC_EXPLOSION))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                Aura const* aura = GetHitUnit()->GetAura(GetSpellInfo()->Id);
                if (!(aura && aura->GetStackAmount() == 10))
                    return;

                GetHitUnit()->RemoveAurasDueToSpell(GetSpellInfo()->Id);
                GetHitUnit()->CastSpell(GetHitUnit(), SPELL_GASTRIC_EXPLOSION, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_festergut_gastric_bloat_SpellScript::HandleScript, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_festergut_gastric_bloat_SpellScript();
        }
};

class achievement_flu_shot_shortage : public AchievementCriteriaScript
{
    public:
        achievement_flu_shot_shortage() : AchievementCriteriaScript("achievement_flu_shot_shortage") { }

        bool OnCheck(Player* /*source*/, Unit* target)
        {
            if (target && target->GetTypeId() == TYPEID_UNIT)
                return target->ToCreature()->AI()->GetData(DATA_INOCULATED_STACK) < 3;

            return false;
        }
};

class npc_stinky_icc : public CreatureScript
{
    public:
        npc_stinky_icc() : CreatureScript("npc_stinky_icc") { }

        struct npc_stinky_iccAI : public ScriptedAI
        {
            npc_stinky_iccAI(Creature* creature) : ScriptedAI(creature) {}

            void Reset()
            {
                events.Reset();
            }

            void EnterCombat(Unit* /*target*/)
            {
                me->setActive(true);
                me->CastSpell(me, SPELL_PLAGUE_STENCH, true);
                events.ScheduleEvent(EVENT_DECIMATE, urand(20000, 25000));
                events.ScheduleEvent(EVENT_MORTAL_WOUND, urand(1500, 2500));
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (uint32 eventId = events.ExecuteEvent())
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
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

            void JustDied(Unit* /*killer*/)
            {
                if (InstanceScript* _instance = me->GetInstanceScript())
                    if (Creature* festergut = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_FESTERGUT)))
                        if (festergut->IsAlive())
                            festergut->AI()->Talk(SAY_STINKY_DEAD);
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_stinky_iccAI>(creature);
        }
};

void AddSC_boss_festergut()
{
    new boss_festergut();
    new spell_festergut_pungent_blight();
    new spell_festergut_blighted_spores();
    new spell_festergut_gastric_bloat();
    new achievement_flu_shot_shortage();

    new npc_stinky_icc();
}