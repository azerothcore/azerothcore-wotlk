#ifndef _FRIENDLIST_H_
#define _FRIENDLIST_H_

class FriendList
{
public:
    struct Friend;

    static void Initialize();

    void AddFriend(char* name, char* notes);
};

struct FriendList::Friend
{

};

#endif//_FRIENDLIST_H_
