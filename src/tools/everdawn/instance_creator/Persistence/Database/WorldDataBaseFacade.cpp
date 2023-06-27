#include "WorldDataBaseFacade.hpp"

#include "DatabaseEnv.h"
#include "DatabaseLoader.h"
#include "MySQLThreading.h"

#include <thread>

namespace everdawn
{
    void WorldDatabaseFacade::Load()
    {
        m_status.Next({ StatusCode::loading, "MYSQL INIT CONNECTION" });

        std::thread([]()
        {
            std::this_thread::sleep_for(std::chrono::seconds(5));
            m_status.Next({ StatusCode::ready, "MYSQL IS READY" });
        }).detach();

        return;

        MySQL::Library_Init();
        DatabaseLoader loader("");
        loader
            .AddDatabase(WorldDatabase, "World");

        std::this_thread::sleep_for(std::chrono::seconds(5));

        if (!loader.Load())
        {

        }
    }

    Observable<Status>& WorldDatabaseFacade::GetStatus()
    {
        return m_status;
    }

} // namespace everdawn
