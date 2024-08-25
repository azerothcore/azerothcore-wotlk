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

#include "CombatAI.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "WaypointMgr.h"

// Ours
enum qSniffing
{
    SPELL_SUMMON_PURSUERS_PERIODIC          = 54993,
    SPELL_SNIFFING_CREDIT                   = 55477,
};

class npc_frosthound : public CreatureScript
{
public:
    npc_frosthound() : CreatureScript("npc_frosthound") { }

    struct npc_frosthoundAI : public npc_escortAI
    {
        npc_frosthoundAI(Creature* creature) : npc_escortAI(creature) {}

        void AttackStart(Unit* /*who*/) override {}
        void JustEngagedWith(Unit* /*who*/) override {}
        void EnterEvadeMode(EvadeReason /* why */) override {}

        void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                if (apply)
                {
                    me->SetFaction(who->GetFaction());
                    me->CastSpell(me, SPELL_SUMMON_PURSUERS_PERIODIC, true);
                    Start(false, true, who->GetGUID());
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
        }

        void OnCharmed(bool /*apply*/) override
        {
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;
        }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 0:
                    me->TextEmote("You've been seen! Use the net and Freezing elixir to keep the dwarves away!", nullptr, true);
                    break;
                case 19:
                    me->TextEmote("The frosthound has located the thief's hiding place. Confront him!", 0, true);
                    if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                        summoner->ToPlayer()->KilledMonsterCredit(29677);
                    break;
            }
        }

        void JustSummoned(Creature* cr) override
        {
            cr->ToTempSummon()->SetTempSummonType(TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT);
            cr->ToTempSummon()->InitStats(20000);
            if (urand(0, 1))
                cr->GetMotionMaster()->MoveFollow(me, 0.0f, 0.0f);
            else if (cr->AI())
                cr->AI()->AttackStart(me);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_frosthoundAI(creature);
    }
};

enum eIronWatcher
{
    SPELL_THUNDERING_STOMP          = 60925,
    SPELL_STORM_HAMMER              = 56448,
    SPELL_SHATTERED_EYES            = 57290,
    SPELL_STORM_HAMMER_DUMMY        = 60930,
};

class npc_iron_watcher : public CreatureScript
{
public:
    npc_iron_watcher() : CreatureScript("npc_iron_watcher") { }

    struct npc_iron_watcherAI : public ScriptedAI
    {
        npc_iron_watcherAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 spellTimer;
        uint32 hpTimer;
        bool charging;

        void Reset() override
        {
            spellTimer = 0;
            hpTimer = 0;
            charging = false;
            me->SetControlled(false, UNIT_STATE_STUNNED);
        }

