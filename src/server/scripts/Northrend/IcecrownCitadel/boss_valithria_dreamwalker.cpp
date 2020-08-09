/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "icecrown_citadel.h"

enum Texts
{
    // The Lich King
    SAY_LICH_KING_INTRO         = 0,

    // Valithria Dreamwalker
    SAY_VALITHRIA_ENTER_COMBAT  = 0,
    SAY_VALITHRIA_DREAM_PORTAL  = 1,
    SAY_VALITHRIA_75_PERCENT    = 2,
    SAY_VALITHRIA_25_PERCENT    = 3,
    SAY_VALITHRIA_DEATH         = 4,
    SAY_VALITHRIA_PLAYER_DEATH  = 5,
    SAY_VALITHRIA_BERSERK       = 6,
    SAY_VALITHRIA_SUCCESS       = 7,
};

enum Spells
{
    // Valithria Dreamwalker
    SPELL_COPY_DAMAGE                   = 71948,
    SPELL_DREAM_PORTAL_VISUAL_PRE       = 71304,
    SPELL_NIGHTMARE_PORTAL_VISUAL_PRE   = 71986,
    SPELL_NIGHTMARE_CLOUD               = 71970,
    SPELL_NIGHTMARE_CLOUD_VISUAL        = 71939,
    SPELL_PRE_SUMMON_DREAM_PORTAL       = 72224,
    SPELL_PRE_SUMMON_NIGHTMARE_PORTAL   = 72480,
    SPELL_SUMMON_DREAM_PORTAL           = 71305,
    SPELL_SUMMON_NIGHTMARE_PORTAL       = 71987,
    SPELL_DREAMWALKERS_RAGE             = 71189,
    SPELL_DREAM_SLIP                    = 71196,
    SPELL_ACHIEVEMENT_CHECK             = 72706,
    SPELL_CLEAR_ALL                     = 71721,
    SPELL_AWARD_REPUTATION_BOSS_KILL    = 73843,
    SPELL_CORRUPTION_VALITHRIA          = 70904,

    // The Lich King
    SPELL_TIMER_GLUTTONOUS_ABOMINATION  = 70915,
    SPELL_TIMER_SUPPRESSER              = 70912,
    SPELL_TIMER_BLISTERING_ZOMBIE       = 70914,
    SPELL_TIMER_RISEN_ARCHMAGE          = 70916,
    SPELL_TIMER_BLAZING_SKELETON        = 70913,
    SPELL_SUMMON_SUPPRESSER             = 70936,
    SPELL_RECENTLY_SPAWNED              = 72954,
    SPELL_SPAWN_CHEST                   = 71207,

    // Risen Archmage
    SPELL_CORRUPTION                    = 70602,
    SPELL_FROSTBOLT_VOLLEY              = 70759,
    SPELL_MANA_VOID                     = 71179,
    SPELL_COLUMN_OF_FROST               = 70704,
    SPELL_COLUMN_OF_FROST_DAMAGE        = 70702,

    // Blazing Skeleton
    SPELL_FIREBALL                      = 70754,
    SPELL_LEY_WASTE                     = 69325,

    // Suppresser
    SPELL_SUPPRESSION                   = 70588,

    // Blistering Zombie
    SPELL_ACID_BURST                    = 70744,

    // Gluttonous Abomination
    SPELL_GUT_SPRAY                     = 70633,
    SPELL_ROT_WORM_SPAWNER              = 70675,

    // Dream Cloud
    SPELL_EMERALD_VIGOR                 = 70873,

    // Nightmare Cloud
    SPELL_TWISTED_NIGHTMARE             = 71941,
};

#define SUMMON_PORTAL RAID_MODE<uint32>(SPELL_PRE_SUMMON_DREAM_PORTAL, SPELL_PRE_SUMMON_DREAM_PORTAL, SPELL_PRE_SUMMON_NIGHTMARE_PORTAL, SPELL_PRE_SUMMON_NIGHTMARE_PORTAL)
#define EMERALD_VIGOR RAID_MODE<uint32>(SPELL_EMERALD_VIGOR, SPELL_EMERALD_VIGOR, SPELL_TWISTED_NIGHTMARE, SPELL_TWISTED_NIGHTMARE)

enum Events
{
    // Valithria Dreamwalker
    EVENT_INTRO_TALK                        = 1,
    EVENT_BERSERK                           = 2,
    EVENT_DREAM_PORTAL                      = 3,
    EVENT_DREAM_SLIP                        = 4,

    // The Lich King
    EVENT_GLUTTONOUS_ABOMINATION_SUMMONER   = 5,
    EVENT_SUPPRESSER_SUMMONER               = 6,
    EVENT_BLISTERING_ZOMBIE_SUMMONER        = 7,
    EVENT_RISEN_ARCHMAGE_SUMMONER           = 8,
    EVENT_BLAZING_SKELETON_SUMMONER         = 9,

    // Risen Archmage
    EVENT_FROSTBOLT_VOLLEY                  = 10,
    EVENT_MANA_VOID                         = 11,
    EVENT_COLUMN_OF_FROST                   = 12,

    // Blazing Skeleton
    EVENT_FIREBALL                          = 13,
    EVENT_LEY_WASTE                         = 14,

    // Suppresser
    EVENT_SUPPRESSION                       = 15,

    // Gluttonous Abomination
    EVENT_GUT_SPRAY                         = 16,

    // Dream Cloud
    // Nightmare Cloud
    EVENT_CHECK_PLAYER                      = 17,
    EVENT_EXPLODE                           = 18,
};

enum Actions
{
    ACTION_ENTER_COMBAT = 1,
    MISSED_PORTALS      = 2,
    ACTION_DEATH        = 3,
};

Position const ValithriaSpawnPos = {4210.813f, 2484.443f, 364.9558f, 0.01745329f};

