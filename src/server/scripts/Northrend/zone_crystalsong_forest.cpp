/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CombatAI.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "Transport.h"
#include "Vehicle.h"

enum ePreparationsForWar
{
    NPC_CLOUDBUSTER = 30470,
    NPC_HAMMERHEAD = 30585,
    TRANSPORT_ORGRIMS_HAMMER  = 192241,
    TRANSPORT_THE_SKYBREAKER = 192242,
    SEAT_PLAYER  = 0,
    SPELL_FLIGHT = 48602,
    SPELL_TO_ICECROWN_PLAYER_AURA_DISMOUNT_A = 56904,
    SPELL_TO_ICECROWN_PLAYER_AURA_DISMOUNT_H = 57419,
    SPELL_TO_ICECROWN_AIRSHIP_PLAYER_AURA_TELEPORT_TO_DALARAN = 57460,
    SPELL_TO_ICECROWN_AIRSHIP_FROST_WYRM_WAITING_TO_SUMMON_AURA = 57498,
    POINT_END = 16,
    SPELL_TO_ICECROWN_AIRSHIP_AURA_DISMOUNT_RESPONSE = 56921, // unhandled - vehicle casts 50630 on self
    SPELL_EJECT_ALL_PASSENGERS  = 50630,
    SPELL_TO_ICECROWN_AIRSHIP_TELEPORT_TO_AIRSHIP_A_FORCE_PLAYER_TO_CAST = 57554,
    SPELL_TO_ICECROWN_AIRSHIP_TELEPORT_TO_AIRSHIP_H_FORCE_PLAYER_TO_CAST = 57556,
    SPELL_TO_ICECROWN_AIRSHIP_TELEPORT_TO_AIRSHIP_A = 56917,
    SPELL_TO_ICECROWN_AIRSHIP_TELEPORT_TO_AIRSHIP_H = 57417,
};

struct npc_preparations_for_war_vehicle : public VehicleAI
{
    explicit npc_preparations_for_war_vehicle(Creature* creature) : VehicleAI(creature), searchForShipTimer(0), transportEntry(me->GetEntry() == NPC_CLOUDBUSTER ? TRANSPORT_THE_SKYBREAKER : TRANSPORT_ORGRIMS_HAMMER)
    {
        if (transportEntry == TRANSPORT_THE_SKYBREAKER)
        {
            // 30476 - [DND] Icecrown Flight To Airship Bunny (A)
            passenger_x = 31.41805;
            passenger_y = 0.126893;
            passenger_z = 41.69821;
        }
        else // TRANSPORT_ORGRIMS_HAMMER
        {
            // 30588 - [DND] Icecrown Flight To Airship Bunny (H)
            passenger_x = -18.10283;
            passenger_y = -0.042108;
            passenger_z = 45.31725;
        }
    }

    void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) override
    {
        if (apply)
        {
            DoCastSelf(SPELL_TO_ICECROWN_AIRSHIP_PLAYER_AURA_TELEPORT_TO_DALARAN, true);
            DoCastSelf(SPELL_FLIGHT, true);
            DoCastSelf(me->GetEntry() == NPC_CLOUDBUSTER ? SPELL_TO_ICECROWN_PLAYER_AURA_DISMOUNT_A : SPELL_TO_ICECROWN_PLAYER_AURA_DISMOUNT_H , true);
            DoCastSelf(SPELL_TO_ICECROWN_AIRSHIP_FROST_WYRM_WAITING_TO_SUMMON_AURA, true);
            me->GetMotionMaster()->MovePath(me->GetEntry(), FORCED_MOVEMENT_NONE, PathSource::SMART_WAYPOINT_MGR);
        }
        else
            who->RemoveAurasDueToSpell(VEHICLE_SPELL_PARACHUTE); // maybe vehicle / seat flag should be responsible for parachute gain?
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == ESCORT_MOTION_TYPE && id == POINT_END)
            searchForShipTimer = 3000;
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        switch (spell->Id)
        {
            case SPELL_TO_ICECROWN_AIRSHIP_AURA_DISMOUNT_RESPONSE:
                break;
            case SPELL_TO_ICECROWN_AIRSHIP_TELEPORT_TO_AIRSHIP_A_FORCE_PLAYER_TO_CAST:
            case SPELL_TO_ICECROWN_AIRSHIP_TELEPORT_TO_AIRSHIP_H_FORCE_PLAYER_TO_CAST:
            {
                uint32 teleportSpell = (spell->Id == SPELL_TO_ICECROWN_AIRSHIP_TELEPORT_TO_AIRSHIP_A_FORCE_PLAYER_TO_CAST)
                    ? SPELL_TO_ICECROWN_AIRSHIP_TELEPORT_TO_AIRSHIP_A
                    : SPELL_TO_ICECROWN_AIRSHIP_TELEPORT_TO_AIRSHIP_H;
                DoCastSelf(teleportSpell, true); // hack: cast on self to avoid visual glitch on player when ejecting and teleporting on transport
                DoCastSelf(SPELL_EJECT_ALL_PASSENGERS, true);
                me->DespawnOrUnsummon(0s);
                break;
            }
            default:
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (searchForShipTimer)
        {
            searchForShipTimer += diff;
            if (searchForShipTimer >= 3000)
            {
                searchForShipTimer = 1;
                TransportsContainer const& transports = me->GetMap()->GetAllTransports();
                for (auto const transport : transports)
                {
                    if (transport->GetEntry() == transportEntry)
                    {
                        float x = passenger_x, y = passenger_y, z = passenger_z;
                        transport->CalculatePassengerPosition(x, y, z);

                        if (me->GetDistance2d(x, y) > 20.0f) // dismount trigger (56905, 57420) range is 30
                            me->GetMotionMaster()->MovePoint(0, x, y, z, FORCED_MOVEMENT_NONE, 0.f, 0.f, false, false);
                        break;
                    }
                }
            }
        }
    }
private:
    float passenger_x, passenger_y, passenger_z;
    uint32 searchForShipTimer;
    uint32 transportEntry;
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
