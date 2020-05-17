/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Twinemperors
SD%Complete: 95
SDComment:
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "temple_of_ahnqiraj.h"
#include "WorldPacket.h"
#include "Item.h"
#include "Spell.h"

enum Spells
{
    SPELL_HEAL_BROTHER            = 7393,
    SPELL_TWIN_TELEPORT           = 800,                     // CTRA watches for this spell to start its teleport timer
    SPELL_TWIN_TELEPORT_VISUAL    = 26638,                  // visual
    SPELL_EXPLODEBUG              = 804,
    SPELL_MUTATE_BUG              = 802,
    SPELL_BERSERK                 = 26662,
    SPELL_UPPERCUT                = 26007,
    SPELL_UNBALANCING_STRIKE      = 26613,
    SPELL_SHADOWBOLT              = 26006,
    SPELL_BLIZZARD                = 26607,
    SPELL_ARCANEBURST             = 568,
};

enum Sound
{
    SOUND_VL_AGGRO                = 8657,                    //8657 - Aggro - To Late
    SOUND_VL_KILL                 = 8658,                    //8658 - Kill - You will not
    SOUND_VL_DEATH                = 8659,                    //8659 - Death
    SOUND_VN_DEATH                = 8660,                    //8660 - Death - Feel
    SOUND_VN_AGGRO                = 8661,                    //8661 - Aggro - Let none
    SOUND_VN_KILL                 = 8662,                    //8661 - Kill - your fate
};

enum Misc
{
    PULL_RANGE                    = 50,
    ABUSE_BUG_RANGE               = 20,
    VEKLOR_DIST                   = 20,                      // VL will not come to melee when attacking
    TELEPORTTIME                  = 30000
};

enum Events
{
    // Veknilash
    EVENT_VEKNILASH_UPPERCUT = 1,
    EVENT_VEKNILASH_UNBALANCINGSTRIKE = 2,

    // Veklor
    EVENT_VEKLOR_SHADOWBOLT = 1,
    EVENT_VEKLOR_BLIZZARD = 2,
    EVENT_VEKLOR_ARCANEBURST = 3,

    // Both
    EVENT_ENRAGE = 99,
    EVENT_SCARABS = 100,
    EVENT_TELEPORT = 101,
    EVENT_TELEPORT_AFTER = 102
};

struct boss_twinemperorsAI : public ScriptedAI
{
    boss_twinemperorsAI(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
        DontYellWhenDead = false;
        AfterTeleport = false;
    }

    virtual bool IAmVeklor() = 0;
    virtual void Reset() = 0;

    void DoTwinReset()
    {
        me->ClearUnitState(UNIT_STATE_STUNNED);
        DontYellWhenDead = false;
        AfterTeleport = false;
    }

    void DamageTaken(Unit* /*pUnit*/, uint32 &damage, DamageEffectType /*dType*/, SpellSchoolMask /*sMask*/)
    {
        if (Unit* pBoss = GetOtherBoss())
        {
            float DamagePercent = ((float)damage) / ((float)me->GetMaxHealth());
            int OverallDamage = (int)(DamagePercent * ((float)pBoss->GetMaxHealth()));
            int DamageToApply = pBoss->GetHealth() - OverallDamage;

            if (DamageToApply <= 0)
            {
                pBoss->setDeathState(JUST_DIED);
                pBoss->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
            }
        }
    }

    void JustDied(Unit* /*pUnit*/)
    {
        if (Creature* pBoss = GetOtherBoss())
        {
            pBoss->SetHealth(0);
            pBoss->setDeathState(JUST_DIED);
            pBoss->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        }

        if (DontYellWhenDead == false)
            DoPlaySoundToSet(me, IAmVeklor() ? SOUND_VL_DEATH : SOUND_VN_DEATH);
    }

    void KilledUnit(Unit* /*pUnit*/)
    {
        DoPlaySoundToSet(me, IAmVeklor() ? SOUND_VL_KILL : SOUND_VN_KILL);
    }

    void EnterCombat(Unit* pUnit)
    {
        DoZoneInCombat();

        if (Creature* pBoss = GetOtherBoss())
            if (pBoss->IsInCombat() == false)
                if (ScriptedAI* pBossAI = CAST_AI(ScriptedAI, pBoss->AI()))
                {
                    DoPlaySoundToSet(me, IAmVeklor() ? SOUND_VL_AGGRO : SOUND_VN_AGGRO);
                    pBossAI->AttackStart(pUnit);
                    pBossAI->DoZoneInCombat();
                }
    }

    void SpellHit(Unit* pUnit, const SpellInfo* sEntry)
    {
        if (pUnit == me)
            return;

        if (Creature* pBoss = GetOtherBoss())
        {
            if (sEntry->Id != SPELL_HEAL_BROTHER)
                return;

            uint32 MyTotalHealth = me->GetMaxHealth(), HisTotalHealth = pBoss->GetMaxHealth();
            float Multiplier = ((float)MyTotalHealth) / ((float)HisTotalHealth);
            if (Multiplier < 1)
                Multiplier = 1.0f / Multiplier;

            float HealBrotherAmount = 30000.0f;
            uint32 LargerHealAmount = (uint32)((HealBrotherAmount * Multiplier) - HealBrotherAmount);

            if (MyTotalHealth > HisTotalHealth)
            {
                uint32 tHealth = MyTotalHealth + LargerHealAmount;
                me->SetHealth(std::min(MyTotalHealth, tHealth));
            }
            else
            {
                uint32 tHealth = HisTotalHealth + LargerHealAmount;
                me->SetHealth(std::min(HisTotalHealth, tHealth));
            }
        }
    }

