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
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "ulduar.h"

enum FreyaSpells
{
    // LIFEBINDER
    SPELL_AUTO_GROW                             = 62559,
    SPELL_LIFEBINDER_PHERONOMES                 = 62619,
    SPELL_LIFEBINDER_VISUAL                     = 62579,
    SPELL_LIFEBINDER_HEAL_10                    = 62584,
    SPELL_LIFEBINDER_HEAL_25                    = 64185,

    // FREYA
    SPELL_TOUCH_OF_EONAR_10                     = 62528,
    SPELL_TOUCH_OF_EONAR_25                     = 62892,
    SPELL_ATTUNED_TO_NATURE                     = 62519,
    SPELL_SUMMON_LIFEBINDER                     = 62870,
    SPELL_SUNBEAM_10                            = 62623,
    SPELL_SUNBEAM_25                            = 62872,
    SPELL_NATURE_BOMB_FLIGHT                    = 64648,
    SPELL_NATURE_BOMB_DAMAGE_10                 = 64587,
    SPELL_NATURE_BOMB_DAMAGE_25                 = 64650,
    SPELL_GREEN_BANISH_STATE                    = 32567,
    SPELL_BERSERK                               = 47008,

    // HARD MODE
    SPELL_GROUND_TREMOR_FREYA_10                = 62437,
    SPELL_GROUND_TREMOR_FREYA_25                = 62859,
    SPELL_IRON_ROOTS_FREYA_10                   = 62862,
    SPELL_IRON_ROOTS_FREYA_25                   = 62439,
    SPELL_IRON_ROOTS_FREYA_DAMAGE_10            = 62861,
    SPELL_IRON_ROOTS_FREYA_DAMAGE_25            = 62438,
    SPELL_UNSTABLE_SUN_FREYA_DAMAGE_10          = 62451,
    SPELL_UNSTABLE_SUN_FREYA_DAMAGE_25          = 62865,
    SPELL_UNSTABLE_SUN_VISUAL                   = 62216,

    // ELDERS
    SPELL_DRAINED_OF_POWER                      = 62467,
    SPELL_STONEBARK_ESSENCE                     = 62483,
    SPELL_IRONBRANCH_ESSENCE                    = 62484,
    SPELL_BRIGHTLEAF_ESSENCE                    = 62485,

    // BRIGHTLEAF
    SPELL_BRIGHTLEAF_FLUX                       = 62239,
    SPELL_SOLAR_FLARE_10                        = 62240,
    SPELL_SOLAR_FLARE_25                        = 64087,
    SPELL_UNSTABLE_SUN_BEAM_AURA                = 62211,
    SPELL_PHOTOSYNTHESIS                        = 62209,
    SPELL_UNSTABLE_SUN_DAMAGE_10                = 62217,
    SPELL_UNSTABLE_SUN_DAMAGE_25                = 62922,

    // IRONBRANCH
    SPELL_IMPALE_10                             = 62310,
    SPELL_IMPALE_25                             = 62928,
    SPELL_IRON_ROOTS_10                         = 62275,
    SPELL_IRON_ROOTS_25                         = 62929,
    SPELL_IRON_ROOTS_DAMAGE_10                  = 62283,
    SPELL_IRON_ROOTS_DAMAGE_25                  = 62930,
    SPELL_THORN_SWARM_10                        = 62285,
    SPELL_THORN_SWARM_25                        = 62931,

    // STONEBARK
    SPELL_FISTS_OF_STONE                        = 62344,
    SPELL_GROUND_TREMOR_10                      = 62325,
    SPELL_GROUND_TREMOR_25                      = 62932,
    SPELL_PETRIFIED_BARK_10                     = 62337,
    SPELL_PETRIFIED_BARK_25                     = 62933,

    // SNAPLASHER
    SPELL_HARDENED_BARK_10                      = 62664,
    SPELL_HARDENED_BARK_25                      = 64191,

    // ANCIENT WATER SPIRIT
    SPELL_TIDAL_WAVE_10                         = 62653,
    SPELL_TIDAL_WAVE_25                         = 62935,
    SPELL_TIDAL_WAVE_DAMAGE_10                  = 62654,
    SPELL_TIDAL_WAVE_DAMAGE_25                  = 62936,
    SPELL_TIDAL_WAVE_AURA                       = 62655,

    // STORM LASHER
    SPELL_LIGHTNING_LASH_10                     = 62648,
    SPELL_LIGHTNING_LASH_25                     = 62939,
    SPELL_STORMBOLT_10                          = 62649,
    SPELL_STORMBOLT_25                          = 62938,

    // ANCIENT CONSERVATOR
    SPELL_CONSERVATOR_GRIP                      = 62532,
    SPELL_NATURE_FURY_10                        = 62589,
    SPELL_NATURE_FURY_25                        = 63571,
    SPELL_POTENT_PHEROMONES                     = 62541,
    SPELL_HEALTHY_SPORE_VISUAL                  = 62538,
    SPELL_HEALTHY_SPORE_SUMMON                  = 62566,

    // DETONATING LASHER
    SPELL_DETONATE_10                           = 62598,
    SPELL_DETONATE_25                           = 62937,
    SPELL_FLAME_LASH                            = 62608,

    // ACHIEVEMENT
    SPELL_DEFORESTATION_CREDIT                  = 65015,
};

