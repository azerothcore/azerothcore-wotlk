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

#ifndef _CHATCOMMAND_H
#define _CHATCOMMAND_H

#include "ChatCommandArgs.h"
#include "ChatCommandTags.h"
#include "Define.h"
#include "Errors.h"
#include "Language.h"
#include "Optional.h"
#include "StringFormat.h"
#include "Util.h"
#include <cstddef>
#include <map>
#include <tuple>
#include <variant>
#include <vector>

class ChatHandler;

namespace Acore::ChatCommands
{
    enum class Console : bool
    {
        No = false,
        Yes = true
    };

    struct ChatCommandBuilder;
    using ChatCommandTable = std::vector<ChatCommandBuilder>;
}

namespace Acore::Impl::ChatCommands
{
    // forward declaration
    // ConsumeFromOffset contains the bounds check for offset, then hands off to MultiConsumer
    // the call stack is MultiConsumer -> ConsumeFromOffset -> MultiConsumer -> ConsumeFromOffset etc
    // MultiConsumer goes into ArgInfo for parsing on each iteration
    template <typename Tuple, std::size_t offset>
    ChatCommandResult ConsumeFromOffset(Tuple&, ChatHandler const* handler, std::string_view args);

    template <typename Tuple, typename NextType, std::size_t offset>
    struct MultiConsumer
    {
        static ChatCommandResult TryConsumeTo(Tuple& tuple, ChatHandler const* handler, std::string_view args)
        {
            ChatCommandResult next = ArgInfo<NextType>::TryConsume(std::get<offset>(tuple), handler, args);
            if (next)
                return ConsumeFromOffset<Tuple, offset + 1>(tuple, handler, *next);
            else
                return next;
        }
    };

    template <typename Tuple, typename NestedNextType, std::size_t offset>
    struct MultiConsumer<Tuple, Optional<NestedNextType>, offset>
    {
        static ChatCommandResult TryConsumeTo(Tuple& tuple, ChatHandler const* handler, std::string_view args)
        {
            // try with the argument
            auto& myArg = std::get<offset>(tuple);
            myArg.emplace();

            ChatCommandResult result1 = ArgInfo<NestedNextType>::TryConsume(myArg.value(), handler, args);
            if (result1)
                if ((result1 = ConsumeFromOffset<Tuple, offset + 1>(tuple, handler, *result1)))
                    return result1;
            // try again omitting the argument
            myArg = std::nullopt;
            ChatCommandResult result2 = ConsumeFromOffset<Tuple, offset + 1>(tuple, handler, args);
            if (result2)
                return result2;
            if (result1.HasErrorMessage() && result2.HasErrorMessage())
            {
                return Acore::StringFormat("{} \"{}\"\n{} \"{}\"",
                    GetAcoreString(handler, LANG_CMDPARSER_EITHER), result2.GetErrorMessage(),
                    GetAcoreString(handler, LANG_CMDPARSER_OR), result1.GetErrorMessage());
            }
            else if (result1.HasErrorMessage())
                return result1;
            else
                return result2;
        }
    };

    template <typename Tuple, std::size_t offset>
    ChatCommandResult ConsumeFromOffset([[maybe_unused]] Tuple& tuple, [[maybe_unused]] ChatHandler const* handler, std::string_view args)
    {
        if constexpr (offset < std::tuple_size_v<Tuple>)
            return MultiConsumer<Tuple, std::tuple_element_t<offset, Tuple>, offset>::TryConsumeTo(tuple, handler, args);
        else if (!args.empty()) /* the entire string must be consumed */
            return std::nullopt;
        else
            return args;
    }

    template <typename T> struct HandlerToTuple { static_assert(Acore::dependant_false_v<T>, "Invalid command handler signature"); };
    template <typename... Ts> struct HandlerToTuple<bool(ChatHandler*, Ts...)> { using type = std::tuple<ChatHandler*, std::remove_cvref_t<Ts>...>; };
    template <typename T> using TupleType = typename HandlerToTuple<T>::type;

    struct CommandInvoker
    {
        CommandInvoker() : _wrapper(nullptr), _handler(nullptr) {}
        template <typename TypedHandler>
        CommandInvoker(TypedHandler& handler)
        {
            _wrapper = [](void* handler, ChatHandler* chatHandler, std::string_view argsStr)
            {
                using Tuple = TupleType<TypedHandler>;

                Tuple arguments;
                std::get<0>(arguments) = chatHandler;
                ChatCommandResult result = ConsumeFromOffset<Tuple, 1>(arguments, chatHandler, argsStr);
                if (result)
                    return std::apply(reinterpret_cast<TypedHandler*>(handler), std::move(arguments));
                else
                {
                    if (result.HasErrorMessage())
                        SendErrorMessageToHandler(chatHandler, result.GetErrorMessage());
                    return false;
                }
            };
            _handler = reinterpret_cast<void*>(handler);
        }
        CommandInvoker(bool(&handler)(ChatHandler*, char const*))
        {
            _wrapper = [](void* handler, ChatHandler* chatHandler, std::string_view argsStr)
            {
                // make a copy of the argument string
                // legacy handlers can destroy input strings with strtok
                std::string argsStrCopy(argsStr);
                return reinterpret_cast<bool(*)(ChatHandler*, char const*)>(handler)(chatHandler, argsStrCopy.c_str());
            };
            _handler = reinterpret_cast<void*>(handler);
        }

