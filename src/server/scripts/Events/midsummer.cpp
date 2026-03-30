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

#include "AreaDefines.h"
#include "CreatureScript.h"
#include "GameEventMgr.h"
#include "GameObjectScript.h"
#include "GameTime.h"
#include "Player.h"
#include "PlayerScript.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include <random>

enum eBonfire
{
    GO_MIDSUMMER_BONFIRE_SPELL_FOCUS            = 181371,
    GO_MIDSUMMER_BONFIRE_CAMPFIRE_SPELL_FOCUS   = 181377,
    GO_AHUNE_BONFIRE                            = 188073,

    SPELL_MIDSUMMER_BONFIRE_BUNNIES_2   = 29114,

    SPELL_STAMP_OUT_BONFIRE             = 45437,
    SPELL_STAMP_OUT_BONFIRE_ART_KIT     = 46903,

    SPELL_TOSS_FUEL_ON_BONFIRE          = 28806,
    SPELL_LIGHT_BONFIRE_ART_KIT         = 46904,

    SPELL_BONFIRES_BLESSING             = 45444,

    BONFIRE_TYPE_NONE     = 0,
    BONFIRE_TYPE_ALLIANCE = 1,
    BONFIRE_TYPE_HORDE    = 2,
    BONFIRE_TYPE_CITY     = 3,
    BONFIRE_TYPE_AHUNE    = 4,

    COUNT_GO_BONFIRE_ALLIANCE   = 40,
    COUNT_GO_BONFIRE_HORDE      = 38,
    COUNT_GO_BONFIRE_CITY       = 9,
};

static bool BonfireStampedOutState[COUNT_GO_BONFIRE_ALLIANCE + COUNT_GO_BONFIRE_HORDE];

