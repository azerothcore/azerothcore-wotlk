/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ulduar.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Player.h"

#define BASE_CAMP    200
#define GROUNDS      201
#define FORGE        202
#define SCRAPYARD    203
#define ANTECHAMBER  204
#define WALKWAY      205
#define CONSERVATORY 206
#define MADNESS      207
#define SPARK        208

class go_ulduar_teleporter : public GameObjectScript
{
public:
    go_ulduar_teleporter() : GameObjectScript("ulduar_teleporter") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        InstanceScript* pInstance = go->GetInstanceScript();
        if (!pInstance)
            return true;

        AddGossipItemFor(player, 0, "Teleport to the Expedition Base Camp.", GOSSIP_SENDER_MAIN, BASE_CAMP);
        if (pInstance->GetData(TYPE_LEVIATHAN) >= DONE) // count special
        {
            AddGossipItemFor(player, 0, "Teleport to the Formation Grounds.", GOSSIP_SENDER_MAIN, GROUNDS);
            if (pInstance->GetData(TYPE_LEVIATHAN) == DONE)
            {
                AddGossipItemFor(player, 0, "Teleport to the Colossal Forge.", GOSSIP_SENDER_MAIN, FORGE);
                if (pInstance->GetData(TYPE_XT002) == DONE)
                {
                    AddGossipItemFor(player, 0, "Teleport to the Scrapyard.", GOSSIP_SENDER_MAIN, SCRAPYARD);
                    AddGossipItemFor(player, 0, "Teleport to the Antechamber of Ulduar.", GOSSIP_SENDER_MAIN, ANTECHAMBER);
                    if (pInstance->GetData(TYPE_KOLOGARN) == DONE)
                    {
                        AddGossipItemFor(player, 0, "Teleport to the Shattered Walkway.", GOSSIP_SENDER_MAIN, WALKWAY);
                        if (pInstance->GetData(TYPE_AURIAYA) == DONE)
                        {
                            AddGossipItemFor(player, 0, "Teleport to the Conservatory of Life.", GOSSIP_SENDER_MAIN, CONSERVATORY);
                            if (pInstance->GetData(DATA_CALL_TRAM))
                                AddGossipItemFor(player, 0, "Teleport to the Spark of Imagination.", GOSSIP_SENDER_MAIN, SPARK);
                            if (pInstance->GetData(TYPE_VEZAX) == DONE)
                                AddGossipItemFor(player, 0, "Teleport to the Prison of Yogg-Saron.", GOSSIP_SENDER_MAIN, MADNESS);
                        }
                    }
                }
            }
        }

        SendGossipMenuFor(player, 14424, go->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, GameObject*  /*go*/, uint32 sender, uint32 action) override
    {
        if (sender != GOSSIP_SENDER_MAIN || !player->getAttackers().empty())
            return true;

        switch(action)
        {
            case BASE_CAMP:
                player->TeleportTo(603, -706.122f, -92.6024f, 429.876f, 0);
                CloseGossipMenuFor(player); break;
            case GROUNDS:
                player->TeleportTo(603, 131.248f, -35.3802f, 409.804f, 0);
                CloseGossipMenuFor(player); break;
            case FORGE:
                player->TeleportTo(603, 553.233f, -12.3247f, 409.679f, 0);
                CloseGossipMenuFor(player); break;
            case SCRAPYARD:
                player->TeleportTo(603, 926.292f, -11.4635f, 418.595f, 0);
                CloseGossipMenuFor(player); break;
            case ANTECHAMBER:
                player->TeleportTo(603, 1498.09f, -24.246f, 420.967f, 0);
                CloseGossipMenuFor(player); break;
            case WALKWAY:
                player->TeleportTo(603, 1859.45f, -24.1f, 448.9f, 0);
                CloseGossipMenuFor(player); break;
            case CONSERVATORY:
                player->TeleportTo(603, 2086.27f, -24.3134f, 421.239f, 0);
                CloseGossipMenuFor(player); break;
            case MADNESS:
                player->TeleportTo(603, 1854.8f, -11.46f, 334.57f, 4.8f);
                CloseGossipMenuFor(player); break;
            case SPARK:
                player->TeleportTo(603, 2517.9f, 2568.9f, 412.7f, 0);
                CloseGossipMenuFor(player); break;
        }

        return true;
    }
};

