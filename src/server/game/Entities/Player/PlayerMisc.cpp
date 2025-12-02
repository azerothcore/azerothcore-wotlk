/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "AccountMgr.h"
#include "GameTime.h"
#include "MapMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "WorldSession.h"

/*********************************************************/
/***               FLOOD FILTER SYSTEM                 ***/
/*********************************************************/

void Player::UpdateSpeakTime(ChatFloodThrottle::Index index)
{
    // ignore chat spam protection for GMs in any mode
    if (!AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()))
        return;

    uint32 limit, delay;
    switch (index)
    {
         case ChatFloodThrottle::ADDON:
             limit = sWorld->getIntConfig(CONFIG_CHATFLOOD_ADDON_MESSAGE_COUNT);
             delay = sWorld->getIntConfig(CONFIG_CHATFLOOD_ADDON_MESSAGE_DELAY);
             break;
         case ChatFloodThrottle::REGULAR:
             limit = sWorld->getIntConfig(CONFIG_CHATFLOOD_MESSAGE_COUNT);
             delay = sWorld->getIntConfig(CONFIG_CHATFLOOD_MESSAGE_DELAY);
             [[fallthrough]];
         default:
             return;
    }
    time_t current = GameTime::GetGameTime().count();
    if (m_chatFloodData[index].Time > current)
    {
        ++m_chatFloodData[index].Count;
        if (m_chatFloodData[index].Count >= limit)
        {
            // prevent overwrite mute time, if message send just before mutes set, for example.
            time_t new_mute = current + sWorld->getIntConfig(CONFIG_CHATFLOOD_MUTE_TIME);
            if (GetSession()->m_muteTime < new_mute)
                GetSession()->m_muteTime = new_mute;

            m_chatFloodData[index].Count = 0;
        }
    }
    else
        m_chatFloodData[index].Count = 1;

    m_chatFloodData[index].Time = current + delay;
}

bool Player::CanSpeak() const
{
    return  GetSession()->m_muteTime <= time (nullptr);
}

/*********************************************************/
/***              LOW LEVEL FUNCTIONS:Notifiers        ***/
/*********************************************************/

void Player::SendAttackSwingNotInRange()
{
    WorldPacket data(SMSG_ATTACKSWING_NOTINRANGE, 0);
    SendDirectMessage(&data);
}

void Player::SavePositionInDB(uint32 mapid, float x, float y, float z, float o, uint32 zone, ObjectGuid guid)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_POSITION);

    stmt->SetData(0, x);
    stmt->SetData(1, y);
    stmt->SetData(2, z);
    stmt->SetData(3, o);
    stmt->SetData(4, uint16(mapid));
    stmt->SetData(5, uint16(zone));
    stmt->SetData(6, guid.GetCounter());

    CharacterDatabase.Execute(stmt);
}

void Player::SavePositionInDB(WorldLocation const& loc, uint16 zoneId, ObjectGuid guid, CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_POSITION);

    stmt->SetData(0, loc.GetPositionX());
    stmt->SetData(1, loc.GetPositionY());
    stmt->SetData(2, loc.GetPositionZ());
    stmt->SetData(3, loc.GetOrientation());
    stmt->SetData(4, uint16(loc.GetMapId()));
    stmt->SetData(5, zoneId);
    stmt->SetData(6, guid.GetCounter());

    CharacterDatabase.ExecuteOrAppend(trans, stmt);
}

void Player::Customize(CharacterCustomizeInfo const* customizeInfo, CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_GENDER_AND_APPEARANCE);
    stmt->SetData(0, customizeInfo->Gender);
    stmt->SetData(1, customizeInfo->Skin);
    stmt->SetData(2, customizeInfo->Face);
    stmt->SetData(3, customizeInfo->HairStyle);
    stmt->SetData(4, customizeInfo->HairColor);
    stmt->SetData(5, customizeInfo->FacialHair);
    stmt->SetData(6, customizeInfo->Guid.GetCounter());

    CharacterDatabase.ExecuteOrAppend(trans, stmt);
}

void Player::SendAttackSwingDeadTarget()
{
    WorldPacket data(SMSG_ATTACKSWING_DEADTARGET, 0);
    SendDirectMessage(&data);
}

void Player::SendAttackSwingCantAttack()
{
    WorldPacket data(SMSG_ATTACKSWING_CANT_ATTACK, 0);
    SendDirectMessage(&data);
}

void Player::SendAttackSwingCancelAttack()
{
    WorldPacket data(SMSG_CANCEL_COMBAT, 0);
    SendDirectMessage(&data);
}