        explicit operator bool() const { return (_wrapper != nullptr); }
        bool operator()(ChatHandler* chatHandler, std::string_view args) const
        {
            ASSERT(_wrapper && _handler);
            return _wrapper(_handler, chatHandler, args);
        }

    private:
        using wrapper_func = bool(void*, ChatHandler*, std::string_view);
        wrapper_func* _wrapper;
        void* _handler;
    };

    struct CommandPermissions
    {
        CommandPermissions() : RequiredLevel{}, AllowConsole{} { }
        CommandPermissions(uint32 securityLevel, Acore::ChatCommands::Console console) : RequiredLevel{ securityLevel }, AllowConsole{ console } {}
        uint32 RequiredLevel;
        Acore::ChatCommands::Console AllowConsole;
    };

    class ChatCommandNode
    {
    friend struct FilteredCommandListIterator;
    using ChatCommandBuilder = Acore::ChatCommands::ChatCommandBuilder;

    public:
        static void LoadCommandMap();
        static void InvalidateCommandMap();
        static bool TryExecuteCommand(ChatHandler& handler, std::string_view cmd);
        static void SendCommandHelpFor(ChatHandler& handler, std::string_view cmd);
        static std::vector<std::string> GetAutoCompletionsFor(ChatHandler const& handler, std::string_view cmd);

        ChatCommandNode() : _name{}, _invoker {}, _permission{}, _help{}, _subCommands{} { }

    private:
        static std::map<std::string_view, ChatCommandNode, StringCompareLessI_T> const& GetTopLevelMap();
        static void LoadCommandsIntoMap(ChatCommandNode* blank, std::map<std::string_view, Acore::Impl::ChatCommands::ChatCommandNode, StringCompareLessI_T>& map, Acore::ChatCommands::ChatCommandTable const& commands);

        void LoadFromBuilder(ChatCommandBuilder const& builder);
        ChatCommandNode(ChatCommandNode&& other) = default;

        void ResolveNames(std::string name);
        void SendCommandHelp(ChatHandler& handler) const;

        bool IsVisible(ChatHandler const& who) const { return (IsInvokerVisible(who) || HasVisibleSubCommands(who)); }
        bool IsInvokerVisible(ChatHandler const& who) const;
        bool HasVisibleSubCommands(ChatHandler const& who) const;

        std::string _name;
        CommandInvoker _invoker;
        CommandPermissions _permission;
        std::variant<std::monostate, AcoreStrings, std::string> _help;
        std::map<std::string_view, ChatCommandNode, StringCompareLessI_T> _subCommands;
    };
}

namespace Acore::ChatCommands
{
    struct ChatCommandBuilder
    {
        friend class Acore::Impl::ChatCommands::ChatCommandNode;

        struct InvokerEntry
        {
            template <typename T>
            InvokerEntry(T& handler, AcoreStrings help, uint32 securityLevel, Acore::ChatCommands::Console allowConsole)
                : _invoker{ handler }, _help{ help }, _permissions{ securityLevel, allowConsole } { }

            InvokerEntry(InvokerEntry const&) = default;
            InvokerEntry(InvokerEntry&&) = default;

            Acore::Impl::ChatCommands::CommandInvoker _invoker;
            AcoreStrings _help;
            Acore::Impl::ChatCommands::CommandPermissions _permissions;

            auto operator*() const { return std::tie(_invoker, _help, _permissions); }
        };

        using SubCommandEntry = std::reference_wrapper<std::vector<ChatCommandBuilder> const>;

        ChatCommandBuilder(ChatCommandBuilder&&) = default;
        ChatCommandBuilder(ChatCommandBuilder const&) = default;

        template <typename TypedHandler>
        ChatCommandBuilder(char const* name, TypedHandler& handler, AcoreStrings help, uint32 securityLevel, Acore::ChatCommands::Console allowConsole)
            : _name{ ASSERT_NOTNULL(name) }, _data{ std::in_place_type<InvokerEntry>, handler, help, securityLevel, allowConsole } { }

        template <typename TypedHandler>
        ChatCommandBuilder(char const* name, TypedHandler& handler, uint32 securityLevel, Acore::ChatCommands::Console allowConsole)
            : ChatCommandBuilder(name, handler, AcoreStrings(), securityLevel, allowConsole) { }

        ChatCommandBuilder(char const* name, std::vector<ChatCommandBuilder> const& subCommands)
            : _name{ ASSERT_NOTNULL(name) }, _data{ std::in_place_type<SubCommandEntry>, subCommands } { }

    private:
        std::string_view _name;
        std::variant<InvokerEntry, SubCommandEntry> _data;
    };

    AC_GAME_API void LoadCommandMap();
    AC_GAME_API void InvalidateCommandMap();
    AC_GAME_API bool TryExecuteCommand(ChatHandler& handler, std::string_view cmd);
    AC_GAME_API void SendCommandHelpFor(ChatHandler& handler, std::string_view cmd);
    AC_GAME_API std::vector<std::string> GetAutoCompletionsFor(ChatHandler const& handler, std::string_view cmd);
}

// backwards compatibility with old patches
using ChatCommand [[deprecated("std::vector<ChatCommand> should be ChatCommandTable! (using namespace Acore::ChatCommands)")]] = Acore::ChatCommands::ChatCommandBuilder;

#endif
