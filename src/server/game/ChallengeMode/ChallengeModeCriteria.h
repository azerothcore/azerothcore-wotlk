#ifndef ChallengeModeCriteria_h__
#define ChallengeModeCriteria_h__

#include "ObjectMgr.h"

class Map;

class ChallengeModeCriteria
{
    public:
        ChallengeModeCriteria(Map* map);

        void SaveToDB();
        void LoadInstanceData();

        bool CheckCriteria() {
            return _criteria[0] >= _maxMinionCount && bossesCompleted();
        }
        void CompleteCriteria(Unit*);

        void UpdateMinionCount(uint32 unit)
        {
            auto count = sObjectMgr->GetMythicMinionValue(_map->GetId(), unit);
            _criteria[0] += count;
        }

        void UpdateBossState(uint32 unit)
        {
            auto boss = _criteria.find(unit);
            if (boss != _criteria.end()) {
                _criteria[unit] = 1;
            }
        }
        
        Map* GetMap() const { return _map; }

        float _maxMinionCount;
        std::unordered_map<uint32, float> _criteria;
        uint32 maxTimer;
        // 0 key is minion count, others are boss id as key
    protected:
        Map* _map;
        std::unordered_map<uint32, float> _minionCountMap;

    private:
        bool bossesCompleted() {
            bool out = true;
            for (auto boss : _criteria) {
                if (boss.first > 0) {
                    out = boss.second == 1 && out;
                    if (!out)
                        return out;
                }
            }
            return out;
        }
};

#endif