// <mapId, zoneId, teamId>, <state>
const std::map<std::tuple<uint32, uint32, TeamId>, bool*> BonfireStateStore = {
    { { MAP_EASTERN_KINGDOMS, AREA_DUN_MOROGH,          TEAM_ALLIANCE }, &BonfireStampedOutState[0] },
    { { MAP_EASTERN_KINGDOMS, AREA_BADLANDS,            TEAM_HORDE    }, &BonfireStampedOutState[1] },
    { { MAP_EASTERN_KINGDOMS, AREA_BLASTED_LANDS,       TEAM_ALLIANCE }, &BonfireStampedOutState[2] },
    { { MAP_EASTERN_KINGDOMS, AREA_SWAMP_OF_SORROWS,    TEAM_HORDE    }, &BonfireStampedOutState[3] },
    { { MAP_EASTERN_KINGDOMS, AREA_DUSKWOOD,            TEAM_ALLIANCE }, &BonfireStampedOutState[4] },
    { { MAP_EASTERN_KINGDOMS, AREA_WETLANDS,            TEAM_ALLIANCE }, &BonfireStampedOutState[5] },
    { { MAP_EASTERN_KINGDOMS, AREA_ELWYNN_FOREST,       TEAM_ALLIANCE }, &BonfireStampedOutState[6] },
    { { MAP_EASTERN_KINGDOMS, AREA_WESTERN_PLAGUELANDS, TEAM_ALLIANCE }, &BonfireStampedOutState[7] },
    { { MAP_EASTERN_KINGDOMS, AREA_STRANGLETHORN_VALE,  TEAM_ALLIANCE }, &BonfireStampedOutState[8] },
    { { MAP_EASTERN_KINGDOMS, AREA_STRANGLETHORN_VALE,  TEAM_HORDE    }, &BonfireStampedOutState[9] },
    { { MAP_EASTERN_KINGDOMS, AREA_LOCH_MODAN,          TEAM_ALLIANCE }, &BonfireStampedOutState[10] },
    { { MAP_EASTERN_KINGDOMS, AREA_WESTFALL,            TEAM_ALLIANCE }, &BonfireStampedOutState[11] },
    { { MAP_EASTERN_KINGDOMS, AREA_REDRIDGE_MOUNTAINS,  TEAM_ALLIANCE }, &BonfireStampedOutState[12] },
    { { MAP_EASTERN_KINGDOMS, AREA_ARATHI_HIGHLANDS,    TEAM_ALLIANCE }, &BonfireStampedOutState[13] },
    { { MAP_EASTERN_KINGDOMS, AREA_ARATHI_HIGHLANDS,    TEAM_HORDE    }, &BonfireStampedOutState[14] },
    { { MAP_EASTERN_KINGDOMS, AREA_BURNING_STEPPES,     TEAM_ALLIANCE }, &BonfireStampedOutState[15] },
    { { MAP_EASTERN_KINGDOMS, AREA_BURNING_STEPPES,     TEAM_HORDE    }, &BonfireStampedOutState[16] },
    { { MAP_EASTERN_KINGDOMS, AREA_THE_HINTERLANDS,     TEAM_ALLIANCE }, &BonfireStampedOutState[17] },
    { { MAP_EASTERN_KINGDOMS, AREA_THE_HINTERLANDS,     TEAM_HORDE    }, &BonfireStampedOutState[18] },
    { { MAP_EASTERN_KINGDOMS, AREA_TIRISFAL_GLADES,     TEAM_HORDE    }, &BonfireStampedOutState[19] },
    { { MAP_EASTERN_KINGDOMS, AREA_SILVERPINE_FOREST,   TEAM_HORDE    }, &BonfireStampedOutState[20] },
    { { MAP_EASTERN_KINGDOMS, AREA_HILLSBRAD_FOOTHILLS, TEAM_ALLIANCE }, &BonfireStampedOutState[21] },
    { { MAP_EASTERN_KINGDOMS, AREA_HILLSBRAD_FOOTHILLS, TEAM_HORDE    }, &BonfireStampedOutState[22] },

    { { MAP_KALIMDOR, AREA_DUROTAR,              TEAM_HORDE    }, &BonfireStampedOutState[23] },
    { { MAP_KALIMDOR, AREA_DUSTWALLOW_MARSH,     TEAM_ALLIANCE }, &BonfireStampedOutState[24] },
    { { MAP_KALIMDOR, AREA_DUSTWALLOW_MARSH,     TEAM_HORDE    }, &BonfireStampedOutState[25] },
    { { MAP_KALIMDOR, AREA_THE_BARRENS,          TEAM_HORDE    }, &BonfireStampedOutState[26] },
    { { MAP_KALIMDOR, AREA_TELDRASSIL,           TEAM_ALLIANCE }, &BonfireStampedOutState[27] },
    { { MAP_KALIMDOR, AREA_DARKSHORE,            TEAM_ALLIANCE }, &BonfireStampedOutState[28] },
    { { MAP_KALIMDOR, AREA_MULGORE,              TEAM_HORDE    }, &BonfireStampedOutState[29] },
    { { MAP_KALIMDOR, AREA_ASHENVALE,            TEAM_ALLIANCE }, &BonfireStampedOutState[30] },
    { { MAP_KALIMDOR, AREA_ASHENVALE,            TEAM_HORDE    }, &BonfireStampedOutState[31] },
    { { MAP_KALIMDOR, AREA_FERALAS,              TEAM_ALLIANCE }, &BonfireStampedOutState[32] },
    { { MAP_KALIMDOR, AREA_FERALAS,              TEAM_HORDE    }, &BonfireStampedOutState[33] },
    { { MAP_KALIMDOR, AREA_THOUSAND_NEEDLES,     TEAM_HORDE    }, &BonfireStampedOutState[34] },
    { { MAP_KALIMDOR, AREA_DESOLACE,             TEAM_ALLIANCE }, &BonfireStampedOutState[35] },
    { { MAP_KALIMDOR, AREA_DESOLACE,             TEAM_HORDE    }, &BonfireStampedOutState[36] },
    { { MAP_KALIMDOR, AREA_STONETALON_MOUNTAINS, TEAM_HORDE    }, &BonfireStampedOutState[37] },
    { { MAP_KALIMDOR, AREA_TANARIS,              TEAM_ALLIANCE }, &BonfireStampedOutState[38] },
    { { MAP_KALIMDOR, AREA_TANARIS,              TEAM_HORDE    }, &BonfireStampedOutState[39] },
    { { MAP_KALIMDOR, AREA_WINTERSPRING,         TEAM_ALLIANCE }, &BonfireStampedOutState[40] },
    { { MAP_KALIMDOR, AREA_WINTERSPRING,         TEAM_HORDE    }, &BonfireStampedOutState[41] },
    { { MAP_KALIMDOR, AREA_SILITHUS,             TEAM_ALLIANCE }, &BonfireStampedOutState[42] },
    { { MAP_KALIMDOR, AREA_SILITHUS,             TEAM_HORDE    }, &BonfireStampedOutState[43] },

    { { MAP_OUTLAND, AREA_EVERSONG_WOODS,        TEAM_HORDE    }, &BonfireStampedOutState[44] },
    { { MAP_OUTLAND, AREA_GHOSTLANDS,            TEAM_HORDE    }, &BonfireStampedOutState[45] },
    { { MAP_OUTLAND, AREA_HELLFIRE_PENINSULA,    TEAM_ALLIANCE }, &BonfireStampedOutState[46] },
    { { MAP_OUTLAND, AREA_HELLFIRE_PENINSULA,    TEAM_HORDE    }, &BonfireStampedOutState[47] },
    { { MAP_OUTLAND, AREA_NAGRAND,               TEAM_ALLIANCE }, &BonfireStampedOutState[48] },
    { { MAP_OUTLAND, AREA_NAGRAND,               TEAM_HORDE    }, &BonfireStampedOutState[49] },
    { { MAP_OUTLAND, AREA_TEROKKAR_FOREST,       TEAM_ALLIANCE }, &BonfireStampedOutState[50] },
    { { MAP_OUTLAND, AREA_TEROKKAR_FOREST,       TEAM_HORDE    }, &BonfireStampedOutState[51] },
    { { MAP_OUTLAND, AREA_SHADOWMOON_VALLEY,     TEAM_ALLIANCE }, &BonfireStampedOutState[52] },
    { { MAP_OUTLAND, AREA_SHADOWMOON_VALLEY,     TEAM_HORDE    }, &BonfireStampedOutState[53] },
    { { MAP_OUTLAND, AREA_ZANGARMARSH,           TEAM_ALLIANCE }, &BonfireStampedOutState[54] },
    { { MAP_OUTLAND, AREA_ZANGARMARSH,           TEAM_HORDE    }, &BonfireStampedOutState[55] },
    { { MAP_OUTLAND, AREA_BLADES_EDGE_MOUNTAINS, TEAM_ALLIANCE }, &BonfireStampedOutState[56] },
    { { MAP_OUTLAND, AREA_BLADES_EDGE_MOUNTAINS, TEAM_HORDE    }, &BonfireStampedOutState[57] },
    { { MAP_OUTLAND, AREA_NETHERSTORM,           TEAM_ALLIANCE }, &BonfireStampedOutState[58] },
    { { MAP_OUTLAND, AREA_NETHERSTORM,           TEAM_HORDE    }, &BonfireStampedOutState[59] },
    { { MAP_OUTLAND, AREA_AZUREMYST_ISLE,        TEAM_ALLIANCE }, &BonfireStampedOutState[60] },
    { { MAP_OUTLAND, AREA_BLOODMYST_ISLE,        TEAM_ALLIANCE }, &BonfireStampedOutState[61] },

    { { MAP_NORTHREND, AREA_DRAGONBLIGHT,       TEAM_ALLIANCE }, &BonfireStampedOutState[62] },
    { { MAP_NORTHREND, AREA_DRAGONBLIGHT,       TEAM_HORDE    }, &BonfireStampedOutState[63] },
    { { MAP_NORTHREND, AREA_ZUL_DRAK,           TEAM_ALLIANCE }, &BonfireStampedOutState[64] },
    { { MAP_NORTHREND, AREA_ZUL_DRAK,           TEAM_HORDE    }, &BonfireStampedOutState[65] },
    { { MAP_NORTHREND, AREA_THE_STORM_PEAKS,    TEAM_ALLIANCE }, &BonfireStampedOutState[66] },
    { { MAP_NORTHREND, AREA_THE_STORM_PEAKS,    TEAM_HORDE    }, &BonfireStampedOutState[67] },
    { { MAP_NORTHREND, AREA_GRIZZLY_HILLS,      TEAM_ALLIANCE }, &BonfireStampedOutState[68] },
    { { MAP_NORTHREND, AREA_GRIZZLY_HILLS,      TEAM_HORDE    }, &BonfireStampedOutState[69] },
    { { MAP_NORTHREND, AREA_HOWLING_FJORD,      TEAM_ALLIANCE }, &BonfireStampedOutState[70] },
    { { MAP_NORTHREND, AREA_HOWLING_FJORD,      TEAM_HORDE    }, &BonfireStampedOutState[71] },
    { { MAP_NORTHREND, AREA_CRYSTALSONG_FOREST, TEAM_ALLIANCE }, &BonfireStampedOutState[72] },
    { { MAP_NORTHREND, AREA_CRYSTALSONG_FOREST, TEAM_HORDE    }, &BonfireStampedOutState[73] },
    { { MAP_NORTHREND, AREA_BOREAN_TUNDRA,      TEAM_ALLIANCE }, &BonfireStampedOutState[74] },
    { { MAP_NORTHREND, AREA_BOREAN_TUNDRA,      TEAM_HORDE    }, &BonfireStampedOutState[75] },
    { { MAP_NORTHREND, AREA_SHOLAZAR_BASIN,     TEAM_ALLIANCE }, &BonfireStampedOutState[76] },
    { { MAP_NORTHREND, AREA_SHOLAZAR_BASIN,     TEAM_HORDE    }, &BonfireStampedOutState[77] },
};

