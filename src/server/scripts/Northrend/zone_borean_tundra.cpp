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

#include "AreaDefines.h"
#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedFollowerAI.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum eDrakeHunt
{
    SPELL_DRAKE_HATCHLING_SUBDUED       = 46691,
    SPELL_SUBDUED                       = 46675
};

class spell_q11919_q11940_drake_hunt_aura : public AuraScript
{
    PrepareAuraScript(spell_q11919_q11940_drake_hunt_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUBDUED, SPELL_DRAKE_HATCHLING_SUBDUED });
    }

    bool Load() override
    {
        return GetOwner()->IsCreature();
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE || !GetCaster())
            return;

        Creature* owner = GetOwner()->ToCreature();
        owner->RemoveAllAurasExceptType(SPELL_AURA_DUMMY);
        owner->CombatStop(true);
        owner->GetThreatMgr().ClearAllThreat();
        owner->GetMotionMaster()->Clear(false);
        owner->GetMotionMaster()->MoveFollow(GetCaster(), 4.0f, M_PI, MOTION_SLOT_ACTIVE);
        owner->CastSpell(owner, SPELL_SUBDUED, true);
        GetCaster()->CastSpell(GetCaster(), SPELL_DRAKE_HATCHLING_SUBDUED, true);
        owner->SetFaction(FACTION_FRIENDLY);
        owner->SetImmuneToAll(true);
        owner->DespawnOrUnsummon(180s);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_q11919_q11940_drake_hunt_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

/*######
## npc_sinkhole_kill_credit
######*/

enum Sinkhole
{
    GO_EXPLOSIVES_CART            = 188160,
    NPC_SCOURGED_BURROWER         = 26250,
    QUEST_PLUG_THE_SINKHOLES      = 11897,
    SPELL_SET_CART                = 46797,
    SPELL_EXPLODE_CART            = 46799,
    SPELL_SUMMON_CART             = 46798,
    SPELL_SUMMON_WORM             = 46800,
};

class npc_sinkhole_kill_credit : public CreatureScript
{
public:
    npc_sinkhole_kill_credit() : CreatureScript("npc_sinkhole_kill_credit") { }

    struct npc_sinkhole_kill_creditAI : public NullCreatureAI
    {
        npc_sinkhole_kill_creditAI(Creature* creature) : NullCreatureAI(creature) { }

        uint32 phaseTimer;
        uint8  phase;
        ObjectGuid casterGuid;

        void Reset() override
        {
            phaseTimer = 30000;
            phase = 0;
            casterGuid.Clear();
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (phase || spell->Id != SPELL_SET_CART)
                return;

            Player* player = caster->ToPlayer();
            if (player && player->GetQuestStatus(QUEST_PLUG_THE_SINKHOLES) == QUEST_STATUS_INCOMPLETE)
            {
                phase = 1;
                phaseTimer = 0;
                casterGuid = caster->GetGUID();
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!phase)
                return;

            if (phaseTimer <= diff)
            {
                switch (phase)
                {
                    case 1:
                        DoCast(me, SPELL_EXPLODE_CART, true);
                        DoCast(me, SPELL_SUMMON_CART, true);
                        if (GameObject* cart = me->FindNearestGameObject(GO_EXPLOSIVES_CART, 3.0f))
                            cart->SetUInt32Value(GAMEOBJECT_FACTION, 14);
                        phaseTimer = 3000;
                        phase = 2;
                        break;
                    case 2:
                        if (GameObject* cart = me->FindNearestGameObject(GO_EXPLOSIVES_CART, 3.0f))
                            cart->UseDoorOrButton();
                        DoCast(me, SPELL_EXPLODE_CART, true);
                        phaseTimer = 3000;
                        phase = 3;
                        break;
                    case 3:
                        DoCast(me, SPELL_EXPLODE_CART, true);
                        phaseTimer = 2000;
                        phase = 5; // @fixme: phase 4 is missing...
                        break;
                    case 5:
                        DoCast(me, SPELL_SUMMON_WORM, true);
                        if (Unit* worm = me->FindNearestCreature(NPC_SCOURGED_BURROWER, 3.0f))
                        {
                            worm->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                            worm->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                        }
                        phaseTimer = 1000;
                        phase = 6;
                        break;
                    case 6:
                        DoCast(me, SPELL_EXPLODE_CART, true);
                        if (Unit* worm = me->FindNearestCreature(NPC_SCOURGED_BURROWER, 3.0f))
                        {
                            Unit::Kill(me, worm);
                            worm->RemoveDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
                        }
                        phaseTimer = 2000;
                        phase = 7;
                        break;
                    case 7:
                        DoCast(me, SPELL_EXPLODE_CART, true);
                        if (Player* caster = ObjectAccessor::GetPlayer(*me, casterGuid))
                            caster->KilledMonster(me->GetCreatureTemplate(), me->GetGUID());
                        phaseTimer = 5000;
                        phase = 8;
                        break;
                    default:
                        CreatureAI::EnterEvadeMode();
                        break;
                }
            }
            else phaseTimer -= diff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_sinkhole_kill_creditAI(creature);
    }
};

/*######
## npc_khunok_the_behemoth
######*/

enum Khunok
{
    NPC_ORPHANED_MAMMOTH_CALF        = 25861,
    SPELL_MAMMOTH_CALF_ESCORT_CREDIT = 46231
};

class npc_khunok_the_behemoth : public CreatureScript
{
public:
    npc_khunok_the_behemoth() : CreatureScript("npc_khunok_the_behemoth") { }

