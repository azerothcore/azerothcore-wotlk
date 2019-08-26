/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

 #include "TaskScheduler.h"

TaskScheduler& TaskScheduler::Update()
{
    _now = clock_t::now();
    Dispatch();
    return *this;
}

TaskScheduler& TaskScheduler::Update(size_t const milliseconds)
{
    return Update(std::chrono::milliseconds(milliseconds));
}

TaskScheduler& TaskScheduler::Async(std::function<void()> const& callable)
{
    _asyncHolder.push(callable);
    return *this;
}

TaskScheduler& TaskScheduler::CancelAll()
{
    /// Clear the task holder
    _task_holder.Clear();
    _asyncHolder = AsyncHolder();
    return *this;
}

TaskScheduler& TaskScheduler::CancelGroup(group_t const group)
{
    _task_holder.RemoveIf([group](TaskContainer const& task) -> bool
    {
        return task->IsInGroup(group);
    });
    return *this;
}

TaskScheduler& TaskScheduler::CancelGroupsOf(std::vector<group_t> const& groups)
{
    std::for_each(groups.begin(), groups.end(),
        std::bind(&TaskScheduler::CancelGroup, this, std::placeholders::_1));

    return *this;
}

TaskScheduler& TaskScheduler::InsertTask(TaskContainer task)
{
    _task_holder.Push(std::forward<TaskContainer>(task));
    return *this;
}

void TaskScheduler::Dispatch()
{
    // Process all asyncs
    while (!_asyncHolder.empty())
    {
        _asyncHolder.front()();
        _asyncHolder.pop();
    }

    while (!_task_holder.IsEmpty())
    {
        if (_task_holder.First()->_end > _now)
            break;

        // Perfect forward the context to the handler
        // Use weak references to catch destruction before callbacks.
        TaskContext context(new TaskContextInstance(_task_holder.Pop(),
            std::weak_ptr<TaskScheduler>(self_reference)));

        // Invoke the context
        context->Invoke();
    }
}

void TaskScheduler::TaskQueue::Push(TaskContainer&& task)
{
    container.insert(task);
}

auto TaskScheduler::TaskQueue::Pop() -> TaskContainer
{
    TaskContainer result = *container.begin();
    container.erase(container.begin());
    return result;
}

auto TaskScheduler::TaskQueue::First() const -> TaskContainer const&
{
    return *container.begin();
}

void TaskScheduler::TaskQueue::Clear()
{
    container.clear();
}

void TaskScheduler::TaskQueue::RemoveIf(std::function<bool(TaskContainer const&)> const& filter)
{
    for (auto itr = container.begin(); itr != container.end();)
        if (filter(*itr))
            itr = container.erase(itr);
        else
            ++itr;
}

void TaskScheduler::TaskQueue::ModifyIf(std::function<bool(TaskContainer const&)> const& filter)
{
    std::vector<TaskContainer> cache;
    for (auto itr = container.begin(); itr != container.end();)
        if (filter(*itr))
        {
            cache.push_back(*itr);
            itr = container.erase(itr);
        }
        else
            ++itr;

    container.insert(cache.begin(), cache.end());
}

bool TaskScheduler::TaskQueue::IsEmpty() const
{
    return container.empty();
}

TaskContextInstance& TaskContextInstance::Dispatch(std::function<TaskScheduler&(TaskScheduler&)> const& apply)
{
    if (auto const owner = _owner.lock())
        apply(*owner);

    return *this;
}

bool TaskContextInstance::IsInGroup(TaskScheduler::group_t const group) const
{
    return _task->IsInGroup(group);
}

TaskContextInstance& TaskContextInstance::SetGroup(TaskScheduler::group_t const group)
{
    _task->_group = group;
    return *this;
}

TaskContextInstance& TaskContextInstance::ClearGroup()
{
    _task->_group = std::nullopt;
    return *this;
}

TaskScheduler::repeated_t TaskContextInstance::GetRepeatCounter() const
{
    return _task->_repeated;
}

TaskContextInstance& TaskContextInstance::Async(std::function<void()> const& callable)
{
    return Dispatch(std::bind(&TaskScheduler::Async, std::placeholders::_1, callable));
}

TaskContextInstance& TaskContextInstance::CancelAll()
{
    return Dispatch(std::mem_fn(&TaskScheduler::CancelAll));
}

TaskContextInstance& TaskContextInstance::CancelGroup(TaskScheduler::group_t const group)
{
    return Dispatch(std::bind(&TaskScheduler::CancelGroup, std::placeholders::_1, group));
}

TaskContextInstance& TaskContextInstance::CancelGroupsOf(std::vector<TaskScheduler::group_t> const& groups)
{
    return Dispatch(std::bind(&TaskScheduler::CancelGroupsOf, std::placeholders::_1, groups));
}

void TaskContextInstance::AssertOnConsumed()
{
    // This was adapted to TC to prevent static analysis tools from complaining.
    // If you encounter this assertion check if you repeat a TaskContext more then 1 time!
    ASSERT(_task && "Bad task logic, task context was consumed already!");
}

void TaskContextInstance::Invoke()
{
    _task->_task(shared_from_this());
}
