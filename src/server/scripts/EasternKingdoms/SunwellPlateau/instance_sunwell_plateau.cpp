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
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "sunwell_plateau.h"

DoorData const doorData[] =
{
    { GO_FIRE_BARRIER,     DATA_FELMYST_DOORS,  DOOR_TYPE_PASSAGE },
    { GO_MURUS_GATE_1,     DATA_MURU,     DOOR_TYPE_ROOM   },
    { GO_MURUS_GATE_2,     DATA_MURU,     DOOR_TYPE_PASSAGE },
    { GO_BOSS_COLLISION_1, DATA_KALECGOS, DOOR_TYPE_ROOM   },
    { GO_BOSS_COLLISION_2, DATA_KALECGOS, DOOR_TYPE_ROOM   },
    { GO_FORCE_FIELD,      DATA_KALECGOS, DOOR_TYPE_ROOM   },
    { 0,                   0,             DOOR_TYPE_ROOM   } // END
};

ObjectData const creatureData[] =
{
    { NPC_KALECGOS,               DATA_KALECGOS      },
    { NPC_BRUTALLUS,              DATA_BRUTALLUS     },
    { NPC_FELMYST,                DATA_FELMYST       },
    { NPC_MURU,                   DATA_MURU          },
    { NPC_LADY_SACROLASH,         DATA_SACROLASH     },
    { NPC_GRAND_WARLOCK_ALYTHESS, DATA_ALYTHESS      },
    { NPC_MADRIGOSA,              DATA_MADRIGOSA     },
    { NPC_SATHROVARR,             DATA_SATHROVARR    },
    { NPC_KILJAEDEN_CONTROLLER,   DATA_KJ_CONTROLLER },
    { NPC_ANVEENA,                DATA_ANVEENA       },
    { NPC_KALECGOS_KJ,            DATA_KALECGOS_KJ   },
    { 0,                          0                  }
};

ObjectData const gameObjectData[] =
{
    { GO_ICE_BARRIER,                   DATA_ICEBARRIER                     },
    { GO_ORB_OF_THE_BLUE_DRAGONFLIGHT1, DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_1 },
    { GO_ORB_OF_THE_BLUE_DRAGONFLIGHT2, DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_2 },
    { GO_ORB_OF_THE_BLUE_DRAGONFLIGHT3, DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_3 },
    { GO_ORB_OF_THE_BLUE_DRAGONFLIGHT4, DATA_ORB_OF_THE_BLUE_DRAGONFLIGHT_4 },
    { 0,                                0                                   }
};

ObjectData const summonData[] =
{
    { NPC_DEMONIC_VAPOR_TRAIL,    DATA_FELMYST       },
    { NPC_UNYIELDING_DEAD,        DATA_FELMYST       },
    { NPC_DARKNESS,               DATA_MURU          },
    { NPC_VOID_SENTINEL,          DATA_MURU          },
    { NPC_VOID_SPAWN,             DATA_MURU          },
    { NPC_FELFIRE_PORTAL,         DATA_KJ_CONTROLLER },
    { NPC_VOLATILE_FELFIRE_FIEND, DATA_KJ_CONTROLLER },
    { NPC_SHIELD_ORB,             DATA_KJ_CONTROLLER },
    { NPC_SINISTER_REFLECTION,    DATA_KJ_CONTROLLER },
    { 0,                          0                  }
};

class instance_sunwell_plateau : public InstanceMapScript
{
public:
    instance_sunwell_plateau() : InstanceMapScript("instance_sunwell_plateau", 580) { }

    struct instance_sunwell_plateau_InstanceMapScript : public InstanceScript
    {
        instance_sunwell_plateau_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, gameObjectData);
            LoadSummonData(summonData);
        }

        void Load(char const* data) override
        {
            InstanceScript::Load(data);

            scheduler.Schedule(3s, [this](TaskContext /*context*/)
            {
                if (IsBossDone(DATA_BRUTALLUS) && !IsBossDone(DATA_FELMYST))
                    if (Creature* madrigosa = GetCreature(DATA_MADRIGOSA))
                        madrigosa->CastSpell((Unit*)nullptr, SPELL_SUMMON_FELBLAZE, true);
            });
        }

        void OnPlayerEnter(Player* player) override
        {
            if (GameObject* gobj = GetGameObject(DATA_ICEBARRIER))
                gobj->SendUpdateToPlayer(player);
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_sunwell_plateau_InstanceMapScript(map);
    }
};

enum cataclysmBreath
{
    SPELL_CORROSIVE_POISON      = 46293,
    SPELL_FEVERED_FATIGUE       = 46294,
    SPELL_HEX                   = 46295,
    SPELL_NECROTIC_POISON       = 46296,
    SPELL_PIERCING_SHADOW       = 46297,
    SPELL_SHRINK                = 46298,
    SPELL_WAVERING_WILL         = 46299,
    SPELL_WITHERED_TOUCH        = 46300
};

class spell_cataclysm_breath : public SpellScript
{
    PrepareSpellScript(spell_cataclysm_breath);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CORROSIVE_POISON, SPELL_FEVERED_FATIGUE, SPELL_HEX, SPELL_NECROTIC_POISON, SPELL_PIERCING_SHADOW, SPELL_SHRINK, SPELL_WAVERING_WILL, SPELL_WITHERED_TOUCH });
    }

    void HandleAfterCast()
    {
        if (Unit* target = GetExplTargetUnit())
            for (uint8 i = 0; i < 4; ++i)
                GetCaster()->CastSpell(target, RAND(SPELL_CORROSIVE_POISON, SPELL_FEVERED_FATIGUE, SPELL_HEX, SPELL_NECROTIC_POISON, SPELL_PIERCING_SHADOW, SPELL_SHRINK, SPELL_WAVERING_WILL, SPELL_WITHERED_TOUCH), true);
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_cataclysm_breath::HandleAfterCast);
    }
};

