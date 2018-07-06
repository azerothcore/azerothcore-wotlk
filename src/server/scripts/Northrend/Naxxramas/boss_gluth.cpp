/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"
#include "SpellScript.h"
#include "Player.h"

enum Spells
{
    SPELL_MORTAL_WOUND                  = 25646,
    SPELL_ENRAGE_10                     = 28371,
    SPELL_ENRAGE_25                     = 54427,
    SPELL_DECIMATE_10                   = 28374,
    SPELL_DECIMATE_25                   = 54426,
    SPELL_BERSERK                       = 26662,
    SPELL_INFECTED_WOUND                = 29306,
    SPELL_CHOW_SEARCHER                 = 28404,
};

enum Events
{
    EVENT_SPELL_MORTAL_WOUND            = 1,
    EVENT_SPELL_ENRAGE                  = 2,
    EVENT_SPELL_DECIMATE                = 3,
    EVENT_SPELL_BERSERK                 = 4,
    EVENT_SUMMON_ZOMBIE                 = 5,
    EVENT_CAN_EAT_ZOMBIE                = 6,
};

enum Misc
{
    NPC_ZOMBIE_CHOW                     = 16360,
};

const Position zombiePos[3] =
{
    {3267.9f, -3172.1f, 297.42f, 0.94f},
    {3253.2f, -3132.3f, 297.42f, 0},
    {3308.3f, -3185.8f, 297.42f, 1.58f},
};

class boss_gluth : public CreatureScript
{
public:
    boss_gluth() : CreatureScript("boss_gluth") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_gluthAI (pCreature);
    }

    struct boss_gluthAI : public BossAI
    {
        boss_gluthAI(Creature *c) : BossAI(c, BOSS_GLUTH), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        InstanceScript* pInstance;
        uint64 gazeTarget;
        
        void Reset()
        {
            BossAI::Reset();
            me->ApplySpellImmune(29306, IMMUNITY_ID, 29306, true);
            events.Reset();
            summons.DespawnAll();
            gazeTarget = 0;
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void MoveInLineOfSight(Unit *who)
        {
            if ((!me->GetVictim() || me->GetVictim()->GetEntry() != NPC_ZOMBIE_CHOW) && who->GetEntry() == NPC_ZOMBIE_CHOW && me->IsWithinDistInMap(who, 6.5f))
            {
                SetGazeOn(who);
                me->MonsterTextEmote("%s spots a nearby zombie to devour!", 0, false);
            }
            else
                ScriptedAI::MoveInLineOfSight(who);
        }

        void EnterCombat(Unit * who)
        {
            BossAI::EnterCombat(who);
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_SPELL_MORTAL_WOUND, 10000);
            events.ScheduleEvent(EVENT_SPELL_ENRAGE, 30000);
            events.ScheduleEvent(EVENT_SPELL_DECIMATE, 105000);
            events.ScheduleEvent(EVENT_SPELL_BERSERK, 8*60000);
            events.ScheduleEvent(EVENT_SUMMON_ZOMBIE, 10000);
            events.ScheduleEvent(EVENT_CAN_EAT_ZOMBIE, 1000);
        }

        void JustSummoned(Creature *summon)
        {
            if (summon->GetEntry() == NPC_ZOMBIE_CHOW)
                summon->AI()->AttackStart(me);

            summons.Summon(summon);
        }

        void SummonedCreatureDies(Creature* cr, Unit*) { summons.Despawn(cr); }

        void KilledUnit(Unit* who)
        {
            if (me->IsAlive() && who->GetEntry() == NPC_ZOMBIE_CHOW)
                me->ModifyHealth(int32(me->GetMaxHealth()*0.05f));

            if (who->GetTypeId() == TYPEID_PLAYER && pInstance)
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void JustDied(Unit*  killer)
        {
            BossAI::JustDied(killer);
            summons.DespawnAll();
        }

        bool SelectPlayerInRoom()
        {
            if (me->IsInCombat())
                return false;

            Map::PlayerList const& pList = me->GetMap()->GetPlayers();
            for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
            {
                Player* player = itr->GetSource();
                if (!player || !player->IsAlive())
                    continue;
                if (player->GetPositionZ() > 300.0f || me->GetExactDist(player) > 50.0f)
                    continue;

                AttackStart(player);
                return true;
            }

            return false;
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictimWithGaze() && !SelectPlayerInRoom())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_ENRAGE:
                    me->MonsterTextEmote("Gluth becomes enraged!", 0, true);
                    me->CastSpell(me, RAID_MODE(SPELL_ENRAGE_10, SPELL_ENRAGE_25), true);
                    events.RepeatEvent(30000);
                    break;
                case EVENT_SPELL_MORTAL_WOUND:
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_WOUND, false);
                    events.RepeatEvent(10000);
                    break;
                case EVENT_SPELL_DECIMATE:
                    me->MonsterTextEmote("Gluth decimates all nearby flesh!", 0, true);
                    me->CastSpell(me, RAID_MODE(SPELL_DECIMATE_10, SPELL_DECIMATE_25), false);
                    events.RepeatEvent(105000);
                    break;
                case EVENT_SUMMON_ZOMBIE:
                    {
                        uint8 rand = urand(0,2);
                        for (int32 i = 0; i < RAID_MODE(1,2); ++i)
                        {
                            // In 10 man raid, normal mode - should spawn only from mid gate
                            // \1 |0 /2 pos
                            // In 25 man raid - should spawn from all 3 gates
                            if (me->GetMap()->GetDifficulty() == RAID_DIFFICULTY_10MAN_NORMAL)
                                me->SummonCreature(NPC_ZOMBIE_CHOW, zombiePos[0]);
                            else
                                me->SummonCreature(NPC_ZOMBIE_CHOW, zombiePos[urand(0, 2)]);
                            (rand == 2 ? rand = 0 : rand++);
                        }

                        events.RepeatEvent(10000);
                        break;
                    }
                case EVENT_CAN_EAT_ZOMBIE:
                    events.RepeatEvent(1000);
                    if (me->GetVictim()->GetEntry() == NPC_ZOMBIE_CHOW && me->IsWithinMeleeRange(me->GetVictim()))
                    {
                        me->CastCustomSpell(SPELL_CHOW_SEARCHER, SPELLVALUE_RADIUS_MOD, 20000, me, true);
                        me->MonsterTextEmote("%s devour all nearby zombies!", 0, false);
                        return; // leave it to skip DoMeleeAttackIfReady
                    }
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_gluth_decimate : public SpellScriptLoader
{
    public:
        spell_gluth_decimate() : SpellScriptLoader("spell_gluth_decimate") { }

        class spell_gluth_decimate_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_gluth_decimate_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                {
                    int32 damage = int32(unitTarget->GetHealth()) - int32(unitTarget->CountPctFromMaxHealth(5));
                    if (damage <= 0)
                        return;

                    if (Creature* cTarget = unitTarget->ToCreature())
                    {
                        cTarget->SetWalk(true);
                        cTarget->GetMotionMaster()->MoveFollow(GetCaster(), 0.0f, 0.0f, MOTION_SLOT_CONTROLLED);
                        cTarget->SetReactState(REACT_PASSIVE);
                        Unit::DealDamage(GetCaster(), cTarget, damage);
                        return;
                    }

                    GetCaster()->CastCustomSpell(28375, SPELLVALUE_BASE_POINT0, damage, unitTarget);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_gluth_decimate_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_gluth_decimate_SpellScript();
        }
};

void AddSC_boss_gluth()
{
    new boss_gluth();
    new spell_gluth_decimate();
}

