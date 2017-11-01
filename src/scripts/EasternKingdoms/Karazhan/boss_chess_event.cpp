/* Copyright (C) 2006 - 2013 ScriptDev2 <http://www.scriptdev2.com/>
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/* ScriptData
SDName: chess_event
SD%Complete: 75
SDComment: Friendly game NYI; Chess AI could use some improvements.
SDCategory: Karazhan
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "DBCStores.h"
#include "karazhan.h"
#include "instance_karazhan.cpp"

/// TODO: indentation
enum
{
    // texts
    EMOTE_LIFT_CURSE = -1532131,
    EMOTE_CHEAT = -1532132,

    SOUND_ID_GAME_BEGIN = 10338,
    SOUND_ID_LOSE_PAWN_PLAYER_1 = 10339,
    SOUND_ID_LOSE_PAWN_PLAYER_2 = 10340,
    SOUND_ID_LOSE_PAWN_PLAYER_3 = 10341,
    SOUND_ID_LOSE_PAWN_MEDIVH_1 = 10342,
    SOUND_ID_LOSE_PAWN_MEDIVH_2 = 10343,
    SOUND_ID_LOSE_PAWN_MEDIVH_3 = 10344,
    SOUND_ID_LOSE_ROOK_PLAYER = 10345,
    SOUND_ID_LOSE_ROOK_MEDIVH = 10346,
    SOUND_ID_LOSE_BISHOP_PLAYER = 10347,
    SOUND_ID_LOSE_BISHOP_MEDIVH = 10348,
    SOUND_ID_LOSE_KNIGHT_PLAYER = 10349,
    SOUND_ID_LOSE_KNIGHT_MEDIVH = 10350,
    SOUND_ID_LOSE_QUEEN_PLAYER = 10351,
    SOUND_ID_LOSE_QUEEN_MEDIVH = 10352,
    SOUND_ID_CHECK_PLAYER = 10353,
    SOUND_ID_CHECK_MEDIVH = 10354,
    SOUND_ID_WIN_PLAYER = 10355,
    SOUND_ID_WIN_MEDIVH = 10356,
    SOUND_ID_CHEAT_1 = 10357,
    SOUND_ID_CHEAT_2 = 10358,
    SOUND_ID_CHEAT_3 = 10359,

    // movement spells
    SPELL_MOVE_GENERIC = 30012,                    // spell which sends the signal to move - handled in core
    SPELL_MOVE_1 = 32312,                    // spell which selects AI move square (for short range pieces)
    SPELL_MOVE_2 = 37388,                    // spell which selects AI move square (for long range pieces)
    // SPELL_MOVE_PAWN              = 37146,                    // individual move spells (used only by controlled npcs)
    // SPELL_MOVE_KNIGHT            = 37144,
    // SPELL_MOVE_QUEEN             = 37148,
    // SPELL_MOVE_ROCK              = 37151,
    // SPELL_MOVE_BISHOP            = 37152,
    // SPELL_MOVE_KING              = 37153,

    // additional movement spells
    SPELL_CHANGE_FACING = 30284,                    // spell which sends the initial facing request - handled in core
    SPELL_FACE_SQUARE = 30270,                    // change facing - finalize facing update

    SPELL_MOVE_TO_SQUARE = 30253,                    // spell which sends the move response from the square to the piece
    SPELL_MOVE_COOLDOWN = 30543,                    // add some cooldown to movement
    SPELL_MOVE_MARKER = 32261,                    // white beam visual - used to mark the movement as complete
    SPELL_DISABLE_SQUARE = 32745,                    // used by the White / Black triggers on the squares when a chess piece moves into place
    SPELL_IS_SQUARE_USED = 39400,                    // cast when a chess piece moves to another square
    // SPELL_SQUARED_OCCUPIED       = 39399,                    // triggered by 39400; used to check if the square is occupied (if hits a target); Missing in 2.4.3

    // generic spells
    SPELL_IN_GAME = 30532,                    // teleport player near the entrance
    SPELL_CONTROL_PIECE = 30019,                    // control a chess piece
    SPELL_RECENTLY_IN_GAME = 30529,                    // debuff on player after chess piece uncharm

    SPELL_CHESS_AI_ATTACK_TIMER = 32226,                    // melee action timer - triggers 32225
    SPELL_ACTION_MELEE = 32225,                    // handle melee attacks
    SPELL_MELEE_DAMAGE = 32247,                    // melee damage spell - used by all chess pieces
    // SPELL_AI_SNAPSHOT_TIMER      = 37440,                    // used to trigger spell 32260; purpose and usage unk
    // SPELL_DISABLE_SQUARE_SELF    = 32260,                    // used when a piece moves to another square
    // SPELL_AI_ACTION_TIMER        = 37504,                    // handle some kind of event check. Cast by npc 17459. Currently the way it works is unk
    // SPELL_DISABLE_SQUARE         = 30271,                    // not used
    // SPELL_FIND_ENEMY             = 32303,                    // not used
    // SPELL_MOVE_NEAR_UNIT         = 30417,                    // not used
    // SPELL_GET_EMPTY_SQUARE       = 30418,                    // not used
    // SPELL_FACE_NEARBY_ENEMY      = 37787,                    // not used
    // SPELL_POST_MOVE_FACING       = 38011,                    // not used

    // melee action spells
    SPELL_MELEE_FOOTMAN = 32227,
    SPELL_MELEE_WATER_ELEM = 37142,
    SPELL_MELEE_CHARGER = 37143,
    SPELL_MELEE_CLERIC = 37147,
    SPELL_MELEE_CONJURER = 37149,
    SPELL_MELEE_KING_LLANE = 37150,
    SPELL_MELEE_GRUNT = 32228,
    SPELL_MELEE_DAEMON = 37220,
    SPELL_MELEE_NECROLYTE = 37337,
    SPELL_MELEE_WOLF = 37339,
    SPELL_MELEE_WARLOCK = 37345,
    SPELL_MELEE_WARCHIEF_BLACKHAND = 37348,

    // cheat spells
    SPELL_HAND_OF_MEDIVH_HORDE = 39338,                    // triggers 39339
    SPELL_HAND_OF_MEDIVH_ALLIANCE = 39342,                    // triggers 39339
    SPELL_FURY_OF_MEDIVH_HORDE = 39341,                    // triggers 39343
    SPELL_FURY_OF_MEDIVH_ALLIANCE = 39344,                    // triggers 39345
    SPELL_FURY_OF_MEDIVH_AURA = 39383,
    // SPELL_FULL_HEAL_HORDE        = 39334,                    // spells are not confirmed (probably removed after 2.4.3)
    // SPELL_FULL_HEAL_ALLIANCE     = 39335,

    // spells used by the chess npcs
    SPELL_HEROISM = 37471,                    // human king
    SPELL_SWEEP = 37474,
    SPELL_BLOODLUST = 37472,                    // orc king
    SPELL_CLEAVE = 37476,
    SPELL_HEROIC_BLOW = 37406,                    // human pawn
    SPELL_SHIELD_BLOCK = 37414,
    SPELL_VICIOUS_STRIKE = 37413,                    // orc pawn
    SPELL_WEAPON_DEFLECTION = 37416,
    SPELL_SMASH = 37453,                    // human knight
    SPELL_STOMP = 37498,
    SPELL_BITE = 37454,                    // orc knight
    SPELL_HOWL = 37502,
    SPELL_ELEMENTAL_BLAST = 37462,                    // human queen
    SPELL_RAIN_OF_FIRE = 37465,
    SPELL_FIREBALL = 37463,                    // orc queen
    // SPELL_POISON_CLOUD           = 37469,
    SPELL_POISON_CLOUD_ACTION = 37775,                    // triggers 37469 - acts as a target selector spell for orc queen
    SPELL_HEALING = 37455,                    // human bishop
    SPELL_HOLY_LANCE = 37459,
    // SPELL_SHADOW_MEND            = 37456,                    // orc bishop
    SPELL_SHADOW_MEND_ACTION = 37824,                    // triggers 37456 - acts as a target selector spell for orc bishop
    SPELL_SHADOW_SPEAR = 37461,
    SPELL_GEYSER = 37427,                    // human rook
    SPELL_WATER_SHIELD = 37432,
    SPELL_HELLFIRE = 37428,                    // orc rook
    SPELL_FIRE_SHIELD = 37434,

    // spells used to transform side trigger when npc dies
    SPELL_TRANSFORM_FOOTMAN = 39350,
    SPELL_TRANSFORM_CHARGER = 39352,
    SPELL_TRANSFORM_CLERIC = 39353,
    SPELL_TRANSFORM_WATER_ELEM = 39354,
    SPELL_TRANSFORM_CONJURER = 39355,
    SPELL_TRANSFORM_KING_LLANE = 39356,
    SPELL_TRANSFORM_GRUNT = 39357,
    SPELL_TRANSFORM_WOLF = 39358,
    SPELL_TRANSFORM_NECROLYTE = 39359,
    SPELL_TRANSFORM_DAEMON = 39360,
    SPELL_TRANSFORM_WARLOCK = 39361,
    SPELL_TRANSFORM_BLACKHAND = 39362,

    // generic npcs
    // NPC_SQUARE_OUTSIDE_B         = 17316,                    // used to check the interior of the board
    // NPC_SQUARE_OUTSIDE_W         = 17317,                    // not used in our script; keep for reference only
    NPC_FURY_MEDIVH_VISUAL = 22521,                    // has aura 39383

                                                           // gossip texts
    /// TODO: correct values after query db
    GOSSIP_ITEM_ORC_GRUNT = -3532006,
    GOSSIP_ITEM_ORC_WOLF = -3532007,
    GOSSIP_ITEM_SUMMONED_DEAMON = -3532008,
    GOSSIP_ITEM_ORC_WARLOCK = -3532009,
    GOSSIP_ITEM_ORC_NECROLYTE = -3532010,
    GOSSIP_ITEM_WARCHIEF_BLACKHAND = -3532011,
    GOSSIP_ITEM_HUMAN_FOOTMAN = -3532012,
    GOSSIP_ITEM_HUMAN_CHARGER = -3532013,
    GOSSIP_ITEM_WATER_ELEMENTAL = -3532014,
    GOSSIP_ITEM_HUMAN_CONJURER = -3532015,
    GOSSIP_ITEM_HUMAN_CLERIC = -3532016,
    GOSSIP_ITEM_KING_LLANE = -3532017,

    // gossip menu
    GOSSIP_MENU_ID_GRUNT = 10425,
    GOSSIP_MENU_ID_WOLF = 10439,
    GOSSIP_MENU_ID_WARLOCK = 10440,
    GOSSIP_MENU_ID_NECROLYTE = 10434,
    GOSSIP_MENU_ID_DEAMON = 10426,
    GOSSIP_MENU_ID_BLACKHAND = 10442,
    GOSSIP_MENU_ID_FOOTMAN = 8952,
    GOSSIP_MENU_ID_CHARGER = 10414,
    GOSSIP_MENU_ID_CONJURER = 10417,
    GOSSIP_MENU_ID_CLERIC = 10416,
    GOSSIP_MENU_ID_ELEMENTAL = 10413,
    GOSSIP_MENU_ID_LLANE = 10418,

    // misc       
    TARGET_TYPE_RANDOM = 1,
    TARGET_TYPE_FRIENDLY = 2,
};

/*######
## npc_echo_of_medivh
######*/

