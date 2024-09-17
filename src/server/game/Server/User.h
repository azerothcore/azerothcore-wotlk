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

/// \addtogroup u2w
/// @{
/// \file

#ifndef __WORLDSESSION_H
#define __WORLDSESSION_H

#include "AccountMgr.h"
#include "AddonMgr.h"
#include "AuthDefines.h"
#include "CircularBuffer.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "GossipDef.h"
#include "Packet.h"
#include "SharedDefines.h"
#include "World.h"
#include <map>
#include <memory>
#include <utility>

#include "FriendList.h"
class Creature;
class GameObject;
class InstanceSave;
class Item;
class LoginQueryHolder;
class LoadPetFromDBQueryHolder;
class Object;
class Pet;
class Player;
class Quest;
class SpellCastTargets;
class Unit;
class Warden;
class WDataStore;
class WowConnection;
class AsynchPetSummon;
struct AreaTableEntry;
struct AuctionEntry;
struct DeclinedName;
struct ItemTemplate;
class CMovement;

namespace lfg
{
    struct LfgJoinResultData;
    struct LfgPlayerBoot;
    struct LfgProposal;
    struct LfgQueueStatusData;
    struct LfgPlayerRewardData;
    struct LfgRoleCheck;
    struct LfgUpdateData;
}

namespace WorldPackets
{
    namespace LFG
    {
        class LFGJoin;
        class LFGLeave;
    }

    namespace Chat
    {
        class EmoteClient;
    }

    namespace Character
    {
        class ShowingCloak;
        class ShowingHelm;
        class PlayedTimeClient;
    }

    namespace Totem
    {
        class TotemDestroyed;
    }

    namespace Bank
    {
        class AutoBankItem;
        class AutoStoreBankItem;
        class BuyBankSlot;
    }

    namespace Combat
    {
        class SetSheathed;
    }

    namespace Guild
    {
        class QueryGuildInfo;
        class GuildCreate;
        class GuildInviteByName;
        class AcceptGuildInvite;
        class GuildDeclineInvitation;
        class GuildGetInfo;
        class GuildGetRoster;
        class GuildPromoteMember;
        class GuildDemoteMember;
        class GuildOfficerRemoveMember;
        class GuildLeave;
        class GuildDelete;
        class GuildUpdateMotdText;
        class GuildAddRank;
        class GuildDeleteRank;
        class GuildUpdateInfoText;
        class GuildSetMemberNote;
        class GuildEventLogQuery;
        class GuildBankRemainingWithdrawMoneyQuery;
        class GuildPermissionsQuery;
        class GuildSetRankPermissions;
        class GuildBankActivate;
        class GuildBankQueryTab;
        class GuildBankDepositMoney;
        class GuildBankWithdrawMoney;
        class GuildBankSwapItems;
        class GuildBankBuyTab;
        class GuildBankUpdateTab;
        class GuildBankLogQuery;
        class GuildBankTextQuery;
        class GuildBankSetTabText;
        class GuildSetGuildMaster;
        class SaveGuildEmblem;
    }

    namespace Misc
    {
        class RandomRollClient;
    }

    namespace Pet
    {
        class DismissCritter;
        class PetAbandon;
        class PetStopAttack;
        class PetSpellAutocast;
        class RequestPetInfo;
    }
}


struct LogoutResponse {
  BOOL logoutFailed;
  bool instantLogout;
};


enum AccountDataType
{
    GLOBAL_CONFIG_CACHE             = 0,                    // 0x01 g
    PER_CHARACTER_CONFIG_CACHE      = 1,                    // 0x02 p
    GLOBAL_BINDINGS_CACHE           = 2,                    // 0x04 g
    PER_CHARACTER_BINDINGS_CACHE    = 3,                    // 0x08 p
    GLOBAL_MACROS_CACHE             = 4,                    // 0x10 g
    PER_CHARACTER_MACROS_CACHE      = 5,                    // 0x20 p
    PER_CHARACTER_LAYOUT_CACHE      = 6,                    // 0x40 p
    PER_CHARACTER_CHAT_CACHE        = 7,                    // 0x80 p
};

#define NUM_ACCOUNT_DATA_TYPES        8

#define GLOBAL_CACHE_MASK           0x15
#define PER_CHARACTER_CACHE_MASK    0xEA

struct AccountData
{
    AccountData() :  Data("") {}

    time_t Time{0};
    std::string Data;
};

enum PartyOperation
{
    PARTY_OP_INVITE = 0,
    PARTY_OP_UNINVITE = 1,
    PARTY_OP_LEAVE = 2,
    PARTY_OP_SWAP = 4
};

enum BFLeaveReason
{
    BF_LEAVE_REASON_CLOSE     = 0x00000001,
    //BF_LEAVE_REASON_UNK1      = 0x00000002, (not used)
    //BF_LEAVE_REASON_UNK2      = 0x00000004, (not used)
    BF_LEAVE_REASON_EXITED    = 0x00000008,
    BF_LEAVE_REASON_LOW_LEVEL = 0x00000010,
};

enum ChatRestrictionType
{
    ERR_CHAT_RESTRICTED = 0,
    ERR_CHAT_THROTTLED  = 1,
    ERR_USER_SQUELCHED  = 2,
    ERR_YELL_RESTRICTED = 3
};

enum DeclinedNameResult
{
    DECLINED_NAMES_RESULT_SUCCESS = 0,
    DECLINED_NAMES_RESULT_ERROR = 1
};

enum CharterTypes
{
    GUILD_CHARTER_TYPE                            = 9,
    ARENA_TEAM_CHARTER_2v2_TYPE                   = 2,
    ARENA_TEAM_CHARTER_3v3_TYPE                   = 3,
    ARENA_TEAM_CHARTER_5v5_TYPE                   = 5
};

//class to deal with packet processing
//allows to determine if next packet is safe to be processed
class PacketFilter
{
public:
    explicit PacketFilter(User* pSession) : m_pSession(pSession) {}
    virtual ~PacketFilter() = default;

    virtual bool Process(WDataStore* /*packet*/) { return true; }
    [[nodiscard]] virtual bool ProcessUnsafe() const { return true; }

protected:
    User* const m_pSession;
};
//process only thread-safe packets in Map::Update()
class MapSessionFilter : public PacketFilter
{
public:
    explicit MapSessionFilter(User* pSession) : PacketFilter(pSession) {}
    ~MapSessionFilter() override = default;

    bool Process(WDataStore* packet) override;
    //in Map::Update() we do not process player logout!
    [[nodiscard]] bool ProcessUnsafe() const override { return false; }
};

//class used to filer only thread-unsafe packets from queue
//in order to update only be used in World::UpdateUsers()
class WorldSessionFilter : public PacketFilter
{
public:
    explicit WorldSessionFilter(User* pSession) : PacketFilter(pSession) {}
    ~WorldSessionFilter() override = default;

    bool Process(WDataStore* packet) override;
};

