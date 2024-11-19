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
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellScriptLoader.h"
#include "icecrown_citadel.h"
#include "SpellMgr.h"

enum ScriptTexts
{
    // Deathbringer Saurfang
    SAY_INTRO_ALLIANCE_2            = 0,
    SAY_INTRO_ALLIANCE_3            = 1,
    SAY_INTRO_ALLIANCE_6            = 2,
    SAY_INTRO_ALLIANCE_7            = 3,
    SAY_INTRO_HORDE_2               = 4,
    SAY_INTRO_HORDE_4               = 5,
    SAY_INTRO_HORDE_9               = 6,
    SAY_AGGRO                       = 7,
    SAY_MARK_OF_THE_FALLEN_CHAMPION = 8,
    SAY_BLOOD_BEASTS                = 9,
    SAY_KILL                        = 10,
    SAY_FRENZY                      = 11,
    SAY_BERSERK                     = 12,
    SAY_DEATH                       = 13,
    EMOTE_SCENT_OF_BLOOD            = 14,

    // High Overlord Saurfang
    SAY_INTRO_HORDE_1               = 0,
    SAY_INTRO_HORDE_3               = 1,
    SAY_INTRO_HORDE_5               = 2,
    SAY_INTRO_HORDE_6               = 3,
    SAY_INTRO_HORDE_7               = 4,
    SAY_INTRO_HORDE_8               = 5,
    SAY_OUTRO_ALLIANCE_8            = 6,
    SAY_OUTRO_ALLIANCE_12           = 7, // kneel after WP reached
    SAY_OUTRO_ALLIANCE_13           = 8,
    SAY_OUTRO_ALLIANCE_14           = 9,
    SAY_OUTRO_ALLIANCE_15           = 10,
    SAY_OUTRO_HORDE_1               = 11,
    SAY_OUTRO_HORDE_2               = 12,
    SAY_OUTRO_HORDE_3               = 13,
    SAY_OUTRO_HORDE_4               = 14,

    // Muradin Bronzebeard
    SAY_INTRO_ALLIANCE_1            = 0,
    SAY_INTRO_ALLIANCE_4            = 1,
    SAY_INTRO_ALLIANCE_5            = 2,
    SAY_OUTRO_ALLIANCE_1            = 3, /// @todo ALLIANCE OUTRO
    SAY_OUTRO_ALLIANCE_2            = 4,
    SAY_OUTRO_ALLIANCE_3            = 5,
    SAY_OUTRO_ALLIANCE_4            = 6,
    SAY_OUTRO_ALLIANCE_5            = 7,
    SAY_OUTRO_ALLIANCE_6            = 8,
    SAY_OUTRO_ALLIANCE_7            = 9,
    SAY_OUTRO_ALLIANCE_9            = 10,
    SAY_OUTRO_ALLIANCE_10           = 11,
    SAY_OUTRO_ALLIANCE_21           = 12,

    // Lady Jaina Proudmoore
    SAY_OUTRO_ALLIANCE_17           = 0,
    SAY_OUTRO_ALLIANCE_19           = 1,

    // King Varian Wrynn
    SAY_OUTRO_ALLIANCE_11           = 0,
    SAY_OUTRO_ALLIANCE_16           = 1,
    SAY_OUTRO_ALLIANCE_18           = 2,
    SAY_OUTRO_ALLIANCE_20           = 3,
};

enum Spells
{
    // Deathbringer Saurfang
    SPELL_ZERO_POWER                    = 72242,
    SPELL_GRIP_OF_AGONY                 = 70572, // Intro
    SPELL_BLOOD_LINK                    = 72178,
    SPELL_MARK_OF_THE_FALLEN_CHAMPION_S = 72256,
    SPELL_RUNE_OF_BLOOD_S               = 72408,

    SPELL_SUMMON_BLOOD_BEAST            = 72172,
    SPELL_SUMMON_BLOOD_BEAST_25_MAN     = 72356, // Additional cast, does not replace
    SPELL_FRENZY                        = 72737,
    SPELL_BLOOD_NOVA_TRIGGER            = 72378,
    SPELL_BLOOD_NOVA                    = 72380,
    SPELL_BLOOD_POWER                   = 72371,
    SPELL_BLOOD_LINK_POWER              = 72195,
    SPELL_BLOOD_LINK_DUMMY              = 72202,
    SPELL_MARK_OF_THE_FALLEN_CHAMPION   = 72293,
    SPELL_BOILING_BLOOD                 = 72385,
    SPELL_RUNE_OF_BLOOD                 = 72410,

    // Blood Beast
    SPELL_BLOOD_LINK_BEAST              = 72176,
    SPELL_RESISTANT_SKIN                = 72723,
    SPELL_SCENT_OF_BLOOD                = 72769, // Heroic only

    SPELL_RIDE_VEHICLE                  = 70640, // Outro
    SPELL_ACHIEVEMENT                   = 72928,
};

// Helper to get id of the aura on different modes (HasAura(baseId) wont work)
#define BOILING_BLOOD_HELPER RAID_MODE<int32>(72385, 72441, 72442, 72443)

enum EventTypes
{
    EVENT_INTRO_ALLIANCE_1      = 1,
    EVENT_INTRO_ALLIANCE_2      = 2,
    EVENT_INTRO_ALLIANCE_3      = 3,
    EVENT_INTRO_ALLIANCE_4      = 4,
    EVENT_INTRO_ALLIANCE_5      = 5,
    EVENT_INTRO_ALLIANCE_6      = 6,
    EVENT_INTRO_ALLIANCE_7      = 7,

    EVENT_INTRO_HORDE_1         = 8,
    EVENT_INTRO_HORDE_2         = 9,
    EVENT_INTRO_HORDE_3         = 10,
    EVENT_INTRO_HORDE_4         = 11,
    EVENT_INTRO_HORDE_5         = 12,
    EVENT_INTRO_HORDE_6         = 13,
    EVENT_INTRO_HORDE_7         = 14,
    EVENT_INTRO_HORDE_8         = 15,
    EVENT_INTRO_HORDE_9         = 16,

