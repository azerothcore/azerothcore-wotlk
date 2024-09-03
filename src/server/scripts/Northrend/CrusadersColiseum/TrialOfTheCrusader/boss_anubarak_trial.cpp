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
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "trial_of_the_crusader.h"

enum AnubTexts
{
    SAY_INTRO               = 0,
    SAY_AGGRO               = 1,
    EMOTE_SUBMERGE          = 2,
    EMOTE_BURROWER          = 3,
    SAY_EMERGE              = 4,
    SAY_LEECHING_SWARM      = 5,
    EMOTE_LEECHING_SWARM    = 6,
    SAY_KILL_PLAYER         = 7,
    SAY_DEATH               = 8,

    EMOTE_SPIKE             = 0,
};

enum AnubNPCs
{
    NPC_FROST_SPHERE                            = 34606,
    NPC_BURROW                                  = 34862,
    NPC_BURROWER                                = 34607,
    NPC_SCARAB                                  = 34605,
    NPC_SPIKE                                   = 34660,
};

const Position AnubLocs[] =
{
    // scarab's beginning pos
    {722.65f, 135.41f, 142.16f, M_PI},

    // churning ground spawns
    {694.886353f, 102.484665f, 142.119614f, 0},
    {731.987244f, 83.3824690f, 142.119614f, 0},
    {694.500671f, 185.363968f, 142.117905f, 0},
    {740.184509f, 193.443390f, 142.117584f, 0},

    // sphere spawns
    { 786.6439f, 108.2498f, 155.6701f, 0 },
    { 806.8429f, 150.5902f, 155.6701f, 0 },
    { 759.1386f, 163.9654f, 155.6701f, 0 },
    { 744.3701f, 119.5211f, 155.6701f, 0 },
    { 710.0211f, 120.8152f, 155.6701f, 0 },
    { 706.6383f, 161.5266f, 155.6701f, 0 },
};

class HideNpcEvent : public BasicEvent
{
public:
    HideNpcEvent(Creature& owner) : _owner(owner) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _owner.SetVisible(false);
        return true;
    }

private:
    Creature& _owner;
};

enum AnubSpells
{
    // Anub'arak
    SPELL_SUBMERGE                              = 65981,
    SPELL_EMERGE                                = 65982,
    SPELL_BERSERK                               = 26662,
    SPELL_CLEAR_ALL_DEBUFFS                     = 34098,

    SPELL_FREEZING_SLASH                        = 66012,
    SPELL_PENETRATING_COLD                      = 66013,
    SPELL_SUMMON_SCARAB                         = 66339,
    SPELL_SUMMON_BURROWER                       = 66332,
    SPELL_LEECHING_SWARM                        = 66118,

    // Anub'arak Pursue
    SPELL_MARK                                  = 67574,
    SPELL_SUMMON_SPIKE                          = 66169,
    SPELL_SPIKE_SPEED1                          = 65920,
    SPELL_SPIKE_TRAIL                           = 65921,
    SPELL_SPIKE_SPEED2                          = 65922,
    SPELL_SPIKE_SPEED3                          = 65923,
    SPELL_SPIKE_FAIL                            = 66181,
    SPELL_SPIKE_TELE                            = 66170,
    SPELL_IMPALE                                = 65919,

    // Scarab
    SPELL_DETERMINATION                         = 66092,
    SPELL_ACID_MANDIBLE                         = 65774,

    // Burrow
    SPELL_CHURNING_GROUND                       = 66969,

    // Frost Sphere
    SPELL_FROST_SPHERE                          = 67539,
    SPELL_PERMAFROST                            = 66193,
    SPELL_PERMAFROST_VISUAL                     = 65882,

    // Burrower
    SPELL_SPIDER_FRENZY                         = 66128,
    SPELL_EXPOSE_WEAKNESS                       = 67720,
    SPELL_SHADOW_STRIKE                         = 66134,
    SPELL_SUBMERGE_EFFECT                       = 53421,
    SPELL_EMERGE_EFFECT                         = 66947,
};

