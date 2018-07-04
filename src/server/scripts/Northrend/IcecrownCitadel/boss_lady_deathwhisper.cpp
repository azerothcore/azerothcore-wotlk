/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Group.h"
#include "icecrown_citadel.h"
#include "SpellInfo.h"
#include "Player.h"

enum ScriptTexts
{
    // Lady Deathwhisper
    SAY_INTRO_1                 = 0,
    SAY_INTRO_2                 = 1,
    SAY_INTRO_3                 = 2,
    SAY_INTRO_4                 = 3,
    SAY_INTRO_5                 = 4,
    SAY_INTRO_6                 = 5,
    SAY_INTRO_7                 = 6,
    SAY_AGGRO                   = 7,
    SAY_PHASE_2                 = 8,
    EMOTE_PHASE_2               = 9,
    SAY_DOMINATE_MIND           = 10,
    SAY_DARK_EMPOWERMENT        = 11,
    SAY_DARK_TRANSFORMATION     = 12,
    SAY_ANIMATE_DEAD            = 13,
    SAY_KILL                    = 14,
    SAY_BERSERK                 = 15,
    SAY_DEATH                   = 16,

    // Darnavan
    SAY_DARNAVAN_AGGRO          = 0,
    SAY_DARNAVAN_RESCUED        = 1,
};

enum Spells
{
    // Lady Deathwhisper
    SPELL_SHADOW_CHANNELING         = 43897, // during intro
    SPELL_MANA_BARRIER              = 70842,
    SPELL_DEATH_AND_DECAY           = 71001,
    SPELL_DOMINATE_MIND_25          = 71289,
    SPELL_SHADOW_BOLT               = 71254,
    SPELL_DARK_MARTYRDOM_T          = 70897,
    SPELL_DARK_TRANSFORMATION_T     = 70895,
    SPELL_DARK_EMPOWERMENT_T        = 70896,
    SPELL_FROSTBOLT                 = 71420,
    SPELL_FROSTBOLT_VOLLEY          = 72905,
    SPELL_TOUCH_OF_INSIGNIFICANCE   = 71204,
    SPELL_SUMMON_SHADE              = 71363,

    // Fanatics
    SPELL_NECROTIC_STRIKE           = 70659,
    SPELL_SHADOW_CLEAVE             = 70670,
    SPELL_VAMPIRIC_MIGHT            = 70674,
    SPELL_DARK_MARTYRDOM_FANATIC    = 71236,
    SPELL_FANATIC_S_DETERMINATION   = 71235,
    SPELL_DARK_TRANSFORMATION       = 70900,

    //  Adherents
    SPELL_FROST_FEVER               = 67767,
    SPELL_DEATHCHILL_BOLT           = 70594,
    SPELL_DEATHCHILL_BLAST          = 70906,
    SPELL_CURSE_OF_TORPOR           = 71237,
    SPELL_SHORUD_OF_THE_OCCULT      = 70768,
    SPELL_DARK_MARTYRDOM_ADHERENT   = 70903,
    SPELL_ADHERENT_S_DETERMINATION  = 71234,
    SPELL_DARK_EMPOWERMENT          = 70901,

    // Vengeful Shade
    SPELL_VENGEFUL_BLAST_PASSIVE    = 71494,
    SPELL_VENGEFUL_BLAST_10N        = 71544,
    SPELL_VENGEFUL_BLAST_25N        = 72010,
    SPELL_VENGEFUL_BLAST_10H        = 72011,
    SPELL_VENGEFUL_BLAST_25H        = 72012,

    // Darnavan
    SPELL_BLADESTORM                = 65947,
    SPELL_CHARGE                    = 65927,
    SPELL_INTIMIDATING_SHOUT        = 65930,
    SPELL_MORTAL_STRIKE             = 65926,
    SPELL_SHATTERING_THROW          = 65940,
    SPELL_SUNDER_ARMOR              = 65936,

    // misc
    SPELL_FULL_HOUSE                = 72827, // achievement
    SPELL_TELEPORT_VISUAL           = 52096, // used by adds
};

enum EventTypes
{
    // Lady Deathwhisper:
    EVENT_INTRO_2 = 1,
    EVENT_INTRO_3,
    EVENT_INTRO_4,
    EVENT_INTRO_5,
    EVENT_INTRO_6,
    EVENT_INTRO_7,

    EVENT_BERSERK,
    EVENT_SPELL_DEATH_AND_DECAY,
    EVENT_SPELL_DOMINATE_MIND_25,

    // Phase 1:
    EVENT_SPELL_SHADOW_BOLT,
    EVENT_SUMMON_WAVE_P1,
    EVENT_REANIMATE_CULTIST,
    EVENT_EMPOWER_CULTIST,

    // Phase 2:
    EVENT_SPELL_FROSTBOLT,
    EVENT_SPELL_FROSTBOLT_VOLLEY,
    EVENT_SPELL_TOUCH_OF_INSIGNIFICANCE,
    EVENT_SPELL_SUMMON_SHADE,
    EVENT_SUMMON_WAVE_P2,

    // Shared adds events:
    EVENT_SPELL_CULTIST_DARK_MARTYRDOM,
    EVENT_CULTIST_DARK_MARTYRDOM_SELF_KILL,

