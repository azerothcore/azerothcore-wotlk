/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "AllScriptsObjects.h"
#include "InstanceScript.h"
#include "LFGScripts.h"
#include "ScriptSystem.h"
#include "SmartAI.h"
#include "SpellMgr.h"
#include "Utilities/TypeList.h"
#include "UnitAI.h"

namespace
{
    // Metadata for the script-registry operations derived in this file.
    // EnabledHooks is the legacy *_HOOK_END count for enabled-hook dispatch.
    // LegacyDbValidationCandidate preserves the old database-validation search set.
    template<typename Script, uint16 EnabledHookCountValue = 0, bool PromotedAfterDbLoadValue = false, bool LegacyDbValidationValue = false>
    struct ScriptTypeInfo
    {
        using type = Script;
        static constexpr uint16 EnabledHooks = EnabledHookCountValue;
        static constexpr bool HasEnabledHooks = EnabledHookCountValue > 0;
        static constexpr bool PromotedAfterDbLoad = PromotedAfterDbLoadValue;
        static constexpr bool LegacyDbValidationCandidate = LegacyDbValidationValue;
    };

    //                 script type                hooks                    afterLoad  dbCheck
    using ScriptRegistryTypes = Acore::type_list<
        ScriptTypeInfo<AccountScript,             ACCOUNTHOOK_END>,
        ScriptTypeInfo<AchievementCriteriaScript, 0,                       true,      true>,
        ScriptTypeInfo<AchievementScript,         ACHIEVEMENTHOOK_END,     false,     true>,
        ScriptTypeInfo<AllCreatureScript>,
        ScriptTypeInfo<AllGameObjectScript>,
        ScriptTypeInfo<AllItemScript>,
        ScriptTypeInfo<AllMapScript,              ALLMAPHOOK_END>,
        ScriptTypeInfo<AreaTriggerScript,         0,                       true,      true>,
        ScriptTypeInfo<ArenaScript,               ARENAHOOK_END,           false,     true>,
        ScriptTypeInfo<ArenaTeamScript,           ARENATEAMHOOK_END,       false,     true>,
        ScriptTypeInfo<AuctionHouseScript,        AUCTIONHOUSEHOOK_END,    false,     true>,
        ScriptTypeInfo<BattlefieldScript,         BATTLEFIELDHOOK_END>,
        ScriptTypeInfo<BGScript,                  ALLBATTLEGROUNDHOOK_END, false,     true>,
        ScriptTypeInfo<BattlegroundMapScript,     0,                       true,      true>,
        ScriptTypeInfo<BattlegroundScript,        0,                       true,      true>,
        ScriptTypeInfo<CommandSC,                 ALLCOMMANDHOOK_END,      false,     true>,
        ScriptTypeInfo<CommandScript,             0,                       false,     true>,
        ScriptTypeInfo<ConditionScript,           0,                       true,      true>,
        ScriptTypeInfo<CreatureScript,            0,                       true,      true>,
        ScriptTypeInfo<DatabaseScript,            DATABASEHOOK_END,        false,     true>,
        ScriptTypeInfo<DynamicObjectScript,       0,                       false,     true>,
        ScriptTypeInfo<ALEScript>,
        ScriptTypeInfo<FormulaScript,             FORMULAHOOK_END,         false,     true>,
        ScriptTypeInfo<GameEventScript,           GAMEEVENTHOOK_END>,
        ScriptTypeInfo<GameObjectScript,          0,                       true,      true>,
        ScriptTypeInfo<GlobalScript,              GLOBALHOOK_END>,
        ScriptTypeInfo<GroupScript,               GROUPHOOK_END,           false,     true>,
        ScriptTypeInfo<GuildScript,               GUILDHOOK_END,           false,     true>,
        ScriptTypeInfo<InstanceMapScript,         0,                       true,      true>,
        ScriptTypeInfo<ItemScript,                0,                       true,      true>,
        ScriptTypeInfo<LootScript,                LOOTHOOK_END>,
        ScriptTypeInfo<MailScript,                MAILHOOK_END>,
        ScriptTypeInfo<MiscScript,                MISCHOOK_END,            false,     true>,
        ScriptTypeInfo<MovementHandlerScript,     MOVEMENTHOOK_END>,
        ScriptTypeInfo<OutdoorPvPScript,          0,                       true,      true>,
        ScriptTypeInfo<PetScript,                 PETHOOK_END,             false,     true>,
        ScriptTypeInfo<PlayerScript,              PLAYERHOOK_END,          false,     true>,
        ScriptTypeInfo<ServerScript,              SERVERHOOK_END,          false,     true>,
        ScriptTypeInfo<SpellSC,                   ALLSPELLHOOK_END,        false,     true>,
        ScriptTypeInfo<SpellScriptLoader,         0,                       true,      true>,
        ScriptTypeInfo<TicketScript,              TICKETHOOK_END,          false,     true>,
        ScriptTypeInfo<TransportScript,           0,                       true,      true>,
        ScriptTypeInfo<UnitScript,                UNITHOOK_END>,
        ScriptTypeInfo<VehicleScript,             0,                       false,     true>,
        ScriptTypeInfo<WeatherScript,             0,                       true,      true>,
        ScriptTypeInfo<WorldMapScript,            0,                       true,      true>,
        ScriptTypeInfo<WorldObjectScript,         WORLDOBJECTHOOK_END>,
        ScriptTypeInfo<WorldScript,               WORLDHOOK_END,           false,     true>>;

