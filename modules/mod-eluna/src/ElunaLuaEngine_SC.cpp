/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
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

#include "Chat.h"
#include "ElunaEventMgr.h"
#include "Log.h"
#include "LuaEngine.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedGossip.h"

class Eluna_AllCreatureScript : public AllCreatureScript
{
public:
    Eluna_AllCreatureScript() : AllCreatureScript("Eluna_AllCreatureScript") { }

    // Creature
    bool CanCreatureGossipHello(Player* player, Creature* creature) override
    {
        if (sEluna->OnGossipHello(player, creature))
            return true;

        return false;
    }

    bool CanCreatureGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        if (sEluna->OnGossipSelect(player, creature, sender, action))
            return true;

        return false;
    }

    bool CanCreatureGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code) override
    {
        if (sEluna->OnGossipSelectCode(player, creature, sender, action, code))
            return true;

        return false;
    }

    void OnCreatureAddWorld(Creature* creature) override
    {
        sEluna->OnAddToWorld(creature);

        if (creature->IsGuardian() && creature->ToTempSummon() && creature->ToTempSummon()->GetSummonerGUID().IsPlayer())
            sEluna->OnPetAddedToWorld(creature->ToTempSummon()->GetSummonerUnit()->ToPlayer(), creature);
    }

    void OnCreatureRemoveWorld(Creature* creature) override
    {
        sEluna->OnRemoveFromWorld(creature);
    }

    bool CanCreatureQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        sEluna->OnQuestAccept(player, creature, quest);
        return false;
    }

    bool CanCreatureQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 opt) override
    {
        if (sEluna->OnQuestReward(player, creature, quest, opt))
        {
            ClearGossipMenuFor(player);
            return true;
        }

        return false;
    }

    CreatureAI* GetCreatureAI(Creature* creature) const override
    {
        if (CreatureAI* luaAI = sEluna->GetAI(creature))
            return luaAI;

        return nullptr;
    }
};

class Eluna_AllGameObjectScript : public AllGameObjectScript
{
public:
    Eluna_AllGameObjectScript() : AllGameObjectScript("Eluna_AllGameObjectScript") { }

    void OnGameObjectAddWorld(GameObject* go) override
    {
        sEluna->OnAddToWorld(go);
    }

    void OnGameObjectRemoveWorld(GameObject* go) override
    {
        sEluna->OnRemoveFromWorld(go);
    }

    void OnGameObjectUpdate(GameObject* go, uint32 diff) override
    {
        sEluna->UpdateAI(go, diff);
    }

    bool CanGameObjectGossipHello(Player* player, GameObject* go) override
    {
        if (sEluna->OnGossipHello(player, go))
            return true;

        if (sEluna->OnGameObjectUse(player, go))
            return true;

        return false;
    }

    void OnGameObjectDamaged(GameObject* go, Player* player) override
    {
        sEluna->OnDamaged(go, player);
    }

    void OnGameObjectDestroyed(GameObject* go, Player* player) override
    {
        sEluna->OnDestroyed(go, player);
    }

    void OnGameObjectLootStateChanged(GameObject* go, uint32 state, Unit* /*unit*/) override
    {
        sEluna->OnLootStateChanged(go, state);
    }

    void OnGameObjectStateChanged(GameObject* go, uint32 state) override
    {
        sEluna->OnGameObjectStateChanged(go, state);
    }

    bool CanGameObjectQuestAccept(Player* player, GameObject* go, Quest const* quest) override
    {
        sEluna->OnQuestAccept(player, go, quest);
        return false;
    }

    bool CanGameObjectGossipSelect(Player* player, GameObject* go, uint32 sender, uint32 action) override
    {
        if (sEluna->OnGossipSelect(player, go, sender, action))
            return true;

        return false;
    }

    bool CanGameObjectGossipSelectCode(Player* player, GameObject* go, uint32 sender, uint32 action, const char* code) override
    {
        if (sEluna->OnGossipSelectCode(player, go, sender, action, code))
            return true;

        return false;
    }

    bool CanGameObjectQuestReward(Player* player, GameObject* go, Quest const* quest, uint32 opt) override
    {
        if (sEluna->OnQuestAccept(player, go, quest))
            return false;

        if (sEluna->OnQuestReward(player, go, quest, opt))
            return false;

        return true;
    }

    GameObjectAI* GetGameObjectAI(GameObject* go) const override
    {
        sEluna->OnSpawn(go);
        return nullptr;
    }
};

class Eluna_AllItemScript : public AllItemScript
{
public:
    Eluna_AllItemScript() : AllItemScript("Eluna_AllItemScript") { }

    bool CanItemQuestAccept(Player* player, Item* item, Quest const* quest) override
    {
        if (sEluna->OnQuestAccept(player, item, quest))
            return false;

        return true;
    }

    bool CanItemUse(Player* player, Item* item, SpellCastTargets const& targets) override
    {
        if (!sEluna->OnUse(player, item, targets))
            return true;

        return false;
    }

