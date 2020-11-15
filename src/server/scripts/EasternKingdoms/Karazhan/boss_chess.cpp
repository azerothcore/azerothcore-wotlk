#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "HostileRefManager.h"
#include "ScriptedEscortAI.h"
#include "ScriptedFollowerAI.h"
#include "ScriptedGossip.h"
#include "ObjectMgr.h" 
#include "World.h" 
#include "Player.h"
#include "SpellInfo.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "Unit.h"
#include "karazhan.h"

struct BoardCell
{
    uint64 triggerGUID;
    uint64 pieceGUID;
    uint32 pieceEntry;
    uint8 row;
    uint8 col;

    void SetData(uint64 _triggerGUID, uint8 _row, uint8 _col)
    {
        triggerGUID = _triggerGUID;
        row = _row;
        col = _col;
    }

    void Reset()
    {
        pieceGUID = 0;
        pieceEntry = 0;
    }

    void SetPiece(Creature* piece)
    {
        pieceGUID = piece->GetGUID();
        pieceEntry = piece->GetEntry();
    }
};

//! Facing Medivh = 1 = ORI_SW = col - 1 (col - 1)
//! To the right  = 0 = ORI_SE = row - 1 (row - 1)
//! To the right  = 3 = ORI_NE = col + 1 (col + 1)
//! To the right  = 2 = ORI_NW = row + 1 (row + 1)

//                        ORI_SE     ORI_SW     ORI_NW     ORI_NE
float orientations[4] = { 3.809080f, 2.235102f, 0.661124f, 5.385472f };

