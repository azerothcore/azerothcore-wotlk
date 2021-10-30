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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ObjectAccessor.h"

enum Texts
{
    SAY_AGGRO                       = 0,
    SAY_SPAWN                       = 1,
    SAY_SLAY                        = 2,
    SAY_SPECIAL                     = 3,
    SAY_DEFEAT                      = 4,
    SAY_SUMMON_MAJ                  = 5,
    SAY_ARRIVAL2_MAJ                = 6,
    SAY_LAST_ADD                    = 7,
};

enum Spells
{
    SPELL_MAGIC_REFLECTION          = 20619,
    SPELL_DAMAGE_REFLECTION         = 21075,
    SPELL_BLAST_WAVE                = 20229,
    SPELL_AEGIS_OF_RAGNAROS         = 20620,
    SPELL_TELEPORT                  = 20618,
    SPELL_ENCOURAGEMENT             = 21086,
    SPELL_CHAMPION                  = 21090,    // Server side
    SPELL_IMMUNE_POLY               = 21087,    // Server side
    SPELL_HATE_TO_ZERO              = 20538,    // Threat reset after each teleport. Server side
    SPELL_SEPARATION_ANXIETY        = 21094,    // Aura cast on himself by Majordomo Executus, if adds move out of range, they will cast spell 21095 on themselves
    SPELL_SEPARATION_ANXIETY_MINION = 21095,

    // Outro & Ragnaros intro
    SPELL_TELEPORT_SELF             = 19484,
    SPELL_SUMMON_RAGNAROS           = 19774,
    SPELL_ELEMENTAL_FIRE            = 19773,
    SPELL_RAGNA_EMERGE              = 20568,
};

enum Events
{
    EVENT_MAGIC_REFLECTION  = 1,
    EVENT_DAMAGE_REFLECTION,
    EVENT_BLAST_WAVE,
    EVENT_TELEPORT,
    EVENT_AEGIS_OF_RAGNAROS,

    EVENT_OUTRO_1,
    EVENT_OUTRO_2,
    EVENT_OUTRO_3,
};

enum Misc
{
    GOSSIP_HELLO        = 4995,
    FACTION_FRIENDLY    = 35,
    SUMMON_GROUP_ADDS   = 1,

    // Event phases
    EVENT_NORMAL_COMBAT = 0x01,
    EVENT_OUTRO_EVENT   = 0x02,
};

Position const RagnarosSummonPos = {838.510f, -829.840f, -232.000f, 2.0f};
class boss_majordomo : public CreatureScript
{
public:
    boss_majordomo() : CreatureScript("boss_majordomo") {}

    struct boss_majordomoAI : public BossAI
    {
        boss_majordomoAI(Creature* creature) : BossAI(creature, DATA_MAJORDOMO_EXECUTUS) {}

        // Disabled events
        void JustDied(Unit* /*killer*/) override {}

        void InitializeAI() override
        {
            BossAI::InitializeAI();
            if (instance->GetBossState(DATA_MAJORDOMO_EXECUTUS) != DONE)
            {
                std::list<TempSummon*> p_summons;
                me->SummonCreatureGroup(SUMMON_GROUP_ADDS, &p_summons);
                if (!p_summons.empty())
                {
                    for (TempSummon const* summon : p_summons)
                    {
                        if (summon)
                        {
                            static_minionsGUIDS.insert(summon->GetGUID());
                        }
                    }
                }
            }
        }

        void Reset() override
        {
            me->ResetLootMode();
            events.Reset();
            aliveMinionsGUIDS.clear();

            if (instance->GetBossState(DATA_MAJORDOMO_EXECUTUS) != DONE)
            {
                events.SetPhase(EVENT_NORMAL_COMBAT);
                instance->SetBossState(DATA_MAJORDOMO_EXECUTUS, NOT_STARTED);
            }
            else
            {
                static_minionsGUIDS.clear();
                summons.DespawnAll();
                events.SetPhase(EVENT_OUTRO_EVENT);
            }
        }

        bool CanAIAttack(Unit const* /*target*/) const override
        {
            return instance->GetBossState(DATA_MAJORDOMO_EXECUTUS) != DONE;
        }

        void KilledUnit(Unit* victim) override
        {
            if (roll_chance_i(25) && victim->IsPlayer())
            {
                Talk(SAY_SLAY);
            }
        }

        void EnterCombat(Unit* /*attacker*/) override
        {
            _EnterCombat();
            Talk(SAY_AGGRO);
            DoCastSelf(SPELL_AEGIS_OF_RAGNAROS, true);
            events.ScheduleEvent(EVENT_MAGIC_REFLECTION, 30000, EVENT_NORMAL_COMBAT, EVENT_NORMAL_COMBAT);
            events.ScheduleEvent(EVENT_DAMAGE_REFLECTION, 15000, EVENT_NORMAL_COMBAT, EVENT_NORMAL_COMBAT);
            events.ScheduleEvent(EVENT_BLAST_WAVE, 10000, EVENT_NORMAL_COMBAT, EVENT_NORMAL_COMBAT);
            events.ScheduleEvent(EVENT_TELEPORT, 20000, EVENT_NORMAL_COMBAT, EVENT_NORMAL_COMBAT);

            aliveMinionsGUIDS.clear();
            aliveMinionsGUIDS = static_minionsGUIDS;
        }

