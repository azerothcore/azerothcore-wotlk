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

#include "CreatureScript.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "InstanceScript.h"
#include "Map.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "blackwing_lair.h"

enum Emotes
{
    EMOTE_FRENZY                                           = 0,
    EMOTE_SHIMMER                                          = 1,
};

enum Spells
{
    // Other spells
    SPELL_INCINERATE                                       = 23308,   //Incinerate 23308, 23309
    SPELL_TIMELAPSE                                        = 23310,   //Time lapse 23310, 23311(old threat mod that was removed in 2.01)
    SPELL_CORROSIVEACID                                    = 23313,   //Corrosive Acid 23313, 23314
    SPELL_IGNITEFLESH                                      = 23315,   //Ignite Flesh 23315, 23316
    SPELL_FROSTBURN                                        = 23187,   //Frost burn 23187, 23189
    // Brood Affliction 23173 - Scripted Spell that cycles through all targets within 100 yards and has a chance to cast one of the afflictions on them
    // Since Scripted spells arn't coded I'll just write a function that does the same thing
    SPELL_BROODAF_BLUE                                     = 23153,   //Blue affliction 23153
    SPELL_BROODAF_BLACK                                    = 23154,   //Black affliction 23154
    SPELL_BROODAF_RED                                      = 23155,   //Red affliction 23155 (23168 on death)
    SPELL_BROODAF_BRONZE                                   = 23170,   //Bronze Affliction  23170
    SPELL_BROODAF_GREEN                                    = 23169,   //Brood Affliction Green 23169
    SPELL_CHROMATIC_MUT_1                                  = 23174,   //Spell cast on player if they get all 5 debuffs

    SPELL_ELEMENTAL_SHIELD                                 = 22276,
    SPELL_FRENZY                                           = 23128,
    SPELL_ENRAGE                                           = 23537
};

enum Events
{
    EVENT_SHIMMER       = 1,
    EVENT_BREATH        = 2,
    EVENT_AFFLICTION    = 3,
    EVENT_FRENZY        = 4
};

enum Misc
{
    GUID_LEVER_USER = 0
};

Position const homePos = { -7491.1587f, -1069.718f, 476.59094, 476.59094f };

class boss_chromaggus : public CreatureScript
{
public:
    boss_chromaggus() : CreatureScript("boss_chromaggus") { }

    struct boss_chromaggusAI : public BossAI
    {
        boss_chromaggusAI(Creature* creature) : BossAI(creature, DATA_CHROMAGGUS)
        {
            Initialize();

            // Select the 2 breaths that we are going to use until despawned so we don't end up casting 2 of the same breath.
            _breathSpells = { SPELL_INCINERATE, SPELL_TIMELAPSE,  SPELL_CORROSIVEACID, SPELL_IGNITEFLESH, SPELL_FROSTBURN };

            Acore::Containers::RandomResize(_breathSpells, 2);

            // Hack fix: This is here to prevent him from being pulled from the floor underneath, remove it once maps are fixed.
            creature->SetImmuneToAll(true);
        }

        void Initialize()
        {
            Enraged = false;
        }

        void Reset() override
        {
            _Reset();

            Initialize();
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);

            events.ScheduleEvent(EVENT_SHIMMER, 1s);
            events.ScheduleEvent(EVENT_BREATH, 30s);
            events.ScheduleEvent(EVENT_BREATH, 60s);
            events.ScheduleEvent(EVENT_AFFLICTION, 10s);
            events.ScheduleEvent(EVENT_FRENZY, 15s);
        }

        bool CanAIAttack(Unit const* victim) const override
        {
            return !victim->HasAura(SPELL_TIMELAPSE);
        }

        void SetGUID(ObjectGuid const& guid, int32 id) override
        {
            if (id == GUID_LEVER_USER)
            {
                _playerGUID = guid;
                // Hack fix: This is here to prevent him from being pulled from the floor underneath, remove it once maps are fixed.
                me->SetImmuneToAll(false);
            }
        }

        void PathEndReached(uint32 /*pathId*/) override
        {
            if (Unit* player = ObjectAccessor::GetUnit(*me, _playerGUID))
            {
                me->SetInCombatWith(player);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SHIMMER:
                        {
                            // Cast new random vulnerabilty on self
                            DoCast(me, SPELL_ELEMENTAL_SHIELD);
                            Talk(EMOTE_SHIMMER);
                            events.ScheduleEvent(EVENT_SHIMMER, 17s, 25s);
                            break;
                        }
                    case EVENT_BREATH:
                        DoCastVictim(_breathSpells.front());
                        _breathSpells.reverse();
                        events.ScheduleEvent(EVENT_BREATH, 60s);
                        break;
                    case EVENT_AFFLICTION:
                        {
                            uint32 afflictionSpellID = RAND(SPELL_BROODAF_BLUE, SPELL_BROODAF_BLACK, SPELL_BROODAF_RED, SPELL_BROODAF_BRONZE, SPELL_BROODAF_GREEN);
                            std::vector<Player*> playerTargets;
                            Map::PlayerList const& players = me->GetMap()->GetPlayers();
                            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                            {
                                if (Player* player = itr->GetSource()->ToPlayer())
                                {
                                    if (!player->IsGameMaster() && !player->IsSpectator() && player->IsAlive())
                                    {
                                        playerTargets.push_back(player);
                                    }
                                }
                            }

                            if (playerTargets.size() > 12)
                            {
                                Acore::Containers::RandomResize(playerTargets, 12);
                            }

                            for (Player* player : playerTargets)
                            {
                                DoCast(player, afflictionSpellID, true);

                                if (player->HasAllAuras(SPELL_BROODAF_BLUE, SPELL_BROODAF_BLACK, SPELL_BROODAF_RED, SPELL_BROODAF_BRONZE, SPELL_BROODAF_GREEN))
                                    DoCast(player, SPELL_CHROMATIC_MUT_1);
                            }
                        }
                        events.ScheduleEvent(EVENT_AFFLICTION, 10s);
                        break;
                    case EVENT_FRENZY:
                        DoCast(me, SPELL_FRENZY);
                        events.ScheduleEvent(EVENT_FRENZY, 10s, 15s);
                        break;
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
            }

            // Enrage if not already enraged and below 20%
            if (!Enraged && HealthBelowPct(20))
            {
                DoCast(me, SPELL_ENRAGE);
                Enraged = true;
            }

            DoMeleeAttackIfReady();
        }

