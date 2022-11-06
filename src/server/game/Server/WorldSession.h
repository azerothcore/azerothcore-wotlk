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
#include "BanMgr.h"
#include "CircularBuffer.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "GossipDef.h"
#include "Packet.h"
#include "SharedDefines.h"
#include "World.h"
#include <map>
#include <utility>

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
class WorldPacket;
class WorldSocket;
class AsynchPetSummon;
struct AreaTableEntry;
struct AuctionEntry;
struct DeclinedName;
struct ItemTemplate;
struct MovementInfo;

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
        class LogoutCancel;
        class LogoutRequest;
        class ShowingCloak;
        class ShowingHelm;
        class PlayerLogout;
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
    explicit PacketFilter(WorldSession* pSession) : m_pSession(pSession) {}
    virtual ~PacketFilter() = default;

    virtual bool Process(WorldPacket* /*packet*/) { return true; }
    [[nodiscard]] virtual bool ProcessUnsafe() const { return true; }

protected:
    WorldSession* const m_pSession;
};
//process only thread-safe packets in Map::Update()
class MapSessionFilter : public PacketFilter
{
public:
    explicit MapSessionFilter(WorldSession* pSession) : PacketFilter(pSession) {}
    ~MapSessionFilter() override = default;

    bool Process(WorldPacket* packet) override;
    //in Map::Update() we do not process player logout!
    [[nodiscard]] bool ProcessUnsafe() const override { return false; }
};

//class used to filer only thread-unsafe packets from queue
//in order to update only be used in World::UpdateSessions()
class WorldSessionFilter : public PacketFilter
{
public:
    explicit WorldSessionFilter(WorldSession* pSession) : PacketFilter(pSession) {}
    ~WorldSessionFilter() override = default;

    bool Process(WorldPacket* packet) override;
};

// Proxy structure to contain data passed to callback function,
// only to prevent bloating the parameter list
class CharacterCreateInfo
{
    friend class WorldSession;
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
    friend class WorldSession;

protected:
    ObjectGuid Guid;
    std::string Name;
};

struct CharacterCustomizeInfo : public CharacterRenameInfo
{
    friend class Player;
    friend class WorldSession;

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
    friend class WorldSession;

protected:
    uint8 Race = 0;
    bool FactionChange = false;
};

struct PacketCounter
{
    time_t lastReceiveTime;
    uint32 amountCounter;
};

/// Player session in the World
class WorldSession
{
public:
    WorldSession(uint32 id, std::string&& name, std::shared_ptr<WorldSocket> sock, AccountTypes sec, uint8 expansion, time_t mute_time, LocaleConstant locale, uint32 recruiter, bool isARecruiter, bool skipQueue, uint32 TotalTime);
    ~WorldSession();

    bool PlayerLoading() const { return m_playerLoading; }
    bool PlayerLogout() const { return m_playerLogout; }
    bool PlayerLogoutWithSave() const { return m_playerLogout && m_playerSave; }

    void ReadAddonsInfo(ByteBuffer& data);
    void SendAddonsInfo();

    void ReadMovementInfo(WorldPacket& data, MovementInfo* mi);
    void WriteMovementInfo(WorldPacket* data, MovementInfo* mi);

    void SendPacket(WorldPacket const* packet);
    void SendNotification(const char* format, ...) ATTR_PRINTF(2, 3);
    void SendNotification(uint32 string_id, ...);
    void SendPetNameInvalid(uint32 error, std::string const& name, DeclinedName* declinedName);
    void SendPartyResult(PartyOperation operation, std::string const& member, PartyResult res, uint32 val = 0);
    void SendAreaTriggerMessage(const char* Text, ...) ATTR_PRINTF(2, 3);
    void SendSetPhaseShift(uint32 phaseShift);
    void SendQueryTimeResponse();

    void SendAuthResponse(uint8 code, bool shortForm, uint32 queuePos = 0);
    void SendClientCacheVersion(uint32 version);

    AccountTypes GetSecurity() const { return _security; }
    bool CanSkipQueue() const { return _skipQueue; }
    uint32 GetAccountId() const { return _accountId; }
    Player* GetPlayer() const { return _player; }
    std::string const& GetPlayerName() const;
    std::string GetPlayerInfo() const;

    uint32 GetCurrentVendor() const { return m_currentVendorEntry; }
    void SetCurrentVendor(uint32 vendorEntry) { m_currentVendorEntry = vendorEntry; }

    ObjectGuid::LowType GetGuidLow() const;
    void SetSecurity(AccountTypes security) { _security = security; }
    std::string const& GetRemoteAddress() { return m_Address; }
    void SetPlayer(Player* player);
    uint8 Expansion() const { return m_expansion; }

    void SetTotalTime(uint32 TotalTime) { m_total_time = TotalTime; }
    uint32 GetTotalTime() const { return m_total_time; }

    void InitWarden(SessionKey const&, std::string const& os);

    /// Session in auth.queue currently
    void SetInQueue(bool state) { m_inQueue = state; }

    /// Is the user engaged in a log out process?
    bool isLogingOut() const { return _logoutTime || m_playerLogout; }

    /// Engage the logout process for the user
    void SetLogoutStartTime(time_t requestTime)
    {
        _logoutTime = requestTime;
    }

    /// Is logout cooldown expired?
    bool ShouldLogOut(time_t currTime) const
    {
        return (_logoutTime > 0 && currTime >= _logoutTime + 20);
    }