uint32 const GoBonfireAlliance[COUNT_GO_BONFIRE_ALLIANCE] = { 187564, 187914, 187916, 187917, 187919, 187920, 187921, 187922, 187923, 187924, 187925, 187926, 187927, 187928, 187929, 187930, 187931, 187932, 187933, 187934, 187935, 187936, 187937, 187938, 187939, 187940, 187941, 187942, 187943, 187944, 187945, 187946, 194032, 194035, 194036, 194038, 194040, 194044, 194045, 194049 };
uint32 const GoBonfireHorde[COUNT_GO_BONFIRE_HORDE] = { 187559, 187947, 187948, 187949, 187950, 187951, 187952, 187953, 187954, 187955, 187956, 187957, 187958, 187959, 187960, 187961, 187962, 187963, 187964, 187965, 187966, 187967, 187968, 187969, 187970, 187971, 187972, 187973, 187974, 187975, 194033, 194034, 194037, 194039, 194042, 194043, 194046, 194048 };
uint32 const GoBonfireCity[COUNT_GO_BONFIRE_CITY] = { 181332, 181333, 181334, 181335, 181336, 181337, 188128, 188129, 188352 };

class MidsummerPlayerScript : public PlayerScript
{
public:
    MidsummerPlayerScript() : PlayerScript("MidsummerPlayerScript", {PLAYERHOOK_ON_UPDATE_ZONE})
    {
    }

    void OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 /*newArea*/) override
    {
        if (!IsHolidayActive(HOLIDAY_FIRE_FESTIVAL))
            return;

        auto itr = BonfireStateStore.find(std::make_tuple(player->GetMapId(), newZone, player->GetTeamId()));
        if ((itr != BonfireStateStore.end()) && (itr->second))
        {
            if (!(*(itr->second)))
            {
                if (!player->HasAura(SPELL_BONFIRES_BLESSING))
                    player->CastSpell(player, SPELL_BONFIRES_BLESSING, true);

                return;
            }
        }

        player->RemoveAurasDueToSpell(SPELL_BONFIRES_BLESSING);
    }
};

struct npc_midsummer_bonfire : public ScriptedAI
{
    npc_midsummer_bonfire(Creature* creature) : ScriptedAI(creature)
    {
        //  Midsummer Bonfire Spawn Trap also spawns this NPC (currently unwanted)
        if (me->ToTempSummon())
            me->DespawnOrUnsummon();

        _isStampedOut  = nullptr;
        _teamId     = TEAM_NEUTRAL;
        _type       = BONFIRE_TYPE_NONE;
        _spellFocus = nullptr;

        if (!IsHolidayActive(HOLIDAY_FIRE_FESTIVAL))
            return;

        scheduler.Schedule(420ms, [this](TaskContext context)
            {
                if (!InitBonfire())
                    context.Repeat();
            });
    }

    void Ignite()
    {
        if (_isStampedOut)
            *_isStampedOut = false;

        if (!_spellFocus)
        {
            DoCastSelf(SPELL_MIDSUMMER_BONFIRE_BUNNIES_2, true);

            if ((_spellFocus = me->FindNearestGameObject(GO_MIDSUMMER_BONFIRE_CAMPFIRE_SPELL_FOCUS, 10.0f)))
                me->AddGameObject(_spellFocus);
        }

        switch (_type)
        {
            case BONFIRE_TYPE_ALLIANCE:
            case BONFIRE_TYPE_HORDE:
                DoCastSelf(SPELL_LIGHT_BONFIRE_ART_KIT, true);
                UpdateBonfireBlessingBuffs();
                break;
            case BONFIRE_TYPE_AHUNE:
                if (_bonfire)
                    _bonfire->SetGoState(GO_STATE_ACTIVE);
                break;
            default:
                break;
        }
    }

    void StampOut()
    {
        switch (_type)
        {
            case BONFIRE_TYPE_ALLIANCE:
            case BONFIRE_TYPE_HORDE:
                if (_isStampedOut)
                    *_isStampedOut = true;

                if (_spellFocus)
                {
                    _spellFocus->DespawnOrUnsummon();
                    _spellFocus->AddObjectToRemoveList();
                    _spellFocus = nullptr;
                }

                DoCastSelf(SPELL_STAMP_OUT_BONFIRE_ART_KIT, true);
                UpdateBonfireBlessingBuffs();
                break;
            default:
                break;
        }
    }

