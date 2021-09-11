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
    EVENT_UNFAIR_FIGHT                        = 4,
    EVENT_FOOLS_PLIGHT                        = 5
};

enum NPCArtorius
{
    ARTORIUS_EVENT_DEMONIC_DOOM               = 5,
    ARTORIUS_EVENT_DEMONIC_ENRAGE             = 6,

    ARTORIUS_GOSSIP_TEXT                      = 7045,   // npc_text.ID               "How wonderful to see another person in..."
    ARTORIUS_GOSSIP_OPTION_TEXT               = 14531,  // creature_text.CreatureID  "I know you as Artorius the Doombringer..."
    ARTORIUS_WEAKNESS_EMOTE                   = 9786,   // broadcast_text.ID         "%s is stricken by a virulent poison."
    ARTORIUS_SAY                              = 9787,   // broadcast_text.ID         "Your soul is mine, weakling."

    ARTORIUS_NORMAL_ENTRY                     = 14531,  // creature_template.entry
    ARTORIUS_EVIL_ENTRY                       = 14535,  // creature_template.entry

    ARTORIUS_HEAD                             = 18955,  // item_template.entry

    ARTORIUS_SPELL_DEMONIC_ENRAGE             = 23257,
    ARTORIUS_SPELL_DEMONIC_DOOM               = 23298,
    ARTORIUS_SPELL_STINGING_TRAUMA            = 23299
};

enum NPCSimone
{
    SIMONE_EVENT_TALK                         = 6,
    SIMONE_EVENT_CHECK_PET_STATE              = 7,
    SIMONE_EVENT_CHAIN_LIGHTNING              = 8,
    SIMONE_EVENT_TEMPTRESS_KISS               = 9,

    SIMONE_GOSSIP_TEXT                        = 7041,   // npc_text.ID               "What a wonderful day to be alive! Look ..."
    SIMONE_GOSSIP_OPTION_TEXT                 = 14527,  // creature_text.CreatureID  "I am not fooled by your disguise, tempt..."
    SIMONE_EMOTE                              = 9759,   // broadcast_text.ID         "%s laughs at your foolish request."
    SIMONE_SAY                                = 9760,   // broadcast_text.ID         "As you wish, $c."
    SIMONE_WEAKNESS_EMOTE                     = 9762,   // broadcast_text.ID         "%s is silenced by the venomous sting."

    SIMONE_NORMAL_ENTRY                       = 14527,  // creature_template.entry
    SIMONE_EVIL_ENTRY                         = 14533,  // creature_template.entry

    SIMONE_HEAD                               = 18952,  // item_template.entry

    SIMONE_SPELL_WEAKNESS_VIPER_STING         = 3034,
    SIMONE_SPELL_TEMPTRESS_KISS               = 23205,
    SIMONE_SPELL_CHAIN_LIGHTNING              = 23206,
    // Found 23207 using spell editor it matches the duration, it doesn't have animation and the id is close to the other simone spells
    SIMONE_SPELL_SILENCE                      = 23207,
    SPELL_FOOLS_PLIGHT                        = 23504
};

enum NPCPrecious
{
    PRECIOUS_GOSSIP_TEXT                      = 7042,   // npc_text.ID               "*GRRRR* *RUFF* *RUFF*"

    PRECIOUS_NORMAL_ENTRY                     = 14528,
    PRECIOUS_EVIL_ENTRY                       = 14538
};

enum NPCNelson
{
    NELSON_EVENT_DREADFUL_FRIGHT              = 7,
    NELSON_EVENT_CREEPING_DOOM                = 8,

    NELSON_GOSSIP_TEXT                        = 7044,  // npc_text.ID                "I come to Silithus every year around th..."
    NELSON_GOSSIP_OPTION_TEXT                 = 14536, // creature_text.CreatureID   "A gnome? How pathetic. Face me, demon!"
    NELSON_SAY                                = 9782,  // broadcast_text.ID          "You dare challenge me? Prepare for an e..."
    NELSON_WEAKNESS_EMOTE                     = 9785,  // breadcast_text.ID          "%s is immobilized."
    NELSON_DESPAWN_SAY                        = 9815,  // breadcast_text.ID          "Only a fool would remain in this battle..."

    NELSON_NORMAL_ENTRY                       = 14536, // creature_template.entry
    NELSON_EVIL_ENTRY                         = 14530, // creature_template.entry
    CREEPING_DOOM_ENTRY                       = 14761,

