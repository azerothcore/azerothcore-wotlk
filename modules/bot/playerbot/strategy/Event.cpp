#include "../../pchdef.h"
#include "../playerbot.h"
#include "Event.h"


using namespace BotAI;

uint64 Event::getObject()
{
    if (packet.empty())
        return 0;

    WorldPacket p(packet);
    p.rpos(0);
    
    uint64 guid;
    p >> guid;

    return guid;
}