class RisenArchmageCheck
{
    public:
        // look for all permanently spawned Risen Archmages that are not yet in combat
        bool operator()(Creature* creature)
        {
            return creature->IsAlive() && creature->GetEntry() == NPC_RISEN_ARCHMAGE &&
                creature->GetDBTableGUIDLow() && !creature->IsInCombat();
        }
};

struct ManaVoidSelector : public acore::unary_function<Unit*, bool>
{
        explicit ManaVoidSelector(WorldObject const* source) : _source(source) { }

        bool operator()(Unit* unit) const
        {
            return unit->getPowerType() == POWER_MANA && _source->GetDistance(unit) > 15.0f;
        }

        WorldObject const* _source;
};

class DelayedCastEvent : public BasicEvent
{
    public:
        DelayedCastEvent(Creature* trigger, uint32 spellId, uint64 originalCaster, uint32 despawnTime) : _trigger(trigger), _originalCaster(originalCaster), _spellId(spellId), _despawnTime(despawnTime)
        {
        }

        bool Execute(uint64 /*time*/, uint32 /*diff*/)
        {
            _trigger->CastSpell(_trigger, _spellId, false, nullptr, nullptr, _originalCaster);
            if (_despawnTime)
                _trigger->DespawnOrUnsummon(_despawnTime);
            return true;
        }

    private:
        Creature* _trigger;
        uint64 _originalCaster;
        uint32 _spellId;
        uint32 _despawnTime;
};

class AuraRemoveEvent : public BasicEvent
{
    public:
        AuraRemoveEvent(Creature* trigger, uint32 spellId) : _trigger(trigger), _spellId(spellId)
        {
        }

        bool Execute(uint64 /*time*/, uint32 /*diff*/)
        {
            _trigger->RemoveAurasDueToSpell(_spellId);
            return true;
        }

    private:
        Creature* _trigger;
        uint32 _spellId;
};

class ValithriaDespawner : public BasicEvent
{
    public:
        explicit ValithriaDespawner(Creature* creature) : _creature(creature)
        {
        }

        bool Execute(uint64 /*currTime*/, uint32 /*diff*/)
        {
            acore::CreatureWorker<ValithriaDespawner> worker(_creature, *this);
            _creature->VisitNearbyGridObject(333.0f, worker);
            _creature->AI()->Reset();
            _creature->setActive(false);
            return true;
        }

        void operator()(Creature* creature) const
        {
            switch (creature->GetEntry())
            {
                case NPC_VALITHRIA_DREAMWALKER:
                    if (InstanceScript* instance = creature->GetInstanceScript())
                        instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, creature);
                    break;
                case NPC_THE_LICH_KING_VALITHRIA:
                    if (creature->IsAlive())
                        creature->AI()->Reset();
                    return;
                case NPC_BLAZING_SKELETON:
                case NPC_SUPPRESSER:
                case NPC_BLISTERING_ZOMBIE:
                case NPC_GLUTTONOUS_ABOMINATION:
                case NPC_MANA_VOID:
                case NPC_COLUMN_OF_FROST:
                case NPC_ROT_WORM:
                    creature->DespawnOrUnsummon();
                    return;
                case NPC_RISEN_ARCHMAGE:
                    if (!creature->GetDBTableGUIDLow())
                    {
                        creature->DespawnOrUnsummon();
                        return;
                    }
                    break;
                default:
                    return;
            }

            uint32 corpseDelay = creature->GetCorpseDelay();
            uint32 respawnDelay = creature->GetRespawnDelay();
            creature->SetCorpseDelay(1);
            creature->SetRespawnDelay(10);

            if (CreatureData const* data = creature->GetCreatureData())
                creature->SetPosition(data->posX, data->posY, data->posZ, data->orientation);
            if (!creature->IsAlive())
            {
                creature->RemoveCorpse(false);
                creature->SetRespawnTime(11);
            }
            else
                creature->DespawnOrUnsummon();

            creature->SetCorpseDelay(corpseDelay);
            creature->SetRespawnDelay(respawnDelay);
        }

    private:
        Creature* _creature;
};

class boss_valithria_dreamwalker : public CreatureScript
{
    public:
        boss_valithria_dreamwalker() : CreatureScript("boss_valithria_dreamwalker") { }

        struct boss_valithria_dreamwalkerAI : public ScriptedAI
        {
            boss_valithria_dreamwalkerAI(Creature* creature) : ScriptedAI(creature),
                _instance(creature->GetInstanceScript()), _portalCount(RAID_MODE<uint32>(3, 8, 3, 8))
            {
                me->SetReactState(REACT_PASSIVE);
                _spawnHealth = 1; // just in case if not set below
                if (CreatureData const* data = sObjectMgr->GetCreatureData(me->GetDBTableGUIDLow()))
                    if (data->curhealth)
                        _spawnHealth = data->curhealth;
            }

            void Reset()
            {
                _events.Reset();
                me->SetHealth(_spawnHealth);
                me->LoadCreaturesAddon(true);
                // immune to percent heals
                me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_OBS_MOD_HEALTH, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_HEAL_PCT, true);
                // Glyph of Dispel Magic - not a percent heal by effect, its cast with custom basepoints
                me->ApplySpellImmune(0, IMMUNITY_ID, 56131, true);
                _instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
                _missedPortals = 0;
                _under25PercentTalkDone = false;
                _over75PercentTalkDone = false;
                _justDied = false;
                _done = false;
            }

            void AttackStart(Unit* /*target*/) {}
            void MoveInLineOfSight(Unit* /*who*/) {}