// Proxy structure to contain data passed to callback function,
// only to prevent bloating the parameter list
class CharacterCreateInfo
{
    friend class User;
    friend class Player;

protected:
    /// User specified variables
    std::string Name;
    uint8 Race = 0;
    uint8 Class = 0;
    uint8 Gender = GENDER_NONE;
    uint8 Skin = 0;
    uint8 Face = 0;
    uint8 HairStyle = 0;
    uint8 HairColor = 0;
    uint8 FacialHair = 0;
    uint8 OutfitId = 0;

    /// Server side data
    uint8 CharCount = 0;
};

struct CharacterRenameInfo
{
    friend class User;

protected:
    WOWGUID Guid;
    std::string Name;
};

struct CharacterCustomizeInfo : public CharacterRenameInfo
{
    friend class Player;
    friend class User;

protected:
    uint8 Gender = GENDER_NONE;
    uint8 Skin = 0;
    uint8 Face = 0;
    uint8 HairStyle = 0;
    uint8 HairColor = 0;
    uint8 FacialHair = 0;
};

struct CharacterFactionChangeInfo : public CharacterCustomizeInfo
{
    friend class Player;
    friend class User;

protected:
    uint8 Race = 0;
    bool FactionChange = false;
};

struct PacketCounter
{
    time_t lastReceiveTime;
    uint32 amountCounter;
};

extern void UserInitialize ();
extern void UserDestroy ();

/// Player session in the World
class User
{
public:
    Player* ActivePlayer() const;
    void AddFriend (char const* name, char const* notes);
    void AddIgnore (char const* name);
    void DelIgnore (WOWGUID& guid);
    FriendList* FriendList () const;
    void RemoveFriend (WOWGUID& guid);
    void SendContactList (uint32_t flags);
    void SendFriendStatus (FRIEND_RESULT res, WOWGUID guid);
    void SetFriendNotes (WOWGUID const& guid, char const* notes);

    User(uint32 id, uint32_t accountFlags, std::string&& name, std::shared_ptr<WowConnection> sock, AccountTypes sec, uint8 expansion, time_t mute_time, LocaleConstant locale, uint32 recruiter, bool isARecruiter, bool skipQueue, uint32 TotalTime);
    ~User();

    void CharacterAbortLogout ();
    void CharacterLogout (bool instant);
    bool CharacterLoggingOut () const { return this->m_loggingOut; }
    void CharacterRemoveFromGame(bool save);

    char const* GetAccountName();

    bool IsGMAccount () const;

    bool PlayerLoading() const { return m_playerLoading; }
    bool PlayerRecentlyLoggedOut() const { return m_playerRecentlyLogout; }
    bool PlayerLogoutWithSave() const { return m_loggingOut && m_playerSave; }

    void ReadAddonsInfo(ByteBuffer& data);
    void SendAddonsInfo();

    void ReadMovementInfo(WDataStore& data, CMovement* mi);
    void WriteMovementInfo(WDataStore* data, CMovement* mi);

    void SendLogoutCancelAckMessage ();
    void SendLogoutCompleteMessage ();
    void SendLogoutResponse (LogoutResponse& res);

    void Send(WDataStore const* packet);
    void SendNotification(const char* format, ...) ATTR_PRINTF(2, 3);
    void SendNotification(uint32 string_id, ...);
    void SendPetNameInvalid(uint32 error, std::string const& name, DeclinedName* declinedName);
    void SendPartyResult(PartyOperation operation, std::string const& member, PartyResult res, uint32 val = 0);
    void SendAreaTriggerMessage(const char* Text, ...) ATTR_PRINTF(2, 3);
    void SendAreaTriggerMessage(uint32 entry, ...);
    void SendSetPhaseShift(uint32 phaseShift);
    void SendQueryTimeResponse();

    void SendAuthResponse(uint8 code, bool shortForm, uint32 queuePos = 0);
    void SendClientCacheVersion(uint32 version);

    AccountTypes GetSecurity() const { return _security; }
    bool CanSkipQueue() const { return _skipQueue; }
    uint32 GetAccountId() const { return _accountId; }
    Player* GetPlayer() const { return m_player; }
    std::string const& GetPlayerName() const;
    std::string GetPlayerInfo() const;

    uint32 GetCurrentVendor() const { return m_currentVendorEntry; }
    void SetCurrentVendor(uint32 vendorEntry) { m_currentVendorEntry = vendorEntry; }

    WOWGUID::LowType GetGuidLow() const;
    void SetSecurity(AccountTypes security) { _security = security; }
    std::string const& GetRemoteAddress() { return m_Address; }
    void SetPlayer(Player* player);
    uint8 Expansion() const { return m_expansion; }

    void SetTotalTime(uint32 TotalTime) { m_total_time = TotalTime; }
    uint32 GetTotalTime() const { return m_total_time; }

    void InitWarden(SessionKey const&, std::string const& os);
    Warden* GetWarden();

    /// Session in auth.queue currently
    void SetInQueue(bool state) { m_inQueue = state; }

    void KickPlayer(bool setKicked = true) { return this->KickPlayer("Unknown reason", setKicked); }
    void KickPlayer(std::string const& reason, bool setKicked = true);

    // Returns true if all contained hyperlinks are valid
    // May kick player on false depending on world config (handler should abort)
    bool ValidateHyperlinksAndMaybeKick(std::string_view str);
    // Returns true if the message contains no hyperlinks
    // May kick player on false depending on world config (handler should abort)
    bool DisallowHyperlinksAndMaybeKick(std::string_view str);

    void QueuePacket(WDataStore* new_packet);
    bool Update(uint32 diff, PacketFilter& updater);

    /// Handle the authentication waiting queue (to be completed)
    void SendAuthWaitQueue(uint32 position);

    //void SendTestCreatureQueryOpcode(uint32 entry, WOWGUID guid, uint32 testvalue);
    void SendNameQueryOpcode(WOWGUID guid);

    void SendTrainerList(WOWGUID guid);
    void SendTrainerList(WOWGUID guid, std::string const& strTitle);
    void SendListInventory(WOWGUID guid, uint32 vendorEntry = 0);
    void SendShowBank(WOWGUID guid);
    bool CanOpenMailBox(WOWGUID guid);
    void SendShowMailBox(WOWGUID guid);
    void SendTabardVendorActivate(WOWGUID guid);
    void SendSpiritResurrect();
    void SendBindPoint(Creature* npc);

    void SendAttackStop(Unit const* enemy);

    void SendBattleGroundList(WOWGUID guid, BattlegroundTypeId bgTypeId = BATTLEGROUND_RB);

    void SendTradeStatus(TradeStatus status);
    void SendUpdateTrade(bool trader_data = true);
    void SendCancelTrade();

    void SendPetitionQueryOpcode(WOWGUID petitionguid);

    // Spell
    void HandleClientCastFlags(WDataStore& recvPacket, uint8 castFlags, SpellCastTargets& targets);

    // Pet
    void SendPetNameQuery(WOWGUID guid, uint32 petnumber);
    void SendStablePet(WOWGUID guid);
    void SendStablePetCallback(WOWGUID guid, PreparedQueryResult result);
    void SendStableResult(uint8 guid);
    bool CheckStableMaster(WOWGUID guid);