class npc_ulduar_keeper : public CreatureScript
{
public:
    npc_ulduar_keeper() : CreatureScript("npc_ulduar_keeper_gossip") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Lend us your aid, keeper. Together we shall defeat Yogg-Saron.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player*  /*player*/, Creature* creature, uint32  /*uiSender*/, uint32  /*uiAction*/) override
    {
        creature->SetUInt32Value(UNIT_NPC_FLAGS, 0);
        uint8 _keeper = 0;
        switch (creature->GetEntry())
        {
            case NPC_FREYA_GOSSIP:
                creature->MonsterYell("Eonar, your servant calls for your blessing!", LANG_UNIVERSAL, 0);
                creature->PlayDirectSound(15535);
                _keeper = KEEPER_FREYA;
                break;
            case NPC_HODIR_GOSSIP:
                creature->MonsterYell("The veil of winter will protect you, champions!", LANG_UNIVERSAL, 0);
                creature->PlayDirectSound(15559);
                _keeper = KEEPER_HODIR;
                break;
            case NPC_MIMIRON_GOSSIP:
                creature->MonsterYell("Combat matrix enhanced. Behold wonderous rapidity!", LANG_UNIVERSAL, 0);
                creature->PlayDirectSound(15630);
                _keeper = KEEPER_MIMIRON;
                break;
            case NPC_THORIM_GOSSIP:
                creature->MonsterYell("Golganneth, lend me your strengh! Grant my mortal allies the power of thunder!", LANG_UNIVERSAL, 0);
                creature->PlayDirectSound(15750);
                _keeper = KEEPER_THORIM;
                break;
        }

        if (creature->GetInstanceScript())
        {
            creature->GetInstanceScript()->SetData(TYPE_WATCHERS, _keeper);
            creature->DespawnOrUnsummon(6000);
        }

        return true;
    }
};

class spell_ulduar_energy_sap : public SpellScriptLoader
{
public:
    spell_ulduar_energy_sap() : SpellScriptLoader("spell_ulduar_energy_sap") { }

    class spell_ulduar_energy_sap_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_ulduar_energy_sap_AuraScript)

        void HandleEffectPeriodic(AuraEffect const * aurEff)
        {
            if (Unit* target = GetTarget())
                target->CastSpell(target, (aurEff->GetId() == 64740) ? 64747 : 64863, true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_ulduar_energy_sap_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_ulduar_energy_sap_AuraScript();
    }
};

class npc_ulduar_snow_mound : public CreatureScript
{
public:
    npc_ulduar_snow_mound() : CreatureScript("npc_ulduar_snow_mound") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ulduar_snow_moundAI(creature);
    }

    struct npc_ulduar_snow_moundAI : public ScriptedAI
    {
        npc_ulduar_snow_moundAI(Creature* creature) : ScriptedAI(creature)
        {
            activated = false;
            me->CastSpell(me, 64615, true);
        }

        bool activated;

        void MoveInLineOfSight(Unit* who)
        {
            if (!activated && who->GetTypeId() == TYPEID_PLAYER)
                if (me->GetExactDist2d(who) <= 25.0f && me->GetMap()->isInLineOfSight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+5.0f, who->GetPositionX(), who->GetPositionY(), who->GetPositionZ()+5.0f, 2, LINEOFSIGHT_ALL_CHECKS))
                {
                    activated = true;
                    me->RemoveAura(64615);
                    if (GameObject* go = me->FindNearestGameObject(194907, 5.0f))
                        go->Delete();
                    uint8 count;
                    if (me->GetEntry() == 34146) count = 4;
                    else if (me->GetEntry() == 34150) count = 6;
                    else count = 8;
                    for (uint8 i=0; i<count; ++i)
                    {
                        float a = rand_norm()*2*M_PI; float d = rand_norm()*4.0f;
                        if (Creature* c = me->SummonCreature(34137, me->GetPositionX()+cos(a)*d, me->GetPositionY()+sin(a)*d, me->GetPositionZ()+1.0f, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 300000))
                            c->AI()->AttackStart(who);
                    }
                }
        }

        void UpdateAI(uint32  /*diff*/) {}
    };
};

