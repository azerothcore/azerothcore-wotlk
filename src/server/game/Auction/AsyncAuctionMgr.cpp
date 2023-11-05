/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "AsyncAuctionMgr.h"
#include "AsyncAuctionOperation.h"
#include "GameTime.h"
#include "Log.h"
#include "PCQueue.h"
#include "Player.h"
#include "StopWatch.h"
#include "TaskScheduler.h"
#include "World.h"

constexpr Milliseconds LIST_OWNER_ITEMS_DELAY = 100ms;
constexpr Milliseconds LIST_ITEMS_DELAY = 500ms;

bool AuctionListItems::IsNoFilter() const
{
    return ItemClass == 0xffffffff &&
           ItemSubClass == 0xffffffff &&
           InventoryType == 0xffffffff &&
           Quality == 0xffffffff &&
           LevelMin == 0x00 &&
           LevelMax == 0x00 &&
           Usable == 0x00;
}

AsyncAuctionMgr::~AsyncAuctionMgr()
{
    if (_scheduler)
        _scheduler->CancelAll();

    if (_queue)
        _queue->Cancel();

    for (auto& thread : _threads)
        if (thread.joinable())
            thread.join();
}

/*static*/ AsyncAuctionMgr* AsyncAuctionMgr::instance()
{
    static AsyncAuctionMgr instance;
    return &instance;
}

void AsyncAuctionMgr::Initialize()
{
    StopWatch sw;

    LOG_INFO("server.loading", "Initialize async auction...");

    _scheduler = std::make_unique<TaskScheduler>();
    _queue = std::make_unique<ProducerConsumerQueue<AsyncAuctionOperation*>>();

    auto threadsCount = sWorld->getIntConfig(CONFIG_AUCTION_ASYNC_THREADS);
    if (!threadsCount || threadsCount > 32)
    {
        LOG_ERROR("server.loading", "Async auction: Incorrect threads count: {}. Set 1.", threadsCount);
        threadsCount = 1;
    }

    for (std::size_t i{}; i < threadsCount; i++)
        _threads.emplace_back([this](){ ExecuteAsyncQueue(); });

    _threads.shrink_to_fit();

    LOG_INFO("server.loading", ">> Async auction initialized in {}. Threads: {}", sw, threadsCount);
    LOG_INFO("server.loading", " ");
}

void AsyncAuctionMgr::Update(Milliseconds diff)
{
    _scheduler->Update(diff);
}

void AsyncAuctionMgr::SellItem(ObjectGuid playerGuid, std::shared_ptr<AuctionSellItem> packet)
{
    Enqueue(new SellItemTask(playerGuid, std::move(packet)));
}

void AsyncAuctionMgr::PlaceBid(ObjectGuid playerGuid, ObjectGuid auctioneer, uint32 auctionID, uint32 price)
{
    Enqueue(new PlaceBidTask(playerGuid, auctioneer, auctionID, price));
}

void AsyncAuctionMgr::ListBidderItems(ObjectGuid playerGuid, ObjectGuid auctioneer, std::vector<uint32>&& outbiddedAuctionIds)
{
    Enqueue(new ListBidderItemsTask(playerGuid, auctioneer, std::move(outbiddedAuctionIds)));
}

void AsyncAuctionMgr::ListOwnerItems(ObjectGuid playerGuid, ObjectGuid creatureGuid)
{
    _scheduler->Schedule(LIST_OWNER_ITEMS_DELAY, [this, playerGuid, creatureGuid](TaskContext)
    {
        Enqueue(new ListOwnerTask(playerGuid, creatureGuid));
    });
}

void AsyncAuctionMgr::ListItems(ObjectGuid playerGuid, std::shared_ptr<AuctionListItems> listItems)
{
    _scheduler->Schedule(LIST_ITEMS_DELAY, [this, playerGuid, listItems = std::move(listItems)](TaskContext)
    {
        Enqueue(new ListItemsTask(playerGuid, listItems));
    });
}

void AsyncAuctionMgr::Enqueue(AsyncAuctionOperation* operation)
{
    _queue->Push(operation);
}

void AsyncAuctionMgr::ExecuteAsyncQueue()
{
    if (!_queue)
        return;

    for (;;)
    {
        AsyncAuctionOperation* task{ nullptr };
        _queue->WaitAndPop(task);

        if (!task)
            break;

        task->Execute();
        delete task;
    }
}
