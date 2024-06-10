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

#include "AccountMgr.h"
#include "AchievementCriteriaScript.h"
#include "BanMgr.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "WorldSession.h"
#include "ulduar.h"

enum VezaxSpellData
{
    SPELL_VEZAX_BERSERK                         = 26662,

    SPELL_VEZAX_SHADOW_CRASH                    = 62660,
    SPELL_VEZAX_SHADOW_CRASH_DMG                = 62659,
    SPELL_VEZAX_SHADOW_CRASH_AREA_AURA          = 63277,
    SPELL_VEZAX_SHADOW_CRASH_AURA               = 65269,

    SPELL_SEARING_FLAMES                        = 62661,

    SPELL_SURGE_OF_DARKNESS                     = 62662,

    SPELL_MARK_OF_THE_FACELESS_AURA             = 63276,
    SPELL_MARK_OF_THE_FACELESS_EFFECT           = 63278,

    SPELL_AURA_OF_DESPAIR_1                     = 62692,
    SPELL_AURA_OF_DESPAIR_2                     = 64848,
    SPELL_CORRUPTED_RAGE                        = 68415,
    SPELL_CORRUPTED_WISDOM                      = 64646,
    SPELL_SHAMANISTIC_RAGE                      = 30823,
    SPELL_JUDGEMENTS_OF_THE_WISDOM_RANK_1       = 31876,

    SPELL_SUMMON_SARONITE_VAPORS                = 63081,
    NPC_SARONITE_VAPORS                         = 33488,
    SPELL_SARONITE_VAPORS_DMG                   = 63338,
    SPELL_SARONITE_VAPORS_ENERGIZE              = 63337,
    SPELL_SARONITE_VAPORS_AURA                  = 63323,
    SPELL_SARONITE_VAPORS_DUMMYAURA             = 63322,

    SPELL_SARONITE_ANIMUS_FORMATION_VISUAL      = 63319,
    SPELL_SUMMON_SARONITE_ANIMUS                = 63145,
    SPELL_SARONITE_BARRIER                      = 63364,
    SPELL_PROFOUND_DARKNESS                     = 63420,
};

enum VezaxNpcs
{
    // NPC_VEZAX                                = 33271,
    // NPC_VEZAX_BUNNY                          = 33500,
    NPC_SARONITE_ANIMUS                         = 33524,
};

enum VezaxGOs
{
    // GO_VEZAX_DOOR                            = 194750,
};

enum VezaxEvents
{
    EVENT_SPELL_VEZAX_SHADOW_CRASH              = 1,
    EVENT_SPELL_SEARING_FLAMES                  = 2,
    EVENT_SPELL_SURGE_OF_DARKNESS               = 3,
    EVENT_SPELL_MARK_OF_THE_FACELESS            = 4,
    EVENT_SPELL_SUMMON_SARONITE_VAPORS          = 5,
    EVENT_SARONITE_VAPORS_SWIRL                 = 6,
    EVENT_SPELL_SUMMON_SARONITE_ANIMUS          = 7,
    EVENT_DESPAWN_SARONITE_VAPORS               = 8,
    EVENT_SPELL_PROFOUND_DARKNESS               = 9,
    EVENT_BERSERK                               = 10,
    EVENT_RESTORE_TARGET                        = 11,
};

enum VezaxText
{
    SAY_AGGRO                            = 0,
    SAY_SLAY                             = 1,
    SAY_SURGE_OF_DARKNESS                = 2,
    SAY_DEATH                            = 3,
    SAY_BERSERK                          = 4,
    SAY_HARDMODE                         = 5,
    SAY_EMOTE_ANIMUS                     = 6,
    SAY_EMOTE_BARRIER                    = 7,
    SAY_EMOTE_SURGE_OF_DARKNESS          = 8,
};

enum VaporsText
{
    SAY_EMOTE_VAPORS    = 0,
};

