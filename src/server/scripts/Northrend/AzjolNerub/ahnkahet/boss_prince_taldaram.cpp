/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ahnkahet.h"
#include "SpellInfo.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_BLOODTHIRST                       = 55968, //Trigger Spell + add aura
    SPELL_CONJURE_FLAME_SPHERE              = 55931,
    SPELL_FLAME_SPHERE_SPAWN_EFFECT         = 55891,
    SPELL_FLAME_SPHERE_SUMMON_1             = 55895, // 1x 30106
    SPELL_FLAME_SPHERE_SUMMON_2             = 59511, // 1x 31686
    SPELL_FLAME_SPHERE_SUMMON_3             = 59512, // 1x 31687
    SPELL_FLAME_SPHERE_VISUAL               = 55928,
    SPELL_FLAME_SPHERE_PERIODIC             = 55926,
    SPELL_FLAME_SPHERE_PERIODIC_H           = 59508,
    SPELL_FLAME_SPHERE_DEATH_EFFECT         = 55947,
    SPELL_BEAM_VISUAL                       = 60342,
    SPELL_EMBRACE_OF_THE_VAMPYR             = 55959,
    SPELL_EMBRACE_OF_THE_VAMPYR_H           = 59513,
    SPELL_VANISH                            = 55964,
    SPELL_SHADOWSTEP                        = 55966,
    SPELL_HOVER_FALL                        = 60425
};

enum Creatures
{
    CREATURE_FLAME_SPHERE_1                 = 30106,
    CREATURE_FLAME_SPHERE_2                 = 31686,
    CREATURE_FLAME_SPHERE_3                 = 31687,
};

enum Misc
{
    DATA_EMBRACE_DMG                        = 20000,
    DATA_EMBRACE_DMG_H                      = 40000,
    DATA_SPHERE_DISTANCE                    = 30,
};

enum Actions
{
    ACTION_REMOVE_PRISON                             = 1,
    ACTION_SPHERE                           = 2,
};

enum Event
{
    EVENT_PRINCE_FLAME_SPHERES              = 1,
    EVENT_PRINCE_VANISH                     = 2,
    EVENT_PRINCE_BLOODTHIRST                = 3,
    EVENT_PRINCE_VANISH_RUN                 = 4,
    EVENT_PRINCE_RESCHEDULE                 = 5,
};

#define DATA_GROUND_POSITION_Z             11.4f

enum Yells
{
    SAY_1                                         = 0,
    SAY_WARNING                                   = 1,
    SAY_AGGRO                                     = 2,
    SAY_SLAY                                      = 3,
    SAY_DEATH                                     = 4,
    SAY_FEED                                      = 5,
    SAY_VANISH                                    = 6,
};

class boss_taldaram : public CreatureScript
{
public:
    boss_taldaram() : CreatureScript("boss_taldaram")
    {
    }

    struct boss_taldaramAI : public BossAI
    {
        boss_taldaramAI(Creature* pCreature) : BossAI(pCreature, DATA_PRINCE_TALDARAM)
        {         
        }

        void Reset() override
        {
            _Reset();

            if (me->GetPositionZ() > 15.0f)
                DoCastSelf(SPELL_BEAM_VISUAL, true);

            vanishDamage = 0;
            vanishTarget = 0;

            // Event not started
            if (instance->GetData(DATA_TELDRAM_SPHERE1) == DONE && instance->GetData(DATA_TELDRAM_SPHERE2) == DONE)
            {
                DoAction(ACTION_REMOVE_PRISON);
            }
        }

        void DoAction(int32 action) override
        {
            if (action != ACTION_REMOVE_PRISON)
            {
                return;
            }

            me->RemoveAllAuras();
            me->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);

