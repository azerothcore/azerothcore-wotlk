/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Jin'do the Hexxer
SD%Complete: 85
SDComment: Mind Control not working because of core bug. Shades visible for all.
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Say
{
    SAY_AGGRO                       = 1
};

enum Spells
{
    SPELL_BRAINWASHTOTEM            = 24262,
    SPELL_POWERFULLHEALINGWARD      = 24309, // HACKED Totem summoned by script because the spell totems will not cast.
    SPELL_HEX                       = 24053,
    SPELL_DELUSIONSOFJINDO          = 24306,
    SPELL_SHADEOFJINDO              = 24308, // HACKED
    //Healing Ward Spell
    SPELL_HEAL                      = 38588, // HACKED Totems are not working right. Right heal spell ID is 24311 but this spell is not casting...
    //Shade of Jindo Spell
    SPELL_SHADOWSHOCK               = 19460,
    SPELL_INVISIBLE                 = 24699
};

enum Events
{
    EVENT_BRAINWASHTOTEM            = 1,
    EVENT_POWERFULLHEALINGWARD      = 2,
    EVENT_HEX                       = 3,
    EVENT_DELUSIONSOFJINDO          = 4,
    EVENT_TELEPORT                  = 5
};

Position const TeleportLoc = {-11583.7783f, -1249.4278f, 77.5471f, 4.745f};

class boss_jindo : public CreatureScript
{
    public: boss_jindo() : CreatureScript("boss_jindo") { }

        struct boss_jindoAI : public BossAI
        {
            boss_jindoAI(Creature* creature) : BossAI(creature, DATA_JINDO) { }

            void Reset()
            {
                _Reset();
            }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_BRAINWASHTOTEM, 20000);
                events.ScheduleEvent(EVENT_POWERFULLHEALINGWARD, 16000);
                events.ScheduleEvent(EVENT_HEX, 8000);
                events.ScheduleEvent(EVENT_DELUSIONSOFJINDO, 10000);
                events.ScheduleEvent(EVENT_TELEPORT, 5000);
                Talk(SAY_AGGRO);
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
                        case EVENT_BRAINWASHTOTEM:
                            DoCast(me, SPELL_BRAINWASHTOTEM);
                            events.ScheduleEvent(EVENT_BRAINWASHTOTEM, urand(18000, 26000));
                            break;
                        case EVENT_POWERFULLHEALINGWARD: // HACK
                            //DoCast(me, SPELL_POWERFULLHEALINGWARD);
                            me->SummonCreature(14987, me->GetPositionX()+3, me->GetPositionY()-2, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 30000);
                            events.ScheduleEvent(EVENT_POWERFULLHEALINGWARD, urand(14000, 20000));
                            break;
                        case EVENT_HEX:
                            if (Unit* target = me->GetVictim())
                            {
                                DoCast(target, SPELL_HEX, true);
                                if (DoGetThreat(target))
                                    DoModifyThreatPercent(target, -80);
                            }
                            events.ScheduleEvent(EVENT_HEX, urand(12000, 20000));
                            break;
                        case EVENT_DELUSIONSOFJINDO: // HACK
                            // Casting the delusion curse with a shade so shade will attack the same target with the curse.
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            {
                                DoCast(target, SPELL_DELUSIONSOFJINDO);
                                Creature* Shade = me->SummonCreature(NPC_SHADE_OF_JINDO, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                                if (Shade)
                                    Shade->AI()->AttackStart(target);
                            }
                            events.ScheduleEvent(EVENT_DELUSIONSOFJINDO, urand(4000, 12000));
                            break;
                        case EVENT_TELEPORT: // Possible HACK
                            // Teleports a random player and spawns 9 Sacrificed Trolls to attack player
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            {
                                DoTeleportPlayer(target, TeleportLoc.m_positionX, TeleportLoc.m_positionY, TeleportLoc.m_positionZ, TeleportLoc.m_orientation);
                                if (DoGetThreat(me->GetVictim()))
                                    DoModifyThreatPercent(target, -100);
                                Creature* SacrificedTroll;
                                SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, target->GetPositionX()+2, target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                                if (SacrificedTroll)
                                    SacrificedTroll->AI()->AttackStart(target);
                                SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, target->GetPositionX()-2, target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                                if (SacrificedTroll)
                                    SacrificedTroll->AI()->AttackStart(target);
                                SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, target->GetPositionX()+4, target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                                if (SacrificedTroll)
                                    SacrificedTroll->AI()->AttackStart(target);
                                SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, target->GetPositionX()-4, target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                                if (SacrificedTroll)
                                    SacrificedTroll->AI()->AttackStart(target);
                                SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, target->GetPositionX(), target->GetPositionY()+2, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                                if (SacrificedTroll)
                                    SacrificedTroll->AI()->AttackStart(target);
                                SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, target->GetPositionX(), target->GetPositionY()-2, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                                if (SacrificedTroll)
                                    SacrificedTroll->AI()->AttackStart(target);
                                SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, target->GetPositionX(), target->GetPositionY()+4, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                                if (SacrificedTroll)
                                    SacrificedTroll->AI()->AttackStart(target);
                                SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, target->GetPositionX(), target->GetPositionY()-4, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                                if (SacrificedTroll)
                                    SacrificedTroll->AI()->AttackStart(target);
                                SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, target->GetPositionX()+3, target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                                if (SacrificedTroll)
                                    SacrificedTroll->AI()->AttackStart(target);
                            }
                            events.ScheduleEvent(EVENT_TELEPORT, urand(15000, 23000));
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_jindoAI(creature);
        }
};

//Healing Ward
class npc_healing_ward : public CreatureScript
{
    public:

        npc_healing_ward()
            : CreatureScript("npc_healing_ward")
        {
        }

        struct npc_healing_wardAI : public ScriptedAI
        {
            npc_healing_wardAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = creature->GetInstanceScript();
            }

            uint32 Heal_Timer;

            InstanceScript* instance;

            void Reset()
            {
                Heal_Timer = 2000;
            }

            void EnterCombat(Unit* /*who*/)
            {
            }

            void UpdateAI(uint32 diff)
            {
                //Heal_Timer
                if (Heal_Timer <= diff)
                {
                    Unit* pJindo = ObjectAccessor::GetUnit(*me, instance->GetData64(DATA_JINDO));
                    if (pJindo)
                        DoCast(pJindo, SPELL_HEAL);
                    Heal_Timer = 3000;
                } else Heal_Timer -= diff;

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<npc_healing_wardAI>(creature);
        }
};

//Shade of Jindo
class npc_shade_of_jindo : public CreatureScript
{
    public:

        npc_shade_of_jindo()
            : CreatureScript("npc_shade_of_jindo")
        {
        }

        struct npc_shade_of_jindoAI : public ScriptedAI
        {
            npc_shade_of_jindoAI(Creature* creature) : ScriptedAI(creature) { }

            uint32 ShadowShock_Timer;

            void Reset()
            {
                ShadowShock_Timer = 1000;
                DoCast(me, SPELL_INVISIBLE, true);
            }

            void EnterCombat(Unit* /*who*/) { }

            void UpdateAI(uint32 diff)
            {

                //ShadowShock_Timer
                if (ShadowShock_Timer <= diff)
                {
                    DoCastVictim(SPELL_SHADOWSHOCK);
                    ShadowShock_Timer = 2000;
                } else ShadowShock_Timer -= diff;

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_shade_of_jindoAI(creature);
        }
};

void AddSC_boss_jindo()
{
    new boss_jindo();
    new npc_healing_ward();
    new npc_shade_of_jindo();
}