enum AnubEvents
{
    EVENT_RESPAWN_SPHERE = 1,
    EVENT_ENRAGE,
    EVENT_SPELL_FREEZING_SLASH,
    EVENT_SPELL_PENETRATING_COLD,
    EVENT_SUMMON_NERUBIAN,
    EVENT_SUBMERGE,
    EVENT_EMERGE,
    EVENT_EMERGE_2,
    EVENT_SPELL_SUMMON_SPIKE,
    EVENT_SPELL_SHADOW_STRIKE,
    EVENT_SUMMON_SCARAB,
};

class boss_anubarak_trial : public CreatureScript
{
public:
    boss_anubarak_trial() : CreatureScript("boss_anubarak_trial") {}

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<boss_anubarak_trialAI>(pCreature);
    };

    struct boss_anubarak_trialAI : public ScriptedAI
    {
        boss_anubarak_trialAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = (InstanceScript*)pCreature->GetInstanceScript();
            events.Reset();
            bIntro = false;
            bPhase3 = false;
            me->ApplySpellImmune(0, IMMUNITY_ID, RAID_MODE(66193, 67855, 67856, 67857), true);
            me->m_SightDistance = 90.0f; // for MoveInLineOfSight distance
        }

        InstanceScript* pInstance;
        SummonList summons;
        EventMap events;
        bool bIntro;
        bool bPhase3;
        ObjectGuid SphereGUID[6];
        ObjectGuid BurrowGUID[4];

        void Reset() override
        {
            me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            summons.DespawnAll();
            for( uint8 i = 0; i < 10; ++i )
            {
                float angle = rand_norm() * 2 * M_PI;
                float dist = rand_norm() * 40.0f;
                if( Creature* c = me->SummonCreature(NPC_SCARAB, AnubLocs[0].GetPositionX() + cos(angle) * dist, AnubLocs[0].GetPositionY() + std::sin(angle) * dist, AnubLocs[0].GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000) )
                {
                    c->SetFaction(FACTION_PREY);
                    c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    c->GetMotionMaster()->MoveRandom(15.0f);
                }
            }
        }

        void DoAction(int32 param) override
        {
            switch( param )
            {
                case -1:
                    summons.DespawnAll();
                    break;
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->setActive(true);
            events.Reset();
            events.RescheduleEvent(EVENT_ENRAGE, 10min);
            events.RescheduleEvent(EVENT_SPELL_FREEZING_SLASH, 7s, 15s);
            events.RescheduleEvent(EVENT_SPELL_PENETRATING_COLD, 15s, 20s);
            events.RescheduleEvent(EVENT_SUMMON_NERUBIAN, 5s, 8s);
            events.RescheduleEvent(EVENT_SUBMERGE, 80s);
            if( !IsHeroic() )
                events.RescheduleEvent(EVENT_RESPAWN_SPHERE, 4s);

            for (ObjectGuid const& guid : summons)
                if (pInstance)
                    if (Creature* c = pInstance->instance->GetCreature(guid))
                    {
                        c->GetMotionMaster()->MoveIdle();
                        c->StopMoving();
                        c->CastSpell(c, SPELL_SUBMERGE, false);
                        c->AI()->DoAction(1);
                    }
            summons.clear();
            for( uint8 i = 0; i < 4; ++i )
                if( Creature* c = me->SummonCreature(NPC_BURROW, AnubLocs[i + 1]) )
                    BurrowGUID[i] = c->GetGUID();
            for( uint8 i = 0; i < 6; ++i )
                if( Creature* c = me->SummonCreature(NPC_FROST_SPHERE, AnubLocs[i + 5]) )
                    SphereGUID[i] = c->GetGUID();

            Talk(SAY_AGGRO);
            DoZoneInCombat();
            if( pInstance )
                pInstance->SetData(TYPE_ANUBARAK, IN_PROGRESS);
        }

        void JustReachedHome() override
        {
            me->setActive(false);
        }

        void UpdateAI(uint32 diff) override
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            if( !bPhase3 && HealthBelowPct(30) && !me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE) && !me->HasAura(SPELL_SUBMERGE) && !me->HasAura(SPELL_EMERGE) )
            {
                bPhase3 = true;
                events.CancelEvent(EVENT_SUBMERGE);
                events.CancelEvent(EVENT_EMERGE);
                events.CancelEvent(EVENT_EMERGE_2);
                if( !IsHeroic() )
                    events.CancelEvent(EVENT_SUMMON_NERUBIAN);
                me->CastSpell((Unit*)nullptr, SPELL_LEECHING_SWARM, false);
                Talk(EMOTE_LEECHING_SWARM);
                Talk(SAY_LEECHING_SWARM);
                return;
            }

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_ENRAGE:
                    {
                        me->CastSpell(me, SPELL_BERSERK, true);
                    }
                    break;
                case EVENT_RESPAWN_SPHERE:
                    {
                        uint8 StartAt = urand(0, 5);
                        uint8 i = StartAt;
                        do
                        {
                            if( Creature* c = ObjectAccessor::GetCreature(*me, SphereGUID[i]) )
                                if( !c->HasAura(SPELL_FROST_SPHERE) )
                                {
                                    if( Creature* c = me->SummonCreature(NPC_FROST_SPHERE, AnubLocs[i + 5]) )
                                        SphereGUID[i] = c->GetGUID();
                                    break;
                                }
                            i = (i + 1) % 6;
                        } while( i != StartAt );
                        events.Repeat(4s);
                    }
                    break;
                case EVENT_SPELL_FREEZING_SLASH:
                    {
                        if( me->GetVictim() )
                            me->CastSpell(me->GetVictim(), SPELL_FREEZING_SLASH, false);
                        events.Repeat(15s, 20s);
                    }
                    break;
                case EVENT_SPELL_PENETRATING_COLD:
                    {
                        me->CastCustomSpell(SPELL_PENETRATING_COLD, SPELLVALUE_MAX_TARGETS, RAID_MODE(2, 5, 2, 5));
                        events.Repeat(18s);
                    }
                    break;
                case EVENT_SUMMON_NERUBIAN:
                    {
                        me->CastCustomSpell(SPELL_SUMMON_BURROWER, SPELLVALUE_MAX_TARGETS, RAID_MODE(1, 2, 2, 4));
                        events.Repeat(45s);
                    }
                    break;
                case EVENT_SUBMERGE:
                    {
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        bool berserk = me->HasAura(SPELL_BERSERK);
                        DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
                        if (berserk)
                            me->CastSpell(me, SPELL_BERSERK, true);
                        Talk(EMOTE_SUBMERGE);
                        Talk(EMOTE_BURROWER);
                        me->CastSpell(me, SPELL_SUBMERGE, false);
                        events.CancelEvent(EVENT_SUMMON_NERUBIAN);
                        events.CancelEvent(EVENT_SPELL_FREEZING_SLASH);
                        events.CancelEvent(EVENT_SPELL_PENETRATING_COLD);
                        events.RescheduleEvent(EVENT_EMERGE, 1min);
                        events.RescheduleEvent(EVENT_SPELL_SUMMON_SPIKE, 2500ms);
                        events.RescheduleEvent(EVENT_SUMMON_SCARAB, 3s);
                    }
                    break;
                case EVENT_SUMMON_SCARAB:
                    {
                        uint8 i = urand(0, 3);
                        if( Creature* c = ObjectAccessor::GetCreature(*me, BurrowGUID[i]) )
                            me->CastSpell(c, SPELL_SUMMON_SCARAB, true);
                        events.Repeat(4s);
                    }
                    break;
                case EVENT_EMERGE:
                    {
                        me->CastSpell(me, SPELL_SPIKE_TELE, true);
                        summons.DespawnEntry(NPC_SPIKE);
                        events.CancelEvent(EVENT_SUMMON_SCARAB);
                        events.RescheduleEvent(EVENT_EMERGE_2, 2s);
                    }
                    break;
                case EVENT_EMERGE_2:
                    {
                        Talk(SAY_EMERGE);
                        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        me->setAttackTimer(BASE_ATTACK, 3000);
                        me->RemoveAura(SPELL_SUBMERGE);
                        me->CastSpell(me, SPELL_EMERGE, false);
                        events.RescheduleEvent(EVENT_SUMMON_NERUBIAN, 5s, 8s);
                        events.RescheduleEvent(EVENT_SPELL_FREEZING_SLASH, 7s, 15s);
                        events.RescheduleEvent(EVENT_SPELL_PENETRATING_COLD, 15s, 20s);
                        events.RescheduleEvent(EVENT_SUBMERGE, 80s);
                    }
                    break;
                case EVENT_SPELL_SUMMON_SPIKE:
                    me->CastSpell(me, SPELL_SUMMON_SPIKE, true);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* summon) override
        {
            if( !summon )
                return;

            summons.Summon(summon);
        }

        void JustDied(Unit* /*pKiller*/) override
        {
            events.Reset();
            summons.DespawnAll();
            Talk(SAY_DEATH);
            if( pInstance )
                pInstance->SetData(TYPE_ANUBARAK, DONE);
        }

        void KilledUnit(Unit* who) override
        {
            if( who->IsPlayer() )
                Talk(SAY_KILL_PLAYER);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            events.Reset();
            summons.DespawnAll();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            if( pInstance )
                pInstance->SetData(TYPE_FAILED, 1);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER || me->GetExactDistSq(who) > 6400.0f) // 80yd*80yd
                return;

            if (me->getStandState() != UNIT_STAND_STATE_STAND)
                me->SetStandState(UNIT_STAND_STATE_STAND);

            if (!bIntro)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                if( !me->IsInCombat() )
                    Talk(SAY_INTRO);
                bIntro = true;
            }
            ScriptedAI::MoveInLineOfSight(who);
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return target->GetEntry() != NPC_FROST_SPHERE;
        }
    };
};

