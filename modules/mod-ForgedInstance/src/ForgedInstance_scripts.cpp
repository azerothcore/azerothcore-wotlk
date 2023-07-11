/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "ForgedInstanceManager.h"
#include "ScriptedAI/ScriptedCreature.h"
#include "GossipDef.h"
#include "ScriptedGossip.h"
#include "MapMgr.h"
#include "Chat.h"
#include "ScriptMgr.h"

class go_ForgedInstance : public GameObjectScript
{
public:
    go_ForgedInstance() : GameObjectScript("go_ForgedInstance") {}

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        Map* map = player->GetMap();
        std::string mapName = map->GetMapName();
        std::string gossip = "Start " + mapName + " on ForgedInstance difficulty.";
        if (!ForgedInstanceManager::IsInForgedInstance(player)) {
            AddGossipItemFor(player, 0, gossip, 0, 0);
            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, go->GetGUID());
        }
        return true;
    }

    bool OnGossipSelect(Player* player, GameObject* go, uint32 sender, uint32 action) override
    {
        if (action == 0)
            ForgedInstanceManager::StartForgedInstance(player, 0);

        CloseGossipMenuFor(player);
        return true;
    }
};

class AutoBalance_AllCreatureScript : public AllCreatureScript
{
public:
    AutoBalance_AllCreatureScript()
        : AllCreatureScript("AutoBalance_AllCreatureScript")
    {
    }

    void Creature_SelectLevel(const CreatureTemplate* /*creatureTemplate*/, Creature* creature) override
    {
        ModifyCreatureAttributes(creature, true);
    }

    void OnAllCreatureUpdate(Creature* creature, uint32 /*diff*/) override
    {
        ModifyCreatureAttributes(creature);
    }

    void ModifyCreatureAttributes(Creature* creature, bool resetSelLevel = false)
    {
        if (!creature || !creature->GetMap())
            return;

        if ((creature->IsHunterPet() || creature->IsPet() || creature->IsSummon()))
            return;

        if (!creature->GetMap()->IsDungeon())
            return;

        if (creature->GetMap()->IsBattleground())
            return;

        if (!creature->IsAlive())
            return;

        if (creature->IsInCombat())
            return;

        if (!ForgedInstanceManager::IsInForgedInstance(creature->GetMap()->GetInstanceId()))
            return;

        CreatureBaseStats const* origCreatureStats = sObjectMgr->GetCreatureBaseStats(creature->getLevel(), creature->GetCreatureTemplate()->unit_class);
        uint32 baseHealth = origCreatureStats->GenerateHealth(creature->GetCreatureTemplate());
        uint32 baseMana = origCreatureStats->GenerateMana(creature->GetCreatureTemplate());

        if (creature->GetMaxHealth() == baseHealth)
            ForgedInstanceManager::RemoveGuidCalculated(creature);

        if (ForgedInstanceManager::creatureAlreadyCalculated(creature->GetMap()->GetInstanceId(), creature->GetGUID().GetCounter()))
            return;

        ForgedInstanceManager::ForgedInstance ForgedInstance = ForgedInstanceManager::GetForgedInstanceEncounter(creature->GetMap()->GetInstanceId());
        uint32 playersCounts = creature->GetMap()->GetPlayersCountExceptGMs() < 10 ? 10 : creature->GetMap()->GetPlayersCountExceptGMs();

        float scaleWithPlayers = 0.0f;
        float scaledHealth = 0.0f;
        float scaledMana = 0.0f;

        Modifier modifier = ForgedInstanceManager::GetModifier(creature->GetMapId());

        if (ForgedInstance.isRaid) {
            scaleWithPlayers = modifier.healthCofficient * playersCounts;
            scaledHealth = round((baseHealth) * scaleWithPlayers);
            scaledMana = round((baseMana) * scaleWithPlayers);
        }
        else {
            float multiplier = sConfigMgr->GetOption<float>("HpDungeonMultiplier", 4.0f);
            scaledHealth = round(((float)baseHealth * multiplier));
            scaledMana = round(((float)baseMana * multiplier));
        }

        creature->SetMaxHealth(scaledHealth);
        creature->SetHealth(scaledHealth);
        creature->SetMaxPower(POWER_MANA, scaledMana);
        creature->SetPower(POWER_MANA, scaledMana);
        ForgedInstanceManager::AddCreatureCalculated(creature->GetMap(), creature->GetGUID().GetCounter());
    };
};


class AutoBalance_UnitScript : public UnitScript
{
public:
    AutoBalance_UnitScript()
        : UnitScript("AutoBalance_UnitScript", true)
    {
    }

