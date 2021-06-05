/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "ChatCommandArgs.h"
#include "AchievementMgr.h"
#include "ChatCommand.h"
#include "ObjectMgr.h"
#include "SpellMgr.h"
#include "Util.h"

using namespace Acore::ChatCommands;
using ChatCommandResult = Acore::Impl::ChatCommands::ChatCommandResult;

struct AchievementVisitor
{
    using value_type = AchievementEntry const*;
    value_type operator()(Hyperlink<achievement> achData) const { return achData->Achievement; }
    value_type operator()(uint32 achId) const { return sAchievementMgr->GetAchievement(achId); }
};

ChatCommandResult Acore::Impl::ChatCommands::ArgInfo<AchievementEntry const*>::TryConsume(AchievementEntry const*& data, ChatHandler const* handler, std::string_view args)
{
    Variant<Hyperlink<achievement>, uint32> val;
    ChatCommandResult result = ArgInfo<decltype(val)>::TryConsume(val, handler, args);

    if (!result || (data = val.visit(AchievementVisitor())))
        return result;

    if (uint32* id = std::get_if<uint32>(&val))
        return FormatAcoreString(handler, LANG_CMDPARSER_ACHIEVEMENT_NO_EXIST, *id);

    return std::nullopt;
}

struct GameTeleVisitor
{
    using value_type = GameTele const*;
    value_type operator()(Hyperlink<tele> tele) const { return sObjectMgr->GetGameTele(tele); }
    value_type operator()(std::string_view tele) const { return sObjectMgr->GetGameTele(tele); }
};

ChatCommandResult Acore::Impl::ChatCommands::ArgInfo<GameTele const*>::TryConsume(GameTele const*& data, ChatHandler const* handler, std::string_view args)
{
    Variant<Hyperlink<tele>, std::string_view> val;
    ChatCommandResult result = ArgInfo<decltype(val)>::TryConsume(val, handler, args);

    if (!result || (data = val.visit(GameTeleVisitor())))
        return result;

    if (val.holds_alternative<Hyperlink<tele>>())
        return FormatAcoreString(handler, LANG_CMDPARSER_GAME_TELE_ID_NO_EXIST, static_cast<uint32>(std::get<Hyperlink<tele>>(val)));
    else
        return FormatAcoreString(handler, LANG_CMDPARSER_GAME_TELE_NO_EXIST, STRING_VIEW_FMT_ARG(std::get<std::string_view>(val)));
}

struct ItemTemplateVisitor
{
    using value_type = ItemTemplate const*;
    value_type operator()(Hyperlink<item> item) const { return item->Item; }
    value_type operator()(uint32 item) { return sObjectMgr->GetItemTemplate(item); }
};

ChatCommandResult Acore::Impl::ChatCommands::ArgInfo<ItemTemplate const*>::TryConsume(ItemTemplate const*& data, ChatHandler const* handler, std::string_view args)
{
    Variant<Hyperlink<item>, uint32> val;
    ChatCommandResult result = ArgInfo<decltype(val)>::TryConsume(val, handler, args);

    if (!result || (data = val.visit(ItemTemplateVisitor())))
        return result;

    if (uint32* id = std::get_if<uint32>(&val))
        return FormatAcoreString(handler, LANG_CMDPARSER_ITEM_NO_EXIST, *id);

    return std::nullopt;
}

struct SpellInfoVisitor
{
    using value_type = SpellInfo const*;
    value_type operator()(Hyperlink<enchant> enchant) const { return enchant; };
    value_type operator()(Hyperlink<glyph> glyph) const { return operator()(glyph->Glyph->SpellId); };
    value_type operator()(Hyperlink<spell> spell) const { return *spell; }
    value_type operator()(Hyperlink<talent> talent) const
    {
        return operator()(talent->Talent->RankID[talent->Rank - 1]);
    };
    value_type operator()(Hyperlink<trade> trade) const { return trade->Spell; };

    value_type operator()(uint32 spellId) const { return sSpellMgr->GetSpellInfo(spellId); }
};

ChatCommandResult Acore::Impl::ChatCommands::ArgInfo<SpellInfo const*>::TryConsume(SpellInfo const*& data, ChatHandler const* handler, std::string_view args)
{
    Variant<Hyperlink<enchant>, Hyperlink<glyph>, Hyperlink<spell>, Hyperlink<talent>, Hyperlink<trade>, uint32> val;
    ChatCommandResult result = ArgInfo<decltype(val)>::TryConsume(val, handler, args);

    if (!result || (data = val.visit(SpellInfoVisitor())))
        return result;

    if (uint32* id = std::get_if<uint32>(&val))
        return FormatAcoreString(handler, LANG_CMDPARSER_SPELL_NO_EXIST, *id);

    return std::nullopt;
}
