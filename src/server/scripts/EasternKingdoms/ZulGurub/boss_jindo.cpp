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
    SPELL_POWERFULLHEALINGWARD      = 24309,
    SPELL_HEX                       = 24053,
    SPELL_DELUSIONSOFJINDO          = 24306,
    //Healing Ward Spell
    SPELL_HEAL                      = 24311,
    //Shade of Jindo Spell
    SPELL_SHADEOFJINDO_PASSIVE      = 24307,
    SPELL_SHADEOFJINDO_VISUAL       = 24313,
    SPELL_SHADOWSHOCK               = 19460
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
public:
    boss_jindo() : CreatureScript("boss_jindo") { }

    struct boss_jindoAI : public BossAI
    {
        boss_jindoAI(Creature* creature) : BossAI(creature, DATA_JINDO) { }

        void Reset() override
        {
            _Reset();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_BRAINWASHTOTEM, 20000);
            events.ScheduleEvent(EVENT_POWERFULLHEALINGWARD, 16000);
            events.ScheduleEvent(EVENT_HEX, 8000);
            events.ScheduleEvent(EVENT_DELUSIONSOFJINDO, 10000);
            events.ScheduleEvent(EVENT_TELEPORT, 5000);
            Talk(SAY_AGGRO);
        }

        void JustSummoned(Creature* summon) override
        {
            BossAI::JustSummoned(summon);

            switch (summon->GetEntry())
            {
                case NPC_BRAIN_WASH_TOTEM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
                    {
                        summon->CastSpell(target, summon->m_spells[0], true);
                    }
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
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
                    case EVENT_POWERFULLHEALINGWARD:
                        DoCastSelf(SPELL_POWERFULLHEALINGWARD, true);
                        events.ScheduleEvent(EVENT_POWERFULLHEALINGWARD, urand(14000, 20000));
                        break;
                    case EVENT_HEX:
                        DoCastVictim(SPELL_HEX, true);
                        events.ScheduleEvent(EVENT_HEX, urand(12000, 20000));
                        break;
                    case EVENT_DELUSIONSOFJINDO: // HACK
                        // Casting the delusion curse with a shade so shade will attack the same target with the curse.
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
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
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        {
                            DoTeleportPlayer(target, TeleportLoc.m_positionX, TeleportLoc.m_positionY, TeleportLoc.m_positionZ, TeleportLoc.GetOrientation());
                            if (GetThreat(me->GetVictim()))
                                ModifyThreatByPercent(target, -100);
                            Creature* SacrificedTroll;
                            SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, TeleportLoc.m_positionX + 2, TeleportLoc.m_positionY, TeleportLoc.m_positionZ, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            if (SacrificedTroll)
                                SacrificedTroll->AI()->AttackStart(target);
                            SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, TeleportLoc.m_positionX - 2, TeleportLoc.m_positionY, TeleportLoc.m_positionZ, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            if (SacrificedTroll)
                                SacrificedTroll->AI()->AttackStart(target);
                            SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, TeleportLoc.m_positionX + 4, TeleportLoc.m_positionY, TeleportLoc.m_positionZ, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            if (SacrificedTroll)
                                SacrificedTroll->AI()->AttackStart(target);
                            SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, TeleportLoc.m_positionX - 4, TeleportLoc.m_positionY, TeleportLoc.m_positionZ, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            if (SacrificedTroll)
                                SacrificedTroll->AI()->AttackStart(target);
                            SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, TeleportLoc.m_positionX, TeleportLoc.m_positionY + 2, TeleportLoc.m_positionZ, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            if (SacrificedTroll)
                                SacrificedTroll->AI()->AttackStart(target);
                            SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, TeleportLoc.m_positionX, TeleportLoc.m_positionY - 2, TeleportLoc.m_positionZ, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            if (SacrificedTroll)
                                SacrificedTroll->AI()->AttackStart(target);
                            SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, TeleportLoc.m_positionX, TeleportLoc.m_positionY + 4, TeleportLoc.m_positionZ, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            if (SacrificedTroll)
                                SacrificedTroll->AI()->AttackStart(target);
                            SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, TeleportLoc.m_positionX, TeleportLoc.m_positionY - 4, TeleportLoc.m_positionZ, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            if (SacrificedTroll)
                                SacrificedTroll->AI()->AttackStart(target);
                            SacrificedTroll = me->SummonCreature(NPC_SACRIFICED_TROLL, TeleportLoc.m_positionX + 3, TeleportLoc.m_positionY, TeleportLoc.m_positionZ, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
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

        bool CanAIAttack(Unit const* target) const override
        {
            return !target->HasAura(SPELL_HEX);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<boss_jindoAI>(creature);
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

        void Reset() override
        {
            Heal_Timer = 2000;
        }

        void EnterCombat(Unit* /*who*/) override
        {
        }

        void UpdateAI(uint32 diff) override
        {
            //Heal_Timer
            if (Heal_Timer <= diff)
            {
                Unit* pJindo = ObjectAccessor::GetUnit(*me, instance->GetGuidData(DATA_JINDO));
                if (pJindo)
                    DoCast(pJindo, SPELL_HEAL);
                Heal_Timer = 3000;
            }
            else Heal_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<npc_healing_wardAI>(creature);
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

        void Reset() override
        {
            ShadowShock_Timer = 1000;
            DoCastSelf(SPELL_SHADEOFJINDO_PASSIVE, true);
            DoCastSelf(SPELL_SHADEOFJINDO_VISUAL, true);
        }

        void EnterCombat(Unit* /*who*/) override { }

        void UpdateAI(uint32 diff) override
        {
            //ShadowShock_Timer
            if (ShadowShock_Timer <= diff)
            {
                DoCastVictim(SPELL_SHADOWSHOCK);
                ShadowShock_Timer = 2000;
            }
            else ShadowShock_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<npc_shade_of_jindoAI>(creature);
    }
};

void AddSC_boss_jindo()
{
    new boss_jindo();
    new npc_healing_ward();
    new npc_shade_of_jindo();
}
