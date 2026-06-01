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

#include "CompilerDefs.h"

#if AC_PLATFORM == AC_PLATFORM_UNIX && defined(__linux__)

#include "RingBuffer.h"
#include "Errors.h"
#include "ScopeExit.h"

#include <cerrno>
#include <limits>
#include <system_error>

#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef MFD_CLOEXEC
#define MFD_CLOEXEC 0x0001U
#endif

namespace
{
    [[noreturn]] void ThrowSystemError(char const* what)
    {
        throw std::system_error(errno, std::generic_category(), what);
    }

    int CreateAnonymousFile()
    {
#ifdef SYS_memfd_create
        int fd = static_cast<int>(syscall(SYS_memfd_create, "acore-ring-buffer", MFD_CLOEXEC));
        if (fd == -1)
            ThrowSystemError("memfd_create");

        return fd;
#else
        errno = ENOSYS;
        ThrowSystemError("memfd_create");
#endif
    }

}

RingBuffer::RingBuffer(std::size_t desiredSize)
{
    long pageSize = sysconf(_SC_PAGESIZE);
    if (pageSize <= 0)
        ThrowSystemError("sysconf(_SC_PAGESIZE)");

    _mappedSize = AlignUp(desiredSize, static_cast<std::size_t>(pageSize));

    int fd = CreateAnonymousFile();
    ScopeExit fdGuard([fd]() noexcept { close(fd); });

    ASSERT(_mappedSize <= std::numeric_limits<std::size_t>::max() / 2,
        "RingBuffer size is too large");
    ASSERT(_mappedSize <= static_cast<std::size_t>(std::numeric_limits<off_t>::max()),
        "RingBuffer size is too large for ftruncate");

    if (ftruncate(fd, static_cast<off_t>(_mappedSize)) == -1)
        ThrowSystemError("ftruncate");

    std::size_t const totalSize = _mappedSize * 2;
    void* reserved = mmap(nullptr, totalSize, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (reserved == MAP_FAILED)
        ThrowSystemError("mmap reserve");

    ScopeExit reservedGuard([&]() noexcept { munmap(reserved, totalSize); });

    void* firstView = mmap(reserved, _mappedSize, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, 0);
    if (firstView == MAP_FAILED)
        ThrowSystemError("mmap first view");

    ScopeExit firstViewGuard([&]() noexcept { munmap(firstView, _mappedSize); });

    void* const secondAddress = static_cast<uint8*>(reserved) + _mappedSize;
    void* secondView = mmap(secondAddress, _mappedSize, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, 0);
    if (secondView == MAP_FAILED)
        ThrowSystemError("mmap second view");

    ScopeExit secondViewGuard([&]() noexcept { munmap(secondView, _mappedSize); });

    _base = static_cast<uint8*>(reserved);
    reservedGuard.Release();
    firstViewGuard.Release();
    secondViewGuard.Release();
}

void RingBuffer::Release() noexcept
{
    if (_base)
    {
        munmap(_base, _mappedSize * 2);
        _base = nullptr;
    }

    _mappedSize = 0;
    _position = 0;
}

#endif
