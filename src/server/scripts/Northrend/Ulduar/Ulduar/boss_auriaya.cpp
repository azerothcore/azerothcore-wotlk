/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "ulduar.h"
#include "SpellAuraEffects.h"
#include "Player.h"

enum AuriayaSpells
{
    // BASIC
    SPELL_TERRIFYING_SCREECH            = 64386,
    SPELL_SENTINEL_BLAST_10             = 64389,
    SPELL_SENTINEL_BLAST_25             = 64678,
    SPELL_SONIC_SCREECH_10              = 64422,
    SPELL_SONIC_SCREECH_25              = 64688,
    SPELL_GUARDIAN_SWARM                = 64396,
    SPELL_ENRAGE                        = 47008,
    SPELL_ACTIVATE_FERAL_DEFENDER       = 64449,

    // Sanctum Sentry
    SPELL_SAVAGE_POUNCE_10              = 64666,
    SPELL_SAVAGE_POUNCE_25              = 64374,
    SPELL_RIP_FLESH_10                  = 64375,
    SPELL_RIP_FLESH_25                  = 64667,
    SPELL_STRENGTH_OF_THE_PACK          = 64369,

    // Feral Defender
    SPELL_FERAL_ESSENCE                 = 64455,
    SPELL_FERAL_POUNCE_10               = 64478,
    SPELL_FERAL_POUNCE_25               = 64669,
    SPELL_FERAL_RUSH_10                 = 64496,
    SPELL_FERAL_RUSH_25                 = 64674,
    //SPELL_SEEPING_FERAL_ESSENCE_SUMMON    = 64457,
    SPELL_SEEPING_FERAL_ESSENCE_10      = 64458,
    SPELL_SEEPING_FERAL_ESSENCE_25      = 64676,
};

#define SPELL_SONIC_SCREECH             RAID_MODE(SPELL_SONIC_SCREECH_10, SPELL_SONIC_SCREECH_25)
#define SPELL_SENTINEL_BLAST            RAID_MODE(SPELL_SENTINEL_BLAST_10, SPELL_SENTINEL_BLAST_25)
#define SPELL_SAVAGE_POUNCE             RAID_MODE(SPELL_SAVAGE_POUNCE_10, SPELL_SAVAGE_POUNCE_25)
#define SPELL_RIP_FLESH                 RAID_MODE(SPELL_RIP_FLESH_10, SPELL_RIP_FLESH_25)
#define SPELL_FERAL_POUNCE              RAID_MODE(SPELL_FERAL_POUNCE_10, SPELL_FERAL_POUNCE_25)
#define SPELL_FERAL_RUSH                RAID_MODE(SPELL_FERAL_RUSH_10, SPELL_FERAL_RUSH_25)
#define SPELL_SEEPING_FERAL_ESSENCE     RAID_MODE(SPELL_SEEPING_FERAL_ESSENCE_10, SPELL_SEEPING_FERAL_ESSENCE_25)

enum AuriayaNPC
{
    NPC_FERAL_DEFENDER                  = 34035,
    NPC_SANCTUM_SENTRY                  = 34014,
    NPC_SEEPING_FERAL_ESSENCE           = 34098,
};

enum AuriayaEvents
{
    EVENT_SUMMON_FERAL_DEFENDER         = 1,
    EVENT_TERRIFYING_SCREECH            = 2,
    EVENT_SONIC_SCREECH                 = 3,
    EVENT_GUARDIAN_SWARM                = 4,
    EVENT_SENTINEL_BLAST                = 5,
    EVENT_REMOVE_IMMUNE                 = 6,

    EVENT_RESPAWN_FERAL_DEFENDER        = 9,
    EVENT_ENRAGE                        = 10,
};

enum AuriayaSounds
{
    SOUND_AGGRO                         = 15473,
    SOUND_SLAY1                         = 15474,
    SOUND_SLAY2                         = 15475,
    SOUND_DEATH                         = 15476,
    SOUND_BERSERK                       = 15477,
    SOUND_WOUND                         = 15478,
};