        void MovementInform(uint32 type, uint32  /*pointId*/) override
        {
            if (type == POINT_MOTION_TYPE)
                me->SetControlled(true, UNIT_STATE_STUNNED);
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_STORM_HAMMER)
            {
                me->CastSpell(caster, SPELL_STORM_HAMMER_DUMMY, true);
                if (charging)
                {
                    me->RemoveAllAurasExceptType(SPELL_AURA_MECHANIC_IMMUNITY);
                    Talk(1);
                    caster->ToPlayer()->KilledMonsterCredit(me->GetEntry());
                    me->DespawnOrUnsummon(8000);
                    me->GetMotionMaster()->MoveJump(8721.94f, -1955, 963, 70.0f, 30.0f);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (charging)
                return;

            if (!UpdateVictim())
                return;

            spellTimer += diff;
            hpTimer += diff;
            if (spellTimer >= 10000)
            {
                me->CastSpell(me, SPELL_THUNDERING_STOMP, false);
                spellTimer = 0;
            }
            if (hpTimer >= 1000)
            {
                if (me->HealthBelowPct(40))
                {
                    Talk(0);
                    me->RemoveAllAuras();
                    me->CastSpell(me, SPELL_SHATTERED_EYES, true);
                    me->ApplySpellImmune(SPELL_SHATTERED_EYES, IMMUNITY_MECHANIC, MECHANIC_STUN, false);
                    me->GetMotionMaster()->MoveCharge(8548, -1956, 1467.8f);
                    charging = true;
                }
                hpTimer = 0;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_iron_watcherAI(creature);
    }
};

enum eTimeLost
{
    NPC_TIME_LOST_PROTO_DRAKE   = 32491,
    NPC_VYRAGOSA                = 32630,

    SPELL_TIME_SHIFT            = 61084,
    SPELL_TIME_LAPSE            = 51020,
    SPELL_FROST_BREATH          = 47425,
    SPELL_FROST_CLEAVE          = 51857,
};

class npc_time_lost_proto_drake : public CreatureScript
{
public:
    npc_time_lost_proto_drake() : CreatureScript("npc_time_lost_proto_drake") { }

    struct npc_time_lost_proto_drakeAI : public npc_escortAI
    {
        npc_time_lost_proto_drakeAI(Creature* creature) : npc_escortAI(creature)
        {
            rollPath = false;
            setVisible = false;
            me->setActive(true);
            me->SetVisible(false);
        }

        EventMap events;
        bool rollPath;
        bool setVisible;

        void Reset() override
        {
            npc_escortAI::Reset();
            if (me->HasUnitState(UNIT_STATE_EVADE))
                return;
            me->SetVisible(false); // pussywizard: zeby nie dostawali info o npc w miejscu spawna (kampienie z addonem npc scan)
            rollPath = true;
        }

        void RollPath()
        {
            me->SetEntry(NPC_TIME_LOST_PROTO_DRAKE);
            Start(true, true, ObjectGuid::Empty, 0, false, true, true);
            SetNextWaypoint(urand(0, 250), true);
            me->UpdateEntry(roll_chance_i(25) ? NPC_TIME_LOST_PROTO_DRAKE : NPC_VYRAGOSA, 0, false);
        }

        void WaypointReached(uint32  /*pointId*/) override { }

        void JustEngagedWith(Unit*) override
        {
            events.Reset();
            if (me->GetEntry() == NPC_TIME_LOST_PROTO_DRAKE)
            {
                events.ScheduleEvent(SPELL_TIME_SHIFT, 10s);
                events.ScheduleEvent(SPELL_TIME_LAPSE, 5s);
            }
            else
            {
                events.ScheduleEvent(SPELL_FROST_BREATH, 8s);
                events.ScheduleEvent(SPELL_FROST_CLEAVE, 5s);
            }
        }

        void UpdateEscortAI(uint32 diff) override
        {
            if (rollPath)
            {
                RollPath();
                rollPath = false;
                setVisible = true;
                return;
            }

            if (setVisible)
            {
                me->SetVisible(true);
                setVisible = false;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case SPELL_TIME_SHIFT:
                    me->CastSpell(me, SPELL_TIME_SHIFT, false);
                    events.Repeat(18s);
                    break;
                case SPELL_TIME_LAPSE:
                    me->CastSpell(me->GetVictim(), SPELL_TIME_LAPSE, false);
                    events.Repeat(12s);
                    break;
                case SPELL_FROST_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_FROST_BREATH, false);
                    events.Repeat(12s);
                    break;
                case SPELL_FROST_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_FROST_CLEAVE, false);
                    events.Repeat(8s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_time_lost_proto_drakeAI(creature);
    }
};

enum eWildWyrm
{
    SPELL_FIGHT_WYRM_BASE           = 56673,
    SPELL_FIGHT_WYRM_NEXT           = 60863,
    SPELL_SPEAR_OF_HODIR            = 56671,
    SPELL_DODGE_CLAWS               = 56704,
    SPELL_WYRM_GRIP                 = 56689,
    SPELL_GRAB_ON                   = 60533,
    SPELL_THRUST_SPEAR              = 56690,
    SPELL_MIGHTY_SPEAR_THRUST       = 60586,
    SPELL_FATAL_STRIKE              = 60587,
    SPELL_PRY_JAWS_OPEN             = 56706,
    SPELL_JAWS_OF_DEATH             = 56692,
};

class npc_wild_wyrm : public CreatureScript
{
public:
    npc_wild_wyrm() : CreatureScript("npc_wild_wyrm") { }

    struct npc_wild_wyrmAI : public ScriptedAI
    {
        npc_wild_wyrmAI(Creature* creature) : ScriptedAI(creature) {}

        ObjectGuid playerGUID;
        uint32 checkTimer;
        uint32 announceAttackTimer;
        uint32 attackTimer;
        bool setCharm;
        bool switching;
        bool startPath;

        void EnterEvadeMode(EvadeReason why) override
        {
            if (switching || me->HasAuraType(SPELL_AURA_CONTROL_VEHICLE))
                return;
            ScriptedAI::EnterEvadeMode(why);
        }

        void Reset() override
        {
            me->SetRegeneratingHealth(true);
            me->SetSpeed(MOVE_RUN, 1.14f, true); // ZOMG!
            setCharm = false;
            switching = false;
            startPath = false;
            checkTimer = 0;
            playerGUID.Clear();
            attackTimer = 0;
            announceAttackTimer = 0;
            me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
        }

        void PassengerBoarded(Unit*, int8, bool apply) override
        {
            if (!apply && me->IsAlive() && me->HasAura(SPELL_WYRM_GRIP))
                me->RemoveAurasDueToSpell(SPELL_WYRM_GRIP);
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            if (type == POINT_MOTION_TYPE && pointId == 1 && !me->GetCharmerGUID())
            {
                if (Player* player = GetValidPlayer())
                {
                    checkTimer = 1;
                    me->SetFullHealth();
                    player->CastSpell(me, SPELL_FIGHT_WYRM_BASE, true);
                    me->CastSpell(me, SPELL_WYRM_GRIP, true);
                    me->SetRegeneratingHealth(false);
                }
            }
            else if (type == ESCORT_MOTION_TYPE && me->movespline->Finalized())
                startPath = true;
            else if (type == EFFECT_MOTION_TYPE && pointId == me->GetEntry())
                me->KillSelf();
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (who != me)
            {
                damage = 0;
                if (!GetValidPlayer())
                    setCharm = true; // will enter evade on next update
            }
        }

        void AttackStart(Unit*) override { }
        void MoveInLineOfSight(Unit*  /*who*/) override { }

        void OnCharmed(bool apply) override
        {
            if (apply)
                setCharm = true;
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            if (!playerGUID && spellInfo->Id == SPELL_SPEAR_OF_HODIR)
            {
                me->GetMotionMaster()->MovePoint(1, caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ() + 12.0f);
                playerGUID = caster->GetGUID();
            }
            else if (spellInfo->Id == SPELL_GRAB_ON)
            {
                if (Aura* aura = me->GetAura(SPELL_WYRM_GRIP))
                    aura->ModStackAmount(10);
            }
            else if (spellInfo->Id == SPELL_THRUST_SPEAR)
            {
                if (Aura* aura = me->GetAura(SPELL_WYRM_GRIP))
                    aura->ModStackAmount(-5);
            }
            else if (spellInfo->Id == SPELL_MIGHTY_SPEAR_THRUST)
            {
                if (Aura* aura = me->GetAura(SPELL_WYRM_GRIP))
                    aura->ModStackAmount(-15);
            }
            else if (spellInfo->Id == SPELL_FATAL_STRIKE)
            {
                if (roll_chance_i(me->GetAuraCount(SPELL_PRY_JAWS_OPEN) * 10))
                {
                    if (Player* player = GetValidPlayer())
                    {
                        player->KilledMonsterCredit(30415);
                        player->RemoveAurasDueToSpell(SPELL_JAWS_OF_DEATH);
                    }
                    me->SetStandState(UNIT_STAND_STATE_DEAD);
                    me->GetMotionMaster()->MoveFall(me->GetEntry());
                }
                else
                    Talk(2);
            }
        }

        Player* GetValidPlayer()
        {
            Player* charmer = ObjectAccessor::GetPlayer(*me, playerGUID);
            if (charmer && charmer->IsAlive() && me->GetDistance(charmer) < 20.0f)
                return charmer;
            return nullptr;
        }

        void UpdateAI(uint32 diff) override
        {
            if (startPath)
            {
                startPath = false;
                Movement::PointsArray pathPoints;
                pathPoints.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));

                WaypointPath const* i_path = sWaypointMgr->GetPath(me->GetWaypointPath());
                for (uint8 i = 0; i < i_path->size(); ++i)
                {
                    WaypointData const* node = i_path->at(i);
                    pathPoints.push_back(G3D::Vector3(node->x, node->y, node->z));
                }

                me->GetMotionMaster()->MoveSplinePath(&pathPoints);
            }
            if (setCharm)
            {
                setCharm = false;

                if (Player* charmer = GetValidPlayer())
                {
                    me->SetFaction(FACTION_MONSTER_2);
                    charmer->SetClientControl(me, 0, true);

                    me->SetSpeed(MOVE_RUN, 2.0f, true);
                    startPath = true;
                }
                else
                {
                    me->RemoveAllAuras();
                    EnterEvadeMode(EVADE_REASON_OTHER);
                }
                return;
            }

            if (!checkTimer)
                return;

            if (checkTimer < 10000)
            {
                checkTimer += diff;
                if (checkTimer >= 2000)
                {
                    checkTimer = 1;
                    if (me->HealthBelowPct(25))
                    {
                        if (Player* player = GetValidPlayer())
                        {
                            Talk(3);
                            switching = true;
                            me->RemoveAllAuras();
                            me->CastSpell(me, SPELL_JAWS_OF_DEATH, true);
                            player->CastSpell(me, SPELL_FIGHT_WYRM_NEXT, true);
                            checkTimer = 10000;
                            return;
                        }
                        else
                        {
                            me->RemoveAllAuras();
                            EnterEvadeMode(EVADE_REASON_OTHER);
                            return;
                        }
                    }
                }
            }
            else if (checkTimer < 20000)
            {
                checkTimer += diff;
                if (checkTimer >= 13000)
                {
                    switching = false;
                    checkTimer = 20000;
                }
            }
            else if (checkTimer < 30000)
            {
                checkTimer += diff;
                if (checkTimer >= 22000)
                {
                    checkTimer = 20000;
                    Player* player = GetValidPlayer();
                    if (!player)
                    {
                        me->RemoveAllAuras();
                        EnterEvadeMode(EVADE_REASON_OTHER);
                    }
                }
                return;
            }

            announceAttackTimer += diff;
            if (announceAttackTimer >= 7000)
            {
                announceAttackTimer = urand(0, 3000);
                Talk(0);
                attackTimer = 1;
            }
            if (attackTimer)
            {
                attackTimer += diff;
                if (attackTimer > 2000)
                {
                    attackTimer = 0;
                    Player* player = ObjectAccessor::GetPlayer(*me, playerGUID);
                    if (player && player->HasAura(SPELL_DODGE_CLAWS))
                        Talk(1);
                    else if (player)
                        me->AttackerStateUpdate(player);
                    else
                    {
                        me->RemoveAllAuras();
                        EnterEvadeMode(EVADE_REASON_OTHER);
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_wild_wyrmAI(creature);
    }
};

class spell_q13003_thursting_hodirs_spear_aura : public AuraScript
{
    PrepareAuraScript(spell_q13003_thursting_hodirs_spear_aura);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        ModStackAmount(60);
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* creature = GetUnitOwner()->ToCreature())
        {
            if (!creature->IsInEvadeMode())
            {
                creature->RemoveAllAuras();
                creature->AI()->EnterEvadeMode();
            }
        }
    }

    void HandlePeriodic(AuraEffect const* /* aurEff */)
    {
        ModStackAmount(-1);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_q13003_thursting_hodirs_spear_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectApply += AuraEffectApplyFn(spell_q13003_thursting_hodirs_spear_aura::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_q13003_thursting_hodirs_spear_aura::AfterRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

enum q13007IronColossus
{
    SPELL_JORMUNGAR_SUBMERGE        = 56504,
    SPELL_JORMUNGAR_EMERGE          = 56508,
    SPELL_JORMUNGAR_SUBMERGE_VISUAL = 56512,
    SPELL_COLOSSUS_GROUND_SLAM      = 61673
};

class spell_q13007_iron_colossus : public SpellScript
{
    PrepareSpellScript(spell_q13007_iron_colossus);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_JORMUNGAR_SUBMERGE_VISUAL, SPELL_COLOSSUS_GROUND_SLAM });
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Creature* caster = GetCaster()->ToCreature();
        if (!caster)
            return;

        if (GetSpellInfo()->Id == SPELL_JORMUNGAR_SUBMERGE)
        {
            caster->CastSpell(caster, SPELL_JORMUNGAR_SUBMERGE_VISUAL, true);
            caster->ApplySpellImmune(SPELL_COLOSSUS_GROUND_SLAM, IMMUNITY_ID, SPELL_COLOSSUS_GROUND_SLAM, true);
            caster->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            caster->SetControlled(false, UNIT_STATE_ROOT);
            for (uint8 i = 0; i < MAX_CREATURE_SPELLS; ++i)
                caster->m_spells[i] = 0;

            caster->m_spells[0] = SPELL_JORMUNGAR_EMERGE;
        }
        else
        {
            caster->RemoveAurasDueToSpell(SPELL_JORMUNGAR_SUBMERGE_VISUAL);
            caster->ApplySpellImmune(SPELL_COLOSSUS_GROUND_SLAM, IMMUNITY_ID, SPELL_COLOSSUS_GROUND_SLAM, false);
            caster->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            caster->SetControlled(true, UNIT_STATE_ROOT);

            if (CreatureTemplate const* ct = sObjectMgr->GetCreatureTemplate(caster->GetEntry()))
                for (uint8 i = 0; i < MAX_CREATURE_SPELLS; ++i)
                    caster->m_spells[i] = ct->spells[i];
        }

        if (Player* player = caster->GetCharmerOrOwnerPlayerOrPlayerItself())
            player->VehicleSpellInitialize();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q13007_iron_colossus::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// Theirs
/*######
## npc_roxi_ramrocket
######*/

enum RoxiRamrocket
{
    SPELL_MECHANO_HOG               = 60866,
    SPELL_MEKGINEERS_CHOPPER        = 60867
};

class npc_roxi_ramrocket : public CreatureScript
{
public:
    npc_roxi_ramrocket() : CreatureScript("npc_roxi_ramrocket") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        //Quest Menu
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        //Trainer Menu
        if ( creature->IsTrainer() )
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);

        //Vendor Menu
        if ( creature->IsVendor() )
            if (player->HasSpell(SPELL_MECHANO_HOG) || player->HasSpell(SPELL_MEKGINEERS_CHOPPER))
                AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_TRAIN:
                player->GetSession()->SendTrainerList(creature->GetGUID());
                break;
            case GOSSIP_ACTION_TRADE:
                player->GetSession()->SendListInventory(creature->GetGUID());
                break;
        }
        return true;
    }
};

/*######
## npc_brunnhildar_prisoner
######*/

enum BrunnhildarPrisoner
{
    SPELL_ICE_PRISON           = 54894,
    SPELL_ICE_LANCE            = 55046,
    SPELL_FREE_PRISONER        = 55048,
    SPELL_RIDE_DRAKE           = 55074,
    SPELL_SHARD_IMPACT         = 55047
};

class npc_brunnhildar_prisoner : public CreatureScript
{
public:
    npc_brunnhildar_prisoner() : CreatureScript("npc_brunnhildar_prisoner") { }

    struct npc_brunnhildar_prisonerAI : public ScriptedAI
    {
        npc_brunnhildar_prisonerAI(Creature* creature) : ScriptedAI(creature) { }

        bool freed;

        void Reset() override
        {
            freed = false;
            me->CastSpell(me, SPELL_ICE_PRISON, true);
        }

        void JustRespawned() override
        {
            Reset();
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (!freed)
                return;

            if (!me->GetVehicle())
                me->DespawnOrUnsummon();
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id != SPELL_ICE_LANCE)
                return;

            if (caster->GetVehicleKit()->GetAvailableSeatCount() != 0)
            {
                me->CastSpell(me, SPELL_FREE_PRISONER, true);
                me->CastSpell(caster, SPELL_RIDE_DRAKE, true);
                me->CastSpell(me, SPELL_SHARD_IMPACT, true);
                freed = true;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_brunnhildar_prisonerAI(creature);
    }
};

/*######
## npc_freed_protodrake
######*/

enum FreedProtoDrake
{
    NPC_DRAKE                           = 29709,

    AREA_VALLEY_OF_ANCIENT_WINTERS      = 4437,

    TEXT_EMOTE                          = 0,

    SPELL_KILL_CREDIT_PRISONER          = 55144,
    SPELL_SUMMON_LIBERATED              = 55073,
    SPELL_KILL_CREDIT_DRAKE             = 55143,

    EVENT_CHECK_AREA                    = 1,
    EVENT_REACHED_HOME                  = 2,
};

class npc_freed_protodrake : public CreatureScript
{
public:
    npc_freed_protodrake() : CreatureScript("npc_freed_protodrake") { }

    struct npc_freed_protodrakeAI : public VehicleAI
    {
        npc_freed_protodrakeAI(Creature* creature) : VehicleAI(creature) { }

        EventMap events;

        void Reset() override
        {
            events.ScheduleEvent(EVENT_CHECK_AREA, 5s);
            me->SetSpeed(MOVE_RUN, 2.0f);
        }

        void MovementInform(uint32 type, uint32  /*id*/) override
        {
            if (type == ESCORT_MOTION_TYPE && me->movespline->Finalized())
                events.ScheduleEvent(EVENT_REACHED_HOME, 2s);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_CHECK_AREA:
                    if (me->GetAreaId() == AREA_VALLEY_OF_ANCIENT_WINTERS)
                    {
                        if (Vehicle* vehicle = me->GetVehicleKit())
                            if (Unit* passenger = vehicle->GetPassenger(0))
                            {
                                Talk(TEXT_EMOTE, passenger);

                                Movement::PointsArray pathPoints;
                                pathPoints.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));

                                WaypointPath const* i_path = sWaypointMgr->GetPath(NPC_DRAKE);
                                for (uint8 i = 0; i < i_path->size(); ++i)
                                {
                                    WaypointData const* node = i_path->at(i);
                                    pathPoints.push_back(G3D::Vector3(node->x, node->y, node->z));
                                }

                                me->GetMotionMaster()->MoveSplinePath(&pathPoints);
                            }
                    }
                    else
                        events.ScheduleEvent(EVENT_CHECK_AREA, 5s);
                    break;
                case EVENT_REACHED_HOME:
                    if (Vehicle* vehicle = me->GetVehicleKit())
                        if (Unit* player = vehicle->GetPassenger(0))
                            if (player->GetTypeId() == TYPEID_PLAYER)
                            {
                                // for each prisoner on drake, give credit
                                for (uint8 i = 1; i < 4; ++i)
                                    if (Unit* prisoner = me->GetVehicleKit()->GetPassenger(i))
                                    {
                                        if (prisoner->GetTypeId() != TYPEID_UNIT)
                                            return;
                                        prisoner->CastSpell(player, SPELL_KILL_CREDIT_PRISONER, true);
                                        prisoner->CastSpell(prisoner, SPELL_SUMMON_LIBERATED, true);
                                        prisoner->ExitVehicle();
                                    }
                                me->CastSpell(me, SPELL_KILL_CREDIT_DRAKE, true);
                                player->ExitVehicle();
                            }
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_freed_protodrakeAI(creature);
    }
};

class npc_icefang : public CreatureScript
{
public:
    npc_icefang() : CreatureScript("npc_icefang") { }

    struct npc_icefangAI : public npc_escortAI
    {
        npc_icefangAI(Creature* creature) : npc_escortAI(creature) { }

        void AttackStart(Unit* /*who*/) override { }
        void JustEngagedWith(Unit* /*who*/) override { }
        void EnterEvadeMode(EvadeReason /*why*/) override { }

        void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                if (apply)
                    Start(false, true, who->GetGUID());
            }
        }

        void WaypointReached(uint32 /*waypointId*/) override { }
        void JustDied(Unit* /*killer*/) override { }
        void OnCharmed(bool /*apply*/) override { }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_icefangAI(creature);
    }
};

class npc_hyldsmeet_protodrake : public CreatureScript
{
    enum NPCs
    {
        NPC_HYLDSMEET_DRAKERIDER = 29694
    };

public:
    npc_hyldsmeet_protodrake() : CreatureScript("npc_hyldsmeet_protodrake") { }

