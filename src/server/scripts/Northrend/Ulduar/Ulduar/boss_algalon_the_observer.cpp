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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "MapMgr.h"
#include "MoveSplineInit.h"
#include "ObjectMgr.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

enum Spells
{
    // Algalon the Observer
    SPELL_ARRIVAL                       = 64997,
    SPELL_RIDE_THE_LIGHTNING            = 64986,
    SPELL_SUMMON_AZEROTH                = 64994,
    SPELL_REORIGINATION                 = 64996,
    SPELL_SUPERMASSIVE_FAIL             = 65311,
    SPELL_QUANTUM_STRIKE                = 64395,
    SPELL_PHASE_PUNCH                   = 64412,
    SPELL_BIG_BANG                      = 64443,
    SPELL_ASCEND_TO_THE_HEAVENS         = 64487,
    SPELL_COSMIC_SMASH                  = 62301,
    SPELL_COSMIC_SMASH_TRIGGERED        = 62304,
    SPELL_COSMIC_SMASH_VISUAL_STATE     = 62300,
    SPELL_SELF_STUN                     = 65256,
    SPELL_KILL_CREDIT                   = 65184,
    SPELL_DUAL_WIELD                    = 42459,

    // Algalon Stalker
    SPELL_TRIGGER_3_ADDS                = 62266,    // Triggers Living Constellation

    // Living Constellation
    SPELL_ARCANE_BARRAGE                = 64599,

    // Collapsing Star
    SPELL_COLLAPSE                      = 62018,
    SPELL_BLACK_HOLE_SPAWN_VISUAL       = 62003,
    SPELL_SUMMON_BLACK_HOLE             = 62189,

    // Black Hole
    SPELL_BLACK_HOLE_TRIGGER            = 62185,
    SPELL_CONSTELLATION_PHASE_TRIGGER   = 65508,
    SPELL_CONSTELLATION_PHASE_EFFECT    = 65509,
    SPELL_BLACK_HOLE_EXPLOSION          = 64122,
    SPELL_SUMMON_VOID_ZONE_VISUAL       = 64470,
    SPELL_VOID_ZONE_VISUAL              = 64469,
    SPELL_BLACK_HOLE_CREDIT             = 65312,
    SPELL_BLACK_HOLE_DAMAGE             = 62169,

    // Worm Hole
    SPELL_WORM_HOLE_TRIGGER             = 65251,
    SPELL_SUMMON_UNLEASHED_DARK_MATTER  = 64450,
};

enum Actions
{
    //ACTION_INIT_ALGALON       = 1, defined in ulduar.h
    //ACTION_DESPAWN_ALGALON    = 2, defined in ulduar.h
    ACTION_START_INTRO      = 3,
    ACTION_FINISH_INTRO     = 4,
    ACTION_ACTIVATE_STAR    = 5,
    ACTION_BIG_BANG         = 6,
    ACTION_ASCEND           = 7,
    ACTION_OUTRO            = 8,
};

enum Misc
{
    POINT_BRANN_INTRO           = 0,
    MAX_BRANN_WAYPOINTS_INTRO   = 11,
    POINT_BRANN_OUTRO           = 11,
    POINT_BRANN_OUTRO_END       = 12,

    POINT_ALGALON_LAND          = 1,
    POINT_ALGALON_OUTRO         = 2,

    EVENT_ID_SUPERMASSIVE_START = 21697,

    DATA_HAS_FED_ON_TEARS       = 1,
    DATA_HERALD_OF_THE_TITANS   = 2,
};

enum Events
{
    // Celestial Planetarium Access
    EVENT_DESPAWN_CONSOLE           = 1,

    // Brann Bronzebeard
    EVENT_BRANN_MOVE_INTRO          = 2,
    EVENT_SUMMON_ALGALON            = 3,
    EVENT_BRANN_OUTRO_1             = 4,
    EVENT_BRANN_OUTRO_2             = 5,

    // Algalon the Observer
    EVENT_INTRO_1                   = 6,
    EVENT_INTRO_2                   = 7,
    EVENT_INTRO_3                   = 8,
    EVENT_INTRO_FINISH              = 9,
    EVENT_START_COMBAT              = 10,
    EVENT_INTRO_TIMER_DONE          = 11,
    EVENT_QUANTUM_STRIKE            = 12,
    EVENT_PHASE_PUNCH               = 13,
    EVENT_SUMMON_COLLAPSING_STAR    = 14,
    EVENT_BIG_BANG                  = 15,
    EVENT_RESUME_UPDATING           = 16,
    EVENT_ASCEND_TO_THE_HEAVENS     = 17,
    EVENT_EVADE                     = 18,
    EVENT_COSMIC_SMASH              = 19,
    EVENT_UNLOCK_YELL               = 20,
    EVENT_OUTRO_START               = 21,
    EVENT_OUTRO_1                   = 22,
    EVENT_OUTRO_2                   = 23,
    EVENT_OUTRO_3                   = 24,
    EVENT_OUTRO_4                   = 25,
    EVENT_OUTRO_5                   = 26,
    EVENT_OUTRO_6                   = 27,
    EVENT_OUTRO_7                   = 28,
    EVENT_OUTRO_8                   = 29,
    EVENT_OUTRO_9                   = 30,
    EVENT_OUTRO_10                  = 31,
    EVENT_OUTRO_11                  = 32,
    EVENT_ACTIVATE_LIVING_CONSTELLATION = 33,
    EVENT_CHECK_HERALD_ITEMS        = 34,
    EVENT_REMOVE_UNNATTACKABLE      = 35,
    EVENT_DESPAWN_ALGALON_1         = 36,
    EVENT_DESPAWN_ALGALON_2         = 37,
    EVENT_DESPAWN_ALGALON_3         = 38,
    EVENT_DESPAWN_ALGALON_4         = 39,
    EVENT_DESPAWN_ALGALON_5         = 40,

    // Living Constellation
    EVENT_ARCANE_BARRAGE            = 41,
};

enum EncounterPhases
{
    PHASE_NORMAL             = 0,
    PHASE_ROLE_PLAY          = 1,
    PHASE_BIG_BANG           = 2,

