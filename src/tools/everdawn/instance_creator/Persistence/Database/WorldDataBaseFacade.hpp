#ifndef EVERDAWN_WORLDDATABASEFACADE_HPP
#define EVERDAWN_WORLDDATABASEFACADE_HPP

#include "Observable.hpp"
#include "Status.hpp"

#pragma once

namespace everdawn
{
    class WorldDatabaseFacade
    {
        inline static  Observable<Status> m_status;
    public:
        static void Load();
        static Observable<Status>& GetStatus();
    };
} // namespace everdawn

#endif // EVERDAWN_WORLDDATABASEFACADE_HPP