#define SPELL_GROUND_TREMOR                     RAID_MODE(SPELL_GROUND_TREMOR_10, SPELL_GROUND_TREMOR_25)
#define SPELL_PETRIFIED_BARK                    RAID_MODE(SPELL_PETRIFIED_BARK_10, SPELL_PETRIFIED_BARK_25)
#define SPELL_IRON_ROOTS                        RAID_MODE(SPELL_IRON_ROOTS_10, SPELL_IRON_ROOTS_25)
#define SPELL_IMPALE                            RAID_MODE(SPELL_IMPALE_10, SPELL_IMPALE_25)
#define SPELL_THORN_SWARM                       RAID_MODE(SPELL_THORN_SWARM_10, SPELL_THORN_SWARM_25)
#define SPELL_UNSTABLE_SUN_DAMAGE               RAID_MODE(SPELL_UNSTABLE_SUN_DAMAGE_10, SPELL_UNSTABLE_SUN_DAMAGE_25)
#define SPELL_SOLAR_FLARE                       RAID_MODE(SPELL_SOLAR_FLARE_10, SPELL_SOLAR_FLARE_25)
#define SPELL_TOUCH_OF_EONAR                    RAID_MODE(SPELL_TOUCH_OF_EONAR_10, SPELL_TOUCH_OF_EONAR_25)
#define SPELL_LIFEBINDER_HEAL                   RAID_MODE(SPELL_LIFEBINDER_HEAL_10, SPELL_LIFEBINDER_HEAL_25)
#define SPELL_TIDAL_WAVE                        RAID_MODE(SPELL_TIDAL_WAVE_10, SPELL_TIDAL_WAVE_25)
#define SPELL_TIDAL_WAVE_DAMAGE                 RAID_MODE(SPELL_TIDAL_WAVE_DAMAGE_10, SPELL_TIDAL_WAVE_DAMAGE_25)
#define SPELL_NATURE_FURY                       RAID_MODE(SPELL_NATURE_FURY_10, SPELL_NATURE_FURY_25)
#define SPELL_HARDENED_BARK                     RAID_MODE(SPELL_HARDENED_BARK_10, SPELL_HARDENED_BARK_25)
#define SPELL_DETONATE                          RAID_MODE(SPELL_DETONATE_10, SPELL_DETONATE_25)
//#define SPELL_NATURE_BOMB_DAMAGE                RAID_MODE(SPELL_NATURE_BOMB_DAMAGE_10, SPELL_NATURE_BOMB_DAMAGE_25)
#define SPELL_SUNBEAM                           RAID_MODE(SPELL_SUNBEAM_10, SPELL_SUNBEAM_25)
#define SPELL_GROUND_TREMOR_FREYA               RAID_MODE(SPELL_GROUND_TREMOR_FREYA_10, SPELL_GROUND_TREMOR_FREYA_25)
#define SPELL_IRON_ROOTS_FREYA                  RAID_MODE(SPELL_IRON_ROOTS_FREYA_10, SPELL_IRON_ROOTS_FREYA_25)
#define SPELL_UNSTABLE_SUN_FREYA_DAMAGE         RAID_MODE(SPELL_UNSTABLE_SUN_FREYA_DAMAGE_10, SPELL_UNSTABLE_SUN_FREYA_DAMAGE_25)
#define SPELL_LIGHTNING_LASH                    RAID_MODE(SPELL_LIGHTNING_LASH_10, SPELL_LIGHTNING_LASH_25)
#define SPELL_STORMBOLT                         RAID_MODE(SPELL_STORMBOLT_10, SPELL_STORMBOLT_25)

enum FreyaEvents
{
    // FREYA
    EVENT_FREYA_ADDS_SPAM                       = 1,
    EVENT_FREYA_LIFEBINDER                      = 2,
    EVENT_FREYA_NATURE_BOMB                     = 3,
    EVENT_FREYA_SUNBEAM                         = 4,
    EVENT_FREYA_BERSERK                         = 5,
    // HARD MODE
    EVENT_FREYA_GROUND_TREMOR                   = 6,
    EVENT_FREYA_IRON_ROOT                       = 7,
    EVENT_FREYA_UNSTABLE_SUN_BEAM               = 8,
    EVENT_FREYA_RESPAWN_TRIO                    = 9,

    // STONEBARK
    EVENT_STONEBARK_FISTS_OF_STONE              = 10,
    EVENT_STONEBARK_GROUND_TREMOR               = 11,
    EVENT_STONEBARK_PETRIFIED_BARK              = 12,

    // BRIGHTLEAF
    EVENT_BRIGHTLEAF_FLUX                       = 20,
    EVENT_BRIGHTLEAF_SOLAR_FLARE                = 21,
    EVENT_BRIGHTLEAF_UNSTABLE_SUN_BEAM          = 22,
    EVENT_BRIGHTLEAF_DESPAWN_SUN_BEAM           = 23,

    // IRONBRANCH
    EVENT_IRONBRANCH_IMPALE                     = 30,
    EVENT_IRONBRANCH_IRON_ROOT                  = 31,
    EVENT_IRONBRANCH_THORN_SWARM                = 32,

    // SUMMONS
    EVENT_ANCIENT_CONSERVATOR_NATURE_FURY       = 40,
    EVENT_ANCIENT_CONSERVATOR_GRIP              = 41,
    EVENT_WATER_SPIRIT_CHARGE                   = 45,
    EVENT_WATER_SPIRIT_DAMAGE                   = 46,
    EVENT_STORM_LASHER_LIGHTNING_LASH           = 50,
    EVENT_STORM_LASHER_STORMBOLT                = 51,
    EVENT_DETONATING_LASHER_FLAME_LASH          = 55,
};

enum Texts
{
    // Elder Brightleaf / Elder Ironbranch / Elder Stonebark
    SAY_ELDER_AGGRO                              = 0,
    SAY_ELDER_SLAY                               = 1,
    SAY_ELDER_DEATH                              = 2,

    // Freya
    SAY_AGGRO                                    = 0,
    SAY_AGGRO_WITH_ELDER                         = 1,
    SAY_SLAY                                     = 2,
    SAY_DEATH                                    = 3,
    SAY_BERSERK                                  = 4,
    SAY_SUMMON_CONSERVATOR                       = 5,
    SAY_SUMMON_TRIO                              = 6,
    SAY_SUMMON_LASHERS                           = 7,
    EMOTE_LIFEBINDERS_GIFT                       = 8,
    EMOTE_ALLIES_OF_NATURE                       = 9,
    EMOTE_GROUND_TREMOR                          = 10,
    EMOTE_IRON_ROOTS                             = 11,
};

