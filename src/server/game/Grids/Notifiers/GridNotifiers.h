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

#include "Define.h"
#include "Group.h"
#include "Player.h"
#include "Spell.h"

namespace Acore
{
    struct AC_GAME_API VisibleNotifier
    {
    public:
        VisibleNotifier(Player& player, bool gobjOnly, bool largeOnly) :
            i_player(player),
            vis_guids(player.m_clientGUIDs),
            i_visibleNow(player.m_newVisible),
            i_gobjOnly(gobjOnly),
            i_largeOnly(largeOnly)
        {
            i_visibleNow.clear();
        }

        void Visit(GameObjectMapType&);

        template<class T>
        void Visit(GridRefMgr<T>& m);

        void SendToSelf(void);

    protected:
        Player& i_player;
        GuidUnorderedSet vis_guids;
        std::vector<Unit*>& i_visibleNow;
        bool i_gobjOnly;
        bool i_largeOnly;
        UpdateData i_data;
    };

    struct AC_GAME_API VisibleChangesNotifier
    {
    public:
        explicit VisibleChangesNotifier(WorldObject& object) :
            i_object(object) { }

        template<class T>
        void Visit(GridRefMgr<T>&) { }

        void Visit(PlayerMapType&);
        void Visit(CreatureMapType&);
        void Visit(DynamicObjectMapType&);

    protected:
        WorldObject& i_object;
    };

    struct AC_GAME_API PlayerRelocationNotifier : public VisibleNotifier
    {
        PlayerRelocationNotifier(Player& player, bool largeOnly):
            VisibleNotifier(player, false, largeOnly) { }

        template<class T>
        void Visit(GridRefMgr<T>& m)
        {
            VisibleNotifier::Visit(m);
        }

        void Visit(PlayerMapType&);
    };

    struct AC_GAME_API CreatureRelocationNotifier
    {
    public:
        CreatureRelocationNotifier(Creature& c) :
            i_creature(c) { }

        template<class T>
        void Visit(GridRefMgr<T>&) {}

        void Visit(PlayerMapType&);
    private:
        Creature& i_creature;
    };

    struct AC_GAME_API AIRelocationNotifier
    {
    public:
        explicit AIRelocationNotifier(Unit& unit) :
            i_unit(unit),
            isCreature(unit.GetTypeId() == TYPEID_UNIT) { }

        template<class T>
        void Visit(GridRefMgr<T>&) { }

        void Visit(CreatureMapType&);

    private:
        Unit& i_unit;
        bool isCreature;
    };

    struct AC_GAME_API MessageDistDeliverer
    {
    public:
        MessageDistDeliverer(WorldObject* src, WorldPacket* msg, float dist, bool own_team_only = false, Player const* skipped = nullptr)
            : i_source(src),
              i_message(msg),
              i_phaseMask(src->GetPhaseMask()),
              i_distSq(dist * dist),
              teamId((own_team_only && src->GetTypeId() == TYPEID_PLAYER) ? src->ToPlayer()->GetTeamId() : TEAM_NEUTRAL),
              skipped_receiver(skipped) { }

        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(DynamicObjectMapType& m);

        template<class SKIP>
        void Visit(GridRefMgr<SKIP>&) { }

        void SendPacket(Player* player);

    private:
        WorldObject* i_source;
        WorldPacket* i_message;
        uint32 i_phaseMask;
        float i_distSq;
        TeamId teamId;
        Player const* skipped_receiver;
    };

    struct AC_GAME_API MessageDistDelivererToHostile
    {
    public:
        MessageDistDelivererToHostile(Unit* src, WorldPacket* msg, float dist)
            : i_source(src),
              i_message(msg),
              i_phaseMask(src->GetPhaseMask()),
              i_distSq(dist * dist) { }

        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(DynamicObjectMapType& m);

        template<class SKIP>
        void Visit(GridRefMgr<SKIP>&) { }

        void SendPacket(Player* player);

    private:
        Unit* i_source;
        WorldPacket* i_message;
        uint32 i_phaseMask;
        float i_distSq;
    };

    struct AC_GAME_API ObjectUpdater
    {
    public:
        explicit ObjectUpdater(const uint32 diff, bool largeOnly) : i_timeDiff(diff), i_largeOnly(largeOnly) {}

