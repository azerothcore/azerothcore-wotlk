/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef DEF_SETHEKK_HALLS_H
#define DEF_SETHEKK_HALLS_H

#include "CreatureAIImpl.h"

#define SethekkHallsScriptName "instance_sethekk_halls"

enum eTypes
{
    DATA_IKISSDOOREVENT = 1,
    TYPE_ANZU_ENCOUNTER = 2,
};

enum eIds
{
    NPC_VOICE_OF_THE_RAVEN_GOD  = 21851,
    NPC_ANZU                    = 23035,

    GO_IKISS_DOOR               = 177203,
    GO_THE_TALON_KINGS_COFFER   = 187372
};

template <class AI, class T>
inline AI* GetSethekkHallsAI(T* obj)
{
    return GetInstanceAI<AI>(obj, SethekkHallsScriptName);
}

#endif