enum FreyaNPCs
{
    NPC_NATURE_BOMB                             = 34129,
    NPC_IRON_ROOT_TRIGGER                       = 33088,
    NPC_FREYA_UNSTABLE_SUN_BEAM                 = 33170,
    NPC_UNSTABLE_SUN_BRIGHTLEAF                 = 33050, // 10 SECS?

    // FIRST WAVE
    NPC_STORM_LASHER                            = 32919,
    NPC_ANCIENT_WATER_SPIRIT                    = 33202,
    NPC_SNAPLASHER                              = 32916,

    // SEC WAVE
    NPC_ANCIENT_CONSERVATOR                     = 33203,
    NPC_HEALTHY_SPORE                           = 33215,

    // THIRD WAVE
    NPC_DETONATING_LASHER                       = 32918,
};

enum Misc
{
    ACTION_REMOVE_10_STACK                      = 10,
    ACTION_REMOVE_25_STACK                      = 25,
    ACTION_REMOVE_2_STACK                       = 2,
    ACTION_RESPAWN_TRIO                         = 1,
    ACTION_LUMBERJACKED                         = -1,

    EVENT_PHASE_ADDS                            = 1,
    EVENT_PHASE_FINAL                           = 2,

    DATA_GET_ELDER_COUNT                        = 1,
    DATA_BACK_TO_NATURE                         = 2,

    CRITERIA_LUMBERJACKED                       = 21686,
};

