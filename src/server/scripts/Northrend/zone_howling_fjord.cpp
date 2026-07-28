/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Containers.h"
#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "WaypointMgr.h"

class npc_attracted_reef_bull : public CreatureScript
{
public:
    npc_attracted_reef_bull() : CreatureScript("npc_attracted_reef_bull") { }

    struct npc_attracted_reef_bullAI : public NullCreatureAI
    {
        npc_attracted_reef_bullAI(Creature* creature) : NullCreatureAI(creature)
        {
            me->SetDisableGravity(true);
            if (me->IsSummon())
                if (Unit* owner = me->ToTempSummon()->GetSummonerUnit())
                    me->GetMotionMaster()->MovePoint(0, *owner);
        }

        void MovementInform(uint32  /*type*/, uint32  /*id*/) override
        {
            if (Creature* cow = me->FindNearestCreature(24797, 5.0f, true))
            {
                me->CastSpell(me, 44460, true);
                me->DespawnOrUnsummon(10s);
                cow->CastSpell(cow, 44460, true);
                cow->DespawnOrUnsummon(10s);
                if (me->IsSummon())
                    if (Unit* owner = me->ToTempSummon()->GetSummonerUnit())
                        owner->CastSpell(owner, 44463, true);
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            if (caster && spellInfo->Id == 44454)
                me->GetMotionMaster()->MovePoint(0, *caster);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_attracted_reef_bullAI(creature);
    }
};

/*######
## npc_apothecary_hanes
######*/
enum Entries
{
    NPC_APOTHECARY_HANES         = 23784,
    NPC_HANES_FIRE_TRIGGER       = 23968,
    QUEST_TRAIL_OF_FIRE          = 11241,
    SPELL_COSMETIC_LOW_POLY_FIRE = 56274,
    SPELL_HEALING_POTION         = 17534
};

class npc_apothecary_hanes : public CreatureScript
{
public:
    npc_apothecary_hanes() : CreatureScript("npc_apothecary_hanes") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_TRAIL_OF_FIRE)
        {
            creature->SetFaction(player->GetTeamId() == TEAM_ALLIANCE ? FACTION_ESCORTEE_A_PASSIVE : FACTION_ESCORTEE_H_PASSIVE);
            creature->SetWalk(true);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, player->GetGUID());
        }
        return true;
    }

    struct npc_Apothecary_HanesAI : public npc_escortAI
    {
        npc_Apothecary_HanesAI(Creature* creature) : npc_escortAI(creature) { }
        uint32 PotTimer;

        void Reset() override
        {
            SetDespawnAtFar(false);
            PotTimer = 10000; //10 sec cooldown on potion
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_TRAIL_OF_FIRE);
        }

        void UpdateEscortAI(uint32 diff) override
        {
            if (HealthBelowPct(75))
            {
                if (PotTimer <= diff)
                {
                    DoCast(me, SPELL_HEALING_POTION, true);
                    PotTimer = 10000;
                }
                else PotTimer -= diff;
            }
            if (GetAttack() && UpdateVictim())
                DoMeleeAttackIfReady();
        }

        using CreatureAI::WaypointReached;
        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 1:
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetWalk(false);
                    break;
                case 23:
                    player->GroupEventHappens(QUEST_TRAIL_OF_FIRE, me);
                    me->DespawnOrUnsummon();
                    break;
                case 5:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    me->SetWalk(true);
                    break;
                case 6:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    me->SetWalk(false);
                    break;
                case 8:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    me->SetWalk(true);
                    break;
                case 9:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    break;
                case 10:
                    me->SetWalk(false);
                    break;
                case 13:
                    me->SetWalk(true);
                    break;
                case 14:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    me->SetWalk(false);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_Apothecary_HanesAI(creature);
    }
};

/*######
## npc_plaguehound_tracker
######*/

class npc_plaguehound_tracker : public CreatureScript
{
public:
    npc_plaguehound_tracker() : CreatureScript("npc_plaguehound_tracker") { }

