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

#include "ScriptMgr.h"
#include "LFGScripts.h"
#include "ScriptRegistry.h"
#include "ScriptReloadMgr.h"
#include "ScriptSystem.h"
#include "SmartAI.h"
#include "SpellMgr.h"
//#include "StopWatch.h"
#include "UnitAI.h"
#include "CreatureAIImpl.h"

struct TSpellSummary
{
    uint8 Targets; // set of enum SelectTarget
    uint8 Effects; // set of enum SelectEffect
}*SpellSummary;

ScriptMgr* ScriptMgr::instance()
{
    static ScriptMgr instance;
    return &instance;
}

void ScriptMgr::Initialize()
{
    LOG_INFO("server.loading", "> Loading C++ scripts");
    LOG_INFO("server.loading", " ");

    // Load core scripts
    SetScriptContext(GetNameOfStaticContext());

    AddSC_SmartScripts();

    // LFGScripts
    lfg::AddSC_LFGScripts();

    ASSERT(_script_loader_callback,
        "Script loader callback wasn't registered!");

    ASSERT(_modules_loader_callback,
        "Modules loader callback wasn't registered!");

    _script_loader_callback();
    _modules_loader_callback();

    // Initialize all dynamic scripts
    // and finishes the context switch to do
    // bulk loading
    sScriptReloadMgr->Initialize();

    // Loads all scripts from the current context
    SwapScriptContext(true);

    LOG_INFO("server.loading", ">> Loaded {} C++ scripts", GetScriptCount());
    LOG_INFO("server.loading", "");
}

void ScriptMgr::Unload()
{
    sScriptRegistryCompositum->Unload();
    delete[] SpellSummary;
    delete[] UnitAI::AISpellInfo;
}

