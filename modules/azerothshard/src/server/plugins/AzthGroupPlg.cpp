/**
This plugin can be used for common group customizations
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "InstanceSaveMgr.h"
#include "Player.h"
#include "Map.h"
#include "WorldSession.h"

class AzthGroupPlg : public GroupScript {
public:

    AzthGroupPlg() : GroupScript("AzthGroupPlg") { }

    void OnAddMember(Group* group, uint64 guid) override {
        Player* player = ObjectAccessor::FindPlayer(guid);
        if (group->azthGroupMgr->levelMaxGroup < player->getLevel()) {
            group->azthGroupMgr->levelMaxGroup = player->getLevel();
            group->azthGroupMgr->saveToDb();
        }
    }
};

void AddSC_azth_group_plg() {
    new AzthGroupPlg();
}