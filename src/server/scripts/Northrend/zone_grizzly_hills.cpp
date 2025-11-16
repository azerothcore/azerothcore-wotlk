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

#include "CombatAI.h"
#include "CreatureScript.h"
#include "CreatureTextMgr.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

 /*######
 ## Quest 12027: Mr. Floppy's Perilous Adventure
 ######*/

enum Floppy
{
    // Creature
    NPC_MRFLOPPY                 = 26589,
    NPC_HUNGRY_WORG              = 26586,
    NPC_RAVENOUS_WORG            = 26590,   // RWORG
    NPC_EMILY                    = 26588,
    // Quest
    QUEST_PERILOUS_ADVENTURE     = 12027,
    // Spell
    SPELL_MRFLOPPY               = 47184,   // vehicle aura
    // Text
    SAY_WORGHAGGRO1              = 0, // Um... I think one of those wolves is back...
    SAY_WORGHAGGRO2              = 1, // He's going for Mr. Floppy!
    SAY_WORGRAGGRO3              = 2, // Oh, no! Look, it's another wolf, and it's a biiiiiig one!
    SAY_WORGRAGGRO4              = 3, // He's gonna eat Mr. Floppy! You gotta help Mr. Floppy! You just gotta!
    SAY_RANDOMAGGRO              = 4, // There's a big meanie attacking Mr. Floppy! Help!
    SAY_VICTORY1                 = 5, // Let's get out of here before more wolves find us!
    SAY_VICTORY2                 = 6, // Don't go toward the light, Mr. Floppy!
    SAY_VICTORY3                 = 7, // Mr. Floppy, you're ok! Thank you so much for saving Mr. Floppy!
    SAY_VICTORY4                 = 8, // I think I see the camp! We're almost home, Mr. Floppy! Let's go!
    TEXT_EMOTE_WP1               = 9, // Mr. Floppy revives
    TEXT_EMOTE_AGGRO             = 10, // The Ravenous Worg chomps down on Mr. Floppy
    SAY_QUEST_ACCEPT             = 11, // Are you ready, Mr. Floppy? Stay close to me and watch out for those wolves!
    SAY_QUEST_COMPLETE           = 12  // Thank you for helping me get back to the camp. Go tell Walter that I'm safe now!
};

// emily
class npc_emily : public CreatureScript
{
public:
    npc_emily() : CreatureScript("npc_emily") { }

    struct npc_emilyAI : public npc_escortAI
    {
        npc_emilyAI(Creature* creature) : npc_escortAI(creature) { }

