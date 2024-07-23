#include "FriendList.h"

#include "CharacterCache.h"
#include "Language.h"
#include "Opcodes.h"
#include "Player.h"
#include "WorldSocket.h"

#include <map>

#define MAX_NAME_SIZE   305
#define MAX_NOTES_SIZE  512

typedef std::map<WOWGUID, FriendList*> FRIENDLISTMAP_T;


static BOOL AddFriendHandler (User*         user,
                              Opcodes       msgId,
                              uint32_t      eventTime,
                              WorldPacket*  msg);
static BOOL AddIgnoreHandler (User*         user,
                              Opcodes       msgId,
                              uint32_t      eventTime,
                              WorldPacket*  msg);
static BOOL ContactListHandler (User*         user,
                                Opcodes       msgId,
                                uint32_t      eventTime,
                                WorldPacket*  msg);
static BOOL DeleteFriendHandler (User*        user,
                                 Opcodes      msgId,
                                 uint32_t     eventTime,
                                 WorldPacket* msg);
static BOOL DelIgnoreHandler (User*         user,
                              Opcodes       msgId,
                              uint32_t      eventTime,
                              WorldPacket*  msg);
static BOOL SetFriendNotesHandler (User*        user,
                                   Opcodes      msgId,
                                   uint32_t     eventTime,
                                   WorldPacket* msg);
static BOOL WhoIsHandler (User*         user,
                          Opcodes       msgId,
                          uint32_t      eventTime,
                          WorldPacket*  msg);


/****************************************************************************
*
*   FriendList Class Implementation
*
***/

static FRIENDLISTMAP_T  s_friendListMap;
static bool             s_initialized;

//===========================================================================
FriendList::FriendList (Player* plr) {
  ASSERT(plr);

  m_playerPtr = plr;
  WOWGUID guid = plr->GetGUID();

  s_friendListMap[guid] = this;

  AddContacts();

  // Send a friend status packet
  // to all users that have this player on their friends list
  for (auto it = s_friendListMap.begin(); it != s_friendListMap.end(); it++) {
    if (it->second != this && it->second->GetFriend(guid)) {
      WorldPacket msg(SMSG_FRIEND_STATUS);
      msg << (unsigned char)FRIEND_ONLINE;
      msg << guid;
      msg << (unsigned char)FRIEND_STATUS_ONLINE;
      msg << plr->GetAreaId();
      msg << (uint32_t)plr->GetLevel();
      msg << (uint32_t)plr->getClass();
      it->second->m_playerPtr->User()->Send(&msg);
    }
  }
}

//===========================================================================
FriendList::~FriendList () {
  for (auto pFriend = m_friends.begin(); pFriend != m_friends.end(); pFriend++) {
    // Save each contact to the database
    SaveContact(pFriend->m_GUID, CONTACT_FRIEND, pFriend->m_notes);

    // Notify every user with this character on their friends list
    // that it is going offline
    if (s_friendListMap.contains(pFriend->m_GUID)) {
      FriendList* friendList = s_friendListMap.at(pFriend->m_GUID);
      if (friendList->GetFriend(m_playerPtr->GetGUID())) {
        friendList->SendFriendStatus(FRIEND_OFFLINE, m_playerPtr->GetGUID());
      }
    }

    if (pFriend->m_name)
      FREE(pFriend->m_name);
    if (pFriend->m_notes)
      FREE(pFriend->m_notes);
  }
  for (uint32_t i = 0; i < GetNumIgnores(); i++) {
    SaveContact(m_ignore[i], CONTACT_IGNORED, "");
  }
  for (uint32_t i = 0; i < GetNumMutes(); i++) {
    SaveContact(m_mute[i], CONTACT_MUTED, "");
  }

  // Remove this FriendList object reference from the hash table
  s_friendListMap.erase(m_playerPtr->GetGUID());
}

