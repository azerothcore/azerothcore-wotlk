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
#include "Cell.h"
#include "CellImpl.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScriptLoader.h"
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
               creature->GetSpawnId() && !creature->IsInCombat();
    }
};

struct ManaVoidSelector
{
public:
    explicit ManaVoidSelector(WorldObject const* source) : _source(source) { }

    bool operator()(Unit* unit) const
    {
        return unit->getPowerType() == POWER_MANA && _source->GetDistance(unit) > 15.0f;
    }

private:
    WorldObject const* _source;
};

class DelayedCastEvent : public BasicEvent
{
public:
    DelayedCastEvent(Creature* trigger, uint32 spellId, ObjectGuid originalCaster, uint32 despawnTime) : _trigger(trigger), _originalCaster(originalCaster), _spellId(spellId), _despawnTime(despawnTime)
    {
    }

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        _trigger->CastSpell(_trigger, _spellId, false, nullptr, nullptr, _originalCaster);
        if (_despawnTime)
            _trigger->DespawnOrUnsummon(_despawnTime);
        return true;
    }

private:
    Creature* _trigger;
    ObjectGuid _originalCaster;
    uint32 _spellId;
    uint32 _despawnTime;
};

class AuraRemoveEvent : public BasicEvent
{
public:
    AuraRemoveEvent(Creature* trigger, uint32 spellId) : _trigger(trigger), _spellId(spellId)
    {
    }

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
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

    bool Execute(uint64 /*currTime*/, uint32 /*diff*/) override
    {
        Acore::CreatureWorker<ValithriaDespawner> worker(_creature, *this);
        Cell::VisitGridObjects(_creature, worker, 333.0f);
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
                if (!creature->GetSpawnId())
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
        }

        void Reset() override
        {
            _events.Reset();
            me->SetHealth(me->GetMaxHealth() * 0.5f); // starts at 50% health
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

        void AttackStart(Unit* /*target*/) override {}
        void MoveInLineOfSight(Unit* /*who*/) override {}

        void DoAction(int32 action) override
        {
            if (action != ACTION_ENTER_COMBAT)
                return;

            _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me);
            _events.Reset();
            _events.ScheduleEvent(EVENT_INTRO_TALK, 15s);
            _events.ScheduleEvent(EVENT_DREAM_PORTAL, 45s, 48s);
            if (IsHeroic())
                _events.ScheduleEvent(EVENT_BERSERK, 7min);
        }

        void HealReceived(Unit* healer, uint32& heal) override
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
                me->CastSpell((Unit*)nullptr, SPELL_DREAMWALKERS_RAGE, false);
                _events.Reset();
                _events.ScheduleEvent(EVENT_DREAM_SLIP, 3500ms);
                _instance->SetBossState(DATA_VALITHRIA_DREAMWALKER, DONE);

