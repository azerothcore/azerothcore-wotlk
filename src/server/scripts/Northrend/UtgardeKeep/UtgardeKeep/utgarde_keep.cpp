/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "GameObjectAI.h"
#include "Vehicle.h"
#include "utgarde_keep.h"

class npc_dragonflayer_forge_master : public CreatureScript
{
public:
    npc_dragonflayer_forge_master() : CreatureScript("npc_dragonflayer_forge_master") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_dragonflayer_forge_masterAI(pCreature);
    }

    struct npc_dragonflayer_forge_masterAI : public ScriptedAI
    {
        npc_dragonflayer_forge_masterAI(Creature *c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();

            float x = me->GetHomePosition().GetPositionX();
            float y = me->GetHomePosition().GetPositionY();
            if (x>344.0f && x<357.0f && y<-35.0f && y>-44.0f)
            {
                dataId = DATA_FORGE_1;
                prevDataId = 0;
            }
            else if (x>380.0f && x<389.0f && y<-12.0f && y>-21.0f)
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

        void Reset()
        {
            if (pInstance)
                pInstance->SetData(dataId, NOT_STARTED);
        }

        void JustDied(Unit* /*killer*/)
        {
            if (pInstance)
                pInstance->SetData(dataId, DONE);
            me->SaveRespawnTime();
        }

        void EnterCombat(Unit* /*who*/)
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

        void Reset()
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_REND, urand(2000, 3000));
            _events.ScheduleEvent(EVENT_FLAME_BREATH, urand(5500, 7000));
            _events.ScheduleEvent(EVENT_KNOCKAWAY, urand(3500, 6000));
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == WAYPOINT_MOTION_TYPE && id == POINT_LAST)
            {
                me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.25f);
                if (Vehicle* v = me->GetVehicleKit())
                    if (Unit* p = v->GetPassenger(0))
                        if (Creature* rider = p->ToCreature())
                            rider->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.25f);

                me->SetDisableGravity(false);
                me->SetHover(false);
                me->SetCanFly(false);
                me->SetFacingTo(0.25f);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
            }
        }

        void SetData(uint32 type, uint32 data)
        {
            if (type == TYPE_PROTODRAKE_AT && data == DATA_PROTODRAKE_MOVE && !_setData && me->IsAlive() && me->GetDistance(protodrakeCheckPos) < 10.0f)
            {
                _setData = true;
                me->SetDisableGravity(true);
                me->SetHover(true);
                me->SetCanFly(true);
                me->GetMotionMaster()->MovePath(PATH_PROTODRAKE, false);
            }
        }

        void UpdateAI(uint32 diff)
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
                        _events.ScheduleEvent(EVENT_REND, urand(15000, 20000));
                        break;
                    case EVENT_FLAME_BREATH:
                        DoCast(SPELL_FLAME_BREATH);
                        _events.ScheduleEvent(EVENT_FLAME_BREATH, urand(11000, 12000));
                        break;
                    case EVENT_KNOCKAWAY:
                        DoCast(SPELL_KNOCK_AWAY);
                        _events.ScheduleEvent(EVENT_KNOCKAWAY, urand(7000, 8500));
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

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_enslaved_proto_drakeAI(creature);
    }
};

enum TickingTimeBomb
{
    SPELL_TICKING_TIME_BOMB_EXPLODE = 59687
};

class spell_ticking_time_bomb : public SpellScriptLoader
{
    public:
        spell_ticking_time_bomb() : SpellScriptLoader("spell_ticking_time_bomb") { }

        class spell_ticking_time_bomb_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_ticking_time_bomb_AuraScript);

            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                return (bool) sSpellMgr->GetSpellInfo(SPELL_TICKING_TIME_BOMB_EXPLODE);
            }

            void HandleOnEffectRemove(AuraEffect const* /* aurEff */, AuraEffectHandleModes /* mode */)
            {
                if (GetCaster() == GetTarget())
                {
                    GetTarget()->CastSpell(GetTarget(), SPELL_TICKING_TIME_BOMB_EXPLODE, true);
                }
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_ticking_time_bomb_AuraScript::HandleOnEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_ticking_time_bomb_AuraScript();
        }
};

void AddSC_utgarde_keep()
{
    new npc_dragonflayer_forge_master();
    new npc_enslaved_proto_drake();

    new spell_ticking_time_bomb();
}
