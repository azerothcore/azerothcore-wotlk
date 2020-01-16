/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_CONTAINERS_H
#define ACORE_CONTAINERS_H

#include "Define.h"
#include <algorithm>
#include <exception>
#include <iterator>
#include <utility>
#include <list>
#include <vector>

//! Because circular includes are bad
extern uint32 urand(uint32 min, uint32 max);
extern uint32 urandweighted(size_t count, double const* chances);

namespace acore
{
    template<class T>
    constexpr inline T* AddressOrSelf(T* ptr)
    {
        return ptr;
    }

    template<class T>
    constexpr inline T* AddressOrSelf(T& not_ptr)
    {
        return std::addressof(not_ptr);
    }

    template <class T>
    class CheckedBufferOutputIterator
    {
        public:
            using iterator_category = std::output_iterator_tag;
            using value_type = void;
            using pointer = T*;
            using reference = T&;
            using difference_type = std::ptrdiff_t;

            CheckedBufferOutputIterator(T* buf, size_t n) : _buf(buf), _end(buf+n) {}

            T& operator*() const { check(); return *_buf; }
            CheckedBufferOutputIterator& operator++() { check(); ++_buf; return *this; }
            CheckedBufferOutputIterator operator++(int) { CheckedBufferOutputIterator v = *this; operator++(); return v; }

            size_t remaining() const { return (_end - _buf); }

        private:
            T* _buf;
            T* _end;
            void check() const
            {
                if (!(_buf < _end))
                    throw std::out_of_range("index");
            }
    };

    namespace Containers
    {
        template<class T>
        void RandomResizeList(std::list<T> &list, uint32 size)
        {
            size_t list_size = list.size();

            while (list_size > size)
            {
                typename std::list<T>::iterator itr = list.begin();
                std::advance(itr, urand(0, list_size - 1));
                list.erase(itr);
                --list_size;
            }
        }

        template<class T, class Predicate>
        void RandomResizeList(std::list<T> &list, Predicate& predicate, uint32 size)
        {
            //! First use predicate filter
            std::list<T> listCopy;
            for (typename std::list<T>::iterator itr = list.begin(); itr != list.end(); ++itr)
                if (predicate(*itr))
                    listCopy.push_back(*itr);

            if (size)
                RandomResizeList(listCopy, size);

            list = listCopy;
        }

        /* Select a random element from a container. Note: make sure you explicitly empty check the container */
        template <class C> typename C::value_type const& SelectRandomContainerElement(C const& container)
        {
            typename C::const_iterator it = container.begin();
            std::advance(it, urand(0, container.size() - 1));
            return *it;
        }

        /*  Select a random element from a container where each element has a different chance to be selected. */
        template <class C> typename C::value_type const& SelectRandomWeightedContainerElement(C const& container, std::vector<double> const& weights)
        {
            typename C::const_iterator it = container.begin();
            std::advance(it, urandweighted(weights.size(), weights.data()));
            return *it;
        }
    }
    //! namespace Containers
}
//! namespace acore

#endif //! #ifdef ACORE_CONTAINERS_H
