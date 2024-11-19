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
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Unit.h"
#include "World.h"
#include "karazhan.h"
#include <array>

#include "SpellMgr.h"

enum EchoOfMedivhGossipOptions
{
    MEDIVH_GOSSIP_START_PVE = 1,
    MEDIVH_GOSSIP_RESTART,
    MEDIVH_GOSSIP_START_PVP
};

enum KarazhanChessSpells
{
    SPELL_MOVE_1                        = 37146, // 8y
    SPELL_MOVE_2                        = 37144, // 15y
    SPELL_MOVE_3                        = 37148, // 20y
    SPELL_MOVE_4                        = 37151, // 8y
    SPELL_MOVE_5                        = 37152, // 8y
    SPELL_MOVE_6                        = 37153, // 8y

    SPELL_MOVE_GENERIC                  = 30012, // Unlimited

    SPELL_CHANGE_FACING                 = 30284,
    SPELL_MOVE_MARKER                   = 32261,
    SPELL_MOVE_COOLDOWN                 = 30543,
    SPELL_CONTROL_PIECE                 = 30019,
    SPELL_RECENTLY_INGAME               = 30529,

    SPELL_FURY_OF_MEDIVH_FIRE           = 39345,
    SPELL_MELEE_ATTACK_TIMER            = 32226,
    SPELL_MELEE_ATTACK_TIMER_TRIGGER    = 32225,
    SPELL_MELEE_DAMAGE                  = 32247
};

enum KarazhanChessNPCs
{
    NPC_CHESS_MOVE_TRIGGER      = 22519
};

enum KarazhanChessTeam
{
    DEAD_ALLIANCE   = 0,
    DEAD_HORDE      = 1,
};

enum KarazhanChessOrientationType : uint8
{
    ORI_SE  = 0,    // Horde start
    ORI_S   = 1,
    ORI_SW  = 2,
    ORI_W   = 3,
    ORI_NW  = 4,    // Alliance start
    ORI_N   = 5,
    ORI_NE  = 6,
    ORI_E   = 7,

    MAX_ORI
};

enum KarazhanChessPiecesSpells
{
    //ability 1
    SPELL_KING_H_1    = 37472,    //Bloodlust
    SPELL_KING_A_1    = 37471,    //Heroism
    SPELL_QUEEN_H_1   = 37463,    //Fireball
    SPELL_QUEEN_A_1   = 37462,    //Elemental Blast
    SPELL_BISHOP_H_1  = 37461,    //Shadow Spear
    SPELL_BISHOP_A_1  = 37459,    //Holy Lance
    SPELL_KNIGHT_H_1  = 37502,    //Howl
    SPELL_KNIGHT_A_1  = 37453,    //Smash
    SPELL_ROOK_H_1    = 37428,    //Hellfire
    SPELL_ROOK_A_1    = 37427,    //Geyser
    SPELL_PAWN_H_1    = 37416,    //Weapon Deflection
    SPELL_PAWN_A_1    = 37414,    //Shield Block

    //ability 2
    SPELL_KING_H_2    = 37476,    //Cleave
    SPELL_KING_A_2    = 37474,    //Sweep
    SPELL_QUEEN_H_2   = 37469,    //Poison Cloud
    SPELL_QUEEN_A_2   = 37465,    //Rain of Fire
    SPELL_BISHOP_H_2  = 37456,    //Shadow Mend
    SPELL_BISHOP_A_2  = 37455,    //Healing
    SPELL_KNIGHT_H_2  = 37454,    //Bite
    SPELL_KNIGHT_A_2  = 37498,    //Stomp
    SPELL_ROOK_H_2    = 37434,    //Fire Shield
    SPELL_ROOK_A_2    = 37432,    //Water Shield
    SPELL_PAWN_H_2    = 37413,    //Vicious Strike
    SPELL_PAWN_A_2    = 37406     //Heroic Blow
};

enum ChessEventTalks
{
    TALK_EVENT_BEGIN            = 0,

    TALK_MEDIHV_CHEAT           = 1,
    TALK_MEDIHV_CHEAT_EMOTE     = 2,

    TALK_PLAYER_LOOSE_PAWN      = 3,
    TALK_PLAYER_LOOSE_ROOK      = 4,
    TALK_PLAYER_LOOSE_KNIGHT    = 5,
    TALK_PLAYER_LOOSE_BISHOP    = 6,
    TALK_PLAYER_LOOSE_QUEEN     = 7,
    TALK_PLAYER_LOOSE_KING      = 8,

    TALK_MEDIVH_LOOSE_PAWN      = 9,
    TALK_MEDIVH_LOOSE_ROOK      = 10,
    TALK_MEDIVH_LOOSE_KNIGHT    = 11,
    TALK_MEDIVH_LOOSE_BISHOP    = 12,
    TALK_MEDIVH_LOOSE_QUEEN     = 13,
    TALK_MEDIVH_LOOSE_KING      = 14,

    TALK_CHECKMATE              = 15,
    TALK_EVENT_ENDED            = 16
};

static constexpr uint8 MAX_ROW = 8;
static constexpr uint8 MAX_COL = 8;

struct BoardCell
{
    BoardCell() : pieceEntry(0), row(0), col(0) { }

    ObjectGuid triggerGUID;
    ObjectGuid pieceGUID;
    uint32 pieceEntry;
    uint8 row;
    uint8 col;

    void SetData(ObjectGuid _triggerGUID, uint8 _row, uint8 _col)
    {
        triggerGUID = _triggerGUID;
        row = _row;
        col = _col;
    }

    void Reset()
    {
        pieceGUID.Clear();
        pieceEntry = 0;
    }

    void SetPiece(Creature* piece)
    {
        pieceGUID = piece->GetGUID();
        pieceEntry = piece->GetEntry();
    }
};

//                                                  ORI_SE      ORI_S      ORI_SW     ORI_W     ORI_NW      ORI_N      ORI_NE      ORI_E
static std::array<float, MAX_ORI> orientations = { 3.809080f, 3.022091f, 2.235102f, 1.448113f, 0.661124f, 6.1724616f, 5.385472f, 4.598483f };

static bool IsFriendly(Creature* piece, Creature* target)
{
    return piece->GetFaction() == target->GetFaction();
}

enum ChessPieceSearchType
{
    CHESS_PIECE_SEARCH_TYPE_CLOSEST     = 1,
    CHESS_PIECE_SEARCH_TYPE_RANDOM      = 2
};

struct npc_echo_of_medivh : public ScriptedAI
{
    npc_echo_of_medivh(Creature* creature) : ScriptedAI(creature), _summons(me)
    {
        _instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        for (uint8 row = 0; row < MAX_ROW; ++row)
        {
            for (uint8 col = 0; col < MAX_COL; ++col)
            {
                _boards[row][col].Reset();
            }
        }

        _summons.DespawnAll();

        _cheatTimer = urand(45 * IN_MILLISECONDS, 100 * IN_MILLISECONDS);
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
    }

    void SummonedCreatureDespawn(Creature* summon) override
    {
        _summons.Despawn(summon);
    }

    void RemoveCheats()
    {
        // Buffs
        for (uint8 row = 0; row < MAX_ROW; ++row)
        {
            for (uint8 col = 0; col < MAX_COL; ++col)
            {
                if (ObjectGuid guid = _boards[row][col].pieceGUID)
                {
                    if (Creature* piece = ObjectAccessor::GetCreature(*me, guid))
                    {
                        piece->RemoveAurasDueToSpell(SPELL_HAND_OF_MEDIVH);
                    }
                }
            }
        }
    }

