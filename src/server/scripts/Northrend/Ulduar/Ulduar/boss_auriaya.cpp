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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

enum AuriayaSpells
{
    // BASIC
    SPELL_TERRIFYING_SCREECH            = 64386,
    SPELL_SENTINEL_BLAST_10             = 64389,
    SPELL_SENTINEL_BLAST_25             = 64678,
    SPELL_SONIC_SCREECH_10              = 64422,
    SPELL_SONIC_SCREECH_25              = 64688,
    SPELL_GUARDIAN_SWARM                = 64396,
    SPELL_ENRAGE                        = 47008,
    SPELL_ACTIVATE_FERAL_DEFENDER       = 64449,

    // Sanctum Sentry
    SPELL_SAVAGE_POUNCE_10              = 64666,
    SPELL_SAVAGE_POUNCE_25              = 64374,
    SPELL_RIP_FLESH_10                  = 64375,
    SPELL_RIP_FLESH_25                  = 64667,
    SPELL_STRENGTH_OF_THE_PACK          = 64369,

    // Feral Defender
    SPELL_FERAL_ESSENCE                 = 64455,
    SPELL_FERAL_POUNCE_10               = 64478,
    SPELL_FERAL_POUNCE_25               = 64669,
    SPELL_FERAL_RUSH_10                 = 64496,
    SPELL_FERAL_RUSH_25                 = 64674,
    //SPELL_SEEPING_FERAL_ESSENCE_SUMMON    = 64457,
    SPELL_SEEPING_FERAL_ESSENCE_10      = 64458,
    SPELL_SEEPING_FERAL_ESSENCE_25      = 64676,
};

#define SPELL_SONIC_SCREECH             RAID_MODE(SPELL_SONIC_SCREECH_10, SPELL_SONIC_SCREECH_25)
#define SPELL_SENTINEL_BLAST            RAID_MODE(SPELL_SENTINEL_BLAST_10, SPELL_SENTINEL_BLAST_25)
#define SPELL_SAVAGE_POUNCE             RAID_MODE(SPELL_SAVAGE_POUNCE_10, SPELL_SAVAGE_POUNCE_25)
#define SPELL_RIP_FLESH                 RAID_MODE(SPELL_RIP_FLESH_10, SPELL_RIP_FLESH_25)
#define SPELL_FERAL_POUNCE              RAID_MODE(SPELL_FERAL_POUNCE_10, SPELL_FERAL_POUNCE_25)
#define SPELL_FERAL_RUSH                RAID_MODE(SPELL_FERAL_RUSH_10, SPELL_FERAL_RUSH_25)
//#define SPELL_SEEPING_FERAL_ESSENCE     RAID_MODE(SPELL_SEEPING_FERAL_ESSENCE_10, SPELL_SEEPING_FERAL_ESSENCE_25)

enum AuriayaNPC
{
    NPC_FERAL_DEFENDER                  = 34035,
    NPC_SANCTUM_SENTRY                  = 34014,
    NPC_SEEPING_FERAL_ESSENCE           = 34098,
};

enum AuriayaEvents
{
    EVENT_SUMMON_FERAL_DEFENDER         = 1,
    EVENT_TERRIFYING_SCREECH            = 2,
    EVENT_SONIC_SCREECH                 = 3,
    EVENT_GUARDIAN_SWARM                = 4,
    EVENT_SENTINEL_BLAST                = 5,
    EVENT_REMOVE_IMMUNE                 = 6,

    EVENT_RESPAWN_FERAL_DEFENDER        = 9,
    EVENT_ENRAGE                        = 10,
};

enum Texts
{
    SAY_AGGRO       = 0,
    SAY_SLAY        = 1,
    SAY_BERSERK     = 2,
    EMOTE_DEATH     = 3,
    EMOTE_FEAR      = 4,
    EMOTE_DEFFENDER = 5,
};

enum Misc
{
    ACTION_FERAL_RESPAWN                = 1,
    ACTION_FERAL_DEATH                  = 2,
    ACTION_DESPAWN_ADDS                 = 3,
    ACTION_FERAL_DEATH_WITH_STACK       = 4,

    DATA_CRAZY_CAT                      = 10,
    DATA_NINE_LIVES                     = 11,
};