    void UpdateBonfireBlessingBuffs()
    {
        if ((_type != BONFIRE_TYPE_ALLIANCE) && (_type != BONFIRE_TYPE_HORDE))
            return;

        me->GetMap()->DoForAllPlayers([&](Player* p)
            {
                if ((p->GetZoneId() == me->GetZoneId()) && (p->GetTeamId() == _teamId))
                {
                    if (_isStampedOut)
                    {
                        if (*_isStampedOut)
                            p->RemoveAurasDueToSpell(SPELL_BONFIRES_BLESSING);
                        else
                        {
                            if (!p->HasAura(SPELL_BONFIRES_BLESSING))
                                p->CastSpell(p, SPELL_BONFIRES_BLESSING, true);
                        }
                    }
                }
            });
    }

    bool InitBonfire()
    {
        _type = BONFIRE_TYPE_NONE;
        _teamId = TEAM_NEUTRAL;

        for (uint32 i = 0; (i < COUNT_GO_BONFIRE_ALLIANCE) && (_type == BONFIRE_TYPE_NONE); i++)
        {
            if ((_bonfire = me->FindNearestGameObject(GoBonfireAlliance[i], 10.0f)))
            {
                _type = BONFIRE_TYPE_ALLIANCE;
                _teamId = TEAM_ALLIANCE;
            }
        }

        for (uint32 i = 0; (i < COUNT_GO_BONFIRE_HORDE) && (_type == BONFIRE_TYPE_NONE); i++)
        {
            if ((_bonfire = me->FindNearestGameObject(GoBonfireHorde[i], 10.0f)))
            {
                _type = BONFIRE_TYPE_HORDE;
                _teamId = TEAM_HORDE;
            }
        }

        for (uint32 i = 0; (i < COUNT_GO_BONFIRE_CITY) && (_type == BONFIRE_TYPE_NONE); i++)
        {
            if ((_bonfire = me->FindNearestGameObject(GoBonfireCity[i], 10.0f)))
            {
                _type = BONFIRE_TYPE_CITY;
                Ignite();
                return true;
            }
        }

        if ((_type == BONFIRE_TYPE_NONE) && (_bonfire = me->FindNearestGameObject(GO_AHUNE_BONFIRE, 10.0f)))
        {
            _type = BONFIRE_TYPE_AHUNE;
            return true;
        }

        if (_type == BONFIRE_TYPE_NONE)
            return false;

        auto itr = BonfireStateStore.find(std::make_tuple(me->GetMapId(), me->GetZoneId(), _teamId));
        if ((itr != BonfireStateStore.end()) && (itr->second))
            _isStampedOut = itr->second;
        else
            LOG_ERROR("scripts.midsummer", "NPC {} (GUID{}) in map {}, zone {} with teamId {} can't locate its entry within BonfireStateStore", me->GetGUID().GetEntry(), me->GetSpawnId(), me->GetMapId(), me->GetZoneId(), _teamId);

        Ignite();

        return true;
    }

    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
    {
        if (!caster->IsPlayer())
            return;

        switch (spellInfo->Id)
        {
            case SPELL_TOSS_FUEL_ON_BONFIRE:
            {
                Ignite();
                break;
            }
            case SPELL_STAMP_OUT_BONFIRE:
            {
                StampOut();

                // desecrating other faction's bonfire flags player for PVP
                caster->SetPvP(true);
                break;
            }
            default:
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

private:
    bool* _isStampedOut;
    TeamId _teamId;
    uint8 _type;
    GameObject* _spellFocus;
    GameObject* _bonfire;
};

struct npc_midsummer_bonfire_despawner : public ScriptedAI
{
    npc_midsummer_bonfire_despawner(Creature* creature) : ScriptedAI(creature)
    {
        std::list<GameObject*> gobjList;
        me->GetGameObjectListWithEntryInGrid(gobjList, GO_MIDSUMMER_BONFIRE_SPELL_FOCUS, 10.0f);
        for (std::list<GameObject*>::const_iterator itr = gobjList.begin(); itr != gobjList.end(); ++itr)
        {
            // spawnID is 0 for temp spawns
            if (0 == (*itr)->GetSpawnId())
            {
                (*itr)->DespawnOrUnsummon();
                (*itr)->AddObjectToRemoveList();
            }
        }

        me->DespawnOrUnsummon();
    }
};

enum torchToss
{
    SPELL_TORCH_TOSSING_TRAINING_SUCCESS_A  = 45719,
    SPELL_TORCH_TOSSING_TRAINING_SUCCESS_H  = 46651,
    SPELL_TORCH_TOSSING_TRAINING            = 45716,
    SPELL_TORCH_TOSSING_PRACTICE            = 46630,
    SPELL_REMOVE_TORCHES                    = 46074,
};

///////////////////////////////
// SPELLS
///////////////////////////////

class spell_fire_festival_fortitude : public SpellScript
{
    PrepareSpellScript(spell_fire_festival_fortitude)

    void SelectTargets(std::list<WorldObject*>& targets)
    {
        targets.clear();

        GetCaster()->GetMap()->DoForAllPlayers([&](Player* p)
            {
                if (p->GetZoneId() == GetCaster()->GetZoneId())
                    targets.push_back(p);
            });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_fire_festival_fortitude::SelectTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
    }
};

class spell_bonfires_blessing : public AuraScript
{
    PrepareAuraScript(spell_bonfires_blessing)

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BONFIRES_BLESSING });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (!IsHolidayActive(HOLIDAY_FIRE_FESTIVAL))
        {
            if (Unit* target = GetTarget())
                target->RemoveAurasDueToSpell(SPELL_BONFIRES_BLESSING);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_bonfires_blessing::OnApply, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

enum CrabDisguise
{
    SPELL_CRAB_DISGUISE = 46337,
    SPELL_APPLY_DIGUISE = 34804,
    SPELL_FADE_DIGUISE = 47693,
};

class spell_gen_crab_disguise : public AuraScript
{
    PrepareAuraScript(spell_gen_crab_disguise);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_APPLY_DIGUISE, SPELL_FADE_DIGUISE });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
        {
            caster->CastSpell(caster, SPELL_APPLY_DIGUISE, true);
            caster->SetFaction(FACTION_BLACKFATHOM);
        }
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
        {
            caster->CastSpell(caster, SPELL_FADE_DIGUISE, true);
            caster->RestoreFaction();
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_gen_crab_disguise::OnApply, EFFECT_0, SPELL_AURA_FORCE_REACTION, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_gen_crab_disguise::OnRemove, EFFECT_0, SPELL_AURA_FORCE_REACTION, AURA_EFFECT_HANDLE_REAL);
    }
};