            void DoAction(int32 action)
            {
                if (action != ACTION_ENTER_COMBAT)
                    return;

                _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me);
                _events.Reset();
                _events.ScheduleEvent(EVENT_INTRO_TALK, 15000);
                _events.ScheduleEvent(EVENT_DREAM_PORTAL, urand(45000, 48000));
                if (IsHeroic())
                    _events.ScheduleEvent(EVENT_BERSERK, 420000);
            }

            void HealReceived(Unit* healer, uint32& heal)
            {
                if (!me->hasLootRecipient())
                    me->SetLootRecipient(healer);
                me->LowerPlayerDamageReq(heal);

                // encounter complete
                if (me->HealthAbovePctHealed(100, heal) && !_done)
                {
                    _done = true;
                    Talk(SAY_VALITHRIA_SUCCESS);
                    _instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
                    _instance->DoRemoveAurasDueToSpellOnPlayers(70766);
                    me->RemoveAurasDueToSpell(SPELL_CORRUPTION_VALITHRIA);
                    me->CastSpell(me, SPELL_ACHIEVEMENT_CHECK, true);
                    me->CastSpell((Unit*)NULL, SPELL_DREAMWALKERS_RAGE, false);
                    _events.Reset();
                    _events.ScheduleEvent(EVENT_DREAM_SLIP, 3500);
                    _instance->SetBossState(DATA_VALITHRIA_DREAMWALKER, DONE);

                    if (Creature* trigger = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_VALITHRIA_TRIGGER)))
                        trigger->AI()->EnterEvadeMode();
                    if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_VALITHRIA_LICH_KING)))
                        lichKing->AI()->Reset();
                }
                else if (!_over75PercentTalkDone && me->HealthAbovePctHealed(75, heal))
                {
                    _over75PercentTalkDone = true;
                    Talk(SAY_VALITHRIA_75_PERCENT);
                }
                else if (_instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) == NOT_STARTED)
                    if (Creature* trigger = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_VALITHRIA_TRIGGER)))
                        trigger->AI()->DoAction(ACTION_ENTER_COMBAT);
            }

            void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (me->HealthBelowPctDamaged(25, damage))
                {
                    if (!_under25PercentTalkDone)
                    {
                        _under25PercentTalkDone = true;
                        Talk(SAY_VALITHRIA_25_PERCENT);
                    }

                    if (damage >= me->GetHealth())
                    {
                        damage = 0;
                        if (!_justDied)
                        {
                            _justDied = true;
                            Talk(SAY_VALITHRIA_DEATH);
                            _instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
                            if (Creature* trigger = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_VALITHRIA_TRIGGER)))
                                trigger->AI()->EnterEvadeMode();
                        }
                    }
                }
            }

            void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
            {
                if (spell->Id == SPELL_DREAM_SLIP)
                {
                    me->CastSpell(me, SPELL_CLEAR_ALL, true);
                    me->CastSpell(me, SPELL_AWARD_REPUTATION_BOSS_KILL, true);
                    // this display id was found in sniff instead of the one on aura
                    me->SetDisplayId(11686);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    me->DespawnOrUnsummon(4000);
                    if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_VALITHRIA_LICH_KING)))
                        lichKing->CastSpell(lichKing, SPELL_SPAWN_CHEST, false);
                    _instance->SetData(DATA_WEEKLY_QUEST_ID, 0); // show hidden npc if necessary
                }
            }

            void JustSummoned(Creature* summon)
            {
                if (summon->GetEntry() == NPC_DREAM_PORTAL_PRE_EFFECT)
                {
                    summon->m_Events.AddEvent(new DelayedCastEvent(summon, SPELL_SUMMON_DREAM_PORTAL, me->GetGUID(), 6000), summon->m_Events.CalculateTime(15000));
                    summon->m_Events.AddEvent(new AuraRemoveEvent(summon, SPELL_DREAM_PORTAL_VISUAL_PRE), summon->m_Events.CalculateTime(15000));
                }
                else if (summon->GetEntry() == NPC_NIGHTMARE_PORTAL_PRE_EFFECT)
                {
                    summon->m_Events.AddEvent(new DelayedCastEvent(summon, SPELL_SUMMON_NIGHTMARE_PORTAL, me->GetGUID(), 6000), summon->m_Events.CalculateTime(15000));
                    summon->m_Events.AddEvent(new AuraRemoveEvent(summon, SPELL_NIGHTMARE_PORTAL_VISUAL_PRE), summon->m_Events.CalculateTime(15000));
                }
            }

            void SummonedCreatureDespawn(Creature* summon)
            {
                if (summon->GetEntry() == NPC_DREAM_PORTAL || summon->GetEntry() == NPC_NIGHTMARE_PORTAL)
                    if (summon->AI()->GetData(MISSED_PORTALS))
                        ++_missedPortals;
            }

            void UpdateAI(uint32 diff)
            {
                // does not enter combat
                if (_instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) == NOT_STARTED)
                {
                    if (me->GetHealth() != _spawnHealth) // healing when boss cannot be engaged (lower spire not finished, cheating) doesn't start the fight, prevent winning this way
                        me->SetHealth(_spawnHealth);
                    return;
                }

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_INTRO_TALK:
                        Talk(SAY_VALITHRIA_ENTER_COMBAT);
                        break;
                    case EVENT_BERSERK:
                        Talk(SAY_VALITHRIA_BERSERK);
                        break;
                    case EVENT_DREAM_PORTAL:
                        if (!IsHeroic())
                            Talk(SAY_VALITHRIA_DREAM_PORTAL);
                        for (uint32 i = 0; i < _portalCount; ++i)
                            me->CastSpell(me, SUMMON_PORTAL, false);
                        _events.ScheduleEvent(EVENT_DREAM_PORTAL, urand(45000, 48000));
                        break;
                    case EVENT_DREAM_SLIP:
                        me->CastSpell(me, SPELL_DREAM_SLIP, false);
                        break;
                    default:
                        break;
                }
            }

            uint32 GetData(uint32 type) const
            {
                if (type == MISSED_PORTALS)
                    return _missedPortals;

                return 0;
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
            uint32 _spawnHealth;
            uint32 const _portalCount;
            uint32 _missedPortals;
            bool _under25PercentTalkDone;
            bool _over75PercentTalkDone;
            bool _justDied;
            bool _done;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_valithria_dreamwalkerAI>(creature);
        }
};