    bool CanItemExpire(Player* player, ItemTemplate const* proto) override
    {
        if (sEluna->OnExpire(player, proto))
            return false;

        return true;
    }

    bool CanItemRemove(Player* player, Item* item) override
    {
        if (sEluna->OnRemove(player, item))
            return false;

        return true;
    }

    void OnItemGossipSelect(Player* player, Item* item, uint32 sender, uint32 action) override
    {
        sEluna->HandleGossipSelectOption(player, item, sender, action, "");
    }

    void OnItemGossipSelectCode(Player* player, Item* item, uint32 sender, uint32 action, const char* code) override
    {
        sEluna->HandleGossipSelectOption(player, item, sender, action, code);
    }
};

class Eluna_AllMapScript : public AllMapScript
{
public:
    Eluna_AllMapScript() : AllMapScript("Eluna_AllMapScript", {
        ALLMAPHOOK_ON_BEFORE_CREATE_INSTANCE_SCRIPT,
        ALLMAPHOOK_ON_DESTROY_INSTANCE,
        ALLMAPHOOK_ON_CREATE_MAP,
        ALLMAPHOOK_ON_DESTROY_MAP,
        ALLMAPHOOK_ON_PLAYER_ENTER_ALL,
        ALLMAPHOOK_ON_PLAYER_LEAVE_ALL,
        ALLMAPHOOK_ON_MAP_UPDATE
    }) { }

    void OnBeforeCreateInstanceScript(InstanceMap* instanceMap, InstanceScript** instanceData, bool /*load*/, std::string /*data*/, uint32 /*completedEncounterMask*/) override
    {
        if (instanceData)
            *instanceData = sEluna->GetInstanceData(instanceMap);
    }

    void OnDestroyInstance(MapInstanced* /*mapInstanced*/, Map* map) override
    {
        sEluna->FreeInstanceId(map->GetInstanceId());
    }

    void OnCreateMap(Map* map) override
    {
        sEluna->OnCreate(map);
    }

    void OnDestroyMap(Map* map) override
    {
        sEluna->OnDestroy(map);
    }

    void OnPlayerEnterAll(Map* map, Player* player) override
    {
        sEluna->OnPlayerEnter(map, player);
    }

    void OnPlayerLeaveAll(Map* map, Player* player) override
    {
        sEluna->OnPlayerLeave(map, player);
    }

    void OnMapUpdate(Map* map, uint32 diff) override
    {
        sEluna->OnUpdate(map, diff);
    }
};

class Eluna_AuctionHouseScript : public AuctionHouseScript
{
public:
    Eluna_AuctionHouseScript() : AuctionHouseScript("Eluna_AuctionHouseScript", {
        AUCTIONHOUSEHOOK_ON_AUCTION_ADD,
        AUCTIONHOUSEHOOK_ON_AUCTION_REMOVE,
        AUCTIONHOUSEHOOK_ON_AUCTION_SUCCESSFUL,
        AUCTIONHOUSEHOOK_ON_AUCTION_EXPIRE
    }) { }

    void OnAuctionAdd(AuctionHouseObject* ah, AuctionEntry* entry) override
    {
        sEluna->OnAdd(ah, entry);
    }

    void OnAuctionRemove(AuctionHouseObject* ah, AuctionEntry* entry) override
    {
        sEluna->OnRemove(ah, entry);
    }

    void OnAuctionSuccessful(AuctionHouseObject* ah, AuctionEntry* entry) override
    {
        sEluna->OnSuccessful(ah, entry);
    }

    void OnAuctionExpire(AuctionHouseObject* ah, AuctionEntry* entry) override
    {
        sEluna->OnExpire(ah, entry);
    }
};

class Eluna_BGScript : public BGScript
{
public:
    Eluna_BGScript() : BGScript("Eluna_BGScript", {
        ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_START,
        ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_END,
        ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_DESTROY,
        ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_CREATE
    }) { }

    void OnBattlegroundStart(Battleground* bg) override
    {
        sEluna->OnBGStart(bg, bg->GetBgTypeID(), bg->GetInstanceID());
    }

    void OnBattlegroundEnd(Battleground* bg, TeamId winnerTeam) override
    {
        sEluna->OnBGEnd(bg, bg->GetBgTypeID(), bg->GetInstanceID(), winnerTeam);
    }

    void OnBattlegroundDestroy(Battleground* bg) override
    {
        sEluna->OnBGDestroy(bg, bg->GetBgTypeID(), bg->GetInstanceID());
    }

    void OnBattlegroundCreate(Battleground* bg) override
    {
        sEluna->OnBGCreate(bg, bg->GetBgTypeID(), bg->GetInstanceID());
    }
};

class Eluna_CommandSC : public CommandSC
{
public:
    Eluna_CommandSC() : CommandSC("Eluna_CommandSC", {
        ALLCOMMANDHOOK_ON_TRY_EXECUTE_COMMAND
    }) { }

    bool OnTryExecuteCommand(ChatHandler& handler, std::string_view cmdStr) override
    {
        if (!sEluna->OnCommand(handler, std::string(cmdStr).c_str()))
        {
            return false;
        }

        return true;
    }
};