    NELSON_HEAD                               = 18954, // item_template.entry

    NELSON_WEAKNESS_WING_CLIP                 = 2974,
    NELSON_WEAKNESS_FROST_TRAP                = 13810,

    NELSON_SPELL_SOUL_FLAME                   = 23272,
    NELSON_SPELL_DREADFUL_FRIGHT              = 23275,
    NELSON_SPELL_CRIPPLING_CLIP               = 23279,
    NELSON_SPELL_CREEPING_DOOM                = 23589
};

enum NPCFranklin
{
    FRANKLIN_EVENT_DEMONIC_ENRAGE               = 6,

    FRANKLIN_GOSSIP_TEXT                        = 7043,  // npc_text.ID                "Lava? Pay no mind to all of that, frien..."
    FRANKLIN_GOSSIP_OPTION_TEXT                 = 14529, // creature_text.CreatureID   "So you are Klinfran the Crazed? Sad, I ..."
    FRANKLIN_SAY                                = 9772,  // broadcast_text.ID          "I shall enjoy this, $c."
    FRANKLIN_ENRAGE_EMOTE                       = 9764,  // broadcast_text.ID          "%s goes into a killing frenzy!"
    FRANKLIN_DESPAWN_SAY                        = 9815,  // breadcast_text.ID          "Only a fool would remain in this battle..."

    FRANKLIN_NORMAL_ENTRY                       = 14529,
    FRANKLIN_EVIL_ENTRY                         = 14534,

    FRANKLIN_HEAD                               = 18953, // item_template.entry

    FRANKLIN_WEAKNESS_SCORPID_STING             = 3043,

    FRANKLIN_SPELL_DEMONIC_ENRAGE               = 23257,
    FRANKLIN_SPELL_ENTROPIC_STING               = 23260
};

struct NPCStaveQuestAI : public ScriptedAI
{
    NPCStaveQuestAI(Creature *creature) : ScriptedAI(creature) { }

    ObjectGuid gossipPlayerGUID;
    ObjectGuid playerGUID;
    bool encounterStarted;
    ThreatContainer::StorageType const& threatList = me->getThreatManager().getThreatList();

    std::map<int, int> entryKeys = {
        { ARTORIUS_NORMAL_ENTRY, 1 },
        { ARTORIUS_EVIL_ENTRY,   1 },
        { SIMONE_NORMAL_ENTRY,   2 },
        { SIMONE_EVIL_ENTRY,     2 },
        { PRECIOUS_NORMAL_ENTRY, 3 },
        { PRECIOUS_EVIL_ENTRY,   3 },
        { NELSON_NORMAL_ENTRY,   4 },
        { NELSON_EVIL_ENTRY,     4 },
        { FRANKLIN_NORMAL_ENTRY, 5 },
        { FRANKLIN_EVIL_ENTRY,   5 }
    };
    std::map<int, std::map<std::string, int>> entryList = {
        {
            1, {
                {"normal", ARTORIUS_NORMAL_ENTRY},
                {"evil", ARTORIUS_EVIL_ENTRY}
            }
        },
        {
            2, {
                {"normal", SIMONE_NORMAL_ENTRY},
                {"evil", SIMONE_EVIL_ENTRY}
            }
        },
        {
            3, {
                {"normal", PRECIOUS_NORMAL_ENTRY},
                {"evil", PRECIOUS_EVIL_ENTRY}
            }
        },
        {
            4, {
                {"normal", NELSON_NORMAL_ENTRY},
                {"evil", NELSON_EVIL_ENTRY}
            }
        },
        {
            5, {
                {"normal", FRANKLIN_NORMAL_ENTRY},
                {"evil", FRANKLIN_EVIL_ENTRY}
            }
        }
    };
    std::vector<uint64> attackerGuids;

    uint32 GetFormEntry(std::string /*type*/);
    bool InNormalForm();
    void RevealForm();
    void StorePlayerGUID();
    Player* GetGossipPlayer();
    bool IsAllowedEntry(uint32 /*entry*/);
    bool UnitIsUnfair(Unit* unit);
    bool IsFairFight();
    bool ValidThreatlist();
    void SetHomePosition();
    void PrepareForEncounter();
    void ClearLootIfUnfair(Unit* killer);
    bool PlayerEligibleForReward(Unit* killer);
    void StoreAttackerGuidValue(Unit* attacker);
};

#endif