    struct npc_plaguehound_trackerAI : public npc_escortAI
    {
        npc_plaguehound_trackerAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() override
        {
            ObjectGuid summonerGUID;
            if (me->IsSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                    if (summoner->IsPlayer())
                        summonerGUID = summoner->GetGUID();

            if (!summonerGUID)
                return;

            me->SetWalk(true);
            Start(false, summonerGUID);
        }

        using CreatureAI::WaypointReached;
        void WaypointReached(uint32 waypointId) override
        {
            if (waypointId != 26)
                return;

            me->DespawnOrUnsummon();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_plaguehound_trackerAI(creature);
    }
};

enum RodinLightningSpells
{
    SPELL_RODIN_LIGHTNING_START = 44787,
    SPELL_RODIN_LIGHTNING_END   = 44791,

    NPC_RODIN                   = 24876
};

struct npc_rodin_lightning_enabler : public ScriptedAI
{
    npc_rodin_lightning_enabler(Creature* creature) : ScriptedAI(creature) {}

    void Reset() override
    {
        _scheduler.Schedule(1s, [this](TaskContext context)
        {
            if (Creature* rodin = me->FindNearestCreature(NPC_RODIN, 10.0f))
                DoCast(rodin, urand(SPELL_RODIN_LIGHTNING_START, SPELL_RODIN_LIGHTNING_END));

            context.Repeat(2s, 8s);
        });
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        _scheduler.Update();
    }

private:
    TaskScheduler _scheduler;
};

enum HawkHunting
{
    SPELL_HAWK_HUNTING_ITEM = 44408
};

// 44407 - Spell hawk Hunting
class spell_hawk_hunting : public SpellScript
{
    PrepareSpellScript(spell_hawk_hunting);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HAWK_HUNTING_ITEM });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (!GetCaster())
            return;

        GetCaster()->CastSpell(GetCaster(), SPELL_HAWK_HUNTING_ITEM, true);
        GetHitUnit()->ToCreature()->DespawnOrUnsummon();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hawk_hunting::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## Quest 11317, 11322: The Cleansing
######*/

enum TheCleansing
{
    SPELL_CLEANSING_SOUL            = 43351,
    SPELL_SUMMON_INNER_TURMOIL      = 50167,
    SPELL_RECENT_MEDITATION         = 61720,
    SPELL_MIRROR_IMAGE_AURA         = 50218,

    QUEST_THE_CLEANSING_H           = 11317,
    QUEST_THE_CLEANSING_A           = 11322
};

// 43365 - The Cleansing: Shrine Cast
class spell_the_cleansing_shrine_cast : public SpellScript
{
    PrepareSpellScript(spell_the_cleansing_shrine_cast);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_RECENT_MEDITATION, SPELL_CLEANSING_SOUL }) &&
            sObjectMgr->GetQuestTemplate(QUEST_THE_CLEANSING_H) &&
            sObjectMgr->GetQuestTemplate(QUEST_THE_CLEANSING_A);
    }

    SpellCastResult CheckCast()
    {
        // Error is correct for quest check but may be not correct for aura and this may be a wrong place to send error
        if (Player* target = GetExplTargetUnit()->ToPlayer())
        {
            if (target->HasAura(SPELL_RECENT_MEDITATION) || (!(target->GetQuestStatus(QUEST_THE_CLEANSING_H) == QUEST_STATUS_INCOMPLETE ||
                target->GetQuestStatus(QUEST_THE_CLEANSING_A) == QUEST_STATUS_INCOMPLETE)))
            {
                Spell::SendCastResult(target, GetSpellInfo(), 0, SPELL_FAILED_FIZZLE);
                return SPELL_FAILED_FIZZLE;
            }
        }
        return SPELL_CAST_OK;
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_CLEANSING_SOUL, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_the_cleansing_shrine_cast::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_the_cleansing_shrine_cast::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 43351 - Cleansing Soul
class spell_the_cleansing_cleansing_soul : public AuraScript
{
    PrepareAuraScript(spell_the_cleansing_cleansing_soul);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_INNER_TURMOIL, SPELL_RECENT_MEDITATION });
    }

    void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->SetStandState(UNIT_STAND_STATE_SIT);
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->SetStandState(UNIT_STAND_STATE_STAND);
        target->CastSpell(target, SPELL_SUMMON_INNER_TURMOIL, true);
        target->CastSpell(target, SPELL_RECENT_MEDITATION, true);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_the_cleansing_cleansing_soul::AfterApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_the_cleansing_cleansing_soul::AfterRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 50217 - The Cleansing: Script Effect Player Cast Mirror Image