class npc_green_dragon_combat_trigger : public CreatureScript
{
    public:
        npc_green_dragon_combat_trigger() : CreatureScript("npc_green_dragon_combat_trigger") { }

        struct npc_green_dragon_combat_triggerAI : public BossAI
        {
            npc_green_dragon_combat_triggerAI(Creature* creature) : BossAI(creature, DATA_VALITHRIA_DREAMWALKER)
            {
            }

            void Reset()
            {
                events.Reset();
                summons.DespawnAll();
                if (instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) != DONE)
                    instance->SetBossState(DATA_VALITHRIA_DREAMWALKER, NOT_STARTED);
                me->SetReactState(REACT_PASSIVE);
                checkTimer = 5000;
            }

            void EnterCombat(Unit* target)
            {
                if (!instance->CheckRequiredBosses(DATA_VALITHRIA_DREAMWALKER, target->ToPlayer()))
                {
                    me->setActive(true);
                    EnterEvadeMode();
                    instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                    return;
                }
                if (instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) == DONE)
                {
                    me->CombatStop();
                    return;
                }

                me->setActive(true);
                me->SetInCombatWithZone();
                instance->SetBossState(DATA_VALITHRIA_DREAMWALKER, IN_PROGRESS);
                if (Creature* valithria = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_VALITHRIA_DREAMWALKER)))
                    valithria->AI()->DoAction(ACTION_ENTER_COMBAT);
                if (Creature* lichKing = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_VALITHRIA_LICH_KING)))
                    lichKing->AI()->DoAction(ACTION_ENTER_COMBAT);

                std::list<Creature*> archmages;
                RisenArchmageCheck check;
                acore::CreatureListSearcher<RisenArchmageCheck> searcher(me, archmages, check);
                me->VisitNearbyGridObject(100.0f, searcher);
                for (std::list<Creature*>::iterator itr = archmages.begin(); itr != archmages.end(); ++itr)
                    (*itr)->AI()->DoAction(ACTION_ENTER_COMBAT);
            }

            void AttackStart(Unit* target)
            {
                if (target->GetTypeId() == TYPEID_PLAYER)
                    BossAI::AttackStart(target);
            }

            void MoveInLineOfSight(Unit* /*who*/) {}

            bool CanAIAttack(Unit const* target) const
            {
                return target->GetTypeId() == TYPEID_PLAYER;
            }

            void JustReachedHome()
            {
                if (instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) != DONE)
                    DoAction(ACTION_DEATH); // setActive(false) in ValithriaDespawner
                else
                    _JustReachedHome();
            }

            void DoAction(int32 action)
            {
                if (action == ACTION_DEATH)
                    me->m_Events.AddEvent(new ValithriaDespawner(me), me->m_Events.CalculateTime(5000));
                else if (action == ACTION_ENTER_COMBAT)
                {
                    if (!me->IsInCombat())
                        me->SetInCombatWithZone();
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!me->IsInCombat())
                    return;

                if (checkTimer <= diff)
                {
                    checkTimer = 3000;
                    me->SetInCombatWithZone();
                    ThreatContainer::StorageType const& threatList = me->getThreatManager().getThreatList();
                    if (!threatList.empty())
                        for (ThreatContainer::StorageType::const_iterator itr = threatList.begin(); itr != threatList.end(); ++itr)
                            if (Unit* target = (*itr)->getTarget())
                                if (target->IsAlive() && target->GetTypeId() == TYPEID_PLAYER && me->GetExactDist(target) < 200.0f && !target->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_ALL))
                                    return;
                    EnterEvadeMode();
                }
                else
                    checkTimer -= diff;
            }

        private:
            uint16 checkTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_green_dragon_combat_triggerAI>(creature);
        }
};

class npc_the_lich_king_controller : public CreatureScript
{
    public:
        npc_the_lich_king_controller() : CreatureScript("npc_the_lich_king_controller") { }

        struct npc_the_lich_king_controllerAI : public ScriptedAI
        {
            npc_the_lich_king_controllerAI(Creature* creature) : ScriptedAI(creature),
                _instance(creature->GetInstanceScript())
            {
                me->SetReactState(REACT_PASSIVE);
            }

            void Reset()
            {
                _events.Reset();
                me->RemoveAllAuras();
                me->CombatStop();
            }

            void DoAction(int32 action)
            {
                if (action == ACTION_ENTER_COMBAT)
                {
                    Talk(SAY_LICH_KING_INTRO);
                    _events.Reset();
                    _events.ScheduleEvent(EVENT_GLUTTONOUS_ABOMINATION_SUMMONER, 5000);
                    _events.ScheduleEvent(EVENT_SUPPRESSER_SUMMONER, 10000);
                    _events.ScheduleEvent(EVENT_BLISTERING_ZOMBIE_SUMMONER, 15000);
                    _events.ScheduleEvent(EVENT_RISEN_ARCHMAGE_SUMMONER, 20000);
                    _events.ScheduleEvent(EVENT_BLAZING_SKELETON_SUMMONER, 30000);
                }
            }

            void AttackStart(Unit* /*who*/) {}
            void MoveInLineOfSight(Unit* /*who*/) {}

            void JustSummoned(Creature* summon)
            {
                summon->SetPhaseMask((summon->GetPhaseMask() & ~0x10), true); // must not be in dream phase
                if (summon->GetEntry() != NPC_SUPPRESSER)
                    if (Unit* target = SelectTargetFromPlayerList(200.0f))
                        summon->AI()->AttackStart(target);
            }

