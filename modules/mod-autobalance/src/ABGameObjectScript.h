/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_GAME_OBJECT_SCRIPT_H
#define __AB_GAME_OBJECT_SCRIPT_H

#include "ScriptMgr.h"
#include "SpellInfo.h"
#include "Unit.h"

class AutoBalance_GameObjectScript : public AllGameObjectScript
{
public:
    AutoBalance_GameObjectScript()
        : AllGameObjectScript("AutoBalance_GameObjectScript")
    {}

    void OnGameObjectModifyHealth(GameObject* target, Unit* source, int32& amount, SpellInfo const* spellInfo) override;

private:

    [[maybe_unused]] bool _debug_damage_and_healing = false; // defaults to false, overwritten in each function

    void  _Debug_Output(std::string function_name, GameObject* target, Unit* source, int32 amount, std::string prefix = "", std::string spell_name = "Unknown Spell", uint32 spell_id = 0);
    int32 _Modify_GameObject_Damage_Healing(GameObject* target, Unit* source, int32 amount, SpellInfo const* spellInfo);
    int32 _Calculate_Amount_For_GameObject(GameObject* target, int32 amount, float multiplier);
};

#endif