enum RibbonPole
{
    GO_RIBBON_POLE                      = 181605,

    SPELL_RIBBON_POLE_CHANNEL_VISUAL    = 29172,
    SPELL_RIBBON_POLE_CHANNEL_VISUAL_2  = 29531,
    SPELL_TEST_RIBBON_POLE_CHANNEL_BLUE = 29705,
    SPELL_TEST_RIBBON_POLE_CHANNEL_RED  = 29726,
    SPELL_TEST_RIBBON_POLE_CHANNEL_PINK = 29727,
    // player spinning/rorating around himself
    SPELL_RIBBON_POLE_PERIODIC_VISUAL   = 45406,
    // spew lava trails
    SPELL_RIBBON_POLE_FIRE_SPIRAL_VISUAL= 45421,
    // blue fire ring, duration 5s
    SPELL_FLAME_RING                    = 46842,
    // red fire ring, duration 5s
    SPELL_FLAME_PATCH                   = 46836,
    // single firework explosion
    SPELL_RIBBON_POLE_FIREWORK          = 46847,
    SPELL_RIBBON_POLE_GROUND_FLOWER     = 46969,
    SPELL_RIBBON_POLE_XP                = 29175,

    NPC_RIBBON_POLE_DEBUG_TARGET        = 17066,
    NPC_GROUND_FLOWER                   = 25518,
    NPC_BIG_DANCING_FLAMES              = 26267,
    NPC_RIBBON_POLE_FIRE_SPIRAL_BUNNY   = 25303,

    // dancing players count
    THRESHOLD_FLAME_CIRCLE              = 1,
    THRESHOLD_FIREWORK                  = 2,
    THRESHOLD_FIREWORK_3                = 3,
    THRESHOLD_FIREWORK_5                = 5,
    THRESHOLD_GROUND_FLOWERS            = 3,
    THRESHOLD_SPEW_LAVA                 = 6,
    THRESHOLD_DANCING_FLAMES            = 7,

    MAX_COUNT_GROUND_FLOWERS            = 3,
    MAX_COUNT_SPEW_LAVA_TARGETS         = 2,
    MAX_COUNT_DANCING_FLAMES            = 4,
};

struct npc_midsummer_ribbon_pole_target : public ScriptedAI
{
    npc_midsummer_ribbon_pole_target(Creature* creature) : ScriptedAI(creature)
    {
        // ribbonPole trap also spawns this NPC (currently unwanted)
        if (me->ToTempSummon())
            me->DespawnOrUnsummon();

        _ribbonPole = nullptr;
        _bunny = nullptr;
        _dancerList.clear();

        LocateRibbonPole();
        SpawnFireSpiralBunny();

        scheduler.Schedule(1s, [this](TaskContext context)
            {
                DoCleanupChecks();
                context.Repeat();
            })
            .Schedule(5s, [this](TaskContext context)
            {
                DoFlameCircleChecks();
                context.Repeat();
            })
            .Schedule(15s, [this](TaskContext context)
            {
                DoFireworkChecks();
                context.Repeat();
            })
            .Schedule(10s, [this](TaskContext context)
            {
                DoGroundFlowerChecks();
                context.Repeat();
            })
            .Schedule(10s, [this](TaskContext context)
            {
                DoSpewLavaChecks();
                context.Repeat();
            })
            .Schedule(15s, [this](TaskContext context)
            {
                DoDancingFLameChecks();
                context.Repeat();
            });
    }

    void SpellHit(Unit* caster, SpellInfo const* spell) override
    {
        Player* dancer = caster->ToPlayer();
        if (!dancer)
            return;

        switch (spell->Id)
        {
            case SPELL_TEST_RIBBON_POLE_CHANNEL_BLUE:
            case SPELL_TEST_RIBBON_POLE_CHANNEL_RED:
            case SPELL_TEST_RIBBON_POLE_CHANNEL_PINK:
                break;
            default:
                return;
        }

        // prevent duplicates
        if (std::find(_dancerList.begin(), _dancerList.end(), dancer->GetGUID()) != _dancerList.end())
            return;

        _dancerList.push_back(dancer->GetGUID());
    }

    void LocateRibbonPole()
    {
        scheduler.Schedule(420ms, [this](TaskContext context)
            {
                _ribbonPole = me->FindNearestGameObject(GO_RIBBON_POLE, 10.0f);

                if (!_ribbonPole)
                    context.Repeat(420ms);
            });
    }

    void SpawnFireSpiralBunny()
    {
        _bunny = me->FindNearestCreature(NPC_RIBBON_POLE_FIRE_SPIRAL_BUNNY, 10.0f);

        if (!_bunny)
            _bunny = DoSpawnCreature(NPC_RIBBON_POLE_FIRE_SPIRAL_BUNNY, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN, 0);
    }

    void DoCleanupChecks()
    {
        if (_dancerList.empty())
            return;

        // remove non-dancing players from list
        std::erase_if(_dancerList, [this](ObjectGuid dancerGUID)
        {
            Player* dancer = ObjectAccessor::GetPlayer(*me, dancerGUID);
            return !dancer || !dancer->HasAura(SPELL_RIBBON_POLE_PERIODIC_VISUAL);
        });
    }

    void DoFlameCircleChecks()
    {
        if (!_ribbonPole)
            return;
        if (_dancerList.size() >= THRESHOLD_FLAME_CIRCLE)
        {
            // random blue / red circle
            if (urand(0, 1))
                _ribbonPole->CastSpell(me, SPELL_FLAME_RING);
            else
                _ribbonPole->CastSpell(me, SPELL_FLAME_PATCH);
        }
    }

