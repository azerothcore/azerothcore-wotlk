#include "WorldDataBaseFacade.hpp"

#include "DatabaseEnv.h"
#include "MySQLThreading.h"

#include <thread>
#include <sstream>

namespace everdawn
{
    void WorldDatabaseFacade::Load()
    {
        std::thread([]()
            {
                m_status.Next({ StatusCode::Loading, "MYSQL INIT CONNECTION" });

                std::this_thread::sleep_for(std::chrono::seconds(5));

                MySQL::Library_Init();
                m_connectionInfo = std::make_unique<MySQLConnectionInfo>("127.0.0.1;3306;everdawn;everdawn;everdawn_world");
                m_connection = std::make_unique<WorldDatabaseDecorator>(*m_connectionInfo);

                auto error = m_connection->Open();

                if (error)
                {
                    std::stringstream ss;
                    ss << "MYSQL CONNECTION ERROR CODE: " << error;
                    m_status.Next({ StatusCode::Error, ss.str().c_str() });
                    return;
                }

                m_status.Next({ StatusCode::Loading, "MYSQL PREPARING STATEMENTS" });

                std::this_thread::sleep_for(std::chrono::seconds(5));

                m_connection->DoPrepareStatements();

                std::stringstream ss;
                ss << "MYSQL VERSION: " << m_connection->GetServerVersion();

                m_status.Next({ StatusCode::Ready, ss.str().c_str() });
            }).detach();
    }

    const Observable<Status>& WorldDatabaseFacade::GetStatus()
    {
        return m_status;
    }

} // namespace everdawn