    struct npc_khunok_the_behemothAI : public ScriptedAI
    {
        npc_khunok_the_behemothAI(Creature* creature) : ScriptedAI(creature) { }

        void MoveInLineOfSight(Unit* who) override

        {
            ScriptedAI::MoveInLineOfSight(who);

            if (!who->IsCreature())
                return;

            if (who->GetEntry() == NPC_ORPHANED_MAMMOTH_CALF && me->IsWithinDistInMap(who, 10.0f))
            {
                if (Unit* owner = who->GetOwner())
                {
                    if (owner->IsPlayer())
                    {
                        owner->CastSpell(owner, SPELL_MAMMOTH_CALF_ESCORT_CREDIT, true);
                        who->ToCreature()->DespawnOrUnsummon();
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_khunok_the_behemothAI(creature);
    }
};

/*######
## npc_iruk
######*/

enum Iruk
{
    GOSSIP_MENU_ID_NPC_IRUK                 = 9280,
    GOSSIP_OPTION_SEARCH_CORPSE             = 0,
    NPC_TEXT_THIS_YOUNG_TUSKARR             = 12585,

    QUEST_SPIRITS_WATCH_OVER_US             = 11961,

    SPELL_CREATE_TOTEM_OF_ISSLIRUK          = 46816
};

class npc_iruk : public CreatureScript
{
public:
    npc_iruk() : CreatureScript("npc_iruk") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_SPIRITS_WATCH_OVER_US) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_MENU_ID_NPC_IRUK, GOSSIP_OPTION_SEARCH_CORPSE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, NPC_TEXT_THIS_YOUNG_TUSKARR, creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);

        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            player->CastSpell(player, SPELL_CREATE_TOTEM_OF_ISSLIRUK, true);
            CloseGossipMenuFor(player);
        }

        return true;
    }
};

/*######
## npc_nerubar_victim
######*/

enum Nerubar
{
    NPC_WARSONG_PEON                        = 25270,
    QUEST_TAKEN_BY_THE_SCOURGE              = 11611,
    SPELL_FREED_WARSONG_MAGE                = 45526,
    SPELL_FREED_WARSONG_SHAMAN              = 45527,
    SPELL_FREED_WARSONG_WARRIOR             = 45514,
    SPELL_FREED_WARSONG_PEON                = 45532
};

const uint32 nerubarVictims[3] =
{
    SPELL_FREED_WARSONG_MAGE, SPELL_FREED_WARSONG_SHAMAN, SPELL_FREED_WARSONG_WARRIOR
};

class npc_nerubar_victim : public CreatureScript
{
public:
    npc_nerubar_victim() : CreatureScript("npc_nerubar_victim") { }

    struct npc_nerubar_victimAI : public NullCreatureAI
    {
        npc_nerubar_victimAI(Creature* creature) : NullCreatureAI(creature) { }