class npc_echo_of_medivh : public CreatureScript
{
public:
    npc_echo_of_medivh() : CreatureScript("npc_echo_of_medivh") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_echo_of_medivhAI>(creature);
    }

    struct npc_echo_of_medivhAI : public ScriptedAI
    {
        npc_echo_of_medivhAI(Creature* creature) : ScriptedAI(creature)
        {
            m_instance = (instance_karazhan::instance_karazhan_InstanceMapScript*)creature->GetInstanceScript();// GetInstanceScript(); NOT SURE!
            Reset();
        }

        instance_karazhan::instance_karazhan_InstanceMapScript* m_instance;

        uint32 m_uiCheatTimer;

        void Reset() override
        {
            m_uiCheatTimer = 90000;
        }

        void MoveInLineOfSight(Unit* /*who*/) override { }
        void AttackStart(Unit* /*who*/) override { }

        void JustSummoned(Creature* pSummoned) override
        {
            if (pSummoned->GetEntry() == NPC_FURY_MEDIVH_VISUAL)
                pSummoned->CastSpell(pSummoned, SPELL_FURY_OF_MEDIVH_AURA, true);
        }

        void UpdateAI(uint32 uiDiff) override
        {
            if (!m_instance || me->GetInstanceScript()->GetData(DATA_CHESS) != IN_PROGRESS)
                return;

            if (m_uiCheatTimer < uiDiff)
            {
                DoCast(me, urand(0, 1) ? (m_instance->GetPlayerTeam() == ALLIANCE ? SPELL_HAND_OF_MEDIVH_HORDE : SPELL_HAND_OF_MEDIVH_ALLIANCE) :
                    (m_instance->GetPlayerTeam() == ALLIANCE ? SPELL_FURY_OF_MEDIVH_ALLIANCE : SPELL_FURY_OF_MEDIVH_HORDE));
                /*DoCast(me, urand(0, 1) ? (m_instance->GetPlayerTeam() == ALLIANCE ? SPELL_HAND_OF_MEDIVH_HORDE : SPELL_HAND_OF_MEDIVH_ALLIANCE) :
                    (m_instance->GetPlayerTeam() == ALLIANCE ? SPELL_FURY_OF_MEDIVH_ALLIANCE : SPELL_FURY_OF_MEDIVH_HORDE));*/

                switch (urand(0, 2))
                {
                case 0: DoPlaySoundToSet(me, SOUND_ID_CHEAT_1); break;
                case 1: DoPlaySoundToSet(me, SOUND_ID_CHEAT_2); break;
                case 2: DoPlaySoundToSet(me, SOUND_ID_CHEAT_3); break;
                }

                me->MonsterTextEmote(EMOTE_CHEAT, me);
                //me->MonsterTextEmote(EMOTE_CHEAT, me);

                m_uiCheatTimer = 90000;
            }
            else
                m_uiCheatTimer -= uiDiff;
        }
    };
};

