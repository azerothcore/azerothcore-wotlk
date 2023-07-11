/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "AccountwideManager.h"
#include "Spell.h"

// Add player scripts

class PS_Accountwide : public PlayerScript
{
public:
    Accountwide* aw;

    PS_Accountwide(Accountwide* instance) : PlayerScript("PS_Accountwide")
    {
        aw = instance;
    }

    std::vector<uint32> spells = { 100014, 100012, 100013, 230230, 230231,230232,230233,230234,230235,230236,230237, 230238, 230239, 230240, 63624, 33388, 34091, 54197, 34090, 33391, 230229, 625140, 625141, 625142, 625143, 625144 };
    std::vector<uint32> ignored = { 932, 934, 1104, 1105, 92, 93 };

    void OnLearnSpell(Player* player, uint32 spellID) override
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellID);

        if (std::find(spells.begin(), spells.end(), spellID) != spells.end())
            aw->AddAWMount(player, spellInfo->Id);

        if (spellInfo->Mechanic == MECHANIC_MOUNT || spellInfo->Id == 54197 || (spellInfo->SpellVisual[0] == 353 && spellInfo->Effects[0].Effect == 28))
            aw->AddAWMount(player, spellInfo->Id);

        if (spellInfo->Effects[0].MiscValueB == 41)
            aw->AddAWMount(player, spellInfo->Id);

        if (spellID == 100014) {
            player->SetTaxiCheater(true);
        }
    }

    bool OnReputationChange(Player* player, uint32 factionID, int32& standing, bool incremental) override
    {
        if (std::find(ignored.begin(), ignored.end(), factionID) == ignored.end())
            return true;

        FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionID);

        if (factionEntry)
        {
            aw->m_rep[player->GetSession()->GetAccountId()][player->TeamIdForRace(player->getRace())][factionID] = standing;
            auto trans = CharacterDatabase.BeginTransaction();
            trans->Append("INSERT INTO character_accountwide_reputation(`accountId`,`factionGroup`,`factionId`,`rep`) VALUES({}, {}, {}, {}) ON DUPLICATE KEY UPDATE rep = {}",
                player->GetSession()->GetAccountId(), (uint32)player->TeamIdForRace(player->getRace()), factionID, standing, standing);
            CharacterDatabase.CommitTransaction(trans);
        }

        return true;
    }

    void OnLogin(Player* player) override
    {
        aw->applyAW(player);
    }
};

class AccountWideCache : public DatabaseScript
{
public:


    AccountWideCache(Accountwide* awc) : DatabaseScript("AccountWideCache")
    {
        aw = awc;
    }

    bool IsDatabaseBound() const override
    {
        return true;
    }

    void OnAfterDatabasesLoaded(uint32 updateFlags) override
    {
        aw->Load();
    }

    Accountwide* aw;
};

void AddSC_Accountwide()
{
    Accountwide* aw = new Accountwide();
    new AccountWideCache(aw);
    new PS_Accountwide(aw);
}