class Eluna_ElunaScript : public ElunaScript
{
public:
    Eluna_ElunaScript() : ElunaScript("Eluna_ElunaScript") { }

    // Weather
    void OnWeatherChange(Weather* weather, WeatherState state, float grade) override
    {
        sEluna->OnChange(weather, weather->GetZone(), state, grade);
    }

    // AreaTriger
    bool CanAreaTrigger(Player* player, AreaTrigger const* trigger) override
    {
        if (sEluna->OnAreaTrigger(player, trigger))
            return true;

        return false;
    }
};

class Eluna_GameEventScript : public GameEventScript
{
public:
    Eluna_GameEventScript() : GameEventScript("Eluna_GameEventScript", {
        GAMEEVENTHOOK_ON_START,
        GAMEEVENTHOOK_ON_STOP
    }) { }

    void OnStart(uint16 eventID) override
    {
        sEluna->OnGameEventStart(eventID);
    }

    void OnStop(uint16 eventID) override
    {
        sEluna->OnGameEventStop(eventID);
    }
};

class Eluna_GroupScript : public GroupScript
{
public:
    Eluna_GroupScript() : GroupScript("Eluna_GroupScript", {
        GROUPHOOK_ON_ADD_MEMBER,
        GROUPHOOK_ON_INVITE_MEMBER,
        GROUPHOOK_ON_REMOVE_MEMBER,
        GROUPHOOK_ON_CHANGE_LEADER,
        GROUPHOOK_ON_DISBAND,
        GROUPHOOK_ON_CREATE
    }) { }

    void OnAddMember(Group* group, ObjectGuid guid) override
    {
        sEluna->OnAddMember(group, guid);
    }

    void OnInviteMember(Group* group, ObjectGuid guid) override
    {
        sEluna->OnInviteMember(group, guid);
    }

    void OnRemoveMember(Group* group, ObjectGuid guid, RemoveMethod method, ObjectGuid /* kicker */, const char* /* reason */) override
    {
        sEluna->OnRemoveMember(group, guid, method);
    }

    void OnChangeLeader(Group* group, ObjectGuid newLeaderGuid, ObjectGuid oldLeaderGuid) override
    {
        sEluna->OnChangeLeader(group, newLeaderGuid, oldLeaderGuid);
    }

    void OnDisband(Group* group) override
    {
        sEluna->OnDisband(group);
    }

    void OnCreate(Group* group, Player* leader) override
    {
        sEluna->OnCreate(group, leader->GetGUID(), group->GetGroupType());
    }
};

class Eluna_GuildScript : public GuildScript
{
public:
    Eluna_GuildScript() : GuildScript("Eluna_GuildScript", {
        GUILDHOOK_ON_ADD_MEMBER,
        GUILDHOOK_ON_REMOVE_MEMBER,
        GUILDHOOK_ON_MOTD_CHANGED,
        GUILDHOOK_ON_INFO_CHANGED,
        GUILDHOOK_ON_CREATE,
        GUILDHOOK_ON_DISBAND,
        GUILDHOOK_ON_MEMBER_WITDRAW_MONEY,
        GUILDHOOK_ON_MEMBER_DEPOSIT_MONEY,
        GUILDHOOK_ON_ITEM_MOVE,
        GUILDHOOK_ON_EVENT,
        GUILDHOOK_ON_BANK_EVENT
    }) { }

    void OnAddMember(Guild* guild, Player* player, uint8& plRank) override
    {
        sEluna->OnAddMember(guild, player, plRank);
    }

    void OnRemoveMember(Guild* guild, Player* player, bool isDisbanding, bool /*isKicked*/) override
    {
        sEluna->OnRemoveMember(guild, player, isDisbanding);
    }

    void OnMOTDChanged(Guild* guild, const std::string& newMotd) override
    {
        sEluna->OnMOTDChanged(guild, newMotd);
    }

    void OnInfoChanged(Guild* guild, const std::string& newInfo) override
    {
        sEluna->OnInfoChanged(guild, newInfo);
    }

    void OnCreate(Guild* guild, Player* leader, const std::string& name) override
    {
        sEluna->OnCreate(guild, leader, name);
    }

    void OnDisband(Guild* guild) override
    {
        sEluna->OnDisband(guild);
    }

    void OnMemberWitdrawMoney(Guild* guild, Player* player, uint32& amount, bool isRepair) override
    {
        sEluna->OnMemberWitdrawMoney(guild, player, amount, isRepair);
    }

    void OnMemberDepositMoney(Guild* guild, Player* player, uint32& amount) override
    {
        sEluna->OnMemberDepositMoney(guild, player, amount);
    }

    void OnItemMove(Guild* guild, Player* player, Item* pItem, bool isSrcBank, uint8 srcContainer, uint8 srcSlotId,
        bool isDestBank, uint8 destContainer, uint8 destSlotId) override
    {
        sEluna->OnItemMove(guild, player, pItem, isSrcBank, srcContainer, srcSlotId, isDestBank, destContainer, destSlotId);
    }

