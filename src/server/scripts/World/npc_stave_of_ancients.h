/* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 *
 *
 * This program is free software licensed under GPL version 2
 * Please see the included DOCS/LICENSE.TXT for more information */

#ifndef NPC_STAVE_OF_ANCIENTS_H
#define NPC_STAVE_OF_ANCIENTS_H

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum StaveOfAncients
{
    QUEST_STAVE_OF_THE_ANCIENTS               = 7636
};

enum CommonEvents
{
    EVENT_ENCOUNTER_START                     = 1,
    EVENT_REVEAL                              = 2,
    EVENT_RANGE_CHECK                         = 3,
    EVENT_UNFAIR_FIGHT                        = 4
};

enum NPCArtorius
{
    ARTORIUS_EVENT_DEMONIC_DOOM               = 5,

    ARTORIUS_GOSSIP_TEXT                      = 7045,   // npc_text.ID               "How wonderful to see another person in..."
    ARTORIUS_GOSSIP_OPTION_TEXT               = 14531,  // creature_text.CreatureID  "I know you as Artorius the Doombringer..."
    ARTORIUS_WEAKNESS_EMOTE                   = 9786,   // broadcast_text.ID         "%s is stricken by a virulent poison."
    ARTORIUS_SAY                              = 9787,   // broadcast_text.ID         "Your soul is mine, weakling."

    ARTORIUS_NORMAL_ENTRY                     = 14531,  // creature_template.entry
    ARTORIUS_EVIL_ENTRY                       = 14535,  // creature_template.entry

    ARTORIUS_HEAD                             = 18955,   // item_template.entry

    ARTORIUS_SPELL_DEMONIC_DOOM               = 23298,
    ARTORIUS_SPELL_STINGING_TRAUMA            = 23299
};

struct NPCStaveQuestAI : public ScriptedAI
{
    NPCStaveQuestAI(Creature *creature) : ScriptedAI(creature) { }

    ObjectGuid playerGUID;
    bool encounterStarted;
    ThreatContainer::StorageType const& threatList = me->getThreatManager().getThreatList();

    std::map<int, int> entryKeys = {
        { ARTORIUS_NORMAL_ENTRY, 1 },
        { ARTORIUS_EVIL_ENTRY, 1 }
    };
    std::map<int, std::map<std::string, int>> entryList = {
        {
            1, {
                {"normal", ARTORIUS_NORMAL_ENTRY},
                {"evil", ARTORIUS_EVIL_ENTRY}
            }
        }
    };

    uint32 GetFormEntry(std::string /*type*/);
    bool InNormalForm();
    void RevealForm();
    void StorePlayerGUID();
    bool IsAllowedEntry(uint32 /*entry*/);
    bool IsFairFight();
    bool ValidThreatlist();
    void SetHomePosition();
    void PrepareForEncounter();
};

#endif
