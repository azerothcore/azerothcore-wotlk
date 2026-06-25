#include "BrandRole.h"
#include "LoadoutMgr.h"
#include "branding/effects/ItemBrand.h"
#include "branding/effects/RolePolicy.h"
#include "Configuration/Config.h"
#include "Player.h"

namespace Branding
{
    namespace
    {
        // DK tank presence (spell_dk.cpp). Active Frost Presence => tank intent in WotLK.
        constexpr uint32_t SPELL_DK_FROST_PRESENCE = 48263;

        ClassDefaultRolePolicy g_classDefault;
        TalentInferredRolePolicy g_talentInferred;
        IDefaultRolePolicy const* g_policy = &g_classDefault;   // prod default

        RoleSignals SampleSignals(Player* player)
        {
            RoleSignals s;
            s.classId = player->getClass();
            s.dominantTab = player->GetMostPointsTalentTree();
            s.shapeshiftForm = static_cast<uint8_t>(player->GetShapeshiftForm());
            s.inFrostPresence = player->HasAura(SPELL_DK_FROST_PRESENCE);
            return s;
        }
    }

    void LoadRolePolicyConfig()
    {
        std::string const mode = sConfigMgr->GetOption<std::string>("Branding.Effect.DefaultRolePolicy", "class");
        g_policy = (mode == "talent")
            ? static_cast<IDefaultRolePolicy const*>(&g_talentInferred)
            : static_cast<IDefaultRolePolicy const*>(&g_classDefault);
    }

    RoleContribution DetectRole(Player* player)
    {
        if (!player)
            return RoleContribution::Damage;

        uint8_t const classId = player->getClass();
        RoleContribution const chosen = sLoadoutMgr->GetLoadout(player->GetGUID()).selectedRole;

        // Fast path: an explicit, class-legal choice resolves with no talent-map sampling.
        if (chosen != RoleContribution::None)
            return RoleAllowed(classId, chosen) ? chosen : RoleContribution::Damage;

        // Unset -> default policy. Only sample the live signals when the active policy reads them.
        RoleSignals signals = g_policy->UsesSignals() ? SampleSignals(player) : RoleSignals{};
        signals.classId = classId;
        return g_policy->DefaultRole(signals, RoleCapabilityMask(classId));
    }
}