    // Account Data
    AccountData* GetAccountData(AccountDataType type) { return &m_accountData[type]; }
    void SetAccountData(AccountDataType type, time_t tm, std::string const& data);
    void SendAccountDataTimes(uint32 mask);
    void LoadAccountData(PreparedQueryResult result, uint32 mask);

    void LoadTutorialsData(PreparedQueryResult result);
    void SendTutorialsData();
    void SaveTutorialsData(CharacterDatabaseTransaction trans);
    uint32 GetTutorialInt(uint8 index) const { return m_Tutorials[index]; }
    void SetTutorialInt(uint8 index, uint32 value)
    {
        if (m_Tutorials[index] != value)
        {
            m_Tutorials[index] = value;
            m_TutorialsChanged = true;
        }
    }
    //auction
    void SendAuctionHello(WOWGUID guid, Creature* unit);
    void SendAuctionCommandResult(uint32 auctionId, uint32 Action, uint32 ErrorCode, uint32 bidError = 0);
    void SendAuctionBidderNotification(uint32 location, uint32 auctionId, WOWGUID bidder, uint32 bidSum, uint32 diff, uint32 item_template);
    void SendAuctionOwnerNotification(AuctionEntry* auction);

    //Item Enchantment
    void SendEnchantmentLog(WOWGUID target, WOWGUID caster, uint32 itemId, uint32 enchantId);
    void SendItemEnchantTimeUpdate(WOWGUID Playerguid, WOWGUID Itemguid, uint32 slot, uint32 Duration);

    //Taxi
    void SendTaxiStatus(WOWGUID guid);
    void SendTaxiMenu(Creature* unit);
    void SendDoFlight(uint32 mountDisplayId, uint32 path, uint32 pathNode = 0);
    bool SendLearnNewTaxiNode(Creature* unit);
    void SendDiscoverNewTaxiNode(uint32 nodeid);

    // Guild/Arena Team
    void SendArenaTeamCommandResult(uint32 team_action, std::string const& team, std::string const& player, uint32 error_id = 0);
    void SendNotInArenaTeamPacket(uint8 type);
    void SendPetitionShowList(WOWGUID guid);

    void BuildPartyMemberStatsChangedPacket(Player* player, WDataStore* data);

    void DoLootRelease(WOWGUID lguid);

    // Account mute time
    time_t m_muteTime;

    // Locales
    LocaleConstant GetSessionDbcLocale() const { return m_sessionDbcLocale; }
    LocaleConstant GetSessionDbLocaleIndex() const { return m_sessionDbLocaleIndex; }
    char const* GetAcoreString(uint32 entry) const;

    uint32 GetLatency() const { return m_latency; }
    void SetLatency(uint32 latency) { m_latency = latency; }

    std::atomic<time_t> m_timeOutTime;
    void UpdateTimeOutTime(uint32 diff)
    {
        if (time_t(diff) > m_timeOutTime)
            m_timeOutTime = 0;
        else
            m_timeOutTime -= diff;
    }
    void ResetTimeOutTime(bool onlyActive)
    {
        if (GetPlayer())
            m_timeOutTime = int32(sWorld->getIntConfig(CONFIG_SOCKET_TIMEOUTTIME_ACTIVE));
        else if (!onlyActive)
            m_timeOutTime = int32(sWorld->getIntConfig(CONFIG_SOCKET_TIMEOUTTIME));
    }
    bool IsConnectionIdle() const
    {
        return (m_timeOutTime <= 0 && !m_inQueue);
    }

    // Recruit-A-Friend Handling
    uint32 GetRecruiterId() const { return recruiterId; }
    bool IsARecruiter() const { return isRecruiter; }

    // Packets cooldown
    time_t GetCalendarEventCreationCooldown() const { return _calendarEventCreationCooldown; }
    void SetCalendarEventCreationCooldown(time_t cooldown) { _calendarEventCreationCooldown = cooldown; }

    // Time Synchronisation
    void ResetTimeSync();
    void SendTimeSync();
public:                                                 // opcodes handlers
    void Handle_NULL(WDataStore& null);                // not used
    void Handle_EarlyProccess(WDataStore& recvPacket); // just mark packets processed in WowConnection::OnRead
    void Handle_ServerSide(WDataStore& recvPacket);    // sever side only, can't be accepted from client
    void Handle_Deprecated(WDataStore& recvPacket);    // never used anymore by client

    void HandleCharEnumOpcode(WDataStore& recvPacket);
    void HandleCharDeleteOpcode(WDataStore& recvPacket);
    void HandleCharCreateOpcode(WDataStore& recvPacket);
    void HandlePlayerLoginOpcode(WDataStore& recvPacket);
    void HandleCharEnum(PreparedQueryResult result);
    void HandlePlayerLoginFromDB(LoginQueryHolder const& holder);
    void HandlePlayerLoginToCharInWorld(Player* pCurrChar);
    void HandlePlayerLoginToCharOutOfWorld(Player* pCurrChar);
    void HandleCharFactionOrRaceChange(WDataStore& recvData);
    void HandleCharFactionOrRaceChangeCallback(std::shared_ptr<CharacterFactionChangeInfo> factionChangeInfo, PreparedQueryResult result);

    void SendCharCreate(ResponseCodes result);
    void SendCharDelete(ResponseCodes result);
    void SendCharRename(ResponseCodes result, CharacterRenameInfo const* renameInfo);
    void SendCharCustomize(ResponseCodes result, CharacterCustomizeInfo const* customizeInfo);
    void SendCharFactionChange(ResponseCodes result, CharacterFactionChangeInfo const* factionChangeInfo);
    void SendSetPlayerDeclinedNamesResult(DeclinedNameResult result, WOWGUID guid);

    // played time
    void HandlePlayedTime(WorldPackets::Character::PlayedTimeClient& packet);

    // new
    void HandleMoveUnRootAck(WDataStore& recvPacket);
    void HandleMoveRootAck(WDataStore& recvPacket);

    // new inspect
    void HandleInspectOpcode(WDataStore& recvPacket);

    // new party stats
    void HandleInspectHonorStatsOpcode(WDataStore& recvPacket);

    void HandleMoveWaterWalkAck(WDataStore& recvPacket);
    void HandleFeatherFallAck(WDataStore& recvData);

    void HandleMoveHoverAck(WDataStore& recvData);

    void HandleMountSpecialAnimOpcode(WDataStore& recvdata);

    // character view
    void HandleShowingHelmOpcode(WorldPackets::Character::ShowingHelm& packet);
    void HandleShowingCloakOpcode(WorldPackets::Character::ShowingCloak& packet);

    // repair
    void HandleRepairItemOpcode(WDataStore& recvPacket);

    // Knockback
    void HandleMoveKnockBackAck(WDataStore& recvPacket);

    void HandleMoveTeleportAck(WDataStore& recvPacket);
    void HandleForceSpeedChangeAck(WDataStore& recvData);

