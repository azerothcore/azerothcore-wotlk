#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "bot_ai.h"
#include "bot_Events.h"
#include "botdatamgr.h"
#include "botdpstracker.h"
#include "botmgr.h"
#include "botspell.h"
#include "bottext.h"
#include "bpet_ai.h"
#include "Chat.h"
#include "CombatPackets.h"
#include "Config.h"
#include "GroupMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Language.h"
#include "Log.h"
#include "Map.h"
#include "MapMgr.h"
#include "MotionMaster.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "Transport.h"
#include "World.h"
/*
Npc Bot Manager by Trickerer (onlysuffering@gmail.com)
Player NpcBots management
TODO: Move creature hooks here
*/

#ifdef _MSC_VER
# pragma warning(push, 4)
#endif

static std::list<BotMgr::delayed_teleport_callback_type> delayed_bot_teleports;

//config
uint8 _basefollowdist;
uint8 _maxNpcBots;
uint8 _maxClassNpcBots;
uint8 _xpReductionNpcBots;
uint8 _healTargetIconFlags;
uint8 _tankingTargetIconFlags;
uint8 _offTankingTargetIconFlags;
uint8 _dpsTargetIconFlags;
uint8 _rangedDpsTargetIconFlags;
uint8 _noDpsTargetIconFlags;
int32 _botInfoPacketsLimit;
uint32 _npcBotsCost;
uint32 _npcBotUpdateDelayBase;
uint32 _npcBotEngageDelayDPS_default;
uint32 _npcBotEngageDelayHeal_default;
uint32 _npcBotOwnerExpireTime;
uint32 _desiredWanderingBotsCount;
bool _enableNpcBots;
bool _enableNpcBotsDungeons;
bool _enableNpcBotsRaids;
bool _enableNpcBotsBGs;
bool _enableNpcBotsArenas;
bool _enableDungeonFinder;
bool _limitNpcBotsDungeons;
bool _limitNpcBotsRaids;
bool _botPvP;
bool _botMovementFoodInterrupt;
bool _filterRaces;
bool _displayEquipment;
bool _showCloak;
bool _showHelm;
bool _sendEquipListItems;
bool _transmog_enable;
bool _transmog_mixArmorClasses;
bool _transmog_mixWeaponClasses;
bool _transmog_mixWeaponInvTypes;
bool _transmog_useEquipmentSlots;
bool _enableclass_blademaster;
bool _enableclass_sphynx;
bool _enableclass_archmage;
bool _enableclass_dreadlord;
bool _enableclass_spellbreaker;
bool _enableclass_darkranger;
bool _enableclass_necromancer;
bool _enableclass_seawitch;
bool _enrageOnDismiss;
bool _botStatLimits;
bool _enableWanderingBotsBG;
float _botStatLimits_dodge;
float _botStatLimits_parry;
float _botStatLimits_block;
float _botStatLimits_crit;
float _mult_dmg_physical;
float _mult_dmg_spell;
float _mult_healing;
float _mult_hp;
float _mult_dmg_wanderer;
float _mult_healing_wanderer;
float _mult_hp_wanderer;
float _mult_speed_wanderer;
float _mult_dmg_warrior;
float _mult_dmg_paladin;
float _mult_dmg_hunter;
float _mult_dmg_rogue;
float _mult_dmg_priest;
float _mult_dmg_deathknight;
float _mult_dmg_shaman;
float _mult_dmg_mage;
float _mult_dmg_warlock;
float _mult_dmg_druid;
float _mult_dmg_blademaster;
float _mult_dmg_obsidiandestroyer;
float _mult_dmg_archmage;
float _mult_dmg_dreadlord;
float _mult_dmg_spellbreaker;
float _mult_dmg_darkranger;
float _mult_dmg_necromancer;
float _mult_dmg_seawitch;

bool __firstload = true;

void AddSC_death_knight_bot();
void AddSC_druid_bot();
void AddSC_hunter_bot();
void AddSC_mage_bot();
void AddSC_paladin_bot();
void AddSC_priest_bot();
void AddSC_rogue_bot();
void AddSC_shaman_bot();
void AddSC_warlock_bot();
void AddSC_warrior_bot();
void AddSC_blademaster_bot();
void AddSC_sphynx_bot();
void AddSC_archmage_bot();
void AddSC_dreadlord_bot();
void AddSC_spellbreaker_bot();
void AddSC_dark_ranger_bot();
void AddSC_necromancer_bot();
void AddSC_sea_witch_bot();
void AddSC_archmage_bot_pets();
void AddSC_dreadlord_bot_pets();
void AddSC_dark_ranger_bot_pets();
void AddSC_necromancer_bot_pets();
void AddSC_sea_witch_bot_pets();
void AddSC_hunter_bot_pets();
void AddSC_warlock_bot_pets();
void AddSC_deathknight_bot_pets();
void AddSC_priest_bot_pets();
void AddSC_shaman_bot_pets();
void AddSC_mage_bot_pets();
void AddSC_druid_bot_pets();
void AddSC_script_bot_commands();
void AddSC_script_bot_giver();
void AddSC_wandering_bot_xp_gain_script();

void AddNpcBotScripts()
{
    AddSC_death_knight_bot();
    AddSC_druid_bot();
    AddSC_hunter_bot();
    AddSC_mage_bot();
    AddSC_paladin_bot();
    AddSC_priest_bot();
    AddSC_rogue_bot();
    AddSC_shaman_bot();
    AddSC_warlock_bot();
    AddSC_warrior_bot();
    AddSC_blademaster_bot();
    AddSC_sphynx_bot();
    AddSC_archmage_bot();
    AddSC_dreadlord_bot();
    AddSC_spellbreaker_bot();
    AddSC_dark_ranger_bot();
    AddSC_necromancer_bot();
    AddSC_sea_witch_bot();
    AddSC_archmage_bot_pets();
    AddSC_dreadlord_bot_pets();
    AddSC_dark_ranger_bot_pets();
    AddSC_necromancer_bot_pets();
    AddSC_sea_witch_bot_pets();
    AddSC_hunter_bot_pets();
    AddSC_warlock_bot_pets();
    AddSC_deathknight_bot_pets();
    AddSC_priest_bot_pets();
    AddSC_shaman_bot_pets();
    AddSC_mage_bot_pets();
    AddSC_druid_bot_pets();
    AddSC_script_bot_commands();
    AddSC_script_bot_giver();
    AddSC_wandering_bot_xp_gain_script();
}

BotMgr::BotMgr(Player* const master) : _owner(master), _dpstracker(new DPSTracker())
{
    //LoadConfig(); already loaded (MapMgr.cpp)
    _followdist = _basefollowdist;
    _exactAttackRange = 0;
    _attackRangeMode = BOT_ATTACK_RANGE_SHORT;
    _attackAngleMode = BOT_ATTACK_ANGLE_NORMAL;
    _allowCombatPositioning = true;
    _npcBotEngageDelayDPS = _npcBotEngageDelayDPS_default;
    _npcBotEngageDelayHeal = _npcBotEngageDelayHeal_default;

    _botsHidden = false;
    _quickrecall = false;
}
BotMgr::~BotMgr()
{
    delete _dpstracker;
}

void BotMgr::Initialize()
{
    LoadConfig();

    BotDataMgr::LoadNpcBots();
    BotDataMgr::LoadNpcBotGroupData();
}

void BotMgr::ReloadConfig()
{
    LoadConfig(true);
}