class npc_echo_of_medivh : public CreatureScript
{
public:
    npc_echo_of_medivh() : CreatureScript("npc_echo_of_medivh") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_echo_of_medivhAI(creature);
    }

    struct npc_echo_of_medivhAI : public ScriptedAI
    {
        npc_echo_of_medivhAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        BoardCell* board[8][8];

        uint32 cheatTimer;
        uint32 deadCount[2];

        InstanceScript* instance;

        void Reset()
        {
            for (uint8 row = 0; row < 8; row++)
                for (uint8 col = 0; col < 8; col++)
                    board[row][col] = NULL;

            cheatTimer = urand(45000, 100000);
        }

        void RemoveCheats()
        {
            // Buffs
            for (uint8 row = 0; row < 8; row++)
                for (uint8 col = 0; col < 8; col++)
                    if (uint64 guid = board[row][col]->pieceGUID)
                        if (Creature* piece = ObjectAccessor::GetCreature(*me, guid))
                            piece->RemoveAurasDueToSpell(SPELL_HAND_OF_MEDIVH);
        }

        void SetupBoard()
        {
            if (instance)
                instance->SetData(DATA_CHESS_CHECK_PIECES_ALIVE, 0);

            std::list<Creature*> triggers;
            me->GetCreatureListWithEntryInGrid(triggers, NPC_CHESS_MOVE_TRIGGER, 300.0f);

            for (std::list<Creature*>::iterator itr = triggers.begin(); itr != triggers.end(); ++itr)
                (*itr)->DespawnOrUnsummon();

            // Cleanup needed?
            for (uint8 row = 0; row < 8; row++)
                for (uint8 col = 0; col < 8; col++)
                    delete board[row][col];

            for (uint8 row = 0; row < 8; row++)
            {
                for (uint8 col = 0; col < 8; col++)
                {
                    BoardCell* cell = new BoardCell();
                    board[row][col] = cell;

                    if (Creature* trigger = me->SummonCreature(NPC_CHESS_MOVE_TRIGGER, (-11108.099609 + (3.49f * col) + (4.4f * row)), (-1872.910034 - (4.4f * col) + (3.45f * row)), 220.667f, 0, TEMPSUMMON_MANUAL_DESPAWN, 0))
                    {
                        cell->SetData(trigger->GetGUID(), row, col);
                        HandleCellInitialData(row, col, trigger, cell);
                    }
                }
            }

            for (int i = 0; i < 2; ++i)
                deadCount[i] = 0;
        }

        void HandleCellInitialData(uint8 row, uint8 col, Creature* trigger, BoardCell* cell)
        {
            switch (row)
            {
                case 0: // Alliance first row
                    switch (col)
                    {
                        case 0:
                        case 7: // Rook
                            if (Creature* rook = trigger->FindNearestCreature(NPC_ROOK_A, 40.0f, true))
                                cell->SetPiece(rook);
                            break;

                        case 1:
                        case 6: // Knight
                            if (Creature* knight = trigger->FindNearestCreature(NPC_KNIGHT_A, 40.0f, true))
                                cell->SetPiece(knight);
                            break;

                        case 2:
                        case 5: // Bishop
                            if (Creature* bishop = trigger->FindNearestCreature(NPC_BISHOP_A, 40.0f, true))
                                cell->SetPiece(bishop);
                            break;

                        case 3: // Queen
                            if (Creature* queen = trigger->FindNearestCreature(NPC_QUEEN_A, 40.0f, true))
                                cell->SetPiece(queen);
                            break;

                        case 4: // King
                            if (Creature* king = trigger->FindNearestCreature(NPC_KING_A, 40.0f, true))
                                cell->SetPiece(king);
                            break;
                    }
                    break;
                case 1: // Alliance second row
                    // All pawns
                    if (Creature* pawn = trigger->FindNearestCreature(NPC_PAWN_A, 40.0f, true))
                        cell->SetPiece(pawn);
                    break;

                case 6: // Horde second row
                    // All pawns
                    if (Creature* pawn = trigger->FindNearestCreature(NPC_PAWN_H, 40.0f, true))
                        cell->SetPiece(pawn);
                    break;

                case 7: // Horde first row
                    switch (col)
                    {
                        case 0:
                        case 7: // Rook
                            if (Creature* rook = trigger->FindNearestCreature(NPC_ROOK_H, 40.0f, true))
                                cell->SetPiece(rook);
                            break;

                        case 1:
                        case 6: // Knight
                            if (Creature* knight = trigger->FindNearestCreature(NPC_KNIGHT_H, 40.0f, true))
                                cell->SetPiece(knight);
                            break;

                        case 2:
                        case 5: // Bishop
                            if (Creature* bishop = trigger->FindNearestCreature(NPC_BISHOP_H, 40.0f, true))
                                cell->SetPiece(bishop);
                            break;

                        case 3: // Queen
                            if (Creature* queen = trigger->FindNearestCreature(NPC_QUEEN_H, 40.0f, true))
                                cell->SetPiece(queen);
                            break;

                        case 4: // King
                            if (Creature* king = trigger->FindNearestCreature(NPC_KING_H, 40.0f, true))
                                cell->SetPiece(king);
                            break;
                    }
                    break;
                default:
                    ////sLog.outString("Default for %u %u", row, col);
                    cell->Reset();
                    break;
            }
        }

        bool IsMedivhPiece(uint32 entry)
        {
            if (!instance)
                return false;

            switch (entry)
            {
                case NPC_PAWN_H:
                case NPC_KNIGHT_H:
                case NPC_QUEEN_H:
                case NPC_BISHOP_H:
                case NPC_ROOK_H:
                case NPC_KING_H:
                    return instance->GetData(CHESS_EVENT_TEAM) == ALLIANCE;
                case NPC_PAWN_A:
                case NPC_KNIGHT_A:
                case NPC_QUEEN_A:
                case NPC_BISHOP_A:
                case NPC_ROOK_A:
                case NPC_KING_A:
                    return instance->GetData(CHESS_EVENT_TEAM) == HORDE;
            }

            return false;
        }

        Creature* GetTargetFor(Creature* piece, KarazhanChessOrientationType orientation)
        {
            Creature* target = NULL;
            BoardCell* targetCell = NULL;

            for (uint8 row = 0; row < 8 && !targetCell; row++)
            {
                for (uint8 col = 0; col < 8 && !targetCell; col++)
                {
                    BoardCell* cell = board[row][col];

                    if (cell && cell->pieceGUID == piece->GetGUID())
                    {
                        switch (orientation)
                        {
                            //! Before setting targetCell we check if we're not at the edge of the board
                            case ORI_SE:
                                if (row != 0)
                                    targetCell = board[row - 1][col];
                                break;

                            case ORI_SW:
                                if (col != 0)
                                    targetCell = board[row][col - 1];
                                break;

                            case ORI_NW:
                                if (row != 7)
                                    targetCell = board[row + 1][col];
                                break;

                            case ORI_NE:
                                if (col != 7)
                                    targetCell = board[row][col + 1];
                                break;
                        }
                    }
                }
            }

            if (targetCell && targetCell->pieceGUID)
                target = ObjectAccessor::GetCreature(*me, targetCell->pieceGUID);

            return target;
        }

        void HandlePieceJustDied(Creature* piece)
        {
            switch (piece->getFaction())
            {
                case A_FACTION:
                {
                    float baseX = -11078.116211f;
                    float baseY = -1908.443115f;
                    float deltaX = 2.148438f;
                    float deltaY = 1.723755f;
                    float extraX = 2.416992f;
                    float extraY = -2.889649f;
                    float offset = 1.3f * (deadCount[DEAD_ALLIANCE] % 8);
                    float finalX = baseX + offset * deltaX + (deadCount[DEAD_ALLIANCE] >= 8 ? 1 : 0) * extraX;
                    float finalY = baseY + offset * deltaY + (deadCount[DEAD_ALLIANCE] >= 8 ? 1 : 0) * extraY;
                    piece->NearTeleportTo(finalX, finalY, 222.0f, orientations[ORI_SW]);
                    ++deadCount[DEAD_ALLIANCE];

                    piece->CombatStop();
                    piece->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    piece->setDeathState(JUST_RESPAWNED);
                    piece->SetHealth(piece->GetMaxHealth());
                    break;
                }
                case H_FACTION:
                {
                    float baseX = -11081.393555f;
                    float baseY = -1844.194092f;
                    float deltaX = -2.148438f;
                    float deltaY = -1.723755f;
                    float extraX = -2.416992f;
                    float extraY = 2.889649f;

                    float offset = 1.3f * (deadCount[DEAD_HORDE] % 8);

                    float finalX = baseX + offset * deltaX + (deadCount[DEAD_HORDE] >= 8 ? 1 : 0) * extraX;
                    float finalY = baseY + offset * deltaY + (deadCount[DEAD_HORDE] >= 8 ? 1 : 0) * extraY;
                    piece->NearTeleportTo(finalX, finalY, 222.0f, orientations[ORI_NE]);
                    ++deadCount[DEAD_HORDE];

                    piece->CombatStop();
                    piece->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    piece->setDeathState(JUST_RESPAWNED);
                    piece->SetHealth(piece->GetMaxHealth());
                    break;
                }
            }

            for (uint8 row = 0; row < 8; row++)
                for (uint8 col = 0; col < 8; col++)
                    if (board[row][col]->pieceGUID == piece->GetGUID())
                        board[row][col]->Reset();

            if (!instance)
                return;

            if (instance->GetData(CHESS_EVENT_TEAM) == HORDE)
            {
                switch (piece->GetEntry())
                {
                    case NPC_KING_H:
                        instance->SetData(DATA_CHESS_EVENT, NOT_STARTED);
                        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                        instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                        instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_NOT_STARTED);
                        break;

                    case NPC_KING_A:
                        if (instance->GetData(DATA_CHESS_EVENT) == IN_PROGRESS)
                        {
                            instance->SetData(DATA_CHESS_EVENT, DONE);
                            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                            instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                            me->SummonGameObject(DUST_COVERED_CHEST, -11058.0f, -1903.0f, 222.0f, 2.24f, 0.f, 0.f, 0.f, 0.f, 7200000);
                            instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                        }
                        else if (instance->GetData(DATA_CHESS_EVENT) == SPECIAL)
                        {
                            instance->SetData(DATA_CHESS_EVENT, DONE);
                            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                            instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                            instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                        }
                        break;

                    default:
                        break;
                }
            }
            else if (instance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
            {
                switch (piece->GetEntry())
                {
                    case NPC_KING_A:
                        instance->SetData(DATA_CHESS_EVENT, NOT_STARTED);
                        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                        instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                        instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_NOT_STARTED);
                        break;

                    case NPC_KING_H:
                        me->MonsterTextEmote("The halls of Karazhan shake, as the curse binding the doors of the Gamesman's Hall is lifted.", 0, false);

                        if (instance->GetData(DATA_CHESS_EVENT) == IN_PROGRESS)
                        {
                            instance->SetData(DATA_CHESS_EVENT, DONE);
                            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                            instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                            me->SummonGameObject(DUST_COVERED_CHEST, -11058.0f, -1903.0f, 222.0f, 2.24f, 0.f, 0.f, 0.f, 0.f, 7200000);
                            instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                        }
                        else if (instance->GetData(DATA_CHESS_EVENT) == SPECIAL)
                        {
                            instance->SetData(DATA_CHESS_EVENT, DONE);
                            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                            instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                            instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                        }
                        break;

                    default:
                        break;
                }
            }
            else
            {
                switch (piece->GetEntry())
                {
                    case NPC_KING_H:
                    case NPC_KING_A:
                        instance->SetData(DATA_CHESS_EVENT, DONE);
                        instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
                        instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
                        instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_FINISHED);
                        break;
                }
            }
        }

        int HandlePieceRotate(Creature* piece, uint64 trigger)
        {
            bool foundOld = false;
            bool foundNew = false;
            int8 pieceRow = 8, pieceCol = 8, targetRow = -1, targetCol = -1;

            for (uint8 row = 0; row < 8; row++)
            {
                for (uint8 col = 0; col < 8; col++)
                {
                    BoardCell* cell = board[row][col];

                    if (!foundNew && cell->triggerGUID == trigger)
                    {
                        targetRow = row;
                        targetCol = col;
                        foundNew = true;
                    }

                    if (!foundOld && cell->pieceGUID == piece->GetGUID())
                    {
                        pieceRow = row;
                        pieceCol = col;
                        foundOld = true;
                    }

                    if (foundNew && foundOld)
                        break;
                }

                if (foundNew && foundOld)
                    break;
            }

            if (targetRow == -1 || targetCol == -1)
                return 0;

            int8 deltaRow = pieceRow - targetRow;
            int8 deltaCol = pieceCol - targetCol;

            if (fabs((float)deltaRow) + fabs((float)deltaCol) > 1)
                return -1;

            if (deltaRow == 1 && deltaCol == 0)
                return ORI_SE;

            if (deltaRow == 0 && deltaCol == 1)
                return ORI_SW;

            if (deltaRow == -1 && deltaCol == 0)
                return ORI_NW;

            if (deltaRow == 0 && deltaCol == -1)
                return ORI_NE;

            return 0;
        }

        bool HandlePieceMove(Creature* piece, uint64 trigger)
        {
            bool foundProperCell = false;
            bool foundOld = false;
            bool foundNew = false;
            int8 oldCol = 8, oldRow = 8, newCol = -1, newRow = -1;

            for (uint8 row = 0; row < 8; row++)
            {
                for (uint8 col = 0; col < 8; col++)
                {
                    BoardCell* cell = board[row][col];

                    if (!foundNew)
                    {
                        if (cell->triggerGUID == trigger)
                        {
                            //is there already a piece on this cell ?
                            if (cell->pieceGUID)
                                return false;

                            newCol = col;
                            newRow = row;
                            foundProperCell = true;
                            foundNew = true;
                        }
                    }

                    if (!foundOld)
                    {
                        if (cell->pieceGUID == piece->GetGUID())
                        {
                            oldCol = col;
                            oldRow = row;
                            foundOld = true;
                        }
                    }

                    if (foundNew && foundOld)
                        break;
                }

                if (foundNew && foundOld)
                    break;
            }

            if (newCol == -1 || newRow == -1)
                return false;

            if (foundProperCell)
            {
                uint8 deltaRow = fabs((float)oldRow - newRow);
                uint8 deltaCol = fabs((float)oldCol - newCol);

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
                            foundProperCell = false;
                        break;

                    case NPC_QUEEN_H:
                    case NPC_QUEEN_A:
                        if (deltaRow > 3 || deltaCol > 3)
                            foundProperCell = false;
                        break;

                    case NPC_KNIGHT_H:
                    case NPC_KNIGHT_A:
                        if (deltaRow > 2 || deltaCol > 2)
                            foundProperCell = false;
                        break;

                    default:
                        break;
                }
            }

            if (foundProperCell)
            {
                board[newRow][newCol]->triggerGUID = trigger;
                board[newRow][newCol]->SetPiece(piece);

                if (oldRow != 8 && oldCol != 8)
                    board[oldRow][oldCol]->Reset();
            }

            return foundProperCell;
        }

        void CastChangeFacing(Creature* piece, Creature* trigger)
        {
            piece->CastSpell(trigger, SPELL_CHANGE_FACING, false);
            piece->AttackStop();
        }

        bool HandlePieceMoveByAI(Creature* piece, KarazhanChessOrientationType orientation)
        {
            uint8 pieceRow = 0, pieceCol = 0;
            bool found = false;

            for (uint8 row = 0; row < 8; row++)
            {
                for (uint8 col = 0; col < 8; col++)
                {
                    if (board[row][col]->pieceGUID == piece->GetGUID())
                    {
                        pieceRow = row;
                        pieceCol = col;
                        found = true;
                        break;
                    }
                }

                if (found)
                    break;
            }

            //! Change orientation at edges
            if (orientation == ORI_SE && pieceRow == 0)
            {
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, board[pieceRow + 1][pieceCol]->triggerGUID))
                    CastChangeFacing(piece, trigger);
                return true;
            }
            else if (orientation == ORI_NW && pieceRow == 7)
            {
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, board[pieceRow - 1][pieceCol]->triggerGUID))
                    CastChangeFacing(piece, trigger);
                return true;
            }
            else if (orientation == ORI_SW && pieceCol == 0)
            {
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, board[pieceRow][pieceCol + 1]->triggerGUID))
                    CastChangeFacing(piece, trigger);
                return true;
            }
            else if (orientation == ORI_NE && pieceCol == 7)
            {
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, board[pieceRow][pieceCol - 1]->triggerGUID))
                    CastChangeFacing(piece, trigger);
                return true;
            }
            else if (urand(0, 1)) // 50% chance to check for nearby enemies
            {
                if (pieceRow > 0 && pieceRow < 7 && pieceCol > 0 && pieceCol < 7)
                {
                    Creature* neighbour = ObjectAccessor::GetCreature(*me, board[pieceRow - 1][pieceCol]->pieceGUID);

                    if (neighbour == NULL)
                        Creature* neighbour = ObjectAccessor::GetCreature(*me, board[pieceRow + 1][pieceCol]->pieceGUID);

                    if (neighbour == NULL)
                        Creature* neighbour = ObjectAccessor::GetCreature(*me, board[pieceRow][pieceCol - 1]->pieceGUID);

                    if (neighbour == NULL)
                        Creature* neighbour = ObjectAccessor::GetCreature(*me, board[pieceRow][pieceCol + 1]->pieceGUID);

                    if (neighbour && !piece->IsFriendlyTo(neighbour))
                        CastChangeFacing(piece, neighbour);
                }
                return true;
            }
            //! Just not move at all - resets timer
            //else if (urand(0, 1) == 1) // rand() % 4 != 0
            //    return true;

            switch (orientation) //! Here we shouldn't be facing the edges of the board, check in the 4 first if statements
            {
                case ORI_SE:
                case ORI_NW:
                {
                    int randomCol = 0;

                    switch (urand(0, 2))
                    {
                        case 0:
                            randomCol = pieceCol - 1;
                            break;
                        case 1:
                            randomCol = pieceCol;
                            break;
                        case 2:
                            randomCol = pieceCol + 1;
                            break;
                    }

                    if (randomCol > 7)
                        randomCol = 7;

                    if (randomCol < 0)
                        randomCol = 0;

                    if (BoardCell* cell = board[orientation == ORI_SE ? pieceRow - 1 : pieceRow + 1][randomCol])
                        if (Creature* trigger = ObjectAccessor::GetCreature(*me, cell->triggerGUID))
                            if (!cell->pieceGUID)
                                piece->CastSpell(trigger, SPELL_MOVE_1, false);

                    break;
                    //return HandlePieceMove(piece, board[orientation == ORI_SE ? pieceRow - 1 : pieceRow + 1][randomCol]->triggerGUID);
                }
                case ORI_SW:
                case ORI_NE:
                {
                    int randomRow = 0;

                    switch (urand(0, 2))
                    {
                        case 0:
                            randomRow = pieceRow - 1;
                            break;
                        case 1:
                            randomRow = pieceRow;
                            break;
                        case 2:
                            randomRow = pieceRow + 1;
                            break;
                    }

                    if (randomRow > 7)
                        randomRow = 7;

                    if (randomRow < 0)
                        randomRow = 0;

                    if (BoardCell* cell = board[randomRow][orientation == ORI_SW ? pieceCol - 1 : pieceCol + 1])
                        if (Creature* trigger = ObjectAccessor::GetCreature(*me, cell->triggerGUID))
                            if (!cell->pieceGUID)
                                piece->CastSpell(trigger, SPELL_MOVE_1, false);

                    break;
                    //return HandlePieceMove(piece, board[randomRow][orientation == ORI_SW ? pieceCol - 1 : pieceCol + 1]->triggerGUID);
                }
            }

            return true;
        }

        void HandleCheat()
        {
            switch (urand(0, 2))
            {
                case 0: // Heal king
                {
                    if (instance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
                    {
                        if (Creature* king = me->FindNearestCreature(NPC_KING_H, 80.0f, true))
                            king->SetHealth(king->GetMaxHealth());
                    }
                    else if (instance->GetData(CHESS_EVENT_TEAM) == HORDE)
                    {
                        if (Creature* king = me->FindNearestCreature(NPC_KING_A, 80.0f, true))
                            king->SetHealth(king->GetMaxHealth());
                    }

                    break;
                }
                case 1: // Fire
                {
                    std::list<Creature*> targetList;

                    for (uint8 row = 0; row < 8; row++)
                    {
                        for (uint8 col = 0; col < 8; col++)
                        {
                            BoardCell* cell = board[row][col];

                            if (!cell->pieceGUID || IsMedivhPiece(cell->pieceEntry))
                                continue;

                            if (Creature* trigger = ObjectAccessor::GetCreature(*me, cell->triggerGUID))
                                targetList.push_back(trigger);
                        }
                    }

                    if (targetList.size() > 3)
                        acore::Containers::RandomResizeList(targetList, 3);

                    for (std::list<Creature*>::iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
                        DoCast(*itr, SPELL_FURY_OF_MEDIVH_FIRE, true);

                    break;
                }
                case 2: // Buff
                {
                    std::list<Creature*> targetList;

                    for (uint8 row = 0; row < 8; row++)
                    {
                        for (uint8 col = 0; col < 8; col++)
                        {
                            BoardCell* cell = board[row][col];

                            if (!cell->pieceGUID || !IsMedivhPiece(cell->pieceEntry))
                                continue;

                            if (Creature* piece = ObjectAccessor::GetCreature(*me, cell->pieceGUID))
                                targetList.push_back(piece);
                        }
                    }

                    acore::Containers::RandomResizeList(targetList, urand(1, 4));

                    for (std::list<Creature*>::iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
                        DoCast(*itr, SPELL_HAND_OF_MEDIVH, true);

                    break;
                }
            }

            MonsterWhisperToPlayers("%s cheats!");
        }

        void MonsterWhisperToPlayers(char const* text)
        {
            Map::PlayerList const &players = me->GetMap()->GetPlayers();

            if (!players.isEmpty())
                for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
                    if (Player* player = i->GetSource())
                        me->MonsterWhisper(text, player, true);
        }

        std::string HandleShowDebug(Creature* piece)
        {
            for (uint8 row = 0; row < 8; row++)
            {
                for (uint8 col = 0; col < 8; col++)
                {
                    if (board[row][col]->pieceGUID == piece->GetGUID())
                    {
                        std::stringstream ss;
                        ss << "\nRow: '" << uint32(row) << "'.\nColumn: '" << uint32(col) << "'.\nTriggerGUID: '" << board[row][col]->triggerGUID << "'.\nPieceGUID (mine): '" << board[row][col]->pieceGUID;
                        ss << "'.\nPieceEntry (mine): '" << board[row][col]->pieceEntry << "'";
                        return ss.str();
                    }
                }
            }

            return "";
        }

        Creature* GetClosestEnemyPiece(Creature* sourcePiece, float maxDistance, bool inFront = false)
        {
            if (!sourcePiece)
                return NULL;

            float distToClosest = std::numeric_limits<float>::max();
            Creature* closestPiece = NULL;

            for (uint8 row = 0; row < 8; row++)
            {
                for (uint8 col = 0; col < 8; col++)
                {
                    if (Creature* piece = ObjectAccessor::GetCreature(*me, board[row][col]->pieceGUID))
                    {
                        if (piece->IsFriendlyTo(sourcePiece))
                            continue;

                        if (inFront && !piece->HasInArc(float(M_PI) / 3.0f, sourcePiece))
                            continue;

                        float dist = sourcePiece->GetExactDist2d(piece);

                        if (dist < distToClosest && dist < maxDistance)
                        {
                            distToClosest = dist;
                            closestPiece = piece;
                        }
                    }
                }
            }

            return closestPiece;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!instance)
                return;

            uint32 chessPhase = instance->GetData(DATA_CHESS_GAME_PHASE);

            if (chessPhase != CHESS_PHASE_INPROGRESS_PVE && chessPhase != CHESS_PHASE_INPROGRESS_PVP)
                return;

            if (chessPhase == CHESS_PHASE_INPROGRESS_PVE)
            {
                if (cheatTimer <= diff)
                {
                    HandleCheat();
                    cheatTimer = urand(45000, 100000);
                }
                else
                    cheatTimer -= diff;
            }
        }

      };

      bool OnGossipHello(Player* player, Creature* me) override
      {
          InstanceScript* instance = me->GetInstanceScript();

          if (!instance)
              return true;

          KarazhanChessGamePhase chessPhase = (KarazhanChessGamePhase)instance->GetData(DATA_CHESS_GAME_PHASE);

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
          return true;
      }

      bool OnGossipSelect(Player* player, Creature* me, uint32 /*sender*/, uint32 action) override
      {
          InstanceScript* instance = me->GetInstanceScript();

          if (!instance)
              return true;

          uint32 chessPhase = instance->GetData(DATA_CHESS_GAME_PHASE);
          instance->SetData(CHESS_EVENT_TEAM, chessPhase < CHESS_PHASE_PVE_FINISHED ? player->GetTeamId() : TEAM_NEUTRAL);

          CloseGossipMenuFor(player);
          switch (action)
          {
          case MEDIVH_GOSSIP_START_PVE:
              instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVE_WARMUP);
              ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, me->AI())->SetupBoard();
              //SetupBoard();
              instance->SetData(DATA_CHESS_EVENT, IN_PROGRESS);
              instance->DoCastSpellOnPlayers(SPELL_GAME_IN_SESSION);
              break;

          case MEDIVH_GOSSIP_RESTART:
              instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_FAILED);
              instance->SetData(DATA_CHESS_REINIT_PIECES, 0);
              ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, me->AI())->deadCount[DEAD_ALLIANCE] = 0;
              ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, me->AI())->deadCount[DEAD_HORDE] = 0;
              //deadCount[DEAD_ALLIANCE] = 0;
              //deadCount[DEAD_HORDE] = 0;
              //ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, me->AI())->RemoveCheats();

              if (instance->GetData(DATA_CHESS_EVENT) == IN_PROGRESS)
                  instance->SetData(DATA_CHESS_EVENT, NOT_STARTED);
              else if (instance->GetData(DATA_CHESS_EVENT) == SPECIAL)
                  instance->SetData(DATA_CHESS_EVENT, DONE);

              instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAME_IN_SESSION);
              instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_NOT_STARTED);
              break;

          case MEDIVH_GOSSIP_START_PVP:
              instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_PVP_WARMUP);
              ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, me->AI())->SetupBoard();
              //SetupBoard();
              instance->SetData(DATA_CHESS_EVENT, SPECIAL);
              instance->DoCastSpellOnPlayers(SPELL_GAME_IN_SESSION);
              break;

          default:
              //sLog.outError("Chess event: unknown action %u", action);
              break;
          }

          return true;
      }

};