class boss_vezax : public CreatureScript
{
public:
    boss_vezax() : CreatureScript("boss_vezax") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_vezaxAI>(pCreature);
    }

    struct boss_vezaxAI : public ScriptedAI
    {
        boss_vezaxAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        uint8 vaporsCount;
        bool hardmodeAvailable;
        bool berserk;
        bool bAchievShadowdodger;

        InstanceScript* pInstance;

        void Reset() override
        {
            vaporsCount = 0;
            hardmodeAvailable = true;
            berserk = false;
            bAchievShadowdodger = true;
            events.Reset();
            summons.DespawnAll();
            me->SetLootMode(1);

            if (pInstance)
                pInstance->SetData(TYPE_VEZAX, NOT_STARTED);
        }

        void JustReachedHome() override
        {
            me->setActive(false);
        }

        void JustEngagedWith(Unit*  /*pWho*/) override
        {
            me->setActive(true);
            me->SetInCombatWithZone();

            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_VEZAX_SHADOW_CRASH, 13s);
            events.RescheduleEvent(EVENT_SPELL_SEARING_FLAMES, 10s, 1);
            events.RescheduleEvent(EVENT_SPELL_SURGE_OF_DARKNESS, 63s);
            events.RescheduleEvent(EVENT_SPELL_MARK_OF_THE_FACELESS, 20s);
            events.RescheduleEvent(EVENT_SPELL_SUMMON_SARONITE_VAPORS, 30s);
            events.RescheduleEvent(EVENT_BERSERK, 10min);

            Talk(SAY_AGGRO);

            if (pInstance)
                pInstance->SetData(TYPE_VEZAX, IN_PROGRESS);

            me->CastSpell(me, SPELL_AURA_OF_DESPAIR_1, true);
        }

        void DoAction(int32 param) override
        {
            switch( param )
            {
                case 1:
                    hardmodeAvailable = false;
                    break;
                case 2:
                    me->RemoveAura(SPELL_SARONITE_BARRIER);
                    me->SetLootMode(3);
                    break;
            }
        }

        uint32 GetData(uint32 id) const override
        {
            switch (id)
            {
                case 1:
                    return (me->GetLootMode() == 3 ? 1 : 0);
                case 2:
                    return (bAchievShadowdodger ? 1 : 0);
            }
            return 0;
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (target && spell && target->GetTypeId() == TYPEID_PLAYER && spell->Id == SPELL_VEZAX_SHADOW_CRASH_DMG)
                bAchievShadowdodger = false;
        }

        void UpdateAI(uint32 diff) override
        {
            if( !UpdateVictim() )
                return;

            if( !berserk && (me->GetPositionX() < 1720.0f || me->GetPositionX() > 1940.0f || me->GetPositionY() < 20.0f || me->GetPositionY() > 210.0f) )
                events.RescheduleEvent(EVENT_BERSERK, 1ms);

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.ExecuteEvent() )
            {
                case 0:
                    break;
                case EVENT_BERSERK:
                    berserk = true;
                    me->CastSpell(me, SPELL_VEZAX_BERSERK, true);
                    Talk(SAY_BERSERK);
                    break;
                case EVENT_SPELL_VEZAX_SHADOW_CRASH:
                    {
                        events.Repeat(10s);

                        std::vector<Player*> players;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                        {
                            Player* temp = itr->GetSource();
                            if( temp->IsAlive() && temp->GetDistance(me) > 15.0f )
                                players.push_back(temp);
                        }
                        if (!players.empty())
                        {
                            me->setAttackTimer(BASE_ATTACK, 2000);
                            Player* target = players.at(urand(0, players.size() - 1));
                            me->SetGuidValue(UNIT_FIELD_TARGET, target->GetGUID());
                            me->CastSpell(target, SPELL_VEZAX_SHADOW_CRASH, false);
                            events.ScheduleEvent(EVENT_RESTORE_TARGET, 750ms);
                        }
                    }
                    break;
                case EVENT_RESTORE_TARGET:
                    if (me->GetVictim())
                        me->SetGuidValue(UNIT_FIELD_TARGET, me->GetVictim()->GetGUID());
                    break;
                case EVENT_SPELL_SEARING_FLAMES:
                    if(!me->HasAura(SPELL_SARONITE_BARRIER))
                        me->CastSpell(me->GetVictim(), SPELL_SEARING_FLAMES, false);
                    events.Repeat(me->GetMap()->Is25ManRaid() ? 8s : 15s);
                    break;
                case EVENT_SPELL_SURGE_OF_DARKNESS:
                    Talk(SAY_SURGE_OF_DARKNESS);
                    Talk(SAY_EMOTE_SURGE_OF_DARKNESS);
                    me->CastSpell(me, SPELL_SURGE_OF_DARKNESS, false);
                    events.Repeat(63s);
                    events.DelayEvents(10000, 1);
                    break;
                case EVENT_SPELL_MARK_OF_THE_FACELESS:
                    {
                        std::vector<Player*> outside;
                        std::vector<Player*> inside;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                            if( Player* tmp = itr->GetSource() )
                                if( tmp->IsAlive() )
                                {
                                    if( tmp->GetDistance(me) > 15.0f )
                                        outside.push_back(tmp);
                                    else
                                        inside.push_back(tmp);
                                }

                        Player* t = nullptr;
                        if( outside.size() >= uint8(me->GetMap()->Is25ManRaid() ? 9 : 4) )
                            t = outside.at(urand(0, outside.size() - 1));
                        else if( !inside.empty() )
                            t = inside.at(urand(0, inside.size() - 1));

                        if (t)
                            me->CastSpell(t, SPELL_MARK_OF_THE_FACELESS_AURA, false);

                        events.Repeat(40s);
                    }
                    break;
                case EVENT_SPELL_SUMMON_SARONITE_VAPORS:
                    {
                        vaporsCount++;
                        me->CastSpell(me, SPELL_SUMMON_SARONITE_VAPORS, false);

                        if( vaporsCount < 6 || !hardmodeAvailable )
                            events.Repeat(30s);
                        else
                        {
                            for (ObjectGuid const& guid : summons)
                                if (Creature* sv = ObjectAccessor::GetCreature(*me, guid))
                                {
                                    sv->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                                    sv->GetMotionMaster()->MoveIdle();
                                    sv->GetMotionMaster()->MoveCharge(1852.78f, 81.38f, 342.461f, 28.0f);
                                }

                            events.DelayEvents(12000, 0);
                            events.DelayEvents(12000, 1);
                            events.ScheduleEvent(EVENT_SARONITE_VAPORS_SWIRL, 6s);
                        }
                    }
                    break;
                case EVENT_SARONITE_VAPORS_SWIRL:
                    if (summons.size())
                    {
                        Talk(SAY_EMOTE_ANIMUS);
                        if( Creature* sv = ObjectAccessor::GetCreature(*me, *(summons.begin())) )
                            sv->CastSpell(sv, SPELL_SARONITE_ANIMUS_FORMATION_VISUAL, true);

                        events.ScheduleEvent(EVENT_SPELL_SUMMON_SARONITE_ANIMUS, 2s);
                        break;
                    }
                    break;
                case EVENT_SPELL_SUMMON_SARONITE_ANIMUS:
                    if (summons.size())
                    {
                        Talk(SAY_HARDMODE);
                        Talk(SAY_EMOTE_BARRIER);
                        me->CastSpell(me, SPELL_SARONITE_BARRIER, true);
                        if( Creature* sv = ObjectAccessor::GetCreature(*me, *(summons.begin())) )
                            sv->CastSpell(sv, SPELL_SUMMON_SARONITE_ANIMUS, true);

                        events.ScheduleEvent(EVENT_DESPAWN_SARONITE_VAPORS, 2500ms);
                        break;
                    }
                    break;
                case EVENT_DESPAWN_SARONITE_VAPORS:
                    summons.DespawnEntry(NPC_SARONITE_VAPORS);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*killer*/) override
        {
            summons.DespawnAll();
            if (pInstance)
                pInstance->SetData(TYPE_VEZAX, DONE);

            Talk(SAY_DEATH);

            if( GameObject* door = me->FindNearestGameObject(GO_VEZAX_DOOR, 500.0f) )
                if( door->GetGoState() != GO_STATE_ACTIVE )
                {
                    door->SetLootState(GO_READY);
                    door->UseDoorOrButton(0, false);
                }
        }

        void KilledUnit(Unit* who) override
        {
            if( who->GetTypeId() == TYPEID_PLAYER )
                Talk(SAY_SLAY);
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
        }

        void SummonedCreatureDespawn(Creature* s) override
        {
            summons.Despawn(s);
        }
    };
};

