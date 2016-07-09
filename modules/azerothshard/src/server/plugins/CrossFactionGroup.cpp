#include "ScriptMgr.h"
#include "Language.h"
#include "Player.h"
#include "ObjectAccessor.h"
#include "Group.h"
#include "Log.h"

/* [TODO] fix and re-enable */
// class CrossFactionGroup : public GroupScript {
// public:
//
//     CrossFactionGroup() : GroupScript("CrossFactionGroup") {
//     }
//
//     void OnAddMember(Group* group, ObjectGuid guid) {
//         UpdatePlayerTeam(guid);
//     }
//
//     void OnAfterRemoveMember(Group* group, ObjectGuid guid, RemoveMethod /*method*/, ObjectGuid /*kicker*/, const char* /*reason*/) {
//         UpdatePlayerTeam(guid);
//     }
//
//     void OnAfterChangeLeader(Group* group, ObjectGuid leaderGuid) {
//         std::list<Group::MemberSlot> memberSlots = group->GetMemberSlots();
//         for (std::list<Group::MemberSlot>::iterator membersIterator = memberSlots.begin(); membersIterator != memberSlots.end(); membersIterator++)
//             UpdatePlayerTeam((*membersIterator).guid);
//     }
//
//     void OnAfterDisband(Group* group) {
//         std::list<Group::MemberSlot> memberSlots = group->GetMemberSlots();
//         for (std::list<Group::MemberSlot>::iterator membersIterator = memberSlots.begin(); membersIterator != memberSlots.end(); membersIterator++)
//             UpdatePlayerTeam((*membersIterator).guid);
//     }
//
// private:
//
//     void UpdatePlayerTeam(ObjectGuid guid) {
//         Player* player = ObjectAccessor::FindConnectedPlayer(guid);
//         if (player)
//             player->setFactionForRace(player->getRace());
//     }
// };
//
// void AddSC_CrossFactionGroups() {
//     new CrossFactionGroup();
// }
