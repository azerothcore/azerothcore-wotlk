#ifndef AZTHGROUPMGR_H
#define AZTHGROUPMGR_H

#include "Group.h"

class AzthGroupMgr {
public:
    explicit AzthGroupMgr(Group* group);
    ~AzthGroupMgr();

    void saveToDb();

    uint8 levelMaxGroup;
    Group* group;
};
#endif
