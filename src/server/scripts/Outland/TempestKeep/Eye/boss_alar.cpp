/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_eye.h"
#include "WaypointManager.h"
#include "MoveSplineInit.h"

enum Spells
{
    SPELL_BERSERK                   = 45078,
    SPELL_FLAME_QUILLS              = 34229,
    SPELL_QUILL_MISSILE_1           = 34269, // 21
    SPELL_QUILL_MISSILE_2           = 34314, // 3
    SPELL_FLAME_BUFFET              = 34121,
    SPELL_EMBER_BLAST               = 34341,
    SPELL_REBIRTH_PHASE2            = 34342,
    SPELL_MELT_ARMOR                = 35410,
    SPELL_CHARGE                    = 35412,
    SPELL_REBIRTH_DIVE              = 35369,
    SPELL_DIVE_BOMB_VISUAL          = 35367,
    SPELL_DIVE_BOMB                 = 35181
};

const Position alarPoints[7] =
{
    {340.15f, 58.65f, 17.71f, 4.60f},
    {388.09f, 31.54f, 20.18f, 1.61f},
    {388.18f, -32.85f, 20.18f, 0.52f},
    {340.29f, -60.19f, 17.72f, 5.71f},
    {332.0f, 0.01f, 43.0f, 0.0f},
    {331.0f, 0.01f, -2.38f, 0.0f},
    {332.0f, 0.01f, 43.0f, 0.0f}
};

enum Misc
{
    DISPLAYID_INVISIBLE         = 23377,
    NPC_EMBER_OF_ALAR           = 19551,
    NPC_FLAME_PATCH             = 20602,
    
    POINT_PLATFORM              = 0,
    POINT_QUILL                 = 4,
    POINT_MIDDLE                = 5,
    POINT_DIVE                  = 6,

    EVENT_SWITCH_PLATFORM       = 1,
    EVENT_START_QUILLS          = 2,
    EVENT_RELOCATE_MIDDLE       = 3,
    EVENT_REBIRTH               = 4,
    EVENT_SPELL_MELT_ARMOR      = 5,
    EVENT_SPELL_FLAME_PATCH     = 6,
    EVENT_SPELL_CHARGE          = 7,
    EVENT_SPELL_DIVE_BOMB       = 8,
    EVENT_START_DIVE            = 9,
    EVENT_CAST_DIVE_BOMB        = 10,
    EVENT_SUMMON_DIVE_PHOENIX   = 11,
    EVENT_REBIRTH_DIVE          = 12,
    EVENT_SPELL_BERSERK         = 13,

    EVENT_MOVE_TO_PHASE_2       = 20,
    EVENT_FINISH_DIVE           = 21

};

// Xinef: Ruse of the Ashtongue (10946)
enum qruseoftheAshtongue
{
    SPELL_ASHTONGUE_RUSE        = 42090,
    QUEST_RUSE_OF_THE_ASHTONGUE = 10946,
};

class boss_alar : public CreatureScript
{
    public:
        boss_alar() : CreatureScript("boss_alar") { }

        struct boss_alarAI : public BossAI
        {
            boss_alarAI(Creature* creature) : BossAI(creature, DATA_ALAR)
            {
                startPath = true;
                SetCombatMovement(false);
            }

            uint8 platform;
            uint8 noQuillTimes;
            bool startPath;

            void JustReachedHome()
            {
                BossAI::JustReachedHome();
                startPath = true;
            }

            void Reset()
            {
                BossAI::Reset();
                platform = 0;
                noQuillTimes = 0;
                me->SetModelVisible(true);
                me->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_FIRE, true);
                me->SetReactState(REACT_AGGRESSIVE);
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                events.ScheduleEvent(EVENT_SWITCH_PLATFORM, 0);
            }

            void JustDied(Unit* killer)
            {
                me->SetModelVisible(true);
                BossAI::JustDied(killer);

                // Xinef: Ruse of the Ashtongue (10946)
                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                {
                    Player* player = itr->GetSource();
                    if (player->GetQuestStatus(QUEST_RUSE_OF_THE_ASHTONGUE) == QUEST_STATUS_INCOMPLETE)
                        if (player->HasAura(SPELL_ASHTONGUE_RUSE))
                            player->AreaExploredOrEventHappens(QUEST_RUSE_OF_THE_ASHTONGUE);
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (summon->GetEntry() == NPC_EMBER_OF_ALAR)    
                    summon->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_FIRE, true);
            }

