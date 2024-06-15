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
SDName: Boss_Nalorakk
SD%Complete: 100
SDComment:
SDCategory: Zul'Aman
EndScriptData */

#include "CellImpl.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "ScriptedCreature.h"
#include "zulaman.h"

enum Spells
{
    SPELL_BERSERK           = 45078,

    // Troll form
    SPELL_BRUTALSWIPE       = 42384,
    SPELL_MANGLE            = 42389,
    SPELL_MANGLEEFFECT      = 44955,
    SPELL_SURGE             = 42402,
    SPELL_BEARFORM          = 42377,

    // Bear form
    SPELL_LACERATINGSLASH   = 42395,
    SPELL_RENDFLESH         = 42397,
    SPELL_DEAFENINGROAR     = 42398
};

// Trash Waves
float NalorakkWay[8][3] =
{
    { 18.569f, 1414.512f, 11.42f}, // waypoint 1
    {-17.264f, 1419.551f, 12.62f},
    {-52.642f, 1419.357f, 27.31f}, // waypoint 2
    {-69.908f, 1419.721f, 27.31f},
    {-79.929f, 1395.958f, 27.31f},
    {-80.072f, 1374.555f, 40.87f}, // waypoint 3
    {-80.072f, 1314.398f, 40.87f},
    {-80.072f, 1295.775f, 48.60f} // waypoint 4
};

enum Talks
{
    SAY_WAVE1 = 0,
    SAY_WAVE2,
    SAY_WAVE3,
    SAY_WAVE4,
    SAY_AGGRO,
    SAY_SURGE,
    SAY_SHIFTEDTOBEAR,
    SAY_SHIFTEDTOTROLL,
    SAY_BERSERK,
    SAY_KILL_ONE,
    SAY_KILL_TWO,
    SAY_DEATH,
    SAY_NALORAKK_EVENT1, // Not implemented
    SAY_NALORAKK_EVENT2 // Not implemented
};

class boss_nalorakk : public CreatureScript
{
public:
    boss_nalorakk()
        : CreatureScript("boss_nalorakk")
    {
    }