    void HealBrotherIfCan()
    {
        if (IAmVeklor() == true)
            return;

        if (Unit* pBoss = GetOtherBoss())
            if (pBoss->IsWithinDist(me, 60))
            {
                DoCast(pBoss, SPELL_HEAL_BROTHER);
            }
    }

    void TeleportToBrotherIfCan()
    {
        if (IAmVeklor() == true)
            return;

        if (Creature* pBoss = GetOtherBoss())
        {
            Position MyLocation;
            Position HisLocation;

            MyLocation.Relocate(me);
            HisLocation.Relocate(pBoss);

            me->SetPosition(HisLocation);
            pBoss->SetPosition(MyLocation);

            DoSetAfterTeleport();
            CAST_AI(boss_twinemperorsAI, pBoss->AI())->DoSetAfterTeleport();
        }
    }

    void DoSetAfterTeleport()
    {
        me->InterruptNonMeleeSpells(false);

        DoStopAttack();
        DoResetThreat();
        DoCast(me, SPELL_TWIN_TELEPORT_VISUAL);

        me->AddUnitState(UNIT_STATE_STUNNED);
        AfterTeleport = true;
    }

    Creature* RespawnNearbyBugsAndGetOne()
    {
        std::list<Creature*> pUnitList;
        me->GetCreatureListWithEntryInGrid(pUnitList, 15316, 150.0f);
        me->GetCreatureListWithEntryInGrid(pUnitList, 15317, 150.0f);

        if (pUnitList.empty() == true)
            return nullptr;

        Creature* pCreatureNearby = nullptr;
        for (std::list<Creature*>::const_iterator iter = pUnitList.begin(); iter != pUnitList.end(); ++iter)
            if (Creature* pCreature = *iter)
            {
                if (pCreature->isDead())
                {
                    pCreature->Respawn();
                    pCreature->setFaction(7);
                    pCreature->RemoveAllAuras();
                }

                if (pCreature->IsWithinDistInMap(me, ABUSE_BUG_RANGE))
                    if (!pCreatureNearby || (rand() % 4) == 0)
                        pCreatureNearby = pCreature;
            }
        return pCreatureNearby;
    }

    void MoveInLineOfSight(Unit* pUnit)
    {
        if (!pUnit || me->GetVictim())
            return;

        if (me->_CanDetectFeignDeathOf(pUnit) && me->CanCreatureAttack(pUnit))
            if (me->IsWithinDistInMap(pUnit, PULL_RANGE) && me->GetDistanceZ(pUnit) <= 7)
                AttackStart(pUnit);
    }

    Creature* GetOtherBoss()
    {
        return ObjectAccessor::GetCreature(*me, instance->GetData64(IAmVeklor() ? DATA_VEKNILASH : DATA_VEKLOR));
    }

protected:
    EventMap events;
    bool AfterTeleport;
private:
    InstanceScript* instance;
    bool DontYellWhenDead;
};

class boss_veknilash : public CreatureScript
{
public:
    boss_veknilash() : CreatureScript("boss_veknilash") { }
    CreatureAI* GetAI(Creature* creature) const { return GetInstanceAI<boss_veknilashAI>(creature); }

    struct boss_veknilashAI : public boss_twinemperorsAI
    {
        bool IAmVeklor() { return false; }
        boss_veknilashAI(Creature* creature) : boss_twinemperorsAI(creature) { }

        void Reset()
        {
            DoTwinReset();

            events.Reset();
        }

        void EnterCombat(Unit* /*pUnit*/)
        {
            events.ScheduleEvent(EVENT_VEKNILASH_UPPERCUT, urand(14000, 29000));
            events.ScheduleEvent(EVENT_VEKNILASH_UNBALANCINGSTRIKE, urand(8000, 18000));
            events.ScheduleEvent(EVENT_SCARABS, urand(7000, 14000));
            events.ScheduleEvent(EVENT_TELEPORT, 30000);
            events.ScheduleEvent(EVENT_ENRAGE, 3600000);
        }

        void JustDied(Unit* /*pUnit*/) { events.Reset(); }

