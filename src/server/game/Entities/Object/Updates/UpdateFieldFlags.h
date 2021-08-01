/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _UPDATEFIELDFLAGS_H
#define _UPDATEFIELDFLAGS_H

#include "Define.h"
#include "UpdateFields.h"

enum UpdatefieldFlags
{
    UF_FLAG_NONE         = 0x000,
    UF_FLAG_PUBLIC       = 0x001,
    UF_FLAG_PRIVATE      = 0x002,
    UF_FLAG_OWNER        = 0x004,
    UF_FLAG_UNUSED1      = 0x008,
    UF_FLAG_ITEM_OWNER   = 0x010,
    UF_FLAG_SPECIAL_INFO = 0x020,
    UF_FLAG_PARTY_MEMBER = 0x040,
    UF_FLAG_UNUSED2      = 0x080,
    UF_FLAG_DYNAMIC      = 0x100,
};

extern uint32 ItemUpdateFieldFlags[CONTAINER_END];
extern uint32 UnitUpdateFieldFlags[PLAYER_END];
extern uint32 GameObjectUpdateFieldFlags[GAMEOBJECT_END];
extern uint32 DynamicObjectUpdateFieldFlags[DYNAMICOBJECT_END];
extern uint32 CorpseUpdateFieldFlags[CORPSE_END];

#endif // _UPDATEFIELDFLAGS_H
