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
    SPELL_SHADOW_WORD_PAIN     = 14032,
    SPELL_POWER_WORD_SHIELD    = 44291,
    SPELL_RENEW                = 44174
};

enum Misc
{
    MAX_ACTIVE_HELPERS             = 4,
    MAX_HELPERS_COUNT              = 8
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

struct boss_priestess_delrissa : public BossAI
{
    boss_priestess_delrissa(Creature* creature) : BossAI(creature, DATA_DELRISSA) { }

    uint8 PlayersKilled;
    uint8 HelpersKilled;

    void Reset() override
    {
        instance->SetBossState(DATA_DELRISSA, NOT_STARTED);
        scheduler.CancelAll();
        PlayersKilled = SAY_PLAYER_KILLED;
        HelpersKilled = SAY_HELPER_DIED;
        summons.Respawn();

        me->SetLootMode(0);
    }

    bool CheckInRoom() override
    {
        return me->GetDistance(me->GetHomePosition()) < 75.0f;
    }

    void InitializeAI() override
    {
        ScriptedAI::InitializeAI();

        if (instance->GetBossState(DATA_DELRISSA) != DONE)
        {
            std::vector<uint32> helpersList(std::begin(helpersEntries), std::end(helpersEntries));
            Acore::Containers::RandomResize(helpersList, MAX_ACTIVE_HELPERS);

            uint8 j = 0;
            for (uint32 entry : helpersList)
                me->SummonCreature(entry, helpersLocations[j++], TEMPSUMMON_MANUAL_DESPAWN, 0);
        }
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
        _JustEngagedWith();

        ScheduleTimedEvent(15s, [&] {
            if (Unit* target = DoSelectLowestHpFriendly(40.0f, 1000))
                DoCast(target, SPELL_FLASH_HEAL);
        }, 15s);

        ScheduleTimedEvent(10s, [&] {
            if (Unit* target = DoSelectLowestHpFriendly(40.0f, 1000))
                DoCast(target, SPELL_RENEW);
        }, 7s);

        ScheduleTimedEvent(2s, [&] {
            std::list<Creature*> cList = DoFindFriendlyMissingBuff(40.0f, SPELL_POWER_WORD_SHIELD);
            if (Unit* target = Acore::Containers::SelectRandomContainerElement(cList))
                DoCast(target, SPELL_POWER_WORD_SHIELD);
        }, 10s);

        ScheduleTimedEvent(5s, [&] {
            DoCastRandomTarget(SPELL_SHADOW_WORD_PAIN, 0, 30.0f);
        }, 10s);

        ScheduleTimedEvent(7500ms, [&] {
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
                DoCast(target, SPELL_DISPEL_MAGIC);
        }, 12s);

        if (IsHeroic())
        {
            scheduler.Schedule(4s, [this](TaskContext context)
            {
                if (me->HasUnitState(UNIT_STATE_LOST_CONTROL))
                {
                    DoCastSelf(SPELL_MEDALION_OF_IMMUNITY, false);
                    context.Repeat(1min);
                }
                else
                    context.Repeat(1s);
            });
        }
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
};

enum helpersShared
{
    SPELL_HEALING_POTION              = 15503,

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
    SummonList summons;
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
        for (auto const& ref : tList)
        {
            Unit* pUnit = ObjectAccessor::GetUnit(*me, ref->getUnitGuid());
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
        scheduler.CancelAll();
        summons.DespawnAll();
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (Creature* delrissa = instance->GetCreature(DATA_DELRISSA))
            if (!delrissa->IsAlive())
            {
                delrissa->Respawn();
                return;
            }
        ScriptedAI::EnterEvadeMode(why);
    }

    void JustEngagedWith(Unit* who) override
    {
        if (Creature* delrissa = instance->GetCreature(DATA_DELRISSA))
            if (delrissa->IsAlive() && !delrissa->IsEngaged())
                delrissa->AI()->AttackStart(who);

        scheduler.Schedule(5s, [this](TaskContext context)
        {
            if (me->HealthBelowPct(25))
                DoCastSelf(SPELL_HEALING_POTION, true);
            else
                context.Repeat(1s);
        });

        ScheduleTimedEvent(8s, 10s, [&] {
            RecalculateThreat();
        }, 8s, 10s);

        if (IsHeroic())
        {
            scheduler.Schedule(2s, [this](TaskContext context)
            {
                if (me->HasUnitState(UNIT_STATE_LOST_CONTROL))
                {
                    DoCastSelf(SPELL_MEDALION_OF_IMMUNITY);
                    context.Repeat(1min);
                }
                else
                    context.Repeat(1s);
            });
        }

        RecalculateThreat();
    }

