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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "Player.h"
#include "SpellScriptLoader.h"
#include "zulaman.h"

enum Says
{
    SAY_AGGRO,
    SAY_KILL_ONE,
    SAY_KILL_TWO,
    SAY_DRAIN_POWER,
    SAY_SPIRIT_BOLTS,
    SAY_DEATH
};

enum Creatures
{
    NPC_TEMP_TRIGGER                = 23920,
    NPC_ALYSON_ANTILLE              = 24240,
    NPC_THURG                       = 24241,
    NPC_GAZAKROTH                   = 24244,
    NPC_LORD_RADAAN                 = 24243,
    NPC_DARKHEART                   = 24246,
    NPC_SLITHER                     = 24242,
    NPC_FENSTALKER                  = 24245,
    NPC_KORAGG                      = 24247

};

enum Spells
{
    SPELL_SPIRIT_BOLTS              = 43383,
    SPELL_DRAIN_POWER               = 44131,
    SPELL_SIPHON_SOUL               = 43501,

    // Alyson Antille
    SPELL_ARCANE_TORRENT            = 33390,
    SPELL_DISPEL_MAGIC              = 43577,
    SPELL_FLASH_HEAL                = 43575,

    // Druid
    SPELL_DR_THORNS                 = 43420,
    SPELL_DR_LIFEBLOOM              = 43421,
    SPELL_DR_MOONFIRE               = 43545,

    // Hunter
    SPELL_HU_EXPLOSIVE_TRAP         = 43444,
    SPELL_HU_FREEZING_TRAP          = 43447,
    SPELL_HU_SNAKE_TRAP             = 43449,

    // Mage
    SPELL_MG_FIREBALL               = 41383,
    SPELL_MG_FROST_NOVA             = 43426,
    SPELL_MG_ICE_LANCE              = 43427,
    SPELL_MG_FROSTBOLT              = 43428,

    // Paladin
    SPELL_PA_CONSECRATION           = 43429,
    SPELL_PA_AVENGING_WRATH         = 43430,
    SPELL_PA_HOLY_LIGHT             = 43451,

    // Priest
    SPELL_PR_HEAL                   = 41372,
    SPELL_PR_MIND_BLAST             = 41374,
    SPELL_PR_SW_DEATH               = 41375,
    SPELL_PR_PSYCHIC_SCREAM         = 43432,
    SPELL_PR_MIND_CONTROL           = 43550,
    SPELL_PR_PAIN_SUPP              = 44416,

    // Rogue
    SPELL_RO_BLIND                  = 43433,
    SPELL_RO_SLICE_DICE             = 43547,
    SPELL_RO_WOUND_POISON           = 43461,

    // Shaman
    SPELL_SH_CHAIN_LIGHT            = 43435,
    SPELL_SH_FIRE_NOVA              = 43436,
    SPELL_SH_HEALING_WAVE           = 43548,

    // Warlock
    SPELL_WL_CURSE_OF_DOOM          = 43439,
    SPELL_WL_RAIN_OF_FIRE           = 43440,
    SPELL_WL_UNSTABLE_AFFL          = 43522,
    SPELL_WL_UNSTABLE_AFFL_DISPEL   = 43523,

    // Warrior
    SPELL_WR_MORTAL_STRIKE          = 43441,
    SPELL_WR_WHIRLWIND              = 43442,
    SPELL_WR_SPELL_REFLECT          = 43443,

    // Death Knight
    SPELL_DK_PLAGUE_STRIKE          = 57599,
    SPELL_DK_DEATH_AND_DECAY        = 43265,
    SPELL_DK_BLOOD_WORMS            = 97630
};

const Position AddPosition[4] =
{
    { 128.48448f, 923.04285f, 33.97255f,  1.588249564170837402f },
    { 122.60526f, 923.24536f, 33.97256f,  1.570796370506286621f },
    { 111.69282f, 923.15314f, 33.972576f, 1.570796370506286621f },
    { 105.40299f, 923.3421f,  33.972588f, 1.553343057632446289f }
};

static uint32 AddEntrySets[4][2] =
{
    { NPC_THURG,         NPC_ALYSON_ANTILLE  },
    { NPC_LORD_RADAAN,   NPC_SLITHER         },
    { NPC_GAZAKROTH,     NPC_FENSTALKER      },
    { NPC_DARKHEART,     NPC_KORAGG          }
};

enum Misc
{
    MAX_ADD_COUNT               = 4,
    ADDITIONAL_CLASS_SPRIEST    = 11,
    AURA_SHADOW_FORM            = 15473,
    GROUP_CLASS_ABILITY         = 1,
    GROUP_DRAIN_POWER           = 2
};