    void LogoutPlayer(bool save);
    void KickPlayer(bool setKicked = true) { return this->KickPlayer("Unknown reason", setKicked); }
    void KickPlayer(std::string const& reason, bool setKicked = true);

    // Returns true if all contained hyperlinks are valid
    // May kick player on false depending on world config (handler should abort)
    bool ValidateHyperlinksAndMaybeKick(std::string_view str);
    // Returns true if the message contains no hyperlinks
    // May kick player on false depending on world config (handler should abort)
    bool DisallowHyperlinksAndMaybeKick(std::string_view str);

    void QueuePacket(WorldPacket* new_packet);
    bool Update(uint32 diff, PacketFilter& updater);

    /// Handle the authentication waiting queue (to be completed)
    void SendAuthWaitQueue(uint32 position);

    //void SendTestCreatureQueryOpcode(uint32 entry, ObjectGuid guid, uint32 testvalue);
    void SendNameQueryOpcode(ObjectGuid guid);

    void SendTrainerList(ObjectGuid guid);
    void SendTrainerList(ObjectGuid guid, std::string const& strTitle);
    void SendListInventory(ObjectGuid guid, uint32 vendorEntry = 0);
    void SendShowBank(ObjectGuid guid);
    bool CanOpenMailBox(ObjectGuid guid);
    void SendShowMailBox(ObjectGuid guid);
    void SendTabardVendorActivate(ObjectGuid guid);
    void SendSpiritResurrect();
    void SendBindPoint(Creature* npc);

    void SendAttackStop(Unit const* enemy);

    void SendBattleGroundList(ObjectGuid guid, BattlegroundTypeId bgTypeId = BATTLEGROUND_RB);

    void SendTradeStatus(TradeStatus status);
    void SendUpdateTrade(bool trader_data = true);
    void SendCancelTrade();

    void SendPetitionQueryOpcode(ObjectGuid petitionguid);

    // Spell
    void HandleClientCastFlags(WorldPacket& recvPacket, uint8 castFlags, SpellCastTargets& targets);

    // Pet
    void SendPetNameQuery(ObjectGuid guid, uint32 petnumber);
    void SendStablePet(ObjectGuid guid);
    void SendStablePetCallback(ObjectGuid guid, PreparedQueryResult result);
    void SendStableResult(uint8 guid);
    bool CheckStableMaster(ObjectGuid guid);

    // Account Data
    AccountData* GetAccountData(AccountDataType type) { return &m_accountData[type]; }
    void SetAccountData(AccountDataType type, time_t tm, std::string const& data);
    void SendAccountDataTimes(uint32 mask);
    void LoadGlobalAccountData();
    void LoadAccountData(PreparedQueryResult result, uint32 mask);

    void LoadTutorialsData();
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
    void SendAuctionHello(ObjectGuid guid, Creature* unit);
    void SendAuctionCommandResult(uint32 auctionId, uint32 Action, uint32 ErrorCode, uint32 bidError = 0);
    void SendAuctionBidderNotification(uint32 location, uint32 auctionId, ObjectGuid bidder, uint32 bidSum, uint32 diff, uint32 item_template);
    void SendAuctionOwnerNotification(AuctionEntry* auction);

    //Item Enchantment
    void SendEnchantmentLog(ObjectGuid target, ObjectGuid caster, uint32 itemId, uint32 enchantId);
    void SendItemEnchantTimeUpdate(ObjectGuid Playerguid, ObjectGuid Itemguid, uint32 slot, uint32 Duration);

    //Taxi
    void SendTaxiStatus(ObjectGuid guid);
    void SendTaxiMenu(Creature* unit);
    void SendDoFlight(uint32 mountDisplayId, uint32 path, uint32 pathNode = 0);
    bool SendLearnNewTaxiNode(Creature* unit);
    void SendDiscoverNewTaxiNode(uint32 nodeid);

    // Guild/Arena Team
    void SendArenaTeamCommandResult(uint32 team_action, std::string const& team, std::string const& player, uint32 error_id = 0);
    void SendNotInArenaTeamPacket(uint8 type);
    void SendPetitionShowList(ObjectGuid guid);

    void BuildPartyMemberStatsChangedPacket(Player* player, WorldPacket* data);

    void DoLootRelease(ObjectGuid lguid);

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
    void Handle_NULL(WorldPacket& null);                // not used
    void Handle_EarlyProccess(WorldPacket& recvPacket); // just mark packets processed in WorldSocket::OnRead
    void Handle_ServerSide(WorldPacket& recvPacket);    // sever side only, can't be accepted from client
    void Handle_Deprecated(WorldPacket& recvPacket);    // never used anymore by client

    void HandleCharEnumOpcode(WorldPacket& recvPacket);
    void HandleCharDeleteOpcode(WorldPacket& recvPacket);
    void HandleCharCreateOpcode(WorldPacket& recvPacket);
    void HandlePlayerLoginOpcode(WorldPacket& recvPacket);
    void HandleCharEnum(PreparedQueryResult result);
    void HandlePlayerLoginFromDB(LoginQueryHolder const& holder);
    void HandlePlayerLoginToCharInWorld(Player* pCurrChar);
    void HandlePlayerLoginToCharOutOfWorld(Player* pCurrChar);
    void HandleCharFactionOrRaceChange(WorldPacket& recvData);
    void HandleCharFactionOrRaceChangeCallback(std::shared_ptr<CharacterFactionChangeInfo> factionChangeInfo, PreparedQueryResult result);