    class npc_hyldsmeet_protodrakeAI : public CreatureAI
    {
    public:
        npc_hyldsmeet_protodrakeAI(Creature* creature) : CreatureAI(creature), _accessoryRespawnTimer(0), _vehicleKit(creature->GetVehicleKit()) { }

        void PassengerBoarded(Unit* who, int8 /*seat*/, bool apply) override
        {
            if (apply)
            {
                class DelayedTransportPositionOffsets : public BasicEvent
                {
                    public:
                        DelayedTransportPositionOffsets(Unit* owner) : _owner(owner) { }

                        bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
                        {
                            _owner->m_movementInfo.transport.pos.Relocate(-3.5f, 0.f, -0.2f, 0.f);
                            return true;
                        }

                    private:
                        Unit* _owner;
                };

                if (who->IsPlayer())
                    who->m_Events.AddEvent(new DelayedTransportPositionOffsets(who), who->m_Events.CalculateTime(500));

                return;
            }

            if (who->GetEntry() == NPC_HYLDSMEET_DRAKERIDER)
                _accessoryRespawnTimer = 5 * MINUTE * IN_MILLISECONDS;
        }

        void UpdateAI(uint32 diff) override
        {
            //! We need to manually reinstall accessories because the vehicle itself is friendly to players,
            //! so EnterEvadeMode is never triggered. The accessory on the other hand is hostile and killable.
            if (_accessoryRespawnTimer && _accessoryRespawnTimer <= diff && _vehicleKit)
            {
                _vehicleKit->InstallAllAccessories(true);
                _accessoryRespawnTimer = 0;
            }
            else
                _accessoryRespawnTimer -= diff;
        }

