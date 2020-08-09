/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "GridNotifiers.h"
#include "icecrown_citadel.h"
#include "Player.h"

enum Texts
{
    SAY_AGGRO                           = 0, // You are fools to have come to this place! The icy winds of Northrend will consume your souls!
    SAY_UNCHAINED_MAGIC                 = 1, // Suffer, mortals, as your pathetic magic betrays you!
    EMOTE_WARN_BLISTERING_COLD          = 2, // %s prepares to unleash a wave of blistering cold!
    SAY_BLISTERING_COLD                 = 3, // Can you feel the cold hand of death upon your heart?
    SAY_RESPITE_FOR_A_TORMENTED_SOUL    = 4, // Aaah! It burns! What sorcery is this?!
    SAY_AIR_PHASE                       = 5, // Your incursion ends here! None shall survive!
    SAY_PHASE_2                         = 6, // Now feel my master's limitless power and despair!
    EMOTE_WARN_FROZEN_ORB               = 7, // %s fires a frozen orb towards $N!
    SAY_KILL                            = 8, // Perish!
                                             // A flaw of mortality...
    SAY_BERSERK                         = 9, // Enough! I tire of these games!
    SAY_DEATH                           = 10, // Free...at last...
    EMOTE_BERSERK_RAID                  = 11,
    EMOTE_WEAKENING                     = 101, // %s appears to be weakening!
};

enum Spells
{
    // Sindragosa
    SPELL_SINDRAGOSA_S_FURY     = 70608,
    SPELL_TANK_MARKER           = 71039,
    SPELL_TANK_MARKER_AURA      = 71038,
    SPELL_FROST_AURA            = 70084,
    SPELL_PERMAEATING_CHILL     = 70109,
    SPELL_CLEAVE                = 19983,
    SPELL_TAIL_SMASH            = 71077,
    SPELL_FROST_BREATH_P1       = 69649,
    SPELL_FROST_BREATH_P2       = 73061,
    SPELL_UNCHAINED_MAGIC       = 69762,
    SPELL_INSTABILITY           = 69766,
    SPELL_BACKLASH              = 69770,
    SPELL_ICY_GRIP              = 70117,
    SPELL_ICY_GRIP_JUMP         = 70122,
    SPELL_BLISTERING_COLD       = 70123,
    SPELL_FROST_BEACON          = 70126,
    SPELL_ICE_TOMB_TARGET       = 69712,
    SPELL_ICE_TOMB_DUMMY        = 69675,
    SPELL_ICE_TOMB_UNTARGETABLE = 69700,
    SPELL_ICE_TOMB_DAMAGE       = 70157,
    SPELL_ASPHYXIATION          = 71665,
    SPELL_FROST_BOMB_TRIGGER    = 69846,
    SPELL_FROST_BOMB_VISUAL     = 70022,
    SPELL_BIRTH_NO_VISUAL       = 40031,
    SPELL_FROST_BOMB            = 69845,
    SPELL_MYSTIC_BUFFET         = 70128,

    // Spinestalker
    SPELL_BELLOWING_ROAR        = 36922,
    SPELL_CLEAVE_SPINESTALKER   = 40505,
    SPELL_TAIL_SWEEP            = 71370,

    // Rimefang
    SPELL_FROST_BREATH          = 71386,
    SPELL_FROST_AURA_RIMEFANG   = 71387,
    SPELL_ICY_BLAST             = 71376,
    SPELL_ICY_BLAST_AREA        = 71380,

    // Frostwarden Handler
    SPELL_FOCUS_FIRE            = 71350,
    SPELL_ORDER_WHELP           = 71357,
    SPELL_CONCUSSIVE_SHOCK      = 71337,
};

enum Shadowmourne
{
    QUEST_FROST_INFUSION        = 24757,
    SPELL_FROST_INFUSION_CREDIT = 72289,
    SPELL_FROST_IMBUED_BLADE    = 72290,
    SPELL_FROST_INFUSION        = 72292,
};

enum Events
{
    EVENT_NONE,

    // Sindragosa
    EVENT_BERSERK,
    EVENT_CLEAVE,
    EVENT_TAIL_SMASH,
    EVENT_FROST_BREATH,
    EVENT_UNROOT,
    EVENT_UNCHAINED_MAGIC,
    EVENT_ICY_GRIP,
    EVENT_BLISTERING_COLD,
    EVENT_BLISTERING_COLD_YELL,
    EVENT_AIR_PHASE,
    EVENT_AIR_MOVEMENT,
    EVENT_AIR_MOVEMENT_FAR,
    EVENT_LAND,
    EVENT_LAND_GROUND,
    EVENT_FROST_BOMB,
    EVENT_THIRD_PHASE_CHECK,
    EVENT_ICE_TOMB,

    // Spinestalker
    EVENT_BELLOWING_ROAR            = 13,
    EVENT_CLEAVE_SPINESTALKER       = 14,
    EVENT_TAIL_SWEEP                = 15,

    // Rimefang
    EVENT_FROST_BREATH_RIMEFANG     = 16,
    EVENT_ICY_BLAST                 = 17,
    EVENT_ICY_BLAST_CAST            = 18,

    // Trash
    EVENT_FROSTWARDEN_ORDER_WHELP   = 19,
    EVENT_CONCUSSIVE_SHOCK          = 20,
    EVENT_WHELP_FROST_BLAST         = 21,

    // event groups
    EVENT_GROUP_LAND_PHASE          = 1,
};

enum FrostwingData
{
    DATA_MYSTIC_BUFFET_STACK    = 0,
    DATA_FROSTWYRM_OWNER        = 1,
    DATA_WHELP_MARKER           = 2,
    DATA_LINKED_GAMEOBJECT      = 3,
    DATA_TRAPPED_PLAYER         = 4,
};

enum MovementPoints
{
    POINT_FROSTWYRM_FLY_IN  = 1,
    POINT_FROSTWYRM_LAND    = 2,
    POINT_AIR_PHASE         = 3,
    POINT_TAKEOFF           = 4,
    POINT_LAND              = 5,
    POINT_AIR_PHASE_FAR     = 6,
    POINT_LAND_GROUND       = 7,
    POINT_CHASE_VICTIM      = 8,
};

Position const RimefangFlyPos      = {4413.309f, 2456.421f, 233.3795f, 2.890186f};
Position const RimefangLandPos     = {4413.309f, 2456.421f, 203.3848f, 2.890186f};
Position const SpinestalkerFlyPos  = {4418.895f, 2514.233f, 230.4864f, 3.396045f};
Position const SpinestalkerLandPos = {4418.895f, 2514.233f, 203.3848f, 3.396045f};
Position const SindragosaSpawnPos  = {4818.700f, 2483.710f, 287.0650f, 3.089233f};
Position const SindragosaFlyInPos  = {4420.190f, 2484.360f, 232.5150f, 3.141593f};
Position const SindragosaLandPos   = {4419.190f, 2484.570f, 203.3848f, 3.141593f};
Position const SindragosaAirPos    = {4475.990f, 2484.430f, 247.9340f, 3.141593f};
Position const SindragosaAirPosFar = {4525.600f, 2485.150f, 245.0820f, 3.141593f};

class FrostwyrmLandEvent : public BasicEvent
{
    public:
        FrostwyrmLandEvent(Creature& owner, Position const& dest) : _owner(owner), _dest(dest) { }

        bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/)
        {
            _owner.GetMotionMaster()->MoveLand(POINT_FROSTWYRM_LAND, _dest, 8.5f);
            return true;
        }

    private:
        Creature& _owner;
        Position const& _dest;
};

class FrostBombExplosion : public BasicEvent
{
    public:
        FrostBombExplosion(Creature* owner, uint64 sindragosaGUID) : _owner(owner), _sindragosaGUID(sindragosaGUID) { }

        bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/)
        {
            _owner->CastSpell((Unit*)NULL, SPELL_FROST_BOMB, false, nullptr, nullptr, _sindragosaGUID);
            _owner->RemoveAurasDueToSpell(SPELL_FROST_BOMB_VISUAL);
            return true;
        }

    private:
        Creature* _owner;
        uint64 _sindragosaGUID;
};

class IceTombSummonEvent : public BasicEvent
{
    public:
        IceTombSummonEvent(Unit* owner, uint64 sindragosaGUID) : _owner(owner), _sindragosaGUID(sindragosaGUID) { }

        bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/)
        {
            if (!_owner->IsAlive() || !_owner->HasAura(SPELL_ICE_TOMB_DAMAGE))
                return true;
            if (Creature* sindragosa = ObjectAccessor::GetCreature(*_owner, _sindragosaGUID))
            {
                if (!sindragosa->IsAlive())
                    return true;
                Position pos;
                _owner->GetPosition(&pos);
                _owner->m_positionZ -= 1.0f; // +2.0f in UpdateGroundPositionZ, prevent going over GO model of another ice block, because new would be spawned on top of the old one xd
                _owner->UpdateGroundPositionZ(pos.m_positionX, pos.m_positionY, pos.m_positionZ);
                if (pos.GetPositionZ() < 203.0f)
                    pos.m_positionZ = 203.0f;
                if (TempSummon* summon = sindragosa->SummonCreature(NPC_ICE_TOMB, pos))
                {
                    summon->m_positionZ = summon->GetPositionZ()+5.0f;
                    summon->AI()->SetGUID(_owner->GetGUID(), DATA_TRAPPED_PLAYER);
                    _owner->CastSpell(_owner, SPELL_ICE_TOMB_UNTARGETABLE, true);
                    if (GameObject* go = summon->SummonGameObject(GO_ICE_BLOCK, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ()-3.5f, pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 0))
                    {
                        go->SetSpellId(SPELL_ICE_TOMB_DAMAGE);
                        summon->AddGameObject(go);
                    }
                }
            }
            return true;
        }

    private:
        Unit* _owner;
        uint64 _sindragosaGUID;
};

struct LastPhaseIceTombTargetSelector : public acore::unary_function<Unit*, bool>
{
    public:
        LastPhaseIceTombTargetSelector(Creature* source) : _source(source) { }
        bool operator()(Unit const* target) const
        {
            if (!target)
                return false;

            if (target->GetExactDist(_source) > 80.0f)
                return false;

            if (target->GetTypeId() != TYPEID_PLAYER)
                return false;

            if (target->HasAura(SPELL_FROST_IMBUED_BLADE))
                return false;

            if (target->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_ALL) || target->HasAura(SPELL_ICE_TOMB_UNTARGETABLE) || target->HasAura(SPELL_ICE_TOMB_DAMAGE) || target->HasAura(SPELL_TANK_MARKER_AURA) || target->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
                return false;

            return target != _source->GetVictim();
        }

    private:
        Creature const* _source;
};

class boss_sindragosa : public CreatureScript
{
    public:
        boss_sindragosa() : CreatureScript("boss_sindragosa") { }

        struct boss_sindragosaAI : public BossAI
        {
            boss_sindragosaAI(Creature* creature) : BossAI(creature, DATA_SINDRAGOSA), _summoned(false)
            {
                me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_HASTE_SPELLS, true);
            }

            void Reset()
            {
                _didFirstFlyPhase = false;
                _isBelow20Pct = false;
                _isThirdPhase = false;
                _bombCount = 0;
                _mysticBuffetStack = 0;
                _Reset();
                me->DisableRotate(false);
                me->SetControlled(false, UNIT_STATE_ROOT);
                me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run);
                me->SetReactState(REACT_AGGRESSIVE);
                me->CastSpell(me, SPELL_TANK_MARKER, true);

