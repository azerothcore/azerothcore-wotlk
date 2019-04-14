#include "../pchdef.h"
#include "playerbot.h"
#include "PlayerbotFactory.h"
#include "GuildMgr.h"
#include "ItemPrototype.h"
#include "PlayerbotAIConfig.h"
#include "DBCStore.h"
#include "../Miscellaneous/SharedDefines.h"
#include "../Entities/Pet/Pet.h"
#include "RandomPlayerbotFactory.h"
#include "AiFactory.h"
#include "../Entities/Player/Player.h"
#include "strategy/Engine.h"

#include "ObjectMgr.h"

using namespace BotAI;
using namespace std;

uint32 PlayerbotFactory::tradeSkills[] =
{
	SKILL_ALCHEMY,
	SKILL_ENCHANTING,
	SKILL_SKINNING,
	SKILL_JEWELCRAFTING,
	SKILL_INSCRIPTION,
	SKILL_TAILORING,
	SKILL_LEATHERWORKING,
	SKILL_ENGINEERING,
	SKILL_HERBALISM,
	SKILL_MINING,
	SKILL_BLACKSMITHING,
	SKILL_COOKING,
	SKILL_FIRST_AID,
	SKILL_FISHING
};

list<uint32> PlayerbotFactory::classQuestIds;

void PlayerbotFactory::Randomize()
{
	Randomize(true);
}

void PlayerbotFactory::Refresh()
{
	Prepare();
	InitEquipment(true);
	InitAmmo();
	InitFood();
	InitPotions();

	uint32 money = urand(level * 1000, level * 5 * 1000);
	if (bot->GetMoney() < money)
		bot->SetMoney(money);
	bot->SaveToDB(false, true);
}

void PlayerbotFactory::CleanRandomize()
{
	Randomize(false);
}

void PlayerbotFactory::Prepare()
{
	if (!itemQuality)
	{
		if (level <= 10)
			itemQuality = urand(ITEM_QUALITY_NORMAL, ITEM_QUALITY_UNCOMMON);
		else if (level <= 20)
			itemQuality = urand(ITEM_QUALITY_UNCOMMON, ITEM_QUALITY_RARE);
		else if (level <= 40)
			itemQuality = urand(ITEM_QUALITY_UNCOMMON, ITEM_QUALITY_EPIC);
		else if (level < 60)
			itemQuality = urand(ITEM_QUALITY_UNCOMMON, ITEM_QUALITY_EPIC);
		else
			itemQuality = urand(ITEM_QUALITY_RARE, ITEM_QUALITY_EPIC);
	}

	if (bot->isDead())
		bot->ResurrectPlayer(1.0f);

	bot->CombatStop(true);
	bot->GiveLevel(level);

	//thesawolf - refill hp/sp since level resets can leave a vacuum
	bot->SetHealth(bot->GetMaxHealth());
	bot->SetPower(POWER_MANA, bot->GetMaxPower(POWER_MANA));

	if (!sPlayerbotAIConfig.randomBotShowHelmet)
	{
		bot->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_HELM);
		bot->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_CLOAK);
	}
}

void PlayerbotFactory::Randomize(bool incremental)
{
	sLog->outBasic("Preparing to randomize...");
	Prepare();

	sLog->outBasic("Resetting player...");
	bot->resetTalents(true);
	ClearSpells();
	ClearInventory();
	CancelAuras();
	bot->SaveToDB(false, true);

	if (sPlayerbotAIConfig.randomBotInitQuest)
	{
		sLog->outBasic("Initializing quests...");
		InitQuests();
	}
	// quest rewards boost bot level, so reduce back
    bot->SetLevel(level);
	//thesawolf - refill hp/sp since level resets can leave a vacuum
	bot->SetHealth(bot->GetMaxHealth());
	bot->SetPower(POWER_MANA, bot->GetMaxPower(POWER_MANA));
    ClearInventory();
    bot->SetUInt32Value(PLAYER_XP, 0);
    CancelAuras();
    bot->SaveToDB(false, true);

	sLog->outBasic("Initializing skills...");
	InitSkills();
	InitTradeSkills();
	UpdateTradeSkills();

	sLog->outBasic("Initializing talents...");
	InitTalents();

	sLog->outBasic("Initializing spells...");
	InitAvailableSpells();
	// EJ learn quest spells instead
	InitQuestSpells();
	InitSpecialSpells();

	sLog->outBasic("Initializing mounts...");
	InitMounts();

	bot->SaveToDB(false, true);

	sLog->outBasic("Initializing equipment...");
	InitEquipment(incremental);

	sLog->outBasic("Initializing bags...");
	InitBags();

	sLog->outBasic("Initializing ammo...");
	InitAmmo();

	sLog->outBasic("Initializing food...");
	InitFood();

	sLog->outBasic("Initializing potions...");
	InitPotions();

	sLog->outBasic("Initializing second equipment set...");
	InitSecondEquipmentSet();

	sLog->outBasic("Initializing inventory...");
	InitInventory();

	sLog->outBasic("Initializing glyphs...");
	InitGlyphs();

	sLog->outBasic("Initializing guilds...");
	bot->SaveToDB(false, true); //thesawolf - save save save (hopefully avoids dupes)
	InitGuild(); //thesawolf - duplicate guild leaders causing segfault CHECK
	
	sLog->outBasic("Initializing pet...");
	InitPet();

	sLog->outBasic("Saving to DB...");
	bot->SetMoney(urand(level * 1000, level * 5 * 1000));
	bot->SaveToDB(false, true);
}

void PlayerbotFactory::InitPet()
{
	Pet* pet = bot->GetPet();
	if (!pet)
	{
		if (bot->getClass() != CLASS_HUNTER)
			return;

		Map* map = bot->GetMap();
		if (!map)
			return;

		vector<uint32> ids;
		CreatureTemplateContainer const* creatureTemplateContainer = sObjectMgr->GetCreatureTemplates();
		for (CreatureTemplateContainer::const_iterator i = creatureTemplateContainer->begin(); i != creatureTemplateContainer->end(); ++i)
		{
			CreatureTemplate const& co = i->second;
			if (!co.IsTameable(false))
				continue;

			if (co.minlevel > bot->getLevel())
				continue;

			PetLevelInfo const* petInfo = sObjectMgr->GetPetLevelInfo(co.Entry, bot->getLevel());
			if (!petInfo)
				continue;

			ids.push_back(i->first);
		}

		if (ids.empty())
		{
			sLog->outBasic("No pets available for bot %s (%d level)", bot->GetName().c_str(), bot->getLevel());
			return;
		}

		for (int i = 0; i < 100; i++)
		{
			int index = urand(0, ids.size() - 1);
			CreatureTemplate const* co = sObjectMgr->GetCreatureTemplate(ids[index]);

			PetLevelInfo const* petInfo = sObjectMgr->GetPetLevelInfo(co->Entry, bot->getLevel());
			if (!petInfo)
				continue;

			uint32 guid = sObjectMgr->GenerateLowGuid(HIGHGUID_PET);
			pet = new Pet(bot, HUNTER_PET);
			if (!pet->Create(guid, map, 0, ids[index], 0))
			{
				delete pet;
				pet = NULL;
				continue;
			}

			pet->SetPosition(bot->GetPositionX(), bot->GetPositionY(), bot->GetPositionZ(), bot->GetOrientation());
			pet->setFaction(bot->getFaction());
			pet->SetLevel(bot->getLevel());
			bot->SetPetGUID(pet->GetGUID());
			bot->GetMap()->AddToMap(pet->ToCreature());
			bot->SetMinion(pet, true);
			pet->InitTalentForLevel();
			bot->PetSpellInitialize();
			bot->InitTamedPet(pet, bot->getLevel(), 0);

			sLog->outBasic("Bot %s: assign pet %d (%d level)", bot->GetName().c_str(), co->Entry, bot->getLevel());
			pet->SavePetToDB(PET_SAVE_AS_CURRENT, false);
			break;
		}
	}

	if (!pet)
	{
		sLog->outBasic("Cannot create pet for bot %s", bot->GetName().c_str());
		return;
	}

	for (PetSpellMap::const_iterator itr = pet->m_spells.begin(); itr != pet->m_spells.end(); ++itr)
	{
		if (itr->second.state == PETSPELL_REMOVED)
			continue;

		uint32 spellId = itr->first;
		const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(spellId);
		if (spellInfo->IsPassive())
			continue;

		pet->ToggleAutocast(spellInfo, true);
	}
}

void PlayerbotFactory::ClearSpells()
{
	list<uint32> spells;
	for (PlayerSpellMap::iterator itr = bot->GetSpellMap().begin(); itr != bot->GetSpellMap().end(); ++itr)
	{
		uint32 spellId = itr->first;
		const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(spellId);
		if (itr->second->State == PLAYERSPELL_REMOVED || spellInfo->IsPassive())
			continue;

		spells.push_back(spellId);
	}

	for (list<uint32>::iterator i = spells.begin(); i != spells.end(); ++i)
	{
		bot->removeSpell(*i, SPEC_MASK_ALL, false);
	}
}

void PlayerbotFactory::InitSpells()
{
	for (int i = 0; i < 15; i++)
		InitAvailableSpells();
}

void PlayerbotFactory::InitTalents()
{
	uint32 point = urand(0, 100);
	uint8 cls = bot->getClass();
	uint32 p1 = sPlayerbotAIConfig.specProbability[cls][0];
	uint32 p2 = p1 + sPlayerbotAIConfig.specProbability[cls][1];

	uint32 specNo = (point < p1 ? 0 : (point < p2 ? 1 : 2));
	InitTalents(specNo);

	if (bot->GetFreeTalentPoints())
		InitTalents(2 - specNo);
}


class DestroyItemsVisitor : public IterateItemsVisitor
{
public:
	DestroyItemsVisitor(Player* bot) : IterateItemsVisitor(), bot(bot) {}

