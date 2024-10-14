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
#include "SpellScriptLoader.h"
#include "zulaman.h"
/* ScriptData
SDName: Boss_Hex_Lord_Malacrass
SD%Complete:
SDComment:
SDCategory: Zul'Aman
EndScriptData */

enum Says
{
    SAY_AGGRO = 0,
    SAY_KILL_ONE,
    SAY_KILL_TWO,
    SAY_DRAIN_POWER,
    SAY_SPIRIT_BOLTS,
    SAY_DEATH
};

enum Creatures
{
    NPC_TEMP_TRIGGER                = 23920
};

enum Spells
{
    SPELL_SPIRIT_BOLTS              = 43383,
    SPELL_DRAIN_POWER               = 44131,
    SPELL_SIPHON_SOUL               = 43501,

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
    SPELL_RO_SLICE_DICE             = 43457,
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
    SPELL_DK_BLOOD_WORMS            = 97630,


    // Thurg
    SPELL_BLOODLUST                 = 43578,
    SPELL_CLEAVE                    = 15496,

    // Gazakroth
    SPELL_FIREBOLT                  = 43584,

    // Alyson Antille
    SPELL_FLASH_HEAL                = 43575,
    SPELL_DISPEL_MAGIC              = 43577,

    // Lord Raadan
    SPELL_FLAME_BREATH              = 43582,
    SPELL_THUNDERCLAP               = 43583,

    // Darkheart
    SPELL_PSYCHIC_WAIL              = 43590,

    // Slither
    SPELL_VENOM_SPIT                = 43579,

    // Fenstalker
    SPELL_VOLATILE_INFECTION        = 43586,

    // Koragg
    SPELL_COLD_STARE                = 43593,
    SPELL_MIGHTY_BLOW               = 43592
};

const Position addPosition[4] =
{
    {112.8827f, 921.2795f, 33.8883f, 1.5696f},
    {107.8827f, 921.2795f, 33.8883f, 1.5696f},
    {122.8827f, 921.2795f, 33.8883f, 1.5696f},
    {127.8827f, 921.2795f, 33.8883f, 1.5696f}
};

static uint32 addEntrySets[4][2] =
{
    {24240, 24241}, // Thurg or Alyson Antille
    {24242, 24243}, // Lord Raadan or Slither
    {24244, 24245}, // Gazakroth or Fenstalker
    {24246, 24247}  // Darkheart or Koragg
};

enum Misc
{
    MAX_ADD_COUNT       = 4
};

enum AbilityTarget
{
    ABILITY_TARGET_SELF = 0,
    ABILITY_TARGET_VICTIM = 1,
    ABILITY_TARGET_ENEMY = 2,
    ABILITY_TARGET_HEAL = 3,
    ABILITY_TARGET_BUFF = 4,
    ABILITY_TARGET_SPECIAL = 5
};

struct PlayerAbilityStruct
{
    uint32 spell;
    AbilityTarget target;
    uint32 cooldown; //FIXME - it's never used
};

static PlayerAbilityStruct PlayerAbility[][3] =
{
    // 1 warrior
    {   {SPELL_WR_SPELL_REFLECT, ABILITY_TARGET_SELF, 10000},
        {SPELL_WR_WHIRLWIND, ABILITY_TARGET_SELF, 10000},
        {SPELL_WR_MORTAL_STRIKE, ABILITY_TARGET_VICTIM, 6000}
    },
    // 2 paladin
    {   {SPELL_PA_CONSECRATION, ABILITY_TARGET_SELF, 10000},
        {SPELL_PA_HOLY_LIGHT, ABILITY_TARGET_HEAL, 10000},
        {SPELL_PA_AVENGING_WRATH, ABILITY_TARGET_SELF, 10000}
    },
    // 3 hunter
    {   {SPELL_HU_EXPLOSIVE_TRAP, ABILITY_TARGET_SELF, 10000},
        {SPELL_HU_FREEZING_TRAP, ABILITY_TARGET_SELF, 10000},
        {SPELL_HU_SNAKE_TRAP, ABILITY_TARGET_SELF, 10000}
    },
    // 4 rogue
    {   {SPELL_RO_WOUND_POISON, ABILITY_TARGET_VICTIM, 3000},
        {SPELL_RO_SLICE_DICE, ABILITY_TARGET_SELF, 10000},
        {SPELL_RO_BLIND, ABILITY_TARGET_ENEMY, 10000}
    },
    // 5 priest
    {   {SPELL_PR_PAIN_SUPP, ABILITY_TARGET_HEAL, 10000},
        {SPELL_PR_HEAL, ABILITY_TARGET_HEAL, 10000},
        {SPELL_PR_PSYCHIC_SCREAM, ABILITY_TARGET_SELF, 10000}
    },
    // 5* shadow priest
    {   {SPELL_PR_MIND_CONTROL, ABILITY_TARGET_ENEMY, 15000},
        {SPELL_PR_MIND_BLAST, ABILITY_TARGET_ENEMY, 5000},
        {SPELL_PR_SW_DEATH, ABILITY_TARGET_ENEMY, 10000}
    },
    // 7 shaman
    {   {SPELL_SH_FIRE_NOVA, ABILITY_TARGET_SELF, 10000},
        {SPELL_SH_HEALING_WAVE, ABILITY_TARGET_HEAL, 10000},
        {SPELL_SH_CHAIN_LIGHT, ABILITY_TARGET_ENEMY, 8000}
    },
    // 8 mage
    {   {SPELL_MG_FIREBALL, ABILITY_TARGET_ENEMY, 5000},
        {SPELL_MG_FROSTBOLT, ABILITY_TARGET_ENEMY, 5000},
        {SPELL_MG_ICE_LANCE, ABILITY_TARGET_SPECIAL, 2000}
    },
    // 9 warlock
    {   {SPELL_WL_CURSE_OF_DOOM, ABILITY_TARGET_ENEMY, 10000},
        {SPELL_WL_RAIN_OF_FIRE, ABILITY_TARGET_ENEMY, 10000},
        {SPELL_WL_UNSTABLE_AFFL, ABILITY_TARGET_ENEMY, 10000}
    },
    // 11 druid
    {   {SPELL_DR_LIFEBLOOM, ABILITY_TARGET_HEAL, 10000},
        {SPELL_DR_THORNS, ABILITY_TARGET_SELF, 10000},
        {SPELL_DR_MOONFIRE, ABILITY_TARGET_ENEMY, 8000}
    },
    // 12 death knight
    {
        {SPELL_DK_PLAGUE_STRIKE, ABILITY_TARGET_ENEMY, 2000},
        {SPELL_DK_DEATH_AND_DECAY, ABILITY_TARGET_SELF, 10000},
        {SPELL_DK_BLOOD_WORMS, ABILITY_TARGET_ENEMY, 5000}
    }
};

