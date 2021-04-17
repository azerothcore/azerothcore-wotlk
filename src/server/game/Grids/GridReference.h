/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _GRIDREFERENCE_H
#define _GRIDREFERENCE_H

#include "LinkedReference/Reference.h"

template<class OBJECT>
class GridRefManager;

template<class OBJECT>
class GridReference : public Reference<GridRefManager<OBJECT>, OBJECT>
{
protected:
    void targetObjectBuildLink() override
    {
        // called from link()
        this->getTarget()->insertFirst(this);
        this->getTarget()->incSize();
    }
    void targetObjectDestroyLink() override
    {
        // called from unlink()
        if (this->isValid()) this->getTarget()->decSize();
    }
    void sourceObjectDestroyLink() override
    {
        // called from invalidate()
        this->getTarget()->decSize();
    }
public:
    GridReference() : Reference<GridRefManager<OBJECT>, OBJECT>() {}
    ~GridReference() override { this->unlink(); }
    GridReference* next() { return (GridReference*)Reference<GridRefManager<OBJECT>, OBJECT>::next(); }
};
#endif
