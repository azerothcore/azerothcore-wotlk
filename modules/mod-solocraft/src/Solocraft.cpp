#include "Chat.h"
#include "Config.h"
#include "Group.h"
#include "Log.h"
#include "Map.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "Vehicle.h"
#include <unordered_map>

#if not(defined(MOD_PRESENT_NPCBOTS)) || MOD_PRESENT_NPCBOTS != 1
 #error "NPCBots mod is not installed! This version of Autobalance only supports AzerothCore+NPCBots."
#endif
#include "botdatamgr.h"
#include "botmgr.h"

//TODO: Vehicle handlers do not always work (missing hook)

#ifdef _MSC_VER
# pragma warning(push, 4)
#endif

typedef std::unordered_map<uint8, std::vector<uint8>> ClassStatsMap;
static const ClassStatsMap classPrimaryStats =
{
    { CLASS_WARRIOR,      {UNIT_MOD_HEALTH, UNIT_MOD_ATTACK_POWER, UNIT_MOD_ATTACK_POWER_RANGED} },
    { CLASS_PALADIN,      {UNIT_MOD_HEALTH, UNIT_MOD_MANA, UNIT_MOD_ATTACK_POWER} },
    { CLASS_HUNTER,       {UNIT_MOD_HEALTH, UNIT_MOD_MANA, UNIT_MOD_ATTACK_POWER, UNIT_MOD_ATTACK_POWER_RANGED} },
    { CLASS_ROGUE,        {UNIT_MOD_HEALTH, UNIT_MOD_ATTACK_POWER, UNIT_MOD_ATTACK_POWER_RANGED} },
    { CLASS_PRIEST,       {UNIT_MOD_HEALTH, UNIT_MOD_MANA} },
    { CLASS_DEATH_KNIGHT, {UNIT_MOD_HEALTH, UNIT_MOD_ATTACK_POWER} },
    { CLASS_SHAMAN,       {UNIT_MOD_HEALTH, UNIT_MOD_MANA, UNIT_MOD_ATTACK_POWER} },
    { CLASS_MAGE,         {UNIT_MOD_HEALTH, UNIT_MOD_MANA} },
    { CLASS_WARLOCK,      {UNIT_MOD_HEALTH, UNIT_MOD_MANA} },
    { CLASS_DRUID,        {UNIT_MOD_HEALTH, UNIT_MOD_MANA, UNIT_MOD_ATTACK_POWER} }
};

enum SCSpells
{
    SPELL_CRIT_PCT_BONUS     = 19591, //"Tamed Pet Passive 06 (DND)", effct_0, effect_1
    //SPELL_DAMAGE_PCT_BONUS   = 30147, //"Tamed Pet Passive (DND)", effct_0, effect_1
    SPELL_HEALTH_PCT_BONUS   = 56257, //"Increased Health", effct_0
    SPELL_SPELLPOWER_BONUS   = 47182, //"Copy of Increase Spell Dam 121", effect_0, effect_1
    SPELL_DEFENSE_BONUS      = 39423, //"QATest +500 Defense (QASpell)", effect 0
    SPELL_DAMAGETAKEN_BONUS  = 35697, //"Pet Passive (DND)", effect 0
};

bool SoloCraftEnable           = true;
bool SoloCraftAnnounceModule   = true;
bool SolocraftXPBalEnabled     = true;
bool SolocraftXPEnabled        = true;
float SoloCraftCritMult        = 1.0f;
float SoloCraftDefenseMult     = 1.0f;
float SoloCraftDamagetakenMult = 1.0f;
float SoloCraftSpellpowerMult  = 1.0f;
float SoloCraftStatsMult       = 100.0f;
uint32 SolocraftLevelDiff      = 1;
uint32 SolocraftDungeonLevel   = 1;

std::unordered_map<uint8, uint32> classBalanceMap;
std::unordered_map<uint32, uint32> dungeonLevelMap;
std::unordered_map<uint32, float> dungeonDifficultyNormalMap;
std::unordered_map<uint32, float> dungeonDifficultyHeroicMap;

float DifficultyDefault5      = 1.0f;
float DifficultyDefault10     = 1.0f;
float DifficultyDefault25     = 1.0f;
float DifficultyDefault40     = 1.0f;
float DifficultyDefault649H10 = 1.0f;
float DifficultyDefault649H25 = 1.0f;

struct SolocraftPlayer
{
    SolocraftPlayer() : difficulty(0.0f), spellpower_bonus(0), crit_bonus(0), defense_bonus(0), dmgtaken_bonus(0), stats_mult(0.0f), xp_mult(1.0f) {}

    float difficulty;
    int32 spellpower_bonus;
    int32 crit_bonus;
    int32 defense_bonus;
    int32 dmgtaken_bonus;
    float stats_mult;
    float xp_mult;
};

typedef std::unordered_map<ObjectGuid /*player_guid*/, SolocraftPlayer> SolocraftPlayerMap;
SolocraftPlayerMap scPlayers;

class Solocraft
{
    using UnitVec = std::vector<Unit const*>;

public:
    Solocraft() = delete;

    static void OnConfigReload()
    {
        for (auto const& kv : scPlayers)
        {
            if (kv.first.IsPlayer())
            {
                if (Player* player = ObjectAccessor::FindPlayer(kv.first))
                {
                    Map const* map = player->FindMap();
                    if (map && dungeonLevelMap.find(map->GetId()) != dungeonLevelMap.cend())
                        UpdateUnitBuffs(player, player->GetClass());
                }
            }
            else //if (kv.first.IsCreature())
            {
                if (Creature const* bot = BotDataMgr::FindBot(kv.first.GetEntry()))
                {
                    Map const* map = bot->FindMap();
                    if (map && dungeonLevelMap.find(map->GetId()) != dungeonLevelMap.cend())
                        UpdateUnitBuffs(const_cast<Creature*>(bot), BotMgr::GetBotPlayerClass(bot->GetBotClass()));
                }
            }
        }
    }

    static void OnPlayerLogin(Player* player)
    {
        scPlayers.insert_or_assign(player->GetGUID(), SolocraftPlayer());
        OnPlayerMapChange(player);
    }

    static void OnPlayerLogout(Player* player)
    {
        Map const* map = player->GetMap();
        if (dungeonLevelMap.find(map->GetId()) != dungeonLevelMap.cend())
        {
            Map::PlayerList const& players = map->GetPlayers();
            Group const* group = nullptr;
            for (MapReference const& ref : players)
            {
                if (Player const* p = ref.GetSource())
                {
                    if (Group const* gr = p->GetGroup())
                    {
                        group = gr;
                        break;
                    }
                }
            }

            if (group)
                UpdateGroupBuffs(group, player, true);
            else
            {
                ClearBuffs(player, map, player->GetClass());
                if (players.getSize() == 2u)
                {
                    Player* other = players.getFirst()->GetSource() == player ? players.getLast()->GetSource() : players.getFirst()->GetSource();
                    UpdateUnitBuffs(other, other->GetClass(), player);
                }
            }
        }
        scPlayers.erase(player->GetGUID());
    }

    static void OnGiveXP(Player* player, uint32& amount)
    {
        auto cit = scPlayers.find(player->GetGUID());
        if (cit != scPlayers.cend())
            amount = std::decay_t<decltype(amount)>(amount * cit->second.xp_mult);
    }

    static void OnPlayerMapChange(Player* player)
    {
        if (!SoloCraftEnable)
            return;

        // This hook may get triggered before OnLogin()
        if (scPlayers.find(player->GetGUID()) == scPlayers.cend())
            return;

        if (Group const* group = player->GetGroup())
            UpdateGroupBuffs(group, player, false);
        else
            UpdateUnitBuffs(player, player->GetClass(), player);
    }

