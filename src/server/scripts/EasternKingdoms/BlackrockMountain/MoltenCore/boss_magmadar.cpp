/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Magmadar
SD%Complete: 75
SDComment: Conflag on ground nyi
SDCategory: Molten Core
EndScriptData */

#include "ScriptMgr.h"
#include "SpellScript.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Texts
{
    EMOTE_FRENZY                    = 0,
};

enum Spells
{
    SPELL_FRENZY                    = 19451,
    SPELL_MAGMA_SPIT                = 19449,
    SPELL_PANIC                     = 19408,
    SPELL_LAVA_BOMB                 = 19411,                    // This calls a dummy server side effect that cast spell 20494 to spawn GO 177704 for 30s
    SPELL_LAVA_BOMB_EFFECT          = 20494,                    // Spawns trap GO 177704 which triggers 19428
    SPELL_LAVA_BOMB_RANGED          = 20474,                    // This calls a dummy server side effect that cast spell 20495 to spawn GO 177704 for 60s
    SPELL_LAVA_BOMB_RANGED_EFFECT   = 20495,                    // Spawns trap GO 177704 which triggers 19428
};

enum Events
{
    EVENT_FRENZY                    = 1,
    EVENT_PANIC,
    EVENT_LAVA_BOMB,
    EVENT_LAVA_BOMB_RANGED,
};

constexpr float MELEE_TARGET_LOOKUP_DIST = 10.0f;

class boss_magmadar : public CreatureScript
{
public:
    boss_magmadar() : CreatureScript("boss_magmadar") {}

    struct boss_magmadarAI : public BossAI
    {
        boss_magmadarAI(Creature* creature) : BossAI(creature, DATA_MAGMADAR) {}

        void EnterCombat(Unit* /*victim*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_FRENZY, 8500);
            events.ScheduleEvent(EVENT_PANIC, 9500);
            events.ScheduleEvent(EVENT_LAVA_BOMB, 12000);
            events.ScheduleEvent(EVENT_LAVA_BOMB_RANGED, 15000);
        }

        void ExecuteEvent(uint32 eventId) override
        {
            switch (eventId)
            {
                case EVENT_FRENZY:
                {
                    Talk(EMOTE_FRENZY);
                    DoCastSelf(SPELL_FRENZY);
                    events.RepeatEvent(urand(15000, 20000));
                    break;
                }
                case EVENT_PANIC:
                {
                    DoCastVictim(SPELL_PANIC);
                    events.RepeatEvent(urand(31000, 38000));
                    break;
                }
                case EVENT_LAVA_BOMB:
                {
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, MELEE_TARGET_LOOKUP_DIST, true))
                    {
                        DoCast(target, SPELL_LAVA_BOMB);
                    }

                    events.RepeatEvent(urand(12000, 15000));
                    break;
                }
                case EVENT_LAVA_BOMB_RANGED:
                {
                    std::list<Unit*> targets;
                    SelectTargetList(targets, [this](Unit* target)
                    {
                        return target && target->GetTypeId() == TYPEID_PLAYER && target->GetDistance(me) > MELEE_TARGET_LOOKUP_DIST && target->GetDistance(me) < 100.0f;
                    }, 1, SELECT_TARGET_RANDOM);

                    if (!targets.empty())
                    {
                        DoCast(targets.front() , SPELL_LAVA_BOMB_RANGED);
                    }
                    events.RepeatEvent(urand(12000, 15000));
                    break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_magmadarAI>(creature);
    }
};

// 19411 Lava Bomb
// 20474 Lava Bomb
class spell_magmadar_lava_bomb : public SpellScriptLoader
{
public:
    spell_magmadar_lava_bomb() : SpellScriptLoader("spell_magmadar_lava_bomb")
    {
    }

    class spell_magmadar_lava_bomb_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_magmadar_lava_bomb_SpellScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo({ SPELL_LAVA_BOMB_EFFECT, SPELL_LAVA_BOMB_RANGED_EFFECT });
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit* target = GetHitUnit())
            {
                uint32 spellId = 0;
                switch (m_scriptSpellId)
                {
                    case SPELL_LAVA_BOMB:
                    {
                        spellId = SPELL_LAVA_BOMB_EFFECT;
                        break;
                    }
                    case SPELL_LAVA_BOMB_RANGED:
                    {
                        spellId = SPELL_LAVA_BOMB_RANGED_EFFECT;
                        break;
                    }
                    default:
                    {
                        return;
                    }
                }
                target->CastSpell(target, spellId, true, nullptr, nullptr, GetCaster()->GetGUID());
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_magmadar_lava_bomb_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_magmadar_lava_bomb_SpellScript();
    }
};

void AddSC_boss_magmadar()
{
    new boss_magmadar();
    new spell_magmadar_lava_bomb();
}