void BotMgr::LoadConfig(bool reload)
{
    if (__firstload)
        __firstload = false;
    else if (!reload)
        return;

    _enableNpcBots                  = sConfigMgr->GetBoolDefault("NpcBot.Enable", true);
    _maxNpcBots                     = sConfigMgr->GetIntDefault("NpcBot.MaxBots", 1);
    _maxClassNpcBots                = sConfigMgr->GetIntDefault("NpcBot.MaxBotsPerClass", 1);
    _filterRaces                    = sConfigMgr->GetBoolDefault("NpcBot.Botgiver.FilterRaces", false);
    _basefollowdist                 = sConfigMgr->GetIntDefault("NpcBot.BaseFollowDistance", 30);
    _xpReductionNpcBots             = sConfigMgr->GetIntDefault("NpcBot.XpReduction", 0);
    _healTargetIconFlags            = sConfigMgr->GetIntDefault("NpcBot.HealTargetIconMask", 0);
    _tankingTargetIconFlags         = sConfigMgr->GetIntDefault("NpcBot.TankTargetIconMask", 0);
    _offTankingTargetIconFlags      = sConfigMgr->GetIntDefault("NpcBot.OffTankTargetIconMask", 0);
    _dpsTargetIconFlags             = sConfigMgr->GetIntDefault("NpcBot.DPSTargetIconMask", 0);
    _rangedDpsTargetIconFlags       = sConfigMgr->GetIntDefault("NpcBot.RangedDPSTargetIconMask", 0);
    _noDpsTargetIconFlags           = sConfigMgr->GetIntDefault("NpcBot.NoDPSTargetIconMask", 0);
    _mult_dmg_physical              = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Physical", 1.0f);
    _mult_dmg_spell                 = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Spell", 1.0f);
    _mult_healing                   = sConfigMgr->GetFloatDefault("NpcBot.Mult.Healing", 1.0f);
    _mult_hp                        = sConfigMgr->GetFloatDefault("NpcBot.Mult.HP", 1.0f);
    _mult_dmg_wanderer              = sConfigMgr->GetFloatDefault("NpcBot.Mult.Wanderer.Damage", 1.0f);
    _mult_healing_wanderer          = sConfigMgr->GetFloatDefault("NpcBot.Mult.Wanderer.Healing", 1.0f);
    _mult_hp_wanderer               = sConfigMgr->GetFloatDefault("NpcBot.Mult.Wanderer.HP", 1.0f);
    _mult_speed_wanderer            = sConfigMgr->GetFloatDefault("NpcBot.Mult.Wanderer.Speed", 1.0f);
    _mult_dmg_warrior               = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Warrior", 1.0f);
    _mult_dmg_paladin               = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Paladin", 1.0f);
    _mult_dmg_hunter                = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Hunter", 1.0f);
    _mult_dmg_rogue                 = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Rogue", 1.0f);
    _mult_dmg_priest                = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Priest", 1.0f);
    _mult_dmg_deathknight           = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.DeathKnight", 1.0f);
    _mult_dmg_shaman                = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Shaman", 1.0f);
    _mult_dmg_mage                  = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Mage", 1.0f);
    _mult_dmg_warlock               = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Warlock", 1.0f);
    _mult_dmg_druid                 = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Druid", 1.0f);
    _mult_dmg_blademaster           = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Blademaster", 1.0f);
    _mult_dmg_obsidiandestroyer     = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.ObsidianDestroyer", 1.0f);
    _mult_dmg_archmage              = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Archmage", 1.0f);
    _mult_dmg_dreadlord             = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Dreadlord", 1.0f);
    _mult_dmg_spellbreaker          = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.SpellBreaker", 1.0f);
    _mult_dmg_darkranger            = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.DarkRanger", 1.0f);
    _mult_dmg_necromancer           = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.Necromancer", 1.0f);
    _mult_dmg_seawitch              = sConfigMgr->GetFloatDefault("NpcBot.Mult.Damage.SeaWitch", 1.0f);
    _enableNpcBotsDungeons          = sConfigMgr->GetBoolDefault("NpcBot.Enable.Dungeon", true);
    _enableNpcBotsRaids             = sConfigMgr->GetBoolDefault("NpcBot.Enable.Raid", false);
    _enableNpcBotsBGs               = sConfigMgr->GetBoolDefault("NpcBot.Enable.BG", false);
    _enableNpcBotsArenas            = sConfigMgr->GetBoolDefault("NpcBot.Enable.Arena", false);
    _enableDungeonFinder            = sConfigMgr->GetBoolDefault("NpcBot.Enable.DungeonFinder", true);
    _limitNpcBotsDungeons           = sConfigMgr->GetBoolDefault("NpcBot.Limit.Dungeon", true);
    _limitNpcBotsRaids              = sConfigMgr->GetBoolDefault("NpcBot.Limit.Raid", true);
    _botInfoPacketsLimit            = sConfigMgr->GetIntDefault("NpcBot.InfoPacketsLimit", -1);
    _npcBotsCost                    = sConfigMgr->GetIntDefault("NpcBot.Cost", 1000000);
    _npcBotUpdateDelayBase          = sConfigMgr->GetIntDefault("NpcBot.UpdateDelay.Base", 0);
    _npcBotEngageDelayDPS_default   = sConfigMgr->GetIntDefault("NpcBot.EngageDelay.DPS", 0);
    _npcBotEngageDelayHeal_default  = sConfigMgr->GetIntDefault("NpcBot.EngageDelay.Heal", 0);
    _npcBotOwnerExpireTime          = sConfigMgr->GetIntDefault("NpcBot.OwnershipExpireTime", 0);
    _botPvP                         = sConfigMgr->GetBoolDefault("NpcBot.PvP", true);
    _botMovementFoodInterrupt       = sConfigMgr->GetBoolDefault("NpcBot.Movements.InterruptFood", false);
    _displayEquipment               = sConfigMgr->GetBoolDefault("NpcBot.EquipmentDisplay.Enable", true);
    _showCloak                      = sConfigMgr->GetBoolDefault("NpcBot.EquipmentDisplay.ShowCloak", true);
    _showHelm                       = sConfigMgr->GetBoolDefault("NpcBot.EquipmentDisplay.ShowHelm", false);
    _sendEquipListItems             = sConfigMgr->GetBoolDefault("NpcBot.Gossip.ShowEquipmentListItems", false);
    _transmog_enable                = sConfigMgr->GetBoolDefault("NpcBot.Transmog.Enable", false);
    _transmog_mixArmorClasses       = sConfigMgr->GetBoolDefault("NpcBot.Transmog.MixArmorClasses", false);
    _transmog_mixWeaponClasses      = sConfigMgr->GetBoolDefault("NpcBot.Transmog.MixWeaponClasses", false);
    _transmog_mixWeaponInvTypes     = sConfigMgr->GetBoolDefault("NpcBot.Transmog.MixWeaponInventoryTypes", false);
    _transmog_useEquipmentSlots     = sConfigMgr->GetBoolDefault("NpcBot.Transmog.UseEquipmentSlots", false);
    _enableclass_blademaster        = sConfigMgr->GetBoolDefault("NpcBot.NewClasses.Blademaster.Enable", true);
    _enableclass_sphynx             = sConfigMgr->GetBoolDefault("NpcBot.NewClasses.ObsidianDestroyer.Enable", true);
    _enableclass_archmage           = sConfigMgr->GetBoolDefault("NpcBot.NewClasses.Archmage.Enable", true);
    _enableclass_dreadlord          = sConfigMgr->GetBoolDefault("NpcBot.NewClasses.Dreadlord.Enable", true);
    _enableclass_spellbreaker       = sConfigMgr->GetBoolDefault("NpcBot.NewClasses.SpellBreaker.Enable", true);
    _enableclass_darkranger         = sConfigMgr->GetBoolDefault("NpcBot.NewClasses.DarkRanger.Enable", true);
    _enableclass_necromancer        = sConfigMgr->GetBoolDefault("NpcBot.NewClasses.Necromancer.Enable", true);
    _enableclass_seawitch           = sConfigMgr->GetBoolDefault("NpcBot.NewClasses.SeaWitch.Enable", true);
    _enrageOnDismiss                = sConfigMgr->GetBoolDefault("NpcBot.EnrageOnDismiss", true);
    _botStatLimits                  = sConfigMgr->GetBoolDefault("NpcBot.Stats.Limits.Enable", false);
    _botStatLimits_dodge            = sConfigMgr->GetFloatDefault("NpcBot.Stats.Limits.Dodge", 95.0f);
    _botStatLimits_parry            = sConfigMgr->GetFloatDefault("NpcBot.Stats.Limits.Parry", 95.0f);
    _botStatLimits_block            = sConfigMgr->GetFloatDefault("NpcBot.Stats.Limits.Block", 95.0f);
    _botStatLimits_crit             = sConfigMgr->GetFloatDefault("NpcBot.Stats.Limits.Crit", 95.0f);
    _desiredWanderingBotsCount      = sConfigMgr->GetIntDefault("NpcBot.WanderingBots.Continents.Count", 0);
    _enableWanderingBotsBG          = sConfigMgr->GetBoolDefault("NpcBot.WanderingBots.BG.Enable", false);

    //limits
    RoundToInterval(_mult_dmg_physical, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_spell, 0.1f, 10.f);
    RoundToInterval(_mult_healing, 0.1f, 10.f);
    RoundToInterval(_mult_hp, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_wanderer, 0.1f, 10.f);
    RoundToInterval(_mult_healing_wanderer, 0.1f, 10.f);
    RoundToInterval(_mult_hp_wanderer, 0.1f, 10.f);
    RoundToInterval(_mult_speed_wanderer, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_warrior, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_paladin, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_hunter, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_rogue, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_priest, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_deathknight, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_shaman, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_mage, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_warlock, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_druid, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_blademaster, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_obsidiandestroyer, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_archmage, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_dreadlord, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_spellbreaker, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_darkranger, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_necromancer, 0.1f, 10.f);
    RoundToInterval(_mult_dmg_seawitch, 0.1f, 10.f);

    //exclusions
    uint8 dpsFlags = /*_tankingTargetIconFlags | _offTankingTargetIconFlags | */_dpsTargetIconFlags | _rangedDpsTargetIconFlags;
    if (uint8 interFlags = (_noDpsTargetIconFlags & dpsFlags))
    {
        _noDpsTargetIconFlags &= ~interFlags;
        LOG_ERROR("scripts", "BotMgr::LoadConfig: NoDPSTargetIconMask intersects with dps targets flags {:#X}! Removed, new mask: {:#X}",
            uint32(interFlags), uint32(_noDpsTargetIconFlags));
    }
}

uint8 BotMgr::GetNpcBotsCount() const
{
    //if (!inWorldOnly)
        return (uint8)_bots.size();

    //CRITICAL SECTION
    //inWorldOnly is only for one-shot cases (opcodes, etc.)
    //maybe convert to (bot && bot->isInWorld()) ?
    //uint8 count = 0;
    //for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    //    if (ObjectAccessor::GetObjectInWorld(itr->first, (Creature*)nullptr))
    //        ++count;
    //return count;
}

uint8 BotMgr::GetNpcBotsCountByRole(uint32 roles) const
{
    uint8 count = 0;
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        if (itr->second && (roles & itr->second->GetBotRoles()))
            ++count;
    return count;
}

uint8 BotMgr::GetNpcBotsCountByVehicleEntry(uint32 creEntry) const
{
    uint8 count = 0;
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        if (itr->second && itr->second->GetVehicle() && itr->second->GetVehicleBase()->GetEntry() == creEntry)
            ++count;
    return count;
}

uint8 BotMgr::GetNpcBotSlot(Creature const* bot) const
{
    uint8 count = 0;
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        ++count;
        if (itr->second == bot)
            return count;
    }
    return 1;
}

uint8 BotMgr::GetNpcBotSlotByRole(uint32 roles, Creature const* bot) const
{
    uint8 count = 0;
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        if (roles & itr->second->GetBotRoles())
        {
            if (!(roles == BOT_ROLE_DPS && (itr->second->GetBotRoles() & BOT_ROLE_TANK)))
                ++count;
            if (itr->second == bot)
                return count;
        }
    }
    return 1;
}

uint32 BotMgr::GetAllNpcBotsClassMask() const
{
    uint32 classMask = 0;
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        classMask |= (1 << (itr->second->GetBotClass() - 1));

    return classMask;
}

bool BotMgr::IsNpcBotModEnabled()
{
    return _enableNpcBots;
}

bool BotMgr::IsNpcBotDungeonFinderEnabled()
{
    return _enableDungeonFinder;
}

