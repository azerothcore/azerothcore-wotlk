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
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum q10935Exorcism
{
    SPELL_HOLY_FIRE             = 39323,
    SPELL_HEAL_BARADA           = 39322
};

class spell_q10935_the_exorcism_of_colonel_jules : public SpellScript
{
    PrepareSpellScript(spell_q10935_the_exorcism_of_colonel_jules);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HOLY_FIRE, SPELL_HEAL_BARADA });
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Creature* target = GetHitCreature();
        if (!target)
            return;

        if (GetCaster()->IsHostileTo(target))
            GetCaster()->CastSpell(target, SPELL_HOLY_FIRE, true);
        else
            GetCaster()->CastSpell(target, SPELL_HEAL_BARADA, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q10935_the_exorcism_of_colonel_jules::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// Theirs
/*######
## npc_aeranas
######*/

enum Aeranas
{
    SAY_SUMMON                  = 0,
    SAY_FREE                    = 1,
    SPELL_ENVELOPING_WINDS      = 15535,
    SPELL_SHOCK                 = 12553
};

class npc_aeranas : public CreatureScript
{
public:
    npc_aeranas() : CreatureScript("npc_aeranas") { }

    struct npc_aeranasAI : public ScriptedAI
    {
        npc_aeranasAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            faction_Timer = 8000;
            envelopingWinds_Timer = 9000;
            shock_Timer = 5000;

            me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
            me->SetFaction(FACTION_FRIENDLY);

            Talk(SAY_SUMMON);
        }

        void UpdateAI(uint32 diff) override
        {
            if (faction_Timer)
            {
                if (faction_Timer <= diff)
                {
                    me->SetFaction(FACTION_MONSTER_2);
                    faction_Timer = 0;
                }
                else faction_Timer -= diff;
            }

            if (!UpdateVictim())
                return;

            if (HealthBelowPct(30))
            {
                me->SetFaction(FACTION_FRIENDLY);
                me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                me->RemoveAllAuras();
                me->GetThreatMgr().ClearAllThreat();
                me->CombatStop(true);
                Talk(SAY_FREE);
                return;
            }

            if (shock_Timer <= diff)
            {
                DoCastVictim(SPELL_SHOCK);
                shock_Timer = 10000;
            }
            else shock_Timer -= diff;

            if (envelopingWinds_Timer <= diff)
            {
                DoCastVictim(SPELL_ENVELOPING_WINDS);
                envelopingWinds_Timer = 25000;
            }
            else envelopingWinds_Timer -= diff;

            DoMeleeAttackIfReady();
        }

    private:
        uint32 faction_Timer;
        uint32 envelopingWinds_Timer;
        uint32 shock_Timer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_aeranasAI(creature);
    }
};

/*######
## npc_ancestral_wolf
######*/

enum AncestralWolf
{
    EMOTE_WOLF_LIFT_HEAD        = 0,
    EMOTE_WOLF_HOWL             = 1,
    SAY_WOLF_WELCOME            = 0,
    SPELL_GUIDED_BY_THE_SPIRITS       = 29938,
    NPC_RYGA                    = 17123
};

class npc_ancestral_wolf : public CreatureScript
{
public:
    npc_ancestral_wolf() : CreatureScript("npc_ancestral_wolf") { }

    struct npc_ancestral_wolfAI : public npc_escortAI
    {
        npc_ancestral_wolfAI(Creature* creature) : npc_escortAI(creature)
        {
            if (creature->GetOwner() && creature->GetOwner()->IsPlayer())
                Start(false, false, creature->GetOwner()->GetGUID());
            creature->SetSpeed(MOVE_WALK, 1.5f);
            DoCast(SPELL_GUIDED_BY_THE_SPIRITS);
            Reset();
        }

        void Reset() override
        {
            ryga = nullptr;
            me->SetReactState(REACT_PASSIVE);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!ryga && who->GetEntry() == NPC_RYGA && me->IsWithinDistInMap(who, 15.0f))
                if (Creature* temp = who->ToCreature())
                    ryga = temp;

            npc_escortAI::MoveInLineOfSight(who);
        }

        void WaypointReached(uint32 waypointId) override
        {
            switch (waypointId)
            {
                case 0:
                    Talk(EMOTE_WOLF_LIFT_HEAD);
                    break;
                case 2:
                    Talk(EMOTE_WOLF_HOWL);
                    break;
                case 50:
                    if (Creature* ryga = me->FindNearestCreature(NPC_RYGA, 70))
                    {
                        if (ryga->IsAlive() && !ryga->IsInCombat())
                        {
                            ryga->SetWalk(true);
                            ryga->SetSpeed(MOVE_WALK, 1.0f);
                            ryga->GetMotionMaster()->MovePoint(0, 515.877991f, 3885.67627f, 190.470535f, true);
                            Reset();
                        }
                    }
                    break;
                case 51:
                    if (Creature* ryga = me->FindNearestCreature(NPC_RYGA, 70))
                    {
                        if (ryga->IsAlive() && !ryga->IsInCombat())
                        {
                            ryga->SetFacingTo(0.2602f);
                            ryga->SetStandState(UNIT_STAND_STATE_KNEEL);
                            ryga->AI()->Talk(SAY_WOLF_WELCOME);
                            Reset();
                        }
                    }
                    break;
                case 52:
                    if (Creature* ryga = me->FindNearestCreature(NPC_RYGA, 70))
                    {
                        if (ryga->IsAlive() && !ryga->IsInCombat())
                        {
                            ryga->SetStandState(UNIT_STAND_STATE_STAND);
                            ryga->SetWalk(true);
                            ryga->SetSpeed(MOVE_WALK, 1.0f);
                            ryga->GetMotionMaster()->MovePoint(0, 504.59201f, 3882.12988f, 192.156006f, true);
                            Reset();
                        }
                    }
                    break;
                case 53:
                    if (Creature* ryga = me->FindNearestCreature(NPC_RYGA, 70))
                    {
                        if (ryga->IsAlive() && !ryga->IsInCombat())
                        {
                            ryga->SetFacingTo(5.79449f);
                            Reset();
                        }
                    }
                    break;
            }
        }