        void JustSummoned(Creature* summoned) override
        {
            if (Creature* Mrfloppy = GetClosestCreatureWithEntry(me, NPC_MRFLOPPY, 50.0f))
                summoned->AI()->AttackStart(Mrfloppy);
            else
                summoned->AI()->AttackStart(me->GetVictim());
        }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
            case 9:
                if (Creature* Mrfloppy = GetClosestCreatureWithEntry(me, NPC_MRFLOPPY, 100.0f))
                    _mrfloppyGUID = Mrfloppy->GetGUID();
                break;
            case 10:
                if (ObjectAccessor::GetCreature(*me, _mrfloppyGUID))
                {
                    Talk(SAY_WORGHAGGRO1);
                    if (Creature* worg = me->SummonCreature(NPC_HUNGRY_WORG, me->GetPositionX() + 5, me->GetPositionY() + 2, me->GetPositionZ() + 1, 3.229f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 120000))
                        if (Creature* Mrfloppy = ObjectAccessor::GetCreature(*me, _mrfloppyGUID))
                        {
                            worg->SetReactState(REACT_AGGRESSIVE);
                            worg->GetAI()->AttackStart(Mrfloppy);
                        }
                }
                break;
            case 11:
                if (Creature* Mrfloppy = ObjectAccessor::GetCreature(*me, _mrfloppyGUID))
                    Mrfloppy->GetMotionMaster()->MoveFollow(me, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                break;
            case 17:
                if (Creature* Mrfloppy = ObjectAccessor::GetCreature(*me, _mrfloppyGUID))
                    Mrfloppy->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                Talk(SAY_WORGRAGGRO3);
                if (Creature* RWORG = me->SummonCreature(NPC_RAVENOUS_WORG, me->GetPositionX() + 10, me->GetPositionY() + 8, me->GetPositionZ() + 2, 3.229f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 120000))
                {
                    RWORG->SetReactState(REACT_PASSIVE);
                    RWORG->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    RWORG->SetUnitFlag(UNIT_FLAG_PACIFIED);
                    _RavenousworgGUID = RWORG->GetGUID();
                }
                break;
            case 18:
                if (Creature* Mrfloppy = ObjectAccessor::GetCreature(*me, _mrfloppyGUID))
                {
                    if (Creature* RWORG = ObjectAccessor::GetCreature(*me, _RavenousworgGUID))
                        RWORG->GetMotionMaster()->MovePoint(0, Mrfloppy->GetPositionX(), Mrfloppy->GetPositionY(), Mrfloppy->GetPositionZ());
                    me->AddAura(SPELL_MRFLOPPY, Mrfloppy);
                }
                break;
            case 19:
                if (Creature* Mrfloppy = ObjectAccessor::GetCreature(*me, _mrfloppyGUID))
                {
                    if (Mrfloppy->HasAura(SPELL_MRFLOPPY))
                    {
                        if (Creature* RWORG = ObjectAccessor::GetCreature(*me, _RavenousworgGUID))
                            Mrfloppy->EnterVehicle(RWORG);
                    }
                }
                break;
            case 20:
                if (Creature* RWORG = ObjectAccessor::GetCreature(*me, _RavenousworgGUID))
                    RWORG->HandleEmoteCommand(34);
                break;
            case 21:
                if (Creature* Mrfloppy = ObjectAccessor::GetCreature(*me, _mrfloppyGUID))
                {
                    if (Creature* RWORG = ObjectAccessor::GetCreature(*me, _RavenousworgGUID))
                    {
                        Unit::Kill(RWORG, Mrfloppy);
                        Mrfloppy->ExitVehicle();
                        RWORG->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        RWORG->RemoveUnitFlag(UNIT_FLAG_PACIFIED);
                        RWORG->AI()->AttackStart(player);
                        Talk(SAY_VICTORY2);
                    }
                }
                break;
            case 22:
                if (Creature* Mrfloppy = ObjectAccessor::GetCreature(*me, _mrfloppyGUID))
                {
                    if (Mrfloppy->isDead())
                    {
                        me->GetMotionMaster()->MovePoint(0, Mrfloppy->GetPositionX(), Mrfloppy->GetPositionY(), Mrfloppy->GetPositionZ());
                        Mrfloppy->setDeathState(DeathState::Alive);
                        Mrfloppy->GetMotionMaster()->MoveFollow(me, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                        Talk(SAY_VICTORY3);
                    }
                }
                break;
            case 24:
                if (player)
                {
                    player->GroupEventHappens(QUEST_PERILOUS_ADVENTURE, me);
                    Talk(SAY_QUEST_COMPLETE, player);
                }
                me->SetWalk(false);
                break;
            case 25:
                Talk(SAY_VICTORY4);
                break;
            case 27:
                me->DisappearAndDie();
                if (Creature* Mrfloppy = ObjectAccessor::GetCreature(*me, _mrfloppyGUID))
                    Mrfloppy->DisappearAndDie();
                break;
            }
        }

        void JustEngagedWith(Unit* /*Who*/) override
        {
            Talk(SAY_RANDOMAGGRO);
        }

        void Reset() override
        {
            _mrfloppyGUID.Clear();
            _RavenousworgGUID.Clear();
        }

    private:
        ObjectGuid   _RavenousworgGUID;
        ObjectGuid   _mrfloppyGUID;
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_PERILOUS_ADVENTURE)
        {
            creature->AI()->Talk(SAY_QUEST_ACCEPT);
            if (Creature* Mrfloppy = GetClosestCreatureWithEntry(creature, NPC_MRFLOPPY, 180.0f))
                Mrfloppy->GetMotionMaster()->MoveFollow(creature, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_emily::npc_emilyAI, (creature->AI())))
                pEscortAI->Start(true, player->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_emilyAI(creature);
    }
};

// mrfloppy
class npc_mrfloppy : public CreatureScript
{
public:
    npc_mrfloppy() : CreatureScript("npc_mrfloppy") { }

    struct npc_mrfloppyAI : public ScriptedAI
    {
        npc_mrfloppyAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override { }

