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

#include "utgarde_keep.h"
#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"

class npc_dragonflayer_forge_master : public CreatureScript
{
public:
    npc_dragonflayer_forge_master() : CreatureScript("npc_dragonflayer_forge_master") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardeKeepAI<npc_dragonflayer_forge_masterAI>(pCreature);
    }

    struct npc_dragonflayer_forge_masterAI : public ScriptedAI
    {
        npc_dragonflayer_forge_masterAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();

            float x = me->GetHomePosition().GetPositionX();
            float y = me->GetHomePosition().GetPositionY();
            if (x > 344.0f && x < 357.0f && y < -35.0f && y > -44.0f)
            {
                dataId = DATA_FORGE_1;
                prevDataId = 0;
            }
            else if (x > 380.0f && x < 389.0f && y < -12.0f && y > -21.0f)
            {
                dataId = DATA_FORGE_2;
                prevDataId = DATA_FORGE_1;
            }
            else
            {
                dataId = DATA_FORGE_3;
                prevDataId = DATA_FORGE_2;
            }
        }

        InstanceScript* pInstance;
        uint32 dataId;
        uint32 prevDataId;

        void Reset() override
        {
            if (pInstance)
                pInstance->SetData(dataId, NOT_STARTED);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (pInstance)
                pInstance->SetData(dataId, DONE);
            me->SaveRespawnTime();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (pInstance)
            {
                if (prevDataId && !pInstance->GetData(prevDataId))
                {
                    EnterEvadeMode();
                    return;
                }
                pInstance->SetData(dataId, IN_PROGRESS);
            }
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
        }
    };
};

enum EnslavedProtoDrake
{
    TYPE_PROTODRAKE_AT      = 28,
    DATA_PROTODRAKE_MOVE    = 6,

    PATH_PROTODRAKE         = 125946,

    EVENT_REND              = 1,
    EVENT_FLAME_BREATH      = 2,
    EVENT_KNOCKAWAY         = 3,

    SPELL_REND              = 43931,
    SPELL_FLAME_BREATH      = 50653,
    SPELL_KNOCK_AWAY        = 49722,

    POINT_LAST              = 5,
};

const Position protodrakeCheckPos = {206.24f, -190.28f, 200.11f, 0.f};

class npc_enslaved_proto_drake : public CreatureScript
{
public:
    npc_enslaved_proto_drake() : CreatureScript("npc_enslaved_proto_drake") { }

    struct npc_enslaved_proto_drakeAI : public ScriptedAI
    {
        npc_enslaved_proto_drakeAI(Creature* creature) : ScriptedAI(creature)
        {
            _setData = false;
        }

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_REND, 2s, 3s);
            _events.ScheduleEvent(EVENT_FLAME_BREATH, 5500ms, 7000ms);
            _events.ScheduleEvent(EVENT_KNOCKAWAY, 3500ms, 6000ms);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == WAYPOINT_MOTION_TYPE && id == POINT_LAST)
            {
                me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.25f);
                if (Vehicle* v = me->GetVehicleKit())
                    if (Unit* p = v->GetPassenger(0))
                        if (Creature* rider = p->ToCreature())
                            rider->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.25f);

                me->SetCanFly(false);
                me->SetDisableGravity(false);
                me->SetFacingTo(0.25f);
                me->SetImmuneToAll(false);
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == TYPE_PROTODRAKE_AT && data == DATA_PROTODRAKE_MOVE && !_setData && me->IsAlive() && me->GetDistance(protodrakeCheckPos) < 10.0f)
            {
                _setData = true;
                me->SetCanFly(true);
                me->SetDisableGravity(true);
                me->GetMotionMaster()->MovePath(PATH_PROTODRAKE, false);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventid = _events.ExecuteEvent())
            {
                switch (eventid)
                {
                    case EVENT_REND:
                        DoCast(SPELL_REND);
                        _events.ScheduleEvent(EVENT_REND, 15s, 20s);
                        break;
                    case EVENT_FLAME_BREATH:
                        DoCast(SPELL_FLAME_BREATH);
                        _events.ScheduleEvent(EVENT_FLAME_BREATH, 11s, 12s);
                        break;
                    case EVENT_KNOCKAWAY:
                        DoCast(SPELL_KNOCK_AWAY);
                        _events.ScheduleEvent(EVENT_KNOCKAWAY, 7000ms, 8500ms);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        bool _setData;
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUtgardeKeepAI<npc_enslaved_proto_drakeAI>(creature);
    }
};

enum TickingTimeBomb
{
    SPELL_TICKING_TIME_BOMB_EXPLODE = 59687
};

class spell_ticking_time_bomb_aura : public AuraScript
{
    PrepareAuraScript(spell_ticking_time_bomb_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TICKING_TIME_BOMB_EXPLODE });
    }

    void HandleOnEffectRemove(AuraEffect const* /* aurEff */, AuraEffectHandleModes /* mode */)
    {
        if (GetCaster() == GetTarget())
        {
            GetTarget()->CastSpell(GetTarget(), SPELL_TICKING_TIME_BOMB_EXPLODE, true);
        }
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_ticking_time_bomb_aura::HandleOnEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_utgarde_keep()
{
    new npc_dragonflayer_forge_master();
    new npc_enslaved_proto_drake();

    RegisterSpellScript(spell_ticking_time_bomb_aura);
}
