/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* Script Data Start
SDName: CrystalSongForest
SDAuthor: Malcrom
SD%Complete: 99%
SDComment:
SDCategory: CrystalsongForest
Script Data End */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"
#include "SmartScriptMgr.h"
#include "Transport.h"
#include "Vehicle.h"
#include "PassiveAI.h"

enum ePreparationsForWar
{
    NPC_HAMMERHEAD                  = 30585,
    NPC_CLOUDBUSTER                 = 30470,
    TRANSPORT_ORGRIMS_HAMMER        = 192241,
    TRANSPORT_THE_SKYBREAKER        = 192242
};

class npc_preparations_for_war_vehicle : public CreatureScript
{
    public:
        npc_preparations_for_war_vehicle() : CreatureScript("npc_preparations_for_war_vehicle") { }

        struct npc_preparations_for_war_vehicleAI : public NullCreatureAI
        {
            npc_preparations_for_war_vehicleAI(Creature* creature) : NullCreatureAI(creature)
            {
            }

            uint8 pointId;
            uint32 searchForShipTimer;
            uint32 transportEntry;

            void InitializeAI()
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

            void MovementInform(uint32 type, uint32  /*id*/)
            {
                if (type == ESCORT_MOTION_TYPE)
                    if (++pointId == 17) // path size
                        searchForShipTimer = 3000;
            }

            void UpdateAI(uint32 diff)
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
                                            passenger->NearTeleportTo(x, y, z-(transportEntry == TRANSPORT_ORGRIMS_HAMMER ? 19.0f : 4.0f), M_PI);
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

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_preparations_for_war_vehicleAI(creature);
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

class npc_warmage_violetstand : public CreatureScript
{
public:
    npc_warmage_violetstand() : CreatureScript("npc_warmage_violetstand") { }

    struct npc_warmage_violetstandAI : public ScriptedAI
    {
        npc_warmage_violetstandAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);
        }

        uint64 targetGUID;

        void Reset()
        {
            targetGUID = 0;
        }

        void UpdateAI(uint32 /*diff*/)
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
            }else
            {
                if (!targetGUID)
                    if (Creature* pOrb = GetClosestCreatureWithEntry(me, NPC_TRANSITUS_SHIELD_DUMMY, 32.0f))
                        targetGUID = pOrb->GetGUID();

            }

            if (Creature* pOrb = ObjectAccessor::GetCreature(*me, targetGUID))
                DoCast(pOrb, SPELL_TRANSITUS_SHIELD_BEAM);

        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_warmage_violetstandAI(creature);
    }
};

void AddSC_crystalsong_forest()
{
    new npc_preparations_for_war_vehicle();
    new npc_warmage_violetstand();
}