                if (!_summoned)
                {
                    me->SetDisableGravity(true);
                    me->SetHover(true);
                    me->SetCanFly(true);
                }
            }

            void MoveInLineOfSight(Unit* who)
            {
                if (!me->HasUnitMovementFlag(MOVEMENTFLAG_CAN_FLY))
                    BossAI::MoveInLineOfSight(who);
            }

            void JustDied(Unit* /* killer */)
            {
                _JustDied();
                Talk(SAY_DEATH);

                if (Is25ManRaid() && me->HasAura(SPELL_SHADOWS_FATE))
                    DoCastAOE(SPELL_FROST_INFUSION_CREDIT, true);

                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_FROST_BEACON);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ICE_TOMB_TARGET);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ICE_TOMB_DUMMY);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ICE_TOMB_UNTARGETABLE);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ICE_TOMB_DAMAGE);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ASPHYXIATION);
            }

            void EnterCombat(Unit* victim)
            {
                if (!instance->CheckRequiredBosses(DATA_SINDRAGOSA, victim->ToPlayer()) || !me->IsVisible())
                {
                    EnterEvadeMode();
                    instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                    return;
                }

                _didFirstFlyPhase = false;
                _isBelow20Pct = false;
                _isThirdPhase = false;
                _bombCount = 0;
                _mysticBuffetStack = 0;

                summons.DespawnAll();
                events.Reset();
                events.ScheduleEvent(EVENT_BERSERK, 600000);
                events.ScheduleEvent(EVENT_AIR_PHASE, 50000);
                events.ScheduleEvent(EVENT_CLEAVE, 10000, EVENT_GROUP_LAND_PHASE);
                events.ScheduleEvent(EVENT_TAIL_SMASH, 20000, EVENT_GROUP_LAND_PHASE);
                events.ScheduleEvent(EVENT_FROST_BREATH, urand(8000, 12000), EVENT_GROUP_LAND_PHASE);
                events.ScheduleEvent(EVENT_UNCHAINED_MAGIC, urand(9000, 14000), EVENT_GROUP_LAND_PHASE);
                events.ScheduleEvent(EVENT_ICY_GRIP, 33500, EVENT_GROUP_LAND_PHASE);

                me->setActive(true);
                me->SetInCombatWithZone();
                instance->SetBossState(DATA_SINDRAGOSA, IN_PROGRESS);

                me->CastSpell(me, SPELL_FROST_AURA, true);
                me->CastSpell(me, SPELL_PERMAEATING_CHILL, true);
                Talk(SAY_AGGRO);
            }

            bool CanAIAttack(const Unit* target) const
            {
                return me->IsVisible() && target->GetEntry() != NPC_CROK_SCOURGEBANE;
            }

            void JustReachedHome()
            {
                _JustReachedHome();
                instance->SetBossState(DATA_SINDRAGOSA, FAIL);
                if (_summoned)
                {
                    me->SetDisableGravity(false);
                    me->SetHover(false);
                    me->SetCanFly(false);
                }
            }

            void EnterEvadeMode()
            {
                if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE)) // this flag is removed after she lands and can be engaged
                {
                    const Map::PlayerList &pl = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                        if (Player* p = itr->GetSource())
                            if (p->IsAlive() && !p->IsGameMaster() && p->GetExactDist(&SindragosaLandPos) < 200.0f && !p->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_ALL))
                                Unit::Kill(me, p);
                }
                me->DisableRotate(false);
                me->SetControlled(false, UNIT_STATE_ROOT);
                BossAI::EnterEvadeMode();
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_KILL);
            }

            void DoAction(int32 action)
            {
                if (action == ACTION_START_FROSTWYRM)
                {
                    if (_summoned)
                        return;

                    _summoned = true;
                    if (TempSummon* summon = me->ToTempSummon())
                        summon->SetTempSummonType(TEMPSUMMON_DEAD_DESPAWN);

                    if (me->isDead())
                        return;

                    me->setActive(true);
                    me->SetCanFly(true);
                    me->SetDisableGravity(true);
                    me->SetHover(true);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->SetSpeed(MOVE_RUN, 4.28571f);
                    float moveTime = me->GetExactDist(&SindragosaFlyInPos) / (me->GetSpeed(MOVE_RUN) * 0.001f);
                    me->m_Events.AddEvent(new FrostwyrmLandEvent(*me, SindragosaLandPos), me->m_Events.CalculateTime(uint64(moveTime) + 250));
                    me->GetMotionMaster()->MovePoint(POINT_FROSTWYRM_FLY_IN, SindragosaFlyInPos);
                    me->CastSpell(me, SPELL_SINDRAGOSA_S_FURY, true);
                }
            }

            uint32 GetData(uint32 type) const
            {
                if (type == DATA_MYSTIC_BUFFET_STACK)
                    return _mysticBuffetStack;
                return 0xFFFFFFFF;
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type != POINT_MOTION_TYPE && type != EFFECT_MOTION_TYPE)
                    return;

                switch (point)
                {
                    case POINT_FROSTWYRM_LAND:
                        me->setActive(false);
                        me->SetDisableGravity(false);
                        me->SetHover(false);
                        me->SetCanFly(false);
                        me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run);
                        me->SetHomePosition(SindragosaLandPos);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                        // Sindragosa enters combat as soon as she lands
                        me->SetInCombatWithZone();
                        break;
                    case POINT_TAKEOFF:
                        events.ScheduleEvent(EVENT_AIR_MOVEMENT, 0);
                        break;
                    case POINT_AIR_PHASE:
                        me->CastCustomSpell(SPELL_ICE_TOMB_TARGET, SPELLVALUE_MAX_TARGETS, RAID_MODE<int32>(2, 5, 2, 6), nullptr);
                        me->SetFacingTo(float(M_PI));
                        events.ScheduleEvent(EVENT_AIR_MOVEMENT_FAR, 0); // won't be processed during cast time anyway, so 0
                        events.ScheduleEvent(EVENT_FROST_BOMB, 7000);
                        _bombCount = 0;
                        break;
                    case POINT_AIR_PHASE_FAR:
                        me->SetFacingTo(float(M_PI));
                        break;
                    case POINT_LAND:
                        events.ScheduleEvent(EVENT_LAND_GROUND, 0);
                        break;
                    case POINT_LAND_GROUND:
                    {
                        me->SetDisableGravity(false);
                        me->SetHover(false);
                        me->SetCanFly(false);
                        me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run);
                        me->SetReactState(REACT_AGGRESSIVE);
                        if (Unit* target = me->SelectVictim())
                            AttackStart(target);
                        break;
                    }
                    default:
                        break;
                }
            }

            void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (!damage || me->IsInEvadeMode())
                    return;

                if (!_didFirstFlyPhase)
                    return;

                if (!_isThirdPhase)
                {
                    if (!HealthAbovePct(35))
                    {
                        _isThirdPhase = true;
                        events.CancelEvent(EVENT_AIR_PHASE);
                        events.ScheduleEvent(EVENT_THIRD_PHASE_CHECK, 1000);
                    }
                }
                else if (!_isBelow20Pct)
                {
                    if (!HealthAbovePct(20))
                    {
                        _isBelow20Pct = true;
                        if (instance->GetData(DATA_WEEKLY_QUEST_ID) == QUEST_RESPITE_FOR_A_TORMENTED_SOUL_10)
                            Talk(EMOTE_WEAKENING);
                    }
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (summon->GetEntry() == NPC_FROST_BOMB)
                    summon->m_Events.AddEvent(new FrostBombExplosion(summon, me->GetGUID()), summon->m_Events.CalculateTime(5500));
            }

            void SummonedCreatureDespawn(Creature* summon)
            {
                BossAI::SummonedCreatureDespawn(summon);
                if (summon->GetEntry() == NPC_ICE_TOMB)
                    summon->AI()->JustDied(summon);
            }

            void SpellHitTarget(Unit* target, SpellInfo const* spell)
            {
                if (target->GetTypeId() == TYPEID_PLAYER)
                    if (uint32 spellId = sSpellMgr->GetSpellIdForDifficulty(70127, me))
                        if (spellId == spell->Id)
                            if (Aura const* mysticBuffet = target->GetAura(spell->Id))
                                _mysticBuffetStack = std::max<uint8>(_mysticBuffetStack, mysticBuffet->GetStackAmount());
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() || !CheckInRoom())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_BERSERK:
                        Talk(EMOTE_BERSERK_RAID);
                        Talk(SAY_BERSERK);
                        me->CastSpell(me, SPELL_BERSERK, true);
                        break;
                    case EVENT_CLEAVE:
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                        events.ScheduleEvent(EVENT_CLEAVE, urand(10000, 15000), EVENT_GROUP_LAND_PHASE);
                        break;
                    case EVENT_TAIL_SMASH:
                        me->DisableRotate(true);
                        me->SetControlled(true, UNIT_STATE_ROOT);
                        me->SendMovementFlagUpdate();
                        me->CastSpell(me->GetVictim(), SPELL_TAIL_SMASH, false);
                        events.DelayEventsToMax(1, 0);
                        events.ScheduleEvent(EVENT_UNROOT, 0);
                        events.ScheduleEvent(EVENT_TAIL_SMASH, urand(22000, 27000), EVENT_GROUP_LAND_PHASE);
                        break;
                    case EVENT_FROST_BREATH:
                        me->DisableRotate(true);
                        me->SetControlled(true, UNIT_STATE_ROOT);
                        me->SendMovementFlagUpdate();
                        me->CastSpell(me->GetVictim(), _isThirdPhase ? SPELL_FROST_BREATH_P2 : SPELL_FROST_BREATH_P1, false);
                        events.DelayEventsToMax(1, 0);
                        events.ScheduleEvent(EVENT_UNROOT, 0);
                        events.ScheduleEvent(EVENT_FROST_BREATH, urand(20000, 25000), EVENT_GROUP_LAND_PHASE);
                        break;
                    case EVENT_UNROOT:
                        me->DisableRotate(false);
                        me->SetControlled(false, UNIT_STATE_ROOT);
                        break;
                    case EVENT_UNCHAINED_MAGIC:
                        Talk(SAY_UNCHAINED_MAGIC);
                        me->CastSpell((Unit*)NULL, SPELL_UNCHAINED_MAGIC, false);
                        events.ScheduleEvent(EVENT_UNCHAINED_MAGIC, urand(30000, 35000), EVENT_GROUP_LAND_PHASE);
                        break;
                    case EVENT_ICY_GRIP:
                        me->CastSpell((Unit*)NULL, SPELL_ICY_GRIP, false);
                        events.DelayEventsToMax(1001, 0);
                        events.ScheduleEvent(EVENT_BLISTERING_COLD, 1000, EVENT_GROUP_LAND_PHASE);
                        if (uint32 evTime = events.GetNextEventTime(EVENT_ICE_TOMB))
                            if (events.GetTimer() > evTime || evTime - events.GetTimer() < 7000)
                                events.RescheduleEvent(EVENT_ICE_TOMB, 7000);
                        break;
                    case EVENT_BLISTERING_COLD:
                        Talk(EMOTE_WARN_BLISTERING_COLD);
                        me->CastSpell(me, SPELL_BLISTERING_COLD, false);
                        events.ScheduleEvent(EVENT_BLISTERING_COLD_YELL, 5000, EVENT_GROUP_LAND_PHASE);
                        if (_isThirdPhase)
                            events.RescheduleEvent(EVENT_ICY_GRIP, urand(65000, 70000));
                        break;
                    case EVENT_BLISTERING_COLD_YELL:
                        Talk(SAY_BLISTERING_COLD);
                        break;

                    // AIR PHASE EVENTS BELOW:
                    case EVENT_AIR_PHASE:
                        // pussywizard: unroot may be scheduled after this event cos of events shitness (time must be unique)
                        if (me->HasUnitState(UNIT_STATE_ROOT))
                        {
                            events.CancelEvent(EVENT_UNROOT);
                            me->DisableRotate(false);
                            me->SetControlled(false, UNIT_STATE_ROOT);
                        }

                        _didFirstFlyPhase = true;
                        Talk(SAY_AIR_PHASE);
                        me->SetReactState(REACT_PASSIVE);
                        me->SetSpeed(MOVE_RUN, 4.28571f);
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->AttackStop();
                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        me->SetCanFly(true);
                        me->SetDisableGravity(true);
                        me->SetHover(true);
                        me->SendMovementFlagUpdate();
                        me->GetMotionMaster()->MoveTakeoff(POINT_TAKEOFF, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+20.0f, 10.0f);
                        events.CancelEventGroup(EVENT_GROUP_LAND_PHASE);
                        events.ScheduleEvent(EVENT_AIR_PHASE, 110000);
                        break;
                    case EVENT_AIR_MOVEMENT:
                        me->GetMotionMaster()->MovePoint(POINT_AIR_PHASE, SindragosaAirPos);
                        break;
                    case EVENT_AIR_MOVEMENT_FAR:
                        me->GetMotionMaster()->MovePoint(POINT_AIR_PHASE_FAR, SindragosaAirPosFar);
                        break;
                    case EVENT_FROST_BOMB:
                    {
                        ++_bombCount;
                        float destX, destY, destZ;
                        std::list<GameObject*> gl;
                        me->GetGameObjectListWithEntryInGrid(gl, GO_ICE_BLOCK, SIZE_OF_GRIDS);
                        uint8 triesLeft = 10;
                        do
                        {
                            destX = float(rand_norm()) * 75.0f + 4350.0f;
                            destY = float(rand_norm()) * 75.0f + 2450.0f;
                            destZ = 205.0f; // random number close to ground, get exact in next call
                            me->UpdateGroundPositionZ(destX, destY, destZ);
                            bool ok = true;
                            for (std::list<GameObject*>::const_iterator itr = gl.begin(); itr != gl.end(); ++itr)
                                if ((*itr)->GetExactDist2dSq(destX, destY) < 3.0f*3.0f)
                                {
                                    ok = false;
                                    break;
                                }
                            if (ok)
                                break;
                        } while (--triesLeft);
                                
                        me->CastSpell(destX, destY, destZ, SPELL_FROST_BOMB_TRIGGER, false);
                        if (_bombCount >= 4)
                            events.ScheduleEvent(EVENT_LAND, 5500);
                        else
                            events.ScheduleEvent(EVENT_FROST_BOMB, 6000);
                        break;
                    }
                    case EVENT_LAND:
                        me->GetMotionMaster()->MovePoint(POINT_LAND, SindragosaFlyInPos);
                        break;
                    case EVENT_LAND_GROUND:
                        events.ScheduleEvent(EVENT_CLEAVE, urand(13000, 15000), EVENT_GROUP_LAND_PHASE);
                        events.ScheduleEvent(EVENT_TAIL_SMASH, urand(19000, 23000), EVENT_GROUP_LAND_PHASE);
                        events.ScheduleEvent(EVENT_FROST_BREATH, urand(7000, 10000), EVENT_GROUP_LAND_PHASE);
                        events.ScheduleEvent(EVENT_UNCHAINED_MAGIC, urand(12000, 17000), EVENT_GROUP_LAND_PHASE);
                        events.ScheduleEvent(EVENT_ICY_GRIP, urand(35000, 40000), EVENT_GROUP_LAND_PHASE);
                        me->GetMotionMaster()->MoveLand(POINT_LAND_GROUND, SindragosaLandPos, 10.0f);
                        break;
                    case EVENT_THIRD_PHASE_CHECK:
                        if (!me->HasByteFlag(UNIT_FIELD_BYTES_1, 3, UNIT_BYTE1_FLAG_HOVER))
                        {
                            Talk(SAY_PHASE_2);
                            events.ScheduleEvent(EVENT_ICE_TOMB, urand(7000, 10000));
                            events.RescheduleEvent(EVENT_ICY_GRIP, urand(35000, 40000), EVENT_GROUP_LAND_PHASE);
                            me->CastSpell(me, SPELL_MYSTIC_BUFFET, true);
                        }
                        else
                            events.ScheduleEvent(EVENT_THIRD_PHASE_CHECK, 5000);
                        break;
                    case EVENT_ICE_TOMB:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, LastPhaseIceTombTargetSelector(me)))
                        {
                            Talk(EMOTE_WARN_FROZEN_ORB, target);
                            me->CastSpell(target, SPELL_ICE_TOMB_DUMMY, true);
                            me->CastSpell(target, SPELL_FROST_BEACON, true);
                            if (uint32 evTime = events.GetNextEventTime(EVENT_ICY_GRIP))
                                if (events.GetTimer() > evTime || evTime - events.GetTimer() < 8000)
                                    events.RescheduleEvent(EVENT_ICY_GRIP, 8000, EVENT_GROUP_LAND_PHASE);
                        }
                        events.ScheduleEvent(EVENT_ICE_TOMB, urand(18000, 22000));
                        break;
                    default:
                        break;
                }

                if (me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()) && me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE && !me->IsWithinLOSInMap(me->GetVictim()))
                    me->GetMotionMaster()->MoveCharge(me->GetVictim()->GetPositionX(), me->GetVictim()->GetPositionY(), me->GetVictim()->GetPositionZ(), me->GetSpeed(MOVE_RUN), POINT_CHASE_VICTIM);
                DoMeleeAttackIfReady();
            }

        private:
            bool _summoned;
            uint8 _bombCount;
            uint8 _mysticBuffetStack;
            bool _didFirstFlyPhase;
            bool _isBelow20Pct;
            bool _isThirdPhase;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_sindragosaAI>(creature);
        }
};

