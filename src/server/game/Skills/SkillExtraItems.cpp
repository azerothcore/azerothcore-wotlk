/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "SkillExtraItems.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Player.h"
#include <map>

// some type definitions
// no use putting them in the header file, they're only used in this .cpp

// struct to store information about extra item creation
// one entry for every spell that is able to create an extra item
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
    QueryResult result = WorldDatabase.Query("SELECT spellId, requiredSpecialization, additionalCreateChance, newMaxOrEntry FROM skill_extra_item_template");

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