    EVENT_INTRO_FINISH          = 17,

    EVENT_BERSERK               = 18,
    EVENT_SUMMON_BLOOD_BEAST    = 19,
    EVENT_BLOOD_BEAST_SCENT_OF_BLOOD = 100,
    EVENT_BOILING_BLOOD         = 20,
    EVENT_BLOOD_NOVA            = 21,
    EVENT_RUNE_OF_BLOOD         = 22,

    EVENT_OUTRO_ALLIANCE_1      = 23,
    EVENT_OUTRO_ALLIANCE_2      = 24,
    EVENT_OUTRO_ALLIANCE_3      = 25,
    EVENT_OUTRO_ALLIANCE_4      = 26,
    EVENT_OUTRO_ALLIANCE_5      = 27,
    EVENT_OUTRO_ALLIANCE_6      = 28,
    EVENT_OUTRO_ALLIANCE_7      = 29,
    EVENT_OUTRO_ALLIANCE_8      = 30,
    EVENT_OUTRO_ALLIANCE_9      = 31,
    EVENT_OUTRO_ALLIANCE_10     = 32,
    EVENT_OUTRO_ALLIANCE_11     = 33,
    EVENT_OUTRO_ALLIANCE_12     = 34,
    EVENT_OUTRO_ALLIANCE_13     = 35,
    EVENT_OUTRO_ALLIANCE_14     = 36,
    EVENT_OUTRO_ALLIANCE_15     = 37,
    EVENT_OUTRO_ALLIANCE_16     = 38,
    EVENT_OUTRO_ALLIANCE_17     = 39,
    EVENT_OUTRO_ALLIANCE_18     = 40,
    EVENT_OUTRO_ALLIANCE_19     = 41,
    EVENT_OUTRO_ALLIANCE_20     = 42,
    EVENT_OUTRO_ALLIANCE_21     = 43,

    EVENT_OUTRO_HORDE_1         = 44,
    EVENT_OUTRO_HORDE_2         = 45,
    EVENT_OUTRO_HORDE_3         = 46,
    EVENT_OUTRO_HORDE_4         = 47,
    EVENT_OUTRO_HORDE_5         = 48,
};

enum Phases
{
    PHASE_INTRO_A       = 1,
    PHASE_INTRO_H       = 2,
    PHASE_COMBAT        = 3,

    PHASE_INTRO_MASK    = (1 << (PHASE_INTRO_A - 1)) | (1 << (PHASE_INTRO_H - 1)),
};

enum Actions
{
    ACTION_START_EVENT                  = -3781300,
    ACTION_CONTINUE_INTRO               = -3781301,
    ACTION_CHARGE                       = -3781302,
    ACTION_START_OUTRO                  = -3781303,
    ACTION_DESPAWN                      = -3781304,
    ACTION_INTRO_DONE                   = -3781305,
    ACTION_EVADE                        = -3781306,
    ACTION_GAIN_SCENT_OF_BLOOD          = -3781307,
    ACTION_MARK_OF_THE_FALLEN_CHAMPION  = -72293,
};

#define DATA_MADE_A_MESS 45374613 // 4537, 4613 are achievement IDs
#define FALLEN_CHAMPION_CAST_COUNT 123456

enum MovePoints
{
    POINT_SAURFANG          = 3781300,
    POINT_FIRST_STEP        = 3781301,
    POINT_CHARGE            = 3781302,
    POINT_CHOKE             = 3781303,
    POINT_CORPSE            = 3781304,
    POINT_FINAL             = 3781305,
};

Position const deathbringerPos = {-496.3542f, 2211.33f, 541.1138f, 0.0f};
Position const firstStepPos = {-541.3177f, 2211.365f, 539.2921f, 0.0f};

Position const chargePos[6] =
{
    {-509.6505f, 2211.377f, 539.2872f, 0.0f}, // High Overlord Saurfang/Muradin Bronzebeard
    {-508.7480f, 2211.897f, 539.2870f, 0.0f}, // front left
    {-509.2929f, 2211.411f, 539.2870f, 0.0f}, // front right
    {-506.6607f, 2211.367f, 539.2870f, 0.0f}, // back middle
    {-506.1137f, 2213.306f, 539.2870f, 0.0f}, // back left
    {-509.0040f, 2211.743f, 539.2870f, 0.0f}  // back right
};

Position const chokePos[6] =
{
    {-514.4834f, 2211.334f, 549.2887f, 0.0f}, // High Overlord Saurfang/Muradin Bronzebeard
    {-510.1081f, 2211.592f, 546.3773f, 0.0f}, // front left
    {-513.3210f, 2211.396f, 551.2882f, 0.0f}, // front right
    {-507.3684f, 2210.353f, 545.7497f, 0.0f}, // back middle
    {-507.0486f, 2212.999f, 545.5512f, 0.0f}, // back left
    {-510.7041f, 2211.069f, 546.5298f, 0.0f}  // back right
};

//Position const finalPos = {-563.7552f, 2211.328f, 538.7848f, 0.0f};

class boss_deathbringer_saurfang : public CreatureScript
{
public:
    boss_deathbringer_saurfang() : CreatureScript("boss_deathbringer_saurfang") { }

    struct boss_deathbringer_saurfangAI : public BossAI
    {
        boss_deathbringer_saurfangAI(Creature* creature) : BossAI(creature, DATA_DEATHBRINGER_SAURFANG)
        {
            ASSERT(creature->GetVehicleKit()); // we dont actually use it, just check if exists
        }

        void Reset() override
        {
            _Reset();
            me->SetImmuneToAll(true);
            me->SetReactState(REACT_DEFENSIVE);
            events.Reset();
            _introDone = false;
            _frenzied = false;
            _fallenChampionCastCount = 0;
            _transportCheckTimer = 1000;
            me->SetPower(POWER_ENERGY, 0);
            DoCast(me, SPELL_ZERO_POWER, true);
            DoCast(me, SPELL_BLOOD_LINK, true);
            DoCast(me, SPELL_BLOOD_POWER, true);
            DoCast(me, SPELL_MARK_OF_THE_FALLEN_CHAMPION_S, true);
            DoCast(me, SPELL_RUNE_OF_BLOOD_S, true);
            me->RemoveAurasDueToSpell(SPELL_BERSERK);
            me->RemoveAurasDueToSpell(SPELL_FRENZY);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_MARK_OF_THE_FALLEN_CHAMPION);
        }

