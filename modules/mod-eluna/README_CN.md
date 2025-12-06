### [![Eluna](src/LuaEngine/docs/Eluna.png)](https://github.com/ElunaLuaEngine/Eluna)

## 关于

Eluna Lua Engine &copy; 是嵌入到魔兽世界模拟器中的lua引擎。 Eluna支持MaNGOS，CMaNGOS，TrinityCore和AzerothCore。
我们目前正在努力使Eluna从内到外变得更好。

如果您在安装或脚本方面遇到问题，请随时提出问题。
有关文档和参考，请参阅[Eluna API (AC版)](https://www.azerothcore.org/pages/eluna/index.html) and [Lua 参考手册](http://www.lua.org/manual/5.2/).


## 社区

您可以加入官方的Eluna Discord服务器，在那里您将能够找到社区提供的资源，版本和支持：
<a href="https://discord.gg/bjkCVWqqfX">
    <img src="https://img.shields.io/badge/discord-join-7289DA.svg?logo=discord&longCache=true&style=flat" />
</a>

官方的Azerothcore Discord服务器也提供了一个专门用于lua开发的通道：
<a href="https://discord.gg/gkt4y2x">
    <img src="https://img.shields.io/badge/discord-join-7289DA.svg?logo=discord&longCache=true&style=flat" />
</a>

# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) mod-eluna for AzerothCore
- azerothcore 的最新构建状态：[![Build Status](https://github.com/azerothcore/mod-eluna/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-eluna)

[english](README.md) | [中文说明](README_CN.md) | [Español](README_ES.md)

一个AzerothCore的[Eluna](https://github.com/ElunaLuaEngine/Eluna)模块。


## 如何安装:

### 1) 下载源代码

您可以使用 git 获取源代码。


#### 使用 git 下载

1. 在命令行中打开 `azerothcore-wotlk` 的文件夹。
2. 进入 **modules** 文件夹: `cd modules`
3. 使用以下命令下载模块源代码。
```
git clone https://github.com/azerothcore/mod-eluna.git mod-eluna
```

### 2) 构建

您需要再次运行 cmake 并重新生成项目。

AC版的Eluna API: 
[https://www.azerothcore.org/pages/eluna/index.html](https://www.azerothcore.org/pages/eluna/index.html)


## 文档

* [入门指南](https://github.com/ElunaLuaEngine/Eluna/blob/master/docs/USAGE.md)
* [Eluna特性](https://github.com/ElunaLuaEngine/Eluna/blob/master/docs/IMPL_DETAILS.md)
* [功能文档(AC版本)](https://www.azerothcore.org/pages/eluna/index.html)
* [Hook文档](https://github.com/ElunaLuaEngine/Eluna/blob/master/Hooks.h)
* [Lua参考手册](http://www.lua.org/manual/5.2/)
* [论坛 - 支持, 发布, 指南](https://www.getmangos.eu/forums/forum/119-eluna-central/)
* [示例脚本](https://github.com/ElunaLuaEngine/Scripts)
* [贡献](https://github.com/ElunaLuaEngine/Eluna/blob/master/docs/CONTRIBUTING.md)


## 链接

* [MaNGOS](http://getmangos.eu/)
* [cMaNGOS](http://cmangos.net/)
* [TrinityCore](http://www.trinitycore.org/)
* [AzerothCore](http://www.azerothcore.org/)
* [Lua.org](http://www.lua.org/)
* [License](https://github.com/ElunaLuaEngine/Eluna/blob/master/docs/LICENSE.md)


## 来自Eluna/master的拓展

- 添加了 HttpRequest 方法. https://github.com/azerothcore/Eluna/pull/2
- 添加玩家注册事件43(当宠物添加到世界中时): `PLAYER_EVENT_ON_PET_ADDED_TO_WORLD` https://github.com/azerothcore/Eluna/pull/3
- 添加聊天处理方法到玩家事件中。 https://github.com/azerothcore/Eluna/pull/23
- 暴露方法 `ModifyThreatPct()`. https://github.com/azerothcore/Eluna/pull/25
- 暴露方法 `Object:IsPlayer()`. https://github.com/azerothcore/Eluna/pull/42
- 添加玩家注册事件44(当玩家学习技能时): `PLAYER_EVENT_ON_LEARN_SPELL`. https://github.com/azerothcore/mod-eluna/pull/46
- 添加玩家注册事件45(当玩家完成成就时): `PLAYER_ON_ACHIEVEMENT_COMPLETE`。 https://github.com/azerothcore/mod-eluna/pull/47
- 添加玩家注册事件51(当玩家获得任务奖励时) `PLAYER_EVENT_ON_QUEST_REWARD_ITEM`。https://github.com/azerothcore/mod-eluna/pull/88
- 添加玩家注册事件52(当玩家创建物品时) `PLAYER_EVENT_ON_CREATE_ITEM`。https://github.com/azerothcore/mod-eluna/pull/88
- 添加玩家注册事件53(当玩家创建物品实例时) `PLAYER_EVENT_ON_STORE_NEW_ITEM`。https://github.com/azerothcore/mod-eluna/pull/88
- 添加玩家注册事件54(当玩家完成任务时) `PLAYER_EVENT_ON_COMPLETE_QUEST`。https://github.com/azerothcore/mod-eluna/pull/90
- 新增参数*商人Id*到方法player:SendListInventory(object, vendorentry)中。 https://github.com/azerothcore/mod-eluna/pull/48
- 添加方法`gameobject:AddLoot()`, 可以在线给**空**的容器中添加战利品。 https://github.com/azerothcore/mod-eluna/pull/52
