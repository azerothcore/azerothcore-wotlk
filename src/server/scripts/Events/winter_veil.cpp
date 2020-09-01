// Scripted by Xinef

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellScript.h"
#include "GameEventMgr.h"
#include "Player.h"


///////////////////////////////
// SPELLS
///////////////////////////////

enum Mistletoe
{
    SPELL_CREATE_MISTLETOE          = 26206,
    SPELL_CREATE_HOLLY              = 26207,
    SPELL_CREATE_SNOWFLAKES         = 45036
};

class spell_winter_veil_mistletoe : public SpellScriptLoader
{
    public:
        spell_winter_veil_mistletoe() : SpellScriptLoader("spell_winter_veil_mistletoe") { }

        class spell_winter_veil_mistletoe_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_winter_veil_mistletoe_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_CREATE_MISTLETOE) ||
                    !sSpellMgr->GetSpellInfo(SPELL_CREATE_HOLLY) ||
                    !sSpellMgr->GetSpellInfo(SPELL_CREATE_SNOWFLAKES))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                if (Player* target = GetHitPlayer())
                {
                    uint32 spellId = RAND(SPELL_CREATE_HOLLY, SPELL_CREATE_MISTLETOE, SPELL_CREATE_SNOWFLAKES);
                    GetCaster()->CastSpell(target, spellId, true);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_winter_veil_mistletoe_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_winter_veil_mistletoe_SpellScript();
        }
};

enum winterWondervoltTrap
{
    SPELL_WINTER_WONDERVOLT_GREEN_WOMEN     = 26272,
    SPELL_WINTER_WONDERVOLT_GREEN_MAN       = 26157,
    SPELL_WINTER_WONDERVOLT_RED_WOMEN       = 26274,
    SPELL_WINTER_WONDERVOLT_RED_MAN         = 26273,
};

class spell_winter_wondervolt_trap : public SpellScriptLoader
{
    public:
    spell_winter_wondervolt_trap() : SpellScriptLoader("spell_winter_wondervolt_trap") {}

    class spell_winter_wondervolt_trap_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_winter_wondervolt_trap_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            if (Player* target = GetHitPlayer())
            {
                // check presence
                if (target->HasAuraType(SPELL_AURA_TRANSFORM))
                    return;

                uint32 spellId = 0;
                if (target->getGender() == GENDER_MALE)
                    spellId = RAND(SPELL_WINTER_WONDERVOLT_RED_MAN, SPELL_WINTER_WONDERVOLT_GREEN_MAN);
                else
                    spellId = RAND(SPELL_WINTER_WONDERVOLT_RED_WOMEN, SPELL_WINTER_WONDERVOLT_GREEN_WOMEN);

                // cast
                target->CastSpell(target, spellId, true);
                return;
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_winter_wondervolt_trap_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_winter_wondervolt_trap_SpellScript();
    }
};

enum crashinTrashin
{
    SPELL_BLUE_CAR_VISUAL               = 75110,
    SPELL_RED_CAR_VISUAL                = 49384,
    NPC_RED_RACER                       = 27664,
    NPC_BLUE_RACER                      = 40281,

    SPELL_RACER_DEATH_VISUAL            = 49337,
    SPELL_RACER_CHARGE_TO_OBJECT        = 49302,
    SPELL_RACER_KILL_COUNTER            = 49444,
    SPELL_RACER_SLAM_HIT                = 49324,
    SPELL_RACER_FLAMES                  = 49328,

    RACER_ACHI_CRITERIA                 = 4090,
};

class spell_winter_veil_racer_rocket_slam : public SpellScriptLoader
{
    public:
    spell_winter_veil_racer_rocket_slam() : SpellScriptLoader("spell_winter_veil_racer_rocket_slam") {}