    void JustDied(Unit* /*killer*/) override
    {
        summons.DespawnAll();
    }

    void KilledUnit(Unit* victim) override
    {
        if (Creature* delrissa = instance->GetCreature(DATA_DELRISSA))
            delrissa->AI()->KilledUnit(victim);
    }

    void AttackStart(Unit* victim) override
    {
        if (victim && me->Attack(victim, true))
            me->GetMotionMaster()->MoveChase(victim, aiType == AI_TYPE_MELEE ? 0.0f : 20.0f);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        scheduler.Update(diff,
            std::bind(&BossAI::DoMeleeAttackIfReady, this));
    }
};

enum RogueEnum
{
    SPELL_KIDNEY_SHOT  = 27615,
    SPELL_VANISH       = 44290,
    SPELL_GOUGE        = 12540,
    SPELL_KICK         = 27613,
    SPELL_BACKSTAB     = 15657,
    SPELL_EVISCERATE   = 27611
};

struct boss_kagani_nightstrike : public boss_priestess_lackey_commonAI
{
    boss_kagani_nightstrike(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_MELEE) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        ScheduleTimedEvent(5500ms, [&] {
            DoCastVictim(SPELL_GOUGE);
        }, 15s);

        ScheduleTimedEvent(6s, [&] {
            DoCastVictim(SPELL_EVISCERATE);
        }, 10s);

        ScheduleTimedEvent(1s, [&] {
            DoCastSelf(SPELL_VANISH);
            DoResetThreatList();
            if (Unit* unit = SelectTarget(SelectTargetMethod::Random, 0))
                me->AddThreat(unit, 1000.0f);
        }, 30s);

        scheduler.Schedule(9s, [this](TaskContext context)
        {
            if (me->GetVictim() && me->GetVictim()->HasUnitState(UNIT_STATE_CASTING))
            {
                DoCastVictim(SPELL_KICK);
                context.Repeat(15s);
            }
            else
                context.Repeat(1s);
        });

        scheduler.Schedule(9s, [this](TaskContext context)
        {
            if (me->GetVictim() && !me->GetVictim()->HasInArc(static_cast<float>(M_PI), me))
            {
                DoCastVictim(SPELL_BACKSTAB);
                context.Repeat(5s);
            }
            else
                context.Repeat(1s);
        });
    }

    void MovementInform(uint32 type, uint32  /*point*/) override
    {
        if (type == CHASE_MOTION_TYPE && me->HasAura(SPELL_VANISH) && me->GetVictim())
            me->CastSpell(me->GetVictim(), SPELL_KIDNEY_SHOT, false);
    }
};

enum WarlockEnum
{
    SPELL_IMMOLATE           = 44267,
    SPELL_SHADOW_BOLT        = 12471,
    SPELL_CURSE_OF_AGONY     = 14875,
    SPELL_SEED_OF_CORRUPTION = 44141,
    SPELL_FEAR               = 38595,
    SPELL_SUMMON_IMP         = 44163
};

struct boss_ellris_duskhallow : public boss_priestess_lackey_commonAI
{
    boss_ellris_duskhallow(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_RANGED) { }

    void JustEngagedWith(Unit* who) override
    {
        DoCastAOE(SPELL_SUMMON_IMP);
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        ScheduleTimedEvent(3s, [&] {
            DoCastRandomTarget(SPELL_IMMOLATE, 0, 20.0f);
        }, 12s);

        ScheduleTimedEvent(1s, [&] {
            DoCastVictim(SPELL_SHADOW_BOLT);
        }, 5s);

        ScheduleTimedEvent(10s, [&] {
            DoCastRandomTarget(SPELL_SEED_OF_CORRUPTION, 0, 30.0f);
        }, 18s);

        ScheduleTimedEvent(6s, [&] {
            DoCastRandomTarget(SPELL_CURSE_OF_AGONY, 0, 30.0f);
        }, 13s);

        ScheduleTimedEvent(15s, [&] {
            DoCastRandomTarget(SPELL_FEAR, 0, 20.0f);
        }, 15s);
    }
};

enum MonkEnum
{
    SPELL_KNOCKDOWN       = 11428,
    SPELL_SNAP_KICK       = 46182,
    SPELL_FISTS_OF_ARCANE = 44120
};

struct boss_eramas_brightblaze : public boss_priestess_lackey_commonAI
{
    boss_eramas_brightblaze(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_MELEE) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        ScheduleTimedEvent(6s, [&] {
            DoCastVictim(SPELL_KNOCKDOWN);
        }, 10s);