class npc_ulduar_saronite_vapors : public CreatureScript
{
public:
    npc_ulduar_saronite_vapors() : CreatureScript("npc_ulduar_saronite_vapors") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_saronite_vaporsAI>(pCreature);
    }

    struct npc_ulduar_saronite_vaporsAI : public NullCreatureAI
    {
        npc_ulduar_saronite_vaporsAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->GetMotionMaster()->MoveRandom(4.0f);
        }

        InstanceScript* pInstance;

        void JustDied(Unit*  /*killer*/) override
        {
            me->CastSpell(me, SPELL_SARONITE_VAPORS_AURA, true);

            // killed saronite vapors, hard mode unavailable
            if( pInstance )
                if( Creature* vezax = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(TYPE_VEZAX)) )
                    vezax->AI()->DoAction(1);
        }

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            Talk(SAY_EMOTE_VAPORS);
        }
    };
};

class npc_ulduar_saronite_animus : public CreatureScript
{
public:
    npc_ulduar_saronite_animus() : CreatureScript("npc_ulduar_saronite_animus") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_saronite_animusAI>(pCreature);
    }

    struct npc_ulduar_saronite_animusAI : public ScriptedAI
    {
        npc_ulduar_saronite_animusAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            if( pInstance )
                if( Creature* vezax = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(TYPE_VEZAX)) )
                    vezax->AI()->JustSummoned(me);
            timer = 0;
            me->SetInCombatWithZone();
        }

        InstanceScript* pInstance;
        uint16 timer;

        void JustDied(Unit*  /*killer*/) override
        {
            me->DespawnOrUnsummon(3000);

            if( pInstance )
                if( Creature* vezax = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(TYPE_VEZAX)) )
                    vezax->AI()->DoAction(2);
        }

        void UpdateAI(uint32 diff) override
        {
            UpdateVictim();

            timer += diff;
            if (timer >= 2000)
            {
                me->CastSpell(me, SPELL_PROFOUND_DARKNESS, true);
                timer -= 2000;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_aura_of_despair_aura : public AuraScript
{
    PrepareAuraScript(spell_aura_of_despair_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_AURA_OF_DESPAIR_2, SPELL_CORRUPTED_RAGE, SPELL_CORRUPTED_WISDOM });
    }

    void OnApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes  /*mode*/)
    {
        if (Unit* caster = GetCaster())
            if (Unit* target = GetTarget())
            {
                if (target->GetTypeId() != TYPEID_PLAYER)
                    return;

                target->CastSpell(target, SPELL_AURA_OF_DESPAIR_2, true);
                if (target->HasSpell(SPELL_SHAMANISTIC_RAGE))
                    caster->CastSpell(target, SPELL_CORRUPTED_RAGE, true);
                else if (target->HasSpell(SPELL_JUDGEMENTS_OF_THE_WISDOM_RANK_1) || target->HasSpell(SPELL_JUDGEMENTS_OF_THE_WISDOM_RANK_1 + 1) || target->HasSpell(SPELL_JUDGEMENTS_OF_THE_WISDOM_RANK_1 + 2))
                    caster->CastSpell(target, SPELL_CORRUPTED_WISDOM, true);
            }
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
        {
            target->RemoveAurasDueToSpell(SPELL_AURA_OF_DESPAIR_2);
            target->RemoveAurasDueToSpell(SPELL_CORRUPTED_RAGE);
            target->RemoveAurasDueToSpell(SPELL_CORRUPTED_WISDOM);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_aura_of_despair_aura::OnApply, EFFECT_0, SPELL_AURA_PREVENT_REGENERATE_POWER, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_aura_of_despair_aura::OnRemove, EFFECT_0, SPELL_AURA_PREVENT_REGENERATE_POWER, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_mark_of_the_faceless_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_mark_of_the_faceless_periodic_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MARK_OF_THE_FACELESS_EFFECT });
    }

    void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
    {
        if (Unit* caster = GetCaster())
            if (Unit* target = GetTarget())
                if (target->GetMapId() == 603)
                {
                    int32 dmg = 5000;
                    caster->CastCustomSpell(target, SPELL_MARK_OF_THE_FACELESS_EFFECT, 0, &dmg, 0, true);
                }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_mark_of_the_faceless_periodic_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_mark_of_the_faceless_drainhealth : public SpellScript
{
    PrepareSpellScript(spell_mark_of_the_faceless_drainhealth);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove(GetExplTargetUnit());
        if (targets.empty())
            Cancel();
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mark_of_the_faceless_drainhealth::FilterTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENEMY);
    }
};

