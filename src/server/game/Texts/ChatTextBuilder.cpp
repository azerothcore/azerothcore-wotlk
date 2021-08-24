/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ Trinitycore <https://TrinityCore.org/>
 */

#include "ChatTextBuilder.h"
#include "Chat.h"
#include "ObjectMgr.h"
#include <cstdarg>

void Acore::BroadcastTextBuilder::operator()(WorldPacket& data, LocaleConstant locale) const
{
    BroadcastText const* bct = sObjectMgr->GetBroadcastText(_textId);
    ChatHandler::BuildChatPacket(data, _msgType, bct ? Language(bct->LanguageID) : LANG_UNIVERSAL, _source, _target, bct ? bct->GetText(locale, _gender) : "", _achievementId, "", locale);
}

size_t Acore::BroadcastTextBuilder::operator()(WorldPacket* data, LocaleConstant locale) const
{
    BroadcastText const* bct = sObjectMgr->GetBroadcastText(_textId);
    return ChatHandler::BuildChatPacket(*data, _msgType, bct ? Language(bct->LanguageID) : LANG_UNIVERSAL, _source, _target, bct ? bct->GetText(locale, _gender) : "", _achievementId, "", locale);
}

void Acore::CustomChatTextBuilder::operator()(WorldPacket& data, LocaleConstant locale) const
{
    ChatHandler::BuildChatPacket(data, _msgType, _language, _source, _target, _text, 0, "", locale);
}

void Acore::AcoreStringChatBuilder::operator()(WorldPacket& data, LocaleConstant locale) const
{
    char const* text = sObjectMgr->GetAcoreString(_textId, locale);

    if (_args)
    {
        // we need copy va_list before use or original va_list will corrupted
        va_list ap;
        va_copy(ap, *_args);

        static size_t const BufferSize = 2048;
        char strBuffer[BufferSize];
        vsnprintf(strBuffer, BufferSize, text, ap);
        va_end(ap);

        ChatHandler::BuildChatPacket(data, _msgType, LANG_UNIVERSAL, _source, _target, strBuffer, 0, "", locale);
    }
    else
        ChatHandler::BuildChatPacket(data, _msgType, LANG_UNIVERSAL, _source, _target, text, 0, "", locale);
}
