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

/* ScriptData
SDName: Boss_Marli
SD%Complete: 80
SDComment: Charging healers and casters not working. Perhaps wrong Spell Timers.
SDCategory: Zul'Gurub
EndScriptData */

#include "GameObjectAI.h"
#include "SpellScript.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Says
{
    SAY_AGGRO               = 0,
    SAY_TRANSFORM           = 1,
    SAY_SPIDER_SPAWN        = 2,
    SAY_DEATH               = 3
};

enum Spells
{
    // Spider form
    SPELL_CHARGE              = 22911,
    SPELL_ENVOLWING_WEB       = 24110,
    SPELL_CORROSIVE_POISON    = 24111,
    SPELL_POISON_SHOCK        = 24112,

    //Troll form
    SPELL_POISON_VOLLEY       = 24099,
    SPELL_DRAIN_LIFE          = 24300,
    SPELL_ENLARGE             = 24109,
    SPELL_SPIDER_EGGS         = 24082,

    // All
    SPELL_SPIDER_FORM         = 24084,
    SPELL_TRANSFORM_BACK      = 24085,
    SPELL_TRASH               = 3391,
    SPELL_HATCH_SPIDER_EGGS   = 24082,
    SPELL_HATCH_EGGS          = 24083,

    // The Spider Spell
    SPELL_LEVELUP             = 24312  // Not right Spell.
};

enum Events
{
    EVENT_SPAWN_START_SPIDERS = 1, // Phase 1
    EVENT_POISON_VOLLEY       = 2, // Phase All
    EVENT_HATCH_SPIDER_EGG    = 3, // Phase All
    EVENT_CHARGE_PLAYER       = 4, // Phase 3
    EVENT_ASPECT_OF_MARLI     = 5, // Phase 2
    EVENT_TRANSFORM           = 6, // Phase 2
    EVENT_TRANSFORM_BACK      = 7  // Phase 3
};

enum Phases
{
    PHASE_ONE                 = 1,
    PHASE_TWO                 = 2,
    PHASE_THREE               = 3
};

enum Misc
{
    NPN_SPAWN_OF_MARLI        = 15041,
    GO_SPIDER_EGGS      = 179985
};

struct boss_marli : public BossAI
{
    boss_marli(Creature* creature) : BossAI(creature, DATA_MARLI) { }

    void Reset() override
    {
        if (events.IsInPhase(PHASE_THREE))
            me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, false); // hack

        std::list<GameObject*> eggs;
        me->GetGameObjectListWithEntryInGrid(eggs, GO_SPIDER_EGGS, DEFAULT_VISIBILITY_INSTANCE);

        for (auto const& egg : eggs)
        {
            egg->Respawn();
            egg->UpdateObjectVisibility();
        }

        BossAI::Reset();
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

    void JustSummoned(Creature* creature) override
    {
        summons.Summon(creature);
        creature->AI()->DoZoneInCombat();
    }