    static void OnPetAddToWorld(Creature* creature)
    {
        auto cit = scPlayers.find(creature->GetCreatorGUID());
        if (cit != scPlayers.cend())
            ApplyPetBuffs(creature, cit->second);
    }

    static void OnAfterPetInitStats(Player const* player, Guardian* guardian)
    {
        auto cit = scPlayers.find(player->GetGUID());
        if (cit != scPlayers.cend())
            ApplyPetBuffs(guardian, cit->second);
    }

    static void OnBotAddToWorld(Creature* creature)
    {
        scPlayers.insert_or_assign(creature->GetGUID(), SolocraftPlayer());

        if (!SoloCraftEnable)
            return;

        if (dungeonLevelMap.find(creature->GetMap()->GetId()) == dungeonLevelMap.cend())
            return;

        if (Group const* group = creature->GetBotGroup())
            UpdateGroupBuffs(group, creature, false);
    }

    static void OnBotRemoveFromWorld(Creature* creature)
    {
        Map const* map = creature->GetMap();
        if (dungeonLevelMap.find(map->GetId()) != dungeonLevelMap.cend())
        {
            Map::PlayerList const& players = map->GetPlayers();
            Group const* group = nullptr;
            for (MapReference const& ref : players)
            {
                if (Player const* p = ref.GetSource())
                {
                    if (Group const* gr = p->GetGroup())
                    {
                        group = gr;
                        break;
                    }
                }
            }

            if (group)
            {
                if (!group->IsMember(creature->GetGUID()))
                    ClearBuffs(creature, map, BotMgr::GetBotPlayerClass(creature->GetBotClass()));
                else
                    UpdateGroupBuffs(group, creature, true);
            }
            else
            {
                ClearBuffs(creature, map, BotMgr::GetBotPlayerClass(creature->GetBotClass()));
                if (players.getSize() == 1u)
                {
                    if (Player* player = players.getFirst()->GetSource())
                        UpdateUnitBuffs(player, player->GetClass(), creature);
                }
            }
        }
        scPlayers.erase(creature->GetGUID());
    }

    static void OnBotPetAddToWorld(Creature* creature)
    {
        if (!SoloCraftEnable)
            return;

        auto cit = scPlayers.find(creature->GetCreatorGUID());
        if (cit == scPlayers.cend())
            return;

        ApplyPetBuffs(creature, cit->second);
    }

    //static void OnBotPetRemoveFromWorld(Creature* creature)
    //{
    //    if (!SoloCraftEnable)
    //        return;

    //    if (scPlayers.find(creature->GetOwnerGUID()) == scPlayers.cend())
    //        return;

    //    if (Unit const* creator = creature->GetCreator())
    //        if (creator->IsPlayer())
    //            if (Creature const* bot = creator->ToPlayer()->GetBotMgr()->GetBot(creature->GetOwnerGUID()))
    //                ClearPetBuffs(creature);
    //}

    static void OnGroupMemberAdd(Group const* group, ObjectGuid guid)
    {
        OnGroupMemberAddedOrRemoved(group, guid);
    }

    static void OnGroupMemberRemove(Group const* group, ObjectGuid guid)
    {
        OnGroupMemberAddedOrRemoved(group, guid, true);
    }

    //static void OnVehiclePassengerAdd(Vehicle* vehicle, Unit* passenger)
    //{
    //    if (!SoloCraftEnable)
    //        return;

    //    if (vehicle->GetBase()->IsPlayer())
    //        return;

    //    if (dungeonLevelMap.find(vehicle->GetBase()->GetMap()->GetId()) == dungeonLevelMap.cend())
    //        return;

    //    auto cit = scPlayers.find(passenger->GetGUID());
    //    if (cit == scPlayers.cend())
    //        return;

    //    if (VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(passenger))
    //        if (seat->m_flags & VEHICLE_SEAT_FLAG_CAN_CONTROL)
    //            ApplyVehicleBuffs(vehicle->GetBase()->ToCreature(), cit->second);
    //}

    //static void OnVehiclePassengerRemove(Vehicle* vehicle, Unit* passenger)
    //{
    //    if (!SoloCraftEnable)
    //        return;

    //    if (vehicle->GetBase()->IsPlayer())
    //        return;

    //    if (dungeonLevelMap.find(vehicle->GetBase()->GetMap()->GetId()) == dungeonLevelMap.cend())
    //        return;

    //    if (scPlayers.find(passenger->GetGUID()) == scPlayers.cend())
    //        return;

    //    if (VehicleSeatEntry const* seat = vehicle->GetSeatForPassenger(passenger))
    //    {
    //        if (seat->m_flags & VEHICLE_SEAT_FLAG_CAN_CONTROL)
    //            ClearVehicleBuffs(vehicle->GetBase()->ToCreature());
    //    }
    //}

private:
    static void OnGroupMemberAddedOrRemoved(Group const* group, ObjectGuid guid, bool remove = false)
    {
        if (!SoloCraftEnable)
            return;

        if (scPlayers.find(guid) == scPlayers.cend())
            return;

        bool is_player = guid.IsPlayer();
        Unit const* unit = nullptr;
        if (is_player)
            unit = ObjectAccessor::FindPlayer(guid);
        else
            unit = BotDataMgr::FindBot(guid.GetEntry());

        if (!unit || !unit->IsInWorld() || dungeonLevelMap.find(unit->GetMap()->GetId()) == dungeonLevelMap.cend())
            return;

        if (remove)
        {
            uint8 class_ = is_player ? unit->GetClass() : BotMgr::GetBotPlayerClass(unit->ToCreature()->GetBotClass());
            ClearBuffs(const_cast<Unit*>(unit), unit->GetMap(), class_);
        }

        UpdateGroupBuffs(group, unit, remove);
    }

    static void UpdateUnitBuffs(Unit* unit, uint8 class_, Unit const* instigator = nullptr)
    {
        Map const* map = unit->GetMap();
        float difficulty = GetDungeonDifficulty(map);
        uint32 dunLevel = GetDungeonLevel(map);
        UnitVec members = GetDungeonGroupMembers(unit);
        uint32 classBalance = GetClassBalance(class_);
        ApplyBuffs(unit, class_, map, difficulty, dunLevel, members, classBalance, instigator);
    }

    static void UpdateGroupBuffs(Group const* group, Unit const* instigator, bool remove)
    {
        for (GroupReference const* pref = group->GetFirstMember(); pref != nullptr; pref = pref->next())
        {
            if (Player* player = pref->GetSource())
            {
                if (player->IsInWorld())
                {
                    uint8 player_class = player->GetClass();
                    if (remove && instigator == player)
                        ClearBuffs(player, player->GetMap(), player_class);
                    else
                        UpdateUnitBuffs(player, player_class, instigator);
                }
            }
        }
        for (GroupBotReference const* bref = group->GetFirstBotMember(); bref != nullptr; bref = bref->next())
        {
            if (Creature* bot = bref->GetSource())
            {
                if (bot->IsInWorld())
                {
                    uint8 bot_class = BotMgr::GetBotPlayerClass(bot->GetBotClass());
                    if (remove && instigator == bot)
                        ClearBuffs(bot, bot->GetMap(), bot_class);
                    else
                        UpdateUnitBuffs(bot, bot_class, instigator);
                }
            }
        }
    }