        void JustDied(Unit* killer) override
        {
            if (!killer || !killer->IsPlayer())
            {
                return;
            }

            Player* player = killer->ToPlayer();

            if (player->GetQuestStatus(QUEST_TAKEN_BY_THE_SCOURGE) == QUEST_STATUS_INCOMPLETE)
            {
                uint8 uiRand = urand(0, 99);
                if (uiRand < 40)
                {
                    player->CastSpell(me, SPELL_FREED_WARSONG_PEON, true);
                    player->KilledMonsterCredit(NPC_WARSONG_PEON);
                }
                else if (uiRand < 80)
                {
                    player->CastSpell(me, nerubarVictims[urand(0, 2)], true);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_nerubar_victimAI(creature);
    }
};

/*######
## npc_lurgglbr
######*/

enum Lurgglbr
{
    QUEST_ESCAPE_WINTERFIN_CAVERNS      = 11570,
    GO_CAGE                             = 187369,
    SAY_START_1                         = 0,
    SAY_START_2                         = 1,
    SAY_END_1                           = 2,
    SAY_END_2                           = 3
};

class npc_lurgglbr : public CreatureScript
{
public:
    npc_lurgglbr() : CreatureScript("npc_lurgglbr") { }

    struct npc_lurgglbrAI : public npc_escortAI
    {
        npc_lurgglbrAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 IntroTimer;
        uint32 IntroPhase;

        void Reset() override
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
            {
                IntroTimer = 0;
                IntroPhase = 0;
            }
        }

        void WaypointReached(uint32 waypointId) override
        {
            switch (waypointId)
            {
                case 0:
                    IntroPhase = 1;
                    IntroTimer = 2000;
                    break;
                case 41:
                    IntroPhase = 4;
                    IntroTimer = 2000;
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (IntroPhase)
            {
                if (IntroTimer <= diff)
                {
                    switch (IntroPhase)
                    {
                        case 1:
                            if (Player* player = GetPlayerForEscort())
                                Talk(SAY_START_1, player);
                            IntroPhase = 2;
                            IntroTimer = 7500;
                            break;
                        case 2:
                            Talk(SAY_START_2);
                            IntroPhase = 3;
                            IntroTimer = 7500;
                            break;
                        case 3:
                            me->SetReactState(REACT_AGGRESSIVE);
                            IntroPhase = 0;
                            IntroTimer = 0;
                            break;
                        case 4:
                            Talk(SAY_END_1);
                            IntroPhase = 5;
                            IntroTimer = 8000;
                            break;
                        case 5:
                            if (Player* player = GetPlayerForEscort())
                                Talk(SAY_END_2, player);
                            IntroPhase = 6;
                            IntroTimer = 2500;
                            break;

                        case 6:
                            if (Player* player = GetPlayerForEscort())
                                player->GroupEventHappens(QUEST_ESCAPE_WINTERFIN_CAVERNS, me);
                            IntroPhase = 7;
                            IntroTimer = 2500;
                            break;

                        case 7:
                            me->DespawnOrUnsummon();
                            IntroPhase = 0;
                            IntroTimer = 0;
                            break;
                    }
                }
                else IntroTimer -= diff;
            }
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_lurgglbrAI(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_ESCAPE_WINTERFIN_CAVERNS)
        {
            if (GameObject* go = creature->FindNearestGameObject(GO_CAGE, 5.0f))
                go->UseDoorOrButton();

            if (npc_escortAI* pEscortAI = CAST_AI(npc_lurgglbr::npc_lurgglbrAI, creature->AI()))
            {
                creature->SetWalk(true);
                pEscortAI->Start(true, player->GetGUID());
            }

            creature->SetFaction(player->GetTeamId() == TEAM_ALLIANCE ? FACTION_ESCORTEE_A_PASSIVE : FACTION_ESCORTEE_H_PASSIVE);
            return true;
        }
        return false;
    }
};

/*######
## Quest 11881: Load'er Up
######*/

// NPC 25969: Jenny
enum Jenny
{
    EVENT_JENNY_START_FOLLOW                        = 1,
    EVENT_JENNY_MOVE_TO_FEZZIX                      = 2,
    EVENT_JENNY_DESPAWN                             = 3,
    SPELL_CRATES_CARRIED                            = 46340,
    SPELL_DROP_CRATE                                = 46342,
    SPELL_GIVE_JENNY_CREDIT                         = 46358,
    NPC_FEZZIX_GEARTWIST                            = 25849
};

struct npc_jenny : public FollowerAI
{
    npc_jenny(Creature* creature) : FollowerAI(creature)
    {
        Initialize();
    }

    void Initialize()
    {
        me->SetReactState(REACT_PASSIVE);
        me->CastSpell(me, SPELL_CRATES_CARRIED);

        // can't update follow here, call later
        _events.ScheduleEvent(EVENT_JENNY_START_FOLLOW, 1s);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& /*damage*/, DamageEffectType /*type*/, SpellSchoolMask /*school*/) override
    {
        if (me->HasAura(SPELL_CRATES_CARRIED))
            me->CastSpell(me, SPELL_DROP_CRATE);
        else
            me->DespawnOrUnsummon();
    }

    void UpdateFollowerAI(uint32 diff) override
    {
        _events.Update(diff);

        if (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_JENNY_START_FOLLOW:
                    // This NPC only moves at its fixed speed_run rate in the db
                    // and does not inherit the speed of the target
                    if (TempSummon* summon = me->ToTempSummon())
                        if (Unit* summonerUnit = summon->GetSummonerUnit())
                            if (Player* summoner = summonerUnit->ToPlayer())
                                StartFollow(summoner, 0, nullptr, true, false);
                    break;
                case EVENT_JENNY_MOVE_TO_FEZZIX:
                    me->SetWalk(true);
                    me->GetMotionMaster()->MovePoint(0, _fezzix);
                    _events.ScheduleEvent(EVENT_JENNY_DESPAWN, 7s);
                    break;
                case EVENT_JENNY_DESPAWN:
                    me->DespawnOrUnsummon();
                    break;
            }
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->GetEntry() == NPC_FEZZIX_GEARTWIST && me->IsWithinDistInMap(who, 15.0f))
        {
            if (TempSummon* s = me->ToTempSummon())
                if (Unit* u = s->GetSummonerUnit())
                    if (Player* p = u->ToPlayer())
                        me->CastSpell(p, SPELL_GIVE_JENNY_CREDIT);
            SetFollowComplete(true);
            _fezzix = who->GetPosition();
            _events.ScheduleEvent(EVENT_JENNY_MOVE_TO_FEZZIX, 1s);
        }
    }
private:
    EventMap _events;
    Position _fezzix;
};

// Spell 45625: - Arcane Chains: Character Force Cast
enum ArcaneChains
{
    SPELL_ARCANE_CHAINS_CHARACTER_FORCE_CAST       = 45625,
    SPELL_ARCANE_CHAINS_SUMMON_CHAINED_MAGE_HUNTER = 45626
};

class spell_arcane_chains_character_force_cast : public SpellScript
{
    PrepareSpellScript(spell_arcane_chains_character_force_cast);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ARCANE_CHAINS_SUMMON_CHAINED_MAGE_HUNTER, 45626 });
    }