    void SendCharCreate(ResponseCodes result);
    void SendCharDelete(ResponseCodes result);
    void SendCharRename(ResponseCodes result, CharacterRenameInfo const* renameInfo);
    void SendCharCustomize(ResponseCodes result, CharacterCustomizeInfo const* customizeInfo);
    void SendCharFactionChange(ResponseCodes result, CharacterFactionChangeInfo const* factionChangeInfo);
    void SendSetPlayerDeclinedNamesResult(DeclinedNameResult result, ObjectGuid guid);

    // played time
    void HandlePlayedTime(WorldPackets::Character::PlayedTimeClient& packet);

    // new
    void HandleMoveUnRootAck(WorldPacket& recvPacket);
    void HandleMoveRootAck(WorldPacket& recvPacket);

    // new inspect
    void HandleInspectOpcode(WorldPacket& recvPacket);

    // new party stats
    void HandleInspectHonorStatsOpcode(WorldPacket& recvPacket);

    void HandleMoveWaterWalkAck(WorldPacket& recvPacket);
    void HandleFeatherFallAck(WorldPacket& recvData);

    void HandleMoveHoverAck(WorldPacket& recvData);

    void HandleMountSpecialAnimOpcode(WorldPacket& recvdata);

    // character view
    void HandleShowingHelmOpcode(WorldPackets::Character::ShowingHelm& packet);
    void HandleShowingCloakOpcode(WorldPackets::Character::ShowingCloak& packet);

    // repair
    void HandleRepairItemOpcode(WorldPacket& recvPacket);

    // Knockback
    void HandleMoveKnockBackAck(WorldPacket& recvPacket);

    void HandleMoveTeleportAck(WorldPacket& recvPacket);
    void HandleForceSpeedChangeAck(WorldPacket& recvData);

    void HandleRepopRequestOpcode(WorldPacket& recvPacket);
    void HandleAutostoreLootItemOpcode(WorldPacket& recvPacket);
    void HandleLootMoneyOpcode(WorldPacket& recvPacket);
    void HandleLootOpcode(WorldPacket& recvPacket);
    void HandleLootReleaseOpcode(WorldPacket& recvPacket);
    void HandleLootMasterGiveOpcode(WorldPacket& recvPacket);
    void HandleWhoOpcode(WorldPacket& recvPacket);
    void HandleLogoutRequestOpcode(WorldPackets::Character::LogoutRequest& logoutRequest);
    void HandlePlayerLogoutOpcode(WorldPackets::Character::PlayerLogout& playerLogout);
    void HandleLogoutCancelOpcode(WorldPackets::Character::LogoutCancel& logoutCancel);

    // GM Ticket opcodes
    void HandleGMTicketCreateOpcode(WorldPacket& recvPacket);
    void HandleGMTicketUpdateOpcode(WorldPacket& recvPacket);
    void HandleGMTicketDeleteOpcode(WorldPacket& recvPacket);
    void HandleGMTicketGetTicketOpcode(WorldPacket& recvPacket);
    void HandleGMTicketSystemStatusOpcode(WorldPacket& recvPacket);
    void HandleGMSurveySubmit(WorldPacket& recvPacket);
    void HandleReportLag(WorldPacket& recvPacket);
    void HandleGMResponseResolve(WorldPacket& recvPacket);

    void HandleTogglePvP(WorldPacket& recvPacket);

    void HandleZoneUpdateOpcode(WorldPacket& recvPacket);
    void HandleSetSelectionOpcode(WorldPacket& recvPacket);
    void HandleStandStateChangeOpcode(WorldPacket& recvPacket);
    void HandleEmoteOpcode(WorldPackets::Chat::EmoteClient& packet);
    void HandleContactListOpcode(WorldPacket& recvPacket);
    void HandleAddFriendOpcode(WorldPacket& recvPacket);
    void HandleDelFriendOpcode(WorldPacket& recvPacket);
    void HandleAddIgnoreOpcode(WorldPacket& recvPacket);
    void HandleDelIgnoreOpcode(WorldPacket& recvPacket);
    void HandleSetContactNotesOpcode(WorldPacket& recvPacket);
    void HandleBugOpcode(WorldPacket& recvPacket);
    void HandleSetAmmoOpcode(WorldPacket& recvPacket);
    void HandleItemNameQueryOpcode(WorldPacket& recvPacket);

    void HandleAreaTriggerOpcode(WorldPacket& recvPacket);

    void HandleSetFactionAtWar(WorldPacket& recvData);
    void HandleSetFactionCheat(WorldPacket& recvData);
    void HandleSetWatchedFactionOpcode(WorldPacket& recvData);
    void HandleSetFactionInactiveOpcode(WorldPacket& recvData);

    void HandleUpdateAccountData(WorldPacket& recvPacket);
    void HandleRequestAccountData(WorldPacket& recvPacket);
    void HandleSetActionButtonOpcode(WorldPacket& recvPacket);

    void HandleGameObjectUseOpcode(WorldPacket& recPacket);
    void HandleGameobjectReportUse(WorldPacket& recvPacket);

    void HandleNameQueryOpcode(WorldPacket& recvPacket);

    void HandleQueryTimeOpcode(WorldPacket& recvPacket);

    void HandleCreatureQueryOpcode(WorldPacket& recvPacket);

