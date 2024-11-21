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

#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "Group.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScriptLoader.h"
#include "icecrown_citadel.h"
#include <random>

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
    SPELL_SHADOW_CHANNELING           = 43897, // during intro
    SPELL_MANA_BARRIER                = 70842,
    SPELL_DEATH_AND_DECAY             = 71001,
    SPELL_DOMINATE_MIND_25            = 71289,
    SPELL_SHADOW_BOLT                 = 71254,
    SPELL_DARK_MARTYRDOM_T            = 70897,
    SPELL_DARK_TRANSFORMATION_T       = 70895,
    SPELL_DARK_EMPOWERMENT_T          = 70896,
    SPELL_FROSTBOLT                   = 71420,
    SPELL_FROSTBOLT_VOLLEY            = 72905,
    SPELL_TOUCH_OF_INSIGNIFICANCE     = 71204,
    SPELL_SUMMON_SHADE                = 71363,

    // Fanatics
    SPELL_NECROTIC_STRIKE             = 70659,
    SPELL_SHADOW_CLEAVE               = 70670,
    SPELL_VAMPIRIC_MIGHT              = 70674,
    SPELL_DARK_MARTYRDOM_FANATIC      = 71236,
    SPELL_DARK_MARTYRDOM_FANATIC_25N  = 72495,
    SPELL_DARK_MARTYRDOM_FANATIC_10H  = 72496,
    SPELL_DARK_MARTYRDOM_FANATIC_25H  = 72497,
    SPELL_FANATIC_S_DETERMINATION     = 71235,
    SPELL_DARK_TRANSFORMATION         = 70900,

    //  Adherents
    SPELL_FROST_FEVER                 = 67767,
    SPELL_DEATHCHILL_BOLT             = 70594,
    SPELL_DEATHCHILL_BLAST            = 70906,
    SPELL_CURSE_OF_TORPOR             = 71237,
    SPELL_SHORUD_OF_THE_OCCULT        = 70768,
    SPELL_DARK_MARTYRDOM_ADHERENT     = 70903,
    SPELL_DARK_MARTYRDOM_ADHERENT_25N = 72498,
    SPELL_DARK_MARTYRDOM_ADHERENT_10H = 72499,
    SPELL_DARK_MARTYRDOM_ADHERENT_25H = 72500,
    SPELL_ADHERENT_S_DETERMINATION    = 71234,
    SPELL_DARK_EMPOWERMENT            = 70901,

    // Vengeful Shade
    SPELL_VENGEFUL_BLAST_PASSIVE      = 71494,
    SPELL_VENGEFUL_BLAST_10N          = 71544,
    SPELL_VENGEFUL_BLAST_25N          = 72010,
    SPELL_VENGEFUL_BLAST_10H          = 72011,
    SPELL_VENGEFUL_BLAST_25H          = 72012,

    // Darnavan
    SPELL_BLADESTORM                  = 65947,
    SPELL_CHARGE                      = 65927,
    SPELL_INTIMIDATING_SHOUT          = 65930,
    SPELL_MORTAL_STRIKE               = 65926,
    SPELL_SHATTERING_THROW            = 65940,
    SPELL_SUNDER_ARMOR                = 65936,

    // misc
    SPELL_FULL_HOUSE                  = 72827, // achievement
    SPELL_TELEPORT_VISUAL             = 52096, // used by adds
    SPELL_CLEAR_ALL_DEBUFFS           = 34098,
    SPELL_FULL_HEAL                   = 17683,
    SPELL_PERMANENT_FEIGN_DEATH       = 70628,
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
    EVENT_EMPOWER_CULTIST,

    // Phase 2:
    EVENT_SPELL_FROSTBOLT,
    EVENT_SPELL_FROSTBOLT_VOLLEY,
    EVENT_SPELL_TOUCH_OF_INSIGNIFICANCE,
    EVENT_SPELL_SUMMON_SHADE,
    EVENT_SUMMON_WAVE_P2,

    // Shared adds events:
    EVENT_SPELL_CULTIST_DARK_MARTYRDOM,
    EVENT_CULTIST_DARK_MARTYRDOM_REVIVE,

    // Cult Fanatic:
    EVENT_SPELL_FANATIC_NECROTIC_STRIKE,
    EVENT_SPELL_FANATIC_SHADOW_CLEAVE,
    EVENT_SPELL_FANATIC_VAMPIRIC_MIGHT,

    // Cult Adherent:
    EVENT_SPELL_ADHERENT_FROST_FEVER,
    EVENT_SPELL_ADHERENT_DEATHCHILL,
    EVENT_SPELL_ADHERENT_CURSE_OF_TORPOR,
    EVENT_SPELL_ADHERENT_SHROUD_OF_THE_OCCULT,

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

    PHASE_INTRO_MASK    = 1 << (PHASE_INTRO - 1),
    PHASE_ONE_MASK      = 1 << (PHASE_ONE - 1),
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

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        _darnavan.GetMotionMaster()->MovePoint(POINT_DESPAWN, SummonPositions[6]);
        return true;
    }