    void HandleScriptEffect(SpellEffIndex /* effIndex */)
    {
        GetHitUnit()->CastSpell(GetCaster(), SPELL_ARCANE_CHAINS_SUMMON_CHAINED_MAGE_HUNTER, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_SET_FACING & ~TRIGGERED_IGNORE_AURA_INTERRUPT_FLAGS & ~TRIGGERED_IGNORE_CAST_ITEM & ~TRIGGERED_IGNORE_GCD)); // Player cast back 45626 on npc
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_arcane_chains_character_force_cast::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## npc_imprisoned_beryl_sorcerer
######*/
enum ImprisionedBerylSorcerer
{
    SPELL_NEURAL_NEEDLE                 = 45634,
    SPELL_COSMETIC_ENSLAVE_CHAINS_SELF  = 45631,

    NPC_IMPRISONED_BERYL_SORCERER   = 25478,

    SAY_IMPRISIONED_BERYL_1         = 0,
    SAY_IMPRISIONED_BERYL_2         = 1,
    SAY_IMPRISIONED_BERYL_3         = 2,
    SAY_IMPRISIONED_BERYL_4         = 3,
    SAY_IMPRISIONED_BERYL_5         = 4,
    SAY_IMPRISIONED_BERYL_6         = 5,
    SAY_IMPRISIONED_BERYL_7         = 6
};

class npc_imprisoned_beryl_sorcerer : public CreatureScript
{
public:
    npc_imprisoned_beryl_sorcerer() : CreatureScript("npc_imprisoned_beryl_sorcerer") { }

    struct npc_imprisoned_beryl_sorcererAI : public ScriptedAI
    {
        npc_imprisoned_beryl_sorcererAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 rebuff;

        void Reset() override
        {
            if (me->GetReactState() != REACT_PASSIVE)
                me->SetReactState(REACT_PASSIVE);

            rebuff = 0;

            // xinef: correct visuals
            me->UpdatePosition(me->GetPositionX(), me->GetPositionY(), 150.517f, me->GetOrientation(), true);
            me->SetStandState(UNIT_STAND_STATE_SIT_MEDIUM_CHAIR);
        }

        void UpdateAI(uint32 diff) override
        {
            UpdateVictim();

            if (rebuff <= diff)
            {
                if (!me->HasAura(SPELL_COSMETIC_ENSLAVE_CHAINS_SELF))
                {
                    DoCast(me, SPELL_COSMETIC_ENSLAVE_CHAINS_SELF);
                }
                rebuff = 180000;
            }
            else
                rebuff -= diff;

            DoMeleeAttackIfReady();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
        }