class npc_ice_tomb : public CreatureScript
{
    public:
        npc_ice_tomb() : CreatureScript("npc_ice_tomb") { }

        struct npc_ice_tombAI : public NullCreatureAI
        {
            npc_ice_tombAI(Creature* creature) : NullCreatureAI(creature)
            {
                me->SetReactState(REACT_PASSIVE);
                _trappedPlayerGUID = 0;
                _existenceCheckTimer = 1000;
                _asphyxiationTimer = 22500;
            }

            uint64 _trappedPlayerGUID;
            uint32 _existenceCheckTimer;
            uint16 _asphyxiationTimer;

            void SetGUID(uint64 guid, int32 type)
            {
                if (type == DATA_TRAPPED_PLAYER)
                    _trappedPlayerGUID = guid;
            }

            void DamageTaken(Unit*, uint32 &dmg, DamageEffectType, SpellSchoolMask)
            {
                if (dmg >= me->GetHealth())
                    me->m_positionZ = me->GetPositionZ() - 5.0f;
            }

            void JustDied(Unit* /*killer*/)
            {
                me->RemoveAllGameObjects();

                if (Player* player = ObjectAccessor::GetPlayer(*me, _trappedPlayerGUID))
                {
                    _trappedPlayerGUID = 0;
                    player->RemoveAurasDueToSpell(SPELL_ICE_TOMB_DAMAGE);
                    player->RemoveAurasDueToSpell(SPELL_ASPHYXIATION);
                    player->RemoveAurasDueToSpell(SPELL_ICE_TOMB_UNTARGETABLE);
                    me->DespawnOrUnsummon(5000);
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!_trappedPlayerGUID)
                    return;

                if (_existenceCheckTimer <= diff)
                {
                    Player* player = ObjectAccessor::GetPlayer(*me, _trappedPlayerGUID);
                    if (!player || !player->IsAlive() || !player->HasAura(SPELL_ICE_TOMB_DAMAGE))
                    {
                        // Remove object
                        JustDied(me);
                        me->DespawnOrUnsummon();
                        return;
                    }
                    _existenceCheckTimer = 1000;
                }
                else
                    _existenceCheckTimer -= diff;

                if (_asphyxiationTimer)
                {
                    if (_asphyxiationTimer <= diff)
                    {
                        _asphyxiationTimer = 0;
                        if (Player* player = ObjectAccessor::GetPlayer(*me, _trappedPlayerGUID))
                        {
                            player->RemoveAurasDueToSpell(SPELL_ICE_TOMB_UNTARGETABLE);
                            player->CastSpell(player, SPELL_ASPHYXIATION, true);
                        }
                    }
                    else
                        _asphyxiationTimer -= diff;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_ice_tombAI>(creature);
        }
};

class spell_sindragosa_s_fury : public SpellScriptLoader
{
    public:
        spell_sindragosa_s_fury() : SpellScriptLoader("spell_sindragosa_s_fury") { }

        class spell_sindragosa_s_fury_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sindragosa_s_fury_SpellScript);

            bool Load()
            {
                _targetCount = 0;

                // This script should execute only in Icecrown Citadel
                if (InstanceMap* instance = GetCaster()->GetMap()->ToInstanceMap())
                    if (instance->GetInstanceScript())
                        if (instance->GetScriptId() == sObjectMgr->GetScriptId(ICCScriptName))
                            return true;

                return false;
            }

            void SelectDest()
            {
                if (Position* dest = const_cast<WorldLocation*>(GetExplTargetDest()))
                {
                    float destX = float(rand_norm()) * 75.0f + 4350.0f;
                    float destY = float(rand_norm()) * 75.0f + 2450.0f;
                    float destZ = 205.0f; // random number close to ground, get exact in next call
                    GetCaster()->UpdateGroundPositionZ(destX, destY, destZ);
                    dest->Relocate(destX, destY, destZ);
                }
            }

            void CountTargets(std::list<WorldObject*>& targets)
            {
                _targetCount = targets.size();
            }

            void HandleDummy(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                if (!GetHitUnit()->IsAlive() || (GetHitUnit()->GetTypeId() == TYPEID_PLAYER && GetHitUnit()->ToPlayer()->IsGameMaster()) || !_targetCount)
                    return;

                float resistance = float(GetHitUnit()->GetResistance(SpellSchoolMask(GetSpellInfo()->SchoolMask)));
                float ResistFactor = ((resistance*2.0f) / (resistance + 510.0f));
                if (ResistFactor > 0.9f)
                    ResistFactor = 0.9f;

                uint32 damage = uint32( (GetEffectValue()/_targetCount) * (1.0f-ResistFactor) );

                SpellNonMeleeDamage damageInfo(GetCaster(), GetHitUnit(), GetSpellInfo()->Id, GetSpellInfo()->SchoolMask);
                damageInfo.damage = damage;
                GetCaster()->SendSpellNonMeleeDamageLog(&damageInfo);
                GetCaster()->DealSpellDamage(&damageInfo, false);
            }

            void Register()
            {
                BeforeCast += SpellCastFn(spell_sindragosa_s_fury_SpellScript::SelectDest);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_s_fury_SpellScript::CountTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENTRY);
                OnEffectHitTarget += SpellEffectFn(spell_sindragosa_s_fury_SpellScript::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
            }

            uint32 _targetCount;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sindragosa_s_fury_SpellScript();
        }
};

class UnchainedMagicTargetSelector
{
public:
    UnchainedMagicTargetSelector(bool removeHealers) : _removeHealers(removeHealers) { }

