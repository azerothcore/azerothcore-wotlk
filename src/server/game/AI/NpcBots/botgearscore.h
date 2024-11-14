#ifndef BOT_GEARSCORE_H_
#define BOT_GEARSCORE_H_

#include "botcommon.h"

#include <utility>

class Creature;
class Item;

struct ItemTemplate;

float CalculateItemGearScoreRaw(ItemTemplate const* proto);
float CalculateItemGearScore(ItemTemplate const* proto, uint32 botentry = 0, uint8 botlevel = 0, uint8 botclass = 0, uint8 botspec = 0, uint8 slot = BOT_INVENTORY_SIZE);
std::pair<float, float> CalculateBotGearScore(uint32 botentry, uint8 botlevel, uint8 botclass, uint8 botspec, Item const* const items[BOT_INVENTORY_SIZE]);

#endif
