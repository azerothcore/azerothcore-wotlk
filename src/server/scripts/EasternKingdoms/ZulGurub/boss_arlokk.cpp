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
TCName: Boss_Arlokk
TC%Complete: 95
TCComment: Wrong cleave and red aura is missing not yet added.
TCComment: Prowlers moving through wall hopefully mmaps will fix.
TCComment: Can't test LOS until mmaps.
TCCategory: Zul'Gurub
EndScriptData */

#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "zulgurub.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_FEAST_PROWLER           = 1,
    SAY_DEATH                   = 2
};

enum Spells
{
    SPELL_SHADOW_WORD_PAIN      = 24212, // Corrected
    SPELL_GOUGE                 = 12540, // Corrected
    SPELL_MARK_OF_ARLOKK        = 24210, // triggered spell 24211 Added to spell_dbc
    SPELL_RAVAGE                = 24213, // Corrected
    SPELL_CLEAVE                = 25174, // Searching for right spell
    SPELL_PANTHER_TRANSFORM     = 24190, // Transform to panther now used
    SPELL_SUMMON_PROWLER        = 24246, // Added to Spell_dbc
    SPELL_VANISH_VISUAL         = 24222, // Added
    SPELL_VANISH                = 24223, // Added
    SPELL_SUPER_INVIS           = 24235  // Added to Spell_dbc
};

enum Events
{
    EVENT_SHADOW_WORD_PAIN      = 1,
    EVENT_GOUGE                 = 2,
    EVENT_MARK_OF_ARLOKK        = 3,
    EVENT_RAVAGE                = 4,
    EVENT_TRANSFORM             = 5,
    EVENT_VANISH                = 6,
    EVENT_VANISH_2              = 7,
    EVENT_TRANSFORM_BACK        = 8,
    EVENT_VISIBLE               = 9,
    EVENT_SUMMON_PROWLERS       = 10
};

enum Phases
{
    PHASE_ALL                   = 0,
    PHASE_ONE                   = 1,
    PHASE_TWO                   = 2
};

enum Weapon
{
    WEAPON_DAGGER               = 10616
};

enum Misc
{
    MAX_PROWLERS_PER_SIDE       = 15
};

Position const PosMoveOnSpawn[1] =
{
    { -11561.9f, -1627.868f, 41.29941f, 0.0f }
};

class boss_arlokk : public CreatureScript
{
public:
    boss_arlokk() : CreatureScript("boss_arlokk") { }

    struct boss_arlokkAI : public BossAI
    {
        boss_arlokkAI(Creature* creature) : BossAI(creature, DATA_ARLOKK) { }

