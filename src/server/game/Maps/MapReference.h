/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _MAPREFERENCE_H
#define _MAPREFERENCE_H

#include "Reference.h"
#include "Map.h"

class MapReference : public Reference<Map, Player>
{
    protected:
        void targetObjectBuildLink()
        {
            // called from link()
            getTarget()->m_mapRefManager.insertFirst(this);
            getTarget()->m_mapRefManager.incSize();
        }
        void targetObjectDestroyLink()
        {
            // called from unlink()
            if (isValid()) getTarget()->m_mapRefManager.decSize();
        }
        void sourceObjectDestroyLink()
        {
            // called from invalidate()
            getTarget()->m_mapRefManager.decSize();
        }
    public:
        MapReference() : Reference<Map, Player>() {}
        ~MapReference() { unlink(); }
        MapReference* next() { return (MapReference*)Reference<Map, Player>::next(); }
        MapReference const* next() const { return (MapReference const*)Reference<Map, Player>::next(); }
        MapReference* nockeck_prev() { return (MapReference*)Reference<Map, Player>::nocheck_prev(); }
        MapReference const* nocheck_prev() const { return (MapReference const*)Reference<Map, Player>::nocheck_prev(); }
};
#endif

