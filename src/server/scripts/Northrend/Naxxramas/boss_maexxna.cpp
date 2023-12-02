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
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

enum Spells
{
    SPELL_WEB_WRAP                      = 28622,
    SPELL_WEB_SPRAY_10                  = 29484,
    SPELL_WEB_SPRAY_25                  = 54125,
    SPELL_POISON_SHOCK_10               = 28741,
    SPELL_POISON_SHOCK_25               = 54122,
    SPELL_NECROTIC_POISON_10            = 54121,
    SPELL_NECROTIC_POISON_25            = 28776,
    SPELL_FRENZY_10                     = 54123,
    SPELL_FRENZY_25                     = 54124
};

enum Events
{
    EVENT_WEB_SPRAY                     = 1,
    EVENT_POISON_SHOCK                  = 2,
    EVENT_NECROTIC_POISON               = 3,
    EVENT_WEB_WRAP                      = 4,
    EVENT_HEALTH_CHECK                  = 5,
    EVENT_SUMMON_SPIDERLINGS            = 6
};

enum Emotes
{
    EMOTE_SPIDERS                       = 0,
    EMOTE_WEB_WRAP                      = 1,
    EMOTE_WEB_SPRAY                     = 2
};

enum Misc
{
    NPC_WEB_WRAP                        = 16486,
    NPC_MAEXXNA_SPIDERLING              = 17055
};

const Position PosWrap[3] =
{
    {3546.796f, -3869.082f, 296.450f, 0.0f},
    {3531.271f, -3847.424f, 299.450f, 0.0f},
    {3497.067f, -3843.384f, 302.384f, 0.0f}
};

class boss_maexxna : public CreatureScript
{
public:
    boss_maexxna() : CreatureScript("boss_maexxna") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_maexxnaAI>(pCreature);
    }

    struct boss_maexxnaAI : public BossAI
    {
        explicit boss_maexxnaAI(Creature* c) : BossAI(c, BOSS_MAEXXNA), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        bool IsInRoom()
        {
            if (me->GetExactDist(3486.6f, -3890.6f, 291.8f) > 100.0f)
            {
                EnterEvadeMode();
                return false;
            }
            return true;
        }

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_MAEXXNA_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_WEB_WRAP, 20s);
            events.ScheduleEvent(EVENT_WEB_SPRAY, 40s);
            events.ScheduleEvent(EVENT_POISON_SHOCK, 10s);
            events.ScheduleEvent(EVENT_NECROTIC_POISON, 5s);
            events.ScheduleEvent(EVENT_HEALTH_CHECK, 1s);
            events.ScheduleEvent(EVENT_SUMMON_SPIDERLINGS, 30s);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_MAEXXNA_GATE)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
            }
        }

        void JustSummoned(Creature* cr) override
        {
            if (cr->GetEntry() == NPC_MAEXXNA_SPIDERLING)
            {
                cr->SetInCombatWithZone();
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                {
                    cr->AI()->AttackStart(target);
                }
            }
            summons.Summon(cr);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER && pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            summons.DespawnAll();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!IsInRoom())
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_WEB_SPRAY:
                    Talk(EMOTE_WEB_SPRAY);
                    me->CastSpell(me, RAID_MODE(SPELL_WEB_SPRAY_10, SPELL_WEB_SPRAY_25), true);
                    events.Repeat(40s);
                    break;
                case EVENT_POISON_SHOCK:
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_POISON_SHOCK_10, SPELL_POISON_SHOCK_25), false);
                    events.Repeat(10s);
                    break;
                case EVENT_NECROTIC_POISON:
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_NECROTIC_POISON_10, SPELL_NECROTIC_POISON_25), false);
                    events.Repeat(30s);
                    break;
                case EVENT_SUMMON_SPIDERLINGS:
                    Talk(EMOTE_SPIDERS);
                    for (uint8 i = 0; i < 8; ++i)
                    {
                        me->SummonCreature(NPC_MAEXXNA_SPIDERLING, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                    }
                    events.Repeat(40s);
                    break;
                case EVENT_HEALTH_CHECK:
                    if (me->GetHealthPct() < 30)
                    {
                        me->CastSpell(me, RAID_MODE(SPELL_FRENZY_10, SPELL_FRENZY_25), true);
                        break;
                    }
                    events.Repeat(1s);
                    break;
                case EVENT_WEB_WRAP:
                    Talk(EMOTE_WEB_WRAP);
                    for (uint8 i = 0; i < RAID_MODE(1, 2); ++i)
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 0, true, true, -SPELL_WEB_WRAP))
                        {
                            target->RemoveAura(RAID_MODE(SPELL_WEB_SPRAY_10, SPELL_WEB_SPRAY_25));
                            uint8 pos = urand(0, 2);
                            if (Creature* wrap = me->SummonCreature(NPC_WEB_WRAP, PosWrap[pos].GetPositionX(), PosWrap[pos].GetPositionY(), PosWrap[pos].GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                            {
                                wrap->AI()->SetGUID(target->GetGUID());
                                target->GetMotionMaster()->MoveJump(PosWrap[pos].GetPositionX(), PosWrap[pos].GetPositionY(), PosWrap[pos].GetPositionZ(), 20, 20);
                            }
                        }
                    }
                    events.Repeat(40s);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class boss_maexxna_webwrap : public CreatureScript
{
public:
    boss_maexxna_webwrap() : CreatureScript("boss_maexxna_webwrap") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_maexxna_webwrapAI>(pCreature);
    }

    struct boss_maexxna_webwrapAI : public NullCreatureAI
    {
        explicit boss_maexxna_webwrapAI(Creature* c) : NullCreatureAI(c) {}

        ObjectGuid victimGUID;

        void SetGUID(ObjectGuid guid, int32  /*param*/) override
        {
            victimGUID = guid;

            if (me->m_spells[0] && victimGUID)
            {
                if (Unit* victim = ObjectAccessor::GetUnit(*me, victimGUID))
                {
                    victim->CastSpell(victim, me->m_spells[0], true, nullptr, nullptr, me->GetGUID());
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (me->m_spells[0] && victimGUID)
            {
                if (Unit* victim = ObjectAccessor::GetUnit(*me, victimGUID))
                {
                    victim->RemoveAurasDueToSpell(me->m_spells[0], me->GetGUID());
                }
            }
        }
    };
};

void AddSC_boss_maexxna()
{
    new boss_maexxna();
    new boss_maexxna_webwrap();
}