bool BotMgr::DisplayEquipment()
{
    return _displayEquipment;
}

bool BotMgr::ShowEquippedCloak()
{
    return _showCloak;
}

bool BotMgr::ShowEquippedHelm()
{
    return _showHelm;
}

bool BotMgr::SendEquipListItems()
{
    return _sendEquipListItems;
}

bool BotMgr::IsTransmogEnabled()
{
    return _transmog_enable;
}
bool BotMgr::MixArmorClasses()
{
    return _transmog_mixArmorClasses;
}
bool BotMgr::MixWeaponClasses()
{
    return _transmog_mixWeaponClasses;
}
bool BotMgr::MixWeaponInventoryTypes()
{
    return _transmog_mixWeaponInvTypes;
}
bool BotMgr::TransmogUseEquipmentSlots()
{
    return _transmog_useEquipmentSlots;
}

bool BotMgr::IsClassEnabled(uint8 m_class)
{
    switch (m_class)
    {
        case BOT_CLASS_BM:
            return _enableclass_blademaster;
        case BOT_CLASS_SPHYNX:
            return _enableclass_sphynx;
        case BOT_CLASS_ARCHMAGE:
            return _enableclass_archmage;
        case BOT_CLASS_DREADLORD:
            return _enableclass_dreadlord;
        case BOT_CLASS_SPELLBREAKER:
            return _enableclass_spellbreaker;
        case BOT_CLASS_DARK_RANGER:
            return _enableclass_darkranger;
        case BOT_CLASS_NECROMANCER:
            return _enableclass_necromancer;
        case BOT_CLASS_SEA_WITCH:
            return _enableclass_seawitch;
        default:
            return true;
    }
}

bool BotMgr::IsEnrageOnDimissEnabled()
{
    return _enrageOnDismiss;
}
bool BotMgr::IsBotStatsLimitsEnabled()
{
    return _botStatLimits;
}
bool BotMgr::IsPvPEnabled()
{
    return _botPvP;
}
bool BotMgr::IsFoodInterruptedByMovement()
{
    return _botMovementFoodInterrupt;
}
bool BotMgr::FilterRaces()
{
    return _filterRaces;
}
bool BotMgr::IsBotGenerationEnabledBGs()
{
    return _enableWanderingBotsBG;
}
uint8 BotMgr::GetMaxClassBots()
{
    return _maxClassNpcBots;
}
uint8 BotMgr::GetHealTargetIconFlags()
{
    return _healTargetIconFlags;
}
uint8 BotMgr::GetTankTargetIconFlags()
{
    return _tankingTargetIconFlags;
}
uint8 BotMgr::GetOffTankTargetIconFlags()
{
    return _offTankingTargetIconFlags;
}
uint8 BotMgr::GetDPSTargetIconFlags()
{
    return _dpsTargetIconFlags;
}
uint8 BotMgr::GetRangedDPSTargetIconFlags()
{
    return _rangedDpsTargetIconFlags;
}
uint8 BotMgr::GetNoDPSTargetIconFlags()
{
    return _noDpsTargetIconFlags;
}
uint32 BotMgr::GetBaseUpdateDelay()
{
    return _npcBotUpdateDelayBase;
}
uint32 BotMgr::GetOwnershipExpireTime()
{
    return _npcBotOwnerExpireTime;
}
uint32 BotMgr::GetDesiredWanderingBotsCount()
{
    return _desiredWanderingBotsCount;
}
float BotMgr::GetBotStatLimitDodge()
{
    return _botStatLimits_dodge;
}
float BotMgr::GetBotStatLimitParry()
{
    return _botStatLimits_parry;
}
float BotMgr::GetBotStatLimitBlock()
{
    return _botStatLimits_block;
}
float BotMgr::GetBotStatLimitCrit()
{
    return _botStatLimits_crit;
}

uint8 BotMgr::GetNpcBotXpReduction()
{
    return _xpReductionNpcBots;
}

uint8 BotMgr::GetMaxNpcBots()
{
    return _maxNpcBots <= MAXRAIDSIZE - 1 ? _maxNpcBots : MAXRAIDSIZE - 1;
}

int32 BotMgr::GetBotInfoPacketsLimit()
{
    return _botInfoPacketsLimit;
}

bool BotMgr::LimitBots(Map const* map)
{
    if (map->IsBattlegroundOrArena())
        return true;

    if (_limitNpcBotsDungeons && map->IsNonRaidDungeon())
        return true;
    if (_limitNpcBotsRaids && map->IsRaid())
        return true;

    return false;
}

bool BotMgr::CanBotParryWhileCasting(Creature const* bot)
{
    switch (bot->GetBotClass())
    {
        case BOT_CLASS_SEA_WITCH:
            return true;
        default:
            return false;
    }
}

bool BotMgr::IsWanderingWorldBot(Creature const* bot)
{
    return (bot->IsWandererBot() && !(bot->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_XP));
}

void BotMgr::Update(uint32 diff)
{
    //remove temp bots from bot map before updating it
    while (!_removeList.empty())
    {
        std::list<ObjectGuid>::iterator itr = _removeList.begin();

        BotMap::iterator bitr = _bots.find(*itr);
        ASSERT(bitr != _bots.end());
        _bots.erase(bitr);

        _removeList.erase(itr);
    }

    _dpstracker->Update(diff);

    if (!HaveBot())
        return;

    //ObjectGuid guid;
    Creature* bot;
    bot_ai* ai;
    bool partyCombat = IsPartyInCombat();
    bool restrictBots = RestrictBots(nullptr, false);

    _aoespots.clear();
    if (partyCombat)
        bot_ai::CalculateAoeSpots(_owner, _aoespots);

    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        //guid = itr->first;
        bot = itr->second;
        ai = bot->GetBotAI();

        if (ai->IAmFree())
            continue;

        if (!bot->IsInWorld())
        {
            ai->CommonTimers(diff);
            continue;
        }

        if (partyCombat == false || _owner->InBattleground())
            ai->UpdateReviveTimer(diff);

        //bot->IsAIEnabled = true;

        if (ai->GetReviveTimer() <= diff)
        {
            if (bot->IsInMap(_owner) && !bot->IsAlive() && !ai->IsDuringTeleport() && _owner->IsAlive() && !_owner->IsInCombat() &&
                !_owner->IsBeingTeleported() && !_owner->InArena() && !_owner->IsInFlight() &&
                !_owner->HasUnitFlag2(UNIT_FLAG2_FEIGN_DEATH) &&
                !_owner->HasInvisibilityAura() && !_owner->HasStealthAura())
            {
                _reviveBot(bot);
                continue;
            }

            ai->SetReviveTimer(urand(1000, 5000));
        }

        if (_owner->IsAlive() && (bot->IsAlive() || restrictBots) && !ai->IsTempBot() && !ai->IsDuringTeleport() &&
            (restrictBots || bot->GetMap() != _owner->GetMap() ||
            (!bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_STAY) && _owner->GetDistance(bot) > SIZE_OF_GRIDS)))
        {
            //_owner->m_Controlled.erase(bot);
            TeleportBot(bot, _owner->GetMap(), _owner, _quickrecall);
            continue;
        }

        ai->canUpdate = true;
        bot->Update(diff);
        ai->canUpdate = false;
    }

    if (_quickrecall)
    {
        _quickrecall = false;
        _botsHidden = false;
    }
}

bool BotMgr::RestrictBots(Creature const* bot, bool add) const
{
    if (!_owner->FindMap())
        return true;

    if (_owner->IsInFlight())
        return true;

    if (_botsHidden)
        return true;

    Map const* currMap = _owner->GetMap();

    if ((!_enableNpcBotsBGs && currMap->IsBattleground()) ||
        (!_enableNpcBotsArenas && currMap->IsBattleArena()) ||
        (!_enableNpcBotsDungeons && currMap->IsNonRaidDungeon()) ||
        (!_enableNpcBotsRaids && currMap->IsRaid()))
        return true;

    if (LimitBots(currMap))
    {
        //if bot is not in instance group - deny (only if trying to teleport to instance)
        if (add)
            if (!_owner->GetGroup() || !_owner->GetGroup()->IsMember(bot->GetGUID()))
                return true;

        uint32 max_players = 0;
        if (currMap->IsDungeon())
            max_players = currMap->ToInstanceMap()->GetMaxPlayers();
        else if (currMap->IsBattleground())
            max_players = _owner->GetBattleground()->GetMaxPlayersPerTeam();
        else if (currMap->IsBattleArena())
            max_players = _owner->GetBattleground()->GetArenaType();

        if (max_players && currMap->GetPlayersCountExceptGMs() + uint32(add) > max_players)
            return true;
    }

    return false;
}

bool BotMgr::IsPartyInCombat() const
{
    if (_owner->IsInCombat())
        return true;

    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        if (!itr->second->IsInWorld())
            continue;
        if (itr->second->IsInCombat())
            return true;
        if (Unit const* pet = itr->second->GetBotsPet())
            if (pet->IsInCombat())
                return true;
    }

    return false;
}

bool BotMgr::HasBotClass(uint8 botclass) const
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        if (itr->second->GetBotClass() == botclass)
            return true;

    return false;
}

bool BotMgr::HasBotWithSpec(uint8 spec, bool alive) const
{
    for (BotMap::const_iterator itr = _bots.cbegin(); itr != _bots.cend(); ++itr)
        if (itr->second->GetBotAI()->GetSpec() == spec && (!alive || itr->second->IsAlive()))
            return true;

    return false;
}

bool BotMgr::HasBotPetType(uint32 petType) const
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        if (itr->second->GetBotsPet() && itr->second->GetBotAI()->GetAIMiscValue(BOTAI_MISC_PET_TYPE) == petType)
            return true;

    return false;
}

