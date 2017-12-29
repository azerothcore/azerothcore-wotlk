/*
 * Copyright (C) 2008-2017 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _DATA_MAP_H_
#define _DATA_MAP_H_

#include "Define.h"
#include <string>
#include <unordered_map>
#include <memory>

class TC_COMMON_API DataMap
{
public:
    class Base
    {
    public:
        virtual ~Base() = default;
    };

    template<class T> T* GetCustomData(std::string const & k) const {
        static_assert(std::is_base_of<Base, T>::value, "T must derive from Base");
        auto it = Container.find(k);
        if (it != Container.end())
            return dynamic_cast<T*>(it->second.get());
        return nullptr;
    }
    void SetCustomData(std::string const & k, Base* v) { Container[k] = std::unique_ptr<Base>(v); }

private:
    std::unordered_map<std::string, std::unique_ptr<Base>> Container;
};

#endif
