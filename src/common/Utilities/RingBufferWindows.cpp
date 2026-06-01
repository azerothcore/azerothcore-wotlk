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

#if AC_PLATFORM == AC_PLATFORM_WINDOWS

#include "RingBuffer.h"
#include "Errors.h"
#include "ScopeExit.h"

#include <limits>
#include <memory>
#include <system_error>

#include <windows.h>

namespace
{
    using VirtualAlloc2Fn = decltype(&::VirtualAlloc2);
    using MapViewOfFile3Fn = decltype(&::MapViewOfFile3);

    [[noreturn]] void ThrowSystemError(char const* what, DWORD error = GetLastError())
    {
        throw std::system_error(static_cast<int>(error), std::system_category(), what);
    }

    template <typename T>
    T LoadProcAddress(HMODULE module, char const* name)
    {
        FARPROC function = GetProcAddress(module, name);
        if (!function)
            ThrowSystemError(name);

        return reinterpret_cast<T>(function);
    }

    HMODULE GetKernelModule()
    {
        HMODULE module = GetModuleHandleA("kernelbase.dll");
        if (!module)
            module = GetModuleHandleA("kernel32.dll");

        if (!module)
            ThrowSystemError("GetModuleHandleA");

        return module;
    }

    struct Win32MemoryApi
    {
        VirtualAlloc2Fn VirtualAlloc2;
        MapViewOfFile3Fn MapViewOfFile3;
    };

    Win32MemoryApi const& GetWin32MemoryApi()
    {
        static Win32MemoryApi const api = []
        {
            HMODULE module = GetKernelModule();
            return Win32MemoryApi
            {
                LoadProcAddress<VirtualAlloc2Fn>(module, "VirtualAlloc2"),
                LoadProcAddress<MapViewOfFile3Fn>(module, "MapViewOfFile3")
            };
        }();

        return api;
    }

}

RingBuffer::RingBuffer(std::size_t desiredSize)
{
    SYSTEM_INFO systemInfo;
    GetSystemInfo(&systemInfo);

    // Note that dwAllocationGranularity is usually 64k
    _mappedSize = AlignUp(desiredSize, systemInfo.dwAllocationGranularity);

    Win32MemoryApi const& memory = GetWin32MemoryApi();
    ASSERT(_mappedSize <= std::numeric_limits<std::size_t>::max() / 2,
        "RingBuffer size is too large");

    std::size_t const totalSize = _mappedSize * 2;

    void* firstPlaceholder = memory.VirtualAlloc2(GetCurrentProcess(), nullptr, totalSize,
        MEM_RESERVE | MEM_RESERVE_PLACEHOLDER, PAGE_NOACCESS, nullptr, 0);
    if (!firstPlaceholder)
        ThrowSystemError("VirtualAlloc2");

    ScopeExit firstPlaceholderGuard([&]() noexcept { VirtualFree(firstPlaceholder, 0, MEM_RELEASE); });

    if (!VirtualFree(firstPlaceholder, _mappedSize, MEM_RELEASE | MEM_PRESERVE_PLACEHOLDER))
        ThrowSystemError("VirtualFree split placeholder");

    void* const secondPlaceholder = static_cast<uint8*>(firstPlaceholder) + _mappedSize;
    ScopeExit secondPlaceholderGuard([&]() noexcept { VirtualFree(secondPlaceholder, 0, MEM_RELEASE); });

    ULARGE_INTEGER mappingSize;
    mappingSize.QuadPart = _mappedSize;

    std::unique_ptr<void, decltype([](void* handle) noexcept { CloseHandle(handle); }) > section{
        CreateFileMapping(INVALID_HANDLE_VALUE, nullptr, PAGE_READWRITE,
            mappingSize.HighPart, mappingSize.LowPart, nullptr) };
    if (!section)
        ThrowSystemError("CreateFileMapping");

    void* firstView = memory.MapViewOfFile3(section.get(), GetCurrentProcess(), firstPlaceholder, 0, _mappedSize,
        MEM_REPLACE_PLACEHOLDER, PAGE_READWRITE, nullptr, 0);
    if (!firstView)
        ThrowSystemError("MapViewOfFile3 first view");

    firstPlaceholderGuard.Release();
    ScopeExit firstViewGuard([&]() noexcept { UnmapViewOfFile(firstView); });

    void* secondView = memory.MapViewOfFile3(section.get(), GetCurrentProcess(), secondPlaceholder, 0, _mappedSize,
        MEM_REPLACE_PLACEHOLDER, PAGE_READWRITE, nullptr, 0);
    if (!secondView)
        ThrowSystemError("MapViewOfFile3 second view");

    secondPlaceholderGuard.Release();
    ScopeExit secondViewGuard([&]() noexcept { UnmapViewOfFile(secondView); });

    _base = static_cast<uint8*>(firstView);
    firstViewGuard.Release();
    secondViewGuard.Release();
}

void RingBuffer::Release() noexcept
{
    if (_base)
    {
        UnmapViewOfFile(_base + _mappedSize);
        UnmapViewOfFile(_base);
        _base = nullptr;
    }

    _mappedSize = 0;
    _position = 0;
}

#endif