    PHASE_MASK_NO_UPDATE     = (1 << (PHASE_ROLE_PLAY - 1)) | (1 << (PHASE_BIG_BANG - 1)),
    PHASE_MASK_NO_CAST_CHECK = 1 << (PHASE_ROLE_PLAY - 1),
};

enum Texts
{
    SAY_BRANN_ALGALON_INTRO_1       = 0,
    SAY_BRANN_ALGALON_INTRO_2       = 1,
    SAY_BRANN_ALGALON_OUTRO         = 2,

    SAY_ALGALON_INTRO_1             = 0,
    SAY_ALGALON_INTRO_2             = 1,
    SAY_ALGALON_INTRO_3             = 2,
    SAY_ALGALON_START_TIMER         = 3,
    SAY_ALGALON_AGGRO               = 4,
    SAY_ALGALON_COLLAPSING_STAR     = 5,
    EMOTE_ALGALON_COLLAPSING_STAR   = 6,
    SAY_ALGALON_BIG_BANG            = 7,
    EMOTE_ALGALON_BIG_BANG          = 8,
    SAY_ALGALON_ASCEND              = 9,
    EMOTE_ALGALON_COSMIC_SMASH      = 10,
    SAY_ALGALON_PHASE_TWO           = 11,
    SAY_ALGALON_OUTRO_1             = 12,
    SAY_ALGALON_OUTRO_2             = 13,
    SAY_ALGALON_OUTRO_3             = 14,
    SAY_ALGALON_OUTRO_4             = 15,
    SAY_ALGALON_OUTRO_5             = 16,
    SAY_ALGALON_DESPAWN_1           = 17,
    SAY_ALGALON_DESPAWN_2           = 18,
    SAY_ALGALON_DESPAWN_3           = 19,
    SAY_ALGALON_KILL                = 20,
};

uint32 const PhasePunchAlphaId[5] = {64435, 64434, 64428, 64421, 64417};

Position const BrannIntroSpawnPos = {1676.277f, -162.5308f, 427.3326f, 3.235537f};
Position const BrannIntroWaypoint[MAX_BRANN_WAYPOINTS_INTRO] =
{
    {1642.482f, -164.0812f, 427.2602f, 0.0f},
    {1635.000f, -169.5145f, 427.2523f, 0.0f},
    {1632.814f, -173.9334f, 427.2621f, 0.0f},
    {1632.676f, -190.5927f, 427.2631f, 0.0f},
    {1631.497f, -214.2221f, 418.1152f, 0.0f},
    {1636.455f, -263.6647f, 417.3213f, 0.0f},
    {1629.586f, -267.9792f, 417.3219f, 0.0f},
    {1631.497f, -214.2221f, 418.1152f, 0.0f},
    {1632.676f, -190.5927f, 425.8831f, 0.0f},
    {1632.814f, -173.9334f, 427.2621f, 0.0f},
    {1635.000f, -169.5145f, 427.2523f, 0.0f},
};

#define LIVING_CONSTELLATION_COUNT 11
Position const ConstellationPos[LIVING_CONSTELLATION_COUNT] =
{
    {1625.208f, -267.2771f, 446.4296f, 5.044002f},
    {1593.389f, -299.4325f, 432.4636f, 6.073746f},
    {1668.317f, -324.7676f, 457.9394f, 3.211406f},
    {1685.613f, -300.1219f, 443.2366f, 3.385939f},
    {1592.242f, -325.5323f, 446.9508f, 0.226893f},
    {1658.279f, -262.5490f, 441.9073f, 4.188790f},
    {1635.821f, -363.3442f, 424.3459f, 1.466077f},
    {1591.706f, -263.8201f, 441.4153f, 5.253441f},
    {1672.188f, -357.2484f, 436.7337f, 2.338741f},
    {1678.677f, -276.3280f, 427.7531f, 3.979351f},
    {1615.800f, -348.0065f, 442.9586f, 1.134464f},
};

#define COLLAPSING_STAR_COUNT 4
Position const CollapsingStarPos[COLLAPSING_STAR_COUNT] =
{
    {1649.438f, -319.8127f, 418.3941f, 1.082104f},
    {1647.005f, -288.6790f, 417.3955f, 3.490659f},
    {1622.451f, -321.1563f, 417.6188f, 4.677482f},
    {1615.060f, -291.6816f, 417.7796f, 3.490659f},
};
Position const AlgalonOutroPos = {1633.64f, -317.78f, 417.3211f, 0.0f};
Position const BrannOutroPos[3] =
{
    {1632.023f, -243.7434f, 417.9118f, 0.0f},
    {1631.986f, -297.7831f, 417.3210f, 0.0f},
    {1633.832f, -216.2948f, 417.0463f, 0.0f},
};

class CosmicSmashDamageEvent : public BasicEvent
{
public:
    CosmicSmashDamageEvent(Unit* caster) : _caster(caster)
    {
    }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        _caster->CastSpell(_caster, SPELL_COSMIC_SMASH_TRIGGERED, true);
        return true;
    }

private:
    Unit* _caster;
};

class boss_algalon_the_observer : public CreatureScript
{
public:
    boss_algalon_the_observer() : CreatureScript("boss_algalon_the_observer") {}

    struct boss_algalon_the_observerAI : public ScriptedAI
    {
        boss_algalon_the_observerAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            _fedOnTears = true;
            _firstPull = true;
            _fightWon = false;
            m_pInstance = me->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        InstanceScript* m_pInstance;

        bool _firstPull;
        bool _fightWon;
        bool _phaseTwo;
        bool _fedOnTears;
        bool _heraldOfTheTitans;

        bool IsValidHeraldItem(ItemTemplate const* item)
        {
            if (!item) // should not happen, but checked in GetAverageItemLevel()
                return true;
            if (item->ItemLevel <= 226 || (item->ItemLevel <= 232 && (
                                               item->InventoryType == INVTYPE_SHIELD ||
                                               item->Class == ITEM_CLASS_WEAPON ||
                                               (item->Class == ITEM_CLASS_ARMOR && (item->InventoryType == INVTYPE_RELIC || item->InventoryType == INVTYPE_HOLDABLE))
                                           )))
                return true;
            return false;
        }

