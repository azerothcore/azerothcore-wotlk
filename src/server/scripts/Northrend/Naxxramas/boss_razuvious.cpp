/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

enum Sounds
{
    SOUND_AGGRO_1                   = 8852,
    SOUND_AGGRO_2                   = 8853,
    SOUND_AGGRO_3                   = 8854,
    SOUND_SLAY                      = 8861,
    SOUND_COMMAND_1                 = 8855,
    SOUND_COMMAND_2                 = 8856,
    SOUND_COMMAND_3                 = 8858,
    SOUND_COMMAND_4                 = 8859,
    SOUND_COMMAND_5                 = 8861,
    SOUND_DEATH                     = 8860,
};

enum Spells
{
    SPELL_UNBALANCING_STRIKE        = 26613,
    SPELL_DISRUPTING_SHOUT_10       = 29107, 
    SPELL_DISRUPTING_SHOUT_25       = 55543,
    SPELL_JAGGED_KNIFE              = 55550,
    SPELL_HOPELESS                  = 29125,

    SPELL_BONE_BARRIER              = 29061,
    SPELL_BLOOD_STRIKE              = 61696, 
};


enum Events
{
    EVENT_SPELL_UNBALANCING_STRIKE  = 1,
    EVENT_SPELL_DISRUPTING_SHOUT    = 2,
    EVENT_SPELL_JAGGED_KNIFE        = 3,
    EVENT_PLAY_COMMAND              = 4,

    EVENT_MINION_BLOOD_STRIKE       = 10,
    EVENT_MINION_BONE_BARRIER       = 11,
};

enum Misc
{
    NPC_DEATH_KNIGHT_UNDERSTUDY     = 16803,
    NPC_RAZUVIOUS                   = 16061,
};

class boss_razuvious : public CreatureScript
{
public:
    boss_razuvious() : CreatureScript("boss_razuvious") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_razuviousAI (pCreature);
    }

    struct boss_razuviousAI : public BossAI
    {
        boss_razuviousAI(Creature *c) : BossAI(c, BOSS_RAZUVIOUS), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        InstanceScript* pInstance;

        void SpawnHelpers()
        {
            me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2782.45f, -3088.03f, 267.685f, 0.75f);
            me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2778.56f, -3113.74f, 267.685f, 5.28f);
            if (Is25ManRaid())
            {
                me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2762.23f, -3085.07f, 267.685f, 1.95f);
                me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2758.24f, -3110.97f, 267.685f, 3.94f);
            }
        }

        void JustSummoned(Creature* cr) { summons.Summon(cr); }

        void Reset()
        {
            BossAI::Reset();
            summons.DespawnAll();
            events.Reset();
            SpawnHelpers();
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (!urand(0,3))
            {
                DoPlaySoundToSet(me, SOUND_SLAY);
                me->MonsterYell("You should've stayed home!", LANG_UNIVERSAL, 0);
            }

            if (pInstance)
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            // Damage done by the controlled Death Knight understudies should also count toward damage done by players
            if(who && who->GetTypeId() == TYPEID_UNIT && who->GetEntry() == NPC_DEATH_KNIGHT_UNDERSTUDY)
                me->LowerPlayerDamageReq(damage);
        }

        void JustDied(Unit*  killer)
        {
            BossAI::JustDied(killer);
            DoPlaySoundToSet(me, SOUND_DEATH);
            me->MonsterYell("An honorable... death...", LANG_UNIVERSAL, 0);
            
            me->CastSpell(me, SPELL_HOPELESS, true);
        }

        void EnterCombat(Unit * who)
        {
            BossAI::EnterCombat(who);
            switch (urand(0,2))
            {
                case 0:
                    DoPlaySoundToSet(me, SOUND_AGGRO_1);
                    me->MonsterYell("Hah hah, I'm just getting warmed up!", LANG_UNIVERSAL, 0);
                    break;
                case 1:
                    DoPlaySoundToSet(me, SOUND_AGGRO_2);
                    me->MonsterYell("Stand and fight!", LANG_UNIVERSAL, 0);
                    break;
                case 2:
                    DoPlaySoundToSet(me, SOUND_AGGRO_3);
                    me->MonsterYell("Show me what you've got!", LANG_UNIVERSAL, 0);
                    break;
            }

            events.ScheduleEvent(EVENT_SPELL_UNBALANCING_STRIKE, 30000);
            events.ScheduleEvent(EVENT_SPELL_DISRUPTING_SHOUT, 25000);
            events.ScheduleEvent(EVENT_SPELL_JAGGED_KNIFE, 15000);
            events.ScheduleEvent(EVENT_PLAY_COMMAND, 40000);

            summons.DoZoneInCombat();
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_UNBALANCING_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_UNBALANCING_STRIKE, false);
                    events.RepeatEvent(30000);
                    break;
                case EVENT_SPELL_DISRUPTING_SHOUT:
                    me->CastSpell(me, RAID_MODE(SPELL_DISRUPTING_SHOUT_10, SPELL_DISRUPTING_SHOUT_25), false);
                    events.RepeatEvent(25000);
                    break;
                case EVENT_SPELL_JAGGED_KNIFE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 45.0f))
                        me->CastSpell(target, SPELL_JAGGED_KNIFE, false);

                    events.RepeatEvent(25000);
                    break;
                case EVENT_PLAY_COMMAND:
                    switch (urand(0,2))
                    {
                        case 0:
                            DoPlaySoundToSet(me, SOUND_COMMAND_1);
                            me->MonsterYell("Do as I taught you!", LANG_UNIVERSAL, 0);
                            break;
                        case 1:
                            DoPlaySoundToSet(me, SOUND_COMMAND_2);
                            me->MonsterYell("Show them no mercy!", LANG_UNIVERSAL, 0);
                            break;
                        case 2:
                            DoPlaySoundToSet(me, SOUND_COMMAND_3);
                            me->MonsterYell("You disappoint me, students!", LANG_UNIVERSAL, 0);
                            break;
                    }
                    events.RepeatEvent(40000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_razuvious_minion : public CreatureScript
{
public:
    boss_razuvious_minion() : CreatureScript("boss_razuvious_minion") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_razuvious_minionAI (pCreature);
    }

    struct boss_razuvious_minionAI : public ScriptedAI
    {
        boss_razuvious_minionAI(Creature *c) : ScriptedAI(c)
        {
        }

        EventMap events;

        void Reset()
        {
            events.Reset();
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (me->GetInstanceScript())
                me->GetInstanceScript()->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void EnterCombat(Unit *who)
        {
            if (Creature* cr = me->FindNearestCreature(NPC_RAZUVIOUS, 100.0f))
            {
                cr->SetInCombatWithZone();
                cr->AI()->AttackStart(who);
            }

            events.ScheduleEvent(EVENT_MINION_BLOOD_STRIKE, 4000);
            events.ScheduleEvent(EVENT_MINION_BONE_BARRIER, 9000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING) || me->IsCharmed())
                return;

            switch (events.GetEvent())
            {
                case EVENT_MINION_BLOOD_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_BLOOD_STRIKE, false);
                    events.RepeatEvent(8000);
                    break;
                case EVENT_MINION_BONE_BARRIER:
                    me->CastSpell(me, SPELL_BONE_BARRIER, true);
                    events.RepeatEvent(40000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_razuvious()
{
    new boss_razuvious();
    new boss_razuvious_minion();
}