    void HandleRepopRequestOpcode(WDataStore& recvPacket);
    void HandleAutostoreLootItemOpcode(WDataStore& recvPacket);
    void HandleLootMoneyOpcode(WDataStore& recvPacket);
    void HandleLootOpcode(WDataStore& recvPacket);
    void HandleLootReleaseOpcode(WDataStore& recvPacket);
    void HandleLootMasterGiveOpcode(WDataStore& recvPacket);
    void HandleWhoOpcode(WDataStore& recvPacket);

    // GM Ticket opcodes
    void HandleGMTicketCreateOpcode(WDataStore& recvPacket);
    void HandleGMTicketUpdateOpcode(WDataStore& recvPacket);
    void HandleGMTicketDeleteOpcode(WDataStore& recvPacket);
    void HandleGMTicketGetTicketOpcode(WDataStore& recvPacket);
    void HandleGMTicketSystemStatusOpcode(WDataStore& recvPacket);
    void HandleGMSurveySubmit(WDataStore& recvPacket);
    void HandleReportLag(WDataStore& recvPacket);
    void HandleGMResponseResolve(WDataStore& recvPacket);

    void HandleTogglePvP(WDataStore& recvPacket);

    void HandleZoneUpdateOpcode(WDataStore& recvPacket);
    void HandleSetSelectionOpcode(WDataStore& recvPacket);
    void HandleStandStateChangeOpcode(WDataStore& recvPacket);
    void HandleEmoteOpcode(WorldPackets::Chat::EmoteClient& packet);
    void HandleBugOpcode(WDataStore& recvPacket);
    void HandleSetAmmoOpcode(WDataStore& recvPacket);
    void HandleItemNameQueryOpcode(WDataStore& recvPacket);

    void HandleAreaTriggerOpcode(WDataStore& recvPacket);

    void HandleSetFactionAtWar(WDataStore& recvData);
    void HandleSetFactionCheat(WDataStore& recvData);
    void HandleSetWatchedFactionOpcode(WDataStore& recvData);
    void HandleSetFactionInactiveOpcode(WDataStore& recvData);

    void HandleUpdateAccountData(WDataStore& recvPacket);
    void HandleRequestAccountData(WDataStore& recvPacket);
    void HandleSetActionButtonOpcode(WDataStore& recvPacket);

    void HandleGameObjectUseOpcode(WDataStore& recPacket);
    void HandleGameobjectReportUse(WDataStore& recvPacket);

    void HandleNameQueryOpcode(WDataStore& recvPacket);

    void HandleQueryTimeOpcode(WDataStore& recvPacket);

    void HandleCreatureQueryOpcode(WDataStore& recvPacket);

    void HandleGameObjectQueryOpcode(WDataStore& recvPacket);

    void HandleMoveWorldportAckOpcode(WDataStore& recvPacket);
    void HandleMoveWorldportAck(); // for server-side calls

    void HandleMovementOpcodes(WDataStore& recvPacket);
    void HandleSetActiveMoverOpcode(WDataStore& recvData);
    void HandleMoveNotActiveMover(WDataStore& recvData);
    void HandleDismissControlledVehicle(WDataStore& recvData);
    void HandleRequestVehicleExit(WDataStore& recvData);
    void HandleChangeSeatsOnControlledVehicle(WDataStore& recvData);
    void HandleMoveTimeSkippedOpcode(WDataStore& recvData);

    void HandleRequestRaidInfoOpcode(WDataStore& recvData);

    void HandleBattlefieldStatusOpcode(WDataStore& recvData);

    void HandleGroupInviteOpcode(WDataStore& recvPacket);
    void HandleGroupAcceptOpcode(WDataStore& recvPacket);
    void HandleGroupDeclineOpcode(WDataStore& recvPacket);
    void HandleGroupUninviteOpcode(WDataStore& recvPacket);
    void HandleGroupUninviteGuidOpcode(WDataStore& recvPacket);
    void HandleGroupSetLeaderOpcode(WDataStore& recvPacket);
    void HandleGroupDisbandOpcode(WDataStore& recvPacket);
    void HandleOptOutOfLootOpcode(WDataStore& recvData);
    void HandleLootMethodOpcode(WDataStore& recvPacket);
    void HandleLootRoll(WDataStore& recvData);
    void HandleRequestPartyMemberStatsOpcode(WDataStore& recvData);
    void HandleGroupSwapSubGroupOpcode(WDataStore& recvData);
    void HandleRaidTargetUpdateOpcode(WDataStore& recvData);
    void HandleRaidReadyCheckOpcode(WDataStore& recvData);
    void HandleRaidReadyCheckFinishedOpcode(WDataStore& recvData);
    void HandleGroupRaidConvertOpcode(WDataStore& recvData);
    void HandleGroupChangeSubGroupOpcode(WDataStore& recvData);
    void HandleGroupAssistantLeaderOpcode(WDataStore& recvData);
    void HandlePartyAssignmentOpcode(WDataStore& recvData);

    void HandlePetitionBuyOpcode(WDataStore& recvData);
    void HandlePetitionShowSignOpcode(WDataStore& recvData);
    void HandlePetitionQueryOpcode(WDataStore& recvData);
    void HandlePetitionRenameOpcode(WDataStore& recvData);
    void HandlePetitionSignOpcode(WDataStore& recvData);
    void HandlePetitionDeclineOpcode(WDataStore& recvData);
    void HandleOfferPetitionOpcode(WDataStore& recvData);
    void HandleTurnInPetitionOpcode(WDataStore& recvData);

    void HandleGuildQueryOpcode(WorldPackets::Guild::QueryGuildInfo& query);
    void HandleGuildCreateOpcode(WorldPackets::Guild::GuildCreate& packet);
    void HandleGuildInviteOpcode(WorldPackets::Guild::GuildInviteByName& packet);
    void HandleGuildRemoveOpcode(WorldPackets::Guild::GuildOfficerRemoveMember& packet);
    void HandleGuildAcceptOpcode(WorldPackets::Guild::AcceptGuildInvite& invite);
    void HandleGuildDeclineOpcode(WorldPackets::Guild::GuildDeclineInvitation& decline);
    void HandleGuildInfoOpcode(WorldPackets::Guild::GuildGetInfo& packet);
    void HandleGuildEventLogQueryOpcode(WorldPackets::Guild::GuildEventLogQuery& packet);
    void HandleGuildRosterOpcode(WorldPackets::Guild::GuildGetRoster& packet);
    void HandleGuildPromoteOpcode(WorldPackets::Guild::GuildPromoteMember& promote);
    void HandleGuildDemoteOpcode(WorldPackets::Guild::GuildDemoteMember& demote);
    void HandleGuildLeaveOpcode(WorldPackets::Guild::GuildLeave& leave);
    void HandleGuildDisbandOpcode(WorldPackets::Guild::GuildDelete& packet);
    void HandleGuildLeaderOpcode(WorldPackets::Guild::GuildSetGuildMaster& packet);
    void HandleGuildMOTDOpcode(WorldPackets::Guild::GuildUpdateMotdText& packet);
    void HandleGuildSetPublicNoteOpcode(WorldPackets::Guild::GuildSetMemberNote& packet);
    void HandleGuildSetOfficerNoteOpcode(WorldPackets::Guild::GuildSetMemberNote& packet);
    void HandleGuildRankOpcode(WorldPackets::Guild::GuildSetRankPermissions& packet);
    void HandleGuildAddRankOpcode(WorldPackets::Guild::GuildAddRank& packet);
    void HandleGuildDelRankOpcode(WorldPackets::Guild::GuildDeleteRank& packet);
    void HandleGuildChangeInfoTextOpcode(WorldPackets::Guild::GuildUpdateInfoText& packet);
    void HandleSaveGuildEmblemOpcode(WorldPackets::Guild::SaveGuildEmblem& packet);

