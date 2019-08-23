/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Channel.h"
#include "ChannelAppenders.h"
#include "Chat.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "ObjectMgr.h"
#include "Language.h"
#include "SocialMgr.h"
#include "World.h"
#include "DatabaseEnv.h"
#include "AccountMgr.h"
#include "Player.h"

Channel::Channel(uint32 channelId, TeamId teamId, AreaTableEntry const* zoneEntry /*= nullptr*/) :
    _announceEnabled(false),                                        // no join/leave announces
    _ownershipEnabled(false),                                       // no ownership handout
    _persistentChannel(false),
    _isOwnerInvisible(false),
    _channelFlags(CHANNEL_FLAG_GENERAL),                            // for all built-in channels
    _channelId(channelId),
    _channelTeam(teamId),
    _ownerGuid(),
    _channelName(),
    _channelPassword(),
    _zoneEntry(zoneEntry)
{
    ChatChannelsEntry const* channelEntry = sChatChannelsStore.AssertEntry(channelId);
    if (channelEntry->flags & CHANNEL_DBC_FLAG_TRADE)              // for trade channel
        _channelFlags |= CHANNEL_FLAG_TRADE;

    if (channelEntry->flags & CHANNEL_DBC_FLAG_CITY_ONLY2)         // for city only channels
        _channelFlags |= CHANNEL_FLAG_CITY;

    if (channelEntry->flags & CHANNEL_DBC_FLAG_LFG)                // for LFG channel
        _channelFlags |= CHANNEL_FLAG_LFG;
    else                                                            // for all other channels
        _channelFlags |= CHANNEL_FLAG_NOT_LFG;
}


Channel::Channel(std::string const& name, TeamId teamId) :
    _announceEnabled(true),
    _ownershipEnabled(true),
    _persistentChannel(false),
    _isOwnerInvisible(false),
    _channelFlags(CHANNEL_FLAG_CUSTOM),
    _channelId(0),
    _channelTeam(teamId),
    _ownerGuid(),
    _channelName(name),
    _channelPassword(),
    _zoneEntry(nullptr)
{
    // If storing custom channels in the db is enabled either load or save the channel
    if (sWorld->getBoolConfig(CONFIG_PRESERVE_CUSTOM_CHANNELS))
    {
        PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHANNEL);
        stmt->setString(0, name);
        stmt->setUInt32(1, _channelTeam);
        if (PreparedQueryResult result = CharacterDatabase.Query(stmt)) // load
        {
            Field* fields = result->Fetch();
            _channelName = fields[0].GetString(); // re-get channel name. MySQL table collation is case insensitive
            _announceEnabled = fields[1].GetBool();
            _ownershipEnabled = fields[2].GetBool();
            _channelPassword = fields[3].GetString();
            std::string db_BannedList = fields[4].GetString();

            if (!db_BannedList.empty())
            {
                Tokenizer tokens(db_BannedList, ' ');
                for (auto const& token : tokens)
                {
                    uint64 banned_guid(uint64(atoull(token)));
                    if (banned_guid)
                    {
                        sLog->outDebug(LOG_FILTER_CHATSYS, "Channel(%s) loaded player %s into bannedStore", name.c_str(), banned_guid.ToString().c_str());
                        _bannedStore.insert(banned_guid);
                    }
                }
            }
        }
        else // save
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHANNEL);
            stmt->setString(0, name);
            stmt->setUInt32(1, _channelTeam);
            CharacterDatabase.Execute(stmt);
            sLog->outDebug(LOG_FILTER_CHATSYS, "Channel(%s) saved in database", name.c_str());
        }

        _persistentChannel = true;
    }
}

void Channel::GetChannelName(std::string& channelName, uint32 channelId, LocaleConstant locale, AreaTableEntry const* zoneEntry)
{
    if (channelId)
    {
        ChatChannelsEntry const* channelEntry = sChatChannelsStore.AssertEntry(channelId);
        if (!(channelEntry->flags & CHANNEL_DBC_FLAG_GLOBAL))
        {
            if (channelEntry->flags & CHANNEL_DBC_FLAG_CITY_ONLY)
                channelName = Trinity::StringFormat(channelEntry->pattern[locale], sObjectMgr->GetTrinityString(LANG_CHANNEL_CITY, locale));
            else
                channelName = Trinity::StringFormat(channelEntry->pattern[locale], ASSERT_NOTNULL(zoneEntry)->area_name[locale]);
        }
        else
            channelName = channelEntry->pattern[locale];
    }
}

