#include "Player.h"

#include "mod_learnspells.h"

void LearnSpells::OnLevelChanged(Player* player, uint8 /*oldLevel*/)
{
    LearnAllSpells(player);
}

void LearnSpells::OnLogin(Player* player)
{
    LearnAllSpells(player);
}

void LearnSpells::OnPlayerLearnTalents(Player* player, uint32 /*talentId*/, uint32 /*talentRank*/, uint32 /*spellid*/)
{
    LearnAllSpells(player);
}

void LearnSpells::LearnAllSpells(Player* player)
{
    if (player->IsGameMaster() && !EnableGamemasters)
    {
        return;
    }

    if (player->getClass() == CLASS_DEATH_KNIGHT && player->GetMapId() == 609)
    {
        return;
    }

    LearnClassSpells(player);
    LearnTalentRanks(player);
    LearnProficiencies(player);
    LearnMounts(player);
    AddTotems(player);
}

void LearnSpells::LearnClassSpells(Player* player)
{
    if (!EnableClassSpells && !EnableFromQuests)
    {
        return;
    }

    std::vector<std::vector<int>> spells = GetSpells(TYPE_CLASS);

    if (spells.empty())
    {
        return;
    }

    for (auto& spell : spells)
    {
        if (spell[SPELL_REQUIRES_QUEST] == 0 && !EnableClassSpells)
        {
            continue;
        }

        if (spell[SPELL_REQUIRES_QUEST] == 1 && !EnableFromQuests)
        {
            continue;
        }

        if (spell[SPELL_REQUIRED_RACE] == -1 || spell[SPELL_REQUIRED_RACE] == player->getRace())
        {
            if (spell[SPELL_REQUIRED_CLASS] == player->getClass())
            {
                if (player->GetLevel() >= spell[SPELL_REQUIRED_LEVEL])
                {
                    if (spell[SPELL_REQUIRED_SPELL_ID] == -1 || player->HasSpell(spell[SPELL_REQUIRED_SPELL_ID]))
                    {
                        if (!player->HasSpell(spell[SPELL_ID]))
                        {
                            player->learnSpell(spell[SPELL_ID]);
                        }
                    }
                }
            }
        }
    }
}

void LearnSpells::LearnTalentRanks(Player* player)
{
    if (!EnableTalentRanks)
    {
        return;
    }

    std::vector<std::vector<int>> spells = GetSpells(TYPE_TALENTS);

    if (spells.empty())
    {
        return;
    }

    for (auto& spell : spells)
    {
        if (spell[SPELL_REQUIRED_CLASS] == player->getClass())
        {
            if (player->GetLevel() >= spell[SPELL_REQUIRED_LEVEL])
            {
                if (player->HasSpell(spell[SPELL_REQUIRED_SPELL_ID]))
                {
                    if (!player->HasSpell(spell[SPELL_ID]))
                    {
                        player->learnSpell(spell[SPELL_ID]);
                    }
                }
            }
        }
    }
}

void LearnSpells::LearnProficiencies(Player* player)
{
    if (!EnableProficiencies)
    {
        return;
    }

    std::vector<std::vector<int>> spells = GetSpells(TYPE_PROFICIENCIES);

    if (spells.empty())
    {
        return;
    }

    for (auto& spell : spells)
    {
        if (spell[SPELL_REQUIRED_CLASS] == player->getClass())
        {
            if (player->GetLevel() >= spell[SPELL_REQUIRED_LEVEL])
            {
                if (!player->HasSpell(spell[SPELL_ID]))
                {
                    player->learnSpell(spell[SPELL_ID]);
                }
            }
        }
    }
}

void LearnSpells::LearnMounts(Player* player)
{
    if (!EnableApprenticeRiding && !EnableJourneymanRiding && !EnableExpertRiding && !EnableArtisanRiding && !EnableColdWeatherFlying)
    {
        return;
    }

    std::vector<std::vector<int>> spells = GetSpells(TYPE_MOUNTS);

    if (spells.empty())
    {
        return;
    }

    for (auto& spell : spells)
    {
        if (((spell[SPELL_ID] == SPELL_APPRENTICE_RIDING || spell[SPELL_REQUIRED_SPELL_ID] == SPELL_APPRENTICE_RIDING) && !EnableApprenticeRiding) ||
            ((spell[SPELL_ID] == SPELL_JOURNEYMAN_RIDING || spell[SPELL_REQUIRED_SPELL_ID] == SPELL_JOURNEYMAN_RIDING) && !EnableJourneymanRiding) ||
            ((spell[SPELL_ID] == SPELL_EXPERT_RIDING || spell[SPELL_REQUIRED_SPELL_ID] == SPELL_EXPERT_RIDING) && !EnableExpertRiding) ||
            ((spell[SPELL_ID] == SPELL_ARTISAN_RIDING || spell[SPELL_REQUIRED_SPELL_ID] == SPELL_ARTISAN_RIDING) && !EnableArtisanRiding) ||
            (spell[SPELL_ID] == SPELL_COLD_WEATHER_FLYING && !EnableColdWeatherFlying) ||
            (spell[SPELL_REQUIRES_QUEST] == 1 && !EnableFromQuests))
        {
            continue;
        }

        if (spell[SPELL_REQUIRED_RACE] == -1 || spell[SPELL_REQUIRED_RACE] == player->getRace())
        {
            if (spell[SPELL_REQUIRED_CLASS] == -1 || spell[SPELL_REQUIRED_CLASS] == player->getClass())
            {
                if (spell[SPELL_REQUIRED_TEAM] == -1 || spell[SPELL_REQUIRED_TEAM] == player->GetTeamId())
                {
                    if (spell[SPELL_REQUIRED_SPELL_ID] == -1 || player->HasSpell(spell[SPELL_REQUIRED_SPELL_ID]))
                    {
                        if (player->GetLevel() >= spell[SPELL_REQUIRED_LEVEL])
                        {
                            if (!player->HasSpell(spell[SPELL_ID]))
                            {
                                player->learnSpell(spell[SPELL_ID]);
                            }
                        }
                    }
                }
            }
        }
    }
}

void LearnSpells::AddTotems(Player* player)
{
    if (player->getClass() != CLASS_SHAMAN)
    {
        return;
    }

    if (!EnableClassSpells || !EnableFromQuests)
    {
        return;
    }

    uint32 totems[4][3] =
    {
        {5175, 2, 4}, // Earth Totem, TotemCategory 2, Level 4
        {5176, 4, 10}, // Fire Totem, TotemCategory 4, Level 10
        {5177, 5, 20}, // Water Totem, TotemCategory 5, Level 20
        {5178, 3, 30} // Air Totem, TotemCategory 3, Level 30
    };

    for (int i = 0; i <= 3; i++)
    {
        if (player->GetLevel() >= totems[i][2])
        {
            if (!player->HasItemTotemCategory(totems[i][1]))
            {
                player->AddItem(totems[i][0], 1);
            }
        }
    }
}