    class spell_winter_veil_racer_rocket_slam_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_winter_veil_racer_rocket_slam_SpellScript);

        void HandleTriggerSpell(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            PreventHitEffect(EFFECT_0);
            PreventHitEffect(EFFECT_1);

            std::list<Creature*> unitList;
            Unit* target = nullptr;
            caster->GetCreaturesWithEntryInRange(unitList, 30.0f, NPC_BLUE_RACER);
            if (!unitList.empty())
                for (std::list<Creature*>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                    if (caster->HasInLine((*itr), 1.0f) && (*itr)->GetGUID() != caster->GetGUID())
                    {
                        target = (*itr);
                        break;
                    }
            if (!target)
            {
                unitList.clear();
                caster->GetCreaturesWithEntryInRange(unitList, 30.0f, NPC_RED_RACER);
                if (!unitList.empty())
                    for (std::list<Creature*>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                        if (caster->HasInLine((*itr), 1.0f) && (*itr)->GetGUID() != caster->GetGUID())
                        {
                            target = (*itr);
                            break;
                        }
            }

            if (target)
            {
                caster->CastSpell(target, SPELL_RACER_CHARGE_TO_OBJECT, true);
                caster->CastSpell(target, SPELL_RACER_SLAM_HIT, true);
            }
            else
            {
                Position pos;
                float x = caster->GetPositionX()+30*cos(caster->GetOrientation());
                float y = caster->GetPositionY()+30*sin(caster->GetOrientation());
                pos.Relocate(x, y, caster->GetMap()->GetHeight(x, y, MAX_HEIGHT)+0.5f);
                //caster->GetFirstCollisionPosition(pos, 30.0f, caster->GetOrientation());
                caster->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_RACER_CHARGE_TO_OBJECT, true);
            }
        }

        void Register()
        {
            OnEffectLaunch += SpellEffectFn(spell_winter_veil_racer_rocket_slam_SpellScript::HandleTriggerSpell, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_winter_veil_racer_rocket_slam_SpellScript();
    }
};

class spell_winter_veil_racer_slam_hit : public SpellScriptLoader
{
    public:
    spell_winter_veil_racer_slam_hit() : SpellScriptLoader("spell_winter_veil_racer_slam_hit") {}

    class spell_winter_veil_racer_slam_hit_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_winter_veil_racer_slam_hit_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            Creature* target = GetHitCreature();
            if (!target || caster == target)
                return;

            target->CastSpell(target->GetPositionX()+irand(-10, 10), target->GetPositionY()+irand(-10, 10), target->GetPositionZ() , SPELL_RACER_DEATH_VISUAL, true);
            target->DespawnOrUnsummon(3000);
            target->CastSpell(target, SPELL_RACER_FLAMES, true);
            caster->CastSpell(caster, SPELL_RACER_KILL_COUNTER, true);

            if (Player* targetSummoner = target->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                //targetSummoner->RemoveCriteriaProgress(sAchievementCriteriaStore.LookupEntry(RACER_ACHI_CRITERIA)); !ZOMG, ADD ACCESSOR
                targetSummoner->RemoveAurasDueToSpell(SPELL_RACER_KILL_COUNTER);
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_winter_veil_racer_slam_hit_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_winter_veil_racer_slam_hit_SpellScript();
    }
};

enum airRifle
{
    SPELL_AIR_RIFLE_RIGHT_IN_THE_EYE        = 65577,
    SPELL_AIR_RIFLE_STARLED                 = 61862,
    SPELL_AIR_RIFLE_HIT                     = 61866,
    SPELL_AIR_RIFLE_HIT_TRIGGER             = 65576,
    SPELL_AIR_RIFLE_PELTED_DAMAGE           = 67531,
};

class spell_winter_veil_shoot_air_rifle : public SpellScriptLoader
{
    public:
    spell_winter_veil_shoot_air_rifle() : SpellScriptLoader("spell_winter_veil_shoot_air_rifle") {}

    class spell_winter_veil_shoot_air_rifle_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_winter_veil_shoot_air_rifle_SpellScript);

        void HandleScriptEffect(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetOriginalCaster();
            Unit* target = GetHitUnit();
            if (!target)
                return;

            if (GetSpellInfo()->Id == SPELL_AIR_RIFLE_HIT_TRIGGER)
            {
                if (!caster->IsFriendlyTo(target))
                    caster->CastSpell(target, SPELL_AIR_RIFLE_PELTED_DAMAGE, true, nullptr, nullptr, caster->GetGUID());
            }
            else
            {
                uint8 rand = urand(0, 99);
                if (rand < 15)
                    caster->CastSpell(caster, SPELL_AIR_RIFLE_RIGHT_IN_THE_EYE, true, nullptr, nullptr, caster->GetGUID());
                else if (rand < 35)
                    caster->CastSpell(target, SPELL_AIR_RIFLE_STARLED, true, nullptr, nullptr, caster->GetGUID());
                else
                    caster->CastSpell(target, SPELL_AIR_RIFLE_HIT, true, nullptr, nullptr, caster->GetGUID());
            }
        }

        void Register()
        {
            if (m_scriptSpellId == SPELL_AIR_RIFLE_HIT_TRIGGER)
                OnEffectHitTarget += SpellEffectFn(spell_winter_veil_shoot_air_rifle_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
            else
                OnEffectHitTarget += SpellEffectFn(spell_winter_veil_shoot_air_rifle_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_winter_veil_shoot_air_rifle_SpellScript();
    }
};

void AddSC_event_winter_veil_scripts()
{
    // Spells
    new spell_winter_veil_mistletoe();
    new spell_winter_wondervolt_trap();
    new spell_winter_veil_racer_rocket_slam();
    new spell_winter_veil_racer_slam_hit();
    new spell_winter_veil_shoot_air_rifle();
}