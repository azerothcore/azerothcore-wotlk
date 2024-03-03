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
#include "ScriptedEscortAI.h"
#include "ScriptedFollowerAI.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

// Ours
enum eDrakeHunt
{
    SPELL_DRAKE_HATCHLING_SUBDUED       = 46691,
    SPELL_SUBDUED                       = 46675
};

class spell_q11919_q11940_drake_hunt : public SpellScriptLoader
{
public:
    spell_q11919_q11940_drake_hunt() : SpellScriptLoader("spell_q11919_q11940_drake_hunt") { }

    class spell_q11919_q11940_drake_hunt_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_q11919_q11940_drake_hunt_AuraScript)

        bool Load() override
        {
            return GetOwner()->GetTypeId() == TYPEID_UNIT;
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
            owner->DespawnOrUnsummon(3 * MINUTE * IN_MILLISECONDS);
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_q11919_q11940_drake_hunt_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_q11919_q11940_drake_hunt_AuraScript();
    }
};

// Theirs
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

            if (who->GetTypeId() != TYPEID_UNIT)
                return;

            if (who->GetEntry() == NPC_ORPHANED_MAMMOTH_CALF && me->IsWithinDistInMap(who, 10.0f))
            {
                if (Unit* owner = who->GetOwner())
                {
                    if (owner->GetTypeId() == TYPEID_PLAYER)
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
            if (!killer || killer->GetTypeId() != TYPEID_PLAYER)
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
                                player->AreaExploredOrEventHappens(QUEST_ESCAPE_WINTERFIN_CAVERNS);
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
                pEscortAI->Start(true, false, player->GetGUID());

            creature->SetFaction(player->GetTeamId() == TEAM_ALLIANCE ? FACTION_ESCORTEE_A_PASSIVE : FACTION_ESCORTEE_H_PASSIVE);
            return true;
        }
        return false;
    }
};

/*######
## Quest 11590: Abduction
######*/

// NPC 25316: Beryl Sorcerer
enum BerylSorcerer
{
    EVENT_FROSTBOLT                                = 1,
    EVENT_ARCANE_CHAINS                            = 2,
    NPC_LIBRARIAN_DONATHAN                         = 25262,
    NPC_CAPTURED_BERLY_SORCERER                    = 25474,
    SPELL_FROSTBOLT                                = 9672,
    SPELL_ARCANE_CHAINS                            = 45611,
    SPELL_ARCANE_CHAINS_CHARACTER_FORCE_CAST       = 45625,
    SPELL_ARCANE_CHAINS_SUMMON_CHAINED_MAGE_HUNTER = 45626,
    SPELL_COSMETIC_ENSLAVE_CHAINS_SELF             = 45631,
    SPELL_ARCANE_CHAINS_CHANNEL_II                 = 45735
};

class npc_beryl_sorcerer : public CreatureScript
{
public:
    npc_beryl_sorcerer() : CreatureScript("npc_beryl_sorcerer") { }

struct npc_beryl_sorcererAI : public CreatureAI
    {
        npc_beryl_sorcererAI(Creature* creature) : CreatureAI(creature)
        {
            Initialize();
        }

        void Initialize()
        {
            _playerGUID.Clear();
            _chainsCast = false;
        }

        void Reset() override
        {
            me->SetReactState(REACT_AGGRESSIVE);
            Initialize();
        }

        void JustEngagedWith(Unit* who) override
        {
            if (me->IsValidAttackTarget(who))
            {
                AttackStart(who);
            }

            _events.ScheduleEvent(EVENT_FROSTBOLT, 3000, 4000);
        }

