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
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "naxxramas.h"

enum Spells
{

    SPELL_WEB_WRAP_KILL_WEBS = 52512,

    SPELL_WEB_WRAP_INIT          = 28673,

    SPELL_WEB_WRAP_200          = 28618, // 200 Pull speed
    SPELL_WEB_WRAP_300          = 28619,
    SPELL_WEB_WRAP_400          = 28620,
    SPELL_WEB_WRAP_500          = 28621,
    SPELL_WEB_SPRAY_10                  = 29484,
    SPELL_WEB_SPRAY_25                  = 54125,
    SPELL_POISON_SHOCK_10               = 28741,
    SPELL_POISON_SHOCK_25               = 54122,
    SPELL_NECROTIC_POISON_10            = 54121,
    SPELL_NECROTIC_POISON_25            = 28776,
    SPELL_FRENZY_10                     = 54123,
    SPELL_FRENZY_25                     = 54124,
    SPELL_WEB_WRAP_STUN                 = 28622, // STUN Triggered by spells
    SPELL_WEB_WRAP_SUMMON                 = 28627,
    SPELL_WEB_WRAP_SCRIPT_EFFECT_10 = 28673, // SCRIPT_EFFECT 0, INIT
    SPELL_WEB_WRAP_SCRIPT_EFFECT_25 = 54127, // SCRIPT_EFFECT 0, INIT
    SPELL_SUMMON_SPIDERLINGS_10 = 54130, // DOES NOT EXIST IN WRATH, 29434 1.12
    SPELL_SUMMON_SPIDERLINGS_25 = 29434, // DOES NOT EXIST, CUSTOM
};

enum Events
{
    EVENT_WEB_SPRAY                     = 1,
    EVENT_POISON_SHOCK                  = 2,
    EVENT_NECROTIC_POISON               = 3,
    EVENT_WEB_WRAP                      = 4,
    EVENT_HEALTH_CHECK                  = 5,
    EVENT_SUMMON_SPIDERLINGS            = 6
};

enum Emotes
{
    EMOTE_SPIDERS                       = 0,
    EMOTE_WEB_WRAP                      = 1,
    EMOTE_WEB_SPRAY                     = 2
};

enum Misc
{
    NPC_WEB_WRAP                        = 16486,
    NPC_MAEXXNA_SPIDERLING              = 17055,
    NPC_WEB_WRAP_TRIGGER                = 15384
};

    // {3546.796f, -3869.082f, 296.450f, 0.0f},
    // {3531.271f, -3847.424f, 299.450f, 0.0f},
    // {3497.067f, -3843.384f, 302.384f, 0.0f}

const Position PosWrap[8] =
{
    {3562.40f, -3890.35f, 314.30f, 0.0f},
    {3560.78f, -3878.10f, 316.18f, 0.0f},
    {3554.95f, -3863.24f, 314.46f, 0.0f},
    {3549.02f, -3855.07f, 311.58f, 0.0f},
    {3538.34f, -3844.68f, 314.21f, 0.0f},
    {3526.43f, -3838.73f, 317.10f, 0.0f},
    {3507.84f, -3832.71f, 319.00f, 0.0f},
    {3493.35f, -3834.06f, 318.71f, 0.0f}
};

struct WebTargetSelector
{
    WebTargetSelector(Unit* maexxna) : _maexxna(maexxna) {}
    bool operator()(Unit const* target) const
    {
        if (target->GetTypeId() != TYPEID_PLAYER) // never web nonplayers (pets, guardians, etc.)
            return false;
        if (_maexxna->GetVictim() == target) // never target tank
            return false;
        if (target->HasAura(SPELL_WEB_WRAP_STUN)) // never target targets that are already webbed
            return false;
        return true;
    }

    private:
        Unit const* _maexxna;
};