        void UpdateAI(uint32 diff)
        {
            if (UpdateVictim() == false)
                return;

            HealBrotherIfCan();

            while (uint32 eventid = events.ExecuteEvent())
            {
                switch (eventid)
                {
                case EVENT_VEKNILASH_UPPERCUT:
                    if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 0, NOMINAL_MELEE_RANGE, true))
                        DoCast(pUnit, SPELL_UPPERCUT);
                    events.RepeatEvent(15000 + rand() % 15000);
                    break;
                case EVENT_VEKNILASH_UNBALANCINGSTRIKE:
                    DoCastVictim(SPELL_UNBALANCING_STRIKE);
                    events.RepeatEvent(8000 + rand() % 12000);
                    break;
                case EVENT_SCARABS:
                    if (Creature* pCreature = RespawnNearbyBugsAndGetOne())
                        MutateBug(pCreature);
                    events.RepeatEvent(2000);
                    break;
                case EVENT_TELEPORT:
                    TeleportToBrotherIfCan();
                    events.ScheduleEvent(EVENT_TELEPORT_AFTER, 2000);
                    events.RepeatEvent(30000);
                case EVENT_TELEPORT_AFTER:
                    if (AfterTeleport == true)
                    {
                        me->ClearUnitState(UNIT_STATE_STUNNED);
                        DoCast(me, SPELL_TWIN_TELEPORT);
                        me->AddUnitState(UNIT_STATE_STUNNED);

                        if (Unit* pUnit = me->SelectNearestTarget(100))
                        {
                            AttackStart(pUnit);
                            me->AddThreat(pUnit, 10000);
                        }
                    }
                    break;
                case EVENT_ENRAGE:
                    DoCast(me, SPELL_BERSERK);
                    events.RepeatEvent(3600000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void MutateBug(Creature* pCreature)
        {
            pCreature->setFaction(14);
            pCreature->AI()->AttackStart(me->getThreatManager().getHostilTarget());
            pCreature->AddAura(SPELL_MUTATE_BUG, pCreature);
            pCreature->SetFullHealth();
        }

    };
};

class boss_veklor : public CreatureScript
{
public:
    boss_veklor() : CreatureScript("boss_veklor") { }
    CreatureAI* GetAI(Creature* creature) const { return GetInstanceAI<boss_veklorAI>(creature); }

    struct boss_veklorAI : public boss_twinemperorsAI
    {
        bool IAmVeklor() { return true; }
        boss_veklorAI(Creature* creature) : boss_twinemperorsAI(creature) { }

        void Reset()
        {
            DoTwinReset();

            events.Reset();
        }

        void JustDied(Unit* /*pUnit*/) { events.Reset(); }

        void EnterCombat(Unit* /*pUnit*/)
        {

        }

        void UpdateAI(uint32 diff)
        {
            if (UpdateVictim() == false)
                return;

            HealBrotherIfCan();

            while (uint32 eventid = events.ExecuteEvent())
            {
                switch (eventid)
                {
                case EVENT_VEKLOR_SHADOWBOLT:
                    if (me->IsWithinDist(me->GetVictim(), 45.0) == false)
                        me->GetMotionMaster()->MoveChase(me->GetVictim(), VEKLOR_DIST, 0);
                    else
                        DoCastVictim(SPELL_SHADOWBOLT);
                    events.RepeatEvent(2000);
                    break;
                case EVENT_VEKLOR_BLIZZARD:
                    if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 0, 45, true))
                        DoCast(pUnit, SPELL_BLIZZARD);
                    events.RepeatEvent(15000 + rand() % 15000);
                    break;
                case EVENT_VEKLOR_ARCANEBURST:
                    if (Unit* pUnit = SelectTarget(SELECT_TARGET_NEAREST, 0, NOMINAL_MELEE_RANGE, true))
                        DoCast(pUnit, SPELL_ARCANEBURST);
                    events.RepeatEvent(5000);
                    break;
                case EVENT_SCARABS:
                    if (Creature* pCreature = RespawnNearbyBugsAndGetOne())
                        ExplodeBug(pCreature);
                    events.RepeatEvent(2000);
                    break;
                case EVENT_TELEPORT:
                    TeleportToBrotherIfCan();
                    events.ScheduleEvent(EVENT_TELEPORT_AFTER, 2000);
                    events.RepeatEvent(30000);
                case EVENT_TELEPORT_AFTER:
                    if (AfterTeleport == true)
                    {
                        me->ClearUnitState(UNIT_STATE_STUNNED);
                        DoCast(me, SPELL_TWIN_TELEPORT);
                        me->AddUnitState(UNIT_STATE_STUNNED);

                        if (Unit* pUnit = me->SelectNearestTarget(100))
                        {
                            AttackStart(pUnit);
                            me->AddThreat(pUnit, 10000);
                        }
                    }
                    break;
                case EVENT_ENRAGE:
                    DoCast(me, SPELL_BERSERK);
                    events.RepeatEvent(3600000);
                    break;
                }
            }
        }

        void ExplodeBug(Creature* pCreature)
        {
            pCreature->setFaction(14);
            pCreature->AddAura(SPELL_EXPLODEBUG, pCreature);
            pCreature->SetFullHealth();
        }

        void AttackStart(Unit* pUnit)
        {
            if (!pUnit)
                return;

            if (pUnit->isTargetableForAttack())
                if (me->Attack(pUnit, false))
                {
                    me->GetMotionMaster()->MoveChase(pUnit, VEKLOR_DIST, 0);
                    me->AddThreat(pUnit, 0.0f);
                }
        }

    };
};

void AddSC_boss_twinemperors()
{
    new boss_veknilash();
    new boss_veklor();
}