        void JustEngagedWith(Unit* who) override
        {
            if (!_introDone)
            {
                me->CombatStop();
                return;
            }

            // pussywizard: without this, the aura is not recalculated the first time
            me->RemoveAurasDueToSpell(SPELL_BLOOD_POWER);
            DoCast(me, SPELL_BLOOD_POWER, true);

            if (!instance->CheckRequiredBosses(DATA_DEATHBRINGER_SAURFANG, who->ToPlayer()))
            {
                EnterEvadeMode(EVADE_REASON_OTHER);
                instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                return;
            }

            // oh just screw intro, enter combat - no exploits please
            me->setActive(true);
            DoZoneInCombat();
            Talk(SAY_AGGRO);

            events.Reset();
            events.ScheduleEvent(EVENT_SUMMON_BLOOD_BEAST, 30s);
            events.ScheduleEvent(EVENT_BERSERK, (IsHeroic() ? 6min : 8min));
            events.ScheduleEvent(EVENT_BOILING_BLOOD, 15s + 500ms, 0);
            events.ScheduleEvent(EVENT_BLOOD_NOVA, 17s, 0);
            events.ScheduleEvent(EVENT_RUNE_OF_BLOOD, 20s, 0);

            _fallenChampionCastCount = 0;
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_MARK_OF_THE_FALLEN_CHAMPION);
            instance->SetBossState(DATA_DEATHBRINGER_SAURFANG, IN_PROGRESS);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            DoCast(me, SPELL_ACHIEVEMENT, true);
            Talk(SAY_DEATH);

            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_MARK_OF_THE_FALLEN_CHAMPION);
            if (Creature* creature = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_SAURFANG_EVENT_NPC)))
                creature->AI()->DoAction(ACTION_START_OUTRO);
        }

        bool CanAIAttack(Unit const*  /*target*/) const override
        {
            return _introDone;
        }

        void AttackStart(Unit* victim) override
        {
            if (!_introDone || me->IsImmuneToPC())
                return;

            ScriptedAI::AttackStart(victim);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void JustReachedHome() override
        {
            _JustReachedHome();
            instance->SetBossState(DATA_DEATHBRINGER_SAURFANG, FAIL);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer())
                Talk(SAY_KILL);
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (!_frenzied && HealthBelowPct(31)) // AT 30%, not below
            {
                _frenzied = true;
                DoCast(me, SPELL_FRENZY, true);
                Talk(SAY_FRENZY);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 0.0f, true))
                summon->AI()->AttackStart(target);

            //if (IsHeroic())
            //    DoCast(summon, SPELL_SCENT_OF_BLOOD);

            summon->AI()->DoCast(summon, SPELL_BLOOD_LINK_BEAST, true);
            summon->AI()->DoCast(summon, SPELL_RESISTANT_SKIN, true);
            summons.Summon(summon);
            DoZoneInCombat(summon);
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            summons.Despawn(summon);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE && id != POINT_SAURFANG)
                return;

            instance->HandleGameObject(instance->GetGuidData(GO_SAURFANG_S_DOOR), false);
        }

        void SpellHitTarget(Unit*  /*target*/, SpellInfo const* spell) override
        {
            switch (spell->Id)
            {
                case SPELL_MARK_OF_THE_FALLEN_CHAMPION:
                    Talk(SAY_MARK_OF_THE_FALLEN_CHAMPION);
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (_transportCheckTimer <= diff)
            {
                _transportCheckTimer = 1000;
                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                    if (Player* p = itr->GetSource())
                        if (p->GetTransport())
                        {
                            EnterEvadeMode(EVADE_REASON_OTHER);
                            return;
                        }
            }
            else
                _transportCheckTimer -= diff;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SUMMON_BLOOD_BEAST:
                        for (uint32 i10 = 0; i10 < 2; ++i10)
                            DoCast(me, SPELL_SUMMON_BLOOD_BEAST + i10);
                        if (Is25ManRaid())
                            for (uint32 i25 = 0; i25 < 3; ++i25)
                                DoCast(me, SPELL_SUMMON_BLOOD_BEAST_25_MAN + i25);
                        Talk(SAY_BLOOD_BEASTS);
                        events.ScheduleEvent(EVENT_SUMMON_BLOOD_BEAST, 40s);
                        if (IsHeroic())
                            events.ScheduleEvent(EVENT_BLOOD_BEAST_SCENT_OF_BLOOD, 10s);
                        break;
                    case EVENT_BLOOD_BEAST_SCENT_OF_BLOOD:
                        Talk(EMOTE_SCENT_OF_BLOOD);
                        summons.DoAction(ACTION_GAIN_SCENT_OF_BLOOD);
                        break;
                    case EVENT_BLOOD_NOVA:
                        {
                            me->CastSpell((Unit*)nullptr, SPELL_BLOOD_NOVA_TRIGGER, false);
                            events.ScheduleEvent(EVENT_BLOOD_NOVA, 20s, 25s);
                            break;
                        }
                    case EVENT_RUNE_OF_BLOOD:
                        DoCastVictim(SPELL_RUNE_OF_BLOOD);
                        events.ScheduleEvent(EVENT_RUNE_OF_BLOOD, 20s, 25s);
                        break;
                    case EVENT_BOILING_BLOOD:
                        me->CastSpell((Unit*)nullptr, SPELL_BOILING_BLOOD, false);
                        events.ScheduleEvent(EVENT_BOILING_BLOOD, 15s, 20s);
                        break;
                    case EVENT_BERSERK:
                        DoCast(me, SPELL_BERSERK);
                        Talk(SAY_BERSERK);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_MARK_OF_THE_FALLEN_CHAMPION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 0.0f, true, true, -SPELL_MARK_OF_THE_FALLEN_CHAMPION))
                    {
                        ++_fallenChampionCastCount;
                        me->CastSpell(target, SPELL_MARK_OF_THE_FALLEN_CHAMPION, false);
                        me->SetPower(POWER_ENERGY, 0);
                        if (Aura* bloodPower = me->GetAura(SPELL_BLOOD_POWER))
                            bloodPower->RecalculateAmountOfEffects();
                    }
                    break;
                case ACTION_INTRO_DONE:
                    _introDone = true;
                    break;
                default:
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_MADE_A_MESS)
            {
                if (_fallenChampionCastCount < RAID_MODE<uint32>(3, 5, 3, 5))
                    return 1;
            }
            else if (type == FALLEN_CHAMPION_CAST_COUNT)
                return _fallenChampionCastCount;

            return 0;
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            BossAI::EnterEvadeMode(why);
            if (Creature* creature = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_SAURFANG_EVENT_NPC)))
                creature->AI()->DoAction(ACTION_EVADE);
        }

    private:
        uint32 _fallenChampionCastCount;
        bool _introDone;
        bool _frenzied;   // faster than iterating all auras to find Frenzy
        uint16 _transportCheckTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<boss_deathbringer_saurfangAI>(creature);
    }
};