                if (Creature* trigger = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_VALITHRIA_TRIGGER)))
                    trigger->AI()->EnterEvadeMode();
                if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_VALITHRIA_LICH_KING)))
                    lichKing->AI()->Reset();
            }
            else if (!_over75PercentTalkDone && me->HealthAbovePctHealed(75, heal))
            {
                _over75PercentTalkDone = true;
                Talk(SAY_VALITHRIA_75_PERCENT);
            }
            else if (_instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) == NOT_STARTED)
            {
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_VALITHRIA_TRIGGER)))
                {
                    trigger->AI()->DoAction(ACTION_ENTER_COMBAT);
                    _instance->SetBossState(DATA_VALITHRIA_DREAMWALKER, IN_PROGRESS);
                }
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
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
                        if (Creature* trigger = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_VALITHRIA_TRIGGER)))
                            trigger->AI()->EnterEvadeMode();
                    }
                }
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_DREAM_SLIP)
            {
                me->CastSpell(me, SPELL_CLEAR_ALL, true);
                me->CastSpell(me, SPELL_AWARD_REPUTATION_BOSS_KILL, true);
                // this display id was found in sniff instead of the one on aura
                me->SetDisplayId(11686);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->DespawnOrUnsummon(4000);
                if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_VALITHRIA_LICH_KING)))
                    lichKing->CastSpell(lichKing, SPELL_SPAWN_CHEST, false);
                _instance->SetData(DATA_WEEKLY_QUEST_ID, 0); // show hidden npc if necessary
            }
        }

        void JustSummoned(Creature* summon) override
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

        void SummonedCreatureDespawn(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_DREAM_PORTAL || summon->GetEntry() == NPC_NIGHTMARE_PORTAL)
                if (summon->AI()->GetData(MISSED_PORTALS))
                    ++_missedPortals;
        }

        void UpdateAI(uint32 diff) override
        {
            // does not enter combat
            if (_instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) == NOT_STARTED)
            {
                uint32 startingHealth = me->GetMaxHealth() * 0.5f;
                if (me->GetHealth() != startingHealth) // healing when boss cannot be engaged (lower spire not finished, cheating) doesn't start the fight, prevent winning this way
                    me->SetHealth(startingHealth);
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
                    _events.ScheduleEvent(EVENT_DREAM_PORTAL, 45s, 48s);
                    break;
                case EVENT_DREAM_SLIP:
                    me->CastSpell(me, SPELL_DREAM_SLIP, false);
                    break;
                default:
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == MISSED_PORTALS)
                return _missedPortals;

            return 0;
        }

    private:
        EventMap _events;
        InstanceScript* _instance;
        uint32 const _portalCount;
        uint32 _missedPortals;
        bool _under25PercentTalkDone;
        bool _over75PercentTalkDone;
        bool _justDied;
        bool _done;
    };

    CreatureAI* GetAI(Creature* creature) const override
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

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
            if (instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) != DONE)
                instance->SetBossState(DATA_VALITHRIA_DREAMWALKER, NOT_STARTED);
            me->SetReactState(REACT_PASSIVE);
            checkTimer = 5000;
        }

        void JustEngagedWith(Unit* target) override
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
            if (Creature* valithria = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_VALITHRIA_DREAMWALKER)))
                valithria->AI()->DoAction(ACTION_ENTER_COMBAT);
            if (Creature* lichKing = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_VALITHRIA_LICH_KING)))
                lichKing->AI()->DoAction(ACTION_ENTER_COMBAT);

            std::list<Creature*> archmages;
            RisenArchmageCheck check;
            Acore::CreatureListSearcher<RisenArchmageCheck> searcher(me, archmages, check);
            Cell::VisitGridObjects(me, searcher, 100.0f);
            for (std::list<Creature*>::iterator itr = archmages.begin(); itr != archmages.end(); ++itr)
                (*itr)->AI()->DoAction(ACTION_ENTER_COMBAT);
        }

        void AttackStart(Unit* target) override
        {
            if (target->IsPlayer())
                BossAI::AttackStart(target);
        }

        void EnterEvadeMode(EvadeReason why = EVADE_REASON_OTHER) override
        {
            CreatureAI::EnterEvadeMode(why);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        bool CanAIAttack(Unit const* target) const override
        {
            return target->IsPlayer();
        }

        void JustReachedHome() override
        {
            if (instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) != DONE)
                DoAction(ACTION_DEATH); // setActive(false) in ValithriaDespawner
            else
                _JustReachedHome();
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_DEATH)
                me->m_Events.AddEvent(new ValithriaDespawner(me), me->m_Events.CalculateTime(5000));
            else if (action == ACTION_ENTER_COMBAT)
            {
                if (!me->IsInCombat())
                    me->SetInCombatWithZone();
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->IsInCombat())
                return;

            if (checkTimer <= diff)
            {
                checkTimer = 3000;
                me->SetInCombatWithZone();
                ThreatContainer::StorageType const& threatList = me->GetThreatMgr().GetThreatList();
                if (!threatList.empty())
                    for (ThreatContainer::StorageType::const_iterator itr = threatList.begin(); itr != threatList.end(); ++itr)
                        if (Unit* target = (*itr)->getTarget())
                            if (target->IsAlive() && target->IsPlayer() && me->GetExactDist(target) < 200.0f && !target->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_ALL))
                                return;
                EnterEvadeMode();
            }
            else
                checkTimer -= diff;
        }

    private:
        uint16 checkTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
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

        void Reset() override
        {
            _events.Reset();
            me->RemoveAllAuras();
            me->CombatStop();
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_ENTER_COMBAT)
            {
                Talk(SAY_LICH_KING_INTRO);
                _events.Reset();
                _events.ScheduleEvent(EVENT_GLUTTONOUS_ABOMINATION_SUMMONER, 5s);
                _events.ScheduleEvent(EVENT_SUPPRESSER_SUMMONER, 10s);
                _events.ScheduleEvent(EVENT_BLISTERING_ZOMBIE_SUMMONER, 15s);
                _events.ScheduleEvent(EVENT_RISEN_ARCHMAGE_SUMMONER, 20s);
                _events.ScheduleEvent(EVENT_BLAZING_SKELETON_SUMMONER, 30s);
            }
        }

        void AttackStart(Unit* /*who*/) override {}
        void MoveInLineOfSight(Unit* /*who*/) override {}

        void JustSummoned(Creature* summon) override
        {
            summon->SetPhaseMask((summon->GetPhaseMask() & ~0x10), true); // must not be in dream phase
            if (summon->GetEntry() != NPC_SUPPRESSER)
                if (Unit* target = SelectTargetFromPlayerList(200.0f))
                    summon->AI()->AttackStart(target);
        }

        void UpdateAI(uint32 diff) override
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

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_the_lich_king_controllerAI>(creature);
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

        bool CanAIAttack(Unit const* target) const override
        {
            return target->GetEntry() != NPC_VALITHRIA_DREAMWALKER;
        }

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_FROSTBOLT_VOLLEY, 5s, 15s);
            _events.ScheduleEvent(EVENT_MANA_VOID, 15s, 25s);
            _events.ScheduleEvent(EVENT_COLUMN_OF_FROST, 10s, 20s);
        }

        void JustEngagedWith(Unit* /*target*/) override
        {
            me->FinishSpell(CURRENT_CHANNELED_SPELL, false);
            me->SetInCombatWithZone();
            if (me->GetSpawnId())
                if (Creature* trigger = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_VALITHRIA_TRIGGER)))
                    trigger->AI()->DoAction(ACTION_ENTER_COMBAT);
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_ENTER_COMBAT && !me->IsInCombat())
                me->SetInCombatWithZone();
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_COLUMN_OF_FROST)
                summon->m_Events.AddEvent(new DelayedCastEvent(summon, SPELL_COLUMN_OF_FROST_DAMAGE, ObjectGuid::Empty, 8000), summon->m_Events.CalculateTime(2000));
            else if (summon->GetEntry() == NPC_MANA_VOID)
                summon->DespawnOrUnsummon(36000);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->IsInCombat())
                if (me->GetSpawnId())
                    if (!me->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
                        me->CastSpell(me, SPELL_CORRUPTION, true);

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
                        _events.ScheduleEvent(EVENT_FROSTBOLT_VOLLEY, 8s, 15s);
                        break;
                    case EVENT_MANA_VOID:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, ManaVoidSelector(me)))
                            me->CastSpell(target, SPELL_MANA_VOID, false);
                        _events.ScheduleEvent(EVENT_MANA_VOID, 20s, 25s);
                        break;
                    case EVENT_COLUMN_OF_FROST:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, -10.0f, true))
                            me->CastSpell(target, SPELL_COLUMN_OF_FROST, false);
                        _events.ScheduleEvent(EVENT_COLUMN_OF_FROST, 15s, 25s);
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

    CreatureAI* GetAI(Creature* creature) const override
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

        void OnSpellClick(Unit* /*clicker*/, bool& result) override
        {
            if (!result)
                return;

            _used = true;
            me->DespawnOrUnsummon();
        }

        uint32 GetData(uint32 type) const override
        {
            return (type == MISSED_PORTALS && _used) ? 0 : 1;
        }

    private:
        bool _used;
    };

    CreatureAI* GetAI(Creature* creature) const override
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

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_CHECK_PLAYER, 750ms);
            me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
            me->SetCorpseDelay(0);
            me->LoadCreaturesAddon(true);
        }

        void AttackStart(Unit*) override {}
        void MoveInLineOfSight(Unit*) override {}
        void EnterEvadeMode(EvadeReason /*why*/) override {}

        void UpdateAI(uint32 diff) override
        {
            if (_instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) != IN_PROGRESS)
                return;

            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case EVENT_CHECK_PLAYER:
                    if (me->SelectNearestPlayer(5.0f)) // also checks phase
                        _events.ScheduleEvent(EVENT_EXPLODE, 500ms);
                    else
                        _events.ScheduleEvent(EVENT_CHECK_PLAYER, 750ms);
                    break;
                case EVENT_EXPLODE:
                    me->StopMoving();
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                    // must use originalCaster the same for all clouds to allow stacking
                    me->CastSpell(me, EMERALD_VIGOR, false, nullptr, nullptr, _instance->GetGuidData(DATA_VALITHRIA_DREAMWALKER));
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

    CreatureAI* GetAI(Creature* creature) const override
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

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_FIREBALL, 2s, 4s);
            _events.ScheduleEvent(EVENT_LEY_WASTE, 15s, 20s);
        }

        void UpdateAI(uint32 diff) override
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
                    _events.ScheduleEvent(EVENT_FIREBALL, 2s, 4s);
                    break;
                case EVENT_LEY_WASTE:
                    me->CastSpell(me, SPELL_LEY_WASTE, false);
                    _events.ScheduleEvent(EVENT_LEY_WASTE, 15s, 20s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
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

        void AttackStart(Unit* who) override
        {
            if (who->GetEntry() == NPC_VALITHRIA_DREAMWALKER)
                ScriptedAI::AttackStart(who);
        }

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            if (Creature* valithria = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_VALITHRIA_DREAMWALKER)))
                AttackStart(valithria);
        }

        void UpdateAI(uint32  /*diff*/) override
        {
            if (!UpdateVictim())
                return;

            if (!me->GetVictim())
                if (Creature* valithria = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_VALITHRIA_DREAMWALKER)))
                    if (valithria->IsAlive())
                        AttackStart(valithria);

            if (!me->GetVictim() || me->GetVictim()->GetEntry() != NPC_VALITHRIA_DREAMWALKER)
                return;

            if (!me->HasUnitState(UNIT_STATE_CASTING) && !me->isMoving() && me->IsWithinMeleeRange(me->GetVictim()))
                me->CastSpell((Unit*)nullptr, SPELL_SUPPRESSION, false);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
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

        void DamageTaken(Unit*, uint32& dmg, DamageEffectType, SpellSchoolMask) override
        {
            if (dmg >= me->GetHealth())
            {
                dmg = me->GetHealth() - 1;
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

        void UpdateAI(uint32 diff) override
        {
            if (timer)
            {
                if (timer <= diff)
                {
                    timer = 0;
                    me->SetDisplayId(11686);
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
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

    CreatureAI* GetAI(Creature* creature) const override
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

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_GUT_SPRAY, 10s, 13s);
        }

        void JustSummoned(Creature* summon) override
        {
            if (me->GetInstanceScript() && me->GetInstanceScript()->GetBossState(DATA_VALITHRIA_DREAMWALKER) == DONE)
                summon->DespawnOrUnsummon(1);
            else if (Unit* target = SelectTargetFromPlayerList(200.0f))
                summon->AI()->AttackStart(target);
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->CastSpell(me, SPELL_ROT_WORM_SPAWNER, true);
        }

        void UpdateAI(uint32 diff) override
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
                    _events.ScheduleEvent(EVENT_GUT_SPRAY, 10s, 13s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gluttonous_abominationAI>(creature);
    }
};

class spell_dreamwalker_summon_portal : public SpellScript
{
    PrepareSpellScript(spell_dreamwalker_summon_portal);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* target = GetHitUnit();
        if (!target)
            return;

        uint32 spellId = (GetSpellInfo()->Id == 72224 ? 71301 : 71977); // spell implicit target replaced to TARGET_DEST_DEST
        float minDist = 20.0f;
        float maxDist = 30.0f;
        float dist = (maxDist - minDist) * rand_norm() + minDist;
        float startAngle = 3 * M_PI / 2;
        float maxAddAngle = ((target->GetMap()->GetSpawnMode() % 2) == 0 ? M_PI : 2 * M_PI);
        float angle = startAngle + rand_norm() * maxAddAngle;
        target->CastSpell(target->GetPositionX() + cos(angle)*dist, target->GetPositionY() + std::sin(angle)*dist, target->GetPositionZ(), spellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_dreamwalker_summon_portal::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_dreamwalker_twisted_nightmares : public SpellScript
{
    PrepareSpellScript(spell_dreamwalker_twisted_nightmares);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (!GetHitUnit())
            return;

        if (InstanceScript* instance = GetHitUnit()->GetInstanceScript())
            GetHitUnit()->CastSpell((Unit*)nullptr, GetSpellInfo()->Effects[effIndex].TriggerSpell, true, nullptr, nullptr, instance->GetGuidData(DATA_VALITHRIA_DREAMWALKER));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_dreamwalker_twisted_nightmares::HandleScript, EFFECT_2, SPELL_EFFECT_FORCE_CAST);
    }
};

class spell_dreamwalker_nightmare_cloud_aura : public AuraScript
{
    PrepareAuraScript(spell_dreamwalker_nightmare_cloud_aura);

    bool Load() override
    {
        _instance = GetOwner()->GetInstanceScript();
        return _instance != nullptr;
    }

    void PeriodicTick(AuraEffect const* /*aurEff*/)
    {
        if (_instance->GetBossState(DATA_VALITHRIA_DREAMWALKER) != IN_PROGRESS)
            PreventDefaultAction();
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_dreamwalker_nightmare_cloud_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }

private:
    InstanceScript* _instance;
};

class spell_dreamwalker_mana_void_aura : public AuraScript
{
    PrepareAuraScript(spell_dreamwalker_mana_void_aura);

    void PeriodicTick(AuraEffect const* aurEff)
    {
        // first 3 ticks have amplitude 1 second
        // remaining tick every 500ms
        if (aurEff->GetTickNumber() <= 5)
            if (!(aurEff->GetTickNumber() & 1))
                PreventDefaultAction();
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_dreamwalker_mana_void_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_dreamwalker_decay_periodic_timer_aura : public AuraScript
{
    PrepareAuraScript(spell_dreamwalker_decay_periodic_timer_aura);

    bool Load() override
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

    void Register() override
    {
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_dreamwalker_decay_periodic_timer_aura::DecayPeriodicTimer, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }

private:
    int32 _decayRate;
};

class spell_dreamwalker_summoner : public SpellScript
{
    PrepareSpellScript(spell_dreamwalker_summoner);

    bool Load() override
    {
        if (!GetCaster()->GetInstanceScript())
            return false;
        return true;
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::AllWorldObjectsInExactRange(GetCaster(), 250.0f, true));
        std::list<WorldObject*> list_copy = targets;
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_RECENTLY_SPAWNED));
        if (targets.empty())
        {
            if (list_copy.empty())
                return;
            targets = list_copy;
        }

        WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
        targets.clear();
        targets.push_back(target);
    }

    void HandleForceCast(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (!GetHitUnit())
            return;

        GetHitUnit()->CastSpell(GetCaster(), GetSpellInfo()->Effects[effIndex].TriggerSpell, true, nullptr, nullptr, GetCaster()->GetInstanceScript()->GetGuidData(DATA_VALITHRIA_LICH_KING));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dreamwalker_summoner::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_dreamwalker_summoner::HandleForceCast, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
    }
};

class spell_dreamwalker_summon_suppresser_aura : public AuraScript
{
    PrepareAuraScript(spell_dreamwalker_summon_suppresser_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_SUPPRESSER });
    }

    void PeriodicTick(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        Unit* caster = GetCaster();
        if (!caster)
            return;

        std::list<Creature*> summoners;
        caster->GetCreaturesWithEntryInRange(summoners, 200.0f, NPC_WORLD_TRIGGER);
        std::list<Creature*> list_copy = summoners;
        summoners.remove_if(Acore::UnitAuraCheck(true, SPELL_RECENTLY_SPAWNED));
        if (summoners.empty())
        {
            if (list_copy.empty())
                return;
            summoners = list_copy;
        }
        Acore::Containers::RandomResize(summoners, 2);

        for (uint32 i = 0; i < 3; ++i)
            caster->CastSpell(summoners.front(), SPELL_SUMMON_SUPPRESSER, true);
        for (uint32 i = 0; i < 3; ++i)
            caster->CastSpell(summoners.back(), SPELL_SUMMON_SUPPRESSER, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_dreamwalker_summon_suppresser_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_dreamwalker_summon_suppresser_effect : public SpellScript
{
    PrepareSpellScript(spell_dreamwalker_summon_suppresser_effect);

    bool Load() override
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

        GetHitUnit()->CastSpell(GetCaster(), GetSpellInfo()->Effects[effIndex].TriggerSpell, true, nullptr, nullptr, GetCaster()->GetInstanceScript()->GetGuidData(DATA_VALITHRIA_LICH_KING));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_dreamwalker_summon_suppresser_effect::HandleForceCast, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
    }
};

class spell_valithria_suppression_aura : public AuraScript
{
    PrepareAuraScript(spell_valithria_suppression_aura);

    void OnApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        const_cast<AuraEffect*>(aurEff)->SetAmount(0);

        Unit* target = GetTarget();
        Unit::AuraApplicationMap& aam = target->GetAppliedAuras();
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
        Unit::AuraApplicationMap& aam = target->GetAppliedAuras();
        Unit::AuraApplicationMapBounds range = aam.equal_range(GetSpellInfo()->Id);
        uint32 count = target->GetAuraCount(GetSpellInfo()->Id);

        if (range.first == range.second)
            return;

        for (Unit::AuraApplicationMap::const_iterator itr = range.first; itr != range.second; ++itr)
            if (itr->second->GetBase()->GetEffect(EFFECT_0)->GetAmount())
                itr->second->GetBase()->GetEffect(EFFECT_0)->SetAmount(0);

        range.first->second->GetBase()->GetEffect(EFFECT_0)->SetAmount(count * GetSpellInfo()->Effects[0].CalcValue());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_valithria_suppression_aura::OnApply, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        AfterEffectRemove += AuraEffectRemoveFn(spell_valithria_suppression_aura::OnRemove, EFFECT_0, SPELL_AURA_MOD_HEALING_PCT, AURA_EFFECT_HANDLE_REAL);
    }
};

class achievement_portal_jockey : public AchievementCriteriaScript
{
public:
    achievement_portal_jockey() : AchievementCriteriaScript("achievement_portal_jockey") { }

    bool OnCheck(Player* /*source*/, Unit* target, uint32 /*criteria_id*/) override
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

    RegisterSpellScript(spell_dreamwalker_summon_portal);
    RegisterSpellScript(spell_dreamwalker_twisted_nightmares);
    RegisterSpellScript(spell_dreamwalker_nightmare_cloud_aura);
    RegisterSpellScript(spell_dreamwalker_mana_void_aura);
    RegisterSpellScript(spell_dreamwalker_decay_periodic_timer_aura);
    RegisterSpellScript(spell_dreamwalker_summoner);
    RegisterSpellScript(spell_dreamwalker_summon_suppresser_aura);
    RegisterSpellScript(spell_dreamwalker_summon_suppresser_effect);
    RegisterSpellScript(spell_valithria_suppression_aura);

    new achievement_portal_jockey();
}
