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
#include "ScriptedCreature.h"
#include "magisters_terrace.h"

enum Yells
{
    SAY_AGGRO         = 0,
    SAY_HELPER_DIED   = 1,
    SAY_PLAYER_KILLED = 5,
    SAY_DEATH         = 10,
};

enum Spells
{
    SPELL_MEDALION_OF_IMMUNITY = 46227,
    SPELL_DISPEL_MAGIC         = 27609,
    SPELL_FLASH_HEAL           = 17843,
    SPELL_SHADOW_WORD_PAIN_N   = 14032,
    SPELL_SHADOW_WORD_PAIN_H   = 15654,
    SPELL_POWER_WORD_SHIELD_N  = 44291,
    SPELL_POWER_WORD_SHIELD_H  = 46193,
    SPELL_RENEW_N              = 44174,
    SPELL_RENEW_H              = 46192,
};

enum Misc
{
    MAX_ACTIVE_HELPERS = 4,
    MAX_HELPERS_COUNT  = 8
};

const Position helpersLocations[MAX_ACTIVE_HELPERS] =
{
    {123.77f, 17.6007f, -19.921f, 4.98f},
    {131.731f, 15.0827f, -19.921f, 4.98f},
    {121.563f, 15.6213f, -19.921f, 4.98f},
    {129.988f, 17.2355f, -19.921f, 4.98f},
};

const uint32 helpersEntries[MAX_HELPERS_COUNT] =
{
    24557,                                                  //Kagani Nightstrike
    24558,                                                  //Elris Duskhallow
    24554,                                                  //Eramas Brightblaze
    24561,                                                  //Yazzaj
    24559,                                                  //Warlord Salaris
    24555,                                                  //Garaxxas
    24553,                                                  //Apoko
    24556,                                                  //Zelfan
};

enum Events
{
    EVENT_SPELL_FLASH_HEAL = 1,
    EVENT_SPELL_RENEW      = 2,
    EVENT_SPELL_PW_SHIELD  = 3,
    EVENT_SPELL_SW_PAIN    = 4,
    EVENT_SPELL_DISPEL     = 5,
    EVENT_CHECK_DIST       = 6,
    EVENT_SPELL_IMMUNITY   = 7,
};

struct boss_priestess_delrissa : public ScriptedAI
{
    boss_priestess_delrissa(Creature* creature) : ScriptedAI(creature), summons(me)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;
    EventMap events;
    SummonList summons;

    uint8 PlayersKilled;
    uint8 HelpersKilled;

    void Reset() override
    {
        PlayersKilled = SAY_PLAYER_KILLED;
        HelpersKilled = SAY_HELPER_DIED;
        instance->SetBossState(DATA_DELRISSA, NOT_STARTED);
        summons.Respawn();

        me->SetLootMode(0);
    }

    void InitializeAI() override
    {
        ScriptedAI::InitializeAI();
        std::list<uint32> helpersList;
        for (uint8 i = 0; i < MAX_HELPERS_COUNT; ++i)
            helpersList.push_back(helpersEntries[i]);
        Acore::Containers::RandomResize(helpersList, MAX_ACTIVE_HELPERS);

        uint8 j = 0;
        for (std::list<uint32>::const_iterator itr = helpersList.begin(); itr != helpersList.end(); ++itr, ++j)
            me->SummonCreature(*itr, helpersLocations[j], TEMPSUMMON_MANUAL_DESPAWN, 0);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
    }

    void SummonedCreatureDies(Creature*  /*summon*/, Unit*) override
    {
        if (me->IsAlive() && HelpersKilled < SAY_PLAYER_KILLED)
        {
            if (HelpersKilled == MAX_ACTIVE_HELPERS)
                me->SetLootMode(1);
            Talk(HelpersKilled);
        }
        else if (HelpersKilled == MAX_ACTIVE_HELPERS)
        {
            me->loot.clear();
            me->loot.FillLoot(me->GetCreatureTemplate()->lootid, LootTemplates_Creature, me->GetLootRecipient(), false, false, 1, me);
            instance->SetBossState(DATA_DELRISSA, DONE);
            me->SetDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
        }
        ++HelpersKilled;
    }

    void JustEngagedWith(Unit*  /*who*/) override
    {
        Talk(SAY_AGGRO);
        summons.DoZoneInCombat();
        instance->SetBossState(DATA_DELRISSA, IN_PROGRESS);

        events.ScheduleEvent(EVENT_SPELL_FLASH_HEAL, 15000);
        events.ScheduleEvent(EVENT_SPELL_RENEW, 10000);
        events.ScheduleEvent(EVENT_SPELL_PW_SHIELD, 2000);
        events.ScheduleEvent(EVENT_SPELL_SW_PAIN, 5000);
        events.ScheduleEvent(EVENT_SPELL_DISPEL, 7500);
        events.ScheduleEvent(EVENT_CHECK_DIST, 5000);
        if (IsHeroic())
            events.ScheduleEvent(EVENT_SPELL_IMMUNITY, 4000);
    }