        bool DoCheckHeraldOfTheTitans()
        {
            if (!_heraldOfTheTitans)
                return true;

            Map::PlayerList const& pl = me->GetMap()->GetPlayers();
            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                if (Player* plr = itr->GetSource())
                    if (!plr->IsGameMaster() && plr->IsInCombat() /*performance*/)
                    {
                        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i) // loop through equipped items
                            if (Item* item = plr->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                                if (!IsValidHeraldItem(item->GetTemplate()))
                                {
                                    _heraldOfTheTitans = false;
                                    return true;
                                }
                    }

            return false;
        }

        void AttackStart(Unit* who) override
        {
            if (_fightWon)
                return;
            ScriptedAI::AttackStart(who);
        }

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_HAS_FED_ON_TEARS)
                return _fedOnTears;
            if (param == DATA_HERALD_OF_THE_TITANS)
                return _heraldOfTheTitans;
            return 0;
        }

        void CallConstellations()
        {
            uint8 _count = 0;
            for (SummonList::const_iterator i = summons.begin(); i != summons.end(); )
            {
                Creature* summon = ObjectAccessor::GetCreature(*me, *i++);
                if (summon && summon->GetEntry() == NPC_LIVING_CONSTELLATION && !summon->AI()->GetData(0))
                {
                    ++_count;
                    summon->AI()->DoAction(ACTION_ACTIVATE_STAR);
                    if (_count >= 3)
                        break;
                }
            }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (_fightWon)
                return;

            if (SelectTargetFromPlayerList(120.0f))
            {
                me->SetInCombatWithZone();
                return;
            }
            else if (events.GetPhaseMask() & PHASE_NORMAL)
            {
                DoAction(ACTION_ASCEND);
                return;
            }

            if (m_pInstance)
                m_pInstance->SetData(TYPE_ALGALON, FAIL);

            ScriptedAI::EnterEvadeMode(why);
        }

        void Reset() override
        {
            if (_fightWon)
                return;

            events.Reset();
            summons.DespawnAll();
            me->SetReactState(REACT_PASSIVE);
            me->SetImmuneToPC(false);
            me->SetSheath(SHEATH_STATE_UNARMED);
            me->SetFaction(190);
            me->CastSpell(me, SPELL_DUAL_WIELD, true);

            _phaseTwo = false;
            _heraldOfTheTitans = true;

            if (m_pInstance->GetData(TYPE_ALGALON) == FAIL)
            {
                _firstPull = false;
            }

            if (m_pInstance)
                m_pInstance->SetData(TYPE_ALGALON, NOT_STARTED);
        }

        void KilledUnit(Unit* victim) override
        {
            if (!victim->IsPlayer() || urand(0, 2))
                return;

            Talk(SAY_ALGALON_KILL);
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_START_INTRO:
                    {
                        me->SetImmuneToPC(true);
                        me->SetUnitFlag2(UNIT_FLAG2_DO_NOT_FADE_IN);
                        me->SetDisableGravity(true);
                        me->CastSpell(me, SPELL_ARRIVAL, true);
                        me->CastSpell(me, SPELL_RIDE_THE_LIGHTNING, true);
                        me->GetMotionMaster()->MovePoint(POINT_ALGALON_LAND, AlgalonLandPos);
                        me->SetHomePosition(AlgalonLandPos);
                        Movement::MoveSplineInit init(me);
                        init.MoveTo(AlgalonLandPos.GetPositionX(), AlgalonLandPos.GetPositionY(), AlgalonLandPos.GetPositionZ());
                        init.SetOrientationFixed(true);
                        init.Launch();
                        events.Reset();
                        events.SetPhase(PHASE_ROLE_PLAY);
                        events.ScheduleEvent(EVENT_INTRO_1, 5s, 0, PHASE_ROLE_PLAY);
                        events.ScheduleEvent(EVENT_INTRO_2, 15s, 0, PHASE_ROLE_PLAY);
                        events.ScheduleEvent(EVENT_INTRO_3, 23s, 0, PHASE_ROLE_PLAY);
                        events.ScheduleEvent(EVENT_INTRO_FINISH, 36s, 0, PHASE_ROLE_PLAY);
                        break;
                    }
                case ACTION_DESPAWN_ALGALON:
                    _fightWon = true;
                    events.Reset();
                    summons.DespawnAll();
                    events.SetPhase(PHASE_ROLE_PLAY);
                    events.ScheduleEvent(EVENT_DESPAWN_ALGALON_1, 5s);
                    events.ScheduleEvent(EVENT_DESPAWN_ALGALON_2, 17s);
                    events.ScheduleEvent(EVENT_DESPAWN_ALGALON_3, 26s);
                    if (me->IsInCombat())
                        events.ScheduleEvent(EVENT_DESPAWN_ALGALON_4, 26s);
                    events.ScheduleEvent(EVENT_DESPAWN_ALGALON_5, 32s);
                    me->DespawnOrUnsummon(39000);

                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    me->SetFaction(FACTION_FRIENDLY);
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->InterruptNonMeleeSpells(false);
                    if (m_pInstance)
                        m_pInstance->SetData(TYPE_ALGALON, NOT_STARTED);
                    break;
                case ACTION_INIT_ALGALON:
                    _firstPull = false;
                    _fedOnTears = false;
                    me->SetImmuneToPC(false);
                    break;
                case ACTION_ASCEND:
                    summons.DespawnAll();
                    events.SetPhase(PHASE_BIG_BANG);
                    events.ScheduleEvent(EVENT_ASCEND_TO_THE_HEAVENS, 1500ms);
                    break;
                case ACTION_FEEDS_ON_TEARS_FAILED:
                    _fedOnTears = false;
            }
        }

        void JustReachedHome() override
        {
            me->setActive(false);
        }

        void JustEngagedWith(Unit*) override
        {
            if (_fightWon)
                return;

            if (!m_pInstance)
            {
                EnterEvadeMode(EVADE_REASON_OTHER);
                return;
            }

            uint32 introDelay = 0;
            me->setActive(true);
            me->SetInCombatWithZone();
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetImmuneToNPC(true);
            events.Reset();
            events.SetPhase(PHASE_ROLE_PLAY);

            if (!_firstPull)
            {
                events.ScheduleEvent(EVENT_START_COMBAT, 0ms);
                introDelay = 8000;
            }
            else
            {
                summons.DespawnEntry(NPC_AZEROTH);
                _firstPull = false;
                Talk(SAY_ALGALON_START_TIMER);
                introDelay = 22000;
                events.ScheduleEvent(EVENT_START_COMBAT, 14s);
                m_pInstance->SetData(DATA_DESPAWN_ALGALON, 0);
            }

            events.ScheduleEvent(EVENT_REMOVE_UNNATTACKABLE, introDelay - 500);
            events.ScheduleEvent(EVENT_INTRO_TIMER_DONE, introDelay);
            events.ScheduleEvent(EVENT_QUANTUM_STRIKE, 3500 + introDelay);
            events.ScheduleEvent(EVENT_PHASE_PUNCH, 15500 + introDelay);
            events.ScheduleEvent(EVENT_SUMMON_COLLAPSING_STAR, 16500 + introDelay);
            events.ScheduleEvent(EVENT_COSMIC_SMASH, 25000 + introDelay);
            events.ScheduleEvent(EVENT_ACTIVATE_LIVING_CONSTELLATION, 50500 + introDelay);
            events.ScheduleEvent(EVENT_BIG_BANG, 90000 + introDelay);
            events.ScheduleEvent(EVENT_ASCEND_TO_THE_HEAVENS, 360000 + introDelay);

            events.ScheduleEvent(EVENT_CHECK_HERALD_ITEMS, 5s);
            DoCheckHeraldOfTheTitans();
        }

        void MovementInform(uint32 movementType, uint32 pointId) override
        {
            if (movementType != POINT_MOTION_TYPE)
                return;

            if (pointId == POINT_ALGALON_LAND)
                me->SetDisableGravity(false);
            else if (pointId == POINT_ALGALON_OUTRO)
            {
                me->SetFacingTo(1.605703f);
                events.ScheduleEvent(EVENT_OUTRO_3, 1200ms);
                events.ScheduleEvent(EVENT_OUTRO_4, 2400ms);
                events.ScheduleEvent(EVENT_OUTRO_5, 8500ms);
                events.ScheduleEvent(EVENT_OUTRO_6, 15s + 500ms);
                events.ScheduleEvent(EVENT_OUTRO_7, 55s + 500ms);
                events.ScheduleEvent(EVENT_OUTRO_8, 73s + 500ms);
                events.ScheduleEvent(EVENT_OUTRO_9, 85s + 500ms);
                events.ScheduleEvent(EVENT_OUTRO_10, 101s + 500ms);
                events.ScheduleEvent(EVENT_OUTRO_11, 117s + 500ms);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            switch (summon->GetEntry())
            {
                case NPC_AZEROTH:
                    me->CastSpell(summon, SPELL_REORIGINATION, true);
                    break;
                case NPC_BLACK_HOLE:
                    summon->CastSpell((Unit*)nullptr, SPELL_BLACK_HOLE_TRIGGER, true);
                    summon->CastSpell(summon, SPELL_CONSTELLATION_PHASE_TRIGGER, true);
                    summon->CastSpell((Unit*)nullptr, SPELL_BLACK_HOLE_EXPLOSION, false);
                    summon->CastSpell(summon, SPELL_SUMMON_VOID_ZONE_VISUAL, true);
                    break;
                case NPC_ALGALON_VOID_ZONE_VISUAL_STALKER:
                    summon->CastSpell(summon, SPELL_VOID_ZONE_VISUAL, true);
                    break;
                case NPC_ALGALON_STALKER_ASTEROID_TARGET_01:
                    summon->CastSpell(summon, SPELL_COSMIC_SMASH_VISUAL_STATE, true);
                    break;
                case NPC_ALGALON_STALKER_ASTEROID_TARGET_02:
                    {
                        float x = summon->GetPositionX();
                        float y = summon->GetPositionY();
                        float z = summon->GetPositionZ() + 35.0f;
                        float o = summon->GetOrientation();

                        summon->GetMotionMaster()->Clear();
                        summon->SetHomePosition(x, y, z, o);
                        summon->UpdatePosition(x, y, z, o, true);
                        summon->StopMovingOnCurrentPos();
                        summon->m_Events.AddEvent(new CosmicSmashDamageEvent(summon), summon->m_Events.CalculateTime(4000));
                        break;
                    }
                case NPC_UNLEASHED_DARK_MATTER:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                        if (summon->Attack(target, true))
                            summon->GetMotionMaster()->MoveChase(target);
                    break;
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (_fightWon)
            {
                damage = 0;
                return;
            }

            if (!_phaseTwo && me->HealthBelowPctDamaged(20, damage))
            {
                _phaseTwo = true;
                Talk(SAY_ALGALON_PHASE_TWO);
                summons.DespawnEntry(NPC_LIVING_CONSTELLATION);
                summons.DespawnEntry(NPC_COLLAPSING_STAR);
                summons.DespawnEntry(NPC_BLACK_HOLE);
                summons.DespawnEntry(NPC_ALGALON_VOID_ZONE_VISUAL_STALKER);
                events.CancelEvent(EVENT_SUMMON_COLLAPSING_STAR);
                events.CancelEvent(EVENT_ACTIVATE_LIVING_CONSTELLATION);

                for (uint32 i = 0; i < COLLAPSING_STAR_COUNT; ++i)
                    me->SummonCreature(NPC_WORM_HOLE, CollapsingStarPos[i], TEMPSUMMON_MANUAL_DESPAWN);
            }
            else if (me->HealthBelowPctDamaged(2, damage) && !_fightWon)
            {
                _fightWon = true;
                damage = 0;
                me->SetReactState(REACT_PASSIVE);
                me->AttackStop();
                me->SetFaction(FACTION_FRIENDLY);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                events.Reset();
                summons.DespawnAll();
                me->InterruptNonMeleeSpells(false);
                events.SetPhase(PHASE_ROLE_PLAY);
                events.ScheduleEvent(EVENT_OUTRO_START, 1500ms);
                events.ScheduleEvent(EVENT_OUTRO_1, 7200ms);
                events.ScheduleEvent(EVENT_OUTRO_2, 8700ms);
            }
        }

        bool IsInRoom()
        {
            if (me->GetExactDist2d(&me->GetHomePosition()) > 45.f || me->GetPositionZ() < 410.f)
            {
                DoAction(ACTION_ASCEND);
                return false;
            }

            return true;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!(events.GetPhaseMask() & PHASE_MASK_NO_UPDATE) && (!UpdateVictim() || !IsInRoom()))
                return;

            events.Update(diff);
            if (!(events.GetPhaseMask() & PHASE_MASK_NO_CAST_CHECK) && me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_INTRO_1:
                    me->RemoveAurasDueToSpell(SPELL_RIDE_THE_LIGHTNING);
                    Talk(SAY_ALGALON_INTRO_1);
                    break;
                case EVENT_INTRO_2:
                    me->CastSpell((Unit*)nullptr, SPELL_SUMMON_AZEROTH, true);
                    Talk(SAY_ALGALON_INTRO_2);
                    break;
                case EVENT_INTRO_3:
                    Talk(SAY_ALGALON_INTRO_3);
                    break;
                case EVENT_INTRO_FINISH:
                    events.Reset();
                    me->SetImmuneToPC(false);
                    if (Creature* brann = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(NPC_BRANN_BRONZBEARD_ALG)))
                        brann->AI()->DoAction(ACTION_FINISH_INTRO);
                    break;
                case EVENT_START_COMBAT:
                    m_pInstance->SetData(TYPE_ALGALON, IN_PROGRESS);
                    Talk(SAY_ALGALON_AGGRO);
                    break;
                case EVENT_REMOVE_UNNATTACKABLE:
                    me->SetSheath(SHEATH_STATE_MELEE);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->SetImmuneToNPC(false);
                    break;
                case EVENT_INTRO_TIMER_DONE:
                    events.SetPhase(PHASE_NORMAL);
                    me->CastSpell((Unit*)nullptr, SPELL_SUPERMASSIVE_FAIL, true);
                    // Hack: _IsValidTarget failed earlier due to flags, call AttackStart again
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetFaction(FACTION_MONSTER);
                    if (Player* target = SelectTargetFromPlayerList(150.0f))
                        AttackStart(target);
                    me->SetInCombatWithZone();

                    for (uint32 i = 0; i < LIVING_CONSTELLATION_COUNT; ++i)
                        me->SummonCreature(NPC_LIVING_CONSTELLATION, ConstellationPos[i], TEMPSUMMON_DEAD_DESPAWN);
                    break;
                case EVENT_QUANTUM_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_QUANTUM_STRIKE, false);
                    events.Repeat(3000ms, 4500ms);
                    break;
                case EVENT_PHASE_PUNCH:
                    me->CastSpell(me->GetVictim(), SPELL_PHASE_PUNCH, false);
                    events.Repeat(15s + 500ms);
                    break;
                case EVENT_SUMMON_COLLAPSING_STAR:
                    Talk(SAY_ALGALON_COLLAPSING_STAR);
                    Talk(EMOTE_ALGALON_COLLAPSING_STAR);
                    for (uint8 i = 0; i < COLLAPSING_STAR_COUNT; ++i)
                        me->SummonCreature(NPC_COLLAPSING_STAR, CollapsingStarPos[i], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000);
                    events.Repeat(1min);
                    break;
                case EVENT_COSMIC_SMASH:
                    Talk(EMOTE_ALGALON_COSMIC_SMASH);
                    me->CastCustomSpell(SPELL_COSMIC_SMASH, SPELLVALUE_MAX_TARGETS, RAID_MODE(1, 3), (Unit*)nullptr);
                    events.Repeat(25s + 500ms);
                    break;
                case EVENT_ACTIVATE_LIVING_CONSTELLATION:
                    {
                        if (events.GetPhaseMask() & PHASE_MASK_NO_UPDATE)
                        {
                            events.Repeat(4s);
                            break;
                        }
                        CallConstellations();
                        //me->CastSpell(me, SPELL_TRIGGER_3_ADDS, true);
                        events.Repeat(50s);
                        break;
                    }
                case EVENT_BIG_BANG:
                    {
                        Talk(SAY_ALGALON_BIG_BANG);
                        Talk(EMOTE_ALGALON_BIG_BANG);

                        EntryCheckPredicate pred(NPC_LIVING_CONSTELLATION);
                        summons.DoAction(ACTION_BIG_BANG, pred);

                        me->CastSpell((Unit*)nullptr, SPELL_BIG_BANG, false);
                        events.Repeat(90s + 500ms);
                        break;
                    }
                case EVENT_ASCEND_TO_THE_HEAVENS:
                    Talk(SAY_ALGALON_ASCEND);
                    me->CastSpell((Unit*)nullptr, SPELL_ASCEND_TO_THE_HEAVENS, false);
                    events.ScheduleEvent(EVENT_EVADE, 2500ms);
                    break;
                case EVENT_EVADE:
                    events.Reset();
                    ScriptedAI::EnterEvadeMode();
                    return;
                case EVENT_OUTRO_START:
                    if (m_pInstance)
                    {
                        m_pInstance->SetData(TYPE_ALGALON, DONE);
                        m_pInstance->SetData(DATA_ALGALON_DEFEATED, 1);
                    }
                    break;
                case EVENT_OUTRO_1:
                    me->RemoveAllAuras();
                    me->SetUnitFlag(UNIT_FLAG_RENAME);
                    break;
                case EVENT_OUTRO_2:
                {
                    Player* lootRecipent = me->GetLootRecipient();
                    _EnterEvadeMode();
                    // LootRecipent is cleared in _EnterEvadeMode, restore it
                    me->SetLootRecipient(lootRecipent);
                    me->GetMotionMaster()->MovePoint(POINT_ALGALON_OUTRO, AlgalonOutroPos);
                    break;
                }
                case EVENT_OUTRO_3:
                    me->CastSpell((Unit*)nullptr, SPELL_KILL_CREDIT);
                    // Summon Chest
                    if (GameObject* go = me->SummonGameObject(RAID_MODE(GO_ALGALON_CHEST, GO_ALGALON_CHEST_HERO), 1632.1f, -306.561f, 417.321f, 4.69494f, 0, 0, 0, 1, 0))
                    {
                        go->ReplaceAllGameObjectFlags((GameObjectFlags)0);
                        go->SetLootRecipient(me);
                    }
                    break;
                case EVENT_OUTRO_4:
                    me->CastSpell((Unit*)nullptr, SPELL_SUPERMASSIVE_FAIL);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    break;
                case EVENT_OUTRO_5:
                    if (Creature* brann = me->SummonCreature(NPC_BRANN_BRONZBEARD_ALG, BrannOutroPos[0], TEMPSUMMON_TIMED_DESPAWN, 131500))
                        brann->AI()->DoAction(ACTION_OUTRO);
                    break;
                case EVENT_OUTRO_6:
                    Talk(SAY_ALGALON_OUTRO_1);
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    break;
                case EVENT_OUTRO_7:
                    Talk(SAY_ALGALON_OUTRO_2);
                    break;
                case EVENT_OUTRO_8:
                    Talk(SAY_ALGALON_OUTRO_3);
                    break;
                case EVENT_OUTRO_9:
                    Talk(SAY_ALGALON_OUTRO_4);
                    break;
                case EVENT_OUTRO_10:
                    Talk(SAY_ALGALON_OUTRO_5);
                    break;
                case EVENT_OUTRO_11:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->CastSpell(me, SPELL_TELEPORT, false);
                    me->DespawnOrUnsummon(3000);
                    break;
                case EVENT_DESPAWN_ALGALON_1:
                    Talk(SAY_ALGALON_DESPAWN_1);
                    break;
                case EVENT_DESPAWN_ALGALON_2:
                    Talk(SAY_ALGALON_DESPAWN_2);
                    break;
                case EVENT_DESPAWN_ALGALON_3:
                    Talk(SAY_ALGALON_DESPAWN_3);
                    break;
                case EVENT_DESPAWN_ALGALON_4:
                    me->CastSpell((Unit*)nullptr, SPELL_ASCEND_TO_THE_HEAVENS, false);
                    break;
                case EVENT_DESPAWN_ALGALON_5:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->CastSpell(me, SPELL_TELEPORT, false);
                    me->DespawnOrUnsummon(3000);
                    break;
                case EVENT_CHECK_HERALD_ITEMS:
                    if (!DoCheckHeraldOfTheTitans())
                        events.Repeat(5s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUlduarAI<boss_algalon_the_observerAI>(creature);
    }
};

