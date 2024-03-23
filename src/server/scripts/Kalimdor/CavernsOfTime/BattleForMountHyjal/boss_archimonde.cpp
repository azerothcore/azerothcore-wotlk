/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "hyjal.h"

enum Texts
{
    SAY_AGGRO       = 1,
    SAY_DOOMFIRE    = 2,
    SAY_AIR_BURST   = 3,
    SAY_SLAY        = 4,
    SAY_ENRAGE      = 5,
    SAY_DEATH       = 6,
    SAY_SOUL_CHARGE = 7,
};

enum ArchiSpells
{
    SPELL_DENOUEMENT_WISP       = 32124,
    SPELL_ANCIENT_SPARK         = 39349,
    SPELL_PROTECTION_OF_ELUNE   = 38528,

    SPELL_DRAIN_WORLD_TREE      = 39140,
    SPELL_DRAIN_WORLD_TREE_2    = 39141,

    SPELL_FINGER_OF_DEATH       = 31984,
    SPELL_RED_SKY_EFFECT        = 32111,
    SPELL_HAND_OF_DEATH         = 35354,
    SPELL_AIR_BURST             = 32014,
    SPELL_GRIP_OF_THE_LEGION    = 31972,
    SPELL_DOOMFIRE_STRIKE       = 31903,    //summons two creatures
    SPELL_DOOMFIRE_SPAWN        = 32074,
    SPELL_DOOMFIRE              = 31945,
    SPELL_SOUL_CHARGE_YELLOW    = 32045,
    SPELL_SOUL_CHARGE_GREEN     = 32051,
    SPELL_SOUL_CHARGE_RED       = 32052,
    SPELL_UNLEASH_SOUL_YELLOW   = 32054,
    SPELL_UNLEASH_SOUL_GREEN    = 32057,
    SPELL_UNLEASH_SOUL_RED      = 32053,
    SPELL_FEAR                  = 31970,
};

enum Summons
{
    CREATURE_DOOMFIRE           = 18095,
    CREATURE_DOOMFIRE_SPIRIT    = 18104,
    CREATURE_ANCIENT_WISP       = 17946,
    CREATURE_CHANNEL_TARGET     = 22418,
};

enum Events
{
    EVENT_DRAIN_WORLD_TREE              = 1,
    EVENT_SPELL_FEAR                    = 2,
    EVENT_SPELL_AIR_BURST               = 3,
    EVENT_SPELL_GRIP_OF_THE_LEGION      = 4,
    EVENT_SPELL_UNLEASH_SOUL_CHARGES    = 5,
    EVENT_SPELL_DOOMFIRE                = 6,
    EVENT_SPELL_FINGER_OF_DEATH         = 7,
    EVENT_SPELL_HAND_OF_DEATH           = 8,
    EVENT_SPELL_PROTECTION_OF_ELUNE     = 9,
    EVENT_ENRAGE                        = 10,
    EVENT_CHECK_WORLD_TREE_DISTANCE     = 11,    // Enrage if too close to the tree
    EVENT_BELOW_10_PERCENT_HP           = 12,
    EVENT_SUMMON_WISPS                  = 13,
    EVENT_TOO_CLOSE_TO_WORLD_TREE       = 14,
    EVENT_ENRAGE_ROOT                   = 15,
    EVENT_SPELL_FINGER_OF_DEATH_PHASE_4 = 16
};

Position const NordrassilLoc = { 5503.713f, -3523.436f, 1608.781f, 0.0f };

class npc_ancient_wisp : public CreatureScript
{
public:
    npc_ancient_wisp() : CreatureScript("npc_ancient_wisp") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHyjalAI<npc_ancient_wispAI>(creature);
    }

    struct npc_ancient_wispAI : public ScriptedAI
    {
        npc_ancient_wispAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            ArchimondeGUID.Clear();
        }

        InstanceScript* instance;
        ObjectGuid ArchimondeGUID;
        uint32 CheckTimer;

        void Reset() override
        {
            CheckTimer = 1000;

            ArchimondeGUID = instance->GetGuidData(DATA_ARCHIMONDE);

            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            damage = 0;
        }

        void UpdateAI(uint32 diff) override
        {
            if (CheckTimer <= diff)
            {
                if (Unit* Archimonde = ObjectAccessor::GetUnit(*me, ArchimondeGUID))
                {
                    if (Archimonde->HealthBelowPct(2) || !Archimonde->IsAlive())
                        DoCast(me, SPELL_DENOUEMENT_WISP);
                    else
                        DoCast(Archimonde, SPELL_ANCIENT_SPARK);
                }
                CheckTimer = 1000;
            }
            else CheckTimer -= diff;
        }
    };
};

