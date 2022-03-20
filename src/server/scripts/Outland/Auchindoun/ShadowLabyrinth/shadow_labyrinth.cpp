#include "SpellScript.h"

enum Spells
{
    SPELL_MARK_OF_MALICE_TRIGGERED = 33494
};

class spell_mark_of_malice : public SpellScriptLoader
{
public:
    spell_mark_of_malice() : SpellScriptLoader("spell_mark_of_malice") { }

    class spell_mark_of_malice_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mark_of_malice_AuraScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_MARK_OF_MALICE_TRIGGERED))
                return false;
            return true;
        }

        void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
        {
            PreventDefaultAction();
            // just drop charges
            if (aurEff->GetBase()->GetCharges() > 1)
                return;

            GetTarget()->CastSpell(GetTarget(), SPELL_MARK_OF_MALICE_TRIGGERED, true);
        }

        void Register() override
        {
            OnEffectProc += AuraEffectProcFn(spell_mark_of_malice_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_mark_of_malice_AuraScript();
    }
};

void AddSC_shadow_labyrinth()
{
    new spell_mark_of_malice();
}
