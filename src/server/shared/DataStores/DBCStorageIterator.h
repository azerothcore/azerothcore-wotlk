/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2020 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DBCStorageIterator_h__
#define DBCStorageIterator_h__

#include "Define.h"
#include <iterator>

template <class T>
class DBCStorageIterator : public std::iterator<std::forward_iterator_tag, T>
{
public:
    DBCStorageIterator() : _index(nullptr) { }
    DBCStorageIterator(T** index, uint32 size, uint32 pos = 0) : _index(index), _pos(pos), _end(size)
    {
        if (_pos < _end)
        {
            while (_pos < _end && !_index[_pos])
                ++_pos;
        }
    }

    T const* operator->() { return _index[_pos]; }
    T const* operator*() { return _index[_pos]; }

    bool operator==(DBCStorageIterator const& right) const { /*ASSERT(_index == right._index, "Iterator belongs to a different container")*/ return _pos == right._pos; }
    bool operator!=(DBCStorageIterator const& right) const { return !(*this == right); }

    DBCStorageIterator& operator++()
    {
        if (_pos < _end)
        {
            do
                ++_pos;
            while (_pos < _end && !_index[_pos]);
        }

        return *this;
    }

    DBCStorageIterator operator++(int)
    {
        DBCStorageIterator tmp = *this;
        ++*this;
        return tmp;
    }

private:
    T** _index;
    uint32 _pos{0};
    uint32 _end{0};
};

#endif // DBCStorageIterator_h__