/*######
## npc_chess_piece_generic
######*/

struct npc_chess_piece_genericAI : public ScriptedAI
{
    npc_chess_piece_genericAI(Creature* creature) : ScriptedAI(creature)
    {
        m_instance = (instance_karazhan::instance_karazhan_InstanceMapScript*)creature->GetInstanceScript();
        Reset();
    }

    instance_karazhan::instance_karazhan_InstanceMapScript* m_instance;

    uint64 m_currentSquareGuid;

    uint32 m_uiMoveTimer;
    uint32 m_uiMoveCommandTimer;
    uint32 m_uiSpellCommandTimer;

    bool m_bIsPrimarySpell;
    float m_fCurrentOrientation;

    void Reset() override
    {
        m_uiMoveTimer = 0;
        m_uiMoveCommandTimer = 1000;
        m_uiSpellCommandTimer = me->HasAura(SPELL_CONTROL_PIECE) ? 0 : 1000;
        m_bIsPrimarySpell = true;

        // cancel move timer for player faction npcs
        if (m_instance)
        {
            if ((m_instance->GetPlayerTeam() == ALLIANCE && me->getFaction() == FACTION_ID_CHESS_ALLIANCE) ||
                (m_instance->GetPlayerTeam() == HORDE && me->getFaction() == FACTION_ID_CHESS_HORDE))
                m_uiMoveCommandTimer = 0;
        }
    }