        void JustEngagedWith(Unit* Who) override
        {
            if (Creature* Emily = GetClosestCreatureWithEntry(me, NPC_EMILY, 50.0f))
            {
                switch (Who->GetEntry())
                {
                    case NPC_HUNGRY_WORG:
                        Emily->AI()->Talk(SAY_WORGHAGGRO2);
                        break;
                    case NPC_RAVENOUS_WORG:
                        Emily->AI()->Talk(SAY_WORGRAGGRO4);
                        break;
                    default:
                        Emily->AI()->Talk(SAY_RANDOMAGGRO);
                }
            }
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            if (Creature* Emily = GetClosestCreatureWithEntry(me, NPC_EMILY, 50.0f))
                me->GetMotionMaster()->MoveFollow(Emily, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
        }

        void MoveInLineOfSight(Unit* /*who*/) override { }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_mrfloppyAI(creature);
    }
};

// Ravenous Worg
class npc_ravenous_worg : public CreatureScript
{
public:
    npc_ravenous_worg() : CreatureScript("npc_ravenous_worg") { }

    struct npc_ravenous_worgAI : public CombatAI
    {
        npc_ravenous_worgAI(Creature* creature) : CombatAI(creature)
        {
            _pacified = false;
            _attack = false;
        }

        void AttackStart(Unit* who) override
        {
            if (me->HasUnitFlag(UNIT_FLAG_PACIFIED))
                _pacified = true;

            if (_pacified && !me->HasUnitFlag(UNIT_FLAG_PACIFIED))
                _attack = true;

            if (_attack)
                CombatAI::AttackStart(who);
        }

        void UpdateAI(uint32 diff) override
        {
            if (me->HasUnitFlag(UNIT_FLAG_PACIFIED))
                _pacified = true;

            if (_pacified && !me->HasUnitFlag(UNIT_FLAG_PACIFIED))
                _attack = true;

            CombatAI::UpdateAI(diff);
        }