    private:
        uint32 _accessoryRespawnTimer;
        Vehicle* _vehicleKit;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_hyldsmeet_protodrakeAI(creature);
    }
};

enum CloseRift
{
    SPELL_DESPAWN_RIFT          = 61665
};

class spell_close_rift_aura : public AuraScript
{
    PrepareAuraScript(spell_close_rift_aura);

    bool Load() override
    {
        _counter = 0;
        return true;
    }

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_DESPAWN_RIFT });
    }

    void HandlePeriodic(AuraEffect const* /* aurEff */)
    {
        if (++_counter == 5)
            GetTarget()->CastSpell((Unit*)nullptr, SPELL_DESPAWN_RIFT, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_close_rift_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }

private:
    uint8 _counter;
};

enum CollapsingCave
{
    SPELL_COLLAPSING_CAVE = 55486
};

// 55693 - Remove Collapsing Cave Aura
class spell_q12823_remove_collapsing_cave_aura : public SpellScript
{
    PrepareSpellScript(spell_q12823_remove_collapsing_cave_aura);

    void HandleScriptEffect(SpellEffIndex /* effIndex */)
    {
        GetHitUnit()->RemoveAurasDueToSpell(SPELL_COLLAPSING_CAVE);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12823_remove_collapsing_cave_aura::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

//Generic Fix for Quest WhenAllElseFails ID: 12862
enum WhenAllElseFailsAlliance
{
    // Creature
    NPC_PROPELLED_DEVICE_1      = 30477,
    NPC_PROPELLED_DEVICE_2      = 30487,

    // Spell
    SPELL_EJECT_PLAYER          = 68576,
    SPELL_KNOCKBACK_PLAYER      = 42895
};

class npc_vehicle_d16_propelled_delivery : public CreatureScript
{
public:
    npc_vehicle_d16_propelled_delivery() : CreatureScript("npc_vehicle_d16_propelled_delivery") { }

    struct npc_vehicle_d16_propelled_deliveryAI : public VehicleAI
    {
        npc_vehicle_d16_propelled_deliveryAI(Creature* creature) : VehicleAI(creature) { }

        void PassengerBoarded(Unit* /*who*/, int8 /*seatId*/, bool apply) override
        {
            if (apply)
            {
                Movement::PointsArray pathPoints;
                pathPoints.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                WaypointPath const* i_path = sWaypointMgr->GetPath(me->GetEntry() * 100);
                for (uint8 i = 0; i < i_path->size(); ++i)
                {
                    WaypointData const* node = i_path->at(i);
                    pathPoints.push_back(G3D::Vector3(node->x, node->y, node->z));
                }
                me->GetMotionMaster()->MoveSplinePath(&pathPoints);
                me->SetCanFly(true);
                me->SetDisableGravity(true);
                me->SetSpeed(MOVE_RUN, 6.0f);
                me->SetSpeedRate(MOVE_FLIGHT, 8.0f);
                me->setActive(true);
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != ESCORT_MOTION_TYPE)
                return;

            switch (id)
            {
                case 12:
                    if (me->GetEntry() == NPC_PROPELLED_DEVICE_2)
                    {
                        if (Vehicle* vehicle = me->GetVehicleKit())
                        {
                            if (Unit* player = vehicle->GetPassenger(0))
                            {
                                if (player->GetTypeId() == TYPEID_PLAYER)
                                {
                                    player->m_Events.AddEventAtOffset([player]()
                                    {
                                        player->CastSpell(player, SPELL_KNOCKBACK_PLAYER, true);
                                    }, 1s);
                                }
                            }
                        }

                        DoCastSelf(SPELL_EJECT_PLAYER);
                    }
                    break;
                case 17:
                    if (me->GetEntry() == NPC_PROPELLED_DEVICE_1)
                    {
                        if (Vehicle* vehicle = me->GetVehicleKit())
                        {
                            if (Unit* player = vehicle->GetPassenger(0))
                            {
                                if (player->GetTypeId() == TYPEID_PLAYER)
                                {
                                    player->m_Events.AddEventAtOffset([player]()
                                    {
                                        player->CastSpell(player, SPELL_KNOCKBACK_PLAYER, true);
                                    }, 1s);
                                }
                            }
                        }

                        DoCastSelf(SPELL_EJECT_PLAYER);
                    }
                    else
                    {
                        me->DespawnOrUnsummon(100);
                    }
                    break;
                case 24:
                    if (me->GetEntry() == NPC_PROPELLED_DEVICE_1)
                    {
                        me->DespawnOrUnsummon(100);
                    }
                    break;
                default:
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_vehicle_d16_propelled_deliveryAI(creature);
    }
};
void AddSC_storm_peaks()
{
    new npc_frosthound();
    new npc_iron_watcher();
    new npc_time_lost_proto_drake();
    new npc_wild_wyrm();
    RegisterSpellScript(spell_q13003_thursting_hodirs_spear_aura);
    RegisterSpellScript(spell_q13007_iron_colossus);
    new npc_roxi_ramrocket();
    new npc_brunnhildar_prisoner();
    new npc_freed_protodrake();
    new npc_icefang();
    new npc_hyldsmeet_protodrake();
    RegisterSpellScript(spell_close_rift_aura);
    new npc_vehicle_d16_propelled_delivery();
    RegisterSpellScript(spell_q12823_remove_collapsing_cave_aura);
}