    // Cult Fanatic:
    EVENT_SPELL_FANATIC_NECROTIC_STRIKE,
    EVENT_SPELL_FANATIC_SHADOW_CLEAVE,
    EVENT_SPELL_FANATIC_VAMPIRIC_MIGHT,

    // Cult Adherent:
    EVENT_SPELL_ADHERENT_FROST_FEVER,
    EVENT_SPELL_ADHERENT_DEATHCHILL,
    EVENT_SPELL_ADHERENT_CURSE_OF_TORPOR,
    EVENT_SPELL_ADHERENT_SHORUD_OF_THE_OCCULT,

    // Darnavan:
    EVENT_DARNAVAN_BLADESTORM,
    EVENT_DARNAVAN_CHARGE,
    EVENT_DARNAVAN_INTIMIDATING_SHOUT,
    EVENT_DARNAVAN_MORTAL_STRIKE,
    EVENT_DARNAVAN_SHATTERING_THROW,
    EVENT_DARNAVAN_SUNDER_ARMOR,
};

enum Phases
{
    PHASE_ALL       = 0,
    PHASE_INTRO     = 1,
    PHASE_ONE       = 2,
    PHASE_TWO       = 3,

    PHASE_INTRO_MASK    = 1 << (PHASE_INTRO-1),
    PHASE_ONE_MASK      = 1 << (PHASE_ONE-1),
};

enum DeprogrammingData
{
    NPC_DARNAVAN_10         = 38472,
    NPC_DARNAVAN_25         = 38485,
    NPC_DARNAVAN_CREDIT_10  = 39091,
    NPC_DARNAVAN_CREDIT_25  = 39092,

    ACTION_COMPLETE_QUEST   = -384720,
    POINT_DESPAWN           = 384721,
};

enum Actions
{
    ACTION_START_INTRO
};

#define NPC_DARNAVAN        RAID_MODE<uint32>(NPC_DARNAVAN_10, NPC_DARNAVAN_25, NPC_DARNAVAN_10, NPC_DARNAVAN_25)
#define NPC_DARNAVAN_CREDIT RAID_MODE<uint32>(NPC_DARNAVAN_CREDIT_10, NPC_DARNAVAN_CREDIT_25, NPC_DARNAVAN_CREDIT_10, NPC_DARNAVAN_CREDIT_25)
#define QUEST_DEPROGRAMMING RAID_MODE<uint32>(QUEST_DEPROGRAMMING_10, QUEST_DEPROGRAMMING_25, QUEST_DEPROGRAMMING_10, QUEST_DEPROGRAMMING_25)

uint32 const SummonEntries[2] = {NPC_CULT_FANATIC, NPC_CULT_ADHERENT};
Position const SummonPositions[7] =
{
    {-578.7066f, 2154.167f, 51.01529f, 1.692969f}, // 1 Left Door 1 (Cult Fanatic)
    {-598.9028f, 2155.005f, 51.01530f, 1.692969f}, // 2 Left Door 2 (Cult Adherent)
    {-619.2864f, 2154.460f, 51.01530f, 1.692969f}, // 3 Left Door 3 (Cult Fanatic)
    {-578.6996f, 2269.856f, 51.01529f, 4.590216f}, // 4 Right Door 1 (Cult Adherent)
    {-598.9688f, 2269.264f, 51.01529f, 4.590216f}, // 5 Right Door 2 (Cult Fanatic)
    {-619.4323f, 2268.523f, 51.01530f, 4.590216f}, // 6 Right Door 3 (Cult Adherent)
    {-524.2480f, 2211.920f, 62.90960f, 3.141592f}, // 7 Upper (Random Cultist)
};

class DaranavanMoveEvent : public BasicEvent
{
    public:
        DaranavanMoveEvent(Creature& darnavan) : _darnavan(darnavan) { }

        bool Execute(uint64 /*time*/, uint32 /*diff*/)
        {
            _darnavan.GetMotionMaster()->MovePoint(POINT_DESPAWN, SummonPositions[6]);
            return true;
        }

    private:
        Creature& _darnavan;
};

class boss_lady_deathwhisper : public CreatureScript
{
    public:
        boss_lady_deathwhisper() : CreatureScript("boss_lady_deathwhisper") { }

        struct boss_lady_deathwhisperAI : public BossAI
        {
            boss_lady_deathwhisperAI(Creature* creature) : BossAI(creature, DATA_LADY_DEATHWHISPER), _introDone(false), _darnavanGUID(0)
            {
            }

            void Reset()
            {
                if (Creature* darnavan = ObjectAccessor::GetCreature(*me, _darnavanGUID))
                    darnavan->DespawnOrUnsummon();
                _darnavanGUID = 0;
                _waveCounter = 0;
                _reanimationQueue.clear();
                _Reset();
                me->SetPower(POWER_MANA, me->GetMaxPower(POWER_MANA));
                events.SetPhase(PHASE_ONE);
                me->CastSpell(me, SPELL_SHADOW_CHANNELING, false);
            }

            void AttackStart(Unit* victim)
            {
                if (victim && me->Attack(victim, true) && !(events.GetPhaseMask() & PHASE_ONE_MASK))
                    me->GetMotionMaster()->MoveChase(victim);
            }

