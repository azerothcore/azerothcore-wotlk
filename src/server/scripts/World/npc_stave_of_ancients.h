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

#ifndef NPC_STAVE_OF_ANCIENTS_H
#define NPC_STAVE_OF_ANCIENTS_H

#include "ScriptedCreature.h"

enum Common
{
    // Gossip
    GOSSIP_EVENT_START_OPTION_ID              = 0,

    // Events
    EVENT_ENCOUNTER_START                     = 1,
    EVENT_REVEAL                              = 2,
    EVENT_FOOLS_PLIGHT                        = 3,
    EVENT_RANGE_CHECK                         = 4,
    EVENT_UNFAIR_FIGHT                        = 5,

    QUEST_STAVE_OF_THE_ANCIENTS               = 7636,

    // Spells
    // Player
    SPELL_FEIGN_DEATH                         = 5384,
    // NPC
    SPELL_DEMONIC_ENRAGE                      = 23257,
    SPELL_FOOLS_PLIGHT                        = 23504,
};

enum NPCArtorius
{
    ARTORIUS_EVENT_DEMONIC_DOOM               = 6,
    ARTORIUS_EVENT_DEMONIC_ENRAGE             = 7,

    ARTORIUS_WEAKNESS_EMOTE                   = 9786,   // broadcast_text.ID         "%s is stricken by a virulent poison."
    ARTORIUS_SAY                              = 9787,   // broadcast_text.ID         "Your soul is mine, weakling."

    ARTORIUS_NORMAL_ENTRY                     = 14531,  // creature_template.entry
    ARTORIUS_EVIL_ENTRY                       = 14535,  // creature_template.entry

    ARTORIUS_HEAD                             = 18955,  // item_template.entry

    ARTORIUS_SPELL_DEMONIC_DOOM               = 23298,
    ARTORIUS_SPELL_STINGING_TRAUMA            = 23299
};

enum NPCSimone
{
    SIMONE_EVENT_TALK                         = 6,
    SIMONE_EVENT_CHECK_PET_STATE              = 7,
    SIMONE_EVENT_CHAIN_LIGHTNING              = 8,
    SIMONE_EVENT_TEMPTRESS_KISS               = 9,

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
    SIMONE_SPELL_SILENCE                      = 23207
};

enum NPCPrecious
{
    PRECIOUS_NORMAL_ENTRY                     = 14528,
    PRECIOUS_EVIL_ENTRY                       = 14538
};

enum NPCNelson
{
    NELSON_EVENT_DREADFUL_FRIGHT              = 6,
    NELSON_EVENT_CREEPING_DOOM                = 7,

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

    FRANKLIN_SAY                                = 9772,  // broadcast_text.ID          "I shall enjoy this, $c."
    FRANKLIN_ENRAGE_EMOTE                       = 9764,  // broadcast_text.ID          "%s goes into a killing frenzy!"
    FRANKLIN_DESPAWN_SAY                        = 9815,  // breadcast_text.ID          "Only a fool would remain in this battle..."

    FRANKLIN_NORMAL_ENTRY                       = 14529,
    FRANKLIN_EVIL_ENTRY                         = 14534,

    FRANKLIN_HEAD                               = 18953, // item_template.entry

    FRANKLIN_WEAKNESS_SCORPID_STING             = 3043,

    FRANKLIN_SPELL_ENTROPIC_STING               = 23260
};

struct NPCStaveQuestAI : public ScriptedAI
{
    NPCStaveQuestAI(Creature *creature) : ScriptedAI(creature) { }

    ObjectGuid gossipPlayerGUID;
    ObjectGuid playerGUID;
    bool encounterStarted;
    ThreatContainer::StorageType const& threatList = me->GetThreatMgr().GetThreatList();

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
    bool QuestIncomplete(Unit* unit, uint32 questItem);
    void ResetState(uint32 /*aura*/);
    void EvadeOnFeignDeath();

    virtual void AttackStart(Unit* /*target*/);
    virtual void AttackedBy(Unit* /*attacker*/);
    virtual void JustDied(Unit* /*killer*/);
};

#endif