        void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
        {
            aliveMinionsGUIDS.erase(summon->GetGUID());
            if (summon->GetEntry() == NPC_FLAMEWAKER_HEALER || summon->GetEntry() == NPC_FLAMEWAKER_ELITE)
            {
                uint32 const remainingAdds = std::count_if(aliveMinionsGUIDS.begin(), aliveMinionsGUIDS.end(), [](ObjectGuid const& summonGuid)
                {
                    return summonGuid.GetEntry() == NPC_FLAMEWAKER_HEALER || summonGuid.GetEntry() == NPC_FLAMEWAKER_ELITE;
                });

                // Last remaining add
                if (remainingAdds == 1)
                {
                    Talk(SAY_LAST_ADD);
                    DoCastAOE(SPELL_CHAMPION);
                }
                // 50% of adds
                else if (remainingAdds == 4)
                {
                    DoCastAOE(SPELL_IMMUNE_POLY);
                }
                else if (!remainingAdds)
                {
                    instance->SetBossState(DATA_MAJORDOMO_EXECUTUS, DONE);
                    events.CancelEventGroup(EVENT_NORMAL_COMBAT);
                    me->GetMap()->UpdateEncounterState(ENCOUNTER_CREDIT_KILL_CREATURE, me->GetEntry(), me);
                    me->setFaction(FACTION_FRIENDLY);
                    EnterEvadeMode();
                    Talk(SAY_DEFEAT);
                    return;
                }
                DoCastAOE(SPELL_ENCOURAGEMENT);
            }
        }

        void JustReachedHome() override
        {
            _JustReachedHome();
            if (instance->GetBossState(DATA_MAJORDOMO_EXECUTUS) == DONE)
            {
                events.Reset();
                events.ScheduleEvent(EVENT_OUTRO_1, 32000);
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*dmgType*/, SpellSchoolMask /*school*/) override
        {
            if (me->GetHealth() <= damage)
            {
                damage = 0;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (events.IsInPhase(EVENT_NORMAL_COMBAT))
            {
                if (!UpdateVictim())
                {
                    return;
                }

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }

                while (uint32 const eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_MAGIC_REFLECTION:
                        {
                            DoCastSelf(SPELL_MAGIC_REFLECTION);
                            events.RepeatEvent(30000);
                            break;
                        }
                        case EVENT_DAMAGE_REFLECTION:
                        {
                            DoCastSelf(SPELL_DAMAGE_REFLECTION);
                            events.RepeatEvent(30000);
                            break;
                        }
                        case EVENT_BLAST_WAVE:
                        {
                            DoCastVictim(SPELL_BLAST_WAVE);
                            events.ScheduleEvent(EVENT_BLAST_WAVE, 10000);
                            break;
                        }
                        case EVENT_TELEPORT:
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true))
                            {
                                DoCast(target, SPELL_TELEPORT);
                            }

                            events.RepeatEvent(20000);
                            break;
                        }
                    }

                    if (me->HasUnitState(UNIT_STATE_CASTING))
                    {
                        return;
                    }
                }

                DoMeleeAttackIfReady();
            }
            else if (!events.Empty())
            {
                events.Update(diff);

                while (uint32 const eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_OUTRO_1:
                        {
                            me->NearTeleportTo(RagnarosTelePos.GetPositionX(), RagnarosTelePos.GetPositionY(), RagnarosTelePos.GetPositionZ(), RagnarosTelePos.GetOrientation());
                            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                            break;
                        }
                        case EVENT_OUTRO_2:
                        {
                            instance->instance->SummonCreature(NPC_RAGNAROS, RagnarosSummonPos);
                            break;
                        }
                        case EVENT_OUTRO_3:
                        {
                            Talk(SAY_ARRIVAL2_MAJ);
                            break;
                        }
                    }
                }
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_RAGNAROS && events.GetNextEventTime(EVENT_OUTRO_2) == 0)
            {
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                Talk(SAY_SUMMON_MAJ);
                events.ScheduleEvent(EVENT_OUTRO_2, 8000);
                events.ScheduleEvent(EVENT_OUTRO_3, 24000);
            }
            else if (action == ACTION_START_RAGNAROS_ALT)
            {
                me->setFaction(FACTION_FRIENDLY);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }
        }

    private:
        GuidSet static_minionsGUIDS;    // contained data should be changed on encounter completion
        GuidSet aliveMinionsGUIDS;      // used for calculations
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        AddGossipItemFor(player, 4093, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        SendGossipMenuFor(player, GOSSIP_HELLO, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        creature->AI()->DoAction(ACTION_START_RAGNAROS);
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_majordomoAI>(creature);
    }
};

void AddSC_boss_majordomo()
{
    new boss_majordomo();
}
