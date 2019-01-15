// Scripted by Xinef

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "GridNotifiers.h"
#include "GossipDef.h"
#include "SpellScript.h"
#include "LFGMgr.h"
#include "PassiveAI.h"
#include "Group.h"
#include "CellImpl.h"

///////////////////////////////////////
////// ITEMS FIXES, BASIC STUFF
///////////////////////////////////////

enum eTrickSpells
{
    SPELL_PIRATE_COSTUME_MALE           = 24708,
    SPELL_PIRATE_COSTUME_FEMALE         = 24709,
    SPELL_NINJA_COSTUME_MALE            = 24710,
    SPELL_NINJA_COSTUME_FEMALE          = 24711,
    SPELL_LEPER_GNOME_COSTUME_MALE      = 24712,
    SPELL_LEPER_GNOME_COSTUME_FEMALE    = 24713,
    SPELL_SKELETON_COSTUME              = 24723,
    SPELL_BAT_COSTUME                   = 24732,
    SPELL_GHOST_COSTUME_MALE            = 24735,
    SPELL_GHOST_COSTUME_FEMALE          = 24736,
    SPELL_WHISP_COSTUME                 = 24740,
    SPELL_TRICK_BUFF                    = 24753,
};

class spell_hallows_end_trick : public SpellScriptLoader
{
    public:
    spell_hallows_end_trick() : SpellScriptLoader("spell_hallows_end_trick") {}

    class spell_hallows_end_trick_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hallows_end_trick_SpellScript);

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            if (Player* target = GetHitPlayer())
            {
                uint8 gender = target->getGender();
                uint32 spellId = SPELL_TRICK_BUFF;
                switch (urand(0, 7))
                {
                    case 1:
                        spellId = gender ? SPELL_LEPER_GNOME_COSTUME_FEMALE : SPELL_LEPER_GNOME_COSTUME_MALE;
                        break;
                    case 2:
                        spellId = gender ? SPELL_PIRATE_COSTUME_FEMALE : SPELL_PIRATE_COSTUME_MALE;
                        break;
                    case 3:
                        spellId = gender ? SPELL_GHOST_COSTUME_FEMALE : SPELL_GHOST_COSTUME_MALE;
                        break;
                    case 4:
                        spellId = gender ? SPELL_NINJA_COSTUME_FEMALE : SPELL_NINJA_COSTUME_MALE;
                        break;
                    case 5:
                        spellId = SPELL_SKELETON_COSTUME;
                        break;
                    case 6:
                        spellId = SPELL_BAT_COSTUME;
                        break;
                    case 7:
                        spellId = SPELL_WHISP_COSTUME;
                        break;
                    default:
                        break;
                }

                GetCaster()->CastSpell(target, spellId, true);
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_hallows_end_trick_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_hallows_end_trick_SpellScript();
    }
};

class spell_hallows_end_put_costume : public SpellScriptLoader
{
    public:
    spell_hallows_end_put_costume(const char* name, uint32 maleSpell, uint32 femaleSpell) : SpellScriptLoader(name), _maleSpell(maleSpell), _femaleSpell(femaleSpell) {}

    class spell_hallows_end_put_costume_SpellScript : public SpellScript
    {
        public:
        spell_hallows_end_put_costume_SpellScript(uint32 maleSpell, uint32 femaleSpell) : _maleSpell(maleSpell), _femaleSpell(femaleSpell) { }

        PrepareSpellScript(spell_hallows_end_put_costume_SpellScript);

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            if (Player* target = GetHitPlayer())
                GetCaster()->CastSpell(target, target->getGender() ? _femaleSpell : _maleSpell, true);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_hallows_end_put_costume_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }

        private:
            uint32 _maleSpell;
            uint32 _femaleSpell;
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_hallows_end_put_costume_SpellScript(_maleSpell, _femaleSpell);
    }

    private:
        uint32 _maleSpell;
        uint32 _femaleSpell;
};

// 24751 Trick or Treat
enum eTrickOrTreatSpells
{
    SPELL_TRICK                 = 24714,
    SPELL_TREAT                 = 24715,
    SPELL_TRICKED_OR_TREATED    = 24755
};

class spell_hallows_end_trick_or_treat : public SpellScriptLoader
{
    public:
    spell_hallows_end_trick_or_treat() : SpellScriptLoader("spell_hallows_end_trick_or_treat") {}

    class spell_hallows_end_trick_or_treat_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hallows_end_trick_or_treat_SpellScript);

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            if (Player* target = GetHitPlayer())
            {
                GetCaster()->CastSpell(target, roll_chance_i(50) ? SPELL_TRICK : SPELL_TREAT, true, NULL);
                GetCaster()->CastSpell(target, SPELL_TRICKED_OR_TREATED, true, NULL);
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_hallows_end_trick_or_treat_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_hallows_end_trick_or_treat_SpellScript();
    }
};

enum eHallowsEndCandy
{
    SPELL_HALLOWS_END_CANDY_1               = 24924,
    SPELL_HALLOWS_END_CANDY_2               = 24925,
    SPELL_HALLOWS_END_CANDY_3               = 24926,
    SPELL_HALLOWS_END_CANDY_4               = 24927,
};

class spell_hallows_end_candy : public SpellScriptLoader
{
    public:
    spell_hallows_end_candy() : SpellScriptLoader("spell_hallows_end_candy") {}

    class spell_hallows_end_candy_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hallows_end_candy_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Player* target = GetHitPlayer())
            {
                uint32 spellId = SPELL_HALLOWS_END_CANDY_1+urand(0,3);
                GetCaster()->CastSpell(target, spellId, true, NULL);
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_hallows_end_candy_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_hallows_end_candy_SpellScript();
    }
};

