#include "AzthGroupMgr.h"
#include "DatabaseEnv.h"

AzthGroupMgr::AzthGroupMgr(Group* group) {
    this->levelMaxGroup = 0;
    this->group = group;
}

void AzthGroupMgr::saveToDb() {
    CharacterDatabase.PExecute("UPDATE groups SET maxLevelGroup = %u WHERE leaderGuid = %u", this->levelMaxGroup, this->group->GetLeaderGUID());
}