    private:
        Creature* ryga;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ancestral_wolfAI(creature);
    }
};

/*######
## npc_wounded_blood_elf
######*/

enum WoundedBloodElf
{
    SAY_ELF_START               = 0,
    SAY_ELF_SUMMON1             = 1,
    SAY_ELF_RESTING             = 2,
    SAY_ELF_SUMMON2             = 3,
    SAY_ELF_COMPLETE            = 4,
    SAY_ELF_AGGRO               = 5,
    QUEST_ROAD_TO_FALCON_WATCH  = 9375,
    NPC_HAALESHI_WINDWALKER     = 16966,
    NPC_HAALESHI_TALONGUARD     = 16967,
    ARAKKOA_CAGE                = 181664
};

class npc_wounded_blood_elf : public CreatureScript
{
public:
    npc_wounded_blood_elf() : CreatureScript("npc_wounded_blood_elf") { }

    struct npc_wounded_blood_elfAI : public npc_escortAI
    {
        npc_wounded_blood_elfAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() override
        {
            me->SetReactState(REACT_PASSIVE);
            me->FindNearestGameObject(ARAKKOA_CAGE, 10.0f)->SetGoState(GO_STATE_READY);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
                Talk(SAY_ELF_AGGRO);
        }

        void JustSummoned(Creature* summoned) override
        {
            summoned->AI()->AttackStart(me);
        }

