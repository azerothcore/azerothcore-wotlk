/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _POSITION_H
#define _POSITION_H

#include "Common.h"

class ByteBuffer;

struct Position
{
    Position(float x = 0, float y = 0, float z = 0, float o = 0)
        : m_positionX(x), m_positionY(y), m_positionZ(z), m_orientation(NormalizeOrientation(o)) { }

    Position(Position const& loc) { Relocate(loc); }

    /* requried as of C++ 11 */
#if __cplusplus >= 201103L
    Position(Position&&) = default;
    Position& operator=(const Position&) = default;
    Position& operator=(Position&&) = default;
#endif

    struct PositionXYStreamer
    {
        explicit PositionXYStreamer(Position& pos) : Pos(&pos) { }
        Position* Pos;
    };

    struct PositionXYZStreamer
    {
        explicit PositionXYZStreamer(Position& pos) : m_pos(&pos) {}
        Position* m_pos;
    };

    struct PositionXYZOStreamer
    {
        explicit PositionXYZOStreamer(Position& pos) : m_pos(&pos) {}
        Position* m_pos;
    };

    float m_positionX = 0;
    float m_positionY = 0;
    float m_positionZ = 0;
    float m_orientation = 0;

    bool operator==(Position const& a);

    inline bool operator!=(Position const& a)
    {
        return !(operator==(a));
    }

    void Relocate(float x, float y)
    {
        m_positionX = x;
        m_positionY = y;
    }
    void Relocate(float x, float y, float z)
    {
        m_positionX = x;
        m_positionY = y;
        m_positionZ = z;
    }
    void Relocate(float x, float y, float z, float orientation)
    {
        m_positionX = x;
        m_positionY = y;
        m_positionZ = z;
        m_orientation = orientation;
    }
    void Relocate(const Position& pos)
    {
        m_positionX = pos.m_positionX;
        m_positionY = pos.m_positionY;
        m_positionZ = pos.m_positionZ;
        m_orientation = pos.m_orientation;
    }
    void Relocate(const Position* pos)
    {
        m_positionX = pos->m_positionX;
        m_positionY = pos->m_positionY;
        m_positionZ = pos->m_positionZ;
        m_orientation = pos->m_orientation;
    }
    void RelocatePolarOffset(float angle, float dist, float z = 0.0f);
    void RelocateOffset(const Position& offset);
    void SetOrientation(float orientation)
    {
        m_orientation = orientation;
    }

    [[nodiscard]] float GetPositionX() const { return m_positionX; }
    [[nodiscard]] float GetPositionY() const { return m_positionY; }
    [[nodiscard]] float GetPositionZ() const { return m_positionZ; }
    [[nodiscard]] float GetOrientation() const { return m_orientation; }

    void GetPosition(float& x, float& y) const
    {
        x = m_positionX;
        y = m_positionY;
    }
    void GetPosition(float& x, float& y, float& z) const
    {
        x = m_positionX;
        y = m_positionY;
        z = m_positionZ;
    }
    void GetPosition(float& x, float& y, float& z, float& o) const
    {
        x = m_positionX;
        y = m_positionY;
        z = m_positionZ;
        o = m_orientation;
    }
    void GetPosition(Position* pos) const
    {
        if (pos)
            pos->Relocate(m_positionX, m_positionY, m_positionZ, m_orientation);
    }

    [[nodiscard]] Position GetPosition() const { return *this; }


    Position::PositionXYZStreamer PositionXYZStream()
    {
        return PositionXYZStreamer(*this);
    }
    Position::PositionXYZOStreamer PositionXYZOStream()
    {
        return PositionXYZOStreamer(*this);
    }

    [[nodiscard]] bool IsPositionValid() const;

    [[nodiscard]] float GetExactDist2dSq(float x, float y) const
    {
        float dx = m_positionX - x;
        float dy = m_positionY - y;
        return dx * dx + dy * dy;
    }
    [[nodiscard]] float GetExactDist2d(const float x, const float y) const
    {
        return sqrt(GetExactDist2dSq(x, y));
    }
    float GetExactDist2dSq(const Position* pos) const
    {
        float dx = m_positionX - pos->m_positionX;
        float dy = m_positionY - pos->m_positionY;
        return dx * dx + dy * dy;
    }
    float GetExactDist2d(const Position* pos) const
    {
        return sqrt(GetExactDist2dSq(pos));
    }
    [[nodiscard]] float GetExactDistSq(float x, float y, float z) const
    {
        float dz = m_positionZ - z;
        return GetExactDist2dSq(x, y) + dz * dz;
    }
    [[nodiscard]] float GetExactDist(float x, float y, float z) const
    {
        return sqrt(GetExactDistSq(x, y, z));
    }
    float GetExactDistSq(const Position* pos) const
    {
        float dx = m_positionX - pos->m_positionX;
        float dy = m_positionY - pos->m_positionY;
        float dz = m_positionZ - pos->m_positionZ;
        return dx * dx + dy * dy + dz * dz;
    }
    float GetExactDist(const Position* pos) const
    {
        return sqrt(GetExactDistSq(pos));
    }

    void GetPositionOffsetTo(const Position& endPos, Position& retOffset) const;

    float GetAngle(const Position* pos) const;
    [[nodiscard]] float GetAngle(float x, float y) const;
    float GetRelativeAngle(const Position* pos) const
    {
        return GetAngle(pos) - m_orientation;
    }
    [[nodiscard]] float GetRelativeAngle(float x, float y) const { return GetAngle(x, y) - m_orientation; }
    void GetSinCos(float x, float y, float& vsin, float& vcos) const;

    [[nodiscard]] bool IsInDist2d(float x, float y, float dist) const
    {
        return GetExactDist2dSq(x, y) < dist * dist;
    }
    bool IsInDist2d(const Position* pos, float dist) const
    {
        return GetExactDist2dSq(pos) < dist * dist;
    }
    [[nodiscard]] bool IsInDist(float x, float y, float z, float dist) const
    {
        return GetExactDistSq(x, y, z) < dist * dist;
    }
    bool IsInDist(const Position* pos, float dist) const
    {
        return GetExactDistSq(pos) < dist * dist;
    }

    [[nodiscard]] bool IsWithinBox(const Position& center, float xradius, float yradius, float zradius) const;
    bool HasInArc(float arcangle, const Position* pos, float targetRadius = 0.0f) const;
    bool HasInLine(WorldObject const* target, float width) const;
    [[nodiscard]] std::string ToString() const;

    // modulos a radian orientation to the range of 0..2PI
    static float NormalizeOrientation(float o)
    {
        // fmod only supports positive numbers. Thus we have
        // to emulate negative numbers
        if (o < 0)
        {
            float mod = o * -1;
            mod = fmod(mod, 2.0f * static_cast<float>(M_PI));
            mod = -mod + 2.0f * static_cast<float>(M_PI);
            return mod;
        }
        return fmod(o, 2.0f * static_cast<float>(M_PI));
    }
};

ByteBuffer& operator<<(ByteBuffer& buf, Position::PositionXYStreamer const& streamer);
ByteBuffer& operator >> (ByteBuffer& buf, Position::PositionXYStreamer const& streamer);
ByteBuffer& operator<<(ByteBuffer& buf, Position::PositionXYZStreamer const& streamer);
ByteBuffer& operator >> (ByteBuffer& buf, Position::PositionXYZStreamer const& streamer);
ByteBuffer& operator<<(ByteBuffer& buf, Position::PositionXYZOStreamer const& streamer);
ByteBuffer& operator >> (ByteBuffer& buf, Position::PositionXYZOStreamer const& streamer);


#endif
