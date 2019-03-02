/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _CALLBACK_H
#define _CALLBACK_H

#include <ace/Future.h>
#include <ace/Future_Set.h>
#include "QueryResult.h"

typedef ACE_Future<QueryResult> QueryResultFuture;
typedef ACE_Future<PreparedQueryResult> PreparedQueryResultFuture;

/*! A simple template using ACE_Future to manage callbacks from the thread and object that
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
        void SetFutureResult(ACE_Future<Result> value)
        {
            _result = value;
        }

        ACE_Future<Result> GetFutureResult()
        {
            return _result;
        }

        int IsReady()
        {
            return _result.ready();
        }

        void GetResult(Result& res)
        {
            _result.get(res);
        }

        void FreeResult()
        {
            _result.cancel();
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
            FreeResult();
            ResetStage();
        }

    private:
        ACE_Future<Result> _result;
        ParamType _param;
        uint8 _stage;
};

template <typename Result, typename ParamType1, typename ParamType2, bool chain = false>
class QueryCallback_2
{
    public:
        QueryCallback_2() : _stage(chain ? 0 : CALLBACK_STAGE_INVALID) {}

        //! The parameter of this function should be a resultset returned from either .AsyncQuery or .AsyncPQuery
        void SetFutureResult(ACE_Future<Result> value)
        {
            _result = value;
        }

        ACE_Future<Result> GetFutureResult()
        {
            return _result;
        }

        int IsReady()
        {
            return _result.ready();
        }

        void GetResult(Result& res)
        {
            _result.get(res);
        }

        void FreeResult()
        {
            _result.cancel();
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
            FreeResult();
            ResetStage();
        }

    private:
        ACE_Future<Result> _result;
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
        void SetFutureResult(ACE_Future<Result> value)
        {
            _result = value;
        }

        ACE_Future<Result> GetFutureResult()
        {
            return _result;
        }

        int IsReady()
        {
            return _result.ready();
        }

        void GetResult(Result& res)
        {
            _result.get(res);
        }

        void FreeResult()
        {
            _result.cancel();
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
            FreeResult();
            ResetStage();
        }

    private:
        ACE_Future<Result> _result;
        ParamType1 _param_1;
        ParamType2 _param_2;
        ParamType3 _param_3;
        uint8 _stage;
};

#endif