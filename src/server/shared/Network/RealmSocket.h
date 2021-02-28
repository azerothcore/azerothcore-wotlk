/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __REALMSOCKET_H__
#define __REALMSOCKET_H__

#include "Common.h"
#include <ace/Message_Block.h>
#include <ace/SOCK_Stream.h>
#include <ace/Svc_Handler.h>
#include <ace/Synch_Traits.h>

class RealmSocket : public ACE_Svc_Handler<ACE_SOCK_STREAM, ACE_NULL_SYNCH>
{
private:
    typedef ACE_Svc_Handler<ACE_SOCK_STREAM, ACE_NULL_SYNCH> Base;

public:
    class Session
    {
    public:
        Session();
        virtual ~Session();

        virtual void OnRead() = 0;
        virtual void OnAccept() = 0;
        virtual void OnClose() = 0;
    };

    RealmSocket();
    ~RealmSocket() override;

    [[nodiscard]] size_t recv_len() const;
    bool recv_soft(char* buf, size_t len);
    bool recv(char* buf, size_t len);
    void recv_skip(size_t len);

    bool send(const char* buf, size_t len);

    [[nodiscard]] const std::string& getRemoteAddress() const;

    [[nodiscard]] uint16 getRemotePort() const;

    int open(void*) override;

    int close(u_long) override;

    int handle_input(ACE_HANDLE = ACE_INVALID_HANDLE) override;
    int handle_output(ACE_HANDLE = ACE_INVALID_HANDLE) override;

    int handle_close(ACE_HANDLE = ACE_INVALID_HANDLE, ACE_Reactor_Mask = ACE_Event_Handler::ALL_EVENTS_MASK) override;

    void set_session(Session* session);

private:
    ssize_t noblk_send(ACE_Message_Block& message_block);

    ACE_Message_Block input_buffer_;
    Session* session_{nullptr};
    std::string _remoteAddress;
    uint16 _remotePort{0};
};

#endif /* __REALMSOCKET_H__ */
