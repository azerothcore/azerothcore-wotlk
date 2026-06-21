#include "MasteryMgr.h"
#include "mod_branding_loader.h"
#include "branding/mastery/Mastery.h"
#include "Item.h"
#include "Player.h"
#include "Random.h"
#include "ScriptMgr.h"
#include <cmath>

using namespace Branding;

namespace
{
    // Re-entrancy guard: granting bonus items fires OnPlayerCreateItem/OnPlayerLootItem again, which
    // would otherwise recurse. Only the original (player-driven) event should award a mastery bonus.
    bool s_grantingBonus = false;

    // Translate a fractional bonus into a whole-item count: the integer part is guaranteed, the
    // fractional remainder is awarded probabilistically so the long-run average matches the bonus.
    uint32 BonusUnits(uint32 baseCount, double bonus)
    {
        if (baseCount == 0 || bonus <= 0.0)
            return 0;

        double const expected = static_cast<double>(baseCount) * bonus;
        uint32 units = static_cast<uint32>(std::floor(expected));
        double const remainder = expected - static_cast<double>(units);
        if (remainder > 0.0 && roll_chance_f(static_cast<float>(remainder * 100.0)))
            ++units;

        return units;
    }

    void AwardBonus(Player* player, uint32 itemId, uint32 baseCount, MasterySystem system)
    {
        if (s_grantingBonus || !player || !sMasteryMgr->Enabled() || itemId == 0)
            return;

        double const bonus = sMasteryMgr->Bonus(player->GetGUID(), player->GetSession()->GetAccountId(), system);
        uint32 const extra = BonusUnits(baseCount, bonus);
        if (extra == 0)
            return;

        s_grantingBonus = true;
        player->AddItem(itemId, extra);
        s_grantingBonus = false;
    }
}

// Loads/refreshes mastery config on startup and on `.reload config`.
class BrandingMasteryWorldScript : public WorldScript
{
public:
    BrandingMasteryWorldScript() : WorldScript("BrandingMasteryWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sMasteryMgr->LoadConfig();
    }
};

// Player lifecycle + the observable §14 consumers: a small crafting/gathering efficiency bonus that
// is only granted when BOTH dual keys are present (account unlock x earned character skill).
class BrandingMasteryPlayerScript : public PlayerScript
{
public:
    BrandingMasteryPlayerScript() : PlayerScript("BrandingMasteryPlayerScript") { }

    void OnPlayerLogin(Player* player) override
    {
        sMasteryMgr->LoadPlayer(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        sMasteryMgr->SavePlayer(player);
        sMasteryMgr->UnloadPlayer(player->GetGUID());
    }

    // Profession crafting -> Crafting mastery efficiency bonus (extra units of the crafted item).
    void OnPlayerCreateItem(Player* player, Item* item, uint32 count) override
    {
        if (item)
            AwardBonus(player, item->GetEntry(), count, MasterySystem::Crafting);
    }

    // Looting (gathering nodes, etc.) -> Gathering mastery efficiency bonus.
    void OnPlayerLootItem(Player* player, Item* item, uint32 count, ObjectGuid /*lootguid*/) override
    {
        if (item)
            AwardBonus(player, item->GetEntry(), count, MasterySystem::Gathering);
    }
};

void AddBrandingMasteryScripts()
{
    new BrandingMasteryWorldScript();
    new BrandingMasteryPlayerScript();
}
