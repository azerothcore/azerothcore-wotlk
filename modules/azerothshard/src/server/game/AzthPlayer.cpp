#include "Player.h"
#include "Group.h"
#include "AzthPlayer.h"
#include "Define.h"
#include "ObjectAccessor.h"
#include "World.h"

AzthPlayer::AzthPlayer(Player *origin) {
    playerQuestRate = sWorld->getRate(RATE_XP_QUEST);
    player = origin;
}

void AzthPlayer::SetPlayerQuestRate(float rate) {
    playerQuestRate = rate;
}

uint32 AzthPlayer::getArena1v1Info(uint8 type) {
    return arena1v1Info[type];
}

void AzthPlayer::setArena1v1Info(uint8 type, uint32 value) {
    arena1v1Info[type] = value;
}

float AzthPlayer::GetPlayerQuestRate() {
    return playerQuestRate;
}

AzthPlayer::~AzthPlayer() {}