    void HandleGameObjectQueryOpcode(WorldPacket& recvPacket);

    void HandleMoveWorldportAckOpcode(WorldPacket& recvPacket);
    void HandleMoveWorldportAck(); // for server-side calls

    void HandleMovementOpcodes(WorldPacket& recvPacket);
    void HandleSetActiveMoverOpcode(WorldPacket& recvData);
    void HandleMoveNotActiveMover(WorldPacket& recvData);
    void HandleDismissControlledVehicle(WorldPacket& recvData);
    void HandleRequestVehicleExit(WorldPacket& recvData);
    void HandleChangeSeatsOnControlledVehicle(WorldPacket& recvData);
    void HandleMoveTimeSkippedOpcode(WorldPacket& recvData);

    void HandleRequestRaidInfoOpcode(WorldPacket& recvData);

    void HandleBattlefieldStatusOpcode(WorldPacket& recvData);

    void HandleGroupInviteOpcode(WorldPacket& recvPacket);
    void HandleGroupAcceptOpcode(WorldPacket& recvPacket);
    void HandleGroupDeclineOpcode(WorldPacket& recvPacket);
    void HandleGroupUninviteOpcode(WorldPacket& recvPacket);
    void HandleGroupUninviteGuidOpcode(WorldPacket& recvPacket);
    void HandleGroupSetLeaderOpcode(WorldPacket& recvPacket);
    void HandleGroupDisbandOpcode(WorldPacket& recvPacket);
    void HandleOptOutOfLootOpcode(WorldPacket& recvData);
    void HandleLootMethodOpcode(WorldPacket& recvPacket);
    void HandleLootRoll(WorldPacket& recvData);
    void HandleRequestPartyMemberStatsOpcode(WorldPacket& recvData);
    void HandleGroupSwapSubGroupOpcode(WorldPacket& recvData);
    void HandleRaidTargetUpdateOpcode(WorldPacket& recvData);
    void HandleRaidReadyCheckOpcode(WorldPacket& recvData);
    void HandleRaidReadyCheckFinishedOpcode(WorldPacket& recvData);
    void HandleGroupRaidConvertOpcode(WorldPacket& recvData);
    void HandleGroupChangeSubGroupOpcode(WorldPacket& recvData);
    void HandleGroupAssistantLeaderOpcode(WorldPacket& recvData);
    void HandlePartyAssignmentOpcode(WorldPacket& recvData);

    void HandlePetitionBuyOpcode(WorldPacket& recvData);
    void HandlePetitionShowSignOpcode(WorldPacket& recvData);
    void HandlePetitionQueryOpcode(WorldPacket& recvData);
    void HandlePetitionRenameOpcode(WorldPacket& recvData);
    void HandlePetitionSignOpcode(WorldPacket& recvData);
    void HandlePetitionDeclineOpcode(WorldPacket& recvData);
    void HandleOfferPetitionOpcode(WorldPacket& recvData);
    void HandleTurnInPetitionOpcode(WorldPacket& recvData);

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

    void HandleTaxiNodeStatusQueryOpcode(WorldPacket& recvPacket);
    void HandleTaxiQueryAvailableNodes(WorldPacket& recvPacket);
    void HandleActivateTaxiOpcode(WorldPacket& recvPacket);
    void HandleActivateTaxiExpressOpcode(WorldPacket& recvPacket);
    void HandleMoveSplineDoneOpcode(WorldPacket& recvPacket);
    void SendActivateTaxiReply(ActivateTaxiReply reply);

    void HandleTabardVendorActivateOpcode(WorldPacket& recvPacket);
    void HandleTrainerListOpcode(WorldPacket& recvPacket);
    void HandleTrainerBuySpellOpcode(WorldPacket& recvPacket);
    void HandlePetitionShowListOpcode(WorldPacket& recvPacket);
    void HandleGossipHelloOpcode(WorldPacket& recvPacket);
    void HandleGossipSelectOptionOpcode(WorldPacket& recvPacket);
    void HandleSpiritHealerActivateOpcode(WorldPacket& recvPacket);
    void HandleNpcTextQueryOpcode(WorldPacket& recvPacket);
    void HandleBinderActivateOpcode(WorldPacket& recvPacket);
    void HandleListStabledPetsOpcode(WorldPacket& recvPacket);
    void HandleStablePet(WorldPacket& recvPacket);
    void HandleUnstablePet(WorldPacket& recvPacket);
    void HandleBuyStableSlot(WorldPacket& recvPacket);
    void HandleStableRevivePet(WorldPacket& recvPacket);
    void HandleStableSwapPet(WorldPacket& recvPacket);
    void HandleOpenWrappedItemCallback(uint8 bagIndex, uint8 slot, ObjectGuid::LowType itemLowGUID, PreparedQueryResult result);
    void HandleLoadActionsSwitchSpec(PreparedQueryResult result);
    void HandleCharacterAuraFrozen(PreparedQueryResult result);

    void HandleDuelAcceptedOpcode(WorldPacket& recvPacket);
    void HandleDuelCancelledOpcode(WorldPacket& recvPacket);

