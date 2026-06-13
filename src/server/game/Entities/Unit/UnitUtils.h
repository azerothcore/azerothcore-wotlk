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

class MMapTargetData
{
public:
    MMapTargetData() = default;
    MMapTargetData(uint32 endTime, const Position* o, const Position* t)
    {
        _endTime = endTime;
        _posOwner.Relocate(o);
        _posTarget.Relocate(t);
    }
    MMapTargetData(const MMapTargetData& c)
    {
        _endTime = c._endTime;
        _posOwner.Relocate(c._posOwner);
        _posTarget.Relocate(c._posTarget);
    }
    MMapTargetData(MMapTargetData&&) = default;
    MMapTargetData& operator=(const MMapTargetData&) = default;
    MMapTargetData& operator=(MMapTargetData&&) = default;
    [[nodiscard]] bool PosChanged(const Position& o, const Position& t) const
    {
        return _posOwner.GetExactDistSq(&o) > 0.5f * 0.5f || _posTarget.GetExactDistSq(&t) > 0.5f * 0.5f;
    }
    uint32 _endTime;
    Position _posOwner;
    Position _posTarget;
};

class SafeUnitPointer
{
public:
    explicit SafeUnitPointer(Unit* defVal) : ptr(defVal), defaultValue(defVal) {}
    SafeUnitPointer(const SafeUnitPointer& /*p*/) { ABORT(); }
    void Initialize(Unit* defVal) { defaultValue = defVal; ptr = defVal; }
    ~SafeUnitPointer();
    void SetPointedTo(Unit* u);
    void UnitDeleted();
    Unit* operator->() const { return ptr; }
    void operator=(Unit* u) { SetPointedTo(u); }
    operator Unit* () const { return ptr; }
private:
    Unit* ptr;
    Unit* defaultValue;
};

// BuildValuesCachePosPointers is marks of the position of some data inside of BuildValue cache.
struct BuildValuesCachePosPointers
{
    BuildValuesCachePosPointers() :
        UnitNPCFlagsPos(-1), UnitFieldAuraStatePos(-1), UnitFieldFlagsPos(-1), UnitFieldDisplayPos(-1),
        UnitDynamicFlagsPos(-1), UnitFieldBytes2Pos(-1), UnitFieldFactionTemplatePos(-1) {}

    void ApplyOffset(uint32 offset)
    {
        if (UnitNPCFlagsPos >= 0)
            UnitNPCFlagsPos += offset;

        if (UnitFieldAuraStatePos >= 0)
            UnitFieldAuraStatePos += offset;

        if (UnitFieldFlagsPos >= 0)
            UnitFieldFlagsPos += offset;

        if (UnitFieldDisplayPos >= 0)
            UnitFieldDisplayPos += offset;

        if (UnitDynamicFlagsPos >= 0)
            UnitDynamicFlagsPos += offset;

        if (UnitFieldBytes2Pos >= 0)
            UnitFieldBytes2Pos += offset;

        if (UnitFieldFactionTemplatePos >= 0)
            UnitFieldFactionTemplatePos += offset;

        for (auto it = other.begin(); it != other.end(); ++it)
            it->second += offset;
    }

    int32 UnitNPCFlagsPos;
    int32 UnitFieldAuraStatePos;
    int32 UnitFieldFlagsPos;
    int32 UnitFieldDisplayPos;
    int32 UnitDynamicFlagsPos;
    int32 UnitFieldBytes2Pos;
    int32 UnitFieldFactionTemplatePos;

    std::unordered_map<uint16 /*index*/, uint32 /*pos*/> other;
};

// BuildValuesCachedBuffer cache for calculated BuildValue.
struct BuildValuesCachedBuffer
{
    BuildValuesCachedBuffer(uint32 bufferSize) :
        buffer(bufferSize), posPointers() {}

    ByteBuffer buffer;

    BuildValuesCachePosPointers posPointers;
};