enum SunbladeScout
{
    NPC_SUNBLADE_PROTECTOR               = 25507,
    SAY_AGGRO                            = 0, // Enemies spotted! Attack while I try to activate a Protector!
    SPELL_ACTIVATE_SUNBLADE_PROTECTOR    = 46475,
    SPELL_COSMETIC_STUN_IMMUNE_PERMANENT = 59123,
    SPELL_FELBLOOD_CHANNEL               = 46319,
    SPELL_SINISTER_STRIKE                = 46558,
};

struct npc_sunblade_scout : public ScriptedAI
{
    npc_sunblade_scout(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
        ScheduleOOC();
        me->SetCombatMovement(false);
        me->SetReactState(REACT_AGGRESSIVE);
        _protectorGUID.Clear();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.CancelAll();
        me->CallForHelp(30.0f);
        Talk(SAY_AGGRO);
        std::list<Creature*> protectors;
        GetCreatureListWithEntryInGrid(protectors, me, NPC_SUNBLADE_PROTECTOR, 100.0f); // range unknown
        // Skip already activated protectors
        protectors.remove_if([](Creature* trigger) {return !trigger->HasAura(SPELL_COSMETIC_STUN_IMMUNE_PERMANENT);});
        protectors.sort(Acore::ObjectDistanceOrderPred(me));
        if (protectors.empty())
        {
            ScheduleCombat();
            return;
        }
        Creature* closestProtector = protectors.front();
        me->GetMotionMaster()->MoveFollow(closestProtector, 0.0f, 0.0f);
        _protectorGUID = closestProtector->GetGUID();
        me->ClearTarget();
        me->SetReactState(REACT_PASSIVE);
        scheduler.Schedule(1s, [this](TaskContext context)
        {
            if (_protectorGUID)
                if (Creature* protector = ObjectAccessor::GetCreature(*me, _protectorGUID))
                {
                    if (me->IsWithinRange(protector, 25.0f))
                    {
                        me->SetFacingToObject(protector);
                        DoCastSelf(SPELL_ACTIVATE_SUNBLADE_PROTECTOR);
                        scheduler.Schedule(5s, [this](TaskContext /*context*/)
                        {
                            ScheduleCombat();
                        });
                        return;
                    }
                    context.Repeat(1s);
                    return;
                }
            ScheduleCombat();
        });
    }

    void ScheduleCombat()
    {
        me->SetReactState(REACT_AGGRESSIVE);
        me->SetCombatMovement(true);
        if (Unit* victim = me->GetVictim())
            me->GetMotionMaster()->MoveChase(victim);
        scheduler.Schedule(2s, 5s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SINISTER_STRIKE);
            context.Repeat(7s, 8s);
        });
    }

    void ScheduleOOC()
    {
        scheduler.Schedule(45s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_FELBLOOD_CHANNEL);
            context.Repeat();
        });
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!me->IsCombatMovementAllowed() || !UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
private:
    ObjectGuid _protectorGUID;
};

enum SunwellTeleportSpells
{
    SPELL_TELEPORT_TO_APEX_POINT = 46881,
    SPELL_TELEPORT_TO_WITCHS_SANCTUM = 46883,
    SPELL_TELEPORT_TO_SUNWELL_PLATEAU = 46884,
};
class spell_sunwell_teleport : public SpellScript
{
    PrepareSpellScript(spell_sunwell_teleport);
public:
    spell_sunwell_teleport(uint32 triggeredSpellId) : SpellScript(), _triggeredSpellId(triggeredSpellId) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ _triggeredSpellId });
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Player* target = GetHitPlayer())
            target->CastSpell(target, _triggeredSpellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_sunwell_teleport::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
private:
    uint32 _triggeredSpellId;
};

enum SunbladeArchMageSpells
{
    SPELL_ARCANE_EXPLOSION    = 46553,
    SPELL_BLINK               = 28401,
    SPELL_FROST_NOVA          = 46555
};

struct npc_sunblade_arch_mage : public ScriptedAI
{
    npc_sunblade_arch_mage(Creature* creature) : ScriptedAI(creature)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        scheduler.CancelAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.Schedule(6s, 12s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_ARCANE_EXPLOSION);
            context.Repeat(12s, 18s);
        });

        scheduler.Schedule(8s, 15s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true))
            {
                DoCast(target, SPELL_BLINK, true);
                DoCastAOE(SPELL_FROST_NOVA, true);
            }
            context.Repeat(20s, 25s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler scheduler;
};

void AddSC_instance_sunwell_plateau()
{
    new instance_sunwell_plateau();
    RegisterSpellScript(spell_cataclysm_breath);
    RegisterSunwellPlateauCreatureAI(npc_sunblade_arch_mage);
    RegisterSunwellPlateauCreatureAI(npc_sunblade_scout);
    RegisterSpellScriptWithArgs(spell_sunwell_teleport, "spell_teleport_to_apex_point", SPELL_TELEPORT_TO_APEX_POINT);
    RegisterSpellScriptWithArgs(spell_sunwell_teleport, "spell_teleport_to_witchs_sanctum", SPELL_TELEPORT_TO_WITCHS_SANCTUM);
    RegisterSpellScriptWithArgs(spell_sunwell_teleport, "spell_teleport_to_sunwell_plateau", SPELL_TELEPORT_TO_SUNWELL_PLATEAU);
}