	virtual bool Visit(Item* item)
	{
		uint32 id = item->GetTemplate()->ItemId;
		if (CanKeep(id))
		{
			keep.insert(id);
			return true;
		}

		bot->DestroyItem(item->GetBagSlot(), item->GetSlot(), true);
		return true;
	}

private:
	bool CanKeep(uint32 id)
	{
		if (keep.find(id) != keep.end())
			return false;

		if (sPlayerbotAIConfig.IsInRandomQuestItemList(id))
			return true;


		ItemTemplate const* proto = sObjectMgr->GetItemTemplate(id);
		if (proto->Class == ITEM_CLASS_MISC && (proto->SubClass == ITEM_SUBCLASS_JUNK_REAGENT || proto->SubClass == ITEM_SUBCLASS_JUNK))
			return true;

		return false;
	}

private:
	Player* bot;
	set<uint32> keep;

};

bool PlayerbotFactory::CanEquipArmor(ItemTemplate const* proto)
{
	if (bot->HasSkill(SKILL_SHIELD) && proto->SubClass == ITEM_SUBCLASS_ARMOR_SHIELD)
		return true;

	if (bot->HasSkill(SKILL_PLATE_MAIL))
	{
		if (proto->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
			return false;
	}
	else if (bot->HasSkill(SKILL_MAIL))
	{
		if (proto->SubClass != ITEM_SUBCLASS_ARMOR_MAIL)
			return false;
	}
	else if (bot->HasSkill(SKILL_LEATHER))
	{
		if (proto->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER)
			return false;
	}

	if (proto->Quality <= ITEM_QUALITY_NORMAL)
		return true;
	//Lidocain//
	//sph - spellpower healer,
	//spd - spellpower dps,
	//apa - attackpower based on agility, 
	//aps - attackpower based on strenght,
	//apr - attackpower based on ranged (agility),
	//tank - tank
	uint8 sp = 0, ap = 0, tank = 0;
	for (int j = 0; j < MAX_ITEM_PROTO_STATS; ++j)
	{
		// for ItemStatValue != 0
		if (!proto->ItemStat[j].ItemStatValue)
			continue;

		AddItemStats(proto->ItemStat[j].ItemStatType, sp, ap, tank);
	}

	return CheckItemStats(sp, ap, tank);
}


bool PlayerbotFactory::CheckItemStats(uint8 sp, uint8 ap, uint8 tank)
{
	switch (bot->getClass())
	{
	case CLASS_PRIEST:
	case CLASS_MAGE:
	case CLASS_WARLOCK:
		if (!sp || ap > sp || tank > sp)
			return false;
		break;
	case CLASS_PALADIN:
	case CLASS_WARRIOR:
	case CLASS_DEATH_KNIGHT:
		if ((!ap && !tank) || sp > ap || sp > tank)
			return false;
		break;
	case CLASS_HUNTER:
	case CLASS_ROGUE:
		if (!ap || sp > ap || sp > tank)
			return false;
		break;
	}

	return sp || ap || tank;
}

void PlayerbotFactory::AddItemStats(uint32 mod, uint8 &sp, uint8 &ap, uint8 &tank)
{
	switch (mod)
	{
	case ITEM_MOD_HIT_RATING:
	case ITEM_MOD_CRIT_RATING:
	case ITEM_MOD_HASTE_RATING:
	case ITEM_MOD_HEALTH:
	case ITEM_MOD_STAMINA:
	case ITEM_MOD_HEALTH_REGEN:
	case ITEM_MOD_MANA:
	case ITEM_MOD_INTELLECT:
	case ITEM_MOD_SPIRIT:
	case ITEM_MOD_MANA_REGENERATION:
	case ITEM_MOD_SPELL_POWER:
	case ITEM_MOD_SPELL_PENETRATION:
	case ITEM_MOD_HIT_SPELL_RATING:
	case ITEM_MOD_CRIT_SPELL_RATING:
	case ITEM_MOD_HASTE_SPELL_RATING:
		sp++;
		break;
	}

	switch (mod)
	{
	case ITEM_MOD_HIT_RATING:
	case ITEM_MOD_CRIT_RATING:
	case ITEM_MOD_HASTE_RATING:
	case ITEM_MOD_AGILITY:
	case ITEM_MOD_STRENGTH:
	case ITEM_MOD_HEALTH:
	case ITEM_MOD_STAMINA:
	case ITEM_MOD_HEALTH_REGEN:
	case ITEM_MOD_DEFENSE_SKILL_RATING:
	case ITEM_MOD_DODGE_RATING:
	case ITEM_MOD_PARRY_RATING:
	case ITEM_MOD_BLOCK_RATING:
	case ITEM_MOD_HIT_TAKEN_MELEE_RATING:
	case ITEM_MOD_HIT_TAKEN_RANGED_RATING:
	case ITEM_MOD_HIT_TAKEN_SPELL_RATING:
	case ITEM_MOD_CRIT_TAKEN_MELEE_RATING:
	case ITEM_MOD_CRIT_TAKEN_RANGED_RATING:
	case ITEM_MOD_CRIT_TAKEN_SPELL_RATING:
	case ITEM_MOD_HIT_TAKEN_RATING:
	case ITEM_MOD_CRIT_TAKEN_RATING:
	case ITEM_MOD_RESILIENCE_RATING:
	case ITEM_MOD_BLOCK_VALUE:
		tank++;
		break;
	}

	switch (mod)
	{
	case ITEM_MOD_HEALTH:
	case ITEM_MOD_STAMINA:
	case ITEM_MOD_HEALTH_REGEN:
	case ITEM_MOD_AGILITY:
	case ITEM_MOD_STRENGTH:
	case ITEM_MOD_HIT_MELEE_RATING:
	case ITEM_MOD_HIT_RANGED_RATING:
	case ITEM_MOD_CRIT_MELEE_RATING:
	case ITEM_MOD_CRIT_RANGED_RATING:
	case ITEM_MOD_HASTE_MELEE_RATING:
	case ITEM_MOD_HASTE_RANGED_RATING:
	case ITEM_MOD_HIT_RATING:
	case ITEM_MOD_CRIT_RATING:
	case ITEM_MOD_HASTE_RATING:
	case ITEM_MOD_EXPERTISE_RATING:
	case ITEM_MOD_ATTACK_POWER:
	case ITEM_MOD_RANGED_ATTACK_POWER:
	case ITEM_MOD_ARMOR_PENETRATION_RATING:
		ap++;
		break;
	}
}


bool PlayerbotFactory::CanEquipWeapon(ItemTemplate const* proto)
{
	switch (bot->getClass())
	{
	case CLASS_PRIEST:
		if (proto->SubClass != ITEM_SUBCLASS_WEAPON_STAFF &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_WAND &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE)
			return false;
		break;
	case CLASS_MAGE:
	case CLASS_WARLOCK:
		if (proto->SubClass != ITEM_SUBCLASS_WEAPON_STAFF &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_WAND &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_DAGGER &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_SWORD)
			return false;
		break;
	case CLASS_WARRIOR:
		if (proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_AXE &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_POLEARM &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_SWORD2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_SWORD &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_GUN &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_CROSSBOW &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_BOW &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_THROWN)
			return false;
		break;
	case CLASS_PALADIN:
		if (proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_SWORD2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_AXE2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_SWORD)
			return false;
		break;
	case CLASS_DEATH_KNIGHT:
		if (proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_POLEARM &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_SWORD2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_AXE2)
			return false;
		break;
	case CLASS_SHAMAN:
		if (proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_AXE &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_FIST &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_AXE2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_DAGGER &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_FIST &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_STAFF)
			return false;
		break;
	case CLASS_DRUID:
		if (proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_DAGGER &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_STAFF)
			return false;
		break;
	case CLASS_HUNTER:
		if (proto->SubClass != ITEM_SUBCLASS_WEAPON_AXE2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_AXE &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_SWORD2 &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_POLEARM &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_FIST &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_GUN &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_CROSSBOW &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_STAFF &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_BOW)
			return false;
		break;
	case CLASS_ROGUE:
		if (proto->SubClass != ITEM_SUBCLASS_WEAPON_DAGGER &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_SWORD &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_FIST &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_GUN &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_CROSSBOW &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_BOW &&
			proto->SubClass != ITEM_SUBCLASS_WEAPON_THROWN)
			return false;
		break;
	}

	return true;
}

bool PlayerbotFactory::CanEquipItem(ItemTemplate const* proto, uint32 desiredQuality)
{
	if (proto->Duration & 0x80000000)
		return false;

	if (proto->Quality != desiredQuality)
		return false;

	if (proto->Bonding == BIND_QUEST_ITEM || proto->Bonding == BIND_WHEN_USE)
		return false;

	if (proto->Class == ITEM_CLASS_CONTAINER)
		return true;

	uint32 requiredLevel = proto->RequiredLevel;
	if (!requiredLevel)
		return false;

	uint32 level = bot->getLevel();
	uint32 delta = 2;
	if (level < 15)
		delta = urand(7, 15);
	else if (proto->Class == ITEM_CLASS_WEAPON || proto->SubClass == ITEM_SUBCLASS_ARMOR_SHIELD)
		delta = urand(2, 3);
	else if (!(level % 10) || (level % 10) == 9)
		delta = 2;
	else if (level < 40)
		delta = urand(5, 10);
	else if (level < 60)
		delta = urand(3, 7);
	else if (level < 70)
		delta = urand(2, 5);
	else if (level < 80)
		delta = urand(2, 4);

	if (desiredQuality > ITEM_QUALITY_NORMAL &&
		(requiredLevel > level || requiredLevel < level - delta))
		return false;

	for (uint32 gap = 60; gap <= 80; gap += 10)
	{
		if (level > gap && requiredLevel <= gap)
			return false;
	}

	return true;
}

void PlayerbotFactory::InitEquipment(bool incremental)
{
	//thesawolf - lets stick the gearlock check here
	QueryResult gresults = CharacterDatabase.PQuery("SELECT * FROM ai_playerbot_locks WHERE name_id = '%u'", bot->GetGUID());
	if (gresults)
		return;

	DestroyItemsVisitor visitor(bot);
	IterateItems(&visitor, ITERATE_ALL_ITEMS);

	map<uint8, vector<uint32> > items;
	for (uint8 slot = 0; slot < EQUIPMENT_SLOT_END; ++slot)
	{
		if (slot == EQUIPMENT_SLOT_TABARD || slot == EQUIPMENT_SLOT_BODY)
			continue;

		uint32 desiredQuality = itemQuality;
		if (urand(0, 100) < 100 * sPlayerbotAIConfig.randomGearLoweringChance && desiredQuality > ITEM_QUALITY_NORMAL) {
			desiredQuality--;
		}

		do
		{
			ItemTemplateContainer const* itemTemplates = sObjectMgr->GetItemTemplateStore();
			for (ItemTemplateContainer::const_iterator i = itemTemplates->begin(); i != itemTemplates->end(); ++i)
			{
				uint32 itemId = i->first;
				ItemTemplate const* proto = &i->second;
				if (!proto)
					continue;

				if (proto->Class != ITEM_CLASS_WEAPON &&
					proto->Class != ITEM_CLASS_ARMOR &&
					proto->Class != ITEM_CLASS_CONTAINER &&
					proto->Class != ITEM_CLASS_PROJECTILE)
					continue;

				if (!CanEquipItem(proto, desiredQuality))
					continue;

				if (proto->Class == ITEM_CLASS_ARMOR && (
					slot == EQUIPMENT_SLOT_HEAD ||
					slot == EQUIPMENT_SLOT_SHOULDERS ||
					slot == EQUIPMENT_SLOT_CHEST ||
					slot == EQUIPMENT_SLOT_WAIST ||
					slot == EQUIPMENT_SLOT_LEGS ||
					slot == EQUIPMENT_SLOT_FEET ||
					slot == EQUIPMENT_SLOT_WRISTS ||
					slot == EQUIPMENT_SLOT_HANDS) && !CanEquipArmor(proto))
					continue;

				if (proto->Class == ITEM_CLASS_WEAPON && !CanEquipWeapon(proto))
					continue;

				if (slot == EQUIPMENT_SLOT_OFFHAND && bot->getClass() == CLASS_ROGUE && proto->Class != ITEM_CLASS_WEAPON)
					continue;

				uint16 dest = 0;
				if (CanEquipUnseenItem(slot, dest, itemId))
					items[slot].push_back(itemId);
			}
		} while (items[slot].empty() && desiredQuality-- > ITEM_QUALITY_NORMAL);
	}

	for (uint8 slot = 0; slot < EQUIPMENT_SLOT_END; ++slot)
	{
		if (slot == EQUIPMENT_SLOT_TABARD || slot == EQUIPMENT_SLOT_BODY)
			continue;

		vector<uint32>& ids = items[slot];
		if (ids.empty())
		{
			sLog->outError("%s: no items to equip for slot %d", bot->GetName().c_str(), slot);
			continue;
		}

		for (int attempts = 0; attempts < 15; attempts++)
		{
			uint32 index = urand(0, ids.size() - 1);
			uint32 newItemId = ids[index];
			Item* oldItem = bot->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);

			if (incremental && !IsDesiredReplacement(oldItem)) {
				continue;
			}

			uint16 dest;
			if (!CanEquipUnseenItem(slot, dest, newItemId))
				continue;

			if (oldItem)
			{
				bot->RemoveItem(INVENTORY_SLOT_BAG_0, slot, true);
				oldItem->DestroyForPlayer(bot, false);
			}

			Item* newItem = bot->EquipNewItem(dest, newItemId, true);
			if (newItem)
			{
				newItem->AddToWorld();
				newItem->AddToUpdateQueueOf(bot);
				bot->AutoUnequipOffhandIfNeed();
				EnchantItem(newItem);
				break;
			}
		}
	}
}

