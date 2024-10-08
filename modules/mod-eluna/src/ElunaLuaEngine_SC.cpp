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
    Eluna_AllMapScript() : AllMapScript("Eluna_AllMapScript") { }

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
    Eluna_AuctionHouseScript() : AuctionHouseScript("Eluna_AuctionHouseScript") { }

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
    Eluna_BGScript() : BGScript("Eluna_BGScript") { }

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
    Eluna_CommandSC() : CommandSC("Eluna_CommandSC") { }

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
    Eluna_GameEventScript() : GameEventScript("Eluna_GameEventScript") { }

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
    Eluna_GroupScript() : GroupScript("Eluna_GroupScript") { }

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
    Eluna_GuildScript() : GuildScript("Eluna_GuildScript") { }

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
    Eluna_LootScript() : LootScript("Eluna_LootScript") { }

    void OnLootMoney(Player* player, uint32 gold) override
    {
        sEluna->OnLootMoney(player, gold);
    }
};

class Eluna_MiscScript : public MiscScript
{
public:
    Eluna_MiscScript() : MiscScript("Eluna_MiscScript") { }

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
    Eluna_PetScript() : PetScript("Eluna_PetScript") { }

    void OnPetAddToWorld(Pet* pet) override
    {
        sEluna->OnPetAddedToWorld(pet->GetOwner(), pet);
    }
};

class Eluna_PlayerScript : public PlayerScript
{
public:
    Eluna_PlayerScript() : PlayerScript("Eluna_PlayerScript") { }

    void OnPlayerResurrect(Player* player, float /*restore_percent*/, bool /*applySickness*/) override
    {
        sEluna->OnResurrect(player);
    }

    bool CanPlayerUseChat(Player* player, uint32 type, uint32 lang, std::string& msg) override
    {
        if (type != CHAT_MSG_SAY && type != CHAT_MSG_YELL && type != CHAT_MSG_EMOTE)
            return true;

        if (!sEluna->OnChat(player, type, lang, msg))
            return false;

        return true;
    }

