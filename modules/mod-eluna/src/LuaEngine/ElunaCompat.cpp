/*
 * Copyright (C) 2010 - 2024 Eluna Lua Engine <https://elunaluaengine.github.io/>
 * This program is free software licensed under GPL version 3
 * Please see the included DOCS/LICENSE.md for more information
 */

#include "ElunaCompat.h"

#if LUA_VERSION_NUM == 501
const char* luaL_tolstring(lua_State* L, int idx, size_t* len) {
    if (!luaL_callmeta(L, idx, "__tostring")) {
        int t = lua_type(L, idx), tt = 0;
        char const* name = NULL;
        switch (t) {
        case LUA_TNIL:
            lua_pushliteral(L, "nil");
            break;
        case LUA_TSTRING:
        case LUA_TNUMBER:
            lua_pushvalue(L, idx);
            break;
        case LUA_TBOOLEAN:
            if (lua_toboolean(L, idx))
                lua_pushliteral(L, "true");
            else
                lua_pushliteral(L, "false");
            break;
        default:
            tt = luaL_getmetafield(L, idx, "__name");
            name = (tt == LUA_TSTRING) ? lua_tostring(L, -1) : lua_typename(L, t);
            lua_pushfstring(L, "%s: %p", name, lua_topointer(L, idx));
            if (tt != LUA_TNIL)
                lua_replace(L, -2);
            break;
        }
    }
    else {
        if (!lua_isstring(L, -1))
            luaL_error(L, "'__tostring' must return a string");
    }
    return lua_tolstring(L, -1, len);
}

int luaL_getsubtable(lua_State* L, int i, const char* name) {
    int abs_i = lua_absindex(L, i);
    luaL_checkstack(L, 3, "not enough stack slots");
    lua_pushstring(L, name);
    lua_gettable(L, abs_i);
    if (lua_istable(L, -1))
        return 1;
    lua_pop(L, 1);
    lua_newtable(L);
    lua_pushstring(L, name);
    lua_pushvalue(L, -2);
    lua_settable(L, abs_i);
    return 0;
}

int lua_absindex(lua_State* L, int i) {
    if (i < 0 && i > LUA_REGISTRYINDEX)
        i += lua_gettop(L) + 1;
    return i;
}

#if !defined LUAJIT_VERSION
void* luaL_testudata(lua_State* L, int index, const char* tname) {
    void* ud = lua_touserdata(L, index);
    if (ud)
    {
        if (lua_getmetatable(L, index))
        {
            luaL_getmetatable(L, tname);
            if (!lua_rawequal(L, -1, -2))
                ud = NULL;
            lua_pop(L, 2);
            return ud;
        }
    }
    return NULL;
}

void luaL_setmetatable(lua_State* L, const char* tname) {
    lua_pushstring(L, tname);
    lua_rawget(L, LUA_REGISTRYINDEX);
    lua_setmetatable(L, -2);
}
#endif
#endif