            void EnterCombat(Unit* who)
            {
                if (!instance->CheckRequiredBosses(DATA_LADY_DEATHWHISPER, who->ToPlayer()))
                {
                    EnterEvadeMode();
                    instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                    return;
                }

                me->setActive(true);
                DoZoneInCombat();

                events.Reset();
                events.SetPhase(PHASE_ONE);
                events.ScheduleEvent(EVENT_BERSERK, 600000);
                events.ScheduleEvent(EVENT_SPELL_DEATH_AND_DECAY, 10000);
                if (GetDifficulty() != RAID_DIFFICULTY_10MAN_NORMAL)
                    events.ScheduleEvent(EVENT_SPELL_DOMINATE_MIND_25, 27000);
                events.ScheduleEvent(EVENT_SPELL_SHADOW_BOLT, urand(5500, 6000), 0, PHASE_ONE);
                events.ScheduleEvent(EVENT_SUMMON_WAVE_P1, 5000, 0, PHASE_ONE);
                events.ScheduleEvent(EVENT_EMPOWER_CULTIST, urand(20000, 30000), 0, PHASE_ONE);

                Talk(SAY_AGGRO);
                me->RemoveAurasDueToSpell(SPELL_SHADOW_CHANNELING);
                me->CastSpell(me, SPELL_MANA_BARRIER, true);

                instance->SetBossState(DATA_LADY_DEATHWHISPER, IN_PROGRESS);
            }

            void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (events.GetPhaseMask() & PHASE_ONE_MASK && damage >= me->GetPower(POWER_MANA))
                {
                    // reset threat
                    ThreatContainer::StorageType const& threatlist = me->getThreatManager().getThreatList();
                    for (ThreatContainer::StorageType::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
                    {
                        Unit* unit = ObjectAccessor::GetUnit((*me), (*itr)->getUnitGuid());

                        if (unit && DoGetThreat(unit))
                            DoModifyThreatPercent(unit, -100);
                    }

                    Talk(SAY_PHASE_2);
                    Talk(EMOTE_PHASE_2);
                    DoStartMovement(me->GetVictim());
                    damage -= me->GetPower(POWER_MANA);
                    me->SetPower(POWER_MANA, 0);
                    me->RemoveAurasDueToSpell(SPELL_MANA_BARRIER);
                    events.SetPhase(PHASE_TWO);
                    events.ScheduleEvent(EVENT_SPELL_FROSTBOLT, urand(10000, 12000), 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_SPELL_FROSTBOLT_VOLLEY, urand(19000, 21000), 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_SPELL_TOUCH_OF_INSIGNIFICANCE, urand(6000, 9000), 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_SPELL_SUMMON_SHADE, urand(12000, 15000), 0, PHASE_TWO);
                    if (IsHeroic())
                        events.ScheduleEvent(EVENT_SUMMON_WAVE_P2, 45000, 0, PHASE_TWO);
                }
            }

            void UpdateAI(uint32 diff)
            {
                if ((!UpdateVictim() && !(events.GetPhaseMask() & PHASE_INTRO_MASK)) || !CheckInRoom())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING) && !(events.GetPhaseMask() & PHASE_INTRO_MASK))
                    return;

