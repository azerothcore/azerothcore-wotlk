/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef ACORE_GRIDNOTIFIERS_H
#define ACORE_GRIDNOTIFIERS_H

#include "Corpse.h"
#include "CreatureAI.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "Group.h"
#include "Object.h"
#include "ObjectGridLoader.h"
#include "Optional.h"
#include "Player.h"
#include "Spell.h"
#include "Unit.h"
#include "UpdateData.h"
#include "WorldSession.h"
#include <iostream>

#include "SpellMgr.h"

class Player;
//class Map;

namespace Acore
{
    struct VisibleNotifier
    {
        Player& i_player;
        GuidUnorderedSet vis_guids;
        std::vector<Unit*>& i_visibleNow;
        bool i_gobjOnly;
        bool i_largeOnly;
        UpdateData i_data;

        VisibleNotifier(Player& player, bool gobjOnly, bool largeOnly) :
            i_player(player), vis_guids(player.m_clientGUIDs), i_visibleNow(player.m_newVisible), i_gobjOnly(gobjOnly), i_largeOnly(largeOnly)
        {
            i_visibleNow.clear();
        }

        void Visit(GameObjectMapType&);
        template<class T> void Visit(GridRefMgr<T>& m);
        void SendToSelf(void);
    };

    struct VisibleChangesNotifier
    {
        WorldObject& i_object;

        explicit VisibleChangesNotifier(WorldObject& object) : i_object(object) {}
        template<class T> void Visit(GridRefMgr<T>&) {}
        void Visit(PlayerMapType&);
        void Visit(CreatureMapType&);
        void Visit(DynamicObjectMapType&);
    };

    struct PlayerRelocationNotifier : public VisibleNotifier
    {
        PlayerRelocationNotifier(Player& player, bool largeOnly): VisibleNotifier(player, false, largeOnly) { }

        template<class T> void Visit(GridRefMgr<T>& m) { VisibleNotifier::Visit(m); }
        void Visit(PlayerMapType&);
    };

    struct CreatureRelocationNotifier
    {
        Creature& i_creature;
        CreatureRelocationNotifier(Creature& c) : i_creature(c) {}
        template<class T> void Visit(GridRefMgr<T>&) {}
        void Visit(PlayerMapType&);
    };

    struct AIRelocationNotifier
    {
        Unit& i_unit;
        bool isCreature;
        explicit AIRelocationNotifier(Unit& unit) : i_unit(unit), isCreature(unit.GetTypeId() == TYPEID_UNIT)  {}
        template<class T> void Visit(GridRefMgr<T>&) {}
        void Visit(CreatureMapType&);
    };

    struct MessageDistDeliverer
    {
        WorldObject const* i_source;
        WorldPacket const* i_message;
        uint32 i_phaseMask;
        float i_distSq;
        TeamId teamId;
        Player const* skipped_receiver;
        bool required3dDist;
        MessageDistDeliverer(WorldObject const* src, WorldPacket const* msg, float dist, bool own_team_only = false, Player const* skipped = nullptr, bool req3dDist = false)
            : i_source(src), i_message(msg), i_phaseMask(src->GetPhaseMask()), i_distSq(dist * dist)
            , teamId((own_team_only && src->IsPlayer()) ? src->ToPlayer()->GetTeamId() : TEAM_NEUTRAL)
            , skipped_receiver(skipped), required3dDist(req3dDist)
        {
        }
        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(DynamicObjectMapType& m);
        template<class SKIP> void Visit(GridRefMgr<SKIP>&) {}

        void SendPacket(Player* player)
        {
            // never send packet to self
            if (player == i_source || (teamId != TEAM_NEUTRAL && player->GetTeamId() != teamId) || skipped_receiver == player)
                return;

            if (!player->HaveAtClient(i_source))
                return;

            player->GetSession()->SendPacket(i_message);
        }
    };

    struct MessageDistDelivererToHostile
    {
        Unit* i_source;
        WorldPacket* i_message;
        uint32 i_phaseMask;
        float i_distSq;
        MessageDistDelivererToHostile(Unit* src, WorldPacket* msg, float dist)
            : i_source(src), i_message(msg), i_phaseMask(src->GetPhaseMask()), i_distSq(dist * dist)
        {
        }
        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(DynamicObjectMapType& m);
        template<class SKIP> void Visit(GridRefMgr<SKIP>&) {}

        void SendPacket(Player* player)
        {
            // never send packet to self
            if (player == i_source || !player->HaveAtClient(i_source) || player->IsFriendlyTo(i_source))
                return;

            player->GetSession()->SendPacket(i_message);
        }
    };

    struct ObjectUpdater
    {
        uint32 i_timeDiff;
        bool i_largeOnly;
        explicit ObjectUpdater(const uint32 diff, bool largeOnly) : i_timeDiff(diff), i_largeOnly(largeOnly) {}
        template<class T> void Visit(GridRefMgr<T>& m);
        void Visit(PlayerMapType&) {}
        void Visit(CorpseMapType&) {}
    };

    // SEARCHERS & LIST SEARCHERS & WORKERS

    // WorldObject searchers & workers

    // Generic base class to insert elements into arbitrary containers using push_back
    template<typename Type>
    class ContainerInserter
    {
        using InserterType = void(*)(void*, Type&&);

        void* ref;
        InserterType inserter;

        // MSVC workaround
        template<typename T>
        static void InserterOf(void* ref, Type&& type)
        {
            static_cast<T*>(ref)->push_back(std::move(type));
        }

    protected:
        template<typename T>
        ContainerInserter(T& ref_) : ref(&ref_), inserter(&InserterOf<T>) { }

        void Insert(Type type)
        {
            inserter(ref, std::move(type));
        }
    };

    template<class Check>
    struct WorldObjectSearcher
    {
        uint32 i_mapTypeMask;
        uint32 i_phaseMask;
        WorldObject*& i_object;
        Check& i_check;