    void SetupBoard()
    {
        _instance->SetData(DATA_CHESS_REINIT_PIECES, 0);

        _summons.DespawnAll();

        for (uint8 row = 0; row < MAX_ROW; ++row)
        {
            for (uint8 col = 0; col < MAX_COL; ++col)
            {
                BoardCell& cell = _boards[row][col];

                if (Creature* trigger = me->SummonCreature(NPC_CHESS_MOVE_TRIGGER, (-11108.099609f + (3.49f * col) + (4.4f * row)), (-1872.910034f - (4.4f * col) + (3.45f * row)), 220.667f, 0, TEMPSUMMON_MANUAL_DESPAWN, 0))
                {
                    cell.SetData(trigger->GetGUID(), row, col);
                    HandleCellInitialData(row, col, trigger, cell);
                }
            }
        }

        _deadCount.fill(0);
    }

    void HandleCellInitialData(uint8 row, uint8 col, Creature* trigger, BoardCell& cell)
    {
        switch (row)
        {
            case 0: // Alliance first row
            {
                switch (col)
                {
                    case 0:
                    case 7: // Rook
                        if (Creature* rook = trigger->FindNearestCreature(NPC_ROOK_A, 4.0f, true))
                        {
                            cell.SetPiece(rook);
                        }
                        break;
                    case 1:
                    case 6: // Knight
                        if (Creature* knight = trigger->FindNearestCreature(NPC_KNIGHT_A, 4.0f, true))
                        {
                            cell.SetPiece(knight);
                        }
                        break;
                    case 2:
                    case 5: // Bishop
                        if (Creature* bishop = trigger->FindNearestCreature(NPC_BISHOP_A, 4.0f, true))
                        {
                            cell.SetPiece(bishop);
                        }
                        break;
                    case 3: // Queen
                        if (Creature* queen = trigger->FindNearestCreature(NPC_QUEEN_A, 4.0f, true))
                        {
                            cell.SetPiece(queen);
                        }
                        break;
                    case 4: // King
                        if (Creature* king = trigger->FindNearestCreature(NPC_KING_A, 4.0f, true))
                        {
                            cell.SetPiece(king);
                        }
                        break;
                }
                break;
            }
            case 1: // Alliance second row
                // All pawns
                if (Creature* pawn = trigger->FindNearestCreature(NPC_PAWN_A, 4.0f, true))
                {
                    cell.SetPiece(pawn);
                }
                break;
            case 6: // Horde second row
                // All pawns
                if (Creature* pawn = trigger->FindNearestCreature(NPC_PAWN_H, 4.0f, true))
                {
                    cell.SetPiece(pawn);
                }
                break;
            case 7: // Horde first row
            {
                switch (col)
                {
                    case 0:
                    case 7: // Rook
                        if (Creature* rook = trigger->FindNearestCreature(NPC_ROOK_H, 4.0f, true))
                        {
                            cell.SetPiece(rook);
                        }
                        break;
                    case 1:
                    case 6: // Knight
                        if (Creature* knight = trigger->FindNearestCreature(NPC_KNIGHT_H, 4.0f, true))
                        {
                            cell.SetPiece(knight);
                        }
                        break;
                    case 2:
                    case 5: // Bishop
                        if (Creature* bishop = trigger->FindNearestCreature(NPC_BISHOP_H, 4.0f, true))
                        {
                            cell.SetPiece(bishop);
                        }
                        break;
                    case 3: // Queen
                        if (Creature* queen = trigger->FindNearestCreature(NPC_QUEEN_H, 4.0f, true))
                        {
                            cell.SetPiece(queen);
                        }
                        break;
                    case 4: // King
                        if (Creature* king = trigger->FindNearestCreature(NPC_KING_H, 4.0f, true))
                        {
                            cell.SetPiece(king);
                        }
                        break;
                    default:
                        break;
                }
                break;
            }
            default:
                cell.Reset();
                break;
        }
    }

    bool IsMedivhPiece(uint32 entry) const
    {
        switch (entry)
        {
            case NPC_PAWN_H:
            case NPC_KNIGHT_H:
            case NPC_QUEEN_H:
            case NPC_BISHOP_H:
            case NPC_ROOK_H:
            case NPC_KING_H:
                return _instance->GetData(CHESS_EVENT_TEAM) == TEAM_ALLIANCE;
            case NPC_PAWN_A:
            case NPC_KNIGHT_A:
            case NPC_QUEEN_A:
            case NPC_BISHOP_A:
            case NPC_ROOK_A:
            case NPC_KING_A:
                return _instance->GetData(CHESS_EVENT_TEAM) == TEAM_HORDE;
        }

        return false;
    }

    Creature* GetHostileTargetForChangeFacing(Creature* piece, KarazhanChessOrientationType orientation)
    {
        for (uint8 row = 0; row < MAX_ROW; ++row)
        {
            for (uint8 col = 0; col < MAX_COL; ++col)
            {
                BoardCell const& cell = _boards[row][col];
                if (cell.pieceGUID != piece->GetGUID())
                    continue;

                std::vector<KarazhanChessOrientationType> orientations;
                switch (orientation)
                {
                    case ORI_SE:
                        orientations = { ORI_NE, ORI_E, ORI_S, ORI_SW };
                        break;
                    case ORI_S:
                        orientations = { ORI_E, ORI_SE, ORI_SW, ORI_W };
                        break;
                    case ORI_SW:
                        orientations = { ORI_SE, ORI_S, ORI_W, ORI_NW };
                        break;
                    case ORI_W:
                        orientations = { ORI_NE, ORI_SW, ORI_NW, ORI_N };
                        break;
                    case ORI_NW:
                        orientations = { ORI_SW, ORI_W, ORI_N, ORI_NE };
                        break;
                    case ORI_N:
                        orientations = { ORI_W, ORI_NW, ORI_NE, ORI_E };
                        break;
                    case ORI_NE:
                        orientations = { ORI_NW, ORI_N, ORI_E, ORI_SE };
                        break;
                    case ORI_E:
                        orientations = { ORI_N, ORI_NE, ORI_SE, ORI_S };
                        break;
                    default:
                        break;
                }

                for (KarazhanChessOrientationType orient : orientations)
                {
                    uint8 newRow = row;
                    uint8 newCol = col;
                    switch (orient)
                    {
                        case ORI_SE:
                            newRow -= 1;
                            break;
                        case ORI_S:
                            newRow -= 1;
                            newCol -= 1;
                            break;
                        case ORI_SW:
                            newCol -= 1;
                            break;
                        case ORI_W:
                            newRow += 1;
                            newCol -= 1;
                            break;
                        case ORI_NW:
                            newRow += 1;
                            break;
                        case ORI_N:
                            newRow += 1;
                            newCol += 1;
                            break;
                        case ORI_NE:
                            newCol += 1;
                            break;
                        case ORI_E:
                            newRow -= 1;
                            newCol += 1;
                            break;
                        default:
                            break;
                    }

                    if (newRow < MAX_ROW && newCol < MAX_COL)
                        if (Creature* targetPiece = ObjectAccessor::GetCreature(*me, _boards[newRow][newCol].pieceGUID))
                            if (!IsFriendly(piece, targetPiece))
                                return targetPiece;
                }

                return nullptr;
            }
        }

        return nullptr;
    }