/* This script is merely a placeholder for the Doomfire that triggers Doomfire spell. It will
   MoveChase the Doomfire Spirit always, until despawn (AttackStart is called upon it's spawn) */
class npc_doomfire : public CreatureScript
{
public:
    npc_doomfire() : CreatureScript("npc_doomfire") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHyjalAI<npc_doomfireAI>(creature);
    }

    struct npc_doomfireAI : public ScriptedAI
    {
        npc_doomfireAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override { }

        void MoveInLineOfSight(Unit* /*who*/) override { }

        void JustEngagedWith(Unit* /*who*/) override { }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            damage = 0;
        }
    };
};

/* This is the script for the Doomfire Spirit Mob. This mob simply follow players or
   travels in random directions if target cannot be found. */
class npc_doomfire_targetting : public CreatureScript
{
public:
    npc_doomfire_targetting() : CreatureScript("npc_doomfire_targetting") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHyjalAI<npc_doomfire_targettingAI>(creature);
    }

    struct npc_doomfire_targettingAI : public ScriptedAI
    {
        npc_doomfire_targettingAI(Creature* creature) : ScriptedAI(creature) { }

        ObjectGuid TargetGUID;
        uint32 ChangeTargetTimer;

        void Reset() override
        {
            TargetGUID.Clear();
            ChangeTargetTimer = 5000;
        }

        void MoveInLineOfSight(Unit* who) override

        {
            //will update once TargetGUID is 0. In case noone actually moves(not likely) and this is 0
            //when UpdateAI needs it, it will be forced to select randomPoint
            if (!TargetGUID && who->GetTypeId() == TYPEID_PLAYER)
                TargetGUID = who->GetGUID();
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            damage = 0;
        }

        void UpdateAI(uint32 diff) override
        {
            if (ChangeTargetTimer <= diff)
            {
                if (Unit* temp = ObjectAccessor::GetUnit(*me, TargetGUID))
                {
                    me->GetMotionMaster()->MoveFollow(temp, 0.0f, 0.0f);
                    TargetGUID.Clear();
                }
                else
                {
                    Position pos = me->GetRandomNearPosition(40);
                    me->GetMotionMaster()->MovePoint(0, pos.m_positionX, pos.m_positionY, pos.m_positionZ);
                }

                ChangeTargetTimer = 5000;
            }
            else ChangeTargetTimer -= diff;
        }
    };
};

/* Finally, Archimonde's script. His script isn't extremely complex, most are simply spells on timers.
   The only complicated aspect of the battle is Finger of Death and Doomfire, with Doomfire being the
   hardest bit to code. Finger of Death is simply a distance check - if no one is in melee range, then
   select a random target and cast the spell on them. However, if someone IS in melee range, and this
   is NOT the main tank (creature's victim), then we aggro that player and they become the new victim.
   For Doomfire, we summon a mob (Doomfire Spirit) for the Doomfire mob to follow. It's spirit will
   randomly select it's target to follow and then we create the random movement making it unpredictable. */

