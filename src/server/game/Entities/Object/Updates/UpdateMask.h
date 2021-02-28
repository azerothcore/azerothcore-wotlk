/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __UPDATEMASK_H
#define __UPDATEMASK_H

#include "ByteBuffer.h"
#include "Errors.h"
#include "UpdateFields.h"

class UpdateMask
{
public:
    /// Type representing how client reads update mask
    typedef uint32 ClientUpdateMaskType;

    enum UpdateMaskCount
    {
        CLIENT_UPDATE_MASK_BITS = sizeof(ClientUpdateMaskType) * 8,
    };

    UpdateMask()  { }

    UpdateMask(UpdateMask const& right) : _bits(nullptr)
    {
        SetCount(right.GetCount());
        memcpy(_bits, right._bits, sizeof(uint8) * _blockCount * 32);
    }

    ~UpdateMask() { delete[] _bits; }

    void SetBit(uint32 index) { _bits[index] = 1; }
    void UnsetBit(uint32 index) { _bits[index] = 0; }
    [[nodiscard]] bool GetBit(uint32 index) const { return _bits[index] != 0; }

    void AppendToPacket(ByteBuffer* data)
    {
        for (uint32 i = 0; i < GetBlockCount(); ++i)
        {
            ClientUpdateMaskType maskPart = 0;
            for (uint32 j = 0; j < CLIENT_UPDATE_MASK_BITS; ++j)
                if (_bits[CLIENT_UPDATE_MASK_BITS * i + j])
                    maskPart |= 1 << j;

            *data << maskPart;
        }
    }

    [[nodiscard]] uint32 GetBlockCount() const { return _blockCount; }
    [[nodiscard]] uint32 GetCount() const { return _fieldCount; }

    void SetCount(uint32 valuesCount)
    {
        delete[] _bits;

        _fieldCount = valuesCount;
        _blockCount = (valuesCount + CLIENT_UPDATE_MASK_BITS - 1) / CLIENT_UPDATE_MASK_BITS;

        _bits = new uint8[_blockCount * CLIENT_UPDATE_MASK_BITS];
        memset(_bits, 0, sizeof(uint8) * _blockCount * CLIENT_UPDATE_MASK_BITS);
    }

    void Clear()
    {
        if (_bits)
            memset(_bits, 0, sizeof(uint8) * _blockCount * CLIENT_UPDATE_MASK_BITS);
    }

    UpdateMask& operator=(UpdateMask const& right)
    {
        if (this == &right)
            return *this;

        SetCount(right.GetCount());
        memcpy(_bits, right._bits, sizeof(uint8) * _blockCount * CLIENT_UPDATE_MASK_BITS);
        return *this;
    }

    UpdateMask& operator&=(UpdateMask const& right)
    {
        ASSERT(right.GetCount() <= GetCount());
        for (uint32 i = 0; i < _fieldCount; ++i)
            _bits[i] &= right._bits[i];

        return *this;
    }

    UpdateMask& operator|=(UpdateMask const& right)
    {
        ASSERT(right.GetCount() <= GetCount());
        for (uint32 i = 0; i < _fieldCount; ++i)
            _bits[i] |= right._bits[i];

        return *this;
    }

    UpdateMask operator|(UpdateMask const& right)
    {
        UpdateMask ret(*this);
        ret |= right;
        return ret;
    }

private:
    uint32 _fieldCount{0};
    uint32 _blockCount{0};
    uint8* _bits{nullptr};
};

#endif