    private:
        bool   _pacified;
        bool   _attack;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ravenous_worgAI(creature);
    }
};

/*######
## Quest 12227: Doing Your Duty
######*/

enum Outhouse
{
    // Sound
    SOUND_FEMALE                    = 12671,
    SOUND_MALE                      = 12670,
    // Spell
    SPELL_CAMERA_SHAKE              = 47533,
    SPELL_DUST_FIELD                = 48329,
    // Item
    ITEM_ANDERHOLS_SLIDER_CIDER     = 37247,
    // NPC
    NPC_OUTHOUSE_BUNNY_GRIZZLY      = 27326,
};

class spell_q12227_outhouse_groans : public SpellScript
{
    PrepareSpellScript(spell_q12227_outhouse_groans);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CAMERA_SHAKE, SPELL_DUST_FIELD });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            player->CastSpell(player, SPELL_CAMERA_SHAKE, true);

            switch (GetCaster()->getGender())
            {
            case GENDER_FEMALE:
                player->PlayDirectSound(SOUND_FEMALE);
                break;
            case GENDER_MALE:
                player->PlayDirectSound(SOUND_MALE);
                break;
            default:
                break;
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12227_outhouse_groans::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};
class spell_q12227_camera_shake : public SpellScript
{
    PrepareSpellScript(spell_q12227_camera_shake);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DUST_FIELD });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetCaster()->ToPlayer())
            if (Creature* target = GetClosestCreatureWithEntry(player, NPC_OUTHOUSE_BUNNY_GRIZZLY, 3.0f)) // hackfix: Outhouse bunny doesnt show in any script. But the visual of Dust Field do not show if cast by the player
                target->CastSpell(target, SPELL_DUST_FIELD, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12227_camera_shake::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

/*######
## Quest 12288: Overwhelmed!
######*/

enum Skirmisher
{
    // Quest
    QUEST_OVERWHELMED           = 12288,

    // Spell
    SPELL_RENEW_SKIRMISHER      = 48812,
    SPELL_KILL_CREDIT           = 48813,
    SPELL_CLEAVE                = 15496,
    SPELL_HAMSTRING             = 9080,
    SPELL_MORTAL_STRIKE         = 32736,

    // Text
    SAY_RANDOM                  = 0,

    // EVENT
    EVENT_WOUNDED_MOVE          = 1,
    EVENT_CLEAVE                = 2,
    EVENT_HAMSTRING             = 3,
    EVENT_MORTAL_STRIKE         = 4,

    // Waypoints
    WOUNDED_MOVE_1              = 274630,
    WOUNDED_MOVE_2              = 274631,
    WOUNDED_MOVE_3              = 274632
};

struct npc_wounded_skirmisher : public CreatureAI
{
public:
    npc_wounded_skirmisher(Creature* creature) : CreatureAI(creature)
    {
        Initialize();
    }

    void Initialize()
    {
        me->SetReactState(REACT_DEFENSIVE);
    }

    void Reset() override
    {
        Initialize();
        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        events.ScheduleEvent(EVENT_CLEAVE, 1s, 7s);
        events.ScheduleEvent(EVENT_HAMSTRING, 5s, 12s);
        events.ScheduleEvent(EVENT_MORTAL_STRIKE, 5s, 10s);
    }

    void SpellHit(Unit* caster, SpellInfo const* spell) override
    {
        Player* playerCaster = caster->ToPlayer();
        if (!playerCaster)
            return;

        if (spell->Id == SPELL_RENEW_SKIRMISHER && playerCaster->GetQuestStatus(QUEST_OVERWHELMED) == QUEST_STATUS_INCOMPLETE)
        {
            me->SetFacingToObject(caster);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            Talk(SAY_RANDOM, caster);
            DoCast(caster, SPELL_KILL_CREDIT);

            if (!me->IsStandState())
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
                events.ScheduleEvent(EVENT_WOUNDED_MOVE, 3s);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        switch (events.ExecuteEvent())
        {
            case EVENT_WOUNDED_MOVE:
                if (me->GetPositionY() == -2835.11f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_1, false);
                    me->DespawnOrUnsummon(20s);
                }
                if (me->GetPositionY() == -2981.89f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_3, false);
                    me->DespawnOrUnsummon(18s);
                }
                if (me->GetPositionY() == -2934.44f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_3, false);
                    me->DespawnOrUnsummon(9s);
                }
                if (me->GetPositionY() == -3020.99f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_1, false);
                    me->DespawnOrUnsummon(22s);
                }
                if (me->GetPositionY() == -2964.73f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_2, false);
                    me->DespawnOrUnsummon(15s);
                }
                if (me->GetPositionY() == -2940.50f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_1, false);
                    me->DespawnOrUnsummon(20s);
                }
                if (me->GetPositionY() == -2847.93f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_1, false);
                    me->DespawnOrUnsummon(30s);
                }
                if (me->GetPositionY() == -2835.31f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_1, false);
                    me->DespawnOrUnsummon(27s);
                }
                if (me->GetPositionY() == -2822.20f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_1, false);
                    me->DespawnOrUnsummon(25s);
                }
                if (me->GetPositionY() == -2846.31f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_1, false);
                    me->DespawnOrUnsummon(21s);
                }
                if (me->GetPositionY() == -2897.23f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_3, false);
                    me->DespawnOrUnsummon(15s);
                }
                if (me->GetPositionY() == -2886.01f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_3, false);
                    me->DespawnOrUnsummon(25s);
                }
                if (me->GetPositionY() == -2906.89f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_3, false);
                    me->DespawnOrUnsummon(25s);
                }
                if (me->GetPositionY() == -3048.94f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_2, false);
                    me->DespawnOrUnsummon(30s);
                }
                if (me->GetPositionY() == -2961.08f)
                {
                    me->GetMotionMaster()->MoveWaypoint(WOUNDED_MOVE_2, false);
                    me->DespawnOrUnsummon(25s);
                }
                break;
            case EVENT_CLEAVE:
                me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                events.Repeat(7s, 15s);
                break;
            case EVENT_HAMSTRING:
                me->CastSpell(me->GetVictim(), SPELL_HAMSTRING, false);
                events.Repeat(9s, 15s);
                break;
            case EVENT_MORTAL_STRIKE:
                me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
                events.Repeat(10s, 15s);
                break;
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

enum renewskirmisher
{
    NPC_WOUNDED_SKIRMISHER = 27463
};

class spell_renew_skirmisher : public SpellScript
{
public:
    PrepareSpellScript(spell_renew_skirmisher);

    SpellCastResult CheckRequirement()
    {
        if (Unit* caster = GetCaster())
            if (Creature* wounded = caster->FindNearestCreature(NPC_WOUNDED_SKIRMISHER, 5.0f))
                if (!wounded->IsInCombat())
                    return SPELL_CAST_OK;

        return SPELL_FAILED_CASTER_AURASTATE;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_renew_skirmisher::CheckRequirement);
    }
};

