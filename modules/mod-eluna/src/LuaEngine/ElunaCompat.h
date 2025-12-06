/*
 * Copyright (C) 2010 - 2024 Eluna Lua Engine <https://elunaluaengine.github.io/>
 * This program is free software licensed under GPL version 3
 * Please see the included DOCS/LICENSE.md for more information
 */

#ifndef ELUNACOMPAT_H
#define ELUNACOMPAT_H

extern "C"
{
#include "lua.h"
#include "lauxlib.h"
};

/* Compatibility layer for compiling with Lua 5.1 or LuaJIT */
#if LUA_VERSION_NUM == 501
    int luaL_getsubtable(lua_State* L, int i, const char* name);
    const char* luaL_tolstring(lua_State* L, int idx, size_t* len);
    int lua_absindex(lua_State* L, int i);
    #define lua_pushglobaltable(L) \
        lua_pushvalue((L), LUA_GLOBALSINDEX)
    #define lua_rawlen(L, idx) \
        lua_objlen(L, idx)
    #define lua_pushunsigned(L, u) \
        lua_pushinteger(L, u)
    #define lua_load(L, buf_read, dec_buf, str, NULL) \
        lua_load(L, buf_read, dec_buf, str)

#if !defined LUAJIT_VERSION
    void* luaL_testudata(lua_State* L, int index, const char* tname);
    void luaL_setmetatable(lua_State* L, const char* tname);
    #define luaL_setfuncs(L, l, n) luaL_register(L, NULL, l)
#endif
#endif

#if LUA_VERSION_NUM > 502
    #define lua_dump(L, writer, data) \
        lua_dump(L, writer, data, 0)
    #define lua_pushunsigned(L, u) \
        lua_pushinteger(L, u)
#endif
#endif