    // no default attacking or evading
    void MoveInLineOfSight(Unit* /*who*/) override { }
    void AttackStart(Unit* /*who*/) override { }
    void EnterEvadeMode() override { }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* square = me->GetMap()->GetCreature(m_currentSquareGuid))
            square->RemoveAllAuras();

        /// TODO: remove corpse after 10 sec
    }
    //pChessPiece->AI()->SendAIEvent(AI_EVENT_CUSTOM_B, pSquare, pChessPiece);
    //void ReceiveAIEvent(AIEventType eventType, Creature* /*pSender*/, Unit* pInvoker, uint32 /*uiMiscValue*/) override

    void SetData(uint32 id, uint32 value) override
    {
        Creature* invoker = m_instance->GetCreatureByGUID(value);
        // handle move event
        if (id == AI_EVENT_CUSTOM_A)
        {
            // clear the current square
            if (Creature* square = me->GetMap()->GetCreature(m_currentSquareGuid))
                square->RemoveAllAuras();

            m_currentSquareGuid = value;
            m_uiMoveTimer = 2000;
        }
        // handle encounter start event
        else if (id == AI_EVENT_CUSTOM_B)
        {
            // reset the variables
            Reset();
            m_currentSquareGuid = value;

            /// TODO: enable this when the scope of the spell is clear
            //if (Creature* pStalker = m_instance->GetCreatureByGUID(NPC_WAITING_ROOM_STALKER))
            //    pStalker->CastSpell(pStalker, SPELL_AI_ACTION_TIMER, true);

            //DoCast(me, SPELL_AI_SNAPSHOT_TIMER, CAST_TRIGGERED);
            DoCast(me, SPELL_CHESS_AI_ATTACK_TIMER, true);

            invoker->CastSpell(invoker, SPELL_DISABLE_SQUARE, true);
            invoker->CastSpell(invoker, SPELL_IS_SQUARE_USED, true);
        }
    }

    void MovementInform(uint32 uiMotionType, uint32 uiPointId) override
    {
        if (uiMotionType != POINT_MOTION_TYPE || !uiPointId)
            return;

        // update facing
        if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 5.0f))
            DoCast(target, SPELL_CHANGE_FACING);
        else
            me->SetFacingTo(m_fCurrentOrientation);
    }

    void SpellHit(Unit* caster, const SpellInfo* spell) override
    {
        // do a soft reset when the piece is controlled
        if (caster->GetTypeId() == TYPEID_PLAYER && spell->Id == SPELL_CONTROL_PIECE)
            Reset();
    }

    // Function which returns a random target by type and range
    Unit* GetTargetByType(uint8 uiType, float fRange, float fArc = M_PI)
    {
        if (!m_instance)
            return NULL;

        uint32 uiTeam = me->getFaction() == FACTION_ID_CHESS_ALLIANCE ? FACTION_ID_CHESS_HORDE : FACTION_ID_CHESS_ALLIANCE;

        // get friendly list for this type
        if (uiType == TARGET_TYPE_FRIENDLY)
            uiTeam = me->getFaction();

        // Get the list of enemies
        std::list<uint64> lTempList;
        std::vector<Creature*> vTargets;
        vTargets.reserve(lTempList.size());

        m_instance->GetChessPiecesByFaction(lTempList, uiTeam);
        for (std::list<uint64>::const_iterator itr = lTempList.begin(); itr != lTempList.end(); ++itr)
        {
            Creature* temp = me->GetMap()->GetCreature(*itr);
            if (temp && temp->IsAlive())
            {
                // check for specified range targets and angle; Note: to be checked if the angle is right
                if (fRange && !me->isInFrontInMap(temp, fRange, fArc))
                    continue;

                // skip friendly targets which are at full HP
                if (uiType == TARGET_TYPE_FRIENDLY && temp->GetHealth() == temp->GetMaxHealth())
                    continue;

                vTargets.push_back(temp);
            }
        }

        if (vTargets.empty())
            return NULL;

        return vTargets[urand(0, vTargets.size() - 1)];
    }

    // Function to get a square as close as possible to the enemy
    /// TODO: prioritize better targets and missing sort!
    Unit* GetMovementSquare()
    {
        if (!m_instance)
            return NULL;

        // define distance based on the spell radius
        // this will replace the targeting sysmte of spells SPELL_MOVE_1 and SPELL_MOVE_2
        float fRadius = 10.0f;
        std::list<Creature*> lSquaresList;

        // some pieces have special distance
        switch (me->GetEntry())
        {
        case NPC_HUMAN_CONJURER:
        case NPC_ORC_WARLOCK:
        case NPC_HUMAN_CHARGER:
        case NPC_ORC_WOLF:
            fRadius = 15.0f;
            break;
        }

        // get all available squares for movement
        GetCreatureListWithEntryInGrid(lSquaresList, me, NPC_SQUARE_BLACK, fRadius);
        GetCreatureListWithEntryInGrid(lSquaresList, me, NPC_SQUARE_WHITE, fRadius);

        if (lSquaresList.empty())
            return NULL;

        // Get the list of enemies
        std::list<uint64> lTempList;
        std::list<Creature*> lEnemies;

        m_instance->GetChessPiecesByFaction(lTempList, me->getFaction() == FACTION_ID_CHESS_ALLIANCE ? FACTION_ID_CHESS_HORDE : FACTION_ID_CHESS_ALLIANCE);
        for (std::list<uint64>::const_iterator itr = lTempList.begin(); itr != lTempList.end(); ++itr)
        {
            Creature* temp = me->GetMap()->GetCreature(*itr);
            if (temp && temp->IsAlive())
                lEnemies.push_back(temp);
        }

        if (lEnemies.empty())
            return NULL;

        // Sort the enemies by distance and the squares compared to the distance to the closest enemy
        //lEnemies.sort(ObjectDistanceOrder(me));
        //lSquaresList.sort(ObjectDistanceOrder(lEnemies.front()));

        return lSquaresList.front();
    }

    virtual uint32 DoCastPrimarySpell() { return 5000; }
    virtual uint32 DoCastSecondarySpell() { return 5000; }

    void UpdateAI(uint32 uiDiff) override
    {
        if (!m_instance || m_instance->GetData(DATA_CHESS) != IN_PROGRESS)
            return;

        // issue move command
        if (m_uiMoveCommandTimer)
        {
            if (m_uiMoveCommandTimer <= uiDiff)
            {
                // just update facing if some enemy is near
                if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 5.0f))
                    DoCast(target, SPELL_CHANGE_FACING);
                else
                {
                    /// TODO: GCD CHECK
                    // the npc doesn't have a 100% chance to move; also there should be some GCD check in core for this part
                    if (roll_chance_i(15))
                    {
                        // Note: in a normal case the target would be chosen using the spells above
                        // However, because the core doesn't support special targeting, we'll provide explicit target
                        //uint32 uiMoveSpell = SPELL_MOVE_1;
                        //switch (me->GetEntry())
                        //{
                        //    case NPC_HUMAN_CONJURER:
                        //    case NPC_ORC_WARLOCK:
                        //    case NPC_HUMAN_CHARGER:
                        //    case NPC_ORC_WOLF:
                        //        uiMoveSpell = SPELL_MOVE_2;
                        //        break;
                        //}
                        //DoCast(me, uiMoveSpell, true);

                        // workaround which provides specific move target
                        if (Unit* target = GetMovementSquare())
                            DoCast(target, SPELL_MOVE_GENERIC, true);

                        m_fCurrentOrientation = me->GetOrientation();
                    }
                }

                m_uiMoveCommandTimer = 5000;
            }
            else
                m_uiMoveCommandTimer -= uiDiff;
        }

        // issue spell command
        if (m_uiSpellCommandTimer)
        {
            if (m_uiSpellCommandTimer <= uiDiff)
            {
                // alternate the spells and also reset the timer
                m_uiSpellCommandTimer = m_bIsPrimarySpell ? DoCastPrimarySpell() : DoCastSecondarySpell();
                m_bIsPrimarySpell = !m_bIsPrimarySpell;
            }
            else
                m_uiSpellCommandTimer -= uiDiff;
        }

        // finish move timer
        if (m_uiMoveTimer)
        {
            if (m_uiMoveTimer <= uiDiff)
            {
                if (Creature* square = me->GetMap()->GetCreature(m_currentSquareGuid))
                {
                    DoCast(square, SPELL_MOVE_MARKER, true);
                    me->GetMotionMaster()->MovePoint(1, square->GetPositionX(), square->GetPositionY(), square->GetPositionZ());
                }
                m_uiMoveTimer = 0;
            }
            else
                m_uiMoveTimer -= uiDiff;
        }

        /// TODO: check, unsure, it was SelectHostileTarget() instead of SelectVictim()
        if (!me->SelectVictim() || !me->GetVictim())
            return;
    }
};