            void MoveInLineOfSight(Unit* /*who*/) { }

            void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (damage >= me->GetHealth() && platform < POINT_MIDDLE)
                {
                    damage = 0;
                    if (events.GetNextEventTime(EVENT_REBIRTH) == 0)
                    {
                        me->InterruptNonMeleeSpells(false);
                        me->SetHealth(me->GetMaxHealth());
                        me->SetReactState(REACT_PASSIVE);
                        me->CastSpell(me, SPELL_EMBER_BLAST, true);

                        me->setAttackTimer(BASE_ATTACK, 16000);
                        events.Reset();
                        events.ScheduleEvent(EVENT_RELOCATE_MIDDLE, 8000);
                        events.ScheduleEvent(EVENT_MOVE_TO_PHASE_2, 12000);
                        events.ScheduleEvent(EVENT_REBIRTH, 16001);
                    }
                }
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE)
                {
                    if (type == ESCORT_MOTION_TYPE && me->movespline->Finalized() && !me->IsInCombat())
                        startPath = true;
                    return;
                }

                if (id == POINT_PLATFORM)
                    me->setAttackTimer(BASE_ATTACK, 1000);
                else if (id == POINT_QUILL)
                    events.ScheduleEvent(EVENT_START_QUILLS, 1000);
                else if (id == POINT_DIVE)
                {
                    events.ScheduleEvent(EVENT_START_DIVE, 1000);
                    events.ScheduleEvent(EVENT_CAST_DIVE_BOMB, 5000);
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (startPath)
                {
                    me->StopMoving();
                    startPath = false;
                    if (WaypointPath const* i_path = sWaypointMgr->GetPath(me->GetWaypointPath()))
                    {
                        Movement::PointsArray pathPoints;
                        pathPoints.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                        for (uint8 i = 0; i < i_path->size(); ++i)
                        {
                            WaypointData const* node = i_path->at(i);
                            pathPoints.push_back(G3D::Vector3(node->x, node->y, node->z));
                        }
                        me->GetMotionMaster()->MoveSplinePath(&pathPoints);
                    }
                }

                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SWITCH_PLATFORM:
                        if (roll_chance_i(20*noQuillTimes))
                        {
                            noQuillTimes = 0;
                            platform = RAND(0, 3);
                            me->GetMotionMaster()->MovePoint(POINT_QUILL, alarPoints[POINT_QUILL], false, true);
                            events.ScheduleEvent(EVENT_SWITCH_PLATFORM, 16000);
                        }
                        else
                        {
                            if (noQuillTimes++ > 0)
                            {
                                me->SetOrientation(alarPoints[platform].GetOrientation());
                                me->SummonCreature(NPC_EMBER_OF_ALAR, *me, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 6000);
                            }
                            me->GetMotionMaster()->MovePoint(POINT_PLATFORM, alarPoints[platform], false, true);
                            platform = (platform+1)%4;
                            events.ScheduleEvent(EVENT_SWITCH_PLATFORM, 30000);
                        }
                        me->setAttackTimer(BASE_ATTACK, 20000);
                        break;
                    case EVENT_START_QUILLS:
                        me->CastSpell(me, SPELL_FLAME_QUILLS, false);
                        break;
                    case EVENT_RELOCATE_MIDDLE:
                        me->SetPosition(alarPoints[POINT_MIDDLE]);
                        break;
                    case EVENT_MOVE_TO_PHASE_2:
                        me->RemoveAurasDueToSpell(SPELL_EMBER_BLAST);
                        me->CastSpell(me, SPELL_REBIRTH_PHASE2, false);
                        break;
                    case EVENT_REBIRTH:
                        me->SetReactState(REACT_AGGRESSIVE);
                        platform = POINT_MIDDLE;
                        me->GetMotionMaster()->MoveChase(me->GetVictim());

                        events.ScheduleEvent(EVENT_SPELL_MELT_ARMOR, 67000);
                        events.ScheduleEvent(EVENT_SPELL_CHARGE, 10000);
                        events.ScheduleEvent(EVENT_SPELL_FLAME_PATCH, 20000);
                        events.ScheduleEvent(EVENT_SPELL_DIVE_BOMB, 30000);
                        break;
                    case EVENT_SPELL_MELT_ARMOR:
                        me->CastSpell(me->GetVictim(), SPELL_MELT_ARMOR, false);
                        events.ScheduleEvent(EVENT_SPELL_MELT_ARMOR, 60000);
                        break;
                    case EVENT_SPELL_CHARGE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                            me->CastSpell(target, SPELL_CHARGE, false);
                        events.ScheduleEvent(EVENT_SPELL_CHARGE, 30000);
                        break;
                    case EVENT_SPELL_FLAME_PATCH:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                            me->SummonCreature(NPC_FLAME_PATCH, *target, TEMPSUMMON_TIMED_DESPAWN, 2*MINUTE*IN_MILLISECONDS);
                        events.ScheduleEvent(EVENT_SPELL_FLAME_PATCH, 30000);
                        break;
                    case EVENT_SPELL_DIVE_BOMB:
                        me->GetMotionMaster()->MovePoint(POINT_DIVE, alarPoints[POINT_DIVE], false, true);
                        events.ScheduleEvent(EVENT_SPELL_DIVE_BOMB, 30000);
                        events.DelayEvents(15000);
                        me->setAttackTimer(BASE_ATTACK, 20000);
                        break;
                    case EVENT_START_DIVE:
                        me->CastSpell(me, SPELL_DIVE_BOMB_VISUAL, false);
                        break;
                    case EVENT_CAST_DIVE_BOMB:
                        events.ScheduleEvent(EVENT_SUMMON_DIVE_PHOENIX, 2000);
                        events.ScheduleEvent(EVENT_REBIRTH_DIVE, 6000);
                        events.ScheduleEvent(EVENT_FINISH_DIVE, 10000);
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 90.0f, true))
                        {
                            me->CastSpell(target, SPELL_DIVE_BOMB, false);
                            me->SetPosition(*target);
                            me->StopMovingOnCurrentPos();
                        }

                        me->RemoveAurasDueToSpell(SPELL_DIVE_BOMB_VISUAL);
                        break;
                    case EVENT_SUMMON_DIVE_PHOENIX:
                    {
                        Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 10.0f, true);
                        me->SummonCreature(NPC_EMBER_OF_ALAR, target ? *target : *me, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 6000);
                        me->SummonCreature(NPC_EMBER_OF_ALAR, target ? *target : *me, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 6000);
                        break;
                    }
                    case EVENT_REBIRTH_DIVE:
                        me->SetModelVisible(true);
                        me->CastSpell(me, SPELL_REBIRTH_DIVE, false);
                        break;
                    case EVENT_FINISH_DIVE:
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                        break;
                    case EVENT_SPELL_BERSERK:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        break;
                }

                if (me->isAttackReady())
                {
                    if (me->IsWithinMeleeRange(me->GetVictim()))
                    {
                        me->AttackerStateUpdate(me->GetVictim());
                        me->resetAttackTimer();
                    }
                    else
                    {
                        me->resetAttackTimer();
                        ThreatContainer::StorageType const &threatList = me->getThreatManager().getThreatList();
                        for (ThreatContainer::StorageType::const_iterator itr = threatList.begin(); itr != threatList.end(); ++itr)
                            if (Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
                                if (me->IsWithinMeleeRange(unit))
                                {
                                    me->AttackerStateUpdate(unit);
                                    return;
                                }

                        me->CastSpell(me, SPELL_FLAME_BUFFET, false);
                    }
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_alarAI>(creature);
        }
};

