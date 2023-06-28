#ifndef EVERDAWN_WORLDDATABASEFACADE_HPP
#define EVERDAWN_WORLDDATABASEFACADE_HPP

#include "MySQLConnection.h"
#include "WorldDatabase.h"
#include "Observable.hpp"
#include "Status.hpp"

#pragma once

namespace everdawn
{
    namespace StatusType::Database
    {
        constexpr int WorldDatabase = 2002;
        constexpr int WorldDatabaseConnection = 2003;
    }

    class WorldDatabaseFacade
    {
        class WorldDatabaseDecorator;
        inline static std::unique_ptr<WorldDatabaseDecorator> m_connection = nullptr;
        inline static std::unique_ptr<MySQLConnectionInfo> m_connectionInfo = nullptr;
        inline static  Observable<Status> m_status;

        class WorldDatabaseDecorator : public WorldDatabaseConnection
        {
            friend class WorldDatabaseFacade;
        public:
            WorldDatabaseDecorator(MySQLConnectionInfo& connInfo) : WorldDatabaseConnection(connInfo) {}
        };

    public:
        static void Load();
        const static Observable<Status>& GetStatus();
    };
} // namespace everdawn

#endif // EVERDAWN_WORLDDATABASEFACADE_HPP
