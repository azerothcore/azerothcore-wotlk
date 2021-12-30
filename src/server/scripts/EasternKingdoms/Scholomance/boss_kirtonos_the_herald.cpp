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

#include "GameObjectAI.h"
#include "MoveSplineInit.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "scholomance.h"

enum Spells
{
    SPELL_SWOOP                       = 18144,
    SPELL_WING_FLAP                   = 12882,
    SPELL_PIERCE_ARMOR                = 6016,
    SPELL_DISARM                      = 8379,
    SPELL_KIRTONOS_TRANSFORM          = 16467,
    SPELL_SHADOW_BOLT_VOLLEY          = 17228,
    SPELL_CURSE_OF_TONGUES            = 12889,
    SPELL_DOMINATE_MIND               = 14515,
    SPELL_TRANSFORM_VISUAL            = 24085
};

enum Events
{
    INTRO_1                           = 1,
    INTRO_2                           = 2,
    INTRO_3                           = 3,
    INTRO_4                           = 4,
    INTRO_5                           = 5,
    INTRO_6                           = 6,
    EVENT_SWOOP                       = 7,
    EVENT_WING_FLAP                   = 8,
    EVENT_PIERCE_ARMOR                = 9,
    EVENT_DISARM                      = 10,
    EVENT_SHADOW_BOLT_VOLLEY          = 11,
    EVENT_CURSE_OF_TONGUES            = 12,
    EVENT_DOMINATE_MIND               = 13,
    EVENT_KIRTONOS_TRANSFORM          = 14
};

enum Misc
{
    WEAPON_KIRTONOS_STAFF             = 11365,
    POINT_KIRTONOS_LAND               = 13,
    KIRTONOS_PATH                     = 105061,

    EMOTE_SUMMONED                    = 0
};

Position const PosMove[2] =
{
    { 299.4884f, 92.76137f, 105.6335f, 0.0f },
    { 314.8673f, 90.30210f, 101.6459f, 0.0f }
};

class boss_kirtonos_the_herald : public CreatureScript
{
public:
    boss_kirtonos_the_herald() : CreatureScript("boss_kirtonos_the_herald") { }

    struct boss_kirtonos_the_heraldAI : public ScriptedAI
    {
        boss_kirtonos_the_heraldAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = me->GetInstanceScript();
        }

        int TransformsCount;
        EventMap events;
        EventMap events2;
        InstanceScript* instance;