    void OnEvent(Guild* guild, uint8 eventType, ObjectGuid::LowType playerGuid1, ObjectGuid::LowType playerGuid2, uint8 newRank) override
    {
        sEluna->OnEvent(guild, eventType, playerGuid1, playerGuid2, newRank);
    }

    void OnBankEvent(Guild* guild, uint8 eventType, uint8 tabId, ObjectGuid::LowType playerGuid, uint32 itemOrMoney, uint16 itemStackCount, uint8 destTabId) override
    {
        sEluna->OnBankEvent(guild, eventType, tabId, playerGuid, itemOrMoney, itemStackCount, destTabId);
    }
};

class Eluna_LootScript : public LootScript
{
public:
    Eluna_LootScript() : LootScript("Eluna_LootScript", {
        LOOTHOOK_ON_LOOT_MONEY
    }) { }

    void OnLootMoney(Player* player, uint32 gold) override
    {
        sEluna->OnLootMoney(player, gold);
    }
};

class Eluna_MiscScript : public MiscScript
{
public:
    Eluna_MiscScript() : MiscScript("Eluna_MiscScript", {
        MISCHOOK_GET_DIALOG_STATUS
    }) { }

    void GetDialogStatus(Player* player, Object* questgiver) override
    {
        if (questgiver->GetTypeId() == TYPEID_GAMEOBJECT)
            sEluna->GetDialogStatus(player, questgiver->ToGameObject());
        else if (questgiver->GetTypeId() == TYPEID_UNIT)
            sEluna->GetDialogStatus(player, questgiver->ToCreature());
    }
};

class Eluna_PetScript : public PetScript
{
public:
    Eluna_PetScript() : PetScript("Eluna_PetScript", {
        PETHOOK_ON_PET_ADD_TO_WORLD
    }) { }

    void OnPetAddToWorld(Pet* pet) override
    {
        sEluna->OnPetAddedToWorld(pet->GetOwner(), pet);
    }
};

class Eluna_PlayerScript : public PlayerScript
{
public:
    Eluna_PlayerScript() : PlayerScript("Eluna_PlayerScript", {
        PLAYERHOOK_ON_PLAYER_RESURRECT,
        PLAYERHOOK_CAN_PLAYER_USE_CHAT,
        PLAYERHOOK_CAN_PLAYER_USE_PRIVATE_CHAT,
        PLAYERHOOK_CAN_PLAYER_USE_GROUP_CHAT,
        PLAYERHOOK_CAN_PLAYER_USE_GUILD_CHAT,
        PLAYERHOOK_CAN_PLAYER_USE_CHANNEL_CHAT,
        PLAYERHOOK_ON_LOOT_ITEM,
        PLAYERHOOK_ON_PLAYER_LEARN_TALENTS,
        PLAYERHOOK_CAN_USE_ITEM,
        PLAYERHOOK_ON_EQUIP,
        PLAYERHOOK_ON_PLAYER_ENTER_COMBAT,
        PLAYERHOOK_ON_PLAYER_LEAVE_COMBAT,
        PLAYERHOOK_CAN_REPOP_AT_GRAVEYARD,
        PLAYERHOOK_ON_QUEST_ABANDON,
        PLAYERHOOK_ON_MAP_CHANGED,
        PLAYERHOOK_ON_GOSSIP_SELECT,
        PLAYERHOOK_ON_GOSSIP_SELECT_CODE,
        PLAYERHOOK_ON_PVP_KILL,
        PLAYERHOOK_ON_CREATURE_KILL,
        PLAYERHOOK_ON_PLAYER_KILLED_BY_CREATURE,
        PLAYERHOOK_ON_LEVEL_CHANGED,
        PLAYERHOOK_ON_FREE_TALENT_POINTS_CHANGED,
        PLAYERHOOK_ON_TALENTS_RESET,
        PLAYERHOOK_ON_MONEY_CHANGED,
        PLAYERHOOK_ON_GIVE_EXP,
        PLAYERHOOK_ON_REPUTATION_CHANGE,
        PLAYERHOOK_ON_DUEL_REQUEST,
        PLAYERHOOK_ON_DUEL_START,
        PLAYERHOOK_ON_DUEL_END,
        PLAYERHOOK_ON_EMOTE,
        PLAYERHOOK_ON_TEXT_EMOTE,
        PLAYERHOOK_ON_SPELL_CAST,
        PLAYERHOOK_ON_LOGIN,
        PLAYERHOOK_ON_LOGOUT,
        PLAYERHOOK_ON_CREATE,
        PLAYERHOOK_ON_SAVE,
        PLAYERHOOK_ON_DELETE,
        PLAYERHOOK_ON_BIND_TO_INSTANCE,
        PLAYERHOOK_ON_UPDATE_AREA,
        PLAYERHOOK_ON_UPDATE_ZONE,
        PLAYERHOOK_ON_FIRST_LOGIN,
        PLAYERHOOK_ON_LEARN_SPELL,
        PLAYERHOOK_ON_ACHI_COMPLETE,
        PLAYERHOOK_ON_FFA_PVP_STATE_UPDATE,
        PLAYERHOOK_CAN_INIT_TRADE,
        PLAYERHOOK_CAN_SEND_MAIL,
        PLAYERHOOK_CAN_JOIN_LFG,
        PLAYERHOOK_ON_QUEST_REWARD_ITEM,
        PLAYERHOOK_ON_GROUP_ROLL_REWARD_ITEM,
        PLAYERHOOK_ON_CREATE_ITEM,
        PLAYERHOOK_ON_STORE_NEW_ITEM,
        PLAYERHOOK_ON_PLAYER_COMPLETE_QUEST,
        PLAYERHOOK_CAN_GROUP_INVITE,
        PLAYERHOOK_ON_BATTLEGROUND_DESERTION,
        PLAYERHOOK_ON_CREATURE_KILLED_BY_PET,
        PLAYERHOOK_ON_CAN_UPDATE_SKILL,
        PLAYERHOOK_ON_BEFORE_UPDATE_SKILL,
        PLAYERHOOK_ON_UPDATE_SKILL,
        PLAYERHOOK_CAN_RESURRECT
    }) { }

