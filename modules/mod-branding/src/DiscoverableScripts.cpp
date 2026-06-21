#include "DiscoverableMgr.h"
#include "RewardDelivery.h"
#include "mod_branding_loader.h"
#include "economy/Discoverable.h"
#include "DBCStores.h"
#include "GameObject.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include <algorithm>

using namespace Branding;

namespace
{
    // Apply a resolved §8.4 reward to the player. Item/recipe grants reuse RewardDelivery (inventory
    // with mail fallback); profession XP, reputation, and hidden quests route to the host directly.
    void GrantReward(Player* player, ResolvedReward const& reward)
    {
        switch (reward.type)
        {
            case DiscoveryRewardType::Recipe:
                // Recipe rewards are taught by an item (the recipe/pattern); deliver it.
                DeliverItem(player, reward.payloadId, reward.amount, "Branding Discovery",
                    "You uncovered a profession discovery.");
                break;

            case DiscoveryRewardType::ProfessionXp:
                // payloadId = skill line, amount = skill points to advance (clamped to the max).
                if (uint16 const cur = player->GetPureSkillValue(static_cast<uint16>(reward.payloadId)))
                {
                    uint16 const max = player->GetPureMaxSkillValue(static_cast<uint16>(reward.payloadId));
                    uint16 const next = static_cast<uint16>(std::min<uint32>(cur + reward.amount, max));
                    player->SetSkill(static_cast<uint16>(reward.payloadId), 0, next, max);
                }
                break;

            case DiscoveryRewardType::Reputation:
                // payloadId = faction, amount = standing gained.
                if (FactionEntry const* faction = sFactionStore.LookupEntry(reward.payloadId))
                    player->GetReputationMgr().ModifyReputation(faction, static_cast<float>(reward.amount));
                break;

            case DiscoveryRewardType::HiddenQuest:
                // payloadId = quest id; start the hidden chain if the player can take it.
                if (Quest const* quest = sObjectMgr->GetQuestTemplate(reward.payloadId))
                {
                    if (player->CanTakeQuest(quest, false) && player->CanAddQuest(quest, false))
                        player->AddQuest(quest, nullptr);
                }
                break;

            default:
                break;
        }
    }
}

// Loads/refreshes the discovery-object mapping on startup and on `.reload config`.
class BrandingDiscoverableWorldScript : public WorldScript
{
public:
    BrandingDiscoverableWorldScript() : WorldScript("BrandingDiscoverableWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sDiscoverableMgr->LoadConfig();
        sDiscoverableMgr->LoadDiscoverables();
    }
};

// Per-character dedupe set lifecycle.
class BrandingDiscoverablePlayerScript : public PlayerScript
{
public:
    BrandingDiscoverablePlayerScript() : PlayerScript("BrandingDiscoverablePlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sDiscoverableMgr->LoadPlayer(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        if (player)
            sDiscoverableMgr->UnloadPlayer(player->GetGUID());
    }
};

// §8.4 interact hook: a placed discoverable gameobject grants its tier-appropriate reward once.
// Re-interact yields nothing (dedupe in DiscoverableMgr + the pure core). Returning true on a grant
// suppresses default gameobject use; unmapped objects fall through to default handling.
class BrandingDiscoverableObjectScript : public GameObjectScript
{
public:
    BrandingDiscoverableObjectScript() : GameObjectScript("BrandingDiscoverableObjectScript") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (!player || !go || !sDiscoverableMgr->Enabled())
            return false;

        ResolvedReward reward = sDiscoverableMgr->OnInteract(player, go->GetEntry());
        if (!reward.granted)
            return false;       // already discovered / unmapped -> default behaviour

        GrantReward(player, reward);
        return true;
    }
};

void AddBrandingDiscoverableScripts()
{
    new BrandingDiscoverableWorldScript();
    new BrandingDiscoverablePlayerScript();
    new BrandingDiscoverableObjectScript();
}
