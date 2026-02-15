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
    // Auriaya
    SPELL_TERRIFYING_SCREECH            = 64386,
    SPELL_SENTINEL_BLAST                = 64389,
    SPELL_SONIC_SCREECH                 = 64422,
    SPELL_GUARDIAN_SWARM                = 64396,
    SPELL_ENRAGE                        = 47008,
    SPELL_ACTIVATE_FERAL_DEFENDER       = 64449,

    // Sanctum Sentry
    SPELL_SAVAGE_POUNCE                 = 64666,
    SPELL_RIP_FLESH                     = 64375,
    SPELL_STRENGTH_OF_THE_PACK          = 64369,

    // Feral Defender
    SPELL_FERAL_ESSENCE                 = 64455,
    SPELL_FERAL_POUNCE                  = 64478,
    SPELL_FERAL_RUSH                    = 64496,
    //SPELL_SEEPING_FERAL_ESSENCE_SUMMON    = 64457,
    SPELL_SEEPING_FERAL_ESSENCE         = 64458,
};

enum AuriayaNPC
{
    NPC_FERAL_DEFENDER                  = 34035,
    NPC_SANCTUM_SENTRY                  = 34014,
    NPC_SEEPING_FERAL_ESSENCE           = 34098,
};

enum AuriayaEvents
{
    // Auriaya
    EVENT_SUMMON_FERAL_DEFENDER         = 1,
    EVENT_TERRIFYING_SCREECH            = 2,
    EVENT_SONIC_SCREECH                 = 3,
    EVENT_GUARDIAN_SWARM                = 4,
    EVENT_SENTINEL_BLAST                = 5,
    EVENT_REMOVE_IMMUNE                 = 6,
    EVENT_RESPAWN_FERAL_DEFENDER        = 7,

    // Sanctum Sentry
    EVENT_SAVAGE_POUNCE                 = 8,
    EVENT_RIP_FLESH                     = 9,

    // Feral Defender
    EVENT_FERAL_RUSH                    = 10,
    EVENT_FERAL_POUNCE                  = 11,
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

struct boss_auriaya : public BossAI
{
    boss_auriaya(Creature* creature) : BossAI(creature, BOSS_AURIAYA) { }

    bool _feralDied{false};
    bool _nineLives{false};

    void Reset() override
    {
        _feralDied = false;
        _nineLives = false;

        EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
        summons.DoAction(ACTION_DESPAWN_ADDS, pred);

        BossAI::Reset();

        for (uint8 i = 0; i < RAID_MODE(2, 4); ++i)
            me->SummonCreature(NPC_SANCTUM_SENTRY, me->GetPositionX() + urand(4, 12), me->GetPositionY() + urand(4, 12), me->GetPositionZ());

        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
    }

    uint32 GetData(uint32 param) const override
    {
        if (param == DATA_CRAZY_CAT)
            return !_feralDied;
        if (param == DATA_NINE_LIVES)
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

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);

        events.ScheduleEvent(EVENT_TERRIFYING_SCREECH, 35s);
        events.ScheduleEvent(EVENT_SONIC_SCREECH, 45s);
        events.ScheduleEvent(EVENT_GUARDIAN_SWARM, 70s);
        events.ScheduleEvent(EVENT_SUMMON_FERAL_DEFENDER, 60s);
        events.ScheduleEvent(EVENT_SENTINEL_BLAST, 36s);

        ScheduleEnrageTimer(SPELL_ENRAGE, 10min, SAY_BERSERK);
    }

    void KilledUnit(Unit* victim) override
    {
        if (!victim->IsPlayer() || urand(0, 2))
            return;

        Talk(SAY_SLAY);
    }

    void JustDied(Unit* killer) override
    {
        EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
        summons.DoAction(ACTION_DESPAWN_ADDS, pred);

        BossAI::JustDied(killer);
        Talk(EMOTE_DEATH);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_FERAL_DEATH_WITH_STACK)
            events.ScheduleEvent(EVENT_RESPAWN_FERAL_DEFENDER, 25s);
        else if (param == ACTION_FERAL_DEATH)
            _nineLives = true;
    }

    void ExecuteEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_SUMMON_FERAL_DEFENDER:
                Talk(EMOTE_DEFFENDER);
                DoCastSelf(SPELL_ACTIVATE_FERAL_DEFENDER, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
                events.ScheduleEvent(EVENT_REMOVE_IMMUNE, 3s);
                break;
            case EVENT_REMOVE_IMMUNE:
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
                break;
            case EVENT_TERRIFYING_SCREECH:
                Talk(EMOTE_FEAR);
                DoCastSelf(SPELL_TERRIFYING_SCREECH);
                events.Repeat(35s);
                break;
            case EVENT_SONIC_SCREECH:
                DoCastSelf(SPELL_SONIC_SCREECH);
                events.Repeat(50s);
                break;
            case EVENT_GUARDIAN_SWARM:
                DoCastVictim(SPELL_GUARDIAN_SWARM);
                events.Repeat(40s);
                break;
            case EVENT_SENTINEL_BLAST:
                DoCastSelf(SPELL_SENTINEL_BLAST);
                events.Repeat(35s);
                events.DelayEvents(5s, 0);
                break;
            case EVENT_RESPAWN_FERAL_DEFENDER:
            {
                EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
                summons.DoAction(ACTION_FERAL_RESPAWN, pred);
                break;
            }
        }
    }
};

