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
    HttpManager();
    ~HttpManager();

    void HttpRequest(HttpMethod method, const std::string& url, HttpCallback cb);
    void HttpRequest(HttpMethod method, const std::string& url, const httplib::Headers& headers, HttpCallback cb);
    void HttpRequest(HttpMethod method, const std::string& url, const std::string& body, const std::string& contentType, HttpCallback cb);
    void HttpRequest(HttpMethod method, const std::string& url, const std::string& body, const std::string& contentType, const httplib::Headers& headers, HttpCallback cb);
    void HandleHttpResponses();

    static HttpManager* GetInstance();

private:
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

    static HttpManager* instance;
};

#endif // #ifndef __HTTP_MANAGER_H