class npc_brann_bronzebeard_algalon : public CreatureScript
{
public:
    npc_brann_bronzebeard_algalon() : CreatureScript("npc_brann_bronzebeard_algalon") { }

    struct npc_brann_bronzebeard_algalonAI : public CreatureAI
    {
        npc_brann_bronzebeard_algalonAI(Creature* creature) : CreatureAI(creature)
        {
        }

        EventMap events;
        uint32 _currentPoint;

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_START_INTRO:
                    me->SetWalk(false);
                    _currentPoint = 0;
                    events.Reset();
                    events.ScheduleEvent(EVENT_BRANN_MOVE_INTRO, 1ms);
                    break;
                case ACTION_FINISH_INTRO:
                    Talk(SAY_BRANN_ALGALON_INTRO_2);
                    events.ScheduleEvent(EVENT_BRANN_MOVE_INTRO, 1ms);
                    break;
                case ACTION_OUTRO:
                    me->GetMotionMaster()->MovePoint(POINT_BRANN_OUTRO, BrannOutroPos[1]);
                    events.ScheduleEvent(EVENT_BRANN_OUTRO_1, 87s + 500ms);
                    events.ScheduleEvent(EVENT_BRANN_OUTRO_2, 116s + 500ms);
                    break;
            }
        }

        void MovementInform(uint32 movementType, uint32 pointId) override
        {
            if (movementType != POINT_MOTION_TYPE)
                return;

            uint32 delay = 1;
            _currentPoint = pointId + 1;
            switch (pointId)
            {
                case 2:
                    delay = 8000;
                    me->SetWalk(true);
                    break;
                case 6:
                    me->SetFacingTo(4.6156f);
                    me->SetWalk(false);
                    Talk(SAY_BRANN_ALGALON_INTRO_1);
                    events.ScheduleEvent(EVENT_SUMMON_ALGALON, 7500ms);
                    return;
                case 10:
                    me->DespawnOrUnsummon(1);
                    return;
                case POINT_BRANN_OUTRO:
                case POINT_BRANN_OUTRO_END:
                    return;
            }

            events.ScheduleEvent(EVENT_BRANN_MOVE_INTRO, delay);
        }

        void UpdateAI(uint32 diff) override
        {
            UpdateVictim();
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_BRANN_MOVE_INTRO:
                    if (_currentPoint < MAX_BRANN_WAYPOINTS_INTRO)
                        me->GetMotionMaster()->MovePoint(_currentPoint, BrannIntroWaypoint[_currentPoint]);
                    break;
                case EVENT_SUMMON_ALGALON:
                    if (me->GetInstanceScript() && !me->GetInstanceScript()->GetGuidData(TYPE_ALGALON))
                        if (Creature* algalon = me->GetMap()->SummonCreature(NPC_ALGALON, AlgalonSummonPos))
                            algalon->AI()->DoAction(ACTION_START_INTRO);
                    break;
                case EVENT_BRANN_OUTRO_1:
                    Talk(SAY_BRANN_ALGALON_OUTRO);
                    break;
                case EVENT_BRANN_OUTRO_2:
                    me->GetMotionMaster()->MovePoint(POINT_BRANN_OUTRO_END, BrannOutroPos[2]);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUlduarAI<npc_brann_bronzebeard_algalonAI>(creature);
    }
};