class npc_chesspiece : public CreatureScript
{
public:
    npc_chesspiece() : CreatureScript("npc_chesspiece") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_chesspieceAI(creature);
    }

    struct npc_chesspieceAI : public ScriptedAI
    {
        npc_chesspieceAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();

            switch (me->getFaction())
            {
                case A_FACTION:
                    currentOrientation = ORI_NW;
                    break;
                case H_FACTION:
                    currentOrientation = ORI_SE;
                    break;
            }

            NextMoveTimer = urand(3000, 19000);
            teleportToDestDelay = 0;
            destX = 0.0f;
            destY = 0.0f;
            InitializeCombatSpellsByEntry();

            switch (instance->GetData(CHESS_EVENT_TEAM))
            {
                case ALLIANCE:
                    teamControlledByRaid = me->getFaction() == A_FACTION;
                    break;
                case HORDE:
                    teamControlledByRaid = me->getFaction() == H_FACTION;
                    break;
                case BOTH:
                    teamControlledByRaid = true;
                    break;
            }
        }

        InstanceScript* instance;

        uint32 NextMoveTimer;
        uint32 AttackTimer;
        uint32 teleportToDestDelay;
        uint32 combatSpellTimer, combatSpellTimerBase;
        uint32 combatSpellTimer2, combatSpellTimerBase2;

        float destX, destY;

        KarazhanChessOrientationType currentOrientation;

        bool teamControlledByRaid;

        void Reset()
        {
            //NextMoveTimer = urand(3000, 25000);

            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_GAME_IN_SESSION, true);
            AttackTimer = me->GetAttackTime(BASE_ATTACK);
            me->SetSheath(SHEATH_STATE_MELEE);
            me->SetReactState(REACT_PASSIVE);
        }

        void EnterEvadeMode()
        {
            // Just stay in place
            //me->RemoveAllAuras();
            Reset();
        }

        void MovementInform(uint32 MovementType, uint32 Data)
        {
            if (MovementType != POINT_MOTION_TYPE && destX != 0.0f && destY != 0.0f)
                return;

            //me->NearTeleportTo(destX, destY, me->GetPositionZ(), 0.0f);
            currentOrientation = GetDefaultOrientationForTeam();
            me->SetFacingTo(orientations[currentOrientation]);
            teleportToDestDelay = 250;

            if (!me->IsCharmed())
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            AttackTimer = 1;

            if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                if (Creature* piece = ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->GetTargetFor(me, currentOrientation))
                    if (!me->IsFriendlyTo(piece))
                        if (Creature* nearestTrigger = piece->FindNearestCreature(NPC_CHESS_MOVE_TRIGGER, 2.0f))
                            CastChangeFacing(me, nearestTrigger);
        }

        KarazhanChessOrientationType GetDefaultOrientationForTeam()
        {
            switch (me->getFaction())
            {
                case A_FACTION:
                    return ORI_NW;
                case H_FACTION:
                    return  ORI_SE;
            }

            return ORI_SE;
        }

        void CastChangeFacing(Creature* piece, Creature* trigger)
        {
            piece->CastSpell(trigger, SPELL_CHANGE_FACING, false);
            piece->AttackStop();
        }

        void OnCharmed(bool apply)
        {
            if (!instance)
                return;

            Unit* charmer = me->GetCharmer();

            if (!charmer)
                return;

            if (apply)
            {
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                charmer->RemoveAurasDueToSpell(SPELL_GAME_IN_SESSION);
            }
            else
            {
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                charmer->CastSpell(charmer, SPELL_GAME_IN_SESSION, false);
            }

            if (apply)
            {
                if (instance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
                    me->setFaction(A_FACTION);
                else if (instance->GetData(CHESS_EVENT_TEAM) == HORDE)
                    me->setFaction(H_FACTION);
                else if (uint32 oldFaction = me->GetOldFactionId())
                    me->setFaction(oldFaction);
                else if (FactionTemplateEntry const* factionTemplateEntry = me->GetFactionTemplateEntry())
                    me->setFaction(factionTemplateEntry->faction);
                else
                    me->setFaction(BOTH);
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
                        me->setFaction(A_FACTION);
                        break;

                    case NPC_KING_H:
                    case NPC_ROOK_H:
                    case NPC_BISHOP_H:
                    case NPC_QUEEN_H:
                    case NPC_KNIGHT_H:
                    case NPC_PAWN_H:
                        me->setFaction(H_FACTION);
                        break;

                    default:
                        break;
                }
            }

            if (charmer->GetTypeId() == TYPEID_PLAYER)
            {
                if (!apply)
                {
                    //me->RemoveCharmedBy(charmer);
                    charmer->AddAura(SPELL_RECENTLY_INGAME, charmer);

                    if (WorldObject* viewpoint = charmer->ToPlayer()->GetViewpoint())
                        charmer->ToPlayer()->SetViewpoint(viewpoint, false);
                }
                else
                    charmer->ToPlayer()->SetViewpoint(me, true);
            }
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case ACTION_PIECE_RESET:
                    float x, y, z, o;
                    me->GetHomePosition(x, y, z, o);
                    destX = x;
                    destY = y;
                    break;

                case ACTION_PIECE_RESET_ORIENTATION:
                    currentOrientation = GetDefaultOrientationForTeam();
                    break;
            }
        }

        void JustDied(Unit* pKiller)
        {
            if (!instance)
                return;

            if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->HandlePieceJustDied(me);

            me->RemoveCharmedBy(me->GetCharmer());
        }

        void UpdateAI(uint32 diff) override
        {
            if (!instance || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE) || me->IsNonMeleeSpellCast(false))
                return;

            uint32 chessPhase = instance->GetData(DATA_CHESS_GAME_PHASE);

            if (chessPhase != CHESS_PHASE_INPROGRESS_PVE && chessPhase != CHESS_PHASE_INPROGRESS_PVP)
                return;

            if (teleportToDestDelay)
            {
                if (teleportToDestDelay <= diff)
                {
                    teleportToDestDelay = 0;

                    me->NearTeleportTo(destX, destY, me->GetPositionZ(), 0.0f);
                    me->SetFacingTo(orientations[currentOrientation]);

                    destX = 0.0f;
                    destY = 0.0f;
                }
                else
                    teleportToDestDelay -= diff;
            }

            if (AttackTimer <= diff)
            {
                if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                {
                    if (Creature* piece = ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->GetTargetFor(me, currentOrientation))
                    {
                        if (!me->IsFriendlyTo(piece))
                        {
                            //! Required to make them attack
                            me->AttackStop();
                            piece->AttackStop();
                            me->Attack(piece, false); //! False to not continue our attacks
                        }
                    }
                }

                AttackTimer = me->GetAttackTime(BASE_ATTACK);
            }
            else
                AttackTimer -= diff;

            if (!me->IsCharmed())
            {
                switch (instance->GetData(CHESS_EVENT_TEAM))
                {
                    case ALLIANCE:
                        teamControlledByRaid = me->getFaction() == A_FACTION;
                        break;

                    case HORDE:
                        teamControlledByRaid = me->getFaction() == H_FACTION;
                        break;

                    case BOTH:
                        teamControlledByRaid = false;
                        break;
                }

                if (!teamControlledByRaid)
                {
                    if (NextMoveTimer <= diff)
                    {
                        if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                        {
                            if (ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->HandlePieceMoveByAI(me, currentOrientation))
                                NextMoveTimer = urand(4000, 12000);
                            else
                                NextMoveTimer = 1000; //! Re-check after a second
                        }
                    }
                    else
                        NextMoveTimer -= diff;
                }

                //! Special handling - could move to own classes
                if (combatSpellTimer)
                {
                    if (combatSpellTimer <= diff)
                    {
                        combatSpellTimer = combatSpellTimerBase + urand(3000, 9000);

                        switch (me->GetEntry())
                        {
                            case NPC_PAWN_A:
                                DoCast(37414); //! Shield Block
                                break;

                            case NPC_KING_A:
                                DoCast(37471); //! Heroism
                                break;

                            case NPC_KNIGHT_A:
                                if (Unit* victim = me->GetVictim())
                                    DoCast(victim, 37453); //! Smash
                                break;

                            case NPC_QUEEN_A:
                                if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                                    if (Creature* closePiece = ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->GetClosestEnemyPiece(me, 20.0f, true))
                                        DoCast(closePiece, 37462); //! Elemental Blast
                                break;

                            case NPC_BISHOP_A:
                                if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                                    if (Creature* closePiece = ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->GetClosestEnemyPiece(me, 20.0f, true))
                                        DoCast(closePiece, 37459); //! Holy Lance
                                break;

                            case NPC_ROOK_A:
                                DoCast(37427); //! Geyser
                                break;

                            case NPC_KING_H:
                                DoCast(37472); //! Bloodlust
                                break;

                            case NPC_ROOK_H:
                                DoCast(37428); //! Hellfire
                                break;

                            case NPC_BISHOP_H:
                                if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                                    if (Creature* closePiece = ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->GetClosestEnemyPiece(me, 20.0f, true))
                                        DoCast(closePiece, 37461); //! Shadow Spear
                                break;

                            case NPC_QUEEN_H:
                                if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                                    if (Creature* closePiece = ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->GetClosestEnemyPiece(me, 20.0f, true))
                                        DoCast(closePiece, 37463); //! Fireball
                                break;

                            case NPC_KNIGHT_H:
                                if (Unit* victim = me->GetVictim())
                                    DoCast(victim, 37502); //! Howl
                                break;

                            case NPC_PAWN_H:
                                DoCast(37416); //! Weapon Deflection
                                break;

                            default:
                                break;
                        }
                    }
                    else
                        combatSpellTimer -= diff;
                }

                if (combatSpellTimer2)
                {
                    if (combatSpellTimer2 <= diff)
                    {
                        combatSpellTimer2 = combatSpellTimerBase2 + urand(3000, 9000);

                        switch (me->GetEntry())
                        {
                            case NPC_PAWN_A:
                                if (Unit* victim = me->GetVictim())
                                    DoCast(victim, 37406); //! Heroic Blow
                                break;

                            case NPC_KING_A:
                                if (Unit* victim = me->GetVictim())
                                    DoCast(victim, 37474); //! Sweep
                                break;

                            case NPC_KNIGHT_A:
                                DoCast(37498); //! Stomp
                                break;

                            case NPC_QUEEN_A:
                                if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                                    if (Creature* closePiece = ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->GetClosestEnemyPiece(me, 25.0f, true))
                                        DoCast(closePiece, 37465); //! Rain of Fire
                                break;

                            case NPC_BISHOP_A:
                                if (Unit* target = DoSelectLowestHpFriendly(25.0f, 5000))
                                    DoCast(target, SPELL_BISHOP_HEAL_A);
                                break;

                            case NPC_BISHOP_H:
                                if (Unit* target = DoSelectLowestHpFriendly(25.0f, 5000))
                                    DoCast(target, SPELL_BISHOP_HEAL_H);
                                break;

                            case NPC_ROOK_A:
                                DoCast(37432); //! Water Shield
                                break;

                            case NPC_KING_H:
                                if (Unit* victim = me->GetVictim())
                                    DoCast(victim, 37476); //! Cleave
                                break;

                            case NPC_ROOK_H:
                                DoCast(37434); //! Fire Shield
                                break;

                            case NPC_QUEEN_H:
                                if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                                    if (Creature* closePiece = ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->GetClosestEnemyPiece(me, 25.0f, true))
                                        DoCast(closePiece, 37469); //! Poison Cloud
                                break;

                            case NPC_KNIGHT_H:
                                DoCast(37502); //! Howl
                                break;

                            case NPC_PAWN_H:
                                if (Unit* victim = me->GetVictim())
                                    DoCast(victim, 37413); //! Vicious Strike
                                break;

                            default:
                                break;
                        }
                    }
                    else
                        combatSpellTimer2 -= diff;
                }
            }

            if (Unit* victim = me->GetVictim())
            {
                if (victim->GetExactDist2d(me) > 8.0f)
                {
                    victim->AttackStop();
                    me->AttackStop();
                }
            }

            if (UpdateVictim())
            {
                DoMeleeAttackIfReady();

                //if (Unit* victim = me->GetVictim())
                //    me->SetFacingTo(me->GetAngle(victim));
            }
        }

        void InitializeCombatSpellsByEntry()
        {
            switch (me->GetEntry())
            {
                case NPC_PAWN_A:
                case NPC_PAWN_H:
                    combatSpellTimer = urand(7000, 27000);
                    combatSpellTimer2 = urand(3000, 5000);
                    break;

                case NPC_KING_A:
                case NPC_KING_H:
                    combatSpellTimer = urand(13000, 15000);
                    combatSpellTimer2 = urand(3000, 5000);
                    break;

                case NPC_BISHOP_A:
                case NPC_BISHOP_H:
                    combatSpellTimer = urand(7000, 15000);
                    combatSpellTimer2 = urand(15000, 90000);
                    break;

                case NPC_ROOK_A:
                case NPC_ROOK_H:
                case NPC_KNIGHT_A:
                case NPC_KNIGHT_H:
                case NPC_QUEEN_A:
                case NPC_QUEEN_H:
                    combatSpellTimer = urand(7000, 15000);
                    combatSpellTimer2 = urand(7000, 27000);
                    break;

                default:
                    return;
            }

            combatSpellTimerBase = combatSpellTimer;
            combatSpellTimerBase2 = combatSpellTimer2;
        }

        void SpellHitTarget(Unit *target, const SpellInfo* spell)
        {
            if (target->GetEntry() != NPC_CHESS_MOVE_TRIGGER || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;

            if ((spell->Id == SPELL_MOVE_1
                || spell->Id == SPELL_MOVE_2 || spell->Id == SPELL_MOVE_3 || spell->Id == SPELL_MOVE_4
                || spell->Id == SPELL_MOVE_5 || spell->Id == SPELL_MOVE_6 || spell->Id == SPELL_MOVE_7))
            {
                if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                {
                    if (ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->HandlePieceMove(me, target->GetGUID()))
                    {
                        DoCast(SPELL_MOVE_COOLDOWN);
                        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        destX = target->GetPositionX();
                        destY = target->GetPositionY();
                        me->GetMotionMaster()->MovePoint(0, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ());
                        target->CastSpell(target, SPELL_MOVE_MARKER, false);
                    }
                }
            }
            else if (spell->Id == SPELL_CHANGE_FACING)
            {
                if (Creature* medivh = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_IMAGE_OF_MEDIVH)))
                {
                    int result = ENSURE_AI(npc_echo_of_medivh::npc_echo_of_medivhAI, medivh->AI())->HandlePieceRotate(me, target->GetGUID());

                    if (result != -1)
                    {
                        DoCast(SPELL_MOVE_COOLDOWN);
                        me->SetFacingTo(orientations[result]);
                        currentOrientation = KarazhanChessOrientationType(result);
                    }
                }
            }
        }

      };

      bool OnGossipHello(Player* player, Creature* me) override
      {
          InstanceScript* instance = me->GetInstanceScript();
          sLog->outString("1");
          if (!instance)
              return true;
          sLog->outString("2");
          uint32 chessPhase = instance->GetData(DATA_CHESS_GAME_PHASE);
          sLog->outString("3");
          if (player->GetTeamId() == TEAM_ALLIANCE && me->getFaction() != A_FACTION && chessPhase < CHESS_PHASE_PVE_FINISHED)
              return true;
          sLog->outString("4");
          if (player->GetTeamId() == TEAM_HORDE && me->getFaction() != H_FACTION && chessPhase < CHESS_PHASE_PVE_FINISHED)
              return true;
          sLog->outString("5");
          bool ok = true;
          uint32 textID = 0;
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
                  ok = false;
              break;

          case NPC_KING_H:
          case NPC_KING_A:
              if (chessPhase != CHESS_PHASE_INPROGRESS_PVE && chessPhase != CHESS_PHASE_INPROGRESS_PVP && chessPhase != CHESS_PHASE_PVE_WARMUP && chessPhase != CHESS_PHASE_PVP_WARMUP)
                  ok = false;
              break;

          default:
              ok = false;
              break;
          }
          sLog->outString("switch (me->GetEntry())");

          switch (me->GetEntry())
          {
          case NPC_PAWN_H:   textID = 20021; break;
          case NPC_PAWN_A:   textID = 20027; break;
          case NPC_KNIGHT_H: textID = 20019; break;
          case NPC_KNIGHT_A: textID = 20025; break;
          case NPC_QUEEN_H:  textID = 20017; break;
          case NPC_QUEEN_A:  textID = 20023; break;
          case NPC_BISHOP_H: textID = 20018; break;
          case NPC_BISHOP_A: textID = 20023; break;
          case NPC_ROOK_H:   textID = 20020; break;
          case NPC_ROOK_A:   textID = 20026; break;
          case NPC_KING_H:   textID = 20016; break;
          case NPC_KING_A:   textID = 20028; break;
          default:           textID = 8990;  break;
          }
          sLog->outString("me->GetEntry(%u)", me->GetEntry());
          if (ok && !player->HasAura(SPELL_RECENTLY_INGAME))
              AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Control " + me->GetName(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
          sLog->outString("AddGossipItemFor");
          SendGossipMenuFor(player, textID, me->GetGUID());
          sLog->outString("return true");
          return true;
      }

      bool OnGossipSelect(Player* player, Creature* me, uint32 /*sender*/, uint32 action) override
      {
          if (me->IsCharmed() && me->GetCharmerGUID() == player->GetGUID()) {
              me->RemoveCharmedBy(me->GetCharmer());
              player->StopCastingCharm();
              sLog->outString("1");
          }

          if (action == GOSSIP_ACTION_INFO_DEF + 1)
          {
              sLog->outString("2");
              player->NearTeleportTo(-11106.92f, -1843.32f, 229.626f, 4.2331f);
              player->CastSpell(me, SPELL_CONTROL_PIECE, false);
              //me->AddAura(SPELL_CONTROL_PIECE, player);
              //player->AddAura(SPELL_CONTROL_PIECE, me);
              me->SetCharmedBy(player, CHARM_TYPE_CHARM, NULL, false);
              //me->InitCharmInfo();
              //me->GetCharmInfo()->InitCharmCreateSpells(false);

              switch (me->GetEntry())
              {
              case NPC_KING_H:
              case NPC_KING_A:
                  if (InstanceScript* instance = me->GetInstanceScript())
                  {
                      uint32 chessPhase = instance->GetData(DATA_CHESS_GAME_PHASE);

                      if (chessPhase == CHESS_PHASE_PVE_WARMUP)
                          instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_INPROGRESS_PVE);
                      else if (chessPhase == CHESS_PHASE_PVP_WARMUP)
                          instance->SetData(DATA_CHESS_GAME_PHASE, CHESS_PHASE_INPROGRESS_PVP);
                  }
                  break;

              default:
                  sLog->outString("Karazhan Chess, Default hit at %u", me->GetEntry());
                  break;
              }
          }
          sLog->outString("3");
          CloseGossipMenuFor(player);
          sLog->outString("4");
          return true;
      }

};
 
class npc_chess_move_trigger : public CreatureScript
{
public:
    npc_chess_move_trigger() : CreatureScript("npc_chess_move_trigger") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_chess_move_triggerAI(creature);
    }

    struct npc_chess_move_triggerAI : public ScriptedAI
    {
        npc_chess_move_triggerAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            damage = 0;
        }
    };
};

void AddSC_karazhan_chess_event()
{
    new npc_echo_of_medivh();
    new npc_chesspiece();
    new npc_chess_move_trigger();
}