enum trickyTreat
{
    SPELL_UPSET_TUMMY               = 42966,
};

class spell_hallows_end_tricky_treat : public SpellScriptLoader
{
    public:
    spell_hallows_end_tricky_treat() : SpellScriptLoader("spell_hallows_end_tricky_treat") {}

    class spell_hallows_end_tricky_treat_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hallows_end_tricky_treat_SpellScript);

        void HandleScript(SpellEffIndex /*effIndex*/)
        {
            if (Player* target = GetHitPlayer())
            {
                if (roll_chance_i(20))
                    target->CastSpell(target, SPELL_UPSET_TUMMY, true);
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_hallows_end_tricky_treat_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_hallows_end_tricky_treat_SpellScript();
    }
};

///////////////////////////////////////
////// SHADE OF THE HORSEMAN EVENT
///////////////////////////////////////

enum costumedOrphan
{
    // Quests
    QUEST_LET_THE_FIRES_COME_A              = 12135,
    QUEST_LET_THE_FIRES_COME_H              = 12139,
    QUEST_STOP_THE_FIRES_A                  = 11131,
    QUEST_STOP_THE_FIRES_H                  = 11219,

    // Spells
    SPELL_HORSEMAN_MOUNT                    = 48025,
    SPELL_FIRE_AURA_BASE                    = 42074,
    SPELL_START_FIRE                        = 42132,
    SPELL_SPREAD_FIRE                       = 42079,
    SPELL_CREATE_BUCKET                     = 42349,
    SPELL_WATER_SPLASH                      = 42348,
    SPELL_SUMMON_LANTERN                    = 44255,

    // NPCs
    NPC_SHADE_OF_HORSEMAN                   = 23543,
    NPC_FIRE_TRIGGER                        = 23686,
    NPC_ALLIANCE_MATRON                     = 24519,

    // Actions
    ACTION_START_EVENT                      = 1,
    DATA_EVENT                              = 1,
    DATA_ALLOW_START                        = 2,
};

class spell_hallows_end_bucket_lands : public SpellScriptLoader
{
    public:
    spell_hallows_end_bucket_lands() : SpellScriptLoader("spell_hallows_end_bucket_lands") {}

    class spell_hallows_end_bucket_lands_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hallows_end_bucket_lands_SpellScript);

        bool handled;
        bool Load() { handled = false; return true; }
        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (handled || !GetCaster())
                return;

            handled = true;
            if (Player* target = GetHitPlayer())
                GetCaster()->CastSpell(target, SPELL_CREATE_BUCKET, true);
            else if (Unit* tgt = GetHitUnit())
                GetCaster()->CastSpell(tgt, SPELL_WATER_SPLASH, true);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_hallows_end_bucket_lands_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_hallows_end_bucket_lands_SpellScript();
    }
};

class spell_hallows_end_base_fire : public SpellScriptLoader
{
    public:
    spell_hallows_end_base_fire() : SpellScriptLoader("spell_hallows_end_base_fire") { }

    class spell_hallows_end_base_fire_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hallows_end_base_fire_AuraScript);

        void HandleEffectPeriodicUpdate(AuraEffect* aurEff)
        {
            // can start from 0
            int32 amount = aurEff->GetAmount();

            if (amount < 3)
                amount++;
            else if (aurEff->GetTickNumber()%3 != 2)
                return;

            aurEff->SetAmount(amount);
            if (Unit* owner = GetUnitOwner())
            {
                if (amount <= 3)
                    owner->SetObjectScale(amount/2.0f);
                if (amount >=3)
                    owner->CastSpell(owner, SPELL_SPREAD_FIRE, true);
            }
        }

        void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            target->SetObjectScale(0.5f);
            if (AuraEffect* aEff = GetEffect(EFFECT_0))
                aEff->SetAmount(1);
        }

        void Register()
        {
            OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_hallows_end_base_fire_AuraScript::HandleEffectPeriodicUpdate, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            OnEffectApply += AuraEffectApplyFn(spell_hallows_end_base_fire_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_hallows_end_base_fire_AuraScript();
    }
};

class npc_costumed_orphan_matron : public CreatureScript
{
public:
    npc_costumed_orphan_matron() : CreatureScript("npc_costumed_orphan_matron") { }

    struct npc_costumed_orphan_matronAI : public ScriptedAI
    {
        npc_costumed_orphan_matronAI(Creature *c) : ScriptedAI(c) 
        {
        }

        uint32 eventStarted;
        bool allowQuest;
        uint64 horseGUID;

        void Reset()
        {
            eventStarted = 0;
            allowQuest = false;
            horseGUID = 0;
        }

        void GetInitXYZ(float &x, float &y, float &z, float &o, uint32 &path)
        {
            switch (me->GetAreaId())
            {
                case 87: // Goldshire
                    x = -9494.4f; y = 48.53f; z = 70.5f; o = 0.5f; path = 235431;
                    break;
                case 131: // Kharanos
                    x = -5558.34f; y = -499.46f; z = 414.12f; o = 2.08f; path = 235432;
                    break;
                case 3576: // Azure Watch
                    x = -4163.58f; y = -12460.30f; z = 63.02f; o = 4.31f; path = 235433;
                    break;
                case 362: // Razor Hill
                    x = 373.2f; y = -4723.4f; z = 31.2f; o = 3.2f; path = 235434;
                    break;
                case 159: // Brill
                    x = 2195.2f; y = 264.0f; z = 55.62f; o = 0.15f; path = 235435;
                    break;
                case 3665: // Falcon Wing Square
                    x = 9547.91f; y = -6809.9f; z = 27.96f; o = 3.4f; path = 235436;
                    break;
            }
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_START_EVENT)
            {
                allowQuest = true;
                eventStarted = 1;
                float x, y, z, o;
                uint32 path;
                GetInitXYZ(x, y, z, o, path);
                if (Creature* cr = me->SummonCreature(NPC_SHADE_OF_HORSEMAN, x, y, z, o, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000))
                {
                    cr->GetMotionMaster()->MovePath(path, false);
                    cr->AI()->DoAction(path);
                    horseGUID = cr->GetGUID();
                }
            }
        }

