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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SmartScriptMgr.h"
#include "Transport.h"
#include "Vehicle.h"

enum ePreparationsForWar
{
    NPC_HAMMERHEAD                  = 30585,
    NPC_CLOUDBUSTER                 = 30470,
    TRANSPORT_ORGRIMS_HAMMER        = 192241,
    TRANSPORT_THE_SKYBREAKER        = 192242
};

struct npc_preparations_for_war_vehicle : public NullCreatureAI
{
    npc_preparations_for_war_vehicle(Creature* creature) : NullCreatureAI(creature) { }

    uint8 pointId;
    uint32 searchForShipTimer;
    uint32 transportEntry;

    void InitializeAI() override
    {
        WPPath* path = sSmartWaypointMgr->GetPath(me->GetEntry());
        if (!path || path->empty())
        {
            me->DespawnOrUnsummon(1);
            return;
        }

        Movement::PointsArray pathPoints;
        pathPoints.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));

        uint32 wpCounter = 1;
        WPPath::const_iterator itr;
        while ((itr = path->find(wpCounter++)) != path->end())
        {
            WayPoint* wp = itr->second;
            pathPoints.push_back(G3D::Vector3(wp->x, wp->y, wp->z));
        }

        me->GetMotionMaster()->MoveSplinePath(&pathPoints);

        NullCreatureAI::InitializeAI();
        pointId = 0;
        searchForShipTimer = 0;
        transportEntry = (me->GetEntry() == NPC_HAMMERHEAD ? TRANSPORT_ORGRIMS_HAMMER : TRANSPORT_THE_SKYBREAKER);
    }

    void MovementInform(uint32 type, uint32  /*id*/) override
    {
        if (type == ESCORT_MOTION_TYPE)
            if (++pointId == 17) // path size
                searchForShipTimer = 3000;
    }

    void UpdateAI(uint32 diff) override
    {
        // horde 7.55f, -0.09, 34.44, 3.13, +20
        // ally 45.18f, 0.03, 40.09, 3.14 +5

        if (searchForShipTimer)
        {
            searchForShipTimer += diff;
            if (searchForShipTimer >= 3000)
            {
                searchForShipTimer = 1;
                TransportsContainer const& transports = me->GetMap()->GetAllTransports();
                for (TransportsContainer::const_iterator itr = transports.begin(); itr != transports.end(); ++itr)
                {
                    if ((*itr)->GetEntry() == transportEntry)
                    {
                        float x, y, z;
                        if (transportEntry == TRANSPORT_ORGRIMS_HAMMER)
                        {
                            x = 7.55f;
                            y = -0.09f;
                            z = 54.44f;
                        }
                        else
                        {
                            x = 45.18f;
                            y = 0.03f;
                            z = 45.09f;
                        }

                        (*itr)->CalculatePassengerPosition(x, y, z);

                        if (me->GetDistance2d(x, y) < 10.0f)
                        {
                            me->DespawnOrUnsummon(1000);
                            if (Vehicle* vehicle = me->GetVehicleKit())
                                if (Unit* passenger = vehicle->GetPassenger(0))
                                {
                                    passenger->NearTeleportTo(x, y, z - (transportEntry == TRANSPORT_ORGRIMS_HAMMER ? 19.0f : 4.0f), M_PI);
                                    passenger->RemoveAurasDueToSpell(VEHICLE_SPELL_PARACHUTE); // maybe vehicle / seat flag should be responsible for parachute gain?
                                }
                        }
                        else
                            me->GetMotionMaster()->MovePoint(0, x, y, z, false, false);
                        break;
                    }
                }
            }
        }
    }
};

/*******************************************************
 * npc_warmage_violetstand
 *******************************************************/

enum Spells
{
    SPELL_TRANSITUS_SHIELD_BEAM = 48310
};

enum NPCs
{
    NPC_TRANSITUS_SHIELD_DUMMY   = 27306,
    NPC_WARMAGE_SARINA           = 32369,
    NPC_WARMAGE_HALISTER         = 32371,
    NPC_WARMAGE_ILSUDRIA         = 32372
};

struct npc_warmage_violetstand : public ScriptedAI
{
    npc_warmage_violetstand(Creature* creature) : ScriptedAI(creature)
    {
        me->SetCombatMovement(false);
    }

    ObjectGuid targetGUID;

    void Reset() override
    {
        targetGUID.Clear();
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        if (me->IsNonMeleeSpellCast(false))
            return;

        if (me->GetEntry() == NPC_WARMAGE_SARINA)
        {
            if (!targetGUID)
            {
                std::list<Creature*> orbList;
                GetCreatureListWithEntryInGrid(orbList, me, NPC_TRANSITUS_SHIELD_DUMMY, 32.0f);
                if (!orbList.empty())
                {
                    for (std::list<Creature*>::const_iterator itr = orbList.begin(); itr != orbList.end(); ++itr)
                    {
                        if (Creature* pOrb = *itr)
                        {
                            if (pOrb->GetPositionY() < 1000)
                            {
                                targetGUID = pOrb->GetGUID();
                                break;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            if (!targetGUID)
                if (Creature* pOrb = GetClosestCreatureWithEntry(me, NPC_TRANSITUS_SHIELD_DUMMY, 32.0f))
                    targetGUID = pOrb->GetGUID();
        }

        if (Creature* pOrb = ObjectAccessor::GetCreature(*me, targetGUID))
            DoCast(pOrb, SPELL_TRANSITUS_SHIELD_BEAM);
    }
};

void AddSC_crystalsong_forest()
{
    RegisterCreatureAI(npc_preparations_for_war_vehicle);
    RegisterCreatureAI(npc_warmage_violetstand);
}
