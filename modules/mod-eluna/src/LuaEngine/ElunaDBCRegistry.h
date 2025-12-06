#ifndef ELUNADBCREGISTRY_H
#define ELUNADBCREGISTRY_H

#include <string>
#include <vector>
#include <functional>
#include <typeinfo>

#include "DBCStores.h"
#include "LuaEngine.h"

struct DBCDefinition
{
    std::string name;
    void* storage;
    const std::type_info& type;
    std::function<const void*(uint32)> lookupFunction;
    std::function<void(lua_State*, const void*)> pushFunction;
};

extern std::vector<DBCDefinition> dbcRegistry;

#define REGISTER_DBC(dbcName, entryType, store) \
    {                                           \
        #dbcName,                               \
        reinterpret_cast<void*>(&store),        \
        typeid(DBCStorage<entryType>),          \
        [](uint32 id) -> const void* {          \
            return store.LookupEntry(id);       \
        },                                      \
        [](lua_State* L, const void* entry) {   \
            auto cast_entry = static_cast<const entryType*>(entry); \
            Eluna::Push(L, *cast_entry);        \
        }                                       \
    }

#endif // ELUNADBCREGISTRY_H