                switch (events.GetEvent())
                {
                    case 0:
                        break;
                    case EVENT_INTRO_2:
                        Talk(SAY_INTRO_2);
                        events.PopEvent();
                        break;
                    case EVENT_INTRO_3:
                        Talk(SAY_INTRO_3);
                        events.PopEvent();
                        break;
                    case EVENT_INTRO_4:
                        Talk(SAY_INTRO_4);
                        events.PopEvent();
                        break;
                    case EVENT_INTRO_5:
                        Talk(SAY_INTRO_5);
                        events.PopEvent();
                        break;
                    case EVENT_INTRO_6:
                        Talk(SAY_INTRO_6);
                        events.PopEvent();
                        break;
                    case EVENT_INTRO_7:
                        Talk(SAY_INTRO_7);
                        events.PopEvent();
                        break;
                    case EVENT_BERSERK:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        Talk(SAY_BERSERK);
                        events.PopEvent();
                        break;
                    case EVENT_SPELL_DEATH_AND_DECAY:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                            me->CastSpell(target, SPELL_DEATH_AND_DECAY, false);
                        events.RepeatEvent(urand(22000, 30000));
                        break;
                    case EVENT_SPELL_DOMINATE_MIND_25:
                        {
                            Talk(SAY_DOMINATE_MIND);

                            std::vector<Player*> validPlayers;
                            Map::PlayerList const &pList = me->GetMap()->GetPlayers();
                            for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                                if (Player* plr = itr->GetSource())
                                    if (plr->IsAlive() && !plr->IsGameMaster() && plr->GetExactDist2dSq(me) < (150.0f * 150.0f))
                                        if (!me->GetVictim() || me->GetVictim()->GetGUID() != plr->GetGUID())
                                        {
                                            // shouldn't be casted on any victim of summoned mobs
                                            bool valid = true;
                                            for (std::list<uint64>::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                                                if (Creature* c = ObjectAccessor::GetCreature(*me, (*itr)))
                                                    if (c->IsAlive() && c->GetVictim() && c->GetVictim()->GetGUID() == plr->GetGUID())
                                                    {
                                                        valid = false;
                                                        break;
                                                    }
                                            if (valid)
                                                validPlayers.push_back(plr);
                                        }

                            std::vector<Player*>::iterator begin=validPlayers.begin(), end=validPlayers.end();
                            std::random_shuffle(begin, end);

                            for (uint8 i = 0; i < RAID_MODE<uint8>(0, 1, 1, 3) && i < validPlayers.size(); i++)
                            {
                                Unit* target = validPlayers[i];
                                me->CastSpell(target, SPELL_DOMINATE_MIND_25, true);
                            }

                            events.RepeatEvent(urand(40000, 45000));
                        }
                        break;
                    case EVENT_SPELL_SHADOW_BOLT:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM))
                            me->CastSpell(target, SPELL_SHADOW_BOLT, false);
                        events.RepeatEvent(urand(5000, 8000));
                        break;
                    case EVENT_SUMMON_WAVE_P1:
                        SummonWaveP1();
                        events.RepeatEvent(IsHeroic() ? 45000 : 60000);
                        break;
                    case EVENT_REANIMATE_CULTIST:
                        ReanimateCultist();
                        events.PopEvent();
                        break;
                    case EVENT_EMPOWER_CULTIST:
                        EmpowerCultist();
                        events.RepeatEvent(urand(18000, 25000));
                        break;
                    case EVENT_SPELL_FROSTBOLT:
                        me->CastSpell(me->GetVictim(), SPELL_FROSTBOLT, false);
                        events.RepeatEvent(urand(10000, 11000));
                        break;
                    case EVENT_SPELL_FROSTBOLT_VOLLEY:
                        me->CastSpell((Unit*)NULL, SPELL_FROSTBOLT_VOLLEY, false);
                        events.RepeatEvent(urand(13000, 15000));
                        break;
                    case EVENT_SPELL_TOUCH_OF_INSIGNIFICANCE:
                        me->CastSpell(me->GetVictim(), SPELL_TOUCH_OF_INSIGNIFICANCE, false);
                        events.RepeatEvent(urand(9000, 13000));
                        break;
                    case EVENT_SUMMON_WAVE_P2:
                        SummonWaveP2();
                        events.RepeatEvent(45000);
                        break;
                    case EVENT_SPELL_SUMMON_SHADE:
                        {
                            uint8 count = 1;
                            if (GetDifficulty() == RAID_DIFFICULTY_25MAN_NORMAL)
                                count = 2;
                            else if (GetDifficulty() == RAID_DIFFICULTY_25MAN_HEROIC)
                                count = 3;

                            std::list<Unit*> targets;
                            SelectTargetList(targets, NonTankTargetSelector(me, true), count, SELECT_TARGET_RANDOM);
                            if (!targets.empty())
                                for (std::list<Unit*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                                    me->CastSpell(*itr, SPELL_SUMMON_SHADE, true);
                        }
                        events.RepeatEvent(urand(18000, 23000));
                        break;
                }

                if (me->HasAura(SPELL_MANA_BARRIER))
                    return;

