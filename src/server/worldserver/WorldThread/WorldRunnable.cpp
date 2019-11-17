/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/** \file
    \ingroup Trinityd
*/

#include "Common.h"
#include "ObjectAccessor.h"
#include "World.h"
#include "WorldSocketMgr.h"
#include "Database/DatabaseEnv.h"
#include "ScriptMgr.h"
#include "BattlegroundMgr.h"
#include "MapManager.h"
#include "Timer.h"
#include "WorldRunnable.h"
#include "OutdoorPvPMgr.h"
#include "AvgDiffTracker.h"
#include "AsyncAuctionListing.h"

#ifdef ELUNA
#include "LuaEngine.h"
#endif

#ifdef _WIN32
#include "ServiceWin32.h"
extern int m_ServiceStatus;
#endif

/// Heartbeat for the World
void WorldRunnable::run()
{
    uint32 realCurrTime = 0;
    uint32 realPrevTime = getMSTime();

    ///- While we have not World::m_stopEvent, update the world
    while (!World::IsStopped())
    {
        ++World::m_worldLoopCounter;
        realCurrTime = getMSTime();

        uint32 diff = getMSTimeDiff(realPrevTime, realCurrTime);

        sWorld->Update( diff );
        realPrevTime = realCurrTime;

        uint32 executionTimeDiff = getMSTimeDiff(realCurrTime, getMSTime());
        devDiffTracker.Update(executionTimeDiff);
        avgDiffTracker.Update(executionTimeDiff > WORLD_SLEEP_CONST ? executionTimeDiff : WORLD_SLEEP_CONST);

        if (executionTimeDiff < WORLD_SLEEP_CONST)
            acore::Thread::Sleep(WORLD_SLEEP_CONST-executionTimeDiff);

        #ifdef _WIN32
            if (m_ServiceStatus == 0)
                World::StopNow(SHUTDOWN_EXIT_CODE);

            while (m_ServiceStatus == 2)
                Sleep(1000);
        #endif
    }

    sLog->SetLogDB(false);

    sScriptMgr->OnShutdown();

    sWorld->KickAll();                                       // save and kick all players
    sWorld->UpdateSessions( 1 );                             // real players unload required UpdateSessions call

    // unload battleground templates before different singletons destroyed
    sBattlegroundMgr->DeleteAllBattlegrounds();

    sWorldSocketMgr->StopNetwork();

    sMapMgr->UnloadAll();                     // unload all grids (including locked in memory)
    sObjectAccessor->UnloadAll();             // unload 'i_player2corpse' storage and remove from world
    sScriptMgr->Unload();
    sOutdoorPvPMgr->Die();
#ifdef ELUNA
    Eluna::Uninitialize();
#endif
}

void AuctionListingRunnable::run()
{
    sLog->outString("Starting up Auction House Listing thread...");
    while (!World::IsStopped())
    {
        if (AsyncAuctionListingMgr::IsAuctionListingAllowed())
        {
            uint32 diff = AsyncAuctionListingMgr::GetDiff();
            AsyncAuctionListingMgr::ResetDiff();

            if (AsyncAuctionListingMgr::GetTempList().size() || AsyncAuctionListingMgr::GetList().size())
            {
                ACORE_GUARD(ACE_Thread_Mutex, AsyncAuctionListingMgr::GetLock());

                {
                    ACORE_GUARD(ACE_Thread_Mutex, AsyncAuctionListingMgr::GetTempLock());
                    for (std::list<AuctionListItemsDelayEvent>::iterator itr = AsyncAuctionListingMgr::GetTempList().begin(); itr != AsyncAuctionListingMgr::GetTempList().end(); ++itr)
                        AsyncAuctionListingMgr::GetList().push_back( (*itr) );
                    AsyncAuctionListingMgr::GetTempList().clear();
                }

                for (std::list<AuctionListItemsDelayEvent>::iterator itr = AsyncAuctionListingMgr::GetList().begin(); itr != AsyncAuctionListingMgr::GetList().end(); ++itr)
                {
                    if ((*itr)._msTimer <= diff)
                        (*itr)._msTimer = 0;
                    else
                        (*itr)._msTimer -= diff;
                }

                for (std::list<AuctionListItemsDelayEvent>::iterator itr = AsyncAuctionListingMgr::GetList().begin(); itr != AsyncAuctionListingMgr::GetList().end(); ++itr)
                    if ((*itr)._msTimer == 0)
                    {
                        if ((*itr).Execute())
                            AsyncAuctionListingMgr::GetList().erase(itr);
                        break;
                    }
            }
        }
        acore::Thread::Sleep(1);
    }
    sLog->outString("Auction House Listing thread exiting without problems.");
}