    void HandlePieceJustDied(Creature* piece)
    {
        switch (piece->GetFaction())
        {
            case CHESS_FACTION_ALLIANCE:
            {
                float baseX = -11078.116211f;
                float baseY = -1908.443115f;
                float deltaX = 2.148438f;
                float deltaY = 1.723755f;
                float extraX = 2.416992f;
                float extraY = -2.889649f;
                float offset = 1.3f * (_deadCount[DEAD_ALLIANCE] % MAX_ROW);
                float finalX = baseX + offset * deltaX + (_deadCount[DEAD_ALLIANCE] >= MAX_ROW ? 1 : 0) * extraX;
                float finalY = baseY + offset * deltaY + (_deadCount[DEAD_ALLIANCE] >= MAX_ROW ? 1 : 0) * extraY;
                piece->NearTeleportTo(finalX, finalY, 221.0f, orientations[ORI_SW]);
                ++_deadCount[DEAD_ALLIANCE];

                piece->CombatStop();
                piece->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                piece->setDeathState(DeathState::JustRespawned);
                piece->SetHealth(piece->GetMaxHealth());
                break;
            }
            case CHESS_FACTION_HORDE:
            {
                float baseX = -11081.393555f;
                float baseY = -1844.194092f;
                float deltaX = -2.148438f;
                float deltaY = -1.723755f;
                float extraX = -2.416992f;
                float extraY = 2.889649f;

                float offset = 1.3f * (_deadCount[DEAD_HORDE] % MAX_ROW);

                float finalX = baseX + offset * deltaX + (_deadCount[DEAD_HORDE] >= MAX_ROW ? 1 : 0) * extraX;
                float finalY = baseY + offset * deltaY + (_deadCount[DEAD_HORDE] >= MAX_ROW ? 1 : 0) * extraY;
                piece->NearTeleportTo(finalX, finalY, 221.0f, orientations[ORI_NE]);
                ++_deadCount[DEAD_HORDE];

                piece->CombatStop();
                piece->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                piece->setDeathState(DeathState::JustRespawned);
                piece->SetHealth(piece->GetMaxHealth());
                break;
            }
        }

        for (uint8 row = 0; row < MAX_ROW; ++row)
        {
            for (uint8 col = 0; col < MAX_COL; ++col)
            {
                if (_boards[row][col].pieceGUID == piece->GetGUID())
                {
                    _boards[row][col].Reset();
                }
            }
        }

        if (_instance->GetData(CHESS_EVENT_TEAM) == TEAM_HORDE)
        {
            bool ended = false;
            switch (piece->GetEntry())
            {
                case NPC_KING_H:
                    _instance->SetData(DATA_CHESS_EVENT, NOT_STARTED);
                    _instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                    _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_NOT_STARTED);
                    break;
                case NPC_KING_A:
                    if (_instance->GetData(DATA_CHESS_EVENT) == IN_PROGRESS)
                    {
                        _instance->SetData(DATA_CHESS_EVENT, DONE);
                        _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                        _instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                        _instance->DoRespawnGameObject(_instance->GetGuidData(DATA_DUST_COVERED_CHEST), DAY);
                        Talk(TALK_EVENT_ENDED);
                        ended = true;
                        _instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                    }
                    else if (_instance->GetData(DATA_CHESS_EVENT) == SPECIAL)
                    {
                        _instance->SetData(DATA_CHESS_EVENT, DONE);
                        _instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                        _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                        ended = true;
                        _instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                    }
                    break;
                default:
                    break;
            }

            if (!ended)
            {
                uint8 talkIndex = TALK_PLAYER_LOOSE_PAWN;
                if (piece->GetFaction() == CHESS_FACTION_ALLIANCE)
                {
                    talkIndex = TALK_MEDIVH_LOOSE_PAWN;
                }

                switch (piece->GetEntry())
                {
                    case NPC_ROOK_A:
                    case NPC_ROOK_H:
                        talkIndex += 1;
                        break;
                    case NPC_KNIGHT_A:
                    case NPC_KNIGHT_H:
                        talkIndex += 2;
                        break;
                    case NPC_BISHOP_A:
                    case NPC_BISHOP_H:
                        talkIndex += 3;
                        break;
                    case NPC_QUEEN_A:
                    case NPC_QUEEN_H:
                        talkIndex += 4;
                        break;
                    case NPC_KING_H:
                    case NPC_KING_A:
                        talkIndex += 5;
                        break;
                }

                Talk(talkIndex);
            }
        }
        else if (_instance->GetData(CHESS_EVENT_TEAM) == TEAM_ALLIANCE)
        {
            bool ended = false;
            switch (piece->GetEntry())
            {
                case NPC_KING_A:
                    _instance->SetData(DATA_CHESS_EVENT, NOT_STARTED);
                    _instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                    _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_NOT_STARTED);
                    break;
                case NPC_KING_H:
                    if (_instance->GetData(DATA_CHESS_EVENT) == IN_PROGRESS)
                    {
                        _instance->SetData(DATA_CHESS_EVENT, DONE);
                        _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                        _instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                        Talk(TALK_EVENT_ENDED);
                        _instance->DoRespawnGameObject(_instance->GetGuidData(DATA_DUST_COVERED_CHEST), DAY);
                        ended = true;
                        _instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                    }
                    else if (_instance->GetData(DATA_CHESS_EVENT) == SPECIAL)
                    {
                        _instance->SetData(DATA_CHESS_EVENT, DONE);
                        _instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                        _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                        _instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                        ended = true;
                    }
                    break;
                default:
                    break;
            }