class spell_saronite_vapors_dummy_aura : public AuraScript
{
    PrepareAuraScript(spell_saronite_vapors_dummy_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SARONITE_VAPORS_DMG });
    }

    void HandleAfterEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
        {
            int32 damage = 100 * pow(2.0f, (float)GetStackAmount());
            caster->CastCustomSpell(GetTarget(), SPELL_SARONITE_VAPORS_DMG, &damage, nullptr, nullptr, true);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_saronite_vapors_dummy_aura::HandleAfterEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

class spell_saronite_vapors_damage : public SpellScript
{
    PrepareSpellScript(spell_saronite_vapors_damage);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SARONITE_VAPORS_ENERGIZE });
    }

    void HandleAfterHit()
    {
        if (Unit* caster = GetCaster())
            if (GetHitDamage() > 2)
            {
                int32 mana = GetHitDamage() / 2;
                if (Unit* target = GetHitUnit())
                    caster->CastCustomSpell(target, SPELL_SARONITE_VAPORS_ENERGIZE, &mana, nullptr, nullptr, true);
            }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_saronite_vapors_damage::HandleAfterHit);
    }
};

class achievement_smell_saronite : public AchievementCriteriaScript
{
public:
    achievement_smell_saronite() : AchievementCriteriaScript("achievement_smell_saronite") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_VEZAX && target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->AI()->GetData(1);
    }
};

