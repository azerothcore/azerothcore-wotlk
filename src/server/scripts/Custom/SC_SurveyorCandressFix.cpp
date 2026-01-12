// serverside damage fix for Surveyor's Candress fireball
#include "ScriptMgr.h"
#include "SpellScript.h"

constexpr int32 DamageCandressFireball = 16;

class spell_surveyor_candress_fireball : public SpellScript
{
    PrepareSpellScript(spell_surveyor_candress_fireball);
    // set flat damage to 16, instead of client side 16-26
    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        SetHitDamage(DamageCandressFireball);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_surveyor_candress_fireball::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

// Loader
class spell_surveyor_candress_fireball_loader : public SpellScriptLoader
{
public:
    spell_surveyor_candress_fireball_loader() : SpellScriptLoader("spell_surveyor_candress_fireball") { }

    SpellScript* GetSpellScript() const override
    {
        return new spell_surveyor_candress_fireball();
    }
};

// Global reg
void AddSC_SurveyorCandressFix()
{
    new spell_surveyor_candress_fireball_loader();
}