        uint32 GetData(uint32 param) const
        {
            if (param == DATA_ALLOW_START)
                return allowQuest;

            return 0;
        }

        void UpdateAI(uint32 diff)
        {
            if (eventStarted)
            {
                eventStarted += diff;
                if (eventStarted >= 5*MINUTE*IN_MILLISECONDS)
                {
                    allowQuest = false;
                    eventStarted = 0;
                }
            }
        }
    };

    bool OnGossipHello(Player* player, Creature* creature)
    {
        QuestRelationBounds pObjectQR = sObjectMgr->GetCreatureQuestRelationBounds(creature->GetEntry());
        QuestRelationBounds pObjectQIR = sObjectMgr->GetCreatureQuestInvolvedRelationBounds(creature->GetEntry());

        QuestMenu &qm = player->PlayerTalkClass->GetQuestMenu();
        qm.ClearMenu();

        for (QuestRelations::const_iterator i = pObjectQIR.first; i != pObjectQIR.second; ++i)
        {
            uint32 quest_id = i->second;
            QuestStatus status = player->GetQuestStatus(quest_id);
            if (status == QUEST_STATUS_COMPLETE)
                qm.AddMenuItem(quest_id, 4);
            else if (status == QUEST_STATUS_INCOMPLETE)
                qm.AddMenuItem(quest_id, 4);
        }

        for (QuestRelations::const_iterator i = pObjectQR.first; i != pObjectQR.second; ++i)
        {
            uint32 quest_id = i->second;
            Quest const* pQuest = sObjectMgr->GetQuestTemplate(quest_id);
            if (!pQuest)
                continue;

            if (!player->CanTakeQuest(pQuest, false))
                continue;
            else if (player->GetQuestStatus(quest_id) == QUEST_STATUS_NONE)
            {
                switch (quest_id)
                {
                    case QUEST_LET_THE_FIRES_COME_A:
                    case QUEST_LET_THE_FIRES_COME_H:
                        if (!creature->AI()->GetData(DATA_ALLOW_START))
                            qm.AddMenuItem(quest_id, 2);
                        break;
                    case QUEST_STOP_THE_FIRES_A:
                    case QUEST_STOP_THE_FIRES_H:
                        if (creature->AI()->GetData(DATA_ALLOW_START))
                            qm.AddMenuItem(quest_id, 2);
                        break;
                    default:
                        qm.AddMenuItem(quest_id, 2);
                        break;
                }
            }
        }

        player->SendPreparedQuest(creature->GetGUID());
        return true;
    }

    bool OnQuestAccept(Player*  /*player*/, Creature* creature, Quest const* quest)
    {
        if ((quest->GetQuestId() == QUEST_LET_THE_FIRES_COME_A || quest->GetQuestId() == QUEST_LET_THE_FIRES_COME_H) && !creature->AI()->GetData(DATA_ALLOW_START))
            creature->AI()->DoAction(ACTION_START_EVENT);

        return true;
    }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_costumed_orphan_matronAI (pCreature);
    }
};

class npc_soh_fire_trigger : public CreatureScript
{
    public:
        npc_soh_fire_trigger() : CreatureScript("npc_soh_fire_trigger") { }

        struct npc_soh_fire_triggerAI : public NullCreatureAI
        {
            npc_soh_fire_triggerAI(Creature* creature) : NullCreatureAI(creature)
            {
            }

            void Reset()
            {
                me->SetDisableGravity(true);
            }

            void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo)
            {
                if (spellInfo->Id == SPELL_START_FIRE)
                {
                    me->CastSpell(me, SPELL_FIRE_AURA_BASE, true);
                    if (AuraEffect* aurEff = me->GetAuraEffect(SPELL_FIRE_AURA_BASE, EFFECT_0))
                    {
                        me->SetObjectScale(1.5f);
                        aurEff->SetAmount(2);
                    }
                }
                else if (spellInfo->Id == SPELL_SPREAD_FIRE)
                {
                    me->CastSpell(me, SPELL_FIRE_AURA_BASE, true);
                }
                else if (spellInfo->Id == SPELL_WATER_SPLASH)
                {
                    if (AuraEffect* aurEff = me->GetAuraEffect(SPELL_FIRE_AURA_BASE, EFFECT_0))
                    {
                        int32 amt = aurEff->GetAmount();
                        if (amt > 2)
                        {
                            aurEff->ResetPeriodic(true);
                            aurEff->SetAmount(amt-2);
                        }
                        else
                            me->RemoveAllAuras();
                    }
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_soh_fire_triggerAI(creature);
        }
};

class npc_hallows_end_soh : public CreatureScript
{
    public:
        npc_hallows_end_soh() : CreatureScript("npc_hallows_end_soh") { }