class npc_collapsing_star : public CreatureScript
{
public:
    npc_collapsing_star() : CreatureScript("npc_collapsing_star") { }

    struct npc_collapsing_starAI : public NullCreatureAI
    {
        npc_collapsing_starAI(Creature* creature) : NullCreatureAI(creature)
        {
            creature->GetMotionMaster()->MoveRandom(25.0f);
            creature->CastSpell(creature, SPELL_COLLAPSE, true);
        }

        void JustSummoned(Creature* summon) override
        {
            if (TempSummon* summ = me->ToTempSummon())
                if (Creature* algalon = ObjectAccessor::GetCreature(*me, summ->GetSummonerGUID()))
                    algalon->AI()->JustSummoned(summon);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                me->CastSpell(me, SPELL_BLACK_HOLE_SPAWN_VISUAL, true);
                me->CastSpell(me, SPELL_SUMMON_BLACK_HOLE, true);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUlduarAI<npc_collapsing_starAI>(creature);
    }
};

class npc_living_constellation : public CreatureScript
{
public:
    npc_living_constellation() : CreatureScript("npc_living_constellation") { }

    struct npc_living_constellationAI : public ScriptedAI
    {
        npc_living_constellationAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
        }

        EventMap events;
        bool _isActive;

        void Reset() override
        {
            events.Reset();
            events.ScheduleEvent(EVENT_ARCANE_BARRAGE, 2500ms);
            _isActive = false;
        }