bool PlayerbotFactory::IsDesiredReplacement(Item* item)
{
	if (!item)
		return true;

	ItemTemplate const* proto = item->GetTemplate();
	int delta = 1 + (80 - bot->getLevel()) / 10;
	return (int)bot->getLevel() - (int)proto->RequiredLevel > delta;
}

void PlayerbotFactory::InitSecondEquipmentSet()
{
	if (bot->getClass() == CLASS_MAGE || bot->getClass() == CLASS_WARLOCK || bot->getClass() == CLASS_PRIEST)
		return;

	map<uint32, vector<uint32> > items;

	uint32 desiredQuality = itemQuality;
	while (urand(0, 100) < 100 * sPlayerbotAIConfig.randomGearLoweringChance && desiredQuality > ITEM_QUALITY_NORMAL) {
		desiredQuality--;
	}

	do
	{
		ItemTemplateContainer const* itemTemplates = sObjectMgr->GetItemTemplateStore();
		for (ItemTemplateContainer::const_iterator i = itemTemplates->begin(); i != itemTemplates->end(); ++i)
		{
			uint32 itemId = i->first;
			ItemTemplate const* proto = &i->second;
			if (!proto)
				continue;

			if (!CanEquipItem(proto, desiredQuality))
				continue;

			if (proto->Class == ITEM_CLASS_WEAPON)
			{
				if (!CanEquipWeapon(proto))
					continue;

				Item* existingItem = bot->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
				if (existingItem)
				{
					switch (existingItem->GetTemplate()->SubClass)
					{
					case ITEM_SUBCLASS_WEAPON_AXE:
					case ITEM_SUBCLASS_WEAPON_DAGGER:
					case ITEM_SUBCLASS_WEAPON_FIST:
					case ITEM_SUBCLASS_WEAPON_MACE:
					case ITEM_SUBCLASS_WEAPON_SWORD:
						if (proto->SubClass == ITEM_SUBCLASS_WEAPON_AXE || proto->SubClass == ITEM_SUBCLASS_WEAPON_DAGGER ||
							proto->SubClass == ITEM_SUBCLASS_WEAPON_FIST || proto->SubClass == ITEM_SUBCLASS_WEAPON_MACE ||
							proto->SubClass == ITEM_SUBCLASS_WEAPON_SWORD)
							continue;
						break;
					default:
						if (proto->SubClass != ITEM_SUBCLASS_WEAPON_AXE && proto->SubClass != ITEM_SUBCLASS_WEAPON_DAGGER &&
							proto->SubClass != ITEM_SUBCLASS_WEAPON_FIST && proto->SubClass != ITEM_SUBCLASS_WEAPON_MACE &&
							proto->SubClass != ITEM_SUBCLASS_WEAPON_SWORD)
							continue;
						break;
					}
				}
			}
			else if (proto->Class == ITEM_CLASS_ARMOR && proto->SubClass == ITEM_SUBCLASS_ARMOR_SHIELD)
			{
				if (!CanEquipArmor(proto))
					continue;

				Item* existingItem = bot->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
				if (existingItem && existingItem->GetTemplate()->SubClass == ITEM_SUBCLASS_ARMOR_SHIELD)
					continue;
			}
			else
				continue;

			items[proto->Class].push_back(itemId);
		}
	} while (items[ITEM_CLASS_ARMOR].empty() && items[ITEM_CLASS_WEAPON].empty() && desiredQuality-- > ITEM_QUALITY_NORMAL);

	for (map<uint32, vector<uint32> >::iterator i = items.begin(); i != items.end(); ++i)
	{
		vector<uint32>& ids = i->second;
		if (ids.empty())
		{
			sLog->outBasic("%s: no items to make second equipment set for slot %d", bot->GetName().c_str(), i->first);
			continue;
		}

		for (int attempts = 0; attempts < 15; attempts++)
		{
			uint32 index = urand(0, ids.size() - 1);
			uint32 newItemId = ids[index];

			ItemPosCountVec sDest;
			Item* newItem = StoreItem(newItemId, 1);
			if (newItem)
			{
				EnchantItem(newItem);
				newItem->AddToWorld();
				newItem->AddToUpdateQueueOf(bot);
				break;
			}
		}
	}
}

void PlayerbotFactory::InitBags()
{
	vector<uint32> ids;

	ItemTemplateContainer const* itemTemplates = sObjectMgr->GetItemTemplateStore();
	for (ItemTemplateContainer::const_iterator i = itemTemplates->begin(); i != itemTemplates->end(); ++i)
	{
		uint32 itemId = i->first;
		ItemTemplate const* proto = &i->second;
		if (!proto || proto->Class != ITEM_CLASS_CONTAINER)
			continue;

		if (!CanEquipItem(proto, ITEM_QUALITY_NORMAL))
			continue;

		ids.push_back(itemId);
	}

	if (ids.empty())
	{
		sLog->outError("%s: no bags found", bot->GetName().c_str());
		return;
	}

	for (uint8 slot = INVENTORY_SLOT_BAG_START; slot < INVENTORY_SLOT_BAG_END; ++slot)
	{
		for (int attempts = 0; attempts < 15; attempts++)
		{
			uint32 index = urand(0, ids.size() - 1);
			uint32 newItemId = ids[index];

			uint16 dest;
			if (!CanEquipUnseenItem(slot, dest, newItemId))
				continue;

			Item* newItem = bot->EquipNewItem(dest, newItemId, true);
			if (newItem)
			{
				newItem->AddToWorld();
				newItem->AddToUpdateQueueOf(bot);
				break;
			}
		}
	}
}