    void EnterCombat(Unit* who) override
    {
        BossAI::EnterCombat(who);
        events.ScheduleEvent(EVENT_SPAWN_START_SPIDERS, 1000, 0, PHASE_ONE);
        Talk(SAY_AGGRO);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SPAWN_START_SPIDERS:

                    Talk(SAY_SPIDER_SPAWN);
                    DoCastAOE(SPELL_HATCH_EGGS);
                    events.ScheduleEvent(EVENT_ASPECT_OF_MARLI, 12000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_TRANSFORM, 45000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_POISON_VOLLEY, 15000);
                    events.ScheduleEvent(EVENT_HATCH_SPIDER_EGG, 30000);
                    events.ScheduleEvent(EVENT_TRANSFORM, 45000, 0, PHASE_TWO);
                    events.SetPhase(PHASE_TWO);
                    break;
                case EVENT_POISON_VOLLEY:
                    DoCastVictim(SPELL_POISON_VOLLEY, true);
                    events.ScheduleEvent(EVENT_POISON_VOLLEY, urand(10000, 20000));
                    break;
                    break;
                case EVENT_HATCH_SPIDER_EGG:
                    DoCastSelf(SPELL_HATCH_SPIDER_EGGS);
                    events.ScheduleEvent(EVENT_HATCH_SPIDER_EGG, urand(12000, 17000));
                    break;
                case EVENT_TRANSFORM:
                {
                    Talk(SAY_TRANSFORM);
                    DoCast(me, SPELL_SPIDER_FORM); // SPELL_AURA_TRANSFORM
                    /*
                    CreatureTemplate const* cinfo = me->GetCreatureTemplate();
                    me->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, (cinfo->mindmg +((cinfo->mindmg/100) * 35)));
                    me->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, (cinfo->maxdmg +((cinfo->maxdmg/100) * 35)));
                    me->UpdateDamagePhysical(BASE_ATTACK);
                    */
                    me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, true); // hack
                    DoCastVictim(SPELL_ENVOLWING_WEB);
                    if (DoGetThreat(me->GetVictim()))
                        DoModifyThreatPercent(me->GetVictim(), -100);
                    events.ScheduleEvent(EVENT_CHARGE_PLAYER, 1500, 0, PHASE_THREE);
                    events.ScheduleEvent(EVENT_TRANSFORM_BACK, 25000, 0, PHASE_THREE);
                    events.CancelEvent(EVENT_HATCH_SPIDER_EGG);
                    events.SetPhase(PHASE_THREE);
                    break;
                }
                case EVENT_CHARGE_PLAYER:
                {
                    Unit* target = nullptr;
                    int i = 0;
                    while (i++ < 3) // max 3 tries to get a random target with power_mana
                    {
                        target = SelectTarget(SelectTargetMethod::Random, 1, 100, true);  // not aggro leader
                        if (target && target->getPowerType() == POWER_MANA)
                            break;
                    }
                    if (target)
                    {
                        DoCast(target, SPELL_CHARGE);
                        AttackStart(target);
                    }
                    events.ScheduleEvent(EVENT_CHARGE_PLAYER, 8000, 0, PHASE_THREE);
                    break;
                }
                case EVENT_TRANSFORM_BACK:
                {
                    me->RemoveAura(SPELL_SPIDER_FORM);
                    /*
                    CreatureTemplate const* cinfo = me->GetCreatureTemplate();
                    me->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, (cinfo->mindmg +((cinfo->mindmg/100) * 1)));
                    me->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, (cinfo->maxdmg +((cinfo->maxdmg/100) * 1)));
                    me->UpdateDamagePhysical(BASE_ATTACK);
                    */
                    me->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, 35.0f, false); // hack
                    events.ScheduleEvent(EVENT_ASPECT_OF_MARLI, 12000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_TRANSFORM, 45000, 0, PHASE_TWO);
                    events.ScheduleEvent(EVENT_POISON_VOLLEY, 15000);
                    events.ScheduleEvent(EVENT_HATCH_SPIDER_EGG, 30000);
                    events.ScheduleEvent(EVENT_TRANSFORM, urand(35000, 60000), 0, PHASE_TWO);
                    events.SetPhase(PHASE_TWO);
                    break;
                }
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
};

// Spawn of Marli
struct npc_spawn_of_marli : public ScriptedAI
{
    npc_spawn_of_marli(Creature* creature) : ScriptedAI(creature) { }

    uint32 LevelUp_Timer;

    void Reset() override
    {
        LevelUp_Timer = 3000;
    }

    void EnterCombat(Unit* /*who*/) override
    {
    }

    void UpdateAI(uint32 diff) override
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        //LevelUp_Timer
        if (LevelUp_Timer <= diff)
        {
            DoCast(me, SPELL_LEVELUP);
            LevelUp_Timer = 3000;
        }
        else LevelUp_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

class spell_hatch_spiders : public SpellScript
{
    PrepareSpellScript(spell_hatch_spiders);

    void HandleObjectAreaTargetSelect(std::list<WorldObject*>& targets)
    {
        targets.sort(Acore::ObjectDistanceOrderPred(GetCaster()));
        targets.resize(GetSpellInfo()->MaxAffectedTargets);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hatch_spiders::HandleObjectAreaTargetSelect, EFFECT_0, TARGET_GAMEOBJECT_DEST_AREA);
    }

};

void AddSC_boss_marli()
{
    RegisterCreatureAI(boss_marli);
    RegisterCreatureAI(npc_spawn_of_marli);
    RegisterSpellScript(spell_hatch_spiders);
}
