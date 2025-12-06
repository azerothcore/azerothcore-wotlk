/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_PLAYER_SCRIPT_H
#define __AB_PLAYER_SCRIPT_H

#include "Player.h"
#include "ScriptMgr.h"
#include "Unit.h"

class AutoBalance_PlayerScript : public PlayerScript
{
public:
    AutoBalance_PlayerScript()
        : PlayerScript("AutoBalance_PlayerScript")
    {
    }

    void         OnPlayerLogin(Player* Player) override;
    virtual void OnPlayerLevelChanged(Player* player, uint8 oldlevel) override;
    void         OnPlayerGiveXP(Player* player, uint32& amount, Unit* victim, uint8 xpSource) override;
    void         OnPlayerBeforeLootMoney(Player* player, Loot* loot) override;
    virtual void OnPlayerEnterCombat(Player* player, Unit* enemy) override;
    virtual void OnPlayerLeaveCombat(Player* player) override;
};

#endif /* __AB_PLAYER_SCRIPT_H */
