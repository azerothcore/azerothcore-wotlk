#ifndef _MOD_CHAT_TRANSMITTER_WEB_SOCKET_CLIENT_H_
#define _MOD_CHAT_TRANSMITTER_WEB_SOCKET_CLIENT_H_

#include <atomic>
#include <optional>

#include <boost/beast/core.hpp>
#include <boost/beast/websocket.hpp>
#include <boost/asio/strand.hpp>

#include "PCQueue.h"
#include "IRequest.h"

namespace beast = boost::beast;
namespace http = beast::http;
namespace websocket = beast::websocket;
namespace net = boost::asio;
using tcp = boost::asio::ip::tcp;

namespace ModChatTransmitter
{
    class WebSocketClient : public std::enable_shared_from_this<WebSocketClient>
    {
    public:
        explicit WebSocketClient(net::io_context& ioc);
        void Run(const std::string& host, int port, const std::string& path);
        void QueueRequest(IRequest* request);
        bool IsReady();
        bool GetReceivedMessage(std::string &data);
        void Close();

    private:
        void Resolve();
        void Write();
        void Read();
        void OnResolve(beast::error_code err, tcp::resolver::results_type results);
        void OnConnect(beast::error_code err, tcp::resolver::results_type::endpoint_type ep);
        void OnHandshake(beast::error_code err);
        void OnWrite(beast::error_code err, std::size_t bytes_transferred);
        void OnRead(beast::error_code err, std::size_t bytes_transferred);
        void OnClose(beast::error_code err);
        void OnError(beast::error_code err, const char* operation);

        tcp::resolver resolver;
        std::optional<websocket::stream<beast::tcp_stream>> ws;
        beast::flat_buffer readBuffer;
        std::string writeData;
        net::mutable_buffer writeBuffer;
        std::string host;
        std::string path;
        int port;
        std::atomic_bool ready;
        std::atomic_bool close;
        std::atomic_bool writing;
        int reconnectDelay;
        int reconnectAttempts;
        ProducerConsumerQueue<IRequest*> workQueue;
        ProducerConsumerQueue<std::string> received;
        std::atomic_bool hasReceivedData;
    };
}

#endif // _MOD_CHAT_TRANSMITTER_WEB_SOCKET_CLIENT_H_