    void HandleTaxiNodeStatusQueryOpcode(WDataStore& recvPacket);
    void HandleTaxiQueryAvailableNodes(WDataStore& recvPacket);
    void HandleActivateTaxiOpcode(WDataStore& recvPacket);
    void HandleActivateTaxiExpressOpcode(WDataStore& recvPacket);
    void HandleMoveSplineDoneOpcode(WDataStore& recvPacket);
    void SendActivateTaxiReply(ActivateTaxiReply reply);

    void HandleTabardVendorActivateOpcode(WDataStore& recvPacket);
    void HandleTrainerListOpcode(WDataStore& recvPacket);
    void HandleTrainerBuySpellOpcode(WDataStore& recvPacket);
    void HandlePetitionShowListOpcode(WDataStore& recvPacket);
    void HandleGossipHelloOpcode(WDataStore& recvPacket);
    void HandleGossipSelectOptionOpcode(WDataStore& recvPacket);
    void HandleSpiritHealerActivateOpcode(WDataStore& recvPacket);
    void HandleNpcTextQueryOpcode(WDataStore& recvPacket);
    void HandleBinderActivateOpcode(WDataStore& recvPacket);
    void HandleListStabledPetsOpcode(WDataStore& recvPacket);
    void HandleStablePet(WDataStore& recvPacket);
    void HandleUnstablePet(WDataStore& recvPacket);
    void HandleBuyStableSlot(WDataStore& recvPacket);
    void HandleStableRevivePet(WDataStore& recvPacket);
    void HandleStableSwapPet(WDataStore& recvPacket);
    void HandleOpenWrappedItemCallback(uint8 bagIndex, uint8 slot, WOWGUID::LowType itemLowGUID, PreparedQueryResult result);
    void HandleLoadActionsSwitchSpec(PreparedQueryResult result);
    void HandleCharacterAuraFrozen(PreparedQueryResult result);

    void HandleDuelAcceptedOpcode(WDataStore& recvPacket);
    void HandleDuelCancelledOpcode(WDataStore& recvPacket);

    void HandleAcceptTradeOpcode(WDataStore& recvPacket);
    void HandleBeginTradeOpcode(WDataStore& recvPacket);
    void HandleBusyTradeOpcode(WDataStore& recvPacket);
    void HandleCancelTradeOpcode(WDataStore& recvPacket);
    void HandleClearTradeItemOpcode(WDataStore& recvPacket);
    void HandleIgnoreTradeOpcode(WDataStore& recvPacket);
    void HandleInitiateTradeOpcode(WDataStore& recvPacket);
    void HandleSetTradeGoldOpcode(WDataStore& recvPacket);
    void HandleSetTradeItemOpcode(WDataStore& recvPacket);
    void HandleUnacceptTradeOpcode(WDataStore& recvPacket);

    void HandleAuctionHelloOpcode(WDataStore& recvPacket);
    void HandleAuctionListItems(WDataStore& recvData);
    void HandleAuctionListBidderItems(WDataStore& recvData);
    void HandleAuctionSellItem(WDataStore& recvData);
    void HandleAuctionRemoveItem(WDataStore& recvData);
    void HandleAuctionListOwnerItems(WDataStore& recvData);
    void HandleAuctionListOwnerItemsEvent(WOWGUID creatureGuid);
    void HandleAuctionPlaceBid(WDataStore& recvData);
    void HandleAuctionListPendingSales(WDataStore& recvData);

    // Bank
    void HandleBankerActivateOpcode(WDataStore& recvData);
    void HandleAutoBankItemOpcode(WorldPackets::Bank::AutoBankItem& packet);
    void HandleAutoStoreBankItemOpcode(WorldPackets::Bank::AutoStoreBankItem& packet);
    void HandleBuyBankSlotOpcode(WorldPackets::Bank::BuyBankSlot& buyBankSlot);

    void HandleGetMailList(WDataStore& recvData);
    void HandleSendMail(WDataStore& recvData);
    void HandleMailTakeMoney(WDataStore& recvData);
    void HandleMailTakeItem(WDataStore& recvData);
    void HandleMailMarkAsRead(WDataStore& recvData);
    void HandleMailReturnToSender(WDataStore& recvData);
    void HandleMailDelete(WDataStore& recvData);
    void HandleItemTextQuery(WDataStore& recvData);
    void HandleMailCreateTextItem(WDataStore& recvData);
    void HandleQueryNextMailTime(WDataStore& recvData);
    void HandleCancelChanneling(WDataStore& recvData);

    void HandleSplitItemOpcode(WDataStore& recvPacket);
    void HandleSwapInvItemOpcode(WDataStore& recvPacket);
    void HandleDestroyItemOpcode(WDataStore& recvPacket);
    void HandleAutoEquipItemOpcode(WDataStore& recvPacket);
    void HandleItemQuerySingleOpcode(WDataStore& recvPacket);
    void HandleSellItemOpcode(WDataStore& recvPacket);
    void HandleBuyItemInSlotOpcode(WDataStore& recvPacket);
    void HandleBuyItemOpcode(WDataStore& recvPacket);
    void HandleListInventoryOpcode(WDataStore& recvPacket);
    void HandleAutoStoreBagItemOpcode(WDataStore& recvPacket);
    void HandleReadItem(WDataStore& recvPacket);
    void HandleAutoEquipItemSlotOpcode(WDataStore& recvPacket);
    void HandleSwapItem(WDataStore& recvPacket);
    void HandleBuybackItem(WDataStore& recvPacket);
    void HandleWrapItemOpcode(WDataStore& recvPacket);

    void HandleAttackSwingOpcode(WDataStore& recvPacket);
    void HandleAttackStopOpcode(WDataStore& recvPacket);
    void HandleSetSheathedOpcode(WorldPackets::Combat::SetSheathed& packet);

    void HandleUseItemOpcode(WDataStore& recvPacket);
    void HandleOpenItemOpcode(WDataStore& recvPacket);
    void HandleCastSpellOpcode(WDataStore& recvPacket);
    void HandleCancelCastOpcode(WDataStore& recvPacket);
    void HandleCancelAuraOpcode(WDataStore& recvPacket);
    void HandleCancelGrowthAuraOpcode(WDataStore& recvPacket);
    void HandleCancelAutoRepeatSpellOpcode(WDataStore& recvPacket);

