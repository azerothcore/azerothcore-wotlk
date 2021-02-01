/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DEF_RUINS_OF_AHNQIRAJ_H
#define DEF_RUINS_OF_AHNQIRAJ_H

enum DataTypes
{
    DATA_KURINNAXX          = 0,
    DATA_RAJAXX             = 1,
    DATA_MOAM               = 2,
    DATA_BURU               = 3,
    DATA_AYAMISS            = 4,
    DATA_OSSIRIAN           = 5,
    NUM_ENCOUNTER           = 6,

    DATA_PARALYZED          = 7
};

enum Creatures
{
    NPC_KURINAXX                = 15348,
    NPC_RAJAXX                  = 15341,
    NPC_MOAM                    = 15340,
    NPC_BURU                    = 15370,
    NPC_AYAMISS                 = 15369,
    NPC_OSSIRIAN                = 15339,
    NPC_HIVEZARA_HORNET         = 15934,
    NPC_HIVEZARA_SWARMER        = 15546,
    NPC_HIVEZARA_LARVA          = 15555,
    NPC_SAND_VORTEX             = 15428,
    NPC_OSSIRIAN_TRIGGER        = 15590,
    NPC_HATCHLING               = 15521,
    NPC_LARVA                   = 15555,
    NPC_SWARMER                 = 15546,
    NPC_HORNET                  = 15934
};

enum GameObjects
{
    GO_OSSIRIAN_CRYSTAL         = 180619
};

#endif
