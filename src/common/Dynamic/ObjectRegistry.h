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

#ifndef ACORE_OBJECTREGISTRY_H
#define ACORE_OBJECTREGISTRY_H

#include <map>
#include <memory>
#include <string>

/** ObjectRegistry holds all registry item of the same type
 */
template<class T, class Key = std::string>
class ObjectRegistry final
{
public:
    typedef std::map<Key, std::unique_ptr<T>> RegistryMapType;

    /// Returns a registry item
    T const* GetRegistryItem(Key const& key) const
    {
        auto itr = _registeredObjects.find(key);
        if (itr == _registeredObjects.end())
            return nullptr;
        return itr->second.get();
    }

    static ObjectRegistry<T, Key>* instance()
    {
        static ObjectRegistry<T, Key>* instance = new ObjectRegistry<T, Key>();
        return instance;
    }

    /// Inserts a registry item
    bool InsertItem(T* obj, Key const& key, bool force = false)
    {
        auto itr = _registeredObjects.find(key);
        if (itr != _registeredObjects.end())
        {
            if (!force)
            {
                return false;
            }
            _registeredObjects.erase(itr);
        }

        _registeredObjects.emplace(std::piecewise_construct, std::forward_as_tuple(key), std::forward_as_tuple(obj));
        return true;
    }

    /// Returns true if registry contains an item
    bool HasItem(Key const& key) const
    {
        return (_registeredObjects.count(key) > 0);
    }

    /// Return the map of registered items
    RegistryMapType const& GetRegisteredItems() const
    {
        return _registeredObjects;
    }

private:
    RegistryMapType _registeredObjects;

    // non instanceable, only static
    ObjectRegistry() { }
    ~ObjectRegistry() { }
};

#endif
