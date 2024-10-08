#include <thread>
#include <boost/beast/core.hpp>
#include <boost/beast/websocket.hpp>
#include <boost/asio/strand.hpp>

#include "Log.h"
#include "WebSocketClient.h"

namespace ModChatTransmitter
{
    // Resolver and socket require an io_context
    WebSocketClient::WebSocketClient(net::io_context& ioc)
        : resolver(net::make_strand(ioc)),
        ws(net::make_strand(ioc)),
        host(""),
        path(""),
        port(0),
        ready(false),
        close(false),
        writing(false),
        reconnectDelay(5),
        reconnectAttempts(0),
        workQueue(),
        received(),
        hasReceivedData(false)
    { }

    // Start the asynchronous operation
    void WebSocketClient::Run(const std::string& host, int port, const std::string& path)
    {
        ready.store(false);
        this->host = host;
        this->port = port;
        this->path = path;

        Resolve();
    }

    void WebSocketClient::QueueRequest(IRequest* request)
    {
        bool idle = workQueue.Empty();
        workQueue.Push(request);

        if (idle && ready.load())
        {
            net::post(ws->get_executor(), [this]()
                {
                    Write();
                });
        }
    }

    bool WebSocketClient::IsReady()
    {
        return ready.load();
    }

    void WebSocketClient::Resolve()
    {
        resolver.async_resolve(host, std::to_string(port).c_str(), beast::bind_front_handler(&WebSocketClient::OnResolve, this));
    }

    void WebSocketClient::Write()
    {
        if (writing.load())
        {
            return;
        }

        IRequest* request;
        if (!workQueue.Pop(request))
        {
            return;
        }

        writing.store(true);
        writeData = request->GetContents();
        writeBuffer = net::buffer(writeData);
        delete request;
        ws->async_write(writeBuffer, beast::bind_front_handler(&WebSocketClient::OnWrite, this));
    }

    void WebSocketClient::Read()
    {
        ws->async_read(readBuffer, beast::bind_front_handler(&WebSocketClient::OnRead, this));
    }

    bool WebSocketClient::GetReceivedMessage(std::string& data)
    {
        if (!ready.load() || close.load() || !hasReceivedData.load())
        {
            return false;
        }

        if (!received.Pop(data))
        {
            return false;
        }

        if (received.Empty())
        {
            hasReceivedData.store(false);
        }

        return true;
    }

    void WebSocketClient::Close()
    {
        ready.store(false);
        close.store(true);

        websocket::close_reason cr;
        cr.code = 4010;
        cr.reason = "Server closed";
        ws->async_close(cr, beast::bind_front_handler(&WebSocketClient::OnClose, this));
    }

    void WebSocketClient::OnResolve(beast::error_code err, tcp::resolver::results_type results)
    {
        if (err)
        {
            return OnError(err, "resolve");
        }

        // Set the timeout for the operation
        beast::get_lowest_layer(*ws).expires_after(std::chrono::seconds(30));

        // Make the connection on the IP address we get from a lookup
        beast::get_lowest_layer(*ws).async_connect(results, beast::bind_front_handler(&WebSocketClient::OnConnect, this));
    }

    void WebSocketClient::OnConnect(beast::error_code err, tcp::resolver::results_type::endpoint_type ep)
    {
        if (err)
        {
            return OnError(err, "connect");
        }

        // Turn off the timeout on the tcp_stream, because
        // the websocket stream has its own timeout system.
        beast::get_lowest_layer(*ws).expires_never();

        // Set suggested timeout settings for the websocket
        ws->set_option(websocket::stream_base::timeout::suggested(beast::role_type::client));

        // This will provide the value of the
        // Host HTTP header during the WebSocket handshake.
        // See https://tools.ietf.org/html/rfc7230#section-5.4
        std::string handshakeHost = host + ':' + std::to_string(ep.port());

        // Perform the websocket handshake
        ws->async_handshake(handshakeHost, path, beast::bind_front_handler(&WebSocketClient::OnHandshake, this));
    }

    void WebSocketClient::OnHandshake(beast::error_code err)
    {
        if (err)
        {
            return OnError(err, "handshake");
        }

        ready.store(true);
        reconnectDelay = 5;
        reconnectAttempts = 0;
        LOG_INFO("module", "[ModChatTransmitter] Connected to WebSocket server.");

        Read();
        Write();
    }

    void WebSocketClient::OnWrite(beast::error_code err, std::size_t bytes_transferred)
    {
        boost::ignore_unused(bytes_transferred);

        writeData = "";
        writeBuffer = net::buffer(writeData);
        writing.store(false);

        if (err)
        {
            return OnError(err, "write");
        }

        Write();
    }

    void WebSocketClient::OnRead(beast::error_code err, std::size_t bytes_transferred)
    {
        boost::ignore_unused(bytes_transferred);

        if (err)
        {
            return OnError(err, "read");
        }

        std::string data = beast::buffers_to_string(readBuffer.data());
        received.Push(data);
        hasReceivedData.store(true);

        readBuffer.clear();
        Read();
    }

    void WebSocketClient::OnClose(beast::error_code err)
    {
        if (err)
        {
            return OnError(err, "close");
        }
    }

    void WebSocketClient::OnError(beast::error_code err, const char* operation)
    {
        if (!strcmp(operation, "read"))
        {
            websocket::close_reason cr = ws->reason();
            if (cr.code == 4000)
            {
                LOG_ERROR("module", "[ModChatTransmitter] Incorrect WebSocket key!");
                return;
            }
            if (cr.code == 4001)
            {
                LOG_ERROR("module", "[ModChatTransmitter] Access denied to the WebSocket server.");
                return;
            }
        }

        ready.store(false);
        int maxReconnectAttempts = 10;
        if (!close.load())
        {
            LOG_ERROR("module", "[ModChatTransmitter] WebSocket {} error: {}", operation, err.message());

            if (!strcmp(operation, "write"))
            {
                // Don't try to reconnect after a write error, the read error
                // after the disconnect will start the reconnects
                return;
            }

            if (reconnectAttempts + 1 < maxReconnectAttempts)
            {
                LOG_INFO("module", "[ModChatTransmitter] Reconnecting to WebSocket server in {} seconds.", reconnectDelay);
            }
        }

        int timeSlept = 0;
        while (timeSlept < reconnectDelay)
        {
            if (close.load())
            {
                return;
            }
            std::this_thread::sleep_for(std::chrono::seconds(1));
            timeSlept += 1;
        }
        reconnectDelay *= 2;
        ++reconnectAttempts;

        if (reconnectAttempts < maxReconnectAttempts)
        {
            ws.emplace(ws->get_executor()); // Reconstruct the stream
            Resolve();
        }
    }
}
