/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "ulduar.h"
#include "AccountMgr.h"
#include "PassiveAI.h"
#include "Player.h"
#include "WorldSession.h"
#include "BanManager.h"

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
    NPC_VEZAX_BUNNY                             = 33500,
    NPC_SARONITE_ANIMUS                         = 33524,
};

enum VezaxGOs
{
    // GO_VEZAX_DOOR                            = 194750,
};

enum VezaxSounds
{
    SOUND_VEZAX_AGGRO                           = 15542,
    SOUND_VEZAX_SLAIN_1                         = 15543,
    SOUND_VEZAX_SLAIN_2                         = 15544,
    SOUND_VEZAX_SURGE                           = 15545,
    SOUND_VEZAX_DEATH                           = 15546,
    SOUND_VEZAX_BERSERK                         = 15547,
    SOUND_VEZAX_HARDMODE                        = 15548,
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

#define TEXT_VEZAX_AGGRO                            "Your destruction will herald a new age of suffering!"
#define TEXT_VEZAX_SLAIN_1                          "You thought to stand before the legions of death... and survive?"
#define TEXT_VEZAX_SLAIN_2                          "Defiance... a flaw of mortality."
#define TEXT_VEZAX_SURGE                            "The black blood of Yogg-Saron courses through me! I. AM. UNSTOPPABLE!"
#define TEXT_VEZAX_BERSERK                          "Your defeat was inevitable!"
#define TEXT_VEZAX_DEATH                            "Oh, what horrors await...."
#define TEXT_VEZAX_HARDMODE                         "Behold, now! Terror, absolute!"


class boss_vezax : public CreatureScript
{
public:
    boss_vezax() : CreatureScript("boss_vezax") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_vezaxAI (pCreature);
    }

    struct boss_vezaxAI : public ScriptedAI
    {
        boss_vezaxAI(Creature *pCreature) : ScriptedAI(pCreature), summons(me)
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

        void Reset()
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

        void JustReachedHome()
        {
            me->setActive(false);
        }

        void EnterCombat(Unit*  /*pWho*/)
        {
            me->setActive(true);
            me->SetInCombatWithZone();

            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_VEZAX_SHADOW_CRASH, 13000);
            events.RescheduleEvent(EVENT_SPELL_SEARING_FLAMES, 10000, 1);
            events.RescheduleEvent(EVENT_SPELL_SURGE_OF_DARKNESS, 63000);
            events.RescheduleEvent(EVENT_SPELL_MARK_OF_THE_FACELESS, 20000);
            events.RescheduleEvent(EVENT_SPELL_SUMMON_SARONITE_VAPORS, 30000);
            events.RescheduleEvent(EVENT_BERSERK, 600000);

            me->MonsterYell(TEXT_VEZAX_AGGRO, LANG_UNIVERSAL, 0);
            me->PlayDirectSound(SOUND_VEZAX_AGGRO, 0);

            if (pInstance)
                pInstance->SetData(TYPE_VEZAX, IN_PROGRESS);

            me->CastSpell(me, SPELL_AURA_OF_DESPAIR_1, true);
        }

        void DoAction(int32 param)
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

        uint32 GetData(uint32 id) const
        {
            switch (id)
            {
                case 1: return (me->GetLootMode() == 3 ? 1 : 0);
                case 2: return (bAchievShadowdodger == true ? 1 : 0);
            }
            return 0;
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spell)
        {
            if (target && spell && target->GetTypeId() == TYPEID_PLAYER && spell->Id == SPELL_VEZAX_SHADOW_CRASH_DMG)
                bAchievShadowdodger = false;
        }

