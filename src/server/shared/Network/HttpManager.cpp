#include <thread>
#include <Logging/Log.h>

#define CPPHTTPLIB_OPENSSL_SUPPORT
#include "HttpManager.h"

HttpManager* HttpManager::instance;

HttpWorkItem::HttpWorkItem(HttpMethod method, const std::string& url, const std::string& body, const std::string& contentType, const httplib::Headers& headers, HttpCallback cb)
    : method(method),
    url(url),
    body(body),
    contentType(contentType),
    headers(headers),
    callback(cb)
{ }

HttpResponse::HttpResponse(int statusCode, const std::string& body, const httplib::Headers& headers, HttpCallback cb)
    : statusCode(statusCode),
    body(body),
    headers(headers),
    callback(cb)
{ }

HttpManager::HttpManager()
    : workQueue(),
    responseQueue(),
    startedWorkerThread(false),
    cancelationToken(false),
    condVar(),
    condVarMutex(),
    parseUrlRegex("^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\\?([^#]*))?(#(.*))?")
{
    HttpManager::instance = this;
    StartHttpWorker();
}

HttpManager::~HttpManager()
{
    StopHttpWorker();
}

void HttpManager::HttpRequest(HttpMethod method, const std::string& url, HttpCallback cb)
{
    httplib::Headers headers;
    PushRequest(new HttpWorkItem(method, url, "", "", headers, cb));
}

void HttpManager::HttpRequest(HttpMethod method, const std::string& url, const httplib::Headers& headers, HttpCallback cb)
{
    PushRequest(new HttpWorkItem(method, url, "", "", headers, cb));
}

void HttpManager::HttpRequest(HttpMethod method, const std::string& url, const std::string& body, const std::string& contentType, HttpCallback cb)
{
    httplib::Headers headers;
    PushRequest(new HttpWorkItem(method, url, body, contentType, headers, cb));
}

void HttpManager::HttpRequest(HttpMethod method, const std::string& url, const std::string& body, const std::string& contentType, const httplib::Headers& headers, HttpCallback cb)
{
    PushRequest(new HttpWorkItem(method, url, body, contentType, headers, cb));
}

void HttpManager::PushRequest(HttpWorkItem* item)
{
    std::unique_lock<std::mutex> lock(condVarMutex);
    workQueue.Enqueue(item);
    condVar.notify_one();
}

void HttpManager::StartHttpWorker()
{
    ClearQueues();

    if (!startedWorkerThread)
    {
        cancelationToken.store(false);
        workerThread = std::thread(&HttpManager::HttpWorkerThread, this);
        startedWorkerThread = true;
    }
}

void HttpManager::ClearQueues()
{
    while (workQueue.Peek())
    {
        HttpWorkItem* item;
        if (workQueue.Dequeue(item))
        {
            delete item;
        }
    }

    while (responseQueue.Peek())
    {
        HttpResponse* item;
        if (responseQueue.Dequeue(item))
        {
            delete item;
        }
    }
}

void HttpManager::StopHttpWorker()
{
    if (!startedWorkerThread)
    {
        return;
    }

    cancelationToken.store(true);
    condVar.notify_one();
    workerThread.join();
    ClearQueues();
    startedWorkerThread = false;
}

HttpManager* HttpManager::GetInstance()
{
    return HttpManager::instance;
}

void HttpManager::HttpWorkerThread()
{
    while (true)
    {
        {
            std::unique_lock<std::mutex> lock(condVarMutex);
            condVar.wait(lock, [&] { return workQueue.Peek() != nullptr || cancelationToken.load(); });
        }

        if (cancelationToken.load())
        {
            break;
        }
        if (!workQueue.Peek())
        {
            continue;
        }

        HttpWorkItem* req;
        workQueue.Dequeue(req);
        if (!req)
        {
            continue;
        }

        try
        {
            std::string host;
            std::string path;

            if (!ParseUrl(req->url, host, path))
            {
                LOG_ERROR("server", "[HttpManager] Could not parse URL %s", req->url.c_str());
                continue;
            }

            httplib::Client cli(host);
            SetupClient(&cli);

            httplib::Result res = DoRequest(cli, req, path);
            httplib::Error err = res.error();
            if (err != httplib::Error::Success)
            {
                LOG_ERROR("server", "[HttpManager] HTTP request error: %s", httplib::to_string(err).c_str());
                continue;
            }

            if (res->status == 301)
            {
                std::string location = res->get_header_value("Location");
                std::string host;
                std::string path;

                if (!ParseUrl(location, host, path))
                {
                    LOG_ERROR("server", "[HttpManager] Could not parse URL after redirect: %s", location.c_str());
                    continue;
                }
                httplib::Client cli2(host);
                SetupClient(&cli2);
                res = DoRequest(cli2, req, path);
            }

            responseQueue.Enqueue(new HttpResponse(res->status, res->body, res->headers, req->callback));
        }
        catch (const std::exception& ex)
        {
            LOG_ERROR("server", "[HttpManager] HTTP request error: %s", ex.what());
        }

        delete req;
    }
}

httplib::Result HttpManager::DoRequest(httplib::Client& client, HttpWorkItem* req, const std::string& urlPath)
{
    const char* path = urlPath.c_str();
    switch (req->method)
    {
    case HttpMethod::Get:
        return client.Get(path, req->headers);
    case HttpMethod::Head:
        return client.Head(path, req->headers);
    case HttpMethod::Post:
        return client.Post(path, req->headers, req->body, req->contentType.c_str());
    case HttpMethod::Put:
        return client.Put(path, req->headers, req->body, req->contentType.c_str());
    case HttpMethod::Patch:
        return client.Patch(path, req->headers, req->body, req->contentType.c_str());
    case HttpMethod::Delete:
        return client.Delete(path, req->headers);
    case HttpMethod::Options:
        return client.Options(path, req->headers);
    default:
        LOG_ERROR("server", "[HttpManager] HTTP request error: invalid HTTP method %d", req->method);
        break;
    }

    return client.Get(path, req->headers);
}

void HttpManager::SetupClient(httplib::Client* client)
{
    if (client == nullptr)
    {
        return;
    }

    client->set_connection_timeout(0, 5000000); // 5 seconds
    client->set_read_timeout(5, 0); // 5 seconds
    client->set_write_timeout(5, 0); // 5 seconds
}

bool HttpManager::ParseUrl(const std::string& url, std::string& host, std::string& path)
{
    std::smatch matches;

    if (!std::regex_search(url, matches, parseUrlRegex))
    {
        return false;
    }

    std::string scheme = matches[2];
    std::string authority = matches[4];
    std::string query = matches[7];
    host = scheme + "://" + authority;
    path = matches[5];
    if (path.empty())
    {
        path = "/";
    }
    path += (query.empty() ? "" : "?") + query;

    return true;
}

void HttpManager::HandleHttpResponses()
{
    while (responseQueue.Peek())
    {
        HttpResponse* res;
        responseQueue.Dequeue(res);

        if (res == nullptr)
        {
            continue;
        }

        res->callback(res->statusCode, res->body, res->headers);
        delete res;
    }
}