class npc_ulduar_storm_tempered_keeper : public CreatureScript
{
public:
    npc_ulduar_storm_tempered_keeper() : CreatureScript("npc_ulduar_storm_tempered_keeper") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ulduar_storm_tempered_keeperAI(creature);
    }

    struct npc_ulduar_storm_tempered_keeperAI : public ScriptedAI
    {
        npc_ulduar_storm_tempered_keeperAI(Creature* creature) : ScriptedAI(creature)
        {
            otherGUID = 0;
        }

        EventMap events;
        uint64 otherGUID;

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.Reset();
            events.ScheduleEvent(1, 2000); // checking Separation Anxiety, Charged Sphere
            events.ScheduleEvent(2, urand(5000,8000)); // Forked Lightning
            events.ScheduleEvent(3, (me->GetEntry() == 33722 ? 20000 : 50000)); // Summon Charged Sphere
            if (Creature* c = me->FindNearestCreature((me->GetEntry() == 33722 ? 33699 : 33722), 30.0f, true))
                otherGUID = c->GetGUID();
            else
                me->CastSpell(me, 63630, true); // Vengeful Surge
        }

        void JustDied(Unit* /*killer*/)
        {
            if (Creature* c = ObjectAccessor::GetCreature(*me, otherGUID))
                c->CastSpell(c, 63630, true); // Vengeful Surge
        }

        void JustSummoned(Creature* s)
        {
            if (Creature* c = ObjectAccessor::GetCreature(*me, otherGUID))
                s->GetMotionMaster()->MoveFollow(c, 0.0f, 0.0f);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case 0:
                    break;
                case 1:
                    if (Creature* c = ObjectAccessor::GetCreature(*me, otherGUID))
                        if (c->IsAlive() && me->GetExactDist2d(c) > 45.0f)
                            me->CastSpell(me, 63539, true);
                    if (Creature* c = me->FindNearestCreature(33715, 2.0f, true))
                        if (c->IsSummon())
                            if (c->ToTempSummon()->GetSummonerGUID() != me->GetGUID())
                                me->CastSpell(me, 63528, true);
                    events.RepeatEvent(2000);
                    break;
                case 2:
                    me->CastSpell(me->GetVictim(), 63541, false);
                    events.RepeatEvent(urand(10000,14000));
                    break;
                case 3:
                    if (!me->HasAura(63630))
                        me->CastSpell(me, 63527, false);
                    events.RepeatEvent(60000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_ulduar_arachnopod_destroyer : public CreatureScript
{
public:
    npc_ulduar_arachnopod_destroyer() : CreatureScript("npc_ulduar_arachnopod_destroyer") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ulduar_arachnopod_destroyerAI(creature);
    }

    struct npc_ulduar_arachnopod_destroyerAI : public ScriptedAI
    {
        npc_ulduar_arachnopod_destroyerAI(Creature* creature) : ScriptedAI(creature)
        {
            _spawnedMechanic = false;
            me->ApplySpellImmune(0, IMMUNITY_ID, 64919, true); // Ice Nova from Ice Turret
        }

        EventMap events;
        bool _spawnedMechanic;

        void Reset()
        {
            events.Reset();
            events.ScheduleEvent(1, urand(5000, 8000)); // Flame Spray
            events.ScheduleEvent(2, urand(3000, 6000)); // Machine Gun
            events.ScheduleEvent(3, 1000); // Charged Leap
        }

        void PassengerBoarded(Unit* p, int8  /*seat*/, bool  /*apply*/)
        {
            me->setFaction(p->getFaction());
            me->SetReactState(REACT_PASSIVE);
        }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if (!_spawnedMechanic && me->HealthBelowPctDamaged(20, damage))
            {
                _spawnedMechanic = true;
                if (Creature* c = me->SummonCreature(34184, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN, 0))
                    c->AI()->AttackStart(me->GetVictim());
                me->InterruptNonMeleeSpells(false);
                me->CombatStop(true);
                me->SetReactState(REACT_PASSIVE);
                me->SetRegeneratingHealth(false);
                me->setFaction(31);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
                me->CastSpell(me, 64770, true);
            }
        }

        void AttackStart(Unit* who)
        {
            if (me->getFaction() == 16)
                ScriptedAI::AttackStart(who);
        }

        void EnterEvadeMode()
        {
            if (me->getFaction() == 16)
                ScriptedAI::EnterEvadeMode();
        }

        void OnCharmed(bool  /*apply*/) {}

        void UpdateAI(uint32 diff)
        {
            if (me->getFaction() != 16)
            {
                if (me->IsAlive() && (me->GetExactDist2dSq(2058.0f, 42.0f) < 25.0f*25.0f || me->GetExactDist2dSq(2203.0f, 292.0f) < 25.0f*25.0f || me->GetExactDist2dSq(2125.0f, 170.0f) > 160.0f*160.0f))
                    Unit::Kill(me, me, false);
            }
            else
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.GetEvent())
                {
                    case 0:
                        break;
                    case 1:
                        me->CastSpell(me->GetVictim(), RAID_MODE(64717, 65241), false);
                        events.RepeatEvent(urand(15000, 25000));
                        break;
                    case 2:
                        me->CastSpell(me->GetVictim(), RAID_MODE(64776, 65240), false);
                        events.RepeatEvent(urand(10000, 15000));
                        break;
                    case 3:
                        {
                            float dist = me->GetDistance(me->GetVictim());
                            if (dist > 10.0f && dist < 40.0f)
                            {
                                me->CastSpell(me->GetVictim(), 64779, false);
                                events.RepeatEvent(25000);
                            }
                            else
                                events.RepeatEvent(3000);
                        }
                        break;
                }

                DoMeleeAttackIfReady();
            }
        }
    };
};