        ScheduleTimedEvent(3s, [&] {
            DoCastVictim(SPELL_SNAP_KICK);
        }, 10s);

        ScheduleTimedEvent(3s, [&] {
            DoCastVictim(SPELL_FISTS_OF_ARCANE);
        }, 10s);
    }
};

enum MageEnum
{
    SPELL_POLYMORPH      = 13323,
    SPELL_ICE_BLOCK      = 27619,
    SPELL_BLIZZARD       = 44178,
    SPELL_ICE_LANCE      = 44176,
    SPELL_CONE_OF_COLD   = 12611,
    SPELL_FROSTBOLT      = 15043,
    SPELL_BLINK          = 14514
};

struct boss_yazzai : public boss_priestess_lackey_commonAI
{
    boss_yazzai(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_RANGED) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        ScheduleTimedEvent(1s, [&] {
            DoCastRandomTarget(SPELL_POLYMORPH);
        }, 20s);

        ScheduleTimedEvent(8s, [&] {
            DoCastRandomTarget(SPELL_BLIZZARD);
        }, 20s);

        ScheduleTimedEvent(12s, [&] {
            DoCastVictim(SPELL_ICE_LANCE);
        }, 12s);

        ScheduleTimedEvent(10s, [&] {
            DoCastVictim(SPELL_CONE_OF_COLD);
        }, 10s);

        ScheduleTimedEvent(3s, [&] {
            DoCastVictim(SPELL_FROSTBOLT);
        }, 8s);

        ScheduleTimedEvent(5s, [&] {
            if (me->SelectNearbyTarget())
                DoCastAOE(SPELL_BLINK);
        }, 15s);

        scheduler.Schedule(1s, [this](TaskContext context)
        {
            if (me->HealthBelowPct(35))
                DoCastSelf(SPELL_ICE_BLOCK, true);
            else
                context.Repeat();
        });
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
    SPELL_MORTAL_STRIKE      = 44268
};

struct boss_warlord_salaris : public boss_priestess_lackey_commonAI
{
    boss_warlord_salaris(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_MELEE) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);
        DoCastAOE(SPELL_BATTLE_SHOUT);

        ScheduleTimedEvent(6s, [&] {
            DoCastVictim(SPELL_INTERCEPT);
        }, 10s);

        ScheduleTimedEvent(10s, [&] {
            DoCastVictim(SPELL_DISARM);
        }, 16s);

        ScheduleTimedEvent(18s, [&] {
            DoCastVictim(SPELL_HAMSTRING);
        }, 15s);

        ScheduleTimedEvent(4s, [&] {
            DoCastVictim(SPELL_MORTAL_STRIKE);
        }, 10s);

        ScheduleTimedEvent(8s, [&] {
            DoCastAOE(SPELL_PIERCING_HOWL);
        }, 15s);

        ScheduleTimedEvent(1s, [&] {
            DoCastAOE(SPELL_FRIGHTENING_SHOUT);
        }, 18s);
    }
};

enum HunterEnum
{
    SPELL_AIMED_SHOT            = 44271,
    SPELL_SHOOT                 = 15620,
    SPELL_CONCUSSIVE_SHOT       = 27634,
    SPELL_MULTI_SHOT            = 31942,
    SPELL_WING_CLIP             = 44286,
    SPELL_FREEZING_TRAP         = 44136,

    NPC_SLIVER                  = 24552
};

struct boss_garaxxas : public boss_priestess_lackey_commonAI
{
    boss_garaxxas(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_RANGED) { }

