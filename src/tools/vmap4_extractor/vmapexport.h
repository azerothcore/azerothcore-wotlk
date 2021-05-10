/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef VMAPEXPORT_H
#define VMAPEXPORT_H

#include "loadlib/loadlib.h"
#include <string>
#include <unordered_map>

namespace VMAP
{
    const char VMAP_MAGIC[] = "VMAP_4.5";
    const char RAW_VMAP_MAGIC[] = "VMAP045";                // used in extracted vmap files with raw data
}

enum ModelFlags
{
    MOD_M2 = 1,
    MOD_WORLDSPAWN = 1 << 1,
    MOD_HAS_BOUND = 1 << 2
};

struct WMODoodadData;

extern const char * szWorkDirWmo;
extern std::unordered_map<std::string, WMODoodadData> WmoDoodads;

uint32 GenerateUniqueObjectId(uint32 clientId, uint16 clientDoodadId);

bool FileExists(const char* file);
void strToLower(char* str);

bool ExtractSingleWmo(std::string& fname);
bool ExtractSingleModel(std::string& fname);

void ExtractGameobjectModels();

#endif
