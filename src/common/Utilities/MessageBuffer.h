/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef __MESSAGEBUFFER_H_
#define __MESSAGEBUFFER_H_

#include "Define.h"
#include <vector>
#include <cstring>

class MessageBuffer
{
    using size_type = std::vector<uint8>::size_type;

public:
    MessageBuffer() : _wpos(0), _rpos(0), _storage()
    {
        _storage.resize(4096);
    }

    explicit MessageBuffer(std::size_t initialSize) : _wpos(0), _rpos(0), _storage()
    {
        _storage.resize(initialSize);
    }

    MessageBuffer(MessageBuffer const& right) :
        _wpos(right._wpos), _rpos(right._rpos), _storage(right._storage) { }

    MessageBuffer(MessageBuffer&& right) noexcept :
        _wpos(right._wpos), _rpos(right._rpos), _storage(right.Move()) { }

    void Reset()
    {
        _wpos = 0;
        _rpos = 0;
    }

    void Resize(size_type bytes)
    {
        _storage.resize(bytes);
    }

    uint8* GetBasePointer() { return _storage.data(); }
    uint8* GetReadPointer() { return GetBasePointer() + _rpos; }
    uint8* GetWritePointer() { return GetBasePointer() + _wpos; }

    void ReadCompleted(size_type bytes) { _rpos += bytes; }
    void WriteCompleted(size_type bytes) { _wpos += bytes; }

    [[nodiscard]] size_type GetActiveSize() const { return _wpos - _rpos; }
    [[nodiscard]] size_type GetRemainingSpace() const { return _storage.size() - _wpos; }
    [[nodiscard]] size_type GetBufferSize() const { return _storage.size(); }

    // Discards inactive data
    void Normalize()
    {
        if (_rpos)
        {
            if (_rpos != _wpos)
            {
                memmove(GetBasePointer(), GetReadPointer(), GetActiveSize());
            }

            _wpos -= _rpos;
            _rpos = 0;
        }
    }

    // Ensures there's "some" free space, make sure to call Normalize() before this
    void EnsureFreeSpace()
    {
        // resize buffer if it's already full
        if (GetRemainingSpace() == 0)
        {
            _storage.resize(_storage.size() * 3 / 2);
        }
    }

    void Write(void const* data, std::size_t size)
    {
        if (size)
        {
            memcpy(GetWritePointer(), data, size);
            WriteCompleted(size);
        }
    }

    std::vector<uint8>&& Move()
    {
        _wpos = 0;
        _rpos = 0;

        return std::move(_storage);
    }

    MessageBuffer& operator=(MessageBuffer const& right)
    {
        if (this != &right)
        {
            _wpos = right._wpos;
            _rpos = right._rpos;
            _storage = right._storage;
        }

        return *this;
    }

    MessageBuffer& operator=(MessageBuffer&& right) noexcept
    {
        if (this != &right)
        {
            _wpos = right._wpos;
            _rpos = right._rpos;
            _storage = right.Move();
        }

        return *this;
    }

private:
    size_type _wpos;
    size_type _rpos;
    std::vector<uint8> _storage;
};

#endif /* __MESSAGEBUFFER_H_ */
