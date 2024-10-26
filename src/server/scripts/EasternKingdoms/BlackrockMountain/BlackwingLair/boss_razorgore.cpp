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
#include "GameObjectScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "blackwing_lair.h"

enum Say
{
    SAY_EGGS_BROKEN1            = 0,
    SAY_EGGS_BROKEN2            = 1,
    SAY_EGGS_BROKEN3            = 2,
    SAY_DEATH                   = 3,

    EMOTE_TROOPS_RETREAT        = 0
};

enum Spells
{
    SPELL_MINDCONTROL           = 19832,
    SPELL_MINDCONTROL_VISUAL    = 45537,
    SPELL_EGG_DESTROY           = 19873,
    SPELL_MIND_EXHAUSTION       = 23958,

    SPELL_CLEAVE                = 19632,
    SPELL_WARSTOMP              = 24375,
    SPELL_FIREBALLVOLLEY        = 22425,
    SPELL_CONFLAGRATION         = 23023,

    SPELL_EXPLODE_ORB           = 20037,
    SPELL_EXPLOSION             = 20038, // Instakill everything.

    SPELL_WARMING_FLAMES        = 23040,
};

enum Summons
{
    NPC_ELITE_DRACHKIN          = 12422,
    NPC_ELITE_WARRIOR           = 12458,
    NPC_WARRIOR                 = 12416,
    NPC_MAGE                    = 12420,
    NPC_WARLOCK                 = 12459,

    GO_EGG                      = 177807
};

enum EVENTS
{
    EVENT_CLEAVE                = 1,
    EVENT_STOMP                 = 2,
    EVENT_FIREBALL              = 3,
    EVENT_CONFLAGRATION         = 4
};

class boss_razorgore : public CreatureScript
{
public:
    boss_razorgore() : CreatureScript("boss_razorgore") { }

    struct boss_razorgoreAI : public BossAI
    {
        boss_razorgoreAI(Creature* creature) : BossAI(creature, DATA_RAZORGORE_THE_UNTAMED) { }

        void Reset() override
        {
            _Reset();
            _charmerGUID.Clear();
            secondPhase = false;
            summons.DespawnAll();
            instance->SetData(DATA_EGG_EVENT, NOT_STARTED);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (secondPhase)
            {
                _JustDied();
            }
            else
            {
                // Respawn shorty in case of failure during phase 1.
                me->SetCorpseRemoveTime(25);
                me->SetRespawnTime(30);
                me->SaveRespawnTime();

                // Might not be required, safe measure.
                me->SetLootRecipient(nullptr);

                instance->SetData(DATA_EGG_EVENT, FAIL);
            }
        }

        bool CanAIAttack(Unit const* target) const override
        {
            if (target->IsCreature() && !secondPhase)
            {
                return false;
            }

            if (me->GetThreatMgr().GetThreatListSize() > 1)
            {
                ThreatContainer::StorageType::const_iterator lastRef = me->GetThreatMgr().GetOnlineContainer().GetThreatList().end();
                --lastRef;
                if (Unit* lastTarget = (*lastRef)->getTarget())
                {
                    if (lastTarget != target)
                    {
                        return !target->HasAura(SPELL_CONFLAGRATION);
                    }
                }
            }

            return true;
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();

            events.ScheduleEvent(EVENT_CLEAVE, 15s);
            events.ScheduleEvent(EVENT_STOMP, 35s);
            events.ScheduleEvent(EVENT_FIREBALL, 7s);
            events.ScheduleEvent(EVENT_CONFLAGRATION, 12s);

            instance->SetData(DATA_EGG_EVENT, IN_PROGRESS);
        }

        void DoChangePhase()
        {
            secondPhase = true;
            _charmerGUID.Clear();
            me->RemoveAllAuras();

            DoCastSelf(SPELL_WARMING_FLAMES, true);

            if (Creature* troops = instance->GetCreature(DATA_NEFARIAN_TROOPS))
            {
                troops->AI()->Talk(EMOTE_TROOPS_RETREAT);
            }

            for (ObjectGuid const& guid : _summonGUIDS)
            {
                if (Creature* creature = ObjectAccessor::GetCreature(*me, guid))
                {
                    if (creature->IsAlive())
                    {
                        creature->CombatStop(true);
                        creature->SetReactState(REACT_PASSIVE);
                        creature->GetMotionMaster()->MovePoint(0, Position(-7560.568848f, -1028.553345f, 408.491211f, 0.523858f));
                    }
                }
            }
        }