class npc_swarm_scarab : public CreatureScript
{
public:
    npc_swarm_scarab() : CreatureScript("npc_swarm_scarab") {}

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<npc_swarm_scarabAI>(pCreature);
    };

    struct npc_swarm_scarabAI : public ScriptedAI
    {
        npc_swarm_scarabAI(Creature* pCreature) : ScriptedAI(pCreature) {}

        int32 determinationTimer;
        int32 despawnTimer;

        void DoAction(int32 param) override
        {
            if( param == 1 )
                despawnTimer = 2000;
        }

        void Reset() override
        {
            me->SetCorpseDelay(10 * 60);
            me->CastSpell(me, SPELL_ACID_MANDIBLE, true);
            determinationTimer = urand(10000, 50000);
            despawnTimer = 0;
            if (me->GetFaction() == FACTION_MONSTER_2) // hostile - it's phase 2
                if( Unit* target = me->SelectNearestTarget(250.0f) )
                {
                    AttackStart(target);
                    DoZoneInCombat();
                    if( Unit* t = SelectTarget(SelectTargetMethod::Random, 0, 250.0f, true) )
                    {
                        me->AddThreat(t, 20000.0f);
                        AttackStart(t);
                    }
                }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            DoZoneInCombat();
        }

        void UpdateAI(uint32 diff) override
        {
            if( despawnTimer )
            {
                if( despawnTimer <= (int32)diff )
                {
                    despawnTimer = 0;
                    me->DisappearAndDie();
                }
                else
                    despawnTimer -= diff;

                return;
            }

            if( !UpdateVictim() )
                return;

            if( determinationTimer <= (int32)diff )
            {
                me->CastSpell(me, SPELL_DETERMINATION, false);
                determinationTimer = urand(20000, 60000);
            }
            else
                determinationTimer -= diff;

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*killer*/) override
        {
            me->CastSpell(me, RAID_MODE(SPELL_TRAITOR_KING_10, SPELL_TRAITOR_KING_25, SPELL_TRAITOR_KING_10, SPELL_TRAITOR_KING_25), true);
            me->m_Events.AddEvent(new HideNpcEvent(*me), me->m_Events.CalculateTime(5000));
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return target->GetEntry() != NPC_FROST_SPHERE && !me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        }
    };
};