        void SpellHit(Unit* unit, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_NEURAL_NEEDLE && unit->IsPlayer())
            {
                if (Player* player = unit->ToPlayer())
                {
                    GotStinged(player->GetGUID());
                }
            }
        }

        void GotStinged(ObjectGuid casterGUID)
        {
            if (Player* caster = ObjectAccessor::GetPlayer(*me, casterGUID))
            {
                uint32 step = caster->GetAuraCount(SPELL_NEURAL_NEEDLE) + 1;
                switch (step)
                {
                    case 1:
                        Talk(SAY_IMPRISIONED_BERYL_1);
                        break;
                    case 2:
                        Talk(SAY_IMPRISIONED_BERYL_2, caster);
                        break;
                    case 3:
                        Talk(SAY_IMPRISIONED_BERYL_3);
                        break;
                    case 4:
                        Talk(SAY_IMPRISIONED_BERYL_4);
                        break;
                    case 5:
                        Talk(SAY_IMPRISIONED_BERYL_5);
                        break;
                    case 6:
                        Talk(SAY_IMPRISIONED_BERYL_6, caster);
                        break;
                    case 7:
                        Talk(SAY_IMPRISIONED_BERYL_7);
                        caster->KilledMonsterCredit(NPC_IMPRISONED_BERYL_SORCERER);
                        break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_imprisoned_beryl_sorcererAI(creature);
    }
};

/*######
## npc_mootoo_the_younger
######*/
enum MootooTheYounger
{
    SAY_1                       = 0,
    SAY_2                       = 1,
    SAY_3                       = 2,
    SAY_4                       = 3,
    SAY_5                       = 4,

    NPC_MOOTOO_THE_YOUNGER      = 25504,
    QUEST_ESCAPING_THE_MIST     = 11664
};

class npc_mootoo_the_younger : public CreatureScript
{
public:
    npc_mootoo_the_younger() : CreatureScript("npc_mootoo_the_younger") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_ESCAPING_THE_MIST)
        {
            creature->SetFaction(player->GetTeamId() == TEAM_ALLIANCE ? FACTION_ESCORTEE_A_PASSIVE : FACTION_ESCORTEE_H_PASSIVE);
            creature->SetStandState(UNIT_STAND_STATE_STAND);
            creature->AI()->Talk(SAY_1, player);
            creature->SetWalk(true);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, player->GetGUID());
        }
        return true;
    }

    struct npc_mootoo_the_youngerAI : public npc_escortAI
    {
        npc_mootoo_the_youngerAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() override
        {
            SetDespawnAtFar(false);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_ESCAPING_THE_MIST);
        }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 10:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    Talk(SAY_2);
                    break;
                case 12:
                    Talk(SAY_3);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LOOT);
                    break;
                case 16:
                    Talk(SAY_4);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    break;
                case 20:
                    me->SetPhaseMask(1, true);
                    Talk(SAY_5);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    player->GroupEventHappens(QUEST_ESCAPING_THE_MIST, me);
                    me->SetWalk(false);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_mootoo_the_youngerAI(creature);
    }
};

/*######
## npc_bonker_togglevolt
######*/

enum BonkerTogglevolt
{
    NPC_BONKER_TOGGLEVOLT   = 25589,
    QUEST_GET_ME_OUTA_HERE  = 11673,

    SAY_BONKER_1            = 0,
    SAY_BONKER_2            = 1
};

class npc_bonker_togglevolt : public CreatureScript
{
public:
    npc_bonker_togglevolt() : CreatureScript("npc_bonker_togglevolt") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_GET_ME_OUTA_HERE)
        {
            creature->SetStandState(UNIT_STAND_STATE_STAND);
            creature->AI()->Talk(SAY_BONKER_2, player);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, player->GetGUID());
        }
        return true;
    }

    struct npc_bonker_togglevoltAI : public npc_escortAI
    {
        npc_bonker_togglevoltAI(Creature* creature) : npc_escortAI(creature) { }
        uint32 Bonker_agro;

        void Reset() override
        {
            Bonker_agro = 0;
            SetDespawnAtFar(false);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_GET_ME_OUTA_HERE);
        }

        void UpdateEscortAI(uint32 /*diff*/) override
        {
            if (GetAttack() && UpdateVictim())
            {
                if (Bonker_agro == 0)
                {
                    Talk(SAY_BONKER_1);
                    Bonker_agro++;
                }
                DoMeleeAttackIfReady();
            }
            else Bonker_agro = 0;
        }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 29:
                    player->GroupEventHappens(QUEST_GET_ME_OUTA_HERE, me);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_bonker_togglevoltAI(creature);
    }
};

