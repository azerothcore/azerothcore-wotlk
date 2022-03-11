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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "blackwing_lair.h"

enum Say
{
    SAY_EGGS_BROKEN1        = 0,
    SAY_EGGS_BROKEN2        = 1,
    SAY_EGGS_BROKEN3        = 2,
    SAY_DEATH               = 3,
};

enum Spells
{
    SPELL_MINDCONTROL       = 19832,
    SPELL_EGG_DESTROY       = 19873,
    SPELL_MIND_EXHAUSTION   = 23958,

    SPELL_CLEAVE            = 19632,
    SPELL_WARSTOMP          = 24375,
    SPELL_FIREBALLVOLLEY    = 22425,
    SPELL_CONFLAGRATION     = 23023,

    SPELL_EXPLODE_ORB       = 20037,
    SPELL_EXPLOSION         = 20038 // Instakill everything.
};

enum Summons
{
    NPC_ELITE_DRACHKIN      = 12422,
    NPC_ELITE_WARRIOR       = 12458,
    NPC_WARRIOR             = 12416,
    NPC_MAGE                = 12420,
    NPC_WARLOCK             = 12459,

    GO_EGG                  = 177807
};

enum EVENTS
{
    EVENT_CLEAVE            = 1,
    EVENT_STOMP             = 2,
    EVENT_FIREBALL          = 3,
    EVENT_CONFLAGRATION     = 4
};

class boss_razorgore : public CreatureScript
{
public:
    boss_razorgore() : CreatureScript("boss_razorgore") { }

    struct boss_razorgoreAI : public BossAI
    {
        boss_razorgoreAI(Creature* creature) : BossAI(creature, DATA_RAZORGORE_THE_UNTAMED) { }
        bool died;
        void Reset() override
        {
            _Reset();
            died = false;
            _charmerGUID.Clear();
            secondPhase = false;
            instance->SetData(DATA_EGG_EVENT, NOT_STARTED);
        }

        void JustDied(Unit* /*killer*/) override
        {
            //_JustDied();
            Talk(SAY_DEATH);
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return !(target->GetTypeId() == TYPEID_UNIT && !secondPhase);
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            _EnterCombat();

            instance->SetData(DATA_EGG_EVENT, IN_PROGRESS);
        }

        void DoChangePhase()
        {
            secondPhase = true;
            _charmerGUID.Clear();
            me->RemoveAllAuras();
            me->SetHealth(me->GetMaxHealth());

            events.ScheduleEvent(EVENT_CLEAVE, 15000);
            events.ScheduleEvent(EVENT_STOMP, 35000);
            events.ScheduleEvent(EVENT_FIREBALL, 7000);
            events.ScheduleEvent(EVENT_CONFLAGRATION, 12000);
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

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!secondPhase && damage >= me->GetHealth() && !died)
            {
                died = true;
                DoCastAOE(SPELL_EXPLODE_ORB);
                DoCastAOE(SPELL_EXPLOSION);
                me->SetCorpseRemoveTime(25);
                me->SetRespawnTime(30);
                me->SaveRespawnTime();
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
                    case EVENT_CLEAVE:
                        DoCastVictim(SPELL_CLEAVE);
                        events.ScheduleEvent(EVENT_CLEAVE, urand(7000, 10000));
                        break;
                    case EVENT_STOMP:
                        DoCastVictim(SPELL_WARSTOMP);
                        events.ScheduleEvent(EVENT_STOMP, urand(15000, 25000));
                        break;
                    case EVENT_FIREBALL:
                        DoCastVictim(SPELL_FIREBALLVOLLEY);
                        events.ScheduleEvent(EVENT_FIREBALL, urand(12000, 15000));
                        break;
                    case EVENT_CONFLAGRATION:
                        DoCastVictim(SPELL_CONFLAGRATION);
                        if (me->GetVictim() && me->GetVictim()->HasAura(SPELL_CONFLAGRATION))
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 100, true))
                                me->TauntApply(target);
                        events.ScheduleEvent(EVENT_CONFLAGRATION, 30000);
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }

    private:
        bool secondPhase;
        ObjectGuid _charmerGUID;
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
            if (instance->GetData(DATA_EGG_EVENT) != DONE && !player->HasAura(SPELL_MIND_EXHAUSTION))
                if (Creature* razor = ObjectAccessor::GetCreature(*go, instance->GetGuidData(DATA_RAZORGORE_THE_UNTAMED)))
                {
                    razor->AI()->SetGUID(player->GetGUID());
                    razor->Attack(player, true);
                    player->CastSpell(razor, SPELL_MINDCONTROL);
                }
        return true;
    }
};

class spell_egg_event : public SpellScriptLoader
{
public:
    spell_egg_event() : SpellScriptLoader("spell_egg_event") { }

    class spell_egg_eventSpellScript : public SpellScript
    {
        PrepareSpellScript(spell_egg_eventSpellScript);

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
                }
            }
        }

        void Register() override
        {
            OnHit += SpellHitFn(spell_egg_eventSpellScript::HandleOnHit);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_egg_eventSpellScript();
    }
};

void AddSC_boss_razorgore()
{
    new boss_razorgore();
    new go_orb_of_domination();
    new spell_egg_event();
}