enum Misc
{
    ACTION_FERAL_RESPAWN                = 1,
    ACTION_FERAL_DEATH                  = 2,
    ACTION_DESPAWN_ADDS                 = 3,
    ACTION_FERAL_DEATH_WITH_STACK       = 4,

    DATA_CRAZY_CAT                      = 10,
    DATA_NINE_LIVES                     = 11,
};

class boss_auriaya : public CreatureScript
{
public:
    boss_auriaya() : CreatureScript("boss_auriaya") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_auriayaAI (pCreature);
    }

    struct boss_auriayaAI : public ScriptedAI
    {
        boss_auriayaAI(Creature* pCreature) : ScriptedAI(pCreature), summons(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;

        bool _feralDied;
        bool _nineLives;

        void Reset()
        {
            _feralDied = false;
            _nineLives = false;

            events.Reset();
            EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
            summons.DoAction(ACTION_DESPAWN_ADDS, pred);
            summons.DespawnAll();

            if (m_pInstance)
                m_pInstance->SetData(TYPE_AURIAYA, NOT_STARTED);

            for (uint8 i = 0; i < RAID_MODE(2,4); ++i)
                me->SummonCreature(NPC_SANCTUM_SENTRY, me->GetPositionX()+urand(4,12), me->GetPositionY()+urand(4,12), me->GetPositionZ());
                
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
        }

        uint32 GetData(uint32 param) const
        {
            if (param == DATA_CRAZY_CAT)
                return !_feralDied;
            else if (param == DATA_NINE_LIVES)
                return _nineLives;

            return 0;
        }

        void JustSummoned(Creature* cr)
        {
            if (cr->GetEntry() == NPC_SANCTUM_SENTRY)
                cr->GetMotionMaster()->MoveFollow(me, 6, rand_norm()*2*3.14f);
            else
                cr->SetInCombatWithZone();

            summons.Summon(cr);
        }

        void SummonedCreatureDies(Creature* cr, Unit*)
        {
            if (cr->GetEntry() == NPC_SANCTUM_SENTRY)
                _feralDied = true;
        }

        void JustReachedHome() { me->setActive(false); }

        void EnterCombat(Unit*  /*who*/)
        {
            if (m_pInstance)
                m_pInstance->SetData(TYPE_AURIAYA, IN_PROGRESS);

            events.ScheduleEvent(EVENT_TERRIFYING_SCREECH, 35000);
            events.ScheduleEvent(EVENT_SONIC_SCREECH, 45000);
            events.ScheduleEvent(EVENT_GUARDIAN_SWARM, 70000);
            events.ScheduleEvent(EVENT_SUMMON_FERAL_DEFENDER, 60000);
            events.ScheduleEvent(EVENT_SENTINEL_BLAST, 36000);
            events.ScheduleEvent(EVENT_ENRAGE, 600000);

            summons.DoZoneInCombat(NPC_SANCTUM_SENTRY);

            me->MonsterYell("Some things are better left alone!", LANG_UNIVERSAL, 0);
            me->PlayDirectSound(SOUND_AGGRO);
            me->setActive(true);
        }

        void KilledUnit(Unit*  /*victim*/)
        {
            if (urand(0,2))
                return;

            if (urand(0,1))
            {
                me->MonsterYell("The secret dies with you!", LANG_UNIVERSAL, 0);
                me->PlayDirectSound(SOUND_SLAY1);
            }
            else
            {
                me->MonsterYell("There is no escape!", LANG_UNIVERSAL, 0);
                me->PlayDirectSound(SOUND_SLAY2);
            }
        }

        void JustDied(Unit * /*victim*/)
        {
            if (m_pInstance)
                m_pInstance->SetData(TYPE_AURIAYA, DONE);

            EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
            summons.DoAction(ACTION_DESPAWN_ADDS, pred);
            summons.DespawnAll();
            me->MonsterTextEmote("Auriaya screams in agony.", 0);
            me->PlayDirectSound(SOUND_DEATH);
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_FERAL_DEATH_WITH_STACK)
                events.ScheduleEvent(EVENT_RESPAWN_FERAL_DEFENDER, 25000);
            else if (param == ACTION_FERAL_DEATH)
                _nineLives = true;
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
                case EVENT_SUMMON_FERAL_DEFENDER:
                    me->MonsterTextEmote("Auriaya begins to activate Feral Defender.", 0, true);
                    me->CastSpell(me, SPELL_ACTIVATE_FERAL_DEFENDER, true);
                    events.PopEvent();
                    me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);
                    events.ScheduleEvent(EVENT_REMOVE_IMMUNE, 3000);
                    break;
                case EVENT_REMOVE_IMMUNE:
                    events.PopEvent();
                    me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);
                    break;
                case EVENT_TERRIFYING_SCREECH:
                    me->MonsterTextEmote("Auriaya begins to cast Terrifying Screech.", 0, true);
                    me->CastSpell(me, SPELL_TERRIFYING_SCREECH, false);
                    events.RepeatEvent(35000);
                    break;
                case EVENT_SONIC_SCREECH:
                    me->CastSpell(me, SPELL_SONIC_SCREECH, false);
                    events.RepeatEvent(50000);
                    break;
                case EVENT_GUARDIAN_SWARM:
                    me->CastSpell(me->GetVictim(), SPELL_GUARDIAN_SWARM, false);
                    events.RepeatEvent(40000);
                    break;
                case EVENT_SENTINEL_BLAST:
                    me->CastSpell(me, SPELL_SENTINEL_BLAST, false);
                    events.RepeatEvent(35000);
                    events.DelayEvents(5000, 0);
                    break;
                case EVENT_RESPAWN_FERAL_DEFENDER:
                {
                    EntryCheckPredicate pred(NPC_FERAL_DEFENDER);
                    summons.DoAction(ACTION_FERAL_RESPAWN, pred);
                    events.PopEvent();
                    break;
                }
                case EVENT_ENRAGE:
                    me->MonsterTextEmote("You waste my time!", 0);
                    me->PlayDirectSound(SOUND_BERSERK);
                    me->CastSpell(me, SPELL_ENRAGE, true);
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_auriaya_sanctum_sentry : public CreatureScript
{
public:
    npc_auriaya_sanctum_sentry() : CreatureScript("npc_auriaya_sanctum_sentry") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_auriaya_sanctum_sentryAI (pCreature);
    }

    struct npc_auriaya_sanctum_sentryAI : public ScriptedAI
    {
        npc_auriaya_sanctum_sentryAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        uint32 _savagePounceTimer;
        uint32 _ripFleshTimer;

        void EnterCombat(Unit*)
        {
            if (me->GetInstanceScript())
                if (Creature* cr = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_AURIAYA)))
                    cr->SetInCombatWithZone();
        }

        void Reset()
        {
            _savagePounceTimer = 5000;
            _ripFleshTimer = 0;

            me->CastSpell(me, SPELL_STRENGTH_OF_THE_PACK, true);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            _savagePounceTimer += diff;
            _ripFleshTimer += diff;

            if (_savagePounceTimer >= 5000)
            {
                float dist = me->GetDistance(me->GetVictim());
                if (dist >= 8 && dist < 25 && me->IsWithinLOSInMap(me->GetVictim()))
                {
                    me->CastSpell(me->GetVictim(), SPELL_SAVAGE_POUNCE, false);
                    _savagePounceTimer = 0;
                    return;
                }
                _savagePounceTimer = 200;
            }
            else if (_ripFleshTimer >= 10000)
            {
                me->CastSpell(me->GetVictim(), SPELL_RIP_FLESH, false);
                _ripFleshTimer = 0;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_auriaya_feral_defender : public CreatureScript
{
public:
    npc_auriaya_feral_defender() : CreatureScript("npc_auriaya_feral_defender") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_auriaya_feral_defenderAI (pCreature);
    }

    struct npc_auriaya_feral_defenderAI : public ScriptedAI
    {
        npc_auriaya_feral_defenderAI(Creature* pCreature) : ScriptedAI(pCreature), summons(pCreature) { }

        int32 _feralRushTimer;
        int32 _feralPounceTimer;
        uint8 _feralEssenceStack;
        SummonList summons;

        void Reset()
        {
            summons.DespawnAll();
            _feralRushTimer = 3000;
            _feralPounceTimer = 0;
            _feralEssenceStack = 8;

            if (Aura* aur = me->AddAura(SPELL_FERAL_ESSENCE, me))
                aur->SetStackAmount(_feralEssenceStack);
        }

        void JustDied(Unit*)
        {
            // inform about our death, start timer
            if (me->GetInstanceScript())
                if (Creature* cr = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_AURIAYA)))
                    cr->AI()->DoAction(_feralEssenceStack ? ACTION_FERAL_DEATH_WITH_STACK : ACTION_FERAL_DEATH);

            if (_feralEssenceStack)
            {
                if (Creature *cr = me->SummonCreature(NPC_SEEPING_FERAL_ESSENCE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f))
                    summons.Summon(cr);

                --_feralEssenceStack;
            }
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_FERAL_RESPAWN)
            {
                me->setDeathState(JUST_RESPAWNED);

                if (Player* target = SelectTargetFromPlayerList(200))
                    AttackStart(target);
                else
                {
                    summons.DespawnAll();
                    me->DespawnOrUnsummon(1);
                }

                if (_feralEssenceStack)
                    if (Aura* aur = me->AddAura(SPELL_FERAL_ESSENCE, me))
                        aur->SetStackAmount(_feralEssenceStack);
            }
            else if (param == ACTION_DESPAWN_ADDS)
                summons.DespawnAll();
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            _feralRushTimer += diff;
            _feralPounceTimer += diff;

            if (_feralRushTimer >= 6000)
            {
                DoResetThreat();
                if (!UpdateVictim())
                    return;

                me->CastSpell(me->GetVictim(), SPELL_FERAL_RUSH, true);
                _feralRushTimer = 0;
            }
            else if (_feralPounceTimer >= 6000)
            {
                me->CastSpell(me->GetVictim(), SPELL_FERAL_POUNCE, false);
                _feralPounceTimer = 0;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_auriaya_sentinel_blast : public SpellScriptLoader
{
    public:
        spell_auriaya_sentinel_blast() : SpellScriptLoader("spell_auriaya_sentinel_blast") { }

        class spell_auriaya_sentinel_blast_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_auriaya_sentinel_blast_SpellScript);

            void FilterTargets(std::list<WorldObject*>& unitList)
            {
                unitList.remove_if(PlayerOrPetCheck());
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_auriaya_sentinel_blast_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_auriaya_sentinel_blast_SpellScript();
        }
};

class achievement_auriaya_crazy_cat_lady : public AchievementCriteriaScript
{
    public:
        achievement_auriaya_crazy_cat_lady() : AchievementCriteriaScript("achievement_auriaya_crazy_cat_lady") {}

        bool OnCheck(Player*  /*player*/, Unit* target)
        {
            if (target)
                if (InstanceScript* instance = target->GetInstanceScript())
                    if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetData64(TYPE_AURIAYA)))
                        return cr->AI()->GetData(DATA_CRAZY_CAT);
                        
            return false;
        }
};

class achievement_auriaya_nine_lives : public AchievementCriteriaScript
{
    public:
        achievement_auriaya_nine_lives() : AchievementCriteriaScript("achievement_auriaya_nine_lives") {}

        bool OnCheck(Player*  /*player*/, Unit* target)
        {
            if (target)
                if (InstanceScript* instance = target->GetInstanceScript())
                    if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetData64(TYPE_AURIAYA)))
                        return cr->AI()->GetData(DATA_NINE_LIVES);
                        
            return false;
        }
};

void AddSC_boss_auriaya()
{
    new boss_auriaya();
    new npc_auriaya_sanctum_sentry();
    new npc_auriaya_feral_defender();

    new spell_auriaya_sentinel_blast();

    new achievement_auriaya_crazy_cat_lady();
    new achievement_auriaya_nine_lives();
}