        struct npc_hallows_end_sohAI : public ScriptedAI
        {
            npc_hallows_end_sohAI(Creature* creature) : ScriptedAI(creature)
            {
                pos = 0;
                counter = 0;
                unitList.clear();
                me->CastSpell(me, SPELL_HORSEMAN_MOUNT, true);
                me->SetSpeed(MOVE_WALK, 3.0f, true);
                Unmount = false;
            }

            bool Unmount;
            EventMap events;
            uint32 counter;
            std::list<uint64> unitList;
            int32 pos;
            void EnterCombat(Unit*) {}
            void MoveInLineOfSight(Unit*  /*who*/){}

            void DoAction(int32 param)
            {
                pos = param;
            }

            void GetPosToLand(float &x, float &y, float &z)
            {
                switch (pos)
                {
                    case 235431: x = -9445.1f; y = 63.27f; z = 58.16f; break;
                    case 235432: x = -5616.30f; y = -481.89f; z = 398.99f; break;
                    case 235433: x = -4198.1f; y = -12509.13f; z = 46.6f; break;
                    case 235434: x = 360.9f; y = -4735.5f; z = 11.773f; break;
                    case 235435: x = 2229.4f; y = 263.1f; z = 36.13f; break;
                    case 235436: x = 9532.9f; y = -6833.8f; z = 18.5f; break;
                }
            }

            void Reset()
            {
                unitList.clear();
                std::list<Creature*> temp;
                me->GetCreaturesWithEntryInRange(temp, 100.0f, NPC_FIRE_TRIGGER);
                for (std::list<Creature*>::const_iterator itr = temp.begin(); itr != temp.end(); ++itr)
                    unitList.push_back((*itr)->GetGUID());

                events.ScheduleEvent(1, 3000);
                events.ScheduleEvent(2, 5000);
                events.ScheduleEvent(2, 7000);
                events.ScheduleEvent(2, 10000);
                events.ScheduleEvent(3, 15000);
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.GetEvent())
                {
                    case 1:
                        me->MonsterYell("Prepare yourselves, the bells have tolled! Shelter your weak, your young and your old! Each of you shall pay the final sum! Cry for mercy; the reckoning has come!", LANG_UNIVERSAL, 0);
                        me->PlayDirectSound(11966);
                        events.PopEvent();
                        break;
                    case 2:
                    {
                        if (Unit* trigger = getTrigger())
                            me->CastSpell(trigger, SPELL_START_FIRE, true);
                        events.PopEvent();
                        break;
                    }
                    case 3:
                    {
                        counter++;
                        if (counter > 10)
                        {
                            if (counter > 12)
                            {
                                bool failed = false;
                                for (std::list<uint64>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                                    if (Unit* c = ObjectAccessor::GetUnit(*me, *itr))
                                        if (c->HasAuraType(SPELL_AURA_PERIODIC_DUMMY))
                                        {
                                            failed = true;
                                            break;
                                        }

                                FinishEvent(failed);
                                events.PopEvent();
                            }
                            return;
                        }
                        if (counter == 5)
                        {
                            me->MonsterYell("The sky is dark. The fire burns. You strive in vain as Fate's wheel turns.", LANG_UNIVERSAL, 0);
                            me->PlayDirectSound(12570);
                        }
                        else if (counter == 10)
                        {
                            me->MonsterYell("The town still burns. A cleansing fire! Time is short, I'll soon retire!", LANG_UNIVERSAL, 0);
                            me->PlayDirectSound(12571);
                        }

                        if (Unit* trigger = getTrigger())
                            me->CastSpell(trigger, SPELL_START_FIRE, true);
                        events.RepeatEvent(12000);
                        break;
                    }
                }

                if (Unmount)
                {
                    me->SetUInt32Value(UNIT_FIELD_FLAGS, 0);
                    me->RemoveAllAuras();
                    me->Dismount();
                    if (Unit* target = me->SelectNearestPlayer(30.0f))
                        AttackStart(target);
                }
                if (me->IsMounted())
                    return;

                if (!UpdateVictim())
                    return;

                // cleave
                if (!urand(0,29))
                    me->CastSpell(me->GetVictim(), 15496, false);

                DoMeleeAttackIfReady();
            }

