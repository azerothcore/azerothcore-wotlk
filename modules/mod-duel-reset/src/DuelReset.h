#ifndef _DUELRESET_H_
#define _DUELRESET_H_

#include "Common.h"
#include "Player.h"
#include "Pet.h"
#include "SpellInfo.h"
#include "Config.h"
#include <unordered_map>

class DuelReset
{
public:
    static DuelReset* instance();

    void LoadConfig(bool reload);
    void FillWhitelist(std::string zonesAreas, std::vector<uint32> &whitelist);

    void ResetSpellCooldowns(Player* player, bool onStartDuel);
    void SaveCooldownStateBeforeDuel(Player* player);
    void RestoreCooldownStateAfterDuel(Player* player);

    void SaveHealthBeforeDuel(Player* player);
    void SaveManaBeforeDuel(Player* player);
    void RestoreHealthAfterDuel(Player* player);
    void RestoreManaAfterDuel(Player* player);

    bool IsAllowedInArea(Player* player) const;
    bool GetResetCooldownsEnabled() const;
    bool GetResetHealthEnabled() const;
    uint32 GetCooldownAge() const;
    std::vector<uint32> GetZoneWhitelist() const;
    std::vector<uint32> GetAreaWhitelist() const;
private:
    // Config values
    bool m_enableCooldowns;
    bool m_enableHealth;
    uint32 m_cooldownAge;
    std::vector<uint32> m_zoneWhitelist;
    std::vector<uint32> m_areaWhitelist;

    // Player value maps
    typedef std::unordered_map<Player*, SpellCooldowns> PlayersCooldownMap;
    typedef std::unordered_map<Player*, uint32> PlayersHealthMap;
    typedef std::unordered_map<Player*, uint32> PlayersManaMap;

    PlayersCooldownMap m_spellCooldownsBeforeDuel;
    PlayersHealthMap m_healthBeforeDuel;
    PlayersManaMap m_manaBeforeDuel;
};

#define sDuelReset DuelReset::instance()

#endif
