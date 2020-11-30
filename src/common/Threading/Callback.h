/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _CALLBACK_H
#define _CALLBACK_H

#include "QueryResult.h"

#include <future>
#include <chrono>

typedef std::promise<QueryResult> QueryResultPromise;
typedef std::promise<PreparedQueryResult> PreparedQueryResultPromise;

/*! A simple template using std::future to manage callbacks from the thread and object that
    issued the request. <ParamType> is variable type of parameter that is used as parameter
    for the callback function.
*/
#define CALLBACK_STAGE_INVALID uint8(-1)

template <typename Result, typename ParamType, bool chain = false>
class QueryCallback
{
public:
    QueryCallback() : _param(), _stage(chain ? 0 : CALLBACK_STAGE_INVALID)  {}

    //! The parameter of this function should be a resultset returned from either .AsyncQuery or .AsyncPQuery
    void SetFutureResult(std::future<Result> &&value)
    {
        _result = std::move(value);
    }

    int IsReady()
    {
        return IsFutureReady(_result);
    }

    void GetResult(Result& res)
    {
        res = _result.get();
    }

    void SetParam(ParamType value)
    {
        _param = value;
    }

    ParamType GetParam()
    {
        return _param;
    }

    //! Resets the stage of the callback chain
    void ResetStage()
    {
        if (!chain)
            return;

        _stage = 0;
    }

    //! Advances the callback chain to the next stage, so upper level code can act on its results accordingly
    void NextStage()
    {
        if (!chain)
            return;

        ++_stage;
    }

    //! Returns the callback stage (or CALLBACK_STAGE_INVALID if invalid)
    uint8 GetStage()
    {
        return _stage;
    }

    //! Resets all underlying variables (param, result and stage)
    void Reset()
    {
        SetParam(NULL);
        ResetStage();
    }

private:
    std::future<Result> _result;
    ParamType _param;
    uint8 _stage;
};

template <typename Result, typename ParamType1, typename ParamType2, bool chain = false>
class QueryCallback_2
{
public:
    QueryCallback_2() : _stage(chain ? 0 : CALLBACK_STAGE_INVALID) {}

    //! The parameter of this function should be a resultset returned from either .AsyncQuery or .AsyncPQuery
    void SetFutureResult(std::future<Result> &&value)
    {
        _result = std::move(value);
    }

    int IsReady()
    {
        return IsFutureReady(_result);
    }

    void GetResult(Result& res)
    {
        res = _result.get();
    }

    void SetFirstParam(ParamType1 value)
    {
        _param_1 = value;
    }

    void SetSecondParam(ParamType2 value)
    {
        _param_2 = value;
    }

    ParamType1 GetFirstParam()
    {
        return _param_1;
    }

    ParamType2 GetSecondParam()
    {
        return _param_2;
    }

    //! Resets the stage of the callback chain
    void ResetStage()
    {
        if (!chain)
            return;

        _stage = 0;
    }

    //! Advances the callback chain to the next stage, so upper level code can act on its results accordingly
    void NextStage()
    {
        if (!chain)
            return;

        ++_stage;
    }

    //! Returns the callback stage (or CALLBACK_STAGE_INVALID if invalid)
    uint8 GetStage()
    {
        return _stage;
    }

    //! Resets all underlying variables (param, result and stage)
    void Reset()
    {
        SetFirstParam(0);
        SetSecondParam(NULL);
        ResetStage();
    }

private:
    std::future<Result> _result;
    ParamType1 _param_1;
    ParamType2 _param_2;
    uint8 _stage;
};

template <typename Result, typename ParamType1, typename ParamType2, typename ParamType3, bool chain = false>
class QueryCallback_3
{
public:
    QueryCallback_3() : _stage(chain ? 0 : CALLBACK_STAGE_INVALID) {}

    //! The parameter of this function should be a resultset returned from either .AsyncQuery or .AsyncPQuery
    void SetFutureResult(std::future<Result> &&value)
    {
        _result = std::move(value);
    }

    int IsReady()
    {
        return IsFutureReady(_result);
    }

    void GetResult(Result& res)
    {
        res = _result.get();
    }

    void SetFirstParam(ParamType1 value)
    {
        _param_1 = value;
    }

    void SetSecondParam(ParamType2 value)
    {
        _param_2 = value;
    }

    void SetThirdParam(ParamType3 value)
    {
        _param_3 = value;
    }

    ParamType1 GetFirstParam()
    {
        return _param_1;
    }

    ParamType2 GetSecondParam()
    {
        return _param_2;
    }

    ParamType3 GetThirdParam()
    {
        return _param_3;
    }

    //! Resets the stage of the callback chain
    void ResetStage()
    {
        if (!chain)
            return;

        _stage = 0;
    }

    //! Advances the callback chain to the next stage, so upper level code can act on its results accordingly
    void NextStage()
    {
        if (!chain)
            return;

        ++_stage;
    }

    //! Returns the callback stage (or CALLBACK_STAGE_INVALID if invalid)
    uint8 GetStage()
    {
        return _stage;
    }

    //! Resets all underlying variables (param, result and stage)
    void Reset()
    {
        SetFirstParam(NULL);
        SetSecondParam(NULL);
        SetThirdParam(NULL);
        ResetStage();
    }

private:
    std::future<Result> _result;
    ParamType1 _param_1;
    ParamType2 _param_2;
    ParamType3 _param_3;
    uint8 _stage;
};

// NOTE: Once http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n3857.pdf
// is adopted these will no longer be necessary.
template <typename T>
bool IsFutureReady(std::future<T> const& f)
{
    return f.valid() && f.wait_for(std::chrono::seconds(0)) == std::future_status::ready;
}

template <typename T>
bool IsFutureReady(std::shared_future<T> const& f)
{
    return f.valid() && f.wait_for(std::chrono::seconds(0)) == std::future_status::ready;
}
#endif