enum AbilityTarget
{
    ABILITY_TARGET_SELF    = 0,
    ABILITY_TARGET_VICTIM  = 1,
    ABILITY_TARGET_ENEMY   = 2,
    ABILITY_TARGET_HEAL    = 3,
    ABILITY_TARGET_BUFF    = 4,
    ABILITY_TARGET_SPECIAL = 5
};

struct PlayerAbilityStruct
{
    uint32 spell;
    AbilityTarget target;
    std::chrono::milliseconds cooldown;
};

static PlayerAbilityStruct PlayerAbility[13][3] =
{
    // 0 UNK class (should never be set)
    {
        // Warrior as fallback behavior if for some reason UNK class
        { SPELL_WR_SPELL_REFLECT, ABILITY_TARGET_SELF,   10000ms },
        { SPELL_WR_WHIRLWIND,     ABILITY_TARGET_SELF,   10000ms },
        { SPELL_WR_MORTAL_STRIKE, ABILITY_TARGET_VICTIM, 6000ms  }
    },
    // 1 warrior
    {   { SPELL_WR_SPELL_REFLECT, ABILITY_TARGET_SELF,   10000ms },
        { SPELL_WR_WHIRLWIND,     ABILITY_TARGET_SELF,   10000ms },
        { SPELL_WR_MORTAL_STRIKE, ABILITY_TARGET_VICTIM, 6000ms  }
    },
    // 2 paladin
    {   { SPELL_PA_CONSECRATION,   ABILITY_TARGET_SELF, 10000ms },
        { SPELL_PA_HOLY_LIGHT,     ABILITY_TARGET_HEAL, 10000ms },
        { SPELL_PA_AVENGING_WRATH, ABILITY_TARGET_SELF, 10000ms }
    },
    // 3 hunter
    {   { SPELL_HU_EXPLOSIVE_TRAP, ABILITY_TARGET_SELF, 10000ms },
        { SPELL_HU_FREEZING_TRAP,  ABILITY_TARGET_SELF, 10000ms },
        { SPELL_HU_SNAKE_TRAP,     ABILITY_TARGET_SELF, 10000ms }
    },
    // 4 rogue
    {   { SPELL_RO_WOUND_POISON, ABILITY_TARGET_VICTIM, 3000ms  },
        { SPELL_RO_SLICE_DICE,   ABILITY_TARGET_SELF,   10000ms },
        { SPELL_RO_BLIND,        ABILITY_TARGET_ENEMY,  10000ms }
    },
    // 5 priest
    {   { SPELL_PR_PAIN_SUPP,      ABILITY_TARGET_HEAL, 10000ms },
        { SPELL_PR_HEAL,           ABILITY_TARGET_HEAL, 10000ms },
        { SPELL_PR_PSYCHIC_SCREAM, ABILITY_TARGET_SELF, 10000ms }
    },
    // 6 death knight
    {
        { SPELL_DK_PLAGUE_STRIKE,   ABILITY_TARGET_ENEMY, 2000ms },
        { SPELL_DK_DEATH_AND_DECAY, ABILITY_TARGET_SELF, 10000ms },
        { SPELL_DK_BLOOD_WORMS,     ABILITY_TARGET_ENEMY, 5000ms }
    },
    // 7 shaman
    {   { SPELL_SH_FIRE_NOVA,    ABILITY_TARGET_SELF, 10000ms },
        { SPELL_SH_HEALING_WAVE, ABILITY_TARGET_HEAL, 10000ms },
        { SPELL_SH_CHAIN_LIGHT,  ABILITY_TARGET_ENEMY, 8000ms }
    },
    // 8 mage
    {   { SPELL_MG_FIREBALL,  ABILITY_TARGET_ENEMY, 5000ms   },
        { SPELL_MG_FROSTBOLT, ABILITY_TARGET_ENEMY, 5000ms   },
        { SPELL_MG_ICE_LANCE, ABILITY_TARGET_SPECIAL, 2000ms }
    },
    // 9 warlock
    {   { SPELL_WL_CURSE_OF_DOOM, ABILITY_TARGET_ENEMY, 10000ms },
        { SPELL_WL_RAIN_OF_FIRE,  ABILITY_TARGET_ENEMY, 10000ms },
        { SPELL_WL_UNSTABLE_AFFL, ABILITY_TARGET_ENEMY, 10000ms }
    },
    // 10 UNK class (should never be set)
    {
        // Warrior as fallback behavior if for some reason UNK class
        { SPELL_WR_SPELL_REFLECT, ABILITY_TARGET_SELF,   10000ms },
        { SPELL_WR_WHIRLWIND,     ABILITY_TARGET_SELF,   10000ms },
        { SPELL_WR_MORTAL_STRIKE, ABILITY_TARGET_VICTIM, 6000ms  }
    },
    // 11 druid
    {   { SPELL_DR_LIFEBLOOM, ABILITY_TARGET_HEAL, 10000ms },
        { SPELL_DR_THORNS,    ABILITY_TARGET_SELF, 10000ms },
        { SPELL_DR_MOONFIRE,  ABILITY_TARGET_ENEMY, 8000ms }
    },
    // MISC shadow priest
    {   { SPELL_PR_MIND_CONTROL, ABILITY_TARGET_ENEMY, 15000ms },
        { SPELL_PR_MIND_BLAST,   ABILITY_TARGET_ENEMY, 5000ms  },
        { SPELL_PR_SW_DEATH,     ABILITY_TARGET_ENEMY, 10000ms }
    }
};