    void HandleLearnTalentOpcode(WDataStore& recvPacket);
    void HandleLearnPreviewTalents(WDataStore& recvPacket);
    void HandleTalentWipeConfirmOpcode(WDataStore& recvPacket);
    void HandleUnlearnSkillOpcode(WDataStore& recvPacket);

    void HandleQuestgiverStatusQueryOpcode(WDataStore& recvPacket);
    void HandleQuestgiverStatusMultipleQuery(WDataStore& recvPacket);
    void HandleQuestgiverHelloOpcode(WDataStore& recvPacket);
    void HandleQuestgiverAcceptQuestOpcode(WDataStore& recvPacket);
    void HandleQuestgiverQueryQuestOpcode(WDataStore& recvPacket);
    void HandleQuestgiverChooseRewardOpcode(WDataStore& recvPacket);
    void HandleQuestgiverRequestRewardOpcode(WDataStore& recvPacket);
    void HandleQuestQueryOpcode(WDataStore& recvPacket);
    void HandleQuestgiverCancel(WDataStore& recvData);
    void HandleQuestLogSwapQuest(WDataStore& recvData);
    void HandleQuestLogRemoveQuest(WDataStore& recvData);
    void HandleQuestConfirmAccept(WDataStore& recvData);
    void HandleQuestgiverCompleteQuest(WDataStore& recvData);
    void HandleQuestgiverQuestAutoLaunch(WDataStore& recvPacket);
    void HandlePushQuestToParty(WDataStore& recvPacket);
    void HandleQuestPushResult(WDataStore& recvPacket);

    void HandleMessagechatOpcode(WDataStore& recvPacket);
    void SendPlayerNotFoundNotice(std::string const& name);
    void SendPlayerAmbiguousNotice(std::string const& name);
    void SendWrongFactionNotice();
    void SendChatRestrictedNotice(ChatRestrictionType restriction);
    void HandleTextEmoteOpcode(WDataStore& recvPacket);
    void HandleChatIgnoredOpcode(WDataStore& recvPacket);

    void HandleReclaimCorpseOpcode(WDataStore& recvPacket);
    void HandleCorpseQueryOpcode(WDataStore& recvPacket);
    void HandleCorpseMapPositionQuery(WDataStore& recvPacket);
    void HandleResurrectResponseOpcode(WDataStore& recvPacket);
    void HandleSummonResponseOpcode(WDataStore& recvData);

    void HandleJoinChannel(WDataStore& recvPacket);
    void HandleLeaveChannel(WDataStore& recvPacket);
    void HandleChannelList(WDataStore& recvPacket);
    void HandleChannelPassword(WDataStore& recvPacket);
    void HandleChannelSetOwner(WDataStore& recvPacket);
    void HandleChannelOwner(WDataStore& recvPacket);
    void HandleChannelModerator(WDataStore& recvPacket);
    void HandleChannelUnmoderator(WDataStore& recvPacket);
    void HandleChannelMute(WDataStore& recvPacket);
    void HandleChannelUnmute(WDataStore& recvPacket);
    void HandleChannelInvite(WDataStore& recvPacket);
    void HandleChannelKick(WDataStore& recvPacket);
    void HandleChannelBan(WDataStore& recvPacket);
    void HandleChannelUnban(WDataStore& recvPacket);
    void HandleChannelAnnouncements(WDataStore& recvPacket);
    void HandleChannelModerateOpcode(WDataStore& recvPacket);
    void HandleChannelDeclineInvite(WDataStore& recvPacket);
    void HandleChannelDisplayListQuery(WDataStore& recvPacket);
    void HandleGetChannelMemberCount(WDataStore& recvPacket);
    void HandleSetChannelWatch(WDataStore& recvPacket);
    void HandleClearChannelWatch(WDataStore& recvPacket);

    void HandleCompleteCinematic(WDataStore& recvPacket);
    void HandleNextCinematicCamera(WDataStore& recvPacket);

    void HandlePageTextQueryOpcode(WDataStore& recvPacket);

    void HandleTutorialFlag (WDataStore& recvData);
    void HandleTutorialClear(WDataStore& recvData);
    void HandleTutorialReset(WDataStore& recvData);

    //Pet
    void HandlePetAction(WDataStore& recvData);
    void HandlePetStopAttack(WorldPackets::Pet::PetStopAttack& packet);
    void HandlePetActionHelper(Unit* pet, WOWGUID guid1, uint32 spellid, uint16 flag, WOWGUID guid2);
    void HandlePetNameQuery(WDataStore& recvData);
    void HandlePetSetAction(WDataStore& recvData);
    void HandlePetAbandon(WorldPackets::Pet::PetAbandon& packet);
    void HandlePetRename(WDataStore& recvData);
    void HandlePetCancelAuraOpcode(WDataStore& recvPacket);
    void HandlePetSpellAutocastOpcode(WorldPackets::Pet::PetSpellAutocast& packet);
    void HandlePetCastSpellOpcode(WDataStore& recvPacket);
    void HandlePetLearnTalent(WDataStore& recvPacket);
    void HandleLearnPreviewTalentsPet(WDataStore& recvPacket);

    void HandleSetActionBarToggles(WDataStore& recvData);

    void HandleCharRenameOpcode(WDataStore& recvData);
    void HandleCharRenameCallBack(std::shared_ptr<CharacterRenameInfo> renameInfo, PreparedQueryResult result);
    void HandleSetPlayerDeclinedNames(WDataStore& recvData);

    void HandleTotemDestroyed(WorldPackets::Totem::TotemDestroyed& totemDestroyed);
    void HandleDismissCritter(WorldPackets::Pet::DismissCritter& dismissCritter);

    //Battleground
    void HandleBattlemasterHelloOpcode(WDataStore& recvData);
    void HandleBattlemasterJoinOpcode(WDataStore& recvData);
    void HandleBattlegroundPlayerPositionsOpcode(WDataStore& recvData);
    void HandlePVPLogDataOpcode(WDataStore& recvData);
    void HandleBattleFieldPortOpcode(WDataStore& recvData);
    void HandleBattlefieldListOpcode(WDataStore& recvData);
    void HandleBattlefieldLeaveOpcode(WDataStore& recvData);
    void HandleBattlemasterJoinArena(WDataStore& recvData);
    void HandleReportPvPAFK(WDataStore& recvData);

    void HandleWardenDataOpcode(WDataStore& recvData);
    void HandleMinimapPingOpcode(WDataStore& recvData);
    void HandleRandomRollOpcode(WorldPackets::Misc::RandomRollClient& packet);
    void HandleFarSightOpcode(WDataStore& recvData);
    void HandleSetDungeonDifficultyOpcode(WDataStore& recvData);
    void HandleSetRaidDifficultyOpcode(WDataStore& recvData);
    void HandleMoveSetCanFlyAckOpcode(WDataStore& recvData);
    void HandleSetTitleOpcode(WDataStore& recvData);
    void HandleRealmSplitOpcode(WDataStore& recvData);
    void HandleTimeSyncResp(WDataStore& recvData);
    void HandleResetInstancesOpcode(WDataStore& recvData);
    void HandleHearthAndResurrect(WDataStore& recvData);
    void HandleInstanceLockResponse(WDataStore& recvPacket);
    void HandleUpdateMissileTrajectory(WDataStore& recvPacket);