    void KilledUnit(Unit* victim) override
    {
        if (!victim->IsPlayer())
            return;

        if (PlayersKilled < SAY_DEATH)
            Talk(PlayersKilled++);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);

        if (HelpersKilled == MAX_ACTIVE_HELPERS + 1)
            instance->SetBossState(DATA_DELRISSA, DONE);
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
        case EVENT_CHECK_DIST:
            if (me->GetDistance(me->GetHomePosition()) > 75.0f)
            {
                EnterEvadeMode(EVADE_REASON_OTHER);
                return;
            }
            events.ScheduleEvent(EVENT_CHECK_DIST, 5000);
            break;
        case EVENT_SPELL_FLASH_HEAL:
            if (Unit* target = DoSelectLowestHpFriendly(40.0f, 1000))
                me->CastSpell(target, SPELL_FLASH_HEAL, false);
            events.ScheduleEvent(EVENT_SPELL_FLASH_HEAL, 15000);
            break;
        case EVENT_SPELL_RENEW:
            if (Unit* target = DoSelectLowestHpFriendly(40.0f, 1000))
                me->CastSpell(target, DUNGEON_MODE(SPELL_RENEW_N, SPELL_RENEW_H), false);
            events.ScheduleEvent(EVENT_SPELL_RENEW, 7000);
            break;
        case EVENT_SPELL_PW_SHIELD:
        {
            std::list<Creature*> cList = DoFindFriendlyMissingBuff(40.0f, DUNGEON_MODE(SPELL_POWER_WORD_SHIELD_N, SPELL_POWER_WORD_SHIELD_H));
            if (Unit* target = Acore::Containers::SelectRandomContainerElement(cList))
                me->CastSpell(target, DUNGEON_MODE(SPELL_POWER_WORD_SHIELD_N, SPELL_POWER_WORD_SHIELD_H), false);
            events.ScheduleEvent(EVENT_SPELL_PW_SHIELD, 10000);
            break;
        }
        case EVENT_SPELL_DISPEL:
        {
            Unit* target = nullptr;
            switch (urand(0, 2))
            {
            case 0:
                target = SelectTarget(SelectTargetMethod::Random, 0, 30, true);
                break;
            case 1:
                target = me;
                break;
            case 2:
                target = ObjectAccessor::GetCreature(*me, Acore::Containers::SelectRandomContainerElement(summons));
                break;
            }

            if (target)
                me->CastSpell(target, SPELL_DISPEL_MAGIC, false);
            events.ScheduleEvent(EVENT_SPELL_DISPEL, 12000);
            break;
        }
        case EVENT_SPELL_IMMUNITY:
            if (me->HasUnitState(UNIT_STATE_LOST_CONTROL))
            {
                me->CastSpell(me, SPELL_MEDALION_OF_IMMUNITY, false);
                events.ScheduleEvent(EVENT_SPELL_IMMUNITY, 60000);
            }
            else
                events.ScheduleEvent(EVENT_SPELL_IMMUNITY, 1000);
            break;
        case EVENT_SPELL_SW_PAIN:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f))
                me->CastSpell(target, DUNGEON_MODE(SPELL_SHADOW_WORD_PAIN_N, SPELL_SHADOW_WORD_PAIN_H), false);
            events.ScheduleEvent(EVENT_SPELL_SW_PAIN, 10000);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

enum helpersShared
{
    SPELL_HEALING_POTION              = 15503,

    EVENT_SPELL_HELPER_HEALING_POTION = 20,
    EVENT_SPELL_HELPER_IMMUNITY       = 21,
    EVENT_HELPER_RESET_THREAT         = 22,

    AI_TYPE_MELEE                     = 1,
    AI_TYPE_RANGED                    = 2
};

struct boss_priestess_lackey_commonAI : public ScriptedAI
{
    boss_priestess_lackey_commonAI(Creature* creature, uint32 type) : ScriptedAI(creature), summons(me)
    {
        instance = creature->GetInstanceScript();
        aiType = type;
    }

    InstanceScript* instance;
    EventMap events;
    SummonList summons;
    uint32 actualEventId;
    uint8 aiType;

    float GetThreatMod(float dist, float  /*armor*/, uint32 health, uint32 /*maxhealth*/, Unit* target)
    {
        float unimportant_dist = (aiType == AI_TYPE_MELEE ? 5.0f : 25.0f);
        if (dist > unimportant_dist) dist -= unimportant_dist;
        else dist = 0.0f;
        const float dist_factor = (aiType == AI_TYPE_MELEE ? 15.0f : 25.0f);
        float mod_dist = dist_factor / (dist_factor + dist); // 0.2 .. 1.0
        float mod_health = health > 20000 ? 2.0f : (40000 - health) / 10000.0f; // 2.0 .. 4.0
        float mod_armor = aiType == AI_TYPE_MELEE ? Unit::CalcArmorReducedDamage(me, target, 10000, nullptr) / 10000.0f : 1.0f;
        return mod_dist * mod_health * mod_armor;
    }