struct boss_hexlord_malacrass : public BossAI
{
    boss_hexlord_malacrass(Creature* creature) : BossAI(creature, DATA_HEXLORD)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        BossAI::Reset();
        _currentClass = CLASS_NONE;
        _classAbilityTimer = 10000ms;
        _timeUntilNextDrainPower = 0ms;
        SpawnAdds();
        ScheduleHealthCheckEvent(80, [&] {
            scheduler.Schedule(1s, GROUP_DRAIN_POWER, [this](TaskContext context)
            {
                DoCastSelf(SPELL_DRAIN_POWER, true);
                Talk(SAY_DRAIN_POWER);
                context.Repeat(30s);
            });
        });
    }

    void SpawnAdds()
    {
        if (_creatureIndex.empty())
        {
            for (uint8 i = 0; i < MAX_ADD_COUNT; ++i)
            {
                uint8 flip = urand(0, 1);
                me->SummonCreature(AddEntrySets[i][flip], AddPosition[i], TEMPSUMMON_DEAD_DESPAWN, 0);
                _creatureIndex.push_back(flip);
            }
        }
        else
        {
            for (uint8 i = 0; i < MAX_ADD_COUNT; ++i)
                me->SummonCreature(AddEntrySets[i][_creatureIndex[i]], AddPosition[i], TEMPSUMMON_DEAD_DESPAWN, 0);
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        summons.DoForAllSummons([&](WorldObject* summon)
        {
            if (Creature* add = summon->ToCreature())
                add->SetInCombatWithZone();
        });

        ScheduleTimedEvent(30s, [&]{
            scheduler.CancelGroup(GROUP_CLASS_ABILITY);
            DoCastSelf(SPELL_SPIRIT_BOLTS);
            // Delay Drain Power if it's currently within 10s of being cast
            // TODO: see what is wrong with GetNextGroupOccurrence as the timers don't seem correct on resets
            _timeUntilNextDrainPower = scheduler.GetNextGroupOccurrence(GROUP_DRAIN_POWER);
            if (_timeUntilNextDrainPower > 0s && _timeUntilNextDrainPower < 10s)
            {
                std::chrono::milliseconds delayTime = 10s - _timeUntilNextDrainPower + 1s;
                scheduler.DelayGroup(GROUP_DRAIN_POWER, delayTime);
            }
            scheduler.Schedule(10s, [this](TaskContext)
            {
                if (Creature* siphonTrigger = me->SummonCreature(NPC_TEMP_TRIGGER, me->GetPosition(), TEMPSUMMON_TIMED_DESPAWN, 30000))
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 70, true))
                    {
                        siphonTrigger->SetDisplayId(11686);
                        siphonTrigger->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        siphonTrigger->AI()->DoCast(target, SPELL_SIPHON_SOUL, true);
                        siphonTrigger->GetMotionMaster()->MoveFollow(me, 0.0f, 0.0f);
                        if (Player* player = target->ToPlayer())
                            _currentClass = player->HasAura(AURA_SHADOW_FORM) ? uint8(ADDITIONAL_CLASS_SPRIEST) : player->getClass();

                        ScheduleClassAbility();
                    }
                }
            });
        }, 40s);
    }

    void UseAbility()
    {
        uint8 random = urand(0, 2);
        Unit* target = nullptr;
        switch (PlayerAbility[_currentClass][random].target)
        {
            case ABILITY_TARGET_SELF:
                target = me;
                break;
            case ABILITY_TARGET_VICTIM:
                target = me->GetVictim();
                break;
            case ABILITY_TARGET_ENEMY:
            default:
                target = SelectTarget(SelectTargetMethod::Random, 0, 100, true);
                break;
            case ABILITY_TARGET_HEAL:
                target = DoSelectLowestHpFriendly(50, 0);
                break;
            case ABILITY_TARGET_BUFF:
                {
                    std::list<Creature*> templist = DoFindFriendlyMissingBuff(50, PlayerAbility[_currentClass][random].spell);
                    if (!templist.empty())
                        target = *(templist.begin());
                }
                break;
        }
        if (target)
            DoCast(target, PlayerAbility[_currentClass][random].spell, false);
        _classAbilityTimer = PlayerAbility[_currentClass][random].cooldown;
    }

    void ScheduleClassAbility()
    {
        scheduler.Schedule(_classAbilityTimer, GROUP_CLASS_ABILITY, [this](TaskContext context)
        {
            UseAbility();
            context.Repeat(_classAbilityTimer);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        BossAI::KilledUnit(victim);
        if (urand(0, 1))
            Talk(SAY_KILL_ONE);
        else
            Talk(SAY_KILL_TWO);
    }
private:
    uint8 _currentClass;
    std::chrono::milliseconds _classAbilityTimer;
    std::chrono::milliseconds _timeUntilNextDrainPower;
    std::vector<uint8> _creatureIndex;
};

struct boss_alyson_antille : public ScriptedAI
{
    boss_alyson_antille(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
        _friendlyList.clear();
        ScriptedAI::Reset();
    }

    void JustEngagedWith(Unit* who) override
    {
        ScriptedAI::JustEngagedWith(who);
        //populate list of friendly adds and malacrass
        GetNearbyFriendlies();
        ScheduleTimedEvent(10s, [&]{
            bool friendlyCast = false;
            RandomReverseFriendlyList();
            for (Creature* friendly : _friendlyList)
            {
                if (friendly->IsAlive() && friendly->IsWithinDist2d(me, 40.0f))
                {
                    DoCast(friendly, SPELL_DISPEL_MAGIC);
                    friendlyCast = true;
                    break;
                }
            }
            if (!friendlyCast)
            {
                if (Map* map = me->GetMap())
                {
                    map->DoForAllPlayers([&](Player* player)
                    {
                        if (player->IsWithinDist2d(me, 40.0f))
                        {
                            DoCast(player, SPELL_DISPEL_MAGIC);
                            return;
                        }
                    });
                }
            }
        }, 10s);
        ScheduleTimedEvent(2500ms, [&]{
            RandomReverseFriendlyList();
            for (Creature* friendly : _friendlyList)
            {
                if (friendly->IsAlive() && friendly->IsWithinDist2d(me, 40.0f) && !friendly->IsFullHealth())
                {
                    DoCast(friendly, SPELL_FLASH_HEAL);
                    break;
                }
            }
        }, 2500ms);
        ScheduleTimedEvent(30s, [&]{
            DoCastSelf(SPELL_ARCANE_TORRENT); // timer not checked
        }, 30s);
    }

    void RandomReverseFriendlyList()
    {
        if (urand(0, 1))
            _friendlyList.reverse();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

    void GetNearbyFriendlies()
    {
        me->GetCreaturesWithEntryInRange(_friendlyList, 100.0f, NPC_HEXLORD);
        me->GetCreaturesWithEntryInRange(_friendlyList, 100.0f, NPC_GAZAKROTH);
        me->GetCreaturesWithEntryInRange(_friendlyList, 100.0f, NPC_LORD_RADAAN);
        me->GetCreaturesWithEntryInRange(_friendlyList, 100.0f, NPC_DARKHEART);
        me->GetCreaturesWithEntryInRange(_friendlyList, 100.0f, NPC_SLITHER);
        me->GetCreaturesWithEntryInRange(_friendlyList, 100.0f, NPC_FENSTALKER);
        me->GetCreaturesWithEntryInRange(_friendlyList, 100.0f, NPC_KORAGG);
    }
private:
    std::list<Creature* > _friendlyList;
};

class spell_hexlord_unstable_affliction : public AuraScript
{
    PrepareAuraScript(spell_hexlord_unstable_affliction);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_WL_UNSTABLE_AFFL_DISPEL });
    }

    void HandleDispel(DispelInfo* dispelInfo)
    {
        if (Unit* caster = GetCaster())
            caster->CastSpell(dispelInfo->GetDispeller(), SPELL_WL_UNSTABLE_AFFL_DISPEL, true, nullptr, GetEffect(EFFECT_0));
    }

    void Register() override
    {
        AfterDispel += AuraDispelFn(spell_hexlord_unstable_affliction::HandleDispel);
    }
};

void AddSC_boss_hex_lord_malacrass()
{
    RegisterZulAmanCreatureAI(boss_hexlord_malacrass);
    RegisterZulAmanCreatureAI(boss_alyson_antille);
    RegisterSpellScript(spell_hexlord_unstable_affliction);
}