void PlayerbotFactory::EnchantItem(Item* item)
{
	if (urand(0, 100) < 100 * sPlayerbotAIConfig.randomGearLoweringChance)
		return;

	if (bot->getLevel() < urand(40, 50))
		return;

	ItemTemplate const* proto = item->GetTemplate();
	int32 itemLevel = proto->ItemLevel;

	vector<uint32> ids;
	for (int id = 0; id < sSpellStore.GetNumRows(); ++id)
	{
		SpellInfo const *entry = sSpellMgr->GetSpellInfo(id);
		if (!entry)
			continue;

		int32 requiredLevel = (int32)entry->BaseLevel;
		if (requiredLevel && (requiredLevel > itemLevel || requiredLevel < itemLevel - 35))
			continue;

		if (entry->MaxLevel && level > entry->MaxLevel)
			continue;

		uint32 spellLevel = entry->SpellLevel;
		if (spellLevel && (spellLevel > level || spellLevel < level - 10))
			continue;

		for (int j = 0; j < 3; ++j)
		{
			if (entry->Effects[j].Effect != SPELL_EFFECT_ENCHANT_ITEM)
				continue;

			uint32 enchant_id = entry->Effects[j].MiscValue;
			if (!enchant_id)
				continue;

			SpellItemEnchantmentEntry const* enchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
			if (!enchant || enchant->slot != PERM_ENCHANTMENT_SLOT)
				continue;

			if (enchant->requiredLevel && enchant->requiredLevel > level)
				continue;

			uint8 sp = 0, ap = 0, tank = 0;
			for (int i = 0; i < 3; ++i)
			{
				if (enchant->type[i] != ITEM_ENCHANTMENT_TYPE_STAT)
					continue;

				AddItemStats(enchant->spellid[i], sp, ap, tank);
			}

			if (!CheckItemStats(sp, ap, tank))
				continue;

			if (enchant->EnchantmentCondition && !bot->EnchantmentFitsRequirements(enchant->EnchantmentCondition, -1))
				continue;

			if (!item->IsFitToSpellRequirements(entry))
				continue;

			ids.push_back(enchant_id);
		}
	}

	if (ids.empty())
	{
		sLog->outBasic("%s: no enchantments found for item %d", bot->GetName().c_str(), item->GetTemplate()->ItemId);
		return;
	}

	int index = urand(0, ids.size() - 1);
	uint32 id = ids[index];

	SpellItemEnchantmentEntry const* enchant = sSpellItemEnchantmentStore.LookupEntry(id);
	if (!enchant)
		return;

	bot->ApplyEnchantment(item, PERM_ENCHANTMENT_SLOT, false);
	item->SetEnchantment(PERM_ENCHANTMENT_SLOT, id, 0, 0);
	bot->ApplyEnchantment(item, PERM_ENCHANTMENT_SLOT, true);
}

bool PlayerbotFactory::CanEquipUnseenItem(uint8 slot, uint16 &dest, uint32 item)
{
	dest = 0;
	Item *pItem = Item::CreateItem(item, 1, bot);
	if (pItem)
	{
		InventoryResult result = bot->CanEquipItem(slot, dest, pItem, true);
		pItem->RemoveFromUpdateQueueOf(bot);
		delete pItem;
		return result == EQUIP_ERR_OK;
	}

	return false;
}

void PlayerbotFactory::InitTradeSkills()
{
	for (int i = 0; i < sizeof(tradeSkills) / sizeof(uint32); ++i)
	{
		bot->SetSkill(tradeSkills[i], 0, 0, 0);
	}

	vector<uint32> firstSkills;
	vector<uint32> secondSkills;
	switch (bot->getClass())
	{
	case CLASS_WARRIOR:
	case CLASS_DEATH_KNIGHT:
	case CLASS_PALADIN:
		firstSkills.push_back(SKILL_MINING);
		secondSkills.push_back(SKILL_BLACKSMITHING);
		secondSkills.push_back(SKILL_ENGINEERING);
		break;
	case CLASS_SHAMAN:
	case CLASS_DRUID:
	case CLASS_HUNTER:
	case CLASS_ROGUE:
		firstSkills.push_back(SKILL_SKINNING);
		secondSkills.push_back(SKILL_LEATHERWORKING);
		break;
	default:
		firstSkills.push_back(SKILL_TAILORING);
		secondSkills.push_back(SKILL_ENCHANTING);
	}

	SetRandomSkill(SKILL_FIRST_AID);
	SetRandomSkill(SKILL_FISHING);
	SetRandomSkill(SKILL_COOKING);

	switch (urand(0, 3))
	{
	case 0:
		SetRandomSkill(SKILL_HERBALISM);
		SetRandomSkill(SKILL_ALCHEMY);
		break;
	case 1:
		SetRandomSkill(SKILL_HERBALISM);
		SetRandomSkill(SKILL_INSCRIPTION);
		break;
	case 2:
		SetRandomSkill(SKILL_MINING);
		SetRandomSkill(SKILL_JEWELCRAFTING);
		break;
	case 3:
		SetRandomSkill(firstSkills[urand(0, firstSkills.size() - 1)]);
		SetRandomSkill(secondSkills[urand(0, secondSkills.size() - 1)]);
		break;
	}
}

void PlayerbotFactory::UpdateTradeSkills()
{
	for (int i = 0; i < sizeof(tradeSkills) / sizeof(uint32); ++i)
	{
		if (bot->GetSkillValue(tradeSkills[i]) == 1)
			bot->SetSkill(tradeSkills[i], 0, 0, 0);
	}
}

void PlayerbotFactory::InitSkills()
{
	uint32 maxValue = level * 5;
	SetRandomSkill(SKILL_DEFENSE);

	if (bot->getLevel() >= 70)
		bot->SetSkill(SKILL_RIDING, 0, 300, 300);
	else if (bot->getLevel() >= 60)
		bot->SetSkill(SKILL_RIDING, 0, 225, 225);
	else if (bot->getLevel() >= 40)
		bot->SetSkill(SKILL_RIDING, 0, 150, 150);
	else if (bot->getLevel() >= 20)
		bot->SetSkill(SKILL_RIDING, 0, 75, 75);
	else
		bot->SetSkill(SKILL_RIDING, 0, 0, 0);

	uint32 skillLevel = bot->getLevel() < 40 ? 0 : 1;
	switch (bot->getClass())
	{
	case CLASS_DEATH_KNIGHT:
		SetRandomSkill(SKILL_SWORDS);
		SetRandomSkill(SKILL_AXES);
		SetRandomSkill(SKILL_MACES);
		SetRandomSkill(SKILL_2H_SWORDS);
		SetRandomSkill(SKILL_2H_MACES);
		SetRandomSkill(SKILL_2H_AXES);
		SetRandomSkill(SKILL_POLEARMS);
		break;
	case CLASS_DRUID:
		SetRandomSkill(SKILL_MACES);
		SetRandomSkill(SKILL_STAVES);
		SetRandomSkill(SKILL_2H_MACES);
		SetRandomSkill(SKILL_DAGGERS);
		SetRandomSkill(SKILL_POLEARMS);
		SetRandomSkill(SKILL_FIST_WEAPONS);
		break;
	case CLASS_WARRIOR:
		SetRandomSkill(SKILL_SWORDS);
		SetRandomSkill(SKILL_AXES);
		SetRandomSkill(SKILL_BOWS);
		SetRandomSkill(SKILL_GUNS);
		SetRandomSkill(SKILL_MACES);
		SetRandomSkill(SKILL_2H_SWORDS);
		SetRandomSkill(SKILL_STAVES);
		SetRandomSkill(SKILL_2H_MACES);
		SetRandomSkill(SKILL_2H_AXES);
		SetRandomSkill(SKILL_DAGGERS);
		SetRandomSkill(SKILL_CROSSBOWS);
		SetRandomSkill(SKILL_POLEARMS);
		SetRandomSkill(SKILL_FIST_WEAPONS);
		SetRandomSkill(SKILL_THROWN);
		break;
	case CLASS_PALADIN:
		bot->SetSkill(SKILL_PLATE_MAIL, 0, skillLevel, skillLevel);
		SetRandomSkill(SKILL_SWORDS);
		SetRandomSkill(SKILL_AXES);
		SetRandomSkill(SKILL_MACES);
		SetRandomSkill(SKILL_2H_SWORDS);
		SetRandomSkill(SKILL_2H_MACES);
		SetRandomSkill(SKILL_2H_AXES);
		SetRandomSkill(SKILL_POLEARMS);
		break;
	case CLASS_PRIEST:
		SetRandomSkill(SKILL_MACES);
		SetRandomSkill(SKILL_STAVES);
		SetRandomSkill(SKILL_DAGGERS);
		SetRandomSkill(SKILL_WANDS);
		break;
	case CLASS_SHAMAN:
		SetRandomSkill(SKILL_AXES);
		SetRandomSkill(SKILL_MACES);
		SetRandomSkill(SKILL_STAVES);
		SetRandomSkill(SKILL_2H_MACES);
		SetRandomSkill(SKILL_2H_AXES);
		SetRandomSkill(SKILL_DAGGERS);
		SetRandomSkill(SKILL_FIST_WEAPONS);
		break;
	case CLASS_MAGE:
		SetRandomSkill(SKILL_SWORDS);
		SetRandomSkill(SKILL_STAVES);
		SetRandomSkill(SKILL_DAGGERS);
		SetRandomSkill(SKILL_WANDS);
		break;
	case CLASS_WARLOCK:
		SetRandomSkill(SKILL_SWORDS);
		SetRandomSkill(SKILL_STAVES);
		SetRandomSkill(SKILL_DAGGERS);
		SetRandomSkill(SKILL_WANDS);
		break;
	case CLASS_HUNTER:
		SetRandomSkill(SKILL_SWORDS);
		SetRandomSkill(SKILL_AXES);
		SetRandomSkill(SKILL_BOWS);
		SetRandomSkill(SKILL_GUNS);
		SetRandomSkill(SKILL_2H_SWORDS);
		SetRandomSkill(SKILL_STAVES);
		SetRandomSkill(SKILL_2H_AXES);
		SetRandomSkill(SKILL_DAGGERS);
		SetRandomSkill(SKILL_CROSSBOWS);
		SetRandomSkill(SKILL_POLEARMS);
		SetRandomSkill(SKILL_FIST_WEAPONS);
		SetRandomSkill(SKILL_THROWN);
		bot->SetSkill(SKILL_MAIL, 0, skillLevel, skillLevel);
		break;
	case CLASS_ROGUE:
		SetRandomSkill(SKILL_SWORDS);
		SetRandomSkill(SKILL_AXES);
		SetRandomSkill(SKILL_BOWS);
		SetRandomSkill(SKILL_GUNS);
		SetRandomSkill(SKILL_MACES);
		SetRandomSkill(SKILL_DAGGERS);
		SetRandomSkill(SKILL_CROSSBOWS);
		SetRandomSkill(SKILL_FIST_WEAPONS);
		SetRandomSkill(SKILL_THROWN);
	}
}

