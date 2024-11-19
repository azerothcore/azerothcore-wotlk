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

#ifndef SCRIPT_OBJECT_SPELL_SCRIPT_LOADER_H_
#define SCRIPT_OBJECT_SPELL_SCRIPT_LOADER_H_

#include "ScriptObject.h"
#include "Tuples.h"
#include "Types.h"

class SpellScriptLoader : public ScriptObject
{
protected:
    SpellScriptLoader(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Should return a fully valid SpellScript pointer.
    [[nodiscard]] virtual SpellScript* GetSpellScript() const { return nullptr; }

    // Should return a fully valid AuraScript pointer.
    [[nodiscard]] virtual AuraScript* GetAuraScript() const { return nullptr; }
};

namespace Acore::SpellScripts
{
    template<typename T>
    using is_SpellScript = std::is_base_of<SpellScript, T>;

    template<typename T>
    using is_AuraScript = std::is_base_of<AuraScript, T>;
}

template <typename... Ts>
class GenericSpellAndAuraScriptLoader : public SpellScriptLoader
{
    using SpellScriptType = typename Acore::find_type_if_t<Acore::SpellScripts::is_SpellScript, Ts...>;
    using AuraScriptType = typename Acore::find_type_if_t<Acore::SpellScripts::is_AuraScript, Ts...>;
    using ArgsType = typename Acore::find_type_if_t<Acore::is_tuple, Ts...>;

public:
    GenericSpellAndAuraScriptLoader(char const* name, ArgsType&& args) : SpellScriptLoader(name), _args(std::move(args)) { }

private:
    [[nodiscard]] SpellScript* GetSpellScript() const override
    {
        if constexpr (!std::is_same_v<SpellScriptType, Acore::find_type_end>)
        {
            return Acore::new_from_tuple<SpellScriptType>(_args);
        }
        else
        {
            return nullptr;
        }
    }

    [[nodiscard]] AuraScript* GetAuraScript() const override
    {
        if constexpr (!std::is_same_v<AuraScriptType, Acore::find_type_end>)
        {
            return Acore::new_from_tuple<AuraScriptType>(_args);
        }
        else
        {
            return nullptr;
        }
    }

    ArgsType _args;
};

#define RegisterSpellScriptWithArgs(spell_script, script_name, ...) new GenericSpellAndAuraScriptLoader<spell_script, decltype(std::make_tuple(__VA_ARGS__))>(script_name, std::make_tuple(__VA_ARGS__))
#define RegisterSpellScript(spell_script) RegisterSpellScriptWithArgs(spell_script, #spell_script)
#define RegisterSpellAndAuraScriptPairWithArgs(script_1, script_2, script_name, ...) new GenericSpellAndAuraScriptLoader<script_1, script_2, decltype(std::make_tuple(__VA_ARGS__))>(script_name, std::make_tuple(__VA_ARGS__))
#define RegisterSpellAndAuraScriptPair(script_1, script_2) RegisterSpellAndAuraScriptPairWithArgs(script_1, script_2, #script_1)

//namespace Acore::SpellScripts
//{
//    template<typename T>
//    using is_SpellScript = std::is_base_of<SpellScript, T>;
//
//    template<typename T>
//    using is_AuraScript = std::is_base_of<AuraScript, T>;
//}
//
//template <typename... Ts>
//class GenericSpellAndAuraScriptLoader : public SpellScriptLoader
//{
//    using SpellScriptType = typename Acore::find_type_if_t<Acore::SpellScripts::is_SpellScript, Ts...>;
//    using AuraScriptType = typename Acore::find_type_if_t<Acore::SpellScripts::is_AuraScript, Ts...>;
//    using ArgsType = typename Acore::find_type_if_t<Acore::is_tuple, Ts...>;
//
//public:
//    GenericSpellAndAuraScriptLoader(std::string_view name, ArgsType&& args) : SpellScriptLoader(name), _args(std::move(args)) { }
//
//private:
//    [[nodiscard]] SpellScript* GetSpellScript() const override
//    {
//        if constexpr (!std::is_same_v<SpellScriptType, Acore::find_type_end>)
//        {
//            return Acore::new_from_tuple<SpellScriptType>(_args);
//        }
//        else
//        {
//            return nullptr;
//        }
//    }
//
//    [[nodiscard]] AuraScript* GetAuraScript() const override
//    {
//        if constexpr (!std::is_same_v<AuraScriptType, Acore::find_type_end>)
//        {
//            return Acore::new_from_tuple<AuraScriptType>(_args);
//        }
//        else
//        {
//            return nullptr;
//        }
//    }
//
//    ArgsType _args;
//};
//
//#define RegisterSpellScriptWithArgs(spell_script, script_name, ...) new GenericSpellAndAuraScriptLoader<spell_script, decltype(std::make_tuple(__VA_ARGS__))>(script_name, std::make_tuple(__VA_ARGS__))
//#define RegisterSpellScript(spell_script) RegisterSpellScriptWithArgs(spell_script, #spell_script)
//#define RegisterSpellAndAuraScriptPairWithArgs(script_1, script_2, script_name, ...) new GenericSpellAndAuraScriptLoader<script_1, script_2, decltype(std::make_tuple(__VA_ARGS__))>(script_name, std::make_tuple(__VA_ARGS__))
//#define RegisterSpellAndAuraScriptPair(script_1, script_2) RegisterSpellAndAuraScriptPairWithArgs(script_1, script_2, #script_1)

#endif
