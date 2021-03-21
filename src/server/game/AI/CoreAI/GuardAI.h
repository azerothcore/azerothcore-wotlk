/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_GUARDAI_H
#define ACORE_GUARDAI_H

#include "ScriptedCreature.h"

class Creature;

class GuardAI : public ScriptedAI
{
public:
    explicit GuardAI(Creature* creature);

    static int Permissible(Creature const* creature);

    void Reset() override;
    void EnterEvadeMode() override;
    void JustDied(Unit* killer) override;
};
#endif