//===========================================================================
void FriendList::AddFriend (char* name, char* notes) {
  ASSERT(name);

  FormatCharacterName(name);

  WOWGUID guid = WOWGUID();
  FRIEND_RESULT res = FRIEND_NOT_FOUND;

  auto charInfo = sCharacterCache->GetCharacterCacheByName(name);
  if (!charInfo) {
    SendFriendStatus(res, guid);
    return;
  }

  guid = charInfo->Guid;

  if (guid == m_playerPtr->GetGUID()) {
    res = FRIEND_SELF;
  }
  else if (m_playerPtr->GetTeamId() != Player::TeamIdForRace(charInfo->Race)) {
    res = FRIEND_ENEMY;
  }
  else if (GetFriend(guid)) {
    res = FRIEND_ALREADY;
  }
  else if (GetNumFriends() < NUM_MAX_FRIENDS) {
    Friend frnd;
    frnd.m_flags = CONTACT_FRIEND;
    frnd.m_GUID = guid;

    frnd.m_name = (char*)malloc(strlen(name) + 1);
    strcpy(frnd.m_name, name);

    if (notes) {
      frnd.m_notes = (char*)malloc(strlen(notes) + 1);
      strcpy(frnd.m_notes, notes);
    }

    Player* plr = ObjectAccessor::FindPlayer(guid);
    if (!plr) {
      res = FRIEND_ADDED_OFFLINE;
    }
    else {
      res = FRIEND_ADDED_ONLINE;

      frnd.m_status = FRIEND_STATUS_ONLINE;
      if (plr->isAFK()) {
        frnd.m_status = FRIEND_STATUS_AFK;
      }
      if (plr->isDND()) {
        frnd.m_status = FRIEND_STATUS_DND;
      }

      frnd.m_areaId = plr->GetAreaId();
      frnd.m_level = plr->GetLevel();
      frnd.m_classId = plr->getClass();
    }

    // Save the new contact to the database
    SaveContact(guid, frnd.m_flags, frnd.m_notes);

    m_friends.push_back(frnd);
  }
  else {
    res = FRIEND_LIST_FULL;
  }

  SendFriendStatus(res, guid);
}

//===========================================================================
void FriendList::AddIgnore (WOWGUID const& guid) {
  FRIEND_RESULT res = FRIEND_IGNORE_FULL;
  for (uint32_t i = 0; i < NUM_MAX_IGNORE; i++) {
    if (m_ignore[i]) {
      continue;
    }
    else {
      if (m_ignore[i] == guid) {
        res = FRIEND_IGNORE_ALREADY;
      }
      else if (m_ignore[i] == m_playerPtr->GetGUID()) {
        res = FRIEND_IGNORE_SELF;
      }
      else {
        res = FRIEND_IGNORE_ADDED;
        m_ignore[i] = guid;
      }
      break;
    }
  }
  CharacterDatabase.Execute("INSERT INTO character_social (guid, friend, flags) "
                            "VALUES ({}, {}, {})",
                            m_playerPtr->GetGUID().GetCounter(), guid.GetCounter(), CONTACT_IGNORED);

  SendFriendStatus(res, guid);
}

//===========================================================================
void FriendList::AddContacts () {
  ASSERT(m_playerPtr);

  auto results = CharacterDatabase.Query("SELECT friend, flags, note "
                                         "FROM character_social "
                                         "WHERE guid = '{}' "
                                         "ORDER BY flags",
                                         m_playerPtr->GetGUID().GetCounter());
  if (!results) {
    return;
  }

  Field* fields = results->Fetch();
  uint32_t numRows = results->GetRowCount();

  // Initialize indexes
  uint32_t iFriends = 0;
  uint32_t iIgnore = 0;
  uint32_t iMute = 0;

  WorldPacket msg(SMSG_CONTACT_LIST);
  msg << uint32_t(CONTACT_FRIEND | CONTACT_IGNORED | CONTACT_MUTED);
  msg << numRows; // Total number of contacts

  // Add each contact to the user's friends list
  // and send a contact list packet to the active player
  for (uint32_t i = 0; i < numRows; i++) {
    WOWGUID guid = WOWGUID(HighGuid::Player, fields[0].Get<uint32_t>());
    uint32_t flags = fields[1].Get<uint8_t>();

    msg << guid;
    msg << flags;

    if (flags & CONTACT_FRIEND && iFriends < NUM_MAX_FRIENDS) {
      Friend frnd;
      frnd.m_GUID = guid;
      frnd.m_flags = flags;

      std::string notes = fields[2].Get<std::string>();
      frnd.m_notes = (char*)malloc(notes.length() + 1);
      strcpy(frnd.m_notes, notes.c_str());

      msg << frnd.m_notes;

      Player* plr = ObjectAccessor::FindConnectedPlayer(guid);
      if (plr) {
        frnd.m_status = FRIEND_STATUS_ONLINE;

        char const* name = plr->GetName().c_str();
        frnd.m_name = (char*)malloc(strlen(name) + 1);
        strcpy(frnd.m_name, name);

        if (plr->isAFK()) {
          frnd.m_status = FRIEND_STATUS_AFK;
        }
        if (plr->isDND()) {
          frnd.m_status = FRIEND_STATUS_DND;
        }

        frnd.m_areaId = plr->GetAreaId();
        frnd.m_level = plr->GetLevel();
        frnd.m_classId = plr->getClass();
      }

      msg << (unsigned char)frnd.m_status;
      if (frnd.m_status != FRIEND_STATUS_OFFLINE) {
        msg << frnd.m_areaId;
        msg << frnd.m_level;
        msg << frnd.m_classId;
      }

      m_friends.push_back(frnd);
      iFriends++;
    }
    else if (flags & CONTACT_IGNORED && iIgnore < NUM_MAX_IGNORE) {
      m_ignore[iIgnore++] = guid;
    }
    else if (flags & CONTACT_MUTED && iMute < NUM_MAX_MUTE) {
      m_mute[iMute++] = guid;
    }

    results->NextRow();
  }

  m_playerPtr->User()->Send(&msg);
}