        template<class T>
        void Visit(GridRefMgr<T>& m);

        void Visit(PlayerMapType&) { }
        void Visit(CorpseMapType&) { }

    private:
        uint32 i_timeDiff;
        bool i_largeOnly;
    };

    // SEARCHERS & LIST SEARCHERS & WORKERS

    // WorldObject searchers & workers

    template<class Check>
    struct AC_GAME_API WorldObjectSearcher
    {
    public:
        WorldObjectSearcher(WorldObject const* searcher, WorldObject*& result, Check& check, uint32 mapTypeMask = GRID_MAP_TYPE_MASK_ALL)
            : i_mapTypeMask(mapTypeMask),
              i_phaseMask(searcher->GetPhaseMask()),
              i_object(result),
              i_check(check) { }

        void Visit(GameObjectMapType& m);
        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(CorpseMapType& m);
        void Visit(DynamicObjectMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }
    private:
        uint32 i_mapTypeMask;
        uint32 i_phaseMask;
        WorldObject*& i_object;
        Check& i_check;
    };

    template<class Check>
    struct AC_GAME_API WorldObjectLastSearcher
    {
    public:
        WorldObjectLastSearcher(WorldObject const* searcher, WorldObject*& result, Check& check, uint32 mapTypeMask = GRID_MAP_TYPE_MASK_ALL)
            :  i_mapTypeMask(mapTypeMask),
               i_phaseMask(searcher->GetPhaseMask()),
               i_object(result),
               i_check(check) { }

        void Visit(GameObjectMapType& m);
        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(CorpseMapType& m);
        void Visit(DynamicObjectMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_mapTypeMask;
        uint32 i_phaseMask;
        WorldObject*& i_object;
        Check& i_check;
    };

    template<class Check>
    struct AC_GAME_API WorldObjectListSearcher
    {
    public:
        WorldObjectListSearcher(WorldObject const* searcher, std::list<WorldObject*>& objects, Check& check, uint32 mapTypeMask = GRID_MAP_TYPE_MASK_ALL)
            : i_mapTypeMask(mapTypeMask),
              i_phaseMask(searcher->GetPhaseMask()),
              i_objects(objects),
              i_check(check) { }

        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(CorpseMapType& m);
        void Visit(GameObjectMapType& m);
        void Visit(DynamicObjectMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_mapTypeMask;
        uint32 i_phaseMask;
        std::list<WorldObject*>& i_objects;
        Check& i_check;
    };

    template<class Do>
    struct AC_GAME_API WorldObjectWorker
    {
    public:
        WorldObjectWorker(WorldObject const* searcher, Do const& _do, uint32 mapTypeMask = GRID_MAP_TYPE_MASK_ALL)
            : i_mapTypeMask(mapTypeMask), i_phaseMask(searcher->GetPhaseMask()), i_do(_do) { }

        void Visit(GameObjectMapType& m);
        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);
        void Visit(CorpseMapType& m);
        void Visit(DynamicObjectMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_mapTypeMask;
        uint32 i_phaseMask;
        Do const& i_do;
    };

    // Gameobject searchers