    uint32 DealDamage(Unit* AttackerUnit, Unit* playerVictim, uint32 damage, DamageEffectType /*damagetype*/) override
    {
        if (playerVictim->IsControlledByPlayer())
            return damage;

        return _Modifer_DealDamage(playerVictim, AttackerUnit, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage) override
    {
        if (target->IsControlledByPlayer())
            return;

        damage = _Modifer_DealDamage(target, attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage) override
    {
        if (target->IsControlledByPlayer())
            return;

        damage = _Modifer_DealDamage(target, attacker, damage);
    }

    void ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage) override
    {
        if (target->IsControlledByPlayer())
            return;

        damage = _Modifer_DealDamage(target, attacker, damage);
    }

    void ModifyHealRecieved(Unit* target, Unit* attacker, uint32& damage) override
    {
        if (target->IsControlledByPlayer())
            return;

        damage = _Modifer_DealDamage(target, attacker, damage);
    }

    uint32 _Modifer_DealDamage(Unit* target, Unit* attacker, uint32 damage)
    {
        if (!attacker || !attacker->GetMap())
            return damage;

        if (attacker->GetMap()->IsBattleground())
            return damage;

        if (!ForgedInstanceManager::IsInForgedInstance(target->GetMap()->GetInstanceId()))
            return damage;

        if (!attacker->ToCreature())
            return damage;

        if (!attacker->ToCreature()->isWorldBoss() && !attacker->ToCreature()->IsDungeonBoss())
            return damage;

        if (!attacker || attacker->GetTypeId() == TYPEID_PLAYER || !attacker->IsInWorld())
            return damage;

        ForgedInstanceManager::ForgedInstance ForgedInstance = ForgedInstanceManager::GetForgedInstanceEncounter(attacker->GetMap()->GetInstanceId());

        float raidMultiplier = sConfigMgr->GetOption<float>("RaidMultiplier", 1.5f);
        float dungeonMultiplier = sConfigMgr->GetOption<float>("DungeonMultiplier", 3.0f);
        float damageMultiplier = ForgedInstance.isRaid ? raidMultiplier : dungeonMultiplier; // default in ForgedInstance

        Modifier modifier = ForgedInstanceManager::GetModifier(attacker->GetMapId());

        if (modifier.meleeMultiplier)
            damageMultiplier = modifier.meleeMultiplier;

        if ((attacker->IsHunterPet() || attacker->IsPet() || attacker->IsSummon()) && attacker->IsControlledByPlayer())
            return damage;

        return damage * damageMultiplier;
    }
};


class PS_ForgedInstance : public PlayerScript
{
public:
    PS_ForgedInstance() : PlayerScript("PS_ForgedInstance") { }

    void OnMapChanged(Player* player) {

        if (!player)
            return;

        if (Group* group = player->GetGroup())
            ForgedInstanceManager::ResetForgedInstance(group, false);
    }
};

class GS_ForgedInstance : public GroupScript
{
public:
    GS_ForgedInstance() : GroupScript("GS_ForgedInstance") { }

    void OnDisband(Group* group) {

        if (!group)
            return;

        ForgedInstanceManager::ResetForgedInstance(group, true);
    }
};


class CS_ForgedInstance : public CommandScript
{
public:
    CS_ForgedInstance() : CommandScript("CS_ForgedInstance") { }

    std::vector<ChatCommand> GetCommands() const
    {
        static Acore::ChatCommands::ChatCommandTable commandTable =
        {
            { "reloadallForgedInstance", HandleResetModifier, SEC_ADMINISTRATOR, Acore::ChatCommands::Console::No },
        };
        return commandTable;
    }

    static bool HandleResetModifier(ChatHandler* handler, const char* args)
    {
        ForgedInstanceManager::PreloadAllCompletions();
        ForgedInstanceManager::PreloadAllCreaturesIds();
        ForgedInstanceManager::PreloadAllLoot();
        ForgedInstanceManager::PreloadAllRequierements();
        return true;
    }
};

class US_ForgedInstance : public UnitScript
{
public:
    US_ForgedInstance() : UnitScript("CS_ForgedInstance") { }

    void OnBossCompleted(Unit* unit, Creature* creature, GameObject* go, uint32 bossId) {
        if (go)
            ForgedInstanceManager::CreateLoot(bossId, go);
        else 
            ForgedInstanceManager::CreateLoot(bossId, creature);
    }

    void OnBossEnterCombat(Creature* creature, uint32 bossId) {
         ForgedInstanceManager::RemoveGuidCalculated(creature);
    }
    
};

class WS_ForgedInstance : public WorldScript
{
public:
    WS_ForgedInstance() : WorldScript("WS_ForgedInstance") { }

    void OnAfterConfigLoad(bool reload) override
    {
        ForgedInstanceManager::PreloadAllCompletions();
        ForgedInstanceManager::PreloadAllCreaturesIds();
        ForgedInstanceManager::PreloadAllLoot();
        ForgedInstanceManager::PreloadAllRequierements();
    }
};

// Add all scripts in one
void AddSC_ForgedInstance()
{
    //new PS_ForgedInstance();
    //new CS_ForgedInstance();
    //new GS_ForgedInstance();
    //new US_ForgedInstance();
    //new WS_ForgedInstance();
    //new go_ForgedInstance();
    //new AutoBalance_UnitScript();
    //new AutoBalance_AllCreatureScript();
}