void Player::SendAttackSwingBadFacingAttack()
{
    WorldPacket data(SMSG_ATTACKSWING_BADFACING, 0);
    SendDirectMessage(&data);
}

void Player::SendAutoRepeatCancel(Unit* target)
{
    WorldPacket data(SMSG_CANCEL_AUTO_REPEAT, target->GetPackGUID().size());
    data << target->GetPackGUID();                  // may be it's target guid
    SendMessageToSet(&data, true);
}

void Player::SendExplorationExperience(uint32 Area, uint32 Experience)
{
    WorldPacket data(SMSG_EXPLORATION_EXPERIENCE, 8);
    data << uint32(Area);
    data << uint32(Experience);
    SendDirectMessage(&data);
}

void Player::SendDungeonDifficulty(bool IsInGroup)
{
    uint8 val = 0x00000001;
    WorldPacket data(MSG_SET_DUNGEON_DIFFICULTY, 12);
    data << (uint32)GetDungeonDifficulty();
    data << uint32(val);
    data << uint32(IsInGroup);
    SendDirectMessage(&data);
}

void Player::SendRaidDifficulty(bool IsInGroup, int32 forcedDifficulty)
{
    uint8 val = 0x00000001;
    WorldPacket data(MSG_SET_RAID_DIFFICULTY, 12);
    data << uint32(forcedDifficulty == -1 ? GetRaidDifficulty() : forcedDifficulty);
    data << uint32(val);
    data << uint32(IsInGroup);
    SendDirectMessage(&data);
}

void Player::SendResetFailedNotify(uint32 mapid)
{
    WorldPacket data(SMSG_RESET_FAILED_NOTIFY, 4);
    data << uint32(mapid);
    SendDirectMessage(&data);
}

/// Reset all solo instances and optionally send a message on success for each
void Player::ResetInstances(ObjectGuid guid, uint8 method, bool isRaid)
{
    switch (method)
    {
        case INSTANCE_RESET_ALL:
        {
            Player* p = ObjectAccessor::FindConnectedPlayer(guid);
            if (!p || p->GetDifficulty(false) != DUNGEON_DIFFICULTY_NORMAL)
                break;
            std::vector<InstanceSave*> toUnbind;
            BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(p->GetGUID(), Difficulty(DUNGEON_DIFFICULTY_NORMAL));
            for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
            {
                InstanceSave* instanceSave = itr->second.save;
                MapEntry const* entry = sMapStore.LookupEntry(itr->first);
                if (!entry || entry->IsRaid() || !instanceSave->CanReset())
                {
                    continue;
                }

                Map* map = sMapMgr->FindMap(instanceSave->GetMapId(), instanceSave->GetInstanceId());
                if (!map || map->ToInstanceMap()->Reset(method))
                {
                    p->SendResetInstanceSuccess(instanceSave->GetMapId());
                    toUnbind.push_back(instanceSave);
                }
                else
                {
                    p->SendResetInstanceFailed(0, instanceSave->GetMapId());
                }

                sInstanceSaveMgr->DeleteInstanceSavedData(instanceSave->GetInstanceId());
            }
            for (std::vector<InstanceSave*>::const_iterator itr = toUnbind.begin(); itr != toUnbind.end(); ++itr)
            {
                sInstanceSaveMgr->UnbindAllFor(*itr);
            }
        }
            break;
        case INSTANCE_RESET_CHANGE_DIFFICULTY:
        {
            Player* p = ObjectAccessor::FindConnectedPlayer(guid);
            if (!p)
                break;
            std::vector<InstanceSave*> toUnbind;
            BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(p->GetGUID(), p->GetDifficulty(isRaid));
            for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
            {
                InstanceSave* instanceSave = itr->second.save;
                MapEntry const* entry = sMapStore.LookupEntry(itr->first);
                if (!entry || entry->IsRaid() != isRaid || !instanceSave->CanReset())
                {
                    continue;
                }

                Map* map = sMapMgr->FindMap(instanceSave->GetMapId(), instanceSave->GetInstanceId());
                if (!map || map->ToInstanceMap()->Reset(method))
                {
                    p->SendResetInstanceSuccess(instanceSave->GetMapId());
                    toUnbind.push_back(instanceSave);
                }
                else
                {
                    p->SendResetInstanceFailed(0, instanceSave->GetMapId());
                }

                sInstanceSaveMgr->DeleteInstanceSavedData(instanceSave->GetInstanceId());
            }
            for (std::vector<InstanceSave*>::const_iterator itr = toUnbind.begin(); itr != toUnbind.end(); ++itr)
                sInstanceSaveMgr->UnbindAllFor(*itr);
        }
            break;
        case INSTANCE_RESET_GROUP_JOIN:
        {
            Player* p = ObjectAccessor::FindConnectedPlayer(guid);
            if (!p)
                break;
            for (uint8 d = 0; d < MAX_DIFFICULTY; ++d)
            {
                std::vector<InstanceSave*> toUnbind;
                BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(p->GetGUID(), Difficulty(d));
                for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
                {
                    if (itr->second.perm)
                        continue;
                    InstanceSave* instanceSave = itr->second.save;
                    Map* map = sMapMgr->FindMap(instanceSave->GetMapId(), instanceSave->GetInstanceId());
                    if (!map || p->FindMap() != map)
                    {
                        //p->SendResetInstanceSuccess(instanceSave->GetMapId());
                        toUnbind.push_back(instanceSave);
                    }
                    //else
                    //  p->SendResetInstanceFailed(0, instanceSave->GetMapId());

                    sInstanceSaveMgr->DeleteInstanceSavedData(instanceSave->GetInstanceId());
                }
                for (std::vector<InstanceSave*>::const_iterator itr = toUnbind.begin(); itr != toUnbind.end(); ++itr)
                    sInstanceSaveMgr->PlayerUnbindInstance(p->GetGUID(), (*itr)->GetMapId(), (*itr)->GetDifficulty(), true, p);
            }
        }
            break;
        case INSTANCE_RESET_GROUP_LEAVE:
        {
            Player* p = ObjectAccessor::FindConnectedPlayer(guid);
            for (uint8 d = 0; d < MAX_DIFFICULTY; ++d)
            {
                std::vector<InstanceSave*> toUnbind;
                BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(guid, Difficulty(d));
                for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end(); ++itr)
                {
                    if (itr->second.perm)
                        continue;
                    InstanceSave* instanceSave = itr->second.save;
                    Map* map = sMapMgr->FindMap(instanceSave->GetMapId(), instanceSave->GetInstanceId());
                    if (!p || !map || p->FindMap() != map)
                    {
                        //p->SendResetInstanceSuccess(instanceSave->GetMapId());
                        toUnbind.push_back(instanceSave);
                    }
                    //else
                    //  p->SendResetInstanceFailed(0, instanceSave->GetMapId());
                }
                for (std::vector<InstanceSave*>::const_iterator itr = toUnbind.begin(); itr != toUnbind.end(); ++itr)
                    sInstanceSaveMgr->PlayerUnbindInstance(guid, (*itr)->GetMapId(), (*itr)->GetDifficulty(), true, p);
            }
        }
            break;
    }
}