struct boss_hexlord_malacrass : public BossAI
{
    boss_hexlord_malacrass(Creature* creature) : BossAI(creature, DATA_HEXLORD) { }

    void Reset() override
    {
        BossAI::Reset();
        SpawnAdds();
    }

    void SpawnAdds()
    {
        for (uint8 i = 0; i < MAX_ADD_COUNT; ++i)
        {
            uint8 flip = urand(0, 1);
            me->SummonCreature(addEntrySets[i][flip], addPosition[i], TEMPSUMMON_DEAD_DESPAWN, 0);
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
    }

    void KilledUnit(Unit* victim) override
    {
        BossAI::KilledUnit(victim);
        if (urand(0, 1))
            Talk(SAY_KILL_ONE);
        else
            Talk(SAY_KILL_TWO);
    }

    void JustDied(Unit* /*killer*/) override
    {
    }
};

class boss_alyson_antille : public CreatureScript
{
public:
    boss_alyson_antille()
        : CreatureScript("boss_alyson_antille")
    {
    }

    struct boss_alyson_antilleAI : public boss_hexlord_addAI
    {
        //Holy Priest
        boss_alyson_antilleAI(Creature* creature) : boss_hexlord_addAI(creature) { }

        uint32 flashheal_timer;
        uint32 dispelmagic_timer;

        void Reset() override
        {
            flashheal_timer = 2500;
            dispelmagic_timer = 10000;

            //AcquireGUID();

            boss_hexlord_addAI::Reset();
        }

        void AttackStart(Unit* who) override
        {
            if (!who)
                return;

            if (who->isTargetableForAttack())
            {
                if (me->Attack(who, false))
                {
                    me->GetMotionMaster()->MoveChase(who, 20);
                    me->AddThreat(who, 0.0f);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (flashheal_timer <= diff)
            {
                Unit* target = DoSelectLowestHpFriendly(99, 30000);
                if (target)
                {
                    if (target->IsWithinDistInMap(me, 50))
                        DoCast(target, SPELL_FLASH_HEAL, false);
                    else
                    {
                        /**
                         * @bug
                         * Bugged
                         * //me->GetMotionMaster()->Clear();
                         * //me->GetMotionMaster()->MoveChase(target, 20);
                         */
                        //me->GetMotionMaster()->Clear();
                        //me->GetMotionMaster()->MoveChase(target, 20);
                    }
                }
                else
                {
                    if (urand(0, 1))
                        target = DoSelectLowestHpFriendly(50, 0);
                    else
                        target = SelectTarget(SelectTargetMethod::Random, 0);
                    if (target)
                        DoCast(target, SPELL_DISPEL_MAGIC, false);
                }
                flashheal_timer = 2500;
            }
            else flashheal_timer -= diff;

            /*if (dispelmagic_timer <= diff)
            {
            if (urand(0, 1))
            {
                Unit* target = SelectTarget();

                DoCast(target, SPELL_DISPEL_MAGIC, false);
            }
            else
                me->CastSpell(SelectUnit(SelectTargetMethod::Random, 0), SPELL_DISPEL_MAGIC, false);

            dispelmagic_timer = 12000;
            } else dispelmagic_timer -= diff;*/

            boss_hexlord_addAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulAmanAI<boss_alyson_antilleAI>(creature);
    }
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
    //new boss_hexlord_malacrass();
    //new boss_alyson_antille();
    RegisterSpellScript(spell_hexlord_unstable_affliction);
}