    void HandleAcceptTradeOpcode(WorldPacket& recvPacket);
    void HandleBeginTradeOpcode(WorldPacket& recvPacket);
    void HandleBusyTradeOpcode(WorldPacket& recvPacket);
    void HandleCancelTradeOpcode(WorldPacket& recvPacket);
    void HandleClearTradeItemOpcode(WorldPacket& recvPacket);
    void HandleIgnoreTradeOpcode(WorldPacket& recvPacket);
    void HandleInitiateTradeOpcode(WorldPacket& recvPacket);
    void HandleSetTradeGoldOpcode(WorldPacket& recvPacket);
    void HandleSetTradeItemOpcode(WorldPacket& recvPacket);
    void HandleUnacceptTradeOpcode(WorldPacket& recvPacket);

    void HandleAuctionHelloOpcode(WorldPacket& recvPacket);
    void HandleAuctionListItems(WorldPacket& recvData);
    void HandleAuctionListBidderItems(WorldPacket& recvData);
    void HandleAuctionSellItem(WorldPacket& recvData);
    void HandleAuctionRemoveItem(WorldPacket& recvData);
    void HandleAuctionListOwnerItems(WorldPacket& recvData);
    void HandleAuctionListOwnerItemsEvent(ObjectGuid creatureGuid);
    void HandleAuctionPlaceBid(WorldPacket& recvData);
    void HandleAuctionListPendingSales(WorldPacket& recvData);

    // Bank
    void HandleBankerActivateOpcode(WorldPacket& recvData);
    void HandleAutoBankItemOpcode(WorldPackets::Bank::AutoBankItem& packet);
    void HandleAutoStoreBankItemOpcode(WorldPackets::Bank::AutoStoreBankItem& packet);
    void HandleBuyBankSlotOpcode(WorldPackets::Bank::BuyBankSlot& buyBankSlot);

    void HandleGetMailList(WorldPacket& recvData);
    void HandleSendMail(WorldPacket& recvData);
    void HandleMailTakeMoney(WorldPacket& recvData);
    void HandleMailTakeItem(WorldPacket& recvData);
    void HandleMailMarkAsRead(WorldPacket& recvData);
    void HandleMailReturnToSender(WorldPacket& recvData);
    void HandleMailDelete(WorldPacket& recvData);
    void HandleItemTextQuery(WorldPacket& recvData);
    void HandleMailCreateTextItem(WorldPacket& recvData);
    void HandleQueryNextMailTime(WorldPacket& recvData);
    void HandleCancelChanneling(WorldPacket& recvData);

    void HandleSplitItemOpcode(WorldPacket& recvPacket);
    void HandleSwapInvItemOpcode(WorldPacket& recvPacket);
    void HandleDestroyItemOpcode(WorldPacket& recvPacket);
    void HandleAutoEquipItemOpcode(WorldPacket& recvPacket);
    void HandleItemQuerySingleOpcode(WorldPacket& recvPacket);
    void HandleSellItemOpcode(WorldPacket& recvPacket);
    void HandleBuyItemInSlotOpcode(WorldPacket& recvPacket);
    void HandleBuyItemOpcode(WorldPacket& recvPacket);
    void HandleListInventoryOpcode(WorldPacket& recvPacket);
    void HandleAutoStoreBagItemOpcode(WorldPacket& recvPacket);
    void HandleReadItem(WorldPacket& recvPacket);
    void HandleAutoEquipItemSlotOpcode(WorldPacket& recvPacket);
    void HandleSwapItem(WorldPacket& recvPacket);
    void HandleBuybackItem(WorldPacket& recvPacket);
    void HandleWrapItemOpcode(WorldPacket& recvPacket);

    void HandleAttackSwingOpcode(WorldPacket& recvPacket);
    void HandleAttackStopOpcode(WorldPacket& recvPacket);
    void HandleSetSheathedOpcode(WorldPackets::Combat::SetSheathed& packet);

    void HandleUseItemOpcode(WorldPacket& recvPacket);
    void HandleOpenItemOpcode(WorldPacket& recvPacket);
    void HandleCastSpellOpcode(WorldPacket& recvPacket);
    void HandleCancelCastOpcode(WorldPacket& recvPacket);
    void HandleCancelAuraOpcode(WorldPacket& recvPacket);
    void HandleCancelGrowthAuraOpcode(WorldPacket& recvPacket);
    void HandleCancelAutoRepeatSpellOpcode(WorldPacket& recvPacket);

    void HandleLearnTalentOpcode(WorldPacket& recvPacket);
    void HandleLearnPreviewTalents(WorldPacket& recvPacket);
    void HandleTalentWipeConfirmOpcode(WorldPacket& recvPacket);
    void HandleUnlearnSkillOpcode(WorldPacket& recvPacket);

    void HandleQuestgiverStatusQueryOpcode(WorldPacket& recvPacket);
    void HandleQuestgiverStatusMultipleQuery(WorldPacket& recvPacket);
    void HandleQuestgiverHelloOpcode(WorldPacket& recvPacket);
    void HandleQuestgiverAcceptQuestOpcode(WorldPacket& recvPacket);
    void HandleQuestgiverQueryQuestOpcode(WorldPacket& recvPacket);
    void HandleQuestgiverChooseRewardOpcode(WorldPacket& recvPacket);
    void HandleQuestgiverRequestRewardOpcode(WorldPacket& recvPacket);
    void HandleQuestQueryOpcode(WorldPacket& recvPacket);
    void HandleQuestgiverCancel(WorldPacket& recvData);
    void HandleQuestLogSwapQuest(WorldPacket& recvData);
    void HandleQuestLogRemoveQuest(WorldPacket& recvData);
    void HandleQuestConfirmAccept(WorldPacket& recvData);
    void HandleQuestgiverCompleteQuest(WorldPacket& recvData);
    void HandleQuestgiverQuestAutoLaunch(WorldPacket& recvPacket);
    void HandlePushQuestToParty(WorldPacket& recvPacket);
    void HandleQuestPushResult(WorldPacket& recvPacket);