/*######
## Help Those That Cannot Help Themselves, Quest 11876
######*/

enum Valiancekeepcannons
{
    GO_VALIANCE_KEEP_CANNON_1                     = 187560,
    GO_VALIANCE_KEEP_CANNON_2                     = 188692
};

class npc_valiance_keep_cannoneer : public CreatureScript
{
public:
    npc_valiance_keep_cannoneer() : CreatureScript("npc_valiance_keep_cannoneer") { }

    struct npc_valiance_keep_cannoneerAI : public ScriptedAI
    {
        npc_valiance_keep_cannoneerAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 uiTimer;

        void Reset() override
        {
            uiTimer = urand(13000, 18000);
        }

        void UpdateAI(uint32 diff) override
        {
            if (uiTimer <= diff)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);
                GameObject* pCannon = me->FindNearestGameObject(GO_VALIANCE_KEEP_CANNON_1, 10);
                if (!pCannon)
                    pCannon = me->FindNearestGameObject(GO_VALIANCE_KEEP_CANNON_2, 10);
                if (pCannon)
                    pCannon->Use(me);
                uiTimer = urand(13000, 18000);
            }
            else uiTimer -= diff;

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_valiance_keep_cannoneerAI(creature);
    }
};

/*******************************************************
 * npc_warmage_coldarra
 *******************************************************/

enum Spells
{
    SPELL_TRANSITUS_SHIELD_BEAM = 48310
};

enum NPCs
{
    NPC_TRANSITUS_SHIELD_DUMMY   = 27306,
    NPC_WARMAGE_HOLLISTER        = 27906,
    NPC_WARMAGE_CALANDRA         = 27173,
    NPC_WARMAGE_WATKINS          = 27904
};

class npc_warmage_coldarra : public CreatureScript
{
public:
    npc_warmage_coldarra() : CreatureScript("npc_warmage_coldarra") { }

    struct npc_warmage_coldarraAI : public ScriptedAI
    {
        npc_warmage_coldarraAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetCombatMovement(false);
        }

        uint32 m_uiTimer;                 //Timer until recast

        void Reset() override
        {
            m_uiTimer = 0;
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void AttackStart(Unit* /*who*/) override { }

        void UpdateAI(uint32 uiDiff) override
        {
            if (m_uiTimer <= uiDiff)
            {
                std::list<Creature*> orbList;
                GetCreatureListWithEntryInGrid(orbList, me, NPC_TRANSITUS_SHIELD_DUMMY, 32.0f);

                switch (me->GetEntry())
                {
                    case NPC_WARMAGE_HOLLISTER:
                        {
                            if (!orbList.empty())
                            {
                                for (std::list<Creature*>::const_iterator itr = orbList.begin(); itr != orbList.end(); ++itr)
                                {
                                    if (Creature* pOrb = *itr)
                                        if (pOrb->GetPositionY() > 6680)
                                            DoCast(pOrb, SPELL_TRANSITUS_SHIELD_BEAM);
                                }
                            }
                            m_uiTimer = urand(90000, 120000);
                        }
                        break;
                    case NPC_WARMAGE_CALANDRA:
                        {
                            if (!orbList.empty())
                            {
                                for (std::list<Creature*>::const_iterator itr = orbList.begin(); itr != orbList.end(); ++itr)
                                {
                                    if (Creature* pOrb = *itr)
                                        if ((pOrb->GetPositionY() < 6680) && (pOrb->GetPositionY() > 6630))
                                            DoCast(pOrb, SPELL_TRANSITUS_SHIELD_BEAM);
                                }
                            }
                            m_uiTimer = urand(90000, 120000);
                        }
                        break;
                    case NPC_WARMAGE_WATKINS:
                        {
                            if (!orbList.empty())
                            {
                                for (std::list<Creature*>::const_iterator itr = orbList.begin(); itr != orbList.end(); ++itr)
                                {
                                    if (Creature* pOrb = *itr)
                                        if (pOrb->GetPositionY() < 6630)
                                            DoCast(pOrb, SPELL_TRANSITUS_SHIELD_BEAM);
                                }
                            }
                            m_uiTimer = urand(90000, 120000);
                        }
                        break;
                }
            }
            else m_uiTimer -= uiDiff;

            ScriptedAI::UpdateAI(uiDiff);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_warmage_coldarraAI(creature);
    }
};

/*######
## Quest 11794: The hunt is on
######*/

// NPCs 25827: Tom Hegger, 25248: Salty John Thorpe, 25828: Guard Mitchells
enum HiddenCultist
{
    SPELL_SHROUD_OF_THE_DEATH_CULTIST = 46077,
    SPELL_RIGHTEOUS_VISION            = 46078,
    NPC_TOM_HEGGER                    = 25827,
    NPC_SALTY_JOHN_THORPE             = 25248,
    NPC_GUARD_MITCHELLS               = 25828,
    SAY_HIDDEN_CULTIST_1              = 0,
    SAY_HIDDEN_CULTIST_2              = 1,
    SAY_HIDDEN_CULTIST_3              = 2,
    SAY_HIDDEN_CULTIST_4              = 3,
    EVENT_CULTIST_SCRIPT_1            = 1,
    EVENT_CULTIST_SCRIPT_2            = 2,
    EVENT_CULTIST_SCRIPT_3            = 3
};

class npc_hidden_cultist : public CreatureScript
{
public:
    npc_hidden_cultist() : CreatureScript("npc_hidden_cultist") { }

