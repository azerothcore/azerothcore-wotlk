/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __HTTP_MANAGER_H
#define __HTTP_MANAGER_H

#include <regex>

#include "httplib.h"
#include "MPSCQueue.h"

#define HttpCallback std::function<void(int, const std::string&, const httplib::Headers&)>

enum class HttpMethod
{
    Get,
    Head,
    Post,
    Put,
    Patch,
    Delete,
    Options,
};

struct HttpWorkItem
{
public:
    HttpWorkItem(HttpMethod method, const std::string& url, const std::string& body, const std::string &contentType, const httplib::Headers& headers, HttpCallback cb);

    HttpMethod method;
    std::string url;
    std::string body;
    std::string contentType;
    httplib::Headers headers;
    HttpCallback callback;
};

struct HttpResponse
{
public:
    HttpResponse(int statusCode, const std::string& body, const httplib::Headers& headers, HttpCallback cb);

    int statusCode;
    std::string body;
    httplib::Headers headers;
    HttpCallback callback;
};

class HttpManager
{
public:
    void HttpRequest(HttpMethod method, const std::string& url, HttpCallback cb);
    void HttpRequest(HttpMethod method, const std::string& url, const httplib::Headers& headers, HttpCallback cb);
    void HttpRequest(HttpMethod method, const std::string& url, const std::string& body, const std::string& contentType, HttpCallback cb);
    void HttpRequest(HttpMethod method, const std::string& url, const std::string& body, const std::string& contentType, const httplib::Headers& headers, HttpCallback cb);
    void HandleHttpResponses();

    static HttpManager* GetInstance();

private:
    HttpManager();
    ~HttpManager();

    void StartHttpWorker();
    void StopHttpWorker();
    void PushRequest(HttpWorkItem* item);
    void ClearQueues();
    void HttpWorkerThread();
    bool ParseUrl(const std::string& url, std::string& host, std::string& path);
    httplib::Result DoRequest(httplib::Client& client, HttpWorkItem* req, const std::string& path);
    void SetupClient(httplib::Client* client);

    MPSCQueue<HttpWorkItem> workQueue;
    MPSCQueue<HttpResponse> responseQueue;
    std::thread workerThread;
    bool startedWorkerThread;
    std::atomic_bool cancelationToken;
    std::condition_variable condVar;
    std::mutex condVarMutex;
    std::regex parseUrlRegex;
};

#endif // #ifndef __HTTP_MANAGER_H
