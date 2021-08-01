/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _FORMATIONS_H
#define _FORMATIONS_H

#include "Define.h"
#include "Unit.h"
#include <map>
#include <unordered_map>

class Creature;
class CreatureGroup;

struct FormationInfo
{
    ObjectGuid::LowType leaderGUID;
    float follow_dist;
    float follow_angle;
    uint8 groupAI;
    uint32 point_1;
    uint32 point_2;
};

typedef std::unordered_map<ObjectGuid::LowType/*memberDBGUID*/, FormationInfo*>   CreatureGroupInfoType;

class FormationMgr
{
public:
    FormationMgr() { }
    ~FormationMgr();

    static FormationMgr* instance();

    void AddCreatureToGroup(uint32 group_id, Creature* creature);
    void RemoveCreatureFromGroup(CreatureGroup* group, Creature* creature);
    void LoadCreatureFormations();
    CreatureGroupInfoType CreatureGroupMap;
};

class CreatureGroup
{
public:
    // pussywizard: moved public to the top so it compiles and typedef is public
    typedef std::map<Creature*, FormationInfo*>  CreatureGroupMemberType;

    //Group cannot be created empty
    explicit CreatureGroup(uint32 id) : m_leader(nullptr), m_groupID(id), m_Formed(false) {}
    ~CreatureGroup() {}

    Creature* getLeader() const { return m_leader; }
    uint32 GetId() const { return m_groupID; }
    bool isEmpty() const { return m_members.empty(); }
    bool isFormed() const { return m_Formed; }
    const CreatureGroupMemberType& GetMembers() const { return m_members; }

    void AddMember(Creature* member);
    void RemoveMember(Creature* member);
    void FormationReset(bool dismiss);

    void LeaderMoveTo(float x, float y, float z, bool run);
    void MemberAttackStart(Creature* member, Unit* target);

private:
    Creature* m_leader; //Important do not forget sometimes to work with pointers instead synonims :D:D
    CreatureGroupMemberType m_members;

    uint32 m_groupID;
    bool m_Formed;
};

#define sFormationMgr FormationMgr::instance()

#endif