void PlayerbotFactory::SetRandomSkill(uint16 id)
{
	uint32 maxValue = level * 5;
	uint32 curValue = urand(maxValue - level, maxValue);
	bot->SetSkill(id, 0, curValue, maxValue);

}

void PlayerbotFactory::InitAvailableSpells()
{
	bot->learnDefaultSpells();
	CreatureTemplateContainer const* creatureTemplateContainer = sObjectMgr->GetCreatureTemplates();
	for (CreatureTemplateContainer::const_iterator i = creatureTemplateContainer->begin(); i != creatureTemplateContainer->end(); ++i)
	{
		CreatureTemplate const& co = i->second;
		if (co.trainer_type != TRAINER_TYPE_TRADESKILLS && co.trainer_type != TRAINER_TYPE_CLASS)
			continue;

		if (co.trainer_type == TRAINER_TYPE_CLASS && co.trainer_class != bot->getClass())
			continue;

		uint32 trainerId = co.Entry;

		TrainerSpellData const* trainer_spells = sObjectMgr->GetNpcTrainerSpells(trainerId);

		if (!trainer_spells)
			continue;

		for (TrainerSpellMap::const_iterator itr = trainer_spells->spellList.begin(); itr != trainer_spells->spellList.end(); ++itr)
		{
			TrainerSpell const* tSpell = &itr->second;

			if (!tSpell)
				continue;

			if (!tSpell->learnedSpell[0] && !bot->IsSpellFitByClassAndRace(tSpell->learnedSpell[0]))
				continue;

			TrainerSpellState state = bot->GetTrainerSpellState(tSpell);
			if (state != TRAINER_SPELL_GREEN)
				continue;

			if (tSpell->learnedSpell)
				bot->learnSpell(tSpell->learnedSpell[0]);
			else
				ai->CastSpell(tSpell->spell, bot);
		}
	}
}

// EJ init quest spells
void PlayerbotFactory::InitQuestSpells()
{
	std::unordered_map<uint32, Quest*> allClassSpellQuestTemplates = sObjectMgr->GetClassSpellQuestTemplates();
	for (std::unordered_map<uint32, Quest*>::iterator i = allClassSpellQuestTemplates.begin(); i != allClassSpellQuestTemplates.end(); ++i)
	{
		if (i->second->GetRequiredClasses() & bot->getClassMask())
		{
			bot->learnQuestRewardedSpells(i->second);
		}
	}
}