bool BotMgr::IsBeingResurrected(WorldObject const* corpse) const
{
    std::vector<Unit const*> casters;
    if (_owner->IsNonMeleeSpellCast(false, true, true))
        casters.push_back(_owner);
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        if (itr->second->IsNonMeleeSpellCast(false, true, true))
            casters.push_back(itr->second);
    }

    if (Group const* group = _owner->GetGroup())
    {
        for (GroupReference const* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player const* player = itr->GetSource();
            if (!player || player == _owner || player->FindMap() != corpse->GetMap())
                continue;

            if (player->IsNonMeleeSpellCast(false, true, true))
                casters.push_back(player);

            if (player->HaveBot())
            {
                BotMap const* map = player->GetBotMgr()->GetBotMap();
                for (BotMap::const_iterator bitr = map->begin(); bitr != map->end(); ++bitr)
                {
                    if (bitr->second->IsNonMeleeSpellCast(false, true, true))
                        casters.push_back(bitr->second);
                }
            }
        }
    }

    for (Unit const* caster : casters)
    {
        if (Spell const* spell = caster->GetCurrentSpell(CURRENT_GENERIC_SPELL))
        {
            if (corpse->GetGUID() == (corpse->ToCorpse() ? spell->m_targets.GetCorpseTargetGUID() : spell->m_targets.GetUnitTargetGUID()))
                return true;
        }
    }

    return false;
}

void BotMgr::_reviveBot(Creature* bot, WorldLocation* dest)
{
    if (bot->IsAlive() || !bot->IsInWorld())
        return;

    if (!bot->GetBotAI()->IAmFree())
    {
        if (!dest)
            bot->CastSpell(bot, COSMETIC_RESURRECTION, false);

        if (!dest)
            dest = bot->GetBotOwner();

        bot->NearTeleportTo(dest->GetPositionX(), dest->GetPositionY(), dest->GetPositionZ(), dest->GetOrientation());
        //some weird pos manipulation
        if (dest != bot)
            bot->Relocate(dest);
    }

    bot->SetDisplayId(bot->GetNativeDisplayId());
    bot->ReplaceAllNpcFlags(NPCFlags(bot->GetCreatureTemplate()->npcflag));
    bot->ClearUnitState(uint32(UNIT_STATE_ALL_STATE & ~(UNIT_STATE_IGNORE_PATHFINDING | UNIT_STATE_NO_ENVIRONMENT_UPD)));
    bot->ReplaceAllUnitFlags(UnitFlags(0));
    bot->SetLootRecipient(nullptr);
    bot->ResetPlayerDamageReq();
    bot->SetPvP(bot->GetBotOwner()->IsPvP());
    bot->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
    bot->Motion_Initialize();
    bot->setDeathState(ALIVE);
    //bot->GetBotAI()->Reset();
    bot->GetBotAI()->SetShouldUpdateStats();

    uint8 restore_factor = (bot->IsWandererBot() || (!bot->GetBotAI()->IAmFree() && bot->GetBotOwner()->InBattleground())) ? 1 : 4;
    bot->SetHealth(bot->GetMaxHealth() / restore_factor); //25% of max health
    if (bot->GetMaxPower(POWER_MANA) > 1)
        bot->SetPower(POWER_MANA, bot->GetMaxPower(POWER_MANA) / restore_factor); //25% of max mana

    if (!bot->GetBotAI()->IAmFree() && !bot->GetBotAI()->HasBotCommandState(BOT_COMMAND_MASK_UNMOVING))
        bot->GetBotAI()->SetBotCommandState(BOT_COMMAND_FOLLOW, true);
}

Creature* BotMgr::GetBot(ObjectGuid guid) const
{
    BotMap::const_iterator itr = _bots.find(guid);
    return itr != _bots.end() ? itr->second : nullptr;
}

Creature* BotMgr::GetBotByName(std::string_view name) const
{
    std::wstring wname;
    if (Utf8toWStr(name, wname))
    {
        wstrToLower(wname);
        for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        {
            if (!itr->second)
                continue;

            std::string basename = itr->second->GetName();
            if (CreatureLocale const* creatureInfo = sObjectMgr->GetCreatureLocale(itr->second->GetEntry()))
            {
                uint32 loc = _owner->GetSession()->GetSessionDbLocaleIndex();
                if (creatureInfo->Name.size() > loc && !creatureInfo->Name[loc].empty())
                    basename = creatureInfo->Name[loc];
            }

            std::wstring wbname;
            if (!Utf8toWStr(basename, wbname))
                continue;

            wstrToLower(wbname);
            if (wbname == wname)
                return itr->second;
        }
    }

    return nullptr;
}

std::list<Creature*> BotMgr::GetAllBotsByClass(uint8 botclass) const
{
    std::list<Creature*> foundBots;
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        if (!itr->second || !itr->second->IsInWorld() || !itr->second->IsAlive())
            continue;

        if (itr->second->GetBotClass() == botclass)
            foundBots.push_back(itr->second);
    }

    return foundBots;
}

void BotMgr::OnOwnerSetGameMaster(bool on)
{
    Creature* bot;
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        bot = itr->second;
        if (!bot)
            continue;

        bot->SetFaction(_owner->GetFaction());
        //bot->getHostileRefManager().setOnlineOfflineState(!on);
        bot->SetByteValue(UNIT_FIELD_BYTES_2, 1, _owner->GetByteValue(UNIT_FIELD_BYTES_2, 1)); //pvp state

        if (on && bot->IsInWorld())
            bot->CombatStop(true);

        if (Unit* pet = bot->GetBotsPet())
        {
            pet->SetFaction(_owner->GetFaction());
            //pet->getHostileRefManager().setOnlineOfflineState(!on);
            pet->SetByteValue(UNIT_FIELD_BYTES_2, 1, _owner->GetByteValue(UNIT_FIELD_BYTES_2, 1)); //pvp state

            if (on)
                pet->CombatStop(true);
        }
    }
}

void BotMgr::OnTeleportFar(uint32 mapId, float x, float y, float z, float ori)
{
    Map* newMap = sMapMgr->CreateBaseMap(mapId);
    Creature* bot;
    Position pos;
    pos.Relocate(x, y, z, ori);

    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        bot = itr->second;
        ASSERT(bot, "BotMgr::OnTeleportFar(): bot does not exist!!!");

        if (bot->IsTempBot())
            continue;

        //_owner->m_Controlled.erase(bot);
        TeleportBot(bot, newMap, &pos);
    }
}

void BotMgr::_teleportBot(Creature* bot, Map* newMap, float x, float y, float z, float ori, bool quick, bool reset)
{
    ASSERT(bot->GetBotAI());
    bot->GetBotAI()->AbortTeleport();
    bot->GetBotAI()->SetIsDuringTeleport(true);
    bot->GetBotAI()->KillEvents(true);

    BotMgr::AddDelayedTeleportCallback([bot, newMap, x, y, z, ori, quick, reset]() {
        if (bot->GetVehicle())
            bot->ExitVehicle();

        if (bot->GetTransport())
        {
            bot->ClearUnitState(UNIT_STATE_IGNORE_PATHFINDING);
            bot->GetTransport()->RemovePassenger(bot, true);
        }

        Map* mymap = bot->FindMap();
        if (mymap)
        {
            bot->BotStopMovement();
            bot->GetBotAI()->UnsummonAll();

            bot->InterruptNonMeleeSpells(true);

            if (bot->IsInWorld())
            {
                if (Battleground* bg = bot->GetBotBG())
                    bg->EventBotDroppedFlag(bot);

                bot->CastSpell(bot, COSMETIC_TELEPORT_EFFECT, true);

                if (!bot->IsFreeBot())
                    if (InstanceScript* iscr = bot->GetBotOwner()->GetInstanceScript())
                        iscr->OnNPCBotLeave(bot);

                bot->RemoveFromWorld();
            }

            ASSERT(bot->GetGUID());

            bot->RemoveAllGameObjects();

            bot->m_Events.KillAllEvents(false);
            bot->CombatStop();
            bot->ClearComboPoints();
            bot->ClearComboPointHolders();

            mymap->RemoveFromMap(bot, false);
        }

        if (bot->IsFreeBot())
        {
            bot->Relocate(x, y, z, ori);
            bot->SetMap(newMap);
            newMap->AddToMap(bot);
            if (reset)
                bot->GetBotAI()->Reset();
            bot->GetBotAI()->SetIsDuringTeleport(false);

            if (newMap->IsBattleground())
            {
                Battleground* bg = bot->GetBotAI()->GetBG();
                if (!bg)
                {
                    BotDataMgr::DespawnWandererBot(bot->GetEntry());
                    return;
                }

                if (newMap != mymap)
                {
                    //we teleport from base non-instanced map which normally doesn't exist
                    ASSERT(mymap->GetPlayersCountExceptGMs() == 0);

                    bg->AddBot(bot);
                }

                if (!bot->IsAlive())
                {
                    ObjectGuid shGuid = ObjectGuid::Empty;
                    float mindist = 0.0f;
                    for (ObjectGuid bgCreGuid : bg->BgCreatures)
                    {
                        if (Creature const* bgCre = newMap->GetCreature(bgCreGuid))
                        {
                            if (bgCre->IsSpiritService())
                            {
                                float dist = bot->GetExactDist2d(bgCre);
                                if (shGuid == ObjectGuid::Empty || dist < mindist)
                                {
                                    mindist = dist;
                                    shGuid = bgCreGuid;
                                }
                            }
                        }
                    }
                    if (shGuid)
                        bg->AddPlayerToResurrectQueue(shGuid, bot->GetGUID());
                    else
                    {
                        LOG_ERROR("npcbots", "TeleportBot: Bot {} '{}' can't find SpiritHealer in bg {}!",
                            bot->GetEntry(), bot->GetName().c_str(), bg->GetName().c_str());
                    }
                }
            }

            bot->GetBotAI()->canUpdate = true;

            return;
        }

        bot->GetBotAI()->AbortTeleport();

        //update group member online state
        if (Group* gr = bot->GetBotOwner()->GetGroup())
            if (gr->IsMember(bot->GetGUID()))
                gr->SendUpdate();

        TeleportFinishEvent* finishEvent = new TeleportFinishEvent(bot->GetBotAI(), reset);
        uint64 delay = quick ? urand(500, 1500) : urand(5000, 8000);
        bot->GetBotAI()->GetEvents()->AddEvent(finishEvent, bot->GetBotAI()->GetEvents()->CalculateTime(delay));
        bot->GetBotAI()->SetTeleportFinishEvent(finishEvent);
    });
}