    void RecalculateThreat()
    {
        ThreatContainer::StorageType const& tList = me->GetThreatMgr().GetThreatList();
        for (ThreatContainer::StorageType::const_iterator itr = tList.begin(); itr != tList.end(); ++itr)
        {
            Unit* pUnit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid());
            if (pUnit && pUnit->IsPlayer() && me->GetThreatMgr().GetThreat(pUnit))
            {
                float threatMod = GetThreatMod(me->GetDistance2d(pUnit), (float)pUnit->GetArmor(), pUnit->GetHealth(), pUnit->GetMaxHealth(), pUnit);
                me->GetThreatMgr().ModifyThreatByPercent(pUnit, -100);
                if (HostileReference* ref = me->GetThreatMgr().GetOnlineContainer().getReferenceByTarget(pUnit))
                    ref->AddThreat(10000000.0f * threatMod);
            }
        }
    }

    void Reset() override
    {
        events.Reset();
        summons.DespawnAll();
        actualEventId = 0;
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (Creature* delrissa = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_DELRISSA)))
            if (!delrissa->IsAlive())
            {
                delrissa->Respawn();
                return;
            }
        ScriptedAI::EnterEvadeMode(why);
    }

    void JustEngagedWith(Unit* who) override
    {
        if (Creature* delrissa = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_DELRISSA)))
            if (delrissa->IsAlive() && !delrissa->IsEngaged())
                delrissa->AI()->AttackStart(who);

        events.ScheduleEvent(EVENT_SPELL_HELPER_HEALING_POTION, 1000);
        events.ScheduleEvent(EVENT_HELPER_RESET_THREAT, urand(8000, 10000));
        if (IsHeroic())
            events.ScheduleEvent(EVENT_SPELL_HELPER_IMMUNITY, 2000, 1);

        RecalculateThreat();
    }

    void JustDied(Unit* /*killer*/) override
    {
        summons.DespawnAll();
    }

    void KilledUnit(Unit* victim) override
    {
        if (Creature* delrissa = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_DELRISSA)))
            delrissa->AI()->KilledUnit(victim);
    }

    void AttackStart(Unit* victim) override
    {
        if (victim && me->Attack(victim, true))
            me->GetMotionMaster()->MoveChase(victim, aiType == AI_TYPE_MELEE ? 0.0f : 20.0f);
    }

    void UpdateAI(uint32 diff) override
    {
        actualEventId = 0;
        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        actualEventId = events.ExecuteEvent();
        switch (actualEventId)
        {
        case EVENT_SPELL_HELPER_IMMUNITY:
            if (me->HasUnitState(UNIT_STATE_LOST_CONTROL))
            {
                me->CastSpell(me, SPELL_MEDALION_OF_IMMUNITY, false);
                events.ScheduleEvent(EVENT_SPELL_HELPER_IMMUNITY, 60000);
            }
            else
                events.ScheduleEvent(EVENT_SPELL_HELPER_IMMUNITY, 1000);
            break;
        case EVENT_SPELL_HELPER_HEALING_POTION:
            if (me->HealthBelowPct(25))
            {
                me->CastSpell(me, SPELL_HEALING_POTION, false);
                break;
            }
            events.ScheduleEvent(EVENT_SPELL_HELPER_HEALING_POTION, 1000);
            break;
        case EVENT_HELPER_RESET_THREAT:
            RecalculateThreat();
            events.ScheduleEvent(EVENT_HELPER_RESET_THREAT, urand(8000, 10000));
            break;
        }
    }
};

enum RogueEnum
{
    SPELL_KIDNEY_SHOT  = 27615,
    SPELL_VANISH       = 44290,
    SPELL_GOUGE        = 12540,
    SPELL_KICK         = 27613,
    SPELL_BACKSTAB_N   = 15657,
    SPELL_BACKSTAB_H   = 15582,
    SPELL_EVISCERATE_N = 27611,
    SPELL_EVISCERATE_H = 46189,

    EVENT_SPELL_GOUGE      = 1,
    EVENT_SPELL_KICK       = 2,
    EVENT_SPELL_VANISH     = 3,
    EVENT_SPELL_EVISCERATE = 4,
    EVENT_SPELL_BACKSTAB   = 5,
};