void PlayerbotFactory::InitSpecialSpells()
{
	for (list<uint32>::iterator i = sPlayerbotAIConfig.randomBotSpellIds.begin(); i != sPlayerbotAIConfig.randomBotSpellIds.end(); ++i)
	{
		uint32 spellId = *i;
		bot->learnSpell(spellId);
	}
	uint8 tab = AiFactory::GetPlayerSpecTab(bot); //Made by Dronkie & Lidocain
	switch (bot->getClass())

	{
	case CLASS_WARRIOR:


		if (bot->getLevel() > 9)
		{
			//Defensive stance and sunder armor
			bot->learnSpell(71);
			bot->learnSpell(7386);
		}
		else if (bot->getLevel() > 29)
		{
			//Berserker stance and Intercept
			bot->learnSpell(2458);
			bot->learnSpell(20252);
		}
		//tab=0=arms					//level		
		else if ((tab == 0) && (bot->getLevel() > 39))
		{
			//Mortal Strike, Whirlwind
			bot->learnSpell(9347);
			bot->learnSpell(1680);
		}
		//tab=1=fury			//level

		else if ((tab == 1) && bot->getLevel() > 39)
		{
			//Bloodthirst, Whirlwind
			bot->learnSpell(13078);
			bot->learnSpell(1680);
		}
		//tab=2=prot			//level

		else if ((tab == 2) && (bot->getLevel() > 13))
		{
			bot->learnSpell(6572); //Revenge
		}
		else

		{
			bot->learnSpell(25710); //Heroic Strike
		}
		break;

	case CLASS_DRUID:

		if 					//level
			(bot->getLevel() > 9)
		{
			//Bear form, Growl and Maul
			bot->learnSpell(5487);
			bot->learnSpell(6795);
			bot->learnSpell(6807);
		}
		else if (bot->getLevel() > 15)
		{
			bot->learnSpell(1066); //Aquatic form	
		}
		else if (bot->getLevel() > 19)
		{
			bot->learnSpell(768); //Cat form
		}
		else if (bot->getLevel() > 29)
		{
			bot->learnSpell(783); //Travel Form
		}
		else if (bot->getLevel() > 39)
		{
			//Moonkin form and Dire Bear form
			bot->learnSpell(24858);
			bot->learnSpell(9634);
		}
		//tab=1=feral			//level 

		else if ((tab == 1) && (bot->getLevel() > 15))
		{
			bot->learnSpell(1066); //Aquatic form	
		}
		else if ((tab == 1) && (bot->getLevel() > 19))
		{
			bot->learnSpell(768); //Cat form
		}
		else if ((tab == 1) && (bot->getLevel() > 29))
		{
			bot->learnSpell(783); //Travel Form
		}
		else if ((tab == 1) && (bot->getLevel() > 39))
		{
			//Leader of the Pack and Dire Bear Form
			bot->learnSpell(17007);
			bot->learnSpell(9634);
		}
		//tab=2=resto			//level 

		else if ((tab == 2) && (bot->getLevel() > 29))
		{
			//Travel Form and Nature's Swiftness
			bot->learnSpell(783);
			bot->learnSpell(17116);
		}
		else if ((tab == 2) && (bot->getLevel() > 39))
		{
			//Dire Bear Form and Swiftmend
			bot->learnSpell(9634);
			bot->learnSpell(18562);
		}
		else
		{
			bot->learnSpell(5176); //Wrath
		}

		break;

	case CLASS_MAGE:

		if //tab=0=arcane					//level					
			((tab == 0) && (bot->getLevel() > 29))
		{
			bot->learnSpell(12043); //Presence of Mind
		}
		else if ((tab == 0) && (bot->getLevel() > 39))
		{
			bot->learnSpell(12042); //Arcane Power
		}

		else if //tab=1=fire			//level				
			((tab == 1) && (bot->getLevel() > 19))
		{
			bot->learnSpell(11366); //Pyroblast
		}
		else if ((tab == 1) && (bot->getLevel() > 29))
		{
			bot->learnSpell(11113); //Blast Wave
		}
		else if ((tab == 1) && (bot->getLevel() > 39))
		{
			bot->learnSpell(11129); //Combustion
		}
		else if //tab=2=frost			//level 				
			((tab == 2) && (bot->getLevel() > 19))
		{
			bot->learnSpell(12472); //Cold Snap
		}
		else if ((tab == 2) && (bot->getLevel() > 29))
		{
			bot->learnSpell(11958); //Ice Block
		}
		else if ((tab == 2) && (bot->getLevel() > 39))
		{
			bot->learnSpell(11426); //Ice Barrier
		}
		else
		{
			bot->learnSpell(133); //Fireball
		}

		break;

	case CLASS_HUNTER:

		if
			(bot->getLevel() > 8)
		{
			//Tame Beast, Call pet, Dismiss pet, Beast Training, Feed Pet, Revive Pet
			bot->learnSpell(1515);
			bot->learnSpell(883);
			bot->learnSpell(2641);
		}
		else if
			(bot->getLevel() > 9)
		{
			//Tame Beast, Call pet, Dismiss pet, Beast Training, Feed Pet, Revive Pet
			bot->learnSpell(5149);
			bot->learnSpell(6991);
			bot->learnSpell(982);
		}
		//tab=0=beastmastery					//level	

		else if ((tab == 0) && (bot->getLevel() > 29))
		{
			bot->learnSpell(19577); //Intimidation
		}
		else if ((tab == 0) && (bot->getLevel() > 39))
		{
			bot->learnSpell(19574); //Bestial Wrath
		}

		//tab=1=marksmanship			//level

		else if ((tab == 1) && (bot->getLevel() > 19))
		{
			bot->learnSpell(19434); //Aimed Shot
		}
		else if ((tab == 1) && (bot->getLevel() > 29))
		{
			bot->learnSpell(19503); //Scatter Shot
		}
		else if ((tab == 1) && (bot->getLevel() > 39))
		{
			bot->learnSpell(19506); //Trueshot Aura
		}
		//tab=2=survival			//level 	

		else if ((tab == 2) && (bot->getLevel() > 19))
		{
			bot->learnSpell(19263); //Deterrence
		}
		else if ((tab == 2) && (bot->getLevel() > 29))
		{
			bot->learnSpell(19306); //Counterattack
		}
		else if ((tab == 2) && (bot->getLevel() > 39))
		{
			bot->learnSpell(19386); //Wyverne Sting
		}
		else
		{
			bot->learnSpell(75); //Auto shot
		}
		break;

	case CLASS_PALADIN:

		if
			(bot->getLevel() > 11)
		{
			bot->learnSpell(7328); //Redemption
		}
		//tab=0=holy					//level			
		else if ((tab == 0) && (bot->getLevel() > 19))
		{
			bot->learnSpell(26573); //Consecration
		}
		else if ((tab == 0) && (bot->getLevel() > 29))
		{
			bot->learnSpell(20216); //Divine Favor
		}
		else if ((tab == 0) && (bot->getLevel() > 39))
		{
			bot->learnSpell(20473); //Holy Shock
		}

		//tab=1=prot			//level

		else if ((tab == 1) && (bot->getLevel() > 19))
		{
			bot->learnSpell(20217); //Blessing of Kings
		}
		else if ((tab == 1) && (bot->getLevel() > 29))
		{
			bot->learnSpell(20911); //Blessing of Sanctuary
		}
		else if ((tab == 1) && (bot->getLevel() > 39))
		{
			bot->learnSpell(20925); //Holy Shield
		}
		//tab=2=retri			//level 	

		else if ((tab == 2) && (bot->getLevel() > 19))
		{
			bot->learnSpell(20375); //Seal of Command
		}
		else if ((tab == 2) && (bot->getLevel() > 29))
		{
			bot->learnSpell(20218); //Sanctity Aura
		}
		else if ((tab == 2) && (bot->getLevel() > 39))
		{
			bot->learnSpell(20066); //Repentance
		}
		else
		{
			bot->learnSpell(20154); //Seal of Righteousness
		}
		break;

	case CLASS_PRIEST:

		if //tab=0=disc					//level						
			((tab == 0) && (bot->getLevel() > 19))
		{
			bot->learnSpell(14751); //Inner Focus
		}
		else if ((tab == 0) && (bot->getLevel() > 29))
		{
			bot->learnSpell(14752); //Divine Spirit
		}
		else if ((tab == 0) && (bot->getLevel() > 39))
		{
			bot->learnSpell(10060); //Power Infusion
		}

		else if //tab=1=holy			//level					
			((tab == 1) && (bot->getLevel() > 19))
		{
			bot->learnSpell(15237); //Holy Nova
		}
		else if ((tab == 1) && (bot->getLevel() > 29))
		{
			bot->learnSpell(20711); //Spirit of Redemption
		}
		else if ((tab == 1) && (bot->getLevel() > 39))
		{
			bot->learnSpell(724); //Lightwell
		}
		else if //tab=2=shadow			//level 					
			((tab == 2) && (bot->getLevel() > 19))
		{
			bot->learnSpell(15407); //Mind Flay
		}
		else if ((tab == 2) && (bot->getLevel() > 29))
		{
			//Silence and Vampiric Embrace
			bot->learnSpell(15487);
			bot->learnSpell(15286);
		}
		else if ((tab == 2) && (bot->getLevel() > 39))
		{
			bot->learnSpell(15473); //Shadowform
		}
		else
		{
			bot->learnSpell(585); //Smite
		}
		break;

	case CLASS_ROGUE:

		if
			(bot->getLevel() > 19)
		{
			//Poisons,Sinister Strike
			bot->learnSpell(2842);
			bot->learnSpell(1752);
		}
		//tab=0=assa					//level		
		else if ((tab == 0) && (bot->getLevel() > 29))
		{
			bot->learnSpell(14177); //Cold Blood
		}
		else if ((tab == 0) && (bot->getLevel() > 39))
		{
			bot->learnSpell(14983); //Vigor
		}
		//tab=1=combat			//level		

		else if ((tab == 1) && (bot->getLevel() > 19))
		{
			bot->learnSpell(14251); //Riposte
		}
		else if ((tab == 1) && (bot->getLevel() > 29))
		{
			bot->learnSpell(13877); //Blade Flurry
		}
		else if ((tab == 1) && (bot->getLevel() > 39))
		{
			bot->learnSpell(13750); //Adrenaline Rush
		}
		//tab=2=sub			//level 			

		else if ((tab == 2) && (bot->getLevel() > 19))
		{
			bot->learnSpell(14278); //Ghostly Strike
		}
		else if ((tab == 2) && (bot->getLevel() > 29))
		{
			//Hemorrhage and Preparation
			bot->learnSpell(16511);
			bot->learnSpell(14185);
		}
		else if ((tab == 2) && (bot->getLevel() > 39))
		{
			bot->learnSpell(14183); //Premeditation
		}


		break;

	case CLASS_SHAMAN:

		if
			(bot->getLevel() > 19)
		{
			bot->learnSpell(2645); //Ghost Wolf
		}
		//tab=0=ele					//level		
		else if ((tab == 0) && (bot->getLevel() > 19))
		{
			bot->learnSpell(16164); //Elemental Focus
		}
		else if ((tab == 0) && (bot->getLevel() > 39))
		{
			bot->learnSpell(16166); //Elemental Mastery
		}

		//tab=1=enhanc			//level		

		else if ((tab == 1) && (bot->getLevel() > 19))
		{
			bot->learnSpell(16269); //Two-Handed axes and maces
		}
		else if ((tab == 1) && (bot->getLevel() > 29))
		{
			bot->learnSpell(16268); //Parry
		}
		else if ((tab == 1) && (bot->getLevel() > 39))
		{
			bot->learnSpell(17364); //Stormstrike
		}
		else if //tab=2=resto			//level 			
			((tab == 2) && (bot->getLevel() > 19))
		{
			bot->learnSpell(2645); //Ghost Wolf
		}
		else if ((tab == 2) && (bot->getLevel() > 29))
		{
			bot->learnSpell(16188); //Nature's Swiftness
		}
		else if ((tab == 2) && (bot->getLevel() > 39))
		{
			bot->learnSpell(16190); //Mana Tide Totem
		}
		else
		{
			bot->learnSpell(403); //Lightning Bolt
		}
		break;

	case CLASS_WARLOCK:

		if //tab=0=affli					//level		
			(bot->getLevel() > 0)
		{
			bot->learnSpell(688); //Summon Imp
		}
		else if (bot->getLevel() > 9)
		{
			bot->learnSpell(697); //Summon Voidwalker
		}
		else if (bot->getLevel() > 19)
		{
			bot->learnSpell(712); //Summon Succubus				
		}
		else if (bot->getLevel() > 29)
		{
			bot->learnSpell(691); //Summon Felhunter
		}
		//tab=0=affli					//level		
		else if ((tab == 0) && (bot->getLevel() > 19))
		{
			bot->learnSpell(18288); //Amplify Curse
		}
		else if ((tab == 0) && (bot->getLevel() > 29))
		{
			//Curse of Exhaustion and Siphon Life
			bot->learnSpell(18223);
			bot->learnSpell(18265);
		}
		else if ((tab == 0) && (bot->getLevel() > 39))
		{
			bot->learnSpell(18220); //Dark Pact
		}

		//tab=1=demo			//level		

		else if ((tab == 1) && (bot->getLevel() > 19))
		{
			bot->learnSpell(18708); //Fel Domination
		}
		else if ((tab == 1) && (bot->getLevel() > 29))
		{
			bot->learnSpell(18788); //Demonic Sacrifice
		}
		else if ((tab == 1) && (bot->getLevel() > 39))
		{
			bot->learnSpell(19028); //Soul Link
		}
		//tab=2=destro			//level 			


		else if ((tab == 2) && (bot->getLevel() > 19))
		{
			bot->learnSpell(17877); // Shadowburn
		}
		else if ((tab == 2) && (bot->getLevel() > 29))
		{
			bot->learnSpell(17959); // Ruin Talent	
		}
		else if ((tab == 2) && (bot->getLevel() > 39))
		{
			bot->learnSpell(17962); // Conflagrate					
		}
		else
		{
			bot->learnSpell(686); //Shadow Bolt
		}
		break;
	}
	//to leave DK starting area 
	if (bot->getClass() == CLASS_DEATH_KNIGHT)
	{
		bot->learnSpell(50977);
	}

	//Mounts
	if (bot->getLevel() > 20 && bot->GetTeamId() == TeamId::TEAM_ALLIANCE)
	{
		bot->learnSpell(6899);
	}
	if (bot->getLevel() > 20 && bot->GetTeamId() == TeamId::TEAM_HORDE)
	{
		bot->learnSpell(8395);

	}
	if (bot->getLevel() > 40 && bot->GetTeamId() == TeamId::TEAM_ALLIANCE)
	{
		bot->learnSpell(23240);

	}
	if (bot->getLevel() > 40 && bot->GetTeamId() == TeamId::TEAM_HORDE)
	{
		bot->learnSpell(23242);
	}
}

void PlayerbotFactory::InitTalents(uint32 specNo)
{
	uint32 classMask = bot->getClassMask();

	map<uint32, vector<TalentEntry const*> > spells;
	for (uint32 i = 0; i < sTalentStore.GetNumRows(); ++i)
	{
		TalentEntry const *talentInfo = sTalentStore.LookupEntry(i);
		if (!talentInfo)
			continue;

		TalentTabEntry const *talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);
		if (!talentTabInfo || talentTabInfo->tabpage != specNo)
			continue;

		if ((classMask & talentTabInfo->ClassMask) == 0)
			continue;

		spells[talentInfo->Row].push_back(talentInfo);
	}

	// EJ init talent points first
	bot->InitTalentForLevel();

	uint32 freePoints = bot->GetFreeTalentPoints();
	for (map<uint32, vector<TalentEntry const*> >::iterator i = spells.begin(); i != spells.end(); ++i)
	{
		vector<TalentEntry const*> &spells = i->second;
		if (spells.empty())
		{
			sLog->outError("%s: No spells for talent row %d", bot->GetName().c_str(), i->first);
			continue;
		}

		int attemptCount = 0;
		while (!spells.empty() && (int)freePoints - (int)bot->GetFreeTalentPoints() < 5 && attemptCount++ < 3 && bot->GetFreeTalentPoints())
		{
			int index = urand(0, spells.size() - 1);
			TalentEntry const *talentInfo = spells[index];
			int maxRank = 0;
			for (int rank = 0; rank < min((uint32)MAX_TALENT_RANK, bot->GetFreeTalentPoints()); ++rank)
			{
				uint32 spellId = talentInfo->RankID[rank];
				if (!spellId)
					continue;

				maxRank = rank;
			}

			bot->LearnTalent(talentInfo->TalentID, maxRank);
			spells.erase(spells.begin() + index);
		}

		freePoints = bot->GetFreeTalentPoints();
	}

	for (uint32 i = 0; i < MAX_TALENT_SPECS; ++i)
	{
		for (PlayerTalentMap::iterator itr = bot->GetTalentMap(i).begin(); itr != bot->GetTalentMap(i).end(); ++itr)
		{
			if (itr->second->State != PLAYERSPELL_REMOVED)
				itr->second->State = PLAYERSPELL_CHANGED;
		}
	}
}