    bool operator()(WorldObject* object) const
    {
        if (Player* p = object->ToPlayer())
        {
            if (p->getPowerType() != POWER_MANA)
                return true;
            if (p->getClass() == CLASS_HUNTER)
                return true;
            uint8 maxIndex = p->GetMostPointsTalentTree();
            if ((p->getClass() == CLASS_PALADIN && maxIndex >= 1) || (p->getClass() == CLASS_SHAMAN && maxIndex == 1) || (p->getClass() == CLASS_DRUID && maxIndex == 1))
                return true;
            if (_removeHealers == ((p->getClass() == CLASS_DRUID && maxIndex == 2) || (p->getClass() == CLASS_PALADIN && maxIndex == 0) || (p->getClass() == CLASS_PRIEST && maxIndex <= 1) || (p->getClass() == CLASS_SHAMAN && maxIndex == 2)))
                return true;

            return false;
        }
        return true;
    }
private:
    bool _removeHealers;
};

class spell_sindragosa_unchained_magic : public SpellScriptLoader
{
    public:
        spell_sindragosa_unchained_magic() : SpellScriptLoader("spell_sindragosa_unchained_magic") { }

        class spell_sindragosa_unchained_magic_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sindragosa_unchained_magic_SpellScript);

            void FilterTargets(std::list<WorldObject*>& unitList)
            {
                std::list<WorldObject*> healList = unitList;
                std::list<WorldObject*> dpsList = unitList;
                unitList.clear();
                uint32 maxSize = uint32(GetCaster()->GetMap()->GetSpawnMode() & 1 ? 3 : 1);
                healList.remove_if(UnchainedMagicTargetSelector(false));
                if (healList.size() > maxSize)
                    acore::Containers::RandomResizeList(healList, maxSize);
                dpsList.remove_if(UnchainedMagicTargetSelector(true));
                if (dpsList.size() > maxSize)
                    acore::Containers::RandomResizeList(dpsList, maxSize);
                unitList.splice(unitList.begin(), healList);
                unitList.splice(unitList.begin(), dpsList);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_unchained_magic_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sindragosa_unchained_magic_SpellScript();
        }

        class spell_sindragosa_unchained_magic_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sindragosa_unchained_magic_AuraScript);

            std::map<uint32, uint32> _lastMSTimeForSpell;

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                _lastMSTimeForSpell.clear();
                return true;
            }

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                const SpellInfo* spellInfo = eventInfo.GetDamageInfo()->GetSpellInfo();
                if (!spellInfo)
                    return false;

                uint32 currMSTime = World::GetGameTimeMS();
                std::map<uint32, uint32>::iterator itr = _lastMSTimeForSpell.find(spellInfo->Id);
                if (itr != _lastMSTimeForSpell.end())
                {
                    uint32 lastMSTime = itr->second;
                    itr->second = currMSTime;
                    if (getMSTimeDiff(lastMSTime, currMSTime) < 600)
                        return false;

                    return true;
                }

                _lastMSTimeForSpell[spellInfo->Id] = currMSTime;
                return true;
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_sindragosa_unchained_magic_AuraScript::CheckProc);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sindragosa_unchained_magic_AuraScript();
        }
};

class spell_sindragosa_permeating_chill : public SpellScriptLoader
{
    public:
        spell_sindragosa_permeating_chill() : SpellScriptLoader("spell_sindragosa_permeating_chill") { }

        class spell_sindragosa_permeating_chill_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sindragosa_permeating_chill_AuraScript);

            bool CheckProc(ProcEventInfo& eventInfo)
            {
                return eventInfo.GetProcTarget() && eventInfo.GetProcTarget()->GetEntry() == NPC_SINDRAGOSA;
            }

            void Register()
            {
                DoCheckProc += AuraCheckProcFn(spell_sindragosa_permeating_chill_AuraScript::CheckProc);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sindragosa_permeating_chill_AuraScript();
        }
};

class spell_sindragosa_instability : public SpellScriptLoader
{
    public:
        spell_sindragosa_instability() : SpellScriptLoader("spell_sindragosa_instability") { }

        class spell_sindragosa_instability_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sindragosa_instability_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_BACKLASH))
                    return false;
                return true;
            }

            void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
                    GetTarget()->CastCustomSpell(SPELL_BACKLASH, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), GetTarget(), true, NULL, aurEff, GetCasterGUID());
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_sindragosa_instability_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sindragosa_instability_AuraScript();
        }
};

class spell_sindragosa_icy_grip : public SpellScriptLoader
{
    public:
        spell_sindragosa_icy_grip() : SpellScriptLoader("spell_sindragosa_icy_grip") { }

        class spell_sindragosa_icy_grip_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sindragosa_icy_grip_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_ICY_GRIP_JUMP))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (!GetHitUnit()->IsWithinLOSInMap(GetCaster()) || GetHitUnit()->HasAura(SPELL_TANK_MARKER_AURA))
                    return;

                GetHitUnit()->CastSpell(GetCaster(), SPELL_ICY_GRIP_JUMP, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_sindragosa_icy_grip_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sindragosa_icy_grip_SpellScript();
        }
};

class spell_sindragosa_icy_grip_jump : public SpellScriptLoader
{
    public:
        spell_sindragosa_icy_grip_jump() : SpellScriptLoader("spell_sindragosa_icy_grip_jump") { }

        class spell_sindragosa_icy_grip_jump_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sindragosa_icy_grip_jump_SpellScript);

            void HandleSpecial(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                float x = GetHitUnit()->GetPositionX();
                float y = GetHitUnit()->GetPositionY();
                float z = GetHitUnit()->GetPositionZ()+0.1f;
                float speedXY, speedZ;

                if (GetSpellInfo()->Effects[effIndex].MiscValue)
                    speedZ = float(GetSpellInfo()->Effects[effIndex].MiscValue)/10;
                else if (GetSpellInfo()->Effects[effIndex].MiscValueB)
                    speedZ = float(GetSpellInfo()->Effects[effIndex].MiscValueB)/10;
                else
                    speedZ = 10.0f;
                speedXY = GetCaster()->GetExactDist2d(x, y) * 10.0f / speedZ;

                GetCaster()->GetMotionMaster()->MoveJump(x, y, z, speedXY, speedZ);
            }

            void Register()
            {
                OnEffectLaunchTarget += SpellEffectFn(spell_sindragosa_icy_grip_jump_SpellScript::HandleSpecial, EFFECT_0, SPELL_EFFECT_JUMP);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sindragosa_icy_grip_jump_SpellScript();
        }
};

class spell_sindragosa_frost_beacon : public SpellScriptLoader
{
    public:
        spell_sindragosa_frost_beacon() : SpellScriptLoader("spell_sindragosa_frost_beacon") { }

        class spell_sindragosa_frost_beacon_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sindragosa_frost_beacon_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_ICE_TOMB_DAMAGE))
                    return false;
                return true;
            }

            void PeriodicTick(AuraEffect const* /*aurEff*/)
            {
                PreventDefaultAction();
                if (Unit* caster = GetCaster())
                    caster->CastSpell(GetTarget(), SPELL_ICE_TOMB_DAMAGE, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_sindragosa_frost_beacon_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sindragosa_frost_beacon_AuraScript();
        }
};

class SindragosaIceTombCheck
{
    public:
        bool operator()(Unit* unit) const
        {
            return unit->HasAura(SPELL_FROST_IMBUED_BLADE) || unit->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_ALL);
        }

        bool operator()(WorldObject* object) const
        {
            return object->ToUnit() && (object->ToUnit()->HasAura(SPELL_FROST_IMBUED_BLADE) || object->ToUnit()->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_ALL));
        }
};

class spell_sindragosa_ice_tomb_filter : public SpellScriptLoader
{
    public:
        spell_sindragosa_ice_tomb_filter() : SpellScriptLoader("spell_sindragosa_ice_tomb_filter") { }

        class spell_sindragosa_ice_tomb_filter_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sindragosa_ice_tomb_filter_SpellScript);

            void FilterTargets(std::list<WorldObject*>& unitList)
            {
                unitList.remove_if(SindragosaIceTombCheck());
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_ice_tomb_filter_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sindragosa_ice_tomb_filter_SpellScript();
        }
};

class spell_sindragosa_ice_tomb : public SpellScriptLoader
{
    public:
        spell_sindragosa_ice_tomb() : SpellScriptLoader("spell_sindragosa_ice_tomb_trap") { }