    template<class Check>
    struct AC_GAME_API GameObjectSearcher
    {
    public:
        GameObjectSearcher(WorldObject const* searcher, GameObject*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_object(result),
              i_check(check) { }

        void Visit(GameObjectMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        GameObject*& i_object;
        Check& i_check;
    };

    // Last accepted by Check GO if any (Check can change requirements at each call)
    template<class Check>
    struct AC_GAME_API GameObjectLastSearcher
    {
    public:
        GameObjectLastSearcher(WorldObject const* searcher, GameObject*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_object(result),
              i_check(check) { }

        void Visit(GameObjectMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        GameObject*& i_object;
        Check& i_check;
    };

    template<class Check>
    struct AC_GAME_API GameObjectListSearcher
    {
    public:
        GameObjectListSearcher(WorldObject const* searcher, std::list<GameObject*>& objects, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_objects(objects),
              i_check(check) { }

        void Visit(GameObjectMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        std::list<GameObject*>& i_objects;
        Check& i_check;
    };

    template<class Functor>
    struct AC_GAME_API GameObjectWorker
    {
    public:
        GameObjectWorker(WorldObject const* searcher, Functor& func)
            : _func(func),
              _phaseMask(searcher->GetPhaseMask()) { }

        void Visit(GameObjectMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        Functor& _func;
        uint32 _phaseMask;
    };

    // Unit searchers

    // First accepted by Check Unit if any
    template<class Check>
    struct AC_GAME_API UnitSearcher
    {
    public:
        UnitSearcher(WorldObject const* searcher, Unit*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_object(result),
              i_check(check) { }

        void Visit(CreatureMapType& m);
        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }
    private:
        uint32 i_phaseMask;
        Unit*& i_object;
        Check& i_check;
    };

    // Last accepted by Check Unit if any (Check can change requirements at each call)
    template<class Check>
    struct AC_GAME_API UnitLastSearcher
    {
    public:
        UnitLastSearcher(WorldObject const* searcher, Unit*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(CreatureMapType& m);
        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        Unit*& i_object;
        Check& i_check;
    };

    // All accepted by Check units if any
    template<class Check>
    struct AC_GAME_API UnitListSearcher
    {
    public:
        UnitListSearcher(WorldObject const* searcher, std::list<Unit*>& objects, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_objects(objects),
              i_check(check) { }

        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        std::list<Unit*>& i_objects;
        Check& i_check;
    };

    // Creature searchers

    template<class Check>
    struct AC_GAME_API CreatureSearcher
    {
    public:
        CreatureSearcher(WorldObject const* searcher, Creature*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_object(result),
              i_check(check) { }

        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        Creature*& i_object;
        Check& i_check;
    };

    // Last accepted by Check Creature if any (Check can change requirements at each call)
    template<class Check>
    struct AC_GAME_API CreatureLastSearcher
    {
    public:
        CreatureLastSearcher(WorldObject const* searcher, Creature*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()), i_object(result), i_check(check) {}

        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        Creature*& i_object;
        Check& i_check;
    };

    template<class Check>
    struct AC_GAME_API CreatureListSearcher
    {
    public:
        CreatureListSearcher(WorldObject const* searcher, std::list<Creature*>& objects, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_objects(objects),
              i_check(check) { }

        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        std::list<Creature*>& i_objects;
        Check& i_check;
    };

    template<class Do>
    struct AC_GAME_API CreatureWorker
    {
    public:
        CreatureWorker(WorldObject const* searcher, Do& _do)
            : i_phaseMask(searcher->GetPhaseMask()), i_do(_do) { }

        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        Do& i_do;
    };

    // Player searchers

    template<class Check>
    struct AC_GAME_API PlayerSearcher
    {
    public:
        PlayerSearcher(WorldObject const* searcher, Player*& result, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_object(result),
              i_check(check) { }

        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        Player*& i_object;
        Check& i_check;
    };

    template<class Check>
    struct AC_GAME_API PlayerListSearcher
    {
    public:
        PlayerListSearcher(WorldObject const* searcher, std::list<Player*>& objects, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_objects(objects),
              i_check(check) { }

        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        std::list<Player*>& i_objects;
        Check& i_check;
    };

    template<class Check>
    struct AC_GAME_API PlayerListSearcherWithSharedVision
    {
    public:
        PlayerListSearcherWithSharedVision(WorldObject const* searcher, std::list<Player*>& objects, Check& check)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_objects(objects),
              i_check(check) { }

        void Visit(PlayerMapType& m);
        void Visit(CreatureMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        std::list<Player*>& i_objects;
        Check& i_check;
    };

    template<class Check>
    struct AC_GAME_API PlayerLastSearcher
    {
    public:
        PlayerLastSearcher(WorldObject const* searcher, Player*& result, Check& check) :
            i_phaseMask(searcher->GetPhaseMask()),
            i_object(result),
            i_check(check) { }

        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        uint32 i_phaseMask;
        Player*& i_object;
        Check& i_check;
    };

    template<class Do>
    struct AC_GAME_API PlayerWorker
    {
    public:
        PlayerWorker(WorldObject const* searcher, Do& _do)
            : i_phaseMask(searcher->GetPhaseMask()),
              i_do(_do) { }

        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) {}

    private:
        uint32 i_phaseMask;
        Do& i_do;
    };

    template<class Do>
    struct AC_GAME_API PlayerDistWorker
    {
    public:
        PlayerDistWorker(WorldObject const* searcher, float _dist, Do& _do)
            : i_searcher(searcher),
              i_dist(_dist),
              i_do(_do) { }

        void Visit(PlayerMapType& m);

        template<class NOT_INTERESTED>
        void Visit(GridRefMgr<NOT_INTERESTED>&) { }

    private:
        WorldObject const* i_searcher;
        float i_dist;
        Do& i_do;
    };

    // CHECKS && DO classes

    // WorldObject check classes

    class AC_GAME_API AnyDeadUnitObjectInRangeCheck
    {
    public:
        AnyDeadUnitObjectInRangeCheck(Unit* searchObj, float range) : i_searchObj(searchObj), i_range(range) {}
        bool operator()(Player* u);
        bool operator()(Corpse* u);
        bool operator()(Creature* u);

        template<class NOT_INTERESTED>
        bool operator()(NOT_INTERESTED*) { return false; }

    protected:
        Unit const* const i_searchObj;
        float i_range;
    };

    class AC_GAME_API AnyDeadUnitSpellTargetInRangeCheck : public AnyDeadUnitObjectInRangeCheck
    {
    public:
        AnyDeadUnitSpellTargetInRangeCheck(Unit* searchObj, float range, SpellInfo const* spellInfo, SpellTargetCheckTypes check)
            : AnyDeadUnitObjectInRangeCheck(searchObj, range),
              i_spellInfo(spellInfo),
              i_check(searchObj, searchObj, spellInfo, check, nullptr) { }

        bool operator()(Player* u);
        bool operator()(Corpse* u);
        bool operator()(Creature* u);

        template<class NOT_INTERESTED>
        bool operator()(NOT_INTERESTED*)
        {
            return false;
        }

    protected:
        SpellInfo const* i_spellInfo;
        WorldObjectSpellTargetCheck i_check;
    };

    // WorldObject do classes

    class AC_GAME_API RespawnDo
    {
    public:
        RespawnDo() { }
        void operator()(Creature* u) const { u->Respawn(); }
        void operator()(GameObject* u) const { u->Respawn(); }
        void operator()(WorldObject*) const {}
        void operator()(Corpse*) const {}
    };

    // GameObject checks

    class AC_GAME_API GameObjectFocusCheck
    {
    public:
        GameObjectFocusCheck(Unit const* unit, uint32 focusId) :
            i_unit(unit), i_focusId(focusId) { }

        bool operator()(GameObject* go) const;
    private:
        Unit const* i_unit;
        uint32 i_focusId;
    };

    // Find the nearest Fishing hole and return true only if source object is in range of hole
    class AC_GAME_API NearestGameObjectFishingHole
    {
    public:
        NearestGameObjectFishingHole(WorldObject const& obj, float range) :
            i_obj(obj),
            i_range(range) { }

        bool operator()(GameObject* go);
    private:
        WorldObject const& i_obj;
        float i_range;

        // prevent clone
        NearestGameObjectFishingHole(NearestGameObjectFishingHole const&);
    };

    class AC_GAME_API NearestGameObjectCheck
    {
    public:
        NearestGameObjectCheck(WorldObject const& obj) :
            i_obj(obj),
            i_range(999) { }

        bool operator()(GameObject* go);
    private:
        WorldObject const& i_obj;
        float i_range;

        // prevent clone this object
        NearestGameObjectCheck(NearestGameObjectCheck const&);
    };

    // Success at unit in range, range update for next check (this can be use with GameobjectLastSearcher to find nearest GO)
    class AC_GAME_API NearestGameObjectEntryInObjectRangeCheck
    {
    public:
        NearestGameObjectEntryInObjectRangeCheck(WorldObject const& obj, uint32 entry, float range, bool onlySpawned = false) :
            i_obj(obj),
            i_entry(entry),
            i_range(range),
            i_onlySpawned(onlySpawned) { }

        bool operator()(GameObject* go);

    private:
        WorldObject const& i_obj;
        uint32 i_entry;
        float i_range;
        bool i_onlySpawned;

        // prevent clone this object
        NearestGameObjectEntryInObjectRangeCheck(NearestGameObjectEntryInObjectRangeCheck const&);
    };

    // Success at unit in range, range update for next check (this can be use with GameobjectLastSearcher to find nearest GO with a certain type)
    class AC_GAME_API NearestGameObjectTypeInObjectRangeCheck
    {
    public:
        NearestGameObjectTypeInObjectRangeCheck(WorldObject const& obj, GameobjectTypes type, float range) : i_obj(obj), i_type(type), i_range(range) {}
        bool operator()(GameObject* go);

    private:
        WorldObject const& i_obj;
        GameobjectTypes i_type;
        float i_range;

        // prevent clone this object
        NearestGameObjectTypeInObjectRangeCheck(NearestGameObjectTypeInObjectRangeCheck const&);
    };

    // Unit checks

    class AC_GAME_API MostHPMissingInRange
    {
    public:
        MostHPMissingInRange(Unit const* obj, float range, uint32 hp) :
            i_obj(obj),
            i_range(range),
            i_hp(hp) { }

        bool operator()(Unit* u);

    private:
        Unit const* i_obj;
        float i_range;
        uint32 i_hp;
    };

    class AC_GAME_API FriendlyCCedInRange
    {
    public:
        FriendlyCCedInRange(Unit const* obj, float range) :
            i_obj(obj),
            i_range(range) { }

        bool operator()(Unit* u);

    private:
        Unit const* i_obj;
        float i_range;
    };

    class AC_GAME_API FriendlyMissingBuffInRange
    {
    public:
        FriendlyMissingBuffInRange(Unit const* obj, float range, uint32 spellid);

        bool operator()(Unit* u);

    private:
        Unit const* i_obj;
        float i_range;
        uint32 i_spell;
    };

    class AC_GAME_API AnyUnfriendlyUnitInObjectRangeCheck
    {
    public:
        AnyUnfriendlyUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) :
            i_obj(obj),
            i_funit(funit),
            i_range(range) { }

        bool operator()(Unit* u);

    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;
    };

    class AC_GAME_API AnyUnfriendlyNoTotemUnitInObjectRangeCheck
    {
    public:
        AnyUnfriendlyNoTotemUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) :
            i_obj(obj),
            i_funit(funit),
            i_range(range) { }

        bool operator()(Unit* u);

    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;
    };

    class AC_GAME_API AnyUnfriendlyAttackableVisibleUnitInObjectRangeCheck
    {
    public:
        AnyUnfriendlyAttackableVisibleUnitInObjectRangeCheck(Unit const* funit, float range)
            : i_funit(funit),
              i_range(range) { }

        bool operator()(const Unit* u);

    private:
        Unit const* i_funit;
        float i_range;
    };

    class AC_GAME_API AnyFriendlyUnitInObjectRangeCheck
    {
    public:
        AnyFriendlyUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range, bool playerOnly = false) :
            i_obj(obj),
            i_funit(funit),
            i_range(range),
            i_playerOnly(playerOnly) { }

        bool operator()(Unit* u);

    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;
        bool i_playerOnly;
    };

    class AC_GAME_API AnyFriendlyNotSelfUnitInObjectRangeCheck
    {
    public:
        AnyFriendlyNotSelfUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range, bool playerOnly = false) :
            i_obj(obj),
            i_funit(funit),
            i_range(range),
            i_playerOnly(playerOnly) { }

        bool operator()(Unit* u);

    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;
        bool i_playerOnly;
    };

    class AC_GAME_API AnyGroupedUnitInObjectRangeCheck
    {
    public:
        AnyGroupedUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range, bool raid) :
            _source(obj),
            _refUnit(funit),
            _range(range),
            _raid(raid) { }

        bool operator()(Unit* u);

    private:
        WorldObject const* _source;
        Unit const* _refUnit;
        float _range;
        bool _raid;
    };

    class AC_GAME_API AnyUnitInObjectRangeCheck
    {
    public:
        AnyUnitInObjectRangeCheck(WorldObject const* obj, float range) :
            i_obj(obj),
            i_range(range) { }

        bool operator()(Unit* u);

    private:
        WorldObject const* i_obj;
        float i_range;
    };

    // Success at unit in range, range update for next check (this can be use with UnitLastSearcher to find nearest unit)
    class AC_GAME_API NearestAttackableUnitInObjectRangeCheck
    {
    public:
        NearestAttackableUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range) :
            i_obj(obj),
            i_funit(funit),
            i_range(range) { }

        bool operator()(Unit* u);

    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;

        // prevent clone this object
        NearestAttackableUnitInObjectRangeCheck(NearestAttackableUnitInObjectRangeCheck const&);
    };

    class AC_GAME_API AnyAoETargetUnitInObjectRangeCheck
    {
    public:
        AnyAoETargetUnitInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range);

        bool operator()(Unit* u);

    private:
        bool i_targetForPlayer;
        WorldObject const* i_obj;
        Unit const* i_funit;
        SpellInfo const* _spellInfo;
        float i_range;
    };

    class AC_GAME_API AnyAttackableUnitExceptForOriginalCasterInObjectRangeCheck
    {
    public:
        AnyAttackableUnitExceptForOriginalCasterInObjectRangeCheck(WorldObject const* obj, Unit const* funit, float range)
            : i_obj(obj),
              i_funit(funit),
              i_range(range) { }

        bool operator()(Unit* u);

    private:
        WorldObject const* i_obj;
        Unit const* i_funit;
        float i_range;
    };

    // do attack at call of help to friendly crearture
    class AC_GAME_API CallOfHelpCreatureInRangeDo
    {
    public:
        CallOfHelpCreatureInRangeDo(Unit* funit, Unit* enemy, float range)
            : i_funit(funit),
              i_enemy(enemy),
              i_range(range) { }

        void operator()(Creature* u);

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

    class AC_GAME_API NearestHostileUnitCheck
    {
    public:
        explicit NearestHostileUnitCheck(Creature const* creature, float dist = 0, bool playerOnly = false) :
            me(creature),
            i_playerOnly(playerOnly)
        {
            m_range = (dist == 0 ? 9999 : dist);
        }

        bool operator()(Unit* u);

    private:
        Creature const* me;
        float m_range;
        bool i_playerOnly;
        NearestHostileUnitCheck(NearestHostileUnitCheck const&);
    };

    class AC_GAME_API NearestHostileUnitInAttackDistanceCheck
    {
    public:
        explicit NearestHostileUnitInAttackDistanceCheck(Creature const* creature, float dist) :
            me(creature),
            m_range(dist) { }

        bool operator()(Unit* u);

    private:
        Creature const* me;
        float m_range;
        NearestHostileUnitInAttackDistanceCheck(NearestHostileUnitInAttackDistanceCheck const&);
    };

    class AC_GAME_API NearestVisibleDetectableContestedGuardUnitCheck
    {
    public:
        explicit NearestVisibleDetectableContestedGuardUnitCheck(Unit const* unit) : me(unit) { }

        bool operator()(Unit* u);

    private:
        Unit const* me;
        NearestVisibleDetectableContestedGuardUnitCheck(NearestVisibleDetectableContestedGuardUnitCheck const&);
    };

    class AC_GAME_API AnyAssistCreatureInRangeCheck
    {
    public:
        AnyAssistCreatureInRangeCheck(Unit* funit, Unit* enemy, float range)
            : i_funit(funit),
              i_enemy(enemy),
              i_range(range) { }

        bool operator()(Creature* u);

    private:
        Unit* const i_funit;
        Unit* const i_enemy;
        float i_range;
    };

    class AC_GAME_API NearestAssistCreatureInCreatureRangeCheck
    {
    public:
        NearestAssistCreatureInCreatureRangeCheck(Creature* obj, Unit* enemy, float range)
            : i_obj(obj),
              i_enemy(enemy),
              i_range(range) { }

        bool operator()(Creature* u);

    private:
        Creature* const i_obj;
        Unit* const i_enemy;
        float  i_range;

        // prevent clone this object
        NearestAssistCreatureInCreatureRangeCheck(NearestAssistCreatureInCreatureRangeCheck const&);
    };

    // Success at unit in range, range update for next check (this can be use with CreatureLastSearcher to find nearest creature)
    class AC_GAME_API NearestCreatureEntryWithLiveStateInObjectRangeCheck
    {
    public:
        NearestCreatureEntryWithLiveStateInObjectRangeCheck(WorldObject const& obj, uint32 entry, bool alive, float range)
            : i_obj(obj),
              i_entry(entry),
              i_alive(alive),
              i_range(range) { }

        bool operator()(Creature* u);

    private:
        WorldObject const& i_obj;
        uint32 i_entry;
        bool i_alive;
        float i_range;

        // prevent clone this object
        NearestCreatureEntryWithLiveStateInObjectRangeCheck(NearestCreatureEntryWithLiveStateInObjectRangeCheck const&);
    };

    class AC_GAME_API AnyPlayerInObjectRangeCheck
    {
    public:
        AnyPlayerInObjectRangeCheck(WorldObject const* obj, float range, bool reqAlive = true, bool disallowGM = false) :
            _obj(obj),
            _range(range),
            _reqAlive(reqAlive),
            _disallowGM(disallowGM) { }

        bool operator()(Player* u);

        // pussywizard: needed for DestroyForNearbyPlayers
        bool operator()(Player* u, bool checkRange);

    private:
        WorldObject const* _obj;
        float _range;
        bool _reqAlive;
        bool _disallowGM;
    };

    class AC_GAME_API AnyPlayerExactPositionInGameObjectRangeCheck
    {
    public:
        AnyPlayerExactPositionInGameObjectRangeCheck(GameObject const* go, float range) :
            _go(go),
            _range(range) { }

        bool operator()(Player* u);

    private:
        GameObject const* _go;
        float _range;
    };

    class AC_GAME_API NearestPlayerInObjectRangeCheck
    {
    public:
        NearestPlayerInObjectRangeCheck(WorldObject const* obj, float range) :
            i_obj(obj),
            i_range(range) { }

        bool operator()(Player* u);

    private:
        WorldObject const* i_obj;
        float i_range;

        NearestPlayerInObjectRangeCheck(NearestPlayerInObjectRangeCheck const&);
    };

    class AC_GAME_API AllFriendlyCreaturesInGrid
    {
    public:
        AllFriendlyCreaturesInGrid(Unit const* obj) :
            unit(obj) { }

        bool operator()(Unit* u);

    private:
        Unit const* unit;
    };

    class AC_GAME_API AllGameObjectsWithEntryInRange
    {
    public:
        AllGameObjectsWithEntryInRange(const WorldObject* object, uint32 entry, float maxRange) :
            m_pObject(object),
            m_uiEntry(entry),
            m_fRange(maxRange) { }

        bool operator()(GameObject* go);

    private:
        const WorldObject* m_pObject;
        uint32 m_uiEntry;
        float m_fRange;
    };

    class AC_GAME_API AllCreaturesOfEntryInRange
    {
    public:
        AllCreaturesOfEntryInRange(const WorldObject* object, uint32 entry, float maxRange) :
            m_pObject(object),
            m_uiEntry(entry),
            m_fRange(maxRange) { }

        bool operator()(Unit* unit);

    private:
        const WorldObject* m_pObject;
        uint32 m_uiEntry;
        float m_fRange;
    };

    class AC_GAME_API MostHPMissingGroupInRange
    {
    public:
        MostHPMissingGroupInRange(Unit const* obj, float range, uint32 hp) :
            i_obj(obj),
            i_range(range),
            i_hp(hp) { }

        bool operator()(Unit* u);

    private:
        Unit const* i_obj;
        float       i_range;
        uint32      i_hp;
    };

    class AC_GAME_API AllDeadCreaturesInRange
    {
    public:
        AllDeadCreaturesInRange(WorldObject const* obj, float range, bool reqAlive = true) :
            _obj(obj),
            _range(range),
            _reqAlive(reqAlive) { }

        bool operator()(Unit* unit) const;

    private:
        WorldObject const* _obj;
        float _range;
        bool _reqAlive;
    };

    class AC_GAME_API PlayerAtMinimumRangeAway
    {
    public:
        PlayerAtMinimumRangeAway(Unit const* unit, float fMinRange) :
            unit(unit),
            fRange(fMinRange) { }

        bool operator()(Player* player);

    private:
        Unit const* unit;
        float fRange;
    };

    class AC_GAME_API GameObjectInRangeCheck
    {
    public:
        GameObjectInRangeCheck(float _x, float _y, float _z, float _range, uint32 _entry = 0) :
            x(_x),
            y(_y),
            z(_z),
            range(_range),
            entry(_entry) { }

        bool operator()(GameObject* go);

    private:
        float x, y, z, range;
        uint32 entry;
    };

    class AC_GAME_API AllWorldObjectsInRange
    {
    public:
        AllWorldObjectsInRange(const WorldObject* object, float maxRange) :
            m_pObject(object),
            m_fRange(maxRange) { }

        bool operator()(WorldObject* go);

    private:
        const WorldObject* m_pObject;
        float m_fRange;
    };

    class AC_GAME_API ObjectTypeIdCheck
    {
    public:
        ObjectTypeIdCheck(TypeID typeId, bool equals) :
            _typeId(typeId),
            _equals(equals) { }

        bool operator()(WorldObject const* object);

    private:
        TypeID _typeId;
        bool _equals;
    };

    class AC_GAME_API ObjectGUIDCheck
    {
    public:
        ObjectGUIDCheck(ObjectGuid GUID, bool equals) :
            _GUID(GUID),
            _equals(equals) { }

        bool operator()(WorldObject const* object);

    private:
        ObjectGuid _GUID;
        bool _equals;
    };

    class AC_GAME_API UnitAuraCheck
    {
    public:
        UnitAuraCheck(bool present, uint32 spellId, ObjectGuid casterGUID = ObjectGuid::Empty) :
            _present(present),
            _spellId(spellId),
            _casterGUID(casterGUID) { }

        bool operator()(Unit const* unit) const;
        bool operator()(WorldObject const* object) const;

    private:
        bool _present;
        uint32 _spellId;
        ObjectGuid _casterGUID;
    };

    class AC_GAME_API AllWorldObjectsInExactRange
    {
    public:
        AllWorldObjectsInExactRange(const WorldObject* object, float range, bool equals) :
            _object(object),
            _range(range),
            _equals(equals) { }

        bool operator()(WorldObject const* object);

    private:
        const WorldObject* _object;
        float _range;
        bool _equals;
    };

    class AC_GAME_API RandomCheck
    {
    public:
        explicit RandomCheck(uint8 chance) :
            _chance(chance) { }

        bool operator()(WorldObject const* /*object*/) const;

    private:
        uint8 const _chance;
    };

    class AC_GAME_API PowerCheck
    {
    public:
        explicit PowerCheck(Powers const power, bool equals) :
            _power(power),
            _equals(equals) { }

        bool operator()(WorldObject const* object) const;

    private:
        Powers const _power;
        bool const _equals;
    };

    class AC_GAME_API RaidCheck
    {
    public:
        explicit RaidCheck(Unit const* compare, bool equals) :
            _compare(compare),
            _equals(equals) { }

        bool operator()(WorldObject const* object) const;

    private:
        Unit const* _compare;
        bool const _equals;
    };

    // Player checks and do

    // Prepare using Builder localized packets with caching and send to player
    template<class Builder>
    class AC_GAME_API LocalizedPacketDo
    {
    public:
        explicit LocalizedPacketDo(Builder& builder) :
            i_builder(builder) { }

        ~LocalizedPacketDo()
        {
            for (size_t i = 0; i < i_data_cache.size(); ++i)
            {
                delete i_data_cache[i];
            }
        }

        void operator()(Player* p);

    private:
        Builder& i_builder;
        std::vector<WorldPacket*> i_data_cache;         // 0 = default, i => i-1 locale index
    };

    // Prepare using Builder localized packets with caching and send to player
    template<class Builder>
    class AC_GAME_API LocalizedPacketListDo
    {
    public:
        explicit LocalizedPacketListDo(Builder& builder) :
            i_builder(builder) { }

        ~LocalizedPacketListDo()
        {
            for (size_t i = 0; i < i_data_cache.size(); ++i)
                for (size_t j = 0; j < i_data_cache[i].size(); ++j)
                {
                    delete i_data_cache[i][j];
                }
        }

        typedef std::vector<WorldPacket*> WorldPacketList;

        void operator()(Player* p);

    private:
        Builder& i_builder;
        std::vector<WorldPacketList> i_data_cache;
        // 0 = default, i => i-1 locale index
    };
}
#endif