    void OnPlayerResurrect(Player* player, float /*restore_percent*/, bool /*applySickness*/) override
    {
        sEluna->OnResurrect(player);
    }

    bool OnPlayerCanUseChat(Player* player, uint32 type, uint32 lang, std::string& msg) override
    {
        if (type != CHAT_MSG_SAY && type != CHAT_MSG_YELL && type != CHAT_MSG_EMOTE)
            return true;

        if (!sEluna->OnChat(player, type, lang, msg))
            return false;

        return true;
    }

    bool OnPlayerCanUseChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* target) override
    {
        if (!sEluna->OnChat(player, type, lang, msg, target))
            return false;

        return true;
    }

    bool OnPlayerCanUseChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group) override
    {
        if (!sEluna->OnChat(player, type, lang, msg, group))
            return false;

        return true;
    }

    bool OnPlayerCanUseChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild) override
    {
        if (!sEluna->OnChat(player, type, lang, msg, guild))
            return false;

        return true;
    }

    bool OnPlayerCanUseChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel) override
    {
        if (!sEluna->OnChat(player, type, lang, msg, channel))
            return false;

        return true;
    }

    void OnPlayerLootItem(Player* player, Item* item, uint32 count, ObjectGuid lootguid) override
    {
        sEluna->OnLootItem(player, item, count, lootguid);
    }

    void OnPlayerLearnTalents(Player* player, uint32 talentId, uint32 talentRank, uint32 spellid) override
    {
        sEluna->OnLearnTalents(player, talentId, talentRank, spellid);
    }

    bool OnPlayerCanUseItem(Player* player, ItemTemplate const* proto, InventoryResult& result) override
    {
        result = sEluna->OnCanUseItem(player, proto->ItemId);
        return result != EQUIP_ERR_OK ? false : true;
    }

    void OnPlayerEquip(Player* player, Item* it, uint8 bag, uint8 slot, bool /*update*/) override
    {
        sEluna->OnEquip(player, it, bag, slot);
    }

    void OnPlayerEnterCombat(Player* player, Unit* enemy) override
    {
        sEluna->OnPlayerEnterCombat(player, enemy);
    }

    void OnPlayerLeaveCombat(Player* player) override
    {
        sEluna->OnPlayerLeaveCombat(player);
    }

    bool OnPlayerCanRepopAtGraveyard(Player* player) override
    {
        sEluna->OnRepop(player);
        return true;
    }

    void OnPlayerQuestAbandon(Player* player, uint32 questId) override
    {
        sEluna->OnQuestAbandon(player, questId);
    }

    void OnPlayerMapChanged(Player* player) override
    {
        sEluna->OnMapChanged(player);
    }

    void OnPlayerGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action) override
    {
        sEluna->HandleGossipSelectOption(player, menu_id, sender, action, "");
    }

    void OnPlayerGossipSelectCode(Player* player, uint32 menu_id, uint32 sender, uint32 action, const char* code) override
    {
        sEluna->HandleGossipSelectOption(player, menu_id, sender, action, code);
    }

    void OnPlayerPVPKill(Player* killer, Player* killed) override
    {
        sEluna->OnPVPKill(killer, killed);
    }

    void OnPlayerCreatureKill(Player* killer, Creature* killed) override
    {
        sEluna->OnCreatureKill(killer, killed);
    }

    void OnPlayerKilledByCreature(Creature* killer, Player* killed) override
    {
        sEluna->OnPlayerKilledByCreature(killer, killed);
    }

    void OnPlayerLevelChanged(Player* player, uint8 oldLevel) override
    {
        sEluna->OnLevelChanged(player, oldLevel);
    }

    void OnPlayerFreeTalentPointsChanged(Player* player, uint32 points) override
    {
        sEluna->OnFreeTalentPointsChanged(player, points);
    }

    void OnPlayerTalentsReset(Player* player, bool noCost) override
    {
        sEluna->OnTalentsReset(player, noCost);
    }

    void OnPlayerMoneyChanged(Player* player, int32& amount) override
    {
        sEluna->OnMoneyChanged(player, amount);
    }

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* victim, uint8 xpSource) override
    {
        sEluna->OnGiveXP(player, amount, victim, xpSource);
    }

    bool OnPlayerReputationChange(Player* player, uint32 factionID, int32& standing, bool incremental) override
    {
        return sEluna->OnReputationChange(player, factionID, standing, incremental);
    }

    void OnPlayerDuelRequest(Player* target, Player* challenger) override
    {
        sEluna->OnDuelRequest(target, challenger);
    }

    void OnPlayerDuelStart(Player* player1, Player* player2) override
    {
        sEluna->OnDuelStart(player1, player2);
    }

    void OnPlayerDuelEnd(Player* winner, Player* loser, DuelCompleteType type) override
    {
        sEluna->OnDuelEnd(winner, loser, type);
    }

    void OnPlayerEmote(Player* player, uint32 emote) override
    {
        sEluna->OnEmote(player, emote);
    }

    void OnPlayerTextEmote(Player* player, uint32 textEmote, uint32 emoteNum, ObjectGuid guid) override
    {
        sEluna->OnTextEmote(player, textEmote, emoteNum, guid);
    }

    void OnPlayerSpellCast(Player* player, Spell* spell, bool skipCheck) override
    {
        sEluna->OnPlayerSpellCast(player, spell, skipCheck);
    }

    void OnPlayerLogin(Player* player) override
    {
        sEluna->OnLogin(player);
    }

    void OnPlayerLogout(Player* player) override
    {
        sEluna->OnLogout(player);
    }

    void OnPlayerCreate(Player* player) override
    {
        sEluna->OnCreate(player);
    }

    void OnPlayerSave(Player* player) override
    {
        sEluna->OnSave(player);
    }

    void OnPlayerDelete(ObjectGuid guid, uint32 /*accountId*/) override
    {
        sEluna->OnDelete(guid.GetCounter());
    }

    void OnPlayerBindToInstance(Player* player, Difficulty difficulty, uint32 mapid, bool permanent) override
    {
        sEluna->OnBindToInstance(player, difficulty, mapid, permanent);
    }

    void OnPlayerUpdateArea(Player* player, uint32 oldArea, uint32 newArea) override
    {
        sEluna->OnUpdateArea(player, oldArea, newArea);
    }

    void OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 newArea) override
    {
        sEluna->OnUpdateZone(player, newZone, newArea);
    }

    void OnPlayerFirstLogin(Player* player) override
    {
        sEluna->OnFirstLogin(player);
    }

    void OnPlayerLearnSpell(Player* player, uint32 spellId) override
    {
        sEluna->OnLearnSpell(player, spellId);
    }

    void OnPlayerAchievementComplete(Player* player, AchievementEntry const* achievement) override
    {
        sEluna->OnAchiComplete(player, achievement);
    }

    void OnPlayerFfaPvpStateUpdate(Player* player, bool IsFlaggedForFfaPvp) override
    {
        sEluna->OnFfaPvpStateUpdate(player, IsFlaggedForFfaPvp);
    }

    bool OnPlayerCanInitTrade(Player* player, Player* target) override
    {
        return sEluna->OnCanInitTrade(player, target);
    }

    bool OnPlayerCanSendMail(Player* player, ObjectGuid receiverGuid, ObjectGuid mailbox, std::string& subject, std::string& body, uint32 money, uint32 cod, Item* item) override
    {
        return sEluna->OnCanSendMail(player, receiverGuid, mailbox, subject, body, money, cod, item);
    }

    bool OnPlayerCanJoinLfg(Player* player, uint8 roles, lfg::LfgDungeonSet& dungeons, const std::string& comment) override
    {
        return sEluna->OnCanJoinLfg(player, roles, dungeons, comment);
    }

    void OnPlayerQuestRewardItem(Player* player, Item* item, uint32 count) override
    {
        sEluna->OnQuestRewardItem(player, item, count);
    }

    void OnPlayerGroupRollRewardItem(Player* player, Item* item, uint32 count, RollVote voteType, Roll* roll) override
    {
        sEluna->OnGroupRollRewardItem(player, item, count, voteType, roll);
    }

    void OnPlayerCreateItem(Player* player, Item* item, uint32 count) override
    {
        sEluna->OnCreateItem(player, item, count);
    }

    void OnPlayerStoreNewItem(Player* player, Item* item, uint32 count) override
    {
        sEluna->OnStoreNewItem(player, item, count);
    }

    void OnPlayerCompleteQuest(Player* player, Quest const* quest) override
    {
        sEluna->OnPlayerCompleteQuest(player, quest);
    }

    bool OnPlayerCanGroupInvite(Player* player, std::string& memberName) override
    {
        return sEluna->OnCanGroupInvite(player, memberName);
    }

    void OnPlayerBattlegroundDesertion(Player* player, const BattlegroundDesertionType type) override
    {
        sEluna->OnBattlegroundDesertion(player, type);
    }

    void OnPlayerCreatureKilledByPet(Player* player, Creature* killed) override
    {
        sEluna->OnCreatureKilledByPet(player, killed);
    }

    bool OnPlayerCanUpdateSkill(Player* player, uint32 skill_id) override
    {
        return sEluna->OnPlayerCanUpdateSkill(player, skill_id);
    }

    void OnPlayerBeforeUpdateSkill(Player* player, uint32 skill_id, uint32& value, uint32 max, uint32 step) override
    {
        sEluna->OnPlayerBeforeUpdateSkill(player, skill_id, value, max, step);
    }

    void OnPlayerUpdateSkill(Player* player, uint32 skill_id, uint32 value, uint32 max, uint32 step, uint32 new_value) override
    {
        sEluna->OnPlayerUpdateSkill(player, skill_id, value, max, step, new_value);
    }
    
    bool OnPlayerCanResurrect(Player* player) override
    {
        return sEluna->CanPlayerResurrect(player);
    }
};

