/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef ACORE_SCOPE_EXIT_H
#define ACORE_SCOPE_EXIT_H

#include <type_traits>
#include <utility>

template <typename F>
    requires std::is_nothrow_invocable_v<F&>
class ScopeExit
{
public:
    explicit ScopeExit(F&& f) noexcept(std::is_nothrow_move_constructible_v<F>) :
        _finalizer(std::move(f))
    {
    }

    ScopeExit(ScopeExit&& other) noexcept(std::is_nothrow_move_constructible_v<F>) :
        _finalizer(std::move(other._finalizer)),
        _active(std::exchange(other._active, false))
    {
    }

    ~ScopeExit()
    {
        if (_active)
            _finalizer();
    }

    ScopeExit(ScopeExit const&) = delete;
    ScopeExit& operator=(ScopeExit const&) = delete;
    ScopeExit& operator=(ScopeExit&&) = delete;

    void Release() noexcept
    {
        _active = false;
    }

private:
    F _finalizer;
    bool _active = true;
};

template <typename F>
ScopeExit(F&&) -> ScopeExit<std::decay_t<F>>;

#endif // ACORE_SCOPE_EXIT_H