void BotMgr::TeleportBot(Creature* bot, Map* newMap, Position const* pos, bool quick, bool reset)
{
    _teleportBot(bot, newMap, pos->GetPositionX(), pos->GetPositionY(), pos->GetPositionZ(), pos->GetOrientation(), quick, reset);
}

void BotMgr::CleanupsBeforeBotDelete(ObjectGuid guid, uint8 removetype)
{
    BotMap::const_iterator itr = _bots.find(guid);
    ASSERT(itr != _bots.end(), "Trying to remove bot which does not belong to this botmgr(b)!!");
    //ASSERT(_owner->IsInWorld(), "Trying to remove bot while not in world(b)!!");

    Creature* bot = itr->second;

    ASSERT(bot->GetCreatorGUID() == _owner->GetGUID());

    RemoveBotFromBGQueue(bot);
    if (removetype != BOT_REMOVE_LOGOUT)
        RemoveBotFromGroup(bot);

    CleanupsBeforeBotDelete(bot);
}

void BotMgr::CleanupsBeforeBotDelete(Creature* bot)
{
    //don't allow removing bots while they are teleporting
    if (!bot->IsInWorld())
        bot->GetBotAI()->AbortTeleport();

    if (bot->GetVehicle())
        bot->ExitVehicle();

    //remove any summons
    bot->GetBotAI()->UnsummonAll();
    bot->AttackStop();
    bot->CombatStopWithPets(true);

    //bot->SetOwnerGUID(ObjectGuid::Empty);
    //_owner->m_Controlled.erase(bot);
    bot->SetControlledByPlayer(false);
    //bot->RemoveUnitFlag(UNIT_FLAG_PVP_ATTACKABLE);
    bot->SetByteValue(UNIT_FIELD_BYTES_2, 1, 0);
    bot->SetCreator(nullptr);

    Map* map = bot->FindMap();
    if (!map || map->IsDungeon())
        bot->RemoveFromWorld();
}

void BotMgr::RemoveAllBots(uint8 removetype)
{
    while (!_bots.empty())
        RemoveBot(_bots.begin()->second->GetGUID(), removetype);
}
//Bot is being abandoned by player
void BotMgr::RemoveBot(ObjectGuid guid, uint8 removetype)
{
    BotMap::const_iterator itr = _bots.find(guid);
    ASSERT(itr != _bots.end(), "Trying to remove bot which does not belong to this botmgr(a)!!");
    //ASSERT(_owner->IsInWorld(), "Trying to remove bot while not in world(a)!!");

    //trying to remove temp bot second time means removing all bots
    //just erase from bots because already cleaned up
    for (std::list<ObjectGuid>::iterator it = _removeList.begin(); it != _removeList.end(); ++it)
    {
        if (*it == guid)
        {
            _removeList.erase(it);
            _bots.erase(itr);
            return;
        }
    }

    Creature* bot = itr->second;
    CleanupsBeforeBotDelete(guid, removetype);

    ////remove control bar
    //if (GetNpcBotsCount() <= 1 && !_owner->GetPetGUID() && _owner->m_Controlled.empty())
    //    _owner->SendRemoveControlBar();

    if (bot->GetBotAI()->IsTempBot())
    {
        //bot->GetBotAI()->OnBotDespawn(bot); //send to self
        _removeList.push_back(guid);
        return;
    }

    _bots.erase(itr);

    BotAIResetType resetType;
    switch (removetype)
    {
        case BOT_REMOVE_DISMISS: resetType = BOTAI_RESET_DISMISS; break;
        case BOT_REMOVE_UNBIND:  resetType = BOTAI_RESET_UNBIND;    break;
        default:                 resetType = BOTAI_RESET_LOGOUT;  break;
    }
    bot->GetBotAI()->ResetBotAI(resetType);

    bot->SetFaction(bot->GetCreatureTemplate()->faction);
    bot->SetLevel(bot->GetCreatureTemplate()->minlevel);

    if (removetype == BOT_REMOVE_DISMISS)
    {
        BotDataMgr::ResetNpcBotTransmogData(bot->GetEntry(), false);
        uint32 newOwner = 0;
        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_OWNER, &newOwner);
    }
}

void BotMgr::UnbindBot(ObjectGuid guid)
{
    Creature const* bot = GetBot(guid);
    ASSERT(bot);

    RemoveBot(guid, BOT_REMOVE_UNBIND);
    bot->GetBotAI()->SetBotCommandState(BOT_COMMAND_UNBIND);
}
BotAddResult BotMgr::RebindBot(Creature* bot)
{
    BotAddResult res = AddBot(bot);
    if (res == BOT_ADD_SUCCESS)
        bot->GetBotAI()->RemoveBotCommandState(BOT_COMMAND_UNBIND);
    return res;
}

BotAddResult BotMgr::AddBot(Creature* bot)
{
    ASSERT(bot->IsNPCBot());
    ASSERT(bot->GetBotAI() != nullptr);

    bool owned = bot->GetBotAI()->IsTempBot() || bot->GetBotAI()->GetBotOwnerGuid() == _owner->GetGUID().GetCounter();
    uint8 owned_count = BotDataMgr::GetOwnedBotsCount(_owner->GetGUID());
    uint8 class_count = BotDataMgr::GetOwnedBotsCount(_owner->GetGUID(), bot->GetClassMask());

    if (!_enableNpcBots)
    {
        ChatHandler ch(_owner->GetSession());
        ch.SendSysMessage(bot_ai::LocalizedNpcText(GetOwner(), BOT_TEXT_BOTADDFAIL_DISABLED).c_str());
        return BOT_ADD_DISABLED;
    }
    if (GetBot(bot->GetGUID()))
        return BOT_ADD_ALREADY_HAVE; //Silent error, intended
    if (!bot->GetBotAI()->IAmFree())
    {
        ChatHandler ch(_owner->GetSession());
        ch.PSendSysMessage(bot_ai::LocalizedNpcText(GetOwner(), BOT_TEXT_BOTADDFAIL_OWNED).c_str(),
            bot->GetName().c_str(), bot->GetBotOwner()->GetName().c_str());
        return BOT_ADD_NOT_AVAILABLE;
    }
    if (bot->GetBotAI()->IsDuringTeleport())
    {
        ChatHandler ch(_owner->GetSession());
        ch.PSendSysMessage(bot_ai::LocalizedNpcText(GetOwner(), BOT_TEXT_BOTADDFAIL_TELEPORTED).c_str(), bot->GetName().c_str());
        return BOT_ADD_BUSY;
    }
    if (!owned && owned_count >= GetMaxNpcBots())
    {
        ChatHandler ch(_owner->GetSession());
        ch.PSendSysMessage(bot_ai::LocalizedNpcText(GetOwner(), BOT_TEXT_HIREFAIL_MAXBOTS).c_str(), GetMaxNpcBots());
        return BOT_ADD_MAX_EXCEED;
    }
    if (!owned && _maxClassNpcBots && class_count >= _maxClassNpcBots)
    {
        ChatHandler ch(_owner->GetSession());
        ch.PSendSysMessage(bot_ai::LocalizedNpcText(GetOwner(), BOT_TEXT_HIREFAIL_MAXCLASSBOTS).c_str(), class_count, _maxClassNpcBots);
        return BOT_ADD_MAX_CLASS_EXCEED;
    }
    //Map* curMap = _owner->GetMap();
    //if (!temporary && LimitBots(curMap))
    //{
    //    InstanceMap* map = curMap->ToInstanceMap();
    //    uint32 count = map->GetPlayersCountExceptGMs();
    //    if (count >= map->GetMaxPlayers())
    //    {
    //        ChatHandler ch(_owner->GetSession());
    //        ch.PSendSysMessage("Instance players limit exceed (%u of %u)", count, map->GetMaxPlayers());
    //        return BOT_ADD_INSTANCE_LIMIT;
    //    }
    //}
    if (!owned)
    {
        uint32 cost = GetNpcBotCost(_owner->GetLevel(), bot->GetBotClass());
        if (!_owner->HasEnoughMoney(cost))
        {
            ChatHandler ch(_owner->GetSession());
            std::string str = bot_ai::LocalizedNpcText(GetOwner(), BOT_TEXT_HIREFAIL_COST) + " (";
            str += GetNpcBotCostStr(_owner->GetLevel(), bot->GetBotClass());
            str += ")!";
            ch.SendSysMessage(str.c_str());
            return BOT_ADD_CANT_AFFORD;
        }

        _owner->ModifyMoney(-(int32(cost)));
    }

    bot->GetBotAI()->canUpdate = false;

    if (!bot->IsAlive())
        _reviveBot(bot);

    bot->GetBotAI()->UnsummonAll();

    _bots[bot->GetGUID()] = bot;

    ASSERT(!bot->GetCreatorGUID());
    //bot->SetOwnerGUID(_owner->GetGUID());
    bot->SetCreator(_owner); //needed in case of FFAPVP
    //_owner->m_Controlled.insert(bot);
    bot->SetControlledByPlayer(true);
    bot->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
    bot->SetByteValue(UNIT_FIELD_BYTES_2, 1, _owner->GetByteValue(UNIT_FIELD_BYTES_2, 1));
    bot->SetFaction(_owner->GetFaction());
    bot->SetPhaseMask(_owner->GetPhaseMask(), true);

    bot->GetBotAI()->SetBotOwner(_owner);

    bot->GetBotAI()->Reset();

    if (!bot->GetBotAI()->IsTempBot())
    {
        bot->GetBotAI()->SetBotCommandState(BOT_COMMAND_FOLLOW, true);
        if (bot->GetBotAI()->HasRole(BOT_ROLE_PARTY))
            AddBotToGroup(bot);

        uint32 newOwner = _owner->GetGUID().GetCounter();
        BotDataMgr::UpdateNpcBotData(bot->GetEntry(), NPCBOT_UPDATE_OWNER, &newOwner);
    }

    return BOT_ADD_SUCCESS;
}