        void UpdateAI(uint32 diff)
        {
            if( !UpdateVictim() )
                return;

            if( !berserk && (me->GetPositionX() < 1720.0f || me->GetPositionX() > 1940.0f || me->GetPositionY() < 20.0f || me->GetPositionY() > 210.0f) )
                events.RescheduleEvent(EVENT_BERSERK, 1);

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;
            
            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_BERSERK:
                    berserk = true;
                    me->CastSpell(me, SPELL_VEZAX_BERSERK, true);
                    me->MonsterYell(TEXT_VEZAX_BERSERK, LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(SOUND_VEZAX_BERSERK, 0);
                    events.PopEvent();
                    break;
                case EVENT_SPELL_VEZAX_SHADOW_CRASH:
                    {
                        events.RepeatEvent(10000);

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
                            Player* target = players.at(urand(0, players.size()-1));
                            me->SetUInt64Value(UNIT_FIELD_TARGET, target->GetGUID());
                            me->CastSpell(target, SPELL_VEZAX_SHADOW_CRASH, false);
                            events.ScheduleEvent(EVENT_RESTORE_TARGET, 750);
                        }
                    }
                    break;
                case EVENT_RESTORE_TARGET:
                    if (me->GetVictim())
                        me->SetUInt64Value(UNIT_FIELD_TARGET, me->GetVictim()->GetGUID());
                    events.PopEvent();
                    break;
                case EVENT_SPELL_SEARING_FLAMES:
                    if(!me->HasAura(SPELL_SARONITE_BARRIER))
                        me->CastSpell(me->GetVictim(), SPELL_SEARING_FLAMES, false);
                    events.RepeatEvent( me->GetMap()->Is25ManRaid() ? 8000 : 15000 );
                    break;
                case EVENT_SPELL_SURGE_OF_DARKNESS:
                    me->MonsterYell(TEXT_VEZAX_SURGE, LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(SOUND_VEZAX_SURGE, 0);
                    me->CastSpell(me, SPELL_SURGE_OF_DARKNESS, false);
                    events.RepeatEvent(63000);
                    events.DelayEvents(10000, 1);
                    break;
                case EVENT_SPELL_MARK_OF_THE_FACELESS:
                    {
                        std::vector<Player*> outside;
                        std::vector<Player*> inside;
                        Map::PlayerList const &pl = me->GetMap()->GetPlayers();
                            for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                                if( Player* tmp = itr->GetSource() )
                                    if( tmp->IsAlive() )
                                    {
                                        if( tmp->GetDistance(me) > 15.0f )
                                            outside.push_back(tmp);
                                        else
                                            inside.push_back(tmp);
                                    }

                        Player* t = NULL;
                        if( outside.size() >= uint8(me->GetMap()->Is25ManRaid() ? 9 : 4) )
                            t = outside.at(urand(0, outside.size()-1));
                        else if( !inside.empty() )
                            t = inside.at(urand(0, inside.size()-1));

                        if (t)
                            me->CastSpell(t, SPELL_MARK_OF_THE_FACELESS_AURA, false);

                        events.RepeatEvent(40000);
                    }
                    break;
                case EVENT_SPELL_SUMMON_SARONITE_VAPORS:
                    {
                        vaporsCount++;
                        me->CastSpell(me, SPELL_SUMMON_SARONITE_VAPORS, false);
                        me->MonsterTextEmote("A cloud of saronite vapors coalesces nearby!", 0, true);

                        if( vaporsCount < 6 || !hardmodeAvailable )
                            events.RepeatEvent(30000);
                        else
                        {
                            for( std::list<uint64>::iterator itr = summons.begin(); itr != summons.end(); ++itr )
                                if( Creature* sv = ObjectAccessor::GetCreature(*me, *itr) )
                                {
                                    sv->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                                    sv->GetMotionMaster()->MoveIdle();
                                    sv->GetMotionMaster()->MoveCharge(1852.78f, 81.38f, 342.461f, 28.0f);
                                }

                            events.PopEvent();
                            events.DelayEvents(12000, 0);
                            events.DelayEvents(12000, 1);
                            events.ScheduleEvent(EVENT_SARONITE_VAPORS_SWIRL, 6000);
                        }
                    }
                    break;
                case EVENT_SARONITE_VAPORS_SWIRL:
                    if (summons.size())
                    {
                        me->MonsterTextEmote("The saronite vapors mass and swirl violently, merging into a monstrous form!", 0, true);
                        if( Creature* sv = ObjectAccessor::GetCreature(*me, *(summons.begin())) )
                            sv->CastSpell(sv, SPELL_SARONITE_ANIMUS_FORMATION_VISUAL, true);

                        events.PopEvent();
                        events.ScheduleEvent(EVENT_SPELL_SUMMON_SARONITE_ANIMUS, 2000);
                        break;
                    }
                    events.PopEvent();
                    break;
                case EVENT_SPELL_SUMMON_SARONITE_ANIMUS:
                    if (summons.size())
                    {
                        me->MonsterTextEmote("A saronite barrier appears around General Vezax!", 0, true);
                        me->MonsterYell(TEXT_VEZAX_HARDMODE, LANG_UNIVERSAL, 0);
                        me->PlayDirectSound(SOUND_VEZAX_HARDMODE, 0);

                        me->CastSpell(me, SPELL_SARONITE_BARRIER, true);
                        if( Creature* sv = ObjectAccessor::GetCreature(*me, *(summons.begin())) )
                            sv->CastSpell(sv, SPELL_SUMMON_SARONITE_ANIMUS, true);

                        events.PopEvent();
                        events.ScheduleEvent(EVENT_DESPAWN_SARONITE_VAPORS, 2500);
                        break;
                    }
                    events.PopEvent();
                    break;
                case EVENT_DESPAWN_SARONITE_VAPORS:
                    summons.DespawnEntry(NPC_SARONITE_VAPORS);
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*killer*/)
        {
            summons.DespawnAll();
            if (pInstance)
                pInstance->SetData(TYPE_VEZAX, DONE);

            me->MonsterYell(TEXT_VEZAX_DEATH, LANG_UNIVERSAL, 0);
            me->PlayDirectSound(SOUND_VEZAX_DEATH, 0);

            if( GameObject* door = me->FindNearestGameObject(GO_VEZAX_DOOR, 500.0f) )
                if( door->GetGoState() != GO_STATE_ACTIVE )
                {
                    door->SetLootState(GO_READY);
                    door->UseDoorOrButton(0, false);
                }
        }

        void KilledUnit(Unit* who)
        {
            if( who->GetTypeId() == TYPEID_PLAYER )
            {
                if( urand(0,1) )
                {
                    me->MonsterYell(TEXT_VEZAX_SLAIN_1, LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(SOUND_VEZAX_SLAIN_1, 0);
                }
                else
                {
                    me->MonsterYell(TEXT_VEZAX_SLAIN_2, LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(SOUND_VEZAX_SLAIN_2, 0);
                }
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
        }

        void SummonedCreatureDespawn(Creature* s)
        {
            summons.Despawn(s);
        }
    };
};

class npc_ulduar_saronite_vapors : public CreatureScript
{
public:
    npc_ulduar_saronite_vapors() : CreatureScript("npc_ulduar_saronite_vapors") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_saronite_vaporsAI (pCreature);
    }

    struct npc_ulduar_saronite_vaporsAI : public NullCreatureAI
    {
        npc_ulduar_saronite_vaporsAI(Creature *pCreature) : NullCreatureAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            me->GetMotionMaster()->MoveRandom(4.0f);
        }

        InstanceScript* pInstance;

        void JustDied(Unit*  /*killer*/)
        {
            me->CastSpell(me, SPELL_SARONITE_VAPORS_AURA, true);

            // killed saronite vapors, hard mode unavailable
            if( pInstance )
                if( Creature* vezax = ObjectAccessor::GetCreature(*me, pInstance->GetData64(TYPE_VEZAX)) )
                    vezax->AI()->DoAction(1);
        }
    };
};

class npc_ulduar_saronite_animus : public CreatureScript
{
public:
    npc_ulduar_saronite_animus() : CreatureScript("npc_ulduar_saronite_animus") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_saronite_animusAI (pCreature);
    }