        void EnterCombat(Unit* /*who*/) override
        {
            TransformsCount = 0;

            events.Reset();
            events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, 2000);
            events.ScheduleEvent(EVENT_CURSE_OF_TONGUES, 6000);
            events.ScheduleEvent(EVENT_KIRTONOS_TRANSFORM, 20000);
        }

        void JustDied(Unit* /*killer*/) override
        {
            instance->SetData(DATA_KIRTONOS_THE_HERALD, DONE);
        }

        void EnterEvadeMode() override
        {
            instance->SetData(DATA_KIRTONOS_THE_HERALD, FAIL);
            me->DespawnOrUnsummon(1);
        }

        void IsSummonedBy(Unit* /*summoner*/) override
        {
            events2.Reset();
            events2.ScheduleEvent(INTRO_1, 1000);
            me->SetDisableGravity(true);
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC); // for some reason he aggroes if we don't have this.
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC); // might not be needed, but guardians and stuff like that could mess up.
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == WAYPOINT_MOTION_TYPE && id == POINT_KIRTONOS_LAND)
            {
                events2.ScheduleEvent(INTRO_2, 1500);
                events2.ScheduleEvent(INTRO_3, 2500);
                events2.ScheduleEvent(INTRO_4, 5500);
                events2.ScheduleEvent(INTRO_5, 6500);
                events2.ScheduleEvent(INTRO_6, 11500);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case INTRO_1:
                    me->GetMotionMaster()->MovePath(KIRTONOS_PATH, false);
                    Talk(EMOTE_SUMMONED);
                    break;
                case INTRO_2:
                    me->GetMotionMaster()->MovePoint(0, PosMove[0]);
                    break;
                case INTRO_3:
                    me->SetFacingTo(0.01745329f);
                    break;
                case INTRO_4:
                    me->SetWalk(true);
                    me->SetCanFly(false);
                    me->SetDisableGravity(false);
                    me->CastSpell(me, SPELL_KIRTONOS_TRANSFORM, true);
                    break;
                case INTRO_5:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                    me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(WEAPON_KIRTONOS_STAFF));
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                    me->SetReactState(REACT_AGGRESSIVE);
                    break;
                case INTRO_6:
                    if (!me->IsInCombat())
                    {
                        me->GetMotionMaster()->MovePoint(0, PosMove[1]);
                    }
                    break;
            }

            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            switch (events.ExecuteEvent())
            {
                case EVENT_SWOOP:
                    me->CastSpell(me->GetVictim(), SPELL_SWOOP, false);
                    events.ScheduleEvent(EVENT_SWOOP, 15000);
                    break;
                case EVENT_WING_FLAP:
                    me->CastSpell(me, SPELL_WING_FLAP, false);
                    events.ScheduleEvent(EVENT_WING_FLAP, 13000);
                    break;
                case EVENT_PIERCE_ARMOR:
                    me->CastSpell(me->GetVictim(), SPELL_PIERCE_ARMOR, false);
                    events.ScheduleEvent(EVENT_PIERCE_ARMOR, 12000);
                    break;
                case EVENT_DISARM:
                    me->CastSpell(me->GetVictim(), SPELL_DISARM, false);
                    events.ScheduleEvent(EVENT_DISARM, 11000);
                    break;
                case EVENT_SHADOW_BOLT_VOLLEY:
                    me->CastSpell(me, SPELL_SHADOW_BOLT_VOLLEY, false);
                    events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, 10000);
                    break;
                case EVENT_CURSE_OF_TONGUES:
                    me->CastSpell(me, SPELL_CURSE_OF_TONGUES, false);
                    events.ScheduleEvent(EVENT_CURSE_OF_TONGUES, 20000);
                    break;
                case EVENT_DOMINATE_MIND:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 20.0f, true))
                    {
                        me->CastSpell(target, SPELL_DOMINATE_MIND, false);
                    }
                    break;
                case EVENT_KIRTONOS_TRANSFORM:
                    TransformsCount++;

                    if (me->HasAura(SPELL_KIRTONOS_TRANSFORM))
                    {
                        events.Reset();
                        events.ScheduleEvent(EVENT_SWOOP, 4000);
                        events.ScheduleEvent(EVENT_WING_FLAP, 7000);
                        events.ScheduleEvent(EVENT_PIERCE_ARMOR, 11000);
                        events.ScheduleEvent(EVENT_DISARM, 15000);
                        // show shape-shift animation before aura removal
                        me->CastSpell(me, SPELL_TRANSFORM_VISUAL, true);
                        me->RemoveAura(SPELL_KIRTONOS_TRANSFORM);
                        me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(0));
                    }
                    else
                    {
                        events.Reset();
                        events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, 2000);
                        events.ScheduleEvent(EVENT_CURSE_OF_TONGUES, 6000);
                        events.ScheduleEvent(EVENT_WING_FLAP, 13000);
                        me->CastSpell(me, SPELL_KIRTONOS_TRANSFORM, true);
                        me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(WEAPON_KIRTONOS_STAFF));
                        // Schedule Dominate Mind on every 2nd caster transform
                        if ((TransformsCount - 2) % 4 == 0)
                        {
                            events.ScheduleEvent(EVENT_DOMINATE_MIND, urand(4000, 8000));
                        }
                    }

                    events.ScheduleEvent(EVENT_KIRTONOS_TRANSFORM, 20000);
                    break;
            }

            DoZoneInCombat();
            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScholomanceAI<boss_kirtonos_the_heraldAI>(creature);
    }
};

void AddSC_boss_kirtonos_the_herald()
{
    new boss_kirtonos_the_herald();
}