class npc_high_overlord_saurfang_icc : public CreatureScript
{
public:
    npc_high_overlord_saurfang_icc() : CreatureScript("npc_high_overlord_saurfang_icc") { }

    struct npc_high_overlord_saurfangAI : public ScriptedAI
    {
        npc_high_overlord_saurfangAI(Creature* creature) : ScriptedAI(creature)
        {
            ASSERT(creature->GetVehicleKit());
            _instance = me->GetInstanceScript();
        }

        void Reset() override
        {
            _events.Reset();
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->SetReactState(REACT_PASSIVE);
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_START_EVENT:
                    {
                        // Prevent crashes
                        if (_events.GetPhaseMask() & PHASE_INTRO_MASK)
                            return;

                        Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG));
                        if (!deathbringer || deathbringer->IsInEvadeMode())
                            return;

                        if (_guardList.empty())
                        {
                            GetCreatureListWithEntryInGrid(_guardList, me, NPC_SE_KOR_KRON_REAVER, 20.0f);
                            _guardList.sort(Acore::ObjectDistanceOrderPred(me));
                        }
                        uint32 x = 1;
                        for (std::list<Creature*>::iterator itr = _guardList.begin(); itr != _guardList.end(); ++itr)
                            (*itr)->AI()->SetData(0, x++);

                        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        Talk(SAY_INTRO_HORDE_1);
                        _events.SetPhase(PHASE_INTRO_H);
                        _events.ScheduleEvent(EVENT_INTRO_HORDE_2, 5s, 0, PHASE_INTRO_H);
                        _events.ScheduleEvent(EVENT_INTRO_HORDE_3, 18s + 500ms, 0, PHASE_INTRO_H);
                        _instance->HandleGameObject(_instance->GetGuidData(GO_SAURFANG_S_DOOR), true);

                        if (GameObject* teleporter = ObjectAccessor::GetGameObject(*me, _instance->GetGuidData(GO_SCOURGE_TRANSPORTER_SAURFANG)))
                        {
                            _instance->HandleGameObject(ObjectGuid::Empty, false, teleporter);
                            teleporter->SetGameObjectFlag(GO_FLAG_IN_USE);
                        }