class boss_freya : public CreatureScript
{
public:
    boss_freya() : CreatureScript("boss_freya") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_freyaAI>(pCreature);
    }

    struct boss_freyaAI : public ScriptedAI
    {
        boss_freyaAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            m_pInstance = pCreature->GetInstanceScript();
            if (!me->IsAlive())
                if (m_pInstance)
                    m_pInstance->SetData(TYPE_FREYA, DONE);
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;

        uint8 _waveNumber;
        uint8 _trioKilled;
        uint8 _spawnedAmount;
        uint8 _lumberjacked;
        bool _respawningTrio;
        bool _backToNature;
        uint8 _deforestation;

        ObjectGuid _elderGUID[3];

        void Reset() override
        {
            if (m_pInstance && m_pInstance->GetData(TYPE_FREYA) != DONE)
                m_pInstance->SetData(TYPE_FREYA, NOT_STARTED);

            events.Reset();
            summons.DespawnAll();

            for (uint8 i = 0; i < 3; ++i)
            {
                if (!_elderGUID[i])
                    continue;

                if (Creature* elder = ObjectAccessor::GetCreature(*me, _elderGUID[i]))
                    elder->AI()->EnterEvadeMode();

                _elderGUID[i].Clear();
            }

            _lumberjacked = 0;
            _spawnedAmount = 0;
            _trioKilled = 0;
            _waveNumber = urand(1, 3);
            _respawningTrio = false;
            _backToNature = true;
            _deforestation = 0;
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() != TYPEID_PLAYER || urand(0, 2))
                return;

            Talk(SAY_SLAY);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;
                if (m_pInstance->GetData(TYPE_FREYA) != DONE)
                {
                    Talk(SAY_DEATH);

                    me->SetReactState(REACT_PASSIVE);
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetFaction(FACTION_FRIENDLY);
                    me->RemoveAllAuras();
                    me->AttackStop();
                    events.Reset();

                    summons.DespawnAll();
                    events.Reset();

                    uint8 _elderCount = 0;
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        if (!_elderGUID[i])
                            continue;

                        if (Creature* e = ObjectAccessor::GetCreature(*me, _elderGUID[i]))
                            e->DespawnOrUnsummon();

                        ++_elderCount;
                    }

                    uint32 chestId = RAID_MODE(GO_FREYA_CHEST, GO_FREYA_CHEST_HERO);
                    chestId -= 2 * _elderCount; // offset

                    if (GameObject* go = me->SummonGameObject(chestId, 2345.61f, -71.20f, 425.104f, 3.0f, 0, 0, 0, 0, 0))
                    {
                        go->ReplaceAllGameObjectFlags((GameObjectFlags)0);
                        go->SetLootRecipient(me->GetMap());
                    }

                    // Defeat credit
                    if (m_pInstance)
                    {
                        me->CastSpell(me, 65074, true); // credit
                        m_pInstance->SetData(TYPE_FREYA, DONE);
                    }

                    scheduler.Schedule(14s, [this](TaskContext /*context*/)
                    {
                        DoCastSelf(SPELL_TELEPORT);
                    });
                }
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_TELEPORT)
            {
                me->DespawnOrUnsummon();
                m_pInstance->SetData(EVENT_KEEPER_TELEPORTED, DONE);
            }
        }

        void JustSummoned(Creature* cr) override
        {
            if (cr->GetEntry() == NPC_FREYA_UNSTABLE_SUN_BEAM)
            {
                cr->CastSpell(cr, SPELL_UNSTABLE_SUN_VISUAL, true);
                cr->CastSpell(cr, SPELL_UNSTABLE_SUN_FREYA_DAMAGE, true);
            }
            summons.Summon(cr);
        }

        void SpawnWave()
        {
            _waveNumber = _waveNumber == 1 ? 3 : _waveNumber - 1;
            Talk(EMOTE_ALLIES_OF_NATURE);

            // Wave of three
            if (_waveNumber == 1)
            {
                Talk(SAY_SUMMON_TRIO);
                me->SummonCreature(NPC_ANCIENT_WATER_SPIRIT, me->GetPositionX() + urand(5, 15), me->GetPositionY() + urand(5, 15), me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                me->SummonCreature(NPC_STORM_LASHER, me->GetPositionX() + urand(5, 15), me->GetPositionY() + urand(5, 15), me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                me->SummonCreature(NPC_SNAPLASHER, me->GetPositionX() + urand(5, 15), me->GetPositionY() + urand(5, 15), me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
            }
            // Ancient Conservator
            else if (_waveNumber == 2)
            {
                Talk(SAY_SUMMON_CONSERVATOR);
                me->SummonCreature(NPC_ANCIENT_CONSERVATOR, me->GetPositionX() + urand(5, 15), me->GetPositionY() + urand(5, 15), me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()), 0, TEMPSUMMON_CORPSE_DESPAWN);
            }
            // Detonating Lashers
            else if (_waveNumber == 3)
            {
                Talk(SAY_SUMMON_LASHERS);
                for (uint8 i = 0; i < 10; ++i)
                    me->SummonCreature(NPC_DETONATING_LASHER, me->GetPositionX() + urand(5, 20), me->GetPositionY() + urand(5, 20), me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()), 0, TEMPSUMMON_CORPSE_DESPAWN);
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_LUMBERJACKED)
            {
                if (!m_pInstance)
                    return;

                ++_lumberjacked;
                if (_lumberjacked == 1)
                    m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, CRITERIA_LUMBERJACKED);
                else if (_lumberjacked == 3)
                    m_pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 65296 /*SPELL_LUMBERJACKED*/, 0, me);
                return;
            }

            if (param == ACTION_RESPAWN_TRIO)
            {
                if (!_respawningTrio)
                {
                    _respawningTrio = true;
                    events.ScheduleEvent(EVENT_FREYA_RESPAWN_TRIO, 10s);
                }

                ++_trioKilled;
                return;
            }

            // Deforestation Achievement Counter
            if (param == ACTION_REMOVE_10_STACK)
            {
                ++_deforestation;
                if (_deforestation >= 6 && m_pInstance)
                    m_pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_DEFORESTATION_CREDIT, 0, me);
                // do not return
            }

            if (Aura* aur = me->GetAura(SPELL_ATTUNED_TO_NATURE))
            {
                // Back to Nature achievement
                if (aur->GetStackAmount() - param < 25)
                    _backToNature = false;

                if (aur->GetStackAmount() > param)
                    aur->SetStackAmount(aur->GetStackAmount() - param);
                else // Aura out of stack
                {
                    events.ScheduleEvent(EVENT_FREYA_NATURE_BOMB, 5s);
                    events.SetPhase(EVENT_PHASE_FINAL);
                    aur->Remove();
                    return;
                }
            }
        }

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_GET_ELDER_COUNT)
            {
                uint8 _count = 0;
                for (uint8 i = 0; i < 3; ++i)
                    if (_elderGUID[i])
                        ++_count;

                return _count;
            }
            if (param == DATA_BACK_TO_NATURE)
                return _backToNature;

            return 0;
        }

        void JustReachedHome() override { me->setActive(false); }

        void JustEngagedWith(Unit*) override
        {
            me->setActive(true);
            me->SetInCombatWithZone();
            me->CastSpell(me, SPELL_TOUCH_OF_EONAR, true);
            if (Aura* aur = me->AddAura(SPELL_ATTUNED_TO_NATURE, me))
                aur->SetStackAmount(150);

            events.ScheduleEvent(EVENT_FREYA_ADDS_SPAM, 10s, 0, EVENT_PHASE_ADDS);
            events.ScheduleEvent(EVENT_FREYA_LIFEBINDER, 30s);
            events.ScheduleEvent(EVENT_FREYA_SUNBEAM, 17s);
            events.ScheduleEvent(EVENT_FREYA_BERSERK, 10min);
            events.SetPhase(EVENT_PHASE_ADDS);

            if( !m_pInstance )
                return;

            if (m_pInstance->GetData(TYPE_FREYA) != DONE)
                m_pInstance->SetData(TYPE_FREYA, IN_PROGRESS);

            // HARD MODE CHECKS
            Creature* elder = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(NPC_ELDER_STONEBARK));
            if (elder && elder->IsAlive())
            {
                elder->CastSpell(elder, SPELL_DRAINED_OF_POWER, true);
                elder->CastSpell(elder, SPELL_STONEBARK_ESSENCE, true);
                elder->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_FREYA_GROUND_TREMOR, 35s);
                _elderGUID[0] = elder->GetGUID();
            }

            elder = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(NPC_ELDER_IRONBRANCH));
            if (elder && elder->IsAlive())
            {
                elder->CastSpell(elder, SPELL_DRAINED_OF_POWER, true);
                elder->CastSpell(elder, SPELL_IRONBRANCH_ESSENCE, true);
                elder->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_FREYA_IRON_ROOT, 20s);
                _elderGUID[1] = elder->GetGUID();
            }

            elder = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(NPC_ELDER_BRIGHTLEAF));
            if (elder && elder->IsAlive())
            {
                elder->CastSpell(elder, SPELL_DRAINED_OF_POWER, true);
                elder->CastSpell(elder, SPELL_BRIGHTLEAF_ESSENCE, true);
                elder->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_FREYA_UNSTABLE_SUN_BEAM, 1min);
                _elderGUID[2] = elder->GetGUID();
            }

            if (_elderGUID[0] || _elderGUID[1] || _elderGUID[2])
            {
                Talk(SAY_AGGRO_WITH_ELDER);
            }
            else
            {
                Talk(SAY_AGGRO);
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_NATURE_BOMB_FLIGHT)
                me->SummonCreature(NPC_NATURE_BOMB, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ());
        }

        void UpdateAI(uint32 diff) override
        {
            scheduler.Update(diff);
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_FREYA_ADDS_SPAM:
                    if (_spawnedAmount < 6)
                        SpawnWave();
                    else if (me->GetAura(SPELL_ATTUNED_TO_NATURE))
                    {
                        me->RemoveAura(SPELL_ATTUNED_TO_NATURE);
                        events.ScheduleEvent(EVENT_FREYA_NATURE_BOMB, 5s);
                        events.SetPhase(EVENT_PHASE_FINAL);
                        return;
                    }
                    _spawnedAmount++;
                    events.Repeat(1min);
                    break;
                case EVENT_FREYA_LIFEBINDER:
                    {
                        Talk(EMOTE_LIFEBINDERS_GIFT);
                        events.Repeat(45s);
                        float x, y, z;
                        for (uint8 i = 0; i < 10; ++i)
                        {
                            x = me->GetPositionX() + urand(7, 25);
                            y = me->GetPositionY() + urand(7, 25);
                            z = me->GetMapHeight(x, y, me->GetPositionZ());
                            if (me->IsWithinLOS(x, y, z))
                            {
                                me->CastSpell(x, y, z, SPELL_SUMMON_LIFEBINDER, true);
                                return;
                            }
                        }

                        me->CastSpell(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), SPELL_SUMMON_LIFEBINDER, true);
                        break;
                    }
                case EVENT_FREYA_SUNBEAM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                        me->CastSpell(target, SPELL_SUNBEAM, false);
                    events.Repeat(15s, 20s);
                    break;
                case EVENT_FREYA_RESPAWN_TRIO:
                    _deforestation = 0;
                    _respawningTrio = false;
                    if (_trioKilled < 3)
                        summons.DoAction(ACTION_RESPAWN_TRIO);

                    _trioKilled = 0;
                    break;
                case EVENT_FREYA_NATURE_BOMB:
                    {
                        uint8 _minCount = me->GetMap()->Is25ManRaid() ? urand(7, 10) : urand(3, 4);
                        Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                        for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                        {
                            if (me->GetDistance(itr->GetSource()) > 70 || !itr->GetSource()->IsAlive())
                                continue;

                            me->CastSpell(itr->GetSource(), SPELL_NATURE_BOMB_FLIGHT, true);

                            if (!(--_minCount))
                                break;
                        }
                        events.Repeat(18s);
                        break;
                    }
                case EVENT_FREYA_BERSERK:
                    Talk(SAY_BERSERK);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_FREYA_GROUND_TREMOR:
                    Talk(EMOTE_GROUND_TREMOR);
                    me->CastSpell(me, SPELL_GROUND_TREMOR_FREYA, false);
                    events.Repeat(25s, 35s);
                    break;
                case EVENT_FREYA_IRON_ROOT:
                    Talk(EMOTE_IRON_ROOTS);
                    me->CastCustomSpell(SPELL_IRON_ROOTS_FREYA, SPELLVALUE_MAX_TARGETS, 1, me, false);
                    events.Repeat(45s, 55s);
                    break;
                case EVENT_FREYA_UNSTABLE_SUN_BEAM:
                    me->SummonCreature(NPC_FREYA_UNSTABLE_SUN_BEAM, me->GetPositionX() + urand(7, 25), me->GetPositionY() + urand(7, 25), me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()), 0, TEMPSUMMON_TIMED_DESPAWN, 10000);
                    if (Is25ManRaid())
                    {
                        me->SummonCreature(NPC_FREYA_UNSTABLE_SUN_BEAM, me->GetPositionX() + urand(7, 25), me->GetPositionY() + urand(7, 25), me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()), 0, TEMPSUMMON_TIMED_DESPAWN, 10000);
                        me->SummonCreature(NPC_FREYA_UNSTABLE_SUN_BEAM, me->GetPositionX() + urand(7, 25), me->GetPositionY() + urand(7, 25), me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()), 0, TEMPSUMMON_TIMED_DESPAWN, 10000);
                    }
                    events.Repeat(38s, 48s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        bool CheckEvadeIfOutOfCombatArea() const override
        {
            return me->GetPositionX() < 2135.0f;
        }
    };
};