        void SetGUID(ObjectGuid const guid, int32 /*id*/) override
        {
            _charmerGUID = guid;
        }

        void OnCharmed(bool apply) override
        {
            if (apply)
            {
                if (Unit* charmer = ObjectAccessor::GetUnit(*me, _charmerGUID))
                {
                    charmer->CastSpell(charmer, SPELL_MIND_EXHAUSTION, true);
                    charmer->CastSpell(me, SPELL_MINDCONTROL_VISUAL, false);
                }
            }
            else
            {
                if (Unit* charmer = ObjectAccessor::GetUnit(*me, _charmerGUID))
                {
                    charmer->RemoveAurasDueToSpell(SPELL_MINDCONTROL_VISUAL);
                    me->TauntApply(charmer);
                }
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_PHASE_TWO)
            {
                DoChangePhase();
            }

            if (action == TALK_EGG_BROKEN_RAND)
            {
                Talk(urand(SAY_EGGS_BROKEN1, SAY_EGGS_BROKEN3));
            }
        }

        void JustSummoned(Creature* summon) override
        {
            _summonGUIDS.push_back(summon->GetGUID());
            summon->SetOwnerGUID(me->GetGUID());
            summons.Summon(summon);
        }

        void SummonMovementInform(Creature* summon, uint32 movementType, uint32 /*pathId*/) override
        {
            if (movementType == POINT_MOTION_TYPE)
            {
                summon->DespawnOrUnsummon();
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!secondPhase && damage >= me->GetHealth())
            {
                Talk(SAY_DEATH);
                DoCastAOE(SPELL_EXPLODE_ORB);
                DoCastAOE(SPELL_EXPLOSION);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (!me->IsCharmed())
            {
                events.Update(diff);
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CLEAVE:
                        DoCastVictim(SPELL_CLEAVE);
                        events.ScheduleEvent(EVENT_CLEAVE, 7s, 10s);
                        break;
                    case EVENT_STOMP:
                        DoCastVictim(SPELL_WARSTOMP);
                        events.ScheduleEvent(EVENT_STOMP, 15s, 25s);
                        break;
                    case EVENT_FIREBALL:
                        DoCastVictim(SPELL_FIREBALLVOLLEY);
                        events.ScheduleEvent(EVENT_FIREBALL, 12s, 15s);
                        break;
                    case EVENT_CONFLAGRATION:
                        DoCastVictim(SPELL_CONFLAGRATION);
                        events.ScheduleEvent(EVENT_CONFLAGRATION, 30s);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        bool secondPhase;
        ObjectGuid _charmerGUID;
        GuidVector _summonGUIDS;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackwingLairAI<boss_razorgoreAI>(creature);
    }
};

class go_orb_of_domination : public GameObjectScript
{
public:
    go_orb_of_domination() : GameObjectScript("go_orb_of_domination") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
            if (instance->GetData(DATA_EGG_EVENT) != DONE && !player->HasAura(SPELL_MIND_EXHAUSTION) && !player->GetPet())
                if (Creature* razor = ObjectAccessor::GetCreature(*go, instance->GetGuidData(DATA_RAZORGORE_THE_UNTAMED)))
                {
                    razor->AI()->SetGUID(player->GetGUID());
                    razor->Attack(player, true);
                    player->CastSpell(razor, SPELL_MINDCONTROL);
                }
        return true;
    }
};

class spell_egg_event : public SpellScript
{
    PrepareSpellScript(spell_egg_event);

    void HandleOnHit()
    {
        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
        {
            instance->SetData(DATA_EGG_EVENT, SPECIAL);
        }

        if (Creature* razorgore = GetCaster()->ToCreature())
        {
            if (GameObject* egg = GetHitGObj())
            {
                razorgore->AI()->DoAction(TALK_EGG_BROKEN_RAND);
                egg->SetLootState(GO_READY);
                egg->UseDoorOrButton(10000);
                egg->SetRespawnTime(WEEK);
            }
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_egg_event::HandleOnHit);
    }
};

void AddSC_boss_razorgore()
{
    new boss_razorgore();
    new go_orb_of_domination();
    RegisterSpellScript(spell_egg_event);
}
