#ifndef _LOOT_BOX_LOADER_H_
#define _LOOT_BOX_LOADER_H_

void AddLootBoxPlayerScripts();
void AddLootBoxItemScripts();
void AddLootBoxWorldScripts();
void AddLootBoxCommandScripts();

void AddLootBoxScripts()
{
    AddLootBoxWorldScripts();
    AddLootBoxPlayerScripts();
    AddLootBoxItemScripts();
    AddLootBoxCommandScripts();
}

#endif // _LOOT_BOX_LOADER_H_