uint64 PlayerbotFactory::GetRandomBot()
{
	vector<uint64> guids;
	for (list<uint32>::iterator i = sPlayerbotAIConfig.randomBotAccounts.begin(); i != sPlayerbotAIConfig.randomBotAccounts.end(); i++)
	{
		uint32 accountId = *i;
		if (!AccountMgr::GetCharactersCount(accountId))
			continue;

		QueryResult result = CharacterDatabase.PQuery("SELECT guid FROM characters WHERE account = '%u'", accountId);
		if (!result)
			continue;

		do
		{
			Field* fields = result->Fetch();
			uint64 guid = MAKE_NEW_GUID(fields[0].GetUInt32(), 0, HIGHGUID_PLAYER);
			if (!ObjectAccessor::FindPlayer(guid))
				guids.push_back(guid);
		} while (result->NextRow());
	}

	if (guids.empty())
		return 0;

	int index = urand(0, guids.size() - 1);
	return guids[index];
}

void AddPrevQuests(uint32 questId, list<uint32>& questIds)
{
	Quest const *quest = sObjectMgr->GetQuestTemplate(questId);
	for (Quest::PrevQuests::const_iterator iter = quest->prevQuests.begin(); iter != quest->prevQuests.end(); ++iter)
	{
		uint32 prevId = abs(*iter);
		AddPrevQuests(prevId, questIds);
		questIds.push_back(prevId);
	}
}

void PlayerbotFactory::InitQuests()
{
	if (classQuestIds.empty())
	{
		ObjectMgr::QuestMap const& questTemplates = sObjectMgr->GetQuestTemplates();
		for (ObjectMgr::QuestMap::const_iterator i = questTemplates.begin(); i != questTemplates.end(); ++i)
		{
			uint32 questId = i->first;
			Quest const *quest = i->second;

			if (!quest->GetRequiredClasses() || quest->IsRepeatable())
				continue;

			AddPrevQuests(questId, classQuestIds);
			classQuestIds.remove(questId);
			classQuestIds.push_back(questId);
		}
	}

	int count = 0;
	for (list<uint32>::iterator i = classQuestIds.begin(); i != classQuestIds.end(); ++i)
	{
		uint32 questId = *i;
		Quest const *quest = sObjectMgr->GetQuestTemplate(questId);

		if (!bot->SatisfyQuestClass(quest, false) ||
			quest->GetMinLevel() > bot->getLevel() ||
			!bot->SatisfyQuestRace(quest, false))
			continue;

		bot->SetQuestStatus(questId, QUEST_STATUS_COMPLETE);
		bot->RewardQuest(quest, 0, bot, false);
		if (!(count++ % 10))
			ClearInventory();
	}
	ClearInventory();
}

void PlayerbotFactory::ClearInventory()
{
	DestroyItemsVisitor visitor(bot);
	IterateItems(&visitor);
}

void PlayerbotFactory::InitAmmo()
{
	if (bot->getClass() != CLASS_HUNTER && bot->getClass() != CLASS_ROGUE && bot->getClass() != CLASS_WARRIOR)
		return;

	Item* const pItem = bot->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED);
	if (!pItem)
		return;

	uint32 subClass = 0;
	switch (pItem->GetTemplate()->SubClass)
	{
	case ITEM_SUBCLASS_WEAPON_GUN:
		subClass = ITEM_SUBCLASS_BULLET;
		break;
	case ITEM_SUBCLASS_WEAPON_BOW:
	case ITEM_SUBCLASS_WEAPON_CROSSBOW:
		subClass = ITEM_SUBCLASS_ARROW;
		break;
	}

	if (!subClass)
		return;

	QueryResult results = WorldDatabase.PQuery("select max(entry), max(RequiredLevel) from item_template where class = '%u' and subclass = '%u' and RequiredLevel <= '%u'",
		ITEM_CLASS_PROJECTILE, subClass, bot->getLevel());

	Field* fields = results->Fetch();
	if (fields)
	{
		uint32 entry = fields[0].GetUInt32();
		for (int i = 0; i < 5; i++)
		{
			bot->StoreNewItemInBestSlots(entry, 1000);
		}
		bot->SetAmmo(entry);
	}
}

void PlayerbotFactory::InitMounts()
{
	map<uint32, map<int32, vector<uint32> > > allSpells;

	for (uint32 spellId = 0; spellId < sSpellStore.GetNumRows(); ++spellId)
	{
		SpellInfo const *spellInfo = sSpellMgr->GetSpellInfo(spellId);
		if (!spellInfo || spellInfo->Effects[0].ApplyAuraName != SPELL_AURA_MOUNTED)
			continue;

		if (spellInfo->GetDuration() != -1)
			continue;

		int32 effect = max(spellInfo->Effects[1].BasePoints, spellInfo->Effects[2].BasePoints);
		if (effect < 50)
			continue;

		uint32 index = (spellInfo->Effects[1].ApplyAuraName == SPELL_AURA_MOD_MOUNTED_FLIGHT_SPEED_ALWAYS ||
			spellInfo->Effects[2].ApplyAuraName == SPELL_AURA_MOD_MOUNTED_FLIGHT_SPEED_ALWAYS) ? 1 : 0;
		allSpells[index][effect].push_back(spellId);
	}

	for (uint32 type = 0; type < 2; ++type)
	{
		map<int32, vector<uint32> >& spells = allSpells[type];
		for (map<int32, vector<uint32> >::iterator i = spells.begin(); i != spells.end(); ++i)
		{
			int32 effect = i->first;
			vector<uint32>& ids = i->second;
			uint32 index = urand(0, ids.size() - 1);
			if (index >= ids.size())
				continue;

			bot->learnSpell(ids[index]);
		}
	}
}

void PlayerbotFactory::InitPotions()
{
	map<uint32, vector<uint32> > items;
	ItemTemplateContainer const* itemTemplateContainer = sObjectMgr->GetItemTemplateStore();
	for (ItemTemplateContainer::const_iterator i = itemTemplateContainer->begin(); i != itemTemplateContainer->end(); ++i)
	{
		ItemTemplate const& itemTemplate = i->second;
		uint32 itemId = i->first;
		ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
		if (!proto)
			continue;

		if (proto->Class != ITEM_CLASS_CONSUMABLE ||
			proto->SubClass != ITEM_SUBCLASS_POTION ||
			proto->Spells[0].SpellCategory != 4 ||
			proto->Bonding != NO_BIND)
			continue;

		if (proto->RequiredLevel > bot->getLevel() || proto->RequiredLevel < bot->getLevel() - 10)
			continue;

		if (proto->RequiredSkill && !bot->HasSkill(proto->RequiredSkill))
			continue;

		if (proto->Area || proto->Map || proto->RequiredCityRank || proto->RequiredHonorRank)
			continue;

		for (int j = 0; j < MAX_ITEM_PROTO_SPELLS; j++)
		{
			const SpellInfo* const spellInfo = sSpellMgr->GetSpellInfo(proto->Spells[j].SpellId);
			if (!spellInfo)
				continue;

			for (int i = 0; i < 3; i++)
			{
				if (spellInfo->Effects[i].Effect == SPELL_EFFECT_HEAL || spellInfo->Effects[i].Effect == SPELL_EFFECT_ENERGIZE)
				{
					items[spellInfo->Effects[i].Effect].push_back(itemId);
					break;
				}
			}
		}
	}

	uint32 effects[] = { SPELL_EFFECT_HEAL, SPELL_EFFECT_ENERGIZE };
	for (int i = 0; i < sizeof(effects) / sizeof(uint32); ++i)
	{
		uint32 effect = effects[i];
		vector<uint32>& ids = items[effect];
		uint32 index = urand(0, ids.size() - 1);
		if (index >= ids.size())
			continue;

		uint32 itemId = ids[index];
		ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
		bot->StoreNewItemInBestSlots(itemId, urand(1, proto->GetMaxStackSize()));
	}
}

void PlayerbotFactory::InitFood()
{
	map<uint32, vector<uint32> > items;
	ItemTemplateContainer const* itemTemplateContainer = sObjectMgr->GetItemTemplateStore();
	for (ItemTemplateContainer::const_iterator i = itemTemplateContainer->begin(); i != itemTemplateContainer->end(); ++i)
	{
		ItemTemplate const& itemTemplate = i->second;
		uint32 itemId = i->first;
		ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
		if (!proto)
			continue;

		if (proto->Class != ITEM_CLASS_CONSUMABLE ||
			proto->SubClass != ITEM_SUBCLASS_FOOD ||
			(proto->Spells[0].SpellCategory != 11 && proto->Spells[0].SpellCategory != 59) ||
			proto->Bonding != NO_BIND)
			continue;

		if (proto->RequiredLevel > bot->getLevel() || proto->RequiredLevel < bot->getLevel() - 10)
			continue;

		if (proto->RequiredSkill && !bot->HasSkill(proto->RequiredSkill))
			continue;

		if (proto->Area || proto->Map || proto->RequiredCityRank || proto->RequiredHonorRank)
			continue;

		items[proto->Spells[0].SpellCategory].push_back(itemId);
	}

	uint32 categories[] = { 11, 59 };
	for (int i = 0; i < sizeof(categories) / sizeof(uint32); ++i)
	{
		uint32 category = categories[i];
		vector<uint32>& ids = items[category];
		uint32 index = urand(0, ids.size() - 1);
		if (index >= ids.size())
			continue;

		uint32 itemId = ids[index];
		ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
		bot->StoreNewItemInBestSlots(itemId, urand(1, proto->GetMaxStackSize()));
	}
}