    void DoFireworkChecks()
    {
        if (!_bunny)
            return;

        if (_dancerList.size() >= THRESHOLD_FIREWORK)
        {
            _bunny->CastSpell(nullptr, SPELL_RIBBON_POLE_FIREWORK);
        }
        if (_dancerList.size() >= THRESHOLD_FIREWORK_3)
        {
            scheduler.Schedule(500ms, [this](TaskContext /*context*/)
            {
                _bunny->CastSpell(nullptr, SPELL_RIBBON_POLE_FIREWORK);
            })
            .Schedule(1s, [this](TaskContext /*context*/)
            {
                _bunny->CastSpell(nullptr, SPELL_RIBBON_POLE_FIREWORK);
            });
        }
        if (_dancerList.size() >= THRESHOLD_FIREWORK_5)
        {
            scheduler.Schedule(1500ms, [this](TaskContext /*context*/)
            {
                _bunny->CastSpell(nullptr, SPELL_RIBBON_POLE_FIREWORK);
            })
            .Schedule(2s, [this](TaskContext /*context*/)
            {
                _bunny->CastSpell(nullptr, SPELL_RIBBON_POLE_FIREWORK);
            });
        }
    }

    void DoGroundFlowerChecks()
    {
        if (!_bunny)
            return;

        if (_dancerList.size() >= THRESHOLD_GROUND_FLOWERS)
        {
            std::list<Creature*> crList;
            me->GetCreaturesWithEntryInRange(crList, 20.0f, NPC_GROUND_FLOWER);

            if (crList.size() < MAX_COUNT_GROUND_FLOWERS)
                _bunny->CastSpell(nullptr, SPELL_RIBBON_POLE_GROUND_FLOWER);
        }
    }

    void DoSpewLavaChecks()
    {
        if (!_bunny)
            return;

        if (_dancerList.size() >= THRESHOLD_SPEW_LAVA)
        {
            if (!_dancerList.empty())
            {
                Acore::Containers::RandomShuffle(_dancerList);

                for (uint8 i = 0; (i < MAX_COUNT_SPEW_LAVA_TARGETS) && (i < _dancerList.size()); i++)
                {
                    if (Player* dancerTarget = ObjectAccessor::GetPlayer(*me, _dancerList[i]))
                    {
                        Creature* fireSpiralBunny = dancerTarget->SummonCreature(NPC_RIBBON_POLE_FIRE_SPIRAL_BUNNY, dancerTarget->GetPositionX(), dancerTarget->GetPositionY(), dancerTarget->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 10000);
                        if (fireSpiralBunny)
                            fireSpiralBunny->CastSpell(_bunny, SPELL_RIBBON_POLE_FIRE_SPIRAL_VISUAL, true);
                    }
                }
            }
        }
    }

    void DoDancingFLameChecks()
    {
        if (_dancerList.size() >= THRESHOLD_DANCING_FLAMES)
        {
            std::list<Creature*> crList;
            me->GetCreaturesWithEntryInRange(crList, 20.0f, NPC_BIG_DANCING_FLAMES);

            if (crList.size() < MAX_COUNT_DANCING_FLAMES)
            {
                float spawnDist = 12.0f;
                float angle = rand_norm() * 2 * M_PI;
                DoSpawnCreature(NPC_BIG_DANCING_FLAMES, spawnDist * cos(angle), spawnDist * std::sin(angle), 0, angle + M_PI, TEMPSUMMON_TIMED_DESPAWN, 60000);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

private:
    GuidVector _dancerList;
    GameObject* _ribbonPole;
    Creature* _bunny;
};

class spell_midsummer_ribbon_pole_firework : public SpellScript
{
    PrepareSpellScript(spell_midsummer_ribbon_pole_firework)

    void ModDestHeight(SpellDestination& dest)
    {
        Position const offset = { 0.0f, 0.0f, 20.0f , 0.0f };
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_midsummer_ribbon_pole_firework::ModDestHeight, EFFECT_0, TARGET_DEST_CASTER_RANDOM);
    }
};

class spell_midsummer_ribbon_pole : public AuraScript
{
    PrepareAuraScript(spell_midsummer_ribbon_pole)

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_RIBBON_POLE_XP,
                SPELL_TEST_RIBBON_POLE_CHANNEL_BLUE,
                SPELL_TEST_RIBBON_POLE_CHANNEL_RED,
                SPELL_TEST_RIBBON_POLE_CHANNEL_PINK
            });
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* target = GetTarget())
        {
            Creature* cr = target->FindNearestCreature(NPC_RIBBON_POLE_DEBUG_TARGET, 10.0f);
            if (!cr)
            {
                target->RemoveAura(SPELL_TEST_RIBBON_POLE_CHANNEL_BLUE);
                target->RemoveAura(SPELL_TEST_RIBBON_POLE_CHANNEL_RED);
                target->RemoveAura(SPELL_TEST_RIBBON_POLE_CHANNEL_PINK);
                SetDuration(1);
                return;
            }

            if (Aura* aur = target->GetAura(SPELL_RIBBON_POLE_XP))
                aur->SetDuration(std::min(aur->GetDuration() + 3 * MINUTE * IN_MILLISECONDS, 60 * MINUTE * IN_MILLISECONDS));
            else
            {
                target->CastSpell(target, SPELL_RIBBON_POLE_XP, true);

                // Achievement
                if ((GameTime::GetGameTime().count() - GetApplyTime()) > 60 && target->IsPlayer())
                    target->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 58934, 0, target);
            }

            // Achievement
            if ((time(nullptr) - GetApplyTime()) > 60 && target->IsPlayer())
                target->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 58934, 0, target);
        }
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* ar = GetTarget();
        switch (urand(0, 2))
        {
            case 0:
                ar->CastSpell(ar, SPELL_TEST_RIBBON_POLE_CHANNEL_BLUE, true);
                break;
            case 1:
                ar->CastSpell(ar, SPELL_TEST_RIBBON_POLE_CHANNEL_RED, true);
                break;
            case 2:
            default:
                ar->CastSpell(ar, SPELL_TEST_RIBBON_POLE_CHANNEL_PINK, true);
                break;
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_midsummer_ribbon_pole::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_midsummer_ribbon_pole::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_midsummer_ribbon_pole_visual : public SpellScript
{
    PrepareSpellScript(spell_midsummer_ribbon_pole_visual)

    void UpdateTarget(WorldObject*& target)
    {
        if (!target)
            return;

        // find NPC at ribbon pole top as target
        // trap 181604 also spawns NPCs at pole bottom - ignore those
        std::list<Creature*> crList;
        target->GetCreaturesWithEntryInRange(crList, 30.0f, NPC_RIBBON_POLE_DEBUG_TARGET);
        if (crList.empty())
            return;

        for (std::list<Creature*>::const_iterator itr = crList.begin(); itr != crList.end(); ++itr)
        {
            // NPC on ribbon pole top is no tempsummon
            if (!(*itr)->ToTempSummon())
            {
                target = *itr;
                return;
            }
        }
    }

    void Register() override
    {
        OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_midsummer_ribbon_pole_visual::UpdateTarget, EFFECT_0, TARGET_UNIT_NEARBY_ENTRY);
    }
};