//===========================================================================
void FriendList::DelIgnore (WOWGUID const& guid) {
  FRIEND_RESULT res = FRIEND_IGNORE_NOT_FOUND;
  for (uint32_t i = 0; i < GetNumIgnores(); i++) {
    if (m_ignore[i] == guid) {
      res = FRIEND_IGNORE_REMOVED;
      m_ignore[i] = WOWGUID();
      break;
    }
  }
  CharacterDatabase.Execute("DELETE FROM character_social "
                            "WHERE guid = {} AND friend = {}",
                            m_playerPtr->GetGUID().GetCounter(), guid.GetCounter());
  SendFriendStatus(res, guid);
}

//===========================================================================
FriendList::Friend const* FriendList::GetFriend (WOWGUID const& guid) {
  for (auto i = m_friends.begin(); i != m_friends.end(); i++) {
    if (i->m_GUID == guid) {
      return &*i;
    }
  }
  return nullptr;
}

//===========================================================================
uint32_t FriendList::GetNumFriends () {
  return static_cast<uint32_t>(m_friends.size());
}

//===========================================================================
uint32_t FriendList::GetNumIgnores () {
  uint32_t result = 0;
  do
  {
    if (!m_ignore[result]) {
      break;
    }
    ++result;
  } while (result < NUM_MAX_IGNORE);
  return result;
}

//===========================================================================
uint32_t FriendList::GetNumMutes () {
  uint32_t result = 0;
  do
  {
    if (!m_mute[result]) {
      break;
    }
    ++result;
  } while (result < NUM_MAX_MUTE);
  return result;
}

//===========================================================================
bool FriendList::IsFriend (WOWGUID const& guid) { return GetFriend(guid); }

//===========================================================================
bool FriendList::IsIgnored (WOWGUID const& guid) {
  for (uint32_t i = 0; i < GetNumIgnores(); i++) {
    if (m_ignore[i] == guid) {
      return true;
    }
  }
  return false;
}

//===========================================================================
void FriendList::RemoveFriend (WOWGUID const& guid) {
  for (auto pFriend = m_friends.begin(); pFriend != m_friends.end(); pFriend++) {
    if (pFriend->m_GUID == guid) {
      CharacterDatabase.Execute("DELETE FROM character_social "
                                "WHERE friend = {} AND guid = {}",
                                guid.GetCounter(), m_playerPtr->GetGUID().GetCounter());
      m_friends.erase(pFriend);

      SendFriendStatus(FRIEND_REMOVED, guid);
      return;
    }
  }

  SendFriendStatus(FRIEND_NOT_FOUND, WOWGUID());
}

//===========================================================================
void FriendList::SaveContact (WOWGUID const& guid, uint32_t flags, const char* notes) {
  uint32_t loFriend = guid.GetCounter();
  uint32_t loGuid = m_playerPtr->GetGUID().GetCounter();

  CharacterDatabase.Execute("REPLACE INTO character_social "
                            "(guid, friend, flags, note) "
                            "VALUES ({}, {}, {}, '{}')",
                            loGuid, loFriend, flags, notes ? notes : "");
}