    struct boss_nalorakkAI : public ScriptedAI
    {
        boss_nalorakkAI(Creature* creature) : ScriptedAI(creature)
        {
            MoveEvent = true;
            MovePhase = 0;
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        uint32 BrutalSwipe_Timer;
        uint32 Mangle_Timer;
        uint32 Surge_Timer;

        uint32 LaceratingSlash_Timer;
        uint32 RendFlesh_Timer;
        uint32 DeafeningRoar_Timer;

        uint32 ShapeShift_Timer;
        uint32 Berserk_Timer;

        bool inBearForm;
        bool MoveEvent;
        bool inMove;
        uint32 MovePhase;
        uint32 waitTimer;

        void Reset() override
        {
            if (MoveEvent)
            {
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                inMove = false;
                waitTimer = 0;
                me->SetSpeed(MOVE_RUN, 2);
                me->SetWalk(false);
                ResetMobs();
            }
            else
            {
                (*me).GetMotionMaster()->MovePoint(0, NalorakkWay[7][0], NalorakkWay[7][1], NalorakkWay[7][2]);
            }

            if (instance)
            {
                instance->SetData(DATA_NALORAKKEVENT, NOT_STARTED);
            }

            Surge_Timer = urand(15000, 20000);
            BrutalSwipe_Timer = urand(7000, 12000);
            Mangle_Timer = urand(10000, 15000);
            ShapeShift_Timer = urand(45000, 50000);
            Berserk_Timer = 600000;

            inBearForm = false;
            // me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, 5122);  /// @todo find the correct equipment id
        }

        void ResetMobs()
        {
            std::list<Creature*> templist;
            float x, y, z;
            me->GetPosition(x, y, z);

            {
                CellCoord pair(Acore::ComputeCellCoord(x, y));
                Cell cell(pair);
                cell.SetNoCreate();

                Acore::AllFriendlyCreaturesInGrid check(me);
                Acore::CreatureListSearcher<Acore::AllFriendlyCreaturesInGrid> searcher(me, templist, check);

                TypeContainerVisitor<Acore::CreatureListSearcher<Acore::AllFriendlyCreaturesInGrid>, GridTypeMapContainer> cSearcher(searcher);

                cell.Visit(pair, cSearcher, *(me->GetMap()), *me, me->GetGridActivationRange());
            }

            if (templist.empty())
                return;

            for (std::list<Creature*>::const_iterator i = templist.begin(); i != templist.end(); ++i)
                if ((*i) && me->GetGUID() != (*i)->GetGUID() && me->IsWithinDistInMap((*i), 25))
                    (*i)->AI()->Reset();
        }

        void SendAttacker(Unit* target)
        {
            std::list<Creature*> templist;
            float x, y, z;
            me->GetPosition(x, y, z);

            {
                CellCoord pair(Acore::ComputeCellCoord(x, y));
                Cell cell(pair);
                cell.SetNoCreate();

                Acore::AllFriendlyCreaturesInGrid check(me);
                Acore::CreatureListSearcher<Acore::AllFriendlyCreaturesInGrid> searcher(me, templist, check);

                TypeContainerVisitor<Acore::CreatureListSearcher<Acore::AllFriendlyCreaturesInGrid>, GridTypeMapContainer> cSearcher(searcher);

                cell.Visit(pair, cSearcher, *(me->GetMap()), *me, me->GetGridActivationRange());
            }

            if (templist.empty())
                return;

            for (std::list<Creature*>::const_iterator i = templist.begin(); i != templist.end(); ++i)
            {
                if ((*i) && me->IsWithinDistInMap((*i), 25))
                {
                    (*i)->SetNoCallAssistance(true);
                    (*i)->AI()->AttackStart(target);
                }
            }
        }

        void AttackStart(Unit* who) override
        {
            if (!MoveEvent)
                ScriptedAI::AttackStart(who);
        }

        void MoveInLineOfSight(Unit* who) override

        {
            if (!MoveEvent)
            {
                ScriptedAI::MoveInLineOfSight(who);
            }
            else
            {
                if (me->IsHostileTo(who))
                {
                    if (!inMove)
                    {
                        switch (MovePhase)
                        {
                            case 0:
                                if (me->IsWithinDistInMap(who, 50))
                                {
                                    Talk(SAY_WAVE1);

                                    (*me).GetMotionMaster()->MovePoint(1, NalorakkWay[1][0], NalorakkWay[1][1], NalorakkWay[1][2]);
                                    MovePhase ++;
                                    inMove = true;

                                    SendAttacker(who);
                                }
                                break;
                            case 2:
                                if (me->IsWithinDistInMap(who, 40))
                                {
                                    Talk(SAY_WAVE2);

                                    (*me).GetMotionMaster()->MovePoint(3, NalorakkWay[3][0], NalorakkWay[3][1], NalorakkWay[3][2]);
                                    MovePhase ++;
                                    inMove = true;

                                    SendAttacker(who);
                                }
                                break;
                            case 5:
                                if (me->IsWithinDistInMap(who, 40))
                                {
                                    Talk(SAY_WAVE3);

                                    (*me).GetMotionMaster()->MovePoint(6, NalorakkWay[6][0], NalorakkWay[6][1], NalorakkWay[6][2]);
                                    MovePhase ++;
                                    inMove = true;

                                    SendAttacker(who);
                                }
                                break;
                            case 7:
                                if (me->IsWithinDistInMap(who, 50))
                                {
                                    SendAttacker(who);

                                    Talk(SAY_WAVE4);

                                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);

                                    MoveEvent = false;
                                }
                                break;
                        }
                    }
                }
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (instance)
                instance->SetData(DATA_NALORAKKEVENT, IN_PROGRESS);

            Talk(SAY_AGGRO);
            DoZoneInCombat();
        }

        void JustDied(Unit* /*killer*/) override
        {
            ResetMobs();

            if (instance)
                instance->SetData(DATA_NALORAKKEVENT, DONE);

            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            switch (urand(0, 1))
            {
                case 0:
                    Talk(SAY_KILL_ONE);
                    break;
                case 1:
                    Talk(SAY_KILL_TWO);
                    break;
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (MoveEvent)
            {
                if (type != POINT_MOTION_TYPE)
                    return;

                if (!inMove)
                    return;

                if (MovePhase != id)
                    return;

                switch (MovePhase)
                {
                    case 2:
                        me->SetOrientation(3.1415f * 2);
                        inMove = false;
                        return;
                    case 1:
                    case 3:
                    case 4:
                    case 6:
                        MovePhase ++;
                        waitTimer = 1;
                        inMove = true;
                        return;
                    case 5:
                        me->SetOrientation(3.1415f * 0.5f);
                        inMove = false;
                        return;
                    case 7:
                        me->SetOrientation(3.1415f * 0.5f);
                        inMove = false;
                        return;
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (waitTimer && inMove)
            {
                if (waitTimer <= diff)
                {
                    (*me).GetMotionMaster()->MovementExpired();
                    (*me).GetMotionMaster()->MovePoint(MovePhase, NalorakkWay[MovePhase][0], NalorakkWay[MovePhase][1], NalorakkWay[MovePhase][2]);
                    waitTimer = 0;
                }
                else waitTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            if (Berserk_Timer <= diff)
            {
                DoCast(me, SPELL_BERSERK, true);
                Talk(SAY_BERSERK);
                Berserk_Timer = 600000;
            }
            else Berserk_Timer -= diff;

            if (ShapeShift_Timer <= diff)
            {
                if (inBearForm)
                {
                    // me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, 5122);
                    Talk(SAY_SHIFTEDTOTROLL);
                    me->RemoveAurasDueToSpell(SPELL_BEARFORM);
                    Surge_Timer = urand(15000, 20000);
                    BrutalSwipe_Timer = urand(7000, 12000);
                    Mangle_Timer = urand(10000, 15000);
                    ShapeShift_Timer = urand(45000, 50000);
                    inBearForm = false;
                }
                else
                {
                    // me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, 0);
                    Talk(SAY_SHIFTEDTOBEAR);
                    DoCast(me, SPELL_BEARFORM, true);
                    LaceratingSlash_Timer = 2000; // dur 18s
                    RendFlesh_Timer = 3000;  // dur 5s
                    DeafeningRoar_Timer = urand(5000, 10000);  // dur 2s
                    ShapeShift_Timer = urand(20000, 25000); // dur 30s
                    inBearForm = true;
                }
            }
            else ShapeShift_Timer -= diff;

            if (!inBearForm)
            {
                if (BrutalSwipe_Timer <= diff)
                {
                    DoCastVictim(SPELL_BRUTALSWIPE);
                    BrutalSwipe_Timer = urand(7000, 12000);
                }
                else BrutalSwipe_Timer -= diff;

                if (Mangle_Timer <= diff)
                {
                    if (me->GetVictim() && !me->GetVictim()->HasAura(SPELL_MANGLEEFFECT))
                    {
                        DoCastVictim(SPELL_MANGLE);
                        Mangle_Timer = 1000;
                    }
                    else Mangle_Timer = urand(10000, 15000);
                }
                else Mangle_Timer -= diff;

                if (Surge_Timer <= diff)
                {
                    Talk(SAY_SURGE);
                    Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 45, true);
                    if (target)
                        DoCast(target, SPELL_SURGE);
                    Surge_Timer = urand(15000, 20000);
                }
                else Surge_Timer -= diff;
            }
            else
            {
                if (LaceratingSlash_Timer <= diff)
                {
                    DoCastVictim(SPELL_LACERATINGSLASH);
                    LaceratingSlash_Timer = urand(18000, 23000);
                }
                else LaceratingSlash_Timer -= diff;

                if (RendFlesh_Timer <= diff)
                {
                    DoCastVictim(SPELL_RENDFLESH);
                    RendFlesh_Timer = urand(5000, 10000);
                }
                else RendFlesh_Timer -= diff;

                if (DeafeningRoar_Timer <= diff)
                {
                    DoCastVictim(SPELL_DEAFENINGROAR);
                    DeafeningRoar_Timer = urand(15000, 20000);
                }
                else DeafeningRoar_Timer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulAmanAI<boss_nalorakkAI>(creature);
    }
};

void AddSC_boss_nalorakk()
{
    new boss_nalorakk();
}
