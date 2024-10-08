#ifndef _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_QUERY_RESULT_H_
#define _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_QUERY_RESULT_H_

#include <vector>
#include "Define.h"

#include "../../libs/nlohmann/json.hpp"

#include "../IRequest.h"

namespace ModChatTransmitter::Requests
{
    class QueryResult : public IRequest
    {
    public:
        QueryResult(const std::string& queryId, const std::vector<nlohmann::json>& data, const std::vector<std::string>& columns);
        QueryResult(const std::string& queryId, bool success, const std::string& error = "");
        QueryResult(const std::string& queryId, uint64 affectedRows);
        QueryResult& operator=(const QueryResult& other);
        std::string GetContents() override;

    protected:
        std::string queryId;
        std::vector<nlohmann::json> data;
        std::vector<std::string> columns;
        bool success;
        std::string error;
        uint64 affectedRows;

        NLOHMANN_DEFINE_TYPE_INTRUSIVE(QueryResult, queryId, data, columns, success, error, affectedRows)
    };
}

#endif // _MOD_CHAT_TRANSMITTER_REQUESTS_REQUEST_QUERY_RESULT_H_