class npc_frost_sphere : public CreatureScript
{
public:
    npc_frost_sphere() : CreatureScript("npc_frost_sphere") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<npc_frost_sphereAI>(pCreature);
    };

    struct npc_frost_sphereAI : public NullCreatureAI
    {
        npc_frost_sphereAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            uint32 ID = 0;
            if (me->GetMap())
                switch (me->GetMap()->GetDifficulty())
                {
                    case RAID_DIFFICULTY_10MAN_NORMAL:
                        ID = 66118;
                        break;
                    case RAID_DIFFICULTY_25MAN_NORMAL:
                        ID = 67630;
                        break;
                    case RAID_DIFFICULTY_10MAN_HEROIC:
                        ID = 68646;
                        break;
                    case RAID_DIFFICULTY_25MAN_HEROIC:
                        ID = 68647;
                        break;
                }
            if (ID)
                me->ApplySpellImmune(0, IMMUNITY_ID, ID, true);

            permafrostTimer = 0;
            me->CastSpell(me, SPELL_FROST_SPHERE, true);
            me->GetMotionMaster()->MoveRandom(20.0f);
            me->SetCorpseDelay(15 * 60 * 1000);
        }

        uint32 permafrostTimer;

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if( me->GetHealth() <= damage )
            {
                damage = 0;
                if( !me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE) )
                {
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->GetMotionMaster()->MoveIdle();
                    me->GetMotionMaster()->MoveCharge(me->GetPositionX(), me->GetPositionY(), 143.0f, 20.0f);
                    permafrostTimer = 1500;
                }
            }
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spell) override
        {
            if( spell->Id == SPELL_SPIKE_FAIL )
            {
                me->RemoveAllAuras();
                me->DespawnOrUnsummon(1500);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if( permafrostTimer )
            {
                if( permafrostTimer <= diff )
                {
                    permafrostTimer = 0;
                    me->RemoveAurasDueToSpell(SPELL_FROST_SPHERE);
                    me->SetDisplayId(11686);
                    me->SetObjectScale(2.0f);
                    me->UpdatePosition(me->GetPositionX(), me->GetPositionY(), 142.7f, me->GetOrientation(), false);
                    me->SetFacingTo(me->GetOrientation());
                    me->CastSpell(me, SPELL_PERMAFROST_VISUAL, true);
                    me->CastSpell(me, SPELL_PERMAFROST, true);
                    me->SetCanFly(false);
                }
                else
                    permafrostTimer -= diff;
            }
        }
    };
};