bool DummyEffect(Unit* caster, uint32 uiSpellId, SpellEffIndex uiEffIndex, Creature* creatureTarget, uint64 /*originalCasterGuid*/)
{
    // movement perform spell
    if (uiSpellId == SPELL_MOVE_TO_SQUARE && uiEffIndex == EFFECT_0)
    {
        if (caster->GetTypeId() == TYPEID_UNIT)
        {
            caster->CastSpell(caster, SPELL_DISABLE_SQUARE, true);
            caster->CastSpell(caster, SPELL_IS_SQUARE_USED, true);

            creatureTarget->CastSpell(creatureTarget, SPELL_MOVE_COOLDOWN, true);
            /// TODO: check
            //creatureTarget->AI()->SendAIEvent(AI_EVENT_CUSTOM_A, caster, creatureTarget);
            creatureTarget->AI()->SetData(AI_EVENT_CUSTOM_A, creatureTarget->GetGUID());
        }

        return true;
    }
    // generic melee tick
    else if (uiSpellId == SPELL_ACTION_MELEE && uiEffIndex == EFFECT_0)
    {
        uint32 uiMeleeSpell = 0;

        switch (creatureTarget->GetEntry())
        {
        case NPC_KING_LLANE:            uiMeleeSpell = SPELL_MELEE_KING_LLANE;          break;
        case NPC_HUMAN_CHARGER:         uiMeleeSpell = SPELL_MELEE_CHARGER;             break;
        case NPC_HUMAN_CLERIC:          uiMeleeSpell = SPELL_MELEE_CLERIC;              break;
        case NPC_HUMAN_CONJURER:        uiMeleeSpell = SPELL_MELEE_CONJURER;            break;
        case NPC_HUMAN_FOOTMAN:         uiMeleeSpell = SPELL_MELEE_FOOTMAN;             break;
        case NPC_CONJURED_WATER_ELEMENTAL: uiMeleeSpell = SPELL_MELEE_WATER_ELEM;       break;
        case NPC_WARCHIEF_BLACKHAND:    uiMeleeSpell = SPELL_MELEE_WARCHIEF_BLACKHAND;  break;
        case NPC_ORC_GRUNT:             uiMeleeSpell = SPELL_MELEE_GRUNT;               break;
        case NPC_ORC_NECROLYTE:         uiMeleeSpell = SPELL_MELEE_NECROLYTE;           break;
        case NPC_ORC_WARLOCK:           uiMeleeSpell = SPELL_MELEE_WARLOCK;             break;
        case NPC_ORC_WOLF:              uiMeleeSpell = SPELL_MELEE_WOLF;                break;
        case NPC_SUMMONED_DAEMON:       uiMeleeSpell = SPELL_MELEE_DAEMON;              break;
        }

        creatureTarget->CastSpell(creatureTarget, uiMeleeSpell, true);
        return true;
    }
    // square facing
    else if (uiSpellId == SPELL_FACE_SQUARE && uiEffIndex == EFFECT_0)
    {
        if (caster->GetTypeId() == TYPEID_UNIT)
            creatureTarget->SetFacingToObject(caster);

        return true;
    }

    return false;
}

//class npc_chess_square : public CreatureScript
//{
//public:
//    npc_chess_square() : CreatureScript("npc_chess_square") { }
//
//    CreatureAI* GetAI(Creature* creature) const override
//    {
//        return GetInstanceAI<npc_chess_squareAI>(creature);
//    }
//
//    struct npc_chess_squareAI : public ScriptedAI
//    {
//        npc_chess_squareAI(Creature* creature) : ScriptedAI(creature) { Reset(); }
//
//        void JustDied(Unit* killer) override
//        {
//        }
//    };
//
//    bool OnGossipHello(Player* player, Creature* creature)
//    {
//        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
//            return true;
//
//        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
//        {
//            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == ALLIANCE)
//                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_HUMAN_CLERIC, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
//        }
//
//        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_CLERIC, creature->GetGUID());
//        return true;
//    }
//};

class npc_chess_square : public CreatureScript
{
public:
    npc_chess_square() : CreatureScript("npc_chess_square") { }

    ScriptedAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_chess_squareAI>(creature);
    }

    struct npc_chess_squareAI : public ScriptedAI
    {
        npc_chess_squareAI(Creature* creature) : ScriptedAI(creature) {}

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            // wrong, it should be the player GUID, not the creature's. Anyway, we do not use it at the moment.
            if (spell->Effects[EFFECT_0].IsEffect()) {
                DummyEffect(caster, spell->Id, EFFECT_0, me, caster->GetGUID());
            }
        }
    };
};


bool OnGossipSelectGeneric(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
{
    if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
    {
        /// TODO: check, it was InstanceScript instead of scirpt and GetInstanceScript instead of script
        // start event when used on the king
        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            // teleport at the entrance and control the chess piece
            player->CastSpell(player, SPELL_IN_GAME, true);
            player->CastSpell(creature, SPELL_CONTROL_PIECE, true);

            if (instance->GetData(DATA_CHESS) == NOT_STARTED)
                instance->SetData(DATA_CHESS, IN_PROGRESS);
        }

        player->CLOSE_GOSSIP_MENU();
    }

    return true;
}


/*######
## npc_king_llane
######*/
class npc_king_llane : public CreatureScript
{
public:
    npc_king_llane() : CreatureScript("npc_king_llane") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_king_llaneAI>(creature);
    }

    struct npc_king_llaneAI : public npc_chess_piece_genericAI
    {
        npc_king_llaneAI(Creature* creature) : npc_chess_piece_genericAI(creature)
        {
            m_bIsAttacked = false;
            Reset();
        }

        bool m_bIsAttacked;

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            if (!damage || !m_bIsAttacked || !m_instance || attacker->GetTypeId() != TYPEID_UNIT)
                return;

            if (Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH))
            {
                if (m_instance->GetPlayerTeam() == ALLIANCE)
                    DoPlaySoundToSet(medivh, SOUND_ID_CHECK_PLAYER);
                else
                    DoPlaySoundToSet(medivh, SOUND_ID_CHECK_MEDIVH);
            }

            m_bIsAttacked = true;
        }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == HORDE)
            {
                DoPlaySoundToSet(medivh, SOUND_ID_WIN_PLAYER);
                /// TODO: check
                //me->MonsterTextEmote(EMOTE_LIFT_CURSE, medivh);
                me->MonsterTextEmote(EMOTE_LIFT_CURSE, medivh);

                m_instance->SetData(DATA_CHESS, DONE);
            }
            else
            {
                DoPlaySoundToSet(medivh, SOUND_ID_WIN_MEDIVH);
                m_instance->SetData(DATA_CHESS, NOT_STARTED);
            }

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_KING_LLANE, FACTION_ID_CHESS_ALLIANCE, true);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 20.0f))
            {
                DoCast(me, SPELL_HEROISM);

                // reset timer based on spell values
                me->GetSpellCooldown(SPELL_HEROISM);
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_HEROISM);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 10.0f))
            {
                DoCast(me, SPELL_SWEEP);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_SWEEP);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) != DONE && player->GetTeamId() == ALLIANCE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_KING_LLANE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_LLANE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override 
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};

/*######
## npc_warchief_blackhand
######*/

class npc_warchief_blackhand : public CreatureScript
{
public:
    npc_warchief_blackhand() : CreatureScript("npc_warchief_blackhand") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_warchief_blackhandAI>(creature);
    }

    struct npc_warchief_blackhandAI : public npc_chess_piece_genericAI
    {
        npc_warchief_blackhandAI(Creature* creature) : npc_chess_piece_genericAI(creature)
        {
            m_bIsAttacked = false;
            Reset();
        }

        bool m_bIsAttacked;

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            if (!damage || !m_bIsAttacked || !m_instance || attacker->GetTypeId() != TYPEID_UNIT)
                return;

            if (Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH))
            {
                if (m_instance->GetPlayerTeam() == HORDE)
                    DoPlaySoundToSet(medivh, SOUND_ID_CHECK_PLAYER);
                else
                    DoPlaySoundToSet(medivh, SOUND_ID_CHECK_MEDIVH);
            }

            m_bIsAttacked = true;
        }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == ALLIANCE)
            {
                DoPlaySoundToSet(medivh, SOUND_ID_WIN_PLAYER);
                me->MonsterTextEmote(EMOTE_LIFT_CURSE, medivh);

                m_instance->SetData(DATA_CHESS, DONE);
            }
            else
            {
                DoPlaySoundToSet(medivh, SOUND_ID_WIN_MEDIVH);
                m_instance->SetData(DATA_CHESS, NOT_STARTED);
            }

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_BLACKHAND, FACTION_ID_CHESS_HORDE, true);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 20.0f))
            {
                DoCast(me, SPELL_BLOODLUST);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_BLOODLUST);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 10.0f))
            {
                DoCast(me, SPELL_CLEAVE);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_CLEAVE);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) != DONE && player->GetTeamId() == HORDE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_WARCHIEF_BLACKHAND, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_BLACKHAND, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override 
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};


/*######
## npc_human_conjurer
######*/


class npc_human_conjurer : public CreatureScript
{
public:
    npc_human_conjurer() : CreatureScript("npc_human_conjurer") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_human_conjurerAI>(creature);
    }

    struct npc_human_conjurerAI : public npc_chess_piece_genericAI
    {
        npc_human_conjurerAI(Creature* creature) : npc_chess_piece_genericAI(creature) { Reset(); }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == ALLIANCE)
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_QUEEN_PLAYER);
            else
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_QUEEN_MEDIVH);

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_CONJURER, FACTION_ID_CHESS_ALLIANCE);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 20.0f))
            {
                DoCast(target, SPELL_ELEMENTAL_BLAST);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_ELEMENTAL_BLAST);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 25.0f))
            {
                DoCast(target, SPELL_RAIN_OF_FIRE);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_RAIN_OF_FIRE);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == ALLIANCE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_HUMAN_CONJURER, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_CONJURER, creature->GetGUID());
        return true;
    }
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};