//===========================================================================
void FriendList::SendContactList (uint32_t flags) {
  WorldPacket msg(SMSG_CONTACT_LIST);
  msg << flags;

  uint32_t iFriend = GetNumFriends();
  uint32_t iIgnore = GetNumIgnores();
  uint32_t iMute = GetNumMutes();

  msg << iFriend + iIgnore + iMute;   // Total number of contacts

  for (auto pFriend = m_friends.begin(); pFriend != m_friends.end(); pFriend++) {
    msg << pFriend->m_GUID;
    msg << pFriend->m_flags;
    msg << pFriend->m_notes;

    Player* plr = ObjectAccessor::FindConnectedPlayer(pFriend->m_GUID);
    if (plr && plr->isGMVisible()) {
      pFriend->m_status = FRIEND_STATUS_ONLINE;
      pFriend->m_areaId = plr->GetAreaId();
      pFriend->m_level = plr->GetLevel();
      pFriend->m_classId = plr->getClass();
      if (plr->isAFK()) {
        pFriend->m_status = FRIEND_STATUS_AFK;
      }
      if (plr->isDND()) {
        pFriend->m_status = FRIEND_STATUS_DND;
      }
    }
    else {
      pFriend->m_status = FRIEND_STATUS_OFFLINE;
    }

    msg << (unsigned char)pFriend->m_status;

    // Send additional data if the character is online
    if (pFriend->m_status != FRIEND_STATUS_OFFLINE) {
      msg << pFriend->m_areaId;
      msg << pFriend->m_level;
      msg << pFriend->m_classId;
    }
  }
  for (uint32_t i = 0; i < iIgnore; i++) {
    msg << m_ignore[i];
    msg << CONTACT_IGNORED;
  }
  for (uint32_t i = 0; i < iMute; i++) {
    msg << m_mute[i];
    msg << CONTACT_MUTED;
  }

  m_playerPtr->User()->Send(&msg);
}

//===========================================================================
void FriendList::SendFriendStatus (FRIEND_RESULT res, WOWGUID guid) {
  WorldPacket msg(SMSG_FRIEND_STATUS);
  msg << (unsigned char)res;
  msg << guid;

  Friend const* frnd = GetFriend(guid);
  if (frnd) {
    if (res == FRIEND_ADDED_ONLINE || res == FRIEND_ADDED_OFFLINE) {
      msg << frnd->m_notes;
    }
    if (res == FRIEND_ONLINE || res == FRIEND_ADDED_ONLINE) {
      msg << (unsigned char)frnd->m_status;
      msg << frnd->m_areaId;
      msg << frnd->m_level;
      msg << frnd->m_classId;
    }
  }

  m_playerPtr->User()->Send(&msg);
}

//===========================================================================
void FriendList::SetFriendNotes (WOWGUID const& guid, char const* notes) {
  for (auto pFriend = m_friends.begin(); pFriend != m_friends.end(); pFriend++) {
    if (pFriend->m_GUID == guid) {
      if (notes && *notes) {
        pFriend->m_notes = (char*)realloc(pFriend->m_notes, strlen(notes) + 1);
        strcpy(pFriend->m_notes, notes);
      }
      else {
        *pFriend->m_notes = '\0';
      }

      CharacterDatabase.Execute("UPDATE character_social "
                                "SET note = '{}' "
                                "WHERE friend = {} AND guid = {}",
                                pFriend->m_notes, pFriend->m_GUID.GetCounter(), m_playerPtr->GetGUID().GetCounter());
      return;
    }
  }
}


/****************************************************************************
*
*   NETMESSAGE HANDLERS
*
***/

//===========================================================================
static BOOL AddFriendHandler (User*         user,
                              Opcodes       msgId,
                              uint32_t      eventTime,
                              WorldPacket*  msg) {

  Player* plr = user->ActivePlayer();
  if (!plr) {
    return FALSE;
  }

  // Read the message data
  char name[MAX_NAME_SIZE];
  msg->GetString(name, sizeof(name));

  char notes[MAX_NOTES_SIZE];
  msg->GetString(notes, sizeof(notes));

  plr->FriendListPtr()->AddFriend(name, notes);
  return TRUE;
}

//===========================================================================
static BOOL AddIgnoreHandler (User*         user,
                              Opcodes       msgId,
                              uint32_t      eventTime,
                              WorldPacket*  msg) {

  FriendList* friendList = user->ActivePlayer()->FriendListPtr();

  // Read the message data
  char name[256];
  msg->GetString(name, sizeof(name));

  FormatCharacterName(name);

  auto charInfo = sCharacterCache->GetCharacterCacheByName(name);
  if (charInfo) {
    friendList->AddIgnore(charInfo->Guid);
  }
  else {
    friendList->SendFriendStatus(FRIEND_IGNORE_NOT_FOUND, WOWGUID());
  }

  return TRUE;
}