private:
    Creature& _darnavan;
};

void ApplyMechanicImmune(Creature* c, bool apply)
{
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FEAR, apply);
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_INTERRUPT, apply);
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_KNOCKOUT, apply);
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SILENCE, apply);
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_STUN, apply);
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, apply);
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, apply);
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SLEEP, apply);
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FREEZE, apply);
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_HORROR, apply);
    c->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_CHARM, apply);
}

class boss_lady_deathwhisper : public CreatureScript
{
public:
    boss_lady_deathwhisper() : CreatureScript("boss_lady_deathwhisper") { }

    struct boss_lady_deathwhisperAI : public BossAI
    {
        boss_lady_deathwhisperAI(Creature* creature) : BossAI(creature, DATA_LADY_DEATHWHISPER), _introDone(false) { }

        void Reset() override
        {
            if (Creature* darnavan = ObjectAccessor::GetCreature(*me, _darnavanGUID))
                darnavan->DespawnOrUnsummon();
            _darnavanGUID.Clear();
            _waveCounter = 0;
            _Reset();
            me->SetPower(POWER_MANA, me->GetMaxPower(POWER_MANA));
            events.SetPhase(PHASE_ONE);
            me->CastSpell(me, SPELL_SHADOW_CHANNELING, false);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, false);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, false);
        }

        void AttackStart(Unit* victim) override
        {
            if (victim && me->Attack(victim, true) && !(events.GetPhaseMask() & PHASE_ONE_MASK))
                me->GetMotionMaster()->MoveChase(victim);
        }

        void JustEngagedWith(Unit* who) override
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
            events.ScheduleEvent(EVENT_BERSERK, 10min);
            events.ScheduleEvent(EVENT_SPELL_DEATH_AND_DECAY, 10s);
            if (GetDifficulty() != RAID_DIFFICULTY_10MAN_NORMAL)
                events.ScheduleEvent(EVENT_SPELL_DOMINATE_MIND_25, 30s);
            events.ScheduleEvent(EVENT_SPELL_SHADOW_BOLT, 2s, 0, PHASE_ONE);
            events.ScheduleEvent(EVENT_SUMMON_WAVE_P1, 5s, 0, PHASE_ONE);
            events.ScheduleEvent(EVENT_EMPOWER_CULTIST, 20s, 30s, 0, PHASE_ONE);

            Talk(SAY_AGGRO);
            me->RemoveAurasDueToSpell(SPELL_SHADOW_CHANNELING);
            me->CastSpell(me, SPELL_MANA_BARRIER, true);

            instance->SetBossState(DATA_LADY_DEATHWHISPER, IN_PROGRESS);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (events.GetPhaseMask() & PHASE_ONE_MASK && damage >= me->GetPower(POWER_MANA))
            {
                // reset threat
                ThreatContainer::StorageType const& threatlist = me->GetThreatMgr().GetThreatList();
                for (ThreatContainer::StorageType::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
                {
                    Unit* unit = ObjectAccessor::GetUnit((*me), (*itr)->getUnitGuid());

                    if (unit && DoGetThreat(unit))
                        DoModifyThreatByPercent(unit, -100);
                }

                Talk(SAY_PHASE_2);
                Talk(EMOTE_PHASE_2);
                DoStartMovement(me->GetVictim());
                damage -= me->GetPower(POWER_MANA);
                me->SetPower(POWER_MANA, 0);
                me->RemoveAurasDueToSpell(SPELL_MANA_BARRIER);
                events.SetPhase(PHASE_TWO);
                events.ScheduleEvent(EVENT_SPELL_FROSTBOLT, 10s, 12s, 0, PHASE_TWO);
                events.ScheduleEvent(EVENT_SPELL_FROSTBOLT_VOLLEY, 19s, 21s, 0, PHASE_TWO);
                events.ScheduleEvent(EVENT_SPELL_TOUCH_OF_INSIGNIFICANCE, 6s, 9s, 0, PHASE_TWO);
                events.ScheduleEvent(EVENT_SPELL_SUMMON_SHADE, 12s, 15s, 0, PHASE_TWO);
                if (IsHeroic())
                {
                    me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
                    me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);
                    events.ScheduleEvent(EVENT_SUMMON_WAVE_P2, 45s, 0, PHASE_TWO);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() && !(events.GetPhaseMask() & PHASE_INTRO_MASK))
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING) && !(events.GetPhaseMask() & PHASE_INTRO_MASK))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_INTRO_2:
                    Talk(SAY_INTRO_2);
                    break;
                case EVENT_INTRO_3:
                    Talk(SAY_INTRO_3);
                    break;
                case EVENT_INTRO_4:
                    Talk(SAY_INTRO_4);
                    break;
                case EVENT_INTRO_5:
                    Talk(SAY_INTRO_5);
                    break;
                case EVENT_INTRO_6:
                    Talk(SAY_INTRO_6);
                    break;
                case EVENT_INTRO_7:
                    Talk(SAY_INTRO_7);
                    break;
                case EVENT_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    Talk(SAY_BERSERK);
                    break;
                case EVENT_SPELL_DEATH_AND_DECAY:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                        me->CastSpell(target, SPELL_DEATH_AND_DECAY, false);
                    events.Repeat(22s, 30s);
                    break;
                case EVENT_SPELL_DOMINATE_MIND_25:
                    {
                        Talk(SAY_DOMINATE_MIND);

                        std::vector<Player*> validPlayers;
                        Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                            if (Player* plr = itr->GetSource())
                                if (plr->IsAlive() && !plr->IsGameMaster() && plr->GetExactDist2dSq(me) < (150.0f * 150.0f))
                                    if (!me->GetVictim() || me->GetVictim()->GetGUID() != plr->GetGUID())
                                    {
                                        // shouldn't be casted on any victim of summoned mobs
                                        bool valid = true;
                                        for (ObjectGuid const& guid : summons)
                                            if (Creature* c = ObjectAccessor::GetCreature(*me, guid))
                                                if (c->IsAlive() && c->GetVictim() && c->GetVictim()->GetGUID() == plr->GetGUID())
                                                {
                                                    valid = false;
                                                    break;
                                                }
                                        if (valid)
                                            validPlayers.push_back(plr);
                                    }

                        std::vector<Player*>::iterator begin = validPlayers.begin(), end = validPlayers.end();

                        std::random_device rd;
                        std::shuffle(begin, end, std::default_random_engine{rd()});

                        for (uint8 i = 0; i < RAID_MODE<uint8>(0, 1, 1, 3) && i < validPlayers.size(); i++)
                        {
                            Unit* target = validPlayers[i];
                            me->CastSpell(target, SPELL_DOMINATE_MIND_25, true);
                        }

                        events.Repeat(40s, 45s);
                    }
                    break;
                case EVENT_SPELL_SHADOW_BOLT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random))
                        me->CastSpell(target, SPELL_SHADOW_BOLT, false);
                    events.Repeat(2100ms);
                    break;
                case EVENT_SUMMON_WAVE_P1:
                    SummonWaveP1();
                    events.Repeat(IsHeroic() ? 45s : 60s);
                    break;
                case EVENT_EMPOWER_CULTIST:
                    EmpowerCultist();
                    events.Repeat(18s, 25s);
                    break;
                case EVENT_SPELL_FROSTBOLT:
                    me->CastSpell(me->GetVictim(), SPELL_FROSTBOLT, false);
                    events.Repeat(12s);
                    break;
                case EVENT_SPELL_FROSTBOLT_VOLLEY:
                    me->CastSpell((Unit*)nullptr, SPELL_FROSTBOLT_VOLLEY, false);
                    events.Repeat(13s, 15s);
                    break;
                case EVENT_SPELL_TOUCH_OF_INSIGNIFICANCE:
                    me->CastSpell(me->GetVictim(), SPELL_TOUCH_OF_INSIGNIFICANCE, false);
                    events.Repeat(6s, 9s);
                    break;
                case EVENT_SUMMON_WAVE_P2:
                    SummonWaveP2();
                    events.Repeat(45s);
                    break;
                case EVENT_SPELL_SUMMON_SHADE:
                    {
                        uint8 count = 1;
                        if (GetDifficulty() == RAID_DIFFICULTY_25MAN_NORMAL)
                            count = 2;
                        else if (GetDifficulty() == RAID_DIFFICULTY_25MAN_HEROIC)
                            count = 3;

                        std::list<Unit*> targets;
                        SelectTargetList(targets, count, SelectTargetMethod::Random, 0, NonTankTargetSelector(me, true));
                        if (!targets.empty())
                            for (std::list<Unit*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                                me->CastSpell(*itr, SPELL_SUMMON_SHADE, true);
                    }
                    events.Repeat(12s);
                    break;
            }

            if (me->HasAura(SPELL_MANA_BARRIER))
                return;

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_DARNAVAN)
                _darnavanGUID = summon->GetGUID();
            else
                summons.Summon(summon);

            Unit* target = nullptr;
            if (summon->GetEntry() == NPC_VENGEFUL_SHADE)
            {
                float minrange = 250.0f;
                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                    if (Player* p = itr->GetSource())
                        if (p != me->GetVictim() && summon->GetExactDist(p) < minrange && me->CanCreatureAttack(p))
                        {
                            target = p;
                            minrange = summon->GetExactDist(p);
                        }

                summon->ToTempSummon()->DespawnOrUnsummon(30000);
            }
            else
            {
                target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true);
            }

            summon->AI()->AttackStart(target);
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            summons.Despawn(summon);
        }

        void JustDied(Unit* killer) override
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
                    darnavan->SetFaction(FACTION_FRIENDLY);
                    darnavan->GetThreatMgr().ClearAllThreat();
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
                            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                                if (Player* member = itr->GetSource())
                                    if (member->IsInMap(owner))
                                        member->KilledMonsterCredit(NPC_DARNAVAN_CREDIT);
                        }
                        else
                            owner->KilledMonsterCredit(NPC_DARNAVAN_CREDIT);
                    }
                }
            }

            _JustDied();
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer())
                Talk(SAY_KILL);
        }

        void DoAction(int32 action) override
        {
            if (action != ACTION_START_INTRO)
                return;

            if (!_introDone && !me->IsInCombat())
            {
                _introDone = true;
                Talk(SAY_INTRO_1);
                events.SetPhase(PHASE_INTRO);
                events.ScheduleEvent(EVENT_INTRO_2, 11s, 0, PHASE_INTRO);
                events.ScheduleEvent(EVENT_INTRO_3, 21s, 0, PHASE_INTRO);
                events.ScheduleEvent(EVENT_INTRO_4, 31s + 500ms, 0, PHASE_INTRO);
                events.ScheduleEvent(EVENT_INTRO_5, 39s + 500ms, 0, PHASE_INTRO);
                events.ScheduleEvent(EVENT_INTRO_6, 48s + 500ms, 0, PHASE_INTRO);
                events.ScheduleEvent(EVENT_INTRO_7, 58s, 0, PHASE_INTRO);
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
                Summon(SummonEntries[addIndex], SummonPositions[addIndex * 3 + 2]);
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
                    trigger->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    trigger->CastSpell(trigger, SPELL_TELEPORT_VISUAL, true);
                }
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
            Creature* cultist = Acore::Containers::SelectRandomContainerElement(temp);
            if (!cultist)
                return;

            if (RAND(0, 1))
                me->CastSpell(cultist, SPELL_DARK_MARTYRDOM_T);
            else
            {
                me->CastSpell(cultist, cultist->GetEntry() == NPC_CULT_FANATIC ? SPELL_DARK_TRANSFORMATION_T : SPELL_DARK_EMPOWERMENT_T, true);
                Talk(uint8(cultist->GetEntry() == NPC_CULT_FANATIC ? SAY_DARK_TRANSFORMATION : SAY_DARK_EMPOWERMENT));
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_DOMINATE_MIND_25)
            {
                const int32 val = 100;
                target->CastCustomSpell(target, 73261, &val, nullptr, nullptr, true); // scale aura, +100% size
            }
        }

    private:
        bool _introDone;
        ObjectGuid _darnavanGUID;
        uint32 _waveCounter;
    };

    CreatureAI* GetAI(Creature* creature) const override
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
        npc_cult_fanaticAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()) {}

        EventMap events;
        InstanceScript* _instance;

        void Reset() override
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_FANATIC_NECROTIC_STRIKE, 10s, 12s);
            events.ScheduleEvent(EVENT_SPELL_FANATIC_SHADOW_CLEAVE, 14s, 16s);
            events.ScheduleEvent(EVENT_SPELL_FANATIC_VAMPIRIC_MIGHT, 20s, 27s);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            switch (spell->Id)
            {
                case SPELL_DARK_TRANSFORMATION:
                    me->UpdateEntry(NPC_DEFORMED_FANATIC);
                    break;
                case SPELL_DARK_TRANSFORMATION_T:
                    me->InterruptNonMeleeSpells(true);
                    me->CastSpell(me, SPELL_DARK_TRANSFORMATION, false);
                    break;
                case SPELL_DARK_MARTYRDOM_T:
                    me->SetReactState(REACT_PASSIVE);
                    me->InterruptNonMeleeSpells(true);
                    ApplyMechanicImmune(me, true);
                    me->AttackStop();
                    me->GetMotionMaster()->MovementExpired();
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMoving();
                    me->CastSpell(me, SPELL_DARK_MARTYRDOM_FANATIC, false);
                    break;
                case SPELL_DARK_MARTYRDOM_FANATIC:
                case SPELL_DARK_MARTYRDOM_FANATIC_10H:
                case SPELL_DARK_MARTYRDOM_FANATIC_25N:
                case SPELL_DARK_MARTYRDOM_FANATIC_25H:
                    ApplyMechanicImmune(me, false);
                    events.ScheduleEvent(EVENT_SPELL_CULTIST_DARK_MARTYRDOM, 5ms); // Visual purposes only.
                    break;
            }
        }

        void JustEngagedWith(Unit*  /*who*/) override { DoZoneInCombat(); }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_FANATIC_NECROTIC_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_NECROTIC_STRIKE, false);
                    events.Repeat(11s, 13s);
                    break;
                case EVENT_SPELL_FANATIC_SHADOW_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_CLEAVE, false);
                    events.Repeat(9500ms, 11s);
                    break;
                case EVENT_SPELL_FANATIC_VAMPIRIC_MIGHT:
                    me->CastSpell(me, SPELL_VAMPIRIC_MIGHT, false);
                    events.Repeat(20s, 27s);
                    break;
                case EVENT_CULTIST_DARK_MARTYRDOM_REVIVE:
                    me->RemoveAurasDueToSpell(SPELL_PERMANENT_FEIGN_DEATH);
                    me->RemoveDynamicFlag(UNIT_DYNFLAG_DEAD);
                    me->RemoveUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
                    me->UpdateEntry(NPC_REANIMATED_FANATIC);
                    me->RemoveUnitFlag(UNIT_FLAG_STUNNED | UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT | UNIT_FLAG_NOT_SELECTABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    DoZoneInCombat(me);
                    me->CastSpell(me, SPELL_FANATIC_S_DETERMINATION);

                    if (Creature* ladyDeathwhisper = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_LADY_DEATHWHISPER)))
                        ladyDeathwhisper->AI()->Talk(SAY_ANIMATE_DEAD);
                    break;
                case EVENT_SPELL_CULTIST_DARK_MARTYRDOM:
                    me->CastSpell(me, SPELL_PERMANENT_FEIGN_DEATH, true);
                    me->CastSpell(me, SPELL_CLEAR_ALL_DEBUFFS, true);
                    me->CastSpell(me, SPELL_FULL_HEAL, true);
                    me->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
                    me->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
                    me->SetUnitFlag(UNIT_FLAG_STUNNED | UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT | UNIT_FLAG_NOT_SELECTABLE);
                    Reset();
                    events.ScheduleEvent(EVENT_CULTIST_DARK_MARTYRDOM_REVIVE, 6s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
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
        npc_cult_adherentAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()) {}

        EventMap events;
        InstanceScript* _instance;

        void Reset() override
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_ADHERENT_FROST_FEVER, 10s, 12s);
            events.ScheduleEvent(EVENT_SPELL_ADHERENT_DEATHCHILL, 14s, 16s);
            events.ScheduleEvent(EVENT_SPELL_ADHERENT_CURSE_OF_TORPOR, 14s, 16s);
            events.ScheduleEvent(EVENT_SPELL_ADHERENT_SHROUD_OF_THE_OCCULT, 32s, 39s);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            switch (spell->Id)
            {
                case SPELL_DARK_EMPOWERMENT:
                    me->UpdateEntry(NPC_EMPOWERED_ADHERENT);
                    break;
                case SPELL_DARK_EMPOWERMENT_T:
                    me->InterruptNonMeleeSpells(true);
                    me->CastSpell(me, SPELL_DARK_EMPOWERMENT, false);
                    break;
                case SPELL_DARK_MARTYRDOM_T:
                    me->SetReactState(REACT_PASSIVE);
                    me->InterruptNonMeleeSpells(true);
                    ApplyMechanicImmune(me, true);
                    me->AttackStop();
                    me->GetMotionMaster()->MovementExpired();
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMoving();
                    me->CastSpell(me, SPELL_DARK_MARTYRDOM_ADHERENT, false);
                    break;
                case SPELL_DARK_MARTYRDOM_ADHERENT:
                case SPELL_DARK_MARTYRDOM_ADHERENT_10H:
                case SPELL_DARK_MARTYRDOM_ADHERENT_25N:
                case SPELL_DARK_MARTYRDOM_ADHERENT_25H:
                    ApplyMechanicImmune(me, false);
                    events.ScheduleEvent(EVENT_SPELL_CULTIST_DARK_MARTYRDOM, 5ms); // Visual purposes only.
                    break;
            }
        }

        void JustEngagedWith(Unit*  /*who*/) override { DoZoneInCombat(); }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_ADHERENT_FROST_FEVER:
                    me->CastSpell(me->GetVictim(), SPELL_FROST_FEVER, false);
                    events.Repeat(9s, 13s);
                    break;
                case EVENT_SPELL_ADHERENT_DEATHCHILL:
                    if (me->GetEntry() == NPC_EMPOWERED_ADHERENT)
                        me->CastSpell(me->GetVictim(), SPELL_DEATHCHILL_BLAST, false);
                    else
                        me->CastSpell(me->GetVictim(), SPELL_DEATHCHILL_BOLT, false);
                    events.Repeat(9s, 13s);
                    break;
                case EVENT_SPELL_ADHERENT_CURSE_OF_TORPOR:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
                        me->CastSpell(target, SPELL_CURSE_OF_TORPOR, false);
                    events.Repeat(9s, 13s);
                    break;
                case EVENT_SPELL_ADHERENT_SHROUD_OF_THE_OCCULT:
                    me->CastSpell(me, SPELL_SHORUD_OF_THE_OCCULT, false);
                    events.Repeat(27s, 32s);
                    break;
                case EVENT_CULTIST_DARK_MARTYRDOM_REVIVE:
                    me->RemoveAurasDueToSpell(SPELL_PERMANENT_FEIGN_DEATH);
                    me->RemoveDynamicFlag(UNIT_DYNFLAG_DEAD);
                    me->RemoveUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
                    me->UpdateEntry(NPC_REANIMATED_ADHERENT);
                    me->RemoveUnitFlag(UNIT_FLAG_STUNNED | UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT | UNIT_FLAG_NOT_SELECTABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    DoZoneInCombat(me);
                    me->CastSpell(me, SPELL_ADHERENT_S_DETERMINATION);

                    if (Creature* ladyDeathwhisper = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_LADY_DEATHWHISPER)))
                        ladyDeathwhisper->AI()->Talk(SAY_ANIMATE_DEAD);
                    break;
                case EVENT_SPELL_CULTIST_DARK_MARTYRDOM:
                    me->CastSpell(me, SPELL_PERMANENT_FEIGN_DEATH, true);
                    me->CastSpell(me, SPELL_CLEAR_ALL_DEBUFFS, true);
                    me->CastSpell(me, SPELL_FULL_HEAL, true);
                    me->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
                    me->SetUnitFlag2(UNIT_FLAG2_FEIGN_DEATH);
                    me->SetUnitFlag(UNIT_FLAG_STUNNED | UNIT_FLAG_PREVENT_EMOTES_FROM_CHAT_TEXT | UNIT_FLAG_NOT_SELECTABLE);
                    Reset();
                    events.ScheduleEvent(EVENT_CULTIST_DARK_MARTYRDOM_REVIVE, 6s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
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
            targetGUID.Clear();
        }

        uint16 unroot_timer;
        ObjectGuid targetGUID;

        void Reset() override
        {
            me->setAttackTimer(BASE_ATTACK, 2000);
            me->AddAura(SPELL_VENGEFUL_BLAST_PASSIVE, me);
        }

        void AttackStart(Unit* who) override
        {
            if (!who)
                return;
            ScriptedAI::AttackStart(who);
            if (!targetGUID)
            {
                me->GetThreatMgr().ResetAllThreat();
                me->AddThreat(who, 1000000.0f);
                targetGUID = who->GetGUID();
            }
        }

        void SpellHitTarget(Unit* /*target*/, SpellInfo const* spell) override
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

        void UpdateAI(uint32 diff) override
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

        void MoveInLineOfSight(Unit*  /*who*/) override {}
        void EnterEvadeMode(EvadeReason /*why*/ = EVADE_REASON_OTHER) override {}
    };

    CreatureAI* GetAI(Creature* creature) const override
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

        void Reset() override
        {
            events.Reset();
            events.ScheduleEvent(EVENT_DARNAVAN_BLADESTORM, 10s);
            events.ScheduleEvent(EVENT_DARNAVAN_INTIMIDATING_SHOUT, 20s, 25s);
            events.ScheduleEvent(EVENT_DARNAVAN_MORTAL_STRIKE, 25s, 30s);
            events.ScheduleEvent(EVENT_DARNAVAN_SUNDER_ARMOR, 5s, 8s);
            _canCharge = true;
            _canShatter = true;
        }

        void JustDied(Unit* killer) override
        {
            events.Reset();
            if (Player* owner = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                if (Group* group = owner->GetGroup())
                {
                    for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                        if (Player* member = itr->GetSource())
                            if (member->IsInMap(owner))
                                member->FailQuest(QUEST_DEPROGRAMMING);
                }
                else
                    owner->FailQuest(QUEST_DEPROGRAMMING);
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != POINT_DESPAWN)
                return;

            me->DespawnOrUnsummon();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            DoZoneInCombat();
            Talk(SAY_DARNAVAN_AGGRO);
        }

        void UpdateAI(uint32 diff) override
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
                events.ScheduleEvent(EVENT_DARNAVAN_SHATTERING_THROW, 30s);
                return;
            }

            if (_canCharge && !me->IsWithinMeleeRange(me->GetVictim()))
            {
                me->CastSpell(me->GetVictim(), SPELL_CHARGE, false);
                _canCharge = false;
                events.ScheduleEvent(EVENT_DARNAVAN_CHARGE, 20s);
                return;
            }

            switch (events.ExecuteEvent())
            {
                case EVENT_DARNAVAN_BLADESTORM:
                    me->CastSpell((Unit*)nullptr, SPELL_BLADESTORM, false);
                    events.Repeat(90s, 100s);
                    break;
                case EVENT_DARNAVAN_CHARGE:
                    _canCharge = true;
                    break;
                case EVENT_DARNAVAN_INTIMIDATING_SHOUT:
                    me->CastSpell((Unit*)nullptr, SPELL_INTIMIDATING_SHOUT, false);
                    events.Repeat(90s, 120s);
                    break;
                case EVENT_DARNAVAN_MORTAL_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
                    events.Repeat(15s, 30s);
                    break;
                case EVENT_DARNAVAN_SHATTERING_THROW:
                    _canShatter = true;
                    break;
                case EVENT_DARNAVAN_SUNDER_ARMOR:
                    me->CastSpell(me->GetVictim(), SPELL_SUNDER_ARMOR, false);
                    events.Repeat(3s, 7s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_darnavanAI>(creature);
    }
};