    // Battlefield
    void SendBfInvitePlayerToWar(uint32 battleId, uint32 zoneId, uint32 time);
    void SendBfInvitePlayerToQueue(uint32 battleId);
    void SendBfQueueInviteResponse(uint32 battleId, uint32 zoneId, bool canQueue = true, bool full = false);
    void SendBfEntered(uint32 battleId);
    void SendBfLeaveMessage(uint32 battleId, BFLeaveReason reason = BF_LEAVE_REASON_EXITED);
    void HandleBfQueueInviteResponse(WDataStore& recvData);
    void HandleBfEntryInviteResponse(WDataStore& recvData);
    void HandleBfExitRequest(WDataStore& recvData);

    // Looking for Dungeon/Raid
    void HandleLfgSetCommentOpcode(WDataStore& recvData);
    void HandleLfgPlayerLockInfoRequestOpcode(WDataStore& recvData);
    void HandleLfgPartyLockInfoRequestOpcode(WDataStore& recvData);
    void HandleLfgJoinOpcode(WorldPackets::LFG::LFGJoin& lfgJoin);
    void HandleLfgLeaveOpcode(WorldPackets::LFG::LFGLeave& lfgleave);
    void HandleLfgSetRolesOpcode(WDataStore& recvData);
    void HandleLfgProposalResultOpcode(WDataStore& recvData);
    void HandleLfgSetBootVoteOpcode(WDataStore& recvData);
    void HandleLfgTeleportOpcode(WDataStore& recvData);
    void HandleLfrSearchJoinOpcode(WDataStore& recvData);
    void HandleLfrSearchLeaveOpcode(WDataStore& recvData);
    void HandleLfgGetStatus(WDataStore& recvData);

    void SendLfgUpdatePlayer(lfg::LfgUpdateData const& updateData);
    void SendLfgUpdateParty(lfg::LfgUpdateData const& updateData);
    void SendLfgRoleChosen(WOWGUID guid, uint8 roles);
    void SendLfgRoleCheckUpdate(lfg::LfgRoleCheck const& pRoleCheck);
    void SendLfgLfrList(bool update);
    void SendLfgJoinResult(lfg::LfgJoinResultData const& joinData);
    void SendLfgQueueStatus(lfg::LfgQueueStatusData const& queueData);
    void SendLfgPlayerReward(lfg::LfgPlayerRewardData const& lfgPlayerRewardData);
    void SendLfgBootProposalUpdate(lfg::LfgPlayerBoot const& boot);
    void SendLfgUpdateProposal(lfg::LfgProposal const& proposal);
    void SendLfgDisabled();
    void SendLfgOfferContinue(uint32 dungeonEntry);
    void SendLfgTeleportError(uint8 err);

    // Arena Team
    void HandleInspectArenaTeamsOpcode(WDataStore& recvData);
    void HandleArenaTeamQueryOpcode(WDataStore& recvData);
    void HandleArenaTeamRosterOpcode(WDataStore& recvData);
    void HandleArenaTeamInviteOpcode(WDataStore& recvData);
    void HandleArenaTeamAcceptOpcode(WDataStore& recvData);
    void HandleArenaTeamDeclineOpcode(WDataStore& recvData);
    void HandleArenaTeamLeaveOpcode(WDataStore& recvData);
    void HandleArenaTeamRemoveOpcode(WDataStore& recvData);
    void HandleArenaTeamDisbandOpcode(WDataStore& recvData);
    void HandleArenaTeamLeaderOpcode(WDataStore& recvData);

    void HandleAreaSpiritHealerQueryOpcode(WDataStore& recvData);
    void HandleAreaSpiritHealerQueueOpcode(WDataStore& recvData);
    void HandleCancelMountAuraOpcode(WDataStore& recvData);
    void HandleSelfResOpcode(WDataStore& recvData);
    void HandleComplainOpcode(WDataStore& recvData);
    void HandleRequestPetInfo(WorldPackets::Pet::RequestPetInfo& packet);

    // Socket gem
    void HandleSocketOpcode(WDataStore& recvData);

    void HandleCancelTempEnchantmentOpcode(WDataStore& recvData);

    void HandleItemRefundInfoRequest(WDataStore& recvData);
    void HandleItemRefund(WDataStore& recvData);

    void HandleChannelVoiceOnOpcode(WDataStore& recvData);
    void HandleVoiceSessionEnableOpcode(WDataStore& recvData);
    void HandleSetActiveVoiceChannel(WDataStore& recvData);
    void HandleSetTaxiBenchmarkOpcode(WDataStore& recvData);

    // Guild Bank
    void HandleGuildPermissions(WorldPackets::Guild::GuildPermissionsQuery& packet);
    void HandleGuildBankMoneyWithdrawn(WorldPackets::Guild::GuildBankRemainingWithdrawMoneyQuery& packet);
    void HandleGuildBankerActivate(WorldPackets::Guild::GuildBankActivate& packet);
    void HandleGuildBankQueryTab(WorldPackets::Guild::GuildBankQueryTab& packet);
    void HandleGuildBankLogQuery(WorldPackets::Guild::GuildBankLogQuery& packet);
    void HandleGuildBankDepositMoney(WorldPackets::Guild::GuildBankDepositMoney& packet);
    void HandleGuildBankWithdrawMoney(WorldPackets::Guild::GuildBankWithdrawMoney& packet);
    void HandleGuildBankSwapItems(WorldPackets::Guild::GuildBankSwapItems& packet);

    void HandleGuildBankUpdateTab(WorldPackets::Guild::GuildBankUpdateTab& packet);
    void HandleGuildBankBuyTab(WorldPackets::Guild::GuildBankBuyTab& packet);
    void HandleQueryGuildBankTabText(WorldPackets::Guild::GuildBankTextQuery& packet);
    void HandleSetGuildBankTabText(WorldPackets::Guild::GuildBankSetTabText& packet);

    // Refer-a-Friend
    void HandleGrantLevel(WDataStore& recvData);
    void HandleAcceptGrantLevel(WDataStore& recvData);

    // Calendar
    void HandleCalendarGetCalendar(WDataStore& recvData);
    void HandleCalendarGetEvent(WDataStore& recvData);
    void HandleCalendarGuildFilter(WDataStore& recvData);
    void HandleCalendarArenaTeam(WDataStore& recvData);
    void HandleCalendarAddEvent(WDataStore& recvData);
    void HandleCalendarUpdateEvent(WDataStore& recvData);
    void HandleCalendarRemoveEvent(WDataStore& recvData);
    void HandleCalendarCopyEvent(WDataStore& recvData);
    void HandleCalendarEventInvite(WDataStore& recvData);
    void HandleCalendarEventRsvp(WDataStore& recvData);
    void HandleCalendarEventRemoveInvite(WDataStore& recvData);
    void HandleCalendarEventStatus(WDataStore& recvData);
    void HandleCalendarEventModeratorStatus(WDataStore& recvData);
    void HandleCalendarComplain(WDataStore& recvData);
    void HandleCalendarGetNumPending(WDataStore& recvData);
    void HandleCalendarEventSignup(WDataStore& recvData);