class spell_braziers_hit : public AuraScript
{
    PrepareAuraScript(spell_braziers_hit)

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_TORCH_TOSSING_TRAINING_SUCCESS_A,
                SPELL_TORCH_TOSSING_TRAINING_SUCCESS_H,
                SPELL_TORCH_TOSSING_TRAINING,
                SPELL_TORCH_TOSSING_PRACTICE,
             });
    }

    void HandleAfterEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* const player = GetTarget()->ToPlayer();

        if (!player)
            return;

        if ((player->HasAura(SPELL_TORCH_TOSSING_TRAINING) && (GetStackAmount() >= 8)) ||
            (player->HasAura(SPELL_TORCH_TOSSING_PRACTICE) && (GetStackAmount() >= 20)))
        {
            player->CastSpell(player, SPELL_TORCH_TOSSING_TRAINING_SUCCESS_A, true);
            player->CastSpell(player, SPELL_TORCH_TOSSING_TRAINING_SUCCESS_H, true);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_braziers_hit::HandleAfterEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

class spell_torch_target_picker : public SpellScript
{
    PrepareSpellScript(spell_torch_target_picker)

    void SelectTargets(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        // keep single random element only
        WorldObject* const bunny = Acore::Containers::SelectRandomContainerElement(targets);
        targets.clear();
        targets.push_back(bunny);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_torch_target_picker::SelectTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
    }
};

class spell_torch_tossing_training : public AuraScript
{
    PrepareAuraScript(spell_torch_tossing_training)

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_REMOVE_TORCHES });
    }

    void HandleAfterEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* const target = GetTarget())
            target->CastSpell(target, SPELL_REMOVE_TORCHES);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectApplyFn(spell_torch_tossing_training::HandleAfterEffectRemove, EFFECT_0, SPELL_AURA_DETECT_AMORE, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

enum flingTorch
{
    NPC_TORCH_TARGET                = 26188,

    SPELL_FLING_TORCH               = 45669,
    SPELL_FLING_TORCH_DUMMY         = 46747,
    SPELL_MISSED_TORCH              = 45676,
    SPELL_TORCH_COUNTER             = 45693,
    SPELL_TORCH_SHADOW              = 46105,
    SPELL_TORCH_CATCH_SUCCESS_A     = 46081,
    SPELL_TORCH_CATCH_SUCCESS_H     = 46654,
    SPELL_JUGGLE_TORCH              = 45671,

    QUEST_MORE_TORCH_TOSS_A         = 11924,
    QUEST_MORE_TORCH_TOSS_H         = 11925,
};

class spell_midsummer_fling_torch : public SpellScript
{
    PrepareSpellScript(spell_midsummer_fling_torch);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_FLING_TORCH,
                SPELL_TORCH_SHADOW,
                SPELL_MISSED_TORCH,
                SPELL_TORCH_CATCH_SUCCESS_A,
                SPELL_TORCH_CATCH_SUCCESS_H,
                SPELL_TORCH_COUNTER
            });
    }

    bool handled;
    bool Load() override { handled = false; return true; }

    void ThrowNextTorch(Unit* caster)
    {
        Creature* bunny = caster->FindNearestCreature(NPC_TORCH_TARGET, 100.0f);

        if (!bunny)
            return;

        // targets are located on a circle with fixed radius around the target bunny
        // first target is chosen randomly anywhere on the circle
        // next target is chosen on the opposite half of the circle
        // so a minimum flight duration of the torch is guaranteed
        float angle = 0.0f;
        if (GetSpellInfo()->Id == SPELL_FLING_TORCH_DUMMY)
            angle = frand(-1.0f * M_PI, 1.0f * M_PI); // full circle
        else
            angle = frand(-0.5f * M_PI, 0.5f * M_PI); // half circle

        Position pos = bunny->GetPosition();
        pos.SetOrientation(caster->GetPosition().GetAbsoluteAngle(pos));
        pos.RelocatePolarOffset(angle, 8.0f); // radius is sniffed value

        caster->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_FLING_TORCH, true);
        caster->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_TORCH_SHADOW, true);
    }

    void HandleFinish()
    {
        Unit* caster = GetCaster();
        if (!caster || !caster->ToPlayer()) // caster cant be null, but meh :p
            return;

        if (GetSpellInfo()->Id != SPELL_FLING_TORCH_DUMMY)
        {
            if (!handled)
                if (const WorldLocation* loc = GetExplTargetDest())
                {
                    caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_MISSED_TORCH, true);
                    caster->RemoveAurasDueToSpell(SPELL_TORCH_COUNTER);
                }
            return;
        }

        ThrowNextTorch(caster);
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Player* target = GetHitPlayer())
        {
            if (target->GetGUID() != GetCaster()->GetGUID())
                return;

            handled = true;
            if (Aura* aur = target->GetAura(SPELL_TORCH_COUNTER))
            {
                aur->ModStackAmount(1);
                uint8 count = 4;
                if (target->GetQuestStatus(target->GetTeamId() ? QUEST_MORE_TORCH_TOSS_H : QUEST_MORE_TORCH_TOSS_A) == QUEST_STATUS_INCOMPLETE) // More Torch Catching quests
                    count = 10;

                if (aur->GetStackAmount() >= count)
                {
                    //target->CastSpell(target, 46711, true); // Set Flag: all torch returning quests are complete
                    target->CastSpell(target, (target->GetTeamId() ? SPELL_TORCH_CATCH_SUCCESS_H : SPELL_TORCH_CATCH_SUCCESS_A), true); // Quest completion
                    aur->SetDuration(1);
                    return;
                }
            }
            else
                target->CastSpell(target, SPELL_TORCH_COUNTER, true);

            ThrowNextTorch(GetCaster());
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_midsummer_fling_torch::HandleFinish);
        if (m_scriptSpellId == SPELL_JUGGLE_TORCH)
        {
            OnEffectHitTarget += SpellEffectFn(spell_midsummer_fling_torch::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    }
};

