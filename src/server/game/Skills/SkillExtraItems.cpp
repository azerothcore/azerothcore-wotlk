/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "SkillExtraItems.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Player.h"
#include "ObjectMgr.h"
#include <map>

// some type definitions
// no use putting them in the header file, they're only used in this .cpp

// struct to store information about extra item creation
// one entry for every spell that is able to create an extra item
struct SkillPerfectItemEntry
{
    // the spell id of the spell required - it's named "specialization" to conform with SkillExtraItemEntry
    uint32 requiredSpecialization;
    // perfection proc chance
    float perfectCreateChance;
    // itemid of the resulting perfect item
    uint32 perfectItemType;

    SkillPerfectItemEntry()
        : requiredSpecialization(0), perfectCreateChance(0.0f), perfectItemType(0) { }
    SkillPerfectItemEntry(uint32 rS, float pCC, uint32 pIT)
        : requiredSpecialization(rS), perfectCreateChance(pCC), perfectItemType(pIT) { }
};

// map to store perfection info. key = spellId of the creation spell, value is the perfectitementry as specified above
typedef std::map<uint32, SkillPerfectItemEntry> SkillPerfectItemMap;

SkillPerfectItemMap SkillPerfectItemStore;

// loads the perfection proc info from DB
void LoadSkillPerfectItemTable()
{
    uint32 oldMSTime = getMSTime();

    SkillPerfectItemStore.clear(); // reload capability

    //                                                  0               1                      2                  3
    QueryResult result = WorldDatabase.Query("SELECT spellId, requiredSpecialization, perfectCreateChance, perfectItemType FROM skill_perfect_item_template");

    if (!result)
    {
        sLog->outErrorDb(">> Loaded 0 spell perfection definitions. DB table `skill_perfect_item_template` is empty.");
        sLog->outString();
        return;
    }

    uint32 count = 0;

    do /* fetch data and run sanity checks */
    {
        Field* fields = result->Fetch();

        uint32 spellId = fields[0].GetUInt32();

        if (!sSpellMgr->GetSpellInfo(spellId))
        {
            sLog->outError("Skill perfection data for spell %u has non-existent spell id in `skill_perfect_item_template`!", spellId);
            continue;
        }

        uint32 requiredSpecialization = fields[1].GetUInt32();
        if (!sSpellMgr->GetSpellInfo(requiredSpecialization))
        {
            sLog->outError("Skill perfection data for spell %u has non-existent required specialization spell id %u in `skill_perfect_item_template`!", spellId, requiredSpecialization);
            continue;
        }

        float perfectCreateChance = fields[2].GetFloat();
        if (perfectCreateChance <= 0.0f)
        {
            sLog->outError("Skill perfection data for spell %u has impossibly low proc chance in `skill_perfect_item_template`!", spellId);
            continue;
        }

        uint32 perfectItemType = fields[3].GetUInt32();
        if (!sObjectMgr->GetItemTemplate(perfectItemType))
        {
            sLog->outError("Skill perfection data for spell %u references non-existent perfect item id %u in `skill_perfect_item_template`!", spellId, perfectItemType);
            continue;
        }

        SkillPerfectItemEntry& skillPerfectItemEntry = SkillPerfectItemStore[spellId];

        skillPerfectItemEntry.requiredSpecialization = requiredSpecialization;
        skillPerfectItemEntry.perfectCreateChance = perfectCreateChance;
        skillPerfectItemEntry.perfectItemType = perfectItemType;

        ++count;
    } while (result->NextRow());

    sLog->outString(">> Loaded %u spell perfection definitions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

struct SkillExtraItemEntry
{
    // the spell id of the specialization required to create extra items
    uint32 requiredSpecialization;
    // the chance to create one additional item
    float additionalCreateChance;
    // maximum number of extra items created per crafting
    int32 newMaxOrEntry;

    SkillExtraItemEntry()
        : requiredSpecialization(0), additionalCreateChance(0.0f), newMaxOrEntry(0) {}

    SkillExtraItemEntry(uint32 rS, float aCC, int32 nMOE)
        : requiredSpecialization(rS), additionalCreateChance(aCC), newMaxOrEntry(nMOE) {}
};

// map to store the extra item creation info, the key is the spellId of the creation spell, the mapped value is the assigned SkillExtraItemEntry
typedef std::map<uint32, SkillExtraItemEntry> SkillExtraItemMap;

SkillExtraItemMap SkillExtraItemStore;

// loads the extra item creation info from DB
void LoadSkillExtraItemTable()
{
    uint32 oldMSTime = getMSTime();

    SkillExtraItemStore.clear();                            // need for reload

    //                                                  0               1                       2                    3
    QueryResult result = WorldDatabase.Query("SELECT spellId, requiredSpecialization, additionalCreateChance, additionalMaxNum FROM skill_extra_item_template");

    if (!result)
    {
        sLog->outErrorDb(">> Loaded 0 spell specialization definitions. DB table `skill_extra_item_template` is empty.");
        sLog->outString();
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 spellId = fields[0].GetUInt32();

        if (!sSpellMgr->GetSpellInfo(spellId))
        {
            sLog->outError("Skill specialization %u has non-existent spell id in `skill_extra_item_template`!", spellId);
            continue;
        }

        uint32 requiredSpecialization = fields[1].GetUInt32();
        if (!sSpellMgr->GetSpellInfo(requiredSpecialization))
        {
            sLog->outError("Skill specialization %u have not existed required specialization spell id %u in `skill_extra_item_template`!", spellId, requiredSpecialization);
            continue;
        }

        float additionalCreateChance = fields[2].GetFloat();
        if (additionalCreateChance <= 0.0f)
        {
            sLog->outError("Skill specialization %u has too low additional create chance in `skill_extra_item_template`!", spellId);
            continue;
        }

        int32 newMaxOrEntry = fields[3].GetInt32();
        if (!newMaxOrEntry)
        {
            sLog->outError("Skill specialization %u has 0 max number of extra items in `skill_extra_item_template`!", spellId);
            continue;
        }

        SkillExtraItemEntry& skillExtraItemEntry = SkillExtraItemStore[spellId];

        skillExtraItemEntry.requiredSpecialization = requiredSpecialization;
        skillExtraItemEntry.additionalCreateChance = additionalCreateChance;
        skillExtraItemEntry.newMaxOrEntry          = newMaxOrEntry;

        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u spell specialization definitions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

bool CanCreatePerfectItem(Player* player, uint32 spellId, float &perfectCreateChance, uint32 &perfectItemType)
{
    SkillPerfectItemMap::const_iterator ret = SkillPerfectItemStore.find(spellId);
    // no entry in DB means no perfection proc possible
    if (ret == SkillPerfectItemStore.end())
        return false;

    SkillPerfectItemEntry const* thisEntry = &ret->second;
    // lack of entry means no perfection proc possible
    if (!thisEntry)
        return false;

    // if you don't have the spell needed, then no procs for you
    if (!player->HasSpell(thisEntry->requiredSpecialization))
        return false;

    // set values as appropriate
    perfectCreateChance = thisEntry->perfectCreateChance;
    perfectItemType = thisEntry->perfectItemType;

    // and tell the caller to start rolling the dice
    return true;
}

bool canCreateExtraItems(Player* player, uint32 spellId, float &additionalChance, int32 &newMaxOrEntry)
{
    // get the info for the specified spell
    SkillExtraItemMap::const_iterator ret = SkillExtraItemStore.find(spellId);
    if (ret == SkillExtraItemStore.end())
        return false;

    SkillExtraItemEntry const* specEntry = &ret->second;

    // if no entry, then no extra items can be created
    if (!specEntry)
        return false;

    // the player doesn't have the required specialization, return false
    if (!player->HasSpell(specEntry->requiredSpecialization))
        return false;

    // set the arguments to the appropriate values
    additionalChance = specEntry->additionalCreateChance;
    newMaxOrEntry = specEntry->newMaxOrEntry;

    // enable extra item creation
    return true;
}
