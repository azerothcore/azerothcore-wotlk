/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ObjectDataHandler.h"
#include "Chunk.h"
#include "ADT.h"
#include "ChunkedData.h"

void ObjectDataHandler::ProcessMapChunk( MapChunk* chunk )
{
    ProcessInternal(chunk);
}