            if (!ended)
            {
                uint8 talkIndex = TALK_PLAYER_LOOSE_PAWN;
                if (piece->GetFaction() == CHESS_FACTION_HORDE)
                {
                    talkIndex = TALK_MEDIVH_LOOSE_PAWN;
                }

                switch (piece->GetEntry())
                {
                    case NPC_ROOK_A:
                    case NPC_ROOK_H:
                        talkIndex += 1;
                        break;
                    case NPC_KNIGHT_A:
                    case NPC_KNIGHT_H:
                        talkIndex += 2;
                        break;
                    case NPC_BISHOP_A:
                    case NPC_BISHOP_H:
                        talkIndex += 3;
                        break;
                    case NPC_QUEEN_A:
                    case NPC_QUEEN_H:
                        talkIndex += 4;
                        break;
                    case NPC_KING_H:
                    case NPC_KING_A:
                        talkIndex += 5;
                        break;
                }

                Talk(talkIndex);
            }
        }
        else
        {
            switch (piece->GetEntry())
            {
                case NPC_KING_H:
                case NPC_KING_A:
                    _instance->SetData(DATA_CHESS_EVENT, DONE);
                    _instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                    _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                    _instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                    break;
            }

            uint8 talkIndex = TALK_PLAYER_LOOSE_PAWN;
            if (piece->GetFaction() == CHESS_FACTION_HORDE)
            {
                talkIndex = TALK_MEDIVH_LOOSE_PAWN;
            }

            switch (piece->GetEntry())
            {
                case NPC_ROOK_A:
                case NPC_ROOK_H:
                    talkIndex += 1;
                    break;
                case NPC_KNIGHT_A:
                case NPC_KNIGHT_H:
                    talkIndex += 2;
                    break;
                case NPC_BISHOP_A:
                case NPC_BISHOP_H:
                    talkIndex += 3;
                    break;
                case NPC_QUEEN_A:
                case NPC_QUEEN_H:
                    talkIndex += 4;
                    break;
                case NPC_KING_H:
                case NPC_KING_A:
                    talkIndex += 5;
                    break;
            }

            Talk(talkIndex);
        }
    }

    int8 HandlePieceRotate(Creature* piece, ObjectGuid const& triggerGUID)
    {
        bool foundOld = false;
        bool foundNew = false;
        int8 pieceRow = MAX_ROW;
        int8 pieceCol = MAX_COL;
        int8 targetRow = -1;
        int8 targetCol = -1;

        for (uint8 row = 0; row < MAX_ROW; ++row)
        {
            for (uint8 col = 0; col < MAX_COL; ++col)
            {
                BoardCell const& cell = _boards[row][col];
                if (!foundNew && cell.triggerGUID == triggerGUID)
                {
                    targetRow = row;
                    targetCol = col;
                    foundNew = true;
                }

                if (!foundOld && cell.pieceGUID == piece->GetGUID())
                {
                    pieceRow = row;
                    pieceCol = col;
                    foundOld = true;
                }

                if (foundNew && foundOld)
                {
                    break;
                }
            }

            if (foundNew && foundOld)
            {
                break;
            }
        }

        if (targetRow == -1 || targetCol == -1)
        {
            return -1;
        }

        int8 deltaRow = targetRow - pieceRow;
        int8 deltaCol = targetCol - pieceCol;

        if (!deltaRow && !deltaCol)
        {
            return -1;
        }

        switch (deltaRow)
        {
            case -3:
            case -2:
            case -1:
            {
                switch (deltaCol)
                {
                    case -3:
                    case -2:
                    case -1:
                        return ORI_S;
                    case 0:
                        return ORI_SE;
                    case 1:
                    case 2:
                    case 3:
                        return ORI_E;
                    default:
                        break;
                }
                break;
            }
            case 0:
            {
                switch (deltaCol)
                {
                    case -3:
                    case -2:
                    case -1:
                        return ORI_SW;
                    case 1:
                    case 2:
                    case 3:
                        return ORI_NE;
                    default:
                        break;
                }
                break;
            }
            case 1:
            case 2:
            case 3:
            {
                switch (deltaCol)
                {
                    case -3:
                    case -2:
                    case -1:
                        return ORI_W;
                    case 0:
                        return ORI_NW;
                    case 1:
                    case 2:
                    case 3:
                        return ORI_N;
                    default:
                        break;
                }
                break;
            }
            default:
                break;
        }

        return -1;
    }

    int8 HandlePieceMove(Creature* piece, ObjectGuid const& triggerGUID, bool moveByAI)
    {
        bool foundProperCell = false;
        bool foundOld = false;
        bool foundNew = false;
        int8 oldRow = MAX_ROW;
        int8 oldCol = MAX_COL;
        int8 newRow = -1;
        int8 newCol = -1;

        for (uint8 row = 0; row < MAX_ROW; ++row)
        {
            for (uint8 col = 0; col < MAX_COL; ++col)
            {
                BoardCell const& cell = _boards[row][col];
                if (!foundNew)
                {
                    if (cell.triggerGUID == triggerGUID)
                    {
                        //is there already a piece on this cell ?
                        if (cell.pieceGUID)
                        {
                            return -1;
                        }

                        newCol = col;
                        newRow = row;
                        foundProperCell = true;
                        foundNew = true;
                    }
                }

                if (!foundOld)
                {
                    if (cell.pieceGUID == piece->GetGUID())
                    {
                        oldCol = col;
                        oldRow = row;
                        foundOld = true;
                    }
                }

                if (foundNew && foundOld)
                {
                    break;
                }
            }

            if (foundNew && foundOld)
            {
                break;
            }
        }

        if (newCol == -1 || newRow == -1)
        {
            return -1;
        }

        if (!moveByAI && foundProperCell)
        {
            uint8 deltaRow = abs(oldRow - newRow);
            uint8 deltaCol = abs(oldCol - newCol);

            switch (piece->GetEntry())
            {
                case NPC_PAWN_H:
                case NPC_PAWN_A:
                case NPC_BISHOP_H:
                case NPC_BISHOP_A:
                case NPC_ROOK_H:
                case NPC_ROOK_A:
                case NPC_KING_H:
                case NPC_KING_A:
                    if (deltaRow > 1 || deltaCol > 1)
                    {
                        foundProperCell = false;
                    }
                    break;
                case NPC_QUEEN_H:
                case NPC_QUEEN_A:
                    if (deltaRow > 3 || deltaCol > 3)
                    {
                        foundProperCell = false;
                    }
                    break;
                case NPC_KNIGHT_H:
                case NPC_KNIGHT_A:
                    if (deltaRow > 2 || deltaCol > 2)
                    {
                        foundProperCell = false;
                    }
                    break;
                default:
                    break;
            }
        }

        if (foundProperCell || moveByAI)
        {
            int8 orientation = HandlePieceRotate(piece, triggerGUID);
            if (orientation != -1)
            {
                _boards[newRow][newCol].triggerGUID = triggerGUID;
                _boards[newRow][newCol].SetPiece(piece);

                if (oldRow != MAX_ROW && oldCol != MAX_COL)
                {
                    _boards[oldRow][oldCol].Reset();
                }
            }

            return orientation;
        }

        return -1;
    }

    void CastChangeFacing(Creature* piece, Creature* trigger)
    {
        piece->CastSpell(trigger, SPELL_CHANGE_FACING, true);
    }

    bool HandlePieceMoveByAI(Creature* piece, KarazhanChessOrientationType orientation)
    {
        uint8 pieceRow = 0;
        uint8 pieceCol = 0;
        bool found = false;

        for (uint8 row = 0; row < MAX_ROW; ++row)
        {
            for (uint8 col = 0; col < MAX_COL; ++col)
            {
                if (_boards[row][col].pieceGUID == piece->GetGUID())
                {
                    pieceRow = row;
                    pieceCol = col;
                    found = true;
                    break;
                }
            }

            if (found)
            {
                break;
            }
        }

        //! Change orientation at edges
        if (orientation == ORI_SE && pieceRow == 0)
        {
            if (Creature* trigger = ObjectAccessor::GetCreature(*me, _boards[pieceRow + 1][pieceCol].triggerGUID))
            {
                CastChangeFacing(piece, trigger);
            }

            return true;
        }
        else if (orientation == ORI_NW && pieceRow == 7)
        {
            if (Creature* trigger = ObjectAccessor::GetCreature(*me, _boards[pieceRow - 1][pieceCol].triggerGUID))
            {
                CastChangeFacing(piece, trigger);
            }

            return true;
        }
        else if (orientation == ORI_SW && pieceCol == 0)
        {
            if (Creature* trigger = ObjectAccessor::GetCreature(*me, _boards[pieceRow][pieceCol + 1].triggerGUID))
            {
                CastChangeFacing(piece, trigger);
            }

            return true;
        }
        else if (orientation == ORI_NE && pieceCol == 7)
        {
            if (Creature* trigger = ObjectAccessor::GetCreature(*me, _boards[pieceRow][pieceCol - 1].triggerGUID))
            {
                CastChangeFacing(piece, trigger);
            }

            return true;
        }
        else if (urand(0, 1)) // 50% chance to check for nearby enemies
        {
            if (Creature* target = GetHostileTargetForChangeFacing(piece, orientation))
            {
                CastChangeFacing(me, target);
                return true;
            }
        }

        switch (orientation)
        {
            case ORI_W:
            case ORI_N:
                orientation = ORI_NW;
                break;
            case ORI_S:
            case ORI_E:
                orientation = ORI_SE;
                break;
            default:
                break;
        }

        switch (orientation) //! Here we shouldn't be facing the edges of the board, check in the 4 first if statements
        {
            case ORI_SE:
            case ORI_NW:
            {
                int32 randomRow = (orientation == ORI_SE) ? pieceRow - 1 : pieceRow + 1;
                int32 randomCol = pieceCol;
                switch (urand(0, 2))
                {
                    case 0:
                        if ((me->GetEntry() == NPC_QUEEN_A || me->GetEntry() == NPC_QUEEN_H))
                        {
                            randomCol -= irand(1, 2);
                        }
                        else
                        {
                            randomCol -= 1;
                        }
                        break;
                    case 1:
                        if ((me->GetEntry() == NPC_QUEEN_A || me->GetEntry() == NPC_QUEEN_H))
                        {
                            randomCol += irand(1, 2);
                        }
                        else
                        {
                            randomCol += 1;
                        }
                        break;
                    case 2:
                        if ((me->GetEntry() == NPC_QUEEN_A || me->GetEntry() == NPC_QUEEN_H))
                        {
                            randomRow += (orientation == ORI_SE) ? irand(-2, 0) : irand(0, 2);
                        }
                        else if ((me->GetEntry() == NPC_KNIGHT_A || me->GetEntry() == NPC_KNIGHT_H) && urand(0, 1))
                        {
                            randomRow += (orientation == ORI_SE) ? -1 : 1;
                        }
                        break;
                }

                randomRow = RoundToInterval(randomRow, 0, 7);
                randomCol = RoundToInterval(randomCol, 0, 7);

                BoardCell const& cell = _boards[randomRow][randomCol];
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, cell.triggerGUID))
                {
                    if (!cell.pieceGUID)
                    {
                        piece->CastSpell(trigger, SPELL_MOVE_GENERIC, false);
                        return true;
                    }
                }
                break;
            }
            case ORI_SW:
            case ORI_NE:
            {
                int32 randomRow = pieceRow;
                int32 randomCol = orientation == ORI_SW ? pieceCol - 1 : pieceCol + 1;
                switch (urand(0, 2))
                {
                    case 0:
                        if ((me->GetEntry() == NPC_QUEEN_A || me->GetEntry() == NPC_QUEEN_H))
                        {
                            randomRow -= irand(1, 2);
                        }
                        else
                        {
                            randomRow -= 1;
                        }
                        break;
                    case 1:
                        if ((me->GetEntry() == NPC_QUEEN_A || me->GetEntry() == NPC_QUEEN_H))
                        {
                            randomRow += irand(1, 2);
                        }
                        else
                        {
                            randomRow += 1;
                        }
                        break;
                    case 2:
                        if ((me->GetEntry() == NPC_QUEEN_A || me->GetEntry() == NPC_QUEEN_H))
                        {
                            randomCol += (orientation == ORI_SW) ? irand(-2, 0) : irand(0, 2);
                        }
                        else if ((me->GetEntry() == NPC_KNIGHT_A || me->GetEntry() == NPC_KNIGHT_H) && urand(0, 1))
                        {
                            randomCol += (orientation == ORI_SW) ? -1 : 1;
                        }
                        break;
                }

                randomRow = RoundToInterval(randomRow, 0, 7);
                randomCol = RoundToInterval(randomCol, 0, 7);

                BoardCell const& cell = _boards[randomRow][randomCol];
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, cell.triggerGUID))
                {
                    if (!cell.pieceGUID)
                    {
                        piece->CastSpell(trigger, SPELL_MOVE_GENERIC, false);
                        return true;
                    }
                }
                break;
            }
            default:
                break;
        }

        return false;
    }

    void HandleCheat()
    {
        Talk(TALK_MEDIHV_CHEAT);

        switch (urand(0, 2))
        {
            case 0: // Heal king
            {
                if (_instance->GetData(CHESS_EVENT_TEAM) == TEAM_ALLIANCE)
                {
                    if (Creature* king = me->FindNearestCreature(NPC_KING_H, 80.0f, true))
                    {
                        king->SetHealth(king->GetMaxHealth());
                    }
                }
                else if (_instance->GetData(CHESS_EVENT_TEAM) == TEAM_HORDE)
                {
                    if (Creature* king = me->FindNearestCreature(NPC_KING_A, 80.0f, true))
                    {
                        king->SetHealth(king->GetMaxHealth());
                    }
                }

                break;
            }
            case 1: // Fire
            {
                std::list<Creature*> targetList;
                for (uint8 row = 0; row < MAX_ROW; ++row)
                {
                    for (uint8 col = 0; col < MAX_COL; ++col)
                    {
                        BoardCell const& cell = _boards[row][col];
                        if (!cell.pieceGUID || IsMedivhPiece(cell.pieceEntry))
                        {
                            continue;
                        }

                        if (Creature* trigger = ObjectAccessor::GetCreature(*me, cell.triggerGUID))
                        {
                            targetList.push_back(trigger);
                        }
                    }
                }

                if (targetList.size() > 3)
                {
                    Acore::Containers::RandomResize(targetList, 3);
                }

                for (Creature* target : targetList)
                {
                    DoCast(target, SPELL_FURY_OF_MEDIVH_FIRE, true);
                }

                break;
            }
            case 2: // Buff
            {
                std::list<Creature*> targetList;
                for (uint8 row = 0; row < MAX_ROW; ++row)
                {
                    for (uint8 col = 0; col < MAX_COL; ++col)
                    {
                        BoardCell const& cell = _boards[row][col];
                        if (!cell.pieceGUID || !IsMedivhPiece(cell.pieceEntry))
                        {
                            continue;
                        }

                        if (Creature* piece = ObjectAccessor::GetCreature(*me, cell.pieceGUID))
                        {
                            targetList.push_back(piece);
                        }
                    }
                }

                uint8 resizeMax = urand(1, 4);
                if (targetList.size() > resizeMax)
                {
                    Acore::Containers::RandomResize(targetList, resizeMax);
                }

                for (Creature* target : targetList)
                {
                    DoCast(target, SPELL_HAND_OF_MEDIVH, true);
                }

                break;
            }
        }

        Talk(TALK_MEDIHV_CHEAT_EMOTE);
    }

    Creature* GetPiece(Creature* sourcePiece, uint8 searchType, float distance, bool hostile, uint32 minHPDiff, bool checkFront)
    {
        if (!sourcePiece)
        {
            return nullptr;
        }

        Creature* target = nullptr;
        std::vector<Creature*> targets;

        for (uint8 row = 0; row < MAX_ROW; ++row)
        {
            for (uint8 col = 0; col < MAX_COL; ++col)
            {
                if (Creature* piece = ObjectAccessor::GetCreature(*me, _boards[row][col].pieceGUID))
                {
                    if (IsFriendly(piece, sourcePiece) == hostile)
                    {
                        continue;
                    }

                    if (checkFront && !sourcePiece->HasInArc(float(M_PI) / 3.0f, piece))
                    {
                        continue;
                    }

                    if (minHPDiff)
                    {
                        if (piece->GetMaxHealth() - piece->GetHealth() <= minHPDiff)
                        {
                            continue;
                        }

                        minHPDiff = piece->GetMaxHealth() - piece->GetHealth();
                    }

                    float dist = sourcePiece->GetExactDist2d(piece);
                    if (dist < distance)
                    {
                        if (searchType == CHESS_PIECE_SEARCH_TYPE_CLOSEST)
                        {
                            distance = dist;
                            target = piece;
                        }
                        else
                        {
                            targets.push_back(piece);
                        }
                    }
                }
            }
        }

        if (!targets.empty())
        {
            target = Acore::Containers::SelectRandomContainerElement(targets);
        }

        return target;
    }

    void UpdateAI(uint32 diff) override
    {
        uint32 chessPhase = _instance->GetData(DATA_CHESS_GAME_PHASE);
        if (chessPhase != CHESS_PHASE_INPROGRESS_PVE && chessPhase != CHESS_PHASE_INPROGRESS_PVP)
            return;

        if (chessPhase == CHESS_PHASE_INPROGRESS_PVE)
        {
            if (_cheatTimer <= diff)
            {
                HandleCheat();
                _cheatTimer = urand(45000, 100000);
            }
            else
            {
                _cheatTimer -= diff;
            }
        }
    }

    void sGossipHello(Player* player) override
    {
        uint32 chessPhase = _instance->GetData(DATA_CHESS_GAME_PHASE);
        switch (chessPhase)
        {
            case CHESS_PHASE_NOT_STARTED:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "We want to play a game against you!", GOSSIP_SENDER_MAIN, MEDIVH_GOSSIP_START_PVE);
                break;
            case CHESS_PHASE_INPROGRESS_PVE:
            case CHESS_PHASE_INPROGRESS_PVP:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Restart", GOSSIP_SENDER_MAIN, MEDIVH_GOSSIP_RESTART); // We want to player another game against you
                break;
            case CHESS_PHASE_PVE_FINISHED:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "PvP", GOSSIP_SENDER_MAIN, MEDIVH_GOSSIP_START_PVP); // We'd like to fight each other
                break;
        }

        SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
    }

    void sGossipSelect(Player* player, uint32 /*sender*/, uint32 gossipListId) override
    {
        uint32 chessPhase = _instance->GetData(DATA_CHESS_GAME_PHASE);
        _instance->SetData(CHESS_EVENT_TEAM, chessPhase < CHESS_PHASE_PVE_FINISHED ? player->GetTeamId() : TEAM_NEUTRAL);

        CloseGossipMenuFor(player);

        uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
        switch (action)
        {
            case MEDIVH_GOSSIP_START_PVE:
                _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_WARMUP);
                SetupBoard();
                _instance->SetData(DATA_CHESS_EVENT, IN_PROGRESS);
                Talk(TALK_EVENT_BEGIN);
                break;
            case MEDIVH_GOSSIP_RESTART:
                _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_FAILED);
                _instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                _deadCount.fill(0);
                if (_instance->GetData(DATA_CHESS_EVENT) == IN_PROGRESS)
                {
                    _instance->SetData(DATA_CHESS_EVENT, NOT_STARTED);
                    _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_NOT_STARTED);
                }
                else if (_instance->GetData(DATA_CHESS_EVENT) == SPECIAL)
                {
                    _instance->SetData(DATA_CHESS_EVENT, DONE);
                    _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                }
                _instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                break;
            case MEDIVH_GOSSIP_START_PVP:
                _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVP_WARMUP);
                SetupBoard();
                _instance->SetData(DATA_CHESS_EVENT, SPECIAL);
                Talk(TALK_EVENT_BEGIN);
                break;
            default:
                break;
        }
    }