    struct npc_hidden_cultistAI : public ScriptedAI
    {
        npc_hidden_cultistAI(Creature* creature) : ScriptedAI(creature)
        {
            Initialize();
            _emoteState = creature->GetUInt32Value(UNIT_NPC_EMOTESTATE);
            _npcFlags   = creature->GetNpcFlags();
        }

        void Initialize()
        {
            _playerGUID.Clear();
        }

        void Reset() override
        {
            if (_emoteState)
            {
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, _emoteState);
            }

            if (_npcFlags)
            {
                me->ReplaceAllNpcFlags(_npcFlags);
            }

            Initialize();
            DoCast(SPELL_SHROUD_OF_THE_DEATH_CULTIST);
            me->RestoreFaction();
        }

        void PreScript()
        {
            me->StopMoving();
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
            {
                me->SetFacingToObject(player);
            }
            _events.ScheduleEvent(EVENT_CULTIST_SCRIPT_1, 3s);
        }

        void AttackPlayer()
        {
            me->SetFaction(FACTION_MONSTER);
            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
            {
                AttackStart(player);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CULTIST_SCRIPT_1:
                    {
                        switch (me->GetEntry())
                        {
                            case NPC_SALTY_JOHN_THORPE:
                                Talk(SAY_HIDDEN_CULTIST_1);
                                _events.ScheduleEvent(EVENT_CULTIST_SCRIPT_2, 5s);
                                break;
                            case NPC_GUARD_MITCHELLS:
                                Talk(SAY_HIDDEN_CULTIST_2);
                                _events.ScheduleEvent(EVENT_CULTIST_SCRIPT_2, 5s);
                                break;
                            case NPC_TOM_HEGGER:
                                if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                                {
                                    Talk(SAY_HIDDEN_CULTIST_3, player);
                                }
                                _events.ScheduleEvent(EVENT_CULTIST_SCRIPT_2, 5s);
                                break;
                        }
                        break;
                    }
                    case EVENT_CULTIST_SCRIPT_2:
                    {
                        switch (me->GetEntry())
                        {
                            case NPC_SALTY_JOHN_THORPE:
                                Talk(SAY_HIDDEN_CULTIST_4);
                                if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                                {
                                    me->SetFacingToObject(player);
                                }
                                _events.ScheduleEvent(EVENT_CULTIST_SCRIPT_3, 3s);
                                break;
                            case NPC_GUARD_MITCHELLS:
                            case NPC_TOM_HEGGER:
                                AttackPlayer();
                                break;
                        }
                        break;
                    }
                    case EVENT_CULTIST_SCRIPT_3:
                    {
                        if (me->GetEntry() == NPC_SALTY_JOHN_THORPE)
                        {
                            AttackPlayer();
                        }
                        break;
                    }
                    default:
                        break;
                }
            }

            if (!UpdateVictim())
            {
                return;
            }

            DoMeleeAttackIfReady();
        }

        void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
        {
            if (gossipListId == 0)
            {
                CloseGossipMenuFor(player);
                _playerGUID = player->GetGUID();
                PreScript();
            }
        }
        private:
            EventMap   _events;
            uint32     _emoteState;
            NPCFlags   _npcFlags;
            ObjectGuid _playerGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_hidden_cultistAI(creature);
    }
};

enum BloodsporeRuination
{
    NPC_BLOODMAGE_LAURITH   = 25381,
    SAY_BLOODMAGE_LAURITH   = 0,
    EVENT_TALK              = 1,
    EVENT_RESET_ORIENTATION
};

class spell_q11719_bloodspore_ruination_45997 : public SpellScript
{
    PrepareSpellScript(spell_q11719_bloodspore_ruination_45997);

