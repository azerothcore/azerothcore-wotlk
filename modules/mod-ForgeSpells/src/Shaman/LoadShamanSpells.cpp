#include "LoadForgeSpells.cpp"
#include "PetDefines.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Totem.h"
#include "UnitAI.h"

enum ShamanSpells
{
    SPELL_SHAMAN_SEARING_FLAMES_DOT = 110004,
};

// Searing Flames
class spell_sha_searing_flames : public SpellScript
{
    PrepareSpellScript(spell_sha_searing_flames);

    void HandleOnHit()
    {
        Unit* caster = GetCaster();
        // Searing Flames
        if (Unit* owner = caster->GetOwner())
            if (AuraEffect* aur = owner->GetDummyAuraEffect(SPELLFAMILY_SHAMAN, 680, EFFECT_0))
                if (roll_chance_i(aur->GetAmount()))
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_SHAMAN_SEARING_FLAMES_DOT);
                    uint32 ticks = spellInfo->GetDuration() / spellInfo->Effects[EFFECT_0].Amplitude;
                    int32 basepoints0 = GetHitDamage() / ticks;
                    caster->CastCustomSpell(GetHitUnit(), SPELL_SHAMAN_SEARING_FLAMES_DOT, &basepoints0, NULL, NULL, true, NULL, NULL, owner->GetGUID());
                }
    }

    void Register()
    {
        OnHit += SpellHitFn(spell_sha_searing_flames::HandleOnHit);
    }
};

// 110006
class spell_sha_lava_lash_trigger : public SpellScript
{
    PrepareSpellScript(spell_sha_lava_lash_trigger)

        bool Load()
    {
        return GetCaster()->GetTypeId() == TYPEID_PLAYER;
    }

    void FilterTargets(std::list < WorldObject* >& unitList)
    {
        targets = unitList;
        if (GetHitUnit())
            targets.remove(GetHitUnit());
    }

    void HandleOnHit()
    {
        if (Unit* target = GetHitUnit())
            if (auto* flameShock = target->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_SHAMAN, 0x10000000, 0, 0, GetCaster()->GetGUID())) {
                auto* aura = target->GetAura(flameShock->GetId(), GetCaster()->GetGUID());
                for (std::list<WorldObject*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
                    if (Unit* triggerTarget = (*itr)->ToUnit())
                        GetCaster()->AddAuraForTarget(aura, triggerTarget);
            }
    }

    void Register()
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sha_lava_lash_trigger::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
        OnHit += SpellHitFn(spell_sha_lava_lash_trigger::HandleOnHit);
    }

private:
    std::list<WorldObject*> targets;

};

class LoadShamanSpells : LoadForgeSpells
{
public:
    LoadShamanSpells() : LoadForgeSpells()
    {

    }

    void Load() override
    {
        RegisterSpellScript(spell_sha_searing_flames);
        RegisterSpellScript(spell_sha_lava_lash_trigger);
    }
};