        void sQuestAccept(Player* player, Quest const* quest) override
        {
            if (quest->GetQuestId() == QUEST_ROAD_TO_FALCON_WATCH)
            {
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetFaction(FACTION_ESCORTEE_H_PASSIVE);
                npc_escortAI::Start(true, false, player->GetGUID());
            }
        }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 0:
                    Talk(SAY_ELF_START, player);
                    me->FindNearestGameObject(ARAKKOA_CAGE, 10.0f)->SetGoState(GO_STATE_ACTIVE);
                    break;
                case 9:
                    Talk(SAY_ELF_SUMMON1, player);
                    // Spawn two Haal'eshi Talonguard
                    DoSpawnCreature(NPC_HAALESHI_TALONGUARD, -15, -15, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    DoSpawnCreature(NPC_HAALESHI_TALONGUARD, -17, -17, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                case 13:
                    Talk(SAY_ELF_RESTING, player);
                    break;
                case 14:
                    Talk(SAY_ELF_SUMMON2, player);
                    // Spawn two Haal'eshi Windwalker
                    DoSpawnCreature(NPC_HAALESHI_WINDWALKER, -15, -15, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    DoSpawnCreature(NPC_HAALESHI_WINDWALKER, -17, -17, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                case 27:
                    Talk(SAY_ELF_COMPLETE, player);
                    // Award quest credit
                    player->GroupEventHappens(QUEST_ROAD_TO_FALCON_WATCH, me);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_wounded_blood_elfAI(creature);
    }
};

/*######
## npc_fel_guard_hound
######*/

enum FelGuard
{
    SPELL_SUMMON_POO            = 37688,
    NPC_DERANGED_HELBOAR        = 16863,
    QUEST_SHIZZ_WORK            = 10629,
};

class npc_fel_guard_hound : public CreatureScript
{
public:
    npc_fel_guard_hound() : CreatureScript("npc_fel_guard_hound") { }

    struct npc_fel_guard_houndAI : public ScriptedAI
    {
        npc_fel_guard_houndAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            checkTimer = 5000; //check for creature every 5 sec
            helboarGUID.Clear();
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != 1)
                return;

            if (Creature* helboar = ObjectAccessor::GetCreature(*me, helboarGUID))
            {
                helboar->RemoveCorpse();
                DoCast(SPELL_SUMMON_POO);

                if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                    me->GetMotionMaster()->MoveFollow(owner, 1.0f, 90.0f);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (checkTimer <= diff)
            {
                if (Creature* helboar = me->FindNearestCreature(NPC_DERANGED_HELBOAR, 10.0f, false))
                {
                    if (helboar->GetGUID() != helboarGUID && me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE && !me->FindCurrentSpellBySpellId(SPELL_SUMMON_POO))
                    {
                        helboarGUID = helboar->GetGUID();
                        me->GetMotionMaster()->MovePoint(1, helboar->GetPositionX(), helboar->GetPositionY(), helboar->GetPositionZ());
                    }
                }
                if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                {
                    if (!owner->HasQuest(QUEST_SHIZZ_WORK))
                    {
                        me->DespawnOrUnsummon();
                    }
                }
                checkTimer = 5000;
            }
            else checkTimer -= diff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

    private:
        uint32 checkTimer;
        ObjectGuid helboarGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_fel_guard_houndAI(creature);
    }
};

enum Aledis
{
    SAY_CHALLENGE = 0,
    SAY_DEFEATED = 1,
    EVENT_TALK = 1,
    EVENT_ATTACK = 2,
    EVENT_EVADE = 3,
    EVENT_FIREBALL = 4,
    EVENT_FROSTNOVA = 5,
    SPELL_FIREBALL = 20823,
    SPELL_FROSTNOVA = 11831,
};

struct npc_magister_aledis : public ScriptedAI
{
    npc_magister_aledis(Creature* creature) : ScriptedAI(creature) { }

    void StartFight(Player* player)
    {
        me->Dismount();
        me->SetFacingToObject(player);
        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        _playerGUID = player->GetGUID();
        _events.ScheduleEvent(EVENT_TALK, 2s);
    }

    void Reset() override
    {
        me->RestoreFaction();
        me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        me->SetImmuneToPC(true);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*spellInfo = nullptr*/) override
    {
        if (damage > me->GetHealth() || me->HealthBelowPctDamaged(20, damage))
        {
            damage = 0;

            _events.Reset();
            me->RestoreFaction();
            me->RemoveAllAuras();
            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(true);
            me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
            me->SetImmuneToPC(true);
            Talk(SAY_DEFEATED);

            _events.ScheduleEvent(EVENT_EVADE, 1min);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_TALK:
                    Talk(SAY_CHALLENGE);
                    _events.ScheduleEvent(EVENT_ATTACK, 2s);
                    break;
                case EVENT_ATTACK:
                    me->SetImmuneToPC(false);
                    me->SetFaction(FACTION_MONSTER);
                    if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                    {
                        AttackStart(player);
                    }
                    _events.ScheduleEvent(EVENT_FIREBALL, 1ms);
                    _events.ScheduleEvent(EVENT_FROSTNOVA, 5s);
                    break;
                case EVENT_FIREBALL:
                    DoCast(SPELL_FIREBALL);
                    _events.ScheduleEvent(EVENT_FIREBALL, 10s);
                    break;
                case EVENT_FROSTNOVA:
                    DoCastAOE(SPELL_FROSTNOVA);
                    _events.ScheduleEvent(EVENT_FROSTNOVA, 20s);
                    break;
                case EVENT_EVADE:
                    EnterEvadeMode();
                    break;
            }
        }

        if (UpdateVictim())
        {
            DoMeleeAttackIfReady();
        }
    }

    void sGossipSelect(Player* player, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        me->StopMoving();
        StartFight(player);
    }

private:
    EventMap _events;
    ObjectGuid _playerGUID;
};

enum Beacon
{
    NPC_STONESCHYE_WHELP        = 16927,
};

class go_beacon : public GameObjectScript
{
public:
    go_beacon() : GameObjectScript("go_beacon") { }

    struct go_beaconAI : public GameObjectAI
    {
        go_beaconAI(GameObject* gameObject) : GameObjectAI(gameObject) { }

        std::list<Creature*> creatureList;

        void OnStateChanged(uint32 state, Unit*  /*unit*/) override
        {
            if (state == GO_ACTIVATED)
            {
                me->GetCreaturesWithEntryInRange(creatureList, 40, NPC_STONESCHYE_WHELP);
                {
                    for (Creature* whelp : creatureList)
                    {
                        if (whelp->IsAlive() && !whelp->IsInCombat() && whelp->GetMotionMaster()->GetCurrentMovementGeneratorType() != HOME_MOTION_TYPE)
                        {
                            whelp->GetMotionMaster()->MovePoint(0, me->GetNearPosition(4.0f, whelp->GetOrientation()));
                        }
                    }
                }
            }
            else if (state == GO_JUST_DEACTIVATED)
            {
                {
                    for (Creature* whelp : creatureList)
                    {
                        if (whelp->IsAlive() && !whelp->IsInCombat() && whelp->GetMotionMaster()->GetCurrentMovementGeneratorType() != HOME_MOTION_TYPE)
                        {
                            whelp->GetMotionMaster()->MoveTargetedHome();
                        }
                    }
                }
            }
            else
            {
                creatureList.clear();
            }
        }
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return new go_beaconAI(go);
    }
};

void AddSC_hellfire_peninsula()
{
    // Ours
    RegisterSpellScript(spell_q10935_the_exorcism_of_colonel_jules);

    // Theirs
    new npc_aeranas();
    new npc_ancestral_wolf();
    new npc_wounded_blood_elf();
    new npc_fel_guard_hound();
    new go_beacon();

    RegisterCreatureAI(npc_magister_aledis);
}