        WorldObjectSearcher(WorldObject const* searcher, WorldObject*& result, Check& check, uint32 mapTypeMask = GRID_MAP_TYPE_MASK_ALL)
            : i_mapTypeMask(mapTypeMask), i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(GameObjectMapType& m);
        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(CorpseMapType& m);
        void Visit(DynamicObjectMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Check>
    struct WorldObjectLastSearcher
    {
        uint32 i_mapTypeMask;
        uint32 i_phaseMask;
        WorldObject*& i_object;
        Check& i_check;

        WorldObjectLastSearcher(WorldObject const* searcher, WorldObject*& result, Check& check, uint32 mapTypeMask = GRID_MAP_TYPE_MASK_ALL)
            :  i_mapTypeMask(mapTypeMask), i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(GameObjectMapType& m);
        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(CorpseMapType& m);
        void Visit(DynamicObjectMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Check>
    struct WorldObjectListSearcher : ContainerInserter<WorldObject*>
    {
        uint32 i_mapTypeMask;
        uint32 i_phaseMask;
        Check& i_check;

        template<typename Container>
        WorldObjectListSearcher(WorldObject const* searcher, Container& container, Check & check, uint32 mapTypeMask = GRID_MAP_TYPE_MASK_ALL)
                : ContainerInserter<WorldObject*>(container),
                  i_mapTypeMask(mapTypeMask), i_phaseMask(searcher->GetPhaseMask()), i_check(check) { }

        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(CorpseMapType& m);
        void Visit(GameObjectMapType& m);
        void Visit(DynamicObjectMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Do>
    struct WorldObjectWorker
    {
        uint32 i_mapTypeMask;
        uint32 i_phaseMask;
        Do const& i_do;

        WorldObjectWorker(WorldObject const* searcher, Do const& _do, uint32 mapTypeMask = GRID_MAP_TYPE_MASK_ALL)
            : i_mapTypeMask(mapTypeMask), i_phaseMask(searcher->GetPhaseMask()), i_do(_do) {}

        void Visit(GameObjectMapType& m)
        {
            if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_GAMEOBJECT))
                return;
            for (GameObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
                if (itr->GetSource()->InSamePhase(i_phaseMask))
                    i_do(itr->GetSource());
        }

        void Visit(PlayerMapType& m)
        {
            if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_PLAYER))
                return;
            for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
                if (itr->GetSource()->InSamePhase(i_phaseMask))
                    i_do(itr->GetSource());
        }
        void Visit(CreatureMapType& m)
        {
            if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CREATURE))
                return;
            for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
                if (itr->GetSource()->InSamePhase(i_phaseMask))
                    i_do(itr->GetSource());
        }

        void Visit(CorpseMapType& m)
        {
            if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CORPSE))
                return;
            for (CorpseMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
                if (itr->GetSource()->InSamePhase(i_phaseMask))
                    i_do(itr->GetSource());
        }

        void Visit(DynamicObjectMapType& m)
        {
            if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_DYNAMICOBJECT))
                return;
            for (DynamicObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
                if (itr->GetSource()->InSamePhase(i_phaseMask))
                    i_do(itr->GetSource());
        }

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    // Gameobject searchers

    template<class Check>
    struct GameObjectSearcher
    {
        uint32 i_phaseMask;
        GameObject*& i_object;
        Check& i_check;