class Eluna_ServerScript : public ServerScript
{
public:
    Eluna_ServerScript() : ServerScript("Eluna_ServerScript", {
        SERVERHOOK_CAN_PACKET_SEND,
        SERVERHOOK_CAN_PACKET_RECEIVE
    }) { }

    bool CanPacketSend(WorldSession* session, WorldPacket& packet) override
    {
        if (!sEluna->OnPacketSend(session, packet))
            return false;

        return true;
    }

    bool CanPacketReceive(WorldSession* session, WorldPacket& packet) override
    {
        if (!sEluna->OnPacketReceive(session, packet))
            return false;

        return true;
    }
};

class Eluna_SpellSC : public SpellSC
{
public:
    Eluna_SpellSC() : SpellSC("Eluna_SpellSC", {
        ALLSPELLHOOK_ON_DUMMY_EFFECT_GAMEOBJECT,
        ALLSPELLHOOK_ON_DUMMY_EFFECT_CREATURE,
        ALLSPELLHOOK_ON_DUMMY_EFFECT_ITEM,
        ALLSPELLHOOK_ON_CAST_CANCEL,
        ALLSPELLHOOK_ON_CAST,
        ALLSPELLHOOK_ON_PREPARE
    }) { }

    void OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, GameObject* gameObjTarget) override
    {
        sEluna->OnDummyEffect(caster, spellID, effIndex, gameObjTarget);
    }

    void OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Creature* creatureTarget) override
    {
        sEluna->OnDummyEffect(caster, spellID, effIndex, creatureTarget);
    }

    void OnDummyEffect(WorldObject* caster, uint32 spellID, SpellEffIndex effIndex, Item* itemTarget) override
    {
        sEluna->OnDummyEffect(caster, spellID, effIndex, itemTarget);
    }

    void OnSpellCastCancel(Spell* spell, Unit* caster, SpellInfo const* spellInfo, bool bySelf) override
    {
        sEluna->OnSpellCastCancel(caster, spell, spellInfo, bySelf);
    }

    void OnSpellCast(Spell* spell, Unit* caster, SpellInfo const* spellInfo, bool skipCheck) override
    {
        sEluna->OnSpellCast(caster, spell, spellInfo, skipCheck);
    }

    void OnSpellPrepare(Spell* spell, Unit* caster, SpellInfo const* spellInfo) override
    {
        sEluna->OnSpellPrepare(caster, spell, spellInfo);
    }
};