    bool CanPlayerUseChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* target) override
    {
        if (!sEluna->OnChat(player, type, lang, msg, target))
            return false;

        return true;
    }

    bool CanPlayerUseChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group) override
    {
        if (!sEluna->OnChat(player, type, lang, msg, group))
            return false;

        return true;
    }

    bool CanPlayerUseChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild) override
    {
        if (!sEluna->OnChat(player, type, lang, msg, guild))
            return false;

        return true;
    }

    bool CanPlayerUseChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel) override
    {
        if (!sEluna->OnChat(player, type, lang, msg, channel))
            return false;

        return true;
    }

    void OnLootItem(Player* player, Item* item, uint32 count, ObjectGuid lootguid) override
    {
        sEluna->OnLootItem(player, item, count, lootguid);
    }

    void OnPlayerLearnTalents(Player* player, uint32 talentId, uint32 talentRank, uint32 spellid) override
    {
        sEluna->OnLearnTalents(player, talentId, talentRank, spellid);
    }

    bool CanUseItem(Player* player, ItemTemplate const* proto, InventoryResult& result) override
    {
        result = sEluna->OnCanUseItem(player, proto->ItemId);
        return result != EQUIP_ERR_OK ? false : true;
    }

    void OnEquip(Player* player, Item* it, uint8 bag, uint8 slot, bool /*update*/) override
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

    bool CanRepopAtGraveyard(Player* player) override
    {
        sEluna->OnRepop(player);
        return true;
    }

    void OnQuestAbandon(Player* player, uint32 questId) override
    {
        sEluna->OnQuestAbandon(player, questId);
    }

    void OnMapChanged(Player* player) override
    {
        sEluna->OnMapChanged(player);
    }

    void OnGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action) override
    {
        sEluna->HandleGossipSelectOption(player, menu_id, sender, action, "");
    }

    void OnGossipSelectCode(Player* player, uint32 menu_id, uint32 sender, uint32 action, const char* code) override
    {
        sEluna->HandleGossipSelectOption(player, menu_id, sender, action, code);
    }

    void OnPVPKill(Player* killer, Player* killed) override
    {
        sEluna->OnPVPKill(killer, killed);
    }

    void OnCreatureKill(Player* killer, Creature* killed) override
    {
        sEluna->OnCreatureKill(killer, killed);
    }

    void OnPlayerKilledByCreature(Creature* killer, Player* killed) override
    {
        sEluna->OnPlayerKilledByCreature(killer, killed);
    }

    void OnLevelChanged(Player* player, uint8 oldLevel) override
    {
        sEluna->OnLevelChanged(player, oldLevel);
    }

    void OnFreeTalentPointsChanged(Player* player, uint32 points) override
    {
        sEluna->OnFreeTalentPointsChanged(player, points);
    }

    void OnTalentsReset(Player* player, bool noCost) override
    {
        sEluna->OnTalentsReset(player, noCost);
    }

    void OnMoneyChanged(Player* player, int32& amount) override
    {
        sEluna->OnMoneyChanged(player, amount);
    }

    void OnGiveXP(Player* player, uint32& amount, Unit* victim, uint8 xpSource) override
    {
        sEluna->OnGiveXP(player, amount, victim, xpSource);
    }

    bool OnReputationChange(Player* player, uint32 factionID, int32& standing, bool incremental) override
    {
        return sEluna->OnReputationChange(player, factionID, standing, incremental);
    }

    void OnDuelRequest(Player* target, Player* challenger) override
    {
        sEluna->OnDuelRequest(target, challenger);
    }

    void OnDuelStart(Player* player1, Player* player2) override
    {
        sEluna->OnDuelStart(player1, player2);
    }

    void OnDuelEnd(Player* winner, Player* loser, DuelCompleteType type) override
    {
        sEluna->OnDuelEnd(winner, loser, type);
    }

    void OnEmote(Player* player, uint32 emote) override
    {
        sEluna->OnEmote(player, emote);
    }

    void OnTextEmote(Player* player, uint32 textEmote, uint32 emoteNum, ObjectGuid guid) override
    {
        sEluna->OnTextEmote(player, textEmote, emoteNum, guid);
    }

    void OnSpellCast(Player* player, Spell* spell, bool skipCheck) override
    {
        sEluna->OnSpellCast(player, spell, skipCheck);
    }

    void OnLogin(Player* player) override
    {
        sEluna->OnLogin(player);
    }

    void OnLogout(Player* player) override
    {
        sEluna->OnLogout(player);
    }

    void OnCreate(Player* player) override
    {
        sEluna->OnCreate(player);
    }

    void OnSave(Player* player) override
    {
        sEluna->OnSave(player);
    }

    void OnDelete(ObjectGuid guid, uint32 /*accountId*/) override
    {
        sEluna->OnDelete(guid.GetCounter());
    }

    void OnBindToInstance(Player* player, Difficulty difficulty, uint32 mapid, bool permanent) override
    {
        sEluna->OnBindToInstance(player, difficulty, mapid, permanent);
    }

    void OnUpdateArea(Player* player, uint32 oldArea, uint32 newArea) override
    {
        sEluna->OnUpdateArea(player, oldArea, newArea);
    }

    void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea) override
    {
        sEluna->OnUpdateZone(player, newZone, newArea);
    }

    void OnFirstLogin(Player* player) override
    {
        sEluna->OnFirstLogin(player);
    }

    void OnLearnSpell(Player* player, uint32 spellId) override
    {
        sEluna->OnLearnSpell(player, spellId);
    }

    void OnAchiComplete(Player* player, AchievementEntry const* achievement) override
    {
        sEluna->OnAchiComplete(player, achievement);
    }

    void OnFfaPvpStateUpdate(Player* player, bool IsFlaggedForFfaPvp) override
    {
        sEluna->OnFfaPvpStateUpdate(player, IsFlaggedForFfaPvp);
    }

    bool CanInitTrade(Player* player, Player* target) override
    {
        return sEluna->OnCanInitTrade(player, target);
    }

    bool CanSendMail(Player* player, ObjectGuid receiverGuid, ObjectGuid mailbox, std::string& subject, std::string& body, uint32 money, uint32 cod, Item* item) override
    {
        return sEluna->OnCanSendMail(player, receiverGuid, mailbox, subject, body, money, cod, item);
    }

    bool CanJoinLfg(Player* player, uint8 roles, lfg::LfgDungeonSet& dungeons, const std::string& comment) override
    {
        return sEluna->OnCanJoinLfg(player, roles, dungeons, comment);
    }

    void OnQuestRewardItem(Player* player, Item* item, uint32 count) override
    {
        sEluna->OnQuestRewardItem(player, item, count);
    }

    void OnGroupRollRewardItem(Player* player, Item* item, uint32 count, RollVote voteType, Roll* roll) override
    {
        sEluna->OnGroupRollRewardItem(player, item, count, voteType, roll);
    }

    void OnCreateItem(Player* player, Item* item, uint32 count) override
    {
        sEluna->OnCreateItem(player, item, count);
    }

    void OnStoreNewItem(Player* player, Item* item, uint32 count) override
    {
        sEluna->OnStoreNewItem(player, item, count);
    }

    void OnPlayerCompleteQuest(Player* player, Quest const* quest) override
    {
        sEluna->OnPlayerCompleteQuest(player, quest);
    }

    bool CanGroupInvite(Player* player, std::string& memberName) override
    {
        return sEluna->OnCanGroupInvite(player, memberName);
    }

    void OnBattlegroundDesertion(Player* player, const BattlegroundDesertionType type) override
    {
        sEluna->OnBattlegroundDesertion(player, type);
    }

    void OnCreatureKilledByPet(Player* player, Creature* killed) override
    {
        sEluna->OnCreatureKilledByPet(player, killed);
    }
};

class Eluna_ServerScript : public ServerScript
{
public:
    Eluna_ServerScript() : ServerScript("Eluna_ServerScript") { }

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
    Eluna_SpellSC() : SpellSC("Eluna_SpellSC") { }

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
};

class Eluna_UnitScript : public UnitScript
{
public:
    Eluna_UnitScript() : UnitScript("Eluna_UnitScript") { }

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
    Eluna_WorldObjectScript() : WorldObjectScript("Eluna_WorldObjectScript") { }

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
    Eluna_WorldScript() : WorldScript("Eluna_WorldScript") { }

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
    new Eluna_UnitScript();
    new Eluna_VehicleScript();
    new Eluna_WorldObjectScript();
    new Eluna_WorldScript();
}