            Unit* getTrigger()
            {
                std::list<Unit*> tmpList;
                for (std::list<uint64>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                    if (Unit* c = ObjectAccessor::GetUnit(*me, *itr))
                        if (!c->HasAuraType(SPELL_AURA_PERIODIC_DUMMY))
                            tmpList.push_back(c);

                if (tmpList.empty())
                    return NULL;

                std::list<Unit*>::const_iterator it2 = tmpList.begin();
                std::advance(it2, urand(0, tmpList.size() - 1));
                return (*it2);
            }

            void FinishEvent(bool failed)
            {
                if (failed)
                {
                    me->MonsterYell("Fire consumes! You've tried and failed. Let there be no doubt, justice prevailed!", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(11967);
                    for (std::list<uint64>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                        if (Unit* c = ObjectAccessor::GetUnit(*me, *itr))
                            c->RemoveAllAuras();

                    me->DespawnOrUnsummon(1);
                }
                else
                {
                    me->MonsterYell("My flames have died, left not a spark! I shall send you now to the lifeless dark!", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(11968);
                    float x, y, z;
                    GetPosToLand(x, y, z);
                    me->GetMotionMaster()->MovePoint(8, x, y, z);
                }
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type == POINT_MOTION_TYPE && point == 8)
                {
                    Unmount = true;
                }
            }

            void JustDied(Unit*  /*killer*/)
            {
                me->MonsterYell("So eager you are, for my blood to spill. Yet to vanquish me, 'tis my head you must kill!", LANG_UNIVERSAL, 0);
                me->PlayDirectSound(11969);
                float x, y, z;
                GetPosToLand(x, y, z);
                me->CastSpell(x, y, z, SPELL_SUMMON_LANTERN, true);
                CompleteQuest();
            }

            void CompleteQuest()
            {
                float radius = 100.0f;
                std::list<Player*> players;
                Trinity::AnyPlayerInObjectRangeCheck checker(me, radius);
                Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(me, players, checker);
                me->VisitNearbyWorldObject(radius, searcher);

                for (std::list<Player*>::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                {
                    (*itr)->AreaExploredOrEventHappens(QUEST_STOP_THE_FIRES_H);
                    (*itr)->AreaExploredOrEventHappens(QUEST_STOP_THE_FIRES_A);
                    (*itr)->AreaExploredOrEventHappens(QUEST_LET_THE_FIRES_COME_H);
                    (*itr)->AreaExploredOrEventHappens(QUEST_LET_THE_FIRES_COME_A);
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_hallows_end_sohAI(creature);
        }
};

class npc_hallows_end_train_fire : public CreatureScript
{
    public:
        npc_hallows_end_train_fire() : CreatureScript("npc_hallows_end_train_fire") { }

        struct npc_hallows_end_train_fireAI : public NullCreatureAI
        {
            npc_hallows_end_train_fireAI(Creature* creature) : NullCreatureAI(creature)
            {
            }

            uint32 timer;
            void Reset()
            {
                timer = 0;
            }

            void UpdateAI(uint32 diff)
            {
                timer += diff;
                if (timer >= 5000)
                    if (!me->GetAuraEffect(SPELL_FIRE_AURA_BASE, EFFECT_0))
                        me->CastSpell(me, SPELL_FIRE_AURA_BASE, true);
            }

            void SpellHit(Unit* caster, const SpellInfo* spellInfo)
            {
                if (spellInfo->Id == SPELL_WATER_SPLASH && caster->ToPlayer())
                {
                    if (AuraEffect* aurEff = me->GetAuraEffect(SPELL_FIRE_AURA_BASE, EFFECT_0))
                    {
                        int32 amt = aurEff->GetAmount();
                        if (amt > 1)
                            aurEff->SetAmount(amt-1);
                        else
                            me->RemoveAllAuras();

                        caster->ToPlayer()->KilledMonsterCredit(me->GetEntry(), 0);
                    }
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_hallows_end_train_fireAI(creature);
        }
};

///////////////////////////////////////
////// HEADLESS HORSEMAN EVENT
///////////////////////////////////////

enum headlessHorseman
{
    // NPCs
    NPC_HEADLESS_HORSEMAN_MOUNTED                   = 23682,
    NPC_HORSEMAN_HEAD                               = 23775,
    NPC_PUMPKIN_FIEND                               = 23545,
    NPC_PUMPKIN                                     = 23694,

    // Spells
    SPELL_SHAKE_CAMERA_MEDIUM                       = 42909,
    SPELL_SHAKE_CAMERA_SMALL                        = 42910,
    SPELL_HORSEMAN_VISUAL                           = 42575,
    SPELL_SUMMONING_RHYME_TARGET                    = 42878,
    SPELL_HEAD_VISUAL                               = 42413,
    SPELL_EARTH_EXPLOSION                           = 42427,
    SPELL_HORSEMAN_CLEAVE                           = 42587,
    SPELL_HORSEMAN_BODY_REGEN                       = 42403,
    SPELL_HORSEMAN_BODY_REGEN_CONFUSE               = 43105,
    SPELL_HORSEMAN_IMMUNITY                         = 42556,
    SPELL_HEAD_DAMAGED_INFO                         = 43101,
    SPELL_BODY_RESTORED_INFO                        = 42405,
    SPELL_HEAD_VISUAL_LAND                          = 44241,
    SPELL_THROW_HEAD                                = 42399,
    SPELL_THROW_HEAD_BACK                           = 42401,
    SPELL_HORSEMAN_BODY_PHASE                       = 42547,
    SPELL_HORSEMAN_SPEAKS                           = 43129,
    SPELL_HORSEMAN_WHIRLWIND                        = 43116,
    SPELL_HORSEMAN_CONFLAGRATION                    = 42380,
    SPELL_SUMMON_PUMPKIN                            = 42552,
    SPELL_PUMPKIN_VISUAL                            = 42280,
    SPELL_SQUASH_SOUL                               = 42514,
    SPELL_SPROUTING                                 = 42281,
    SPELL_PUMPKIN_AURA                              = 42294,
    SPELL_BURNING_BODY                              = 43184,


    // NP
    SPELL_HORSEMAN_SMOKE                            = 42355,
    SPELL_SPIRIT_PARTICLES_GREEN_CHEST              = 43161,
    SPELL_SPIRIT_PARTICLES_GREEN                    = 43167,

    // Events
    EVENT_HH_PLAYER_TALK                            = 1,
    EVENT_HORSEMAN_CLEAVE                           = 2,
    EVENT_HORSEMAN_WHIRLWIND                        = 3,
    EVENT_HORSEMAN_CHECK_HEALTH                     = 4,
    EVENT_HORSEMAN_CONFLAGRATION                    = 5,
    EVENT_SUMMON_PUMPKIN                            = 6,
    EVENT_HORSEMAN_FOLLOW                           = 7,
};

enum hhSounds
{
    SOUND_AGGRO                                     = 11961,
    SOUND_SLAY                                      = 11962,
    SOUND_SPROUT                                    = 11963,
    SOUND_DEATH                                     = 11964,
};

class boss_headless_horseman : public CreatureScript
{
    public:
        boss_headless_horseman() : CreatureScript("boss_headless_horseman") { }

        struct boss_headless_horsemanAI : public ScriptedAI
        {
            boss_headless_horsemanAI(Creature* creature) : ScriptedAI(creature), summons(me)
            {
            }

            EventMap events;
            SummonList summons;
            uint64 playerGUID;
            uint8 talkCount;
            bool inFight;
            uint8 phase;
            uint32 health;

            void JustDied(Unit*  /*killer*/)
            {
                summons.DespawnAll();
                me->MonsterSay("This end have I reached before. What new adventure lies in store?", LANG_UNIVERSAL, 0);
                me->PlayDirectSound(SOUND_DEATH);
                std::list<Creature*> unitList;
                me->GetCreaturesWithEntryInRange(unitList, 100.0f, NPC_PUMPKIN_FIEND);
                for (std::list<Creature*>::iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                    (*itr)->ToCreature()->DespawnOrUnsummon(500);

                
                Map::PlayerList const& players = me->GetMap()->GetPlayers();
                if (!players.isEmpty() && players.begin()->GetSource() && players.begin()->GetSource()->GetGroup())
                    sLFGMgr->FinishDungeon(players.begin()->GetSource()->GetGroup()->GetGUID(), 285, me->FindMap());
            }

            void KilledUnit(Unit*  /*who*/)
            {
                me->MonsterYell("Your body lies beaten, battered and broken. Let my curse be your own, fate has spoken.", LANG_UNIVERSAL, 0);
                me->PlayDirectSound(SOUND_SLAY);
            }

            void DoAction(int32 param)
            {
                health = param;
            }

            void SpellHitTarget(Unit* target, const SpellInfo* spellInfo)
            {
                if (spellInfo->Id == SPELL_SUMMONING_RHYME_TARGET)
                {
                    playerGUID = target->GetGUID();
                    events.ScheduleEvent(EVENT_HH_PLAYER_TALK, 2000);
                }
            }

            void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo)
            {
                if (spellInfo->Id == SPELL_THROW_HEAD_BACK)
                {
                    me->SetHealth(me->GetMaxHealth());
                    me->CastSpell(me, SPELL_HEAD_VISUAL, true);
                    me->RemoveAura(SPELL_HORSEMAN_IMMUNITY);
                    me->RemoveAura(SPELL_HORSEMAN_BODY_REGEN);
                    me->RemoveAura(SPELL_HORSEMAN_BODY_REGEN_CONFUSE);
                    me->RemoveAura(SPELL_HORSEMAN_WHIRLWIND);
                    events.CancelEvent(EVENT_HORSEMAN_CHECK_HEALTH);
                    events.CancelEvent(EVENT_HORSEMAN_WHIRLWIND);
                    events.CancelEvent(EVENT_HORSEMAN_CONFLAGRATION);
                    events.CancelEvent(EVENT_SUMMON_PUMPKIN);
                    me->MonsterYell("Here's my body, fit and pure! Now, your blackened souls I'll cure!", LANG_UNIVERSAL, 0);
                    
                    if (phase == 1)
                        events.ScheduleEvent(EVENT_HORSEMAN_CONFLAGRATION, 6000);
                    else if (phase == 2)
                        events.ScheduleEvent(EVENT_SUMMON_PUMPKIN, 6000);
                }
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type == WAYPOINT_MOTION_TYPE)
                {
                    if (point == 0)
                        me->CastSpell(me, SPELL_HEAD_VISUAL, true);
                    else if (point == 11)
                    {
                        me->SetUInt32Value(UNIT_FIELD_FLAGS, 0);
                        me->StopMoving();
                        
                        me->SetInCombatWithZone();
                        inFight = true;
                        events.ScheduleEvent(EVENT_HORSEMAN_FOLLOW, 500);
                        events.ScheduleEvent(EVENT_HORSEMAN_CLEAVE, 7000);
                    }
                }
            }

            Player* GetRhymePlayer() { return playerGUID ? ObjectAccessor::GetPlayer(*me, playerGUID) : NULL; }

            void EnterCombat(Unit*) { me->SetInCombatWithZone(); }
            void MoveInLineOfSight(Unit*  /*who*/) {}

            void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
            {
                // We die... :(
                if (damage >= me->GetHealth())
                {
                    damage = 0;
                    me->RemoveAura(SPELL_HEAD_VISUAL);
                    me->CastSpell(me, SPELL_HORSEMAN_IMMUNITY, true);
                    me->CastSpell(me, SPELL_HORSEMAN_BODY_REGEN, true);
                    me->CastSpell(me, SPELL_HORSEMAN_BODY_REGEN_CONFUSE, true);
                    events.CancelEvent(EVENT_HORSEMAN_CLEAVE);

                    // Summon Head
                    Position pos;
                    me->GetNearPosition(pos, 15.0f, rand_norm()*2*M_PI);
                    if (Creature* cr = me->SummonCreature(NPC_HORSEMAN_HEAD, pos))
                    {
                        if (health)
                            cr->SetHealth(health);

                        me->CastSpell(cr, SPELL_THROW_HEAD, true);
                        cr->CastSpell(cr, SPELL_HORSEMAN_BODY_PHASE+phase, true);
                        if (phase < 2)
                            phase++;

                        events.ScheduleEvent(EVENT_HORSEMAN_WHIRLWIND, 6000);
                        events.ScheduleEvent(EVENT_HORSEMAN_CHECK_HEALTH, 1000);
                    }
                }
            }

            void JustSummoned(Creature* cr) { summons.Summon(cr); }

            void Reset()
            {
                events.Reset();
                summons.DespawnAll();
                playerGUID = 0;
                talkCount = 0;
                phase = 0;
                inFight = false;
                health = 0;
                
                me->SetDisableGravity(true);
                me->SetSpeed(MOVE_WALK, 5.0f, true);
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (inFight && !UpdateVictim())
                    return;

                switch (events.GetEvent())
                {
                    case EVENT_HH_PLAYER_TALK:
                    {
                        talkCount++;
                        Player* player = GetRhymePlayer();
                        if (!player)
                            return;

                        switch (talkCount)
                        {
                        case 1:
                            player->MonsterSay("Horseman rise...", LANG_UNIVERSAL, 0);
                            break;
                        case 2:
                            player->MonsterSay("Your time is nigh...", LANG_UNIVERSAL, 0);
                            if (Creature* trigger = me->SummonTrigger(1765.28f, 1347.46f, 17.5514f, 0.0f, 15*IN_MILLISECONDS))
                                trigger->CastSpell(trigger, SPELL_EARTH_EXPLOSION, true);
                            break;
                        case 3:
                            me->GetMotionMaster()->MovePath(236820, false);
                            me->CastSpell(me, SPELL_SHAKE_CAMERA_SMALL, true);
                            player->MonsterSay("You felt death once...", LANG_UNIVERSAL, 0);
                            me->MonsterSay("It is over, your search is done. Let fate choose now, the righteous one.", LANG_UNIVERSAL, 0);
                            me->PlayDirectSound(SOUND_AGGRO);
                            break;
                        case 4:
                            me->CastSpell(me, SPELL_SHAKE_CAMERA_MEDIUM, true);
                            player->MonsterSay("Now, know demise!", LANG_UNIVERSAL, 0);
                            events.PopEvent();
                            talkCount = 0;
                            return; // pop and return, skip repeat
                        }
                        events.RepeatEvent(2000);
                        break;
                    }
                    case EVENT_HORSEMAN_FOLLOW:
                    {
                        if (Player* player = GetRhymePlayer())
                        {
                            me->GetMotionMaster()->MoveIdle();
                            AttackStart(player);
                            me->GetMotionMaster()->MoveChase(player);
                        }
                        events.PopEvent();
                        break;
                    }
                    case EVENT_HORSEMAN_CLEAVE:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_HORSEMAN_CLEAVE, false);
                        events.RepeatEvent(8000);
                        break;
                    }
                    case EVENT_HORSEMAN_WHIRLWIND:
                    {
                        if (me->HasAuraEffect(SPELL_HORSEMAN_WHIRLWIND, EFFECT_0))
                        {
                            me->RemoveAura(SPELL_HORSEMAN_WHIRLWIND);
                            events.RepeatEvent(15000);
                            break;
                        }
                        me->CastSpell(me, SPELL_HORSEMAN_WHIRLWIND, true);
                        events.RepeatEvent(6000);
                        break;
                    }
                    case EVENT_HORSEMAN_CHECK_HEALTH:
                    {
                        if (me->GetHealth() == me->GetMaxHealth())
                        {
                            me->CastSpell(me, SPELL_BODY_RESTORED_INFO, true);
                            events.PopEvent();
                            return;
                        }

                        events.RepeatEvent(1000);
                        break;
                    }
                    case EVENT_HORSEMAN_CONFLAGRATION:
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, SPELL_HORSEMAN_CONFLAGRATION, false);

                        events.RepeatEvent(12500);
                        break;
                    }
                    case EVENT_SUMMON_PUMPKIN:
                    {
                        if (talkCount < 4)
                        {
                            events.RepeatEvent(1);
                            talkCount++;
                            me->CastSpell(me, SPELL_SUMMON_PUMPKIN, false);
                        }
                        else
                        {
                            me->MonsterSay("Soldiers arise, stand and fight! Bring victory at last to this fallen knight!", LANG_UNIVERSAL, 0);
                            me->PlayDirectSound(SOUND_SPROUT);
                            events.RepeatEvent(15000);
                            talkCount = 0;
                        }

                        break;
                    }
                }

                if (inFight)
                    DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_headless_horsemanAI(creature);
        }
};

class boss_headless_horseman_head : public CreatureScript
{
    public:
        boss_headless_horseman_head() : CreatureScript("boss_headless_horseman_head") { }

        struct boss_headless_horseman_headAI : public ScriptedAI
        {
            boss_headless_horseman_headAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            uint8 pct;
            uint32 timer;
            bool handled;

            void SpellHitTarget(Unit*  /*target*/, const SpellInfo* spellInfo)
            {
                if (spellInfo->Id == SPELL_THROW_HEAD_BACK)
                {
                    if (Unit* owner = GetOwner())
                        owner->ToCreature()->AI()->DoAction(me->GetHealth());

                    me->DespawnOrUnsummon();
                }
            }

            void SpellHit(Unit* caster, const SpellInfo* spellInfo)
            {
                switch (spellInfo->Id)
                {
                    case SPELL_BODY_RESTORED_INFO:
                        me->RemoveAllAuras();
                        if (Unit* owner = GetOwner())
                            owner->RemoveAura(SPELL_HORSEMAN_IMMUNITY);
                        me->CastSpell(caster, SPELL_THROW_HEAD_BACK, true);
                        break;
                    case SPELL_THROW_HEAD:
                    {
                        me->CastSpell(me, SPELL_HEAD_VISUAL_LAND, true);
                        if (Player* player = me->SelectNearestPlayer(50.0f))
                            me->GetMotionMaster()->MoveFleeing(player);

                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        timer = 26000;
                        break;
                    }
                    case SPELL_HORSEMAN_BODY_PHASE:
                        pct = 67;
                        break;
                    case SPELL_HORSEMAN_BODY_PHASE+1:
                        pct = 34;
                        break;
                    case SPELL_HORSEMAN_BODY_PHASE+2:
                        pct = 0;
                        break;
                }
            }

            Unit* GetOwner()
            {
                if (me->ToTempSummon())
                    return me->ToTempSummon()->GetSummoner();

                return NULL;
            }

            void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
            {
                // We die... :(
                if (damage >= me->GetHealth())
                {
                    if (Unit* owner = GetOwner())
                    {
                        owner->CastSpell(owner, SPELL_BURNING_BODY, true);
                        Unit::Kill(me, owner);
                    }
                    damage = 0;
                    me->DespawnOrUnsummon();
                    return;
                }

                if (me->HealthBelowPctDamaged(pct, damage) && !handled)
                {
                    handled = true;
                    damage = 0;
                    me->RemoveAllAuras();
                    me->CastSpell(me, SPELL_HEAD_DAMAGED_INFO, true);
                    me->CastSpell(me, SPELL_THROW_HEAD_BACK, true); 
                    if (Unit* owner = GetOwner())
                        owner->RemoveAura(SPELL_HORSEMAN_IMMUNITY);
                }
            }

            void Reset()
            {
                pct = 0;
                timer = 0;
                handled = false;
                me->SetInCombatWithZone();
            }

            void UpdateAI(uint32 diff)
            {
                timer += diff;
                if (timer >= 30000)
                {
                    timer = urand(0, 15000);
                    uint32 sound = 11965;
                    switch (urand(0,2))
                    {
                    case 1: sound = 11975; break;
                    case 2: sound = 11976; break;
                    }

                    me->CastSpell(me, SPELL_HORSEMAN_SPEAKS, true);
                    me->MonsterTextEmote("Headless Horseman laughs", 0);
                    me->PlayDirectSound(sound);
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_headless_horseman_headAI(creature);
        }
};

class boss_headless_horseman_pumpkin : public CreatureScript
{
    public:
        boss_headless_horseman_pumpkin() : CreatureScript("boss_headless_horseman_pumpkin") { }

        struct boss_headless_horseman_pumpkinAI : public ScriptedAI
        {
            boss_headless_horseman_pumpkinAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            uint32 timer;

            void AttackStart(Unit* ) { }
            void MoveInLineOfSight(Unit* ) { }

            void Reset()
            {
                if (Player* player = me->SelectNearestPlayer(3.0f))
                    me->CastSpell(player, SPELL_SQUASH_SOUL, true);
                timer = 1;
                me->CastSpell(me, SPELL_PUMPKIN_AURA, true);
                me->CastSpell(me, SPELL_PUMPKIN_VISUAL, true);
            }

            void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo)
            {
                if (spellInfo->Id == SPELL_SPROUTING)
                {
                    if (Creature* cr = me->SummonCreature(NPC_PUMPKIN_FIEND, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                        cr->SetInCombatWithZone();

                    me->DespawnOrUnsummon();
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (timer)
                {
                    timer += diff;
                    if (timer >= 3000)
                    {
                        me->CastSpell(me, SPELL_SPROUTING, false);
                        timer = 0;
                    }
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_headless_horseman_pumpkinAI(creature);
        }
};

class go_loosely_turned_soil : public GameObjectScript
{
public:
    go_loosely_turned_soil() : GameObjectScript("go_loosely_turned_soil") { }

    bool OnQuestReward(Player* player, GameObject* go, Quest const* /*quest*/, uint32 /*opt*/)
    {
        if (player->FindNearestCreature(NPC_HEADLESS_HORSEMAN_MOUNTED, 100.0f))
            return true;

        if (Creature* horseman = go->SummonCreature(NPC_HEADLESS_HORSEMAN_MOUNTED, 1754.00f, 1346.00f, 17.50f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN, 0))
            horseman->CastSpell(player, SPELL_SUMMONING_RHYME_TARGET, true);

        return true;
    }
};

void AddSC_event_hallows_end_scripts()
{
    // Spells
    new spell_hallows_end_trick();
    new spell_hallows_end_trick_or_treat();
    new spell_hallows_end_candy();
    new spell_hallows_end_tricky_treat();
    new spell_hallows_end_put_costume("spell_hallows_end_pirate_costume", SPELL_PIRATE_COSTUME_MALE, SPELL_PIRATE_COSTUME_FEMALE);
    new spell_hallows_end_put_costume("spell_hallows_end_leper_costume", SPELL_LEPER_GNOME_COSTUME_MALE, SPELL_LEPER_GNOME_COSTUME_FEMALE);
    new spell_hallows_end_put_costume("spell_hallows_end_ghost_costume", SPELL_GHOST_COSTUME_MALE, SPELL_GHOST_COSTUME_FEMALE);
    new spell_hallows_end_put_costume("spell_hallows_end_ninja_costume", SPELL_NINJA_COSTUME_MALE, SPELL_NINJA_COSTUME_FEMALE);
    
    // Quests
    new npc_hallows_end_train_fire();

    // Event
    new npc_costumed_orphan_matron();
    new npc_soh_fire_trigger();
    new npc_hallows_end_soh();
    new spell_hallows_end_base_fire();
    new spell_hallows_end_bucket_lands();

    // Headless Horseman
    new go_loosely_turned_soil();
    new boss_headless_horseman();
    new boss_headless_horseman_head();
    new boss_headless_horseman_pumpkin();
}
