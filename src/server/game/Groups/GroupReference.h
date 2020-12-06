/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _GROUPREFERENCE_H
#define _GROUPREFERENCE_H

#include "LinkedReference/Reference.h"

class Group;
class Player;

class GroupReference : public Reference<Group, Player>
{
protected:
    uint8 iSubGroup{0};
    void targetObjectBuildLink() override;
    void targetObjectDestroyLink() override;
    void sourceObjectDestroyLink() override;
public:
    GroupReference() : Reference<Group, Player>() {}
    ~GroupReference() override { unlink(); }
    GroupReference* next() { return (GroupReference*)Reference<Group, Player>::next(); }
    [[nodiscard]] GroupReference const* next() const { return (GroupReference const*)Reference<Group, Player>::next(); }
    [[nodiscard]] uint8 getSubGroup() const { return iSubGroup; }
    void setSubGroup(uint8 pSubGroup) { iSubGroup = pSubGroup; }
};
#endif