enum eJuggle
{
    SPELL_JUGGLE_SELF           = 45638,
    SPELL_JUGGLE_SLOW           = 45792,
    SPELL_JUGGLE_MED            = 45806,
    SPELL_JUGGLE_FAST           = 45816,

    SPELL_TORCH_CHECK           = 45644,
    SPELL_GIVE_TORCH            = 45280,
    QUEST_TORCH_CATCHING_A      = 11657,
    QUEST_TORCH_CATCHING_H      = 11923,

    SPELL_TORCH_SHADOW_SELF     = 46121,
    SPELL_TORCH_SHADOW_SLOW     = 46120,
    SPELL_TORCH_SHADOW_MED      = 46118,
    SPELL_TORCH_SHADOW_FAST     = 46117
};

class spell_midsummer_juggling_torch : public SpellScript
{
    PrepareSpellScript(spell_midsummer_juggling_torch);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_JUGGLE_SELF,
                SPELL_JUGGLE_SLOW,
                SPELL_JUGGLE_MED,
                SPELL_JUGGLE_FAST,
                SPELL_TORCH_SHADOW_SELF,
                SPELL_TORCH_SHADOW_SLOW,
                SPELL_TORCH_SHADOW_MED,
                SPELL_TORCH_SHADOW_FAST
            });
    }

    void HandleFinish()
    {
        Unit* caster = GetCaster();
        if (!caster || !caster->IsPlayer())
            return;

        if (const WorldLocation* loc = GetExplTargetDest())
        {
            if (loc->GetExactDist(caster) < 3.0f)
            {
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_JUGGLE_SELF, true);
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_TORCH_SHADOW_SELF, true);
            }
            else if (loc->GetExactDist(caster) < 10.0f)
            {
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_JUGGLE_SLOW, true);
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_TORCH_SHADOW_SLOW, true);
            }
            else if (loc->GetExactDist(caster) < 25.0f)
            {
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_JUGGLE_MED, true);
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_TORCH_SHADOW_MED, true);
            }
            else
            {
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_JUGGLE_FAST, true);
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_TORCH_SHADOW_FAST, true);
            }
        }
        else
        {
            caster->CastSpell(caster, SPELL_JUGGLE_SELF, true);
            caster->CastSpell(caster, SPELL_TORCH_SHADOW_SELF, true);
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_midsummer_juggling_torch::HandleFinish);
    }
};

// 45644 - Juggle Torch (Catch)
class spell_midsummer_torch_catch : public SpellScript
{
    PrepareSpellScript(spell_midsummer_torch_catch);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GIVE_TORCH });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* player = GetHitPlayer();
        if (!player)
        {
            return;
        }

        if (player->GetQuestStatus(QUEST_TORCH_CATCHING_A) == QUEST_STATUS_REWARDED || player->GetQuestStatus(QUEST_TORCH_CATCHING_H) == QUEST_STATUS_REWARDED)
        {
            player->CastSpell(player, SPELL_GIVE_TORCH);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_midsummer_torch_catch::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 46592 - Summon Ahune Lieutenant
class spell_midsummer_summon_ahune_lieutenant : public SpellScript
{
    PrepareSpellScript(spell_midsummer_summon_ahune_lieutenant);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        uint32 zoneId = caster->GetZoneId();
        uint32 npcEntry = 0;

        switch (zoneId)
        {
        case AREA_ASHENVALE:
            npcEntry = 26116; // Frostwave Lieutenant
            break;
        case AREA_DESOLACE:
            npcEntry = 26178; // Hailstone Lieutenant
            break;
        case AREA_STRANGLETHORN_VALE:
            npcEntry = 26204; // Chillwind Lieutenant
            break;
        case AREA_SEARING_GORGE:
            npcEntry = 26214; // Frigid Lieutenant
            break;
        case AREA_SILITHUS:
            npcEntry = 26215; // Glacial Lieutenant
            break;
        case AREA_HELLFIRE_PENINSULA:
            npcEntry = 26216; // Glacial Templar
            break;
        }

        if (npcEntry)
            caster->SummonCreature(npcEntry, caster->GetPosition(), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, MINUTE * IN_MILLISECONDS);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_midsummer_summon_ahune_lieutenant::HandleDummy, EFFECT_1, SPELL_EFFECT_APPLY_AURA);
    }
};

void AddSC_event_midsummer_scripts()
{
    // Player
    new MidsummerPlayerScript();

    // NPCs
    RegisterCreatureAI(npc_midsummer_bonfire);
    RegisterCreatureAI(npc_midsummer_bonfire_despawner);
    RegisterCreatureAI(npc_midsummer_ribbon_pole_target);

    // Spells
    RegisterSpellScript(spell_fire_festival_fortitude);
    RegisterSpellScript(spell_bonfires_blessing);
    RegisterSpellScript(spell_gen_crab_disguise);
    RegisterSpellScript(spell_midsummer_ribbon_pole_firework);
    RegisterSpellScript(spell_midsummer_ribbon_pole);
    RegisterSpellScript(spell_midsummer_ribbon_pole_visual);
    RegisterSpellScript(spell_midsummer_fling_torch);
    RegisterSpellScript(spell_midsummer_juggling_torch);
    RegisterSpellScript(spell_midsummer_torch_catch);
    RegisterSpellScript(spell_midsummer_summon_ahune_lieutenant);
    RegisterSpellScript(spell_braziers_hit);
    RegisterSpellScript(spell_torch_target_picker);
    RegisterSpellScript(spell_torch_tossing_training);
}