                        deathbringer->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        deathbringer->SetWalk(false);
                        deathbringer->GetMotionMaster()->MovePoint(POINT_SAURFANG, deathbringerPos.GetPositionX(), deathbringerPos.GetPositionY(), deathbringerPos.GetPositionZ());
                    }
                    break;
                case ACTION_START_OUTRO:
                    {
                        me->RemoveAurasDueToSpell(SPELL_GRIP_OF_AGONY);
                        me->SetDisableGravity(false);
                        me->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), 539.2917f, 10.0f);
                        for (std::list<Creature*>::iterator itr = _guardList.begin(); itr != _guardList.end(); ++itr)
                            (*itr)->AI()->DoAction(ACTION_DESPAWN);

                        /*Talk(SAY_OUTRO_HORDE_1);
                        _events.ScheduleEvent(EVENT_OUTRO_HORDE_1, 10000);
                        _events.ScheduleEvent(EVENT_OUTRO_HORDE_2, 18000);
                        _events.ScheduleEvent(EVENT_OUTRO_HORDE_3, 24000);*/
                    }
                    break;
                case ACTION_EVADE:
                    {
                        float x, y, z, o;
                        me->GetMotionMaster()->Clear();
                        me->GetHomePosition(x, y, z, o);
                        me->SetPosition(x, y, z, o);
                        me->StopMovingOnCurrentPos();
                        me->SetDisableGravity(false);
                        EnterEvadeMode();
                        for (std::list<Creature*>::iterator itr = _guardList.begin(); itr != _guardList.end(); ++itr)
                        {
                            (*itr)->GetMotionMaster()->Clear();
                            (*itr)->GetHomePosition(x, y, z, o);
                            (*itr)->SetPosition(x, y, z, o);
                            (*itr)->StopMovingOnCurrentPos();
                            (*itr)->SetDisableGravity(false);
                            (*itr)->AI()->EnterEvadeMode();
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_GRIP_OF_AGONY)
            {
                me->SetDisableGravity(true);
                me->GetMotionMaster()->MovePoint(POINT_CHOKE, chokePos[0]);
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE)
            {
                switch (id)
                {
                    case POINT_FIRST_STEP:
                        me->SetWalk(false);
                        Talk(SAY_INTRO_HORDE_3);
                        _events.ScheduleEvent(EVENT_INTRO_HORDE_4, 6500ms, 0, PHASE_INTRO_H);
                        _events.ScheduleEvent(EVENT_INTRO_HORDE_5, 15s + 500ms, 0, PHASE_INTRO_H);
                        _events.ScheduleEvent(EVENT_INTRO_HORDE_6, 29s + 500ms, 0, PHASE_INTRO_H);
                        _events.ScheduleEvent(EVENT_INTRO_HORDE_7, 43s + 800ms, 0, PHASE_INTRO_H);
                        _events.ScheduleEvent(EVENT_INTRO_HORDE_8, 47s, 0, PHASE_INTRO_H);
                        _events.ScheduleEvent(EVENT_INTRO_HORDE_9, 48s + 200ms, 0, PHASE_INTRO_H);
                        _events.ScheduleEvent(EVENT_INTRO_FINISH,  56s + 700ms, 0, PHASE_INTRO_H);
                        break;
                    /*case POINT_CORPSE:
                        if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                        {
                            deathbringer->CastSpell(me, SPELL_RIDE_VEHICLE, true);
                            deathbringer->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                            deathbringer->setDeathState(DeathState::Alive);
                        }
                        _events.ScheduleEvent(EVENT_OUTRO_HORDE_4, 1000);
                        _events.ScheduleEvent(EVENT_OUTRO_HORDE_5, 4000);
                        break;
                    case POINT_FINAL:
                        if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                            deathbringer->DespawnOrUnsummon();
                        me->DespawnOrUnsummon();
                        break;*/
                    default:
                        break;
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            switch (_events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_INTRO_HORDE_2:
                    if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                        deathbringer->AI()->Talk(SAY_INTRO_HORDE_2);
                    break;
                case EVENT_INTRO_HORDE_3:
                    me->SetWalk(true);
                    me->GetMotionMaster()->MovePoint(POINT_FIRST_STEP, firstStepPos.GetPositionX(), firstStepPos.GetPositionY(), firstStepPos.GetPositionZ());
                    break;
                case EVENT_INTRO_HORDE_4:
                    if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                        deathbringer->AI()->Talk(SAY_INTRO_HORDE_4);
                    break;
                case EVENT_INTRO_HORDE_5:
                    Talk(SAY_INTRO_HORDE_5);
                    break;
                case EVENT_INTRO_HORDE_6:
                    Talk(SAY_INTRO_HORDE_6);
                    break;
                case EVENT_INTRO_HORDE_7:
                    Talk(SAY_INTRO_HORDE_7);
                    break;
                case EVENT_INTRO_HORDE_8:
                    Talk(SAY_INTRO_HORDE_8);
                    for (std::list<Creature*>::iterator itr = _guardList.begin(); itr != _guardList.end(); ++itr)
                        (*itr)->AI()->DoAction(ACTION_CHARGE);
                    me->GetMotionMaster()->MoveCharge(chargePos[0].GetPositionX(), chargePos[0].GetPositionY(), chargePos[0].GetPositionZ(), 8.5f, POINT_CHARGE);
                    break;
                case EVENT_INTRO_HORDE_9:
                    if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                    {
                        deathbringer->AI()->DoCast(me, SPELL_GRIP_OF_AGONY);
                        deathbringer->AI()->Talk(SAY_INTRO_HORDE_9);
                    }
                    break;
                case EVENT_INTRO_FINISH:
                    if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                    {
                        deathbringer->AI()->DoAction(ACTION_INTRO_DONE);
                        deathbringer->SetImmuneToPC(false);
                        if (Player* target = deathbringer->SelectNearestPlayer(100.0f))
                            deathbringer->AI()->AttackStart(target);
                    }
                    break;

                    /*case EVENT_OUTRO_HORDE_1:
                        if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                            me->SetFacingToObject(deathbringer);
                        Talk(SAY_OUTRO_HORDE_2);
                        break;
                    case EVENT_OUTRO_HORDE_2:
                        Talk(SAY_OUTRO_HORDE_3);
                        break;
                    case EVENT_OUTRO_HORDE_3:
                        if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                        {
                            float x, y, z;
                            deathbringer->GetClosePoint(x, y, z, deathbringer->GetObjectSize());
                            me->SetWalk(true);
                            me->GetMotionMaster()->MovePoint(POINT_CORPSE, x, y, z);
                        }
                        break;
                    case EVENT_OUTRO_HORDE_4:
                        me->GetMotionMaster()->MovePoint(POINT_FINAL, finalPos);
                        break;
                    case EVENT_OUTRO_HORDE_5:
                        Talk(SAY_OUTRO_HORDE_4);
                        break;*/
            }
        }

    private:
        EventMap _events;
        InstanceScript* _instance;
        std::list<Creature*> _guardList;
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        InstanceScript* instance = creature->GetInstanceScript();
        if (instance && instance->GetBossState(DATA_DEATHBRINGER_SAURFANG) != DONE && instance->GetBossState(DATA_DEATHBRINGER_SAURFANG) != IN_PROGRESS)
        {
            AddGossipItemFor(player, 10953, 0, GOSSIP_SENDER_INFO, -ACTION_START_EVENT);
            SendGossipMenuFor(player, player->GetGossipTextId(10953, creature), creature->GetGUID());
        }

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        InstanceScript* instance = creature->GetInstanceScript();
        if (instance && instance->GetBossState(DATA_DEATHBRINGER_SAURFANG) != DONE && instance->GetBossState(DATA_DEATHBRINGER_SAURFANG) != IN_PROGRESS)
        {
            ClearGossipMenuFor(player);
            CloseGossipMenuFor(player);
            if (action == -ACTION_START_EVENT)
                creature->AI()->DoAction(ACTION_START_EVENT);
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_high_overlord_saurfangAI>(creature);
    }
};

class npc_muradin_bronzebeard_icc : public CreatureScript
{
public:
    npc_muradin_bronzebeard_icc() : CreatureScript("npc_muradin_bronzebeard_icc") { }

    struct npc_muradin_bronzebeard_iccAI : public ScriptedAI
    {
        npc_muradin_bronzebeard_iccAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = me->GetInstanceScript();
        }

        void Reset() override
        {
            _events.Reset();
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->SetReactState(REACT_PASSIVE);
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_START_EVENT:
                    {
                        // Prevent crashes
                        if (_events.GetPhaseMask() & PHASE_INTRO_MASK)
                            return;

                        Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG));
                        if (!deathbringer || deathbringer->IsInEvadeMode())
                            return;

                        if (_guardList.empty())
                        {
                            GetCreatureListWithEntryInGrid(_guardList, me, NPC_SE_SKYBREAKER_MARINE, 20.0f);
                            _guardList.sort(Acore::ObjectDistanceOrderPred(me));
                        }
                        uint32 x = 1;
                        for (std::list<Creature*>::iterator itr = _guardList.begin(); itr != _guardList.end(); ++itr)
                            (*itr)->AI()->SetData(0, x++);

                        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        Talk(SAY_INTRO_ALLIANCE_1);
                        _events.SetPhase(PHASE_INTRO_A);
                        _events.ScheduleEvent(EVENT_INTRO_ALLIANCE_2, 2500ms, 0, PHASE_INTRO_A);
                        _events.ScheduleEvent(EVENT_INTRO_ALLIANCE_3, 20s, 0, PHASE_INTRO_A);
                        _events.ScheduleEvent(EVENT_INTRO_ALLIANCE_4, 29s + 500ms, 0, PHASE_INTRO_A);
                        _instance->HandleGameObject(_instance->GetGuidData(GO_SAURFANG_S_DOOR), true);

                        if (GameObject* teleporter = ObjectAccessor::GetGameObject(*me, _instance->GetGuidData(GO_SCOURGE_TRANSPORTER_SAURFANG)))
                        {
                            _instance->HandleGameObject(ObjectGuid::Empty, false, teleporter);
                            teleporter->SetGameObjectFlag(GO_FLAG_IN_USE);
                        }

                        deathbringer->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        deathbringer->SetWalk(false);
                        deathbringer->GetMotionMaster()->MovePoint(POINT_SAURFANG, deathbringerPos.GetPositionX(), deathbringerPos.GetPositionY(), deathbringerPos.GetPositionZ());
                    }
                    break;
                case ACTION_START_OUTRO:
                    {
                        me->RemoveAurasDueToSpell(SPELL_GRIP_OF_AGONY);
                        me->SetDisableGravity(false);
                        me->MonsterMoveWithSpeed(me->GetPositionX(), me->GetPositionY(), 539.2917f, 10.0f);
                        for (std::list<Creature*>::iterator itr = _guardList.begin(); itr != _guardList.end(); ++itr)
                            (*itr)->AI()->DoAction(ACTION_DESPAWN);

                        //Talk(SAY_OUTRO_ALLIANCE_1);
                        break;
                    }
                case ACTION_EVADE:
                    {
                        float x, y, z, o;
                        me->GetMotionMaster()->Clear();
                        me->GetHomePosition(x, y, z, o);
                        me->SetPosition(x, y, z, o);
                        me->StopMovingOnCurrentPos();
                        me->SetDisableGravity(false);
                        EnterEvadeMode();
                        for (std::list<Creature*>::iterator itr = _guardList.begin(); itr != _guardList.end(); ++itr)
                        {
                            (*itr)->GetMotionMaster()->Clear();
                            (*itr)->GetHomePosition(x, y, z, o);
                            (*itr)->SetPosition(x, y, z, o);
                            (*itr)->StopMovingOnCurrentPos();
                            (*itr)->SetDisableGravity(false);
                            (*itr)->AI()->EnterEvadeMode();
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_GRIP_OF_AGONY)
            {
                me->SetDisableGravity(true);
                me->GetMotionMaster()->MovePoint(POINT_CHOKE, chokePos[0]);
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE)
            {
                switch (id)
                {
                    case POINT_FIRST_STEP:
                        me->SetWalk(false);
                        Talk(SAY_INTRO_ALLIANCE_4);
                        _events.ScheduleEvent(EVENT_INTRO_ALLIANCE_5, 5s, 0, PHASE_INTRO_A);
                        _events.ScheduleEvent(EVENT_INTRO_ALLIANCE_6, 7s, 0, PHASE_INTRO_A);
                        _events.ScheduleEvent(EVENT_INTRO_ALLIANCE_7, 9s, 0, PHASE_INTRO_A);
                        _events.ScheduleEvent(EVENT_INTRO_FINISH, 14s, 0, PHASE_INTRO_A);
                        break;
                    default:
                        break;
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);
            switch (_events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_INTRO_ALLIANCE_2:
                    if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                        deathbringer->AI()->Talk(SAY_INTRO_ALLIANCE_2);
                    break;
                case EVENT_INTRO_ALLIANCE_3:
                    if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                        deathbringer->AI()->Talk(SAY_INTRO_ALLIANCE_3);
                    break;
                case EVENT_INTRO_ALLIANCE_4:
                    me->SetWalk(true);
                    me->GetMotionMaster()->MovePoint(POINT_FIRST_STEP, firstStepPos.GetPositionX(), firstStepPos.GetPositionY(), firstStepPos.GetPositionZ());
                    break;
                case EVENT_INTRO_ALLIANCE_5:
                    Talk(SAY_INTRO_ALLIANCE_5);
                    for (std::list<Creature*>::iterator itr = _guardList.begin(); itr != _guardList.end(); ++itr)
                        (*itr)->AI()->DoAction(ACTION_CHARGE);
                    me->GetMotionMaster()->MoveCharge(chargePos[0].GetPositionX(), chargePos[0].GetPositionY(), chargePos[0].GetPositionZ(), 8.5f, POINT_CHARGE);
                    break;
                case EVENT_INTRO_ALLIANCE_6:
                    if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                    {
                        deathbringer->AI()->Talk(SAY_INTRO_ALLIANCE_7);
                        deathbringer->AI()->DoCast(me, SPELL_GRIP_OF_AGONY);
                    }
                    break;
                case EVENT_INTRO_ALLIANCE_7:
                    if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                    {
                        deathbringer->AI()->Talk(SAY_INTRO_ALLIANCE_6);
                    }
                    break;
                case EVENT_INTRO_FINISH:
                    if (Creature* deathbringer = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_DEATHBRINGER_SAURFANG)))
                    {
                        deathbringer->AI()->DoAction(ACTION_INTRO_DONE);
                        deathbringer->SetImmuneToPC(false);
                        if (Player* target = deathbringer->SelectNearestPlayer(100.0f))
                            deathbringer->AI()->AttackStart(target);
                    }
                    break;
            }
        }

    private:
        EventMap _events;
        InstanceScript* _instance;
        std::list<Creature*> _guardList;
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        InstanceScript* instance = creature->GetInstanceScript();
        if (instance && instance->GetBossState(DATA_DEATHBRINGER_SAURFANG) != DONE && instance->GetBossState(DATA_DEATHBRINGER_SAURFANG) != IN_PROGRESS)
        {
            AddGossipItemFor(player, 10933, 0, GOSSIP_SENDER_INFO, -ACTION_START_EVENT + 1);
            SendGossipMenuFor(player, player->GetGossipTextId(10933, creature), creature->GetGUID());
        }

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        InstanceScript* instance = creature->GetInstanceScript();
        if (instance && instance->GetBossState(DATA_DEATHBRINGER_SAURFANG) != DONE && instance->GetBossState(DATA_DEATHBRINGER_SAURFANG) != IN_PROGRESS)
        {
            ClearGossipMenuFor(player);
            CloseGossipMenuFor(player);
            if (action == -ACTION_START_EVENT + 1)
                creature->AI()->DoAction(ACTION_START_EVENT);
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_muradin_bronzebeard_iccAI>(creature);
    }
};