class boss_maexxna : public CreatureScript
{
public:
    boss_maexxna() : CreatureScript("boss_maexxna") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_maexxnaAI>(pCreature);
    }

    struct boss_maexxnaAI : public BossAI
    {
        explicit boss_maexxnaAI(Creature* c) : BossAI(c, BOSS_MAEXXNA), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        std::vector<std::pair<uint32, ObjectGuid>> wraps;
        std::vector<std::pair<uint32, ObjectGuid>> wraps2;

        bool IsInRoom()
        {
            if (me->GetExactDist(3486.6f, -3890.6f, 291.8f) > 100.0f)
            {
                EnterEvadeMode();
                return false;
            }
            return true;
        }

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_MAEXXNA_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_WEB_WRAP, 5s); // 20-20, repeat 40-40
            //events.ScheduleEvent(EVENT_WEB_WRAP, 20s); // 20-20, repeat 40-40
            //events.ScheduleEvent(EVENT_WEB_SPRAY, 40s); // 40-40, repeat 40-40
            //events.ScheduleEvent(EVENT_POISON_SHOCK, 10s); // 10-20, repeat 10-20
            //events.ScheduleEvent(EVENT_NECROTIC_POISON, 5s); // 20-30, repeat 10-30
            //events.ScheduleEvent(EVENT_HEALTH_CHECK, 1s);
            //events.ScheduleEvent(EVENT_SUMMON_SPIDERLINGS, 30s); // 30, repeat 40-40
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_MAEXXNA_GATE)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
            }
        }

        void JustSummoned(Creature* cr) override
        {
            if (cr->GetEntry() == NPC_MAEXXNA_SPIDERLING)
            {
                cr->SetInCombatWithZone();
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                {
                    cr->AI()->AttackStart(target);
                }
            }
            summons.Summon(cr);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER && pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
        }

        bool DoCastWebWrap()
        {

            std::list<Unit*> candidates;
            SelectTargetList(candidates, RAID_MODE(1, 2), SelectTargetMethod::Random, 1, WebTargetSelector(me));

            if (candidates.empty())
                return false;


            for (uint i = 0; i < candidates.size() ; i++)
            {
                const Position &randomPos = PosWrap[urand(0,7)];

                auto candIt = candidates.begin();

                if (candidates.size() > 1)
                    std::advance(candIt, urand(0, candidates.size() - 1));

                Unit *target = *candIt;
                candIt = candidates.erase(candIt);

                float dx = target->GetPositionX() - randomPos.GetPositionX();
                float dy = target->GetPositionY() - randomPos.GetPositionY();
                float dist = sqrt((dx * dx) + (dy * dy));
                float yDist = randomPos.GetPositionZ() - target->GetPositionZ();

                // todo: to avoid ever hitting the overhanging ceiling we would need to adjust the horizontal
                // velocity based on how close we are to it. If we are close initially, reduce the travel-time
                // by increasing horizontal velocity, in which case we won't need as much vertical velocity, thus
                // won't hit the ceiling.
                // s=ut+(0.5a*t^2) || s = vertical speed, u = initial up velocity, a = gravity factor(negative), t = time of flight
                // sadly this only aproximates some parts of this formula
                float horizontalSpeed = dist / 1.5f;
                float verticalSpeed = 20.0f + (yDist * 0.5f);
                float angle = target->GetAngle(randomPos.GetPositionX(), randomPos.GetPositionY());

                // set immune anticheat and calculate speed
                if (Player *plr = target->ToPlayer())
                {
                    // plr->SetLaunched(true);
                    // plr->SetXYSpeed(horizontalSpeed);
                }

                target->KnockbackFrom(randomPos.GetPositionX(), randomPos.GetPositionY(), horizontalSpeed, verticalSpeed);
                // target->GetMotionMaster()->MoveJump(PosWrap[pos].GetPositionX(), PosWrap[pos].GetPositionY(), PosWrap[pos].GetPositionZ(), 20, 20);

                wraps.push_back(std::make_pair(uint32(2000), target->GetGUID()));

                auto candIt = candidates.begin();

                if(candidates.size() > 1)
                    std::advance(candIt, urand(0, candidates.size() - 1));

                Unit* target = *candIt;
                candIt = candidates.erase(candIt);

                float dx = target->GetPositionX() - PosWrap[i].GetPositionX();
                float dy = target->GetPositionY() - PosWrap[i].GetPositionY();
                float dist = sqrt((dx * dx) + (dy * dy));
                float yDist = PosWrap[i].GetPositionZ() - target->GetPositionZ();

                // todo: to avoid ever hitting the overhanging ceiling we would need to adjust the horizontal
                // velocity based on how close we are to it. If we are close initially, reduce the travel-time
                // by increasing horizontal velocity, in which case we won't need as much vertical velocity, thus
                // won't hit the ceiling.
                //s=ut+(0.5a*t^2) || s = vertical speed, u = initial up velocity, a = gravity factor(negative), t = time of flight
                // sadly this only aproximates some parts of this formula
                float horizontalSpeed = dist/1.5f;
                float verticalSpeed = 20.0f + (yDist*0.5f);
                float angle = target->GetAngle(PosWrap[i].GetPositionX(), PosWrap[i].GetPositionY());

                // set immune anticheat and calculate speed
                if (Player* plr = target->ToPlayer())
                {
                    // plr->SetLaunched(true);
                    // plr->SetXYSpeed(horizontalSpeed);
                }

                target->KnockbackFrom(PosWrap[i].GetPositionX(), PosWrap[i].GetPositionY(), horizontalSpeed, verticalSpeed);
                // target->GetMotionMaster()->MoveJump(PosWrap[pos].GetPositionX(), PosWrap[pos].GetPositionY(), PosWrap[pos].GetPositionZ(), 20, 20);

                wraps.push_back(std::make_pair(uint32(2000), target->GetGUID()));
            }

        return true;
    }

