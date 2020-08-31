/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef AZEROTHCORE_CHATLINK_H
#define AZEROTHCORE_CHATLINK_H

#include "SharedDefines.h"
#include <sstream>
#include <list>

struct ItemLocale;
struct ItemTemplate;
struct ItemRandomSuffixEntry;
struct ItemRandomPropertiesEntry;
class SpellInfo;
struct AchievementEntry;
struct GlyphPropertiesEntry;
class Quest;

///////////////////////////////////////////////////////////////////////////////////////////////////
// ChatLink - abstract base class for various links
class ChatLink
{
public:
    ChatLink() : _color(0), _startPos(0), _endPos(0) { }
    virtual ~ChatLink() { }
    void SetColor(uint32 color) { _color = color; }
    // This will allow to extract the whole link string from the message, if necessary.
    void SetBounds(std::istringstream::pos_type startPos, std::istringstream::pos_type endPos) { _startPos = startPos; _endPos = endPos; }

    virtual bool Initialize(std::istringstream& iss) = 0;
    virtual bool ValidateName(char* buffer, const char* context) = 0;

protected:
    uint32 _color;
    std::string _name;
    std::istringstream::pos_type _startPos;
    std::istringstream::pos_type _endPos;
};

// ItemChatLink - link to item
class ItemChatLink : public ChatLink
{
public:
    ItemChatLink() : ChatLink(), _item(nullptr), _suffix(nullptr), _property(nullptr)
    { 
        memset(_data, 0, sizeof(_data));
    }
    virtual bool Initialize(std::istringstream& iss);
    virtual bool ValidateName(char* buffer, const char* context);

protected:
    std::string FormatName(uint8 index, ItemLocale const* locale, char* const* suffixStrings) const;

    ItemTemplate const* _item;
    int32 _data[8];
    ItemRandomSuffixEntry const* _suffix;
    ItemRandomPropertiesEntry const* _property;
};

// QuestChatLink - link to quest
class QuestChatLink : public ChatLink
{
public:
    QuestChatLink() : ChatLink(), _quest(nullptr), _questLevel(0) { }
    virtual bool Initialize(std::istringstream& iss);
    virtual bool ValidateName(char* buffer, const char* context);

protected:
    Quest const* _quest;
    int32 _questLevel;
};

// SpellChatLink - link to quest
class SpellChatLink : public ChatLink
{
public:
    SpellChatLink() : ChatLink(), _spell(nullptr) { }
    virtual bool Initialize(std::istringstream& iss);
    virtual bool ValidateName(char* buffer, const char* context);

protected:
    SpellInfo const* _spell;
};

// AchievementChatLink - link to quest
class AchievementChatLink : public ChatLink
{
public:
    AchievementChatLink() : ChatLink(), _guid(0), _achievement(nullptr)
    { 
        memset(_data, 0, sizeof(_data));
    }
    virtual bool Initialize(std::istringstream& iss);
    virtual bool ValidateName(char* buffer, const char* context);

protected:
    uint32 _guid;
    AchievementEntry const* _achievement;
    uint32 _data[8];
};

// TradeChatLink - link to trade info
class TradeChatLink : public SpellChatLink
{
public:
    TradeChatLink() : SpellChatLink(), _minSkillLevel(0), _maxSkillLevel(0), _guid(0) { }
    virtual bool Initialize(std::istringstream& iss);
private:
    int32 _minSkillLevel;
    int32 _maxSkillLevel;
    uint32 _guid;
    std::string _base64;
};

// TalentChatLink - link to talent
class TalentChatLink : public SpellChatLink
{
public:
    TalentChatLink() : SpellChatLink(), _talentId(0), _rankId(0) { }
    virtual bool Initialize(std::istringstream& iss);

private:
    uint32 _talentId;
    int32 _rankId;
};

// EnchantmentChatLink - link to enchantment
class EnchantmentChatLink : public SpellChatLink
{
public:
    EnchantmentChatLink() : SpellChatLink() { }
    virtual bool Initialize(std::istringstream& iss);
};

// GlyphChatLink - link to glyph
class GlyphChatLink : public SpellChatLink
{
public:
    GlyphChatLink() : SpellChatLink(), _slotId(0), _glyph(nullptr) { }
    virtual bool Initialize(std::istringstream& iss);
private:
    uint32 _slotId;
    GlyphPropertiesEntry const* _glyph;
};

class LinkExtractor
{
public:
    explicit LinkExtractor(const char* msg);
    ~LinkExtractor();

    bool IsValidMessage();

private:
    typedef std::list<ChatLink*> Links;
    Links _links;
    std::istringstream _iss;
};


#endif