                DoMeleeAttackIfReady();
            }

            void JustSummoned(Creature* summon)
            {
                if (summon->GetEntry() == NPC_DARNAVAN)
                    _darnavanGUID = summon->GetGUID();
                else
                    summons.Summon(summon);

                Unit* target = NULL;
                if (summon->GetEntry() == NPC_VENGEFUL_SHADE)
                {
                    float minrange = 250.0f;
                    Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                        if (Player* p = itr->GetSource())
                            if (p != me->GetVictim() && summon->GetExactDist(p) < minrange && me->CanCreatureAttack(p) && me->_CanDetectFeignDeathOf(p))
                            {
                                target = p;
                                minrange = summon->GetExactDist(p);
                            }


                    summon->ToTempSummon()->DespawnOrUnsummon(30000);
                }
                else
                {
                    target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true);
                }

                summon->AI()->AttackStart(target);
            }

            void SummonedCreatureDespawn(Creature* summon)
            {
                summons.Despawn(summon);
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);

                std::set<uint32> livingAddEntries;
                // Full House achievement
                for (SummonList::iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    if (Unit* unit = ObjectAccessor::GetUnit(*me, *itr))
                        if (unit->IsAlive() && unit->GetEntry() != NPC_VENGEFUL_SHADE)
                            livingAddEntries.insert(unit->GetEntry());

                if (livingAddEntries.size() >= 5)
                    instance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, SPELL_FULL_HOUSE, 0, me);

                if (Creature* darnavan = ObjectAccessor::GetCreature(*me, _darnavanGUID))
                {
                    if (darnavan->IsAlive())
                    {
                        darnavan->RemoveAllAuras();
                        darnavan->setFaction(35);
                        darnavan->DeleteThreatList();
                        darnavan->CombatStop(true);
                        darnavan->GetMotionMaster()->MoveIdle();
                        darnavan->StopMoving();
                        darnavan->SetReactState(REACT_PASSIVE);
                        darnavan->m_Events.AddEvent(new DaranavanMoveEvent(*darnavan), darnavan->m_Events.CalculateTime(10000));
                        darnavan->AI()->Talk(SAY_DARNAVAN_RESCUED);
                        if (Player* owner = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
                        {
                            if (Group* group = owner->GetGroup())
                            {
                                for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
                                    if (Player* member = itr->GetSource())
                                        if (member->IsInMap(owner))
                                            member->KilledMonsterCredit(NPC_DARNAVAN_CREDIT, 0);
                            }
                            else
                                owner->KilledMonsterCredit(NPC_DARNAVAN_CREDIT, 0);
                        }
                    }
                }

                _JustDied();
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_KILL);
            }

            void DoAction(int32 action)
            {
                if (action != ACTION_START_INTRO)
                    return;

                if (!_introDone)
                {
                    _introDone = true;
                    Talk(SAY_INTRO_1);
                    events.SetPhase(PHASE_INTRO);
                    events.ScheduleEvent(EVENT_INTRO_2, 11000, 0, PHASE_INTRO);
                    events.ScheduleEvent(EVENT_INTRO_3, 21000, 0, PHASE_INTRO);
                    events.ScheduleEvent(EVENT_INTRO_4, 31500, 0, PHASE_INTRO);
                    events.ScheduleEvent(EVENT_INTRO_5, 39500, 0, PHASE_INTRO);
                    events.ScheduleEvent(EVENT_INTRO_6, 48500, 0, PHASE_INTRO);
                    events.ScheduleEvent(EVENT_INTRO_7, 58000, 0, PHASE_INTRO);
                }
            }

            void SummonWaveP1()
            {
                uint8 addIndex = _waveCounter & 1;
                uint8 addIndexOther = uint8(addIndex ^ 1);

                // Summon first add, replace it with Darnavan if weekly quest is active
                if (_waveCounter || instance->GetData(DATA_WEEKLY_QUEST_ID) != QUEST_DEPROGRAMMING_10)
                    Summon(SummonEntries[addIndex], SummonPositions[addIndex * 3]);
                else
                    Summon(NPC_DARNAVAN, SummonPositions[addIndex * 3]);

                Summon(SummonEntries[addIndexOther], SummonPositions[addIndex * 3 + 1]);
                Summon(SummonEntries[addIndex], SummonPositions[addIndex * 3 + 2]);
                if (Is25ManRaid())
                {
                    Summon(SummonEntries[addIndexOther], SummonPositions[addIndexOther * 3]);
                    Summon(SummonEntries[addIndex], SummonPositions[addIndexOther * 3 + 1]);
                    Summon(SummonEntries[addIndexOther], SummonPositions[addIndexOther * 3 + 2]);
                    Summon(SummonEntries[urand(0, 1)], SummonPositions[6]);
                }

                ++_waveCounter;
            }

            void SummonWaveP2()
            {
                if (Is25ManRaid())
                {
                    uint8 addIndex = _waveCounter & 1;
                    Summon(SummonEntries[addIndex], SummonPositions[addIndex * 3]);
                    Summon(SummonEntries[addIndex ^ 1], SummonPositions[addIndex * 3 + 1]);
                    Summon(SummonEntries[addIndex], SummonPositions[addIndex * 3+ 2]);
                }
                else
                    Summon(SummonEntries[urand(0, 1)], SummonPositions[6]);

                ++_waveCounter;
            }

            // helper for summoning wave mobs
            void Summon(uint32 entry, const Position& pos)
            {
                if (me->SummonCreature(entry, pos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000))
                    if (TempSummon* trigger = me->SummonCreature(WORLD_TRIGGER, pos, TEMPSUMMON_TIMED_DESPAWN, 2000))
                    {
                        trigger->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                        trigger->CastSpell(trigger, SPELL_TELEPORT_VISUAL, true);
                    }
            }

            void SetGUID(uint64 guid, int32)
            {
                if (events.GetPhaseMask() & PHASE_ONE_MASK)
                {
                    _reanimationQueue.push_back(guid);
                    events.ScheduleEvent(EVENT_REANIMATE_CULTIST, 3000, 0, PHASE_ONE);
                }
            }

            void ReanimateCultist()
            {
                if (_reanimationQueue.empty())
                    return;

                uint64 cultistGUID = _reanimationQueue.front();
                Creature* cultist = ObjectAccessor::GetCreature(*me, cultistGUID);
                _reanimationQueue.pop_front();
                if (!cultist)
                    return;

                Talk(SAY_ANIMATE_DEAD);
                me->CastSpell(cultist, SPELL_DARK_MARTYRDOM_T, true);
            }

            void EmpowerCultist()
            {
                if (summons.empty())
                    return;

                std::list<Creature*> temp;
                for (SummonList::iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    if (Creature* cre = ObjectAccessor::GetCreature(*me, *itr))
                        if (cre->IsAlive() && (cre->GetEntry() == NPC_CULT_FANATIC || cre->GetEntry() == NPC_CULT_ADHERENT))
                            temp.push_back(cre);

                // noone to empower
                if (temp.empty())
                    return;

                // select random cultist
                if (Creature* cultist = Trinity::Containers::SelectRandomContainerElement(temp))
                {
                    me->CastSpell(cultist, cultist->GetEntry() == NPC_CULT_FANATIC ? SPELL_DARK_TRANSFORMATION_T : SPELL_DARK_EMPOWERMENT_T, true);
                    Talk(uint8(cultist->GetEntry() == NPC_CULT_FANATIC ? SAY_DARK_TRANSFORMATION : SAY_DARK_EMPOWERMENT));
                }
            }

            void SpellHitTarget(Unit* target, SpellInfo const* spell)
            {
                if (spell->Id == SPELL_DARK_MARTYRDOM_T)
                {
                    if (target->GetEntry() == NPC_CULT_FANATIC)
                        me->SummonCreature(NPC_REANIMATED_FANATIC, *target, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    else
                        me->SummonCreature(NPC_REANIMATED_ADHERENT, *target, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);

                    if (TempSummon* summon = target->ToTempSummon())
                        summon->UnSummon();
                }
                else if (spell->Id == SPELL_DOMINATE_MIND_25)
                {
                    const int32 val = 100;
                    target->CastCustomSpell(target, 73261, &val, NULL, NULL, true); // scale aura, +100% size
                }
            }

        private:
            bool _introDone;
            uint64 _darnavanGUID;
            std::deque<uint64> _reanimationQueue;
            uint32 _waveCounter;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<boss_lady_deathwhisperAI>(creature);
        }
};