struct boss_kagani_nightstrike : public boss_priestess_lackey_commonAI
{
    boss_kagani_nightstrike(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_MELEE) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        events.ScheduleEvent(EVENT_SPELL_GOUGE, 5500);
        events.ScheduleEvent(EVENT_SPELL_KICK, 9000);
        events.ScheduleEvent(EVENT_SPELL_VANISH, 200);
        events.ScheduleEvent(EVENT_SPELL_EVISCERATE, 6000);
        events.ScheduleEvent(EVENT_SPELL_BACKSTAB, 4000);
    }

    void MovementInform(uint32 type, uint32  /*point*/) override
    {
        if (type == CHASE_MOTION_TYPE && me->HasAura(SPELL_VANISH) && me->GetVictim())
            me->CastSpell(me->GetVictim(), SPELL_KIDNEY_SHOT, false);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        boss_priestess_lackey_commonAI::UpdateAI(diff);

        switch (actualEventId)
        {
        case EVENT_SPELL_VANISH:
            me->CastSpell(me, SPELL_VANISH, false);
            DoResetThreatList();
            if (Unit* unit = SelectTarget(SelectTargetMethod::Random, 0))
                me->AddThreat(unit, 1000.0f);

            events.ScheduleEvent(EVENT_SPELL_VANISH, 30000);
            break;
        case EVENT_SPELL_GOUGE:
            me->CastSpell(me->GetVictim(), SPELL_GOUGE, false);
            events.ScheduleEvent(EVENT_SPELL_GOUGE, 15000);
            break;
        case EVENT_SPELL_KICK:
            if (me->GetVictim()->HasUnitState(UNIT_STATE_CASTING))
            {
                me->CastSpell(me->GetVictim(), SPELL_KICK, false);
                events.ScheduleEvent(EVENT_SPELL_KICK, 15000);
            }
            else
                events.ScheduleEvent(EVENT_SPELL_KICK, 1000);
            break;
        case EVENT_SPELL_EVISCERATE:
            me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_EVISCERATE_N, SPELL_EVISCERATE_H), false);
            events.ScheduleEvent(EVENT_SPELL_EVISCERATE, 10000);
            break;
        case EVENT_SPELL_BACKSTAB:
            if (!me->GetVictim()->HasInArc(static_cast<float>(M_PI), me))
            {
                me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_BACKSTAB_N, SPELL_BACKSTAB_H), false);
                events.ScheduleEvent(EVENT_SPELL_BACKSTAB, 5000);
            }
            else
                events.ScheduleEvent(EVENT_SPELL_BACKSTAB, 1000);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

enum WarlockEnum
{
    SPELL_IMMOLATE_N         = 44267,
    SPELL_IMMOLATE_H         = 46191,
    SPELL_SHADOW_BOLT_N      = 12471,
    SPELL_SHADOW_BOLT_H      = 15232,
    SPELL_CURSE_OF_AGONY_N   = 14875,
    SPELL_CURSE_OF_AGONY_H   = 46190,
    SPELL_SEED_OF_CORRUPTION = 44141,
    SPELL_FEAR               = 38595,
    SPELL_SUMMON_IMP         = 44163,

    EVENT_SPELL_IMMOLATE           = 1,
    EVENT_SPELL_SHADOW_BOLT        = 2,
    EVENT_SPELL_SEED_OF_CORRUPTION = 3,
    EVENT_SPELL_CURSE_OF_AGONY     = 4,
    EVENT_SPELL_FEAR               = 5,
};

struct boss_ellris_duskhallow : public boss_priestess_lackey_commonAI
{
    boss_ellris_duskhallow(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_RANGED) { }

    void JustEngagedWith(Unit* who) override
    {
        me->CastSpell(me, SPELL_SUMMON_IMP, false);
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        events.ScheduleEvent(EVENT_SPELL_IMMOLATE, 3000);
        events.ScheduleEvent(EVENT_SPELL_SHADOW_BOLT, 1000);
        events.ScheduleEvent(EVENT_SPELL_SEED_OF_CORRUPTION, 10000);
        events.ScheduleEvent(EVENT_SPELL_CURSE_OF_AGONY, 6000);
        events.ScheduleEvent(EVENT_SPELL_FEAR, 15000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        boss_priestess_lackey_commonAI::UpdateAI(diff);

        switch (actualEventId)
        {
        case EVENT_SPELL_IMMOLATE:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f))
                me->CastSpell(target, DUNGEON_MODE(SPELL_IMMOLATE_N, SPELL_IMMOLATE_H), false);
            events.ScheduleEvent(EVENT_SPELL_IMMOLATE, 12000);
            break;
        case EVENT_SPELL_SHADOW_BOLT:
            me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_SHADOW_BOLT_N, SPELL_SHADOW_BOLT_H), false);
            events.ScheduleEvent(EVENT_SPELL_SHADOW_BOLT, 5000);
            break;
        case EVENT_SPELL_SEED_OF_CORRUPTION:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f))
                me->CastSpell(target, SPELL_SEED_OF_CORRUPTION, false);
            events.ScheduleEvent(EVENT_SPELL_SEED_OF_CORRUPTION, 18000);
            break;
        case EVENT_SPELL_CURSE_OF_AGONY:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f))
                me->CastSpell(target, DUNGEON_MODE(SPELL_CURSE_OF_AGONY_N, SPELL_CURSE_OF_AGONY_H), false);
            events.ScheduleEvent(EVENT_SPELL_CURSE_OF_AGONY, 13000);
            break;
        case EVENT_SPELL_FEAR:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 20.0f))
                me->CastSpell(target, SPELL_FEAR, false);
            events.ScheduleEvent(EVENT_SPELL_FEAR, 15000);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