class boss_freya_elder_stonebark : public CreatureScript
{
public:
    boss_freya_elder_stonebark() : CreatureScript("boss_freya_elder_stonebark") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_freya_elder_stonebarkAI>(pCreature);
    }

    struct boss_freya_elder_stonebarkAI : public ScriptedAI
    {
        boss_freya_elder_stonebarkAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
        }

        EventMap events;
        uint8 _chargesCount;

        void Reset() override
        {
            events.Reset();
            _chargesCount = 0;
        }

        void KilledUnit(Unit*) override
        {
            if (urand(0, 1))
                return;

            Talk(SAY_ELDER_SLAY);
        }

        void JustDied(Unit* killer) override
        {
            if (killer && me->GetEntry() == killer->GetEntry())
                return;
            Talk(SAY_ELDER_DEATH);

            // Lumberjacked
            if (me->GetInstanceScript())
                if (Creature* freya = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_FREYA)))
                    freya->AI()->DoAction(ACTION_LUMBERJACKED);
        }

        void JustEngagedWith(Unit*) override
        {
            events.ScheduleEvent(EVENT_STONEBARK_FISTS_OF_STONE, 40s);
            events.ScheduleEvent(EVENT_STONEBARK_GROUND_TREMOR, 5s);
            events.ScheduleEvent(EVENT_STONEBARK_PETRIFIED_BARK, 20s);

            if (!me->HasAura(SPELL_DRAINED_OF_POWER)) // Prevents speech if combat is initiated by hardmode activation
                Talk(SAY_ELDER_AGGRO);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType damageType, SpellSchoolMask damageSchoolMask) override
        {
            if ((damageType == DIRECT_DAMAGE || (damageType == SPELL_DIRECT_DAMAGE && damageSchoolMask & SPELL_SCHOOL_MASK_NORMAL)) && _chargesCount)
            {
                --_chargesCount;
                damage = 0;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_STONEBARK_FISTS_OF_STONE:
                    me->CastSpell(me, SPELL_FISTS_OF_STONE, false);
                    events.Repeat(1min);
                    break;
                case EVENT_STONEBARK_GROUND_TREMOR:
                    if (!me->HasAura(SPELL_FISTS_OF_STONE))
                        me->CastSpell(me, SPELL_GROUND_TREMOR, false);
                    events.Repeat(20s);
                    break;
                case EVENT_STONEBARK_PETRIFIED_BARK:
                    _chargesCount = RAID_MODE(60, 120);
                    me->CastSpell(me, SPELL_PETRIFIED_BARK, false);
                    events.Repeat(30s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_freya_elder_brightleaf : public CreatureScript
{
public:
    boss_freya_elder_brightleaf() : CreatureScript("boss_freya_elder_brightleaf") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_freya_elder_brightleafAI>(pCreature);
    }

    struct boss_freya_elder_brightleafAI : public ScriptedAI
    {
        boss_freya_elder_brightleafAI(Creature* pCreature) : ScriptedAI(pCreature), summons(pCreature)
        {
        }

        EventMap events;
        SummonList summons;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
        }

        void KilledUnit(Unit*) override
        {
            if (urand(0, 1))
                return;

            Talk(SAY_ELDER_SLAY);
        }

        void JustDied(Unit* killer) override
        {
            if (killer && me->GetEntry() == killer->GetEntry())
                return;
            Talk(SAY_ELDER_DEATH);

            // Lumberjacked
            if (me->GetInstanceScript())
                if (Creature* freya = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_FREYA)))
                    freya->AI()->DoAction(ACTION_LUMBERJACKED);
        }

        void JustEngagedWith(Unit*) override
        {
            events.ScheduleEvent(EVENT_BRIGHTLEAF_FLUX, 10s);
            events.ScheduleEvent(EVENT_BRIGHTLEAF_SOLAR_FLARE, 5s);
            events.ScheduleEvent(EVENT_BRIGHTLEAF_UNSTABLE_SUN_BEAM, 8s);

            if (!me->HasAura(SPELL_DRAINED_OF_POWER)) // Prevents speech if combat is initiated by hardmode activation
                Talk(SAY_ELDER_AGGRO);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_BRIGHTLEAF_FLUX:
                    if (Aura* aur = me->AddAura(SPELL_BRIGHTLEAF_FLUX, me))
                        aur->SetStackAmount(urand(1, 10));
                    events.Repeat(10s);
                    break;
                case EVENT_BRIGHTLEAF_SOLAR_FLARE:
                    if (Aura* aur = me->GetAura(SPELL_BRIGHTLEAF_FLUX))
                    {
                        me->CastCustomSpell(SPELL_SOLAR_FLARE, SPELLVALUE_MAX_TARGETS, aur->GetStackAmount(), me, false);
                        me->RemoveAura(aur);
                    }
                    events.Repeat(15s);
                    break;
                case EVENT_BRIGHTLEAF_UNSTABLE_SUN_BEAM:
                    events.ScheduleEvent(EVENT_BRIGHTLEAF_DESPAWN_SUN_BEAM, 15s);
                    if (Creature* beam = me->SummonCreature(NPC_UNSTABLE_SUN_BRIGHTLEAF, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()))
                    {
                        beam->CastSpell(beam, SPELL_UNSTABLE_SUN_BEAM_AURA, true);
                        beam->CastSpell(beam, SPELL_PHOTOSYNTHESIS, true);
                        summons.Summon(beam);
                    }
                    if (Creature* beam = me->SummonCreature(NPC_UNSTABLE_SUN_BRIGHTLEAF, me->GetPositionX() + 8, me->GetPositionY() + 8, me->GetPositionZ()))
                    {
                        beam->CastSpell(beam, SPELL_UNSTABLE_SUN_BEAM_AURA, true);
                        beam->CastSpell(beam, SPELL_PHOTOSYNTHESIS, true);
                        summons.Summon(beam);
                    }
                    events.Repeat(20s);
                    break;
                case EVENT_BRIGHTLEAF_DESPAWN_SUN_BEAM:
                    for (SummonList::iterator i = summons.begin(); i != summons.end();)
                    {
                        Creature* summon = ObjectAccessor::GetCreature(*me, *i);
                        ++i;
                        if (summon)
                            summon->CastSpell(summon, SPELL_UNSTABLE_SUN_DAMAGE, false);
                    }

                    summons.DespawnAll();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_freya_elder_ironbranch : public CreatureScript
{
public:
    boss_freya_elder_ironbranch() : CreatureScript("boss_freya_elder_ironbranch") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_freya_elder_ironbranchAI>(pCreature);
    }

    struct boss_freya_elder_ironbranchAI : public ScriptedAI
    {
        boss_freya_elder_ironbranchAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
        }

        EventMap events;

        void Reset() override
        {
            events.Reset();
        }

        void KilledUnit(Unit*) override
        {
            if (urand(0, 1))
                return;

            Talk(SAY_ELDER_SLAY);
        }

        void JustDied(Unit* killer) override
        {
            if (killer && me->GetEntry() == killer->GetEntry())
                return;
            Talk(SAY_ELDER_DEATH);

            // Lumberjacked
            if (me->GetInstanceScript())
                if (Creature* freya = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_FREYA)))
                    freya->AI()->DoAction(ACTION_LUMBERJACKED);
        }

        void JustEngagedWith(Unit*) override
        {
            events.ScheduleEvent(EVENT_IRONBRANCH_IMPALE, 10s);
            events.ScheduleEvent(EVENT_IRONBRANCH_IRON_ROOT, 15s);
            events.ScheduleEvent(EVENT_IRONBRANCH_THORN_SWARM, 3s);

            if (!me->HasAura(SPELL_DRAINED_OF_POWER)) // Prevents speech if combat is initiated by hardmode activation
                Talk(SAY_ELDER_AGGRO);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_IRONBRANCH_IMPALE:
                    me->CastSpell(me->GetVictim(), SPELL_IMPALE, false);
                    events.Repeat(17s);
                    break;
                case EVENT_IRONBRANCH_IRON_ROOT:
                    me->CastCustomSpell(SPELL_IRON_ROOTS, SPELLVALUE_MAX_TARGETS, 1, me, false);
                    events.Repeat(20s);
                    break;
                case EVENT_IRONBRANCH_THORN_SWARM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), SPELL_THORN_SWARM, false);
                    events.Repeat(14s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_freya_iron_root : public CreatureScript
{
public:
    boss_freya_iron_root() : CreatureScript("boss_freya_iron_root") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_freya_iron_rootAI>(pCreature);
    }

    struct boss_freya_iron_rootAI : public NullCreatureAI
    {
        boss_freya_iron_rootAI(Creature* pCreature) : NullCreatureAI(pCreature) { }

        void JustDied(Unit* /*killer*/) override
        {
            if (!me->IsSummon())
                return;

            if (Unit* target = ObjectAccessor::GetUnit(*me, me->ToTempSummon()->GetSummonerGUID()))
            {
                if (me->GetEntry() == NPC_IRON_ROOT_TRIGGER) // Iron Branch spell
                    target->RemoveAura(target->GetMap()->Is25ManRaid() ? SPELL_IRON_ROOTS_DAMAGE_25 : SPELL_IRON_ROOTS_DAMAGE_10);
                else
                    target->RemoveAura(target->GetMap()->Is25ManRaid() ? SPELL_IRON_ROOTS_FREYA_DAMAGE_25 : SPELL_IRON_ROOTS_FREYA_DAMAGE_10);
            }
        }
    };
};