bool BotMgr::AddBotToGroup(Creature* bot)
{
    ASSERT(GetBot(bot->GetGUID()));

    Group* gr = _owner->GetGroup();
    if (gr)
    {
        if (gr->IsMember(bot->GetGUID()))
            return true;

        if (gr->IsFull())
        {
            if (!gr->isRaidGroup()) //non-raid group is full
                gr->ConvertToRaid();
            else
                return false;
        }
    }
    else
    {
        gr = new Group;
        if (!gr->Create(_owner))
        {
            delete gr;
            return false;
        }
        sGroupMgr->AddGroup(gr);
    }

    if (gr->AddMember(bot))
    {
        if (!bot->GetBotAI()->HasRole(BOT_ROLE_PARTY))
            bot->GetBotAI()->ToggleRole(BOT_ROLE_PARTY, true);

        return true;
    }

    return false;
}

void BotMgr::RemoveBotFromBGQueue(Creature const* bot)
{
    for (uint8 i = 0; i < PLAYER_MAX_BATTLEGROUND_QUEUES; ++i)
    {
        if (BattlegroundQueueTypeId bgQueueTypeId = _owner->GetBattlegroundQueueTypeId(i))
            sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId).RemovePlayer(bot->GetGUID(), true);
    }
}

bool BotMgr::RemoveBotFromGroup(Creature* bot)
{
    ASSERT(GetBot(bot->GetGUID()));

    Group* gr = _owner->GetGroup();
    if (!gr || !gr->IsMember(bot->GetGUID()))
        return false;

    RemoveBotFromBGQueue(bot);

    if (bot->GetBotAI()->HasRole(BOT_ROLE_PARTY) && !_owner->GetSession()->PlayerLogout())
        bot->GetBotAI()->ToggleRole(BOT_ROLE_PARTY, true);

    //debug
    //if (gr->RemoveMember(bot->GetGUID()))
    //    TC_LOG_ERROR("entities.player", "RemoveBotFromGroup(): bot %s removed from group", bot->GetName().c_str());
    //else
    //    TC_LOG_ERROR("entities.player", "RemoveBotFromGroup(): RemoveMember() returned FALSE on bot %s", bot->GetName().c_str());

    gr->RemoveMember(bot->GetGUID());

    //if removed from group while in instance / bg then remove from world immediately
    if (bot->IsInWorld() && RestrictBots(bot, true))
        TeleportBot(bot, bot->GetMap(), bot);

    return true;
}

bool BotMgr::RemoveAllBotsFromGroup()
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        RemoveBotFromGroup(itr->second);

    return true;
}

uint32 BotMgr::GetNpcBotCost(uint8 level, uint8 botclass)
{
    //assuming default 1000000
    //level 1: 500  //5  silver
    //10 : 10000    //1  gold
    //20 : 50000    //5  gold
    //30 : 200000   //20 gold
    //40 : 500000   //50 gold
    //rest is linear
    //rare / rareelite bots have their cost adjusted
    uint32 cost =
        level < 10 ? _npcBotsCost / 2000 : //5 silver
        level < 20 ? _npcBotsCost / 100 :  //1 gold
        level < 30 ? _npcBotsCost / 20 :   //5 gold
        level < 40 ? _npcBotsCost / 5 :    //20 gold
        (_npcBotsCost * level) / DEFAULT_MAX_LEVEL; //50 - 100 gold

    switch (botclass)
    {
        case BOT_CLASS_BM:
        case BOT_CLASS_ARCHMAGE:
        case BOT_CLASS_SPELLBREAKER:
        case BOT_CLASS_NECROMANCER:
            cost += cost; //200%
            break;
        case BOT_CLASS_SPHYNX:
        case BOT_CLASS_DREADLORD:
        case BOT_CLASS_DARK_RANGER:
        case BOT_CLASS_SEA_WITCH:
            cost += cost * 4; //500%
            break;
        default:
            break;
    }

    return cost;
}

std::string BotMgr::GetNpcBotCostStr(uint8 level, uint8 botclass)
{
    std::ostringstream money;

    if (uint32 cost = GetNpcBotCost(level, botclass))
    {
        uint32 gold = uint32(cost / GOLD);
        cost -= (gold * GOLD);
        uint32 silver = uint32(cost / SILVER);
        cost -= (silver * SILVER);

        if (gold != 0)
            money << gold << " |TInterface\\Icons\\INV_Misc_Coin_01:8|t";
        if (silver != 0)
            money << silver << " |TInterface\\Icons\\INV_Misc_Coin_03:8|t";
        if (cost)
            money << cost << " |TInterface\\Icons\\INV_Misc_Coin_05:8|t";
    }

    return money.str();
}

uint8 BotMgr::BotClassByClassName(std::string const& className)
{
    static const std::map<std::string, uint8> BotClassNamesMap = {
        { "warrior", BOT_CLASS_WARRIOR },
        { "paladin", BOT_CLASS_PALADIN },
        { "hunter", BOT_CLASS_HUNTER },
        { "rogue", BOT_CLASS_ROGUE },
        { "priest", BOT_CLASS_PRIEST },
        { "deathknight", BOT_CLASS_DEATH_KNIGHT },
        { "death_knight", BOT_CLASS_DEATH_KNIGHT },
        { "shaman", BOT_CLASS_SHAMAN },
        { "mage", BOT_CLASS_MAGE },
        { "warlock", BOT_CLASS_WARLOCK },
        { "druid", BOT_CLASS_DRUID },
        { "blademaster", BOT_CLASS_BM },
        { "blade_master", BOT_CLASS_BM },
        { "sphynx", BOT_CLASS_SPHYNX },
        { "obsidiandestroyer", BOT_CLASS_SPHYNX },
        { "obsidian_destroyer", BOT_CLASS_SPHYNX },
        { "destroyer", BOT_CLASS_SPHYNX },
        { "archmage", BOT_CLASS_ARCHMAGE },
        { "dreadlord", BOT_CLASS_DREADLORD },
        { "spellbreaker", BOT_CLASS_SPELLBREAKER },
        { "spell_breaker", BOT_CLASS_SPELLBREAKER },
        { "darkranger", BOT_CLASS_DARK_RANGER },
        { "dark_ranger", BOT_CLASS_DARK_RANGER },
        { "necromancer", BOT_CLASS_NECROMANCER },
        { "necro", BOT_CLASS_NECROMANCER },
        { "seawitch", BOT_CLASS_SEA_WITCH },
        { "sea_witch", BOT_CLASS_SEA_WITCH },
        { "战士", BOT_CLASS_WARRIOR },
        { "圣骑士", BOT_CLASS_PALADIN },
        { "猎人", BOT_CLASS_HUNTER },
        { "潜行者", BOT_CLASS_ROGUE },
        { "牧师", BOT_CLASS_PRIEST },
        { "死亡骑士", BOT_CLASS_DEATH_KNIGHT },
        { "萨满祭司", BOT_CLASS_SHAMAN },
        { "法师", BOT_CLASS_MAGE },
        { "术士", BOT_CLASS_WARLOCK },
        { "德鲁伊", BOT_CLASS_DRUID },
        { "剑圣", BOT_CLASS_BM },
        { "毁灭者", BOT_CLASS_SPHYNX },
        { "大法师", BOT_CLASS_ARCHMAGE },
        { "恐惧魔王", BOT_CLASS_DREADLORD },
        { "破法者", BOT_CLASS_SPELLBREAKER },
        { "黑暗游侠", BOT_CLASS_DARK_RANGER },
        { "死灵法师", BOT_CLASS_NECROMANCER },
        { "海妖", BOT_CLASS_SEA_WITCH }
    };

    //std::transform(className.begin(), className.end(), className.begin(), std::tolower);
    auto iter = BotClassNamesMap.find(className);
    if (iter != BotClassNamesMap.end())
        return iter->second;

    return BOT_CLASS_NONE;
}

std::string BotMgr::GetTargetIconString(uint8 icon) const
{
    std::ostringstream ss;
    ss << "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_" << uint32(icon) << ":12|t";
    if (size_t(icon - 1) < TargetIconNamesCacheSize)
        ss << _targetIconNamesCache[icon - 1];

    return ss.str();
}
void BotMgr::UpdateTargetIconName(uint8 id, std::string const& name)
{
    if (id >= TargetIconNamesCacheSize)
        return;

    _targetIconNamesCache[id] = name;
}
void BotMgr::ResetTargetIconNames()
{
    _targetIconNamesCache = {};
}

void BotMgr::ReviveAllBots()
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        _reviveBot(itr->second);
}

void BotMgr::SendBotCommandState(uint8 state)
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        itr->second->GetBotAI()->SetBotCommandState(state, true);
}

void BotMgr::SendBotCommandStateRemove(uint8 state)
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        itr->second->GetBotAI()->RemoveBotCommandState(state);
}

void BotMgr::SendBotAwaitState(uint8 state)
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        itr->second->GetBotAI()->SetBotAwaitState(state);
}

void BotMgr::RecallAllBots(bool teleport)
{
    if (teleport)
    {
        _botsHidden = true;
        _quickrecall = true;
    }
    else
    {
        for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
            if (itr->second->IsInWorld() && itr->second->IsAlive() && !bot_ai::CCed(itr->second, true))
                itr->second->GetMotionMaster()->MovePoint(_owner->GetMapId(), *_owner, false);
    }
}

void BotMgr::RecallBot(Creature* bot)
{
    ASSERT(GetBot(bot->GetGUID()));

    if (bot->IsInWorld() && bot->IsAlive() && !bot_ai::CCed(bot, true))
        bot->GetMotionMaster()->MovePoint(_owner->GetMapId(), *_owner, false);
}

void BotMgr::KillAllBots()
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        KillBot(itr->second);
}

