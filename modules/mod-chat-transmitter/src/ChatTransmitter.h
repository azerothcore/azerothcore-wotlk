#ifndef _MOD_CHAT_TRANSMITTER_H_
#define _MOD_CHAT_TRANSMITTER_H_

#include <thread>

#include "Player.h"
#include "Channel.h"
#include "IRequest.h"
#include "WebSocketClient.h"
#include "DatabaseManager.h"

namespace ModChatTransmitter
{
    struct Command
    {
    public:
        Command(const std::string& id);

        std::string id;
        std::string output;
    };

    class ChatTransmitter
    {
    public:
        static ChatTransmitter& Instance();

        // Config methods
        bool IsEnabled() const;
        std::string GetDiscordGuildId() const;
        std::string GetBotWsHost() const;
        std::string GetBotWsKey() const;
        int GetBotWsPort() const;
        std::string GetElunaDatabaseInfo() const;

        void QueueChat(Player* player, uint32 type, std::string& msg);
        void QueueChat(Player* player, uint32 type, std::string& msg, Channel* channel);
        void Update();
        void Stop();
        void Start();

    protected:
        ChatTransmitter();

        void AddScripts() const;
        void WebSocketThread();
        void DatabaseThread();
        void QueueRequest(IRequest* req);
        void HandleCommand(const std::string& id, const std::string& command);
        void HandleQuery(const std::string& id, const std::string& query, QueryDatabase dbType);

        static void OnCommandOutput(void* arg, std::string_view text);
        static void OnCommandFinished(void* arg, bool success);

        std::thread wsThread;
        WebSocketClient* wsClient;

        std::thread dbThread;
        DatabaseManager* dbManager;
    };
}

#endif // _MOD_CHAT_TRANSMITTER_H_