    void HandleMessagechatOpcode(WorldPacket& recvPacket);
    void SendPlayerNotFoundNotice(std::string const& name);
    void SendPlayerAmbiguousNotice(std::string const& name);
    void SendWrongFactionNotice();
    void SendChatRestrictedNotice(ChatRestrictionType restriction);
    void HandleTextEmoteOpcode(WorldPacket& recvPacket);
    void HandleChatIgnoredOpcode(WorldPacket& recvPacket);

    void HandleReclaimCorpseOpcode(WorldPacket& recvPacket);
    void HandleCorpseQueryOpcode(WorldPacket& recvPacket);
    void HandleCorpseMapPositionQuery(WorldPacket& recvPacket);
    void HandleResurrectResponseOpcode(WorldPacket& recvPacket);
    void HandleSummonResponseOpcode(WorldPacket& recvData);

    void HandleJoinChannel(WorldPacket& recvPacket);
    void HandleLeaveChannel(WorldPacket& recvPacket);
    void HandleChannelList(WorldPacket& recvPacket);
    void HandleChannelPassword(WorldPacket& recvPacket);
    void HandleChannelSetOwner(WorldPacket& recvPacket);
    void HandleChannelOwner(WorldPacket& recvPacket);
    void HandleChannelModerator(WorldPacket& recvPacket);
    void HandleChannelUnmoderator(WorldPacket& recvPacket);
    void HandleChannelMute(WorldPacket& recvPacket);
    void HandleChannelUnmute(WorldPacket& recvPacket);
    void HandleChannelInvite(WorldPacket& recvPacket);
    void HandleChannelKick(WorldPacket& recvPacket);
    void HandleChannelBan(WorldPacket& recvPacket);
    void HandleChannelUnban(WorldPacket& recvPacket);
    void HandleChannelAnnouncements(WorldPacket& recvPacket);
    void HandleChannelModerateOpcode(WorldPacket& recvPacket);
    void HandleChannelDeclineInvite(WorldPacket& recvPacket);
    void HandleChannelDisplayListQuery(WorldPacket& recvPacket);
    void HandleGetChannelMemberCount(WorldPacket& recvPacket);
    void HandleSetChannelWatch(WorldPacket& recvPacket);
    void HandleClearChannelWatch(WorldPacket& recvPacket);

    void HandleCompleteCinematic(WorldPacket& recvPacket);
    void HandleNextCinematicCamera(WorldPacket& recvPacket);

    void HandlePageTextQueryOpcode(WorldPacket& recvPacket);

    void HandleTutorialFlag (WorldPacket& recvData);
    void HandleTutorialClear(WorldPacket& recvData);
    void HandleTutorialReset(WorldPacket& recvData);

    //Pet
    void HandlePetAction(WorldPacket& recvData);
    void HandlePetStopAttack(WorldPackets::Pet::PetStopAttack& packet);
    void HandlePetActionHelper(Unit* pet, ObjectGuid guid1, uint32 spellid, uint16 flag, ObjectGuid guid2);
    void HandlePetNameQuery(WorldPacket& recvData);
    void HandlePetSetAction(WorldPacket& recvData);
    void HandlePetAbandon(WorldPackets::Pet::PetAbandon& packet);
    void HandlePetRename(WorldPacket& recvData);
    void HandlePetCancelAuraOpcode(WorldPacket& recvPacket);
    void HandlePetSpellAutocastOpcode(WorldPackets::Pet::PetSpellAutocast& packet);
    void HandlePetCastSpellOpcode(WorldPacket& recvPacket);
    void HandlePetLearnTalent(WorldPacket& recvPacket);
    void HandleLearnPreviewTalentsPet(WorldPacket& recvPacket);

    void HandleSetActionBarToggles(WorldPacket& recvData);

    void HandleCharRenameOpcode(WorldPacket& recvData);
    void HandleCharRenameCallBack(std::shared_ptr<CharacterRenameInfo> renameInfo, PreparedQueryResult result);
    void HandleSetPlayerDeclinedNames(WorldPacket& recvData);

    void HandleTotemDestroyed(WorldPackets::Totem::TotemDestroyed& totemDestroyed);
    void HandleDismissCritter(WorldPackets::Pet::DismissCritter& dismissCritter);

    //Battleground
    void HandleBattlemasterHelloOpcode(WorldPacket& recvData);
    void HandleBattlemasterJoinOpcode(WorldPacket& recvData);
    void HandleBattlegroundPlayerPositionsOpcode(WorldPacket& recvData);
    void HandlePVPLogDataOpcode(WorldPacket& recvData);
    void HandleBattleFieldPortOpcode(WorldPacket& recvData);
    void HandleBattlefieldListOpcode(WorldPacket& recvData);
    void HandleBattlefieldLeaveOpcode(WorldPacket& recvData);
    void HandleBattlemasterJoinArena(WorldPacket& recvData);
    void HandleReportPvPAFK(WorldPacket& recvData);

