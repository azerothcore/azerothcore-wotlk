#include "FriendList.h"

#include "CharacterCache.h"
#include <Opcodes.h>
#include "SocialMgr.h"
#include <WorldSocket.h>

#include "Player.h"

static bool s_initialized;

//===========================================================================
static int FriendListAddFriendHandler(WorldSession* ses, Opcodes msgId, uint32_t eventTime, WorldPacket* msg)
{
    if (!ses->ActivePlayer()) {
        return 0;
    }
    char name[305] = {};
    char note[512] = {};
    msg->GetString(name, sizeof(name));
    msg->GetString(note, sizeof(note));
    FormatCharacterName(name);
    auto cacheEntry = sCharacterCache->GetCharacterCacheByName(name);
    if (!cacheEntry) {
    CHARACTERNOTFOUND:
        sSocialMgr->SendFriendStatus(ses->ActivePlayer(),FRIEND_NOT_FOUND,ObjectGuid(),false);
        return 0;
    }
    FRIEND_RESULT res = FRIEND_NOT_FOUND;
    if (ses->ActivePlayer()->GetGUID() == cacheEntry->Guid) {
        res = FRIEND_SELF;
    }
    else if (ses->ActivePlayer()->GetTeamId() != Player::TeamIdForRace(cacheEntry->Race)) {
        res = FRIEND_ENEMY;
    }
    else if (ses->ActivePlayer()->GetSocial()->HasFriend(cacheEntry->Guid)) {
        res = FRIEND_ALREADY;
    }
    else {
        Player* pPlayer = ObjectAccessor::FindPlayer(cacheEntry->Guid);
        if (!pPlayer) {
            res = FRIEND_ADDED_OFFLINE;
        }
        else {
            if (!pPlayer->isGMVisible()) {
                goto CHARACTERNOTFOUND;
            }
            if (ses->ActivePlayer()->GetSocial()->AddToSocialList(cacheEntry->Guid, SOCIAL_FLAG_FRIEND)) {
                res = FRIEND_ADDED_ONLINE;
                ses->ActivePlayer()->GetSocial()->SetFriendNote(cacheEntry->Guid, note);
            }
            else
                res = FRIEND_LIST_FULL;
        }
    }
    sSocialMgr->SendFriendStatus(ses->ActivePlayer(),res,ObjectGuid(),false);
    return 0;
}

//===========================================================================
static int FriendListStatusHandler(WorldSession* ses, uint32_t msgId, uint32_t eventTime, WorldPacket* msg)
{
    ses->SendNotification("Hello from %s",__FUNCTION__);
    return 0;
}

//===========================================================================
void FriendList::Initialize()
{
    if (s_initialized) {
        // TODO: handle error
        return;
    }
    WorldSocket::SetMessageHandler(CMSG_ADD_FRIEND, FriendListAddFriendHandler);
}

