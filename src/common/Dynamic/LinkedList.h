/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _LINKEDLIST
#define _LINKEDLIST

#include "Define.h"
#include <iterator>

//============================================
class LinkedListHead;

class LinkedListElement
{
private:
    friend class LinkedListHead;

    LinkedListElement* iNext{nullptr};
    LinkedListElement* iPrev{nullptr};
public:
    LinkedListElement() = default;
    ~LinkedListElement() { delink(); }

    [[nodiscard]] auto hasNext() const -> bool { return (iNext && iNext->iNext != nullptr); }
    [[nodiscard]] auto hasPrev() const -> bool { return (iPrev && iPrev->iPrev != nullptr); }
    [[nodiscard]] auto isInList() const -> bool { return (iNext != nullptr && iPrev != nullptr); }

    auto       next() -> LinkedListElement*       { return hasNext() ? iNext : nullptr; }
    [[nodiscard]] auto next() const -> LinkedListElement const* { return hasNext() ? iNext : nullptr; }
    auto       prev() -> LinkedListElement*       { return hasPrev() ? iPrev : nullptr; }
    [[nodiscard]] auto prev() const -> LinkedListElement const* { return hasPrev() ? iPrev : nullptr; }

    auto       nocheck_next() -> LinkedListElement*       { return iNext; }
    [[nodiscard]] auto nocheck_next() const -> LinkedListElement const* { return iNext; }
    auto       nocheck_prev() -> LinkedListElement*       { return iPrev; }
    [[nodiscard]] auto nocheck_prev() const -> LinkedListElement const* { return iPrev; }

    void delink()
    {
        if (isInList())
        {
            iNext->iPrev = iPrev;
            iPrev->iNext = iNext;
            iNext = nullptr;
            iPrev = nullptr;
        }
    }

    void insertBefore(LinkedListElement* pElem)
    {
        pElem->iNext = this;
        pElem->iPrev = iPrev;
        iPrev->iNext = pElem;
        iPrev = pElem;
    }

    void insertAfter(LinkedListElement* pElem)
    {
        pElem->iPrev = this;
        pElem->iNext = iNext;
        iNext->iPrev = pElem;
        iNext = pElem;
    }
};

//============================================

class LinkedListHead
{
private:
    LinkedListElement iFirst;
    LinkedListElement iLast;
    uint32 iSize{0};
public:
    LinkedListHead()
    {
        // create empty list

        iFirst.iNext = &iLast;
        iLast.iPrev = &iFirst;
    }

    [[nodiscard]] auto isEmpty() const -> bool { return (!iFirst.iNext->isInList()); }

    auto       getFirst() -> LinkedListElement*       { return (isEmpty() ? nullptr : iFirst.iNext); }
    [[nodiscard]] auto getFirst() const -> LinkedListElement const* { return (isEmpty() ? nullptr : iFirst.iNext); }

    auto       getLast() -> LinkedListElement* { return (isEmpty() ? nullptr : iLast.iPrev); }
    [[nodiscard]] auto getLast() const -> LinkedListElement const*  { return (isEmpty() ? nullptr : iLast.iPrev); }

    void insertFirst(LinkedListElement* pElem)
    {
        iFirst.insertAfter(pElem);
    }

    void insertLast(LinkedListElement* pElem)
    {
        iLast.insertBefore(pElem);
    }

    [[nodiscard]] auto getSize() const -> uint32
    {
        if (!iSize)
        {
            uint32 result = 0;
            LinkedListElement const* e = getFirst();
            while (e)
            {
                ++result;
                e = e->next();
            }
            return result;
        }
        else
        {
            return iSize;
        }
    }

    void incSize() { ++iSize; }
    void decSize() { --iSize; }

    template<class _Ty>
    class Iterator
    {
    public:
        typedef std::bidirectional_iterator_tag     iterator_category;
        typedef _Ty                                 value_type;
        typedef ptrdiff_t                           difference_type;
        typedef ptrdiff_t                           distance_type;
        typedef _Ty*                                pointer;
        typedef _Ty const*                          const_pointer;
        typedef _Ty&                                reference;
        typedef _Ty const&                          const_reference;

        Iterator() : _Ptr(0)
        {
            // construct with null node pointer
        }

        Iterator(pointer _Pnode) : _Ptr(_Pnode)
        {
            // construct with node pointer _Pnode
        }

        auto operator=(Iterator const& _Right) -> Iterator&
        {
            _Ptr = _Right._Ptr;
            return *this;
        }

        auto operator=(const_pointer const& _Right) -> Iterator&
        {
            _Ptr = pointer(_Right);
            return *this;
        }

        auto operator*() -> reference
        {
            // return designated value
            return *_Ptr;
        }

        auto operator->() -> pointer
        {
            // return pointer to class object
            return _Ptr;
        }

        auto operator++() -> Iterator&
        {
            // preincrement
            _Ptr = _Ptr->next();
            return (*this);
        }

        auto operator++(int) -> Iterator
        {
            // postincrement
            iterator _Tmp = *this;
            ++*this;
            return (_Tmp);
        }

        auto operator--() -> Iterator&
        {
            // predecrement
            _Ptr = _Ptr->prev();
            return (*this);
        }

        auto operator--(int) -> Iterator
        {
            // postdecrement
            iterator _Tmp = *this;
            --*this;
            return (_Tmp);
        }

        auto operator==(Iterator const& _Right) const -> bool
        {
            // test for iterator equality
            return (_Ptr == _Right._Ptr);
        }

        auto operator!=(Iterator const& _Right) const -> bool
        {
            // test for iterator inequality
            return (!(*this == _Right));
        }

        auto operator==(pointer const& _Right) const -> bool
        {
            // test for pointer equality
            return (_Ptr != _Right);
        }

        auto operator!=(pointer const& _Right) const -> bool
        {
            // test for pointer equality
            return (!(*this == _Right));
        }

        auto operator==(const_reference _Right) const -> bool
        {
            // test for reference equality
            return (_Ptr == &_Right);
        }

        auto operator!=(const_reference _Right) const -> bool
        {
            // test for reference equality
            return (_Ptr != &_Right);
        }

        auto _Mynode() -> pointer
        {
            // return node pointer
            return (_Ptr);
        }

    protected:
        pointer _Ptr;                               // pointer to node
    };

    typedef Iterator<LinkedListElement> iterator;
};

//============================================
#endif