class npc_nerubian_burrower : public CreatureScript
{
public:
    npc_nerubian_burrower() : CreatureScript("npc_nerubian_burrower") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<npc_nerubian_burrowerAI>(pCreature);
    };

    struct npc_nerubian_burrowerAI : public ScriptedAI
    {
        npc_nerubian_burrowerAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            // I am summoned by another npc (SPELL_EFFECT_FORCE_CAST), inform Anub'arak
            if (InstanceScript* pInstance = me->GetInstanceScript())
                if (ObjectGuid guid = pInstance->GetGuidData(TYPE_ANUBARAK))
                    if (Creature* anub = pInstance->instance->GetCreature(guid))
                        CAST_AI(boss_anubarak_trial::boss_anubarak_trialAI, anub->AI())->JustSummoned(me);
        }

        EventMap events;

        void Reset() override
        {
            me->SetCorpseDelay(10 * 60);
            me->CastSpell(me, SPELL_EXPOSE_WEAKNESS, true);
            me->CastSpell(me, SPELL_SPIDER_FRENZY, true);
            events.Reset();
            events.RescheduleEvent(EVENT_SUBMERGE, 30s);
            if( IsHeroic() )
                events.RescheduleEvent(EVENT_SPELL_SHADOW_STRIKE, 30s, 45s);
            if( Unit* target = me->SelectNearestTarget(250.0f) )
            {
                AttackStart(target);
                DoZoneInCombat();
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if( !target || !spell )
                return;

            if( spell->Id == SPELL_SHADOW_STRIKE )
            {
                float o = target->GetOrientation();
                if( o >= M_PI )
                    o -= M_PI;
                else
                    o += M_PI;
                me->NearTeleportTo(target->GetPositionX() + cos(o) * 5.0f, target->GetPositionY() + std::sin(o) * 5.0f, target->GetPositionZ() + 0.6f, target->GetOrientation());
                AttackStart(target);
                me->GetMotionMaster()->MoveChase(target);
                events.DelayEvents(3000);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if( !UpdateVictim() )
                return;

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_SPELL_SHADOW_STRIKE:
                    if( Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 250.0f, true) )
                        me->CastSpell(target, SPELL_SHADOW_STRIKE, false);
                    events.Repeat(30s, 45s);
                    break;
                case EVENT_SUBMERGE:
                    if( HealthBelowPct(80) && !me->HasAura(RAID_MODE(66193, 67855, 67856, 67857)) ) // not having permafrost - allow submerge
                    {
                        me->GetMotionMaster()->MoveIdle();
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        DoCastSelf(SPELL_CLEAR_ALL_DEBUFFS, true);
                        me->CastSpell(me, SPELL_EXPOSE_WEAKNESS, true);
                        me->CastSpell(me, SPELL_SPIDER_FRENZY, true);
                        me->CastSpell(me, SPELL_SUBMERGE, false);

                        events.DelayEvents(15s);
                        events.RescheduleEvent(EVENT_EMERGE, 10s);
                    }
                    else
                        events.Repeat(3s);
                    break;
                case EVENT_EMERGE:
                    me->SetHealth(me->GetMaxHealth());
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->CastSpell(me, SPELL_EMERGE, false);
                    me->RemoveAura(SPELL_SUBMERGE);

                    events.RescheduleEvent(EVENT_SUBMERGE, 30s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*killer*/) override
        {
            me->m_Events.AddEvent(new HideNpcEvent(*me), me->m_Events.CalculateTime(5000));
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return target->GetEntry() != NPC_FROST_SPHERE;
        }
    };
};

