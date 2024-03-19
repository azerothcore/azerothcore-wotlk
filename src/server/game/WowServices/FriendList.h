#ifndef _FRIENDLIST_H_
#define _FRIENDLIST_H_

#include <list>

#define NUM_MAX_FRIENDS 50
#define NUM_MAX_IGNORE  50
#define NUM_MAX_MUTE    50

using std::list;


extern void FriendListInitialize ();
extern void FriendListDestroy ();


enum CONTACT_FLAG {
  CONTACT_FRIEND  = 0x1,
  CONTACT_IGNORED = 0x2,
  CONTACT_MUTED   = 0x4,
};

enum FRIEND_STATUS {
  FRIEND_STATUS_OFFLINE = 0x0,
  FRIEND_STATUS_ONLINE  = 0x1,
  FRIEND_STATUS_AFK     = 0x2,
  FRIEND_STATUS_DND     = 0x4,
  FRIEND_STATUS_RAF     = 0x8
};

enum FRIEND_RESULT {
  FRIEND_DB_ERROR         = 0x0,
  FRIEND_LIST_FULL        = 0x1,
  FRIEND_ONLINE           = 0x2,
  FRIEND_OFFLINE          = 0x3,
  FRIEND_NOT_FOUND        = 0x4,
  FRIEND_REMOVED          = 0x5,
  FRIEND_ADDED_ONLINE     = 0x6,
  FRIEND_ADDED_OFFLINE    = 0x7,
  FRIEND_ALREADY          = 0x8,
  FRIEND_SELF             = 0x9,
  FRIEND_ENEMY            = 0xA,
  FRIEND_IGNORE_FULL      = 0xB,
  FRIEND_IGNORE_SELF      = 0xC,
  FRIEND_IGNORE_NOT_FOUND = 0xD,
  FRIEND_IGNORE_ALREADY   = 0xE,
  FRIEND_IGNORE_ADDED     = 0xF,
  FRIEND_IGNORE_REMOVED   = 0x10,
  FRIEND_IGNORE_AMBIGUOUS = 0x11,
  FRIEND_MUTE_FULL        = 0x12,
  FRIEND_MUTE_SELF        = 0x13,
  FRIEND_MUTE_NOT_FOUND   = 0x14,
  FRIEND_MUTE_ALREADY     = 0x15,
  FRIEND_MUTE_ADDED       = 0x16,
  FRIEND_MUTE_REMOVED     = 0x17,
  FRIEND_MUTE_AMBIGUOUS   = 0x18,
  // TODO:
  FRIEND_UNKNOWN_1        = 0x19,
  FRIEND_UNKNOWN_2        = 0x1A,
  FRIEND_UNKNOWN_3        = 0x1B
};


/****************************************************************************
*
*   FriendList class
*
***/

class FriendList {

private:

  struct Friend {
    ObjectGuid  m_GUID    = ObjectGuid();
    char*       m_name    = nullptr;
    char*       m_notes   = nullptr;
    char        m_status  = FRIEND_STATUS_OFFLINE;
    uint32_t    m_flags   = 0u;
    uint32_t    m_areaId  = 0u;
    uint32_t    m_level   = 0u;
    uint32_t    m_classId = 0u;
  };

  list<Friend>  m_friends                 = {};
  ObjectGuid    m_ignore[NUM_MAX_IGNORE]  = {};
  ObjectGuid    m_mute[NUM_MAX_MUTE]      = {};
  Player*       m_playerPtr               = nullptr;

public:

  FriendList (Player* plr);
  ~FriendList ();
  void AddFriend (char* name, char* notes);
  void AddIgnore (ObjectGuid const& guid);
  void AddContacts ();
  void DelIgnore (ObjectGuid const& guid);
  Friend const* GetFriend (ObjectGuid const& guid);
  uint32_t GetNumFriends ();
  uint32_t GetNumIgnores ();
  uint32_t GetNumMutes ();
  bool IsFriend (ObjectGuid const& guid);
  bool IsIgnored (ObjectGuid const& guid);
  void RemoveFriend (ObjectGuid const& guid);
  void SaveContact (ObjectGuid const& guid, uint32_t flags, char const* notes);
  void SendContactList (uint32_t flags);
  void SendFriendStatus (FRIEND_RESULT res, ObjectGuid guid);
  void SetFriendNotes (ObjectGuid const& guid, char const* notes);

};

#endif//_FRIENDLIST_H_