        GameObjectSearcher(WorldObject const* searcher, GameObject*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(GameObjectMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    // Last accepted by Check GO if any (Check can change requirements at each call)
    template<class Check>
    struct GameObjectLastSearcher
    {
        uint32 i_phaseMask;
        GameObject*& i_object;
        Check& i_check;

        GameObjectLastSearcher(WorldObject const* searcher, GameObject*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(GameObjectMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Check>
    struct GameObjectListSearcher : ContainerInserter<GameObject*>
    {
        uint32 i_phaseMask;
        Check& i_check;

        template<typename Container>
        GameObjectListSearcher(WorldObject const* searcher, Container& container, Check & check)
                : ContainerInserter<GameObject*>(container),
                  i_phaseMask(searcher->GetPhaseMask()), i_check(check) { }

        void Visit(GameObjectMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Functor>
    struct GameObjectWorker
    {
        GameObjectWorker(WorldObject const* searcher, Functor& func)
            : _func(func), _phaseMask(searcher->GetPhaseMask()) {}

        void Visit(GameObjectMapType& m)
        {
            for (GameObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
                if (itr->GetSource()->InSamePhase(_phaseMask))
                    _func(itr->GetSource());
        }

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}

    private:
        Functor& _func;
        uint32 _phaseMask;
    };

    // Unit searchers

    // First accepted by Check Unit if any
    template<class Check>
    struct UnitSearcher
    {
        uint32 i_phaseMask;
        Unit*& i_object;
        Check& i_check;

        UnitSearcher(WorldObject const* searcher, Unit*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(CreatureMapType& m);
        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    // Last accepted by Check Unit if any (Check can change requirements at each call)
    template<class Check>
    struct UnitLastSearcher
    {
        uint32 i_phaseMask;
        Unit*& i_object;
        Check& i_check;

        UnitLastSearcher(WorldObject const* searcher, Unit*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(CreatureMapType& m);
        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    // All accepted by Check units if any
    template<class Check>
    struct UnitListSearcher : ContainerInserter<Unit*>
    {
        uint32 i_phaseMask;
        Check& i_check;

        template<typename Container>
        UnitListSearcher(WorldObject const* searcher, Container& container, Check& check)
                : ContainerInserter<Unit*>(container),
                  i_phaseMask(searcher->GetPhaseMask()), i_check(check) { }

        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    // Creature searchers

    template<class Check>
    struct CreatureSearcher
    {
        uint32 i_phaseMask;
        Creature*& i_object;
        Check& i_check;

        CreatureSearcher(WorldObject const* searcher, Creature*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    // Last accepted by Check Creature if any (Check can change requirements at each call)
    template<class Check>
    struct CreatureLastSearcher
    {
        uint32 i_phaseMask;
        Creature*& i_object;
        Check& i_check;

        CreatureLastSearcher(WorldObject const* searcher, Creature*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Check>
    struct CreatureListSearcher : ContainerInserter<Creature*>
    {
        uint32 i_phaseMask;
        Check& i_check;

        template<typename Container>
        CreatureListSearcher(WorldObject const* searcher, Container& container, Check & check)
                : ContainerInserter<Creature*>(container),
                  i_phaseMask(searcher->GetPhaseMask()), i_check(check) { }

        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Do>
    struct CreatureWorker
    {
        uint32 i_phaseMask;
        Do& i_do;

        CreatureWorker(WorldObject const* searcher, Do& _do)
            : i_phaseMask(searcher->GetPhaseMask()), i_do(_do) {}

        void Visit(CreatureMapType& m)
        {
            for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
                if (itr->GetSource()->InSamePhase(i_phaseMask))
                    i_do(itr->GetSource());
        }

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    // Player searchers

    template<class Check>
    struct PlayerSearcher
    {
        uint32 i_phaseMask;
        Player*& i_object;
        Check& i_check;

        PlayerSearcher(WorldObject const* searcher, Player*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Check>
    struct PlayerListSearcher : ContainerInserter<Player*>
    {
        uint32 i_phaseMask;
        Check& i_check;

        template<typename Container>
        PlayerListSearcher(WorldObject const* searcher, Container& container, Check & check)
                : ContainerInserter<Player*>(container),
                  i_phaseMask(searcher->GetPhaseMask()), i_check(check) { }

        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Check>
    struct PlayerListSearcherWithSharedVision
    {
        uint32 i_phaseMask;
        std::list<Player*>& i_objects;
        Check& i_check;

        PlayerListSearcherWithSharedVision(WorldObject const* searcher, std::list<Player*>& objects, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()), i_objects(objects), i_check(check) {}

        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Check>
    struct PlayerLastSearcher
    {
        uint32 i_phaseMask;
        Player*& i_object;
        Check& i_check;

        PlayerLastSearcher(WorldObject const* searcher, Player*& result, Check& check) : i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check)
        {
        }

        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Do>
    struct PlayerWorker
    {
        uint32 i_phaseMask;
        Do& i_do;

        PlayerWorker(WorldObject const* searcher, Do& _do)
            : i_phaseMask(searcher->GetPhaseMask()), i_do(_do) {}

        void Visit(PlayerMapType& m)
        {
            for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
                if (itr->GetSource()->InSamePhase(i_phaseMask))
                    i_do(itr->GetSource());
        }

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    template<class Do>
    struct PlayerDistWorker
    {
        WorldObject const* i_searcher;
        float i_dist;
        Do& i_do;

        PlayerDistWorker(WorldObject const* searcher, float _dist, Do& _do)
            : i_searcher(searcher), i_dist(_dist), i_do(_do) {}

        void Visit(PlayerMapType& m)
        {
            for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
                if (itr->GetSource()->HaveAtClient(i_searcher) && itr->GetSource()->IsWithinDist(i_searcher, i_dist))
                    i_do(itr->GetSource());
        }

        template<class NOT_INTERESTED> void Visit(GridRefMgr<NOT_INTERESTED>&) {}
    };

    // CHECKS && DO classes

    // WorldObject check classes

    class AnyDeadUnitObjectInRangeCheck
    {
    public:
        AnyDeadUnitObjectInRangeCheck(Unit* searchObj, float range) : i_searchObj(searchObj), i_range(range) {}
        bool operator()(Player* u);
        bool operator()(Corpse* u);
        bool operator()(Creature* u);
        template<class NOT_INTERESTED> bool operator()(NOT_INTERESTED*) { return false; }
    protected:
        Unit const* const i_searchObj;
        float i_range;
    };

    class AnyDeadUnitSpellTargetInRangeCheck : public AnyDeadUnitObjectInRangeCheck
    {
    public:
        AnyDeadUnitSpellTargetInRangeCheck(Unit* searchObj, float range, SpellInfo const* spellInfo, SpellTargetCheckTypes check)
            : AnyDeadUnitObjectInRangeCheck(searchObj, range), i_spellInfo(spellInfo), i_check(searchObj, searchObj, spellInfo, check, nullptr)
        {}
        bool operator()(Player* u);
        bool operator()(Corpse* u);
        bool operator()(Creature* u);
        template<class NOT_INTERESTED> bool operator()(NOT_INTERESTED*) { return false; }
    protected:
        SpellInfo const* i_spellInfo;
        WorldObjectSpellTargetCheck i_check;
    };

    // WorldObject do classes

    class RespawnDo
    {
    public:
        RespawnDo() {}
        void operator()(Creature* u) const { u->Respawn(); }
        void operator()(GameObject* u) const { u->Respawn(); }
        void operator()(WorldObject*) const {}
        void operator()(Corpse*) const {}
    };

    // GameObject checks

    class GameObjectFocusCheck
    {
    public:
        GameObjectFocusCheck(Unit const* unit, uint32 focusId) : i_unit(unit), i_focusId(focusId) {}
        bool operator()(GameObject* go) const
        {
            if (go->GetGOInfo()->type != GAMEOBJECT_TYPE_SPELL_FOCUS)
                return false;

            if (!go->isSpawned()) // xinef: dont allow to count deactivated objects
                return false;

            if (go->GetGOInfo()->spellFocus.focusId != i_focusId)
                return false;

            float dist = (float)((go->GetGOInfo()->spellFocus.dist) / 2);

            return go->IsWithinDistInMap(i_unit, dist);
        }
    private:
        Unit const* i_unit;
        uint32 i_focusId;
    };

    // Find the nearest Fishing hole and return true only if source object is in range of hole
    class NearestGameObjectFishingHole
    {
    public:
        NearestGameObjectFishingHole(WorldObject const& obj, float range) : i_obj(obj), i_range(range) {}
        bool operator()(GameObject* go)
        {
            if (go->GetGOInfo()->type == GAMEOBJECT_TYPE_FISHINGHOLE && go->isSpawned() && i_obj.IsWithinDistInMap(go, i_range) && i_obj.IsWithinDistInMap(go, (float)go->GetGOInfo()->fishinghole.radius))
            {
                i_range = i_obj.GetDistance(go);
                return true;
            }
            return false;
        }
    private:
        WorldObject const& i_obj;
        float  i_range;

        // prevent clone
        NearestGameObjectFishingHole(NearestGameObjectFishingHole const&);
    };

    class NearestGameObjectCheck
    {
    public:
        NearestGameObjectCheck(WorldObject const& obj) : i_obj(obj), i_range(999) {}
        bool operator()(GameObject* go)
        {
            if (i_obj.IsWithinDistInMap(go, i_range))
            {
                i_range = i_obj.GetDistance(go);        // use found GO range as new range limit for next check
                return true;
            }
            return false;
        }
    private:
        WorldObject const& i_obj;
        float i_range;

        // prevent clone this object
        NearestGameObjectCheck(NearestGameObjectCheck const&);
    };

    // Success at unit in range, range update for next check (this can be use with GameobjectLastSearcher to find nearest GO)
    class NearestGameObjectEntryInObjectRangeCheck
    {
    public:
        NearestGameObjectEntryInObjectRangeCheck(WorldObject const& obj, uint32 entry, float range, bool onlySpawned = false) :
            i_obj(obj), i_entry(entry), i_range(range), i_onlySpawned(onlySpawned) { }

        bool operator()(GameObject* go)
        {
            if (go->GetEntry() == i_entry && i_obj.IsWithinDistInMap(go, i_range) && (!i_onlySpawned || go->isSpawned()))
            {
                i_range = i_obj.GetDistance(go);        // use found GO range as new range limit for next check
                return true;
            }
            return false;
        }
    private:
        WorldObject const& i_obj;
        uint32 i_entry;
        float  i_range;
        bool   i_onlySpawned;

        // prevent clone this object
        NearestGameObjectEntryInObjectRangeCheck(NearestGameObjectEntryInObjectRangeCheck const&);
    };

    // Success at unit in range, range update for next check (this can be use with GameobjectLastSearcher to find nearest GO with a certain type)
    class NearestGameObjectTypeInObjectRangeCheck
    {
    public:
        NearestGameObjectTypeInObjectRangeCheck(WorldObject const& obj, GameobjectTypes type, float range) : i_obj(obj), i_type(type), i_range(range) {}
        bool operator()(GameObject* go)
        {
            if (go->GetGoType() == i_type && i_obj.IsWithinDistInMap(go, i_range))
            {
                i_range = i_obj.GetDistance(go);        // use found GO range as new range limit for next check
                return true;
            }
            return false;
        }
    private:
        WorldObject const& i_obj;
        GameobjectTypes i_type;
        float  i_range;

        // prevent clone this object
        NearestGameObjectTypeInObjectRangeCheck(NearestGameObjectTypeInObjectRangeCheck const&);
    };

    // Unit checks

    class MostHPMissingInRange
    {
    public:
        MostHPMissingInRange(Unit const* obj, float range, uint32 hp) : i_obj(obj), i_range(range), i_hp(hp) {}
        bool operator()(Unit* u)
        {
            if (u->IsAlive() && u->IsInCombat() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) && u->GetMaxHealth() - u->GetHealth() > i_hp)
            {
                i_hp = u->GetMaxHealth() - u->GetHealth();
                return true;
            }
            return false;
        }
    private:
        Unit const* i_obj;
        float i_range;
        uint32 i_hp;
    };

    class MostHPPercentMissingInRange
    {
    public:
        MostHPPercentMissingInRange(Unit const* obj, float range, uint32 minHpPct, uint32 maxHpPct) :
            i_obj(obj), i_range(range), i_minHpPct(minHpPct), i_maxHpPct(maxHpPct), i_hpPct(101.f) { }

        bool operator()(Unit* u)
        {
            if (u->IsAlive() && u->IsInCombat() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) &&
                i_minHpPct <= u->GetHealthPct() && u->GetHealthPct() <= i_maxHpPct && u->GetHealthPct() < i_hpPct)
            {
                i_hpPct = u->GetHealthPct();
                return true;
            }

            return false;
        }

    private:
        Unit const* i_obj;
        float i_range;
        float i_minHpPct, i_maxHpPct, i_hpPct;
    };

    class FriendlyCCedInRange
    {
    public:
        FriendlyCCedInRange(Unit const* obj, float range) : i_obj(obj), i_range(range) {}
        bool operator()(Unit* u)
        {
            if (u->IsAlive() && u->IsInCombat() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) &&
                    (u->isFeared() || u->IsCharmed() || u->isFrozen() || u->HasUnitState(UNIT_STATE_STUNNED) || u->HasUnitState(UNIT_STATE_CONFUSED)))
            {
                return true;
            }
            return false;
        }
    private:
        Unit const* i_obj;
        float i_range;
    };

    class FriendlyMissingBuffInRange
    {
    public:
        FriendlyMissingBuffInRange(Unit const* obj, float range, uint32 spellid) : i_obj(obj), i_range(range)
        {
            i_spell = spellid;
            if( SpellInfo const* spell = sSpellMgr->GetSpellInfo(spellid) )
                if( SpellInfo const* newSpell = sSpellMgr->GetSpellForDifficultyFromSpell(spell, const_cast<Unit*>(obj)) )
                    i_spell = newSpell->Id;
        }
        bool operator()(Unit* u)
        {
            if (u->IsAlive() && u->IsInCombat() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) &&
                    !(u->HasAura(i_spell)))
            {
                return true;
            }
            return false;
        }
    private:
        Unit const* i_obj;
        float i_range;
        uint32 i_spell;
    };

    class AnyUnfriendlyUnitInObjectRangeCheck
    {
    public:
        AnyUnfriendlyUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) : i_obj(obj), i_funit(funit), i_range(range) {}
        bool operator()(Unit* u)
        {
            if (u->IsAlive() && !u->IsCritter() && i_obj->IsWithinDistInMap(u, i_range) && !i_funit->IsFriendlyTo(u) &&
                    (i_funit->GetTypeId() != TYPEID_UNIT || !i_funit->ToCreature()->IsAvoidingAOE())) // pussywizard
                return true;
            else
                return false;
        }
    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;
    };

    class AnyUnfriendlyNoTotemUnitInObjectRangeCheck
    {
    public:
        AnyUnfriendlyNoTotemUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) : i_obj(obj), i_funit(funit), i_range(range) {}
        bool operator()(Unit* u)
        {
            if (!u->IsAlive())
                return false;

            if (u->GetCreatureType() == CREATURE_TYPE_NON_COMBAT_PET)
                return false;

            if (u->GetTypeId() == TYPEID_UNIT && (u->ToCreature()->IsTotem() || u->ToCreature()->IsTrigger() || u->ToCreature()->IsAvoidingAOE())) // pussywizard: added IsAvoidingAOE()
                return false;

            if (!u->isTargetableForAttack(false, i_funit))
                return false;

            return i_obj->IsWithinDistInMap(u, i_range) && !i_funit->IsFriendlyTo(u);
        }
    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;
    };

    class NearestAttackableNoTotemUnitInObjectRangeCheck
    {
    public:
        NearestAttackableNoTotemUnitInObjectRangeCheck(WorldObject const* obj, Unit const* owner, float range) : i_obj(obj), i_owner(owner), i_range(range) {}

        bool operator()(Unit* u)
        {
            if (!u->IsAlive())
            {
                return false;
            }

            if (u->GetCreatureType() == CREATURE_TYPE_NON_COMBAT_PET)
            {
                return false;
            }

            if (u->GetTypeId() == TYPEID_UNIT && u->ToCreature()->IsTotem())
            {
                return false;
            }

            if (!u->isTargetableForAttack(false, i_owner))
            {
                return false;
            }

            uint32 losChecks = LINEOFSIGHT_ALL_CHECKS;
            Optional<float> collisionHeight = { };
            if (i_obj->GetTypeId() == TYPEID_GAMEOBJECT)
            {
                losChecks &= ~LINEOFSIGHT_CHECK_GOBJECT_M2;
                collisionHeight = i_owner->GetCollisionHeight();
            }

            if (!i_obj->IsWithinDistInMap(u, i_range) || !i_owner->IsValidAttackTarget(u) ||
                !i_obj->IsWithinLOSInMap(u, VMAP::ModelIgnoreFlags::Nothing, LineOfSightChecks(losChecks), collisionHeight))
            {
                return false;
            }

            return true;
        }

    private:
        WorldObject const* i_obj;
        Unit const* i_owner;
        float i_range;
    };

    class AnyUnfriendlyAttackableVisibleUnitInObjectRangeCheck
    {
    public:
        AnyUnfriendlyAttackableVisibleUnitInObjectRangeCheck(Unit const* funit, float range)
            : i_funit(funit), i_range(range) {}

        bool operator()(Unit const* u)
        {
            return u->IsAlive()
                   && i_funit->IsWithinDistInMap(u, i_range)
                   && !i_funit->IsFriendlyTo(u)
                   && i_funit->IsValidAttackTarget(u)
                   && !u->IsCritter()
                   && !u->IsTotem() //xinef: dont attack totems
                   /*&& i_funit->CanSeeOrDetect(u)*/; // pussywizard: already checked in IsValidAttackTarget(u)
        }
    private:
        Unit const* i_funit;
        float i_range;
    };

    class AnyFriendlyUnitInObjectRangeCheck
    {
    public:
        AnyFriendlyUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range, bool playerOnly = false) : i_obj(obj), i_funit(funit), i_range(range), i_playerOnly(playerOnly) {}
        bool operator()(Unit* u)
        {
            if (u->IsAlive() && i_obj->IsWithinDistInMap(u, i_range) && i_funit->IsFriendlyTo(u) && (!i_playerOnly || u->IsPlayer()))
                return true;
            else
                return false;
        }
    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;
        bool i_playerOnly;
    };

    class AnyFriendlyNotSelfUnitInObjectRangeCheck
    {
    public:
        AnyFriendlyNotSelfUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range, bool playerOnly = false) : i_obj(obj), i_funit(funit), i_range(range), i_playerOnly(playerOnly) {}
        bool operator()(Unit* u)
        {
            if (u != i_obj && u->IsAlive() && i_obj->IsWithinDistInMap(u, i_range) && i_funit->IsFriendlyTo(u) && (!i_playerOnly || u->IsPlayer()))
                return true;
            else
                return false;
        }
    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;
        bool i_playerOnly;
    };

    class AnyGroupedUnitInObjectRangeCheck
    {
    public:
        AnyGroupedUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range, bool raid) : _source(obj), _refUnit(funit), _range(range), _raid(raid) {}
        bool operator()(Unit* u)
        {
            if (_raid)
            {
                if (!_refUnit->IsInRaidWith(u))
                    return false;
            }
            else if (!_refUnit->IsInPartyWith(u))
                return false;

            return !_refUnit->IsHostileTo(u) && u->IsAlive() && _source->IsWithinDistInMap(u, _range);
        }

    private:
        WorldObject const* _source;
        Unit const* _refUnit;
        float _range;
        bool _raid;
    };

    class AnyUnitInObjectRangeCheck
    {
    public:
        AnyUnitInObjectRangeCheck(WorldObject const* obj, float range) : i_obj(obj), i_range(range) {}
        bool operator()(Unit* u)
        {
            if (u->IsAlive() && i_obj->IsWithinDistInMap(u, i_range))
                return true;

            return false;
        }
    private:
        WorldObject const* i_obj;
        float i_range;
    };

    // Success at unit in range, range update for next check (this can be use with UnitLastSearcher to find nearest unit)
    class NearestAttackableUnitInObjectRangeCheck
    {
    public:
        NearestAttackableUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) : i_obj(obj), i_funit(funit), i_range(range) {}
        bool operator()(Unit* u)
        {
            if (u->isTargetableForAttack(true, i_funit) && i_obj->IsWithinDistInMap(u, i_range) &&
                (i_funit->IsInCombatWith(u) || u->IsHostileTo(i_funit)) && i_obj->CanSeeOrDetect(u))
            {
                i_range = i_obj->GetDistance(u);        // use found unit range as new range limit for next check
                return true;
            }

            return false;
        }
    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;

        // prevent clone this object
        NearestAttackableUnitInObjectRangeCheck(NearestAttackableUnitInObjectRangeCheck const&);
    };

    class AnyAoETargetUnitInObjectRangeCheck
    {
    public:
        AnyAoETargetUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range)
            : i_obj(obj), i_funit(funit), _spellInfo(nullptr), i_range(range)
        {
            Unit const* check = i_funit;
            Unit const* owner = i_funit->GetOwner();
            if (owner)
                check = owner;
            i_targetForPlayer = (check->IsPlayer());
            if (i_obj->IsDynamicObject())
                _spellInfo = sSpellMgr->GetSpellInfo(((DynamicObject*)i_obj)->GetSpellId());
        }
        bool operator()(Unit* u)
        {
            // Check contains checks for: live, non-selectable, non-attackable flags, flight check and GM check, ignore totems
            if (Creature* creature = u->ToCreature())
            {
                if (creature->IsTotem())
                {
                    return false;
                }

                if (creature->IsAvoidingAOE())
                {
                    return false;
                }

            }

            if (i_funit->_IsValidAttackTarget(u, _spellInfo, i_obj->IsDynamicObject() ? i_obj : nullptr) && i_obj->IsWithinDistInMap(u, i_range,true,false))

                return true;

            return false;
        }
    private:
        bool i_targetForPlayer;
        WorldObject const* i_obj;
        Unit const* i_funit;
        SpellInfo const* _spellInfo;
        float i_range;
    };

    class AnyAttackableUnitExceptForOriginalCasterInObjectRangeCheck
    {
    public:
        AnyAttackableUnitExceptForOriginalCasterInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range)
            : i_obj(obj), i_funit(funit), i_range(range)
        {}
        bool operator()(Unit* u)
        {
            if (!u->IsAlive() || u->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE) || (u->IsImmuneToPC() && !u->IsInCombat()))
                return false;
            if (u->GetGUID() == i_funit->GetGUID())
                return false;

            if (i_obj->IsWithinDistInMap(u, i_range))
                return true;

            return false;
        }
    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;
    };

    // do attack at call of help to friendly crearture
    class CallOfHelpCreatureInRangeDo
    {
    public:
        CallOfHelpCreatureInRangeDo(Unit* funit, Unit* enemy, float range)
            : i_funit(funit), i_enemy(enemy), i_range(range)
        {}
        void operator()(Creature* u)
        {
            if (u == i_funit)
                return;

            if (!u->CanAssistTo(i_funit, i_enemy, false))
                return;

            // too far
            if (!u->IsWithinDistInMap(i_funit, i_range))
                return;

            // only if see assisted creature's enemy
            if (!u->IsWithinLOSInMap(i_enemy))
                return;

            if (u->AI())
                u->AI()->AttackStart(i_enemy);
        }
    private:
        Unit* const i_funit;
        Unit* const i_enemy;
        float i_range;
    };

    struct AnyDeadUnitCheck
    {
        bool operator()(Unit* u) { return !u->IsAlive(); }
    };

    /*
    struct AnyStealthedCheck
    {
        bool operator()(Unit* u) { return u->GetVisibility() == VISIBILITY_GROUP_STEALTH; }
    };
    */

    // Creature checks

    class NearestHostileUnitCheck
    {
    public:
        explicit NearestHostileUnitCheck(Creature const* creature, float dist = 0, bool playerOnly = false) : me(creature), i_playerOnly(playerOnly)
        {
            m_range = (dist == 0 ? 9999 : dist);
        }
        bool operator()(Unit* u)
        {
            if (!me->IsWithinDistInMap(u, m_range, true, false))
                return false;

            if (!me->IsValidAttackTarget(u))
                return false;

            if (i_playerOnly && u->GetTypeId() != TYPEID_PLAYER)
                return false;

            m_range = me->GetDistance(u);   // use found unit range as new range limit for next check
            return true;
        }

    private:
        Creature const* me;
        float m_range;
        bool i_playerOnly;
        NearestHostileUnitCheck(NearestHostileUnitCheck const&);
    };

    class NearestHostileUnitInAttackDistanceCheck
    {
    public:
        explicit NearestHostileUnitInAttackDistanceCheck(Creature const* creature, float dist) : me(creature), m_range(dist) {}
        bool operator()(Unit* u)
        {
            if (!me->IsWithinDistInMap(u, m_range, true, false))
                return false;

            if (!me->CanStartAttack(u))
                return false;

            m_range = me->GetDistance(u);   // use found unit range as new range limit for next check
            return true;
        }
    private:
        Creature const* me;
        float m_range;
        NearestHostileUnitInAttackDistanceCheck(NearestHostileUnitInAttackDistanceCheck const&);
    };

    class NearestVisibleDetectableContestedGuardUnitCheck
    {
    public:
        explicit NearestVisibleDetectableContestedGuardUnitCheck(Unit const* unit) : me(unit) {}
        bool operator()(Unit* u)
        {
            if (!u->CanSeeOrDetect(me, true, true, false))
            {
                return false;
            }

            if (!u->IsContestedGuard())
            {
                return false;
            }

            return true;
        }

    private:
        Unit const* me;
        NearestVisibleDetectableContestedGuardUnitCheck(NearestVisibleDetectableContestedGuardUnitCheck const&);
    };

    class AnyAssistCreatureInRangeCheck
    {
    public:
        AnyAssistCreatureInRangeCheck(Unit* funit, Unit* enemy, float range)
            : i_funit(funit), i_enemy(enemy), i_range(range)
        {
        }
        bool operator()(Creature* u)
        {
            if (u == i_funit)
                return false;

            if (!u->CanAssistTo(i_funit, i_enemy))
                return false;

            // too far
            if (!i_funit->IsWithinDistInMap(u, i_range))
                return false;

            // only if see assisted creature
            if (!i_funit->IsWithinLOSInMap(u))
                return false;

            return true;
        }
    private:
        Unit* const i_funit;
        Unit* const i_enemy;
        float i_range;
    };

    class NearestAssistCreatureInCreatureRangeCheck
    {
    public:
        NearestAssistCreatureInCreatureRangeCheck(Creature* obj, Unit* enemy, float range)
            : i_obj(obj), i_enemy(enemy), i_range(range) {}

        bool operator()(Creature* u)
        {
            if (u == i_obj)
                return false;
            if (!u->CanAssistTo(i_obj, i_enemy))
                return false;

            if (!i_obj->IsWithinDistInMap(u, i_range))
                return false;

            if (!i_obj->IsWithinLOSInMap(u))
                return false;

            i_range = i_obj->GetDistance(u);            // use found unit range as new range limit for next check
            return true;
        }
    private:
        Creature* const i_obj;
        Unit* const i_enemy;
        float  i_range;

        // prevent clone this object
        NearestAssistCreatureInCreatureRangeCheck(NearestAssistCreatureInCreatureRangeCheck const&);
    };

    // Success at unit in range, range update for next check (this can be use with CreatureLastSearcher to find nearest creature)
    class NearestCreatureEntryWithLiveStateInObjectRangeCheck
    {
    public:
        NearestCreatureEntryWithLiveStateInObjectRangeCheck(WorldObject const& obj, uint32 entry, bool alive, float range)
            : i_obj(obj), i_entry(entry), i_alive(alive), i_range(range) {}

        bool operator()(Creature* u)
        {
            if (u->GetEntry() == i_entry && u->IsAlive() == i_alive && i_obj.IsWithinDist(u, i_range) && i_obj.InSamePhase(u))
            {
                i_range = i_obj.GetDistance(u);         // use found unit range as new range limit for next check
                return true;
            }
            return false;
        }
    private:
        WorldObject const& i_obj;
        uint32 i_entry;
        bool   i_alive;
        float  i_range;

        // prevent clone this object
        NearestCreatureEntryWithLiveStateInObjectRangeCheck(NearestCreatureEntryWithLiveStateInObjectRangeCheck const&);
    };

    class AnyPlayerInObjectRangeCheck
    {
    public:
        AnyPlayerInObjectRangeCheck(WorldObject const* obj, float range, bool reqAlive = true, bool disallowGM = false) : _obj(obj), _range(range), _reqAlive(reqAlive), _disallowGM(disallowGM) {}
        bool operator()(Player* u)
        {
            if (_reqAlive && !u->IsAlive())
                return false;

            if (_disallowGM && (u->IsGameMaster() || u->IsSpectator()))
                return false;

            if (!_obj->IsWithinDistInMap(u, _range))
                return false;

            return true;
        }

        // pussywizard: needed for DestroyForNearbyPlayers
        bool operator()(Player* u, bool checkRange)
        {
            if (checkRange && !_obj->IsWithinDistInMap(u, _range))
                return false;

            return true;
        }

    private:
        WorldObject const* _obj;
        float _range;
        bool _reqAlive;
        bool _disallowGM;
    };

    class AnyPlayerExactPositionInGameObjectRangeCheck
    {
    public:
        AnyPlayerExactPositionInGameObjectRangeCheck(GameObject const* go, float range) : _go(go), _range(range) {}
        bool operator()(Player* u)
        {
            if (!_go->IsInRange(u->GetPositionX(), u->GetPositionY(), u->GetPositionZ(), _range))
                return false;

            return true;
        }

    private:
        GameObject const* _go;
        float _range;
    };

    class NearestPlayerInObjectRangeCheck
    {
    public:
        NearestPlayerInObjectRangeCheck(WorldObject const* obj, float range) : i_obj(obj), i_range(range)
        {
        }

        bool operator()(Player* u)
        {
            if (u->IsAlive() && i_obj->IsWithinDistInMap(u, i_range))
            {
                i_range = i_obj->GetDistance(u);
                return true;
            }

            return false;
        }
    private:
        WorldObject const* i_obj;
        float i_range;

        NearestPlayerInObjectRangeCheck(NearestPlayerInObjectRangeCheck const&);
    };

    class AllFriendlyCreaturesInGrid
    {
    public:
        AllFriendlyCreaturesInGrid(Unit const* obj) : unit(obj) {}
        bool operator() (Unit* u)
        {
            if (u->IsAlive() && u->IsVisible() && u->IsFriendlyTo(unit))
                return true;

            return false;
        }
    private:
        Unit const* unit;
    };

    class AllGameObjectsWithEntryInRange
    {
    public:
        AllGameObjectsWithEntryInRange(WorldObject const* object, uint32 entry, float maxRange) : m_pObject(object), m_uiEntry(entry), m_fRange(maxRange) {}
        bool operator() (GameObject* go)
        {
            if (go->GetEntry() == m_uiEntry && m_pObject->IsWithinDist(go, m_fRange, false))
                return true;

            return false;
        }
    private:
        WorldObject const* m_pObject;
        uint32 m_uiEntry;
        float m_fRange;
    };

    class AllCreaturesOfEntryInRange
    {
    public:
        AllCreaturesOfEntryInRange(WorldObject const* object, uint32 entry, float maxRange) : m_pObject(object), m_uiEntry(entry), m_fRange(maxRange) {}
        bool operator() (Unit* unit)
        {
            if (unit->GetEntry() == m_uiEntry && m_pObject->IsWithinDist(unit, m_fRange, false))
                return true;

            return false;
        }

    private:
        WorldObject const* m_pObject;
        uint32 m_uiEntry;
        float m_fRange;
    };

    class MostHPMissingGroupInRange
    {
    public:
        MostHPMissingGroupInRange(Unit const* obj, float range, uint32 hp) : i_obj(obj), i_range(range), i_hp(hp) {}

        bool operator()(Unit* u)
        {
            if (i_obj == u)
            {
                return false;
            }

            Player* player = nullptr;
            if (u->IsPlayer())
            {
                player = u->ToPlayer();
            }

            else if (u->IsPet() && u->GetOwner())
            {
                player = u->GetOwner()->ToPlayer();
            }

            if (!player)
            {
                return false;
            }

            Group* group = player->GetGroup();
            if (!group || !group->IsMember(i_obj->IsPet() ? i_obj->GetOwnerGUID() : i_obj->GetGUID()))
            {
                return false;
            }

            if (u->IsAlive() && !i_obj->IsHostileTo(u) && i_obj->IsWithinDistInMap(u, i_range) && u->GetMaxHealth() - u->GetHealth() > i_hp)
            {
                i_hp = u->GetMaxHealth() - u->GetHealth();
                return true;
            }

            return false;
        }

    private:
        Unit const* i_obj;
        float       i_range;
        uint32      i_hp;
    };

    class AllDeadCreaturesInRange
    {
    public:
        AllDeadCreaturesInRange(WorldObject const* obj, float range, bool reqAlive = true) : _obj(obj), _range(range), _reqAlive(reqAlive) {}

        bool operator()(Unit* unit) const
        {
            if (_reqAlive && unit->IsAlive())
            {
                return false;
            }
            if (!_obj->IsWithinDistInMap(unit, _range))
            {
                return false;
            }
            return true;
        }

    private:
        WorldObject const* _obj;
        float              _range;
        bool               _reqAlive;
    };

    class PlayerAtMinimumRangeAway
    {
    public:
        PlayerAtMinimumRangeAway(Unit const* unit, float fMinRange) : unit(unit), fRange(fMinRange) {}
        bool operator() (Player* player)
        {
            //No threat list check, must be done explicit if expected to be in combat with creature
            if (!player->IsGameMaster() && player->IsAlive() && !unit->IsWithinDist(player, fRange, false))
                return true;

            return false;
        }

    private:
        Unit const* unit;
        float fRange;
    };

    class GameObjectInRangeCheck
    {
    public:
        GameObjectInRangeCheck(float _x, float _y, float _z, float _range, uint32 _entry = 0) :
            x(_x), y(_y), z(_z), range(_range), entry(_entry) {}
        bool operator() (GameObject* go)
        {
            if (!entry || (go->GetGOInfo() && go->GetGOInfo()->entry == entry))
                return go->IsInRange(x, y, z, range);
            else return false;
        }
    private:
        float x, y, z, range;
        uint32 entry;
    };

    class AllWorldObjectsInRange
    {
    public:
        AllWorldObjectsInRange(WorldObject const* object, float maxRange) : m_pObject(object), m_fRange(maxRange) {}
        bool operator() (WorldObject* go)
        {
            return m_pObject->IsWithinDist(go, m_fRange, false) && m_pObject->InSamePhase(go);
        }
    private:
        WorldObject const* m_pObject;
        float m_fRange;
    };

    class ObjectTypeIdCheck
    {
    public:
        ObjectTypeIdCheck(TypeID typeId, bool equals) : _typeId(typeId), _equals(equals) {}
        bool operator()(WorldObject const* object)
        {
            return (object->GetTypeId() == _typeId) == _equals;
        }

    private:
        TypeID _typeId;
        bool _equals;
    };

    class ObjectGUIDCheck
    {
    public:
        ObjectGUIDCheck(ObjectGuid GUID, bool equals) : _GUID(GUID), _equals(equals) {}
        bool operator()(WorldObject const* object)
        {
            return (object->GetGUID() == _GUID) == _equals;
        }

    private:
        ObjectGuid _GUID;
        bool _equals;
    };

    class UnitAuraCheck
    {
    public:
        UnitAuraCheck(bool present, uint32 spellId, ObjectGuid casterGUID = ObjectGuid::Empty) : _present(present), _spellId(spellId), _casterGUID(casterGUID) {}
        bool operator()(Unit const* unit) const
        {
            return unit->HasAura(_spellId, _casterGUID) == _present;
        }

        bool operator()(WorldObject const* object) const
        {
            return object->ToUnit() && object->ToUnit()->HasAura(_spellId, _casterGUID) == _present;
        }

    private:
        bool _present;
        uint32 _spellId;
        ObjectGuid _casterGUID;
    };

    class AllWorldObjectsInExactRange
    {
    public:
        AllWorldObjectsInExactRange(WorldObject const* object, float range, bool equals) : _object(object), _range(range), _equals(equals) { }
        bool operator() (WorldObject const* object)
        {
            return (_object->GetExactDist2d(object) > _range) == _equals;
        }

    private:
        WorldObject const* _object;
        float _range;
        bool _equals;
    };

    class RandomCheck
    {
    public:
        explicit RandomCheck(uint8 chance) : _chance(chance) { }
        bool operator()(WorldObject const* /*object*/) const
        {
            return roll_chance_i(_chance);
        }

    private:
        uint8 const _chance;
    };

    class PowerCheck
    {
    public:
        explicit PowerCheck(Powers const power, bool equals) : _power(power), _equals(equals) { }
        bool operator()(WorldObject const* object) const
        {
            return object->ToUnit() && (object->ToUnit()->getPowerType() == _power) == _equals;
        }

    private:
        Powers const _power;
        bool const _equals;
    };

    class RaidCheck
    {
    public:
        explicit RaidCheck(Unit const* compare, bool equals) : _compare(compare), _equals(equals) { }
        bool operator()(WorldObject const* object) const
        {
            return object->ToUnit() && object->ToUnit()->IsInRaidWith(_compare) == _equals;
        }

    private:
        Unit const* _compare;
        bool const _equals;
    };

    // Player checks and do

    // Prepare using Builder localized packets with caching and send to player
    template<class Builder>
    class LocalizedPacketDo
    {
    public:
        explicit LocalizedPacketDo(Builder& builder) : i_builder(builder) {}

        ~LocalizedPacketDo()
        {
            for (std::size_t i = 0; i < i_data_cache.size(); ++i)
                delete i_data_cache[i];
        }
        void operator()(Player* p);

    private:
        Builder& i_builder;
        std::vector<WorldPacket*> i_data_cache;         // 0 = default, i => i-1 locale index
    };

    // Prepare using Builder localized packets with caching and send to player
    template<class Builder>
    class LocalizedPacketListDo
    {
    public:
        typedef std::vector<WorldPacket*> WorldPacketList;
        explicit LocalizedPacketListDo(Builder& builder) : i_builder(builder) {}

        ~LocalizedPacketListDo()
        {
            for (std::size_t i = 0; i < i_data_cache.size(); ++i)
                for (std::size_t j = 0; j < i_data_cache[i].size(); ++j)
                    delete i_data_cache[i][j];
        }
        void operator()(Player* p);

    private:
        Builder& i_builder;
        std::vector<WorldPacketList> i_data_cache;
        // 0 = default, i => i-1 locale index
    };
}
#endif
