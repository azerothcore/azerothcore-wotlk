#include "branding/effects/RolePolicy.h"

namespace Branding
{
    namespace
    {
        // WoW 3.3.5 class ids.
        constexpr uint8_t CLASS_WARRIOR = 1, CLASS_PALADIN = 2, CLASS_HUNTER = 3, CLASS_ROGUE = 4,
                          CLASS_PRIEST = 5, CLASS_DEATH_KNIGHT = 6, CLASS_SHAMAN = 7, CLASS_MAGE = 8,
                          CLASS_WARLOCK = 9, CLASS_DRUID = 11;

        // ShapeshiftForm values (UnitDefines.h).
        constexpr uint8_t FORM_CAT = 0x01, FORM_BEAR = 0x05, FORM_DIREBEAR = 0x08;

        constexpr uint8_t Bit(RoleContribution role)
        {
            return static_cast<uint8_t>(1u << static_cast<uint8_t>(role));
        }

        bool HasBit(uint8_t mask, RoleContribution role)
        {
            return (mask & Bit(role)) != 0u;
        }

        // Clamp to a legal role: keep `role` if the class allows it, else fall back to Damage (always
        // legal). Damage is guaranteed present in every capability mask.
        RoleContribution Clamp(RoleContribution role, uint8_t capabilityMask)
        {
            return HasBit(capabilityMask, role) ? role : RoleContribution::Damage;
        }

        bool IsBearForm(uint8_t form)
        {
            return form == FORM_BEAR || form == FORM_DIREBEAR;
        }
    }

    uint8_t RoleCapabilityMask(uint8_t classId)
    {
        uint8_t const dps = Bit(RoleContribution::Damage);
        uint8_t const tank = Bit(RoleContribution::Tank);
        uint8_t const heal = Bit(RoleContribution::Healer);

        switch (classId)
        {
            case CLASS_WARRIOR:
            case CLASS_DEATH_KNIGHT:
                return dps | tank;
            case CLASS_PRIEST:
            case CLASS_SHAMAN:
                return dps | heal;
            case CLASS_PALADIN:
            case CLASS_DRUID:
                return dps | tank | heal;
            case CLASS_HUNTER:
            case CLASS_ROGUE:
            case CLASS_MAGE:
            case CLASS_WARLOCK:
            default:
                return dps;   // pure dps / unknown: Damage only
        }
    }

    bool RoleAllowed(uint8_t classId, RoleContribution role)
    {
        return HasBit(RoleCapabilityMask(classId), role);
    }

    RoleContribution ClassDefaultRolePolicy::DefaultRole(RoleSignals const& /*signals*/, uint8_t capabilityMask) const
    {
        // Damage is legal for every class; clamp is defensive (a no-op in practice).
        return Clamp(RoleContribution::Damage, capabilityMask);
    }

    RoleContribution TalentInferredRolePolicy::DefaultRole(RoleSignals const& signals, uint8_t capabilityMask) const
    {
        RoleContribution role = RoleContribution::Damage;
        uint8_t const tab = signals.dominantTab;

        switch (signals.classId)
        {
            case CLASS_WARRIOR:                                  // 0 Arms · 1 Fury · 2 Prot
                role = tab == 2 ? RoleContribution::Tank : RoleContribution::Damage;
                break;
            case CLASS_PALADIN:                                  // 0 Holy · 1 Prot · 2 Ret
                role = tab == 0 ? RoleContribution::Healer
                     : tab == 1 ? RoleContribution::Tank
                                : RoleContribution::Damage;
                break;
            case CLASS_PRIEST:                                   // 0 Disc · 1 Holy · 2 Shadow
                role = tab == 2 ? RoleContribution::Damage : RoleContribution::Healer;
                break;
            case CLASS_SHAMAN:                                   // 0 Ele · 1 Enh · 2 Resto
                role = tab == 2 ? RoleContribution::Healer : RoleContribution::Damage;
                break;
            case CLASS_DRUID:                                    // 0 Balance · 1 Feral · 2 Resto
                role = tab == 2 ? RoleContribution::Healer
                     : tab == 1 ? (IsBearForm(signals.shapeshiftForm) ? RoleContribution::Tank : RoleContribution::Damage)
                                : RoleContribution::Damage;
                break;
            case CLASS_DEATH_KNIGHT:                             // tanking is presence-driven, not tree-driven
                role = signals.inFrostPresence ? RoleContribution::Tank : RoleContribution::Damage;
                break;
            default:                                             // pure dps / unknown
                role = RoleContribution::Damage;
                break;
        }

        return Clamp(role, capabilityMask);
    }

    RoleContribution ResolveSelectedRole(RoleContribution chosen, RoleSignals const& signals,
        IDefaultRolePolicy const& policy)
    {
        uint8_t const cap = RoleCapabilityMask(signals.classId);
        if (chosen != RoleContribution::None)
            return Clamp(chosen, cap);

        return policy.DefaultRole(signals, cap);
    }
}