    // These counts mirror the four hand-maintained lists this consolidation
    // replaced. If a flag is mistyped or a type is added without its metadata,
    // the build fails here instead of silently drifting.
    static_assert(Acore::size_v<ScriptRegistryTypes> == 48, "Update count when adding a script registry type");
    static_assert(Acore::count_if<ScriptRegistryTypes>([]<typename Info>() { return Info::HasEnabledHooks; }) == 27, "Enabled-hook script type count changed");
    static_assert(Acore::count_if<ScriptRegistryTypes>([]<typename Info>() { return Info::PromotedAfterDbLoad; }) == 14, "After-load script type count changed");
    static_assert(Acore::count_if<ScriptRegistryTypes>([]<typename Info>() { return Info::LegacyDbValidationCandidate; }) == 34, "Database-check script type count changed");
}

struct TSpellSummary
{
    uint8 Targets; // set of enum SelectTarget
    uint8 Effects; // set of enum SelectEffect
}*SpellSummary;

ScriptMgr::ScriptMgr()
    : _scriptCount(0),
    _scheduledScripts(0),
    _script_loader_callback(nullptr),
    _modules_loader_callback(nullptr) { }

ScriptMgr::~ScriptMgr() { }

ScriptMgr* ScriptMgr::instance()
{
    static ScriptMgr instance;
    return &instance;
}

void ScriptMgr::Initialize()
{
    LOG_INFO("server.loading", "> Loading C++ scripts");
    LOG_INFO("server.loading", " ");

    AddSC_SmartScripts();

    // LFGScripts
    lfg::AddSC_LFGScripts();

    ASSERT(_script_loader_callback,
        "Script loader callback wasn't registered!");

    ASSERT(_modules_loader_callback,
        "Modules loader callback wasn't registered!");

    _script_loader_callback();
    _modules_loader_callback();

    Acore::for_each<ScriptRegistryTypes>([]<typename Info>()
    {
        if constexpr (Info::HasEnabledHooks)
            ScriptRegistry<typename Info::type>::InitEnabledHooksIfNeeded(Info::EnabledHooks);
    });
}

void ScriptMgr::Unload()
{
    Acore::for_each<ScriptRegistryTypes>([]<typename Info>()
    {
        for (auto const& [scriptID, script] : ScriptRegistry<typename Info::type>::ScriptPointerList)
        {
            delete script;
        }

        ScriptRegistry<typename Info::type>::ScriptPointerList.clear();
    });

    delete[] SpellSummary;
}

void ScriptMgr::LoadDatabase()
{
    uint32 oldMSTime = getMSTime();

    sScriptSystemMgr->LoadScriptWaypoints();

    // Add all scripts that must be loaded after db/maps. Each registry's
    // after-load list is independent, so iteration order does not matter.
    Acore::for_each<ScriptRegistryTypes>([]<typename Info>()
    {
        if constexpr (Info::PromotedAfterDbLoad)
            ScriptRegistry<typename Info::type>::AddALScripts();
    });

    FillSpellSummary();

    CheckIfScriptsInDatabaseExist();

    LOG_INFO("server.loading", ">> Loaded {} C++ scripts in {} ms", GetScriptCount(), GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

void ScriptMgr::CheckIfScriptsInDatabaseExist()
{
    for (auto const& scriptName : sObjectMgr->GetScriptNames())
    {
        if (uint32 sid = sObjectMgr->GetScriptId(scriptName))
        {
            bool const hasRegisteredScript = Acore::any_of<ScriptRegistryTypes>([sid]<typename Info>()
            {
                if constexpr (Info::LegacyDbValidationCandidate)
                    return ScriptRegistry<typename Info::type>::GetScriptById(sid) != nullptr;

                return false;
            });

            if (!hasRegisteredScript)
                LOG_ERROR("sql.sql", "Script named '{}' is assigned in the database, but has no code!", scriptName);
        }
    }
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
