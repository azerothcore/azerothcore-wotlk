#include "LoadForgeSpells.cpp"
#include "PetDefines.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"

class spell_hun_pet_damage_spells : public SpellScript
{
    PrepareSpellScript(spell_hun_pet_damage_spells)

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (Unit* owner = caster->GetOwner())
        {
            float coeff = 1.0f;
            switch (GetSpellInfo()->Id)
            {
            case 16827: // Claw
            case 49966: // Smack
            case 17253: // Bite
                coeff = 0.2f * 0.4f;
                if (caster->GetPower(POWER_FOCUS) >= 50)
                {
                    // Wild Hunt
                    if (caster->HasSpell(62758))
                    {
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(62758);
                        AddPct(coeff, spellInfo->Effects[EFFECT_0].BasePoints);
                    }
                    else if (caster->HasSpell(62762))
                    {
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(62762);
                        AddPct(coeff, spellInfo->Effects[EFFECT_0].BasePoints);
                    }
                }
                break;
            case 9000000: // Kill command
                coeff = 0.516f;
                break;
            }
            int32 baseDamage = GetEffectValue() + (coeff * owner->GetTotalAttackPowerValue(RANGED_ATTACK));
            SetHitDamage(baseDamage);
        }
    }

    void Register()
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_hun_pet_damage_spells::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class LoadHunterSpells : LoadForgeSpells
{
public:
    LoadHunterSpells() : LoadForgeSpells()
    {

    }

    void Load() override
    {
        RegisterSpellScript(spell_hun_pet_damage_spells);
    }
};