            void UpdateAI(uint32 diff)
            {
                // does not enter combat
                if (_instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) != IN_PROGRESS)
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_GLUTTONOUS_ABOMINATION_SUMMONER:
                        me->CastSpell(me, SPELL_TIMER_GLUTTONOUS_ABOMINATION, false);
                        break;
                    case EVENT_SUPPRESSER_SUMMONER:
                        me->CastSpell(me, SPELL_TIMER_SUPPRESSER, false);
                        break;
                    case EVENT_BLISTERING_ZOMBIE_SUMMONER:
                        me->CastSpell(me, SPELL_TIMER_BLISTERING_ZOMBIE, false);
                        break;
                    case EVENT_RISEN_ARCHMAGE_SUMMONER:
                        me->CastSpell(me, SPELL_TIMER_RISEN_ARCHMAGE, false);
                        break;
                    case EVENT_BLAZING_SKELETON_SUMMONER:
                        me->CastSpell(me, SPELL_TIMER_BLAZING_SKELETON, false);
                        break;
                    default:
                        break;
                }
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_the_lich_king_controllerAI(creature);
        }
};

class npc_risen_archmage : public CreatureScript
{
    public:
        npc_risen_archmage() : CreatureScript("npc_risen_archmage") { }

        struct npc_risen_archmageAI : public ScriptedAI
        {
            npc_risen_archmageAI(Creature* creature) : ScriptedAI(creature),
                _instance(creature->GetInstanceScript())
            {
            }

            bool CanAIAttack(Unit const* target) const
            {
                return target->GetEntry() != NPC_VALITHRIA_DREAMWALKER;
            }

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_FROSTBOLT_VOLLEY, urand(5000, 15000));
                _events.ScheduleEvent(EVENT_MANA_VOID, urand(15000, 25000));
                _events.ScheduleEvent(EVENT_COLUMN_OF_FROST, urand(10000, 20000));
            }

            void EnterCombat(Unit* /*target*/)
            {
                me->FinishSpell(CURRENT_CHANNELED_SPELL, false);
                me->SetInCombatWithZone();
                if (me->GetDBTableGUIDLow())
                    if (Creature* trigger = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_VALITHRIA_TRIGGER)))
                        trigger->AI()->DoAction(ACTION_ENTER_COMBAT);
            }

            void DoAction(int32 action)
            {
                if (action == ACTION_ENTER_COMBAT && !me->IsInCombat())
                    me->SetInCombatWithZone();
            }

            void JustSummoned(Creature* summon)
            {
                if (summon->GetEntry() == NPC_COLUMN_OF_FROST)
                    summon->m_Events.AddEvent(new DelayedCastEvent(summon, SPELL_COLUMN_OF_FROST_DAMAGE, 0, 8000), summon->m_Events.CalculateTime(2000));
                else if (summon->GetEntry() == NPC_MANA_VOID)
                    summon->DespawnOrUnsummon(36000);
            }

            void UpdateAI(uint32 diff)
            {
                if (!me->IsInCombat())
                    if (me->GetDBTableGUIDLow())
                        if (!me->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
                            me->CastSpell(me, SPELL_CORRUPTION, false);

                if (!UpdateVictim())
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_FROSTBOLT_VOLLEY:
                            me->CastSpell(me, SPELL_FROSTBOLT_VOLLEY, false);
                            _events.ScheduleEvent(EVENT_FROSTBOLT_VOLLEY, urand(8000, 15000));
                            break;
                        case EVENT_MANA_VOID:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, ManaVoidSelector(me)))
                                me->CastSpell(target, SPELL_MANA_VOID, false);
                            _events.ScheduleEvent(EVENT_MANA_VOID, urand(20000, 25000));
                            break;
                        case EVENT_COLUMN_OF_FROST:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, -10.0f, true))
                                me->CastSpell(target, SPELL_COLUMN_OF_FROST, false);
                            _events.ScheduleEvent(EVENT_COLUMN_OF_FROST, urand(15000, 25000));
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_risen_archmageAI>(creature);
        }
};

class npc_valithria_portal : public CreatureScript
{
    public:
        npc_valithria_portal() : CreatureScript("npc_valithria_portal") { }

        struct npc_valithria_portalAI : public NullCreatureAI
        {
            npc_valithria_portalAI(Creature* creature) : NullCreatureAI(creature), _used(false) {}

            void OnSpellClick(Unit* /*clicker*/, bool& result)
            {
                if (!result)
                    return;

                _used = true;
                me->DespawnOrUnsummon();
            }

            uint32 GetData(uint32 type) const
            {
                return (type == MISSED_PORTALS && _used) ? 0 : 1;
            }

        private:
            bool _used;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_valithria_portalAI>(creature);
        }
};

class npc_valithria_cloud : public CreatureScript
{
    public:
        npc_valithria_cloud() : CreatureScript("npc_valithria_cloud") { }

        struct npc_valithria_cloudAI : public ScriptedAI
        {
            npc_valithria_cloudAI(Creature* creature) : ScriptedAI(creature),
                _instance(creature->GetInstanceScript())
            {
            }

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_CHECK_PLAYER, 750);
                me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                me->SetCorpseDelay(0);
                me->LoadCreaturesAddon(true);
            }

            void AttackStart(Unit*) {}
            void MoveInLineOfSight(Unit*) {}
            void EnterEvadeMode() {}

            void UpdateAI(uint32 diff)
            {
                if (_instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) != IN_PROGRESS)
                    return;

                _events.Update(diff);

                switch (_events.ExecuteEvent())
                {
                    case EVENT_CHECK_PLAYER:
                        if (me->SelectNearestPlayer(5.0f)) // also checks phase
                            _events.ScheduleEvent(EVENT_EXPLODE, 500);
                        else
                            _events.ScheduleEvent(EVENT_CHECK_PLAYER, 750);
                        break;
                    case EVENT_EXPLODE:
                        me->StopMoving();
                        me->GetMotionMaster()->Clear(false);
                        me->GetMotionMaster()->MoveIdle();
                        // must use originalCaster the same for all clouds to allow stacking
                        me->CastSpell(me, EMERALD_VIGOR, false, nullptr, nullptr, _instance->GetData64(DATA_VALITHRIA_DREAMWALKER));
                        me->DespawnOrUnsummon(1000);
                        break;
                    default:
                        break;
                }
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_valithria_cloudAI>(creature);
        }
};

