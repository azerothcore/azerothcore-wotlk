
#include "Chat.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "DisableMgr.h"
#include "DatabaseWorker.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "CommandScript.h"
#include "ItemTemplate.h"
#include "ChatCommand.h"
#include "World.h"
#include "Totem.h"
#include "DBCStores.h"
#include "SpellMgr.h"
#include "WorldSession.h"
#include "SpellInfo.h"
#include "Spell.h"
#include "Item.h"
#include "Bag.h"
#include <ObjectMgr.cpp>


static const void SendCachePackets(Player* player, ItemTemplate* proto)
{
	if (!player || !proto)
		return;

	std::string Name = proto->Name1;
	std::string Description = proto->Description;

	LocaleConstant loc_idx = player->GetSession()->GetSessionDbLocaleIndex();

	if (loc_idx >= 0)
	{
		if (ItemLocale const* il = sObjectMgr->GetItemLocale(proto->ItemId))
		{
			ObjectMgr::GetLocaleString(il->Name, loc_idx, Name);
			ObjectMgr::GetLocaleString(il->Description, loc_idx, Description);
		}
	}
	WorldPacket data(SMSG_ITEM_QUERY_SINGLE_RESPONSE, 600);
	data << proto->ItemId;
	data << proto->Class;
	data << proto->SubClass;
	data << int32(proto->SoundOverrideSubclass);
	data << Name;
	data << uint8(0x00);
	data << uint8(0x00);
	data << uint8(0x00);
	data << proto->DisplayInfoID;
	data << proto->Quality;
	data << proto->Flags;
	data << proto->Flags2;
	data << proto->BuyPrice;
	data << proto->SellPrice;
	data << proto->InventoryType;
	data << proto->AllowableClass;
	data << proto->AllowableRace;
	data << proto->ItemLevel;
	data << proto->RequiredLevel;
	data << proto->RequiredSkill;
	data << proto->RequiredSkillRank;
	data << proto->RequiredSpell;
	data << proto->RequiredHonorRank;
	data << proto->RequiredCityRank;
	data << proto->RequiredReputationFaction;
	data << proto->RequiredReputationRank;
	data << int32(proto->MaxCount);
	data << int32(proto->Stackable);
	data << proto->ContainerSlots;
	data << proto->StatsCount;
	for (uint32 i = 0; i < proto->StatsCount; ++i)
	{
		data << proto->ItemStat[i].ItemStatType;
		data << proto->ItemStat[i].ItemStatValue;
	}
	data << proto->ScalingStatDistribution;
	data << proto->ScalingStatValue;
	for (int i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
	{
		data << proto->Damage[i].DamageMin;
		data << proto->Damage[i].DamageMax;
		data << proto->Damage[i].DamageType;
	}
	data << proto->Armor;
	data << proto->HolyRes;
	data << proto->FireRes;
	data << proto->NatureRes;
	data << proto->FrostRes;
	data << proto->ShadowRes;
	data << proto->ArcaneRes;
	data << proto->Delay;
	data << proto->AmmoType;
	data << proto->RangedModRange;
	for (int s = 0; s < MAX_ITEM_PROTO_SPELLS; ++s)
	{
		SpellInfo const* spell = sSpellMgr->GetSpellInfo(proto->Spells[s].SpellId);
		if (spell)
		{
			bool db_data = proto->Spells[s].SpellCooldown >= 0 || proto->Spells[s].SpellCategoryCooldown >= 0;
			data << proto->Spells[s].SpellId;
			data << proto->Spells[s].SpellTrigger;
			data << uint32(-abs(proto->Spells[s].SpellCharges));
			if (db_data)
			{
				data << uint32(proto->Spells[s].SpellCooldown);
				data << uint32(proto->Spells[s].SpellCategory);
				data << uint32(proto->Spells[s].SpellCategoryCooldown);
			}
			else
			{
				data << uint32(spell->RecoveryTime);
				data << uint32(spell->GetCategory());
				data << uint32(spell->CategoryRecoveryTime);
			}
		}
		else
		{
			data << uint32(0);
			data << uint32(0);
			data << uint32(0);
			data << uint32(-1);
			data << uint32(0);
			data << uint32(-1);
		}
	}
	data << proto->Bonding;
	data << Description;
	data << proto->PageText;
	data << proto->LanguageID;
	data << proto->PageMaterial;
	data << proto->StartQuest;
	data << proto->LockID;
	data << int32(proto->Material);
	data << proto->Sheath;
	data << proto->RandomProperty;
	data << proto->RandomSuffix;
	data << proto->Block;
	data << proto->ItemSet;
	data << proto->MaxDurability;
	data << proto->Area;
	data << proto->Map;
	data << proto->BagFamily;
	data << proto->TotemCategory;
	for (int s = 0; s < MAX_ITEM_PROTO_SOCKETS; ++s)
	{
		data << proto->Socket[s].Color;
		data << proto->Socket[s].Content;
	}
	data << proto->socketBonus;
	data << proto->GemProperties;
	data << proto->RequiredDisenchantSkill;
	data << proto->ArmorDamageModifier;
	data << proto->Duration;
	data << proto->ItemLimitCategory;
	data << proto->HolidayId;

	player->GetSession()->SendPacket(&data);

	if (Item* item = player->GetItemByEntry(proto->ItemId))
		player->_ApplyItemMods(item, item->GetSlot(), true);
}


using namespace Acore::ChatCommands;
// Comand stuff
class custom_reload_commands : public CommandScript
{
public:
	custom_reload_commands() : CommandScript("custom_reload_commands") { }

	ChatCommandTable GetCommands() const override
	{
		static ChatCommandTable reloadCustomCommandTable =
		{
			{ "reload_item_template",           HandleReloadItemTemplate,  SEC_ADMINISTRATOR, Console::Yes },
			{ "reload_full_creature_template",  HandleReloadFullCreatureTemplate, SEC_ADMINISTRATOR, Console::Yes },
		    { "reload_gameobject_template",     HandleReloadFullGameObject, SEC_ADMINISTRATOR, Console::Yes}
		};

		return reloadCustomCommandTable;
	}
	

	static bool HandleReloadItemTemplate(ChatHandler* handler, const char* args)
	{
		bool itemTemplateReloadEnabled = true;
		if (itemTemplateReloadEnabled)
		{
			LOG_INFO("misc", "Reloading item_template...");
			sObjectMgr->LoadItemTemplates();
			handler->SendGlobalGMSysMessage("Item Template has been reloaded");
		}
		else
			handler->SendGlobalGMSysMessage("The item_template reload command is currently disabled.");
		return true;
	}
	
	static bool HandleReloadFullGameObject(ChatHandler* handler, const char* args)
	{
		bool gameobjectTemplateReloadEnable = true;
		if (gameobjectTemplateReloadEnable)
		{
			LOG_INFO("misc", "Reloading Gameobject Template...");
			sObjectMgr->LoadGameObjectTemplate();
			handler->SendGlobalSysMessage("Gameobject Template has benn reloaded");
		}
		else
			handler->SendGlobalGMSysMessage("The gameobject_template reload command is currently disabled");
		return true;
	}

	static bool HandleReloadFullCreatureTemplate(ChatHandler* handler, const char* args)
	{
		bool creatureTemplateReloadEnabled = true;
		if (creatureTemplateReloadEnabled)
		{
			LOG_INFO("misc", "Reloading Creature Template...");
			sObjectMgr->LoadCreatureTemplates();
			handler->SendGlobalGMSysMessage("Creature Template has been reloaded");
		}
		else
			handler->SendGlobalGMSysMessage("The creature_template reload command is currently disabled");

		return true;
	}
};


void AddSC_custom_reload_commands()
{
	new custom_reload_commands();
}