/*######
## npc_orc_warlock
######*/

class npc_orc_warlock : public CreatureScript
{
public:
    npc_orc_warlock() : CreatureScript("npc_orc_warlock") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_orc_warlockAI>(creature);
    }

    struct npc_orc_warlockAI : public npc_chess_piece_genericAI
    {
        npc_orc_warlockAI(Creature* creature) : npc_chess_piece_genericAI(creature) { Reset(); }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == HORDE)
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_QUEEN_PLAYER);
            else
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_QUEEN_MEDIVH);

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_WARLOCK, FACTION_ID_CHESS_HORDE);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 20.0f))
            {
                DoCast(target, SPELL_FIREBALL);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_FIREBALL);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 25.0f))
            {
                DoCast(target, SPELL_POISON_CLOUD_ACTION);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_POISON_CLOUD_ACTION);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };


    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == HORDE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ORC_WARLOCK, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_WARLOCK, creature->GetGUID());
        return true;
    }
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};

/*######
## npc_human_footman
######*/

class npc_human_footman : public CreatureScript
{
public:
    npc_human_footman() : CreatureScript("npc_human_footman") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_human_footmanAI>(creature);
    }

    struct npc_human_footmanAI : public npc_chess_piece_genericAI
    {
        npc_human_footmanAI(Creature* creature) : npc_chess_piece_genericAI(creature) { Reset(); }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == ALLIANCE)
            {
                switch (urand(0, 2))
                {
                case 0: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_PLAYER_1); break;
                case 1: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_PLAYER_2); break;
                case 2: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_PLAYER_3); break;
                }
            }
            else
            {
                switch (urand(0, 2))
                {
                case 0: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_MEDIVH_1); break;
                case 1: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_MEDIVH_2); break;
                case 2: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_MEDIVH_3); break;
                }
            }

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_FOOTMAN, FACTION_ID_CHESS_ALLIANCE);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f, M_PI / 12))
            {
                DoCast(me, SPELL_HEROIC_BLOW);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_HEROIC_BLOW);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f))
            {
                DoCast(me, SPELL_SHIELD_BLOCK);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_SHIELD_BLOCK);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == ALLIANCE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_HUMAN_FOOTMAN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_FOOTMAN, creature->GetGUID());
        return true;
    }
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};

/*######
## npc_orc_grunt
######*/

class npc_orc_grunt : public CreatureScript
{
public:
    npc_orc_grunt() : CreatureScript("npc_orc_grunt") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_orc_gruntAI>(creature);
    }

    struct npc_orc_gruntAI : public npc_chess_piece_genericAI
    {
        npc_orc_gruntAI(Creature* creature) : npc_chess_piece_genericAI(creature) { Reset(); }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == HORDE)
            {
                switch (urand(0, 2))
                {
                case 0: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_PLAYER_1); break;
                case 1: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_PLAYER_2); break;
                case 2: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_PLAYER_3); break;
                }
            }
            else
            {
                switch (urand(0, 2))
                {
                case 0: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_MEDIVH_1); break;
                case 1: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_MEDIVH_2); break;
                case 2: DoPlaySoundToSet(medivh, SOUND_ID_LOSE_PAWN_MEDIVH_3); break;
                }
            }

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_GRUNT, FACTION_ID_CHESS_HORDE);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f, M_PI / 12))
            {
                DoCast(me, SPELL_VICIOUS_STRIKE);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_VICIOUS_STRIKE);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f))
            {
                DoCast(me, SPELL_WEAPON_DEFLECTION);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_WEAPON_DEFLECTION);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == HORDE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ORC_GRUNT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_GRUNT, creature->GetGUID());
        return true;
    }
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};

/*######
## npc_water_elemental
######*/

class npc_water_elemental : public CreatureScript
{
public:
    npc_water_elemental() : CreatureScript("npc_water_elemental") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_water_elementalAI>(creature);
    }

    struct npc_water_elementalAI : public npc_chess_piece_genericAI
    {
        npc_water_elementalAI(Creature* creature) : npc_chess_piece_genericAI(creature) { Reset(); }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == ALLIANCE)
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_ROOK_PLAYER);
            else
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_ROOK_MEDIVH);

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_WATER_ELEM, FACTION_ID_CHESS_ALLIANCE);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 9.0f))
            {
                DoCast(me, SPELL_GEYSER);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_GEYSER);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 9.0f))
            {
                DoCast(me, SPELL_WATER_SHIELD);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_WATER_SHIELD);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == ALLIANCE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_WATER_ELEMENTAL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_ELEMENTAL, creature->GetGUID());
        return true;
    }
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};

/*######
## npc_summoned_daemon
######*/

class npc_summoned_daemon : public CreatureScript
{
public:
    npc_summoned_daemon() : CreatureScript("npc_summoned_daemon") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_summoned_daemonAI>(creature);
    }

    struct npc_summoned_daemonAI : public npc_chess_piece_genericAI
    {
        npc_summoned_daemonAI(Creature* creature) : npc_chess_piece_genericAI(creature) { Reset(); }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == HORDE)
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_ROOK_PLAYER);
            else
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_ROOK_MEDIVH);

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_DAEMON, FACTION_ID_CHESS_HORDE);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 9.0f))
            {
                DoCast(me, SPELL_HELLFIRE);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_HELLFIRE);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 9.0f))
            {
                DoCast(me, SPELL_FIRE_SHIELD);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_FIRE_SHIELD);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == HORDE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_SUMMONED_DEAMON, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_DEAMON, creature->GetGUID());
        return true;
    }
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};

/*######
## npc_human_charger
######*/