void Player::SendResetInstanceSuccess(uint32 MapId)
{
    WorldPacket data(SMSG_INSTANCE_RESET, 4);
    data << uint32(MapId);
    SendDirectMessage(&data);
}

void Player::SendResetInstanceFailed(uint32 reason, uint32 MapId)
{
    /*reasons for instance reset failure:
    // 0: There are players inside the instance.
    // 1: There are players offline in your party.
    // 2>: There are players in your party attempting to zone into an instance.
    */
    WorldPacket data(SMSG_INSTANCE_RESET_FAILED, 4);
    data << uint32(reason);
    data << uint32(MapId);
    SendDirectMessage(&data);
}

/*********************************************************/
/***              Update timers                        ***/
/*********************************************************/

///checks the 15 afk reports per 5 minutes limit
void Player::UpdateAfkReport(time_t currTime)
{
    if (m_bgData.bgAfkReportedTimer <= currTime)
    {
        m_bgData.bgAfkReportedCount = 0;
        m_bgData.bgAfkReportedTimer = currTime + 5 * MINUTE;
    }
}

void Player::UpdateContestedPvP(uint32 diff)
{
    if (!m_contestedPvPTimer || IsInCombat())
        return;
    if (m_contestedPvPTimer <= diff)
    {
        ResetContestedPvP();
    }
    else
        m_contestedPvPTimer -= diff;
}

void Player::UpdatePvPFlag(time_t currTime)
{
    if (!IsPvP())
        return;

    if (pvpInfo.EndTimer == 0 || pvpInfo.IsHostile)
        return;

    if (currTime < (pvpInfo.EndTimer + 300 + 5))
    {
        if (currTime > (pvpInfo.EndTimer + 4) && !HasPlayerFlag(PLAYER_FLAGS_PVP_TIMER))
            SetPlayerFlag(PLAYER_FLAGS_PVP_TIMER);

        return;
    }

    UpdatePvP(false);
}

