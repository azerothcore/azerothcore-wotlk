/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "Pet.h"
#include "UpdateMask.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleLearnTalentOpcode(WorldPacket & recvData)
{
    uint32 talent_id, requested_rank;
    recvData >> talent_id >> requested_rank;

    _player->LearnTalent(talent_id, requested_rank);
    _player->SendTalentsInfoData(false);
}

void WorldSession::HandleLearnPreviewTalents(WorldPacket& recvPacket)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LEARN_PREVIEW_TALENTS");
#endif

    uint32 talentsCount;
    recvPacket >> talentsCount;

    uint32 talentId, talentRank;

    // Client has max 44 talents for tree for 3 trees, rounded up : 150
    uint32 const MaxTalentsCount = 150;

    for (uint32 i = 0; i < talentsCount && i < MaxTalentsCount; ++i)
    {
        recvPacket >> talentId >> talentRank;

        _player->LearnTalent(talentId, talentRank);
    }

    _player->SendTalentsInfoData(false);

    recvPacket.rfinish();
}

void WorldSession::HandleTalentWipeConfirmOpcode(WorldPacket & recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "MSG_TALENT_WIPE_CONFIRM");
#endif
    uint64 guid;
    recvData >> guid;

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_TRAINER);
    if (!unit)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: HandleTalentWipeConfirmOpcode - Unit (GUID: %u) not found or you can't interact with him.", uint32(GUID_LOPART(guid)));
#endif
        return;
    }

    if (!unit->isCanTrainingAndResetTalentsOf(_player))
        return;

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    if (!(_player->resetTalents()))
    {
        WorldPacket data(MSG_TALENT_WIPE_CONFIRM, 8+4);    //you have not any talent
        data << uint64(0);
        data << uint32(0);
        SendPacket(&data);
        return;
    }

    _player->SendTalentsInfoData(false);
    unit->CastSpell(_player, 14867, true);                  //spell: "Untalent Visual Effect"
}

void WorldSession::HandleUnlearnSkillOpcode(WorldPacket& recvData)
{
    uint32 skillId;
    recvData >> skillId;

    if (!IsPrimaryProfessionSkill(skillId))
        return;

    GetPlayer()->SetSkill(skillId, 0, 0, 0);
}
