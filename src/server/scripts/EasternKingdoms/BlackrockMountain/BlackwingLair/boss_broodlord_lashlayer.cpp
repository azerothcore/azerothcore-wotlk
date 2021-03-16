/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "blackwing_lair.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "InstanceScript.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Say
{
    SAY_AGGRO               = 0,
    SAY_LEASH               = 1
};

enum Spells
{
    SPELL_CLEAVE            = 26350,
    SPELL_BLASTWAVE         = 23331,
    SPELL_MORTALSTRIKE      = 24573,
    SPELL_KNOCKBACK         = 25778,
    SPELL_SUPPRESSION_AURA  = 22247 // Suppression Device Spell
};

enum Events
{
    EVENT_CLEAVE            = 1,
    EVENT_BLASTWAVE         = 2,
    EVENT_MORTALSTRIKE      = 3,
    EVENT_KNOCKBACK         = 4,
    EVENT_CHECK             = 5,
    // Suppression Device Events
    EVENT_SUPPRESSION_CAST  = 6,
    EVENT_SUPPRESSION_RESET = 7
};

enum Actions
{
    ACTION_DEACTIVATE = 0
};

class boss_broodlord : public CreatureScript
{
public:
    boss_broodlord() : CreatureScript("boss_broodlord") { }

    struct boss_broodlordAI : public BossAI
    {
        boss_broodlordAI(Creature* creature) : BossAI(creature, DATA_BROODLORD_LASHLAYER) { }

        void EnterCombat(Unit* who) override
        {
            BossAI::EnterCombat(who);
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_CLEAVE, 8000);
            events.ScheduleEvent(EVENT_BLASTWAVE, 12000);
            events.ScheduleEvent(EVENT_MORTALSTRIKE, 20000);
            events.ScheduleEvent(EVENT_KNOCKBACK, 30000);
            events.ScheduleEvent(EVENT_CHECK, 1000);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();

            std::list<GameObject*> _goList;
            GetGameObjectListWithEntryInGrid(_goList, me, GO_SUPPRESSION_DEVICE, 200.0f);
            for (std::list<GameObject*>::const_iterator itr = _goList.begin(); itr != _goList.end(); itr++)
                ((*itr)->AI()->DoAction(ACTION_DEACTIVATE));
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CLEAVE:
                        DoCastVictim(SPELL_CLEAVE);
                        events.ScheduleEvent(EVENT_CLEAVE, 7000);
                        break;
                    case EVENT_BLASTWAVE:
                        DoCastVictim(SPELL_BLASTWAVE);
                        events.ScheduleEvent(EVENT_BLASTWAVE, 8000, 16000);
                        break;
                    case EVENT_MORTALSTRIKE:
                        DoCastVictim(SPELL_MORTALSTRIKE);
                        events.ScheduleEvent(EVENT_MORTALSTRIKE, 25000, 35000);
                        break;
                    case EVENT_KNOCKBACK:
                        DoCastVictim(SPELL_KNOCKBACK);
                        if (DoGetThreat(me->GetVictim()))
                            DoModifyThreatPercent(me->GetVictim(), -50);
                        events.ScheduleEvent(EVENT_KNOCKBACK, 15000, 30000);
                        break;
                    case EVENT_CHECK:
                        if (me->GetDistance(me->GetHomePosition()) > 150.0f)
                        {
                            Talk(SAY_LEASH);
                            EnterEvadeMode();
                        }
                        events.ScheduleEvent(EVENT_CHECK, 1000);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<boss_broodlordAI>(creature);
    }
};

class go_suppression_device : public GameObjectScript
{
    public:
        go_suppression_device() : GameObjectScript("go_suppression_device") { }

        struct go_suppression_deviceAI : public GameObjectAI
        {
            go_suppression_deviceAI(GameObject* go) : GameObjectAI(go), _instance(go->GetInstanceScript()), _active(true) { }

            void InitializeAI() override
            {
                if (_instance->GetBossState(DATA_BROODLORD_LASHLAYER) == DONE)
                {
                    Deactivate();
                    return;
                }

                _events.ScheduleEvent(EVENT_SUPPRESSION_CAST, 5000);
            }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SUPPRESSION_CAST:
                            if (go->GetGoState() == GO_STATE_READY)
                            {
                                go->CastSpell(nullptr, SPELL_SUPPRESSION_AURA);
                                go->SendCustomAnim(0);
                            }
                            _events.ScheduleEvent(EVENT_SUPPRESSION_CAST, 5000);
                            break;
                        case EVENT_SUPPRESSION_RESET:
                            Activate();
                            break;
                    }
                }
            }

            void OnLootStateChanged(uint32 state, Unit* /*unit*/)
            {
                switch (state)
                {
                    case GO_ACTIVATED:
                        Deactivate();
                        _events.CancelEvent(EVENT_SUPPRESSION_CAST);
                        _events.ScheduleEvent(EVENT_SUPPRESSION_RESET, 30000, 120000);
                        break;
                    case GO_JUST_DEACTIVATED: // This case prevents the Gameobject despawn by Disarm Trap
                        go->SetLootState(GO_READY);
                        break;
                }
            }

            void DoAction(int32 action) override
            {
                if (action == ACTION_DEACTIVATE)
                {
                    Deactivate();
                    _events.CancelEvent(EVENT_SUPPRESSION_RESET);
                }
            }

            void Activate()
            {
                if (_active)
                    return;
                _active = true;
                if (go->GetGoState() == GO_STATE_ACTIVE)
                    go->SetGoState(GO_STATE_READY);
                go->SetLootState(GO_READY);
                go->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                _events.ScheduleEvent(EVENT_SUPPRESSION_CAST, 1000);
            }

            void Deactivate()
            {
                if (!_active)
                    return;
                _active = false;
                go->SetGoState(GO_STATE_ACTIVE);
                go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                _events.CancelEvent(EVENT_SUPPRESSION_CAST);
            }

        private:
            InstanceScript* _instance;
            EventMap _events;
            bool _active;
        };

        GameObjectAI* GetAI(GameObject* go) const
        {
            return new go_suppression_deviceAI(go);
        }
};

void AddSC_boss_broodlord()
{
    new boss_broodlord();
    new go_suppression_device();
}