class npc_saurfang_event : public CreatureScript
{
public:
    npc_saurfang_event() : CreatureScript("npc_saurfang_event") { }

    struct npc_saurfang_eventAI : public ScriptedAI
    {
        npc_saurfang_eventAI(Creature* creature) : ScriptedAI(creature)
        {
            _index = 0;
            me->SetReactState(REACT_PASSIVE);
        }

        void SetData(uint32 type, uint32 data) override
        {
            ASSERT(!type && data && data < 6);
            _index = data;
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_GRIP_OF_AGONY)
            {
                me->SetDisableGravity(true);
                me->GetMotionMaster()->MovePoint(POINT_CHOKE, chokePos[_index]);
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_CHARGE && _index)
            {
                me->SetWalk(false);
                me->GetMotionMaster()->MoveCharge(chargePos[_index].GetPositionX(), chargePos[_index].GetPositionY(), chargePos[_index].GetPositionZ(), 13.0f, POINT_CHARGE);
            }
            else if (action == ACTION_DESPAWN)
                me->DespawnOrUnsummon(1);
        }

    private:
        uint32 _index;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_saurfang_eventAI>(creature);
    }
};

class spell_deathbringer_blood_link_aura : public AuraScript
{
    PrepareAuraScript(spell_deathbringer_blood_link_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BLOOD_LINK_DUMMY });
    }

    void HandlePeriodicTick(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        if (GetUnitOwner()->getPowerType() == POWER_ENERGY && GetUnitOwner()->GetPower(POWER_ENERGY) == GetUnitOwner()->GetMaxPower(POWER_ENERGY))
            if (Creature* saurfang = GetUnitOwner()->ToCreature())
                saurfang->AI()->DoAction(ACTION_MARK_OF_THE_FALLEN_CHAMPION);
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        DamageInfo* damageInfo = eventInfo.GetDamageInfo();
        SpellInfo const* procSpell = eventInfo.GetSpellInfo();
        return eventInfo.GetActor() && eventInfo.GetActionTarget() && ((damageInfo && damageInfo->GetDamage()) || eventInfo.GetHitMask() & PROC_EX_ABSORB) && procSpell && procSpell->SpellIconID != 2731; // Xinef: Mark of the Fallen Champion
    }

    void HandleProc(AuraEffect const*  /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        Unit* victim = eventInfo.GetActionTarget();
        SpellInfo const* procSpell = eventInfo.GetSpellInfo();

        //uint32 markCount = 0;
        //if (Creature* saurfang = eventInfo.GetActor()->ToCreature())
        //markCount = saurfang->IsAIEnabled ? saurfang->AI()->GetData(123456 /*FALLEN_CHAMPION_CAST_COUNT*/) : 0;
        int32 basepoints = int32(1.0f /*+ 0.5f + 0.5f*markCount*/);
        switch (procSpell->Id) // some spells give more Blood Power
        {
            case 72380:
            case 72438:
            case 72439:
            case 72440: // Blood Nova
                basepoints = int32(2.0f /*+ 0.5f + 0.75f*markCount*/);
                break;
        }

        victim->CastCustomSpell(SPELL_BLOOD_LINK_DUMMY, SPELLVALUE_BASE_POINT0, basepoints, eventInfo.GetActor(), true);
        return;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_deathbringer_blood_link_aura::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_deathbringer_blood_link_aura::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_deathbringer_blood_link_aura::HandlePeriodicTick, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_deathbringer_blood_link_blood_beast_aura : public AuraScript
{
    PrepareAuraScript(spell_deathbringer_blood_link_blood_beast_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BLOOD_LINK_DUMMY });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        DamageInfo* damageInfo = eventInfo.GetDamageInfo();
        SpellInfo const* procSpell = eventInfo.GetSpellInfo();
        return eventInfo.GetActor() && eventInfo.GetActionTarget() && ((damageInfo && damageInfo->GetDamage()) || eventInfo.GetHitMask() & PROC_EX_ABSORB) && (!procSpell || procSpell->SpellIconID != 2731); // Xinef: Mark of the Fallen Champion
    }

    void HandleProc(AuraEffect const*  /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        /*
        uint32 markCount = 0;
        if (Map* map = eventInfo.GetActor()->FindMap())
            if (InstanceMap* imap = map->ToInstanceMap())
                if (InstanceScript* isc = imap->GetInstanceScript())
                    if (ObjectGuid sguid = isc->GetGuidData(3) //DATA_DEATHBRINGER_SAURFANG
                        if (Creature* saurfang = ObjectAccessor::GetCreature(*eventInfo.GetActor(), sguid))
                            markCount = saurfang->IsAIEnabled ? saurfang->AI()->GetData(123456) : 0; //FALLEN_CHAMPION_CAST_COUNT
        */
        int32 basepoints = int32(3.0f /*+ 0.5f + 0.5f*markCount*/);

        eventInfo.GetActor()->CastCustomSpell(SPELL_BLOOD_LINK_DUMMY, SPELLVALUE_BASE_POINT0, basepoints, eventInfo.GetActionTarget(), true);
        return;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_deathbringer_blood_link_blood_beast_aura::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_deathbringer_blood_link_blood_beast_aura::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class spell_deathbringer_blood_link : public SpellScript
{
    PrepareSpellScript(spell_deathbringer_blood_link);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BLOOD_LINK_POWER });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastCustomSpell(SPELL_BLOOD_LINK_POWER, SPELLVALUE_BASE_POINT0, GetEffectValue(), GetHitUnit(), true);
        if (Aura* bloodPower = GetHitUnit()->GetAura(SPELL_BLOOD_POWER))
            bloodPower->RecalculateAmountOfEffects();
        PreventHitDefaultEffect(EFFECT_0);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_deathbringer_blood_link::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_deathbringer_blood_power : public SpellScript
{
    PrepareSpellScript(spell_deathbringer_blood_power);

    void ModAuraValue()
    {
        if (Aura* aura = GetHitAura())
            aura->RecalculateAmountOfEffects();
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_deathbringer_blood_power::ModAuraValue);
    }
};