/*Venture co. Straggler - when you cast Smoke Bomb, he will yell and run away*/
enum SmokeEmOut
{
    // Quest
    QUEST_SMOKE_EM_OUT_A                        = 12323,
    QUEST_SMOKE_EM_OUT_H                        = 12324,
    // Spell
    SPELL_SMOKE_BOMB                            = 49075,
    SPELL_CHOP                                  = 43410,
    SPELL_VENTURE_STRAGGLER_CREDIT              = 49093,
    // Text
    SAY_SEO                                     = 0
};

enum StragglerEvents
{
    EVENT_STRAGGLER_1                           = 1,
    EVENT_STRAGGLER_2                           = 2,
    EVENT_STRAGGLER_3                           = 3,
    EVENT_STRAGGLER_4                           = 4,
    EVENT_CHOP                                  = 5
};

class npc_venture_co_straggler : public CreatureScript
{
public:
    npc_venture_co_straggler() : CreatureScript("npc_venture_co_straggler") { }

    struct npc_venture_co_stragglerAI : public ScriptedAI
    {
        npc_venture_co_stragglerAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            _playerGUID.Clear();

            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetImmuneToPC(false);
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_STRAGGLER_1:
                        if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                            DoCast(player, SPELL_VENTURE_STRAGGLER_CREDIT);
                        me->GetMotionMaster()->MovePoint(0, me->GetPositionX() - 7, me->GetPositionY() + 7, me->GetPositionZ());
                        _events.ScheduleEvent(EVENT_STRAGGLER_2, 2500ms);
                        break;
                    case EVENT_STRAGGLER_2:
                        Talk(SAY_SEO);
                        me->GetMotionMaster()->MovePoint(0, me->GetPositionX() - 7, me->GetPositionY() - 5, me->GetPositionZ());
                        _events.ScheduleEvent(EVENT_STRAGGLER_3, 2500ms);
                        break;
                    case EVENT_STRAGGLER_3:
                        me->GetMotionMaster()->MovePoint(0, me->GetPositionX() - 5, me->GetPositionY() - 5, me->GetPositionZ());
                        _events.ScheduleEvent(EVENT_STRAGGLER_4, 2500ms);
                        break;
                    case EVENT_STRAGGLER_4:
                        me->DisappearAndDie();
                        break;
                    case EVENT_CHOP:
                        if (UpdateVictim())
                            DoCastVictim(SPELL_CHOP);
                        _events.ScheduleEvent(EVENT_CHOP, 10s, 12s);
                        break;
                    default:
                        break;
                }
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_SMOKE_BOMB && caster->IsPlayer())
            {
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToPC(true);
                me->SetReactState(REACT_PASSIVE);
                me->CombatStop(false);
                _playerGUID = caster->GetGUID();
                _events.ScheduleEvent(EVENT_STRAGGLER_1, 3500ms);
            }
        }

    private:
        EventMap _events;
        ObjectGuid _playerGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_venture_co_stragglerAI(creature);
    }
};

/*######
## Quest: A Blade Fit For A Champion
######*/

enum LakeFrog
{
    // Creature
    NPC_LAKE_FROG                          = 33211,
    NPC_LAKE_FROG_QUEST                    = 33224,
    NPC_MAIDEN_OF_ASHWOOD_LAKE             = 33220,
    // Items
    ITEM_WARTS_B_GONE_LIP_BALM             = 44986,
    // Spells
    SPELL_WARTSBGONE_LIP_BALM              = 62574,
    SPELL_FROG_LOVE                        = 62537, // for 1 minute !
    SPELL_WARTS                            = 62581,
    SPELL_MAIDEN_OF_ASHWOOD_LAKE_TRANSFORM = 62550,
    SPELL_SUMMON_ASHWOOD_BRAND             = 62554,
    SPELL_FROG_KISS                        = 62536,
    // Text
    SAY_MAIDEN_0                           = 0,
    SAY_MAIDEN_1                           = 1
};

enum LakeFrogEvents
{
    EVENT_LAKEFROG_1                       = 1,
    EVENT_LAKEFROG_2                       = 2,
    EVENT_LAKEFROG_3                       = 3,
    EVENT_LAKEFROG_4                       = 4,
    EVENT_LAKEFROG_5                       = 5
};

class npc_lake_frog : public CreatureScript
{
public:
    npc_lake_frog() : CreatureScript("npc_lake_frog") { }

