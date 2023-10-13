#ifndef CHALLENGEMODE_MGR_H
#define CHALLENGEMODE_MGR_H

class ChallengeModeMgr
{
public:
    static ChallengeModeMgr* instance();

    uint32 GetRandomChallengeId(uint32 flags = 4);

    std::vector<int32> GetBonusListIdsForRewards(uint32 baseItemIlevel, uint8 challengeLevel);
    void Reward(Player* player, uint8 challengeLevel);
};

#define sChallengeModeMgr ChallengeModeMgr::instance()

#endif