    static float GetDungeonDifficulty(Map const* map)
    {
        if (map->Is25ManRaid())
        {
            if (map->IsHeroic() && map->GetId() == 649)
                return DifficultyDefault649H25;
            else
            {
                auto cit = dungeonDifficultyHeroicMap.find(map->GetId());
                return cit != dungeonDifficultyHeroicMap.cend() ? cit->second : DifficultyDefault25;
            }
        }

        if (map->IsHeroic())
        {
            if (map->GetId() == 649)
                return DifficultyDefault649H10;
            else
            {
                auto cit = dungeonDifficultyHeroicMap.find(map->GetId());
                return cit != dungeonDifficultyHeroicMap.cend() ? cit->second : DifficultyDefault10;
            }
        }

        auto ncit = dungeonDifficultyHeroicMap.find(map->GetId());
        if (ncit != dungeonDifficultyHeroicMap.cend())
            return ncit->second;
        else if (map->IsDungeon())
            return DifficultyDefault5;
        else if (map->IsRaid())
            return DifficultyDefault40;

        return 0.0f;
    }

    // Set the Dungeon Level
    static uint32 GetDungeonLevel(Map const* map)
    {
        auto cit = dungeonLevelMap.find(map->GetId());
        return cit != dungeonLevelMap.cend() ? cit->second : SolocraftDungeonLevel;
    }

    // Get group members in unit's dungeon map
    static UnitVec GetDungeonGroupMembers(Unit const* unit)
    {
        Group const* group = unit->IsPlayer() ? unit->ToPlayer()->GetGroup() : unit->ToCreature()->GetBotGroup();
        if (!group)
            return { unit };

        UnitVec members;
        members.reserve(group->GetMembersCount());

        uint32 mapId = unit->GetMap()->GetId();
        for (GroupReference const* pref = group->GetFirstMember(); pref != nullptr; pref = pref->next())
        {
            if (Player const* player = pref->GetSource())
                if (player->IsInWorld() && player->GetMap()->GetId() == mapId)
                    members.push_back(player);
        }
        for (GroupBotReference const* bref = group->GetFirstBotMember(); bref != nullptr; bref = bref->next())
        {
            if (Creature const* bot = bref->GetSource())
                if (bot->IsInWorld() && bot->GetMap()->GetId() == mapId)
                    members.push_back(bot);
        }
        return members;
    }

    // Get the Player's class balance debuff
    static uint32 GetClassBalance(uint8 class_)
    {
        auto cit = classBalanceMap.find(class_);
        return cit != classBalanceMap.end() ? cit->second : 100u;
    }

    // Get the total sum of the difficulty offset by all group members (except one being added) currently in the dungeon
    //static float CalculateGroupDifficulty(Unit const* unit)
    //{
    //    float gdifficulty = 0.0f;
    //    if (Group const* group = unit->IsPlayer() ? unit->ToPlayer()->GetGroup() : unit->ToCreature()->GetBotGroup())
    //    {
    //        for (Group::MemberSlot const& slot : group->GetMemberSlots())
    //        {
    //            if (slot.guid != unit->GetGUID())
    //            {
    //                auto cit = scPlayers.find(slot.guid);
    //                if (cit != scPlayers.cend())
    //                    gdifficulty += cit->second.difficulty;
    //            }
    //        }
    //    }
    //    return gdifficulty;
    //}

    static Aura* EnsureAura(Unit* unit, uint32 spellId)
    {
        constexpr int32 SCAuraDuration = 24 * HOUR * IN_MILLISECONDS;

        Aura* aura = unit->GetAura(spellId);
        if (!aura)
            aura = unit->AddAura(spellId, unit);
        if (aura)
        {
            aura->SetDuration(SCAuraDuration);
            aura->SetMaxDuration(SCAuraDuration);
        }
        return aura;
    }

    static void EnsureUnAura(Unit* unit, uint32 spellId)
    {
        if (Aura* aura = unit->GetAura(spellId))
            aura->Remove();
    }