    struct npc_lake_frogAI : public ScriptedAI
    {
        npc_lake_frogAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            _following = false;
            _runningScript = false;
            if (me->GetEntry() == NPC_LAKE_FROG_QUEST)
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        }

        void UpdateAI(uint32 diff) override
        {
            if (_following)
                if (!me->HasAura(SPELL_FROG_LOVE))
                    me->DespawnOrUnsummon(1s);

            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_LAKEFROG_1:
                        DoCast(me, SPELL_MAIDEN_OF_ASHWOOD_LAKE_TRANSFORM);
                        me->SetEntry(NPC_MAIDEN_OF_ASHWOOD_LAKE);
                        _events.ScheduleEvent(EVENT_LAKEFROG_2, 2s);
                        break;
                    case EVENT_LAKEFROG_2:
                        Talk(SAY_MAIDEN_0);
                        _events.ScheduleEvent(EVENT_LAKEFROG_3, 3s);
                        break;
                    case EVENT_LAKEFROG_3:
                        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        _events.ScheduleEvent(EVENT_LAKEFROG_4, 25s);
                        break;
                    case EVENT_LAKEFROG_4:
                        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        _events.ScheduleEvent(EVENT_LAKEFROG_5, 2s);
                        break;
                    case EVENT_LAKEFROG_5:
                        Talk(SAY_MAIDEN_1);
                        me->DespawnOrUnsummon(4s);
                        break;
                    default:
                        break;
                }
            }
        }

        void ReceiveEmote(Player* player, uint32 emote) override
        {
            if (_following || _runningScript)
                return;

            if (emote == TEXT_EMOTE_KISS && me->IsWithinDistInMap(player, 30.0f) && player->HasItemCount(ITEM_WARTS_B_GONE_LIP_BALM, 1, false))
            {
                if (!player->HasAura(SPELL_WARTSBGONE_LIP_BALM))
                    player->AddAura(SPELL_WARTS, player);
                else
                {
                    // Removes SPELL_WARTSBGONE_LIP_BALM
                    player->CastSpell(player, SPELL_FROG_KISS, true);

                    if (me->GetEntry() == NPC_LAKE_FROG)
                    {
                        me->AddAura(SPELL_FROG_LOVE, me);
                        me->GetMotionMaster()->MoveFollow(player, 0.3f, frand(M_PI / 2, M_PI + (M_PI / 2)));
                        _following = true;
                    }
                    else if (me->GetEntry() == NPC_LAKE_FROG_QUEST)
                    {
                        me->GetMotionMaster()->MoveIdle();
                        me->SetFacingToObject(player);
                        _runningScript = true;
                        _events.ScheduleEvent(EVENT_LAKEFROG_1, 2s);
                    }
                }
            }
        }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32 /*action*/) override
        {
            DoCast(player, SPELL_SUMMON_ASHWOOD_BRAND);
        }

    private:
        EventMap _events;
        bool   _following;
        bool   _runningScript;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_lake_frogAI(creature);
    }
};

enum ShredderDelivery
{
    NPC_BROKEN_DOWN_SHREDDER               = 27354
};

class spell_shredder_delivery : public SpellScript
{
    PrepareSpellScript(spell_shredder_delivery);

    bool Load() override
    {
        return GetCaster()->IsCreature();
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (GetCaster()->ToCreature()->GetEntry() == NPC_BROKEN_DOWN_SHREDDER)
            GetCaster()->ToCreature()->DespawnOrUnsummon();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_shredder_delivery::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum InfectedWorgenBite
{
    SPELL_INFECTED_WORGEN_BITE = 53094,
    SPELL_WORGENS_CALL         = 53095
};

class spell_infected_worgen_bite_aura : public AuraScript
{
    PrepareAuraScript(spell_infected_worgen_bite_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WORGENS_CALL });
    }

    void HandleAfterEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (target->IsPlayer())
            if (GetStackAmount() == GetSpellInfo()->StackAmount)
            {
                SetDuration(0);
                target->CastSpell(target, SPELL_WORGENS_CALL, true);
            }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_infected_worgen_bite_aura::HandleAfterEffectApply, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAPPLY);
    }
};

/*######
## Quest: Riding the Red Rocket
######*/