class npc_cult_fanatic : public CreatureScript
{
public:
    npc_cult_fanatic() : CreatureScript("npc_cult_fanatic") { }

    struct npc_cult_fanaticAI : public ScriptedAI
    {
        npc_cult_fanaticAI(Creature* creature) : ScriptedAI(creature) {}

        EventMap events;

        void Reset()
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_FANATIC_NECROTIC_STRIKE, urand(10000, 12000));
            events.ScheduleEvent(EVENT_SPELL_FANATIC_SHADOW_CLEAVE, urand(14000, 16000));
            events.ScheduleEvent(EVENT_SPELL_FANATIC_VAMPIRIC_MIGHT, urand(20000, 27000));
            if (me->GetEntry() == NPC_CULT_FANATIC)
                events.ScheduleEvent(EVENT_SPELL_CULTIST_DARK_MARTYRDOM, urand(15000, 32000));
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
        {
            if (spell->Id == SPELL_DARK_TRANSFORMATION)
                me->UpdateEntry(NPC_DEFORMED_FANATIC);
            else if (spell->Id == SPELL_DARK_TRANSFORMATION_T)
            {
                events.CancelEvent(EVENT_SPELL_CULTIST_DARK_MARTYRDOM);
                me->InterruptNonMeleeSpells(true);
                me->CastSpell(me, SPELL_DARK_TRANSFORMATION, false);
            }
        }

        void DoAction(int32 a)
        {
            if (a == -1)
            {
                me->SetControlled(true, UNIT_STATE_STUNNED);
                me->SetReactState(REACT_PASSIVE);
                me->GetMotionMaster()->MoveIdle();
                me->StopMoving();
                events.Reset();
                events.ScheduleEvent(EVENT_CULTIST_DARK_MARTYRDOM_SELF_KILL, 500);
            }
        }

        void EnterCombat(Unit*  /*who*/) { DoZoneInCombat(); }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_FANATIC_NECROTIC_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_NECROTIC_STRIKE, false);
                    events.RepeatEvent(urand(11000, 13000));
                    break;
                case EVENT_SPELL_FANATIC_SHADOW_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_CLEAVE, false);
                    events.RepeatEvent(urand(9500, 11000));
                    break;
                case EVENT_SPELL_FANATIC_VAMPIRIC_MIGHT:
                    me->CastSpell(me, SPELL_VAMPIRIC_MIGHT, false);
                    events.RepeatEvent(urand(20000, 27000));
                    break;
                case EVENT_SPELL_CULTIST_DARK_MARTYRDOM:
                    me->CastSpell(me, SPELL_DARK_MARTYRDOM_FANATIC, false);
                    events.RepeatEvent(urand(16000, 21000));
                    break;
                case EVENT_CULTIST_DARK_MARTYRDOM_SELF_KILL:
                    Unit::Kill(me, me);
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetIcecrownCitadelAI<npc_cult_fanaticAI>(creature);
    }
};

class npc_cult_adherent : public CreatureScript
{
public:
    npc_cult_adherent() : CreatureScript("npc_cult_adherent") { }

    struct npc_cult_adherentAI : public ScriptedAI
    {
        npc_cult_adherentAI(Creature* creature) : ScriptedAI(creature) {}

        EventMap events;

        void Reset()
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_ADHERENT_FROST_FEVER, urand(10000, 12000));
            events.ScheduleEvent(EVENT_SPELL_ADHERENT_DEATHCHILL, urand(14000, 16000));
            events.ScheduleEvent(EVENT_SPELL_ADHERENT_CURSE_OF_TORPOR, urand(14000, 16000));
            events.ScheduleEvent(EVENT_SPELL_ADHERENT_SHORUD_OF_THE_OCCULT, urand(32000, 39000));
            if (me->GetEntry() == NPC_CULT_ADHERENT)
                events.ScheduleEvent(EVENT_SPELL_CULTIST_DARK_MARTYRDOM, urand(15000, 32000));
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
        {
            if (spell->Id == SPELL_DARK_EMPOWERMENT)
                me->UpdateEntry(NPC_EMPOWERED_ADHERENT);
            else if (spell->Id == SPELL_DARK_EMPOWERMENT_T)
            {
                events.CancelEvent(EVENT_SPELL_CULTIST_DARK_MARTYRDOM);
                me->InterruptNonMeleeSpells(true);
                me->CastSpell(me, SPELL_DARK_EMPOWERMENT, false);
            }
        }