            me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), DATA_GROUND_POSITION_Z, me->GetOrientation());
            DoCastSelf(SPELL_HOVER_FALL);
            me->GetMotionMaster()->MoveTargetedHome();

            instance->HandleGameObject(instance->GetData64(DATA_PRINCE_TALDARAM_PLATFORM), true);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*school*/) override
        {
            if (vanishTarget)
            {
                vanishDamage += damage;
                if (vanishDamage > DUNGEON_MODE<uint32>(DATA_EMBRACE_DMG, DATA_EMBRACE_DMG_H))
                {
                    ScheduleCombatEvents();
                    me->CastStop();
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            if (vanishTarget && victim->GetGUID() == vanishTarget)
                vanishTarget = 0;

            Talk(SAY_SLAY);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            Talk(SAY_AGGRO);
            ScheduleCombatEvents();

            me->RemoveAllAuras();
            me->InterruptNonMeleeSpells(true);
        }

        void SpellHitTarget(Unit* /*target*/, const SpellInfo *spellInfo)
        {
            if (spellInfo->Id == SPELL_CONJURE_FLAME_SPHERE)
                summons.DoAction(ACTION_SPHERE);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 const eventId = events.GetEvent())
            {
                switch (eventId)
                {
                case EVENT_PRINCE_BLOODTHIRST:
                {
                    DoCastSelf(SPELL_BLOODTHIRST);
                    events.RepeatEvent(10000);
                }break;
                case EVENT_PRINCE_FLAME_SPHERES:
                {
                    DoCastVictim(SPELL_CONJURE_FLAME_SPHERE);
                    events.RescheduleEvent(EVENT_PRINCE_VANISH, 14000);
                    events.RepeatEvent(15000);
                }break;
                case EVENT_PRINCE_VANISH:
                {
                    //Count alive players
                    uint8 count = 0;
                    std::list<HostileReference*> t_list = me->getThreatManager().getThreatList();
                    if (!t_list.empty())
                    {
                        for (HostileReference const* reference : t_list)
                        {
                            if (!reference)
                            {
                                continue;
                            }

                            Unit const* pTarget = ObjectAccessor::GetUnit(*me, reference->getUnitGuid());
                            if (pTarget && pTarget->GetTypeId() == TYPEID_PLAYER && pTarget->IsAlive())
                            {
                                ++count;
                            }
                        }
                    }

                    //He only vanishes if there are 3 or more alive players
                    if (count > 2)
                    {
                        Talk(SAY_VANISH);
                        DoCastSelf(SPELL_VANISH, false);

                        if (Unit* pEmbraceTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            vanishTarget = pEmbraceTarget->GetGUID();

                        events.CancelEvent(EVENT_PRINCE_FLAME_SPHERES);
                        events.CancelEvent(EVENT_PRINCE_BLOODTHIRST);
                        events.ScheduleEvent(EVENT_PRINCE_VANISH_RUN, 2499);

                    }
                    events.PopEvent();
                }break;
                case EVENT_PRINCE_VANISH_RUN:
                {
                    if (Unit* _vanishTarget = ObjectAccessor::GetUnit(*me, vanishTarget))
                    {
                        DoCast(_vanishTarget, SPELL_SHADOWSTEP);
                        me->CastSpell(_vanishTarget, SPELL_EMBRACE_OF_THE_VAMPYR, false);
                        me->RemoveAura(SPELL_VANISH);
                    }

                    events.PopEvent();
                    events.ScheduleEvent(EVENT_PRINCE_RESCHEDULE, 20000);
                }break;
                case EVENT_PRINCE_RESCHEDULE:
                {
                    events.PopEvent();
                    ScheduleCombatEvents();
                }break;
                }
            }

            if (me->IsVisible())
                DoMeleeAttackIfReady();
        }

    private:
        uint64 vanishTarget;
        uint32 vanishDamage;

        void ScheduleCombatEvents()
        {
            events.Reset();
            events.ScheduleEvent(EVENT_PRINCE_FLAME_SPHERES, 10000);
            events.ScheduleEvent(EVENT_PRINCE_BLOODTHIRST, 10000);
            vanishTarget = 0;
            vanishDamage = 0;
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new boss_taldaramAI(creature);
    }
};

class npc_taldaram_flamesphere : public CreatureScript
{
public:
    npc_taldaram_flamesphere() : CreatureScript("npc_taldaram_flamesphere") { }

    struct npc_taldaram_flamesphereAI : public ScriptedAI
    {
        npc_taldaram_flamesphereAI(Creature *pCreature) : ScriptedAI(pCreature), instance(pCreature->GetInstanceScript()), uiDespawnTimer(13 * IN_MILLISECONDS)
        {
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_SPHERE)
            {
                DoCastSelf(DUNGEON_MODE(SPELL_FLAME_SPHERE_PERIODIC, SPELL_FLAME_SPHERE_PERIODIC_H), true);

                float angle = rand_norm()*2*M_PI;
                float x = me->GetPositionX() + DATA_SPHERE_DISTANCE * cos(angle);
                float y = me->GetPositionY() + DATA_SPHERE_DISTANCE * sin(angle);
                me->GetMotionMaster()->MovePoint(1, x, y, me->GetPositionZ());
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == 1)
                me->DisappearAndDie();
        }

        void Reset() override
        {
            // Replace sphere instantly if sphere is summoned after prince death
            if (instance->GetData(DATA_PRINCE_TALDARAM) != IN_PROGRESS)
            {
                me->DespawnOrUnsummon();
                return;
            }

            DoCastSelf(SPELL_FLAME_SPHERE_SPAWN_EFFECT, true);
            DoCastSelf(SPELL_FLAME_SPHERE_VISUAL, true);

            // TODO: replace with DespawnOrUnsummon
            uiDespawnTimer = 13*IN_MILLISECONDS;
        }

        void EnterCombat(Unit * /*who*/) override {}
        void MoveInLineOfSight(Unit * /*who*/) override {}

        void JustDied(Unit* /*who*/) override
        {
            DoCastSelf(SPELL_FLAME_SPHERE_DEATH_EFFECT, true);
        }

        void UpdateAI(uint32 diff) override
        {
            if (uiDespawnTimer <= diff)
                me->DisappearAndDie();
            else
                uiDespawnTimer -= diff;
        }

    private:
        InstanceScript* instance;
        uint32 uiDespawnTimer;
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_taldaram_flamesphereAI(creature);
    }
};