    void HandleEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            if (Creature* laurith = caster->FindNearestCreature(NPC_BLOODMAGE_LAURITH, 100.0f))
                laurith->AI()->SetGUID(caster->GetGUID());
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q11719_bloodspore_ruination_45997::HandleEffect, EFFECT_1, SPELL_EFFECT_SEND_EVENT);
    }
};

class npc_bloodmage_laurith : public CreatureScript
{
public:
    npc_bloodmage_laurith() : CreatureScript("npc_bloodmage_laurith") { }

    struct npc_bloodmage_laurithAI : public ScriptedAI
    {
        npc_bloodmage_laurithAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            _events.Reset();
            _playerGUID.Clear();
        }

        void SetGUID(ObjectGuid const& guid, int32 /*action*/) override
        {
            if (_playerGUID)
                return;

            _playerGUID = guid;

            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                me->SetFacingToObject(player);

            _events.ScheduleEvent(EVENT_TALK, 1s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (UpdateVictim())
            {
                DoMeleeAttackIfReady();
                return;
            }

            _events.Update(diff);

            if (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_TALK:
                        if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                            Talk(SAY_BLOODMAGE_LAURITH, player);
                        _playerGUID.Clear();
                        _events.ScheduleEvent(EVENT_RESET_ORIENTATION, 5s);
                        break;
                    case EVENT_RESET_ORIENTATION:
                        me->SetFacingTo(me->GetHomePosition().GetOrientation());
                        break;
                }
            }
        }

    private:
        EventMap _events;
        ObjectGuid _playerGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_bloodmage_laurithAI(creature);
    }
};

// 45612 - Necropolis Beam
class spell_necropolis_beam: public SpellScript
{
    PrepareSpellScript(spell_necropolis_beam);

    void SetDest(SpellDestination& dest)
    {
        Unit* caster = GetCaster();
        float floorZ = caster->GetMapHeight(caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ());
        if (floorZ > INVALID_HEIGHT)
            dest._position.m_positionZ = floorZ;
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_necropolis_beam::SetDest, EFFECT_0, TARGET_DEST_CASTER);
    }
};

enum SoulDeflectionSpells
{
    SPELL_SOUL_DEFLECTION_DAMAGE = 51011
};

class spell_soul_deflection : public AuraScript
{
    PrepareAuraScript(spell_soul_deflection);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SOUL_DEFLECTION_DAMAGE });
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetDamageInfo() || !eventInfo.GetDamageInfo()->GetDamage() || !GetTarget())
            return;

        GetCaster()->CastCustomSpell(SPELL_SOUL_DEFLECTION_DAMAGE, SPELLVALUE_BASE_POINT0, eventInfo.GetDamageInfo()->GetDamage(), GetTarget(), true);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_soul_deflection::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

enum SpellBloodHaze
{
    SPELL_BLOODSPORE_HAZE = 50380,
    SPELL_PSYCHOSIS       = 50396
};

// 50380 - Bloodspore Haze
class spell_bloodspore_haze : public SpellScript
{
    PrepareSpellScript(spell_bloodspore_haze);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PSYCHOSIS });
    }

    void HandleEffectHit(SpellEffIndex /*effIndex*/)
    {
        if (!GetHitUnit())
            return;

        if (GetHitUnit()->GetAuraCount(SPELL_BLOODSPORE_HAZE) >= 5)
        {
            GetHitUnit()->CastSpell(GetHitUnit(), SPELL_PSYCHOSIS, true);
            GetHitUnit()->RemoveAura(SPELL_BLOODSPORE_HAZE);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_bloodspore_haze::HandleEffectHit, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_borean_tundra()
{
    RegisterSpellScript(spell_q11919_q11940_drake_hunt_aura);
    new npc_sinkhole_kill_credit();
    new npc_khunok_the_behemoth();
    new npc_iruk();
    new npc_nerubar_victim();
    new npc_lurgglbr();
    RegisterSpellScript(spell_arcane_chains_character_force_cast);
    new npc_imprisoned_beryl_sorcerer();
    new npc_mootoo_the_younger();
    new npc_bonker_togglevolt();
    new npc_valiance_keep_cannoneer();
    new npc_warmage_coldarra();
    new npc_hidden_cultist();
    RegisterSpellScript(spell_q11719_bloodspore_ruination_45997);
    new npc_bloodmage_laurith();
    RegisterCreatureAI(npc_jenny);
    RegisterSpellScript(spell_necropolis_beam);
    RegisterSpellScript(spell_soul_deflection);
    RegisterSpellScript(spell_bloodspore_haze);
}
