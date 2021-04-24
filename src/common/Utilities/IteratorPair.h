/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef IteratorPair_h__
#define IteratorPair_h__

#include "Define.h"
#include <utility>

namespace acore
{
    /**
     * @class IteratorPair
     *
     * @brief Utility class to enable range for loop syntax for multimap.equal_range uses
     */
    template<class iterator>
    class IteratorPair
    {
    public:
        constexpr IteratorPair() : _iterators() { }
        constexpr IteratorPair(iterator first, iterator second) : _iterators(first, second) { }
        constexpr IteratorPair(std::pair<iterator, iterator> iterators) : _iterators(iterators) { }

        constexpr iterator begin() const { return _iterators.first; }
        constexpr iterator end() const { return _iterators.second; }

    private:
        std::pair<iterator, iterator> _iterators;
    };

    namespace Containers
    {
        template<class M>
        inline auto MapEqualRange(M& map, typename M::key_type const& key) -> IteratorPair<decltype(map.begin())>
        {
            return { map.equal_range(key) };
        }

        /*
         * Returns a pointer to mapped value (or the value itself if map stores pointers)
         */
        template<class M>
        inline auto MapGetValuePtr(M& map, typename M::key_type const& key) -> decltype(AddressOrSelf(map.find(key)->second))
        {
            auto itr = map.find(key);
            return itr != map.end() ? AddressOrSelf(itr->second) : nullptr;
        }
    }
    //! namespace Containers
}
//! namespace acore

#endif // IteratorPair_h__