    static void ApplyBuffs(Unit* unit, uint8 class_, Map const* map, float difficulty, uint32 dunLevel, UnitVec const& members, uint32 classBalance, Unit const* /*instigator*/)
    {
        Player const* player = unit->ToPlayer();
        uint32 numInGroup = members.size();

        // Check whether to buff the player or check to debuff back to normal
        InstanceMap const* instanceMap = map->ToInstanceMap();
        uint32 maxPlayers = instanceMap ? instanceMap->GetMaxPlayers() : map->GetEntry()->maxPlayers;
        bool max_players_or_more = numInGroup >= maxPlayers;
        if (max_players_or_more || difficulty == 0.0f || (unit->IsPlayer() && unit->ToPlayer()->GetSession()->PlayerLogout()))
        {
            ClearBuffs(unit, map, class_, max_players_or_more);
            return;
        }

        std::ostringstream ss;
        ss.setf(std::ios_base::fixed);
        ss.precision(2);

        // If a player is too high level for dungeon don't buff but if in a group will count towards the group offset balancing.
        if (unit->GetLevel() > dunLevel + SolocraftLevelDiff)
        {
            ss << "|cffFF0000[SoloCraft] |cffFF8000" << unit->GetName() << (unit->IsNPCBot() ? " (bot)" : "") << " updates " << map->GetMapName()
                << " - |cffFF0000Have not been buffed. |cffFF8000Level is higher than the max level ("
                << uint32(dunLevel + SolocraftLevelDiff) << ") threshold for this dungeon.";
            ReportToSelf(unit, ss.str());
            //ReportToGroup(unit, members, ss.str());
            ClearBuffs(unit, map, class_);
            return;
        }

        SolocraftPlayer& scp = scPlayers[unit->GetGUID()];

        difficulty = roundf(((classBalance / 100.0f) * difficulty) / numInGroup);
        // LOG_ERROR("scripts", "{}'s Difficulty {}", unit->GetName(), difficulty);

        ClassStatsMap::const_iterator cit = classPrimaryStats.find(class_);
        ASSERT(cit != classPrimaryStats.cend());

        // Remove old buffs
        if (scp.stats_mult != 0.0f)
        {
            for (uint8 stat : cit->second)
                unit->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + stat), TOTAL_PCT, scp.stats_mult, false);
        }

        // Apply new buffs
        scp.difficulty = difficulty;
        scp.xp_mult = !SolocraftXPEnabled ? 0.0f : !SolocraftXPBalEnabled ? 1.0f : std::min<float>(1.0f, roundf(((1.04f / difficulty) - 0.02f) * 100.0f) / 100.0f);
        scp.stats_mult = difficulty * SoloCraftStatsMult;
        if (scp.stats_mult != 0.0f)
        {
            for (uint8 stat : cit->second)
                unit->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + stat), TOTAL_PCT, scp.stats_mult, true);
        }
        if (Aura* craura = EnsureAura(unit, SPELL_CRIT_PCT_BONUS))
        {
            scp.crit_bonus = std::min<int32>(100, int32(SoloCraftCritMult * scp.stats_mult * 0.1f));
            for (uint8 eff_index = EFFECT_0; eff_index <= EFFECT_1; ++eff_index)
                if (AuraEffect* crit = craura->GetEffect(eff_index))
                    crit->ChangeAmount(scp.crit_bonus);
        }
        if (Aura* defaura = EnsureAura(unit, SPELL_DEFENSE_BONUS))
        {
            scp.defense_bonus = std::min<int32>(1000, std::max<int32>(0, int32(SoloCraftDefenseMult * scp.stats_mult)));
            if (AuraEffect* def = defaura->GetEffect(EFFECT_0))
                def->ChangeAmount(scp.defense_bonus);
        }
        if (Aura* dtaura = EnsureAura(unit, SPELL_DAMAGETAKEN_BONUS))
        {
            scp.dmgtaken_bonus = std::min<int32>(90, std::max<int32>(0, int32(SoloCraftDamagetakenMult * scp.stats_mult * 0.1f)));
            if (AuraEffect* dat = dtaura->GetEffect(EFFECT_0))
                dat->ChangeAmount(-scp.dmgtaken_bonus);
        }
        if (Aura* spaura = EnsureAura(unit, SPELL_SPELLPOWER_BONUS))
        {
            scp.spellpower_bonus = std::max<int32>(0, int32(unit->GetLevel() * SoloCraftSpellpowerMult * scp.stats_mult * 0.01f));
            for (uint8 eff_index = EFFECT_0; eff_index <= EFFECT_1; ++eff_index)
                if (AuraEffect* spp = spaura->GetEffect(eff_index))
                    spp->ChangeAmount(scp.spellpower_bonus);
        }
        // Restore HP / Mana
        unit->SetFullHealth();
        if (unit->GetMaxPower(POWER_MANA) > 1)
            unit->SetPower(POWER_MANA, unit->GetMaxPower(POWER_MANA));

        // Pet stats
        if (player)
        {
            if (Pet* pet = player->GetPet())
                ApplyPetBuffs(pet, scp);
        }
        else //if (unit->IsNPCBot())
        {
            if (Unit* botpet = unit->ToCreature()->GetBotsPet())
                ApplyPetBuffs(botpet->ToCreature(), scp);
        }

        // Vehicle stats
        //if (Vehicle* veh = unit->GetVehicle())
        //    if (!veh->GetBase()->IsPlayer())
        //        ApplyVehicleBuffs(veh->GetBase()->ToCreature(), scp);

        ss << "|cffFF0000[SoloCraft] |cffFF8000" << unit->GetName() << (unit->IsNPCBot() ? " (bot)" : "") << " updates " << map->GetMapName()
            << " - Difficulty Offset: " << difficulty << ". Crit Bonus: " << scp.crit_bonus << "%. Defense Bonus: " << scp.defense_bonus
            << ". Damage Taken Bonus: " << (-scp.dmgtaken_bonus) << "%. Spellpower Bonus: " << scp.spellpower_bonus
            << ". Class Balance Weight: " << classBalance << ". "
            << (SolocraftXPEnabled ? SolocraftXPEnabled ? "XP Balancing: |cff4CFF00Enabled" : "XP Balancing: |cffFF0000Disabled" : "XP Gain: |cffFF0000Disabled");
        ReportToSelf(unit, ss.str());
        //ReportToGroup(unit, members, ss.str());
    }

    static void ClearBuffs(Unit* unit, Map const* map, uint8 class_, bool max_players_reached = false)
    {
        UnitVec members = GetDungeonGroupMembers(unit);
        SolocraftPlayer scp = std::exchange(scPlayers[unit->GetGUID()], SolocraftPlayer());
        bool is_bot = unit->IsNPCBot();

        ClassStatsMap::const_iterator cit = classPrimaryStats.find(class_);
        ASSERT(cit != classPrimaryStats.cend());

        if (scp.stats_mult != 0.0f)
        {
            for (uint8 stat : cit->second)
                unit->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + stat), TOTAL_PCT, scp.stats_mult, false);
        }
        EnsureUnAura(unit, SPELL_CRIT_PCT_BONUS);
        EnsureUnAura(unit, SPELL_DEFENSE_BONUS);
        EnsureUnAura(unit, SPELL_DAMAGETAKEN_BONUS);
        EnsureUnAura(unit, SPELL_SPELLPOWER_BONUS);

        if (Player* player = unit->ToPlayer())
            if (Pet* pet = player->GetPet())
                ClearPetBuffs(pet);

        //if (Vehicle* veh = unit->GetVehicle())
        //    if (!veh->GetBase()->IsPlayer())
        //        ClearVehicleBuffs(veh->GetBase()->ToCreature());

        std::ostringstream ss;
        ss.setf(std::ios_base::fixed);
        ss.precision(2);

        ss << "|cffFF0000[SoloCraft] |cffFF8000" << unit->GetName() << (is_bot ? " (bot)" : "")
            << (max_players_reached ? is_bot ? " resets " : " resets in " : is_bot ? " exited from " : " exited to ") << map->GetMapName()
            << " - Reverting Difficulty Offset: " << scp.difficulty
            << ". Crit Bonus Removed: " << scp.crit_bonus << "%. Defense Bonus Removed: " << scp.defense_bonus
            << ". Damage Taken Bonus Removed: " << (-scp.dmgtaken_bonus) << "%. Spellpower Bonus Removed: " << scp.spellpower_bonus;
        ReportToSelf(unit, ss.str());
        //ReportToGroup(unit, members, ss.str());
    }

    static void ApplyCommonSecondaryBuffs(Creature* creature, SolocraftPlayer const& scp)
    {
        if (Aura* hpaura = EnsureAura(creature, SPELL_HEALTH_PCT_BONUS))
            if (AuraEffect* hpeff = hpaura->GetEffect(EFFECT_0))
                hpeff->ChangeAmount(int32(scp.stats_mult));
        if (Aura* dtaura = EnsureAura(creature, SPELL_DAMAGETAKEN_BONUS))
            if (AuraEffect* dat = dtaura->GetEffect(EFFECT_0))
                dat->ChangeAmount(-scp.dmgtaken_bonus);
        creature->m_Events.AddEventAtOffset([me = creature]() { me->SetFullHealth(); }, 100ms);
    }

    static void ClearCommonSecondaryBuffs(Creature* creature)
    {
        EnsureUnAura(creature, SPELL_HEALTH_PCT_BONUS);
        EnsureUnAura(creature, SPELL_DAMAGETAKEN_BONUS);
    }

    static void ApplyPetBuffs(Creature* creature, SolocraftPlayer const& scp)
    {
        ApplyCommonSecondaryBuffs(creature, scp);
    }

    static void ClearPetBuffs(Creature* creature)
    {
        ClearCommonSecondaryBuffs(creature);
    }

    static void ApplyVehicleBuffs(Creature* creature, SolocraftPlayer const& scp)
    {
        ApplyCommonSecondaryBuffs(creature, scp);
    }

    static void ClearVehicleBuffs(Creature* creature)
    {
        ClearCommonSecondaryBuffs(creature);
    }

    static void ReportToGroup(Unit const* source, UnitVec const& members, std::string const& message)
    {
        for (Unit const* unit : members)
            if (unit != source && unit->IsPlayer())
                ChatHandler(unit->ToPlayer()->GetSession()).SendSysMessage(message.c_str());
    }

    static void ReportToSelf(Unit const* unit, std::string const& message)
    {
        if (unit->IsPlayer())
            ChatHandler(unit->ToPlayer()->GetSession()).SendSysMessage(message.c_str());
    }
};

class SolocraftAnnounce : public PlayerScript
{
public:
    SolocraftAnnounce() : PlayerScript("SolocraftAnnounce") {}

    void OnLogin(Player* player) override
    {
        if (SoloCraftEnable && SoloCraftAnnounceModule)
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00SoloCraft |rmodule.");
    }
};

class SolocraftNPCBotScript : public AllCreatureScript
{
public:
    SolocraftNPCBotScript() : AllCreatureScript("SolocraftNPCBotScript") {}

    void OnCreatureAddWorld(Creature* creature) override
    {
        if (creature->IsNPCBot())
            Solocraft::OnBotAddToWorld(creature);
        else if (creature->IsNPCBotPet())
            Solocraft::OnBotPetAddToWorld(creature);
        else if (creature->IsPet())
            Solocraft::OnPetAddToWorld(creature);
    }

    void OnCreatureRemoveWorld(Creature* creature) override
    {
        if (!creature->IsNPCBot() || creature->IsFreeBot())
            return;

        Solocraft::OnBotRemoveFromWorld(creature);
    }
};