class go_prince_taldaram_sphere : public GameObjectScript
{
public:
    go_prince_taldaram_sphere() : GameObjectScript("go_prince_taldaram_sphere") { }

    bool OnGossipHello(Player * pPlayer, GameObject *go) override
    {
        if (pPlayer && pPlayer->IsInCombat())
        {
            return false;
        }

        InstanceScript *pInstance = go->GetInstanceScript();
        if (!pInstance)
            return false;

        Creature *pPrinceTaldaram = ObjectAccessor::GetCreature(*go, pInstance->GetData64(DATA_PRINCE_TALDARAM));
        if (pPrinceTaldaram && pPrinceTaldaram->IsAlive())
        {
            go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
            go->SetGoState(GO_STATE_ACTIVE);

            uint32 const objectIndex = go->GetEntry() == GO_TELDARAM_SPHERE1 ? DATA_TELDRAM_SPHERE1 : DATA_TELDRAM_SPHERE2;
            if (pInstance->GetData(objectIndex) == NOT_STARTED)
            {
                pInstance->SetData(objectIndex, DONE);
                return true;
            }

            pPrinceTaldaram->AI()->DoAction(ACTION_REMOVE_PRISON);
        }

        return true;
    }
};

// 55931 - Conjure Flame Sphere
class spell_prince_taldaram_conjure_flame_sphere : public SpellScriptLoader
{
public:
    spell_prince_taldaram_conjure_flame_sphere() : SpellScriptLoader("spell_prince_taldaram_conjure_flame_sphere") { }

    class spell_prince_taldaram_conjure_flame_sphere_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_prince_taldaram_conjure_flame_sphere_SpellScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            if (!sSpellMgr->GetSpellInfo(SPELL_FLAME_SPHERE_SUMMON_1))
                return false;

            if (!sSpellMgr->GetSpellInfo(SPELL_FLAME_SPHERE_SUMMON_2))
                return false;

            if (!sSpellMgr->GetSpellInfo(SPELL_FLAME_SPHERE_SUMMON_3))
                return false;

            return true;
        }

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();
            caster->CastSpell(caster, SPELL_FLAME_SPHERE_SUMMON_1, true);

            if (caster->GetMap()->IsHeroic())
            {
                caster->CastSpell(caster, SPELL_FLAME_SPHERE_SUMMON_2, true);
                caster->CastSpell(caster, SPELL_FLAME_SPHERE_SUMMON_3, true);
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_prince_taldaram_conjure_flame_sphere_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_prince_taldaram_conjure_flame_sphere_SpellScript();
    }
};

void AddSC_boss_taldaram()
{
    new boss_taldaram();
    new npc_taldaram_flamesphere();
    new go_prince_taldaram_sphere();

    // Spells
    new spell_prince_taldaram_conjure_flame_sphere();
}