        void DoAction(int32 a)
        {
            if (a == -1)
            {
                me->SetControlled(true, UNIT_STATE_STUNNED);
                me->SetReactState(REACT_PASSIVE);
                me->GetMotionMaster()->MovementExpired();
                me->GetMotionMaster()->MoveIdle();
                me->StopMoving();
                events.Reset();
                events.ScheduleEvent(EVENT_CULTIST_DARK_MARTYRDOM_SELF_KILL, 500);
            }
        }

        void EnterCombat(Unit*  /*who*/) { DoZoneInCombat(); }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_ADHERENT_FROST_FEVER:
                    me->CastSpell(me->GetVictim(), SPELL_FROST_FEVER, false);
                    events.RepeatEvent(urand(9000, 13000));
                    break;
                case EVENT_SPELL_ADHERENT_DEATHCHILL:
                    if (me->GetEntry() == NPC_EMPOWERED_ADHERENT)
                        me->CastSpell(me->GetVictim(), SPELL_DEATHCHILL_BLAST, false);
                    else
                        me->CastSpell(me->GetVictim(), SPELL_DEATHCHILL_BOLT, false);
                    events.RepeatEvent(urand(9000, 13000));
                    break;
                case EVENT_SPELL_ADHERENT_CURSE_OF_TORPOR:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                        me->CastSpell(target, SPELL_CURSE_OF_TORPOR, false);
                    events.RepeatEvent(urand(9000, 13000));
                    break;
                case EVENT_SPELL_ADHERENT_SHORUD_OF_THE_OCCULT:
                    me->CastSpell(me, SPELL_SHORUD_OF_THE_OCCULT, false);
                    events.RepeatEvent(urand(27000, 32000));
                    break;
                case EVENT_SPELL_CULTIST_DARK_MARTYRDOM:
                    me->CastSpell(me, SPELL_DARK_MARTYRDOM_ADHERENT, false);
                    events.RepeatEvent(urand(16000, 21000));
                    break;
                case EVENT_CULTIST_DARK_MARTYRDOM_SELF_KILL:
                    Unit::Kill(me, me);
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetIcecrownCitadelAI<npc_cult_adherentAI>(creature);
    }
};

class npc_vengeful_shade : public CreatureScript
{
public:
    npc_vengeful_shade() : CreatureScript("npc_vengeful_shade") { }

    struct npc_vengeful_shadeAI : public ScriptedAI
    {
        npc_vengeful_shadeAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetControlled(true, UNIT_STATE_ROOT);
            unroot_timer = 500;
            targetGUID = 0;
        }

        uint16 unroot_timer;
        uint64 targetGUID;

        void Reset()
        {
            me->setAttackTimer(BASE_ATTACK, 2000);
            me->AddAura(SPELL_VENGEFUL_BLAST_PASSIVE, me);
        }

        void AttackStart(Unit* who)
        {
            if (!who)
                return;
            ScriptedAI::AttackStart(who);
            if (!targetGUID)
            {
                me->getThreatManager().resetAllAggro();
                me->AddThreat(who, 1000000.0f);
                targetGUID = who->GetGUID();
            }
        }

        void SpellHitTarget(Unit* /*target*/, SpellInfo const* spell)
        {
            switch (spell->Id)
            {
                case SPELL_VENGEFUL_BLAST_10N:
                case SPELL_VENGEFUL_BLAST_25N:
                case SPELL_VENGEFUL_BLAST_10H:
                case SPELL_VENGEFUL_BLAST_25H:
                    me->GetMotionMaster()->MovementExpired();
                    me->StopMoving();
                    me->SetControlled(true, UNIT_STATE_STUNNED);
                    me->DespawnOrUnsummon(500);
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (unroot_timer)
            {
                if (unroot_timer <= diff)
                {
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    me->SetInCombatWithZone();
                    unroot_timer = 0;
                }
                else
                {
                    unroot_timer -= diff;
                    return;
                }
            }

            UpdateVictim();

            if (!me->GetVictim() || me->GetVictim()->GetGUID() != targetGUID)
            {
                me->DespawnOrUnsummon(1);
                return;
            }

            DoMeleeAttackIfReady();
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}
        void EnterEvadeMode() {}
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetIcecrownCitadelAI<npc_vengeful_shadeAI>(creature);
    }
};

class npc_darnavan : public CreatureScript
{
public:
    npc_darnavan() : CreatureScript("npc_darnavan") { }

    struct npc_darnavanAI : public ScriptedAI
    {
        npc_darnavanAI(Creature* creature) : ScriptedAI(creature) {}

        EventMap events;
        bool _canCharge;
        bool _canShatter;

        void Reset()
        {
            events.Reset();
            events.ScheduleEvent(EVENT_DARNAVAN_BLADESTORM, 10000);
            events.ScheduleEvent(EVENT_DARNAVAN_INTIMIDATING_SHOUT, urand(20000, 25000));
            events.ScheduleEvent(EVENT_DARNAVAN_MORTAL_STRIKE, urand(25000, 30000));
            events.ScheduleEvent(EVENT_DARNAVAN_SUNDER_ARMOR, urand(5000, 8000));
            _canCharge = true;
            _canShatter = true;
        }

