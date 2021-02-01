/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */
#ifndef ACORE_CREATUREAIFACTORY_H
#define ACORE_CREATUREAIFACTORY_H

#include "ObjectRegistry.h"
#include "FactoryHolder.h"
#include "GameObjectAI.h"

struct SelectableAI : public FactoryHolder<CreatureAI>, public Permissible<Creature>
{
    SelectableAI(const char* id) : FactoryHolder<CreatureAI>(id) {}
};

template<class REAL_AI>
struct CreatureAIFactory : public SelectableAI
{
    CreatureAIFactory(const char* name) : SelectableAI(name) {}

    CreatureAI* Create(void*) const;

    int Permit(const Creature* c) const { return REAL_AI::Permissible(c); }
};

template<class REAL_AI>
inline CreatureAI*
CreatureAIFactory<REAL_AI>::Create(void* data) const
{
    Creature* creature = reinterpret_cast<Creature*>(data);
    return (new REAL_AI(creature));
}

typedef FactoryHolder<CreatureAI> CreatureAICreator;
typedef FactoryHolder<CreatureAI>::FactoryHolderRegistry CreatureAIRegistry;

//GO
struct SelectableGameObjectAI : public FactoryHolder<GameObjectAI>, public Permissible<GameObject>
{
    SelectableGameObjectAI(const char* id) : FactoryHolder<GameObjectAI>(id) {}
};

template<class REAL_GO_AI>
struct GameObjectAIFactory : public SelectableGameObjectAI
{
    GameObjectAIFactory(const char* name) : SelectableGameObjectAI(name) {}

    GameObjectAI* Create(void*) const;

    int Permit(const GameObject* g) const { return REAL_GO_AI::Permissible(g); }
};

template<class REAL_GO_AI>
inline GameObjectAI*
GameObjectAIFactory<REAL_GO_AI>::Create(void* data) const
{
    GameObject* go = reinterpret_cast<GameObject*>(data);
    return (new REAL_GO_AI(go));
}

typedef FactoryHolder<GameObjectAI> GameObjectAICreator;
typedef FactoryHolder<GameObjectAI>::FactoryHolderRegistry GameObjectAIRegistry;

#endif