class spell_deathbringer_blood_power_aura : public AuraScript
{
    PrepareAuraScript(spell_deathbringer_blood_power_aura);

    void RecalculateHook(AuraEffect const* /*aurEffect*/, int32& amount, bool& canBeRecalculated)
    {
        amount = int32(GetUnitOwner()->GetPower(POWER_ENERGY));
        canBeRecalculated = true;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_deathbringer_blood_power_aura::RecalculateHook, EFFECT_0, SPELL_AURA_MOD_SCALE);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_deathbringer_blood_power_aura::RecalculateHook, EFFECT_1, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
    }
};

class spell_deathbringer_blood_nova_targeting : public SpellScript
{
    PrepareSpellScript(spell_deathbringer_blood_nova_targeting);

    bool Load() override
    {
        // initialize variable
        _target = nullptr;
        return true;
    }

    void FilterTargetsInitial(std::list<WorldObject*>& targets)
    {
        // select one random target, with preference of ranged targets
        uint32 targetsAtRange = 0;
        uint32 const minTargets = uint32(GetCaster()->GetMap()->GetSpawnMode() & 1 ? 10 : 4);
        targets.sort(Acore::ObjectDistanceOrderPred(GetCaster(), false));

        // get target count at range
        for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr, ++targetsAtRange)
            if ((*itr)->GetDistance(GetCaster()) < 12.0f)
                break;

