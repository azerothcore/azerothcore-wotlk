/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "PrometheusExporter.h"
#include "Log.h"
#include "MetricRegistry.h"
#include "PrometheusTextFormat.h"
#include <atomic>
#include <boost/asio/executor_work_guard.hpp>
#include <boost/asio/io_context.hpp>
#include <boost/asio/ip/address.hpp>
#include <boost/asio/ip/tcp.hpp>
#include <boost/asio/post.hpp>
#include <boost/asio/strand.hpp>
#include <boost/beast/core/bind_handler.hpp>
#include <boost/beast/core/flat_buffer.hpp>
#include <boost/beast/core/tcp_stream.hpp>
#include <boost/beast/http.hpp>
#include <exception>
#include <memory>
#include <optional>
#include <stop_token>
#include <thread>
#include <utility>

namespace Acore::Observability
{
    namespace
    {
        namespace beast = boost::beast;
        namespace http = beast::http;
        namespace net = boost::asio;
        using tcp = net::ip::tcp;

        bool IsMetricsTarget(beast::string_view target)
        {
            return target == "/metrics"
                || target.starts_with("/metrics?");
        }

        bool IsClientDisconnect(boost::system::error_code const& error)
        {
            return error == http::error::end_of_stream
                || error == net::error::operation_aborted
                || error == net::error::connection_reset
                || error == net::error::eof;
        }
    }

    class PrometheusExporter::Impl : public std::enable_shared_from_this<PrometheusExporter::Impl>
    {
    public:
        explicit Impl(MetricRegistry& registry)
            : _ioContext(1),
              _workGuard(net::make_work_guard(_ioContext)),
              _strand(net::make_strand(_ioContext)),
              _acceptor(_strand),
              _registry(registry)
        {
            _thread = std::jthread([this](std::stop_token stopToken)
            {
                std::stop_callback onStop(stopToken, [this]
                {
                    net::post(_strand, [this] { StopOnStrand(); });
                    _workGuard.reset();
                });

                try
                {
                    _ioContext.run();
                }
                catch (std::exception const& e)
                {
                    LOG_ERROR("observability", "Prometheus metrics exporter thread terminated: {}", e.what());
                }
            });
        }

        void Shutdown()
        {
            // Explicit join (rather than relying on ~jthread) ensures the io thread is
            // drained before the last shared_ptr<Impl> ref can be released by a handler
            // running on it — otherwise ~Impl could run on the io thread and ~jthread
            // would self-join.
            _thread.request_stop();
            _thread.join();
        }

        void ApplyConfig(PrometheusEndpointConfig config)
        {
            net::post(_strand, [self = shared_from_this(), config = std::move(config)]() mutable
            {
                self->ApplyConfigOnStrand(std::move(config));
            });
        }

        void Stop()
        {
            net::post(_strand, [self = shared_from_this()]
            {
                self->StopOnStrand();
            });
        }

        bool IsRunning() const
        {
            return _running.load(std::memory_order_relaxed);
        }

        std::string RenderMetrics() const
        {
            return PrometheusTextFormat::Serialize(_registry);
        }

    private:
        class Session : public std::enable_shared_from_this<Session>
        {
        public:
            Session(tcp::socket&& socket, std::shared_ptr<Impl> exporter)
                : _stream(std::move(socket)), _exporter(std::move(exporter))
            {
            }

            void Start()
            {
                _stream.expires_after(std::chrono::seconds(30));
                http::async_read(_stream, _buffer, _request, beast::bind_front_handler(&Session::OnRead, shared_from_this()));
            }

        private:
            void OnRead(boost::system::error_code error, std::size_t)
            {
                if (error)
                {
                    if (!IsClientDisconnect(error))
                        LOG_ERROR("observability", "Prometheus metrics request read failed: {}", error.message());

                    return;
                }

                HandleRequest();
            }

            void HandleRequest()
            {
                http::response<http::string_body> response;
                response.version(_request.version());
                response.keep_alive(false);
                response.set(http::field::server, "AzerothCore");

                if (!IsMetricsTarget(_request.target()))
                {
                    response.result(http::status::not_found);
                    response.set(http::field::content_type, "text/plain; charset=utf-8");
                    response.body() = "Not found\n";
                }
                else if (_request.method() != http::verb::get && _request.method() != http::verb::head)
                {
                    response.result(http::status::method_not_allowed);
                    response.set(http::field::allow, "GET, HEAD");
                    response.set(http::field::content_type, "text/plain; charset=utf-8");
                    response.body() = "Method not allowed\n";
                }
                else
                {
                    response.result(http::status::ok);
                    response.set(http::field::content_type, "text/plain; version=0.0.4; charset=utf-8");

                    if (_request.method() == http::verb::get)
                        response.body() = _exporter->RenderMetrics();
                }

                response.prepare_payload();

                _response.emplace(std::move(response));
                http::async_write(_stream, *_response, beast::bind_front_handler(&Session::OnWrite, shared_from_this()));
            }