class spell_deathwhisper_mana_barrier_aura : public AuraScript
{
    PrepareAuraScript(spell_deathwhisper_mana_barrier_aura);

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

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_deathwhisper_mana_barrier_aura::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 69483 - Dark Reckoning
class spell_deathwhisper_dark_reckoning : public AuraScript
{
    PrepareAuraScript(spell_deathwhisper_dark_reckoning);

    bool Validate(SpellInfo const* spell) override
    {
        return ValidateSpellInfo({ spell->Effects[EFFECT_0].TriggerSpell });
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (Unit* caster = GetCaster())
        {
            uint32 spellId = GetSpellInfo()->Effects[EFFECT_0].TriggerSpell;
            caster->CastSpell(GetTarget(), spellId, aurEff);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_deathwhisper_dark_reckoning::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class at_lady_deathwhisper_entrance : public AreaTriggerScript
{
public:
    at_lady_deathwhisper_entrance() : AreaTriggerScript("at_lady_deathwhisper_entrance") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            if (instance->GetBossState(DATA_LADY_DEATHWHISPER) != DONE)
                if (!player->IsGameMaster())
                    if (Creature* ladyDeathwhisper = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_LADY_DEATHWHISPER)))
                        ladyDeathwhisper->AI()->DoAction(ACTION_START_INTRO);
        return true;
    }
};

void AddSC_boss_lady_deathwhisper()
{
    // Creatures
    new boss_lady_deathwhisper();
    new npc_cult_fanatic();
    new npc_cult_adherent();
    new npc_vengeful_shade();
    new npc_darnavan();

    // Spells
    RegisterSpellScript(spell_deathwhisper_mana_barrier_aura);
    RegisterSpellScript(spell_deathwhisper_dark_reckoning);

    // AreaTriggers
    new at_lady_deathwhisper_entrance();
}
