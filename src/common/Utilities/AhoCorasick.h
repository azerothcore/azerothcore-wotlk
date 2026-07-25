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

#ifndef AhoCorasick_h__
#define AhoCorasick_h__

#include "Define.h"
#include <queue>
#include <string>
#include <string_view>
#include <unordered_map>
#include <vector>

namespace Acore
{
    /**
     * @class AhoCorasick
     *
     * @brief Multi-pattern substring matcher.
     *
     * Insert all patterns, call Build() once, then query in O(text length)
     * regardless of pattern count. Insertion after Build() is not supported
     * (it would invalidate failure links — call Build() again if you must).
     *
     * Matching is exact on the @p CharT alphabet — pre-lowercase patterns and
     * inputs in the caller if you need case-insensitive matching.
     *
     * Usage:
     *   Acore::AhoCorasick<wchar_t> a;
     *   a.Insert(L"foo");
     *   a.Insert(L"bar");
     *   a.Build();
     *   bool hit = a.ContainsAny(L"the bar is open"); // -> true
     */
    template<typename CharT>
    class AhoCorasick
    {
    public:
        using StringType = std::basic_string<CharT>;
        using StringViewType = std::basic_string_view<CharT>;

        AhoCorasick() { _nodes.emplace_back(); }

        void Insert(StringViewType pattern)
        {
            if (pattern.empty())
                return;

            uint32 cur = 0;
            for (CharT c : pattern)
            {
                auto it = _nodes[cur].next.find(c);
                if (it != _nodes[cur].next.end())
                {
                    cur = it->second;
                    continue;
                }

                uint32 idx = static_cast<uint32>(_nodes.size());
                _nodes.emplace_back();
                _nodes[cur].next.emplace(c, idx);
                cur = idx;
            }
            _nodes[cur].output = true;
        }

        void Build()
        {
            std::queue<uint32> bfs;
            for (auto const& kv : _nodes[0].next)
            {
                _nodes[kv.second].fail = 0;
                bfs.push(kv.second);
            }

            while (!bfs.empty())
            {
                uint32 u = bfs.front();
                bfs.pop();

                for (auto const& kv : _nodes[u].next)
                {
                    CharT c = kv.first;
                    uint32 v = kv.second;

                    uint32 f = _nodes[u].fail;
                    while (f != 0 && _nodes[f].next.find(c) == _nodes[f].next.end())
                        f = _nodes[f].fail;

                    auto it = _nodes[f].next.find(c);
                    _nodes[v].fail = (it != _nodes[f].next.end() && it->second != v) ? it->second : 0;

                    if (_nodes[_nodes[v].fail].output)
                        _nodes[v].output = true;

                    bfs.push(v);
                }
            }
        }

        [[nodiscard]] bool ContainsAny(StringViewType text) const
        {
            if (_nodes.size() <= 1)
                return false;

            uint32 cur = 0;
            for (CharT c : text)
            {
                while (cur != 0 && _nodes[cur].next.find(c) == _nodes[cur].next.end())
                    cur = _nodes[cur].fail;

                auto it = _nodes[cur].next.find(c);
                if (it != _nodes[cur].next.end())
                    cur = it->second;

                if (_nodes[cur].output)
                    return true;
            }
            return false;
        }

        [[nodiscard]] bool Empty() const { return _nodes.size() <= 1; }

        void Clear()
        {
            _nodes.clear();
            _nodes.emplace_back();
        }

    private:
        struct Node
        {
            std::unordered_map<CharT, uint32> next;
            uint32 fail = 0;
            bool output = false;
        };

        std::vector<Node> _nodes;
    };
}
//! namespace Acore

#endif // AhoCorasick_h__