class boss_freya_lifebinder : public CreatureScript
{
public:
    boss_freya_lifebinder() : CreatureScript("boss_freya_lifebinder") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_freya_lifebinderAI>(pCreature);
    }

    struct boss_freya_lifebinderAI : public NullCreatureAI
    {
        boss_freya_lifebinderAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
        }

        uint32 _healTimer;

        void Reset() override
        {
            me->CastSpell(me, SPELL_LIFEBINDER_VISUAL, true);
            me->CastSpell(me, SPELL_LIFEBINDER_PHERONOMES, true);
            me->CastSpell(me, SPELL_AUTO_GROW, true);
            _healTimer = 0;
        }

        void UpdateAI(uint32 diff) override
        {
            _healTimer += diff;
            if (_healTimer >= 12000)
            {
                me->RemoveAurasDueToSpell(SPELL_AUTO_GROW);
                me->CastSpell(me, me->GetMap()->Is25ManRaid() ? SPELL_LIFEBINDER_HEAL_25 : SPELL_LIFEBINDER_HEAL_10, true);
                me->DespawnOrUnsummon(2000);
                _healTimer = 0;
            }
        }
    };
};

class boss_freya_healthy_spore : public CreatureScript
{
public:
    boss_freya_healthy_spore() : CreatureScript("boss_freya_healthy_spore") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_freya_healthy_sporeAI>(pCreature);
    }

    struct boss_freya_healthy_sporeAI : public NullCreatureAI
    {
        boss_freya_healthy_sporeAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
        }

        uint32 _despawnTimer;

        void Reset() override
        {
            me->CastSpell(me, SPELL_POTENT_PHEROMONES, true);
            me->CastSpell(me, SPELL_HEALTHY_SPORE_VISUAL, true);
            me->CastSpell(me, SPELL_AUTO_GROW, true);
            _despawnTimer = 0;
        }

        void UpdateAI(uint32 diff) override
        {
            _despawnTimer += diff;
            if (_despawnTimer >= 22000)
            {
                me->RemoveAurasDueToSpell(SPELL_AUTO_GROW);
                me->DespawnOrUnsummon(2200);
                _despawnTimer = 0;
            }
        }
    };
};