class npc_blazing_skeleton : public CreatureScript
{
    public:
        npc_blazing_skeleton() : CreatureScript("npc_blazing_skeleton") { }

        struct npc_blazing_skeletonAI : public ScriptedAI
        {
            npc_blazing_skeletonAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_FIREBALL, urand(2000, 4000));
                _events.ScheduleEvent(EVENT_LEY_WASTE, urand(15000, 20000));
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
                    case EVENT_FIREBALL:
                        if (!me->IsWithinMeleeRange(me->GetVictim()))
                            me->CastSpell(me->GetVictim(), SPELL_FIREBALL, false);
                        _events.ScheduleEvent(EVENT_FIREBALL, urand(2000, 4000));
                        break;
                    case EVENT_LEY_WASTE:
                        me->CastSpell(me, SPELL_LEY_WASTE, false);
                        _events.ScheduleEvent(EVENT_LEY_WASTE, urand(15000, 20000));
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_blazing_skeletonAI>(creature);
        }
};

class npc_suppresser : public CreatureScript
{
    public:
        npc_suppresser() : CreatureScript("npc_suppresser") { }

        struct npc_suppresserAI : public ScriptedAI
        {
            npc_suppresserAI(Creature* creature) : ScriptedAI(creature),
                _instance(creature->GetInstanceScript())
            {
                me->SetReactState(REACT_PASSIVE);
            }

            InstanceScript* const _instance;

            void AttackStart(Unit* who)
            {
                if (who->GetEntry() == NPC_VALITHRIA_DREAMWALKER)
                    ScriptedAI::AttackStart(who);
            }

            void IsSummonedBy(Unit* /*summoner*/)
            {
                if (Creature* valithria = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_VALITHRIA_DREAMWALKER)))
                    AttackStart(valithria);
            }

            void UpdateAI(uint32  /*diff*/)
            {
                if (!UpdateVictim())
                    return;

                if (!me->GetVictim())
                    if (Creature* valithria = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_VALITHRIA_DREAMWALKER)))
                        if (valithria->IsAlive())
                            AttackStart(valithria);

                if (!me->GetVictim() || me->GetVictim()->GetEntry() != NPC_VALITHRIA_DREAMWALKER)
                    return;

                if (!me->HasUnitState(UNIT_STATE_CASTING) && !me->isMoving() && me->IsWithinMeleeRange(me->GetVictim()))
                    me->CastSpell((Unit*)NULL, SPELL_SUPPRESSION, false);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_suppresserAI>(creature);
        }
};

class npc_blistering_zombie : public CreatureScript
{
    public:
        npc_blistering_zombie() : CreatureScript("npc_blistering_zombie") { }

        struct npc_blistering_zombieAI : public ScriptedAI
        {
            npc_blistering_zombieAI(Creature* creature) : ScriptedAI(creature)
            {
                timer = 0;
                casted = false;
            }

            uint16 timer;
            bool casted;

            void DamageTaken(Unit*, uint32 &dmg, DamageEffectType, SpellSchoolMask)
            {
                if (dmg >= me->GetHealth())
                {
                    dmg = me->GetHealth()-1;
                    if (!casted)
                    {
                        casted = true;
                        me->StopMoving();
                        me->GetMotionMaster()->Clear(false);
                        me->GetMotionMaster()->MoveIdle();
                        me->SetControlled(true, UNIT_STATE_ROOT);
                        me->CastSpell(me, SPELL_ACID_BURST, false);
                        timer = 750;
                    }
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (timer)
                {
                    if (timer <= diff)
                    {
                        timer = 0;
                        me->SetDisplayId(11686);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        me->DespawnOrUnsummon(2000);
                    }
                    else
                        timer -= diff;
                }

                if (casted)
                    return;

                if (!UpdateVictim())
                    return;

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_blistering_zombieAI>(creature);
        }
};

class npc_gluttonous_abomination : public CreatureScript
{
    public:
        npc_gluttonous_abomination() : CreatureScript("npc_gluttonous_abomination") { }

        struct npc_gluttonous_abominationAI : public ScriptedAI
        {
            npc_gluttonous_abominationAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_GUT_SPRAY, urand(10000, 13000));
            }

            void JustSummoned(Creature* summon)
            {
                if (me->GetInstanceScript() && me->GetInstanceScript()->GetBossState(DATA_VALITHRIA_DREAMWALKER) == DONE)
                    summon->DespawnOrUnsummon(1);
                else if (Unit* target = SelectTargetFromPlayerList(200.0f))
                    summon->AI()->AttackStart(target);
            }

            void JustDied(Unit* /*killer*/)
            {
                me->CastSpell(me, SPELL_ROT_WORM_SPAWNER, true);
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
                    case EVENT_GUT_SPRAY:
                        me->CastSpell(me, SPELL_GUT_SPRAY, false);
                        _events.ScheduleEvent(EVENT_GUT_SPRAY, urand(10000, 13000));
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_gluttonous_abominationAI>(creature);
        }
};

class spell_dreamwalker_summon_portal : public SpellScriptLoader
{
    public:
        spell_dreamwalker_summon_portal() : SpellScriptLoader("spell_dreamwalker_summon_portal") { }