void UpdateWraps(uint32 uiDiff)
    {
        bool wdone = false;
        for (auto& p : wraps2)
        {
            if (p.first < uiDiff)
            {
                if (Player* pl = ObjectAccessor::GetPlayer(*me, p.second))
                {
                    pl->SummonCreature(NPC_WEB_WRAP, pl->GetPositionX(), pl->GetPositionY(), pl->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 57000);
                }
                wdone = true;
            }
            else
                p.first -= uiDiff;
        }

        if (wdone)
            wraps2.clear();

        wdone = false;
        for (auto& p : wraps)
        {
            if (p.first < uiDiff)
            {
                if (Player* pl = ObjectAccessor::GetPlayer(*me, p.second))
                {
                    pl->CastSpell(pl, SPELL_WEB_WRAP_STUN, true);
                    wraps2.push_back(std::make_pair(3000, p.second));
                }
                wdone = true;
            }
            else
                p.first -= uiDiff;
        }
        if (wdone)
            wraps.clear();
    }

        void UpdateAI(uint32 diff) override
        {
            if (!IsInRoom())
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_WEB_SPRAY:
                    Talk(EMOTE_WEB_SPRAY);
                    me->CastSpell(me, RAID_MODE(SPELL_WEB_SPRAY_10, SPELL_WEB_SPRAY_25), true);
                    events.Repeat(40s);
                    break;
                case EVENT_POISON_SHOCK:
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_POISON_SHOCK_10, SPELL_POISON_SHOCK_25), false);
                    events.Repeat(10s);
                    break;
                case EVENT_NECROTIC_POISON:
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_NECROTIC_POISON_10, SPELL_NECROTIC_POISON_25), false);
                    events.Repeat(30s);
                    break;
                case EVENT_SUMMON_SPIDERLINGS:
                    Talk(EMOTE_SPIDERS);
                    for (uint8 i = 0; i < 8; ++i)
                    {
                        me->SummonCreature(NPC_MAEXXNA_SPIDERLING, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                    }
                    events.Repeat(40s);
                    break;
                case EVENT_HEALTH_CHECK:
                    if (me->GetHealthPct() < 30)
                    {
                        me->CastSpell(me, RAID_MODE(SPELL_FRENZY_10, SPELL_FRENZY_25), true);
                        break;
                    }
                    events.Repeat(1s);
                    break;
                case EVENT_WEB_WRAP:
                    Talk(EMOTE_WEB_WRAP);
                    DoCastWebWrap();
                    //me->CastSpell(me, SPELL_WEB_WRAP_INIT, true);
                    events.Repeat(40s);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class boss_maexxna_webwrap_trigger : public CreatureScript
{
public:
    boss_maexxna_webwrap_trigger() : CreatureScript("boss_maexxna_webwrap_trigger") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_maexxna_webwrap_triggerAI>(pCreature);
    }

    struct boss_maexxna_webwrap_triggerAI : public NullCreatureAI
    {
        explicit boss_maexxna_webwrap_triggerAI(Creature* c) : NullCreatureAI(c) {}

        ObjectGuid victimGUID;

        void SetGUID(ObjectGuid guid, int32  /*param*/) override
        {
            victimGUID = guid;

            if (Unit* victim = ObjectAccessor::GetUnit(*me, victimGUID))
            {
                float dist = me->GetDistance(victim);
                uint32 duration = 4000;
                if (dist <= 20.f)
                    duration = 1000;
                else if (dist <= 30.f)
                    duration = 2000;
                else if (dist <= 40.f)
                    duration = 3000;
                me->CastCustomSpell(SPELL_WEB_WRAP_200, SPELLVALUE_AURA_DURATION, duration, victim, true);
            }
        }
    };
};