class spell_the_cleansing_mirror_image_script_effect : public SpellScript
{
    PrepareSpellScript(spell_the_cleansing_mirror_image_script_effect);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MIRROR_IMAGE_AURA });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_MIRROR_IMAGE_AURA, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_cleansing_mirror_image_script_effect::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 50238 - The Cleansing: Your Inner Turmoil's On Death Cast on Master
class spell_the_cleansing_on_death_cast_on_master : public SpellScript
{
    PrepareSpellScript(spell_the_cleansing_on_death_cast_on_master);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ uint32(spellInfo->GetEffect(EFFECT_0).CalcValue()) });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            if (TempSummon* casterSummon = caster->ToTempSummon())
                if (Unit* summoner = casterSummon->GetSummonerUnit())
                    summoner->CastSpell(summoner, GetSpellInfo()->Effects[EFFECT_0].CalcValue(), true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_the_cleansing_on_death_cast_on_master::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## Quest 11529: Sorlof's Booty
######*/

enum SorlofsBooty
{
    NPC_SORLOF                  = 24914,
    NPC_THE_BIG_GUN             = 24992,

    SPELL_CANNON_ASSAULT        = 45008,
    SPELL_SORLOFS_BOOTY         = 45070,

    // SPELL_BOULDER_ASSAULT_AURA  = 44964, // Serverside, triggers 44965 every 3s
    SPELL_BOULDER_ASSAULT_HIT   = 44966,
    SPELL_BOULDER_ASSAULT_FIRE  = 44967,

    // About the maximum range for broadside
    CANNON_RANGE                = 200,

    // The ship needs to ping Sorlof from wherever she is on her lap
    SORLOF_SEARCH_RANGE         = 1000,

    SORLOF_WANDER_DISTANCE      = 10,

    DATA_SORLOF_TAKE_PATH       = 1,
    POINT_SORLOF_PATH           = 1000,

    // He only knits himself back together once he has broken off and headed home
    PATH_SORLOF_RETURN          = 1032785,

    // The gun's own SmartAI announces the booty on this data set.
    DATA_SORLOF_SLAIN           = 1
};

// 44965 - Boulder Assault
class spell_sorlofs_booty_boulder_assault : public SpellScript
{
    PrepareSpellScript(spell_sorlofs_booty_boulder_assault);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BOULDER_ASSAULT_HIT });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        // One boulder per throw from implicit targets (no limit in DBC)
        WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
        targets.clear();
        targets.push_back(target);
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            caster->CastSpell(GetHitUnit(), SPELL_BOULDER_ASSAULT_HIT, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sorlofs_booty_boulder_assault::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_sorlofs_booty_boulder_assault::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 44966 - Boulder Assault
class spell_sorlofs_booty_boulder_assault_hit : public SpellScript
{
    PrepareSpellScript(spell_sorlofs_booty_boulder_assault_hit);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BOULDER_ASSAULT_FIRE });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, SPELL_BOULDER_ASSAULT_FIRE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_sorlofs_booty_boulder_assault_hit::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

uint32 GetSorlofPathForShipEvent(uint32 eventId)
{
    switch (eventId)
    {
        // Departure events of the Sister Mercy's stops (TaxiPathNode.dbc path 778)
        case 16501: return 1032780;
        case 16502: return 1032781;
        case 16503: return 1032782;
        case 16504: return 1032783;
        case 16510: return 1032784;
        case 16511: return 1032785; // Return to spawn
        default:    return 0;
    }
}

struct npc_sorlof : public ScriptedAI
{
    npc_sorlof(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _pathId = 0;
        _pathNode = 0;
        _advancePath = false;
        me->SetRegeneratingHealth(false);
    }

    void SetData(uint32 id, uint32 value) override
    {
        if (id != DATA_SORLOF_TAKE_PATH)
            return;

        _pathId = value;
        _pathNode = 0;
        _advancePath = true;
        me->SetRegeneratingHealth(value == PATH_SORLOF_RETURN);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE || id != POINT_SORLOF_PATH + _pathNode)
            return;

        ++_pathNode;
        _advancePath = true;
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastSelf(SPELL_SORLOFS_BOOTY, true);