class Eluna_UnitScript : public UnitScript
{
public:
    Eluna_UnitScript() : UnitScript("Eluna_UnitScript", true, {
        UNITHOOK_ON_UNIT_UPDATE
    }) { }

    void OnUnitUpdate(Unit* unit, uint32 diff) override
    {
        unit->elunaEvents->Update(diff);
    }
};

class Eluna_VehicleScript : public VehicleScript
{
public:
    Eluna_VehicleScript() : VehicleScript("Eluna_VehicleScript") { }

    void OnInstall(Vehicle* veh) override
    {
        sEluna->OnInstall(veh);
    }

    void OnUninstall(Vehicle* veh) override
    {
        sEluna->OnUninstall(veh);
    }

    void OnInstallAccessory(Vehicle* veh, Creature* accessory) override
    {
        sEluna->OnInstallAccessory(veh, accessory);
    }

    void OnAddPassenger(Vehicle* veh, Unit* passenger, int8 seatId) override
    {
        sEluna->OnAddPassenger(veh, passenger, seatId);
    }

    void OnRemovePassenger(Vehicle* veh, Unit* passenger) override
    {
        sEluna->OnRemovePassenger(veh, passenger);
    }
};

class Eluna_WorldObjectScript : public WorldObjectScript
{
public:
    Eluna_WorldObjectScript() : WorldObjectScript("Eluna_WorldObjectScript", {
        WORLDOBJECTHOOK_ON_WORLD_OBJECT_DESTROY,
        WORLDOBJECTHOOK_ON_WORLD_OBJECT_CREATE,
        WORLDOBJECTHOOK_ON_WORLD_OBJECT_SET_MAP,
        WORLDOBJECTHOOK_ON_WORLD_OBJECT_UPDATE
    }) { }