        void Reset() override
        {
            if (events.IsInPhase(PHASE_TWO))
                me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, false); // hack
            _Reset();
            _summonCountA = 0;
            _summonCountB = 0;
            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(WEAPON_DAGGER));
            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, uint32(WEAPON_DAGGER));
            me->SetWalk(false);
            me->SetHomePosition(PosMoveOnSpawn[0]);
            me->GetMotionMaster()->MoveTargetedHome();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 7s, 9s, 0, PHASE_ONE);
            events.ScheduleEvent(EVENT_GOUGE, 12s, 15s, 0, PHASE_ONE);
            events.ScheduleEvent(EVENT_SUMMON_PROWLERS, 6s, 0, PHASE_ALL);
            events.ScheduleEvent(EVENT_MARK_OF_ARLOKK, 9s, 11s, 0, PHASE_ALL);
            events.ScheduleEvent(EVENT_TRANSFORM, 30s, 0, PHASE_ONE);
            Talk(SAY_AGGRO);

            // Sets up list of Panther spawners to cast on
            std::list<Creature*> triggerList;
            GetCreatureListWithEntryInGrid(triggerList, me, NPC_PANTHER_TRIGGER, 100.0f);
            if (!triggerList.empty())
            {
                uint8 sideA = 0;
                uint8 sideB = 0;
                for (auto const& trigger : triggerList)
                {
                    if (trigger->GetPositionY() < -1625.0f)
                    {
                        _triggersSideAGUID[sideA] = trigger->GetGUID();
                        ++sideA;
                    }
                    else
                    {
                        _triggersSideBGUID[sideB] = trigger->GetGUID();
                        ++sideB;
                    }
                }
            }
        }

        void JustReachedHome() override
        {
            if (GameObject* object = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(GO_GONG_OF_BETHEKK)))
                object->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
            me->DespawnOrUnsummon();
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            BossAI::EnterEvadeMode(why);

            std::list<Creature*> panthers;
            GetCreatureListWithEntryInGrid(panthers, me, NPC_ZULIAN_PROWLER, 200.f);
            for (auto const& panther : panthers)
                panther->DespawnOrUnsummon();
        }

        void SetData(uint32 id, uint32 /*value*/) override
        {
            if (id == 1)
                --_summonCountA;
            else if (id == 2)
                --_summonCountB;
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
                    case EVENT_SHADOW_WORD_PAIN:
                        DoCastVictim(SPELL_SHADOW_WORD_PAIN, true);
                        events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 5s, 7s, 0, PHASE_ONE);
                        break;
                    case EVENT_GOUGE:
                        DoCastVictim(SPELL_GOUGE, true);
                        break;
                    case EVENT_SUMMON_PROWLERS:
                        if (_summonCountA < MAX_PROWLERS_PER_SIDE)
                        {
                            if (Unit* trigger = ObjectAccessor::GetUnit(*me, _triggersSideAGUID[urand(0, 4)]))
                            {
                                trigger->CastSpell(trigger, SPELL_SUMMON_PROWLER);
                                ++_summonCountA;
                            }
                        }
                        if (_summonCountB < MAX_PROWLERS_PER_SIDE)
                        {
                            if (Unit* trigger = ObjectAccessor::GetUnit(*me, _triggersSideBGUID[urand(0, 4)]))
                            {
                                trigger->CastSpell(trigger, SPELL_SUMMON_PROWLER);
                                ++_summonCountB;
                            }
                        }
                        events.ScheduleEvent(EVENT_SUMMON_PROWLERS, 6s, 0, PHASE_ALL);
                        break;
                    case EVENT_MARK_OF_ARLOKK:
                        {
                            Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, urand(1, 3), 0.0f, false, true, -SPELL_MARK_OF_ARLOKK);
                            if (!target)
                                target = me->GetVictim();
                            if (target)
                            {
                                DoCast(target, SPELL_MARK_OF_ARLOKK, true);
                                Talk(SAY_FEAST_PROWLER, target);
                            }
                            events.ScheduleEvent(EVENT_MARK_OF_ARLOKK, 120s, 130s);
                            break;
                        }
                    case EVENT_TRANSFORM:
                        {
                            DoCastSelf(SPELL_PANTHER_TRANSFORM); // SPELL_AURA_TRANSFORM
                            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(EQUIP_UNEQUIP));
                            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, uint32(EQUIP_UNEQUIP));
                            me->AttackStop();
                            DoResetThreatList();
                            me->SetReactState(REACT_PASSIVE);
                            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                            DoCastSelf(SPELL_VANISH_VISUAL);
                            DoCastSelf(SPELL_VANISH);
                            events.ScheduleEvent(EVENT_VANISH, 1s, 0, PHASE_ONE);
                            break;
                        }
                    case EVENT_VANISH:
                        DoCastSelf(SPELL_SUPER_INVIS);
                        me->SetWalk(false);
                        me->GetMotionMaster()->MovePoint(0, frand(-11551.0f, -11508.0f), frand(-1638.0f, -1617.0f), me->GetPositionZ());
                        events.ScheduleEvent(EVENT_VANISH_2, 9s, 0, PHASE_ONE);
                        break;
                    case EVENT_VANISH_2:
                        DoCastSelf(SPELL_VANISH);
                        DoCastSelf(SPELL_SUPER_INVIS);
                        events.ScheduleEvent(EVENT_VISIBLE, 41s, 47s, 0, PHASE_ONE);
                        break;
                    case EVENT_VISIBLE:
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                            AttackStart(target);
                        me->RemoveAura(SPELL_SUPER_INVIS);
                        me->RemoveAura(SPELL_VANISH);
                        events.ScheduleEvent(EVENT_RAVAGE, 10s, 14s, 0, PHASE_TWO);
                        events.ScheduleEvent(EVENT_TRANSFORM_BACK, 30s, 40s, 0, PHASE_TWO);
                        events.SetPhase(PHASE_TWO);
                        me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, true); // hack
                        break;
                    case EVENT_RAVAGE:
                        DoCastVictim(SPELL_RAVAGE, true);
                        events.ScheduleEvent(EVENT_RAVAGE, 10s, 14s, 0, PHASE_TWO);
                        break;
                    case EVENT_TRANSFORM_BACK:
                        {
                            me->RemoveAura(SPELL_PANTHER_TRANSFORM); // SPELL_AURA_TRANSFORM
                            DoCast(me, SPELL_VANISH_VISUAL);
                            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(WEAPON_DAGGER));
                            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, uint32(WEAPON_DAGGER));
                            me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, false); // hack
                            events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 4s, 7s, 0, PHASE_ONE);
                            events.ScheduleEvent(EVENT_GOUGE, 12s, 15s, 0, PHASE_ONE);
                            events.ScheduleEvent(EVENT_TRANSFORM, 30s, 0, PHASE_ONE);
                            events.SetPhase(PHASE_ONE);
                            break;
                        }
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint8 _summonCountA;
        uint8 _summonCountB;
        ObjectGuid _triggersSideAGUID[5];
        ObjectGuid _triggersSideBGUID[5];
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<boss_arlokkAI>(creature);
    }
};

