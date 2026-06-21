#include "AllegianceMgr.h"
#include "DatabaseEnv.h"
#include "Player.h"

namespace Branding
{
    AllegianceMgr* AllegianceMgr::instance()
    {
        static AllegianceMgr mgr;
        return &mgr;
    }

    void AllegianceMgr::LoadConfig()
    {
        _config.Load();
    }

    void AllegianceMgr::LoadPlayer(Player* player)
    {
        // NOTE: blocking read on the login path, matching ProficiencyMgr -- a single primary-key
        // lookup. TODO: move to the async query path per project convention under a full build.
        if (!_config.Enabled() || !player)
            return;

        ObjectGuid const guid = player->GetGUID();
        _charAllegiance[guid] = Allegiance::None;

        QueryResult result = CharacterDatabase.Query(
            "SELECT `allegiance` FROM `character_allegiance` WHERE `guid` = {}", guid.GetCounter());
        if (!result)
            return;

        uint8 const value = result->Fetch()[0].Get<uint8>();
        Allegiance parsed = Allegiance::None;
        if (ParseAllegiance(value, parsed))
            _charAllegiance[guid] = parsed;
    }

    void AllegianceMgr::UnloadPlayer(ObjectGuid guid)
    {
        _charAllegiance.erase(guid);
    }

    Allegiance AllegianceMgr::Current(ObjectGuid guid) const
    {
        auto it = _charAllegiance.find(guid);
        return it != _charAllegiance.end() ? it->second : Allegiance::None;
    }

    bool AllegianceMgr::Select(ObjectGuid guid, uint32_t lowGuid, uint32_t id)
    {
        Allegiance parsed = Allegiance::None;
        if (!ParseAllegiance(id, parsed))
            return false;

        _charAllegiance[guid] = parsed;
        CharacterDatabase.Execute(
            "REPLACE INTO `character_allegiance` (`guid`, `allegiance`) VALUES ({}, {})",
            lowGuid, static_cast<uint32>(id));
        return true;
    }

    double AllegianceMgr::Efficiency(ObjectGuid guid, Allegiance contentAlignment) const
    {
        if (!_config.Enabled())
            return 1.0;

        return AllegianceEfficiency(Current(guid), contentAlignment, _config);
    }
}
