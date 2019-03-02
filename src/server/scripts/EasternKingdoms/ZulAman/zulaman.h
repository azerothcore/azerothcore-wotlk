/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DEF_ZULAMAN_H
#define DEF_ZULAMAN_H

enum DataTypes
{
    DATA_GONGEVENT                      = 0,
    DATA_NALORAKKEVENT                  = 1,
    DATA_AKILZONEVENT                   = 2,
    DATA_JANALAIEVENT                   = 3,
    DATA_HALAZZIEVENT                   = 4,
    DATA_HEXLORDEVENT                   = 5,
    DATA_ZULJINEVENT                    = 6,
    DATA_CHESTLOOTED                    = 7,
    TYPE_RAND_VENDOR_1                  = 8,
    TYPE_RAND_VENDOR_2                  = 9
};

enum CreatureIds
{
    NPC_HARRISON_JONES                  = 24358,
    NPC_JANALAI                         = 23578,
    NPC_ZULJIN                          = 23863,
    NPC_HEXLORD                         = 24239,
    NPC_HALAZZI                         = 23577,
    NPC_NALORAKK                        = 23576
};

enum GameobjectIds
{
    GO_DOOR_HALAZZI                     = 186303,
    GO_GATE_ZULJIN                      = 186304,
    GO_GATE_HEXLORD                     = 186305,
    GO_MASSIVE_GATE                     = 186728,
    GO_DOOR_AKILZON                     = 186858,
    GO_DOOR_ZULJIN                      = 186859,
    GO_HARKORS_SATCHEL                  = 187021,
    GO_TANZARS_TRUNK                    = 186648,
    GO_ASHLIS_BAG                       = 186672,
    GO_KRAZS_PACKAGE                    = 186667,
    GO_STRANGE_GONG                     = 187359
};

#endif