void ScriptMgr::LoadDatabase()
{
    ASSERT(sSpellMgr->GetSpellInfo(SPELL_HOTSWAP_VISUAL_SPELL_EFFECT),
        "Reload hotswap spell effect for creatures isn't valid!");

    sScriptSystemMgr->LoadScriptWaypoints();

    LOG_INFO("server.loading", "> Registing database bound scripts...");

    uint32 oldMSTime = getMSTime();

    // Load core scripts
    SetScriptContext(GetNameOfStaticContext());

    // Add all scripts that must be loaded after db/maps
    sScriptRegistryCompositum->LoadDBBoundScripts();

    FillSpellSummary();

    // Loads all scripts from the current context
    SwapScriptContext(true);

    LOG_INFO("server.loading", ">> Registing database bound scripts is done in {} ms", GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", "");

    // Print unused script names.
    std::unordered_set<std::string> unusedScriptNames
    {
        sObjectMgr->GetAllScriptNames().begin(),
        sObjectMgr->GetAllScriptNames().end()
    };

    // Remove the used scripts from the given container.
    sScriptRegistryCompositum->RemoveUsedScriptsFromContainer(unusedScriptNames);

    LOG_INFO("server.loading", "> Check unused scripts...");

    for (auto const& scriptName : unusedScriptNames)
    {
        // Avoid complaining about empty script names since the
        // script name container contains a placeholder as the 0 element.
        if (scriptName.empty())
            continue;

        LOG_ERROR("sql.sql", "Script '{}' is referenced by the database, but does not exist in the core!", scriptName);
    }

    LOG_INFO("server.loading", " ");
}

void ScriptMgr::SetScriptContext(std::string_view context)
{
    _currentContext = context;
}

void ScriptMgr::SwapScriptContext(bool initialize)
{
    sScriptRegistryCompositum->SwapContext(initialize);
    _currentContext.clear();
}

std::string_view ScriptMgr::GetNameOfStaticContext()
{
    static std::string const name{ "___static___" };
    return name;
}

std::string_view ScriptMgr::GetCurrentScriptContext() const
{
    return _currentContext;
}

void ScriptMgr::ReleaseScriptContext(std::string_view context)
{
    sScriptRegistryCompositum->ReleaseContext(context);
}

std::shared_ptr<ModuleReference> ScriptMgr::AcquireModuleReferenceOfScriptName([[maybe_unused]] std::string_view scriptname) const
{
#ifdef ACORE_API_USE_DYNAMIC_LINKING
    // Returns the reference to the module of the given scriptname
    return ScriptReloadMgr::AcquireModuleReferenceOfContext(sScriptRegistryCompositum->GetScriptContextOfScriptName(scriptname));
#else
    // Something went wrong when this function is used in
    // a static linked context.
    ABORT();
#endif // #ifndef ACORE_API_USE_DYNAMIC_LINKING
}

void ScriptMgr::FillSpellSummary()
{
    UnitAI::FillAISpellInfo();

    SpellSummary = new TSpellSummary[sSpellMgr->GetSpellInfoStoreSize()];

    SpellInfo const* pTempSpell;

    for (uint32 i = 0; i < sSpellMgr->GetSpellInfoStoreSize(); ++i)
    {
        SpellSummary[i].Effects = 0;
        SpellSummary[i].Targets = 0;

        pTempSpell = sSpellMgr->GetSpellInfo(i);
        // This spell doesn't exist.
        if (!pTempSpell)
            continue;

        for (uint32 j = 0; j < MAX_SPELL_EFFECTS; ++j)
        {
            // Spell targets self.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_SELF - 1);

            // Spell targets a single enemy.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_TARGET_ENEMY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_SINGLE_ENEMY - 1);

            // Spell targets AoE at enemy.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_SRC_AREA_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_DEST_AREA_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_DYNOBJ_ENEMY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_AOE_ENEMY - 1);

            // Spell targets an enemy.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_TARGET_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_SRC_AREA_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_DEST_AREA_ENEMY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_DEST_DYNOBJ_ENEMY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_ANY_ENEMY - 1);

            // Spell targets a single friend (or self).
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ALLY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_PARTY)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_SINGLE_FRIEND - 1);

            // Spell targets AoE friends.
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER_AREA_PARTY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_LASTTARGET_AREA_PARTY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_AOE_FRIEND - 1);

            // Spell targets any friend (or self).
            if (pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_ALLY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_TARGET_PARTY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_CASTER_AREA_PARTY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_UNIT_LASTTARGET_AREA_PARTY ||
                    pTempSpell->Effects[j].TargetA.GetTarget() == TARGET_SRC_CASTER)
                SpellSummary[i].Targets |= 1 << (SELECT_TARGET_ANY_FRIEND - 1);

            // Make sure that this spell includes a damage effect.
            if (pTempSpell->Effects[j].Effect == SPELL_EFFECT_SCHOOL_DAMAGE ||
                    pTempSpell->Effects[j].Effect == SPELL_EFFECT_INSTAKILL ||
                    pTempSpell->Effects[j].Effect == SPELL_EFFECT_ENVIRONMENTAL_DAMAGE ||
                    pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEALTH_LEECH)
                SpellSummary[i].Effects |= 1 << (SELECT_EFFECT_DAMAGE - 1);

            // Make sure that this spell includes a healing effect (or an apply aura with a periodic heal).
            if (pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEAL ||
                    pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEAL_MAX_HEALTH ||
                    pTempSpell->Effects[j].Effect == SPELL_EFFECT_HEAL_MECHANICAL ||
                    (pTempSpell->Effects[j].Effect == SPELL_EFFECT_APPLY_AURA  && pTempSpell->Effects[j].ApplyAuraName == 8))
                SpellSummary[i].Effects |= 1 << (SELECT_EFFECT_HEALING - 1);

            // Make sure that this spell applies an aura.
            if (pTempSpell->Effects[j].Effect == SPELL_EFFECT_APPLY_AURA)
                SpellSummary[i].Effects |= 1 << (SELECT_EFFECT_AURA - 1);
        }
    }
}