        void SpellHit(Unit* unit, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_ARCANE_CHAINS && !_chainsCast)
            {
                if (Player* player = unit->ToPlayer())
                {
                    _playerGUID = player->GetGUID();
                    _chainsCast = true;
                    _events.ScheduleEvent(EVENT_ARCANE_CHAINS, 4s);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            _events.Update(diff);

            if (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_FROSTBOLT:
                        DoCastVictim(SPELL_FROSTBOLT);
                        _events.ScheduleEvent(EVENT_FROSTBOLT, 3s, 4s);
                        break;
                    case EVENT_ARCANE_CHAINS:
                        if (me->HasAura(SPELL_ARCANE_CHAINS))
                        {
                            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                            {
                                me->CastSpell(player, SPELL_ARCANE_CHAINS_CHARACTER_FORCE_CAST, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_AURA_INTERRUPT_FLAGS & ~TRIGGERED_IGNORE_CAST_ITEM));
                                player->KilledMonsterCredit(NPC_CAPTURED_BERLY_SORCERER);
                                me->DisappearAndDie();
                            }
                        }
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }

    private:
        EventMap   _events;
        ObjectGuid _playerGUID;
        bool       _chainsCast;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_beryl_sorcererAI(creature);
    }
};

// NPC 25474: Captured Beryl Sorcerer
enum CapturedBerylSorcerer
{
    EVENT_ADD_ARCANE_CHAINS                        = 1,
    EVENT_FOLLOW_PLAYER                            = 2
};

class npc_captured_beryl_sorcerer : public CreatureScript
{
public:
    npc_captured_beryl_sorcerer() : CreatureScript("npc_captured_beryl_sorcerer") {}

    struct npc_captured_beryl_sorcererAI : public FollowerAI
    {
        npc_captured_beryl_sorcererAI(Creature* creature) : FollowerAI(creature)
        {
            Initialize();
        }

        void Initialize()
        {
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            _events.ScheduleEvent(EVENT_ADD_ARCANE_CHAINS, 0ms);
        }

        void Reset() override
        {
            Initialize();
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            if (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ADD_ARCANE_CHAINS:
                        if (Player* summoner = me->ToTempSummon()->GetSummonerUnit()->ToPlayer())
                        {
                            summoner->CastSpell(summoner, SPELL_ARCANE_CHAINS_CHANNEL_II, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_AURA_INTERRUPT_FLAGS & ~TRIGGERED_IGNORE_CAST_ITEM & ~TRIGGERED_IGNORE_POWER_AND_REAGENT_COST & ~TRIGGERED_IGNORE_GCD));
                            _events.ScheduleEvent(EVENT_FOLLOW_PLAYER, 1s);
                        }
                        break;
                    case EVENT_FOLLOW_PLAYER:
                        if (Player* summoner = me->ToTempSummon()->GetSummonerUnit()->ToPlayer())
                        {
                            StartFollow(summoner);
                        }
                        break;
                }
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            FollowerAI::MoveInLineOfSight(who);

            if (who->GetEntry() == NPC_LIBRARIAN_DONATHAN && me->IsWithinDistInMap(who, INTERACTION_DISTANCE))
            {
                SetFollowComplete();
                me->DespawnOrUnsummon();
            }
        }
    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_captured_beryl_sorcererAI(creature);
    }
};

// Spell 45625: - Arcane Chains: Character Force Cast
class spell_arcane_chains_character_force_cast : public SpellScriptLoader
{
public:
    spell_arcane_chains_character_force_cast() : SpellScriptLoader("spell_arcane_chains_character_force_cast") {}

    class spell_arcane_chains_character_force_cast_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_arcane_chains_character_force_cast_SpellScript);

        void HandleScriptEffect(SpellEffIndex /* effIndex */)
        {
            GetHitUnit()->CastSpell(GetCaster(), SPELL_ARCANE_CHAINS_SUMMON_CHAINED_MAGE_HUNTER, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_SET_FACING & ~TRIGGERED_IGNORE_AURA_INTERRUPT_FLAGS & ~TRIGGERED_IGNORE_CAST_ITEM & ~TRIGGERED_IGNORE_GCD)); // Player cast back 45626 on npc
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_arcane_chains_character_force_cast_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_arcane_chains_character_force_cast_SpellScript();
    }
};

/*######
## npc_imprisoned_beryl_sorcerer
######*/
enum ImprisionedBerylSorcerer
{
    SPELL_NEURAL_NEEDLE             = 45634,

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
            if (spell->Id == SPELL_NEURAL_NEEDLE && unit->GetTypeId() == TYPEID_PLAYER)
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
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, false, player->GetGUID());
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
                    SetRun(true);
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
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, true, player->GetGUID());
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

class spell_q11719_bloodspore_ruination_45997 : public SpellScriptLoader
{
public:
    spell_q11719_bloodspore_ruination_45997() : SpellScriptLoader("spell_q11719_bloodspore_ruination_45997") { }

