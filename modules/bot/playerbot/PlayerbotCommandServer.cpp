#include "../pchdef.h"
#include "playerbot.h"
#include "PlayerbotAIConfig.h"
#include "PlayerbotFactory.h"
#include "PlayerbotCommandServer.h"
#include <cstdlib>
#include <iostream>

#include "ace/Service_Manager.h"

#include "ace/Get_Opt.h"
#include "ace/Log_Category.h"
#include "ace/Service_Repository.h"
#include "ace/Service_Config.h"
#include "ace/Service_Types.h"
#include "ace/Reactor.h"
#include "ace/WFMO_Reactor.h"
#include "ace/OS_NS_stdio.h"
#include "ace/OS_NS_string.h"

using namespace std;

bool ReadLine(ACE_SOCK_Stream& client_stream_, string* buffer, string* line)
{
    // Do the real reading from fd until buffer has '\n'.
    string::iterator pos;
    while ((pos = find(buffer->begin(), buffer->end(), '\n')) == buffer->end())
    {
        char buf[33];
        size_t n = client_stream_.recv_n(buf, 1, 0);
        if (n == -1)
            return false;

        buf[n] = 0;
        *buffer += buf;
    }

    *line = string(buffer->begin(), pos);
    *buffer = string(pos + 1, buffer->end());
    return true;
}

class PlayerbotCommandServerThread: public ACE_Task <ACE_MT_SYNCH>
{
public:
    int svc(void) {
        if (!sPlayerbotAIConfig.commandServerPort) {
            return 0;
        }

        ostringstream s; s << "Starting Playerbot Command Server on port " << sPlayerbotAIConfig.commandServerPort;
        sLog->outString(s.str().c_str());

        ACE_INET_Addr server(sPlayerbotAIConfig.commandServerPort);
        ACE_SOCK_Acceptor client_responder(server);

		while (true) 
		{
			ACE_SOCK_Stream client_stream;
			ACE_Time_Value timeout(5);
			ACE_INET_Addr client;
			if (-1 != client_responder.accept(client_stream, &client, &timeout))
			{
				string buffer, request;
				while (ReadLine(client_stream, &buffer, &request)) 
				{
					string response = sRandomPlayerbotMgr.HandleRemoteCommand(request) + "\n";
					client_stream.send_n(response.c_str(), response.size(), 0);
					request = "";
				}
				client_stream.close();
			}
		}

        return 0;
    }
};


void PlayerbotCommandServer::Start()
{
    PlayerbotCommandServerThread *thread = new PlayerbotCommandServerThread();
    thread->activate();
}
