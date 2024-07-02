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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "hyjal.h"

enum Texts
{
    SAY_AGGRO       = 1,
    SAY_DOOMFIRE    = 2,
    SAY_AIR_BURST   = 3,
    SAY_SLAY        = 4,
    SAY_ENRAGE      = 5,
    SAY_DEATH       = 6,
    SAY_SOUL_CHARGE = 7,
};

enum ArchiSpells
{
    SPELL_DENOUEMENT_WISP       = 32124,
    SPELL_ANCIENT_SPARK         = 39349,
    SPELL_PROTECTION_OF_ELUNE   = 38528,

    SPELL_DRAIN_WORLD_TREE      = 39140,
    SPELL_DRAIN_WORLD_TREE_2    = 39141,

    SPELL_FINGER_OF_DEATH       = 31984,
    SPELL_RED_SKY_EFFECT        = 32111,
    SPELL_HAND_OF_DEATH         = 35354,
    SPELL_AIR_BURST             = 32014,
    SPELL_GRIP_OF_THE_LEGION    = 31972,
    SPELL_DOOMFIRE_STRIKE       = 31903,    //summons two creatures
    SPELL_DOOMFIRE_SPAWN        = 32074,
    SPELL_DOOMFIRE              = 31945,
    SPELL_SOUL_CHARGE_YELLOW    = 32045,
    SPELL_SOUL_CHARGE_GREEN     = 32051,
    SPELL_SOUL_CHARGE_RED       = 32052,
    SPELL_UNLEASH_SOUL_YELLOW   = 32054,
    SPELL_UNLEASH_SOUL_GREEN    = 32057,
    SPELL_UNLEASH_SOUL_RED      = 32053,
    SPELL_FEAR                  = 31970,
};

enum Summons
{
    CREATURE_DOOMFIRE           = 18095,
    CREATURE_DOOMFIRE_SPIRIT    = 18104,
    CREATURE_ANCIENT_WISP       = 17946,
    CREATURE_CHANNEL_TARGET     = 22418,
    DISPLAY_ID_TRIGGER          = 11686
};

enum Events
{
    EVENT_ENRAGE = 0
};

enum SpellGroups
{
    GROUP_FEAR  = 0
};

uint32 const availableChargeAurasAndSpells[3][2] = {
    {SPELL_SOUL_CHARGE_RED,     SPELL_UNLEASH_SOUL_RED      },
    {SPELL_SOUL_CHARGE_YELLOW,  SPELL_UNLEASH_SOUL_YELLOW   },
    {SPELL_SOUL_CHARGE_GREEN,   SPELL_UNLEASH_SOUL_GREEN    }
};

Position const nordrassilPosition = { 5503.713f, -3523.436f, 1608.781f, 0.0f };

float const DOOMFIRE_OFFSET = 15.0f;
uint8 const WISP_OFFSET = 40;
uint8 NEAR_POINT = 0;

struct npc_ancient_wisp : public ScriptedAI
{
    npc_ancient_wisp(Creature* creature) : ScriptedAI(creature)
    {
        _instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        ScheduleTimedEvent(1s, [&]
        {
            if (Creature* archimonde = _instance->GetCreature(DATA_ARCHIMONDE))
            {
                if (archimonde->HealthBelowPct(2) || !archimonde->IsAlive())
                {
                    DoCastSelf(SPELL_DENOUEMENT_WISP);
                }
                else
                {
                    DoCast(archimonde, SPELL_ANCIENT_SPARK);
                }
            }
        }, 1s);
    }

    void JustEngagedWith(Unit* /*who*/) override { }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

    }
private:
    InstanceScript* _instance;
};

struct npc_doomfire_spirit : public ScriptedAI
{
    npc_doomfire_spirit(Creature* creature) : ScriptedAI(creature){ }

    float const turnConstant = 0.785402f;
    float fAngle = urand(0, M_PI * 2);

    void Reset() override
    {
        scheduler.CancelAll();
        ScheduleTimedEvent(0s, [&] {
            float nextOrientation = Position::NormalizeOrientation(me->GetOrientation() + irand(-1, 1) * turnConstant);
            Position pos = GetFirstRandomAngleCollisionPosition(8.f, nextOrientation); // both orientation and distance verified with sniffs
            me->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), nextOrientation);
            }, 1600ms);

        fAngle = urand(0, M_PI * 2);
    }

    Position GetFirstRandomAngleCollisionPosition(float dist, float angle)
    {
        Position pos;
        for (uint32 i = 0; i < 10; ++i)
        {
            pos = me->WorldObject::GetFirstCollisionPosition(dist, angle);
            if (me->GetDistance(pos) > dist * 0.8f) // if at least 80% distance, good enough
                break;
            angle += (M_PI / 5); // else try slightly different angle
        }
        return pos;
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }
};