void BotMgr::KillBot(Creature* bot)
{
    ASSERT(GetBot(bot->GetGUID()));

    if (bot->IsInWorld() && bot->IsAlive())
    {
        bot->setDeathState(JUST_DIED);
        bot->GetBotAI()->JustDied(bot);
        //bot->Kill(bot);
    }
}

void BotMgr::SetBotsShouldUpdateStats()
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
        itr->second->GetBotAI()->SetShouldUpdateStats();
}

void BotMgr::UpdatePhaseForBots()
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        itr->second->SetPhaseMask(_owner->GetPhaseMask(), itr->second->IsInWorld());
        if (itr->second->GetBotsPet())
            itr->second->GetBotsPet()->SetPhaseMask(_owner->GetPhaseMask(), true); //only if in world
    }
}

void BotMgr::UpdatePvPForBots()
{
    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        itr->second->SetByteValue(UNIT_FIELD_BYTES_2, 1, _owner->GetByteValue(UNIT_FIELD_BYTES_2, 1));
        if (itr->second->GetBotsPet())
            itr->second->GetBotsPet()->SetByteValue(UNIT_FIELD_BYTES_2, 1, _owner->GetByteValue(UNIT_FIELD_BYTES_2, 1));
    }
}

void BotMgr::PropagateEngageTimers() const
{
    uint32 delay_dps = GetEngageDelayDPS();
    uint32 delay_heal = GetEngageDelayHeal();

    if (!delay_dps && !delay_heal)
        return;

    for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
    {
        if (itr->second->GetBotAI()->IsTank())
            continue;

        bool is_heal = itr->second->GetBotAI()->HasRole(BOT_ROLE_HEAL);
        bool is_dps= itr->second->GetBotAI()->HasRole(BOT_ROLE_DPS);
        uint32 delay = (is_heal && is_dps) ? std::max<uint32>(delay_dps, delay_heal) : is_heal ? delay_heal : is_dps ? delay_dps : 0;

        itr->second->GetBotAI()->ResetEngageTimer(delay);
    }
}

void BotMgr::TrackDamage(Unit const* u, uint32 damage)
{
    _dpstracker->TrackDamage(u, damage);
}

uint32 BotMgr::GetDPSTaken(Unit const* u) const
{
    return _dpstracker->GetDPSTaken(u->GetGUID().GetRawValue());
}