void PlayerbotFactory::CancelAuras()
{
	bot->RemoveAllAuras();
}

void PlayerbotFactory::InitInventory()
{
	InitInventoryTrade();
	InitInventoryEquip();
	InitInventorySkill();
}

void PlayerbotFactory::InitInventorySkill()
{
	if (bot->HasSkill(SKILL_MINING)) {
		StoreItem(2901, 1); // Mining Pick
	}
	if (bot->HasSkill(SKILL_JEWELCRAFTING)) {
		StoreItem(20815, 1); // Jeweler's Kit
		StoreItem(20824, 1); // Simple Grinder
	}
	if (bot->HasSkill(SKILL_BLACKSMITHING) || bot->HasSkill(SKILL_ENGINEERING)) {
		StoreItem(5956, 1); // Blacksmith Hammer
	}
	if (bot->HasSkill(SKILL_ENGINEERING)) {
		StoreItem(6219, 1); // Arclight Spanner
	}
	if (bot->HasSkill(SKILL_ENCHANTING)) {
		StoreItem(44452, 1); // Runed Titanium Rod
	}
	if (bot->HasSkill(SKILL_INSCRIPTION)) {
		StoreItem(39505, 1); // Virtuoso Inking Set
	}
	if (bot->HasSkill(SKILL_SKINNING)) {
		StoreItem(7005, 1); // Skinning Knife
	}
}

Item* PlayerbotFactory::StoreItem(uint32 itemId, uint32 count)
{
	ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
	ItemPosCountVec sDest;
	InventoryResult msg = bot->CanStoreNewItem(INVENTORY_SLOT_BAG_0, NULL_SLOT, sDest, itemId, count);
	if (msg != EQUIP_ERR_OK)
		return NULL;

	return bot->StoreNewItem(sDest, itemId, true, Item::GenerateItemRandomPropertyId(itemId));
}

void PlayerbotFactory::InitInventoryTrade()
{
	vector<uint32> ids;
	ItemTemplateContainer const* itemTemplateContainer = sObjectMgr->GetItemTemplateStore();
	for (ItemTemplateContainer::const_iterator i = itemTemplateContainer->begin(); i != itemTemplateContainer->end(); ++i)
	{
		ItemTemplate const& itemTemplate = i->second;
		uint32 itemId = i->first;
		ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
		if (!proto)
			continue;

		if (proto->Class != ITEM_CLASS_TRADE_GOODS || proto->Bonding != NO_BIND)
			continue;

		if (proto->ItemLevel < bot->getLevel())
			continue;

		if (proto->RequiredLevel > bot->getLevel() || proto->RequiredLevel < bot->getLevel() - 10)
			continue;

		if (proto->RequiredSkill && !bot->HasSkill(proto->RequiredSkill))
			continue;

		ids.push_back(itemId);
	}

	if (ids.empty())
	{
		sLog->outError("No trade items available for bot %s (%d level)", bot->GetName().c_str(), bot->getLevel());
		return;
	}

	uint32 index = urand(0, ids.size() - 1);
	if (index >= ids.size())
		return;

	uint32 itemId = ids[index];
	ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
	if (!proto)
		return;

	uint32 count = 1, stacks = 1;
	switch (proto->Quality)
	{
	case ITEM_QUALITY_NORMAL:
		count = proto->GetMaxStackSize();
		stacks = urand(1, 7);
		break;
	case ITEM_QUALITY_UNCOMMON:
		stacks = 1;
		count = urand(1, proto->GetMaxStackSize());
		break;
	case ITEM_QUALITY_RARE:
		stacks = 1;
		count = urand(1, min(uint32(3), proto->GetMaxStackSize()));
		break;
	}

	for (uint32 i = 0; i < stacks; i++)
		StoreItem(itemId, count);
}

void PlayerbotFactory::InitInventoryEquip()
{
	vector<uint32> ids;

	uint32 desiredQuality = itemQuality;
	if (urand(0, 100) < 100 * sPlayerbotAIConfig.randomGearLoweringChance && desiredQuality > ITEM_QUALITY_NORMAL) {
		desiredQuality--;
	}

	ItemTemplateContainer const* itemTemplateContainer = sObjectMgr->GetItemTemplateStore();
	for (ItemTemplateContainer::const_iterator i = itemTemplateContainer->begin(); i != itemTemplateContainer->end(); ++i)
	{
		ItemTemplate const& itemTemplate = i->second;
		uint32 itemId = i->first;
		ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
		if (!proto)
			continue;

		if (proto->Class != ITEM_CLASS_ARMOR && proto->Class != ITEM_CLASS_WEAPON || (proto->Bonding == BIND_WHEN_PICKED_UP ||
			proto->Bonding == BIND_WHEN_USE))
			continue;

		if (proto->Class == ITEM_CLASS_ARMOR && !CanEquipArmor(proto))
			continue;

		if (proto->Class == ITEM_CLASS_WEAPON && !CanEquipWeapon(proto))
			continue;

		if (!CanEquipItem(proto, desiredQuality))
			continue;

		ids.push_back(itemId);
	}

	int maxCount = urand(0, 3);
	int count = 0;
	for (int attempts = 0; attempts < 15; attempts++)
	{
		uint32 index = urand(0, ids.size() - 1);
		if (index >= ids.size())
			continue;

		uint32 itemId = ids[index];
		if (StoreItem(itemId, 1) && count++ >= maxCount)
			break;
	}
}

void PlayerbotFactory::InitGlyphs()
{
	bot->InitGlyphsForLevel();

	for (uint32 slotIndex = 0; slotIndex < MAX_GLYPH_SLOT_INDEX; ++slotIndex)
	{
		bot->SetGlyph(slotIndex, 0, true);
	}

	uint32 level = bot->getLevel();
	uint32 maxSlot = 0;
	if (level >= 15)
		maxSlot = 2;
	if (level >= 30)
		maxSlot = 3;
	if (level >= 50)
		maxSlot = 4;
	if (level >= 70)
		maxSlot = 5;
	if (level >= 80)
		maxSlot = 6;

	if (!maxSlot)
		return;

	list<uint32> glyphs;
	ItemTemplateContainer const* itemTemplates = sObjectMgr->GetItemTemplateStore();
	for (ItemTemplateContainer::const_iterator i = itemTemplates->begin(); i != itemTemplates->end(); ++i)
	{
		uint32 itemId = i->first;
		ItemTemplate const* proto = &i->second;
		if (!proto)
			continue;

		if (proto->Class != ITEM_CLASS_GLYPH)
			continue;

		if ((proto->AllowableClass & bot->getClassMask()) == 0 || (proto->AllowableRace & bot->getRaceMask()) == 0)
			continue;

		for (uint32 spell = 0; spell < MAX_ITEM_PROTO_SPELLS; spell++)
		{
			uint32 spellId = proto->Spells[spell].SpellId;
			SpellInfo const *entry = sSpellMgr->GetSpellInfo(spellId);
			if (!entry)
				continue;

			for (uint32 effect = 0; effect <= EFFECT_2; ++effect)
			{
				if (entry->Effects[effect].Effect != SPELL_EFFECT_APPLY_GLYPH)
					continue;

				uint32 glyph = entry->Effects[effect].MiscValue;
				glyphs.push_back(glyph);
			}
		}
	}

	if (glyphs.empty())
	{
		sLog->outError("No glyphs found for bot %s", bot->GetName().c_str());
		return;
	}

	set<uint32> chosen;
	for (uint32 slotIndex = 0; slotIndex < maxSlot; ++slotIndex)
	{
		uint32 slot = bot->GetGlyphSlot(slotIndex);
		GlyphSlotEntry const *gs = sGlyphSlotStore.LookupEntry(slot);
		if (!gs)
			continue;

		vector<uint32> ids;
		for (list<uint32>::iterator i = glyphs.begin(); i != glyphs.end(); ++i)
		{
			uint32 id = *i;
			GlyphPropertiesEntry const *gp = sGlyphPropertiesStore.LookupEntry(id);
			if (!gp || gp->TypeFlags != gs->TypeFlags)
				continue;

			ids.push_back(id);
		}

		int maxCount = urand(0, 3);
		int count = 0;
		bool found = false;
		for (int attempts = 0; attempts < 15; ++attempts)
		{
			uint32 index = urand(0, ids.size() - 1);
			if (index >= ids.size())
				continue;

			uint32 id = ids[index];
			if (chosen.find(id) != chosen.end())
				continue;

			chosen.insert(id);

			bot->SetGlyph(slotIndex, id, true);
			found = true;
			break;
		}
		if (!found)
			sLog->outError("No glyphs found for bot %s index %d slot %d", bot->GetName().c_str(), slotIndex, slot);
	}
}

void PlayerbotFactory::InitGuild()
{
	bot->SaveToDB(false, true); //thesawolf - save save save
	if (bot->GetGuildId())
		return;

	if (sPlayerbotAIConfig.randomBotGuilds.empty())
		RandomPlayerbotFactory::CreateRandomGuilds();

	vector<uint32> guilds;
	for (list<uint32>::iterator i = sPlayerbotAIConfig.randomBotGuilds.begin(); i != sPlayerbotAIConfig.randomBotGuilds.end(); ++i)
		guilds.push_back(*i);

	if (guilds.empty())
	{
		sLog->outError("No random guilds available");
		return;
	}

	int index = urand(0, guilds.size() - 1);
	SQLTransaction trans(nullptr);
	uint32 guildId = guilds[index];
	Guild* guild = sGuildMgr->GetGuildById(guildId);
	if (!guild)
	{
		sLog->outError("Invalid guild %u", guildId);
		return;
	}

	if (guild->GetMemberCount() < 10)
		guild->AddMember(bot->GetGUID(), urand(GR_OFFICER, GR_INITIATE));
	bot->SaveToDB(false, true); //thesawolf - save save save
}