enum WarheadSpells
{
    SPELL_DETONATE = 49250,
    SPELL_WARHEAD_Z_CHECK = 61678,
    SPELL_WARHEAD_SEEKING_LUMBERSHIP = 49331,
    SPELL_WARHEAD_FUSE = 49181
};
// 49107 - Vehicle: Warhead Fuse
class spell_vehicle_warhead_fuse : public SpellScript
{
    PrepareSpellScript(spell_vehicle_warhead_fuse);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({
            SPELL_WARHEAD_Z_CHECK,
            SPELL_WARHEAD_SEEKING_LUMBERSHIP,
            SPELL_WARHEAD_FUSE
        });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        caster->CastSpell(caster, SPELL_WARHEAD_Z_CHECK, true);
        caster->CastSpell(caster, SPELL_WARHEAD_SEEKING_LUMBERSHIP, true);
        caster->CastSpell(caster, SPELL_WARHEAD_FUSE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_vehicle_warhead_fuse::HandleDummy, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum WarheadDenonate
{
    SPELL_PARACHUTE = 66154,
    SPELL_TORPEDO_EXPLOSION = 49290,
    NPC_ALLIANCE_LUMBERBOAT_EXPLOSIONS = 27689
};
// 49250 - Detonate
class spell_warhead_detonate : public SpellScript
{
    PrepareSpellScript(spell_warhead_detonate);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PARACHUTE, SPELL_TORPEDO_EXPLOSION });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Player* player = GetHitPlayer();
        if (!player || !caster)
        {
            return;
        }

        player->ExitVehicle();
        float horizontalSpeed = 3.0f;
        float verticalSpeed = 40.0f;
        player->KnockbackFrom(caster->GetPositionX(), caster->GetPositionY(), horizontalSpeed, verticalSpeed);
        player->RemoveAurasDueToSpell(SPELL_WARHEAD_FUSE);

        std::list<Creature*> explosionBunnys;
        caster->GetCreatureListWithEntryInGrid(explosionBunnys, NPC_ALLIANCE_LUMBERBOAT_EXPLOSIONS, 90.0f);
        for (auto itr = explosionBunnys.begin(); itr != explosionBunnys.end(); ++itr)
        {
            (*itr)->CastSpell((*itr), SPELL_TORPEDO_EXPLOSION, true);
        }

        if (Creature* rocket = caster->ToCreature())
            rocket->DespawnOrUnsummon();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_warhead_detonate::HandleDummy, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 61678 - Z Check
class spell_z_check_aura : public AuraScript
{
    PrepareAuraScript(spell_z_check_aura);

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        _posZ = GetTarget()->GetPositionZ();
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();

        if (_posZ != GetTarget()->GetPositionZ())
            if (Creature* target = GetTarget()->ToCreature())
                target->AI()->DoCastSelf(SPELL_DETONATE, true);
    }

    private:
    float _posZ;

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_z_check_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_z_check_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 49181 - Warhead Fuse
class spell_warhead_fuse_aura : public AuraScript
{
    PrepareAuraScript(spell_warhead_fuse_aura);

    void HandleOnEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* rocketUnit = GetTarget()->GetVehicleBase())
            if (Creature* rocketCrea = rocketUnit->ToCreature())
                rocketCrea->AI()->DoCastSelf(SPELL_DETONATE, true);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_warhead_fuse_aura::HandleOnEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 62536 - Frog Kiss
class spell_frog_kiss : public SpellScript
{
    PrepareSpellScript(spell_frog_kiss);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WARTSBGONE_LIP_BALM });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
        {
            target->RemoveAurasDueToSpell(SPELL_WARTSBGONE_LIP_BALM);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_frog_kiss::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_grizzly_hills()
{
    new npc_emily();
    new npc_mrfloppy();
    new npc_ravenous_worg();
    RegisterCreatureAI(npc_wounded_skirmisher);
    RegisterSpellScript(spell_renew_skirmisher);
    new npc_venture_co_straggler();
    new npc_lake_frog();
    RegisterSpellScript(spell_shredder_delivery);
    RegisterSpellScript(spell_infected_worgen_bite_aura);
    RegisterSpellScript(spell_z_check_aura);
    RegisterSpellScript(spell_warhead_detonate);
    RegisterSpellScript(spell_vehicle_warhead_fuse);
    RegisterSpellScript(spell_warhead_fuse_aura);
    RegisterSpellScript(spell_q12227_outhouse_groans);
    RegisterSpellScript(spell_q12227_camera_shake);
    RegisterSpellScript(spell_frog_kiss);
}
