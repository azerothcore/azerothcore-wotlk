#include "mod_learnspells.h"

LearnSpells::LearnSpells() : PlayerScript("LearnSpellsPlayerScript"), WorldScript("LearnSpellsWorldScript") {}

void Addmod_learnspellsScripts()
{
    new LearnSpells();
}