        class spell_dreamwalker_summon_portal_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dreamwalker_summon_portal_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                Unit* target = GetHitUnit();
                if (!target)
                    return;

                uint32 spellId = (GetSpellInfo()->Id == 72224 ? 71301 : 71977); // spell implicit target replaced to TARGET_DEST_DEST
                float minDist = 20.0f;
                float maxDist = 30.0f;
                float dist = (maxDist-minDist)*rand_norm() + minDist;
                float startAngle = 3*M_PI/2;
                float maxAddAngle = ((target->GetMap()->GetSpawnMode()%2) == 0 ? M_PI : 2*M_PI);
                float angle = startAngle + rand_norm()*maxAddAngle;
                target->CastSpell(target->GetPositionX()+cos(angle)*dist, target->GetPositionY()+sin(angle)*dist, target->GetPositionZ(), spellId, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dreamwalker_summon_portal_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dreamwalker_summon_portal_SpellScript();
        }
};

class spell_dreamwalker_twisted_nightmares : public SpellScriptLoader
{
    public:
        spell_dreamwalker_twisted_nightmares() : SpellScriptLoader("spell_dreamwalker_twisted_nightmares") { }

        class spell_dreamwalker_twisted_nightmares_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dreamwalker_twisted_nightmares_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (!GetHitUnit())
                    return;

                if (InstanceScript* instance = GetHitUnit()->GetInstanceScript())
                    GetHitUnit()->CastSpell((Unit*)NULL, GetSpellInfo()->Effects[effIndex].TriggerSpell, true, nullptr, nullptr, instance->GetData64(DATA_VALITHRIA_DREAMWALKER));
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dreamwalker_twisted_nightmares_SpellScript::HandleScript, EFFECT_2, SPELL_EFFECT_FORCE_CAST);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dreamwalker_twisted_nightmares_SpellScript();
        }
};

class spell_dreamwalker_nightmare_cloud : public SpellScriptLoader
{
    public:
        spell_dreamwalker_nightmare_cloud() : SpellScriptLoader("spell_dreamwalker_nightmare_cloud") { }

        class spell_dreamwalker_nightmare_cloud_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dreamwalker_nightmare_cloud_AuraScript);

            bool Load()
            {
                _instance = GetOwner()->GetInstanceScript();
                return _instance != nullptr;
            }

            void PeriodicTick(AuraEffect const* /*aurEff*/)
            {
                if (_instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) != IN_PROGRESS)
                    PreventDefaultAction();
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_dreamwalker_nightmare_cloud_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }

            InstanceScript* _instance;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dreamwalker_nightmare_cloud_AuraScript();
        }
};

class spell_dreamwalker_mana_void : public SpellScriptLoader
{
    public:
        spell_dreamwalker_mana_void() : SpellScriptLoader("spell_dreamwalker_mana_void") { }

        class spell_dreamwalker_mana_void_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dreamwalker_mana_void_AuraScript);

            void PeriodicTick(AuraEffect const* aurEff)
            {
                // first 3 ticks have amplitude 1 second
                // remaining tick every 500ms
                if (aurEff->GetTickNumber() <= 5)
                    if (!(aurEff->GetTickNumber() & 1))
                        PreventDefaultAction();
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_dreamwalker_mana_void_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dreamwalker_mana_void_AuraScript();
        }
};

class spell_dreamwalker_decay_periodic_timer : public SpellScriptLoader
{
    public:
        spell_dreamwalker_decay_periodic_timer() : SpellScriptLoader("spell_dreamwalker_decay_periodic_timer") { }

        class spell_dreamwalker_decay_periodic_timer_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dreamwalker_decay_periodic_timer_AuraScript);

            bool Load()
            {
                _decayRate = GetId() != SPELL_TIMER_BLAZING_SKELETON ? 1000 : 5000;
                return true;
            }

            void DecayPeriodicTimer(AuraEffect* aurEff)
            {
                int32 timer = aurEff->GetPeriodicTimer();
                if (timer <= 5000)
                    return;

                aurEff->SetPeriodicTimer(timer - _decayRate);
            }

            void Register()
            {
                OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_dreamwalker_decay_periodic_timer_AuraScript::DecayPeriodicTimer, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }

            int32 _decayRate;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dreamwalker_decay_periodic_timer_AuraScript();
        }
};

class spell_dreamwalker_summoner : public SpellScriptLoader
{
    public:
        spell_dreamwalker_summoner() : SpellScriptLoader("spell_dreamwalker_summoner") { }

        class spell_dreamwalker_summoner_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dreamwalker_summoner_SpellScript);

            bool Load()
            {
                if (!GetCaster()->GetInstanceScript())
                    return false;
                return true;
            }

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(acore::AllWorldObjectsInExactRange(GetCaster(), 250.0f, true));
                std::list<WorldObject*> list_copy = targets;
                targets.remove_if(acore::UnitAuraCheck(true, SPELL_RECENTLY_SPAWNED));
                if (targets.empty())
                {
                    if (list_copy.empty())
                        return;
                    targets = list_copy;
                }

                WorldObject* target = acore::Containers::SelectRandomContainerElement(targets);
                targets.clear();
                targets.push_back(target);
            }

            void HandleForceCast(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (!GetHitUnit())
                    return;

                GetHitUnit()->CastSpell(GetCaster(), GetSpellInfo()->Effects[effIndex].TriggerSpell, true, nullptr, nullptr, GetCaster()->GetInstanceScript()->GetData64(DATA_VALITHRIA_LICH_KING));
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dreamwalker_summoner_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
                OnEffectHitTarget += SpellEffectFn(spell_dreamwalker_summoner_SpellScript::HandleForceCast, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dreamwalker_summoner_SpellScript();
        }
};