    private:
        std::list<uint32> _breathSpells;
        bool Enraged;
        ObjectGuid _playerGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackwingLairAI<boss_chromaggusAI>(creature);
    }
};

class go_chromaggus_lever : public GameObjectScript
{
    public:
        go_chromaggus_lever() : GameObjectScript("go_chromaggus_lever") { }

        struct go_chromaggus_leverAI : public GameObjectAI
        {
            go_chromaggus_leverAI(GameObject* go) : GameObjectAI(go), _instance(go->GetInstanceScript()) { }

            bool GossipHello(Player* player, bool reportUse) override
            {
                if (reportUse)
                {
                    if (_instance->GetBossState(DATA_CHROMAGGUS) != DONE && _instance->GetBossState(DATA_CHROMAGGUS) != IN_PROGRESS)
                    {
                        if (Creature* creature = _instance->GetCreature(DATA_CHROMAGGUS))
                        {
                            creature->SetHomePosition(homePos);
                            creature->GetMotionMaster()->MoveWaypoint(creature->GetEntry() * 10, false);
                            creature->AI()->SetGUID(player->GetGUID(), GUID_LEVER_USER);
                        }

                        if (GameObject* go = _instance->GetGameObject(DATA_GO_CHROMAGGUS_DOOR))
                            _instance->HandleGameObject(ObjectGuid::Empty, true, go);
                    }

                    me->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE | GO_FLAG_IN_USE);
                    me->SetGoState(GO_STATE_ACTIVE);
                }

                return true;
            }

        private:
            InstanceScript* _instance;
        };

        GameObjectAI* GetAI(GameObject* go) const override
        {
            return GetBlackwingLairAI<go_chromaggus_leverAI>(go);
        }
};

enum ElementalShieldSpells
{
    SPELL_FIRE_ELEMENTAL_SHIELD     = 22277,
    SPELL_FROST_ELEMENTAL_SHIELD    = 22278,
    SPELL_SHADOW_ELEMENTAL_SHIELD   = 22279,
    SPELL_NATURE_ELEMENTAL_SHIELD   = 22280,
    SPELL_ARCANE_ELEMENTAL_SHIELD   = 22281,

    SPELL_RED_BROOD_POWER           = 22283,
    SPELL_BLUE_BROOD_POWER          = 22285,
    SPELL_BRONZE_BROOD_POWER        = 22286,
    SPELL_BLACK_BROOD_POWER         = 22287,
    SPELL_GREEN_BROOD_POWER         = 22288

};

class spell_gen_elemental_shield : public SpellScript
{
    PrepareSpellScript(spell_gen_elemental_shield);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_FIRE_ELEMENTAL_SHIELD,
                SPELL_FROST_ELEMENTAL_SHIELD,
                SPELL_SHADOW_ELEMENTAL_SHIELD,
                SPELL_NATURE_ELEMENTAL_SHIELD,
                SPELL_ARCANE_ELEMENTAL_SHIELD
            });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            for (uint32 spell = SPELL_FIRE_ELEMENTAL_SHIELD; spell <= SPELL_ARCANE_ELEMENTAL_SHIELD; ++spell)
            {
                caster->RemoveAurasDueToSpell(spell);
            }

            caster->CastSpell(caster, SPELL_FIRE_ELEMENTAL_SHIELD + urand(0, 4), true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_elemental_shield::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_gen_brood_power : public SpellScript
{
    PrepareSpellScript(spell_gen_brood_power);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_RED_BROOD_POWER,
                SPELL_BLUE_BROOD_POWER,
                SPELL_BRONZE_BROOD_POWER,
                SPELL_BLACK_BROOD_POWER,
                SPELL_GREEN_BROOD_POWER
            });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            for (uint32 spell = SPELL_RED_BROOD_POWER; spell <= SPELL_GREEN_BROOD_POWER; ++spell)
            {
                caster->RemoveAurasDueToSpell(spell);
            }

            caster->CastSpell(caster, RAND(SPELL_RED_BROOD_POWER, SPELL_BLUE_BROOD_POWER, SPELL_BRONZE_BROOD_POWER, SPELL_BLACK_BROOD_POWER, SPELL_GREEN_BROOD_POWER), true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_gen_brood_power::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_chromaggus()
{
    new boss_chromaggus();
    new go_chromaggus_lever();
    RegisterSpellScript(spell_gen_elemental_shield);
    RegisterSpellScript(spell_gen_brood_power);
}