struct boss_archimonde : public BossAI
{
    boss_archimonde(Creature* creature) : BossAI(creature, DATA_ARCHIMONDE)
    {
        scheduler.SetValidator([&]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        _wispCount = 0;
        _isChanneling = false;
        _enraged = false;
        _availableAuras.clear();
        _availableSpells.clear();

        if (instance->GetBossState(DATA_AZGALOR) != DONE)
        {
            me->SetVisible(false);
            me->SetReactState(REACT_PASSIVE);
        }
        else
        {
            DoAction(ACTION_BECOME_ACTIVE_AND_CHANNEL);
        }

        ScheduleHealthCheckEvent(10, [&]{
            scheduler.CancelAll();
            me->SetReactState(REACT_PASSIVE);
            DoCastAOE(SPELL_PROTECTION_OF_ELUNE, true);
            Talk(SAY_ENRAGE);
            _enraged = true;
            me->GetMotionMaster()->Clear(false);
            me->GetMotionMaster()->MoveIdle();
            ScheduleTimedEvent(1s, [&]
            {
                if (_wispCount >= 30)
                {
                    me->KillSelf();
                }
                Position wispPosition = { me->GetPositionX() + float(rand() % WISP_OFFSET), me->GetPositionY() + float(rand() % WISP_OFFSET), me->GetPositionZ(), 0.0f };
                if (Creature* wisp = me->SummonCreature(CREATURE_ANCIENT_WISP, wispPosition))
                {
                    wisp->AI()->DoCast(me, SPELL_ANCIENT_SPARK);
                    ++_wispCount;
                }
            }, 1500ms);
            ScheduleTimedEvent(1500ms, [&]
            {
                DoCastVictim(SPELL_RED_SKY_EFFECT);
                DoCastVictim(SPELL_HAND_OF_DEATH);
            }, 3s);
        });
    }

    void DoAction(int32 action) override
    {
        switch (action)
        {
            case ACTION_BECOME_ACTIVE_AND_CHANNEL:
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetVisible(true);
                if (!_isChanneling)
                {
                    if (Creature* nordrassil = me->SummonCreature(CREATURE_CHANNEL_TARGET, nordrassilPosition, TEMPSUMMON_TIMED_DESPAWN, 1200000))
                    {
                        DoCast(nordrassil, SPELL_DRAIN_WORLD_TREE);
                        _isChanneling = true;
                        nordrassil->AI()->DoCast(me, SPELL_DRAIN_WORLD_TREE_2, true);
                    }
                }
                break;
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        me->InterruptNonMeleeSpells(false);
        Talk(SAY_AGGRO);
        ScheduleTimedEvent(25s, 35s, [&]
        {
            scheduler.DelayGroup(GROUP_FEAR, 5s);
            Talk(SAY_AIR_BURST);
            DoCastRandomTarget(SPELL_AIR_BURST);
        }, 25s, 40s);
        ScheduleTimedEvent(25s, 35s, [&]
        {
            DoCastDoomFire();
        }, 20s);
        ScheduleTimedEvent(25s, 35s, [&]
        {
            DoCastRandomTarget(SPELL_GRIP_OF_THE_LEGION);
        }, 5s, 25s);
        ScheduleTimedEvent(5s, [&]
        {
            if (me->GetExactDist2d(nordrassilPosition) < 75.0f)
            {
                if (!_enraged)
                {
                    _enraged = true;
                    Talk(SAY_ENRAGE);
                    ScheduleTimedEvent(1s, [&]
                    {
                        DoCastVictim(SPELL_RED_SKY_EFFECT);
                        DoCastVictim(SPELL_HAND_OF_DEATH);
                    }, 3s);
                }
            }
        }, 5s);
        ScheduleTimedEvent(5000ms, [&]
        {
            bool noPlayersInRange = true;
            if (Map* map = me->GetMap())
            {
                map->DoForAllPlayers([&noPlayersInRange, this](Player* player)
                {
                    if (me->IsWithinMeleeRange(player))
                    {
                        noPlayersInRange = false;
                        return false;
                    }
                    return true;
                });
            }
            if (noPlayersInRange)
            {
                DoCastRandomTarget(SPELL_FINGER_OF_DEATH);
            }
        }, 3500ms);
        ScheduleTimedEvent(10min, [&]
        {
            DoCastVictim(SPELL_RED_SKY_EFFECT);
            DoCastVictim(SPELL_HAND_OF_DEATH);
        }, 3s);
        scheduler.Schedule(40s, GROUP_FEAR, [this](TaskContext context)
        {
            DoCastAOE(SPELL_FEAR);
            context.Repeat(42s);
        });
        instance->SetData(DATA_SPAWN_WAVES, 1);
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void SetGUID(ObjectGuid guid, int32 type) override
    {
        if (type == GUID_GAIN_SOUL_CHARGE_PLAYER)
        {
            if (Player* player = ObjectAccessor::GetPlayer(*me, guid))
            {
                switch (player->getClass())
                {
                    case CLASS_PALADIN:
                    case CLASS_PRIEST:
                    case CLASS_WARLOCK:
                        player->CastSpell(me, SPELL_SOUL_CHARGE_RED, true);
                        break;
                    case CLASS_DEATH_KNIGHT:
                    case CLASS_MAGE:
                    case CLASS_ROGUE:
                    case CLASS_WARRIOR:
                        player->CastSpell(me, SPELL_SOUL_CHARGE_YELLOW, true);
                        break;
                    case CLASS_DRUID:
                    case CLASS_HUNTER:
                    case CLASS_SHAMAN:
                        player->CastSpell(me, SPELL_SOUL_CHARGE_GREEN, true);
                        break;
                    case CLASS_NONE:
                    default:
                        break;
                }

                scheduler.Schedule(2s, 10s, [this](TaskContext)
                {
                    UnleashSoulCharge();
                });
            }
        }
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        instance->SetData(DATA_RESET_NIGHT_ELF, 1);
        BossAI::EnterEvadeMode(why);
    }

    void JustSummoned(Creature* summoned) override
    {
        BossAI::JustSummoned(summoned);
        if (summoned->GetEntry() == CREATURE_ANCIENT_WISP)
        {
            summoned->AI()->AttackStart(me);
        }
        else if (summoned->GetEntry() == CREATURE_DOOMFIRE)
        {
            summoned->CastSpell(summoned, SPELL_DOOMFIRE_SPAWN);
            summoned->CastSpell(summoned, SPELL_DOOMFIRE, true, 0, 0, me->GetGUID());
        }
        else
        {
            summoned->SetFaction(me->GetFaction()); //remove?
            summoned->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            summoned->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }
    }

    void DoCastDoomFire()
    {
        // hack because spell doesn't work?
        Talk(SAY_DOOMFIRE);
        float angle = 2 * M_PI * rand() / RAND_MAX;
        float x = me->GetPositionX() + DOOMFIRE_OFFSET * cos(angle);
        float y = me->GetPositionY() + DOOMFIRE_OFFSET * sin(angle);
        Position spiritPosition = Position(x, y, me->GetPositionZ());
        Position doomfirePosition = Position(x, y, me->GetPositionZ());
        if (Creature* doomfireSpirit = me->SummonCreature(CREATURE_DOOMFIRE_SPIRIT, spiritPosition, TEMPSUMMON_TIMED_DESPAWN, 27000))
        {
            if (Creature* doomfire = me->SummonCreature(CREATURE_DOOMFIRE, doomfirePosition, TEMPSUMMON_TIMED_DESPAWN, 27000))
            {
                doomfireSpirit->SetWalk(false);
                doomfireSpirit->SetReactState(REACT_PASSIVE);
                doomfire->SetReactState(REACT_PASSIVE);
                doomfire->GetMotionMaster()->MoveFollow(doomfireSpirit, 0.0f, 0.0f);
            }
        }
    }

    void UnleashSoulCharge()
    {
        me->InterruptNonMeleeSpells(false);
        //add all auras to spells
        for (uint8 n = 0; n < 3; ++n)
        {
            if (me->HasAura(availableChargeAurasAndSpells[n][0]))
            {
                _availableAuras.push_back(availableChargeAurasAndSpells[n][0]);
                _availableSpells.push_back(availableChargeAurasAndSpells[n][1]);
            }
        }
        //only unleash when we found spells and auras
        if (!_availableAuras.empty() && !_availableSpells.empty())
        {
            //coin flip to swap front and back item
            if (urand(0, 1))
            {
                _availableAuras.insert(_availableAuras.begin(), _availableAuras.back());
                _availableAuras.pop_back();
                _availableSpells.insert(_availableSpells.begin(), _availableSpells.back());
                _availableSpells.pop_back();
            }
            //remove aura and cast spell
            me->RemoveAuraFromStack(_availableAuras.front());
            DoCastVictim(_availableSpells.front());
            //clear to clean vectors
            _availableAuras.clear();
            _availableSpells.clear();
        }
    }
private:
    uint8 _wispCount;
    bool _isChanneling;
    bool _enraged;
    std::vector<uint32> _availableAuras;
    std::vector<uint32> _availableSpells;
};
class spell_red_sky_effect : public SpellScript
{
    PrepareSpellScript(spell_red_sky_effect);

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        if (GetHitUnit())
            PreventHitDamage();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_red_sky_effect::HandleHit, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class spell_air_burst : public SpellScript
{
    PrepareSpellScript(spell_air_burst);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (Unit* victim = GetCaster()->GetVictim())
        {
            targets.remove_if(Acore::ObjectGUIDCheck(victim->GetGUID(), true));
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_air_burst::FilterTargets, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENEMY);
    }
};

void AddSC_boss_archimonde()
{
    RegisterSpellScript(spell_red_sky_effect);
    RegisterSpellScript(spell_air_burst);
    RegisterHyjalAI(boss_archimonde);
    RegisterHyjalAI(npc_ancient_wisp);
    RegisterHyjalAI(npc_doomfire_spirit);
}