            void OnWrite(boost::system::error_code error, std::size_t)
            {
                _response.reset();

                if (error && !IsClientDisconnect(error))
                    LOG_ERROR("observability", "Prometheus metrics response write failed: {}", error.message());

                boost::system::error_code shutdownError;
                _stream.socket().shutdown(tcp::socket::shutdown_send, shutdownError);
            }

            beast::tcp_stream _stream;
            beast::flat_buffer _buffer;
            http::request<http::string_body> _request;
            std::optional<http::response<http::string_body>> _response;
            std::shared_ptr<Impl> _exporter;
        };

        void ApplyConfigOnStrand(PrometheusEndpointConfig config)
        {
            if (_running.load(std::memory_order_relaxed) && _config == config)
                return;

            StopOnStrand();
            _config = std::move(config);

            if (!_config.Enabled)
                return;

            StartOnStrand();
        }

        void StartOnStrand()
        {
            boost::system::error_code error;
            net::ip::address bindAddress = net::ip::make_address(_config.BindAddress, error);
            if (error)
            {
                LOG_ERROR("observability", "Prometheus metrics exporter failed to parse bind address '{}': {}", _config.BindAddress, error.message());
                return;
            }

            tcp::endpoint endpoint(bindAddress, _config.Port);
            _acceptor.open(endpoint.protocol(), error);
            if (error)
            {
                LOG_ERROR("observability", "Prometheus metrics exporter failed to open socket on {}:{}: {}", endpoint.address().to_string(), endpoint.port(), error.message());
                return;
            }

            _acceptor.set_option(tcp::acceptor::reuse_address(true), error);
            if (error)
            {
                LOG_ERROR("observability", "Prometheus metrics exporter failed to set reuse_address on {}:{}: {}", endpoint.address().to_string(), endpoint.port(), error.message());
                CloseAcceptorOnStrand();
                return;
            }

            _acceptor.bind(endpoint, error);
            if (error)
            {
                LOG_ERROR("observability", "Prometheus metrics exporter failed to bind {}:{}: {}", endpoint.address().to_string(), endpoint.port(), error.message());
                CloseAcceptorOnStrand();
                return;
            }

            _acceptor.listen(tcp::acceptor::max_listen_connections, error);
            if (error)
            {
                LOG_ERROR("observability", "Prometheus metrics exporter failed to listen on {}:{}: {}", endpoint.address().to_string(), endpoint.port(), error.message());
                CloseAcceptorOnStrand();
                return;
            }

            _running.store(true, std::memory_order_relaxed);
            LOG_INFO("observability", "Prometheus metrics exporter listening on http://{}:{}/metrics.", endpoint.address().to_string(), endpoint.port());
            DoAccept();
        }

        void DoAccept()
        {
            if (!_running.load(std::memory_order_relaxed))
                return;

            _acceptor.async_accept([self = shared_from_this()](boost::system::error_code error, tcp::socket socket)
            {
                self->OnAccept(error, std::move(socket));
            });
        }

        void OnAccept(boost::system::error_code error, tcp::socket socket)
        {
            if (!_running.load(std::memory_order_relaxed))
                return;

            if (error)
            {
                if (error != net::error::operation_aborted)
                    LOG_ERROR("observability", "Prometheus metrics exporter accept failed: {}", error.message());

                DoAccept();
                return;
            }

            std::make_shared<Session>(std::move(socket), shared_from_this())->Start();
            DoAccept();
        }

        void StopOnStrand()
        {
            if (!_running.exchange(false, std::memory_order_relaxed) && !_acceptor.is_open())
                return;

            CloseAcceptorOnStrand();
            LOG_INFO("observability", "Prometheus metrics exporter stopped.");
        }

        void CloseAcceptorOnStrand()
        {
            boost::system::error_code ignored;
            _acceptor.cancel(ignored);
            _acceptor.close(ignored);
        }

        net::io_context _ioContext;
        net::executor_work_guard<net::io_context::executor_type> _workGuard;
        net::strand<net::io_context::executor_type> _strand;
        tcp::acceptor _acceptor;
        MetricRegistry& _registry;
        PrometheusEndpointConfig _config;
        std::atomic<bool> _running{ false };
        std::jthread _thread;
    };

    PrometheusExporter::PrometheusExporter(MetricRegistry& registry)
        : _impl(std::make_shared<Impl>(registry))
    {
    }

    PrometheusExporter::~PrometheusExporter()
    {
        if (_impl)
            _impl->Shutdown();
    }

    void PrometheusExporter::ApplyConfig(PrometheusEndpointConfig config)
    {
        _impl->ApplyConfig(std::move(config));
    }

    void PrometheusExporter::Stop()
    {
        if (_impl)
            _impl->Stop();
    }

    bool PrometheusExporter::IsRunning() const
    {
        return _impl && _impl->IsRunning();
    }

    std::string PrometheusExporter::RenderMetrics() const
    {
        return _impl ? _impl->RenderMetrics() : std::string();
    }
}