struct npc_auriaya_sanctum_sentry : public ScriptedAI
{
    npc_auriaya_sanctum_sentry(Creature* creature) : ScriptedAI(creature) { }

    void JustEngagedWith(Unit*) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            if (Creature* cr = instance->GetCreature(BOSS_AURIAYA))
                cr->SetInCombatWithZone();

        events.ScheduleEvent(EVENT_SAVAGE_POUNCE, 5s);
        events.ScheduleEvent(EVENT_RIP_FLESH, 10s);
    }

    void Reset() override
    {
        events.Reset();
        DoCastSelf(SPELL_STRENGTH_OF_THE_PACK, true);
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
            case EVENT_SAVAGE_POUNCE:
            {
                float dist = me->GetDistance(me->GetVictim());
                if (dist >= 8 && dist < 25 && me->IsWithinLOSInMap(me->GetVictim()))
                {
                    me->CastSpell(me->GetVictim(), SPELL_SAVAGE_POUNCE, false);
                    events.Repeat(5s);
                    break;
                }
                events.Repeat(200ms);
                break;
            }
            case EVENT_RIP_FLESH:
                me->CastSpell(me->GetVictim(), SPELL_RIP_FLESH, false);
                events.Repeat(10s);
                break;
        }

        DoMeleeAttackIfReady();
    }
};

struct npc_auriaya_feral_defender : public ScriptedAI
{
    npc_auriaya_feral_defender(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    uint8 _feralEssenceStack{8};
    SummonList _summons;

    void Reset() override
    {
        events.Reset();
        _summons.DespawnAll();
        _feralEssenceStack = 8;

        if (Aura* aur = me->AddAura(SPELL_FERAL_ESSENCE, me))
            aur->SetStackAmount(_feralEssenceStack);
    }

    void JustEngagedWith(Unit*) override
    {
        events.ScheduleEvent(EVENT_FERAL_RUSH, 3s);
        events.ScheduleEvent(EVENT_FERAL_POUNCE, 6s);
    }

    void JustDied(Unit*) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            if (Creature* cr = instance->GetCreature(BOSS_AURIAYA))
                cr->AI()->DoAction(_feralEssenceStack ? ACTION_FERAL_DEATH_WITH_STACK : ACTION_FERAL_DEATH);

        if (_feralEssenceStack)
        {
            if (Creature* cr = me->SummonCreature(NPC_SEEPING_FERAL_ESSENCE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f))
                _summons.Summon(cr);

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
                _summons.DespawnAll();
                me->DespawnOrUnsummon(1ms);
            }

            if (_feralEssenceStack)
                if (Aura* aur = me->AddAura(SPELL_FERAL_ESSENCE, me))
                    aur->SetStackAmount(_feralEssenceStack);

            events.ScheduleEvent(EVENT_FERAL_RUSH, 3s);
            events.ScheduleEvent(EVENT_FERAL_POUNCE, 6s);
        }
        else if (param == ACTION_DESPAWN_ADDS)
            _summons.DespawnAll();
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
            case EVENT_FERAL_RUSH:
                DoResetThreatList();
                if (!UpdateVictim())
                    return;
                DoCastVictim(SPELL_FERAL_RUSH, true);
                events.Repeat(6s);
                break;
            case EVENT_FERAL_POUNCE:
                DoCastVictim(SPELL_FERAL_POUNCE);
                events.Repeat(6s);
                break;
        }

        DoMeleeAttackIfReady();
    }
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

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (target)
            if (InstanceScript* instance = target->GetInstanceScript())
                if (Creature* auriaya = instance->GetCreature(BOSS_AURIAYA))
                    return auriaya->AI()->GetData(DATA_CRAZY_CAT);

        return false;
    }
};

class achievement_auriaya_nine_lives : public AchievementCriteriaScript
{
public:
    achievement_auriaya_nine_lives() : AchievementCriteriaScript("achievement_auriaya_nine_lives") {}

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (target)
            if (InstanceScript* instance = target->GetInstanceScript())
                if (Creature* cr = instance->GetCreature(BOSS_AURIAYA))
                    return cr->AI()->GetData(DATA_NINE_LIVES);

        return false;
    }
};

void AddSC_boss_auriaya()
{
    RegisterUlduarCreatureAI(boss_auriaya);
    RegisterUlduarCreatureAI(npc_auriaya_sanctum_sentry);
    RegisterUlduarCreatureAI(npc_auriaya_feral_defender);

    RegisterSpellScript(spell_auriaya_sentinel_blast);

    new achievement_auriaya_crazy_cat_lady();
    new achievement_auriaya_nine_lives();
}
