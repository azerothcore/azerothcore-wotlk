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

#ifndef _REFERENCE_H
#define _REFERENCE_H

#include "Dynamic/LinkedList.h"
#include "Errors.h" // for ASSERT

//=====================================================

template <class TO, class FROM> class Reference : public LinkedListElement
{
private:
    TO* iRefTo;
    FROM* iRefFrom;
protected:
    // Tell our refTo (target) object that we have a link
    virtual void targetObjectBuildLink() = 0;

    // Tell our refTo (taget) object, that the link is cut
    virtual void targetObjectDestroyLink() = 0;

    // Tell our refFrom (source) object, that the link is cut (Target destroyed)
    virtual void sourceObjectDestroyLink() = 0;
public:
    Reference() { iRefTo = nullptr; iRefFrom = nullptr; }
    virtual ~Reference() = default;

    // Create new link
    void link(TO* toObj, FROM* fromObj)
    {
        ASSERT(fromObj);                                // fromObj MUST not be nullptr
        if (isValid())
        {
            unlink();
        }
        if (toObj != nullptr)
        {
            iRefTo = toObj;
            iRefFrom = fromObj;
            targetObjectBuildLink();
        }
    }

    // We don't need the reference anymore. Call comes from the refFrom object
    // Tell our refTo object, that the link is cut
    void unlink()
    {
        targetObjectDestroyLink();
        delink();
        iRefTo = nullptr;
        iRefFrom = nullptr;
    }

    // Link is invalid due to destruction of referenced target object. Call comes from the refTo object
    // Tell our refFrom object, that the link is cut
    void invalidate()                                   // the iRefFrom MUST remain!!
    {
        sourceObjectDestroyLink();
        delink();
        iRefTo = nullptr;
    }

    [[nodiscard]] auto isValid() const -> bool                                // Only check the iRefTo
    {
        return iRefTo != nullptr;
    }

    auto        next() -> Reference<TO, FROM>*       { return ((Reference<TO, FROM>*) LinkedListElement::next()); }
    [[nodiscard]] auto next() const -> Reference<TO, FROM> const* { return ((Reference<TO, FROM> const*) LinkedListElement::next()); }
    auto        prev() -> Reference<TO, FROM>*       { return ((Reference<TO, FROM>*) LinkedListElement::prev()); }
    [[nodiscard]] auto prev() const -> Reference<TO, FROM> const* { return ((Reference<TO, FROM> const*) LinkedListElement::prev()); }

    auto        nocheck_next() -> Reference<TO, FROM>*       { return ((Reference<TO, FROM>*) LinkedListElement::nocheck_next()); }
    [[nodiscard]] auto nocheck_next() const -> Reference<TO, FROM> const* { return ((Reference<TO, FROM> const*) LinkedListElement::nocheck_next()); }
    auto        nocheck_prev() -> Reference<TO, FROM>*       { return ((Reference<TO, FROM>*) LinkedListElement::nocheck_prev()); }
    [[nodiscard]] auto nocheck_prev() const -> Reference<TO, FROM> const* { return ((Reference<TO, FROM> const*) LinkedListElement::nocheck_prev()); }

    auto operator ->() const -> TO* { return iRefTo; }
    [[nodiscard]] auto getTarget() const -> TO* { return iRefTo; }

    [[nodiscard]] auto GetSource() const -> FROM* { return iRefFrom; }
};

//=====================================================
#endif
