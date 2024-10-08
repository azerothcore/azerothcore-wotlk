#include "RequestQueryResult.h"
#include "../ChatTransmitter.h"

namespace ModChatTransmitter::Requests
{
    QueryResult::QueryResult(const std::string& queryId, const std::vector<nlohmann::json>& data, const std::vector<std::string>& columns)
      : queryId(queryId),
        data(data),
        columns(columns),
        success(true),
        error(""),
        affectedRows(data.size())
    { }

    QueryResult::QueryResult(const std::string& queryId, bool success, const std::string& error)
        : queryId(queryId),
        data(),
        columns(),
        success(success),
        error(error),
        affectedRows(0)
    { }

    QueryResult::QueryResult(const std::string& queryId, uint64 affectedRows)
        : queryId(queryId),
        data(),
        columns(),
        success(true),
        error(""),
        affectedRows(affectedRows)
    { }

    QueryResult& QueryResult::operator=(const QueryResult& other)
    {
        queryId = other.queryId;
        data = other.data;
        columns = other.columns;
        success = other.success;
        error = other.error;

        return *this;
    }

    std::string QueryResult::GetContents()
    {
        nlohmann::json jsonObj;
        jsonObj["message"] = "queryResult";
        nlohmann::to_json(jsonObj["data"], *this);
        return nlohmann::to_string(jsonObj);
    }
}