        uint32 GetData(uint32  /*param*/) const override
        {
            return _isActive;
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_ACTIVATE_STAR:
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->SetImmuneToAll(false);
                    _isActive = true;

                    if (Player* target = SelectTargetFromPlayerList(250.0f))
                    {
                        AttackStart(target);
                        me->AddThreat(target, 100.0f);
                    }
                    me->SetInCombatWithZone();
                    break;
                case ACTION_BIG_BANG:
                    events.SetPhase(PHASE_BIG_BANG);
                    events.DelayEvents(9500);
                    events.ScheduleEvent(EVENT_RESUME_UPDATING, 9500ms);
                    break;
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id != SPELL_CONSTELLATION_PHASE_EFFECT || !caster->IsCreature())
                return;

            if (InstanceScript* instance = me->GetInstanceScript())
                instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, EVENT_ID_SUPERMASSIVE_START);

            caster->CastSpell((Unit*)nullptr, SPELL_BLACK_HOLE_CREDIT, TRIGGERED_FULL_MASK);
            caster->ToCreature()->DespawnOrUnsummon(1);
            me->DespawnOrUnsummon(1);
            if (Creature* voidZone = caster->FindNearestCreature(NPC_ALGALON_VOID_ZONE_VISUAL_STALKER, 10.0f))
                voidZone->DespawnOrUnsummon(1);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!(events.GetPhaseMask() & PHASE_MASK_NO_UPDATE) && !UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_ARCANE_BARRAGE:
                    me->CastCustomSpell(SPELL_ARCANE_BARRAGE, SPELLVALUE_MAX_TARGETS, 1, (Unit*)nullptr, true);
                    events.Repeat(2500ms);
                    break;
                case EVENT_RESUME_UPDATING:
                    events.SetPhase(0);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUlduarAI<npc_living_constellationAI>(creature);
    }
};