class boss_auriaya : public CreatureScript
{
public:
    boss_auriaya() : CreatureScript("boss_auriaya") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_auriayaAI>(pCreature);
    }

    struct boss_auriayaAI : public ScriptedAI
    {
        boss_auriayaAI(Creature* pCreature) : ScriptedAI(pCreature), summons(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;

        bool _feralDied;
        bool _nineLives;

        void Reset() override
        {
            _feralDied = false;
            _nineLives = false;

            events.Reset();
            EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
            summons.DoAction(ACTION_DESPAWN_ADDS, pred);
            summons.DespawnAll();

            if (m_pInstance)
                m_pInstance->SetData(TYPE_AURIAYA, NOT_STARTED);

            for (uint8 i = 0; i < RAID_MODE(2, 4); ++i)
                me->SummonCreature(NPC_SANCTUM_SENTRY, me->GetPositionX() + urand(4, 12), me->GetPositionY() + urand(4, 12), me->GetPositionZ());

            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
        }

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_CRAZY_CAT)
                return !_feralDied;
            else if (param == DATA_NINE_LIVES)
                return _nineLives;

            return 0;
        }

        void JustSummoned(Creature* cr) override
        {
            if (cr->GetEntry() == NPC_SANCTUM_SENTRY)
                cr->GetMotionMaster()->MoveFollow(me, 6, rand_norm() * 2 * 3.14f);
            else
                cr->SetInCombatWithZone();

            summons.Summon(cr);
        }

        void SummonedCreatureDies(Creature* cr, Unit*) override
        {
            if (cr->GetEntry() == NPC_SANCTUM_SENTRY)
                _feralDied = true;
        }

        void JustReachedHome() override { me->setActive(false); }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            if (m_pInstance)
                m_pInstance->SetData(TYPE_AURIAYA, IN_PROGRESS);

            events.ScheduleEvent(EVENT_TERRIFYING_SCREECH, 35s);
            events.ScheduleEvent(EVENT_SONIC_SCREECH, 45s);
            events.ScheduleEvent(EVENT_GUARDIAN_SWARM, 70s);
            events.ScheduleEvent(EVENT_SUMMON_FERAL_DEFENDER, 60s);
            events.ScheduleEvent(EVENT_SENTINEL_BLAST, 36s);
            events.ScheduleEvent(EVENT_ENRAGE, 10min);

            summons.DoZoneInCombat(NPC_SANCTUM_SENTRY);

            Talk(SAY_AGGRO);
            me->setActive(true);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() != TYPEID_PLAYER || urand(0, 2))
                return;

            Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (m_pInstance)
                m_pInstance->SetData(TYPE_AURIAYA, DONE);

            EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
            summons.DoAction(ACTION_DESPAWN_ADDS, pred);
            summons.DespawnAll();
            Talk(EMOTE_DEATH);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_FERAL_DEATH_WITH_STACK)
                events.ScheduleEvent(EVENT_RESPAWN_FERAL_DEFENDER, 25s);
            else if (param == ACTION_FERAL_DEATH)
                _nineLives = true;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SUMMON_FERAL_DEFENDER:
                    Talk(EMOTE_DEFFENDER);
                    me->CastSpell(me, SPELL_ACTIVATE_FERAL_DEFENDER, true);
                    me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
                    events.ScheduleEvent(EVENT_REMOVE_IMMUNE, 3s);
                    break;
                case EVENT_REMOVE_IMMUNE:
                    me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
                    break;
                case EVENT_TERRIFYING_SCREECH:
                    Talk(EMOTE_FEAR);
                    me->CastSpell(me, SPELL_TERRIFYING_SCREECH, false);
                    events.Repeat(35s);
                    break;
                case EVENT_SONIC_SCREECH:
                    me->CastSpell(me, SPELL_SONIC_SCREECH, false);
                    events.Repeat(50s);
                    break;
                case EVENT_GUARDIAN_SWARM:
                    me->CastSpell(me->GetVictim(), SPELL_GUARDIAN_SWARM, false);
                    events.Repeat(40s);
                    break;
                case EVENT_SENTINEL_BLAST:
                    me->CastSpell(me, SPELL_SENTINEL_BLAST, false);
                    events.Repeat(35s);
                    events.DelayEvents(5000, 0);
                    break;
                case EVENT_RESPAWN_FERAL_DEFENDER:
                    {
                        EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
                        summons.DoAction(ACTION_FERAL_RESPAWN, pred);
                        break;
                    }
                case EVENT_ENRAGE:
                    Talk(SAY_BERSERK);
                    me->CastSpell(me, SPELL_ENRAGE, true);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_auriaya_sanctum_sentry : public CreatureScript
{
public:
    npc_auriaya_sanctum_sentry() : CreatureScript("npc_auriaya_sanctum_sentry") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_auriaya_sanctum_sentryAI>(pCreature);
    }

    struct npc_auriaya_sanctum_sentryAI : public ScriptedAI
    {
        npc_auriaya_sanctum_sentryAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        uint32 _savagePounceTimer;
        uint32 _ripFleshTimer;

        void JustEngagedWith(Unit*) override
        {
            if (me->GetInstanceScript())
                if (Creature* cr = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_AURIAYA)))
                    cr->SetInCombatWithZone();
        }

        void Reset() override
        {
            _savagePounceTimer = 5000;
            _ripFleshTimer = 0;

            me->CastSpell(me, SPELL_STRENGTH_OF_THE_PACK, true);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _savagePounceTimer += diff;
            _ripFleshTimer += diff;

            if (_savagePounceTimer >= 5000)
            {
                float dist = me->GetDistance(me->GetVictim());
                if (dist >= 8 && dist < 25 && me->IsWithinLOSInMap(me->GetVictim()))
                {
                    me->CastSpell(me->GetVictim(), SPELL_SAVAGE_POUNCE, false);
                    _savagePounceTimer = 0;
                    return;
                }
                _savagePounceTimer = 200;
            }
            else if (_ripFleshTimer >= 10000)
            {
                me->CastSpell(me->GetVictim(), SPELL_RIP_FLESH, false);
                _ripFleshTimer = 0;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_auriaya_feral_defender : public CreatureScript
{
public:
    npc_auriaya_feral_defender() : CreatureScript("npc_auriaya_feral_defender") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_auriaya_feral_defenderAI>(pCreature);
    }

    struct npc_auriaya_feral_defenderAI : public ScriptedAI
    {
        npc_auriaya_feral_defenderAI(Creature* pCreature) : ScriptedAI(pCreature), summons(pCreature) { }

        int32 _feralRushTimer;
        int32 _feralPounceTimer;
        uint8 _feralEssenceStack;
        SummonList summons;

        void Reset() override
        {
            summons.DespawnAll();
            _feralRushTimer = 3000;
            _feralPounceTimer = 0;
            _feralEssenceStack = 8;

            if (Aura* aur = me->AddAura(SPELL_FERAL_ESSENCE, me))
                aur->SetStackAmount(_feralEssenceStack);
        }

        void JustDied(Unit*) override
        {
            // inform about our death, start timer
            if (me->GetInstanceScript())
                if (Creature* cr = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_AURIAYA)))
                    cr->AI()->DoAction(_feralEssenceStack ? ACTION_FERAL_DEATH_WITH_STACK : ACTION_FERAL_DEATH);

            if (_feralEssenceStack)
            {
                if (Creature* cr = me->SummonCreature(NPC_SEEPING_FERAL_ESSENCE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f))
                    summons.Summon(cr);

                --_feralEssenceStack;
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_FERAL_RESPAWN)
            {
                me->setDeathState(DeathState::JustRespawned);

                if (Player* target = SelectTargetFromPlayerList(200))
                    AttackStart(target);
                else
                {
                    summons.DespawnAll();
                    me->DespawnOrUnsummon(1);
                }

                if (_feralEssenceStack)
                    if (Aura* aur = me->AddAura(SPELL_FERAL_ESSENCE, me))
                        aur->SetStackAmount(_feralEssenceStack);
            }
            else if (param == ACTION_DESPAWN_ADDS)
                summons.DespawnAll();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _feralRushTimer += diff;
            _feralPounceTimer += diff;

            if (_feralRushTimer >= 6000)
            {
                DoResetThreatList();
                if (!UpdateVictim())
                    return;

                me->CastSpell(me->GetVictim(), SPELL_FERAL_RUSH, true);
                _feralRushTimer = 0;
            }
            else if (_feralPounceTimer >= 6000)
            {
                me->CastSpell(me->GetVictim(), SPELL_FERAL_POUNCE, false);
                _feralPounceTimer = 0;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_auriaya_sentinel_blast : public SpellScript
{
    PrepareSpellScript(spell_auriaya_sentinel_blast);

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        unitList.remove_if(PlayerOrPetCheck());
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_auriaya_sentinel_blast::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class achievement_auriaya_crazy_cat_lady : public AchievementCriteriaScript
{
public:
    achievement_auriaya_crazy_cat_lady() : AchievementCriteriaScript("achievement_auriaya_crazy_cat_lady") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (target)
            if (InstanceScript* instance = target->GetInstanceScript())
                if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetGuidData(TYPE_AURIAYA)))
                    return cr->AI()->GetData(DATA_CRAZY_CAT);

        return false;
    }
};

class achievement_auriaya_nine_lives : public AchievementCriteriaScript
{
public:
    achievement_auriaya_nine_lives() : AchievementCriteriaScript("achievement_auriaya_nine_lives") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (target)
            if (InstanceScript* instance = target->GetInstanceScript())
                if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetGuidData(TYPE_AURIAYA)))
                    return cr->AI()->GetData(DATA_NINE_LIVES);

        return false;
    }
};

void AddSC_boss_auriaya()
{
    new boss_auriaya();
    new npc_auriaya_sanctum_sentry();
    new npc_auriaya_feral_defender();

    RegisterSpellScript(spell_auriaya_sentinel_blast);

    new achievement_auriaya_crazy_cat_lady();
    new achievement_auriaya_nine_lives();
}