class boss_maexxna_webwrap : public CreatureScript
{
public:
    boss_maexxna_webwrap() : CreatureScript("boss_maexxna_webwrap") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_maexxna_webwrapAI>(pCreature);
    }

    struct boss_maexxna_webwrapAI : public ScriptedAI
    {
        explicit boss_maexxna_webwrapAI(Creature* c) : ScriptedAI(c) { }

        ObjectGuid victimGUID;

        // void Reset() override {
        //    me->KillSelf(10000);
        // }


        // void SetGUID(ObjectGuid guid, int32  /*param*/) override
        // {
        //     victimGUID = guid;
        //     if (Unit* victim = ObjectAccessor::GetUnit(*me, victimGUID))
        //     {
        //         float dist = me->GetDistance(victim);
        //         uint32 duration = 4000;
        //         if (dist <= 20.f)
        //             duration = 1000;
        //         else if (dist <= 30.f)
        //             duration = 2000;
        //         else if (dist <= 40.f)
        //             duration = 3000;
        //         me->CastCustomSpell(SPELL_WEB_WRAP_200, SPELLVALUE_AURA_DURATION, duration, victim, true);
        //     }
        // }

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner)
                return;

            victimGUID = summoner->GetGUID();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (victimGUID)
            {
                if (Unit* victim = ObjectAccessor::GetUnit(*me, victimGUID))
                {
                    if (victim->IsAlive())
                    {
                        victim->RemoveAurasDueToSpell(SPELL_WEB_WRAP_STUN);
                        // victim->RemoveAurasDueToSpell(SPELL_WEB_WRAP_SUMMON);
                    }
                    victim->RestoreDisplayId();
                }
            }
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (victimGUID)
            {
                if (Unit* victim = ObjectAccessor::GetUnit(*me, victimGUID))
                {
                    if (!victim->IsAlive())
                    {
                        me->CastSpell(me, SPELL_WEB_WRAP_KILL_WEBS, true);
                    }
                }
            }
        }

    };
};


