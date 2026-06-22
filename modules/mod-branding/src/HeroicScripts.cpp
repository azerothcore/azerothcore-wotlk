#include "HeroicMgr.h"
#include "mod_branding_loader.h"
#include "Creature.h"
#include "Map.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Branding;

namespace
{
    // Only scale hostile-ish instance creatures. Pets/totems/critters/player-controlled are left alone.
    bool ShouldScale(Creature* creature)
    {
        if (!creature)
        {
            return false;
        }

        Map* map = creature->GetMap();
        if (!map || !map->IsDungeon())
        {
            return false;
        }

        if (creature->IsPet() || creature->IsTotem() || creature->IsCritter() || creature->IsControlledByPlayer())
        {
            return false;
        }

        return true;
    }
}

// Loads/refreshes heroic config + the advisory exception table on startup and `.reload config`.
class BrandingHeroicWorldScript : public WorldScript
{
public:
    BrandingHeroicWorldScript() : WorldScript("BrandingHeroicWorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sHeroicMgr->LoadConfig();
        sHeroicMgr->LoadExceptions();
    }
};

// Snapshots the instance's heroic decision from the SELECTED difficulty when a player enters (§2.4.1).
class BrandingHeroicMapScript : public AllMapScript
{
public:
    BrandingHeroicMapScript() : AllMapScript("BrandingHeroicMapScript") { }

    void OnPlayerEnterAll(Map* map, Player* player) override
    {
        sHeroicMgr->OnPlayerEnterInstance(map, player);
    }
};

// Applies the overlay to instance creatures: level target at select-level, HP multiplier at add-world.
class BrandingHeroicCreatureScript : public AllCreatureScript
{
public:
    BrandingHeroicCreatureScript() : AllCreatureScript("BrandingHeroicCreatureScript") { }

    void OnBeforeCreatureSelectLevel(CreatureTemplate const* /*cinfo*/, Creature* creature, uint8& level) override
    {
        if (!sHeroicMgr->Enabled() || !ShouldScale(creature))
        {
            return;
        }

        uint8_t target = 0;
        if (sHeroicMgr->LevelTargetFor(creature->GetMap(), target) && target > level)
        {
            level = target;
        }
    }

    void OnCreatureAddWorld(Creature* creature) override
    {
        if (!sHeroicMgr->Enabled() || !ShouldScale(creature))
        {
            return;
        }

        double const mul = sHeroicMgr->HealthMulFor(creature->GetMap());
        if (mul > 1.0)
        {
            uint32 const maxHealth = static_cast<uint32>(creature->GetMaxHealth() * mul);
            creature->SetMaxHealth(maxHealth);
            creature->SetHealth(maxHealth);
        }
    }
};

// Scales a scaled creature's OUTGOING damage by the overlay multiplier (mirrors the §2.1 pattern).
class BrandingHeroicUnitScript : public UnitScript
{
public:
    BrandingHeroicUnitScript() : UnitScript("BrandingHeroicUnitScript") { }

    void ModifyMeleeDamage(Unit* /*target*/, Unit* attacker, uint32& damage) override
    {
        Scale(attacker, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* /*target*/, Unit* attacker, uint32& damage, SpellInfo const* /*spellInfo*/) override
    {
        Scale(attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* /*target*/, Unit* attacker, int32& damage, SpellInfo const* /*spellInfo*/) override
    {
        double const mul = MulFor(attacker);
        if (mul > 1.0)
        {
            damage = static_cast<int32>(damage * mul);
        }
    }

private:
    static double MulFor(Unit* attacker)
    {
        if (!sHeroicMgr->Enabled() || !attacker)
        {
            return 1.0;
        }

        Creature* creature = attacker->ToCreature();
        if (!creature || creature->IsPet() || creature->IsControlledByPlayer())
        {
            return 1.0;
        }

        return sHeroicMgr->DamageMulFor(creature->GetMap());
    }

    static void Scale(Unit* attacker, uint32& damage)
    {
        double const mul = MulFor(attacker);
        if (mul > 1.0)
        {
            damage = static_cast<uint32>(damage * mul);
        }
    }
};

void AddBrandingHeroicScripts()
{
    new BrandingHeroicWorldScript();
    new BrandingHeroicMapScript();
    new BrandingHeroicCreatureScript();
    new BrandingHeroicUnitScript();
}
