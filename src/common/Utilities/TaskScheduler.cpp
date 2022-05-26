/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU GPL v2 or later license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 * Copyright (C) 2008+  TrinityCore <http://www.trinitycore.org/>
 */

#include "TaskScheduler.h"
#include "Errors.h"

TaskScheduler& TaskScheduler::ClearValidator()
{
    _predicate = EmptyValidator;
    return *this;
}

TaskScheduler& TaskScheduler::Update(success_t const& callback)
{
    _now = clock_t::now();
    Dispatch(callback);
    return *this;
}

TaskScheduler& TaskScheduler::Update(size_t const milliseconds, success_t const& callback)
{
    return Update(std::chrono::milliseconds(milliseconds), callback);
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
    _task_holder.RemoveIf([group](TaskContainer const & task) -> bool
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
    _task_holder.Push(std::move(task));
    return *this;
}

void TaskScheduler::Dispatch(success_t const& callback)
{
    // If the validation failed abort the dispatching here.
    if (!_predicate())
    {
        return;
    }

    // Process all asyncs
    while (!_asyncHolder.empty())
    {
        _asyncHolder.front()();
        _asyncHolder.pop();

        // If the validation failed abort the dispatching here.
        if (!_predicate())
        {
            return;
        }
    }

    while (!_task_holder.IsEmpty())
    {
        if (_task_holder.First()->_end > _now)
        {
            break;
        }

        // Perfect forward the context to the handler
        // Use weak references to catch destruction before callbacks.
        TaskContext context(_task_holder.Pop(), std::weak_ptr<TaskScheduler>(self_reference));

        // Invoke the context
        context.Invoke();

        // If the validation failed abort the dispatching here.
        if (!_predicate())
        {
            return;
        }
    }

    // On finish call the final callback
    callback();
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
        {
            itr = container.erase(itr);
        }
        else
        {
            ++itr;
        }
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
        {
            ++itr;
        }

    container.insert(cache.begin(), cache.end());
}

bool TaskScheduler::TaskQueue::IsEmpty() const
{
    return container.empty();
}

TaskContext& TaskContext::Dispatch(std::function<TaskScheduler&(TaskScheduler&)> const& apply)
{
    if (auto const owner = _owner.lock())
    {
        apply(*owner);
    }

    return *this;
}

bool TaskContext::IsExpired() const
{
    return _owner.expired();
}

bool TaskContext::IsInGroup(TaskScheduler::group_t const group) const
{
    return _task->IsInGroup(group);
}

TaskContext& TaskContext::SetGroup(TaskScheduler::group_t const group)
{
    _task->_group = group;
    return *this;
}

TaskContext& TaskContext::ClearGroup()
{
    _task->_group = std::nullopt;
    return *this;
}

TaskScheduler::repeated_t TaskContext::GetRepeatCounter() const
{
    return _task->_repeated;
}

TaskContext& TaskContext::Async(std::function<void()> const& callable)
{
    return Dispatch(std::bind(&TaskScheduler::Async, std::placeholders::_1, callable));
}

TaskContext& TaskContext::CancelAll()
{
    return Dispatch(std::mem_fn(&TaskScheduler::CancelAll));
}

TaskContext& TaskContext::CancelGroup(TaskScheduler::group_t const group)
{
    return Dispatch(std::bind(&TaskScheduler::CancelGroup, std::placeholders::_1, group));
}

TaskContext& TaskContext::CancelGroupsOf(std::vector<TaskScheduler::group_t> const& groups)
{
    return Dispatch(std::bind(&TaskScheduler::CancelGroupsOf, std::placeholders::_1, std::cref(groups)));
}

void TaskContext::AssertOnConsumed() const
{
    // This was adapted to TC to prevent static analysis tools from complaining.
    // If you encounter this assertion check if you repeat a TaskContext more then 1 time!
    ASSERT(!(*_consumed) && "Bad task logic, task context was consumed already!");
}

void TaskContext::Invoke()
{
    _task->_task(*this);
}
