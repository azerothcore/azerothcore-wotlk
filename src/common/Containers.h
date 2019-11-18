/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_CONTAINERS_H
#define ACORE_CONTAINERS_H

#include "Define.h"
#include "Random.h"
#include <algorithm>
#include <exception>
#include <iterator>
#include <utility>
#include <list>
#include <vector>

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

        // resizes <container> to have at most <requestedSize> elements
        // if it has more than <requestedSize> elements, the elements to keep are selected randomly
        template<class C>
        void RandomResize(C& container, std::size_t requestedSize)
        {
            static_assert(std::is_base_of<std::forward_iterator_tag, typename std::iterator_traits<typename C::iterator>::iterator_category>::value, "Invalid container passed to Trinity::Containers::RandomResize");
            if (std::size(container) <= requestedSize)
                return;
            auto keepIt = std::begin(container), curIt = std::begin(container);
            uint32 elementsToKeep = requestedSize, elementsToProcess = std::size(container);
            while (elementsToProcess)
            {
                // this element has chance (elementsToKeep / elementsToProcess) of being kept
                if (urand(1, elementsToProcess) <= elementsToKeep)
                {
                    if (keepIt != curIt)
                        *keepIt = std::move(*curIt);
                    ++keepIt;
                    --elementsToKeep;
                }
                ++curIt;
                --elementsToProcess;
            }
            container.erase(keepIt, std::end(container));
        }

        /*
         * Select a random element from a container.
         *
         * Note: container cannot be empty
         */
        template <class C>
        typename C::value_type const& SelectRandomContainerElement(C const& container)
        {
            typename C::const_iterator it = container.begin();
            std::advance(it, urand(0, container.size() - 1));
            return *it;
        }

        /*
         * Select a random element from a container where each element has a different chance to be selected.
         *
         * @param container Container to select an element from
         * @param weights Chances of each element to be selected, must be in the same order as elements in container.
         *                Caller is responsible for checking that sum of all weights is greater than 0.
         *
         * Note: container cannot be empty
         */
        template<class C>
        inline auto SelectRandomWeightedContainerElement(C const& container, std::vector<double> weights) -> decltype(std::begin(container))
        {
            auto it = std::begin(container);
            std::advance(it, urandweighted(weights.size(), weights.data()));
            return it;
        }

        /*
         * Select a random element from a container where each element has a different chance to be selected.
         *
         * @param container Container to select an element from
         * @param weightExtractor Function retrieving chance of each element in container, expected to take an element of the container and returning a double
         *
         * Note: container cannot be empty
         */
        template<class C, class Fn>
        auto SelectRandomWeightedContainerElement(C const& container, Fn weightExtractor) -> decltype(std::begin(container))
        {
            std::vector<double> weights;
            weights.reserve(std::size(container));
            double weightSum = 0.0;
            for (auto& val : container)
            {
                double weight = weightExtractor(val);
                weights.push_back(weight);
                weightSum += weight;
            }
            if (weightSum <= 0.0)
                weights.assign(std::size(container), 1.0);

            return SelectRandomWeightedContainerElement(container, weights);
        }

        /**
         * @fn void acore::Containers::RandomShuffle(C& container)
         *
         * @brief Reorder the elements of the container randomly.
         *
         * @param container Container to reorder
         */
        template<class C>
        inline void RandomShuffle(C& container)
        {
            std::shuffle(std::begin(container), std::end(container), RandomEngine::Instance());
        }

        /**
         * @fn bool acore::Containers::Intersects(Iterator first1, Iterator last1, Iterator first2, Iterator last2)
         *
         * @brief Checks if two SORTED containers have a common element
         *
         * @param first1 Iterator pointing to start of the first container
         * @param last1 Iterator pointing to end of the first container
         * @param first2 Iterator pointing to start of the second container
         * @param last2 Iterator pointing to end of the second container
         *
         * @return true if containers have a common element, false otherwise.
        */
        template<class Iterator1, class Iterator2>
        bool Intersects(Iterator1 first1, Iterator1 last1, Iterator2 first2, Iterator2 last2)
        {
            while (first1 != last1 && first2 != last2)
            {
                if (*first1 < *first2)
                    ++first1;
                else if (*first2 < *first1)
                    ++first2;
                else
                    return true;
            }

            return false;
        }

        /**
         * Returns a pointer to mapped value (or the value itself if map stores pointers)
         */
        template<class M>
        inline auto MapGetValuePtr(M& map, typename M::key_type const& key) -> decltype(AddressOrSelf(map.find(key)->second))
        {
            auto itr = map.find(key);
            return itr != map.end() ? AddressOrSelf(itr->second) : nullptr;
        }

        template<class K, class V, template<class, class, class...> class M, class... Rest>
        void MultimapErasePair(M<K, V, Rest...>& multimap, K const& key, V const& value)
        {
            auto range = multimap.equal_range(key);
            for (auto itr = range.first; itr != range.second;)
            {
                if (itr->second == value)
                    itr = multimap.erase(itr);
                else
                    ++itr;
            }
        }
    }
    //! namespace Containers
}
//! namespace acore

#endif //! #ifdef ACORE_CONTAINERS_H
