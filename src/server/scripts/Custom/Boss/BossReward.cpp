#include "ScriptMgr.h"
#include "Unit.h"
#include "Player.h"
#include "Pet.h"
#include "Map.h"
#include "Group.h"
#include "InstanceScript.h"

class RewardRangKillBoss : public PlayerScript
{
public:
	RewardRangKillBoss() : PlayerScript("RewardRangKillBoss") {}

    constexpr static const std::array<uint32, 5> _BossRewardEntry = {99003, 99004, 99005, 99006, 99011};

	void CalculateRate(Player* player, uint32 rate, Creature* Boss)
	{
		if (rate == 0)
			return;

		if (player->GetGroup())
			RewardGroup(player, rate, Boss);
		else
			RewardPlayer(player, rate);
	}

 	static void RewardGroup(Player* player, uint32 rate, Creature* boss)
    {
        if (!player || !boss)
            return;

        for (GroupReference* itr = player->GetGroup()->GetFirstMember(); itr != NULL; itr = itr->next()) {
            if (Player* member = itr->GetSource()) {
                if (player == member || member->IsAtGroupRewardDistance(boss))
                    RewardPlayer(member, rate);
            }
        }
    }

    static void RewardPlayer(Player* player, const uint32 rate)
    {
        if (!player)
            return;

        uint32 reward = rate;

        if (player->GetRankByExp() > 0)
            reward = ((rate / 100) * player->GetRankByExp()) + rate;

        player->RewardRankPoints(reward, 9 /* тип награды -> 9 = убийство боссов */);
    }

	void OnCreatureKill(Player* player, Creature* boss)
	{
        if (!player || !boss)
            return;

        for (const auto& i: _BossRewardEntry) {
		    if (i == boss->GetEntry()) {
                CalculateRate(player, urand(5, 20)*100, boss);
			    return;
            }
        }
	}
};

void AddSC_RewardRangKillBoss()
{
	new RewardRangKillBoss();
}