        if (Creature* gun = me->FindNearestCreature(NPC_THE_BIG_GUN, CANNON_RANGE))
            gun->AI()->SetData(DATA_SORLOF_SLAIN, DATA_SORLOF_SLAIN);
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        // Deferred out of MovementInform: that fires from the generator's DoFinalize, and
        // MotionMaster::DirectExpire then Resets the new top generator, whose DoReset stops
        // the spline it just launched. UpdateAI runs after the MotionMaster, so it sticks.
        if (_advancePath)
        {
            _advancePath = false;
            MoveToNextNode();
        }

        if (UpdateVictim())
            DoMeleeAttackIfReady();
    }

private:
    void MoveToNextNode()
    {
        WaypointPath const* path = sWaypointMgr->GetPath(_pathId);
        if (!path)
            return;

        // Each leg ends with him milling about where the ship has drawn up
        if (_pathNode >= path->Nodes.size())
        {
            me->GetMotionMaster()->MoveRandom(SORLOF_WANDER_DISTANCE);
            return;
        }

        WaypointNode const& node = path->Nodes[_pathNode];
        me->SetWalk(node.MoveType == WAYPOINT_MOVE_TYPE_WALK);
        me->GetMotionMaster()->MovePoint(POINT_SORLOF_PATH + _pathNode, node.X, node.Y, node.Z);
    }

    uint32 _pathId{ 0 };
    uint32 _pathNode{ 0 };
    bool _advancePath{ false };
};

struct go_sister_mercy : public GameObjectAI
{
    go_sister_mercy(GameObject* go) : GameObjectAI(go) { }

    // Notify Sorlof the ship is departing towards the next broadside point
    void EventInform(uint32 eventId) override
    {
        uint32 pathId = GetSorlofPathForShipEvent(eventId);
        if (!pathId)
            return;

        if (Creature* sorlof = me->FindNearestCreature(NPC_SORLOF, SORLOF_SEARCH_RANGE))
            sorlof->AI()->SetData(DATA_SORLOF_TAKE_PATH, pathId);
    }
};

// 45045 - Big Cannon Assault Primer
class spell_sorlofs_booty_cannon_primer : public SpellScript
{
    PrepareSpellScript(spell_sorlofs_booty_cannon_primer);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ uint32(spellInfo->GetEffect(EFFECT_0).CalcValue()) });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        // Primes the gun: the clicker performs the actual, timed Big Gun Assault cast.
        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, GetSpellInfo()->Effects[EFFECT_0].CalcValue(), false);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_sorlofs_booty_cannon_primer::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 45013 - Big Gun Assault
class spell_sorlofs_booty_big_gun_assault : public SpellScript
{
    PrepareSpellScript(spell_sorlofs_booty_big_gun_assault);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CANNON_ASSAULT });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        // Implicit target of the dummy effect, resolved to The Big Gun by conditions
        Creature* gun = GetHitCreature();
        if (!gun)
            return;

        Creature* sorlof = gun->FindNearestCreature(NPC_SORLOF, CANNON_RANGE);
        if (!sorlof)
            return;

        if (!gun->IsWithinLOSInMap(sorlof, VMAP::ModelIgnoreFlags::M2, LINEOFSIGHT_CHECK_VMAP))
            return;

        // Fired by the gun rather than by the player, this is correct
        gun->CastSpell(sorlof, SPELL_CANNON_ASSAULT, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_sorlofs_booty_big_gun_assault::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_howling_fjord()
{
    new npc_attracted_reef_bull();
    new npc_apothecary_hanes();
    new npc_plaguehound_tracker();
    RegisterCreatureAI(npc_rodin_lightning_enabler);
    RegisterSpellScript(spell_hawk_hunting);
    RegisterSpellScript(spell_the_cleansing_shrine_cast);
    RegisterSpellScript(spell_the_cleansing_cleansing_soul);
    RegisterSpellScript(spell_the_cleansing_mirror_image_script_effect);
    RegisterSpellScript(spell_the_cleansing_on_death_cast_on_master);
    RegisterSpellScript(spell_sorlofs_booty_cannon_primer);
    RegisterSpellScript(spell_sorlofs_booty_big_gun_assault);
    RegisterSpellScript(spell_sorlofs_booty_boulder_assault);
    RegisterSpellScript(spell_sorlofs_booty_boulder_assault_hit);
    RegisterCreatureAI(npc_sorlof);
    RegisterGameObjectAI(go_sister_mercy);
}