private:
    InstanceScript* _instance;
    SummonList _summons;
    std::array<std::array<BoardCell, MAX_COL>, MAX_ROW> _boards;
    std::array<uint32, 2> _deadCount;
    uint32 _cheatTimer;
};

struct npc_chesspiece : public ScriptedAI
{
    npc_chesspiece(Creature* creature) : ScriptedAI(creature)
    {
        _instance = creature->GetInstanceScript();

        _currentOrientation = GetDefaultOrientationForTeam();

        _nextMoveTimer = urand(8 * IN_MILLISECONDS, 20 * IN_MILLISECONDS);

        InitializeCombatSpellsByEntry();

        switch (_instance->GetData(CHESS_EVENT_TEAM))
        {
            case TEAM_ALLIANCE:
                _teamControlledByRaid = me->GetFaction() == CHESS_FACTION_ALLIANCE;
                break;
            case TEAM_HORDE:
                _teamControlledByRaid = me->GetFaction() == CHESS_FACTION_HORDE;
                break;
            case TEAM_NEUTRAL:
                _teamControlledByRaid = true;
                break;
        }
    }

    void Reset() override
    {
        me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_GAME_IN_SESSION, true);

        me->SetSheath(SHEATH_STATE_MELEE);
        me->SetReactState(REACT_PASSIVE);
        me->SetWalk(true);

