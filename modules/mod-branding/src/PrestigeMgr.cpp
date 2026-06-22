#include "PrestigeMgr.h"
#include "ProficiencyMgr.h"
#include "Configuration/Config.h"
#include "DBCStores.h"
#include "Log.h"
#include "Player.h"
#include "StringFormat.h"
#include <array>

namespace Branding
{
    namespace
    {
        // Stable per-school suffix for the Branding.Prestige.TitleId.<School> config keys. Order
        // mirrors BrandId (Brand.h); every id < BrandId::COUNT must have an entry here.
        constexpr std::array<char const*, static_cast<size_t>(BrandId::COUNT)> SCHOOL_KEY{
            "Fire", "Frost", "Nature", "Shadow", "Arcane", "Holy", "Physical",
            "Wind", "Lightning", "Blood", "Void", "Stone", "Venom", "Chrono", "Spirit"
        };

        // Placeholder spare 3.3.5a CharTitlesEntry ids (see conf .dist). Sequential block chosen from
        // the high end of the shipped id range; documented as placeholders pending a custom DBC patch.
        constexpr uint32_t DEFAULT_TITLE_BASE = 150;
        constexpr uint32_t DEFAULT_CAPSTONE_TITLE = 177;
    }

    void PrestigeConfig::Load()
    {
        _enabled = sConfigMgr->GetOption<bool>("Branding.Prestige.Enable", false);

        for (size_t i = 0; i < SCHOOL_KEY.size(); ++i)
        {
            std::string const key = Acore::StringFormat("Branding.Prestige.TitleId.{}", SCHOOL_KEY[i]);
            _titleId[i] = sConfigMgr->GetOption<uint32_t>(key, DEFAULT_TITLE_BASE + static_cast<uint32_t>(i));
        }

        _capstoneTitleId = sConfigMgr->GetOption<uint32_t>("Branding.Prestige.CapstoneTitleId", DEFAULT_CAPSTONE_TITLE);
    }

    PrestigeMgr* PrestigeMgr::instance()
    {
        static PrestigeMgr instance;
        return &instance;
    }

    void PrestigeMgr::LoadConfig()
    {
        _config.Load();
    }

    void PrestigeMgr::CheckAndGrant(Player* player)
    {
        if (!player || !_config.Enabled())
            return;

        ObjectGuid const guid = player->GetGUID();
        uint8_t const maxLevel = sProficiencyMgr->Config().MaxLevel();
        bool allMaxed = true;

        for (size_t i = 0; i < static_cast<size_t>(BrandId::COUNT); ++i)
        {
            BrandId const brand = static_cast<BrandId>(i);
            bool const maxed = sProficiencyMgr->BrandLevel(guid, brand) >= maxLevel;
            if (!maxed)
            {
                allMaxed = false;
                continue;
            }

            uint32_t const titleId = _config.TitleId(brand);
            if (!titleId)
                continue;

            CharTitlesEntry const* title = sCharTitlesStore.LookupEntry(titleId);
            if (!title)
            {
                LOG_WARN("module.branding", "Prestige: configured title id {} for school {} is not a valid CharTitlesEntry; skipping.",
                    titleId, SCHOOL_KEY[i]);
                continue;
            }

            if (player->HasTitle(title))
                continue;

            // Cosmetic only: SetTitle is itself idempotent (no-op if already known).
            player->SetTitle(title, false);
            LOG_INFO("module.branding", "Prestige: granted graduation title {} ({}-Branded) to {}.",
                titleId, SCHOOL_KEY[i], guid.ToString());
        }

        if (!allMaxed)
            return;

        uint32_t const capstoneId = _config.CapstoneTitleId();
        if (!capstoneId)
            return;

        CharTitlesEntry const* capstone = sCharTitlesStore.LookupEntry(capstoneId);
        if (!capstone)
        {
            LOG_WARN("module.branding", "Prestige: configured capstone title id {} is not a valid CharTitlesEntry; skipping.", capstoneId);
            return;
        }

        if (player->HasTitle(capstone))
            return;

        player->SetTitle(capstone, false);
        LOG_INFO("module.branding", "Prestige: granted capstone title {} to {} (all schools maxed).", capstoneId, guid.ToString());
    }
}