//class spell_web_wrap_maexxna : public SpellScriptLoader
//{
//public:
//    spell_web_wrap_maexxna() : SpellScriptLoader("spell_web_wrap_maexxna") { }
//
//    class spell_web_wrap_maexxna_SpellScript : public SpellScript
//    {
//        PrepareSpellScript(spell_web_wrap_maexxna_SpellScript);
//
//        void HandleScriptEffect(SpellEffIndex effIndex)
//        {
//            PreventHitDefaultEffect(effIndex);
//            for (uint8 i = 0; i < RAID_MODE(1, 2); ++i)
//            {
//                // TODO: this can select the same target twice
//                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 0, true, true, -SPELL_WEB_WRAP_STUN))
//                {
//                    std::list<Creature*> triggers;
//                    // TODO: This list should be saved OnAggro and range 100.0f
//                    me->GetCreatureListWithEntryInGrid(triggers, NPC_WEB_WRAP_TRIGGER, 150.0f);
//                    if (!triggers.empty())
//                    {
//                        std::list<Creature*>::iterator itr = triggers.begin();
//                        std::advance(itr, urand(0, triggers.size() - 1));
//
//                        Creature* triggerNPC;
//                        triggerNPC = *itr;
//
//                        triggers.erase(std::remove(triggers.begin(), triggers.end(), triggerNPC), triggers.end());
//
//
//                        float dist = me->GetDistance(target);
//                        uint32 spellId = SPELL_WEB_WRAP_500;
//                        if (dist <= 20.f)
//                            spellId = SPELL_WEB_WRAP_200;
//                        else if (dist <= 30.f)
//                            spellId = SPELL_WEB_WRAP_300;
//                        else if (dist <= 40.f)
//                            spellId = SPELL_WEB_WRAP_400;
//                        //triggerNPC->CastCustomSpell(SPELL_WEB_WRAP_200, SPELLVALUE_AURA_DURATION, 1000, target, true);
//                        //triggerNPC->CastSpell(target, spellId, true);
//                        triggerNPC->CastSpell(target, spellId, true); // 4 seconds
//
//
//                        //triggerNPC->AI()->SetGUID(target->GetGUID());
//
//                        //target->RemoveAura(RAID_MODE(SPELL_WEB_SPRAY_10, SPELL_WEB_SPRAY_25));
//                        //uint8 pos = urand(0, 2);
//                        //if (Creature* wrap = me->SummonCreature(NPC_WEB_WRAP, PosWrap[pos].GetPositionX(), PosWrap[pos].GetPositionY(), PosWrap[pos].GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
//                        //{
//                        //    wrap->AI()->SetGUID(target->GetGUID());
//                        //    target->GetMotionMaster()->MoveJump(PosWrap[pos].GetPositionX(), PosWrap[pos].GetPositionY(), PosWrap[pos].GetPositionZ(), 20, 20);
//                        //}
//
//
//                    }
//
//                }
//            }
//
//        }
//
//        void Register() override
//        {
//            OnEffectHitTarget += SpellEffectFn(spell_web_wrap_maexxna_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
//        }
//    };
//
//    SpellScript* GetSpellScript() const override
//    {
//        return new spell_web_wrap_maexxna_SpellScript();
//    }
//};
//
//
// class spell_web_wrap_damage : public SpellScriptLoader
// {
// public:
    // spell_web_wrap_damage() : SpellScriptLoader("spell_web_wrap_damage") { }
//
    // class spell_web_wrap_damage_AuraScript : public AuraScript
    // {
        // PrepareAuraScript(spell_web_wrap_damage_AuraScript);
//
        // void OnPeriodic(AuraEffect const* aurEff)
        // {
            // if (aurEff->GetTickNumber() == 2)
            // {
                // GetTarget()->CastSpell(GetTarget(), SPELL_WEB_WRAP_SUMMON, true);
            // }
//
        // }
//
        // void Register() override
        // {
            // OnEffectPeriodic += AuraEffectPeriodicFn(spell_web_wrap_damage_AuraScript::OnPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
        // }
    // };
//
    // AuraScript* GetAuraScript() const override
    // {
        // return new spell_web_wrap_damage_AuraScript();
    // }
// };

void AddSC_boss_maexxna()
{
    new boss_maexxna();
    new boss_maexxna_webwrap();
    //new boss_maexxna_webwrap_trigger();
    //new spell_web_wrap_damage();
    //new spell_web_wrap_maexxna();
};