/*######
## npc_zulian_prowler
######*/

enum ZulianProwlerSpells
{
    SPELL_SNEAK_RANK_1_1         = 22766,
    SPELL_SNEAK_RANK_1_2         = 7939,  // Added to Spell_dbc
    SPELL_MARK_OF_ARLOKK_TRIGGER = 24211  // Added to Spell_dbc
};

enum ZulianProwlerEvents
{
    EVENT_ATTACK                 = 1
};

class npc_zulian_prowler : public CreatureScript
{
public:
    npc_zulian_prowler() : CreatureScript("npc_zulian_prowler") { }

    struct npc_zulian_prowlerAI : public ScriptedAI
    {
        npc_zulian_prowlerAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()) { }

        void Reset() override
        {
            if (me->GetPositionY() < -1625.0f)
                _sideData = 1;
            else
                _sideData = 2;

            DoCast(me, SPELL_SNEAK_RANK_1_1);
            DoCast(me, SPELL_SNEAK_RANK_1_2);

            if (Unit* arlokk = ObjectAccessor::GetUnit(*me, _instance->GetGuidData(NPC_ARLOKK)))
                me->GetMotionMaster()->MovePoint(0, arlokk->GetPositionX(), arlokk->GetPositionY(), arlokk->GetPositionZ());
            _events.ScheduleEvent(EVENT_ATTACK, 6000);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->GetMotionMaster()->Clear(false);
            me->RemoveAura(SPELL_SNEAK_RANK_1_1);
            me->RemoveAura(SPELL_SNEAK_RANK_1_2);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_MARK_OF_ARLOKK_TRIGGER) // Should only hit if line of sight
            {
                AttackStart(caster);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Unit* arlokk = ObjectAccessor::GetUnit(*me, _instance->GetGuidData(NPC_ARLOKK)))
            {
                if (arlokk->IsAlive())
                    arlokk->GetAI()->SetData(_sideData, 0);
            }
            me->DespawnOrUnsummon(4000);
        }

        void UpdateAI(uint32 diff) override
        {
            if (UpdateVictim())
            {
                DoMeleeAttackIfReady();
                return;
            }

            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ATTACK:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0.0f, 100, false))
                        {
                            AttackStart(target);
                        }
                        break;
                    default:
                        break;
                }
            }
        }

    private:
        int32 _sideData;
        EventMap _events;
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<npc_zulian_prowlerAI>(creature);
    }
};

/*######
## go_gong_of_bethekk
######*/

Position const PosSummonArlokk[1] =
{
    { -11507.22f, -1628.062f, 41.38264f, 3.159046f }
};

class go_gong_of_bethekk : public GameObjectScript
{
public:
    go_gong_of_bethekk() : GameObjectScript("go_gong_of_bethekk") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (go->GetInstanceScript() && !go->FindNearestCreature(NPC_ARLOKK, 25.0f))
        {
            go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
            go->SendCustomAnim(0);
            go->SummonCreature(NPC_ARLOKK, PosSummonArlokk[0], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 600000);
        }

        return true;
    }
};

void AddSC_boss_arlokk()
{
    new boss_arlokk();
    new npc_zulian_prowler();
    new go_gong_of_bethekk();
}