class spell_dreamwalker_summon_suppresser : public SpellScriptLoader
{
    public:
        spell_dreamwalker_summon_suppresser() : SpellScriptLoader("spell_dreamwalker_summon_suppresser") { }

        class spell_dreamwalker_summon_suppresser_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_dreamwalker_summon_suppresser_AuraScript);

            void PeriodicTick(AuraEffect const* /*aurEff*/)
            {
                PreventDefaultAction();
                Unit* caster = GetCaster();
                if (!caster)
                    return;

                std::list<Creature*> summoners;
                caster->GetCreaturesWithEntryInRange(summoners, 200.0f, NPC_WORLD_TRIGGER);
                std::list<Creature*> list_copy = summoners;
                summoners.remove_if(acore::UnitAuraCheck(true, SPELL_RECENTLY_SPAWNED));
                if (summoners.empty())
                {
                    if (list_copy.empty())
                        return;
                    summoners = list_copy;
                }
                acore::Containers::RandomResizeList(summoners, 2);

                for (uint32 i = 0; i < 3; ++i)
                    caster->CastSpell(summoners.front(), SPELL_SUMMON_SUPPRESSER, true);
                for (uint32 i = 0; i < 3; ++i)
                    caster->CastSpell(summoners.back(), SPELL_SUMMON_SUPPRESSER, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_dreamwalker_summon_suppresser_AuraScript::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_dreamwalker_summon_suppresser_AuraScript();
        }
};

class spell_dreamwalker_summon_suppresser_effect : public SpellScriptLoader
{
    public:
        spell_dreamwalker_summon_suppresser_effect() : SpellScriptLoader("spell_dreamwalker_summon_suppresser_effect") { }

        class spell_dreamwalker_summon_suppresser_effect_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_dreamwalker_summon_suppresser_effect_SpellScript);

            bool Load()
            {
                if (!GetCaster()->GetInstanceScript())
                    return false;
                return true;
            }

            void HandleForceCast(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (!GetHitUnit())
                    return;

                GetHitUnit()->CastSpell(GetCaster(), GetSpellInfo()->Effects[effIndex].TriggerSpell, true, nullptr, nullptr, GetCaster()->GetInstanceScript()->GetData64(DATA_VALITHRIA_LICH_KING));
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_dreamwalker_summon_suppresser_effect_SpellScript::HandleForceCast, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_dreamwalker_summon_suppresser_effect_SpellScript();
        }
};

class spell_valithria_suppression : public SpellScriptLoader
{
    public:
        spell_valithria_suppression() : SpellScriptLoader("spell_valithria_suppression") { }

        class spell_valithria_suppression_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_valithria_suppression_AuraScript);

            void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                const_cast<AuraEffect*>(aurEff)->SetAmount(0);

                Unit* target = GetTarget();
                Unit::AuraApplicationMap &aam = target->GetAppliedAuras();
                Unit::AuraApplicationMapBounds range = aam.equal_range(GetSpellInfo()->Id);
                uint32 count = target->GetAuraCount(GetSpellInfo()->Id);

                if (range.first == range.second)
                    return;

                for (Unit::AuraApplicationMap::const_iterator itr = range.first; itr != range.second; ++itr)
                    if (count == 1 || itr->second->GetBase()->GetEffect(EFFECT_0)->GetAmount())
                    {
                        itr->second->GetBase()->GetEffect(EFFECT_0)->SetAmount(count * GetSpellInfo()->Effects[0].CalcValue());
                        break;
                    }
            }

            void OnRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes  /*mode*/)
            {
                Unit* target = GetTarget();
                Unit::AuraApplicationMap &aam = target->GetAppliedAuras();
                Unit::AuraApplicationMapBounds range = aam.equal_range(GetSpellInfo()->Id);
                uint32 count = target->GetAuraCount(GetSpellInfo()->Id);

                if (range.first == range.second)
                    return;

                for (Unit::AuraApplicationMap::const_iterator itr = range.first; itr != range.second; ++itr)
                    if (itr->second->GetBase()->GetEffect(EFFECT_0)->GetAmount())
                        itr->second->GetBase()->GetEffect(EFFECT_0)->SetAmount(0);

                range.first->second->GetBase()->GetEffect(EFFECT_0)->SetAmount(count * GetSpellInfo()->Effects[0].CalcValue());
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_valithria_suppression_AuraScript::OnApply, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
                AfterEffectRemove += AuraEffectRemoveFn(spell_valithria_suppression_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_valithria_suppression_AuraScript();
        }
};

class achievement_portal_jockey : public AchievementCriteriaScript
{
    public:
        achievement_portal_jockey() : AchievementCriteriaScript("achievement_portal_jockey") { }

        bool OnCheck(Player* /*source*/, Unit* target)
        {
            return target && target->GetEntry() == NPC_VALITHRIA_DREAMWALKER && !target->GetAI()->GetData(MISSED_PORTALS);
        }
};

void AddSC_boss_valithria_dreamwalker()
{
    new boss_valithria_dreamwalker();
    new npc_green_dragon_combat_trigger();
    new npc_the_lich_king_controller();
    new npc_risen_archmage();
    new npc_valithria_portal();
    new npc_valithria_cloud();
    new npc_blazing_skeleton();
    new npc_suppresser();
    new npc_blistering_zombie();
    new npc_gluttonous_abomination();

    new spell_dreamwalker_summon_portal();
    new spell_dreamwalker_twisted_nightmares();
    new spell_dreamwalker_nightmare_cloud();
    new spell_dreamwalker_mana_void();
    new spell_dreamwalker_decay_periodic_timer();
    new spell_dreamwalker_summoner();
    new spell_dreamwalker_summon_suppresser();
    new spell_dreamwalker_summon_suppresser_effect();
    new spell_valithria_suppression();

    new achievement_portal_jockey();
}