class achievement_shadowdodger : public AchievementCriteriaScript
{
public:
    achievement_shadowdodger() : AchievementCriteriaScript("achievement_shadowdodger") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_VEZAX && target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->AI()->GetData(2);
    }
};

class go_ulduar_pure_saronite_deposit : public GameObjectScript
{
public:
    go_ulduar_pure_saronite_deposit() : GameObjectScript("go_ulduar_pure_saronite_deposit") { }

    bool OnGossipHello(Player* plr, GameObject* go) override
    {
        if (plr->IsGameMaster())
            return false;

        if (InstanceScript* pInstance = go->GetInstanceScript())
            if (pInstance->GetData(TYPE_XT002) != DONE && pInstance->GetData(TYPE_MIMIRON) != DONE && pInstance->GetData(TYPE_THORIM) != DONE && pInstance->GetData(TYPE_FREYA) != DONE && pInstance->GetData(TYPE_HODIR) != DONE)
            {
                std::string accountName;
                AccountMgr::GetName(plr->GetSession()->GetAccountId(), accountName);
                sBan->BanAccount(accountName, "0s", "Tele hack", "Server");
                return true;
            }

        return false;
    }
};

void AddSC_boss_vezax()
{
    new boss_vezax();
    new npc_ulduar_saronite_vapors();
    new npc_ulduar_saronite_animus();

    RegisterSpellScript(spell_aura_of_despair_aura);
    RegisterSpellScript(spell_mark_of_the_faceless_periodic_aura);
    RegisterSpellScript(spell_mark_of_the_faceless_drainhealth);
    RegisterSpellScript(spell_saronite_vapors_dummy_aura);
    RegisterSpellScript(spell_saronite_vapors_damage);

    new achievement_smell_saronite();
    new achievement_shadowdodger();

    new go_ulduar_pure_saronite_deposit();
}