// class npc_gothik_trigger : public CreatureScript
// {
// public:
//     npc_gothik_trigger() : CreatureScript("npc_gothik_trigger") { }

//     CreatureAI* GetAI(Creature* creature) const override
//     {
//         return new npc_gothik_triggerAI(creature);
//     }

//     struct npc_gothik_triggerAI : public ScriptedAI
//     {
//         npc_gothik_triggerAI(Creature* creature) : ScriptedAI(creature) { creature->SetDisableGravity(true); }

//         void EnterEvadeMode(EvadeReason /*why*/) override {}
//         void UpdateAI(uint32 /*diff*/) override {}
//         void JustEngagedWith(Unit* /*who*/) override {}
//         void DamageTaken(Unit* /*who*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override { damage = 0; }

//         Creature* SelectRandomSkullPile()
//         {
//             std::list<Creature*> triggers;
//             me->GetCreatureListWithEntryInGrid(triggers, NPC_TRIGGER, 150.0f);
//             // Remove triggers that are on live side or soul triggers on the platform
//             triggers.remove_if([](Creature *trigger){
//                 return ((trigger->GetPositionY() < POS_Y_GATE) || (trigger->GetPositionZ() > 280.0f));
//                 });
//             if (!triggers.empty())
//             {
//                 std::list<Creature*>::iterator itr = triggers.begin();
//                 std::advance(itr, urand(0, triggers.size() - 1));
//                 return *itr;
//             }
//             return nullptr;
//         }
//         void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
//         {
//             if (!spell)
//             {
//                 return;
//             }

//             switch (spell->Id)
//             {
//                 case SPELL_ANCHOR_1_TRAINEE:
//                     DoCastAOE(SPELL_ANCHOR_2_TRAINEE, true);
//                     break;
//                 case SPELL_ANCHOR_1_DK:
//                     DoCastAOE(SPELL_ANCHOR_2_DK, true);
//                     break;
//                 case SPELL_ANCHOR_1_RIDER:
//                     DoCastAOE(SPELL_ANCHOR_2_RIDER, true);
//                     break;
//                 case SPELL_ANCHOR_2_TRAINEE:
//                     if (Creature* target = SelectRandomSkullPile())
//                     {
//                         DoCast(target, SPELL_SKULLS_TRAINEE, true);
//                     }
//                     break;
//                 case SPELL_ANCHOR_2_DK:
//                     if (Creature* target = SelectRandomSkullPile())
//                     {
//                         DoCast(target, SPELL_SKULLS_DK, true);
//                     }
//                     break;
//                 case SPELL_ANCHOR_2_RIDER:
//                     if (Creature* target = SelectRandomSkullPile())
//                     {
//                         DoCast(target, SPELL_SKULLS_RIDER, true);
//                     }
//                     break;
//                 case SPELL_SKULLS_TRAINEE:
//                     DoSummon(NPC_DEAD_TRAINEE, me, 0.0f, 15 * IN_MILLISECONDS, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
//                     break;
//                 case SPELL_SKULLS_DK:
//                     DoSummon(NPC_DEAD_KNIGHT, me, 0.0f, 15 * IN_MILLISECONDS, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
//                     break;
//                 case SPELL_SKULLS_RIDER:
//                     DoSummon(NPC_DEAD_RIDER, me, 0.0f, 15 * IN_MILLISECONDS, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
//                     DoSummon(NPC_DEAD_HORSE, me, 0.0f, 15 * IN_MILLISECONDS, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
//                     break;
//             }
//         }

//         // dead side summons are "owned" by gothik
//         void JustSummoned(Creature* summon) override
//         {
//             if (Creature* gothik = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(DATA_GOTHIK_BOSS)))
//             {
//                 gothik->AI()->JustSummoned(summon);
//             }
//         }
//         void SummonedCreatureDespawn(Creature* summon) override
//         {
//             if (Creature* gothik = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(DATA_GOTHIK_BOSS)))
//             {
//                 gothik->AI()->SummonedCreatureDespawn(summon);
//             }
//         }
//     };
// };