int32 BotMgr::GetHPSTaken(Unit const* unit) const
{
    if (!HaveBot())
        return 0;

    std::list<Unit*> unitList;
    Group const* gr = _owner->GetGroup();
    if (!gr)
    {
        if (_owner->HasUnitState(UNIT_STATE_CASTING))
            unitList.push_back(_owner);
        for (BotMap::const_iterator itr = _bots.begin(); itr != _bots.end(); ++itr)
            if (itr->second->GetTarget() == unit->GetGUID() && itr->second->HasUnitState(UNIT_STATE_CASTING))
                unitList.push_back(itr->second);
    }
    else
    {
        bool Bots = false;
        for (GroupReference const* itr = gr->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* player = itr->GetSource();
            if (player == nullptr) continue;
            if (_owner->GetMap() != player->FindMap()) continue;
            if (!Bots)
                Bots = true;
            if (player->HasUnitState(UNIT_STATE_CASTING))
                unitList.push_back(player);
        }
        if (Bots)
        {
            for (GroupReference const* gitr = gr->GetFirstMember(); gitr != nullptr; gitr = gitr->next())
            {
                if (gitr->GetSource() == nullptr) continue;
                if (_owner->GetMap() != gitr->GetSource()->FindMap()) continue;

                if (gitr->GetSource()->HaveBot())
                {
                    BotMap const* map = gitr->GetSource()->GetBotMgr()->GetBotMap();
                    for (BotMap::const_iterator itr = map->begin(); itr != map->end(); ++itr)
                        if (itr->second->GetTarget() == unit->GetGUID() && itr->second->HasUnitState(UNIT_STATE_CASTING))
                            unitList.push_back(itr->second);
                }
            }
        }
    }

    int32 amount = 0;

    Unit* u;
    Spell const* spell;
    SpellInfo const* spellInfo;
    for (std::list<Unit*>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
    {
        u = *itr;

        for (uint8 i = CURRENT_FIRST_NON_MELEE_SPELL; i != CURRENT_AUTOREPEAT_SPELL; ++i)
        {
            spell = u->GetCurrentSpell(CurrentSpellTypes(i));
            if (!spell)
                continue;

            ObjectGuid targetGuid = spell->m_targets.GetObjectTargetGUID();
            if (!targetGuid || !targetGuid.IsUnit())
                continue;

            if (targetGuid != unit->GetGUID())
            {
                if (!gr || !gr->IsMember(unit->GetGUID()))
                    continue;
            }

            spellInfo = spell->GetSpellInfo();

            for (uint8 j = 0; j != MAX_SPELL_EFFECTS; ++j)
            {
                if (spellInfo->Effects[j].Effect != SPELL_EFFECT_HEAL)
                    continue;

                if (targetGuid != unit->GetGUID())
                {
                    if (spellInfo->Effects[j].TargetA.GetSelectionCategory() != TARGET_SELECT_CATEGORY_AREA)
                        continue;

                    //Targets t = spellInfo->Effects[j].TargetA.GetTarget();
                    //non-existing case
                    //if (t == TARGET_UNIT_CASTER_AREA_PARTY && !gr->SameSubGroup(u->GetGUID(), unit->GetGUID()))
                    //    continue;
                    Targets t = spellInfo->Effects[j].TargetB.GetTarget();
                    if (t == TARGET_UNIT_LASTTARGET_AREA_PARTY &&
                        !(GetBot(unit->GetGUID()) && GetBot(targetGuid)) &&
                        !gr->SameSubGroup(unit->GetGUID(), targetGuid))
                        continue;
                }

                int32 healing = u->SpellHealingBonusDone(const_cast<Unit*>(unit), spellInfo, spellInfo->Effects[0].CalcValue(u), HEAL, 0);
                healing = const_cast<Unit*>(unit)->SpellHealingBonusTaken(u, spellInfo, healing, HEAL);

                if (i == CURRENT_CHANNELED_SPELL)
                    amount += int32(healing / (spellInfo->Effects[j].Amplitude * 0.001f));
                else
                    amount += int32(healing / (std::max<int32>(spell->GetTimer(), 1000) * 0.001f));

                //TC_LOG_ERROR("entities.player", "BotMgr:pendingHeals: found %s's %s on %s in %u (%i, total %i)",
                //    u->GetName().c_str(), spellInfo->SpellName[0], target->GetName().c_str(), pheal->delay, healing, pheal->amount);
            }

            break;
        }
    }

    //HoTs
    Unit::AuraEffectList const& hots = unit->GetAuraEffectsByType(SPELL_AURA_PERIODIC_HEAL);
    for (Unit::AuraEffectList::const_iterator itr = hots.begin(); itr != hots.end(); ++itr)
        amount += int32((*itr)->GetAmount() / ((*itr)->GetAmplitude() * 0.001f));

    //if (amount != 0)
    //    TC_LOG_ERROR("entities.player", "BotMgr:GetHPSTaken(): %s got %i)", unit->GetName().c_str(), amount);

    return amount;
}

void BotMgr::OnBotWandererKilled(Creature const* bot, Player* looter)
{
    bot->GetBotAI()->SpawnKillReward(looter);
}

void BotMgr::OnBotWandererKilled(GameObject* go)
{
    if (go->GetEntry() == GO_BOT_MONEY_BAG && go->GetSpellId() > go->GetEntry())
    {
        uint32 bot_id = go->GetSpellId() - GO_BOT_MONEY_BAG;
        if (Creature const* bot = BotDataMgr::FindBot(bot_id))
            bot->GetBotAI()->FillKillReward(go);
    }
}

void BotMgr::OnBotSpellInterrupt(Unit const* caster, CurrentSpellTypes spellType)
{
    if (spellType == CURRENT_AUTOREPEAT_SPELL)
    {
        WorldPacket data(SMSG_CANCEL_AUTO_REPEAT, caster->GetPackGUID().size());
        data << caster->GetPackGUID();
        caster->SendMessageToSet(&data, true);
    }
}

void BotMgr::OnBotSpellGo(Unit const* caster, Spell const* spell, bool ok)
{
    if (caster->ToCreature()->GetBotAI())
        caster->ToCreature()->GetBotAI()->OnBotSpellGo(spell, ok);
    else if (caster->ToCreature()->GetBotPetAI())
        caster->ToCreature()->GetBotPetAI()->OnBotPetSpellGo(spell, ok);
}

void BotMgr::OnBotOwnerSpellGo(Unit const* caster, Spell const* spell, bool ok)
{
    BotMap const* bmap = caster->ToPlayer()->GetBotMgr()->GetBotMap();
    for (BotMap::const_iterator itr = bmap->begin(); itr != bmap->end(); ++itr)
    {
        if (Creature const* bot = itr->second)
        {
            if (!bot->IsInWorld() || !bot->IsAlive())
                continue;

            bot->GetBotAI()->OnBotOwnerSpellGo(spell, ok);
            //if (Creature const* botpet = bot->GetBotsPet())
            //    botpet->GetBotAI()->OnBotPetOwnerSpellGo(spell, ok);
        }
    }
}

void BotMgr::OnVehicleSpellGo(Unit const* caster, Spell const* spell, bool ok)
{
    if (caster->GetCharmerGUID().IsPlayer())
    {
        Unit const* owner = caster->GetCharmer();
        if (owner && owner->ToPlayer()->HaveBot())
        {
            BotMap const* bmap = owner->ToPlayer()->GetBotMgr()->GetBotMap();
            for (BotMap::const_iterator itr = bmap->begin(); itr != bmap->end(); ++itr)
            {
                if (Creature const* bot = itr->second)
                {
                    bot->GetBotAI()->OnBotOwnerSpellGo(spell, ok);
                    //if (Creature const* botpet = bot->GetBotsPet())
                    //    botpet->GetBotAI()->OnBotPetOwnerSpellGo(spell, ok);
                }
            }
        }
    }
    else if (caster->GetCharmerGUID().IsCreature())
    {
        Unit const* bot = caster->GetCharmer();
        if (bot->ToCreature()->GetBotAI())
            bot->ToCreature()->GetBotAI()->OnBotSpellGo(spell, ok);
    }
}

void BotMgr::OnVehicleAttackedBy(Unit* attacker, Unit const* victim)
{
    Unit const* owner = victim->GetCharmer();
    if (victim->GetCharmerGUID().IsPlayer())
        owner = victim->GetCharmer();
    else if (victim->GetCharmerGUID().IsCreature())
        if (Unit const* bot = victim->GetCharmer())
            owner = bot->ToCreature()->GetBotOwner();

    if (owner && owner->GetTypeId() == TYPEID_PLAYER && owner->ToPlayer()->HaveBot())
    {
        BotMap const* bmap = owner->ToPlayer()->GetBotMgr()->GetBotMap();
        for (BotMap::const_iterator itr = bmap->begin(); itr != bmap->end(); ++itr)
            if (Creature const* bot = itr->second)
                bot->GetBotAI()->OnOwnerVehicleDamagedBy(attacker);
    }
}

void BotMgr::OnBotDamageTaken(Unit* attacker, Unit* victim, uint32 damage, CleanDamage const* cleanDamage, DamageEffectType damagetype, SpellInfo const* spellInfo)
{
    victim->ToCreature()->GetBotAI()->OnBotDamageTaken(attacker, damage, cleanDamage , damagetype, spellInfo);
}

void BotMgr::OnBotDamageDealt(Unit* attacker, Unit* victim, uint32 damage, CleanDamage const* cleanDamage, DamageEffectType damagetype, SpellInfo const* spellInfo)
{
    attacker->ToCreature()->GetBotAI()->OnBotDamageDealt(victim, damage, cleanDamage, damagetype, spellInfo);
}

void BotMgr::OnBotDispelDealt(Unit* dispeller, Unit* dispelled, uint8 num)
{
    dispeller->ToCreature()->GetBotAI()->OnBotDispelDealt(dispelled, num);
}

void BotMgr::OnBotEnterVehicle(Creature const* passenger, Vehicle const* vehicle)
{
    passenger->GetBotAI()->OnBotEnterVehicle(vehicle);
}

void BotMgr::OnBotExitVehicle(Creature const* passenger, Vehicle const* vehicle)
{
    passenger->GetBotAI()->OnBotExitVehicle(vehicle);
}

void BotMgr::OnBotOwnerEnterVehicle(Player const* passenger, Vehicle const* vehicle)
{
    BotMap const* bmap = passenger->GetBotMgr()->GetBotMap();
    for (BotMap::const_iterator itr = bmap->begin(); itr != bmap->end(); ++itr)
        if (Creature const* bot = itr->second)
            if (bot->IsInWorld() && bot->IsAlive())
                bot->GetBotAI()->OnBotOwnerEnterVehicle(vehicle);
}

void BotMgr::OnBotOwnerExitVehicle(Player const* passenger, Vehicle const* vehicle)
{
    BotMap const* bmap = passenger->GetBotMgr()->GetBotMap();
    for (BotMap::const_iterator itr = bmap->begin(); itr != bmap->end(); ++itr)
        if (Creature const* bot = itr->second)
            if (bot->IsInWorld() && bot->IsAlive())
                bot->GetBotAI()->OnBotOwnerExitVehicle(vehicle);
}

void BotMgr::OnBotPartyEngage(Player const* owner)
{
    Group const* gr = owner->GetGroup();
    if (gr)
    {
        std::vector<Player const*> affectedPlayers;
        for (GroupReference const* itr = gr->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player const* player = itr->GetSource();
            if (!player || owner->GetMap() != player->FindMap() ||
                player->GetDistance(owner) > World::GetMaxVisibleDistanceOnContinents() ||
                !player->HaveBot())
                continue;

            if (player->GetBotMgr()->IsPartyInCombat())
                return;

            affectedPlayers.push_back(player);
        }
        for (Player const* p : affectedPlayers)
            p->GetBotMgr()->PropagateEngageTimers();
    }
    else
        owner->GetBotMgr()->PropagateEngageTimers();
}

void BotMgr::ApplyBotEffectMods(Unit const* caster, SpellInfo const* spellInfo, uint8 effIndex, float& value)
{
    caster->ToCreature()->GetBotAI()->ApplyBotEffectMods(spellInfo, effIndex, value);
}

void BotMgr::ApplyBotThreatMods(Unit const* attacker, SpellInfo const* spellInfo, float& threat)
{
    attacker->ToCreature()->GetBotAI()->ApplyBotThreatMods(spellInfo, threat);
}

void BotMgr::ApplyBotEffectValueMultiplierMods(Unit const* caster, SpellInfo const* spellInfo, SpellEffIndex effIndex, float& multiplier)
{
    caster->ToCreature()->GetBotAI()->ApplyBotEffectValueMultiplierMods(spellInfo, effIndex, multiplier);
}

float BotMgr::GetBotDamageTakenMod(Creature const* bot, bool magic)
{
    return bot->GetBotAI()->GetBotDamageTakenMod(magic);
}

int32 BotMgr::GetBotStat(Creature const* bot, BotStatMods stat)
{
    return bot->GetBotAI()->GetTotalBotStat(stat);
}

float BotMgr::GetBotResilience(Creature const* botOrPet)
{
    if (botOrPet->IsNPCBot())
        return botOrPet->GetBotAI()->GetBotResilience();

    return botOrPet->GetBotPetAI()->GetPetsOwner()->GetBotAI()->GetBotResilience();
}

float BotMgr::GetBotDamageModPhysical()
{
    return _mult_dmg_physical;
}
float BotMgr::GetBotDamageModSpell()
{
    return _mult_dmg_spell;
}
float BotMgr::GetBotHealingMod()
{
    return _mult_healing;
}
float BotMgr::GetBotHPMod()
{
    return _mult_hp;
}
float BotMgr::GetBotWandererDamageMod()
{
    return _mult_dmg_wanderer;
}
float BotMgr::GetBotWandererHealingMod()
{
    return _mult_healing_wanderer;
}
float BotMgr::GetBotWandererHPMod()
{
    return _mult_hp_wanderer;
}
float BotMgr::GetBotWandererSpeedMod()
{
    return _mult_speed_wanderer;
}
float BotMgr::GetBotDamageModByClass(uint8 botclass)
{
    switch (botclass)
    {
        case BOT_CLASS_WARRIOR:
            return _mult_dmg_warrior;
        case BOT_CLASS_PALADIN:
            return _mult_dmg_paladin;
        case BOT_CLASS_HUNTER:
            return _mult_dmg_hunter;
        case BOT_CLASS_ROGUE:
            return _mult_dmg_rogue;
        case BOT_CLASS_PRIEST:
            return _mult_dmg_priest;
        case BOT_CLASS_DEATH_KNIGHT:
            return _mult_dmg_deathknight;
        case BOT_CLASS_SHAMAN:
            return _mult_dmg_shaman;
        case BOT_CLASS_MAGE:
            return _mult_dmg_mage;
        case BOT_CLASS_WARLOCK:
            return _mult_dmg_warlock;
        case BOT_CLASS_DRUID:
            return _mult_dmg_druid;
        case BOT_CLASS_BM:
            return _mult_dmg_blademaster;
        case BOT_CLASS_SPHYNX:
            return _mult_dmg_obsidiandestroyer;
        case BOT_CLASS_ARCHMAGE:
            return _mult_dmg_archmage;
        case BOT_CLASS_DREADLORD:
            return _mult_dmg_dreadlord;
        case BOT_CLASS_SPELLBREAKER:
            return _mult_dmg_spellbreaker;
        case BOT_CLASS_DARK_RANGER:
            return _mult_dmg_darkranger;
        case BOT_CLASS_NECROMANCER:
            return _mult_dmg_necromancer;
        case BOT_CLASS_SEA_WITCH:
            return _mult_dmg_seawitch;
        default:
            return 1.0;
    }
}

void BotMgr::InviteBotToBG(ObjectGuid botguid, GroupQueueInfo* ginfo, Battleground* bg)
{
    Creature const* bot = BotDataMgr::FindBot(botguid.GetEntry());
    ASSERT(bot);

    bg->IncreaseInvitedCount(ginfo->teamId);
    //TC_LOG_INFO("npcbots", "Battleground: invited NPCBot %u to BG instance %u bgtype %u '%s'",
    //    botguid.GetEntry(), bg->GetInstanceID(), bg->GetTypeID(), bg->GetName().c_str());
}

bool BotMgr::IsBotInAreaTriggerRadius(Creature const* bot, AreaTrigger const* trigger)
{
    if (!trigger || !bot->IsInWorld() || bot->GetMap()->GetId() != trigger->map)
        return false;

    if (trigger->radius > 0.f)
    {
        // if we have radius check it
        float dist = bot->GetDistance(trigger->x, trigger->y, trigger->z);
        if (dist > trigger->radius)
            return false;
    }
    else
    {
        Position center(trigger->x, trigger->y, trigger->z, trigger->orientation);
        if (!bot->IsWithinBox(center, trigger->length / 2.f, trigger->width / 2.f, trigger->height / 2.f))
            return false;
    }

    return true;
}

BotMgr::delayed_teleport_mutex_type* BotMgr::_getTpLock()
{
    static BotMgr::delayed_teleport_mutex_type _lock;
    return &_lock;
}
void BotMgr::AddDelayedTeleportCallback(delayed_teleport_callback_type&& callback)
{
    delayed_teleport_lock_type lock(*_getTpLock());
    delayed_bot_teleports.push_back(std::forward<delayed_teleport_callback_type>(callback));
}
void BotMgr::HandleDelayedTeleports()
{
    for (auto& func : delayed_bot_teleports)
        func();
    delayed_bot_teleports.clear();
}

#ifdef _MSC_VER
# pragma warning(pop)
#endif