class spell_ulduar_arachnopod_damaged : public SpellScriptLoader
{
public:
    spell_ulduar_arachnopod_damaged() : SpellScriptLoader("spell_ulduar_arachnopod_damaged") { }

    class spell_ulduar_arachnopod_damaged_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_ulduar_arachnopod_damaged_AuraScript)

        void HandleEffectPeriodic(AuraEffect const *  /*aurEff*/)
        {
            if (Unit* c = GetCaster())
                Unit::Kill(c, c, false);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_ulduar_arachnopod_damaged_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_ulduar_arachnopod_damaged_AuraScript();
    }
};

class AreaTrigger_at_celestial_planetarium_enterance : public AreaTriggerScript
{
    public:

        AreaTrigger_at_celestial_planetarium_enterance()
            : AreaTriggerScript("at_celestial_planetarium_enterance")
        {
        }

        bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/)
        {
            if (player->IsAlive())
                if (uint32 questId = (player->GetMap()->Is25ManRaid() ? 13816 : 13607 /*QUEST_CELESTIAL_PLANETARIUM*/))
                    if (player->GetQuestStatus(questId) == QUEST_STATUS_INCOMPLETE)
                        player->AreaExploredOrEventHappens(questId);
            return false;
        }
};

class go_call_tram : public GameObjectScript
{
public:
    go_call_tram() : GameObjectScript("go_call_tram") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        InstanceScript* pInstance = go->GetInstanceScript();

        if (!pInstance)
            return false;

        switch(go->GetEntry())
        {
            case 194914:
            case 194438:
                pInstance->SetData(DATA_CALL_TRAM, 0);
                break;
            case 194912:
            case 194437:
                pInstance->SetData(DATA_CALL_TRAM, 1);
                break;
        }
        return true;
    }
};


void AddSC_ulduar()
{
    new go_ulduar_teleporter();
    new npc_ulduar_keeper();

    new spell_ulduar_energy_sap();
    new npc_ulduar_snow_mound();
    new npc_ulduar_storm_tempered_keeper();
    new npc_ulduar_arachnopod_destroyer();
    new spell_ulduar_arachnopod_damaged();

    new AreaTrigger_at_celestial_planetarium_enterance();
    new go_call_tram();
}