class boss_freya_summons : public CreatureScript
{
public:
    boss_freya_summons() : CreatureScript("boss_freya_summons") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_freya_summonsAI>(pCreature);
    }

    struct boss_freya_summonsAI : public ScriptedAI
    {
        boss_freya_summonsAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            _freyaGUID = me->GetInstanceScript() ? me->GetInstanceScript()->GetGuidData(TYPE_FREYA) : ObjectGuid::Empty;
            _isTrio = me->GetEntry() == NPC_ANCIENT_WATER_SPIRIT || me->GetEntry() == NPC_STORM_LASHER || me->GetEntry() == NPC_SNAPLASHER;
            _hasDied = false;
        }

        EventMap events;
        ObjectGuid _freyaGUID;
        uint8 _stackCount;
        bool _hasDied;
        bool _isTrio;

        void Reset() override
        {
            _stackCount = 0;
            events.Reset();
            if (Unit* target = SelectTargetFromPlayerList(70))
                AttackStart(target);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Creature* freya = ObjectAccessor::GetCreature(*me, _freyaGUID))
            {
                if (!_hasDied)
                    freya->AI()->DoAction(_stackCount);

                if (_isTrio)
                {
                    freya->AI()->DoAction(ACTION_RESPAWN_TRIO);
                    _hasDied = true;
                }
            }
            if (me->GetEntry() == NPC_DETONATING_LASHER)
                me->CastSpell(me, SPELL_DETONATE, true);
        }

        void DoAction(int32 param) override
        {
            if (_isTrio && param == ACTION_RESPAWN_TRIO)
            {
                me->setDeathState(DeathState::JustRespawned);
                Reset();
            }
        }

        void JustEngagedWith(Unit*) override
        {
            if (me->GetEntry() == NPC_ANCIENT_CONSERVATOR)
            {
                me->CastSpell(me, SPELL_HEALTHY_SPORE_SUMMON, true);
                events.ScheduleEvent(EVENT_ANCIENT_CONSERVATOR_GRIP, 6s);
                events.ScheduleEvent(EVENT_ANCIENT_CONSERVATOR_NATURE_FURY, 14s);
                _stackCount = ACTION_REMOVE_25_STACK;
            }
            else if (me->GetEntry() == NPC_ANCIENT_WATER_SPIRIT)
            {
                events.ScheduleEvent(EVENT_WATER_SPIRIT_CHARGE, 12s);
                _stackCount = ACTION_REMOVE_10_STACK;
            }
            else if (me->GetEntry() == NPC_STORM_LASHER)
            {
                events.ScheduleEvent(EVENT_STORM_LASHER_LIGHTNING_LASH, 10s);
                events.ScheduleEvent(EVENT_STORM_LASHER_STORMBOLT, 6s);
                _stackCount = ACTION_REMOVE_10_STACK;
            }
            else if (me->GetEntry() == NPC_DETONATING_LASHER)
            {
                events.ScheduleEvent(EVENT_DETONATING_LASHER_FLAME_LASH, 10s);
                _stackCount = ACTION_REMOVE_2_STACK;
            }
            else if (me->GetEntry() == NPC_SNAPLASHER)
            {
                me->CastSpell(me, SPELL_HARDENED_BARK, true);
                _stackCount = ACTION_REMOVE_10_STACK;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_ANCIENT_CONSERVATOR_NATURE_FURY:
                    me->CastSpell(me->GetVictim(), SPELL_NATURE_FURY, false);
                    events.Repeat(14s);
                    break;
                case EVENT_ANCIENT_CONSERVATOR_GRIP:
                   me->CastSpell(me, SPELL_CONSERVATOR_GRIP, true);
                   break;
                case EVENT_WATER_SPIRIT_CHARGE:
                    me->CastSpell(me, SPELL_TIDAL_WAVE_AURA, true);
                    me->CastSpell(me->GetVictim(), SPELL_TIDAL_WAVE, false);
                    events.Repeat(12s);
                    events.ScheduleEvent(EVENT_WATER_SPIRIT_DAMAGE, 3s);
                    break;
                case EVENT_WATER_SPIRIT_DAMAGE:
                    me->CastSpell(me, SPELL_TIDAL_WAVE_DAMAGE, false);
                    break;
                case EVENT_STORM_LASHER_LIGHTNING_LASH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_LIGHTNING_LASH, false);
                    events.Repeat(10s);
                    break;
                case EVENT_STORM_LASHER_STORMBOLT:
                    me->CastSpell(me->GetVictim(), SPELL_STORMBOLT, false);
                    events.Repeat(6s);
                    break;
                case EVENT_DETONATING_LASHER_FLAME_LASH:
                    me->CastSpell(me->GetVictim(), SPELL_FLAME_LASH, false);
                    DoResetThreatList();
                    if (Unit* target = SelectTargetFromPlayerList(80))
                        AttackStart(target);
                    else
                        me->DespawnOrUnsummon(1);
                    events.Repeat(10s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_freya_nature_bomb : public CreatureScript
{
public:
    boss_freya_nature_bomb() : CreatureScript("boss_freya_nature_bomb") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_freya_nature_bombAI>(pCreature);
    }

    struct boss_freya_nature_bombAI : public NullCreatureAI
    {
        boss_freya_nature_bombAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            _goGUID.Clear();
        }

        ObjectGuid _goGUID;
        uint32 _explodeTimer;

        void Reset() override
        {
            me->SetObjectScale(0.5f);
            me->CastSpell(me, SPELL_GREEN_BANISH_STATE, true);

            _explodeTimer = 0;
            if (GameObject* go = me->SummonGameObject(194902 /*GO_NATURE_BOMB*/, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, 0, 0, 0, 0, 0))
                _goGUID = go->GetGUID();
        }

        uint32 Timer;
        void UpdateAI(uint32 diff) override
        {
            _explodeTimer += diff;
            if (_explodeTimer >= 11000)
            {
                me->CastSpell(me, me->GetMap()->Is25ManRaid() ? SPELL_NATURE_BOMB_DAMAGE_25 : SPELL_NATURE_BOMB_DAMAGE_10, false);
                me->DespawnOrUnsummon(1000);
                _explodeTimer = 0;
            }

            // Delay explosion a little, visual
            if (_explodeTimer >= 5000 && _explodeTimer < 10000)
            {
                _explodeTimer = 10000;
                if (GameObject* go = me->GetMap()->GetGameObject(_goGUID))
                    go->SetGoState(GO_STATE_ACTIVE);
            }
        }
    };
};