enum MonkEnum
{
    SPELL_KNOCKDOWN_N     = 11428,
    SPELL_KNOCKDOWN_H     = 46183,
    SPELL_SNAP_KICK       = 46182,
    SPELL_FISTS_OF_ARCANE = 44120,

    EVENT_SPELL_KNOCKDOWN = 1,
    EVENT_SPELL_SNAP_KICK = 2,
    EVENT_SPELL_FISTS     = 3,
};

struct boss_eramas_brightblaze : public boss_priestess_lackey_commonAI
{
    boss_eramas_brightblaze(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_MELEE) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        events.ScheduleEvent(EVENT_SPELL_KNOCKDOWN, 6000);
        events.ScheduleEvent(EVENT_SPELL_SNAP_KICK, 3000);
        events.ScheduleEvent(EVENT_SPELL_FISTS, 0);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        boss_priestess_lackey_commonAI::UpdateAI(diff);

        switch (actualEventId)
        {
        case EVENT_SPELL_KNOCKDOWN:
            me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_KNOCKDOWN_N, SPELL_KNOCKDOWN_H), false);
            events.ScheduleEvent(EVENT_SPELL_KNOCKDOWN, 10000);
            break;
        case EVENT_SPELL_SNAP_KICK:
            me->CastSpell(me->GetVictim(), SPELL_SNAP_KICK, false);
            events.ScheduleEvent(EVENT_SPELL_SNAP_KICK, 10000);
            break;
        case EVENT_SPELL_FISTS:
            me->CastSpell(me->GetVictim(), SPELL_FISTS_OF_ARCANE, false);
            events.ScheduleEvent(EVENT_SPELL_FISTS, 10000);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

enum MageEnum
{
    SPELL_POLYMORPH      = 13323,
    SPELL_ICE_BLOCK      = 27619,
    SPELL_BLIZZARD_N     = 44178,
    SPELL_BLIZZARD_H     = 46195,
    SPELL_ICE_LANCE_N    = 44176,
    SPELL_ICE_LANCE_H    = 46194,
    SPELL_CONE_OF_COLD_N = 38384,
    SPELL_CONE_OF_COLD_H = 12611,
    SPELL_FROSTBOLT_N    = 15043,
    SPELL_FROSTBOLT_H    = 15530,
    SPELL_BLINK          = 14514,

    EVENT_SPELL_POLYMORPH = 1,
    EVENT_SPELL_ICE_BLOCK = 2,
    EVENT_SPELL_BLIZZARD  = 3,
    EVENT_SPELL_ICE_LANCE = 4,
    EVENT_SPELL_COC       = 5,
    EVENT_SPELL_FROSTBOLT = 6,
    EVENT_SPELL_BLINK     = 7
};

struct boss_yazzai : public boss_priestess_lackey_commonAI
{
    boss_yazzai(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_RANGED) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        events.ScheduleEvent(EVENT_SPELL_POLYMORPH, 1000);
        events.ScheduleEvent(EVENT_SPELL_ICE_BLOCK, 1000);
        events.ScheduleEvent(EVENT_SPELL_BLIZZARD, 8000);
        events.ScheduleEvent(EVENT_SPELL_ICE_LANCE, 12000);
        events.ScheduleEvent(EVENT_SPELL_COC, 10000);
        events.ScheduleEvent(EVENT_SPELL_FROSTBOLT, 3000);
        events.ScheduleEvent(EVENT_SPELL_BLINK, 5000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        boss_priestess_lackey_commonAI::UpdateAI(diff);

        switch (actualEventId)
        {
        case EVENT_SPELL_POLYMORPH:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                me->CastSpell(target, SPELL_POLYMORPH, false);
            events.ScheduleEvent(EVENT_SPELL_POLYMORPH, 20000);
            break;
        case EVENT_SPELL_ICE_BLOCK:
            if (HealthBelowPct(35))
            {
                me->CastSpell(me, SPELL_ICE_BLOCK, false);
                return;
            }
            events.ScheduleEvent(EVENT_SPELL_ICE_BLOCK, 1000);
            break;
        case EVENT_SPELL_BLIZZARD:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                me->CastSpell(target, DUNGEON_MODE(SPELL_BLIZZARD_N, SPELL_BLIZZARD_H), false);
            events.ScheduleEvent(EVENT_SPELL_BLIZZARD, 20000);
            break;
        case EVENT_SPELL_ICE_LANCE:
            me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_ICE_LANCE_N, SPELL_ICE_LANCE_H), false);
            events.ScheduleEvent(EVENT_SPELL_ICE_LANCE, 12000);
            break;
        case EVENT_SPELL_COC:
            me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_CONE_OF_COLD_N, SPELL_CONE_OF_COLD_H), false);
            events.ScheduleEvent(EVENT_SPELL_COC, 10000);
            break;
        case EVENT_SPELL_FROSTBOLT:
            me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_FROSTBOLT_N, SPELL_FROSTBOLT_H), false);
            events.ScheduleEvent(EVENT_SPELL_FROSTBOLT, 8000);
            break;
        case EVENT_SPELL_BLINK:
        {
            bool InMeleeRange = false;
            ThreatContainer::StorageType const& t_list = me->GetThreatMgr().GetThreatList();
            for (ThreatContainer::StorageType::const_iterator itr = t_list.begin(); itr != t_list.end(); ++itr)
                if (Unit* target = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
                    if (target->IsWithinMeleeRange(me))
                    {
                        InMeleeRange = true;
                        break;
                    }

            if (InMeleeRange)
                me->CastSpell(me, SPELL_BLINK, false);
            events.ScheduleEvent(EVENT_SPELL_BLINK, 15000);
            break;
        }
        }

        DoMeleeAttackIfReady();
    }
};