class npc_algalon_worm_hole : public CreatureScript
{
public:
    npc_algalon_worm_hole() : CreatureScript("npc_algalon_worm_hole") { }

    struct npc_algalon_worm_holeAI : public NullCreatureAI
    {
        npc_algalon_worm_holeAI(Creature* creature) : NullCreatureAI(creature)
        {
            creature->CastSpell(creature, SPELL_WORM_HOLE_TRIGGER, true);
            creature->CastSpell(creature, SPELL_SUMMON_VOID_ZONE_VISUAL, true);
        }

        uint32 _summonTimer;

        void Reset() override
        {
            _summonTimer = urand(22000, 24000);
        }

        void JustSummoned(Creature* summon) override
        {
            if (TempSummon* summ = me->ToTempSummon())
            {
                if (Creature* algalon = ObjectAccessor::GetCreature(*me, summ->GetSummonerGUID()))
                {
                    algalon->AI()->JustSummoned(summon);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _summonTimer += diff;
            if (_summonTimer >= 30000)
            {
                me->CastSpell((Unit*)nullptr, SPELL_SUMMON_UNLEASHED_DARK_MATTER, true);
                _summonTimer = 0;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUlduarAI<npc_algalon_worm_holeAI>(creature);
    }
};

class go_celestial_planetarium_access : public GameObjectScript
{
public:
    go_celestial_planetarium_access() : GameObjectScript("go_celestial_planetarium_access") {}

    struct go_celestial_planetarium_accessAI : public GameObjectAI
    {
        go_celestial_planetarium_accessAI(GameObject* go) : GameObjectAI(go)
        {
            _locked = false;
        }

        EventMap events;
        bool _locked;

        bool GossipHello(Player* player, bool  /*reportUse*/) override
        {
            bool hasKey = true;
            if (LockEntry const* lock = sLockStore.LookupEntry(me->GetGOInfo()->goober.lockId))
            {
                hasKey = false;
                for (uint32 i = 0; i < MAX_LOCK_CASE; ++i)
                {
                    if (!lock->Index[i])
                        continue;

                    if (player->HasItemCount(lock->Index[i]))
                    {
                        hasKey = true;
                        break;
                    }
                }
            }

            if (!hasKey)
                return false;

            if (_locked)
                return false;
            _locked = true;
            // Start Algalon event
            me->SetGameObjectFlag(GO_FLAG_IN_USE);
            events.ScheduleEvent(EVENT_DESPAWN_CONSOLE, 5000ms);
            if (Creature* brann = me->SummonCreature(NPC_BRANN_BRONZBEARD_ALG, BrannIntroSpawnPos))
                brann->AI()->DoAction(ACTION_START_INTRO);

            if (InstanceScript* instance = me->GetInstanceScript())
            {
                instance->SetData(DATA_ALGALON_SUMMON_STATE, 1);
                if (GameObject* sigil = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(GO_DOODAD_UL_SIGILDOOR_01)))
                    sigil->SetGoState(GO_STATE_ACTIVE);

                if (GameObject* sigil = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(GO_DOODAD_UL_SIGILDOOR_02)))
                    sigil->SetGoState(GO_STATE_ACTIVE);

                if (Map* map = player->GetMap())
                {
                    if (InstanceMap* instanceMap = map->ToInstanceMap())
                    {
                        instanceMap->PermBindAllPlayers();
                    }
                }
            }

            return false;
        }

        void UpdateAI(uint32 diff) override
        {
            if (events.Empty())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_DESPAWN_CONSOLE:
                    me->Delete();
                    break;
            }
        }
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_celestial_planetarium_accessAI(go);
    }
};

class spell_algalon_phase_punch_aura : public AuraScript
{
    PrepareAuraScript(spell_algalon_phase_punch_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(PhasePunchAlphaId);
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        if (GetStackAmount() != 1)
            GetTarget()->RemoveAurasDueToSpell(PhasePunchAlphaId[GetStackAmount() - 2]);
        GetTarget()->CastSpell(GetTarget(), PhasePunchAlphaId[GetStackAmount() - 1], TRIGGERED_FULL_MASK);
        if (GetStackAmount() == 5)
            Remove(AURA_REMOVE_BY_DEFAULT);
    }

