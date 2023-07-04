#ifndef EVERDAWN_WORLDDATABASEFACADE_HPP
#define EVERDAWN_WORLDDATABASEFACADE_HPP

#include "MySQLConnection.h"
#include "WorldDatabase.h"
#include "Observable.hpp"
#include "Status.hpp"

#pragma once

namespace everdawn
{
    namespace StatusCode::DatabaseConnection
    {
        constexpr int Disconnected = 2002;
        constexpr int Loading = 2003;
        constexpr int Ready = 2004;
        constexpr int Error = 2005;
    }

    class WorldDatabaseFacade
    {
        class WorldDatabaseDecorator;
        inline static std::unique_ptr<WorldDatabaseDecorator> m_connection = nullptr;
        inline static std::unique_ptr<MySQLConnectionInfo> m_connectionInfo = nullptr;
        inline static  Observable<Status> m_status = Observable<Status>({ StatusCode::DatabaseConnection::Disconnected, "MYSQL DISCONNECTED" });

        class WorldDatabaseDecorator final : public WorldDatabaseConnection
        {
            friend class WorldDatabaseFacade;
        public:
            explicit WorldDatabaseDecorator(MySQLConnectionInfo& conn_info) : WorldDatabaseConnection(conn_info) {}
        };

    public:
        static void Load();
        const static Observable<Status>& GetStatus();
    };
} // namespace everdawn

#endif // EVERDAWN_WORLDDATABASEFACADE_HPP