enum WarriorEnum
{
    SPELL_INTERCEPT          = 27577,
    SPELL_DISARM             = 27581,
    SPELL_PIERCING_HOWL      = 23600,
    SPELL_FRIGHTENING_SHOUT  = 19134,
    SPELL_HAMSTRING          = 27584,
    SPELL_BATTLE_SHOUT       = 27578,
    SPELL_MORTAL_STRIKE      = 44268,

    EVENT_SPELL_DISARM        = 1,
    EVENT_SPELL_PIERCING_HOWL = 2,
    EVENT_SPELL_SHOUT         = 3,
    EVENT_SPELL_HAMSTRING     = 4,
    EVENT_SPELL_MORTAL_STRIKE = 5,
    EVENT_SPELL_INTERCEPT     = 6,
};

struct boss_warlord_salaris : public boss_priestess_lackey_commonAI
{
    boss_warlord_salaris(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_MELEE) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);
        me->CastSpell(me, SPELL_BATTLE_SHOUT, false);

        events.ScheduleEvent(EVENT_SPELL_DISARM, 6000);
        events.ScheduleEvent(EVENT_SPELL_PIERCING_HOWL, 10000);
        events.ScheduleEvent(EVENT_SPELL_SHOUT, 18000);
        events.ScheduleEvent(EVENT_SPELL_HAMSTRING, 4000);
        events.ScheduleEvent(EVENT_SPELL_MORTAL_STRIKE, 8000);
        events.ScheduleEvent(EVENT_SPELL_INTERCEPT, 1000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        boss_priestess_lackey_commonAI::UpdateAI(diff);

        switch (actualEventId)
        {
        case EVENT_SPELL_INTERCEPT:
            me->CastSpell(me->GetVictim(), SPELL_INTERCEPT, false);
            events.ScheduleEvent(EVENT_SPELL_INTERCEPT, 10000);
            break;
        case EVENT_SPELL_DISARM:
            me->CastSpell(me->GetVictim(), SPELL_DISARM, false);
            events.ScheduleEvent(EVENT_SPELL_DISARM, 16000);
            break;
        case EVENT_SPELL_HAMSTRING:
            me->CastSpell(me->GetVictim(), SPELL_HAMSTRING, false);
            events.ScheduleEvent(EVENT_SPELL_HAMSTRING, 15000);
            break;
        case EVENT_SPELL_MORTAL_STRIKE:
            me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
            events.ScheduleEvent(EVENT_SPELL_MORTAL_STRIKE, 10000);
            break;
        case EVENT_SPELL_PIERCING_HOWL:
            me->CastSpell(me, SPELL_PIERCING_HOWL, false);
            events.ScheduleEvent(EVENT_SPELL_PIERCING_HOWL, 15000);
            break;
        case EVENT_SPELL_SHOUT:
            me->CastSpell(me, SPELL_FRIGHTENING_SHOUT, false);
            events.ScheduleEvent(EVENT_SPELL_SHOUT, 18000);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

enum HunterEnum
{
    SPELL_AIMED_SHOT            = 44271,
    SPELL_SHOOT_N               = 15620,
    SPELL_SHOOT_H               = 22907,
    SPELL_CONCUSSIVE_SHOT       = 27634,
    SPELL_MULTI_SHOT            = 31942,
    SPELL_WING_CLIP             = 44286,
    SPELL_FREEZING_TRAP         = 44136,

    NPC_SLIVER                  = 24552,

    EVENT_SPELL_AIMED_SHOT      = 1,
    EVENT_SPELL_SHOOT           = 2,
    EVENT_SPELL_CONCUSSIVE_SHOT = 3,
    EVENT_SPELL_MULTI_SHOT      = 4,
    EVENT_SPELL_WING_CLIP       = 5
};

struct boss_garaxxas : public boss_priestess_lackey_commonAI
{
    boss_garaxxas(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_RANGED) {}

    void Reset() override
    {
        boss_priestess_lackey_commonAI::Reset();
        me->SummonCreature(NPC_SLIVER, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_CORPSE_DESPAWN, 0);
    }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);
        me->CastSpell(me, SPELL_FREEZING_TRAP, true);

        events.ScheduleEvent(EVENT_SPELL_AIMED_SHOT, 8000);
        events.ScheduleEvent(EVENT_SPELL_SHOOT, 0);
        events.ScheduleEvent(EVENT_SPELL_CONCUSSIVE_SHOT, 6000);
        events.ScheduleEvent(EVENT_SPELL_MULTI_SHOT, 10000);
        events.ScheduleEvent(EVENT_SPELL_WING_CLIP, 4000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        boss_priestess_lackey_commonAI::UpdateAI(diff);

        switch (actualEventId)
        {
        case EVENT_SPELL_WING_CLIP:
            me->CastSpell(me->GetVictim(), SPELL_WING_CLIP, false);
            events.ScheduleEvent(EVENT_SPELL_WING_CLIP, 4000);
            break;
        case EVENT_SPELL_AIMED_SHOT:
            me->CastSpell(me->GetVictim(), SPELL_AIMED_SHOT, false);
            events.ScheduleEvent(EVENT_SPELL_AIMED_SHOT, 15000);
            break;
        case EVENT_SPELL_CONCUSSIVE_SHOT:
            me->CastSpell(me->GetVictim(), SPELL_CONCUSSIVE_SHOT, false);
            events.ScheduleEvent(EVENT_SPELL_CONCUSSIVE_SHOT, 15000);
            break;
        case EVENT_SPELL_MULTI_SHOT:
            me->CastSpell(me->GetVictim(), SPELL_MULTI_SHOT, false);
            events.ScheduleEvent(EVENT_SPELL_MULTI_SHOT, 10000);
            break;
        case EVENT_SPELL_SHOOT:
            me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_SHOOT_N, SPELL_SHOOT_H), false);
            events.ScheduleEvent(EVENT_SPELL_SHOOT, 2500);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

enum ShamanEnum
{
    SPELL_WINDFURY_TOTEM        = 27621,
    SPELL_FIRE_NOVA_TOTEM       = 44257,
    SPELL_EARTHBIND_TOTEM       = 15786,
    SPELL_WAR_STOMP             = 46026,
    SPELL_PURGE                 = 27626,
    SPELL_LESSER_HEALING_WAVE_N = 44256,
    SPELL_LESSER_HEALING_WAVE_H = 46181,
    SPELL_FROST_SHOCK_N         = 21401,
    SPELL_FROST_SHOCK_H         = 46180,

    EVENT_SPELL_TOTEM1       = 1,
    EVENT_SPELL_TOTEM2       = 2,
    EVENT_SPELL_TOTEM3       = 3,
    EVENT_SPELL_WAR_STOMP    = 4,
    EVENT_SPELL_PURGE        = 5,
    EVENT_SPELL_HEALING_WAVE = 6,
    EVENT_SPELL_FROST_SHOCK  = 7
};

struct boss_apoko : public boss_priestess_lackey_commonAI
{
    boss_apoko(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_MELEE) { }

    //        uint32 Totem_Timer;
    uint8  Totem_Amount;
    uint32 War_Stomp_Timer;
    //        uint32 Purge_Timer;
    uint32 Healing_Wave_Timer;
    //        uint32 Frost_Shock_Timer;

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        events.ScheduleEvent(EVENT_SPELL_TOTEM1, 2000);
        events.ScheduleEvent(EVENT_SPELL_TOTEM2, 4000);
        events.ScheduleEvent(EVENT_SPELL_TOTEM3, 6000);
        events.ScheduleEvent(EVENT_SPELL_WAR_STOMP, 10000);
        events.ScheduleEvent(EVENT_SPELL_PURGE, 14000);
        events.ScheduleEvent(EVENT_SPELL_HEALING_WAVE, 12000);
        events.ScheduleEvent(EVENT_SPELL_FROST_SHOCK, 8000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        boss_priestess_lackey_commonAI::UpdateAI(diff);

        switch (actualEventId)
        {
        case EVENT_SPELL_TOTEM1:
            me->CastSpell(me, SPELL_WINDFURY_TOTEM, false);
            events.ScheduleEvent(EVENT_SPELL_TOTEM1, 20000);
            break;
        case EVENT_SPELL_TOTEM2:
            me->CastSpell(me, SPELL_FIRE_NOVA_TOTEM, false);
            events.ScheduleEvent(EVENT_SPELL_TOTEM2, 20000);
            break;
        case EVENT_SPELL_TOTEM3:
            me->CastSpell(me, SPELL_EARTHBIND_TOTEM, false);
            events.ScheduleEvent(EVENT_SPELL_TOTEM3, 20000);
            break;
        case EVENT_SPELL_WAR_STOMP:
            me->CastSpell(me, SPELL_WAR_STOMP, false);
            events.ScheduleEvent(EVENT_SPELL_WAR_STOMP, 120000);
            break;
        case EVENT_SPELL_PURGE:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f))
                me->CastSpell(target, SPELL_PURGE, false);
            events.ScheduleEvent(EVENT_SPELL_PURGE, 15000);
            break;
        case EVENT_SPELL_FROST_SHOCK:
            me->CastSpell(me, DUNGEON_MODE(SPELL_FROST_SHOCK_N, SPELL_FROST_SHOCK_H), false);
            events.ScheduleEvent(EVENT_SPELL_FROST_SHOCK, 12000);
            break;
        case EVENT_SPELL_HEALING_WAVE:
            if (Unit* target = DoSelectLowestHpFriendly(40.0f, 1000))
                me->CastSpell(target, DUNGEON_MODE(SPELL_LESSER_HEALING_WAVE_N, SPELL_LESSER_HEALING_WAVE_H), false);
            events.ScheduleEvent(EVENT_SPELL_HEALING_WAVE, 12000);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

enum EngineerEnum
{
    SPELL_GOBLIN_DRAGON_GUN_N  = 44272,
    SPELL_GOBLIN_DRAGON_GUN_H  = 46186,
    SPELL_ROCKET_LAUNCH_N      = 44137,
    SPELL_ROCKET_LAUNCH_H      = 46187,
    SPELL_FEL_IRON_BOMB_N      = 46024,
    SPELL_FEL_IRON_BOMB_H      = 46184,
    SPELL_RECOMBOBULATE        = 44274,
    SPELL_HIGH_EXPLOSIVE_SHEEP = 44276,

    EVENT_SPELL_DRAGON_GUN      = 1,
    EVENT_SPELL_ROCKET_LAUNCH   = 2,
    EVENT_SPELL_RECOMBOBULATE   = 3,
    EVENT_SPELL_EXPLOSIVE_SHEEP = 4,
    EVENT_SPELL_IRON_BOMB       = 5
};

struct boss_zelfan : public boss_priestess_lackey_commonAI
{
    boss_zelfan(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_RANGED) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        events.ScheduleEvent(EVENT_SPELL_DRAGON_GUN, 20000);
        events.ScheduleEvent(EVENT_SPELL_ROCKET_LAUNCH, 7000);
        events.ScheduleEvent(EVENT_SPELL_RECOMBOBULATE, 14000);
        events.ScheduleEvent(EVENT_SPELL_EXPLOSIVE_SHEEP, 10000);
        events.ScheduleEvent(EVENT_SPELL_IRON_BOMB, 5000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        boss_priestess_lackey_commonAI::UpdateAI(diff);

        switch (actualEventId)
        {
        case EVENT_SPELL_DRAGON_GUN:
            me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_GOBLIN_DRAGON_GUN_N, SPELL_GOBLIN_DRAGON_GUN_H), false);
            events.ScheduleEvent(EVENT_SPELL_DRAGON_GUN, 20000);
            break;
        case EVENT_SPELL_ROCKET_LAUNCH:
            me->CastSpell(me->GetVictim(), DUNGEON_MODE(SPELL_ROCKET_LAUNCH_N, SPELL_ROCKET_LAUNCH_H), false);
            events.ScheduleEvent(EVENT_SPELL_ROCKET_LAUNCH, 20000);
            break;
        case EVENT_SPELL_IRON_BOMB:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 15.0f))
                me->CastSpell(target, DUNGEON_MODE(SPELL_FEL_IRON_BOMB_N, SPELL_FEL_IRON_BOMB_H), false);
            events.ScheduleEvent(EVENT_SPELL_IRON_BOMB, 20000);
            break;
        case EVENT_SPELL_RECOMBOBULATE:
        {
            std::list<Creature*> cList = DoFindFriendlyMissingBuff(30.0f, SPELL_RECOMBOBULATE);
            for (std::list<Creature*>::const_iterator itr = cList.begin(); itr != cList.end(); ++itr)
                if ((*itr)->IsPolymorphed())
                {
                    me->CastSpell(*itr, SPELL_RECOMBOBULATE, false);
                    break;
                }
            events.ScheduleEvent(EVENT_SPELL_RECOMBOBULATE, 10000);
            break;
        }
        case EVENT_SPELL_EXPLOSIVE_SHEEP:
            me->CastSpell(me, SPELL_HIGH_EXPLOSIVE_SHEEP, false);
            events.ScheduleEvent(EVENT_SPELL_EXPLOSIVE_SHEEP, 60000);
            break;
        }

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_priestess_delrissa()
{
    RegisterMagistersTerraceCreatureAI(boss_priestess_delrissa);
    RegisterMagistersTerraceCreatureAI(boss_kagani_nightstrike);
    RegisterMagistersTerraceCreatureAI(boss_ellris_duskhallow);
    RegisterMagistersTerraceCreatureAI(boss_eramas_brightblaze);
    RegisterMagistersTerraceCreatureAI(boss_yazzai);
    RegisterMagistersTerraceCreatureAI(boss_warlord_salaris);
    RegisterMagistersTerraceCreatureAI(boss_garaxxas);
    RegisterMagistersTerraceCreatureAI(boss_apoko);
    RegisterMagistersTerraceCreatureAI(boss_zelfan);
}