class CastQuill : public BasicEvent
{
    public:
        CastQuill(Unit* caster, uint32 spellId) : _caster(caster), _spellId(spellId)
        {
        }

        bool Execute(uint64 /*execTime*/, uint32 /*diff*/)
        {
            _caster->CastSpell(_caster, _spellId, true);
            return true;
        }

    private:
        Unit* _caster;
        uint32 _spellId;
};

class spell_alar_flame_quills : public SpellScriptLoader
{
    public:
        spell_alar_flame_quills() : SpellScriptLoader("spell_alar_flame_quills") { }

        class spell_alar_flame_quills_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_alar_flame_quills_AuraScript);

            void HandlePeriodic(AuraEffect const*  /*aurEff*/)
            {
                PreventDefaultAction();

                // 24 spells in total
                for (uint8 i = 0; i < 21; ++i)
                    GetUnitOwner()->m_Events.AddEvent(new CastQuill(GetUnitOwner(), SPELL_QUILL_MISSILE_1+i), GetUnitOwner()->m_Events.CalculateTime(i*40));
                GetUnitOwner()->m_Events.AddEvent(new CastQuill(GetUnitOwner(), SPELL_QUILL_MISSILE_2+0), GetUnitOwner()->m_Events.CalculateTime(22*40));
                GetUnitOwner()->m_Events.AddEvent(new CastQuill(GetUnitOwner(), SPELL_QUILL_MISSILE_2+1), GetUnitOwner()->m_Events.CalculateTime(23*40));
                GetUnitOwner()->m_Events.AddEvent(new CastQuill(GetUnitOwner(), SPELL_QUILL_MISSILE_2+2), GetUnitOwner()->m_Events.CalculateTime(24*40));
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_alar_flame_quills_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_alar_flame_quills_AuraScript();
        }
};

