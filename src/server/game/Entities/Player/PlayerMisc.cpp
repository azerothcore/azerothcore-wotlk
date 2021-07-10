/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "MapManager.h"
#include "Player.h"
#include "ScriptMgr.h"

/*********************************************************/
/***               FLOOD FILTER SYSTEM                 ***/
/*********************************************************/

void Player::UpdateSpeakTime(uint32 specialMessageLimit)
{
    // ignore chat spam protection for GMs in any mode
    if (!AccountMgr::IsPlayerAccount(GetSession()->GetSecurity()))
        return;

    time_t current = time (nullptr);
    if (m_speakTime > current)
    {
        uint32 max_count = specialMessageLimit ? specialMessageLimit : sWorld->getIntConfig(CONFIG_CHATFLOOD_MESSAGE_COUNT);
        if (!max_count)
            return;

        ++m_speakCount;
        if (m_speakCount >= max_count)
        {
            // prevent overwrite mute time, if message send just before mutes set, for example.
            time_t new_mute = current + sWorld->getIntConfig(CONFIG_CHATFLOOD_MUTE_TIME);
            if (GetSession()->m_muteTime < new_mute)
                GetSession()->m_muteTime = new_mute;

            m_speakCount = 0;
        }
    }
    else
        m_speakCount = 1;

    m_speakTime = current + sWorld->getIntConfig(CONFIG_CHATFLOOD_MESSAGE_DELAY);
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
    GetSession()->SendPacket(&data);
}

void Player::SavePositionInDB(uint32 mapid, float x, float y, float z, float o, uint32 zone, ObjectGuid guid)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_POSITION);

    stmt->setFloat(0, x);
    stmt->setFloat(1, y);
    stmt->setFloat(2, z);
    stmt->setFloat(3, o);
    stmt->setUInt16(4, uint16(mapid));
    stmt->setUInt16(5, uint16(zone));
    stmt->setUInt32(6, guid.GetCounter());

    CharacterDatabase.Execute(stmt);
}

void Player::SavePositionInDB(WorldLocation const& loc, uint16 zoneId, ObjectGuid guid, CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_POSITION);

    stmt->setFloat(0, loc.GetPositionX());
    stmt->setFloat(1, loc.GetPositionY());
    stmt->setFloat(2, loc.GetPositionZ());
    stmt->setFloat(3, loc.GetOrientation());
    stmt->setUInt16(4, uint16(loc.GetMapId()));
    stmt->setUInt16(5, zoneId);
    stmt->setUInt32(6, guid.GetCounter());

    CharacterDatabase.ExecuteOrAppend(trans, stmt);
}

void Player::SetUInt32ValueInArray(Tokenizer& tokens, uint16 index, uint32 value)
{
    char buf[11];
    snprintf(buf, 11, "%u", value);

    if (index >= tokens.size())
        return;

    tokens[index] = buf;
}

void Player::Customize(CharacterCustomizeInfo const* customizeInfo, CharacterDatabaseTransaction trans)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_GENDER_AND_APPEARANCE);
    stmt->setUInt8(0, customizeInfo->Gender);
    stmt->setUInt8(1, customizeInfo->Skin);
    stmt->setUInt8(2, customizeInfo->Face);
    stmt->setUInt8(3, customizeInfo->HairStyle);
    stmt->setUInt8(4, customizeInfo->HairColor);
    stmt->setUInt8(5, customizeInfo->FacialHair);
    stmt->setUInt32(6, customizeInfo->Guid.GetCounter());

    CharacterDatabase.ExecuteOrAppend(trans, stmt);
}

void Player::SendAttackSwingDeadTarget()
{
    WorldPacket data(SMSG_ATTACKSWING_DEADTARGET, 0);
    GetSession()->SendPacket(&data);
}

void Player::SendAttackSwingCantAttack()
{
    WorldPacket data(SMSG_ATTACKSWING_CANT_ATTACK, 0);
    GetSession()->SendPacket(&data);
}

void Player::SendAttackSwingCancelAttack()
{
    WorldPacket data(SMSG_CANCEL_COMBAT, 0);
    GetSession()->SendPacket(&data);
}

void Player::SendAttackSwingBadFacingAttack()
{
    WorldPacket data(SMSG_ATTACKSWING_BADFACING, 0);
    GetSession()->SendPacket(&data);
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
    GetSession()->SendPacket(&data);
}

void Player::SendDungeonDifficulty(bool IsInGroup)
{
    uint8 val = 0x00000001;
    WorldPacket data(MSG_SET_DUNGEON_DIFFICULTY, 12);
    data << (uint32)GetDungeonDifficulty();
    data << uint32(val);
    data << uint32(IsInGroup);
    GetSession()->SendPacket(&data);
}

void Player::SendRaidDifficulty(bool IsInGroup, int32 forcedDifficulty)
{
    uint8 val = 0x00000001;
    WorldPacket data(MSG_SET_RAID_DIFFICULTY, 12);
    data << uint32(forcedDifficulty == -1 ? GetRaidDifficulty() : forcedDifficulty);
    data << uint32(val);
    data << uint32(IsInGroup);
    GetSession()->SendPacket(&data);
}

void Player::SendResetFailedNotify(uint32 mapid)
{
    WorldPacket data(SMSG_RESET_FAILED_NOTIFY, 4);
    data << uint32(mapid);
    GetSession()->SendPacket(&data);
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
                const MapEntry* entry = sMapStore.LookupEntry(itr->first);
                if (!entry || entry->IsRaid() || !instanceSave->CanReset())
                    continue;

                Map* map = sMapMgr->FindMap(instanceSave->GetMapId(), instanceSave->GetInstanceId());
                if (!map || map->ToInstanceMap()->Reset(method))
                {
                    p->SendResetInstanceSuccess(instanceSave->GetMapId());
                    toUnbind.push_back(instanceSave);
                }
                else
                    p->SendResetInstanceFailed(0, instanceSave->GetMapId());
            }
            for (std::vector<InstanceSave*>::const_iterator itr = toUnbind.begin(); itr != toUnbind.end(); ++itr)
                sInstanceSaveMgr->UnbindAllFor(*itr);
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
                const MapEntry* entry = sMapStore.LookupEntry(itr->first);
                if (!entry || entry->IsRaid() != isRaid || !instanceSave->CanReset())
                    continue;

                Map* map = sMapMgr->FindMap(instanceSave->GetMapId(), instanceSave->GetInstanceId());
                if (!map || map->ToInstanceMap()->Reset(method))
                {
                    p->SendResetInstanceSuccess(instanceSave->GetMapId());
                    toUnbind.push_back(instanceSave);
                }
                else
                    p->SendResetInstanceFailed(0, instanceSave->GetMapId());
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
    GetSession()->SendPacket(&data);
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
    GetSession()->SendPacket(&data);
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
        if (currTime > (pvpInfo.EndTimer + 4) && !HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_PVP_TIMER))
            SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_PVP_TIMER);

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

    RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
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
    if (!duel || duel->startTimer == 0 || currTime < duel->startTimer + 3)
        return;

    sScriptMgr->OnPlayerDuelStart(this, duel->opponent);

    SetUInt32Value(PLAYER_DUEL_TEAM, 1);
    duel->opponent->SetUInt32Value(PLAYER_DUEL_TEAM, 2);

    duel->startTimer = 0;
    duel->startTime  = currTime;
    duel->opponent->duel->startTimer = 0;
    duel->opponent->duel->startTime  = currTime;
}

/*********************************************************/