    void HandleWardenDataOpcode(WorldPacket& recvData);
    void HandleWorldTeleportOpcode(WorldPacket& recvData);
    void HandleMinimapPingOpcode(WorldPacket& recvData);
    void HandleRandomRollOpcode(WorldPackets::Misc::RandomRollClient& packet);
    void HandleFarSightOpcode(WorldPacket& recvData);
    void HandleSetDungeonDifficultyOpcode(WorldPacket& recvData);
    void HandleSetRaidDifficultyOpcode(WorldPacket& recvData);
    void HandleMoveSetCanFlyAckOpcode(WorldPacket& recvData);
    void HandleSetTitleOpcode(WorldPacket& recvData);
    void HandleRealmSplitOpcode(WorldPacket& recvData);
    void HandleTimeSyncResp(WorldPacket& recvData);
    void HandleWhoisOpcode(WorldPacket& recvData);
    void HandleResetInstancesOpcode(WorldPacket& recvData);
    void HandleHearthAndResurrect(WorldPacket& recvData);
    void HandleInstanceLockResponse(WorldPacket& recvPacket);
    void HandleUpdateMissileTrajectory(WorldPacket& recvPacket);

    // Battlefield
    void SendBfInvitePlayerToWar(uint32 battleId, uint32 zoneId, uint32 time);
    void SendBfInvitePlayerToQueue(uint32 battleId);
    void SendBfQueueInviteResponse(uint32 battleId, uint32 zoneId, bool canQueue = true, bool full = false);
    void SendBfEntered(uint32 battleId);
    void SendBfLeaveMessage(uint32 battleId, BFLeaveReason reason = BF_LEAVE_REASON_EXITED);
    void HandleBfQueueInviteResponse(WorldPacket& recvData);
    void HandleBfEntryInviteResponse(WorldPacket& recvData);
    void HandleBfExitRequest(WorldPacket& recvData);

    // Looking for Dungeon/Raid
    void HandleLfgSetCommentOpcode(WorldPacket& recvData);
    void HandleLfgPlayerLockInfoRequestOpcode(WorldPacket& recvData);
    void HandleLfgPartyLockInfoRequestOpcode(WorldPacket& recvData);
    void HandleLfgJoinOpcode(WorldPackets::LFG::LFGJoin& lfgJoin);
    void HandleLfgLeaveOpcode(WorldPackets::LFG::LFGLeave& lfgleave);
    void HandleLfgSetRolesOpcode(WorldPacket& recvData);
    void HandleLfgProposalResultOpcode(WorldPacket& recvData);
    void HandleLfgSetBootVoteOpcode(WorldPacket& recvData);
    void HandleLfgTeleportOpcode(WorldPacket& recvData);
    void HandleLfrSearchJoinOpcode(WorldPacket& recvData);
    void HandleLfrSearchLeaveOpcode(WorldPacket& recvData);
    void HandleLfgGetStatus(WorldPacket& recvData);

    void SendLfgUpdatePlayer(lfg::LfgUpdateData const& updateData);
    void SendLfgUpdateParty(lfg::LfgUpdateData const& updateData);
    void SendLfgRoleChosen(ObjectGuid guid, uint8 roles);
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
    void HandleInspectArenaTeamsOpcode(WorldPacket& recvData);
    void HandleArenaTeamQueryOpcode(WorldPacket& recvData);
    void HandleArenaTeamRosterOpcode(WorldPacket& recvData);
    void HandleArenaTeamInviteOpcode(WorldPacket& recvData);
    void HandleArenaTeamAcceptOpcode(WorldPacket& recvData);
    void HandleArenaTeamDeclineOpcode(WorldPacket& recvData);
    void HandleArenaTeamLeaveOpcode(WorldPacket& recvData);
    void HandleArenaTeamRemoveOpcode(WorldPacket& recvData);
    void HandleArenaTeamDisbandOpcode(WorldPacket& recvData);
    void HandleArenaTeamLeaderOpcode(WorldPacket& recvData);

    void HandleAreaSpiritHealerQueryOpcode(WorldPacket& recvData);
    void HandleAreaSpiritHealerQueueOpcode(WorldPacket& recvData);
    void HandleCancelMountAuraOpcode(WorldPacket& recvData);
    void HandleSelfResOpcode(WorldPacket& recvData);
    void HandleComplainOpcode(WorldPacket& recvData);
    void HandleRequestPetInfo(WorldPackets::Pet::RequestPetInfo& packet);

    // Socket gem
    void HandleSocketOpcode(WorldPacket& recvData);

    void HandleCancelTempEnchantmentOpcode(WorldPacket& recvData);

    void HandleItemRefundInfoRequest(WorldPacket& recvData);
    void HandleItemRefund(WorldPacket& recvData);

    void HandleChannelVoiceOnOpcode(WorldPacket& recvData);
    void HandleVoiceSessionEnableOpcode(WorldPacket& recvData);
    void HandleSetActiveVoiceChannel(WorldPacket& recvData);
    void HandleSetTaxiBenchmarkOpcode(WorldPacket& recvData);

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
    void HandleGrantLevel(WorldPacket& recvData);
    void HandleAcceptGrantLevel(WorldPacket& recvData);