//===========================================================================
static BOOL ContactListHandler (User*         user,
                                Opcodes       msgId,
                                uint32_t      eventTime,
                                WorldPacket*  msg) {

  Player* plr = user->ActivePlayer();
  if (!plr) {
    return FALSE;
  }

  // Read the message data
  auto flags = msg->read<uint32_t>();

  plr->FriendListPtr()->SendContactList(flags);
  return TRUE;
}

//===========================================================================
static BOOL DeleteFriendHandler (User*        user,
                                 Opcodes      msgId,
                                 uint32_t     eventTime,
                                 WorldPacket* msg) {

  Player* plr = user->ActivePlayer();
  if (!plr) {
    return FALSE;
  }

  // Read the message data
  auto guid = msg->read<WOWGUID>();

  FriendList* friendList = plr->FriendListPtr();
  if (friendList->GetFriend(guid)) {
    friendList->RemoveFriend(guid);
  }
  else {
    friendList->SendFriendStatus(FRIEND_DB_ERROR, guid);
  }

  return TRUE;
}

//===========================================================================
static BOOL DelIgnoreHandler (User*         user,
                              Opcodes       msgId,
                              uint32_t      eventTime,
                              WorldPacket*  msg) {

  Player* plr = user->ActivePlayer();
  if (!plr) {
    return FALSE;
  }

  // Read the message data
  auto guid = msg->read<WOWGUID>();

  plr->FriendListPtr()->DelIgnore(guid);

  return TRUE;
}

//===========================================================================
static BOOL SetFriendNotesHandler (User*        user,
                                   Opcodes      msgId,
                                   uint32_t     eventTime,
                                   WorldPacket* msg) {

  Player* plr = user->ActivePlayer();
  if (!plr) {
    return FALSE;
  }

  // Read the message data
  auto guid = msg->read<WOWGUID>();

  char notes[MAX_NOTES_SIZE];
  msg->GetString(notes, sizeof(notes));

  FriendList* friendList = plr->FriendListPtr();
  if (friendList->GetFriend(guid)) {
    friendList->SetFriendNotes(guid, notes);
  }
  else {
    friendList->SendFriendStatus(FRIEND_DB_ERROR, guid);
  }

  return TRUE;
}

//===========================================================================
static BOOL WhoIsHandler (User*         user,
                          Opcodes       msgId,
                          uint32_t      eventTime,
                          WorldPacket*  msg) {

  if (!user->IsGMAccount()) {
    user->SendNotification(LANG_PERMISSION_DENIED);
    return FALSE;
  }

  // Read the message data
  char name[256];
  msg->GetString(name, -1);

  FormatCharacterName(name);

  char szResponse[256] = "Character not found"; // Failure case response

  // Find a Player object in the world that matches the name provided
  // and copy its account name to the response buffer
  Player* playerPtr = ObjectAccessor::FindPlayerByName(name);
  if (playerPtr) {
    strcpy(szResponse, playerPtr->User()->GetAccountName());
  }

  // Send the response
  WorldPacket outbound(SMSG_WHOIS, strlen(szResponse) + 1);
  outbound << szResponse;
  user->Send(&outbound);

  return TRUE;
}


/****************************************************************************
*
*   Public Functions
*
***/

//===========================================================================
void FriendListInitialize () {
  if (s_initialized) {
    return;
  }

  WorldSocket::SetMessageHandler(CMSG_WHOIS, WhoIsHandler);
  WorldSocket::SetMessageHandler(CMSG_CONTACT_LIST, ContactListHandler);
  WorldSocket::SetMessageHandler(CMSG_ADD_FRIEND, AddFriendHandler);
  WorldSocket::SetMessageHandler(CMSG_DEL_FRIEND, DeleteFriendHandler);
  WorldSocket::SetMessageHandler(CMSG_SET_CONTACT_NOTES, SetFriendNotesHandler);
  WorldSocket::SetMessageHandler(CMSG_ADD_IGNORE, AddIgnoreHandler);
  WorldSocket::SetMessageHandler(CMSG_DEL_IGNORE, DelIgnoreHandler);

  s_initialized = true;
}

//===========================================================================
void FriendListDestroy () {
  if (!s_initialized) {
    return;
  }

  for (auto i = s_friendListMap.begin(); i != s_friendListMap.end(); i++) {
    s_friendListMap.erase(i);
  }

  s_initialized = false;
}