    struct npc_ulduar_saronite_animusAI : public ScriptedAI
    {
        npc_ulduar_saronite_animusAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = pCreature->GetInstanceScript();
            if( pInstance )
                if( Creature* vezax = ObjectAccessor::GetCreature(*me, pInstance->GetData64(TYPE_VEZAX)) )
                    vezax->AI()->JustSummoned(me);
            timer = 0;
            me->SetInCombatWithZone();
        }

        InstanceScript* pInstance;
        uint16 timer;

        void JustDied(Unit*  /*killer*/)
        {
            me->DespawnOrUnsummon(3000);

            if( pInstance )
                if( Creature* vezax = ObjectAccessor::GetCreature(*me, pInstance->GetData64(TYPE_VEZAX)) )
                    vezax->AI()->DoAction(2);
        }

        void UpdateAI(uint32 diff)
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

class spell_aura_of_despair : public SpellScriptLoader
{
public:
    spell_aura_of_despair() : SpellScriptLoader("spell_aura_of_despair") { }

    class spell_aura_of_despair_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_aura_of_despair_AuraScript)

        void OnApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes  /*mode*/)
        {
            if (Unit* caster = GetCaster())
                if (Unit* target = GetTarget())
                {
                    if (target->GetTypeId() != TYPEID_PLAYER)
                        return;

                    target->CastSpell(target, SPELL_AURA_OF_DESPAIR_2, true);
                    if( target->HasSpell(SPELL_SHAMANISTIC_RAGE) )
                        caster->CastSpell(target, SPELL_CORRUPTED_RAGE, true);
                    else if( target->HasSpell(SPELL_JUDGEMENTS_OF_THE_WISDOM_RANK_1) || target->HasSpell(SPELL_JUDGEMENTS_OF_THE_WISDOM_RANK_1+1) || target->HasSpell(SPELL_JUDGEMENTS_OF_THE_WISDOM_RANK_1+2) )
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

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_aura_of_despair_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PREVENT_REGENERATE_POWER, AURA_EFFECT_HANDLE_REAL);
            AfterEffectRemove += AuraEffectRemoveFn(spell_aura_of_despair_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PREVENT_REGENERATE_POWER, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_aura_of_despair_AuraScript();
    }
};