    void Reset() override
    {
        boss_priestess_lackey_commonAI::Reset();
        me->SummonCreature(NPC_SLIVER, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_CORPSE_DESPAWN, 0);
    }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);
        DoCastAOE(SPELL_FREEZING_TRAP, true);

        ScheduleTimedEvent(8s, [&] {
            DoCastVictim(SPELL_AIMED_SHOT);
        }, 15s);

        ScheduleTimedEvent(6s, [&] {
            DoCastVictim(SPELL_CONCUSSIVE_SHOT);
        }, 15s);

        ScheduleTimedEvent(10s, [&] {
            DoCastVictim(SPELL_MULTI_SHOT);
        }, 10s);

        ScheduleTimedEvent(1s, [&] {
            DoCastVictim(SPELL_SHOOT);
        }, 2500ms);

        ScheduleTimedEvent(4s, [&] {
            DoCastVictim(SPELL_WING_CLIP);
        }, 4s);
    }
};

enum ShamanEnum
{
    SPELL_WINDFURY_TOTEM        = 27621,
    SPELL_FIRE_NOVA_TOTEM       = 44257,
    SPELL_EARTHBIND_TOTEM       = 15786,
    SPELL_WAR_STOMP             = 46026,
    SPELL_PURGE                 = 27626,
    SPELL_LESSER_HEALING_WAVE   = 44256,
    SPELL_FROST_SHOCK           = 21401
};

struct boss_apoko : public boss_priestess_lackey_commonAI
{
    boss_apoko(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_MELEE) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        ScheduleTimedEvent(2s, [&] {
            DoCastAOE(SPELL_WINDFURY_TOTEM);
        }, 20s);

        ScheduleTimedEvent(4s, [&] {
            DoCastAOE(SPELL_FIRE_NOVA_TOTEM);
        }, 20s);

        ScheduleTimedEvent(6s, [&] {
            DoCastAOE(SPELL_EARTHBIND_TOTEM);
        }, 20s);

        ScheduleTimedEvent(10s, [&] {
            DoCastAOE(SPELL_WAR_STOMP);
        }, 2min);

        ScheduleTimedEvent(14s, [&] {
            DoCastRandomTarget(SPELL_PURGE, 0, 30.0f);
        }, 15s);

        ScheduleTimedEvent(12s, [&] {
            if (Unit* target = DoSelectLowestHpFriendly(40.0f, 1000))
                DoCast(target, SPELL_LESSER_HEALING_WAVE);
        }, 15s);

        ScheduleTimedEvent(8s, [&] {
            DoCastVictim(SPELL_FROST_SHOCK);
        }, 12s);
    }
};

enum EngineerEnum
{
    SPELL_GOBLIN_DRAGON_GUN    = 44272,
    SPELL_ROCKET_LAUNCH        = 44137,
    SPELL_FEL_IRON_BOMB        = 46024,
    SPELL_RECOMBOBULATE        = 44274,
    SPELL_HIGH_EXPLOSIVE_SHEEP = 44276
};

struct boss_zelfan : public boss_priestess_lackey_commonAI
{
    boss_zelfan(Creature* creature) : boss_priestess_lackey_commonAI(creature, AI_TYPE_RANGED) { }

    void JustEngagedWith(Unit* who) override
    {
        boss_priestess_lackey_commonAI::JustEngagedWith(who);

        ScheduleTimedEvent(20s, [&] {
            DoCastVictim(SPELL_GOBLIN_DRAGON_GUN);
        }, 20s);

        ScheduleTimedEvent(7s, [&] {
            DoCastVictim(SPELL_ROCKET_LAUNCH);
        }, 20s);

        ScheduleTimedEvent(14s, [&] {
            std::list<Creature*> cList = DoFindFriendlyMissingBuff(30.0f, SPELL_RECOMBOBULATE);
            for (auto const& creature : cList)
                if (creature->IsPolymorphed())
                {
                    DoCast(creature, SPELL_RECOMBOBULATE);
                    break;
                }
        }, 10s);

        ScheduleTimedEvent(10s, [&] {
            DoCastAOE(SPELL_HIGH_EXPLOSIVE_SHEEP);
        }, 1min);

        ScheduleTimedEvent(5s, [&] {
            DoCastRandomTarget(SPELL_FEL_IRON_BOMB, 0, 15.0f);
        }, 20s);
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