        class spell_sindragosa_ice_tomb_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sindragosa_ice_tomb_SpellScript);

            std::list<WorldObject*> targetList;

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sObjectMgr->GetCreatureTemplate(NPC_ICE_TOMB))
                    return false;
                if (!sObjectMgr->GetGameObjectTemplate(GO_ICE_BLOCK))
                    return false;
                return true;
            }

            void FilterTargets(std::list<WorldObject*>& unitList)
            {
                unitList.remove_if(acore::UnitAuraCheck(true, GetSpellInfo()->Id));
                targetList.clear();
                targetList = unitList;
            }

            void FilterTargetsSubseq(std::list<WorldObject*>& unitList)
            {
                unitList.clear();
                unitList = targetList;
            }


            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_ice_tomb_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENEMY);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_ice_tomb_SpellScript::FilterTargetsSubseq, EFFECT_2, TARGET_UNIT_DEST_AREA_ENEMY);
            }
        };

        class spell_sindragosa_ice_tomb_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sindragosa_ice_tomb_AuraScript);

            void PeriodicTick(AuraEffect const* /*aurEff*/)
            {
                PreventDefaultAction();
            }

            void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* c = GetCaster())
                    GetTarget()->m_Events.AddEvent(new IceTombSummonEvent(GetTarget(), c->GetGUID()), GetTarget()->m_Events.CalculateTime(500));
            }

            void ExtraRemoveEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetTarget()->RemoveAurasDueToSpell(SPELL_ASPHYXIATION);
                GetTarget()->RemoveAurasDueToSpell(SPELL_ICE_TOMB_UNTARGETABLE);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_sindragosa_ice_tomb_AuraScript::PeriodicTick, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_sindragosa_ice_tomb_AuraScript::ExtraRemoveEffect, EFFECT_1, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
                AfterEffectApply += AuraEffectApplyFn(spell_sindragosa_ice_tomb_AuraScript::AfterApply, EFFECT_1, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sindragosa_ice_tomb_SpellScript();
        }

        AuraScript* GetAuraScript() const
        {
            return new spell_sindragosa_ice_tomb_AuraScript();
        }
};

class MysticBuffetTargetFilter
{
    public:
        explicit MysticBuffetTargetFilter(Unit* caster) : _caster(caster) { }

        bool operator()(WorldObject* unit) const
        {    
            if (!unit->IsInMap(_caster))
                return true;

            // for standard creatures check full LOS
            if (Creature* c = unit->ToCreature())
                if (!c->IsPet() && c->GetDBTableGUIDLow())
                    return !_caster->IsWithinLOSInMap(unit);

            // for players and pets check only dynamic los (ice block gameobjects)
            float ox, oy, oz;
            _caster->GetPosition(ox, oy, oz);
            DynamicMapTree const& dTree = unit->GetMap()->GetDynamicMapTree();
            return !dTree.isInLineOfSight(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ()+2.f, ox, oy, oz+2.f, unit->GetPhaseMask());
        }

    private:
        Unit* _caster;
};

class spell_sindragosa_mystic_buffet : public SpellScriptLoader
{
    public:
        spell_sindragosa_mystic_buffet() : SpellScriptLoader("spell_sindragosa_mystic_buffet") { }

        class spell_sindragosa_mystic_buffet_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sindragosa_mystic_buffet_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(MysticBuffetTargetFilter(GetCaster()));
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_mystic_buffet_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sindragosa_mystic_buffet_SpellScript();
        }
};

class spell_sindragosa_soul_preservation : public SpellScriptLoader
{
    public:
        spell_sindragosa_soul_preservation() : SpellScriptLoader("spell_sindragosa_soul_preservation") { }

        class spell_sindragosa_soul_preservation_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_sindragosa_soul_preservation_AuraScript);

            void PeriodicTick(AuraEffect const*  /*aurEff*/)
            {
                PreventDefaultAction();
                if (Unit* s = GetTarget())
                    if (GetStackAmount() >= (s->GetMap()->Is25ManRaid() ? 75 : 30))
                    {
                        s->CastSpell(s, 72466, true);
                        s->RemoveAurasDueToSpell(72424);
                        if (s->GetTypeId() == TYPEID_UNIT) s->ToCreature()->SetLootMode(3);
                        SetDuration(1);
                    }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_sindragosa_soul_preservation_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_sindragosa_soul_preservation_AuraScript();
        }
};

class achievement_all_you_can_eat : public AchievementCriteriaScript
{
    public:
        achievement_all_you_can_eat() : AchievementCriteriaScript("achievement_all_you_can_eat") { }

        bool OnCheck(Player* /*source*/, Unit* target)
        {
            if (!target || target->GetEntry() != NPC_SINDRAGOSA)
                return false;
            return target->GetAI()->GetData(DATA_MYSTIC_BUFFET_STACK) <= 5;
        }
};



class npc_spinestalker : public CreatureScript
{
    public:
        npc_spinestalker() : CreatureScript("npc_spinestalker") { }

        struct npc_spinestalkerAI : public ScriptedAI
        {
            npc_spinestalkerAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()), _summoned(false)
            {
            }

            void InitializeAI()
            {
                if (!me->isDead())
                {
                    _instance->SetData(DATA_SINDRAGOSA_FROSTWYRMS, me->GetDBTableGUIDLow());  // this cannot be in Reset because reset also happens on evade
                    Reset();
                }
            }

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_BELLOWING_ROAR, urand(20000, 25000));
                _events.ScheduleEvent(EVENT_CLEAVE_SPINESTALKER, urand(10000, 15000));
                _events.ScheduleEvent(EVENT_TAIL_SWEEP, urand(8000, 12000));
                me->SetReactState(REACT_DEFENSIVE);

                if (!_summoned)
                {
                    me->SetCanFly(true);
                    me->SetDisableGravity(true);
                    me->SetHover(true);
                }
            }

            void JustReachedHome()
            {
                ScriptedAI::JustReachedHome();
                if (_summoned)
                {
                    me->SetCanFly(false);
                    me->SetDisableGravity(false);
                    me->SetHover(false);
                }
            }

            void JustRespawned()
            {
                ScriptedAI::JustRespawned();
                _instance->SetData(DATA_SINDRAGOSA_FROSTWYRMS, me->GetDBTableGUIDLow());  // this cannot be in Reset because reset also happens on evade
            }

            void JustDied(Unit* /*killer*/)
            {
                _events.Reset();
            }

            void DoAction(int32 action)
            {
                if (action == ACTION_START_FROSTWYRM)
                {
                    if (_summoned)
                        return;

                    _summoned = true;
                    if (me->isDead())
                        return;

                    me->setActive(true);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                    float moveTime = me->GetExactDist(&SpinestalkerFlyPos) / (me->GetSpeed(MOVE_RUN) * 0.001f);
                    me->m_Events.AddEvent(new FrostwyrmLandEvent(*me, SpinestalkerLandPos), me->m_Events.CalculateTime(uint64(moveTime) + 250));
                    me->SetDefaultMovementType(IDLE_MOTION_TYPE);
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMoving();
                    me->GetMotionMaster()->MovePoint(POINT_FROSTWYRM_FLY_IN, SpinestalkerFlyPos);
                }
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type != EFFECT_MOTION_TYPE || point != POINT_FROSTWYRM_LAND)
                    return;

                me->setActive(false);
                me->SetCanFly(false);
                me->SetDisableGravity(false);
                me->SetHover(false);
                me->SetHomePosition(SpinestalkerLandPos);
                me->SetFacingTo(SpinestalkerLandPos.GetOrientation());
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_BELLOWING_ROAR:
                        me->CastSpell(me, SPELL_BELLOWING_ROAR, false);
                        _events.ScheduleEvent(EVENT_BELLOWING_ROAR, urand(25000, 30000));
                        break;
                    case EVENT_CLEAVE_SPINESTALKER:
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE_SPINESTALKER, false);
                        _events.ScheduleEvent(EVENT_CLEAVE_SPINESTALKER, urand(10000, 15000));
                        break;
                    case EVENT_TAIL_SWEEP:
                        me->CastSpell(me->GetVictim(), SPELL_TAIL_SWEEP, false);
                        _events.ScheduleEvent(EVENT_TAIL_SWEEP, urand(22000, 25000));
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
            bool _summoned;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_spinestalkerAI>(creature);
        }
};

class npc_rimefang : public CreatureScript
{
    public:
        npc_rimefang() : CreatureScript("npc_rimefang_icc") { }

        struct npc_rimefangAI : public ScriptedAI
        {
            npc_rimefangAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()), _summoned(false)
            {
            }