class achievement_freya_getting_back_to_nature : public AchievementCriteriaScript
{
public:
    achievement_freya_getting_back_to_nature() : AchievementCriteriaScript("achievement_freya_getting_back_to_nature") {}

    bool OnCheck(Player*  /*player*/, Unit* target /*Freya*/, uint32 /*criteria_id*/) override
    {
        if (target)
            if (target->GetAI()->GetData(DATA_BACK_TO_NATURE))
                return true;
        return false;
    }
};

class achievement_freya_knock_on_wood : public AchievementCriteriaScript
{
public:
    achievement_freya_knock_on_wood(char const* name, uint32 count) : AchievementCriteriaScript(name),
        _elderCount(count)
    {
    }

    bool OnCheck(Player*  /*player*/, Unit* target /*Freya*/, uint32 /*criteria_id*/) override
    {
        return target && _elderCount <= target->GetAI()->GetData(DATA_GET_ELDER_COUNT);
    }

private:
    uint32 const _elderCount;
};

void AddSC_boss_freya()
{
    new boss_freya();
    new boss_freya_elder_stonebark();
    new boss_freya_elder_brightleaf();
    new boss_freya_elder_ironbranch();
    new boss_freya_iron_root();
    new boss_freya_lifebinder();
    new boss_freya_healthy_spore();
    new boss_freya_summons();
    new boss_freya_nature_bomb();

    new achievement_freya_getting_back_to_nature();
    new achievement_freya_knock_on_wood("achievement_freya_knock_on_wood", 1);
    new achievement_freya_knock_on_wood("achievement_freya_knock_knock_on_wood", 2);
    new achievement_freya_knock_on_wood("achievement_freya_knock_knock_knock_on_wood", 3);
}
