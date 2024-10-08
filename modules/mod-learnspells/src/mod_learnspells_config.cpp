#include "Config.h"

#include "mod_learnspells.h"

void LearnSpells::OnAfterConfigLoad(bool /*reload*/)
{
    EnableGamemasters = sConfigMgr->GetOption<bool>("LearnSpells.Gamemasters", 0);
    EnableClassSpells = sConfigMgr->GetOption<bool>("LearnSpells.ClassSpells", 1);
    EnableTalentRanks = sConfigMgr->GetOption<bool>("LearnSpells.TalentRanks", 1);
    EnableProficiencies = sConfigMgr->GetOption<bool>("LearnSpells.Proficiencies", 1);
    EnableFromQuests = sConfigMgr->GetOption<bool>("LearnSpells.SpellsFromQuests", 1);
    EnableApprenticeRiding = sConfigMgr->GetOption<bool>("LearnSpells.Riding.Apprentice", 0);
    EnableJourneymanRiding = sConfigMgr->GetOption<bool>("LearnSpells.Riding.Journeyman", 0);
    EnableExpertRiding = sConfigMgr->GetOption<bool>("LearnSpells.Riding.Expert", 0);
    EnableArtisanRiding = sConfigMgr->GetOption<bool>("LearnSpells.Riding.Artisan", 0);
    EnableColdWeatherFlying = sConfigMgr->GetOption<bool>("LearnSpells.Riding.ColdWeatherFlying", 0);
}