            void InitializeAI()
            {
                if (!me->isDead())
                {
                    _instance->SetData(DATA_SINDRAGOSA_FROSTWYRMS, me->GetDBTableGUIDLow());  // this cannot be in Reset because reset also happens on evade
                    Reset();
                }
            }

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_FROST_BREATH_RIMEFANG, urand(12000, 15000));
                _events.ScheduleEvent(EVENT_ICY_BLAST, urand(30000, 35000));
                me->SetReactState(REACT_DEFENSIVE);
                _icyBlastCounter = 0;

                if (!_summoned)
                {
                    me->SetCanFly(true);
                    me->SetDisableGravity(true);
                    me->SetHover(true);
                }
            }

            void JustReachedHome()
            {
                ScriptedAI::JustReachedHome();
                if (_summoned)
                {
                    me->SetCanFly(false);
                    me->SetDisableGravity(false);
                    me->SetHover(false);
                }
            }

            void JustRespawned()
            {
                ScriptedAI::JustRespawned();
                _instance->SetData(DATA_SINDRAGOSA_FROSTWYRMS, me->GetDBTableGUIDLow());  // this cannot be in Reset because reset also happens on evade
            }

            void JustDied(Unit* /*killer*/)
            {
                _events.Reset();
            }

            void DoAction(int32 action)
            {
                if (action == ACTION_START_FROSTWYRM)
                {
                    if (_summoned)
                        return;

                    _summoned = true;
                    if (me->isDead())
                        return;

                    me->setActive(true);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                    float moveTime = me->GetExactDist(&RimefangFlyPos) / (me->GetSpeed(MOVE_RUN) * 0.001f);
                    me->m_Events.AddEvent(new FrostwyrmLandEvent(*me, RimefangLandPos), me->m_Events.CalculateTime(uint64(moveTime) + 250));
                    me->SetDefaultMovementType(IDLE_MOTION_TYPE);
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMoving();
                    me->GetMotionMaster()->MovePoint(POINT_FROSTWYRM_FLY_IN, RimefangFlyPos);
                }
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type != EFFECT_MOTION_TYPE)
                    return;

                if (point == POINT_FROSTWYRM_LAND)
                {
                    me->setActive(false);
                    me->SetCanFly(false);
                    me->SetDisableGravity(false);
                    me->SetHover(false);
                    me->SetHomePosition(RimefangLandPos);
                    me->SetFacingTo(RimefangLandPos.GetOrientation());
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                }
                else if (point == POINT_LAND_GROUND)
                {
                    me->SetCanFly(false);
                    me->SetDisableGravity(false);
                    me->SetHover(false);
                    me->SetReactState(REACT_DEFENSIVE);
                    if (Unit* victim = me->SelectVictim())
                        AttackStart(victim);
                }
            }

            void EnterCombat(Unit* /*victim*/)
            {
                me->CastSpell(me, SPELL_FROST_AURA_RIMEFANG, true);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_FROST_BREATH_RIMEFANG:
                        if (!me->IsFlying())
                        {
                            me->CastSpell(me->GetVictim(), SPELL_FROST_BREATH, false);
                            _events.ScheduleEvent(EVENT_FROST_BREATH_RIMEFANG, urand(20000, 25000));
                        }
                        else
                            _events.ScheduleEvent(EVENT_FROST_BREATH_RIMEFANG, 5000);
                        break;
                    case EVENT_ICY_BLAST:
                    {
                        _icyBlastCounter = RAID_MODE<uint8>(5, 7, 6, 8);
                        me->SetReactState(REACT_PASSIVE);

                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        me->SendMeleeAttackStop(me->GetVictim());

                        me->AttackStop();
                        me->SetCanFly(true);
                        me->SetDisableGravity(true);
                        me->SetHover(true);
                        me->SendMovementFlagUpdate();
                        float floorZ = me->GetMap()->GetHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+2.0f);
                        float destZ;
                        if (floorZ > 190.0f) destZ = floorZ + 25.0f;
                        else destZ = me->GetPositionZ() + 25.0f;
                        me->GetMotionMaster()->MoveTakeoff(0, me->GetPositionX(), me->GetPositionY(), destZ, me->GetSpeed(MOVE_RUN));
                        float moveTime = fabs(destZ-me->GetPositionZ())/(me->GetSpeed(MOVE_RUN)*0.001f);
                        _events.ScheduleEvent(EVENT_ICY_BLAST, uint32(moveTime) + urand(60000, 70000));
                        _events.ScheduleEvent(EVENT_ICY_BLAST_CAST, uint32(moveTime) + 250);
                        break;
                    }
                    case EVENT_ICY_BLAST_CAST:
                        if (--_icyBlastCounter)
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                            {
                                me->SetFacingToObject(target);
                                me->CastSpell(target, SPELL_ICY_BLAST, false);
                            }
                            _events.ScheduleEvent(EVENT_ICY_BLAST_CAST, 3000);
                        }
                        else
                        {
                            float floorZ = me->GetMap()->GetHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+2.0f);
                            float destZ;
                            if (floorZ > 190.0f) destZ = floorZ;
                            else destZ = me->GetPositionZ() - 25.0f;
                            me->SendMeleeAttackStop(me->GetVictim());
                            me->GetMotionMaster()->MoveLand(POINT_LAND_GROUND, me->GetPositionX(), me->GetPositionY(), destZ, me->GetSpeed(MOVE_RUN));
                        }
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
            uint8 _icyBlastCounter;
            bool _summoned;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_rimefangAI>(creature);
        }
};

class spell_rimefang_icy_blast : public SpellScriptLoader
{
    public:
        spell_rimefang_icy_blast() : SpellScriptLoader("spell_rimefang_icy_blast") { }

        class spell_rimefang_icy_blast_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_rimefang_icy_blast_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_ICY_BLAST_AREA))
                    return false;
                return true;
            }

            void HandleTriggerMissile(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Position const* pos = GetExplTargetDest())
                    if (TempSummon* summon = GetCaster()->SummonCreature(NPC_ICY_BLAST, *pos, TEMPSUMMON_TIMED_DESPAWN, 40000))
                        summon->CastSpell(summon, SPELL_ICY_BLAST_AREA, true);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_rimefang_icy_blast_SpellScript::HandleTriggerMissile, EFFECT_1, SPELL_EFFECT_TRIGGER_MISSILE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_rimefang_icy_blast_SpellScript();
        }
};

class at_sindragosa_lair : public AreaTriggerScript
{
    public:
        at_sindragosa_lair() : AreaTriggerScript("at_sindragosa_lair") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (InstanceScript* instance = player->GetInstanceScript())
            {
                if (!instance->GetData(DATA_SPINESTALKER))
                    if (Creature* spinestalker = ObjectAccessor::GetCreature(*player, instance->GetData64(DATA_SPINESTALKER)))
                        spinestalker->AI()->DoAction(ACTION_START_FROSTWYRM);

                if (!instance->GetData(DATA_RIMEFANG))
                    if (Creature* rimefang = ObjectAccessor::GetCreature(*player, instance->GetData64(DATA_RIMEFANG)))
                        rimefang->AI()->DoAction(ACTION_START_FROSTWYRM);

                if (!instance->GetData(DATA_SINDRAGOSA_FROSTWYRMS) && !instance->GetData64(DATA_SINDRAGOSA) && instance->GetBossState(DATA_SINDRAGOSA) != DONE)
                {
                    if (instance->GetData(DATA_HAS_LIMITED_ATTEMPTS) && !instance->GetData(DATA_HEROIC_ATTEMPTS))
                        return true;

                    player->GetMap()->LoadGrid(SindragosaSpawnPos.GetPositionX(), SindragosaSpawnPos.GetPositionY());
                    if (Creature* sindragosa = player->GetMap()->SummonCreature(NPC_SINDRAGOSA, SindragosaSpawnPos))
                        sindragosa->AI()->DoAction(ACTION_START_FROSTWYRM);
                }
            }

            return true;
        }
};

/*** TRASH ***/

class npc_sindragosa_trash : public CreatureScript
{
    public:
        npc_sindragosa_trash() : CreatureScript("npc_sindragosa_trash") { }

        struct npc_sindragosa_trashAI : public ScriptedAI
        {
            npc_sindragosa_trashAI(Creature* creature) : ScriptedAI(creature)
            {
                _instance = creature->GetInstanceScript();
            }

            void InitializeAI()
            {
                _frostwyrmId = (me->GetHomePosition().GetPositionY() < 2484.35f) ? DATA_RIMEFANG : DATA_SPINESTALKER;
                if (!me->isDead())
                {
                    if (me->GetEntry() == NPC_FROSTWING_WHELP)
                        _instance->SetData(_frostwyrmId, me->GetDBTableGUIDLow());  // this cannot be in Reset because reset also happens on evade
                    Reset();
                }
            }