std::string Channel::GetName(LocaleConstant locale /*= DEFAULT_LOCALE*/) const
{
    std::string result = _channelName;
    Channel::GetChannelName(result, _channelId, locale, _zoneEntry);

    return result;
}

void Channel::UpdateChannelInDB() const
{
    if (_persistentChannel)
    {
        std::ostringstream banlist;
        for (BannedContainer::const_iterator iter = _bannedStore.begin(); iter != _bannedStore.end(); ++iter)
            banlist << iter->GetRawValue() << ' ';

        std::string banListStr = banlist.str();

        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHANNEL);
        stmt->setBool(0, _announceEnabled);
        stmt->setBool(1, _ownershipEnabled);
        stmt->setString(2, _channelPassword);
        stmt->setString(3, banListStr);
        stmt->setString(4, _channelName);
        stmt->setUInt32(5, _channelTeam);
        CharacterDatabase.Execute(stmt);

        sLog->outDebug(LOG_FILTER_CHATSYS, "Channel(%s) updated in database", _channelName.c_str());
    }
}

void Channel::UpdateChannelUseageInDB() const
{
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHANNEL_USAGE);
    stmt->setString(0, _channelName);
    stmt->setUInt32(1, _channelTeam);
    CharacterDatabase.Execute(stmt);
}

void Channel::CleanOldChannelsInDB()
{
    if (sWorld->getIntConfig(CONFIG_PRESERVE_CUSTOM_CHANNEL_DURATION) > 0)
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_OLD_CHANNELS);
        stmt->setUInt32(0, sWorld->getIntConfig(CONFIG_PRESERVE_CUSTOM_CHANNEL_DURATION) * DAY);
        CharacterDatabase.Execute(stmt);

        sLog->outDebug(LOG_FILTER_CHATSYS, "Cleaned out unused custom chat channels.");
    }
}

