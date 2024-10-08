#ifndef MOD_LEARNSPELLS
#define MOD_LEARNSPELLS

#include "ScriptMgr.h"

enum SpellType
{
    TYPE_CLASS                  = 0,
    TYPE_TALENTS                = 1,
    TYPE_PROFICIENCIES          = 2,
    TYPE_MOUNTS                 = 3
};

enum SpellColumn
{
    SPELL_ID                    = 0,
    SPELL_REQUIRED_TEAM         = 1,
    SPELL_REQUIRED_RACE         = 2,
    SPELL_REQUIRED_CLASS        = 3,
    SPELL_REQUIRED_LEVEL        = 4,
    SPELL_REQUIRED_SPELL_ID     = 5,
    SPELL_REQUIRES_QUEST        = 6
};

enum Riding
{
    SPELL_APPRENTICE_RIDING     = 33388,
    SPELL_JOURNEYMAN_RIDING     = 33391,
    SPELL_EXPERT_RIDING         = 34090,
    SPELL_ARTISAN_RIDING        = 34091,
    SPELL_COLD_WEATHER_FLYING   = 54197
};

class LearnSpells : public PlayerScript, WorldScript
{
public:
    LearnSpells();

    // PlayerScript
    void OnLevelChanged(Player* /*player*/, uint8 /*oldLevel*/) override;
    void OnLogin(Player* /*player*/) override;
    void OnPlayerLearnTalents(Player* /*player*/, uint32 /*talentId*/, uint32 /*talentRank*/, uint32 /*spellid*/) override;

    // WorldScript
    void OnAfterConfigLoad(bool /*reload*/) override;

private:
    bool EnableGamemasters;
    bool EnableClassSpells;
    bool EnableTalentRanks;
    bool EnableProficiencies;
    bool EnableFromQuests;
    bool EnableApprenticeRiding;
    bool EnableJourneymanRiding;
    bool EnableExpertRiding;
    bool EnableArtisanRiding;
    bool EnableColdWeatherFlying;

    void LearnAllSpells(Player* /*player*/);
    void LearnClassSpells(Player* /*player*/);
    void LearnTalentRanks(Player* /*player*/);
    void LearnProficiencies(Player* /*player*/);
    void LearnMounts(Player* /*player*/);
    void AddTotems(Player* /*player*/);

    std::vector<std::vector<int>> GetSpells(int /*type*/);
};

#endif