            void Reset()
            {
                _isTaunted = false;
                _events.Reset();
                if (me->GetEntry() == NPC_FROSTWARDEN_HANDLER)
                {
                    _events.ScheduleEvent(EVENT_FROSTWARDEN_ORDER_WHELP, 3000);
                    _events.ScheduleEvent(EVENT_CONCUSSIVE_SHOCK, urand(8000, 10000));
                }
                else
                    _events.ScheduleEvent(EVENT_WHELP_FROST_BLAST, urand(3000, 6000));
            }

            void EnterCombat(Unit* who)
            {
                if (me->GetEntry() == NPC_FROSTWARDEN_HANDLER)
                {
                    std::list<Creature*> unitList;
                    GetCreatureListWithEntryInGrid(unitList, me, NPC_FROSTWING_WHELP, 40.0f);
                    for (std::list<Creature*>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                        if (!(*itr)->IsInCombat())
                            (*itr)->AI()->AttackStart(who);
                }
                else
                {
                    if (Creature* c = me->FindNearestCreature(NPC_FROSTWARDEN_HANDLER, 40.0f, true))
                        if (!c->IsInCombat())
                            c->AI()->AttackStart(who);
                    me->CallForHelp(15.0f);
                }
            }

            void JustRespawned()
            {
                ScriptedAI::JustRespawned();

                // Increase add count
                if (me->GetEntry() == NPC_FROSTWING_WHELP)
                    _instance->SetData(_frostwyrmId, me->GetDBTableGUIDLow());  // this cannot be in Reset because reset also happens on evade
            }

            void SetData(uint32 type, uint32 data)
            {
                if (type == DATA_WHELP_MARKER)
                    _isTaunted = data != 0;
            }

            uint32 GetData(uint32 type) const
            {
                if (type == DATA_FROSTWYRM_OWNER)
                    return _frostwyrmId;
                else if (type == DATA_WHELP_MARKER)
                    return uint32(_isTaunted);
                return 0;
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_FROSTWARDEN_ORDER_WHELP:
                        me->CastSpell(me, SPELL_ORDER_WHELP, false);
                        _events.ScheduleEvent(EVENT_FROSTWARDEN_ORDER_WHELP, 3000);
                        break;
                    case EVENT_CONCUSSIVE_SHOCK:
                        me->CastSpell(me, SPELL_CONCUSSIVE_SHOCK, false);
                        _events.ScheduleEvent(EVENT_CONCUSSIVE_SHOCK, urand(10000, 13000));
                        break;
                    case EVENT_WHELP_FROST_BLAST:
                        me->CastSpell(me->GetVictim(), 71361, false);
                        _events.ScheduleEvent(EVENT_WHELP_FROST_BLAST, urand(5000,8000));
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
            uint32 _frostwyrmId;
            bool _isTaunted; // Frostwing Whelp only
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_sindragosa_trashAI>(creature);
        }
};

class OrderWhelpTargetSelector
{
    public:
        explicit OrderWhelpTargetSelector(Creature* owner) : _owner(owner) { }

        bool operator()(Creature* creature)
        {
            if (!creature->AI()->GetData(DATA_WHELP_MARKER) && creature->AI()->GetData(DATA_FROSTWYRM_OWNER) == _owner->AI()->GetData(DATA_FROSTWYRM_OWNER))
                return false;
            return true;
        }

    private:
        Creature* _owner;
};

class spell_frostwarden_handler_order_whelp : public SpellScriptLoader
{
    public:
        spell_frostwarden_handler_order_whelp() : SpellScriptLoader("spell_frostwarden_handler_order_whelp") { }

        class spell_frostwarden_handler_order_whelp_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_frostwarden_handler_order_whelp_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_FOCUS_FIRE))
                    return false;
                return true;
            }

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
                if (targets.empty())
                    return;

                WorldObject* target = acore::Containers::SelectRandomContainerElement(targets);
                targets.clear();
                targets.push_back(target);
            }

            void HandleForcedCast(SpellEffIndex effIndex)
            {
                // caster is Frostwarden Handler, target is player, caster of triggered is whelp
                PreventHitDefaultEffect(effIndex);
                std::list<Creature*> unitList;
                GetCreatureListWithEntryInGrid(unitList, GetCaster(), NPC_FROSTWING_WHELP, 150.0f);
                if (Creature* creature = GetCaster()->ToCreature())
                    unitList.remove_if(OrderWhelpTargetSelector(creature));

                if (unitList.empty())
                    return;

                acore::Containers::SelectRandomContainerElement(unitList)->CastSpell(GetHitUnit(), uint32(GetEffectValue()), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_frostwarden_handler_order_whelp_SpellScript::HandleForcedCast, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_frostwarden_handler_order_whelp_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_frostwarden_handler_order_whelp_SpellScript();
        }
};

class spell_frostwarden_handler_focus_fire : public SpellScriptLoader
{
    public:
        spell_frostwarden_handler_focus_fire() : SpellScriptLoader("spell_frostwarden_handler_focus_fire") { }

        class spell_frostwarden_handler_focus_fire_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_frostwarden_handler_focus_fire_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetCaster()->AddThreat(GetHitUnit(), float(GetEffectValue()));
                GetCaster()->GetAI()->SetData(DATA_WHELP_MARKER, 1);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_frostwarden_handler_focus_fire_SpellScript::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        class spell_frostwarden_handler_focus_fire_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_frostwarden_handler_focus_fire_AuraScript);

            void PeriodicTick(AuraEffect const* /*aurEff*/)
            {
                PreventDefaultAction();
                if (Unit* caster = GetCaster())
                {
                    caster->AddThreat(GetTarget(), -float(GetSpellInfo()->Effects[EFFECT_1].CalcValue()));
                    caster->GetAI()->SetData(DATA_WHELP_MARKER, 0);
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_frostwarden_handler_focus_fire_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_frostwarden_handler_focus_fire_SpellScript();
        }

        AuraScript* GetAuraScript() const
        {
            return new spell_frostwarden_handler_focus_fire_AuraScript();
        }
};

class spell_sindragosa_frost_breath : public SpellScriptLoader
{
    public:
        spell_sindragosa_frost_breath() : SpellScriptLoader("spell_sindragosa_frost_breath") { }

        class spell_sindragosa_frost_breath_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_sindragosa_frost_breath_SpellScript);

            void HandleInfusion()
            {
                Player* target = GetHitPlayer();
                if (!target)
                    return;

                // Check difficulty and quest status
                if (!(target->GetRaidDifficulty() & RAID_DIFFICULTY_MASK_25MAN) || target->GetQuestStatus(QUEST_FROST_INFUSION) != QUEST_STATUS_INCOMPLETE)
                    return;

                // Check if player has Shadow's Edge equipped and not ready for infusion
                if (!target->HasAura(SPELL_UNSATED_CRAVING) || target->HasAura(SPELL_FROST_IMBUED_BLADE))
                    return;

                Aura* infusion = target->GetAura(SPELL_FROST_INFUSION, target->GetGUID());
                if (infusion && infusion->GetStackAmount() >= 3)
                {
                    target->RemoveAura(infusion);
                    target->CastSpell(target, SPELL_FROST_IMBUED_BLADE, TRIGGERED_FULL_MASK);
                }
                else
                    target->CastSpell(target, SPELL_FROST_INFUSION, TRIGGERED_FULL_MASK);
            }

            void Register()
            {
                AfterHit += SpellHitFn(spell_sindragosa_frost_breath_SpellScript::HandleInfusion);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_sindragosa_frost_breath_SpellScript();
        }
};

void AddSC_boss_sindragosa()
{
    new boss_sindragosa();
    new npc_ice_tomb();
    new spell_sindragosa_s_fury();
    new spell_sindragosa_unchained_magic();
    new spell_sindragosa_permeating_chill();
    new spell_sindragosa_instability();
    new spell_sindragosa_icy_grip();
    new spell_sindragosa_icy_grip_jump();
    new spell_sindragosa_ice_tomb_filter();
    new spell_trigger_spell_from_caster("spell_sindragosa_ice_tomb", SPELL_ICE_TOMB_DUMMY);
    new spell_trigger_spell_from_caster("spell_sindragosa_ice_tomb_dummy", SPELL_FROST_BEACON);
    new spell_sindragosa_frost_beacon();
    new spell_sindragosa_ice_tomb();
    new spell_sindragosa_mystic_buffet();
    new spell_sindragosa_soul_preservation();
    new achievement_all_you_can_eat();

    new npc_spinestalker();
    new npc_rimefang();
    new spell_rimefang_icy_blast();
    new at_sindragosa_lair();

    new npc_sindragosa_trash();
    new spell_frostwarden_handler_order_whelp();
    new spell_frostwarden_handler_focus_fire();

    new spell_sindragosa_frost_breath();
}