class SolocraftPlayerScript : public PlayerScript
{
public:
    SolocraftPlayerScript() : PlayerScript("SolocraftPlayerScript") {}

    void OnLogin(Player* player) override
    {
        Solocraft::OnPlayerLogin(player);
    }

    void OnLogout(Player* player) override
    {
        Solocraft::OnPlayerLogout(player);
    }

    void OnGiveXP(Player* player, uint32& amount, Unit* /*victim*/, uint8 /*xpSource*/) override
    {
        Solocraft::OnGiveXP(player, amount);
    }

    void OnMapChanged(Player* player) override
    {
        Solocraft::OnPlayerMapChange(player);
    }

    void OnAfterGuardianInitStatsForLevel(Player* player, Guardian* guardian) override
    {
        Solocraft::OnAfterPetInitStats(player, guardian);
    }
};

class SolocraftGroupScript : public GroupScript
{
public:
    SolocraftGroupScript() : GroupScript("SolocraftGroupScript") {}

    void OnAddMember(Group* group, ObjectGuid guid) override
    {
        Solocraft::OnGroupMemberAdd(group, guid);
    }

    void OnRemoveMember(Group* group, ObjectGuid guid, RemoveMethod /*method*/, ObjectGuid /*kicker*/, const char* /*reason*/) override
    {
        Solocraft::OnGroupMemberRemove(group, guid);
    }
};

class SolocraftVehicleScript : public VehicleScript
{
public:
    SolocraftVehicleScript() : VehicleScript("SolocraftVehicleScript") {}

    //void OnAddPassenger(Vehicle* veh, Unit* passenger, int8 /*seatId*/) override
    //{
    //    Solocraft::OnVehiclePassengerAdd(veh, passenger);
    //}

    //void OnRemovePassenger(Vehicle* veh, Unit* passenger) override
    //{
    //    Solocraft::OnVehiclePassengerRemove(veh, passenger);
    //}
};

class SolocraftConfig : public WorldScript
{
public:
    SolocraftConfig() : WorldScript("SolocraftConfig") {}

    void OnBeforeConfigLoad(bool reload) override
    {
        SetInitialWorldSettings();

        if (reload)
            Solocraft::OnConfigReload();
    }