void Channel::JoinChannel(Player* player, std::string const& pass)
{
    uint64 guid = player->GetGUID();
    if (IsOn(guid))
    {
        // Do not send error message for built-in channels
        if (!IsConstant())
        {
            PlayerAlreadyMemberAppend appender(guid);
            ChannelNameBuilder<PlayerAlreadyMemberAppend> builder(this, appender);
            SendToOne(builder, guid);
        }
        return;
    }

    if (IsBanned(guid))
    {
        BannedAppend appender;
        ChannelNameBuilder<BannedAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    if (!_channelPassword.empty() && pass != _channelPassword)
    {
        WrongPasswordAppend appender;
        ChannelNameBuilder<WrongPasswordAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    if (HasFlag(CHANNEL_FLAG_LFG) &&
        sWorld->getBoolConfig(CONFIG_RESTRICTED_LFG_CHANNEL) &&
        AccountMgr::IsPlayerAccount(player->GetSession()->GetSecurity()) && //FIXME: Move to RBAC
        player->GetGroup())
    {
        NotInLFGAppend appender;
        ChannelNameBuilder<NotInLFGAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    player->JoinedChannel(this);

    if (_announceEnabled && !player->GetSession()->HasPermission(rbac::RBAC_PERM_SILENTLY_JOIN_CHANNEL))
    {
        JoinedAppend appender(guid);
        ChannelNameBuilder<JoinedAppend> builder(this, appender);
        SendToAll(builder);
    }

    bool newChannel = _playersStore.empty();

    PlayerInfo& pinfo = _playersStore[guid];
    pinfo.flags = MEMBER_FLAG_NONE;
    pinfo.invisible = !player->isGMVisible();

    YouJoinedAppend appender(this);
    ChannelNameBuilder<YouJoinedAppend> builder(this, appender);
    SendToOne(builder, guid);

    JoinNotify(guid);

    // Custom channel handling
    if (!IsConstant())
    {
        // Update last_used timestamp in db
        UpdateChannelUseageInDB();

        // If the channel has no owner yet and ownership is allowed, set the new owner.
        // or if the owner was a GM with .gm visible off
        // don't do this if the new player is, too, an invis GM, unless the channel was empty
        if (_ownershipEnabled && (newChannel || !pinfo.IsInvisible()) && (!_ownerGuid || _isOwnerInvisible))
        {
            _isOwnerInvisible = pinfo.IsInvisible();

            SetOwner(guid, !newChannel && !_isOwnerInvisible);
            pinfo.SetModerator(true);
        }
    }
}

void Channel::LeaveChannel(Player* player, bool send)
{
    uint64 guid = player->GetGUID();
    if (!IsOn(guid))
    {
        if (send)
        {
            NotMemberAppend appender;
            ChannelNameBuilder<NotMemberAppend> builder(this, appender);
            SendToOne(builder, guid);
        }
        return;
    }

    if (send)
    {
        YouLeftAppend appender(this);
        ChannelNameBuilder<YouLeftAppend> builder(this, appender);
        SendToOne(builder, guid);

        player->LeftChannel(this);
    }

    PlayerInfo& info = _playersStore.at(guid);
    bool changeowner = info.IsOwner();
    _playersStore.erase(guid);

    if (_announceEnabled && !player->GetSession()->HasPermission(rbac::RBAC_PERM_SILENTLY_JOIN_CHANNEL))
    {
        LeftAppend appender(guid);
        ChannelNameBuilder<LeftAppend> builder(this, appender);
        SendToAll(builder);
    }

    LeaveNotify(guid);

    if (!IsConstant())
    {
        // Update last_used timestamp in db
        UpdateChannelUseageInDB();

        // If the channel owner left and there are players still inside, pick a new owner
        // do not pick invisible gm owner unless there are only invisible gms in that channel (rare)
        if (changeowner && _ownershipEnabled && !_playersStore.empty())
        {
            PlayerContainer::iterator itr;
            for (itr = _playersStore.begin(); itr != _playersStore.end(); ++itr)
            {
                if (!itr->second.IsInvisible())
                    break;
            }

            if (itr == _playersStore.end())
                itr = _playersStore.begin();

            uint64 newOwner = itr->first;
            itr->second.SetModerator(true);

            SetOwner(newOwner);

            // if the new owner is invisible gm, set flag to automatically choose a new owner
            if (itr->second.IsInvisible())
                _isOwnerInvisible = true;
        }
    }
}

void Channel::KickOrBan(Player const* player, std::string const& badname, bool ban)
{
    uint64 good = player->GetGUID();

    if (!IsOn(good))
    {
        NotMemberAppend appender;
        ChannelNameBuilder<NotMemberAppend> builder(this, appender);
        SendToOne(builder, good);
        return;
    }

    PlayerInfo& info = _playersStore.at(good);
    if (!info.IsModerator() && !player->GetSession()->HasPermission(rbac::RBAC_PERM_CHANGE_CHANNEL_NOT_MODERATOR))
    {
        NotModeratorAppend appender;
        ChannelNameBuilder<NotModeratorAppend> builder(this, appender);
        SendToOne(builder, good);
        return;
    }

    Player* bad = ObjectAccessor::FindConnectedPlayerByName(badname);
    uint64 victim = bad ? bad->GetGUID() : uint64::Empty;
    if (!victim || !IsOn(victim))
    {
        PlayerNotFoundAppend appender(badname);
        ChannelNameBuilder<PlayerNotFoundAppend> builder(this, appender);
        SendToOne(builder, good);
        return;
    }

    bool changeowner = _ownerGuid == victim;

    if (!player->GetSession()->HasPermission(rbac::RBAC_PERM_CHANGE_CHANNEL_NOT_MODERATOR) && changeowner && good != _ownerGuid)
    {
        NotOwnerAppend appender;
        ChannelNameBuilder<NotOwnerAppend> builder(this, appender);
        SendToOne(builder, good);
        return;
    }

    if (ban && !IsBanned(victim))
    {
        _bannedStore.insert(victim);
        UpdateChannelInDB();

        if (!player->GetSession()->HasPermission(rbac::RBAC_PERM_SILENTLY_JOIN_CHANNEL))
        {
            PlayerBannedAppend appender(good, victim);
            ChannelNameBuilder<PlayerBannedAppend> builder(this, appender);
            SendToAll(builder);
        }
    }
    else if (!player->GetSession()->HasPermission(rbac::RBAC_PERM_SILENTLY_JOIN_CHANNEL))
    {
        PlayerKickedAppend appender(good, victim);
        ChannelNameBuilder<PlayerKickedAppend> builder(this, appender);
        SendToAll(builder);
    }

    _playersStore.erase(victim);
    bad->LeftChannel(this);

    if (changeowner && _ownershipEnabled && !_playersStore.empty())
    {
        uint64 newowner = good;
        info.SetModerator(true);
        SetOwner(newowner);
    }
}

void Channel::UnBan(Player const* player, std::string const& badname)
{
    uint64 good = player->GetGUID();

    if (!IsOn(good))
    {
        NotMemberAppend appender;
        ChannelNameBuilder<NotMemberAppend> builder(this, appender);
        SendToOne(builder, good);
        return;
    }

    PlayerInfo& info = _playersStore.at(good);
    if (!info.IsModerator() && !player->GetSession()->HasPermission(rbac::RBAC_PERM_CHANGE_CHANNEL_NOT_MODERATOR))
    {
        NotModeratorAppend appender;
        ChannelNameBuilder<NotModeratorAppend> builder(this, appender);
        SendToOne(builder, good);
        return;
    }

    Player* bad = ObjectAccessor::FindConnectedPlayerByName(badname);
    uint64 victim = bad ? bad->GetGUID() : uint64::Empty;

    if (!victim || !IsBanned(victim))
    {
        PlayerNotFoundAppend appender(badname);
        ChannelNameBuilder<PlayerNotFoundAppend> builder(this, appender);
        SendToOne(builder, good);
        return;
    }

    _bannedStore.erase(victim);

    PlayerUnbannedAppend appender(good, victim);
    ChannelNameBuilder<PlayerUnbannedAppend> builder(this, appender);
    SendToAll(builder);

    UpdateChannelInDB();
}

void Channel::Password(Player const* player, std::string const& pass)
{
    uint64 guid = player->GetGUID();

    ChatHandler chat(player->GetSession());
    if (!IsOn(guid))
    {
        NotMemberAppend appender;
        ChannelNameBuilder<NotMemberAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    PlayerInfo& info = _playersStore.at(guid);
    if (!info.IsModerator() && !player->GetSession()->HasPermission(rbac::RBAC_PERM_CHANGE_CHANNEL_NOT_MODERATOR))
    {
        NotModeratorAppend appender;
        ChannelNameBuilder<NotModeratorAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    _channelPassword = pass;

    PasswordChangedAppend appender(guid);
    ChannelNameBuilder<PasswordChangedAppend> builder(this, appender);
    SendToAll(builder);

    UpdateChannelInDB();
}

void Channel::SetMode(Player const* player, std::string const& p2n, bool mod, bool set)
{
    uint64 guid = player->GetGUID();

    if (!IsOn(guid))
    {
        NotMemberAppend appender;
        ChannelNameBuilder<NotMemberAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    PlayerInfo& info = _playersStore.at(guid);
    if (!info.IsModerator() && !player->GetSession()->HasPermission(rbac::RBAC_PERM_CHANGE_CHANNEL_NOT_MODERATOR))
    {
        NotModeratorAppend appender;
        ChannelNameBuilder<NotModeratorAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    if (guid == _ownerGuid && std::string(p2n) == player->GetName() && mod)
        return;

    Player* newp = ObjectAccessor::FindConnectedPlayerByName(p2n);
    uint64 victim = newp ? newp->GetGUID() : uint64::Empty;

    if (!victim || !IsOn(victim) ||
        (player->GetTeam() != newp->GetTeam() &&
        (!player->GetSession()->HasPermission(rbac::RBAC_PERM_TWO_SIDE_INTERACTION_CHANNEL) ||
        !newp->GetSession()->HasPermission(rbac::RBAC_PERM_TWO_SIDE_INTERACTION_CHANNEL))))
    {
        PlayerNotFoundAppend appender(p2n);
        ChannelNameBuilder<PlayerNotFoundAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    if (_ownerGuid == victim && _ownerGuid != guid)
    {
        NotOwnerAppend appender;
        ChannelNameBuilder<NotOwnerAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    if (mod)
        SetModerator(newp->GetGUID(), set);
    else
        SetMute(newp->GetGUID(), set);
}

void Channel::SetInvisible(Player const* player, bool on)
{
    auto itr = _playersStore.find(player->GetGUID());
    if (itr == _playersStore.end())
        return;

    itr->second.SetInvisible(on);

    // we happen to be owner too, update flag
    if (_ownerGuid == player->GetGUID())
        _isOwnerInvisible = on;
}

void Channel::SetModerator(uint64 guid, bool set)
{
    if (!IsOn(guid))
        return;

    PlayerInfo& playerInfo = _playersStore.at(guid);
    if (playerInfo.IsModerator() != set)
    {
        uint8 oldFlag = GetPlayerFlags(guid);
        playerInfo.SetModerator(set);

        ModeChangeAppend appender(guid, oldFlag, GetPlayerFlags(guid));
        ChannelNameBuilder<ModeChangeAppend> builder(this, appender);
        SendToAll(builder);
    }
}

void Channel::SetMute(uint64 guid, bool set)
{
    if (!IsOn(guid))
        return;

    PlayerInfo& playerInfo = _playersStore.at(guid);
    if (playerInfo.IsMuted() != set)
    {
        uint8 oldFlag = GetPlayerFlags(guid);
        playerInfo.SetMuted(set);

        ModeChangeAppend appender(guid, oldFlag, GetPlayerFlags(guid));
        ChannelNameBuilder<ModeChangeAppend> builder(this, appender);
        SendToAll(builder);
    }
}

void Channel::SetOwner(Player const* player, std::string const& newname)
{
    uint64 guid = player->GetGUID();

    if (!IsOn(guid))
    {
        NotMemberAppend appender;
        ChannelNameBuilder<NotMemberAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    if (!player->GetSession()->HasPermission(rbac::RBAC_PERM_CHANGE_CHANNEL_NOT_MODERATOR) && guid != _ownerGuid)
    {
        NotOwnerAppend appender;
        ChannelNameBuilder<NotOwnerAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    Player* newp = ObjectAccessor::FindConnectedPlayerByName(newname);
    uint64 victim = newp ? newp->GetGUID() : uint64::Empty;

    if (!victim || !IsOn(victim) ||
        (player->GetTeam() != newp->GetTeam() &&
        (!player->GetSession()->HasPermission(rbac::RBAC_PERM_TWO_SIDE_INTERACTION_CHANNEL) ||
        !newp->GetSession()->HasPermission(rbac::RBAC_PERM_TWO_SIDE_INTERACTION_CHANNEL))))
    {
        PlayerNotFoundAppend appender(newname);
        ChannelNameBuilder<PlayerNotFoundAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    PlayerInfo& info = _playersStore.at(victim);
    info.SetModerator(true);
    SetOwner(victim);
}

void Channel::SendWhoOwner(uint64 guid)
{
    if (IsOn(guid))
    {
        ChannelOwnerAppend appender(this, _ownerGuid);
        ChannelNameBuilder<ChannelOwnerAppend> builder(this, appender);
        SendToOne(builder, guid);
    }
    else
    {
        NotMemberAppend appender;
        ChannelNameBuilder<NotMemberAppend> builder(this, appender);
        SendToOne(builder, guid);
    }
}

void Channel::List(Player const* player) const
{
    uint64 guid = player->GetGUID();

    if (!IsOn(guid))
    {
        NotMemberAppend appender;
        ChannelNameBuilder<NotMemberAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    std::string channelName = GetName(player->GetSession()->GetSessionDbcLocale());
    sLog->outDebug(LOG_FILTER_CHATSYS, "SMSG_CHANNEL_LIST %s Channel: %s",
        player->GetSession()->GetPlayerInfo().c_str(), channelName.c_str());

    WorldPacket data(SMSG_CHANNEL_LIST, 1 + (channelName.size() + 1) + 1 + 4 + _playersStore.size() * (8 + 1));
    data << uint8(1);                                   // channel type?
    data << channelName;                                // channel name
    data << uint8(GetFlags());                          // channel flags?

    size_t pos = data.wpos();
    data << uint32(0);                                  // size of list, placeholder

    uint32 gmLevelInWhoList = sWorld->getIntConfig(CONFIG_GM_LEVEL_IN_WHO_LIST);

    uint32 count  = 0;
    for (PlayerContainer::const_iterator i = _playersStore.begin(); i != _playersStore.end(); ++i)
    {
        Player* member = ObjectAccessor::FindConnectedPlayer(i->first);

        // PLAYER can't see MODERATOR, GAME MASTER, ADMINISTRATOR characters
        // MODERATOR, GAME MASTER, ADMINISTRATOR can see all
        if (member &&
            (player->GetSession()->HasPermission(rbac::RBAC_PERM_WHO_SEE_ALL_SEC_LEVELS) ||
             member->GetSession()->GetSecurity() <= AccountTypes(gmLevelInWhoList)) &&
            member->IsVisibleGloballyFor(player))
        {
            data << uint64(i->first);
            data << uint8(i->second.flags);             // flags seems to be changed...
            ++count;
        }
    }

    data.put<uint32>(pos, count);
    player->SendDirectMessage(&data);
}

void Channel::Announce(Player const* player)
{
    uint64 guid = player->GetGUID();

    if (!IsOn(guid))
    {
        NotMemberAppend appender;
        ChannelNameBuilder<NotMemberAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    PlayerInfo& info = _playersStore.at(guid);
    if (!info.IsModerator() && !player->GetSession()->HasPermission(rbac::RBAC_PERM_CHANGE_CHANNEL_NOT_MODERATOR))
    {
        NotModeratorAppend appender;
        ChannelNameBuilder<NotModeratorAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    _announceEnabled = !_announceEnabled;

    if (_announceEnabled)
    {
        AnnouncementsOnAppend appender(guid);
        ChannelNameBuilder<AnnouncementsOnAppend> builder(this, appender);
        SendToAll(builder);
    }
    else
    {
        AnnouncementsOffAppend appender(guid);
        ChannelNameBuilder<AnnouncementsOffAppend> builder(this, appender);
        SendToAll(builder);
    }

    UpdateChannelInDB();
}

void Channel::Say(uint64 guid, std::string const& what, uint32 lang) const
{
    if (what.empty())
        return;

    // TODO: Add proper RBAC check
    if (sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL))
        lang = LANG_UNIVERSAL;

    if (!IsOn(guid))
    {
        NotMemberAppend appender;
        ChannelNameBuilder<NotMemberAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    PlayerInfo const& info = _playersStore.at(guid);
    if (info.IsMuted())
    {
        MutedAppend appender;
        ChannelNameBuilder<MutedAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    auto builder = [&](WorldPacket& data, LocaleConstant locale)
    {
        LocaleConstant localeIdx = sWorld->GetAvailableDbcLocale(locale);

        if (Player* player = ObjectAccessor::FindConnectedPlayer(guid))
            ChatHandler::BuildChatPacket(data, CHAT_MSG_CHANNEL, Language(lang), player, player, what, 0, GetName(localeIdx));
        else
            ChatHandler::BuildChatPacket(data, CHAT_MSG_CHANNEL, Language(lang), guid, guid, what, 0, "", "", 0, false, GetName(localeIdx));
    };

    SendToAll(builder, !info.IsModerator() ? guid : uint64::Empty);

}

void Channel::Invite(Player const* player, std::string const& newname)
{
    uint64 guid = player->GetGUID();

    if (!IsOn(guid))
    {
        NotMemberAppend appender;
        ChannelNameBuilder<NotMemberAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    Player* newp = ObjectAccessor::FindConnectedPlayerByName(newname);
    if (!newp || !newp->isGMVisible())
    {
        PlayerNotFoundAppend appender(newname);
        ChannelNameBuilder<PlayerNotFoundAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    if (IsBanned(newp->GetGUID()))
    {
        PlayerInviteBannedAppend appender(newname);
        ChannelNameBuilder<PlayerInviteBannedAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    if (newp->GetTeam() != player->GetTeam() &&
        (!player->GetSession()->HasPermission(rbac::RBAC_PERM_TWO_SIDE_INTERACTION_CHANNEL) ||
        !newp->GetSession()->HasPermission(rbac::RBAC_PERM_TWO_SIDE_INTERACTION_CHANNEL)))
    {
        InviteWrongFactionAppend appender;
        ChannelNameBuilder<InviteWrongFactionAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    if (IsOn(newp->GetGUID()))
    {
        PlayerAlreadyMemberAppend appender(newp->GetGUID());
        ChannelNameBuilder<PlayerAlreadyMemberAppend> builder(this, appender);
        SendToOne(builder, guid);
        return;
    }

    if (!newp->GetSocial()->HasIgnore(guid.GetCounter()))
    {
        InviteAppend appender(guid);
        ChannelNameBuilder<InviteAppend> builder(this, appender);
        SendToOne(builder, newp->GetGUID());
    }

    PlayerInvitedAppend appender(newp->GetName());
    ChannelNameBuilder<PlayerInvitedAppend> builder(this, appender);
    SendToOne(builder, guid);
}

void Channel::SetOwner(uint64 guid, bool exclaim)
{
    if (_ownerGuid)
    {
        auto itr = _playersStore.find(_ownerGuid);
        if (itr != _playersStore.end())
            itr->second.SetOwner(false);
    }

    _ownerGuid = guid;
    if (_ownerGuid)
    {
        uint8 oldFlag = GetPlayerFlags(_ownerGuid);
        auto itr = _playersStore.find(_ownerGuid);
        if (itr == _playersStore.end())
            return;

        itr->second.SetModerator(true);
        itr->second.SetOwner(true);

        ModeChangeAppend appender(_ownerGuid, oldFlag, GetPlayerFlags(_ownerGuid));
        ChannelNameBuilder<ModeChangeAppend> builder(this, appender);
        SendToAll(builder);

        if (exclaim)
        {
            OwnerChangedAppend appender(_ownerGuid);
            ChannelNameBuilder<OwnerChangedAppend> builder(this, appender);
            SendToAll(builder);
        }

        UpdateChannelInDB();
    }
}

void Channel::Voice(uint64 /*guid1*/, uint64 /*guid2*/) const
{

}

void Channel::DeVoice(uint64 /*guid1*/, uint64 /*guid2*/) const
{

}

void Channel::JoinNotify(uint64 guid) const
{
    auto builder = [&](WorldPacket& data, LocaleConstant locale)
    {
        LocaleConstant localeIdx = sWorld->GetAvailableDbcLocale(locale);

        data.Initialize(IsConstant() ? SMSG_USERLIST_ADD : SMSG_USERLIST_UPDATE, 8 + 1 + 1 + 4 + 30 /*channelName buffer*/);
        data << uint64(guid);
        data << uint8(GetPlayerFlags(guid));
        data << uint8(GetFlags());
        data << uint32(GetNumPlayers());
        data << GetName(localeIdx);
    };

    if (IsConstant())
        SendToAllButOne(builder, guid);
    else
        SendToAll(builder);
}

void Channel::LeaveNotify(uint64 guid) const
{
    auto builder = [&](WorldPacket& data, LocaleConstant locale)
    {
        LocaleConstant localeIdx = sWorld->GetAvailableDbcLocale(locale);

        data.Initialize(SMSG_USERLIST_REMOVE, 8 + 1 + 4 + 30 /*channelName buffer*/);
        data << uint64(guid);
        data << uint8(GetFlags());
        data << uint32(GetNumPlayers());
        data << GetName(localeIdx);
    };

    if (IsConstant())
        SendToAllButOne(builder, guid);
    else
        SendToAll(builder);
}

template<class Builder>
void Channel::SendToAll(Builder& builder, uint64 guid /*= uint64::Empty*/) const
{
    Trinity::LocalizedPacketDo<Builder> localizer(builder);

    for (PlayerContainer::const_iterator i = _playersStore.begin(); i != _playersStore.end(); ++i)
        if (Player* player = ObjectAccessor::FindConnectedPlayer(i->first))
            if (!guid || !player->GetSocial()->HasIgnore(guid.GetCounter()))
                localizer(player);
}

template<class Builder>
void Channel::SendToAllButOne(Builder& builder, uint64 who) const
{
    Trinity::LocalizedPacketDo<Builder> localizer(builder);

    for (PlayerContainer::const_iterator i = _playersStore.begin(); i != _playersStore.end(); ++i)
        if (i->first != who)
            if (Player* player = ObjectAccessor::FindConnectedPlayer(i->first))
                localizer(player);
}

template<class Builder>
void Channel::SendToOne(Builder& builder, uint64 who) const
{
    Trinity::LocalizedPacketDo<Builder> localizer(builder);

    if (Player* player = ObjectAccessor::FindConnectedPlayer(who))
        localizer(player);
}