    void OnWorldObjectDestroy(WorldObject* object) override
    {
        delete object->elunaEvents;
        object->elunaEvents = nullptr;
    }

    void OnWorldObjectCreate(WorldObject* object) override
    {
        object->elunaEvents = nullptr;
    }

    void OnWorldObjectSetMap(WorldObject* object, Map* /*map*/) override
    {
        if (!object->elunaEvents)
            object->elunaEvents = new ElunaEventProcessor(&Eluna::GEluna, object);
    }

    void OnWorldObjectUpdate(WorldObject* object, uint32 diff) override
    {
        object->elunaEvents->Update(diff);
    }
};

class Eluna_WorldScript : public WorldScript
{
public:
    Eluna_WorldScript() : WorldScript("Eluna_WorldScript", {
        WORLDHOOK_ON_OPEN_STATE_CHANGE,
        WORLDHOOK_ON_BEFORE_CONFIG_LOAD,
        WORLDHOOK_ON_AFTER_CONFIG_LOAD,
        WORLDHOOK_ON_SHUTDOWN_INITIATE,
        WORLDHOOK_ON_SHUTDOWN_CANCEL,
        WORLDHOOK_ON_UPDATE,
        WORLDHOOK_ON_STARTUP,
        WORLDHOOK_ON_SHUTDOWN,
        WORLDHOOK_ON_AFTER_UNLOAD_ALL_MAPS,
        WORLDHOOK_ON_BEFORE_WORLD_INITIALIZED
    }) { }

    void OnOpenStateChange(bool open) override
    {
        sEluna->OnOpenStateChange(open);
    }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload)
        {
            ///- Initialize Lua Engine
            LOG_INFO("eluna", "Initialize Eluna Lua Engine...");
            Eluna::Initialize();
        }

        sEluna->OnConfigLoad(reload, true);
    }

    void OnAfterConfigLoad(bool reload) override
    {
        sEluna->OnConfigLoad(reload, false);
    }

    void OnShutdownInitiate(ShutdownExitCode code, ShutdownMask mask) override
    {
        sEluna->OnShutdownInitiate(code, mask);
    }

    void OnShutdownCancel() override
    {
        sEluna->OnShutdownCancel();
    }

    void OnUpdate(uint32 diff) override
    {
        sEluna->OnWorldUpdate(diff);
    }

    void OnStartup() override
    {
        sEluna->OnStartup();
    }

    void OnShutdown() override
    {
        sEluna->OnShutdown();
    }

    void OnAfterUnloadAllMaps() override
    {
        Eluna::Uninitialize();
    }

    void OnBeforeWorldInitialized() override
    {
        ///- Run eluna scripts.
        // in multithread foreach: run scripts
        sEluna->RunScripts();
        sEluna->OnConfigLoad(false, false); // Must be done after Eluna is initialized and scripts have run.
    }
};

class Eluna_TicketScript : public TicketScript
{
public:
    Eluna_TicketScript() : TicketScript("Eluna_TicketScript", {
        TICKETHOOK_ON_TICKET_CREATE,
        TICKETHOOK_ON_TICKET_UPDATE_LAST_CHANGE,
        TICKETHOOK_ON_TICKET_CLOSE,
        TICKETHOOK_ON_TICKET_RESOLVE
    }) { }

    void OnTicketCreate(GmTicket* ticket) override
    {
        sEluna->OnTicketCreate(ticket);
    }

    void OnTicketUpdateLastChange(GmTicket* ticket) override
    {
        sEluna->OnTicketUpdateLastChange(ticket);
    }

    void OnTicketClose(GmTicket* ticket) override
    {
        sEluna->OnTicketClose(ticket);
    }

    void OnTicketResolve(GmTicket* ticket) override
    {
        sEluna->OnTicketResolve(ticket);
    }
};

// Group all custom scripts
void AddSC_ElunaLuaEngine()
{
    new Eluna_AllCreatureScript();
    new Eluna_AllGameObjectScript();
    new Eluna_AllItemScript();
    new Eluna_AllMapScript();
    new Eluna_AuctionHouseScript();
    new Eluna_BGScript();
    new Eluna_CommandSC();
    new Eluna_ElunaScript();
    new Eluna_GameEventScript();
    new Eluna_GroupScript();
    new Eluna_GuildScript();
    new Eluna_LootScript();
    new Eluna_MiscScript();
    new Eluna_PetScript();
    new Eluna_PlayerScript();
    new Eluna_ServerScript();
    new Eluna_SpellSC();
    new Eluna_TicketScript();
    new Eluna_UnitScript();
    new Eluna_VehicleScript();
    new Eluna_WorldObjectScript();
    new Eluna_WorldScript();
}