class spell_alar_ember_blast : public SpellScriptLoader
{
    public:
        spell_alar_ember_blast() : SpellScriptLoader("spell_alar_ember_blast") { }

        class spell_alar_ember_blast_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_alar_ember_blast_SpellScript);

            void HandleForceCast(SpellEffIndex effIndex)
            {
                PreventHitEffect(effIndex);
                if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                    if (Creature* alar = ObjectAccessor::GetCreature(*GetCaster(), instance->GetData64(NPC_ALAR)))
                        Unit::DealDamage(GetCaster(), alar, alar->CountPctFromMaxHealth(2));
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_alar_ember_blast_SpellScript::HandleForceCast, EFFECT_2, SPELL_EFFECT_FORCE_CAST);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_alar_ember_blast_SpellScript();
        }
};

class spell_alar_ember_blast_death : public SpellScriptLoader
{
    public:
        spell_alar_ember_blast_death() : SpellScriptLoader("spell_alar_ember_blast_death") { }

        class spell_alar_ember_blast_death_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_alar_ember_blast_death_AuraScript);

            void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                PreventDefaultAction(); // xinef: prevent default action after change that invisibility in instances is executed instantly even for creatures
                Unit* target = GetTarget();
                InvisibilityType type = InvisibilityType(aurEff->GetMiscValue());
                target->m_invisibility.AddFlag(type);
                target->m_invisibility.AddValue(type, aurEff->GetAmount());

                GetUnitOwner()->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                GetUnitOwner()->SetStandState(UNIT_STAND_STATE_DEAD);
                GetUnitOwner()->m_last_notify_position.Relocate(0.0f, 0.0f, 0.0f);
                GetUnitOwner()->m_delayed_unit_relocation_timer = 1000;
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                GetUnitOwner()->SetStandState(UNIT_STAND_STATE_STAND);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_alar_ember_blast_death_AuraScript::OnApply, EFFECT_2, SPELL_AURA_MOD_INVISIBILITY, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_alar_ember_blast_death_AuraScript::OnRemove, EFFECT_2, SPELL_AURA_MOD_INVISIBILITY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_alar_ember_blast_death_AuraScript();
        }
};

class spell_alar_dive_bomb : public SpellScriptLoader
{
    public:
        spell_alar_dive_bomb() : SpellScriptLoader("spell_alar_dive_bomb") { }

        class spell_alar_dive_bomb_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_alar_dive_bomb_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->SetModelVisible(false);
                GetUnitOwner()->SetDisplayId(DISPLAYID_INVISIBLE);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_alar_dive_bomb_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_alar_dive_bomb_AuraScript();
        }
};

void AddSC_boss_alar()
{
    new boss_alar();
    new spell_alar_flame_quills();
    new spell_alar_ember_blast();
    new spell_alar_ember_blast_death();
    new spell_alar_dive_bomb();
}
