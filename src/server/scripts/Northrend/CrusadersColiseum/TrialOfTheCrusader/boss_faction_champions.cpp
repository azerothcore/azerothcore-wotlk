/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "trial_of_the_crusader.h"
#include "SpellScript.h"
#include "Player.h"

enum eAIs
{
    AI_MELEE    = 0,
    AI_RANGED   = 1,
    AI_HEALER   = 2,
    AI_PET      = 3,
};

enum eSharedSpells
{
    SPELL_ANTI_AOE                              = 68595,
    SPELL_PVP_TRINKET                           = 65547,
};

struct boss_faction_championsAI : public ScriptedAI
{
    boss_faction_championsAI(Creature* pCreature, uint32 aitype) : ScriptedAI(pCreature)
    {
        pInstance = pCreature->GetInstanceScript();
        me->SetReactState(REACT_PASSIVE);
        mAIType = aitype;
        threatTimer = 2000;
        powerTimer = 1000;
    }

    InstanceScript* pInstance;
    uint32 mAIType;
    uint32 threatTimer;
    uint32 powerTimer;

    void EnterCombat(Unit* /*who*/)
    {
        me->SetInCombatWithZone();
        RecalculateThreat();
        if( pInstance )
            pInstance->SetData(TYPE_FACTION_CHAMPIONS_START, 0);
    }

    void AttackStart(Unit* who)
    {
        if( !who )
            return;

        if( mAIType == AI_MELEE || mAIType == AI_PET )
            UnitAI::AttackStart(who);
        else
            UnitAI::AttackStartCaster(who, 18.5f);
    }

    float GetThreatMod(float dist, float  /*armor*/, uint32 health, uint32 /*maxhealth*/, Unit* target)
    {
        /*float mod_health = ((float)health)/maxhealth;
        if (mod_health < 0.4f) mod_health = 0.4f;
        float unimportant_dist = (mAIType == AI_MELEE || mAIType == AI_PET ? 5.0f : 20.0f);
        if (dist > unimportant_dist)
            dist -= unimportant_dist; // compensate melee range
        else
            dist = 0.0f;
        float mod_dist = 25.0f/(25.0f + dist);
        float mod_armor = (mAIType == AI_MELEE || mAIType == AI_PET) ? armor / 16635.0f : 0.0f;
        return mod_dist / ((0.15f+mod_armor)*mod_health);*/

        // TC:
        /*float dist_mod = (mAIType == AI_MELEE || mAIType == AI_PET) ? 15.0f / (15.0f + dist) : 1.0f;
        float armor_mod = (mAIType == AI_MELEE || mAIType == AI_PET) ? armor / 16635.0f : 0.0f;
        float eh = (health + 1) * (1.0f + armor_mod);
        return dist_mod * 30000.0f / eh;*/

        // third try:
        float unimportant_dist = (mAIType == AI_MELEE || mAIType == AI_PET ? 5.0f : 35.0f);
        if (dist > unimportant_dist) dist -= unimportant_dist;
        else dist = 0.0f;
        const float dist_factor = (mAIType == AI_MELEE || mAIType == AI_PET ? 15.0f : 25.0f);
        float mod_dist = dist_factor / (dist_factor + dist); // 0.2 .. 1.0
        float mod_health = health > 40000 ? 2.0f : (60000 - health) / 10000.0f; // 2.0 .. 6.0
        float mod_armor = (mAIType == AI_MELEE || mAIType == AI_PET) ? Unit::CalcArmorReducedDamage(me, target, 10000, nullptr) / 10000.0f : 1.0f;
        return mod_dist * mod_health * mod_armor;
    }

    void RecalculateThreat()
    {
        ThreatContainer::StorageType const& tList = me->getThreatManager().getThreatList();
        for( ThreatContainer::StorageType::const_iterator itr = tList.begin(); itr != tList.end(); ++itr )
        {
            Unit* pUnit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid());
            if( pUnit && pUnit->GetTypeId() == TYPEID_PLAYER && me->getThreatManager().getThreat(pUnit) )
            {
                float threatMod = GetThreatMod(me->GetDistance2d(pUnit), (float)pUnit->GetArmor(), pUnit->GetHealth(), pUnit->GetMaxHealth(), pUnit);
                me->getThreatManager().modifyThreatPercent(pUnit, -100);
                //me->getThreatManager().doAddThreat(pUnit, 10000000.0f * threatMod);
                if (HostileReference* ref = me->getThreatManager().getOnlineContainer().getReferenceByTarget(pUnit))
                    ref->addThreat(10000000.0f * threatMod);
            }
        }
    }

    void EventMapGCD(EventMap& e, uint32 delay, uint32 gcd = 0)
    {
        e.DelayEventsToMax(delay, gcd);
    }

    void JustDied(Unit* /*pKiller*/)
    {
        if( pInstance && mAIType != AI_PET )
            pInstance->SetData(TYPE_FACTION_CHAMPIONS, DONE);
    }

    void KilledUnit(Unit*  /*who*/)
    {
        if( pInstance )
            pInstance->SetData(TYPE_FACTION_CHAMPIONS_PLAYER_DIED, 1);
    }

    void EnterEvadeMode()
    {
        if( pInstance )
            pInstance->SetData(TYPE_FAILED, 0);
    }

    bool IsCCed()
    {
        // check for stun, fear, etc.
        // for casting, silence, disarm check individually in the ai
        if( me->isFeared() || me->isFrozen() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasUnitState(UNIT_STATE_CONFUSED) )
        {
            if( !IsHeroic() )
                return true;
            if( me->HasSpellCooldown(SPELL_PVP_TRINKET) )
                return true;
            else
            {
                me->CastSpell(me, SPELL_PVP_TRINKET, false);
                me->AddSpellCooldown(SPELL_PVP_TRINKET, 0, 0);
            }
        }
        return false;
    }

    Creature* SelectTarget_MostHPLostFriendlyMissingBuff(uint32 spell, float range)
    {
        std::list<Creature*> lst = DoFindFriendlyMissingBuff(range, spell);
        if( lst.empty() )
            return nullptr;
        std::list<Creature*>::const_iterator iter = lst.begin();
        uint32 lowestHP = (*iter)->GetMaxHealth() - (*iter)->GetHealth();
        for( std::list<Creature*>::const_iterator itr = lst.begin(); itr != lst.end(); ++itr )
            if( ((*itr)->GetMaxHealth() - (*itr)->GetHealth()) > lowestHP )
            {
                iter = itr;
                lowestHP = (*itr)->GetMaxHealth() - (*itr)->GetHealth();
            }
        return (*iter);
    }

    uint32 EnemiesInRange(float distance)
    {
        ThreatContainer::StorageType const& tList = me->getThreatManager().getThreatList();
        uint32 count = 0;
        Unit* target;
        for( ThreatContainer::StorageType::const_iterator iter = tList.begin(); iter != tList.end(); ++iter )
        {
            target = ObjectAccessor::GetUnit((*me), (*iter)->getUnitGuid());
            if( target && me->GetDistance2d(target) < distance )
                ++count;
        }
        return count;
    }

    Unit* SelectEnemyCaster(bool casting, float range)
    {
        ThreatContainer::StorageType const& tList = me->getThreatManager().getThreatList();
        Unit* target;
        for( ThreatContainer::StorageType::const_iterator iter = tList.begin(); iter != tList.end(); ++iter )
        {
            target = ObjectAccessor::GetUnit((*me), (*iter)->getUnitGuid());
            if( target && target->getPowerType() == POWER_MANA && (!casting || target->HasUnitState(UNIT_STATE_CASTING)) && me->GetExactDist(target) <= range )
                return target;
        }
        return nullptr;
    }

    void UpdateAI(uint32 diff)
    {
        if (!me->IsInCombat())
            return;

        if( threatTimer <= diff )
        {
            RecalculateThreat();
            threatTimer = urand(8750, 9250);
        }
        else
            threatTimer -= diff;

        if( me->getPowerType() == POWER_MANA )
        {
            if( powerTimer <= diff )
            {
                me->ModifyPower(POWER_MANA, me->GetMaxPower(POWER_MANA) / 3);
                powerTimer = 4000;
            }
            else
                powerTimer -= diff;
        }
        else if( me->getPowerType() == POWER_ENERGY )
        {
            if( powerTimer <= diff )
            {
                me->ModifyPower(POWER_ENERGY, me->GetMaxPower(POWER_ENERGY) / 3);
                powerTimer = 1000;
            }
            else
                powerTimer -= diff;
        }
    }
};

