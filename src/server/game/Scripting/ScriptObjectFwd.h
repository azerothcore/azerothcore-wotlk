/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef AC_SCRIPT_OBJECT_FWD_H_
#define AC_SCRIPT_OBJECT_FWD_H_

#include "Define.h"

// Core class
class AchievementGlobalMgr;
class AchievementMgr;
class ArenaTeam;
class AuctionHouseMgr;
class AuctionHouseObject;
class Aura;
class AuraApplication;
class AuraEffect;
class AuraScript;
class Battleground;
class BattlegroundMap;
class BattlegroundQueue;
class Channel;
class ChatHandler;
class Creature;
class CreatureAI;
class DynamicObject;
class GameObject;
class GameObjectAI;
class GridTerrainData;
class Group;
class Guardian;
class Guild;
class InstanceMap;
class InstanceSave;
class InstanceScript;
class Item;
class LootStore;
class LootTemplate;
class MailDraft;
class MailReceiver;
class MailSender;
class Map;
class MapInstanced;
class Object;
class OutdoorPvP;
class Pet;
class Player;
class Quest;
class Roll;
class Spell;
class SpellCastTargets;
class SpellInfo;
class SpellScript;
class TempSummon;
class TicketMgr;
class Transport;
class Unit;
class Vehicle;
class Weather;
class WorldObject;
class WorldPacket;
class WorldSession;
class WorldSocket;

enum ArenaTeamInfoType : uint8;
enum AuraRemoveMode : uint8;
enum BattlegroundDesertionType : uint8;
enum ClassContext : uint8;
enum ContentLevels : uint8;
enum DamageEffectType : uint8;
enum EnchantmentSlot : uint8;
enum EncounterCreditType : uint8;
enum EncounterState : uint8;
enum InventoryResult : uint8;
enum MailCheckMask : uint8;
enum PetType : uint8;
enum RollVote : uint8;
enum ShutdownExitCode : uint8;
enum ShutdownMask : uint8;
enum WeaponAttackType : uint8;
enum WeatherState : uint32;

struct AchievementCriteriaEntry;
struct AchievementEntry;
struct AreaTrigger;
struct AuctionEntry;
struct CompletedAchievementData;
struct Condition;
struct ConditionSourceInfo;
struct CreatureTemplate;
struct CriteriaProgress;
struct DungeonEncounter;
struct DungeonProgressionRequirements;
struct GroupQueueInfo;
struct InstanceTemplate;
struct ItemSetEffect;
struct ItemTemplate;
struct Loot;
struct LootItem;
struct LootStoreItem;
struct MapDifficulty;
struct MapEntry;
struct MovementInfo;
struct PvPDifficultyEntry;
struct QuestStatusData;
struct ScalingStatValuesEntry;
struct SpellModifier;
struct TargetInfo;
struct VendorItem;
struct SkillLineAbilityEntry;

// Dynamic linking class
class ModuleReference;

// Script objects
class SpellScriptLoader;

//
struct OutdoorPvPData;

namespace lfg
{
    struct LFGDungeonData;
}

namespace Acore
{
    namespace Asio
    {
        class IoContext;
    }

    namespace ChatCommands
    {
        struct ChatCommandBuilder;
    }
}

#endif