class npc_anubarak_spike : public CreatureScript
{
public:
    npc_anubarak_spike() : CreatureScript("npc_anubarak_spike") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<npc_anubarak_spikeAI>(pCreature);
    };

    struct npc_anubarak_spikeAI : public ScriptedAI
    {
        npc_anubarak_spikeAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetCorpseDelay(0);
        }

        EventMap events;
        ObjectGuid TargetGUID;

        void DoAction(int32 param) override
        {
            if( param == -1 )
            {
                if( Unit* target = ObjectAccessor::GetPlayer(*me, TargetGUID) )
                    target->RemoveAura(SPELL_MARK);
                TargetGUID.Clear();
                me->RemoveAllAuras();
                me->GetMotionMaster()->MoveIdle();
                events.Reset();
                events.RescheduleEvent(3, 4s);
            }
        }

        void SelectNewTarget(bool next)
        {
            if (TargetGUID)
                if( Unit* target = ObjectAccessor::GetPlayer(*me, TargetGUID) )
                    target->RemoveAura(SPELL_MARK);
            TargetGUID.Clear();
            if (!next)
            {
                events.Reset();
                me->RemoveAllAuras();
            }
            DoZoneInCombat();
            DoResetThreatList();
            if( Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 250.0f, true) )
            {
                if (!next)
                {
                    me->CastSpell(me, SPELL_SPIKE_SPEED1, true);
                    me->CastSpell(me, SPELL_SPIKE_TRAIL, true);
                    events.RescheduleEvent(1, 7s);
                }
                TargetGUID = target->GetGUID();
                me->CastSpell(target, SPELL_MARK, true);
                Talk(EMOTE_SPIKE, target);
                AttackStart(target);
                me->GetMotionMaster()->MoveChase(target);
            }
        }

        void Reset() override
        {
            SelectNewTarget(false);
        }

        void UpdateAI(uint32 diff) override
        {
            if( TargetGUID )
            {
                Unit* target = ObjectAccessor::GetPlayer(*me, TargetGUID);
                if( !target || !target->HasAura(SPELL_MARK) || !me->IsValidAttackTarget(target) || me->GetMotionMaster()->GetCurrentMovementGeneratorType() != CHASE_MOTION_TYPE || !me->HasUnitState(UNIT_STATE_CHASE_MOVE) )
                {
                    SelectNewTarget(true);
                    return;
                }
            }

            events.Update(diff);

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case 1:
                    me->CastSpell(me, SPELL_SPIKE_SPEED2, true);

                    events.RescheduleEvent(2, 7s);
                    break;
                case 2:
                    me->CastSpell(me, SPELL_SPIKE_SPEED3, true);

                    break;
                case 3:
                    Reset();
                    break;
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            damage = 0;
        }
    };
};