    class spell_q11719_bloodspore_ruination_45997_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_q11719_bloodspore_ruination_45997_SpellScript);

        void HandleEffect(SpellEffIndex /*effIndex*/)
        {
            if (Unit* caster = GetCaster())
                if (Creature* laurith = caster->FindNearestCreature(NPC_BLOODMAGE_LAURITH, 100.0f))
                    laurith->AI()->SetGUID(caster->GetGUID());
        }

        void Register() override
        {
            OnEffectHit += SpellEffectFn(spell_q11719_bloodspore_ruination_45997_SpellScript::HandleEffect, EFFECT_1, SPELL_EFFECT_SEND_EVENT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_q11719_bloodspore_ruination_45997_SpellScript();
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

        void SetGUID(ObjectGuid guid, int32 /*action*/) override
        {
            if (_playerGUID)
                return;

            _playerGUID = guid;

            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                me->SetFacingToObject(player);

            _events.ScheduleEvent(EVENT_TALK, 1000);
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

/*######
## Quest 12019: Last Rites
######*/

// NPC 26170: Thassarian
enum Thassarian
{
    EVENT_THASSARIAN_SCRIPT_1     = 1,
    EVENT_THASSARIAN_SCRIPT_2     = 2,
    EVENT_THASSARIAN_SCRIPT_3     = 3,
    EVENT_THASSARIAN_SCRIPT_4     = 4,
    EVENT_THASSARIAN_SCRIPT_5     = 5,
    EVENT_THASSARIAN_SCRIPT_6     = 6,
    EVENT_THASSARIAN_SCRIPT_7     = 7,
    EVENT_THASSARIAN_SCRIPT_8     = 8,
    EVENT_THASSARIAN_SCRIPT_9     = 9,
    EVENT_THASSARIAN_SCRIPT_10    = 10,
    EVENT_THASSARIAN_SCRIPT_11    = 11,
    EVENT_THASSARIAN_SCRIPT_12    = 12,
    EVENT_THASSARIAN_SCRIPT_13    = 13,
    EVENT_THASSARIAN_SCRIPT_14    = 14,
    EVENT_THASSARIAN_SCRIPT_15    = 15,
    EVENT_THASSARIAN_SCRIPT_16    = 16,
    EVENT_THASSARIAN_SCRIPT_17    = 17,
    EVENT_THASSARIAN_SCRIPT_18    = 18,
    EVENT_THASSARIAN_SCRIPT_19    = 19,
    EVENT_THASSARIAN_SCRIPT_20    = 20,
    EVENT_THASSARIAN_SCRIPT_21    = 21,
    EVENT_THASSARIAN_SCRIPT_22    = 22,
    EVENT_THASSARIAN_SCRIPT_23    = 23,
    EVENT_THASSARIAN_SCRIPT_24    = 24,
    EVENT_THASSARIAN_SCRIPT_25    = 25,
    EVENT_THASSARIAN_SCRIPT_26    = 26,
    EVENT_THASSARIAN_SCRIPT_27    = 27,
    EVENT_THASSARIAN_SCRIPT_28    = 28,
    EVENT_THASSARIAN_SCRIPT_29    = 29,
    EVENT_THASSARIAN_CAST         = 30,
    NPC_IMAGE_LICH_KING           = 26203,
    NPC_COUNSELOR_TALBOT          = 25301,
    NPC_PRINCE_VALANAR            = 28189,
    NPC_GENERAL_ARLOS             = 25250,
    NPC_LERYSSA                   = 25251,
    NPC_TANATHAL                  = 26173,
    SPELL_THASSARIAN_FLAY         = 46685,
    SPELL_TRANSFORM_VALANAR       = 46753,
    SPELL_BLOOD_PRESENCE          = 50995,
    SAY_THASSARIAN_1              = 0,
    SAY_THASSARIAN_2              = 1,
    SAY_THASSARIAN_3              = 2,
    SAY_THASSARIAN_4              = 3,
    SAY_THASSARIAN_5              = 4,
    SAY_THASSARIAN_6              = 5,
    SAY_THASSARIAN_7              = 6,
    SAY_TALBOT_1                  = 0,
    SAY_TALBOT_2                  = 1,
    SAY_TALBOT_3                  = 2,
    SAY_TALBOT_4                  = 3,
    SAY_LICH_1                    = 0,
    SAY_LICH_2                    = 1,
    SAY_LICH_3                    = 2,
    SAY_ARLOS_1                   = 0,
    SAY_ARLOS_2                   = 1,
    SAY_LERYSSA_1                 = 0,
    SAY_LERYSSA_2                 = 1,
    SAY_LERYSSA_3                 = 2,
    SAY_LERYSSA_4                 = 3,
    PATH_THASSARIAN               = 1013030,
    PATH_ARTHAS                   = 1013031,
    PATH_TALBOT                   = 1013032,
    PATH_ARLOS                    = 1013033,
    PATH_LERYSSA                  = 1013034
};

class npc_thassarian : public CreatureScript
{
public:
    npc_thassarian() : CreatureScript("npc_thassarian") {}

    struct npc_thassarianAI : public ScriptedAI
    {
        npc_thassarianAI(Creature* creature) : ScriptedAI(creature){}

        void Reset() override
        {
            me->SetImmuneToAll(true);
            _events.ScheduleEvent(EVENT_THASSARIAN_CAST, 1000);
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            if (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_THASSARIAN_CAST:
                    {
                        if (Unit* tanathal = me->FindNearestCreature(NPC_TANATHAL, 10.0f))
                        {
                            me->CastSpell(tanathal, SPELL_THASSARIAN_FLAY);
                        }
                    }
                }
            }
        }
    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_thassarianAI(creature);
    }
};

class npc_thassarian2 : public CreatureScript
{
public:
    npc_thassarian2() : CreatureScript("npc_thassarian2") {}

    struct npc_thassarian2AI : public ScriptedAI
    {
        npc_thassarian2AI(Creature* creature) : ScriptedAI(creature)
        {
            Initialize();
        }

        void Initialize()
        {
            _arthasGUID.Clear();
            _talbotGUID.Clear();
            _leryssaGUID.Clear();
            _arlosGUID.Clear();
        }

        void Reset() override
        {
            me->SetFaction(FACTION_VALIANCE_EXPEDITION_7);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            Initialize();
        }

        void SetData(uint32 /*type*/, uint32 data) override
        {
            switch (data)
            {
                case NPC_LERYSSA:
                {
                    if (Creature* arlos = ObjectAccessor::GetCreature(*me, _arlosGUID))
                    {
                        arlos->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STUN);
                    }
                    if (Creature* leryssa = ObjectAccessor::GetCreature(*me, _leryssaGUID))
                    {
                        leryssa->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STUN);
                        leryssa->SetOrientation(4.537856f);
                    }
                    _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_8, 1s);
                    break;
                }
                case NPC_COUNSELOR_TALBOT:
                {
                    _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_18, 0ms);
                }
                    break;
                default:
                    break;
            }
        }

        void MovementInform(uint32 type, uint32 param) override
        {
            if (type == WAYPOINT_MOTION_TYPE && param == 2)
            {
                me->SetWalk(false);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY1H);
                _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_1, 2s);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            if (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_THASSARIAN_SCRIPT_1:
                        // Summon Arthas and Talbot
                        if (Creature* arthas = me->SummonCreature(NPC_IMAGE_LICH_KING, 3729.4614f, 3520.386f, 473.4048f, 1.361f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 120000))
                        {
                            _arthasGUID = arthas->GetGUID();
                            arthas->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            arthas->SetReactState(REACT_PASSIVE);
                            arthas->SetWalk(true);
                        }
                        if (Creature* talbot = me->SummonCreature(NPC_COUNSELOR_TALBOT, 3748.7627f, 3614.0374f, 473.4048f, 4.5553f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 120000))
                        {
                            _talbotGUID = talbot->GetGUID();
                            talbot->SetWalk(true);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_2, 1s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_2:
                        // Arthas load path
                        if (Creature* arthas = ObjectAccessor::GetCreature(*me, _arthasGUID))
                        {
                            arthas->GetMotionMaster()->MovePath(PATH_ARTHAS, false);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_3, 1s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_3:
                        // Talbot load path
                        if (Creature* talbot = ObjectAccessor::GetCreature(*me, _talbotGUID))
                        {
                            talbot->GetMotionMaster()->MovePath(PATH_TALBOT, false);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_4, 20s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_4:
                        // Talbot transform and knell
                        if (Creature* talbot = ObjectAccessor::GetCreature(*me, _talbotGUID))
                        {
                            talbot->CastSpell(talbot, SPELL_TRANSFORM_VALANAR);
                            talbot->UpdateEntry(NPC_PRINCE_VALANAR);
                            talbot->SetFullHealth();
                            talbot->SetFaction(FACTION_UNDEAD_SCOURGE);
                            talbot->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            talbot->SetReactState(REACT_PASSIVE);
                            talbot->SetStandState(UNIT_STAND_STATE_KNEEL);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_5, 7s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_5:
                        // Talbot say text 1
                        if (Creature* talbot = ObjectAccessor::GetCreature(*me, _talbotGUID))
                        {
                            talbot->AI()->Talk(SAY_TALBOT_1);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_6, 9s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_6:
                        // Summon General Arlos and Leryssa
                        if (Creature* arlos = me->SummonCreature(NPC_GENERAL_ARLOS, 3746.2825f, 3616.3699f, 473.4048f, 4.5029f, TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                        {
                            _arlosGUID = arlos->GetGUID();
                            arlos->SetWalk(true);
                            arlos->SetImmuneToAll(true);
                            arlos->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                            arlos->GetMotionMaster()->MovePath(PATH_ARLOS, false);
                        }
                        if (Creature* leryssa = me->SummonCreature(NPC_LERYSSA, 3751.0986f, 3614.9219f, 473.4048f, 4.5029f, TEMPSUMMON_CORPSE_TIMED_DESPAWN))
                        {
                            _leryssaGUID = leryssa->GetGUID();
                            leryssa->SetWalk(true);
                            leryssa->SetImmuneToAll(true);
                            leryssa->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                            leryssa->GetMotionMaster()->MovePath(PATH_LERYSSA, false);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_7, 7s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_7:
                        // Talbot say text 2
                        if (Creature* talbot = ObjectAccessor::GetCreature(*me, _talbotGUID))
                        {
                            talbot->AI()->Talk(SAY_TALBOT_2);
                        }
                        break;
                    case EVENT_THASSARIAN_SCRIPT_8:
                        // Thassarian say text 1 and move to location
                        Talk(SAY_THASSARIAN_1);
                        me->SetWalk(false);
                        me->GetMotionMaster()->MovePoint(0, 3722.527f, 3567.2583f, 477.44086f);
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_9, 7s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_9:
                        // Thassarian say text 2
                        Talk(SAY_THASSARIAN_2);
                        me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_10, 6s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_10:
                        // Arthas turn to Thassarian and Talbot stand
                        if (Creature* arthas = ObjectAccessor::GetCreature(*me, _arthasGUID))
                        {
                            arthas->SetFacingToObject(me);
                        }
                        if (Creature* talbot = ObjectAccessor::GetCreature(*me, _talbotGUID))
                        {
                            talbot->SetStandState(UNIT_STAND_STATE_STAND);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_11, 4s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_11:
                        // Arthas say text 2
                        if (Creature* arthas = ObjectAccessor::GetCreature(*me, _arthasGUID))
                        {
                            arthas->AI()->Talk(SAY_LICH_2);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_12, 18s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_12:
                        // Thassarian say text 3
                        Talk(SAY_THASSARIAN_3);
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_13, 10s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_13:
                        // Talbot say text 3
                        if (Creature* talbot = ObjectAccessor::GetCreature(*me, _talbotGUID))
                        {
                            talbot->AI()->Talk(SAY_TALBOT_3);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_14, 5s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_14:
                        // Arthas turn to Talbot say text 3
                        if (Creature* arthas = ObjectAccessor::GetCreature(*me, _arthasGUID))
                        {
                            if (Creature* talbot = ObjectAccessor::GetCreature(*me, _talbotGUID))
                            {
                                arthas->SetFacingToObject(talbot);
                            }
                            arthas->AI()->Talk(SAY_LICH_3);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_15, 5s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_15:
                        // Arthas turn to me and emote
                        if (Creature* arthas = ObjectAccessor::GetCreature(*me, _arthasGUID))
                        {
                            arthas->SetFacingToObject(me);
                            arthas->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_16, 5s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_16:
                        // Arthas despawn
                        if (Creature* arthas = ObjectAccessor::GetCreature(*me, _arthasGUID))
                        {
                            arthas->RemoveFromWorld();
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_17, 3s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_17:
                        // Talbot say text 4 and attack
                        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        if (Creature* talbot = ObjectAccessor::GetCreature(*me, _talbotGUID))
                        {
                            talbot->AI()->Talk(SAY_TALBOT_4);
                            talbot->SetFaction(FACTION_UNDEAD_SCOURGE_9);
                            talbot->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            talbot->SetReactState(REACT_AGGRESSIVE);
                            talbot->Attack(me, false);
                        }
                        break;
                    case EVENT_THASSARIAN_SCRIPT_18:
                        // Arlos say text 1
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY1H);
                        if (Creature* arlos = ObjectAccessor::GetCreature(*me, _arlosGUID))
                        {
                            arlos->AI()->Talk(SAY_ARLOS_1);
                            arlos->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                            arlos->SetStandState(UNIT_STAND_STATE_KNEEL);
                        }
                        if (Creature* leryssa = ObjectAccessor::GetCreature(*me, _leryssaGUID))
                        {
                            leryssa->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_19, 3s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_19:
                        // Leryssa set facing to me
                        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                        if (Creature* leryssa = me->FindNearestCreature(NPC_LERYSSA, 50.0f, true))
                        {
                            _leryssaGUID = leryssa->GetGUID();
                            leryssa->SetFacingToObject(me);
                            me->SetFacingToObject(leryssa);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_20, 3s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_20:
                        // Arlos say text 2 and die. Leryssa say text 1
                        if (Creature* arlos = me->FindNearestCreature(NPC_GENERAL_ARLOS, 50.0f, true))
                        {
                            _arlosGUID = arlos->GetGUID();
                            arlos->AI()->Talk(SAY_ARLOS_2);
                            arlos->SetStandState(UNIT_STAND_STATE_DEAD);
                        }
                        if (Creature* leryssa = ObjectAccessor::GetCreature(*me, _leryssaGUID))
                        {
                            leryssa->AI()->Talk(SAY_LERYSSA_1);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_21, 5s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_21:
                        // Thassarian say text 4
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        Talk(SAY_THASSARIAN_4);
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_22, 3s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_22:
                        // Leryssa run to Thassarian
                        if (Creature* leryssa = ObjectAccessor::GetCreature(*me, _leryssaGUID))
                        {
                            leryssa->SetWalk(false);
                            leryssa->MonsterMoveWithSpeed(3726.751f, 3568.1633f, 477.44086f, leryssa->GetSpeed(MOVE_RUN));
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_23, 2s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_23:
                        // Leryssa say text 2
                        if (Creature* leryssa = ObjectAccessor::GetCreature(*me, _leryssaGUID))
                        {
                            leryssa->AI()->Talk(SAY_LERYSSA_2);
                            leryssa->SetStandState(UNIT_STAND_STATE_SIT);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_24, 5s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_24:
                        // Thassarian say text 5
                        Talk(SAY_THASSARIAN_5);
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_25, 10s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_25:
                        // Leryssa say text 3
                        if (Creature* leryssa = ObjectAccessor::GetCreature(*me, _leryssaGUID))
                        {
                            leryssa->AI()->Talk(SAY_LERYSSA_3);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_26, 12s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_26:
                        // Thassarian say text 6
                        Talk(SAY_THASSARIAN_6);
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_27, 11s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_27:
                        // Leryssa say text 4
                        if (Creature* leryssa = ObjectAccessor::GetCreature(*me, _leryssaGUID))
                        {
                            leryssa->AI()->Talk(SAY_LERYSSA_4);
                        }
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_28, 12s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_28:
                        // Thassarian say text 7
                        Talk(SAY_THASSARIAN_7);
                        _events.ScheduleEvent(EVENT_THASSARIAN_SCRIPT_29, 35s);
                        break;
                    case EVENT_THASSARIAN_SCRIPT_29:
                        Cleanup();
                        me->DespawnOrUnsummon(30s, 120s);
                        break;
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

        void JustDied(Unit* /*killer*/) override
        {
            Cleanup();
            me->DespawnOrUnsummon(1s, 120s);
        }

        void Cleanup()
        {
            if (Creature* talbot = ObjectAccessor::GetCreature(*me, _talbotGUID))
            {
                talbot->RemoveFromWorld();
            }

            if (Creature* leryssa = ObjectAccessor::GetCreature(*me, _leryssaGUID))
            {
                leryssa->RemoveFromWorld();
            }

            if (Creature* arlos = ObjectAccessor::GetCreature(*me, _arlosGUID))
            {
                arlos->RemoveFromWorld();
            }

            if (Creature* arthas = ObjectAccessor::GetCreature(*me, _arthasGUID))
            {
                arthas->RemoveFromWorld();
            }
        }

        void sGossipHello(Player* /*player*/) override
        {
            if (!me->HasAura(SPELL_BLOOD_PRESENCE))
            {
                DoCastSelf(SPELL_BLOOD_PRESENCE);
            }
        }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32 action) override
        {
            if (action == 0)
            {
                _playerGUID = player->GetGUID();
                CloseGossipMenuFor(player);
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->GetMotionMaster()->MovePath(PATH_THASSARIAN, false);
            }
        }

    private:
        EventMap   _events;
        ObjectGuid _playerGUID;
        ObjectGuid _arthasGUID;
        ObjectGuid _talbotGUID;
        ObjectGuid _leryssaGUID;
        ObjectGuid _arlosGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_thassarian2AI(creature);
    }
};

// NPC 25251: Leryssa
class npc_leryssa : public CreatureScript
{
public:
    npc_leryssa() : CreatureScript("npc_leryssa") {}

    struct npc_leryssaAI : public ScriptedAI
    {
        npc_leryssaAI(Creature* creature) : ScriptedAI(creature) {}

        void MovementInform(uint32 type, uint32 param) override
        {
            if (type == WAYPOINT_MOTION_TYPE && param == 2)
            {
                if (me->IsSummon())
                {
                    if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                    {
                        summoner->ToCreature()->AI()->SetData(1, NPC_LERYSSA);
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_leryssaAI(creature);
    }
};

// NPC 25301: Counselor Talbot
enum CounselorTalbot
{
    AREA_LAST_RITES     = 4128,
    SPELL_DEFLECTION    = 51009,
    SPELL_SOUL_BLAST    = 50992,
    SPELL_VAMPIRIC_BOLT = 51016,
    EVENT_DEFLECTION    = 1,
    EVENT_SOUL_BLAST    = 2,
    EVENT_VAMPIRIC_BOLT = 3
};

class npc_counselor_talbot : public CreatureScript
{
public:
    npc_counselor_talbot() : CreatureScript("npc_counselor_talbot") {}

    struct npc_counselor_talbotAI : public ScriptedAI
    {
        npc_counselor_talbotAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() override {}

        void JustEngagedWith(Unit* /*who*/) override
        {
            _events.ScheduleEvent(EVENT_DEFLECTION, 10s, 20s);
            _events.ScheduleEvent(EVENT_SOUL_BLAST, 4s, 6s);
            _events.ScheduleEvent(EVENT_VAMPIRIC_BOLT, 0ms);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            if (me->GetAreaId() == AREA_LAST_RITES)
            {
                _events.Update(diff);

                if (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_DEFLECTION:
                            DoCastSelf(SPELL_DEFLECTION);
                            _events.ScheduleEvent(EVENT_DEFLECTION, 10s, 20s);
                            break;
                        case EVENT_SOUL_BLAST:
                            DoCastVictim(SPELL_SOUL_BLAST);
                            _events.ScheduleEvent(EVENT_SOUL_BLAST, 4s, 6s);
                            break;
                        case EVENT_VAMPIRIC_BOLT:
                            DoCastVictim(SPELL_VAMPIRIC_BOLT);
                            _events.ScheduleEvent(EVENT_VAMPIRIC_BOLT, 3s, 4s);
                            break;
                        default:
                            break;
                    }
                }
            }
            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (me->IsSummon())
            {
                if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                {
                    summoner->ToCreature()->AI()->SetData(1, NPC_COUNSELOR_TALBOT);
                }
            }
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_counselor_talbotAI(creature);
    }
};

void AddSC_borean_tundra()
{
    // Ours
    new spell_q11919_q11940_drake_hunt();
    new npc_thassarian();
    new npc_thassarian2();
    new npc_leryssa();
    new npc_counselor_talbot();

    // Theirs
    new npc_sinkhole_kill_credit();
    new npc_khunok_the_behemoth();
    new npc_iruk();
    new npc_nerubar_victim();
    new npc_lurgglbr();
    new npc_beryl_sorcerer();
    new npc_captured_beryl_sorcerer();
    new spell_arcane_chains_character_force_cast();
    new npc_imprisoned_beryl_sorcerer();
    new npc_mootoo_the_younger();
    new npc_bonker_togglevolt();
    new npc_valiance_keep_cannoneer();
    new npc_warmage_coldarra();
    new npc_hidden_cultist();
    new spell_q11719_bloodspore_ruination_45997();
    new npc_bloodmage_laurith();
}