    // Calendar
    void HandleCalendarGetCalendar(WorldPacket& recvData);
    void HandleCalendarGetEvent(WorldPacket& recvData);
    void HandleCalendarGuildFilter(WorldPacket& recvData);
    void HandleCalendarArenaTeam(WorldPacket& recvData);
    void HandleCalendarAddEvent(WorldPacket& recvData);
    void HandleCalendarUpdateEvent(WorldPacket& recvData);
    void HandleCalendarRemoveEvent(WorldPacket& recvData);
    void HandleCalendarCopyEvent(WorldPacket& recvData);
    void HandleCalendarEventInvite(WorldPacket& recvData);
    void HandleCalendarEventRsvp(WorldPacket& recvData);
    void HandleCalendarEventRemoveInvite(WorldPacket& recvData);
    void HandleCalendarEventStatus(WorldPacket& recvData);
    void HandleCalendarEventModeratorStatus(WorldPacket& recvData);
    void HandleCalendarComplain(WorldPacket& recvData);
    void HandleCalendarGetNumPending(WorldPacket& recvData);
    void HandleCalendarEventSignup(WorldPacket& recvData);

    void SendCalendarRaidLockout(InstanceSave const* save, bool add);
    void SendCalendarRaidLockoutUpdated(InstanceSave const* save, bool isExtended);
    void HandleSetSavedInstanceExtend(WorldPacket& recvData);

    void HandleSpellClick(WorldPacket& recvData);
    void HandleMirrorImageDataRequest(WorldPacket& recvData);
    void HandleAlterAppearance(WorldPacket& recvData);
    void HandleRemoveGlyph(WorldPacket& recvData);
    void HandleCharCustomize(WorldPacket& recvData);
    void HandleCharCustomizeCallback(std::shared_ptr<CharacterCustomizeInfo> customizeInfo, PreparedQueryResult result);
    void HandleQueryInspectAchievements(WorldPacket& recvData);
    void HandleEquipmentSetSave(WorldPacket& recvData);
    void HandleEquipmentSetDelete(WorldPacket& recvData);
    void HandleEquipmentSetUse(WorldPacket& recvData);
    void HandleWorldStateUITimerUpdate(WorldPacket& recvData);
    void HandleReadyForAccountDataTimes(WorldPacket& recvData);
    void HandleQueryQuestsCompleted(WorldPacket& recvData);
    void HandleQuestPOIQuery(WorldPacket& recvData);
    void HandleEjectPassenger(WorldPacket& data);
    void HandleEnterPlayerVehicle(WorldPacket& data);
    void HandleUpdateProjectilePosition(WorldPacket& recvPacket);

    uint32 _lastAuctionListItemsMSTime;
    uint32 _lastAuctionListOwnerItemsMSTime;

    void HandleTeleportTimeout(bool updateInSessions);
    bool HandleSocketClosed();
    void SetOfflineTime(uint32 time) { _offlineTime = time; }
    uint32 GetOfflineTime() const { return _offlineTime; }
    bool IsKicked() const { return _kicked; }
    void SetKicked(bool val) { _kicked = val; }
    void SetShouldSetOfflineInDB(bool val) { _shouldSetOfflineInDB = val; }
    bool GetShouldSetOfflineInDB() const { return _shouldSetOfflineInDB; }
    bool IsSocketClosed() const;

    /*
     * CALLBACKS
     */

    QueryCallbackProcessor& GetQueryProcessor() { return _queryProcessor; }
    TransactionCallback& AddTransactionCallback(TransactionCallback&& callback);
    SQLQueryHolderCallback& AddQueryHolderCallback(SQLQueryHolderCallback&& callback);

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
        DosProtection(WorldSession* s);
        bool EvaluateOpcode(WorldPacket& p, time_t time) const;
    protected:
        enum Policy
        {
            POLICY_LOG,
            POLICY_KICK,
            POLICY_BAN
        };

        uint32 GetMaxPacketCounterAllowed(uint16 opcode) const;

        WorldSession* Session;

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

    bool CanUseBank(ObjectGuid bankerGUID = ObjectGuid::Empty) const;

    bool recoveryItem(Item* pItem);

    // logging helper
    void LogUnexpectedOpcode(WorldPacket* packet, char const* status, const char* reason);
    void LogUnprocessedTail(WorldPacket* packet);

    // EnumData helpers
    bool IsLegitCharacterForAccount(ObjectGuid guid)
    {
        return _legitCharacters.find(guid) != _legitCharacters.end();
    }

    // this stores the GUIDs of the characters who can login
    // characters who failed on Player::BuildEnumData shouldn't login
    GuidSet _legitCharacters;

    ObjectGuid::LowType m_GUIDLow;
    Player* _player;
    std::shared_ptr<WorldSocket> m_Socket;
    std::string m_Address;

    AccountTypes _security;
    bool _skipQueue;
    uint32 _accountId;
    std::string _accountName;
    uint8 m_expansion;
    uint32 m_total_time;

    typedef std::list<AddonInfo> AddonsList;

    // Warden
    std::unique_ptr<Warden> _warden;                    // Remains nullptr if Warden system is not enabled by config

    time_t _logoutTime;
    bool m_inQueue;                                     // session wait in auth.queue
    bool m_playerLoading;                               // code processed in LoginPlayer
    bool m_playerLogout;                                // code processed in LogoutPlayer
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
    LockedQueue<WorldPacket*> _recvQueue;
    uint32 m_currentVendorEntry;
    ObjectGuid m_currentBankerGUID;
    uint32 _offlineTime;
    bool _kicked;
    bool _shouldSetOfflineInDB;
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

    WorldSession(WorldSession const& right) = delete;
    WorldSession& operator=(WorldSession const& right) = delete;
};
#endif
/// @}
