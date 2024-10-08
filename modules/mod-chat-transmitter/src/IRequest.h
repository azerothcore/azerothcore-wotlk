#ifndef _MOD_CHAT_TRANSMITTER_I_REQUEST_H_
#define _MOD_CHAT_TRANSMITTER_I_REQUEST_H_

#include <string>

namespace ModChatTransmitter
{
    class IRequest
    {
    public:
        virtual ~IRequest() {}
        virtual std::string GetContents() = 0;
    };
}

#endif // _MOD_CHAT_TRANSMITTER_I_REQUEST_H_