        // set the upper cap
        if (targetsAtRange < minTargets)
            targetsAtRange = std::min<uint32>(targets.size(), minTargets);

        if (!targetsAtRange)
            return;

        std::list<WorldObject*>::iterator itrTarget = targets.begin();
        std::advance(itrTarget, urand(0, targetsAtRange - 1));
        _target = *itrTarget;
        targets.clear();
        targets.push_back(_target);
    }

    // use the same target for first and second effect
    void FilterTargetsSubsequent(std::list<WorldObject*>& targets)
    {
        if (!_target)
            return;

        targets.clear();
        targets.push_back(_target);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_deathbringer_blood_nova_targeting::FilterTargetsInitial, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_deathbringer_blood_nova_targeting::FilterTargetsSubsequent, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
    }

private:
    WorldObject* _target;
};

class spell_deathbringer_boiling_blood : public SpellScript
{
    PrepareSpellScript(spell_deathbringer_boiling_blood);

    bool Load() override
    {
        return GetCaster()->IsCreature();
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove(GetCaster()->GetVictim());
        if (targets.empty())
            return;

        if (GetSpellInfo()->Id == 72385 || GetSpellInfo()->Id == 72442) // 10n, 10h
        {
            WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
            targets.clear();
            targets.push_back(target);
        }
        else
            Acore::Containers::RandomResize(targets, 3);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_deathbringer_boiling_blood::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class achievement_ive_gone_and_made_a_mess : public AchievementCriteriaScript
{
public:
    achievement_ive_gone_and_made_a_mess() : AchievementCriteriaScript("achievement_ive_gone_and_made_a_mess") { }

    bool OnCheck(Player* /*source*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (target)
            if (Creature* saurfang = target->ToCreature())
                if (saurfang->AI()->GetData(DATA_MADE_A_MESS))
                    return true;

        return false;
    }
};

class npc_icc_blood_beast : public CreatureScript
{
public:
    npc_icc_blood_beast() : CreatureScript("npc_icc_blood_beast") { }

    struct npc_icc_blood_beastAI : public ScriptedAI
    {
        npc_icc_blood_beastAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetControlled(true, UNIT_STATE_ROOT);
            timer1 = 1500;
        }

        uint16 timer1;

        void DoAction(int32 param) override
        {
            if (param == ACTION_GAIN_SCENT_OF_BLOOD)
                me->CastSpell(me, SPELL_SCENT_OF_BLOOD, false);
        }

        void UpdateAI(uint32 diff) override
        {
            if (timer1)
            {
                if (timer1 <= diff)
                {
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    timer1 = 0;
                }
                else
                    timer1 -= diff;
            }

            ScriptedAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_icc_blood_beastAI>(creature);
    }
};

void AddSC_boss_deathbringer_saurfang()
{
    new boss_deathbringer_saurfang();
    new npc_high_overlord_saurfang_icc();
    new npc_muradin_bronzebeard_icc();
    new npc_saurfang_event();
    RegisterSpellScript(spell_deathbringer_blood_link_aura);
    RegisterSpellScript(spell_deathbringer_blood_link_blood_beast_aura);
    RegisterSpellScript(spell_deathbringer_blood_link);
    RegisterSpellAndAuraScriptPair(spell_deathbringer_blood_power, spell_deathbringer_blood_power_aura);
    RegisterSpellScript(spell_deathbringer_blood_nova_targeting);
    RegisterSpellScript(spell_deathbringer_boiling_blood);
    new achievement_ive_gone_and_made_a_mess();
    new npc_icc_blood_beast();
}