class spell_pursuing_spikes : public SpellScriptLoader
{
public:
    spell_pursuing_spikes() : SpellScriptLoader("spell_pursuing_spikes") { }

    class spell_pursuing_spikesAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_pursuing_spikesAuraScript)

        void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
        {
            if( Unit* target = GetTarget() )
            {
                if( Creature* c = target->FindNearestCreature(NPC_FROST_SPHERE, 8.0f, true) )
                {
                    target->UpdatePosition(*c, false);
                    target->CastCustomSpell(SPELL_SPIKE_FAIL, SPELLVALUE_MAX_TARGETS, 1);
                    if( target->GetTypeId() == TYPEID_UNIT )
                        target->ToCreature()->AI()->DoAction(-1);
                    Remove();
                    return;
                }
                target->CastSpell((Unit*)nullptr, SPELL_IMPALE, true);
            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_pursuing_spikesAuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_pursuing_spikesAuraScript();
    }
};

// 66118 Leeching Swarm
enum eLeechingSwarmSpells
{
    SPELL_LEECHING_SWARM_DMG    = 66240,
    SPELL_LEECHING_SWARM_HEAL   = 66125,
};

class spell_gen_leeching_swarm : public SpellScriptLoader
{
public:
    spell_gen_leeching_swarm() : SpellScriptLoader("spell_gen_leeching_swarm") { }

    class spell_gen_leeching_swarm_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_gen_leeching_swarm_AuraScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo({ SPELL_LEECHING_SWARM_DMG, SPELL_LEECHING_SWARM_HEAL });
        }

        void HandleEffectPeriodic(AuraEffect const* aurEff)
        {
            if (Unit* caster = GetCaster())
            {
                int32 lifeLeeched = GetTarget()->CountPctFromCurHealth(aurEff->GetAmount());
                if (lifeLeeched < 250)
                    lifeLeeched = 250;
                // Damage
                caster->CastCustomSpell(GetTarget(), SPELL_LEECHING_SWARM_DMG, &lifeLeeched, 0, 0, true);
                // Heal is handled in damage spell. It has to heal the same amount, but some of the dmg can be resisted.
            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_gen_leeching_swarm_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_gen_leeching_swarm_AuraScript();
    }
};

class spell_gen_leeching_swarm_dmg : public SpellScriptLoader
{
public:
    spell_gen_leeching_swarm_dmg() : SpellScriptLoader("spell_gen_leeching_swarm_dmg") {}

    class spell_gen_leeching_swarm_dmg_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_gen_leeching_swarm_dmg_SpellScript);

        void HandleAfterHit()
        {
            if (Unit* caster = GetCaster())
                if (GetHitDamage() > 0)
                {
                    int32 damage = GetHitDamage();
                    caster->CastCustomSpell(caster, SPELL_LEECHING_SWARM_HEAL, &damage, 0, 0, true);
                }
        }

        void Register() override
        {
            AfterHit += SpellHitFn(spell_gen_leeching_swarm_dmg_SpellScript::HandleAfterHit);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_gen_leeching_swarm_dmg_SpellScript();
    }
};

void AddSC_boss_anubarak_trial()
{
    new boss_anubarak_trial();
    new npc_swarm_scarab();
    new npc_frost_sphere();
    new npc_nerubian_burrower();
    new npc_anubarak_spike();
    new spell_pursuing_spikes();
    new spell_gen_leeching_swarm();
    new spell_gen_leeching_swarm_dmg();
}