    void SendCalendarRaidLockout(InstanceSave const* save, bool add);
    void SendCalendarRaidLockoutUpdated(InstanceSave const* save, bool isExtended);
    void HandleSetSavedInstanceExtend(WDataStore& recvData);

    void HandleSpellClick(WDataStore& recvData);
    void HandleMirrorImageDataRequest(WDataStore& recvData);
    void HandleAlterAppearance(WDataStore& recvData);
    void HandleRemoveGlyph(WDataStore& recvData);
    void HandleCharCustomize(WDataStore& recvData);
    void HandleCharCustomizeCallback(std::shared_ptr<CharacterCustomizeInfo> customizeInfo, PreparedQueryResult result);
    void HandleQueryInspectAchievements(WDataStore& recvData);
    void HandleEquipmentSetSave(WDataStore& recvData);
    void HandleEquipmentSetDelete(WDataStore& recvData);
    void HandleEquipmentSetUse(WDataStore& recvData);
    void HandleWorldStateUITimerUpdate(WDataStore& recvData);
    void HandleReadyForAccountDataTimes(WDataStore& recvData);
    void HandleQueryQuestsCompleted(WDataStore& recvData);
    void HandleQuestPOIQuery(WDataStore& recvData);
    void HandleEjectPassenger(WDataStore& data);
    void HandleEnterPlayerVehicle(WDataStore& data);
    void HandleUpdateProjectilePosition(WDataStore& recvPacket);

    Milliseconds _lastAuctionListItemsMSTime;
    Milliseconds _lastAuctionListOwnerItemsMSTime;

    void HandleTeleportTimeout(bool updateInSessions);
    bool HandleSocketClosed();
    void SetOfflineTime(uint32 time) { _offlineTime = time; }
    uint32 GetOfflineTime() const { return _offlineTime; }
    bool IsKicked() const { return _kicked; }
    void SetKicked(bool val) { _kicked = val; }
    bool IsSocketClosed() const;

    /*
     * CALLBACKS
     */

    QueryCallbackProcessor& GetQueryProcessor() { return _queryProcessor; }
    TransactionCallback& AddTransactionCallback(TransactionCallback&& callback);
    SQLQueryHolderCallback& AddQueryHolderCallback(SQLQueryHolderCallback&& callback);

    void InitializeSession();
    void InitializeSessionCallback(CharacterDatabaseQueryHolder const& realmHolder, uint32 clientCacheVersion);

    void BootMeHandler(WDataStore& msg);
    void GmResurrectHandler(WDataStore& msg);
    void SendGmResurrectFailure();
    void SendGmResurrectSuccess();
    void SendPlayerNotFoundFailure();

private:
    void ProcessQueryCallbacks();

    QueryCallbackProcessor _queryProcessor;
    AsyncCallbackProcessor<TransactionCallback> _transactionCallbacks;
    AsyncCallbackProcessor<SQLQueryHolderCallback> _queryHolderProcessor;

    friend class World;
protected:
    class DosProtection
    {
        friend class World;
    public:
        DosProtection(User* s);
        bool EvaluateOpcode(WDataStore& p, time_t time) const;
    protected:
        enum Policy
        {
            POLICY_LOG,
            POLICY_KICK,
            POLICY_BAN
        };

        uint32 GetMaxPacketCounterAllowed(uint16 opcode) const;

        User* Session;

    private:
        Policy _policy;
        typedef std::unordered_map<uint16, PacketCounter> PacketThrottlingMap;
        // mark this member as "mutable" so it can be modified even in const functions
        mutable PacketThrottlingMap _PacketThrottlingMap;

        DosProtection(DosProtection const& right) = delete;
        DosProtection& operator=(DosProtection const& right) = delete;
    } AntiDOS;

private:
    // private trade methods
    void moveItems(Item* myItems[], Item* hisItems[]);

    bool CanUseBank(WOWGUID bankerGUID = WOWGUID::Empty) const;

    bool recoveryItem(Item* pItem);

    // logging helper
    void LogUnexpectedOpcode(WDataStore* packet, char const* status, const char* reason);
    void LogUnprocessedTail(WDataStore* packet);

    // EnumData helpers
    bool IsLegitCharacterForAccount(WOWGUID guid)
    {
        return _legitCharacters.find(guid) != _legitCharacters.end();
    }

    // this stores the GUIDs of the characters who can login
    // characters who failed on Player::BuildEnumData shouldn't login
    GuidSet _legitCharacters;

    WOWGUID::LowType m_GUIDLow;                     // set logined or recently logout player (while m_playerRecentlyLogout set)
    Player* m_player;
    std::shared_ptr<WowConnection> m_sock;
    std::string m_Address;

    AccountTypes _security;
    bool _skipQueue;
    uint32 _accountId;
    uint32_t m_accountFlags;
    std::string m_accountName;  // TODO: replace by a C string implementation
    uint8 m_expansion;
    uint32 m_total_time;

    typedef std::list<AddonInfo> AddonsList;

    // Warden
    std::unique_ptr<Warden> _warden;                    // Remains nullptr if Warden system is not enabled by config

    time_t m_logoutRequestTime;
    bool m_inQueue;                                     // session wait in auth.queue
    bool m_playerLoading;                               // code processed in LoginPlayer
    bool m_loggingOut;
    bool m_playerRecentlyLogout;
    bool m_playerSave;
    LocaleConstant m_sessionDbcLocale;
    LocaleConstant m_sessionDbLocaleIndex;
    std::atomic<uint32> m_latency;
    AccountData m_accountData[NUM_ACCOUNT_DATA_TYPES];
    uint32 m_Tutorials[MAX_ACCOUNT_TUTORIAL_VALUES];
    bool   m_TutorialsChanged;
    AddonsList m_addonsList;
    uint32 recruiterId;
    bool isRecruiter;
    LockedQueue<WDataStore*> _recvQueue;
    uint32 m_currentVendorEntry;
    WOWGUID m_currentBankerGUID;
    uint32 _offlineTime;
    bool _kicked;
    // Packets cooldown
    time_t _calendarEventCreationCooldown;

    // Addon Message count for Metric
    std::atomic<uint32> _addonMessageReceiveCount;

    CircularBuffer<std::pair<int64, uint32>> _timeSyncClockDeltaQueue; // first member: clockDelta. Second member: latency of the packet exchange that was used to compute that clockDelta.
    int64 _timeSyncClockDelta;
    void ComputeNewClockDelta();

    std::map<uint32, uint32> _pendingTimeSyncRequests; // key: counter. value: server time when packet with that counter was sent.
    uint32 _timeSyncNextCounter;
    uint32 _timeSyncTimer;

    User(User const& right) = delete;
    User& operator=(User const& right) = delete;
};
#endif
/// @}