class npc_human_charger : public CreatureScript
{
public:
    npc_human_charger() : CreatureScript("npc_human_charger") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_human_chargerAI>(creature);
    }

    struct npc_human_chargerAI : public npc_chess_piece_genericAI
    {
        npc_human_chargerAI(Creature* creature) : npc_chess_piece_genericAI(creature) { Reset(); }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == ALLIANCE)
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_KNIGHT_PLAYER);
            else
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_KNIGHT_MEDIVH);

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_CHARGER, FACTION_ID_CHESS_ALLIANCE);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f, M_PI / 12))
            {
                DoCast(me, SPELL_SMASH);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_SMASH);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 10.0f, M_PI / 12))
            {
                DoCast(me, SPELL_STOMP);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_STOMP);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == ALLIANCE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_HUMAN_CHARGER, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_CHARGER, creature->GetGUID());
        return true;
    }
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};

/*######
## npc_orc_wolf
######*/

class npc_orc_wolf : public CreatureScript
{
public:
    npc_orc_wolf() : CreatureScript("npc_orc_wolf") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_orc_wolfAI>(creature);
    }

    struct npc_orc_wolfAI : public npc_chess_piece_genericAI
    {
        npc_orc_wolfAI(Creature* creature) : npc_chess_piece_genericAI(creature) { Reset(); }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == HORDE)
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_KNIGHT_PLAYER);
            else
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_KNIGHT_MEDIVH);

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_WOLF, FACTION_ID_CHESS_HORDE);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 8.0f, M_PI / 12))
            {
                DoCast(me, SPELL_BITE);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_BITE);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 10.0f, M_PI / 12))
            {
                DoCast(me, SPELL_HOWL);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_HOWL);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == HORDE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ORC_WOLF, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_WOLF, creature->GetGUID());
        return true;
    }
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};

/*######
## npc_human_cleric
######*/

class npc_human_cleric : public CreatureScript
{
public:
    npc_human_cleric() : CreatureScript("npc_human_cleric") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_human_clericAI>(creature);
    }

    struct npc_human_clericAI : public npc_chess_piece_genericAI
    {
        npc_human_clericAI(Creature* creature) : npc_chess_piece_genericAI(creature) { Reset(); }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == ALLIANCE)
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_BISHOP_PLAYER);
            else
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_BISHOP_MEDIVH);

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_CLERIC, FACTION_ID_CHESS_ALLIANCE);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_FRIENDLY, 25.0f))
            {
                DoCast(target, SPELL_HEALING);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_HEALING);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 18.0f, M_PI / 12))
            {
                DoCast(me, SPELL_HOLY_LANCE);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_HOLY_LANCE);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == ALLIANCE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_HUMAN_CLERIC, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_CLERIC, creature->GetGUID());
        return true;
    }
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};


/*######
## npc_orc_necrolyte
######*/

class npc_orc_necrolyte : public CreatureScript
{
public:
    npc_orc_necrolyte() : CreatureScript("npc_orc_necrolyte") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_orc_necrolyteAI>(creature);
    }

    struct npc_orc_necrolyteAI : public npc_chess_piece_genericAI
    {
        npc_orc_necrolyteAI(Creature* creature) : npc_chess_piece_genericAI(creature) { Reset(); }

        void JustDied(Unit* killer) override
        {
            npc_chess_piece_genericAI::JustDied(killer);

            if (!m_instance)
                return;

            Creature* medivh = m_instance->GetCreatureByGUID(NPC_ECHO_MEDIVH);
            if (!medivh)
                return;

            if (m_instance->GetPlayerTeam() == HORDE)
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_BISHOP_PLAYER);
            else
                DoPlaySoundToSet(medivh, SOUND_ID_LOSE_BISHOP_MEDIVH);

            m_instance->DoMoveChessPieceToSides(SPELL_TRANSFORM_NECROLYTE, FACTION_ID_CHESS_HORDE);
        }

        uint32 DoCastPrimarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_FRIENDLY, 25.0f))
            {
                DoCast(target, SPELL_SHADOW_MEND_ACTION);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_SHADOW_MEND_ACTION);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }

        uint32 DoCastSecondarySpell() override
        {
            if (Unit* target = GetTargetByType(TARGET_TYPE_RANDOM, 18.0f, M_PI / 12))
            {
                DoCast(me, SPELL_SHADOW_SPEAR);

                // reset timer based on spell values
                const SpellEntry* spell = sSpellStore.LookupEntry(SPELL_SHADOW_SPEAR);
                return spell->RecoveryTime ? spell->RecoveryTime : spell->CategoryRecoveryTime;
            }

            return 5000;
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->HasAura(SPELL_RECENTLY_IN_GAME) || creature->HasAura(SPELL_CONTROL_PIECE))
            return true;

        if (InstanceScript* instance = (InstanceScript*)creature->GetInstanceScript())
        {
            if (instance->GetData(DATA_CHESS) == IN_PROGRESS && player->GetTeamId() == HORDE)
                player->PlayerTalkClass->GetGossipMenu().AddMenuItem(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ORC_NECROLYTE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        player->SEND_GOSSIP_MENU(GOSSIP_MENU_ID_NECROLYTE, creature->GetGUID());
        return true;
    }
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        return OnGossipSelectGeneric(player, creature, sender, action);
    }
};

void AddSC_chess_event()
{
    new npc_echo_of_medivh();
    new npc_chess_square();
    new npc_king_llane();
    new npc_warchief_blackhand();
    new npc_human_conjurer();
    new npc_orc_warlock();
    new npc_human_footman();
    new npc_orc_grunt();
    new npc_water_elemental();
    new npc_summoned_daemon();
    new npc_human_charger();
    new npc_orc_wolf();
    new npc_human_cleric();
    new npc_orc_necrolyte();
}