        void JustDied(Unit* killer)
        {
            events.Reset();
            if (Player* owner = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                if (Group* group = owner->GetGroup())
                {
                    for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
                        if (Player* member = itr->GetSource())
                            if (member->IsInMap(owner))
                                member->FailQuest(QUEST_DEPROGRAMMING);
                }
                else
                    owner->FailQuest(QUEST_DEPROGRAMMING);
            }
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE || id != POINT_DESPAWN)
                return;

            me->DespawnOrUnsummon();
        }

        void EnterCombat(Unit* /*victim*/)
        {
            DoZoneInCombat();
            Talk(SAY_DARNAVAN_AGGRO);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (_canShatter && me->GetVictim() && me->GetVictim()->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_NORMAL))
            {
                me->CastSpell(me->GetVictim(), SPELL_SHATTERING_THROW, false);
                _canShatter = false;
                events.ScheduleEvent(EVENT_DARNAVAN_SHATTERING_THROW, 30000);
                return;
            }

            if (_canCharge && !me->IsWithinMeleeRange(me->GetVictim()))
            {
                me->CastSpell(me->GetVictim(), SPELL_CHARGE, false);
                _canCharge = false;
                events.ScheduleEvent(EVENT_DARNAVAN_CHARGE, 20000);
                return;
            }

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_DARNAVAN_BLADESTORM:
                    me->CastSpell((Unit*)NULL, SPELL_BLADESTORM, false);
                    events.RepeatEvent(urand(90000, 100000));
                    break;
                case EVENT_DARNAVAN_CHARGE:
                    _canCharge = true;
                    events.PopEvent();
                    break;
                case EVENT_DARNAVAN_INTIMIDATING_SHOUT:
                    me->CastSpell((Unit*)NULL, SPELL_INTIMIDATING_SHOUT, false);
                    events.RepeatEvent(urand(90000, 120000));
                    break;
                case EVENT_DARNAVAN_MORTAL_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
                    events.RepeatEvent(urand(15000, 30000));
                    break;
                case EVENT_DARNAVAN_SHATTERING_THROW:
                    _canShatter = true;
                    events.PopEvent();
                    break;
                case EVENT_DARNAVAN_SUNDER_ARMOR:
                    me->CastSpell(me->GetVictim(), SPELL_SUNDER_ARMOR, false);
                    events.RepeatEvent(urand(3000, 7000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetIcecrownCitadelAI<npc_darnavanAI>(creature);
    }
};

class spell_deathwhisper_mana_barrier : public SpellScriptLoader
{
    public:
        spell_deathwhisper_mana_barrier() : SpellScriptLoader("spell_deathwhisper_mana_barrier") { }

        class spell_deathwhisper_mana_barrier_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_deathwhisper_mana_barrier_AuraScript);

            void HandlePeriodicTick(AuraEffect const* /*aurEff*/)
            {
                PreventDefaultAction();
                if (Unit* caster = GetCaster())
                {
                    int32 missingHealth = int32(caster->GetMaxHealth() - caster->GetHealth());
                    caster->ModifyHealth(missingHealth);
                    caster->ModifyPower(POWER_MANA, -missingHealth);
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_deathwhisper_mana_barrier_AuraScript::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_deathwhisper_mana_barrier_AuraScript();
        }
};

class spell_cultist_dark_martyrdom : public SpellScriptLoader
{
public:
    spell_cultist_dark_martyrdom() : SpellScriptLoader("spell_cultist_dark_martyrdom") { }

    class spell_cultist_dark_martyrdom_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_cultist_dark_martyrdom_SpellScript);

        void HandleEffect(SpellEffIndex /*effIndex*/)
        {
            if (GetCaster()->ToTempSummon())
                if (Unit* owner = GetCaster()->ToTempSummon()->GetSummoner())
                    owner->GetAI()->SetGUID(GetCaster()->GetGUID());

            if (Creature* caster = GetCaster()->ToCreature())
                caster->AI()->DoAction(-1);
            GetCaster()->SetDisplayId(GetCaster()->GetEntry() == NPC_CULT_FANATIC ? 30968 : 30966);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_cultist_dark_martyrdom_SpellScript::HandleEffect, EFFECT_2, SPELL_EFFECT_FORCE_DESELECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_cultist_dark_martyrdom_SpellScript();
    }
};

class at_lady_deathwhisper_entrance : public AreaTriggerScript
{
public:
    at_lady_deathwhisper_entrance() : AreaTriggerScript("at_lady_deathwhisper_entrance") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            if (instance->GetBossState(DATA_LADY_DEATHWHISPER) != DONE)
                if (!player->IsGameMaster())
                    if (Creature* ladyDeathwhisper = ObjectAccessor::GetCreature(*player, instance->GetData64(DATA_LADY_DEATHWHISPER)))
                        ladyDeathwhisper->AI()->DoAction(ACTION_START_INTRO);
        return true;
    }
};

void AddSC_boss_lady_deathwhisper()
{
    new boss_lady_deathwhisper();
    new npc_cult_fanatic();
    new npc_cult_adherent();
    new npc_vengeful_shade();
    new npc_darnavan();
    new spell_deathwhisper_mana_barrier();
    new spell_cultist_dark_martyrdom();
    new at_lady_deathwhisper_entrance();
}
