/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 */

#ifndef _DATA_MAP_H_
#define _DATA_MAP_H_

#include <string>
#include <unordered_map>
#include <memory>

class DataMap
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