    void OnRemove(AuraEffect const*, AuraEffectHandleModes)
    {
        if (GetStackAmount() != 5)
            GetTarget()->RemoveAurasDueToSpell(PhasePunchAlphaId[GetStackAmount() - 1]);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_algalon_phase_punch_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectRemove += AuraEffectRemoveFn(spell_algalon_phase_punch_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_algalon_collapse_aura : public AuraScript
{
    PrepareAuraScript(spell_algalon_collapse_aura);

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        Unit::DealDamage(GetTarget(), GetTarget(), GetTarget()->CountPctFromMaxHealth(1), nullptr, NODAMAGE);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_algalon_collapse_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class ActiveConstellationFilter
{
public:
    bool operator()(WorldObject* object) const
    {
        return object->ToUnit()->GetAI()->GetData(0);
    }
};

class spell_algalon_trigger_3_adds : public SpellScript
{
    PrepareSpellScript(spell_algalon_trigger_3_adds);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        targets.remove_if(ActiveConstellationFilter());
    }

    void HandleDummyEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Creature* target = GetHitCreature();
        if (!target)
            return;

        target->AI()->DoAction(ACTION_ACTIVATE_STAR);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_algalon_trigger_3_adds::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_algalon_trigger_3_adds::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_algalon_cosmic_smash_damage : public SpellScript
{
    PrepareSpellScript(spell_algalon_cosmic_smash_damage);

    void RecalculateDamage()
    {
        if (!GetExplTargetDest() || !GetHitUnit())
            return;

        float distance = GetHitUnit()->GetDistance2d(GetExplTargetDest()->GetPositionX(), GetExplTargetDest()->GetPositionY());
        if (distance >= 10.0f)
            SetHitDamage(int32(float(GetHitDamage()) / distance));
        else if (distance > 6.0f)
            SetHitDamage(int32(float(GetHitDamage()) / distance) * 2);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_algalon_cosmic_smash_damage::RecalculateDamage);
    }
};

class spell_algalon_big_bang : public SpellScript
{
    PrepareSpellScript(spell_algalon_big_bang);

    bool Load() override
    {
        _targetCount = 0;
        return true;
    }

    void CountTargets(std::list<WorldObject*>& targets)
    {
        _targetCount = targets.size();
    }

    void CheckTargets()
    {
        Unit* caster = GetCaster();
        if (!_targetCount && caster && caster->GetAI())
            caster->GetAI()->DoAction(ACTION_ASCEND);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_algalon_big_bang::CountTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        AfterCast += SpellCastFn(spell_algalon_big_bang::CheckTargets);
    }

private:
    uint32 _targetCount;
};

class spell_algalon_remove_phase_aura : public AuraScript
{
    PrepareAuraScript(spell_algalon_remove_phase_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BLACK_HOLE_DAMAGE });
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        GetTarget()->RemoveAurasByType(SPELL_AURA_PHASE);
        GetTarget()->RemoveAurasDueToSpell(SPELL_BLACK_HOLE_DAMAGE);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_algalon_remove_phase_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_algalon_supermassive_fail : public SpellScript
{
    PrepareSpellScript(spell_algalon_supermassive_fail);

    void RecalculateDamage()
    {
        if (!GetHitPlayer())
            return;

        GetHitPlayer()->ResetAchievementCriteria(ACHIEVEMENT_CRITERIA_CONDITION_NO_SPELL_HIT, GetSpellInfo()->Id, true);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_algalon_supermassive_fail::RecalculateDamage);
    }
};

class achievement_algalon_he_feeds_on_your_tears : public AchievementCriteriaScript
{
public:
    achievement_algalon_he_feeds_on_your_tears() : AchievementCriteriaScript("achievement_algalon_he_feeds_on_your_tears") { }

    bool OnCheck(Player*, Unit* target /*Algalon*/, uint32 /*criteria_id*/) override
    {
        return target && target->GetAI()->GetData(DATA_HAS_FED_ON_TEARS);
    }
};

class achievement_algalon_herald_of_the_titans : public AchievementCriteriaScript
{
public:
    achievement_algalon_herald_of_the_titans() : AchievementCriteriaScript("achievement_algalon_herald_of_the_titans") { }

    bool OnCheck(Player*, Unit* target /*Algalon*/, uint32 /*criteria_id*/) override
    {
        return target && target->GetAI()->GetData(DATA_HERALD_OF_THE_TITANS);
    }
};

void AddSC_boss_algalon_the_observer()
{
    // NPCs
    new boss_algalon_the_observer();
    new npc_brann_bronzebeard_algalon();
    new npc_collapsing_star();
    new npc_living_constellation();
    new npc_algalon_worm_hole();

    // GOs
    new go_celestial_planetarium_access();

    // Spells
    RegisterSpellScript(spell_algalon_phase_punch_aura);
    RegisterSpellScript(spell_algalon_collapse_aura);
    RegisterSpellScript(spell_algalon_trigger_3_adds);
    RegisterSpellScript(spell_algalon_cosmic_smash_damage);
    RegisterSpellScript(spell_algalon_big_bang);
    RegisterSpellScript(spell_algalon_remove_phase_aura);
    RegisterSpellScript(spell_algalon_supermassive_fail);

    // Achievements
    new achievement_algalon_he_feeds_on_your_tears();
    new achievement_algalon_herald_of_the_titans();
}