class spell_mark_of_the_faceless_periodic : public SpellScriptLoader
{
public:
    spell_mark_of_the_faceless_periodic() : SpellScriptLoader("spell_mark_of_the_faceless_periodic") { }

    class spell_mark_of_the_faceless_periodic_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mark_of_the_faceless_periodic_AuraScript)

        void HandleEffectPeriodic(AuraEffect const *  /*aurEff*/)
        {
            if (Unit* caster = GetCaster())
                if (Unit* target = GetTarget())
                    if (target->GetMapId() == 603)
                    {
                        int32 dmg = 5000;
                        caster->CastCustomSpell(target, SPELL_MARK_OF_THE_FACELESS_EFFECT, 0, &dmg, 0, true);
                    }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mark_of_the_faceless_periodic_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_mark_of_the_faceless_periodic_AuraScript();
    }
};

class spell_mark_of_the_faceless_drainhealth : public SpellScriptLoader
{
public:
    spell_mark_of_the_faceless_drainhealth() : SpellScriptLoader("spell_mark_of_the_faceless_drainhealth") { }

    class spell_mark_of_the_faceless_drainhealth_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_mark_of_the_faceless_drainhealth_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            targets.remove(GetExplTargetUnit());
            if (targets.empty())
                Cancel();
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_mark_of_the_faceless_drainhealth_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENEMY);
        }
    };

    SpellScript *GetSpellScript() const
    {
        return new spell_mark_of_the_faceless_drainhealth_SpellScript();
    }
};

class spell_saronite_vapors_dummy : public SpellScriptLoader
{
public:
    spell_saronite_vapors_dummy() : SpellScriptLoader("spell_saronite_vapors_dummy") { }

    class spell_saronite_vapors_dummy_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_saronite_vapors_dummy_AuraScript)

        void HandleAfterEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* caster = GetCaster())
            {
                int32 damage = 100*pow(2.0f, (float)GetStackAmount());
                caster->CastCustomSpell(GetTarget(), SPELL_SARONITE_VAPORS_DMG, &damage, NULL, NULL, true);
            }
        }

        void Register()
        {
            AfterEffectApply += AuraEffectApplyFn(spell_saronite_vapors_dummy_AuraScript::HandleAfterEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_saronite_vapors_dummy_AuraScript();
    }
};

class spell_saronite_vapors_damage : public SpellScriptLoader
{
public:
    spell_saronite_vapors_damage() : SpellScriptLoader("spell_saronite_vapors_damage") { }

    class spell_saronite_vapors_damage_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_saronite_vapors_damage_SpellScript);

        void HandleAfterHit()
        {
            if (Unit* caster = GetCaster())
                if (GetHitDamage() > 2)
                {
                    int32 mana = GetHitDamage()/2;
                    if (Unit* t = GetHitUnit())
                        caster->CastCustomSpell(t, SPELL_SARONITE_VAPORS_ENERGIZE, &mana, NULL, NULL, true);
                }
        }

        void Register()
        {
            AfterHit += SpellHitFn(spell_saronite_vapors_damage_SpellScript::HandleAfterHit);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_saronite_vapors_damage_SpellScript();
    }
};

class achievement_smell_saronite : public AchievementCriteriaScript
{
public:
    achievement_smell_saronite() : AchievementCriteriaScript("achievement_smell_saronite") {}

    bool OnCheck(Player*  /*player*/, Unit* target)
    {
        return target && target->GetEntry() == NPC_VEZAX && target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->AI()->GetData(1);
    }
};

class achievement_shadowdodger : public AchievementCriteriaScript
{
public:
    achievement_shadowdodger() : AchievementCriteriaScript("achievement_shadowdodger") {}

    bool OnCheck(Player*  /*player*/, Unit* target)
    {
        return target && target->GetEntry() == NPC_VEZAX && target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->AI()->GetData(2);
    }
};

class go_ulduar_pure_saronite_deposit : public GameObjectScript
{
public:
    go_ulduar_pure_saronite_deposit() : GameObjectScript("go_ulduar_pure_saronite_deposit") { }

    bool OnGossipHello(Player* plr, GameObject* go)
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

    new spell_aura_of_despair();
    new spell_mark_of_the_faceless_periodic();
    new spell_mark_of_the_faceless_drainhealth();
    new spell_saronite_vapors_dummy();
    new spell_saronite_vapors_damage();

    new achievement_smell_saronite();
    new achievement_shadowdodger();

    new go_ulduar_pure_saronite_deposit();
}