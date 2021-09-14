/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Feralas
SD%Complete: 100
SDComment: Quest support: 3520 Special vendor Gregan Brewspewer
SDCategory: Feralas
EndScriptData */

#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "SpellScript.h"

enum GordunniTrap
{
    GO_GORDUNNI_DIRT_MOUND = 144064,
};

class spell_gordunni_trap : public SpellScriptLoader
{
public:
    spell_gordunni_trap() : SpellScriptLoader("spell_gordunni_trap") { }

    class spell_gordunni_trap_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_gordunni_trap_SpellScript);

        void HandleDummy()
        {
            if (Unit* caster = GetCaster())
                if (GameObject* chest = caster->SummonGameObject(GO_GORDUNNI_DIRT_MOUND, caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                {
                    chest->SetSpellId(GetSpellInfo()->Id);
                    caster->RemoveGameObject(chest, false);
                }
        }

        void Register() override
        {
            OnCast += SpellCastFn(spell_gordunni_trap_SpellScript::HandleDummy);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_gordunni_trap_SpellScript();
    }
};

void AddSC_feralas()
{
    new spell_gordunni_trap();
}
