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
#include "MetricRegistry.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"

#include <boost/asio/io_context.hpp>
#include <boost/asio/ip/address.hpp>
#include <boost/asio/ip/tcp.hpp>
#include <boost/beast/core/flat_buffer.hpp>
#include <boost/beast/core/tcp_stream.hpp>
#include <boost/beast/http.hpp>
#include <chrono>
#include <optional>
#include <ostream>
#include <source_location>
#include <string>
#include <thread>

using namespace Acore::Observability;
using namespace std::chrono_literals;

namespace
{
    namespace beast = boost::beast;
    namespace http = beast::http;
    namespace net = boost::asio;
    using tcp = net::ip::tcp;

    constexpr char LoopbackAddress[] = "127.0.0.1";
    constexpr char PrometheusContentType[] = "text/plain; version=0.0.4; charset=utf-8";
    constexpr char PlainTextContentType[] = "text/plain; charset=utf-8";
    constexpr int StartAttempts = 10;

    struct HttpResponse
    {
        http::status Status;
        std::string ContentType;
        std::string Allow;
        std::string Body;

        bool operator==(HttpResponse const&) const = default;
    };

    void PrintTo(HttpResponse const& response, std::ostream* os)
    {
        *os << "{ Status: " << static_cast<unsigned>(response.Status)
            << ", ContentType: " << testing::PrintToString(response.ContentType)
            << ", Allow: " << testing::PrintToString(response.Allow)
            << ", Body: " << testing::PrintToString(response.Body) << " }";
    }

    uint16 FindFreeLoopbackPort()
    {
        net::io_context ioContext;
        tcp::acceptor acceptor(ioContext, tcp::endpoint(net::ip::make_address(LoopbackAddress), 0));
        return acceptor.local_endpoint().port();
    }

    bool WaitUntil(auto&& predicate, std::chrono::steady_clock::duration timeout = 1s)
    {
        auto const deadline = std::chrono::steady_clock::now() + timeout;

        while (std::chrono::steady_clock::now() < deadline)
        {
            if (predicate())
                return true;

            std::this_thread::sleep_for(10ms);
        }

        return predicate();
    }

    HttpResponse SendRequest(uint16 port, http::verb method, beast::string_view target)
    {
        net::io_context ioContext;
        beast::tcp_stream stream(ioContext);
        stream.expires_after(5s);
        stream.connect(tcp::endpoint(net::ip::make_address(LoopbackAddress), port));

        http::request<http::empty_body> request{ method, target, 11 };
        request.set(http::field::host, LoopbackAddress);
        http::write(stream, request);

        beast::flat_buffer buffer;
        http::response<http::string_body> response;
        http::read(stream, buffer, response);

        boost::system::error_code ignored;
        stream.socket().shutdown(tcp::socket::shutdown_both, ignored);

        return
        {
            response.result(),
            std::string(response[http::field::content_type]),
            std::string(response[http::field::allow]),
            response.body()
        };
    }

    class PrometheusExporterIntegrationTest : public testing::Test
    {
    protected:
        std::optional<uint16> StartExporterOnFreePort()
        {
            for (int i = 0; i < StartAttempts; ++i)
            {
                uint16 port = FindFreeLoopbackPort();
                Exporter.ApplyConfig({ true, LoopbackAddress, port });
                if (WaitUntil([&] { return Exporter.IsRunning(); }))
                    return port;
            }

            return std::nullopt;
        }

        MetricRegistry Registry;
        PrometheusExporter Exporter{ Registry };
    };
}

TEST_F(PrometheusExporterIntegrationTest, ServesMetricsEndpointOverHttp)
{
    Registry.SetConstantLabel("realm", "test");
    Registry.RegisterGauge("ac_world_online_players", "Current number of online players",
        {}, std::source_location::current());

    std::optional<uint16> const port = StartExporterOnFreePort();
    ASSERT_TRUE(port.has_value()) << "Prometheus exporter did not start.";

    HttpResponse const response = SendRequest(*port, http::verb::get, "/metrics");

    EXPECT_THAT(response, testing::Eq(HttpResponse{
        http::status::ok,
        PrometheusContentType,
        "",
        "# HELP ac_world_online_players Current number of online players\n"
        "# TYPE ac_world_online_players gauge\n"
        "ac_world_online_players{realm=\"test\"} 0\n" }));
}

TEST_F(PrometheusExporterIntegrationTest, HandlesHttpMethodAndTargetContract)
{
    std::optional<uint16> const port = StartExporterOnFreePort();
    ASSERT_TRUE(port.has_value()) << "Prometheus exporter did not start.";

    HttpResponse const headResponse = SendRequest(*port, http::verb::head, "/metrics");
    EXPECT_THAT(headResponse, testing::Eq(HttpResponse{
        http::status::ok,
        PrometheusContentType,
        "",
        "" }));

    HttpResponse const missingResponse = SendRequest(*port, http::verb::get, "/not-metrics");
    EXPECT_THAT(missingResponse, testing::Eq(HttpResponse{
        http::status::not_found,
        PlainTextContentType,
        "",
        "Not found\n" }));

    HttpResponse const postResponse = SendRequest(*port, http::verb::post, "/metrics");
    EXPECT_THAT(postResponse, testing::Eq(HttpResponse{
        http::status::method_not_allowed,
        PlainTextContentType,
        "GET, HEAD",
        "Method not allowed\n" }));
}