void Player::UpdateFFAPvPFlag(time_t currTime)
{
    if (!IsFFAPvP() || sWorld->IsFFAPvPRealm() || !pvpInfo.FFAPvPEndTimer || currTime < pvpInfo.FFAPvPEndTimer + 30)
    {
        return;
    }

    pvpInfo.FFAPvPEndTimer = time_t(0);
    if (HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP))
    {
        RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
        sScriptMgr->OnPlayerFfaPvpStateUpdate(this, false);
    }
    for (ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
        (*itr)->RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);

    // xinef: iterate attackers
    AttackerSet toRemove;
    AttackerSet const& attackers = getAttackers();
    for (AttackerSet::const_iterator itr = attackers.begin(); itr != attackers.end(); ++itr)
        if (!(*itr)->IsValidAttackTarget(this))
            toRemove.insert(*itr);

    for (AttackerSet::const_iterator itr = toRemove.begin(); itr != toRemove.end(); ++itr)
        (*itr)->AttackStop();

    // xinef: remove our own victim
    if (Unit* victim = GetVictim())
        if (!IsValidAttackTarget(victim))
            AttackStop();
}

void Player::UpdateDuelFlag(time_t currTime)
{
    if (duel && duel->State == DUEL_STATE_COUNTDOWN && duel->StartTime <= currTime)
    {
        sScriptMgr->OnPlayerDuelStart(this, duel->Opponent);

        SetUInt32Value(PLAYER_DUEL_TEAM, 1);
        duel->Opponent->SetUInt32Value(PLAYER_DUEL_TEAM, 2);

        duel->State = DUEL_STATE_IN_PROGRESS;
        duel->Opponent->duel->State = DUEL_STATE_IN_PROGRESS;
    }
}

/*********************************************************/

void Player::SendItemRetrievalMail(uint32 itemEntry, uint32 count)
{
    SendItemRetrievalMail({ { itemEntry, count } });
}

void Player::SendItemRetrievalMail(std::vector<std::pair<uint32, uint32>> mailItems)
{
    if (mailItems.empty())
    {
        // Skip send if empty items
        LOG_ERROR("entities.player.items", "> SendItemRetrievalMail: Attempt to send almost with items without items. Player {}", GetGUID().ToString());
        return;
    }

    using SendMailTempateVector = std::vector<std::pair<uint32, uint32>>;

    std::vector<SendMailTempateVector> allItems;

    auto AddMailItem = [&allItems](uint32 itemEntry, uint32 itemCount)
    {
        SendMailTempateVector toSendItems;

        ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemEntry);
        if (!itemTemplate)
        {
            LOG_ERROR("entities.player.items", "> SendItemRetrievalMail: Item id {} is invalid", itemEntry);
            return;
        }

        if (itemCount < 1 || (itemTemplate->MaxCount > 0 && itemCount > static_cast<uint32>(itemTemplate->MaxCount)))
        {
            LOG_ERROR("entities.player.items", "> SendItemRetrievalMail: Incorrect item count ({}) for item id {}", itemEntry, itemCount);
            return;
        }

        while (itemCount > itemTemplate->GetMaxStackSize())
        {
            if (toSendItems.size() <= MAX_MAIL_ITEMS)
            {
                toSendItems.emplace_back(itemEntry, itemTemplate->GetMaxStackSize());
                itemCount -= itemTemplate->GetMaxStackSize();
            }
            else
            {
                allItems.emplace_back(toSendItems);
                toSendItems.clear();
            }
        }

        toSendItems.emplace_back(itemEntry, itemCount);
        allItems.emplace_back(toSendItems);
    };

    for (auto& [itemEntry, itemCount] : mailItems)
    {
        AddMailItem(itemEntry, itemCount);
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    for (auto const& items : allItems)
    {
        MailSender sender(MAIL_CREATURE, 34337 /* The Postmaster */);
        MailDraft draft("Recovered Item", "We recovered a lost item in the twisting nether and noted that it was yours.$B$BPlease find said object enclosed."); // This is the text used in Cataclysm, it probably wasn't changed.

        for (auto const& [itemEntry, itemCount] : items)
        {
            if (Item* mailItem = Item::CreateItem(itemEntry, itemCount))
            {
                mailItem->SaveToDB(trans);
                draft.AddItem(mailItem);
            }
        }

        draft.SendMailTo(trans, MailReceiver(this, GetGUID().GetCounter()), sender);
    }

    CharacterDatabase.CommitTransaction(trans);
}