enum eDruidSpells
{
    SPELL_LIFEBLOOM      = 66093,
    SPELL_NOURISH          = 66066,
    SPELL_REGROWTH        = 66067,
    SPELL_REJUVENATION    = 66065,
    SPELL_THORNS            = 66068,
    SPELL_TRANQUILITY      = 66086,
    SPELL_BARKSKIN        = 65860,
    SPELL_NATURE_GRASP    = 66071,
};

enum eDruidEvents
{
    EVENT_SPELL_LIFEBLOOM = 1,
    EVENT_SPELL_NOURISH,
    EVENT_SPELL_REGROWTH,
    EVENT_SPELL_REJUVENATION,
    EVENT_SPELL_THORNS,
    EVENT_SPELL_TRANQUILITY,
    EVENT_SPELL_NATURE_GRASP,
    EVENT_SPELL_BARKSKIN = 101,
};

class npc_toc_druid : public CreatureScript
{
public:
    npc_toc_druid() : CreatureScript("npc_toc_druid") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_druidAI (pCreature);
    }

    struct npc_toc_druidAI : public boss_faction_championsAI
    {
        npc_toc_druidAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_HEALER)
        {
            SetEquipmentSlots(false, 51799, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_LIFEBLOOM, urand(5000, 15000));
            events.RescheduleEvent(EVENT_SPELL_NOURISH, urand(5000, 15000));
            events.RescheduleEvent(EVENT_SPELL_REGROWTH, urand(5000, 15000));
            events.RescheduleEvent(EVENT_SPELL_REJUVENATION, urand(5000, 15000));
            events.RescheduleEvent(EVENT_SPELL_TRANQUILITY, urand(25000, 40000));
            events.RescheduleEvent(EVENT_SPELL_BARKSKIN, 10000);
            events.RescheduleEvent(EVENT_SPELL_THORNS, urand(5000, 15000));
            events.RescheduleEvent(EVENT_SPELL_NATURE_GRASP, urand(5000, 15000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_LIFEBLOOM:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_LIFEBLOOM, 40.0f) )
                        me->CastSpell(target, SPELL_LIFEBLOOM, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_NOURISH:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_NOURISH, 40.0f) )
                        me->CastSpell(target, SPELL_NOURISH, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_REGROWTH:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_REGROWTH, 40.0f) )
                        me->CastSpell(target, SPELL_REGROWTH, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_REJUVENATION:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_REJUVENATION, 40.0f) )
                        me->CastSpell(target, SPELL_REJUVENATION, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_THORNS:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_THORNS, 30.0f) )
                        me->CastSpell(target, SPELL_THORNS, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_TRANQUILITY:
                    me->CastSpell(me, SPELL_TRANQUILITY, false);
                    events.RepeatEvent(urand(120000, 180000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_BARKSKIN:
                    if( HealthBelowPct(50) )
                    {
                        me->CastSpell(me, SPELL_BARKSKIN, false);
                        events.RepeatEvent(60000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_NATURE_GRASP:
                    me->CastSpell(me, SPELL_NATURE_GRASP, false);
                    events.RepeatEvent(60000);
                    EventMapGCD(events, 1500);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum eShamanSpells
{
    SPELL_HEALING_WAVE        = 66055,
    SPELL_RIPTIDE              = 66053,
    SPELL_SPIRIT_CLEANSE        = 66056,
    SPELL_HEROISM              = 65983,
    SPELL_BLOODLUST          = 65980,
    SPELL_HEX                  = 66054,
    SPELL_EARTH_SHIELD        = 66063,
    SPELL_EARTH_SHOCK          = 65973,
    AURA_EXHAUSTION          = 57723,
    AURA_SATED                = 57724,
};

enum eShamanEvents
{
    EVENT_SPELL_HEALING_WAVE = 1,
    EVENT_SPELL_RIPTIDE,
    EVENT_SPELL_SPIRIT_CLEANSE,
    EVENT_SPELL_HEROISM_OR_BLOODLUST,
    EVENT_SPELL_HEX,
    EVENT_SPELL_EARTH_SHIELD,
    EVENT_SPELL_EARTH_SHOCK,
};

class npc_toc_shaman : public CreatureScript
{
public:
    npc_toc_shaman() : CreatureScript("npc_toc_shaman") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_shamanAI (pCreature);
    }

    struct npc_toc_shamanAI : public boss_faction_championsAI
    {
        npc_toc_shamanAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_HEALER)
        {
            SetEquipmentSlots(false, 49992, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_HEALING_WAVE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_RIPTIDE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_SPIRIT_CLEANSE, urand(10000, 15000));
            events.RescheduleEvent(EVENT_SPELL_HEROISM_OR_BLOODLUST, urand(25000, 40000));
            events.RescheduleEvent(EVENT_SPELL_HEX, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_EARTH_SHIELD, urand(15000, 25000));
            events.RescheduleEvent(EVENT_SPELL_EARTH_SHOCK, urand(3000, 10000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_HEALING_WAVE:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_HEALING_WAVE, 40.0f) )
                        me->CastSpell(target, SPELL_HEALING_WAVE, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_RIPTIDE:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_RIPTIDE, 40.0f) )
                        me->CastSpell(target, SPELL_RIPTIDE, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_SPIRIT_CLEANSE:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_SPIRIT_CLEANSE, 40.0f) )
                        me->CastSpell(target, SPELL_SPIRIT_CLEANSE, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_HEROISM_OR_BLOODLUST:
                    if( me->GetEntry() == NPC_ALLIANCE_SHAMAN_RESTORATION )
                        me->CastSpell((Unit*)NULL, SPELL_HEROISM, true);
                    else
                        me->CastSpell((Unit*)NULL, SPELL_BLOODLUST, true);
                    events.RepeatEvent(600000);
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_HEX:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 20.0f, true) )
                        me->CastSpell(target, SPELL_HEX, false);
                    events.RepeatEvent(45000);
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_EARTH_SHIELD:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_EARTH_SHIELD, 40.0f) )
                        me->CastSpell(target, SPELL_EARTH_SHIELD, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_EARTH_SHOCK:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_EARTH_SHOCK, false);
                    events.RepeatEvent(urand(5000, 10000));
                    EventMapGCD(events, 1500);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum ePaladinSpells
{
    SPELL_HAND_OF_FREEDOM    = 68757,
    SPELL_BUBBLE              = 66010,
    SPELL_CLEANSE            = 66116,
    SPELL_FLASH_OF_LIGHT      = 66113,
    SPELL_HOLY_LIGHT          = 66112,
    SPELL_HOLY_SHOCK          = 66114,
    SPELL_HAND_OF_PROTECTION  = 66009,
    SPELL_HAMMER_OF_JUSTICE   = 66613,
};

enum ePaladinEvents
{
    EVENT_SPELL_HAND_OF_FREEDOM = 1,
    EVENT_SPELL_BUBBLE,
    EVENT_SPELL_CLEANSE,
    EVENT_SPELL_FLASH_OF_LIGHT,
    EVENT_SPELL_HOLY_LIGHT,
    EVENT_SPELL_HOLY_SHOCK,
    EVENT_SPELL_HAND_OF_PROTECTION,
    EVENT_SPELL_HAMMER_OF_JUSTICE,
};

class npc_toc_paladin : public CreatureScript
{
public:
    npc_toc_paladin() : CreatureScript("npc_toc_paladin") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_paladinAI (pCreature);
    }

    struct npc_toc_paladinAI : public boss_faction_championsAI
    {
        npc_toc_paladinAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_HEALER)
        {
            SetEquipmentSlots(false, 50771, 47079, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_HAND_OF_FREEDOM, urand(10000, 15000));
            events.RescheduleEvent(EVENT_SPELL_BUBBLE, 10000);
            events.RescheduleEvent(EVENT_SPELL_CLEANSE, urand(10000, 15000));
            events.RescheduleEvent(EVENT_SPELL_FLASH_OF_LIGHT, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_HOLY_LIGHT, urand(5000, 15000));
            events.RescheduleEvent(EVENT_SPELL_HOLY_SHOCK, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_HAND_OF_PROTECTION, urand(20000, 35000));
            events.RescheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, urand(10000, 20000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_HAND_OF_FREEDOM:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_HAND_OF_FREEDOM, 30.0f) )
                        me->CastSpell(target, SPELL_HAND_OF_FREEDOM, false);
                    events.RepeatEvent(25000);
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_BUBBLE:
                    if( HealthBelowPct(25) )
                    {
                        me->CastSpell(me, SPELL_BUBBLE, false);
                        events.RepeatEvent(300000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(10000);
                    break;
                case EVENT_SPELL_CLEANSE:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_CLEANSE, 40.0f) )
                        me->CastSpell(target, SPELL_CLEANSE, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_FLASH_OF_LIGHT:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_FLASH_OF_LIGHT, 40.0f) )
                        me->CastSpell(target, SPELL_FLASH_OF_LIGHT, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_HOLY_LIGHT:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_HOLY_LIGHT, 40.0f) )
                        me->CastSpell(target, SPELL_HOLY_LIGHT, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_HOLY_SHOCK:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_HOLY_SHOCK, 40.0f) )
                        me->CastSpell(target, SPELL_HOLY_SHOCK, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_HAND_OF_PROTECTION:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_HAND_OF_PROTECTION, 40.0f) )
                    {
                        me->CastSpell(target, SPELL_HAND_OF_PROTECTION, false);
                        events.RepeatEvent(300000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(10000);
                    break;
                case EVENT_SPELL_HAMMER_OF_JUSTICE:
                    if( Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 15.0f, true) )
                    {
                        me->CastSpell(target, SPELL_HAMMER_OF_JUSTICE, false);
                        events.RepeatEvent(40000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(10000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum ePriestSpells
{
    SPELL_RENEW          = 66177,
    SPELL_SHIELD            = 66099,
    SPELL_FLASH_HEAL        = 66104,
    SPELL_DISPEL            = 65546,
    SPELL_MANA_BURN      = 66100,
    SPELL_PSYCHIC_SCREAM    = 65543,
};

enum ePriestEvents
{
    EVENT_SPELL_RENEW = 1,
    EVENT_SPELL_SHIELD,
    EVENT_SPELL_FLASH_HEAL,
    EVENT_SPELL_MANA_BURN,
    EVENT_SPELL_DISPEL = 100,
    EVENT_SPELL_PSYCHIC_SCREAM = 101,
};

class npc_toc_priest : public CreatureScript
{
public:
    npc_toc_priest() : CreatureScript("npc_toc_priest") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_priestAI (pCreature);
    }

    struct npc_toc_priestAI : public boss_faction_championsAI
    {
        npc_toc_priestAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_HEALER)
        {
            SetEquipmentSlots(false, 49992, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_RENEW, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_SHIELD, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_FLASH_HEAL, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_DISPEL, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_MANA_BURN, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_PSYCHIC_SCREAM, 10000);
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_RENEW:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_RENEW, 40.0f) )
                        me->CastSpell(target, SPELL_RENEW, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_SHIELD:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_SHIELD, 40.0f) )
                        me->CastSpell(target, SPELL_SHIELD, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_FLASH_HEAL:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_FLASH_HEAL, 40.0f) )
                        me->CastSpell(target, SPELL_FLASH_HEAL, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_DISPEL:
                    if( Unit* target = (urand(0, 1) ? SelectTarget(SELECT_TARGET_TOPAGGRO, 0, 30.0f, true) : SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_DISPEL, 40.0f)) )
                        me->CastSpell(target, SPELL_DISPEL, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_MANA_BURN:
                    if( Unit* target = SelectEnemyCaster(false, 30.0f) )
                    {
                        me->CastSpell(target, SPELL_MANA_BURN, false);
                        events.RepeatEvent(urand(10000, 15000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_PSYCHIC_SCREAM:
                    if( HealthBelowPct(50) && EnemiesInRange(8.0f) >= 3 )
                    {
                        me->CastSpell((Unit*)NULL, SPELL_PSYCHIC_SCREAM, false);
                        events.RepeatEvent(30000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum eShadowPriestSpells
{
    SPELL_SILENCE          = 65542,
    SPELL_VAMPIRIC_TOUCH    = 65490,
    SPELL_SW_PAIN          = 65541,
    SPELL_MIND_FLAY      = 65488,
    SPELL_MIND_BLAST        = 65492,
    SPELL_HORROR            = 65545,
    SPELL_DISPERSION        = 65544,
    SPELL_SHADOWFORM        = 16592,
};

enum eShadowPriestEvents
{
    EVENT_SPELL_SILENCE = 1,
    EVENT_SPELL_VAMPIRIC_TOUCH,
    EVENT_SPELL_SW_PAIN,
    EVENT_SPELL_MIND_FLAY,
    EVENT_SPELL_MIND_BLAST,
    EVENT_SPELL_HORROR,
    EVENT_SPELL_DISPERSION,
};

class npc_toc_shadow_priest : public CreatureScript
{
public:
    npc_toc_shadow_priest() : CreatureScript("npc_toc_shadow_priest") {}

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_shadow_priestAI (pCreature);
    }

    struct npc_toc_shadow_priestAI : public boss_faction_championsAI
    {
        npc_toc_shadow_priestAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_RANGED)
        {
            SetEquipmentSlots(false, 50040, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_SILENCE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_VAMPIRIC_TOUCH, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_SW_PAIN, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_MIND_FLAY, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_MIND_BLAST, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_HORROR, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_DISPERSION, 10000);
            events.RescheduleEvent(EVENT_SPELL_DISPEL, urand(5000, 10000));
            events.RescheduleEvent(EVENT_SPELL_PSYCHIC_SCREAM, 10000);
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_SILENCE:
                    if( Unit* target = SelectEnemyCaster(false, 30.0f) )
                    {
                        me->CastSpell(target, SPELL_SILENCE, false);
                        events.RepeatEvent(45000);
                        EventMapGCD(events, 1500);
                        break;
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_VAMPIRIC_TOUCH:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_VAMPIRIC_TOUCH, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_SW_PAIN:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_SW_PAIN, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_MIND_FLAY:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_MIND_FLAY, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_MIND_BLAST:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_MIND_BLAST, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_HORROR:
                    if( me->GetVictim() && me->GetExactDist2d(me->GetVictim()) <= 30.0f )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_HORROR, false);
                        events.RepeatEvent(120000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(10000);
                    break;
                case EVENT_SPELL_DISPERSION:
                    if( HealthBelowPct(25) )
                    {
                        me->CastSpell(me, SPELL_DISPERSION, false);
                        events.RepeatEvent(180000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_DISPEL:
                    if( Unit* target = (urand(0, 1) ? SelectTarget(SELECT_TARGET_TOPAGGRO, 0, 30.0f, true) : SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_DISPEL, 40.0f)) )
                        me->CastSpell(target, SPELL_DISPEL, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_PSYCHIC_SCREAM:
                    if( EnemiesInRange(8.0f) >= 3 )
                    {
                        me->CastSpell((Unit*)NULL, SPELL_PSYCHIC_SCREAM, false);
                        events.RepeatEvent(30000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum eWarlockSpells
{
    SPELL_HELLFIRE            = 65816,
    SPELL_CORRUPTION            = 65810,
    SPELL_CURSE_OF_AGONY        = 65814,
    SPELL_CURSE_OF_EXHAUSTION   = 65815,
    SPELL_FEAR                = 65809,
    SPELL_SEARING_PAIN        = 65819,
    SPELL_SHADOW_BOLT          = 65821,
    SPELL_UNSTABLE_AFFLICTION   = 65812,
    SPELL_UNSTABLE_AFFLICTION_DISPEL = 65813,
    SPELL_SUMMON_FELHUNTER    = 67514,
};

enum eWarlockEvents
{
    EVENT_SPELL_HELLFIRE = 1,
    EVENT_SPELL_CORRUPTION,
    EVENT_SPELL_CURSE_OF_AGONY,
    EVENT_SPELL_CURSE_OF_EXHAUSTION,
    EVENT_SPELL_FEAR,
    EVENT_SPELL_SEARING_PAIN,
    EVENT_SPELL_SHADOW_BOLT,
    EVENT_SPELL_UNSTABLE_AFFLICTION,
    EVENT_SPELL_SUMMON_FELHUNTER,
};

class npc_toc_warlock : public CreatureScript
{
public:
    npc_toc_warlock() : CreatureScript("npc_toc_warlock") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_warlockAI (pCreature);
    }

    struct npc_toc_warlockAI : public boss_faction_championsAI
    {
        npc_toc_warlockAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_RANGED)
        {
            SetEquipmentSlots(false, 49992, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_HELLFIRE, 10000);
            events.RescheduleEvent(EVENT_SPELL_CORRUPTION, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_CURSE_OF_AGONY, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_CURSE_OF_EXHAUSTION, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_FEAR, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_SEARING_PAIN, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_SHADOW_BOLT, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_UNSTABLE_AFFLICTION, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_SUMMON_FELHUNTER, 0);
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) || IsCCed());
        }

        void JustSummoned(Creature* c)
        {
            if( Unit* target = c->SelectNearestTarget(200.0f) )
                c->AI()->AttackStart(target);
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_SUMMON_FELHUNTER:
                    DoSummon(35465, *me);
                    
                    break;
                case EVENT_SPELL_HELLFIRE:
                    if( EnemiesInRange(9.0f) >= 3 )
                    {
                        me->CastSpell((Unit*)NULL, SPELL_HELLFIRE, false);
                        events.RepeatEvent(30000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_CORRUPTION:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_CORRUPTION, false);
                    events.RepeatEvent(urand(10000, 20000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_CURSE_OF_AGONY:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_CURSE_OF_AGONY, false);
                    events.RepeatEvent(urand(10000, 20000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_CURSE_OF_EXHAUSTION:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_CURSE_OF_EXHAUSTION, false);
                    events.RepeatEvent(urand(10000, 20000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_FEAR:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 20.0f, true) )
                        me->CastSpell(target, SPELL_FEAR, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_SEARING_PAIN:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_SEARING_PAIN, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_SHADOW_BOLT:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_SHADOW_BOLT, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_UNSTABLE_AFFLICTION:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_UNSTABLE_AFFLICTION, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum eMageSpells
{
    SPELL_ARCANE_BARRAGE    = 65799,
    SPELL_ARCANE_BLAST    = 65791,
    SPELL_ARCANE_EXPLOSION  = 65800,
    SPELL_BLINK          = 65793,
    SPELL_COUNTERSPELL    = 65790,
    SPELL_FROST_NOVA        = 65792,
    SPELL_FROSTBOLT      = 65807,
    SPELL_ICE_BLOCK      = 65802,
    SPELL_POLYMORPH      = 65801,
};

enum eMageEvents
{
    EVENT_SPELL_ARCANE_BARRAGE = 1,
    EVENT_SPELL_ARCANE_BLAST,
    EVENT_SPELL_ARCANE_EXPLOSION,
    EVENT_SPELL_BLINK,
    EVENT_SPELL_BLINK_2,
    EVENT_SPELL_COUNTERSPELL,
    EVENT_SPELL_FROSTBOLT,
    EVENT_SPELL_ICE_BLOCK,
    EVENT_SPELL_POLYMORPH,
};

class npc_toc_mage : public CreatureScript
{
public:
    npc_toc_mage() : CreatureScript("npc_toc_mage") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_mageAI (pCreature);
    }

    struct npc_toc_mageAI : public boss_faction_championsAI
    {
        npc_toc_mageAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_RANGED)
        {
            SetEquipmentSlots(false, 47524, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_ARCANE_BARRAGE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_ARCANE_BLAST, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_ARCANE_EXPLOSION, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_BLINK, 10000);
            events.RescheduleEvent(EVENT_SPELL_COUNTERSPELL, urand(10000, 20000));
            events.RescheduleEvent(EVENT_SPELL_FROSTBOLT, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_ICE_BLOCK, 10000);
            events.RescheduleEvent(EVENT_SPELL_POLYMORPH, urand(5000, 10000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_ARCANE_BARRAGE:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_ARCANE_BARRAGE, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_ARCANE_BLAST:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_ARCANE_BLAST, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_ARCANE_EXPLOSION:
                    if( EnemiesInRange(9.0f) >= 3 )
                    {
                        me->CastSpell((Unit*)NULL, SPELL_ARCANE_EXPLOSION, false);
                        events.RepeatEvent(6000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_BLINK:
                    if( HealthBelowPct(50) && EnemiesInRange(10.0f) >= 3 )
                    {
                        me->CastSpell((Unit*)NULL, SPELL_FROST_NOVA, false);
                        events.RepeatEvent(15000);
                        EventMapGCD(events, 1500);
                        // blink disabled, fucking movement shit not working
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_COUNTERSPELL:
                    if( Unit* target = SelectEnemyCaster(true, 30.0f) )
                    {
                        me->CastSpell(target, SPELL_COUNTERSPELL, false);
                        events.RepeatEvent(24000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_FROSTBOLT:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_FROSTBOLT, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_ICE_BLOCK:
                    if( HealthBelowPct(25) )
                    {
                        me->CastSpell(me, SPELL_ICE_BLOCK, false);
                        events.RepeatEvent(300000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_POLYMORPH:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true) )
                        me->CastSpell(target, SPELL_POLYMORPH, false);
                    events.RepeatEvent(15000);
                    EventMapGCD(events, 1500);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum eHunterSpells
{
    SPELL_AIMED_SHOT        = 65883,
    SPELL_DETERRENCE        = 65871,
    SPELL_DISENGAGE      = 65870,
    SPELL_EXPLOSIVE_SHOT    = 65866,
    SPELL_FROST_TRAP        = 65880,
    SPELL_SHOOT          = 65868,
    SPELL_STEADY_SHOT      = 65867,
    SPELL_WING_CLIP      = 66207,
    SPELL_WYVERN_STING    = 65877,
    SPELL_CALL_PET        = 67777,
};

enum eHunterEvents
{
    EVENT_SPELL_AIMED_SHOT = 1,
    EVENT_SPELL_DETERRENCE,
    EVENT_SPELL_DISENGAGE,
    EVENT_SPELL_EXPLOSIVE_SHOT,
    EVENT_SPELL_FROST_TRAP,
    EVENT_SPELL_STEADY_SHOT,
    EVENT_SPELL_WING_CLIP,
    EVENT_SPELL_WYVERN_STING,
    EVENT_SPELL_CALL_PET,
};

class npc_toc_hunter : public CreatureScript
{
public:
    npc_toc_hunter() : CreatureScript("npc_toc_hunter") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_hunterAI (pCreature);
    }

    struct npc_toc_hunterAI : public boss_faction_championsAI
    {
        npc_toc_hunterAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_RANGED)
        {
            SetEquipmentSlots(false, 47156, EQUIP_NO_CHANGE, 48711);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_AIMED_SHOT, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_DETERRENCE, 10000);
            //events.RescheduleEvent(EVENT_SPELL_DISENGAGE, 10000);
            events.RescheduleEvent(EVENT_SPELL_EXPLOSIVE_SHOT, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_FROST_TRAP, urand(15000, 20000));
            events.RescheduleEvent(EVENT_SPELL_STEADY_SHOT, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_WING_CLIP, 10000);
            events.RescheduleEvent(EVENT_SPELL_WYVERN_STING, urand(5000, 15000));
            events.RescheduleEvent(EVENT_SPELL_CALL_PET, 0);
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || me->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_DISARM_RANGED) || IsCCed());
        }

        void JustSummoned(Creature* c)
        {
            if( Unit* target = c->SelectNearestTarget(200.0f) )
                c->AI()->AttackStart(target);
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_CALL_PET:
                    DoSummon(35610, *me);
                    
                    break;
                case EVENT_SPELL_AIMED_SHOT:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_AIMED_SHOT, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_DETERRENCE:
                    if( HealthBelowPct(25) )
                    {
                        me->CastSpell(me, SPELL_DETERRENCE, false);
                        events.RepeatEvent(90000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_DISENGAGE:
                    if( EnemiesInRange(10.0f) >= 3 )
                    {
                        me->CastSpell(me, SPELL_DISENGAGE, false);
                        events.RepeatEvent(20000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_EXPLOSIVE_SHOT:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_EXPLOSIVE_SHOT, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_FROST_TRAP:
                    me->CastSpell(me, SPELL_FROST_TRAP, false);
                    events.RepeatEvent(30000);
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_STEADY_SHOT:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_STEADY_SHOT, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_WING_CLIP:
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) <= 5.0f )
                        me->CastSpell(me->GetVictim(), SPELL_WING_CLIP, false);
                    events.RepeatEvent(8000);
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_WYVERN_STING:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 35.0f, true) )
                    {
                        me->CastSpell(target, SPELL_WYVERN_STING, false);
                        events.RepeatEvent(60000);
                        EventMapGCD(events, 1500);
                        break;
                    }
                    events.RepeatEvent(10000);
                    break;
            }

            if( me->isAttackReady() && !me->HasUnitState(UNIT_STATE_CASTING) )
            {
                me->CastSpell(me->GetVictim(), SPELL_SHOOT, true);
                me->resetAttackTimer();
            }
        }
    };
};

enum eBoomkinSpells
{
    SPELL_WRATH          = 65862,
    SPELL_MOONFIRE        = 65856,
    SPELL_STARFIRE        = 65854,
    SPELL_INSECT_SWARM    = 65855,
    SPELL_ENTANGLING_ROOTS  = 65857,
    SPELL_FAERIE_FIRE      = 65863,
    SPELL_CYCLONE          = 65859,
    SPELL_FORCE_OF_NATURE   = 65861,
};

enum eBoomkinEvents
{
    EVENT_SPELL_WRATH = 1,
    EVENT_SPELL_MOONFIRE,
    EVENT_SPELL_STARFIRE,
    EVENT_SPELL_INSECT_SWARM,
    EVENT_SPELL_ENTANGLING_ROOTS,
    EVENT_SPELL_FAERIE_FIRE,
    EVENT_SPELL_CYCLONE,
    EVENT_SPELL_FORCE_OF_NATURE,
};

class npc_toc_boomkin : public CreatureScript
{
public:
    npc_toc_boomkin() : CreatureScript("npc_toc_boomkin") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_boomkinAI (pCreature);
    }

    struct npc_toc_boomkinAI : public boss_faction_championsAI
    {
        npc_toc_boomkinAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_RANGED)
        {
            SetEquipmentSlots(false, 50966, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_BARKSKIN, 10000);
            events.RescheduleEvent(EVENT_SPELL_WRATH, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_MOONFIRE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_STARFIRE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_INSECT_SWARM, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_ENTANGLING_ROOTS, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_FAERIE_FIRE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_CYCLONE, urand(10000, 15000));
            events.RescheduleEvent(EVENT_SPELL_FORCE_OF_NATURE, urand(20000, 40000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) || IsCCed());
        }

        void JustSummoned(Creature* c)
        {
            if( Unit* target = c->SelectNearestTarget(200.0f) )
                c->AI()->AttackStart(target);
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_BARKSKIN:
                    if( HealthBelowPct(50) )
                    {
                        me->CastSpell(me, SPELL_BARKSKIN, false);
                        events.RepeatEvent(60000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_WRATH:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_WRATH, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_MOONFIRE:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_MOONFIRE, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_STARFIRE:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_STARFIRE, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_INSECT_SWARM:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_INSECT_SWARM, false);
                    events.RepeatEvent(urand(5000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_ENTANGLING_ROOTS:
                    if( Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 30.0f, true) )
                        me->CastSpell(target, SPELL_ENTANGLING_ROOTS, false);
                    events.RepeatEvent(urand(10000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_FAERIE_FIRE:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_FAERIE_FIRE, false);
                    events.RepeatEvent(urand(15000, 20000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_CYCLONE:
                    if( Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 20.0f, true) )
                        me->CastSpell(target, SPELL_CYCLONE, false);
                    events.RepeatEvent(urand(25000, 40000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_FORCE_OF_NATURE:
                    me->CastSpell((Unit*)NULL, SPELL_FORCE_OF_NATURE, false);
                    events.RepeatEvent(180000);
                    EventMapGCD(events, 1500);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum eWarriorSpells
{
    SPELL_BLADESTORM            = 65947,
    SPELL_INTIMIDATING_SHOUT    = 65930,
    SPELL_MORTAL_STRIKE      = 65926,
    SPELL_CHARGE                = 68764,
    SPELL_DISARM                = 65935,
    SPELL_OVERPOWER          = 65924,
    SPELL_SUNDER_ARMOR        = 65936,
    SPELL_SHATTERING_THROW    = 65940,
    SPELL_RETALIATION          = 65932,
};

enum eWarriorEvents
{
    EVENT_SPELL_BLADESTORM = 1,
    EVENT_SPELL_INTIMIDATING_SHOUT,
    EVENT_SPELL_MORTAL_STRIKE,
    EVENT_SPELL_CHARGE,
    EVENT_SPELL_DISARM,
    EVENT_SPELL_OVERPOWER,
    EVENT_SPELL_SUNDER_ARMOR,
    EVENT_SPELL_SHATTERING_THROW,
    EVENT_SPELL_RETALIATION,
};

class npc_toc_warrior : public CreatureScript
{
public:
    npc_toc_warrior() : CreatureScript("npc_toc_warrior") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_warriorAI (pCreature);
    }

    struct npc_toc_warriorAI : public boss_faction_championsAI
    {
        npc_toc_warriorAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_MELEE)
        {
            SetEquipmentSlots(false, 47427, 46964, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_BLADESTORM, 20000);
            events.RescheduleEvent(EVENT_SPELL_INTIMIDATING_SHOUT, 14000);
            events.RescheduleEvent(EVENT_SPELL_MORTAL_STRIKE, urand(5000, 10000));
            events.RescheduleEvent(EVENT_SPELL_CHARGE, 3000);
            events.RescheduleEvent(EVENT_SPELL_DISARM, urand(15000, 25000));
            events.RescheduleEvent(EVENT_SPELL_OVERPOWER, urand(5000, 10000));
            events.RescheduleEvent(EVENT_SPELL_SUNDER_ARMOR, urand(5000, 10000));
            events.RescheduleEvent(EVENT_SPELL_SHATTERING_THROW, urand(25000, 40000));
            events.RescheduleEvent(EVENT_SPELL_RETALIATION, urand(25000, 40000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_BLADESTORM:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( EnemiesInRange(8.0f) >= 3 )
                    {
                        me->CastSpell(me, SPELL_BLADESTORM, false);
                        events.RepeatEvent(90000);
                        events.DelayEvents(9000);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_INTIMIDATING_SHOUT:
                    if( EnemiesInRange(8.0f) >= 3 )
                    {
                        me->CastSpell((Unit*)NULL, SPELL_INTIMIDATING_SHOUT, false);
                        events.RepeatEvent(120000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_MORTAL_STRIKE:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
                    events.RepeatEvent(urand(6000, 8000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_CHARGE:
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) > 8.0f && me->GetDistance2d(me->GetVictim()) < 25.0f )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_CHARGE, false);
                        events.RepeatEvent(10000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_DISARM:
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) < 5.0f  )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_DISARM, false);
                        events.RepeatEvent(60000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_OVERPOWER:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) < 5.0f  )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_OVERPOWER, false);
                        events.RepeatEvent(urand(10000, 15000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_SUNDER_ARMOR:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) < 5.0f  )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_SUNDER_ARMOR, false);
                        events.RepeatEvent(urand(10000, 15000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_SHATTERING_THROW:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) < 25.0f  )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_SHATTERING_THROW, false);
                        events.RepeatEvent(300000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_RETALIATION:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( EnemiesInRange(8.0f) >= 3 )
                    {
                        me->CastSpell(me, SPELL_RETALIATION, false);
                        events.RepeatEvent(300000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum eDeathKnightSpells
{
    SPELL_CHAINS_OF_ICE    = 66020,
    SPELL_DEATH_COIL          = 66019,
    SPELL_DEATH_GRIP          = 66017,
    SPELL_FROST_STRIKE      = 66047,
    SPELL_ICEBOUND_FORTITUDE  = 66023,
    SPELL_ICY_TOUCH        = 66021,
    SPELL_STRANGULATE        = 66018,
};

enum eDeathKnightEvents
{
    EVENT_SPELL_CHAINS_OF_ICE = 1,
    EVENT_SPELL_DEATH_COIL,
    EVENT_SPELL_DEATH_GRIP,
    EVENT_SPELL_FROST_STRIKE,
    EVENT_SPELL_ICEBOUND_FORTITUDE,
    EVENT_SPELL_ICY_TOUCH,
    EVENT_SPELL_STRANGULATE,
};

class npc_toc_dk : public CreatureScript
{
public:
    npc_toc_dk() : CreatureScript("npc_toc_dk") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_dkAI (pCreature);
    }

    struct npc_toc_dkAI : public boss_faction_championsAI
    {
        npc_toc_dkAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_MELEE)
        {
            SetEquipmentSlots(false, 47518, 51021, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_CHAINS_OF_ICE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_DEATH_COIL, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_DEATH_GRIP, 0);
            events.RescheduleEvent(EVENT_SPELL_FROST_STRIKE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_ICEBOUND_FORTITUDE, 10000);
            events.RescheduleEvent(EVENT_SPELL_ICY_TOUCH, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_STRANGULATE, urand(20000, 30000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_CHAINS_OF_ICE:
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) <= 25.0f )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_CHAINS_OF_ICE, false);
                        events.RepeatEvent(urand(10000, 15000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_DEATH_COIL:
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) <= 30.0f )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_DEATH_COIL, false);
                        events.RepeatEvent(urand(5000, 8000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_DEATH_GRIP:
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) <= 30.0f && me->GetDistance2d(me->GetVictim()) >= 12.0f )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_DEATH_GRIP, false);
                        Position pos;
                        float x, y, z;
                        me->GetClosePoint(x, y, z, 3.0f);
                        pos.Relocate(x, y, z);
                        me->GetVictim()->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), 49575, true);
                        events.RepeatEvent(35000);
                        EventMapGCD(events, 2000);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_FROST_STRIKE:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) < 5.0f  )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_FROST_STRIKE, false);
                        events.RepeatEvent(urand(6000, 10000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_ICEBOUND_FORTITUDE:
                    if( HealthBelowPct(50) )
                    {
                        me->CastSpell(me, SPELL_ICEBOUND_FORTITUDE, false);
                        events.RepeatEvent(60000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_ICY_TOUCH:
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) < 20.0f  )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_ICY_TOUCH, false);
                        events.RepeatEvent(urand(10000, 15000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_STRANGULATE:
                    if(SelectEnemyCaster(false, 30.0f))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_STRANGULATE, false);
                        events.RepeatEvent(120000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum eRogueSpells
{
    SPELL_FAN_OF_KNIVES      = 65955,
    SPELL_BLIND              = 65960,
    SPELL_CLOAK              = 65961,
    SPELL_BLADE_FLURRY        = 65956,
    SPELL_SHADOWSTEP            = 66178,
    SPELL_HEMORRHAGE            = 65954,
    SPELL_EVISCERATE            = 65957,
};

enum eRogueEvents
{
    EVENT_SPELL_FAN_OF_KNIVES = 1,
    EVENT_SPELL_BLIND,
    EVENT_SPELL_CLOAK,
    EVENT_SPELL_BLADE_FLURRY,
    EVENT_SPELL_SHADOWSTEP,
    EVENT_SPELL_HEMORRHAGE,
    EVENT_SPELL_EVISCERATE,
};

class npc_toc_rogue : public CreatureScript
{
public:
    npc_toc_rogue() : CreatureScript("npc_toc_rogue") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_rogueAI (pCreature);
    }

    struct npc_toc_rogueAI : public boss_faction_championsAI
    {
        npc_toc_rogueAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_MELEE)
        {
            SetEquipmentSlots(false, 47422, 49982, EQUIP_NO_CHANGE);
            me->setPowerType(POWER_ENERGY);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_FAN_OF_KNIVES, 10000);
            events.RescheduleEvent(EVENT_SPELL_BLIND, urand(10000, 15000));
            events.RescheduleEvent(EVENT_SPELL_CLOAK, 10000);
            events.RescheduleEvent(EVENT_SPELL_BLADE_FLURRY, urand(20000, 40000));
            //events.RescheduleEvent(EVENT_SPELL_SHADOWSTEP, urand(15000,25000));
            events.RescheduleEvent(EVENT_SPELL_HEMORRHAGE, urand(3000, 5000));
            events.RescheduleEvent(EVENT_SPELL_EVISCERATE, urand(20000, 25000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_FAN_OF_KNIVES:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( EnemiesInRange(10.0f) >= 3 )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_FAN_OF_KNIVES, false);
                        events.RepeatEvent(urand(6000, 10000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_BLIND:
                    if( Unit* target = SelectTarget(SELECT_TARGET_BOTTOMAGGRO, 0, 20.0f, true) )
                    {
                        me->CastSpell(target, SPELL_BLIND, false);
                        events.RepeatEvent(120000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_CLOAK:
                    if( HealthBelowPct(50) )
                    {
                        me->CastSpell(me, SPELL_CLOAK, false);
                        events.RepeatEvent(90000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(6000);
                    break;
                case EVENT_SPELL_BLADE_FLURRY:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                        events.RepeatEvent(5000);
                    else
                    {
                        me->CastSpell(me, SPELL_BLADE_FLURRY, false);
                        events.RepeatEvent(120000);
                        EventMapGCD(events, 1500);
                    }
                    break;
                case EVENT_SPELL_SHADOWSTEP:
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) < 40.0f && me->GetDistance2d(me->GetVictim()) > 10.0f )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_SHADOWSTEP, false);
                        events.RepeatEvent(30000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_HEMORRHAGE:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) <= 5.0f )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_HEMORRHAGE, false);
                        events.RepeatEvent(5000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_EVISCERATE:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( me->GetVictim() && me->GetDistance2d(me->GetVictim()) <= 5.0f )
                    {
                        me->CastSpell(me->GetVictim(), SPELL_EVISCERATE, false);
                        events.RepeatEvent(urand(15000, 25000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

};

enum eEnhShamanSpells
{
    SPELL_EARTH_SHOCK_ENH   = 65973,
    SPELL_LAVA_LASH      = 65974,
    SPELL_STORMSTRIKE      = 65970,
    SPELL_GROUNDING_TOTEM   = 65989,
    SPELL_WINDFURY_TOTEM    = 65990,
    SPELL_TREMOR_TOTEM      = 65992,
};

enum eEnhShamanEvents
{
    EVENT_SPELL_EARTH_SHOCK_ENH = 201,
    EVENT_SPELL_LAVA_LASH,
    EVENT_SPELL_STORMSTRIKE,
    EVENT_SUMMON_TOTEM,
};

class npc_toc_enh_shaman : public CreatureScript
{
public:
    npc_toc_enh_shaman() : CreatureScript("npc_toc_enh_shaman") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_enh_shamanAI (pCreature);
    }

    struct npc_toc_enh_shamanAI : public boss_faction_championsAI
    {
        npc_toc_enh_shamanAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_MELEE)
        {
            SetEquipmentSlots(false, 51803, 48013, EQUIP_NO_CHANGE);
            me->SetModifierValue(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_PCT, 1.0f);
            me->UpdateDamagePhysical(OFF_ATTACK);

            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_HEROISM_OR_BLOODLUST, urand(25000, 40000));
            events.RescheduleEvent(EVENT_SPELL_EARTH_SHOCK_ENH, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_LAVA_LASH, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_STORMSTRIKE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SUMMON_TOTEM, urand(10000, 20000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_EARTH_SHOCK_ENH:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 0, 25.0f, true) )
                    {
                        me->CastSpell(target, SPELL_EARTH_SHOCK_ENH, false);
                        events.RepeatEvent(urand(6000, 8000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_LAVA_LASH:
                    if( me->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_DISARM_OFFHAND) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 0, 5.0f, true) )
                    {
                        me->CastSpell(target, SPELL_LAVA_LASH, false);
                        events.RepeatEvent(urand(6000, 8000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_STORMSTRIKE:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) && me->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_DISARM_OFFHAND) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 0, 5.0f, true) )
                    {
                        me->CastSpell(target, SPELL_STORMSTRIKE, false);
                        events.RepeatEvent(urand(8000, 9000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_HEROISM_OR_BLOODLUST:
                    if( me->GetEntry() == NPC_ALLIANCE_SHAMAN_RESTORATION )
                        me->CastSpell((Unit*)NULL, SPELL_HEROISM, true);
                    else
                        me->CastSpell((Unit*)NULL, SPELL_BLOODLUST, true);
                    events.RepeatEvent(600000);
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SUMMON_TOTEM:
                    me->CastSpell((Unit*)NULL, RAND(SPELL_GROUNDING_TOTEM, SPELL_WINDFURY_TOTEM, SPELL_TREMOR_TOTEM), false);
                    events.RepeatEvent(30000);
                    EventMapGCD(events, 1500);
                    break;

            }

            DoMeleeAttackIfReady();
        }
    };
};

enum eRetroPaladinSpells
{
    SPELL_AVENGING_WRATH        = 66011,
    SPELL_CRUSADER_STRIKE      = 66003,
    SPELL_DIVINE_SHIELD      = 66010,
    SPELL_DIVINE_STORM        = 66006,
    SPELL_HAMMER_OF_JUSTICE_RET = 66007,
    SPELL_HAND_OF_PROTECTION_RET = 66009,
    SPELL_JUDGEMENT_OF_COMMAND  = 66005,
    SPELL_REPENTANCE            = 66008,
    SPELL_SEAL_OF_COMMAND      = 66004,
};

enum eRetroPaladinEvents
{
    EVENT_SPELL_AVENGING_WRATH = 1,
    EVENT_SPELL_CRUSADER_STRIKE,
    EVENT_SPELL_DIVINE_SHIELD,
    EVENT_SPELL_DIVINE_STORM,
    EVENT_SPELL_HAMMER_OF_JUSTICE_RET,
    EVENT_SPELL_HAND_OF_PROTECTION_RET,
    EVENT_SPELL_JUDGEMENT_OF_COMMAND,
    EVENT_SPELL_REPENTANCE,
};

class npc_toc_retro_paladin : public CreatureScript
{
public:
    npc_toc_retro_paladin() : CreatureScript("npc_toc_retro_paladin") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_retro_paladinAI (pCreature);
    }

    struct npc_toc_retro_paladinAI : public boss_faction_championsAI
    {
        npc_toc_retro_paladinAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_MELEE)
        {
            SetEquipmentSlots(false, 47519, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_AVENGING_WRATH, urand(20000, 30000));
            events.RescheduleEvent(EVENT_SPELL_CRUSADER_STRIKE, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_DIVINE_SHIELD, 10000);
            events.RescheduleEvent(EVENT_SPELL_DIVINE_STORM, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE_RET, urand(15000, 25000));
            events.RescheduleEvent(EVENT_SPELL_HAND_OF_PROTECTION_RET, urand(25000, 40000));
            events.RescheduleEvent(EVENT_SPELL_JUDGEMENT_OF_COMMAND, urand(3000, 10000));
            events.RescheduleEvent(EVENT_SPELL_REPENTANCE, urand(10000, 15000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasUnitState(UNIT_STATE_CASTING) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_AVENGING_WRATH:
                    me->CastSpell(me, SPELL_AVENGING_WRATH, false);
                    events.RepeatEvent(180000);
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_CRUSADER_STRIKE:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 0, 5.0f, true) )
                    {
                        me->CastSpell(target, SPELL_CRUSADER_STRIKE, false);
                        events.RepeatEvent(urand(6000, 8000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_DIVINE_SHIELD:
                    if( HealthBelowPct(25) )
                    {
                        me->CastSpell(me, SPELL_DIVINE_SHIELD, false);
                        events.RepeatEvent(300000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_DIVINE_STORM:
                    if( me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISARMED) )
                    {
                        events.RepeatEvent(5000);
                        break;
                    }
                    if( EnemiesInRange(5.0f) >= 3 )
                    {
                        me->CastSpell((Unit*)NULL, SPELL_DIVINE_STORM, false);
                        events.RepeatEvent(urand(10000, 15000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_HAMMER_OF_JUSTICE_RET:
                    if( Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 0, 15.0f, true) )
                    {
                        me->CastSpell(target, SPELL_HAMMER_OF_JUSTICE_RET, false);
                        events.RepeatEvent(40000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_HAND_OF_PROTECTION_RET:
                    if( Creature* target = SelectTarget_MostHPLostFriendlyMissingBuff(SPELL_HAND_OF_PROTECTION_RET, 30.0f) )
                    {
                        me->CastSpell(target, SPELL_HAND_OF_PROTECTION_RET, false);
                        events.RepeatEvent(300000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_JUDGEMENT_OF_COMMAND:
                    if( Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 0, 20.0f, true) )
                    {
                        me->CastSpell(target, SPELL_JUDGEMENT_OF_COMMAND, false);
                        events.RepeatEvent(urand(10000, 15000));
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
                case EVENT_SPELL_REPENTANCE:
                    if( Unit* target = SelectTarget(SELECT_TARGET_BOTTOMAGGRO, 0, 20.0f, true) )
                    {
                        me->CastSpell(target, SPELL_REPENTANCE, false);
                        events.RepeatEvent(60000);
                        EventMapGCD(events, 1500);
                    }
                    else
                        events.RepeatEvent(5000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

enum eWarlockPetSpells
{
    SPELL_DEVOUR_MAGIC  = 67518,
    SPELL_SPELL_LOCK  = 67519,
};

enum eWarlockPetEvents
{
    EVENT_SPELL_DEVOUR_MAGIC = 1,
    EVENT_SPELL_SPELL_LOCK,
};

class npc_toc_pet_warlock : public CreatureScript
{
public:
    npc_toc_pet_warlock() : CreatureScript("npc_toc_pet_warlock") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_pet_warlockAI (pCreature);
    }

    struct npc_toc_pet_warlockAI : public boss_faction_championsAI
    {
        npc_toc_pet_warlockAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_PET)
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_DEVOUR_MAGIC, urand(5000, 15000));
            events.RescheduleEvent(EVENT_SPELL_SPELL_LOCK, urand(5000, 15000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !(me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED) || IsCCed());
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_DEVOUR_MAGIC:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_DEVOUR_MAGIC, false);
                    events.RepeatEvent(urand(8000, 15000));
                    EventMapGCD(events, 1500);
                    break;
                case EVENT_SPELL_SPELL_LOCK:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_SPELL_LOCK, false);
                    events.RepeatEvent(24000);
                    EventMapGCD(events, 1500);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void EnterEvadeMode()
        {
            me->DespawnOrUnsummon();
        }
    };

};

enum eHunterPetSpells
{
    SPELL_CLAW  = 67793,
};

enum eHunterPetEvents
{
    EVENT_SPELL_CLAW = 1,
};

class npc_toc_pet_hunter : public CreatureScript
{
public:
    npc_toc_pet_hunter() : CreatureScript("npc_toc_pet_hunter") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_toc_pet_hunterAI (pCreature);
    }

    struct npc_toc_pet_hunterAI : public boss_faction_championsAI
    {
        npc_toc_pet_hunterAI(Creature* pCreature) : boss_faction_championsAI(pCreature, AI_PET)
        {
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_CLAW, urand(5000, 15000));
        }

        EventMap events;

        bool myCanCast()
        {
            return !IsCCed();
        }

        void UpdateAI(uint32 diff)
        {
            boss_faction_championsAI::UpdateAI(diff);
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( !myCanCast() )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_CLAW:
                    if( me->GetVictim() )
                        me->CastSpell(me->GetVictim(), SPELL_CLAW, false);
                    events.RepeatEvent(urand(8000, 15000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void EnterEvadeMode()
        {
            me->DespawnOrUnsummon();
        }
    };
};

class go_toc_champions_cache : public GameObjectScript
{
public:
    go_toc_champions_cache() : GameObjectScript("go_toc_champions_cache") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (player->IsGameMaster())
            return false;

        if (!go->loot.items.size())
            return false;

        for(std::vector<LootItem>::iterator itr = go->loot.items.begin(); itr != go->loot.items.end(); ++itr)
            if( ItemTemplate const* iProto = sObjectMgr->GetItemTemplate((*itr).itemid) )
                if( ((iProto->Flags2 & ITEM_FLAGS_EXTRA_HORDE_ONLY) && player->GetTeamId() != TEAM_HORDE) || ((iProto->Flags2 & ITEM_FLAGS_EXTRA_ALLIANCE_ONLY) && player->GetTeamId() != TEAM_ALLIANCE) )
                    if (!((*itr).is_looted))
                    {
                        (*itr).count = 0;
                        (*itr).is_looted = true;
                        if (go->loot.unlootedCount)
                            --go->loot.unlootedCount;
                    }

        return false;
    }
};

class spell_faction_champion_warl_unstable_affliction : public SpellScriptLoader
{
public:
    spell_faction_champion_warl_unstable_affliction() : SpellScriptLoader("spell_faction_champion_warl_unstable_affliction") { }

    class spell_faction_champion_warl_unstable_affliction_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_faction_champion_warl_unstable_affliction_AuraScript);

        bool Validate(SpellInfo const* /*spell*/)
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_UNSTABLE_AFFLICTION_DISPEL))
                return false;
            return true;
        }

        void HandleDispel(DispelInfo* dispelInfo)
        {
            if (Unit* caster = GetCaster())
                caster->CastSpell(dispelInfo->GetDispeller(), SPELL_UNSTABLE_AFFLICTION_DISPEL, true, NULL, GetEffect(EFFECT_0));
        }

        void Register()
        {
            AfterDispel += AuraDispelFn(spell_faction_champion_warl_unstable_affliction_AuraScript::HandleDispel);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_faction_champion_warl_unstable_affliction_AuraScript();
    }
};

void AddSC_boss_faction_champions()
{
    new npc_toc_druid();
    new npc_toc_shaman();
    new npc_toc_paladin();
    new npc_toc_priest();
    new npc_toc_shadow_priest();
    new npc_toc_mage();
    new npc_toc_warlock();
    new npc_toc_hunter();
    new npc_toc_boomkin();
    new npc_toc_warrior();
    new npc_toc_dk();
    new npc_toc_rogue();
    new npc_toc_enh_shaman();
    new npc_toc_retro_paladin();
    new npc_toc_pet_warlock();
    new npc_toc_pet_hunter();
    new go_toc_champions_cache();
    new spell_faction_champion_warl_unstable_affliction();
}
