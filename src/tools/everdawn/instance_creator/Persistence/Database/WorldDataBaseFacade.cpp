#include "WorldDataBaseFacade.hpp"

#include "DatabaseEnv.h"
#include "MySQLThreading.h"

#include <thread>
#include <sstream>

namespace everdawn
{
    void WorldDatabaseFacade::Load()
    {
        m_status.Next({ StatusCode::loading, "MYSQL INIT CONNECTION" });

        std::thread([]()
            {
                std::this_thread::sleep_for(std::chrono::seconds(5));

                MySQL::Library_Init();
                m_connectionInfo = std::make_unique<MySQLConnectionInfo>("127.0.0.1;3306;everdawn;everdawn;everdawn_world");
                m_connection = std::make_unique<WorldDatabaseDecorator>(*m_connectionInfo);

                auto error = m_connection->Open();

                if (error)
                {
                    m_status.Next({ StatusCode::error, "MYSQL CONNECTION ERROR" });
                    return;
                }

                auto version = m_connection->GetServerVersion();
                std::stringstream ss;
                ss << "MYSQL VERSION: " << version;

                m_status.Next({ StatusCode::ready, ss.str().c_str() });
            }).detach();
    }

    const Observable<Status>& WorldDatabaseFacade::GetStatus()
    {
        return m_status;
    }

} // namespace everdawn