class boss_archimonde : public CreatureScript
{
public:
    boss_archimonde() : CreatureScript("boss_archimonde") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHyjalAI<boss_archimondeAI>(creature);
    }

    struct boss_archimondeAI : public BossAI
    {
        boss_archimondeAI(Creature* creature) : BossAI(creature, BOSS_ARCHIMONDE), summons(me),
            Enraged(false), BelowTenPercent(false), HasProtected(false), IsChanneling(false)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        ObjectGuid DoomfireSpiritGUID;
        ObjectGuid WorldTreeGUID;

        uint8 SoulChargeCount;
        uint8 WispCount;
        SummonList summons;

        bool Enraged;
        bool BelowTenPercent;
        bool HasProtected;
        bool IsChanneling;

        std::list<Unit*> fingerOfDeathTargets;
        std::list<Unit*> spellEffectTargets;

        void Reset() override
        {
            instance->SetData(DATA_ARCHIMONDE, NOT_STARTED);

            me->SetReactState(REACT_AGGRESSIVE);
            DoomfireSpiritGUID.Clear();
            WorldTreeGUID.Clear();
            WispCount = 0;
            Enraged = false;
            BelowTenPercent = false;
            HasProtected = false;
            IsChanneling = false;

            // Reset player's immunity to Spells
            for (auto it = spellEffectTargets.begin(); it != spellEffectTargets.end(); ++it)
            {
                Unit* affected_unit = ObjectAccessor::GetUnit(*me, (*it)->GetGUID());

                // Remove Immunity against Hand of death
                affected_unit->ApplySpellImmune(SPELL_HAND_OF_DEATH, IMMUNITY_ID, SPELL_HAND_OF_DEATH, false);
                affected_unit->ApplySpellImmune(0, IMMUNITY_ID, SPELL_HAND_OF_DEATH, false);
            }

            spellEffectTargets.clear();
            fingerOfDeathTargets.clear();
            summons.DespawnAll();
            events.ScheduleEvent(EVENT_DRAIN_WORLD_TREE, 0);
        }

        void DoCastProtection()
        {
            // lets get spell info
            SpellInfo const* info = sSpellMgr->GetSpellInfo(SPELL_PROTECTION_OF_ELUNE);

            if (!info)
                return;

            // Now lets get archimode threat list
            ThreatContainer::StorageType const& t_list = me->GetThreatMgr().GetThreatList();

            if (t_list.empty())
                return;

            ThreatContainer::StorageType::const_iterator itr = t_list.begin();

            if (Unit* target = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
                if (target->IsAlive() && target->GetTypeId() == TYPEID_PLAYER)
                    spellEffectTargets.push_back(target);

            for (auto iter = spellEffectTargets.begin(); iter != spellEffectTargets.end(); ++iter)
                if (Unit* target = *iter)
                {
                    target->AddAura(SPELL_PROTECTION_OF_ELUNE, target);

                    // Immunity against Hand of death
                    target->ApplySpellImmune(SPELL_HAND_OF_DEATH, IMMUNITY_ID, SPELL_HAND_OF_DEATH, true);
                    target->ApplySpellImmune(0, IMMUNITY_ID, SPELL_HAND_OF_DEATH, true);
                }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->InterruptSpell(CURRENT_CHANNELED_SPELL);
            Talk(SAY_AGGRO);
            DoZoneInCombat();

            instance->SetData(DATA_ARCHIMONDE, IN_PROGRESS);
            events.ScheduleEvent(EVENT_SPELL_AIR_BURST, urand(25000, 35000));
            events.ScheduleEvent(EVENT_SPELL_DOOMFIRE, urand(10000, 20000));
            events.ScheduleEvent(EVENT_SPELL_FEAR, 42000);
            events.ScheduleEvent(EVENT_SPELL_GRIP_OF_THE_LEGION, 2000);
            events.ScheduleEvent(EVENT_SPELL_FINGER_OF_DEATH, 1000);

            instance->SetData(DATA_SPAWN_WAVES, 1);
        }

        void KilledUnit(Unit* victim) override
        {
            Talk(SAY_SLAY);

            if (victim && victim->GetTypeId() == TYPEID_PLAYER)
                GainSoulCharge(victim->ToPlayer());
        }

        void GainSoulCharge(Player* victim)
        {
            switch (victim->getClass())
            {
                case CLASS_PRIEST:
                case CLASS_PALADIN:
                case CLASS_WARLOCK:
                    victim->CastSpell(me, SPELL_SOUL_CHARGE_RED, true);
                    break;
                case CLASS_MAGE:
                case CLASS_ROGUE:
                case CLASS_WARRIOR:
                    victim->CastSpell(me, SPELL_SOUL_CHARGE_YELLOW, true);
                    break;
                case CLASS_DRUID:
                case CLASS_SHAMAN:
                case CLASS_HUNTER:
                    victim->CastSpell(me, SPELL_SOUL_CHARGE_GREEN, true);
                    break;
            }

            events.ScheduleEvent(EVENT_SPELL_UNLEASH_SOUL_CHARGES, urand(2000, 10000));
            ++SoulChargeCount;
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);

            instance->SetData(DATA_ARCHIMONDE, DONE);
            instance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, me->GetEntry(), 1, me);

            // Reset scheduled events
            events.CancelEvent(EVENT_SPELL_FEAR);
            events.CancelEvent(EVENT_SPELL_AIR_BURST);
            events.CancelEvent(EVENT_SPELL_GRIP_OF_THE_LEGION);
            events.CancelEvent(EVENT_SPELL_UNLEASH_SOUL_CHARGES);
            events.CancelEvent(EVENT_SPELL_DOOMFIRE);
            events.CancelEvent(EVENT_SPELL_FINGER_OF_DEATH);
            events.CancelEvent(EVENT_SPELL_HAND_OF_DEATH);
            events.CancelEvent(EVENT_SPELL_PROTECTION_OF_ELUNE);
            events.CancelEvent(EVENT_ENRAGE);

            spellEffectTargets.clear();
            fingerOfDeathTargets.clear();
            summons.DespawnAll();
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            instance->SetData(DATA_RESET_NIGHT_ELF, 1);
            BossAI::EnterEvadeMode(why);
        }

        bool CanUseFingerOfDeath()
        {
            // Cast finger of death below 10% health
            if (BelowTenPercent)
                return true;

            if (me->IsAlive())
            {
                /* Reset the list before checking for new targets
                 * else we will be using old targets that could have
                 * been distant but are no longer.*/
                fingerOfDeathTargets.clear();

                // First we check if our current victim is in melee range or not.
                Unit* victim = me->GetVictim();
                if (victim && me->IsWithinMeleeRange(victim))
                    return false;

                ThreatContainer::StorageType const& threatlist = me->GetThreatMgr().GetThreatList();
                if (threatlist.empty())
                    return false;

                auto itr = threatlist.begin();
                for (; itr != threatlist.end(); ++itr)
                {
                    Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid());
                    if (unit && unit->IsAlive() && me->IsWithinMeleeRange(unit))
                        fingerOfDeathTargets.push_back(unit);
                }

                /* Previous check searched for targets in meele range and
                 * added it to targets list. If there are no targets in meele
                 * range return true, which makes Archimonde cast Finger of Death.
                */
                return fingerOfDeathTargets.empty();
            }
            return false;
        }

        void JustSummoned(Creature* summoned) override
        {
            summons.Summon(summoned);
            if (summoned->GetEntry() == CREATURE_ANCIENT_WISP)
                summoned->AI()->AttackStart(me);
            else
            {
                summoned->SetFaction(me->GetFaction());
                summoned->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                summoned->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            }

            if (summoned->GetEntry() == CREATURE_DOOMFIRE_SPIRIT)
            {
                DoomfireSpiritGUID = summoned->GetGUID();
            }

            if (summoned->GetEntry() == CREATURE_DOOMFIRE)
            {
                summoned->CastSpell(summoned, SPELL_DOOMFIRE_SPAWN, false);
                summoned->CastSpell(summoned, SPELL_DOOMFIRE, true, 0, 0, me->GetGUID());

                if (Unit* DoomfireSpirit = ObjectAccessor::GetUnit(*me, DoomfireSpiritGUID))
                {
                    summoned->GetMotionMaster()->MoveFollow(DoomfireSpirit, 0.0f, 0.0f);
                    DoomfireSpiritGUID.Clear();
                }
            }
        }

        void DoCastDoomfire()
        {
            // Three doomfire can be up at the same time
            Talk(SAY_DOOMFIRE);
            Unit* temp = SelectTarget(SelectTargetMethod::Random, 1);
            if (!temp)
                temp = me->GetVictim();

            //replace with spell cast 31903 once implicitTarget 73 implemented
            SummonDoomfire(temp);
        }

        //this is code doing close to what the summoning spell would do (spell 31903)
        void SummonDoomfire(Unit* target)
        {
            Unit* doomfire1 = me->SummonCreature(CREATURE_DOOMFIRE_SPIRIT,
                                                 target->GetPositionX() + 15.0f, target->GetPositionY() + 15.0f, target->GetPositionZ(), 0,
                                                 TEMPSUMMON_TIMED_DESPAWN, 27000);

            Unit* doomfire2 = me->SummonCreature(CREATURE_DOOMFIRE,
                                                 target->GetPositionX() - 15.0f, target->GetPositionY() - 15.0f, target->GetPositionZ(), 0,
                                                 TEMPSUMMON_TIMED_DESPAWN, 27000);

            doomfire1->SetVisible(false);
            doomfire2->SetVisible(false);
        }

        void UnleashSoulCharge()
        {
            me->InterruptNonMeleeSpells(false);

            uint32 chargeSpell = 0;
            uint32 unleashSpell = 0;

            switch (urand(0, 2))
            {
                case 0:
                    chargeSpell = SPELL_SOUL_CHARGE_RED;
                    unleashSpell = SPELL_UNLEASH_SOUL_RED;
                    break;
                case 1:
                    chargeSpell = SPELL_SOUL_CHARGE_YELLOW;
                    unleashSpell = SPELL_UNLEASH_SOUL_YELLOW;
                    break;
                case 2:
                    chargeSpell = SPELL_SOUL_CHARGE_GREEN;
                    unleashSpell = SPELL_UNLEASH_SOUL_GREEN;
                    break;
            }

            if (me->HasAura(chargeSpell))
            {
                me->RemoveAuraFromStack(chargeSpell);
                DoCastVictim(unleashSpell);
                SoulChargeCount--;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            // Event for draining the tree
            if (!me->IsInCombat())
            {
                // Do not let the raid skip straight to Archimonde. Visible and hostile ONLY if Azagalor is finished.
                if ((instance->GetBossState(DATA_AZGALOR) != DONE) && (me->IsVisible() || (me->GetFaction() != FACTION_FRIENDLY)))
                {
                    me->SetVisible(false);
                    me->SetFaction(FACTION_FRIENDLY);
                }

                if ((instance->GetBossState(DATA_AZGALOR) == DONE) && (!me->IsVisible() || (me->GetFaction() == FACTION_FRIENDLY)))
                {
                    me->SetFaction(FACTION_DRAGONKIN);
                    me->SetVisible(true);
                }

                switch (events.ExecuteEvent())
                {
                    case EVENT_DRAIN_WORLD_TREE:
                        if (!IsChanneling)
                        {
                            Creature* temp = me->SummonCreature(CREATURE_CHANNEL_TARGET, NordrassilLoc, TEMPSUMMON_TIMED_DESPAWN, 1200000);

                            if (temp)
                                WorldTreeGUID = temp->GetGUID();

                            if (Unit* Nordrassil = ObjectAccessor::GetUnit(*me, WorldTreeGUID))
                            {
                                Nordrassil->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                                Nordrassil->SetDisplayId(11686);
                                DoCast(Nordrassil, SPELL_DRAIN_WORLD_TREE);
                                IsChanneling = true;
                            }
                        }

                        if (Unit* Nordrassil = ObjectAccessor::GetUnit(*me, WorldTreeGUID))
                            Nordrassil->CastSpell(me, SPELL_DRAIN_WORLD_TREE_2, true);
                        break;
                }
            }

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (me->HealthBelowPct(10) && !BelowTenPercent)
                events.ScheduleEvent(EVENT_BELOW_10_PERCENT_HP, 0);

            switch (events.ExecuteEvent())
            {
                case EVENT_CHECK_WORLD_TREE_DISTANCE:
                    {
                        // If Archimonde is too close to the world tree this will ENRAGE him
                        Creature* Check = me->SummonCreature(CREATURE_CHANNEL_TARGET, NordrassilLoc, TEMPSUMMON_TIMED_DESPAWN, 2000);
                        if (Check)
                        {
                            Check->SetVisible(false);

                            if (me->IsWithinDistInMap(Check, 75))
                            {
                                events.ScheduleEvent(EVENT_TOO_CLOSE_TO_WORLD_TREE, 0);
                                break;
                            }
                        }
                        events.RepeatEvent(5000);
                        break;
                    }
                case EVENT_BELOW_10_PERCENT_HP:
                    me->SetReactState(REACT_PASSIVE);
                    DoCastProtection();     // Protection of Elune against Finger and Hand of Death
                    BelowTenPercent = true;
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                    events.ScheduleEvent(EVENT_ENRAGE, 0);
                    events.ScheduleEvent(EVENT_ENRAGE_ROOT, 0);
                    events.ScheduleEvent(EVENT_SUMMON_WISPS, 1000);
                    events.ScheduleEvent(EVENT_SPELL_HAND_OF_DEATH, 1500);
                    events.ScheduleEvent(EVENT_SPELL_FINGER_OF_DEATH, 2500);
                    break;
                case EVENT_SUMMON_WISPS:
                    // If there are more than 30 Wisps then kill Archimonde
                    if (WispCount >= 30)
                    {
                        Unit::DealDamage(me, me, me->GetHealth(), nullptr, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, nullptr, false);
                        return;     // Finish the encounter and no more event repeat
                    }
                    DoSpawnCreature(CREATURE_ANCIENT_WISP, float(rand() % 40), float(rand() % 40), 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                    ++WispCount;
                    events.ScheduleEvent(EVENT_SUMMON_WISPS, 1500);
                    break;
                case EVENT_SPELL_HAND_OF_DEATH:
                    DoCastVictim(SPELL_RED_SKY_EFFECT);
                    DoCastVictim(SPELL_HAND_OF_DEATH);
                    events.ScheduleEvent(EVENT_SPELL_HAND_OF_DEATH, 3000);
                    break;
                case EVENT_SPELL_FINGER_OF_DEATH:
                    if (CanUseFingerOfDeath())
                    {
                        Unit* target = SelectTarget(SelectTargetMethod::Random, 0);
                        DoCast(target, SPELL_FINGER_OF_DEATH);
                        DoCastVictim(SPELL_RED_SKY_EFFECT);
                    }
                    events.ScheduleEvent(EVENT_SPELL_FINGER_OF_DEATH, 3500);
                    break;
                case EVENT_SPELL_GRIP_OF_THE_LEGION:
                    DoCast(SelectTarget(SelectTargetMethod::Random, 0), SPELL_GRIP_OF_THE_LEGION);
                    events.ScheduleEvent(EVENT_SPELL_GRIP_OF_THE_LEGION, urand(5000, 25000));
                    break;
                case EVENT_SPELL_AIR_BURST:
                    Talk(SAY_AIR_BURST);
                    DoCast(SelectTarget(SelectTargetMethod::Random, 0), SPELL_AIR_BURST);
                    events.ScheduleEvent(EVENT_SPELL_AIR_BURST, urand(25000, 40000));
                    break;
                case EVENT_SPELL_FEAR:
                    DoCastVictim(SPELL_FEAR);
                    events.ScheduleEvent(EVENT_SPELL_FEAR, 42000);
                    break;
                case EVENT_SPELL_DOOMFIRE:
                    DoCastDoomfire();
                    events.ScheduleEvent(EVENT_SPELL_DOOMFIRE, 20000);
                    break;
                case EVENT_SPELL_UNLEASH_SOUL_CHARGES:
                    UnleashSoulCharge();
                    break;
                case EVENT_ENRAGE:
                    Talk(SAY_ENRAGE);
                    break;
                case EVENT_TOO_CLOSE_TO_WORLD_TREE:
                    // People dragged the boss near the check and now wipe
                    events.ScheduleEvent(EVENT_ENRAGE, 0);
                    events.ScheduleEvent(EVENT_SPELL_HAND_OF_DEATH, 1000);
                    break;
                case EVENT_ENRAGE_ROOT:
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_red_sky_effect : public SpellScriptLoader
{
public:
    spell_red_sky_effect() : SpellScriptLoader("spell_red_sky_effect") { }

    class spell_red_sky_effect_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_red_sky_effect_SpellScript);

        void HandleHit(SpellEffIndex /*effIndex*/)
        {
            if (GetHitUnit())
                PreventHitDamage();
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_red_sky_effect_SpellScript::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_red_sky_effect_SpellScript();
    }
};

class spell_finger_of_death : public SpellScriptLoader
{
public:
    spell_finger_of_death() : SpellScriptLoader("spell_finger_of_death") { }

    class spell_finger_of_death_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_finger_of_death_SpellScript);

        void HandleHit(SpellEffIndex /*effIndex*/)
        {
            if (GetHitUnit() && GetHitUnit()->GetAura(SPELL_PROTECTION_OF_ELUNE))
                PreventHitDamage();
            else
                GetHitUnit()->RemoveAurasByType(SPELL_AURA_EFFECT_IMMUNITY);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_finger_of_death_SpellScript::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_finger_of_death_SpellScript();
    }
};

class spell_hand_of_death : public SpellScriptLoader
{
public:
    spell_hand_of_death() : SpellScriptLoader("spell_hand_of_death") { }

    class spell_hand_of_death_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hand_of_death_SpellScript);

        void HandleHit(SpellEffIndex /*effIndex*/)
        {
            if (GetHitUnit() && GetHitUnit()->GetAura(SPELL_PROTECTION_OF_ELUNE))
                PreventHitDamage();
            else
                GetHitUnit()->RemoveAurasByType(SPELL_AURA_EFFECT_IMMUNITY);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_hand_of_death_SpellScript::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_hand_of_death_SpellScript();
    }
};

void AddSC_boss_archimonde()
{
    new spell_red_sky_effect();
    new spell_hand_of_death();
    new spell_finger_of_death();
    new boss_archimonde();
    new npc_doomfire();
    new npc_doomfire_targetting();
    new npc_ancient_wisp();
}