    // Load Configuration Settings
    void SetInitialWorldSettings()
    {
        SoloCraftEnable          = sConfigMgr->GetOption<bool>("Solocraft.Enable", true);
        SoloCraftAnnounceModule  = sConfigMgr->GetOption<bool>("Solocraft.Announce", true);

        // Balancing
        SoloCraftCritMult        = sConfigMgr->GetOption<float>("SoloCraft.Crit.Mult", 0.5f);
        SoloCraftDefenseMult     = sConfigMgr->GetOption<float>("SoloCraft.Defense.Mult", 1.0f);
        SoloCraftDamagetakenMult = sConfigMgr->GetOption<float>("SoloCraft.Damagetaken.Mult", 1.0f);
        SoloCraftSpellpowerMult  = sConfigMgr->GetOption<float>("SoloCraft.Spellpower.Mult", 2.5f);
        SoloCraftStatsMult       = sConfigMgr->GetOption<float>("SoloCraft.Stats.Mult", 100.0f);

        // XP Enabled
        SolocraftXPEnabled       = sConfigMgr->GetOption<bool>("Solocraft.XP.Enabled", true);
        // XP Balancing
        SolocraftXPBalEnabled    = sConfigMgr->GetOption<bool>("Solocraft.XPBal.Enabled", true);
        // Level Thresholds
        SolocraftLevelDiff       = sConfigMgr->GetOption<uint32>("Solocraft.Max.Level.Diff", 10);
        // Default Dungeon Level
        SolocraftDungeonLevel    = sConfigMgr->GetOption<uint32>("Solocraft.Dungeon.Level", 80);

        classBalanceMap =
        {
            { CLASS_WARRIOR,      sConfigMgr->GetOption<uint32>("SoloCraft.WARRIOR", 100) },
            { CLASS_PALADIN,      sConfigMgr->GetOption<uint32>("SoloCraft.PALADIN", 100) },
            { CLASS_HUNTER,       sConfigMgr->GetOption<uint32>("SoloCraft.HUNTER", 100) },
            { CLASS_ROGUE,        sConfigMgr->GetOption<uint32>("SoloCraft.ROGUE", 100) },
            { CLASS_PRIEST,       sConfigMgr->GetOption<uint32>("SoloCraft.PRIEST", 100) },
            { CLASS_DEATH_KNIGHT, sConfigMgr->GetOption<uint32>("SoloCraft.DEATH_KNIGHT", 100) },
            { CLASS_SHAMAN,       sConfigMgr->GetOption<uint32>("SoloCraft.SHAMAN", 100) },
            { CLASS_MAGE,         sConfigMgr->GetOption<uint32>("SoloCraft.MAGE", 100) },
            { CLASS_WARLOCK,      sConfigMgr->GetOption<uint32>("SoloCraft.WARLOCK", 100) },
            { CLASS_DRUID,        sConfigMgr->GetOption<uint32>("SoloCraft.DRUID", 100) },
        };

        // Dungeon Base Level
        dungeonLevelMap =
        {
            // Wow Classic
            { 33,  sConfigMgr->GetOption<uint32>("Solocraft.ShadowfangKeep.Level", 15) },
            { 34,  sConfigMgr->GetOption<uint32>("Solocraft.Stockades.Level", 22) },
            { 36,  sConfigMgr->GetOption<uint32>("Solocraft.Deadmines.Level", 18) },
            { 43,  sConfigMgr->GetOption<uint32>("Solocraft.WailingCaverns.Level", 17) },
            { 47,  sConfigMgr->GetOption<uint32>("Solocraft.RazorfenKraulInstance.Level", 30) },
            { 48,  sConfigMgr->GetOption<uint32>("Solocraft.Blackfathom.Level", 20) },
            { 70,  sConfigMgr->GetOption<uint32>("Solocraft.Uldaman.Level", 40) },
            { 90,  sConfigMgr->GetOption<uint32>("Solocraft.GnomeragonInstance.Level", 24) },
            { 109, sConfigMgr->GetOption<uint32>("Solocraft.SunkenTemple.Level", 50) },
            { 129, sConfigMgr->GetOption<uint32>("Solocraft.RazorfenDowns.Level", 40) },
            { 189, sConfigMgr->GetOption<uint32>("Solocraft.MonasteryInstances.Level", 35) },                  // Scarlet Monastery
            { 209, sConfigMgr->GetOption<uint32>("Solocraft.TanarisInstance.Level", 44) },                     // Zul'Farrak
            { 229, sConfigMgr->GetOption<uint32>("Solocraft.BlackRockSpire.Level", 55) },
            { 230, sConfigMgr->GetOption<uint32>("Solocraft.BlackrockDepths.Level", 50) },
            { 249, sConfigMgr->GetOption<uint32>("Solocraft.OnyxiaLairInstance.Level", 60) },
            { 289, sConfigMgr->GetOption<uint32>("Solocraft.SchoolofNecromancy.Level", 55) },                  // Scholomance
            { 309, sConfigMgr->GetOption<uint32>("Solocraft.Zul'gurub.Level", 60) },
            { 329, sConfigMgr->GetOption<uint32>("Solocraft.Stratholme.Level", 55) },
            { 349, sConfigMgr->GetOption<uint32>("Solocraft.Mauradon.Level", 48) },
            { 389, sConfigMgr->GetOption<uint32>("Solocraft.OrgrimmarInstance.Level", 15) },                   // Ragefire Chasm
            { 409, sConfigMgr->GetOption<uint32>("Solocraft.MoltenCore.Level", 60) },
            { 429, sConfigMgr->GetOption<uint32>("Solocraft.DireMaul.Level", 48) },
            { 469, sConfigMgr->GetOption<uint32>("Solocraft.BlackwingLair.Level", 40) },
            { 509, sConfigMgr->GetOption<uint32>("Solocraft.AhnQiraj.Level", 60) },                            // Ruins of Ahn'Qiraj
            { 531, sConfigMgr->GetOption<uint32>("Solocraft.AhnQirajTemple.Level", 60) },

            // BC Instances
            { 269, sConfigMgr->GetOption<uint32>("Solocraft.CavernsOfTime.Level", 68) },                       // The Black Morass
            { 532, sConfigMgr->GetOption<uint32>("Solocraft.Karazahn.Level", 68) },
            { 534, sConfigMgr->GetOption<uint32>("Solocraft.HyjalPast.Level", 70) },                           // The Battle for Mount Hyjal - Hyjal Summit
            { 540, sConfigMgr->GetOption<uint32>("Solocraft.HellfireMilitary.Level", 68) },                    // The Shattered Halls
            { 542, sConfigMgr->GetOption<uint32>("Solocraft.HellfireDemon.Level", 68) },                       // The Blood Furnace
            { 543, sConfigMgr->GetOption<uint32>("Solocraft.HellfireRampart.Level", 68) },
            { 544, sConfigMgr->GetOption<uint32>("Solocraft.HellfireRaid.Level", 68) },                        // Magtheridon's Lair
            { 545, sConfigMgr->GetOption<uint32>("Solocraft.CoilfangPumping.Level", 68) },                     // The Steamvault
            { 546, sConfigMgr->GetOption<uint32>("Solocraft.CoilfangMarsh.Level", 68) },                       // The Underbog
            { 547, sConfigMgr->GetOption<uint32>("Solocraft.CoilfangDraenei.Level", 68) },                     // The Slavepens
            { 548, sConfigMgr->GetOption<uint32>("Solocraft.CoilfangRaid.Level", 70) },                        // Serpentshrine Cavern
            { 550, sConfigMgr->GetOption<uint32>("Solocraft.TempestKeepRaid.Level", 70) },                     // The Eye
            { 552, sConfigMgr->GetOption<uint32>("Solocraft.TempestKeepArcane.Level", 68) },                   // The Arcatraz
            { 553, sConfigMgr->GetOption<uint32>("Solocraft.TempestKeepAtrium.Level", 68) },                   // The Botanica
            { 554, sConfigMgr->GetOption<uint32>("Solocraft.TempestKeepFactory.Level", 68) },                  // The Mechanar
            { 555, sConfigMgr->GetOption<uint32>("Solocraft.AuchindounShadow.Level", 68) },                    // Shadow Labyrinth
            { 556, sConfigMgr->GetOption<uint32>("Solocraft.AuchindounDemon.Level", 68) },                     // Sethekk Halls
            { 557, sConfigMgr->GetOption<uint32>("Solocraft.AuchindounEthereal.Level", 68) },                  // Mana-Tombs
            { 558, sConfigMgr->GetOption<uint32>("Solocraft.AuchindounDraenei.Level", 68) },                   // Auchenai Crypts
            { 560, sConfigMgr->GetOption<uint32>("Solocraft.HillsbradPast.Level", 68) },                       // Old Hillsbrad Foothills
            { 564, sConfigMgr->GetOption<uint32>("Solocraft.BlackTemple.Level", 70) },
            { 565, sConfigMgr->GetOption<uint32>("Solocraft.GruulsLair.Level", 70) },
            { 568, sConfigMgr->GetOption<uint32>("Solocraft.ZulAman.Level", 68) },
            { 580, sConfigMgr->GetOption<uint32>("Solocraft.SunwellPlateau.Level", 70) },
            { 585, sConfigMgr->GetOption<uint32>("Solocraft.Sunwell5ManFix.Level", 68) },                      // Magister's Terrace

            // WOTLK Instances
            { 533, sConfigMgr->GetOption<uint32>("Solocraft.StratholmeRaid.Level", 78) },                      // Naxxramas
            { 574, sConfigMgr->GetOption<uint32>("Solocraft.Valgarde70.Level", 78) },                          // Utgarde Keep
            { 575, sConfigMgr->GetOption<uint32>("Solocraft.UtgardePinnacle.Level", 78) },
            { 576, sConfigMgr->GetOption<uint32>("Solocraft.Nexus70.Level", 78) },                             // The Nexus
            { 578, sConfigMgr->GetOption<uint32>("Solocraft.Nexus80.Level", 78) },                             // The Occulus
            { 595, sConfigMgr->GetOption<uint32>("Solocraft.StratholmeCOT.Level", 78) },                       // The Culling of Stratholme
            { 599, sConfigMgr->GetOption<uint32>("Solocraft.Ulduar70.Level", 78) },                            // Halls of Stone
            { 600, sConfigMgr->GetOption<uint32>("Solocraft.DrakTheronKeep.Level", 78) },                      // Drak'Tharon Keep
            { 601, sConfigMgr->GetOption<uint32>("Solocraft.Azjol_Uppercity.Level", 78) },                     // Azjol-Nerub
            { 602, sConfigMgr->GetOption<uint32>("Solocraft.Ulduar80.Level", 78) },                            // Halls of Lighting
            { 603, sConfigMgr->GetOption<uint32>("Solocraft.UlduarRaid.Level", 80) },                          // Ulduar
            { 604, sConfigMgr->GetOption<uint32>("Solocraft.GunDrak.Level", 78) },
            { 608, sConfigMgr->GetOption<uint32>("Solocraft.DalaranPrison.Level", 78) },                       // Violet Hold
            { 615, sConfigMgr->GetOption<uint32>("Solocraft.ChamberOfAspectsBlack.Level", 80) },               // The Obsidian Sanctum
            { 616, sConfigMgr->GetOption<uint32>("Solocraft.NexusRaid.Level", 80) },                           // The Eye of Eternity
            { 619, sConfigMgr->GetOption<uint32>("Solocraft.Azjol_LowerCity.Level", 78) },                     // Ahn'kahet: The Old Kingdom
            { 631, sConfigMgr->GetOption<uint32>("Solocraft.IcecrownCitadel.Level", 80) },                     // Icecrown Citadel
            { 632, sConfigMgr->GetOption<uint32>("Solocraft.IcecrownCitadel5Man.Level", 78) },                 // The Forge of Souls
            { 649, sConfigMgr->GetOption<uint32>("Solocraft.ArgentTournamentRaid.Level", 80) },                // Trial of the Crusader
            { 650, sConfigMgr->GetOption<uint32>("Solocraft.ArgentTournamentDungeon.Level", 80) },             // Trial of the Champion
            { 658, sConfigMgr->GetOption<uint32>("Solocraft.QuarryOfTears.Level", 78) },                       // Pit of Saron
            { 668, sConfigMgr->GetOption<uint32>("Solocraft.HallsOfReflection.Level", 78) },                   // Halls of Reflection
            { 724, sConfigMgr->GetOption<uint32>("Solocraft.ChamberOfAspectsRed.Level", 80) },                 // The Ruby Sanctum
        };

        // Dungeon Difficulty
        DifficultyDefault5  = sConfigMgr->GetOption<float>("Solocraft.Dungeon", 5.0f);
        DifficultyDefault10 = sConfigMgr->GetOption<float>("Solocraft.Heroic", 10.0f);
        DifficultyDefault25 = sConfigMgr->GetOption<float>("Solocraft.Raid25", 25.0f);
        DifficultyDefault40 = sConfigMgr->GetOption<float>("Solocraft.Raid40", 40.0f);

        dungeonDifficultyNormalMap =
        {
            // WOW Classic Instances
            { 33,  sConfigMgr->GetOption<float>("Solocraft.ShadowfangKeep", 5.0) },
            { 34,  sConfigMgr->GetOption<float>("Solocraft.Stockades", 5.0) },
            { 36,  sConfigMgr->GetOption<float>("Solocraft.Deadmines", 5.0) },
            { 43,  sConfigMgr->GetOption<float>("Solocraft.WailingCaverns", 5.0) },
            { 47,  sConfigMgr->GetOption<float>("Solocraft.RazorfenKraulInstance", 5.0) },
            { 48,  sConfigMgr->GetOption<float>("Solocraft.Blackfathom", 5.0) },
            { 70,  sConfigMgr->GetOption<float>("Solocraft.Uldaman", 5.0) },
            { 90,  sConfigMgr->GetOption<float>("Solocraft.GnomeragonInstance", 5.0) },
            { 109, sConfigMgr->GetOption<float>("Solocraft.SunkenTemple", 5.0) },
            { 129, sConfigMgr->GetOption<float>("Solocraft.RazorfenDowns", 5.0) },
            { 189, sConfigMgr->GetOption<float>("Solocraft.MonasteryInstances", 5.0) },                     // Scarlet
            { 209, sConfigMgr->GetOption<float>("Solocraft.TanarisInstance", 5.0) },                        // Zul'Farrak
            { 229, sConfigMgr->GetOption<float>("Solocraft.BlackRockSpire", 10.0) },
            { 230, sConfigMgr->GetOption<float>("Solocraft.BlackrockDepths", 5.0) },
            { 249, sConfigMgr->GetOption<float>("Solocraft.OnyxiaLairInstance", 40.0) },
            { 289, sConfigMgr->GetOption<float>("Solocraft.SchoolofNecromancy", 5.0) },                     // Scholo
            { 309, sConfigMgr->GetOption<float>("Solocraft.Zul'gurub", 20.0) },
            { 329, sConfigMgr->GetOption<float>("Solocraft.Stratholme", 5.0) },
            { 349, sConfigMgr->GetOption<float>("Solocraft.Mauradon", 5.0) },
            { 389, sConfigMgr->GetOption<float>("Solocraft.OrgrimmarInstance", 5.0) },                      // Ragefire
            { 409, sConfigMgr->GetOption<float>("Solocraft.MoltenCore", 40.0) },
            { 429, sConfigMgr->GetOption<float>("Solocraft.DireMaul", 5.0) },
            { 469, sConfigMgr->GetOption<float>("Solocraft.BlackwingLair", 40.0) },
            { 509, sConfigMgr->GetOption<float>("Solocraft.AhnQiraj", 20.0) },
            { 531, sConfigMgr->GetOption<float>("Solocraft.AhnQirajTemple", 40.0) },

            // BC Instances
            { 269, sConfigMgr->GetOption<float>("Solocraft.CavernsOfTime", 5.0) },                          // Black Morass
            { 532, sConfigMgr->GetOption<float>("Solocraft.Karazahn", 10.0) },
            { 534, sConfigMgr->GetOption<float>("Solocraft.HyjalPast", 25.0) },                             // Mount Hyjal
            { 540, sConfigMgr->GetOption<float>("Solocraft.HellfireMilitary", 5.0) },                       // The Shattered Halls
            { 542, sConfigMgr->GetOption<float>("Solocraft.HellfireDemon", 5.0) },                          // The Blood Furnace
            { 543, sConfigMgr->GetOption<float>("Solocraft.HellfireRampart", 5.0) },
            { 544, sConfigMgr->GetOption<float>("Solocraft.HellfireRaid", 25.0) },                          // Magtheridon's Lair
            { 545, sConfigMgr->GetOption<float>("Solocraft.CoilfangPumping", 5.0) },                        // The Steamvault
            { 546, sConfigMgr->GetOption<float>("Solocraft.CoilfangMarsh", 5.0) },                          // The Underbog
            { 547, sConfigMgr->GetOption<float>("Solocraft.CoilfangDraenei", 5.0) },                        // The Slavepens
            { 548, sConfigMgr->GetOption<float>("Solocraft.CoilfangRaid", 25.0) },                          // Serpentshrine Cavern
            { 550, sConfigMgr->GetOption<float>("Solocraft.TempestKeepRaid", 25.0) },                       // The Eye
            { 552, sConfigMgr->GetOption<float>("Solocraft.TempestKeepArcane", 5.0) },                      // The Arcatraz
            { 553, sConfigMgr->GetOption<float>("Solocraft.TempestKeepAtrium", 5.0) },                      // The Botanica
            { 554, sConfigMgr->GetOption<float>("Solocraft.TempestKeepFactory", 5.0) },                     // The Mechanar
            { 555, sConfigMgr->GetOption<float>("Solocraft.AuchindounShadow", 5.0) },                       // Shadow Labyrinth
            { 556, sConfigMgr->GetOption<float>("Solocraft.AuchindounDemon", 5.0) },                        // Sethekk Halls
            { 557, sConfigMgr->GetOption<float>("Solocraft.AuchindounEthereal", 5.0) },                     // Mana-Tombs
            { 558, sConfigMgr->GetOption<float>("Solocraft.AuchindounDraenei", 5.0) },                      // Auchenai Crypts
            { 560, sConfigMgr->GetOption<float>("Solocraft.HillsbradPast", 5.0) },                          // Old Hillsbrad Foothills
            { 564, sConfigMgr->GetOption<float>("Solocraft.BlackTemple", 25.0) },
            { 565, sConfigMgr->GetOption<float>("Solocraft.GruulsLair", 25.0) },
            { 568, sConfigMgr->GetOption<float>("Solocraft.ZulAman", 5.0) },
            { 580, sConfigMgr->GetOption<float>("Solocraft.SunwellPlateau", 25.0) },
            { 585, sConfigMgr->GetOption<float>("Solocraft.Sunwell5ManFix", 5.0) },                         // Magister's Terrace

            // WOTLK Instances
            { 533, sConfigMgr->GetOption<float>("Solocraft.StratholmeRaid", 10.0) },                        //  Nax 10
            { 574, sConfigMgr->GetOption<float>("Solocraft.Valgarde70", 5.0) },                             // Utgarde Keep
            { 575, sConfigMgr->GetOption<float>("Solocraft.UtgardePinnacle", 5.0) },
            { 576, sConfigMgr->GetOption<float>("Solocraft.Nexus70", 5.0) },                                // The Nexus
            { 578, sConfigMgr->GetOption<float>("Solocraft.Nexus80", 5.0) },                                // The Occulus
            { 595, sConfigMgr->GetOption<float>("Solocraft.StratholmeCOT", 5.0) },                          // The Culling of Stratholme
            { 599, sConfigMgr->GetOption<float>("Solocraft.Ulduar70", 5.0) },                               // Halls of Stone
            { 600, sConfigMgr->GetOption<float>("Solocraft.DrakTheronKeep", 5.0) },                         // Drak'Tharon Keep
            { 601, sConfigMgr->GetOption<float>("Solocraft.Azjol_Uppercity", 5.0) },                        // Azjol-Nerub
            { 602, sConfigMgr->GetOption<float>("Solocraft.Ulduar80", 5.0) },                               // Halls of Lighting
            { 603, sConfigMgr->GetOption<float>("Solocraft.UlduarRaid", 10.0) },                            // Ulduar 10
            { 604, sConfigMgr->GetOption<float>("Solocraft.GunDrak", 5.0) },
            { 608, sConfigMgr->GetOption<float>("Solocraft.DalaranPrison", 5.0) },                          // Violet Hold
            { 615, sConfigMgr->GetOption<float>("Solocraft.ChamberOfAspectsBlack", 10.0) },                 // The Obsidian Sanctum 10
            { 616, sConfigMgr->GetOption<float>("Solocraft.NexusRaid", 10.0) },                             // The Eye of Eternity 10
            { 619, sConfigMgr->GetOption<float>("Solocraft.Azjol_LowerCity", 5.0) },                        // Ahn'kahet: The Old Kingdom
            { 631, sConfigMgr->GetOption<float>("Solocraft.IcecrownCitadel", 10.0) },                       // Icecrown Citadel 10
            { 632, sConfigMgr->GetOption<float>("Solocraft.IcecrownCitadel5Man", 5.0) },                    // The Forge of Souls
            { 649, sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentRaid", 10.0) },                  // Trial of the Crusader 10
            { 650, sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentDungeon", 5.0) },                // Trial of the Champion
            { 658, sConfigMgr->GetOption<float>("Solocraft.QuarryOfTears", 5.0) },                          // Pit of Saron
            { 668, sConfigMgr->GetOption<float>("Solocraft.HallsOfReflection", 5.0) },                      // Halls of Reflection
            { 724, sConfigMgr->GetOption<float>("Solocraft.ChamberOfAspectsRed", 10.0) },                   // The Ruby Sanctum 10
        };

        // Heroics
        dungeonDifficultyHeroicMap =
        {
            // BC Instances Heroics
            { 269, sConfigMgr->GetOption<float>("Solocraft.CavernsOfTimeH", 5.0) },                         // Black Morass H
            { 540, sConfigMgr->GetOption<float>("Solocraft.HellfireMilitaryH", 5.0) },                      // The Shattered Halls H
            { 542, sConfigMgr->GetOption<float>("Solocraft.HellfireDemonH", 5.0) },                         // The Blood Furnace H
            { 543, sConfigMgr->GetOption<float>("Solocraft.HellfireRampartH", 5.0) },                       // Heroic
            { 545, sConfigMgr->GetOption<float>("Solocraft.CoilfangPumpingH", 5.0) },                       // The Steamvault
            { 546, sConfigMgr->GetOption<float>("Solocraft.CoilfangMarshH", 5.0) },                         // The Underbog
            { 547, sConfigMgr->GetOption<float>("Solocraft.CoilfangDraeneiH", 5.0) },                       // The Slavepens  H
            { 552, sConfigMgr->GetOption<float>("Solocraft.TempestKeepArcaneH", 5.0) },                     // The Arcatraz H
            { 553, sConfigMgr->GetOption<float>("Solocraft.TempestKeepAtriumH", 5.0) },                     // The Botanica H
            { 554, sConfigMgr->GetOption<float>("Solocraft.TempestKeepFactoryH", 5.0) },                    // The Mechanar H
            { 555, sConfigMgr->GetOption<float>("Solocraft.AuchindounShadowH", 5.0) },                      // Shadow Labyrinth H
            { 556, sConfigMgr->GetOption<float>("Solocraft.AuchindounDemonH", 5.0) },                       // Sethekk Halls H
            { 557, sConfigMgr->GetOption<float>("Solocraft.AuchindounEtherealH", 5.0) },                    // Mana-Tombs H
            { 558, sConfigMgr->GetOption<float>("Solocraft.AuchindounDraeneiH", 5.0) },                     // Auchenai Crypts H
            { 560, sConfigMgr->GetOption<float>("Solocraft.HillsbradPastH", 5.0) },                         // Old Hillsbrad Foothills H
            { 568, sConfigMgr->GetOption<float>("Solocraft.ZulAmanH", 5.0) },                               // Zul'Aman H
            { 585, sConfigMgr->GetOption<float>("Solocraft.Sunwell5ManFixH", 5.0) },                        // Magister's Terrace H

            // WOTLK Instances Heroics
            { 533, sConfigMgr->GetOption<float>("Solocraft.StratholmeRaidH", 25.0) },                       // Naxxramas 25
            { 574, sConfigMgr->GetOption<float>("Solocraft.Valgarde70H", 5.0) },                            // Utgarde Keep H
            { 575, sConfigMgr->GetOption<float>("Solocraft.UtgardePinnacleH", 5.0) },                       // Utgarde Pinnacle H
            { 576, sConfigMgr->GetOption<float>("Solocraft.Nexus70H", 5.0) },                               // The Nexus H
            { 578, sConfigMgr->GetOption<float>("Solocraft.Nexus80H", 5.0) },                               // The Occulus H
            { 595, sConfigMgr->GetOption<float>("Solocraft.StratholmeCOTH", 5.0) },                         // The Culling of Stratholme H
            { 599, sConfigMgr->GetOption<float>("Solocraft.Ulduar70H", 5.0) },                              // Halls of Stone H
            { 600, sConfigMgr->GetOption<float>("Solocraft.DrakTheronKeepH", 5.0) },                        // Drak'Tharon Keep H
            { 601, sConfigMgr->GetOption<float>("Solocraft.Azjol_UppercityH", 5.0) },                       // Azjol-Nerub H
            { 602, sConfigMgr->GetOption<float>("Solocraft.Ulduar80H", 5.0) },                              // Halls of Lighting H
            { 603, sConfigMgr->GetOption<float>("Solocraft.UlduarRaidH", 25.0) },                           // Ulduar 25
            { 604, sConfigMgr->GetOption<float>("Solocraft.GunDrakH", 5.0) },                               // Gundrak H
            { 608, sConfigMgr->GetOption<float>("Solocraft.DalaranPrisonH", 5.0) },                         // Violet Hold H
            { 615, sConfigMgr->GetOption<float>("Solocraft.ChamberOfAspectsBlackH", 25.0) },                // The Obsidian Sanctum 25
            { 616, sConfigMgr->GetOption<float>("Solocraft.NexusRaidH", 25.0) },                            // The Eye of Eternity 25
            { 619, sConfigMgr->GetOption<float>("Solocraft.Azjol_LowerCityH", 5.0) },                       // Ahn'kahet: The Old Kingdom H
            { 631, sConfigMgr->GetOption<float>("Solocraft.IcecrownCitadelH", 25.0) },                      // Icecrown Citadel 25
            { 632, sConfigMgr->GetOption<float>("Solocraft.IcecrownCitadel5ManH", 5.0) },                   // The Forge of Souls
            { 649, sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentRaidH", 25.0) },                 // Trial of the Crusader 25
            { 650, sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentDungeonH", 5.0) },               // Trial of the Champion H
            { 658, sConfigMgr->GetOption<float>("Solocraft.QuarryOfTearsH", 5.0) },                         // Pit of Saron H
            { 668, sConfigMgr->GetOption<float>("Solocraft.HallsOfReflectionH", 5.0) },                     // Halls of Reflection H
            { 724, sConfigMgr->GetOption<float>("Solocraft.ChamberOfAspectsRedH", 25.0) },                  // The Ruby Sanctum 25
        };

        // Unique Raids beyond the heroic and normal versions of themselves
        DifficultyDefault649H10 = sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentRaidH10", 10.0f); // Trial of the Crusader 10 Heroic
        DifficultyDefault649H25 = sConfigMgr->GetOption<float>("Solocraft.ArgentTournamentRaidH25", 25.0f); // Trial of the Crusader 25 Heroic
    }
};

void AddSolocraftScripts()
{
    new SolocraftAnnounce();
    new SolocraftNPCBotScript();
    new SolocraftPlayerScript();
    new SolocraftGroupScript();
    new SolocraftVehicleScript();
    new SolocraftConfig();
}

#ifdef _MSC_VER
# pragma warning(pop)
#endif