        DoCastSelf(SPELL_MELEE_ATTACK_TIMER, true);

        for (uint8 i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; ++i)
        {
            me->SetResistance(SpellSchools(i), 0);
        }
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
    }

    void MovementInform(uint32 movementType, uint32 /*pointId*/) override
    {
        if (movementType != POINT_MOTION_TYPE)
        {
            return;
        }

        if (!me->IsCharmed())
        {
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);

            if (!_nextMoveTimer)
            {
                _nextMoveTimer = urand(10 * IN_MILLISECONDS, 20 * IN_MILLISECONDS);
            }

            if (Creature* medivh = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_ECHO_OF_MEDIVH)))
            {
                if (Creature* target = CAST_AI(npc_echo_of_medivh, medivh->AI())->GetHostileTargetForChangeFacing(me, _currentOrientation))
                {
                    CastChangeFacing(me, target);
                }
            }
        }
    }

    void AttackStart(Unit* /*victim*/) override
    {
    }

    KarazhanChessOrientationType GetDefaultOrientationForTeam()
    {
        switch (me->GetFaction())
        {
            case CHESS_FACTION_ALLIANCE:
                return ORI_NW;
            case CHESS_FACTION_HORDE:
                return ORI_SE;
        }

        return ORI_SE;
    }

    void CastChangeFacing(Creature* piece, Creature* trigger)
    {
        piece->CastSpell(trigger, SPELL_CHANGE_FACING, true);
    }

    void OnCharmed(bool apply) override
    {
        Unit* charmer = me->GetCharmer();
        if (apply)
        {
            ASSERT(charmer);
            _charmerGUID = charmer->GetGUID();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->SetWalk(true);
            charmer->RemoveAurasDueToSpell(SPELL_GAME_IN_SESSION);

            // Build new action bar
            if (Player* playerCharmer = charmer->ToPlayer())
            {
                WorldPacket data(SMSG_PET_SPELLS, 1 + 8 + 2 + 4 + 1 + 1 + 2 + MAX_SPELL_CONTROL_BAR * 4 + 1 + 1);
                data << me->GetGUID();
                data << uint16(0);
                data << uint32(0);
                data << uint8(me->GetReactState());
                data << uint8(0);
                data << uint16(0);

                for (uint32 i = 0; i < MAX_CREATURE_SPELLS; ++i)
                {
                    uint32 spellId = me->m_spells[i];
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
                    if (!spellInfo)
                    {
                        data << uint16(0) << uint8(0) << uint8(i + 8);
                        continue;
                    }

                    data << uint32(MAKE_UNIT_ACTION_BUTTON(spellId, ACT_ENABLED));
                }

                for (uint32 i = MAX_CREATURE_SPELLS; i < MAX_SPELL_CONTROL_BAR; ++i)
                    data << uint32(0);

                data << uint8(0);
                data << uint8(0);

                playerCharmer->SendDirectMessage(&data);
            }
        }
        else
        {
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);

            if (Unit* charmer = ObjectAccessor::GetUnit(*me, _charmerGUID))
            {
                charmer->RemoveAurasDueToSpell(SPELL_CONTROL_PIECE);
                charmer->CastSpell(charmer, SPELL_GAME_IN_SESSION, true);
                charmer->CastSpell(charmer, SPELL_RECENTLY_INGAME, true);
                charmer->NearTeleportTo(-11106.92f, -1843.32f, 229.626f, 4.2331f);
            }

            _charmerGUID.Clear();
        }

        if (apply)
        {
            if (_instance->GetData(CHESS_EVENT_TEAM) == TEAM_ALLIANCE)
            {
                me->SetFaction(CHESS_FACTION_ALLIANCE);
            }
            else if (_instance->GetData(CHESS_EVENT_TEAM) == TEAM_HORDE)
            {
                me->SetFaction(CHESS_FACTION_HORDE);
            }
            else if (uint32 oldFaction = me->GetOldFactionId())
            {
                me->SetFaction(oldFaction);
            }
            else if (FactionTemplateEntry const* factionTemplateEntry = me->GetFactionTemplateEntry())
            {
                me->SetFaction(factionTemplateEntry->faction);
            }
            else
            {
                me->SetFaction(CHESS_FACTION_BOTH);
            }
        }
        else
        {
            switch (me->GetEntry())
            {
                case NPC_PAWN_A:
                case NPC_KING_A:
                case NPC_KNIGHT_A:
                case NPC_QUEEN_A:
                case NPC_BISHOP_A:
                case NPC_ROOK_A:
                    me->SetFaction(CHESS_FACTION_ALLIANCE);
                    break;
                case NPC_KING_H:
                case NPC_ROOK_H:
                case NPC_BISHOP_H:
                case NPC_QUEEN_H:
                case NPC_KNIGHT_H:
                case NPC_PAWN_H:
                    me->SetFaction(CHESS_FACTION_HORDE);
                    break;
                default:
                    break;
            }
        }
    }

    void DoAction(int32 param) override
    {
        switch (param)
        {
            case ACTION_CHESS_PIECE_RESET_ORIENTATION:
                _currentOrientation = GetDefaultOrientationForTeam();
                _nextMoveTimer = urand(8 * IN_MILLISECONDS, 20 * IN_MILLISECONDS);
                break;
            default:
                break;
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* medivh = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_ECHO_OF_MEDIVH)))
        {
            CAST_AI(npc_echo_of_medivh, medivh->AI())->HandlePieceJustDied(me);
        }

        me->RemoveCharmedBy(me->GetCharmer());
    }

    Creature* GetEnemyPiece(float maxDistance, uint8 searchType = CHESS_PIECE_SEARCH_TYPE_CLOSEST, bool checkFront = true)
    {
        if (Creature* medivh = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_ECHO_OF_MEDIVH)))
        {
            return CAST_AI(npc_echo_of_medivh, medivh->AI())->GetPiece(me, searchType, maxDistance, true, 0, checkFront);
        }

        return nullptr;
    }

    Creature* GetLowestHpFriendlyPiece(float maxDistance, uint32 minHPDiff)
    {
        if (Creature* medivh = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_ECHO_OF_MEDIVH)))
        {
            return CAST_AI(npc_echo_of_medivh, medivh->AI())->GetPiece(me, CHESS_PIECE_SEARCH_TYPE_RANDOM, maxDistance, false, minHPDiff, false);
        }

        return nullptr;
    }

    void UpdateAI(uint32 diff) override
    {
        if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) || me->IsNonMeleeSpellCast(false))
        {
            return;
        }

        uint32 chessPhase = _instance->GetData(DATA_CHESS_GAME_PHASE);
        if (chessPhase != CHESS_PHASE_INPROGRESS_PVE && chessPhase != CHESS_PHASE_INPROGRESS_PVP)
        {
            return;
        }

        if (!me->IsCharmed())
        {
            switch (_instance->GetData(CHESS_EVENT_TEAM))
            {
                case TEAM_ALLIANCE:
                    _teamControlledByRaid = me->GetFaction() == CHESS_FACTION_ALLIANCE;
                    break;
                case TEAM_HORDE:
                    _teamControlledByRaid = me->GetFaction() == CHESS_FACTION_HORDE;
                    break;
                case TEAM_NEUTRAL:
                    _teamControlledByRaid = false;
                    break;
            }

            if (!_teamControlledByRaid)
            {
                if (_nextMoveTimer)
                {
                    if (_nextMoveTimer <= diff)
                    {
                        if (Creature* medivh = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_ECHO_OF_MEDIVH)))
                        {
                            if (CAST_AI(npc_echo_of_medivh, medivh->AI())->HandlePieceMoveByAI(me, _currentOrientation))
                            {
                                _nextMoveTimer = 0;
                            }
                            else
                            {
                                _nextMoveTimer = 1 * IN_MILLISECONDS; //! Re-check after a second
                            }
                        }
                    }
                    else
                    {
                        _nextMoveTimer -= diff;
                    }
                }
            }

            if (_combatSpellTimer)
            {
                if (_combatSpellTimer <= diff)
                {
                    _combatSpellTimer = _combatSpellTimerBase + (_teamControlledByRaid ? urand(6 * IN_MILLISECONDS, 12 * IN_MILLISECONDS) : urand(3 * IN_MILLISECONDS, 6 * IN_MILLISECONDS));

                    switch (me->GetEntry())
                    {
                        case NPC_PAWN_A:
                            DoCastSelf(SPELL_PAWN_A_1); //! Shield Block
                            break;
                        case NPC_KING_A:
                            DoCastSelf(SPELL_KING_A_1); //! Heroism
                            break;
                        case NPC_KNIGHT_A:
                            DoCastAOE(SPELL_KNIGHT_A_1); //! Smash
                            break;
                        case NPC_QUEEN_A:
                            if (Creature* victim = GetEnemyPiece(20.0f))
                            {
                                DoCast(victim, SPELL_QUEEN_A_1); //! Elemental Blast
                            }
                            break;
                        case NPC_BISHOP_A:
                            DoCastAOE(SPELL_BISHOP_A_1); //! Holy Lance
                            break;
                        case NPC_ROOK_A:
                            DoCastAOE(SPELL_ROOK_A_1); //! Geyser
                            break;
                        case NPC_KING_H:
                            DoCastAOE(SPELL_KING_H_1); //! Bloodlust
                            break;
                        case NPC_ROOK_H:
                            DoCastAOE(SPELL_ROOK_H_1); //! Hellfire
                            break;
                        case NPC_BISHOP_H:
                            DoCastAOE(SPELL_BISHOP_H_1); //! Shadow Spear
                            break;
                        case NPC_QUEEN_H:
                            if (Creature* victim = GetEnemyPiece(20.0f))
                            {
                                DoCast(victim, SPELL_QUEEN_H_1); //! Fireball
                            }
                            break;
                        case NPC_KNIGHT_H:
                            DoCastAOE(SPELL_KNIGHT_H_1); //! Howl
                            break;
                        case NPC_PAWN_H:
                            DoCastSelf(SPELL_PAWN_H_1); //! Weapon Deflection
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    _combatSpellTimer -= diff;
                }
            }

            if (_combatSpellTimer2)
            {
                if (_combatSpellTimer2 <= diff)
                {
                    _combatSpellTimer2 = _combatSpellTimerBase2 + (_teamControlledByRaid ? urand(6 * IN_MILLISECONDS, 12 * IN_MILLISECONDS) : urand(3 * IN_MILLISECONDS, 6 * IN_MILLISECONDS));

                    switch (me->GetEntry())
                    {
                        case NPC_PAWN_A:
                            DoCastAOE(SPELL_PAWN_A_2); //! Heroic Blow
                            break;
                        case NPC_KING_A:
                            DoCastAOE(SPELL_KING_A_2); //! Sweep
                            break;
                        case NPC_KNIGHT_A:
                            DoCastAOE(SPELL_KNIGHT_A_2); //! Stomp
                            break;
                        case NPC_QUEEN_A:
                            if (Creature* victim = GetEnemyPiece(25.0f, CHESS_PIECE_SEARCH_TYPE_RANDOM, false))
                            {
                                DoCast(victim, SPELL_QUEEN_A_2); //! Rain of Fire
                            }
                            break;
                        case NPC_BISHOP_A:
                            if (Creature* target = GetLowestHpFriendlyPiece(25.0f, 5000))
                            {
                                DoCast(target, SPELL_BISHOP_A_2);
                            }
                            break;
                        case NPC_ROOK_A:
                            DoCast(SPELL_ROOK_A_2); //! Water Shield
                            break;
                        case NPC_KING_H:
                            DoCastAOE(SPELL_KING_H_2); //! Cleave
                            break;
                        case NPC_ROOK_H:
                            DoCast(SPELL_ROOK_H_2); //! Fire Shield
                            break;
                        case NPC_QUEEN_H:
                            if (Creature* victim = GetEnemyPiece(25.0f, CHESS_PIECE_SEARCH_TYPE_RANDOM, false))
                            {
                                DoCast(victim, SPELL_QUEEN_H_2); //! Poison Cloud
                            }
                            break;
                        case NPC_BISHOP_H:
                            if (Unit* target = GetLowestHpFriendlyPiece(25.0f, 5000))
                            {
                                DoCast(target, SPELL_BISHOP_H_2);
                            }
                            break;
                        case NPC_KNIGHT_H:
                            DoCastAOE(SPELL_KNIGHT_H_2); //! Bite
                            break;
                        case NPC_PAWN_H:
                            DoCastAOE(SPELL_PAWN_H_2); //! Vicious Strike
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    _combatSpellTimer2 -= diff;
                }
            }
        }
    }

    void InitializeCombatSpellsByEntry()
    {
        switch (me->GetEntry())
        {
            case NPC_PAWN_A:
            case NPC_PAWN_H:
                _combatSpellTimer = urand(7 * IN_MILLISECONDS, 27 * IN_MILLISECONDS);
                _combatSpellTimer2 = urand(3 * IN_MILLISECONDS, 5 * IN_MILLISECONDS);
                break;
            case NPC_KING_A:
            case NPC_KING_H:
                _combatSpellTimer = urand(13 * IN_MILLISECONDS, 15 * IN_MILLISECONDS);
                _combatSpellTimer2 = urand(3 * IN_MILLISECONDS, 5 * IN_MILLISECONDS);
                break;
            case NPC_BISHOP_A:
            case NPC_BISHOP_H:
                _combatSpellTimer = urand(7 * IN_MILLISECONDS, 15 * IN_MILLISECONDS);
                _combatSpellTimer2 = urand(15 * IN_MILLISECONDS, 90 * IN_MILLISECONDS);
                break;
            case NPC_ROOK_A:
            case NPC_ROOK_H:
            case NPC_KNIGHT_A:
            case NPC_KNIGHT_H:
            case NPC_QUEEN_A:
            case NPC_QUEEN_H:
                _combatSpellTimer = urand(7 * IN_MILLISECONDS, 15 * IN_MILLISECONDS);
                _combatSpellTimer2 = urand(7 * IN_MILLISECONDS, 27 * IN_MILLISECONDS);
                break;

            default:
                return;
        }

        _combatSpellTimerBase = _combatSpellTimer;
        _combatSpellTimerBase2 = _combatSpellTimer2;
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_MELEE_ATTACK_TIMER_TRIGGER)
        {
            if (Creature* victim = GetEnemyPiece(10.0f))
            {
                DoCast(victim, SPELL_MELEE_DAMAGE, true);
            }

            return;
        }

        if (target->GetEntry() != NPC_CHESS_MOVE_TRIGGER || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
        {
            return;
        }

        switch (spellInfo->Id)
        {
            case SPELL_MOVE_1:
            case SPELL_MOVE_2:
            case SPELL_MOVE_3:
            case SPELL_MOVE_4:
            case SPELL_MOVE_5:
            case SPELL_MOVE_6:
            case SPELL_MOVE_GENERIC:
                if (Creature* medivh = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_ECHO_OF_MEDIVH)))
                {
                    int8 result = CAST_AI(npc_echo_of_medivh, medivh->AI())->HandlePieceMove(me, target->GetGUID(), spellInfo->Id == SPELL_MOVE_GENERIC);
                    if (result != -1)
                    {
                        DoCast(SPELL_MOVE_COOLDOWN);
                        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        me->GetMotionMaster()->MovePoint(0, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ());
                        target->CastSpell(target, SPELL_MOVE_MARKER, false);
                        _currentOrientation = KarazhanChessOrientationType(result);
                    }
                }
                break;
            case SPELL_CHANGE_FACING:
                if (Creature* medivh = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_ECHO_OF_MEDIVH)))
                {
                    int8 result = CAST_AI(npc_echo_of_medivh, medivh->AI())->HandlePieceRotate(me, target->GetGUID());
                    if (result != -1)
                    {
                        DoCast(SPELL_MOVE_COOLDOWN);
                        _currentOrientation = KarazhanChessOrientationType(result);
                        me->SetFacingTo(orientations[_currentOrientation]);
                        if (!_nextMoveTimer)
                        {
                            _nextMoveTimer = urand(10 * IN_MILLISECONDS, 20 * IN_MILLISECONDS);
                        }
                    }
                }
                break;
            default:
                break;
        }
    }

    void sGossipHello(Player* player) override
    {
        uint32 chessPhase = _instance->GetData(DATA_CHESS_GAME_PHASE);
        if (_instance->GetData(CHESS_EVENT_TEAM) == TEAM_ALLIANCE && me->GetFaction() != CHESS_FACTION_ALLIANCE && chessPhase < CHESS_PHASE_PVE_FINISHED)
        {
            SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
            return;
        }

        if (_instance->GetData(CHESS_EVENT_TEAM) == TEAM_HORDE && me->GetFaction() != CHESS_FACTION_HORDE && chessPhase < CHESS_PHASE_PVE_FINISHED)
        {
            SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
            return;
        }

        bool ok = true;
        switch (me->GetEntry())
        {
            case NPC_PAWN_H:
            case NPC_PAWN_A:
            case NPC_KNIGHT_H:
            case NPC_KNIGHT_A:
            case NPC_QUEEN_H:
            case NPC_QUEEN_A:
            case NPC_BISHOP_H:
            case NPC_BISHOP_A:
            case NPC_ROOK_H:
            case NPC_ROOK_A:
                if (chessPhase != CHESS_PHASE_INPROGRESS_PVE && chessPhase != CHESS_PHASE_INPROGRESS_PVP)
                {
                    ok = false;
                }
                break;
            case NPC_KING_H:
            case NPC_KING_A:
                if (chessPhase != CHESS_PHASE_INPROGRESS_PVE && chessPhase != CHESS_PHASE_INPROGRESS_PVP && chessPhase != CHESS_PHASE_PVE_WARMUP && chessPhase != CHESS_PHASE_PVP_WARMUP)
                {
                    ok = false;
                }
                break;
            default:
                ok = false;
                break;
        }

        if (ok && !player->HasAura(SPELL_RECENTLY_INGAME))
        {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Control " + me->GetName(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        SendGossipMenuFor(player, player->GetGossipTextId(me), me->GetGUID());
    }

    void sGossipSelect(Player* player, uint32 /*sender*/, uint32 gossipListId) override
    {
        if (me->IsCharmed() && me->GetCharmerGUID() == player->GetGUID())
        {
            me->RemoveCharmedBy(me->GetCharmer());
            player->StopCastingCharm();
        }

        uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            player->CastSpell(me, SPELL_CONTROL_PIECE, false);

            switch (me->GetEntry())
            {
                case NPC_KING_H:
                case NPC_KING_A:
                {
                    uint32 chessPhase = _instance->GetData(DATA_CHESS_GAME_PHASE);
                    if (chessPhase == CHESS_PHASE_PVE_WARMUP)
                    {
                        _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_INPROGRESS_PVE);
                    }
                    else if (chessPhase == CHESS_PHASE_PVP_WARMUP)
                    {
                        _instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_INPROGRESS_PVP);
                    }
                    break;
                }
                default:
                    break;
            }
        }

        CloseGossipMenuFor(player);
    }

private:
    InstanceScript* _instance;

    ObjectGuid _charmerGUID;

    uint32 _nextMoveTimer;
    uint32 _combatSpellTimer;
    uint32 _combatSpellTimerBase;
    uint32 _combatSpellTimer2;
    uint32 _combatSpellTimerBase2;

    KarazhanChessOrientationType _currentOrientation;

    bool _teamControlledByRaid;
};

struct npc_chess_move_trigger : public ScriptedAI
{
    npc_chess_move_trigger(Creature* creature) : ScriptedAI(creature)
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }
};

class spell_control_piece : public AuraScript
{
    PrepareAuraScript(spell_control_piece)

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Player* player = GetTarget()->ToPlayer())
        {
            player->StopCastingBindSight();
        }
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_control_piece::HandleEffectRemove, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_chess_event()
{
    RegisterKarazhanCreatureAI(npc_echo_of_medivh);
    RegisterKarazhanCreatureAI(npc_chesspiece);
    RegisterKarazhanCreatureAI(npc_chess_move_trigger);

    RegisterSpellScript(spell_control_piece);
}
