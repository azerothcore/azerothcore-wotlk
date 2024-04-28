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
#include "GameEventMgr.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "GameTime.h"
#include "Player.h"
#include "PlayerScript.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include <random>

enum eBonfire
{
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
// Map 0
    { { 0, 1,    TEAM_ALLIANCE }, &BonfireStampedOutState[0] },
    { { 0, 3,    TEAM_HORDE    }, &BonfireStampedOutState[1] },
    { { 0, 4,    TEAM_ALLIANCE }, &BonfireStampedOutState[2] },
    { { 0, 8,    TEAM_HORDE    }, &BonfireStampedOutState[3] },
    { { 0, 10,   TEAM_ALLIANCE }, &BonfireStampedOutState[4] },
    { { 0, 11,   TEAM_ALLIANCE }, &BonfireStampedOutState[5] },
    { { 0, 12,   TEAM_ALLIANCE }, &BonfireStampedOutState[6] },
    { { 0, 28,   TEAM_ALLIANCE }, &BonfireStampedOutState[7] },
    { { 0, 33,   TEAM_ALLIANCE }, &BonfireStampedOutState[8] },
    { { 0, 33,   TEAM_HORDE    }, &BonfireStampedOutState[9] },
    { { 0, 38,   TEAM_ALLIANCE }, &BonfireStampedOutState[10] },
    { { 0, 40,   TEAM_ALLIANCE }, &BonfireStampedOutState[11] },
    { { 0, 44,   TEAM_ALLIANCE }, &BonfireStampedOutState[12] },
    { { 0, 45,   TEAM_ALLIANCE }, &BonfireStampedOutState[13] },
    { { 0, 45,   TEAM_HORDE    }, &BonfireStampedOutState[14] },
    { { 0, 46,   TEAM_ALLIANCE }, &BonfireStampedOutState[15] },
    { { 0, 46,   TEAM_HORDE    }, &BonfireStampedOutState[16] },
    { { 0, 47,   TEAM_ALLIANCE }, &BonfireStampedOutState[17] },
    { { 0, 47,   TEAM_HORDE    }, &BonfireStampedOutState[18] },
    { { 0, 85,   TEAM_HORDE    }, &BonfireStampedOutState[19] },
    { { 0, 130,  TEAM_HORDE    }, &BonfireStampedOutState[20] },
    { { 0, 267,  TEAM_ALLIANCE }, &BonfireStampedOutState[21] },
    { { 0, 267,  TEAM_HORDE    }, &BonfireStampedOutState[22] },

// Map 1
    { { 1, 14,   TEAM_HORDE    }, &BonfireStampedOutState[23] },
    { { 1, 15,   TEAM_ALLIANCE }, &BonfireStampedOutState[24] },
    { { 1, 15,   TEAM_HORDE    }, &BonfireStampedOutState[25] },
    { { 1, 17,   TEAM_HORDE    }, &BonfireStampedOutState[26] },
    { { 1, 141,  TEAM_ALLIANCE }, &BonfireStampedOutState[27] },
    { { 1, 148,  TEAM_ALLIANCE }, &BonfireStampedOutState[28] },
    { { 1, 215,  TEAM_HORDE    }, &BonfireStampedOutState[29] },
    { { 1, 331,  TEAM_ALLIANCE }, &BonfireStampedOutState[30] },
    { { 1, 331,  TEAM_HORDE    }, &BonfireStampedOutState[31] },
    { { 1, 357,  TEAM_ALLIANCE }, &BonfireStampedOutState[32] },
    { { 1, 357,  TEAM_HORDE    }, &BonfireStampedOutState[33] },
    { { 1, 400,  TEAM_HORDE    }, &BonfireStampedOutState[34] },
    { { 1, 405,  TEAM_ALLIANCE }, &BonfireStampedOutState[35] },
    { { 1, 405,  TEAM_HORDE    }, &BonfireStampedOutState[36] },
    { { 1, 406,  TEAM_HORDE    }, &BonfireStampedOutState[37] },
    { { 1, 440,  TEAM_ALLIANCE }, &BonfireStampedOutState[38] },
    { { 1, 440,  TEAM_HORDE    }, &BonfireStampedOutState[39] },
    { { 1, 618,  TEAM_ALLIANCE }, &BonfireStampedOutState[40] },
    { { 1, 618,  TEAM_HORDE    }, &BonfireStampedOutState[41] },
    { { 1, 1377, TEAM_ALLIANCE }, &BonfireStampedOutState[42] },
    { { 1, 1377, TEAM_HORDE    }, &BonfireStampedOutState[43] },

// Map 530
    { { 530, 3430, TEAM_HORDE    }, &BonfireStampedOutState[44] },
    { { 530, 3433, TEAM_HORDE    }, &BonfireStampedOutState[45] },
    { { 530, 3483, TEAM_ALLIANCE }, &BonfireStampedOutState[46] },
    { { 530, 3483, TEAM_HORDE    }, &BonfireStampedOutState[47] },
    { { 530, 3518, TEAM_ALLIANCE }, &BonfireStampedOutState[48] },
    { { 530, 3518, TEAM_HORDE    }, &BonfireStampedOutState[49] },
    { { 530, 3519, TEAM_ALLIANCE }, &BonfireStampedOutState[50] },
    { { 530, 3519, TEAM_HORDE    }, &BonfireStampedOutState[51] },
    { { 530, 3520, TEAM_ALLIANCE }, &BonfireStampedOutState[52] },
    { { 530, 3520, TEAM_HORDE    }, &BonfireStampedOutState[53] },
    { { 530, 3521, TEAM_ALLIANCE }, &BonfireStampedOutState[54] },
    { { 530, 3521, TEAM_HORDE    }, &BonfireStampedOutState[55] },
    { { 530, 3522, TEAM_ALLIANCE }, &BonfireStampedOutState[56] },
    { { 530, 3522, TEAM_HORDE    }, &BonfireStampedOutState[57] },
    { { 530, 3523, TEAM_ALLIANCE }, &BonfireStampedOutState[58] },
    { { 530, 3523, TEAM_HORDE    }, &BonfireStampedOutState[59] },
    { { 530, 3524, TEAM_ALLIANCE }, &BonfireStampedOutState[60] },
    { { 530, 3525, TEAM_ALLIANCE }, &BonfireStampedOutState[61] },

// Map 571
    { { 571, 65,   TEAM_ALLIANCE }, &BonfireStampedOutState[62] },
    { { 571, 65,   TEAM_HORDE    }, &BonfireStampedOutState[63] },
    { { 571, 66,   TEAM_ALLIANCE }, &BonfireStampedOutState[64] },
    { { 571, 66,   TEAM_HORDE    }, &BonfireStampedOutState[65] },
    { { 571, 67,   TEAM_ALLIANCE }, &BonfireStampedOutState[66] },
    { { 571, 67,   TEAM_HORDE    }, &BonfireStampedOutState[67] },
    { { 571, 394,  TEAM_ALLIANCE }, &BonfireStampedOutState[68] },
    { { 571, 394,  TEAM_HORDE    }, &BonfireStampedOutState[69] },
    { { 571, 495,  TEAM_ALLIANCE }, &BonfireStampedOutState[70] },
    { { 571, 495,  TEAM_HORDE    }, &BonfireStampedOutState[71] },
    { { 571, 2817, TEAM_ALLIANCE }, &BonfireStampedOutState[72] },
    { { 571, 2817, TEAM_HORDE    }, &BonfireStampedOutState[73] },
    { { 571, 3537, TEAM_ALLIANCE }, &BonfireStampedOutState[74] },
    { { 571, 3537, TEAM_HORDE    }, &BonfireStampedOutState[75] },
    { { 571, 3711, TEAM_ALLIANCE }, &BonfireStampedOutState[76] },
    { { 571, 3711, TEAM_HORDE    }, &BonfireStampedOutState[77] },
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

    void OnUpdateZone(Player* player, uint32 newZone, uint32 /*newArea*/) override
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
        if (caster->GetTypeId() != TYPEID_PLAYER)
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

enum torchToss
{
    GO_TORCH_TARGET_BRAZIER         = 187708,
    NPC_TORCH_TOSS_TARGET_BUNNY     = 25535,

    SPELL_TARGET_INDICATOR_RANK_1   = 43313,
    SPELL_TORCH_TOSS_LAND           = 46054,
    SPELL_BRAZIERS_HIT_VISUAL       = 45724,
    SPELL_TORCH_TOSS_SUCCESS_A      = 45719,
    SPELL_TORCH_TOSS_SUCCESS_H      = 46651,
    SPELL_TORCH_TOSS_TRAINING       = 45716,
};

struct npc_midsummer_torch_target : public ScriptedAI
{
    npc_midsummer_torch_target(Creature* creature) : ScriptedAI(creature)
    {
        teleTimer = 0;
        startTimer = 1;
        posVec.clear();
        playerGUID.Clear();
        me->CastSpell(me, SPELL_TARGET_INDICATOR_RANK_1, true);
        counter = 0;
        maxCount = 0;
    }

    ObjectGuid playerGUID;
    uint32 startTimer;
    uint32 teleTimer;
    std::vector<Position> posVec;
    uint8 counter;
    uint8 maxCount;

    void SetPlayerGUID(ObjectGuid guid, uint8 cnt)
    {
        playerGUID = guid;
        maxCount = cnt;
    }

    bool CanBeSeen(Player const* seer) override
    {
        return seer->GetGUID() == playerGUID;
    }

    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
    {
        if (posVec.empty())
            return;
        // Triggered spell from torch
        if (spellInfo->Id == SPELL_TORCH_TOSS_LAND && caster->GetTypeId() == TYPEID_PLAYER)
        {
            me->CastSpell(me, SPELL_BRAZIERS_HIT_VISUAL, true); // hit visual anim
            if (++counter >= maxCount)
            {
                caster->CastSpell(caster, (caster->ToPlayer()->GetTeamId() ? SPELL_TORCH_TOSS_SUCCESS_H : SPELL_TORCH_TOSS_SUCCESS_A), true); // quest complete spell
                me->DespawnOrUnsummon(1);
                return;
            }

            teleTimer = 1;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (startTimer)
        {
            startTimer += diff;
            if (startTimer >= 200)
            {
                startTimer = 0;
                FillPositions();
                SelectPosition();
            }
        }
        if (teleTimer)
        {
            teleTimer += diff;
            if (teleTimer >= 750 && teleTimer < 10000)
            {
                teleTimer = 10000;
                SelectPosition();
            }
            else if (teleTimer >= 10500)
            {
                if (Player* plr = ObjectAccessor::GetPlayer(*me, playerGUID))
                    plr->UpdateTriggerVisibility();

                teleTimer = 0;
            }
        }
    }

    void FillPositions()
    {
        std::list<GameObject*> gobjList;
        me->GetGameObjectListWithEntryInGrid(gobjList, GO_TORCH_TARGET_BRAZIER, 30.0f);
        for (std::list<GameObject*>::const_iterator itr = gobjList.begin(); itr != gobjList.end(); ++itr)
        {
            Position pos;
            pos.Relocate(*itr);
            posVec.push_back(pos);
        }
    }

    void SelectPosition()
    {
        if (posVec.empty())
            return;
        int8 num = urand(0, posVec.size() - 1);
        Position pos;
        pos.Relocate(posVec.at(num));
        me->m_last_notify_position.Relocate(0.0f, 0.0f, 0.0f);
        me->m_last_notify_mstime = GameTime::GetGameTimeMS().count() + 10000;

        me->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation());
    }
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
        if (std::find(_dancerList.begin(), _dancerList.end(), dancer) != _dancerList.end())
            return;

        _dancerList.push_back(dancer);
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
        std::erase_if(_dancerList, [](Player* dancer)
            {
                return !dancer->HasAura(SPELL_RIBBON_POLE_PERIODIC_VISUAL);
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
                    Player* dancerTarget = _dancerList[i];

                    if (dancerTarget)
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
    std::vector<Player*> _dancerList;
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
                if ((GameTime::GetGameTime().count() - GetApplyTime()) > 60 && target->GetTypeId() == TYPEID_PLAYER)
                    target->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 58934, 0, target);
            }

            // Achievement
            if ((time(nullptr) - GetApplyTime()) > 60 && target->GetTypeId() == TYPEID_PLAYER)
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

class spell_midsummer_torch_quest : public AuraScript
{
    PrepareAuraScript(spell_midsummer_torch_quest)

    bool Load() override
    {
        torchGUID.Clear();
        return true;
    }

    ObjectGuid torchGUID;

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* ar = GetTarget();
        if (Creature* cr = ar->SummonCreature(NPC_TORCH_TOSS_TARGET_BUNNY, ar->GetPositionX(), ar->GetPositionY(), ar->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 90000))
        {
            torchGUID = cr->GetGUID();
            CAST_AI(npc_midsummer_torch_target, cr->AI())->SetPlayerGUID(ar->GetGUID(), (GetId() == SPELL_TORCH_TOSS_TRAINING ? 8 : 20));
        }
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* cr = ObjectAccessor::GetCreature(*GetTarget(), torchGUID))
            cr->DespawnOrUnsummon(1);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_midsummer_torch_quest::HandleEffectApply, EFFECT_0, SPELL_AURA_DETECT_AMORE, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_midsummer_torch_quest::HandleEffectRemove, EFFECT_0, SPELL_AURA_DETECT_AMORE, AURA_EFFECT_HANDLE_REAL);
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
        if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
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
        case 331: // Ashenvale
            npcEntry = 26116; // Frostwave Lieutenant
            break;
        case 405: // Desolace
            npcEntry = 26178; // Hailstone Lieutenant
            break;
        case 33: // Stranglethorn Vale
            npcEntry = 26204; // Chillwind Lieutenant
            break;
        case 51: // Searing Gorge
            npcEntry = 26214; // Frigid Lieutenant
            break;
        case 1377: // Silithus
            npcEntry = 26215; // Glacial Lieutenant
            break;
        case 3483: // Hellfire Peninsula
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

///////////////////////////////
// GAMEOBJECTS
///////////////////////////////

enum eFireworks
{
    GO_FIREWORK_SHOW_TYPE_1_RED         = 180703,
    GO_FIREWORK_SHOW_TYPE_2_RED         = 180704,
    GO_FIREWORK_SHOW_TYPE_1_RED_BIG     = 180707,
    GO_FIREWORK_SHOW_TYPE_2_RED_BIG     = 180708,
    GO_FIREWORK_SHOW_TYPE_1_BLUE        = 180720,
    GO_FIREWORK_SHOW_TYPE_2_BLUE        = 180721,
    GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG    = 180722,
    GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG    = 180723,
    GO_FIREWORK_SHOW_TYPE_1_GREEN       = 180724,
    GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG   = 180725,
    GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG   = 180726,
    GO_FIREWORK_SHOW_TYPE_2_GREEN       = 180727,
    GO_FIREWORK_SHOW_TYPE_1_WHITE       = 180728,
    GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG   = 180729,
    GO_FIREWORK_SHOW_TYPE_2_WHITE       = 180730,
    GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG   = 180731,
    GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG  = 180733,
    GO_FIREWORK_SHOW_TYPE_1_YELLOW      = 180736,
    GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG  = 180737,
    GO_FIREWORK_SHOW_TYPE_2_YELLOW      = 180738,
    GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG  = 180739,
    GO_FIREWORK_SHOW_TYPE_2_PURPLE      = 180740,
    GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG  = 180741,

    COUNT_FIREWORK_SPAWN_POSITIONS      = 106,
};

// VerifiedBuild 50250
// X, Y, Z, orientation, rotX, rotY, rotZ, rotW
float const fireworkSpawnPosition[COUNT_FIREWORK_SPAWN_POSITIONS][8] =
{
    // Teldrassil
    { 8586.716f, 913.4768f, 18.290524f, 4.7647495f, 0.0f, 0.0f, -0.6883545f, 0.72537446f }, /* 0 */
    { 8556.297f, 920.9475f, 16.883488f, 3.47321f, 0.0f, 0.0f, -0.9862852f, 0.1650499f }, /* 1 */
    { 8517.45f, 879.5556f, 37.296207f, 6.073746f, 0.0f, 0.0f, -0.10452843f, 0.9945219f }, /* 2 */
    { 8576.803f, 814.3604f, 33.937782f, 4.66003f, 0.0f, 0.0f, -0.7253742f, 0.68835473f }, /* 3 */
    { 8519.375f, 917.84204f, 31.56014f, 2.1118479f, 0.0f, 0.0f, 0.8703556f, 0.4924237f }, /* 4 */
    { 8508.24f, 838.3653f, 36.13922f, 4.66003f, 0.0f, 0.0f, -0.7253742f, 0.68835473f }, /* 5 */
    { 8572.691f, 814.73785f, 39.06141f, 3.6826503f, 0.0f, 0.0f, -0.9636297f, 0.267241f }, /* 6 */
    { 8617.442f, 917.65735f, 21.298094f, 4.886924f, 0.0f, 0.0f, -0.642787f, 0.766045f }, /* 7 */
    { 8547.279f, 964.1688f, 1.67925f, 5.550147f, 0.0f, 0.0f, -0.35836792f, 0.93358046f }, /* 8 */
    { 8571.629f, 880.1509f, 25.84234f, 5.8992143f, 0.0f, 0.0f, -0.1908083f, 0.9816273f }, /* 9 */
    { 8570.95f, 854.1404f, 33.875076f, 3.0543265f, 0.0f, 0.0f, 0.99904823f, 0.04361926f }, /* 10 */
    { 8550.322f, 910.9803f, 24.775682f, 3.7001047f, 0.0f, 0.0f, -0.9612608f, 0.2756405f }, /* 11 */
    { 8538.561f, 951.66364f, 27.672834f, 4.729844f, 0.0f, 0.0f, -0.70090866f, 0.71325105f }, /* 12 */
    { 8520.907f, 813.0203f, 31.55126f, 3.6826503f, 0.0f, 0.0f, -0.9636297f, 0.267241f }, /* 13 */
    { 8488.077f, 983.2385f, 11.065558f, 2.1118479f, 0.0f, 0.0f, 0.8703556f, 0.4924237f }, /* 14 */
    { 8507.603f, 878.88544f, 21.902124f, 5.8992143f, 0.0f, 0.0f, -0.1908083f, 0.9816273f }, /* 15 */
    { 8560.618f, 777.34174f, 44.394432f, 4.886924f, 0.0f, 0.0f, -0.642787f, 0.766045f }, /* 16 */
    { 8547.402f, 974.4881f, 21.70646f, 5.8468537f, 0.0f, 0.0f, -0.21643925f, 0.97629607f }, /* 17 */
    { 8571.85f, 913.15027f, 23.696306f, 6.073746f, 0.0f, 0.0f, -0.10452843f, 0.9945219f }, /* 18 */
    { 8517.067f, 986.08563f, 18.080776f, 4.729844f, 0.0f, 0.0f, -0.70090866f, 0.71325105f }, /* 19 */
    { 8554.825f, 813.0741f, 41.60293f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 20 */
    { 8570.65f, 885.1715f, 30.919722f, 2.5481794f, 0.0f, 0.0f, 0.95630455f, 0.29237235f }, /* 21 */
    { 8554.281f, 875.83124f, 43.304214f, 5.550147f, 0.0f, 0.0f, -0.35836792f, 0.93358046f }, /* 22 */
    { 8582.255f, 848.0614f, 26.468353f, 5.8992143f, 0.0f, 0.0f, -0.1908083f, 0.9816273f }, /* 23 */
    { 8579.229f, 911.8906f, 43.44348f, 3.0543265f, 0.0f, 0.0f, 0.99904823f, 0.04361926f }, /* 24 */
    { 8553.929f, 853.647f, 45.6748f, 0.13962449f, 0.0f, 0.0f, 0.069755554f, 0.99756414f }, /* 25 */
    { 8574.236f, 944.2092f, 12.242791f, 4.7647495f, 0.0f, 0.0f, -0.6883545f, 0.72537446f }, /* 26 */
    { 8583.88f, 948.4117f, 14.515119f, 5.8468537f, 0.0f, 0.0f, -0.21643925f, 0.97629607f }, /* 27 */
    { 8590.731f, 846.9432f, 32.94236f, 2.1991146f, 0.0f, 0.0f, 0.89100647f, 0.45399064f }, /* 28 */
    { 8494.191f, 943.86847f, 4.296366f, 6.073746f, 0.0f, 0.0f, -0.10452843f, 0.9945219f }, /* 29 */
    { 8514.054f, 848.6051f, 22.294308f, 2.5481794f, 0.0f, 0.0f, 0.95630455f, 0.29237235f }, /* 30 */
    { 8551.224f, 947.6057f, 22.325508f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 31 */
    { 8526.2f, 848.85443f, 29.566902f, 2.1991146f, 0.0f, 0.0f, 0.89100647f, 0.45399064f }, /* 32 */
    { 8553.734f, 780.05054f, 23.383448f, 4.886924f, 0.0f, 0.0f, -0.642787f, 0.766045f }, /* 33 */
    { 8539.493f, 887.22687f, 41.412548f, 3.47321f, 0.0f, 0.0f, -0.9862852f, 0.1650499f }, /* 34 */
    { 8578.887f, 975.26086f, 11.224254f, 5.8468537f, 0.0f, 0.0f, -0.21643925f, 0.97629607f }, /* 35 */
    { 8550.191f, 850.72296f, 20.371725f, 3.7001047f, 0.0f, 0.0f, -0.9612608f, 0.2756405f }, /* 36 */
    { 8617.526f, 851.59625f, 31.061853f, 3.6826503f, 0.0f, 0.0f, -0.9636297f, 0.267241f }, /* 37 */
    { 8550.932f, 817.2398f, 23.243538f, 3.6302915f, 0.0f, 0.0f, -0.97029495f, 0.241925f }, /* 38 */
    { 8558.55f, 838.934f, 23.73945f, 4.66003f, 0.0f, 0.0f, -0.7253742f, 0.68835473f }, /* 39 */
    { 8581.158f, 881.23505f, 27.630243f, 0.9773831f, 0.0f, 0.0f, 0.46947098f, 0.8829479f }, /* 40 */
    { 8591.914f, 901.6492f, 21.890562f, 5.550147f, 0.0f, 0.0f, -0.35836792f, 0.93358046f }, /* 41 */
    { 8578.143f, 948.3262f, 33.434845f, 2.1118479f, 0.0f, 0.0f, 0.8703556f, 0.4924237f }, /* 42 */
    { 8523.006f, 907.74146f, 31.921688f, 0.9773831f, 0.0f, 0.0f, 0.46947098f, 0.8829479f }, /* 43 */
    { 8537.763f, 877.8918f, 38.21184f, 3.0543265f, 0.0f, 0.0f, 0.99904823f, 0.04361926f }, /* 44 */
    { 8539.892f, 914.3368f, 12.866696f, 3.6302915f, 0.0f, 0.0f, -0.97029495f, 0.241925f }, /* 45 */
    { 8536.576f, 873.7225f, 3.934316f, 0.13962449f, 0.0f, 0.0f, 0.069755554f, 0.99756414f }, /* 46 */
    { 8538.786f, 820.7366f, 21.470728f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 47 */
    { 8550.996f, 848.8595f, 29.500027f, 3.47321f, 0.0f, 0.0f, -0.9862852f, 0.1650499f }, /* 48 */
    { 8542.07f, 852.01776f, 44.55815f, 3.7001047f, 0.0f, 0.0f, -0.9612608f, 0.2756405f }, /* 49 */
    { 8544.277f, 885.0594f, 28.99882f, 0.13962449f, 0.0f, 0.0f, 0.069755554f, 0.99756414f }, /* 50 */
    { 8514.364f, 940.0869f, 20.151571f, 4.7647495f, 0.0f, 0.0f, -0.6883545f, 0.72537446f }, /* 51 */
    { 8519.5f, 949.7708f, 17.38267f, 3.6302915f, 0.0f, 0.0f, -0.97029495f, 0.241925f }, /* 52 */
    { 8588.622f, 912.0434f, 24.114552f, 0.9773831f, 0.0f, 0.0f, 0.46947098f, 0.8829479f }, /* 53 */
    { 8581.7705f, 817.0301f, 21.357187f, 2.1991146f, 0.0f, 0.0f, 0.89100647f, 0.45399064f }, /* 54 */
    { 8550.214f, 787.1689f, 25.89918f, 4.729844f, 0.0f, 0.0f, -0.70090866f, 0.71325105f }, /* 55 */
    { 8494.68f, 911.78345f, 21.55266f, 2.5481794f, 0.0f, 0.0f, 0.95630455f, 0.29237235f }, /* 56 */
    { 8697.891f, 991.0841f, 39.18531f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 57 */
    // Stormwind
    { -8945.564f, 511.51562f, 148.2895f, 5.8992143f, 0.0f, 0.0f, -0.1908083f, 0.9816273f }, /* 58 */
    { -8937.466f, 517.05206f, 147.13005f, 3.6826503f, 0.0f, 0.0f, -0.9636297f, 0.267241f }, /* 59 */
    { -8888.514f, 573.9601f, 143.53285f, 4.7647495f, 0.0f, 0.0f, -0.6883545f, 0.72537446f }, /* 60 */
    { -8937.466f, 517.05206f, 167.63005f, 3.6826503f, 0.0f, 0.0f, -0.9636297f, 0.267241f }, /* 61 */
    { -8964.986f, 535.21356f, 160.58374f, 4.886924f, 0.0f, 0.0f, -0.642787f, 0.766045f }, /* 62 */
    { -8877.406f, 577.82294f, 137.76657f, 3.47321f, 0.0f, 0.0f, -0.9862852f, 0.1650499f }, /* 63 */
    { -8945.564f, 511.51562f, 150.92146f, 5.8992143f, 0.0f, 0.0f, -0.1908083f, 0.9816273f }, /* 64 */
    { -8968.125f, 525.1285f, 164.58287f, 3.0543265f, 0.0f, 0.0f, 0.99904823f, 0.04361926f }, /* 65 */
    { -8957.857f, 521.934f, 142.81516f, 4.729844f, 0.0f, 0.0f, -0.70090866f, 0.71325105f }, /* 66 */
    { -8884.038f, 577.46356f, 136.07404f, 3.7001047f, 0.0f, 0.0f, -0.9612608f, 0.2756405f }, /* 67 */
    { -8945.109f, 496.37152f, 137.19191f, 6.073746f, 0.0f, 0.0f, -0.10452843f, 0.9945219f }, /* 68 */
    { -8976.0625f, 535.05035f, 164.378f, 4.66003f, 0.0f, 0.0f, -0.7253742f, 0.68835473f }, /* 69 */
    { -8961.319f, 533.3333f, 146.44656f, 2.1991146f, 0.0f, 0.0f, 0.89100647f, 0.45399064f }, /* 70 */
    { -8887.359f, 568.7083f, 151.4847f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 71 */
    { -8968.125f, 525.1285f, 165.83981f, 3.0543265f, 0.0f, 0.0f, 0.99904823f, 0.04361926f }, /* 72 */
    { -8937.114f, 486.76736f, 164.73012f, 2.1118479f, 0.0f, 0.0f, 0.8703556f, 0.4924237f }, /* 73 */
    { -8954.139f, 507.56946f, 164.82593f, 2.5481794f, 0.0f, 0.0f, 0.95630455f, 0.29237235f }, /* 74 */
    { -8937.466f, 517.05206f, 154.47032f, 3.6826503f, 0.0f, 0.0f, -0.9636297f, 0.267241f }, /* 75 */
    { -8986.255f, 548.2847f, 163.08516f, 5.550147f, 0.0f, 0.0f, -0.35836792f, 0.93358046f }, /* 76 */
    { -8887.359f, 568.7083f, 135.24858f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 77 */
    { -8976.716f, 545.92883f, 143.35352f, 5.550147f, 0.0f, 0.0f, -0.35836792f, 0.93358046f }, /* 78 */
    { -8888.514f, 573.9601f, 141.96341f, 4.7647495f, 0.0f, 0.0f, -0.6883545f, 0.72537446f }, /* 79 */
    { -8976.0625f, 535.05035f, 162.03773f, 4.66003f, 0.0f, 0.0f, -0.7253742f, 0.68835473f }, /* 80 */
    { -8961.319f, 533.3333f, 149.00906f, 2.1991146f, 0.0f, 0.0f, 0.89100647f, 0.45399064f }, /* 81 */
    { -8877.643f, 588.6059f, 138.78757f, 0.13962449f, 0.0f, 0.0f, 0.069755554f, 0.99756414f }, /* 82 */
    { -8937.114f, 486.76736f, 169.5565f, 2.1118479f, 0.0f, 0.0f, 0.8703556f, 0.4924237f }, /* 83 */
    { -8945.109f, 496.37152f, 142.5808f, 6.073746f, 0.0f, 0.0f, -0.10452843f, 0.9945219f }, /* 84 */
    { -8943.316f, 516.0191f, 163.42262f, 5.8468537f, 0.0f, 0.0f, -0.21643925f, 0.97629607f }, /* 85 */
    { -8888.514f, 573.9601f, 149.99118f, 4.7647495f, 0.0f, 0.0f, -0.6883545f, 0.72537446f }, /* 86 */
    { -8957.122f, 517.7014f, 145.23196f, 3.6302915f, 0.0f, 0.0f, -0.97029495f, 0.241925f }, /* 87 */
    { -8954.139f, 507.56946f, 162.77037f, 2.5481794f, 0.0f, 0.0f, 0.95630455f, 0.29237235f }, /* 88 */
    { -8964.986f, 535.21356f, 153.71568f, 4.886924f, 0.0f, 0.0f, -0.642787f, 0.766045f }, /* 89 */
    { -8957.122f, 517.7014f, 141.91252f, 3.6302915f, 0.0f, 0.0f, -0.97029495f, 0.241925f }, /* 90 */
    { -8888.192f, 584.4792f, 138.64586f, 0.9773831f, 0.0f, 0.0f, 0.46947098f, 0.8829479f }, /* 91 */
    { -8888.192f, 584.4792f, 144.4653f, 0.9773831f, 0.0f, 0.0f, 0.46947098f, 0.8829479f }, /* 92 */
    { -8888.192f, 584.4792f, 150.57642f, 0.9773831f, 0.0f, 0.0f, 0.46947098f, 0.8829479f }, /* 93 */
    { -8961.319f, 533.3333f, 154.17574f, 2.1991146f, 0.0f, 0.0f, 0.89100647f, 0.45399064f }, /* 94 */
    { -8877.643f, 588.6059f, 135.17647f, 0.13962449f, 0.0f, 0.0f, 0.069755554f, 0.99756414f }, /* 95 */
    { -8964.986f, 535.21356f, 147.34068f, 4.886924f, 0.0f, 0.0f, -0.642787f, 0.766045f }, /* 96 */
    { -8943.316f, 516.0191f, 139.85316f, 5.8468537f, 0.0f, 0.0f, -0.21643925f, 0.97629607f }, /* 97 */
    { -8877.406f, 577.82294f, 136.93324f, 3.47321f, 0.0f, 0.0f, -0.9862852f, 0.1650499f }, /* 98 */
    { -8884.038f, 577.46356f, 135.34486f, 3.7001047f, 0.0f, 0.0f, -0.9612608f, 0.2756405f }, /* 99 */
    { -8877.643f, 588.6059f, 133.33618f, 0.13962449f, 0.0f, 0.0f, 0.069755554f, 0.99756414f }, /* 100 */
    { -8943.316f, 516.0191f, 177.3115f, 5.8468537f, 0.0f, 0.0f, -0.21643925f, 0.97629607f }, /* 101 */
    { -8887.359f, 568.7083f, 136.9222f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 102 */
    { -8884.038f, 577.46356f, 135.92125f, 3.7001047f, 0.0f, 0.0f, -0.9612608f, 0.2756405f }, /* 103 */
    { -8877.406f, 577.82294f, 132.65547f, 3.47321f, 0.0f, 0.0f, -0.9862852f, 0.1650499f }, /* 104 */
    { -8925.567f, 542.2158f, 116.16192f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 105 */
};

typedef std::vector<std::array<uint32, 3>> const FireworkShow;

// VerifiedBuild 50250
// timestamp[ms], firework gameobject ID, fireworkSpawnPositionIndex
FireworkShow fireworkShowTeldrassil =
{
    { 0, GO_FIREWORK_SHOW_TYPE_1_BLUE, 0 },
    { 2018, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 1 },
    { 3628, GO_FIREWORK_SHOW_TYPE_2_GREEN, 2 },
    { 3628, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 3 },
    { 6886, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 4 },
    { 6886, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 5 },
    { 8230, GO_FIREWORK_SHOW_TYPE_1_RED, 6 },
    { 10130, GO_FIREWORK_SHOW_TYPE_2_GREEN, 7 },
    { 10130, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 8 },
    { 11747, GO_FIREWORK_SHOW_TYPE_1_RED, 9 },
    { 11747, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 10 },
    { 11747, GO_FIREWORK_SHOW_TYPE_2_GREEN, 11 },
    { 13364, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 12 },
    { 14568, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 13 },
    { 14568, GO_FIREWORK_SHOW_TYPE_2_RED, 14 },
    { 14568, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 15 },
    { 14568, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 16 },
    { 14568, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 17 },
    { 16605, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 18 },
    { 16605, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 19 },
    { 16605, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 20 },
    { 18235, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 3 },
    { 18235, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 21 },
    { 18235, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 22 },
    { 19451, GO_FIREWORK_SHOW_TYPE_2_GREEN, 23 },
    { 21207, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 24 },
    { 21207, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 25 },
    { 23111, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 26 },
    { 23111, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 27 },
    { 23111, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 28 },
    { 24312, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 7 },
    { 26350, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 29 },
    { 27957, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 30 },
    { 27957, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 6 },
    { 27957, GO_FIREWORK_SHOW_TYPE_1_BLUE, 2 },
    { 29177, GO_FIREWORK_SHOW_TYPE_1_GREEN, 31 },
    { 29177, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 32 },
    { 29177, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 1 },
    { 30792, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 33 },
    { 32414, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 34 },
    { 32414, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 35 },
    { 34423, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 10 },
    { 34423, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 36 },
    { 34423, GO_FIREWORK_SHOW_TYPE_2_BLUE, 37 },
    { 34423, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 38 },
    { 34423, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 11 },
    { 34423, GO_FIREWORK_SHOW_TYPE_2_BLUE, 39 },
    { 36054, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 19 },
    { 37274, GO_FIREWORK_SHOW_TYPE_2_BLUE, 4 },
    { 37274, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 40 },
    { 37274, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 15 },
    { 39304, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 41 },
    { 39304, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 13 },
    { 39304, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 9 },
    { 40928, GO_FIREWORK_SHOW_TYPE_1_WHITE, 20 },
    { 40928, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 5 },
    { 40928, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 12 },
    { 40928, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 24 },
    { 42555, GO_FIREWORK_SHOW_TYPE_2_WHITE, 42 },
    { 44169, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 0 },
    { 45788, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 43 },
    { 45788, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 16 },
    { 45788, GO_FIREWORK_SHOW_TYPE_2_WHITE, 18 },
    { 45788, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 44 },
    { 47434, GO_FIREWORK_SHOW_TYPE_1_RED, 14 },
    { 49044, GO_FIREWORK_SHOW_TYPE_1_BLUE, 7 },
    { 49044, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 2 },
    { 50361, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 45 },
    { 50361, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 8 },
    { 50361, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 46 },
    { 51886, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 28 },
    { 51886, GO_FIREWORK_SHOW_TYPE_2_BLUE, 39 },
    { 51886, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 33 },
    { 53900, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 27 },
    { 55405, GO_FIREWORK_SHOW_TYPE_2_WHITE, 42 },
    { 55405, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 31 },
    { 55405, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 47 },
    { 55405, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 6 },
    { 56745, GO_FIREWORK_SHOW_TYPE_1_WHITE, 25 },
    { 56745, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 40 },
    { 60406, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 36 },
    { 60406, GO_FIREWORK_SHOW_TYPE_1_RED, 35 },
    { 60406, GO_FIREWORK_SHOW_TYPE_2_BLUE, 48 },
    { 60406, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 49 },
    { 60406, GO_FIREWORK_SHOW_TYPE_2_BLUE, 50 },
    { 61616, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 4 },
    { 61616, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 29 },
    { 63652, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 21 },
    { 65286, GO_FIREWORK_SHOW_TYPE_2_BLUE, 24 },
    { 65286, GO_FIREWORK_SHOW_TYPE_2_GREEN, 37 },
    { 68519, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 51 },
    { 68519, GO_FIREWORK_SHOW_TYPE_1_WHITE, 12 },
    { 71340, GO_FIREWORK_SHOW_TYPE_2_RED, 44 },
    { 71340, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 32 },
    { 71340, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 34 },
    { 73377, GO_FIREWORK_SHOW_TYPE_2_RED, 52 },
    { 74988, GO_FIREWORK_SHOW_TYPE_2_RED, 36 },
    { 76192, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 11 },
    { 76192, GO_FIREWORK_SHOW_TYPE_1_GREEN, 0 },
    { 76192, GO_FIREWORK_SHOW_TYPE_2_RED, 19 },
    { 76192, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 18 },
    { 76192, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 53 },
    { 78221, GO_FIREWORK_SHOW_TYPE_1_BLUE, 54 },
    { 78221, GO_FIREWORK_SHOW_TYPE_2_RED, 9 },
    { 78221, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 30 },
    { 78221, GO_FIREWORK_SHOW_TYPE_2_WHITE, 43 },
    { 79438, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 26 },
    { 81462, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 45 },
    { 81462, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 27 },
    { 81462, GO_FIREWORK_SHOW_TYPE_2_GREEN, 24 },
    { 83084, GO_FIREWORK_SHOW_TYPE_2_RED, 28 },
    { 84297, GO_FIREWORK_SHOW_TYPE_1_WHITE, 3 },
    { 84297, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 1 },
    { 84297, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 22 },
    { 86347, GO_FIREWORK_SHOW_TYPE_1_GREEN, 37 },
    { 87975, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 17 },
    { 87975, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 15 },
    { 87975, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 33 },
    { 87975, GO_FIREWORK_SHOW_TYPE_1_WHITE, 13 },
    { 89174, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 10 },
    { 89174, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 55 },
    { 89174, GO_FIREWORK_SHOW_TYPE_1_RED, 35 },
    { 89174, GO_FIREWORK_SHOW_TYPE_1_BLUE, 23 },
    { 89174, GO_FIREWORK_SHOW_TYPE_2_GREEN, 48 },
    { 89174, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 6 },
    { 91204, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 25 },
    { 91204, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 12 },
    { 91204, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 29 },
    { 92831, GO_FIREWORK_SHOW_TYPE_1_GREEN, 54 },
    { 92831, GO_FIREWORK_SHOW_TYPE_1_RED, 44 },
    { 94045, GO_FIREWORK_SHOW_TYPE_2_RED, 22 },
    { 94045, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 41 },
    { 94045, GO_FIREWORK_SHOW_TYPE_1_GREEN, 31 },
    { 96064, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 24 },
    { 98914, GO_FIREWORK_SHOW_TYPE_2_BLUE, 50 },
    { 98914, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 38 },
    { 98914, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 11 },
    { 98914, GO_FIREWORK_SHOW_TYPE_2_BLUE, 7 },
    { 100690, GO_FIREWORK_SHOW_TYPE_1_WHITE, 21 },
    { 100690, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 34 },
    { 102548, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 42 },
    { 102548, GO_FIREWORK_SHOW_TYPE_1_BLUE, 0 },
    { 102548, GO_FIREWORK_SHOW_TYPE_1_WHITE, 32 },
    { 102548, GO_FIREWORK_SHOW_TYPE_1_RED, 47 },
    { 102548, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 26 },
    { 103771, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 49 },
    { 103771, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 40 },
    { 103771, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 33 },
    { 105657, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 14 },
    { 105657, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 10 },
    { 105657, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 51 },
    { 107404, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 18 },
    { 108624, GO_FIREWORK_SHOW_TYPE_2_RED, 56 },
    { 108624, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 45 },
    { 110651, GO_FIREWORK_SHOW_TYPE_1_RED, 28 },
    { 110651, GO_FIREWORK_SHOW_TYPE_1_RED, 52 },
    { 112278, GO_FIREWORK_SHOW_TYPE_1_WHITE, 3 },
    { 113480, GO_FIREWORK_SHOW_TYPE_2_RED, 22 },
    { 113480, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 12 },
    { 113480, GO_FIREWORK_SHOW_TYPE_1_RED, 36 },
    { 115512, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 53 },
    { 117137, GO_FIREWORK_SHOW_TYPE_1_WHITE, 43 },
    { 118348, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 44 },
    { 118348, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 20 },
    { 120386, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 29 },
    { 120386, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 38 },
    { 120386, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 17 },
    { 120386, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 41 },
    { 120386, GO_FIREWORK_SHOW_TYPE_1_GREEN, 39 },
    { 122001, GO_FIREWORK_SHOW_TYPE_2_GREEN, 54 },
    { 122001, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 5 },
    { 122001, GO_FIREWORK_SHOW_TYPE_2_BLUE, 55 },
    { 122001, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 23 },
    { 123218, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 35 },
    { 123218, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 32 },
    { 125246, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 4 },
    { 128081, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 40 },
    { 130093, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 28 },
    { 132940, GO_FIREWORK_SHOW_TYPE_2_RED, 56 },
    { 132940, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 46 },
    { 134994, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 19 },
    { 134994, GO_FIREWORK_SHOW_TYPE_2_WHITE, 13 },
    { 134994, GO_FIREWORK_SHOW_TYPE_1_BLUE, 7 },
    { 134994, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 52 },
    { 136601, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 1 },
    { 137822, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 27 },
    { 137822, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 51 },
    { 137822, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 43 },
    { 139847, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 44 },
    { 141472, GO_FIREWORK_SHOW_TYPE_1_WHITE, 45 },
    { 141472, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 29 },
    { 142684, GO_FIREWORK_SHOW_TYPE_1_BLUE, 48 },
    { 142684, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 42 },
    { 142684, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 4 },
    { 147557, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 32 },
    { 147557, GO_FIREWORK_SHOW_TYPE_1_WHITE, 18 },
    { 149579, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 34 },
    { 149579, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 22 },
    { 149579, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 14 },
    { 149579, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 26 },
    { 151211, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 36 },
    { 151211, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 15 },
    { 151211, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 24 },
    { 151211, GO_FIREWORK_SHOW_TYPE_1_WHITE, 16 },
    { 152403, GO_FIREWORK_SHOW_TYPE_1_RED, 28 },
    { 154454, GO_FIREWORK_SHOW_TYPE_1_WHITE, 20 },
    { 154454, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 12 },
    { 154454, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 37 },
    { 156081, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 47 },
    { 156081, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 2 },
    { 156081, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 10 },
    { 157284, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 35 },
    { 157284, GO_FIREWORK_SHOW_TYPE_2_BLUE, 38 },
    { 159306, GO_FIREWORK_SHOW_TYPE_1_GREEN, 7 },
    { 159306, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 8 },
    { 160927, GO_FIREWORK_SHOW_TYPE_1_BLUE, 40 },
    { 160927, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 1 },
    { 162153, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 34 },
    { 162153, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 49 },
    { 162153, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 52 },
    { 162153, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 22 },
    { 162153, GO_FIREWORK_SHOW_TYPE_1_GREEN, 11 },
    { 162153, GO_FIREWORK_SHOW_TYPE_1_RED, 53 },
    { 164200, GO_FIREWORK_SHOW_TYPE_1_BLUE, 27 },
    { 164200, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 56 },
    { 165829, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 13 },
    { 165829, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 6 },
    { 167041, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 39 },
    { 167041, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 55 },
    { 167041, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 42 },
    { 169066, GO_FIREWORK_SHOW_TYPE_1_WHITE, 45 },
    { 169066, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 47 },
    { 169066, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 3 },
    { 169066, GO_FIREWORK_SHOW_TYPE_2_GREEN, 30 },
    { 170682, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 14 },
    { 170682, GO_FIREWORK_SHOW_TYPE_1_BLUE, 0 },
    { 171894, GO_FIREWORK_SHOW_TYPE_2_GREEN, 24 },
    { 171894, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 33 },
    { 175539, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 51 },
    { 175539, GO_FIREWORK_SHOW_TYPE_2_WHITE, 25 },
    { 175539, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 20 },
    { 175539, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 37 },
    { 175539, GO_FIREWORK_SHOW_TYPE_2_BLUE, 23 },
    { 175539, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 44 },
    { 176752, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 36 },
    { 176752, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 46 },
    { 178788, GO_FIREWORK_SHOW_TYPE_2_RED, 1 },
    { 178788, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 7 },
    { 178788, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 18 },
    { 180403, GO_FIREWORK_SHOW_TYPE_1_RED, 35 },
    { 180403, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 40 },
    { 180403, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 19 },
    { 180403, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 26 },
    { 181627, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 2 },
    { 181627, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 28 },
    { 183662, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 48 },
    { 183662, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 4 },
    { 183662, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 21 },
    { 183662, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 9 },
    { 183662, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 29 },
    { 183662, GO_FIREWORK_SHOW_TYPE_2_GREEN, 31 },
    { 185293, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 10 },
    { 185293, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 11 },
    { 185293, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 17 },
    { 185293, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 5 },
    { 186508, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 12 },
    { 186508, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 50 },
    { 186508, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 38 },
    { 188548, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 27 },
    { 188548, GO_FIREWORK_SHOW_TYPE_1_WHITE, 43 },
    { 190171, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 15 },
    { 191396, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 22 },
    { 191396, GO_FIREWORK_SHOW_TYPE_1_BLUE, 23 },
    { 193412, GO_FIREWORK_SHOW_TYPE_1_RED, 36 },
    { 193412, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 47 },
    { 195038, GO_FIREWORK_SHOW_TYPE_2_BLUE, 24 },
    { 195038, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 49 },
    { 195038, GO_FIREWORK_SHOW_TYPE_1_BLUE, 8 },
    { 196258, GO_FIREWORK_SHOW_TYPE_1_WHITE, 13 },
    { 196258, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 14 },
    { 196258, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 53 },
    { 198296, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 19 },
    { 198296, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 33 },
    { 198296, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 30 },
    { 198296, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 20 },
    { 199912, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 52 },
    { 199912, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 0 },
    { 199912, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 5 },
    { 203166, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 18 },
    { 204788, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 44 },
    { 204788, GO_FIREWORK_SHOW_TYPE_2_RED, 1 },
    { 204788, GO_FIREWORK_SHOW_TYPE_1_WHITE, 51 },
    { 206010, GO_FIREWORK_SHOW_TYPE_2_BLUE, 27 },
    { 206010, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 46 },
    { 208033, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 32 },
    { 208033, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 9 },
    { 209659, GO_FIREWORK_SHOW_TYPE_2_BLUE, 50 },
    { 209659, GO_FIREWORK_SHOW_TYPE_2_RED, 47 },
    { 209659, GO_FIREWORK_SHOW_TYPE_2_RED, 29 },
    { 209659, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 55 },
    { 210870, GO_FIREWORK_SHOW_TYPE_2_GREEN, 4 },
    { 210870, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 11 },
    { 210870, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 37 },
    { 212881, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 22 },
    { 212881, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 12 },
    { 214508, GO_FIREWORK_SHOW_TYPE_1_BLUE, 48 },
    { 214508, GO_FIREWORK_SHOW_TYPE_2_GREEN, 7 },
    { 215719, GO_FIREWORK_SHOW_TYPE_2_GREEN, 2 },
    { 215719, GO_FIREWORK_SHOW_TYPE_2_BLUE, 23 },
    { 215719, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 8 },
    { 215719, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 17 },
    { 215719, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 25 },
    { 217759, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 36 },
    { 217759, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 10 },
    { 217759, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 19 },
    { 219127, GO_FIREWORK_SHOW_TYPE_2_RED, 52 },
    { 219127, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 56 },
    { 220596, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 53 },
    { 220596, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 18 },
    { 224241, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 42 },
    { 224241, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 0 },
    { 224241, GO_FIREWORK_SHOW_TYPE_1_WHITE, 34 },
    { 224241, GO_FIREWORK_SHOW_TYPE_2_BLUE, 40 },
    { 225465, GO_FIREWORK_SHOW_TYPE_2_RED, 29 },
    { 225465, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 5 },
    { 227519, GO_FIREWORK_SHOW_TYPE_2_WHITE, 3 },
    { 227519, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 26 },
    { 229123, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 12 },
    { 229123, GO_FIREWORK_SHOW_TYPE_1_BLUE, 30 },
    { 229123, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 24 },
    { 229123, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 1 },
    { 229123, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 6 },
    { 230332, GO_FIREWORK_SHOW_TYPE_1_RED, 28 },
    { 233994, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 46 },
    { 233994, GO_FIREWORK_SHOW_TYPE_2_WHITE, 25 },
    { 235193, GO_FIREWORK_SHOW_TYPE_2_RED, 56 },
    { 235193, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 10 },
    { 235193, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 23 },
    { 235193, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 38 },
    { 237223, GO_FIREWORK_SHOW_TYPE_2_BLUE, 11 },
    { 237223, GO_FIREWORK_SHOW_TYPE_2_WHITE, 51 },
    { 237223, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 35 },
    { 237223, GO_FIREWORK_SHOW_TYPE_2_GREEN, 54 },
    { 237223, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 55 },
    { 237223, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 31 },
    { 237223, GO_FIREWORK_SHOW_TYPE_2_WHITE, 45 },
    { 238697, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 48 },
    { 238697, GO_FIREWORK_SHOW_TYPE_1_GREEN, 50 },
    { 238697, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 44 },
    { 238697, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 19 },
    { 240048, GO_FIREWORK_SHOW_TYPE_1_BLUE, 4 },
    { 240048, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 52 },
    { 240048, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 13 },
    { 242070, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 39 },
    { 243703, GO_FIREWORK_SHOW_TYPE_2_WHITE, 43 },
    { 246950, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 49 },
    { 248570, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 37 },
    { 248570, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 18 },
    { 248570, GO_FIREWORK_SHOW_TYPE_1_GREEN, 31 },
    { 248570, GO_FIREWORK_SHOW_TYPE_1_GREEN, 38 },
    { 248570, GO_FIREWORK_SHOW_TYPE_1_GREEN, 38 },
    { 249782, GO_FIREWORK_SHOW_TYPE_2_BLUE, 24 },
    { 249782, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 9 },
    { 249782, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 9 },
    { 251823, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 26 },
    { 251823, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 5 },
    { 253446, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 47 },
    { 253446, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 47 },
    { 254668, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 17 },
    { 254668, GO_FIREWORK_SHOW_TYPE_2_GREEN, 50 },
    { 254668, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 56 },
    { 256709, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 43 },
    { 256709, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 34 },
    { 258330, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 42 },
    { 258330, GO_FIREWORK_SHOW_TYPE_1_RED, 36 },
    { 258330, GO_FIREWORK_SHOW_TYPE_1_RED, 36 },
    { 259548, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 22 },
    { 259548, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 51 },
    { 259548, GO_FIREWORK_SHOW_TYPE_1_GREEN, 7 },
    { 261567, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 6 },
    { 263188, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 11 },
    { 263188, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 33 },
    { 263188, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 2 },
    { 264412, GO_FIREWORK_SHOW_TYPE_1_WHITE, 12 },
    { 264412, GO_FIREWORK_SHOW_TYPE_2_BLUE, 48 },
    { 264412, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 38 },
    { 264412, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 40 },
    { 264412, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 35 },
    { 266449, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 53 },
    { 266449, GO_FIREWORK_SHOW_TYPE_1_WHITE, 18 },
    { 268063, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 32 },
    { 268063, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 27 },
    { 268063, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 16 },
    { 269294, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 26 },
    { 269294, GO_FIREWORK_SHOW_TYPE_2_BLUE, 39 },
    { 269294, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 45 },
    { 269294, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 13 },
    { 269294, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 47 },
    { 269294, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 21 },
    { 271312, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 54 },
    { 271312, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 49 },
    { 272952, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 17 },
    { 274171, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 3 },
    { 276200, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 8 },
    { 277824, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 56 },
    { 281070, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 32 },
    { 282702, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 10 },
    { 282702, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 20 },
    { 282702, GO_FIREWORK_SHOW_TYPE_2_RED, 29 },
    { 282702, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 25 },
    { 282702, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 0 },
    { 283915, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 1 },
    { 283915, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 52 },
    { 283915, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 40 },
    { 285956, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 35 },
    { 287580, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 45 },
    { 287580, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 21 },
    { 287580, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 34 },
    { 288793, GO_FIREWORK_SHOW_TYPE_2_WHITE, 13 },
    { 288793, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 17 },
    { 290814, GO_FIREWORK_SHOW_TYPE_1_RED, 47 },
    { 290814, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 42 },
    { 290814, GO_FIREWORK_SHOW_TYPE_2_GREEN, 4 },
    { 290814, GO_FIREWORK_SHOW_TYPE_1_WHITE, 18 },
    { 292437, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 22 },
    { 292437, GO_FIREWORK_SHOW_TYPE_1_RED, 46 },
    { 292437, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 30 },
    { 292437, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 44 },
    { 292437, GO_FIREWORK_SHOW_TYPE_2_RED, 36 },
    { 293664, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 28 },
    { 293664, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 38 },
    { 295698, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 43 },
    { 295698, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 25 },
    { 295698, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 26 },
    { 297335, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 11 },
    { 298959, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 50 },
    { 300575, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 7 },
    { 302197, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 15 },
    { 302197, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 19 },
    { 302197, GO_FIREWORK_SHOW_TYPE_1_WHITE, 16 },
    { 303406, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 51 },
    { 303406, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 45 },
    { 303406, GO_FIREWORK_SHOW_TYPE_2_RED, 6 },
    { 303406, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 12 },
    { 307078, GO_FIREWORK_SHOW_TYPE_1_BLUE, 31 },
    { 307078, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 29 },
    { 307078, GO_FIREWORK_SHOW_TYPE_1_GREEN, 0 },
    { 307078, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 27 },
    { 310330, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 49 },
    { 310330, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 3 },
    { 310330, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 40 },
    { 311949, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 56 },
    { 313160, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 8 },
    { 313160, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 41 },
    { 316800, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 22 },
    { 318014, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 20 },
    { 320032, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 35 },
    { 321252, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 16 },
    { 321252, GO_FIREWORK_SHOW_TYPE_1_RED, 26 },
    { 323285, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 10 },
    { 324504, GO_FIREWORK_SHOW_TYPE_2_RED, 14 },
    { 324504, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 7 },
    { 324504, GO_FIREWORK_SHOW_TYPE_2_BLUE, 39 },
    { 326128, GO_FIREWORK_SHOW_TYPE_2_RED, 9 },
    { 326128, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 30 },
    { 326128, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 33 },
    { 328158, GO_FIREWORK_SHOW_TYPE_1_BLUE, 37 },
    { 328158, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 3 },
    { 328158, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 38 },
    { 328158, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 18 },
    { 328158, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 46 },
    { 329764, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 5 },
    { 329764, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 12 },
    { 329764, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 56 },
    { 329764, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 44 },
    { 334646, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 49 },
    { 334646, GO_FIREWORK_SHOW_TYPE_2_RED, 29 },
    { 334646, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 22 },
    { 335857, GO_FIREWORK_SHOW_TYPE_1_WHITE, 43 },
    { 335857, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 31 },
    { 335857, GO_FIREWORK_SHOW_TYPE_1_BLUE, 0 },
    { 335857, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 11 },
    { 337880, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 20 },
    { 337880, GO_FIREWORK_SHOW_TYPE_1_BLUE, 2 },
    { 337880, GO_FIREWORK_SHOW_TYPE_2_BLUE, 4 },
    { 337880, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 41 },
    { 340713, GO_FIREWORK_SHOW_TYPE_1_RED, 53 },
    { 340713, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 15 },
    { 340713, GO_FIREWORK_SHOW_TYPE_1_GREEN, 24 },
    { 342745, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 45 },
    { 342745, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 25 },
    { 344378, GO_FIREWORK_SHOW_TYPE_1_WHITE, 3 },
    { 345600, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 46 },
    { 345600, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 14 },
    { 345600, GO_FIREWORK_SHOW_TYPE_1_BLUE, 8 },
    { 347617, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 23 },
    { 347617, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 21 },
    { 349233, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 30 },
    { 349233, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 52 },
    { 349233, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 19 },
    { 349233, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 35 },
    { 350456, GO_FIREWORK_SHOW_TYPE_1_BLUE, 7 },
    { 352495, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 55 },
    { 352495, GO_FIREWORK_SHOW_TYPE_2_WHITE, 32 },
    { 352495, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 1 },
    { 354119, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 26 },
    { 354119, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 42 },
    { 355343, GO_FIREWORK_SHOW_TYPE_2_BLUE, 37 },
    { 355343, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 40 },
    { 355343, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 51 },
    { 357366, GO_FIREWORK_SHOW_TYPE_1_WHITE, 49 },
    { 357366, GO_FIREWORK_SHOW_TYPE_2_GREEN, 54 },
    { 357366, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 15 },
    { 357366, GO_FIREWORK_SHOW_TYPE_1_RED, 22 },
    { 357366, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 56 },
    { 358993, GO_FIREWORK_SHOW_TYPE_2_RED, 33 },
    { 360204, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 41 },
    { 362238, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 6 },
    { 362238, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 3 },
    { 363853, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 45 },
    { 363853, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 16 },
    { 363853, GO_FIREWORK_SHOW_TYPE_2_GREEN, 30 },
    { 363853, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 39 },
    { 363853, GO_FIREWORK_SHOW_TYPE_2_GREEN, 2 },
    { 365083, GO_FIREWORK_SHOW_TYPE_2_BLUE, 50 },
    { 365083, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 13 },
    { 367114, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 20 },
    { 367114, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 12 },
    { 368732, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 29 },
    { 369952, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 38 },
    { 371977, GO_FIREWORK_SHOW_TYPE_1_BLUE, 40 },
    { 371977, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 14 },
    { 371977, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 8 },
    { 371977, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 46 },
    { 371977, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 24 },
    { 373587, GO_FIREWORK_SHOW_TYPE_2_RED, 52 },
    { 373587, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 10 },
    { 374798, GO_FIREWORK_SHOW_TYPE_2_BLUE, 4 },
    { 374798, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 51 },
    { 374798, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 44 },
    { 376835, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 49 },
    { 376835, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 42 },
    { 378460, GO_FIREWORK_SHOW_TYPE_1_BLUE, 55 },
    { 378460, GO_FIREWORK_SHOW_TYPE_2_RED, 1 },
    { 379681, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 16 },
    { 379681, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 37 },
    { 379681, GO_FIREWORK_SHOW_TYPE_1_BLUE, 0 },
    { 379681, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 22 },
    { 379681, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 36 },
    { 381709, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 13 },
    { 388185, GO_FIREWORK_SHOW_TYPE_2_WHITE, 20 },
    { 388185, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 5 },
    { 388185, GO_FIREWORK_SHOW_TYPE_2_GREEN, 23 },
    { 389397, GO_FIREWORK_SHOW_TYPE_1_RED, 47 },
    { 389397, GO_FIREWORK_SHOW_TYPE_1_RED, 26 },
    { 391423, GO_FIREWORK_SHOW_TYPE_1_GREEN, 50 },
    { 391423, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 7 },
    { 393043, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 43 },
    { 394267, GO_FIREWORK_SHOW_TYPE_1_WHITE, 41 },
    { 394267, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 51 },
    { 397923, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 3 },
    { 397923, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 39 },
    { 397923, GO_FIREWORK_SHOW_TYPE_1_RED, 33 },
    { 397923, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 14 },
    { 397923, GO_FIREWORK_SHOW_TYPE_1_BLUE, 37 },
    { 399146, GO_FIREWORK_SHOW_TYPE_2_BLUE, 38 },
    { 399146, GO_FIREWORK_SHOW_TYPE_1_BLUE, 11 },
    { 399146, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 24 },
    { 401188, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 6 },
    { 401188, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 13 },
    { 402805, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 40 },
    { 404032, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 42 },
    { 404032, GO_FIREWORK_SHOW_TYPE_2_WHITE, 17 },
    { 404032, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 21 },
    { 404032, GO_FIREWORK_SHOW_TYPE_1_BLUE, 4 },
    { 406054, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 36 },
    { 406054, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 22 },
    { 406054, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 10 },
    { 407675, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 12 },
    { 408888, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 23 },
    { 408888, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 35 },
    { 408888, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 16 },
    { 410916, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 47 },
    { 410916, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 28 },
    { 410916, GO_FIREWORK_SHOW_TYPE_2_RED, 53 },
    { 415797, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 1 },
    { 415797, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 36 },
    { 415797, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 54 },
    { 415797, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 9 },
    { 415797, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 27 },
    { 417435, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 43 },
    { 417435, GO_FIREWORK_SHOW_TYPE_2_BLUE, 55 },
    { 417435, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 3 },
    { 417435, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 2 },
    { 417435, GO_FIREWORK_SHOW_TYPE_1_BLUE, 50 },
    { 418640, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 26 },
    { 418640, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 21 },
    { 420556, GO_FIREWORK_SHOW_TYPE_2_BLUE, 38 },
    { 420556, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 56 },
    { 420556, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 24 },
    { 420556, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 46 },
    { 422281, GO_FIREWORK_SHOW_TYPE_1_GREEN, 40 },
    { 422281, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 7 },
    { 423498, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 25 },
    { 423498, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 34 },
    { 423498, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 8 },
    { 423498, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 52 },
    { 425512, GO_FIREWORK_SHOW_TYPE_1_RED, 29 },
    { 425512, GO_FIREWORK_SHOW_TYPE_2_BLUE, 30 },
    { 425512, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 49 },
    { 425512, GO_FIREWORK_SHOW_TYPE_2_GREEN, 11 },
    { 427143, GO_FIREWORK_SHOW_TYPE_1_BLUE, 0 },
    { 428348, GO_FIREWORK_SHOW_TYPE_2_RED, 14 },
    { 428348, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 5 },
    { 428348, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 10 },
    { 428348, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 4 },
    { 430356, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 19 },
    { 432010, GO_FIREWORK_SHOW_TYPE_2_WHITE, 41 },
    { 433240, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 37 },
    { 433240, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 6 },
    { 433240, GO_FIREWORK_SHOW_TYPE_2_GREEN, 31 },
    { 433240, GO_FIREWORK_SHOW_TYPE_2_RED, 26 },
    { 435193, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 23 },
    { 435193, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 22 },
    { 436904, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 36 },
    { 436904, GO_FIREWORK_SHOW_TYPE_1_WHITE, 18 },
    { 438110, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 8 },
    { 438110, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 2 },
    { 438110, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 32 },
    { 440134, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 50 },
    { 440134, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 46 },
    { 441748, GO_FIREWORK_SHOW_TYPE_1_BLUE, 39 },
    { 441748, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 25 },
    { 441748, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 52 },
    { 442959, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 48 },
    { 442959, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 24 },
    { 444977, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 42 },
    { 444977, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 45 },
    { 444977, GO_FIREWORK_SHOW_TYPE_1_WHITE, 3 },
    { 446596, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 33 },
    { 447810, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 6 },
    { 447810, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 37 },
    { 449846, GO_FIREWORK_SHOW_TYPE_1_WHITE, 49 },
    { 449846, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 10 },
    { 451473, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 29 },
    { 451473, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 47 },
    { 451473, GO_FIREWORK_SHOW_TYPE_2_WHITE, 43 },
    { 451473, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 35 },
    { 452687, GO_FIREWORK_SHOW_TYPE_2_GREEN, 7 },
    { 452687, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 5 },
    { 454718, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 21 },
    { 454718, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 22 },
    { 456351, GO_FIREWORK_SHOW_TYPE_1_RED, 56 },
    { 456351, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 8 },
    { 457560, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 9 },
    { 459587, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 16 },
    { 459587, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 51 },
    { 459587, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 27 },
    { 459587, GO_FIREWORK_SHOW_TYPE_1_GREEN, 2 },
    { 462433, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 17 },
    { 462433, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 20 },
    { 462433, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 18 },
    { 464463, GO_FIREWORK_SHOW_TYPE_1_BLUE, 4 },
    { 464463, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 1 },
    { 464463, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 45 },
    { 466092, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 42 },
    { 466092, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 19 },
    { 466092, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 35 },
    { 467307, GO_FIREWORK_SHOW_TYPE_2_RED, 44 },
    { 469333, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 41 },
    { 469333, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 34 },
    { 470945, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 54 },
    { 470945, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 50 },
    { 472170, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 13 },
    { 472170, GO_FIREWORK_SHOW_TYPE_1_GREEN, 0 },
    { 475833, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 48 },
    { 475833, GO_FIREWORK_SHOW_TYPE_1_WHITE, 20 },
    { 477057, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 31 },
    { 477057, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 22 },
    { 477057, GO_FIREWORK_SHOW_TYPE_2_WHITE, 21 },
    { 477057, GO_FIREWORK_SHOW_TYPE_2_RED, 33 },
    { 477057, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 24 },
    { 479089, GO_FIREWORK_SHOW_TYPE_1_BLUE, 39 },
    { 479089, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 26 },
    { 479089, GO_FIREWORK_SHOW_TYPE_2_BLUE, 7 },
    { 480713, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 55 },
    { 480713, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 10 },
    { 481936, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 43 },
    { 481936, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 15 },
    { 481936, GO_FIREWORK_SHOW_TYPE_2_WHITE, 12 },
    { 481936, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 4 },
    { 483977, GO_FIREWORK_SHOW_TYPE_2_RED, 1 },
    { 485604, GO_FIREWORK_SHOW_TYPE_1_WHITE, 32 },
    { 485604, GO_FIREWORK_SHOW_TYPE_1_WHITE, 34 },
    { 486819, GO_FIREWORK_SHOW_TYPE_1_BLUE, 11 },
    { 486819, GO_FIREWORK_SHOW_TYPE_1_RED, 6 },
    { 488837, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 45 },
    { 488837, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 47 },
    { 490454, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 3 },
    { 490454, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 16 },
    { 490454, GO_FIREWORK_SHOW_TYPE_2_BLUE, 40 },
    { 491674, GO_FIREWORK_SHOW_TYPE_2_BLUE, 8 },
    { 491674, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 14 },
    { 493704, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 19 },
    { 493704, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 28 },
    { 495335, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 29 },
    { 496546, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 5 },
    { 496546, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 37 },
    { 498568, GO_FIREWORK_SHOW_TYPE_2_GREEN, 27 },
    { 498568, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 22 },
    { 498568, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 43 },
    { 500196, GO_FIREWORK_SHOW_TYPE_1_BLUE, 38 },
    { 500196, GO_FIREWORK_SHOW_TYPE_1_RED, 9 },
    { 500196, GO_FIREWORK_SHOW_TYPE_2_GREEN, 0 },
    { 501409, GO_FIREWORK_SHOW_TYPE_2_WHITE, 32 },
    { 501409, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 54 },
    { 501409, GO_FIREWORK_SHOW_TYPE_2_RED, 36 },
    { 501409, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 51 },
    { 503433, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 56 },
    { 503433, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 13 },
    { 503433, GO_FIREWORK_SHOW_TYPE_2_GREEN, 2 },
    { 505061, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 16 },
    { 505061, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 49 },
    { 505061, GO_FIREWORK_SHOW_TYPE_1_RED, 35 },
    { 505061, GO_FIREWORK_SHOW_TYPE_1_WHITE, 12 },
    { 506272, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 10 },
    { 506272, GO_FIREWORK_SHOW_TYPE_1_RED, 19 },
    { 506272, GO_FIREWORK_SHOW_TYPE_2_RED, 52 },
    { 508313, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 48 },
    { 508313, GO_FIREWORK_SHOW_TYPE_2_GREEN, 50 },
    { 509931, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 41 },
    { 511143, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 45 },
    { 511143, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 14 },
    { 511143, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 17 },
    { 511143, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 7 },
    { 511143, GO_FIREWORK_SHOW_TYPE_1_RED, 46 },
    { 513175, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 11 },
    { 513175, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 20 },
    { 513175, GO_FIREWORK_SHOW_TYPE_2_GREEN, 31 },
    { 514800, GO_FIREWORK_SHOW_TYPE_2_RED, 33 },
    { 514800, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 39 },
    { 514800, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 34 },
    { 514800, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 0 },
    { 516019, GO_FIREWORK_SHOW_TYPE_1_RED, 1 },
    { 516019, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 47 },
    { 516019, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 44 },
    { 518053, GO_FIREWORK_SHOW_TYPE_1_RED, 28 },
    { 519680, GO_FIREWORK_SHOW_TYPE_2_WHITE, 25 },
    { 520891, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 43 },
    { 522914, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 30 },
    { 522914, GO_FIREWORK_SHOW_TYPE_2_GREEN, 4 },
    { 522914, GO_FIREWORK_SHOW_TYPE_1_BLUE, 55 },
    { 522914, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 15 },
    { 522914, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 13 },
    { 524544, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 52 },
    { 524544, GO_FIREWORK_SHOW_TYPE_1_WHITE, 51 },
    { 525754, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 12 },
    { 525754, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 18 },
    { 525754, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 56 },
    { 525754, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 3 },
    { 527793, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 5 },
    { 527793, GO_FIREWORK_SHOW_TYPE_1_GREEN, 50 },
    { 527793, GO_FIREWORK_SHOW_TYPE_2_RED, 22 },
    { 527793, GO_FIREWORK_SHOW_TYPE_2_WHITE, 21 },
    { 530630, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 53 },
    { 530630, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 23 },
    { 532667, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 10 },
    { 532667, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 19 },
    { 532667, GO_FIREWORK_SHOW_TYPE_1_WHITE, 49 },
    { 532667, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 31 },
    { 532667, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 42 },
    { 534292, GO_FIREWORK_SHOW_TYPE_2_GREEN, 48 },
    { 534292, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 29 },
    { 534292, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 43 },
    { 535509, GO_FIREWORK_SHOW_TYPE_1_WHITE, 20 },
    { 537537, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 32 },
    { 539150, GO_FIREWORK_SHOW_TYPE_2_RED, 35 },
    { 539150, GO_FIREWORK_SHOW_TYPE_2_RED, 35 },
    { 540364, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 33 },
    { 544023, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 36 },
    { 544023, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 22 },
    { 545246, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 3 },
    { 547279, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 34 },
    { 547279, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 18 },
    { 547279, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 16 },
    { 548889, GO_FIREWORK_SHOW_TYPE_1_RED, 6 },
    { 548889, GO_FIREWORK_SHOW_TYPE_2_BLUE, 50 },
    { 548889, GO_FIREWORK_SHOW_TYPE_1_BLUE, 0 },
    { 548889, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 13 },
    { 550111, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 5 },
    { 552140, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 12 },
    { 552140, GO_FIREWORK_SHOW_TYPE_1_GREEN, 54 },
    { 553758, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 38 },
    { 553758, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 25 },
    { 553758, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 37 },
    { 553758, GO_FIREWORK_SHOW_TYPE_2_WHITE, 32 },
    { 554965, GO_FIREWORK_SHOW_TYPE_1_BLUE, 30 },
    { 554965, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 56 },
    { 554965, GO_FIREWORK_SHOW_TYPE_1_GREEN, 11 },
    { 554965, GO_FIREWORK_SHOW_TYPE_2_WHITE, 45 },
    { 554965, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 17 },
    { 557006, GO_FIREWORK_SHOW_TYPE_1_BLUE, 24 },
    { 558617, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 28 },
    { 558617, GO_FIREWORK_SHOW_TYPE_1_BLUE, 48 },
    { 558617, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 29 },
    { 558617, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 19 },
    { 558617, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 43 },
    { 559839, GO_FIREWORK_SHOW_TYPE_1_GREEN, 4 },
    { 559839, GO_FIREWORK_SHOW_TYPE_1_GREEN, 2 },
    { 559839, GO_FIREWORK_SHOW_TYPE_1_GREEN, 2 },
    { 561874, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 46 },
    { 561874, GO_FIREWORK_SHOW_TYPE_1_BLUE, 55 },
    { 561874, GO_FIREWORK_SHOW_TYPE_1_RED, 14 },
    { 563498, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 1 },
    { 563498, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 27 },
    { 563498, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 27 },
    { 564704, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 3 },
    { 564704, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 3 },
    { 566735, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 31 },
    { 566735, GO_FIREWORK_SHOW_TYPE_1_RED, 35 },
    { 566735, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 53 },
    { 566735, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 44 },
    { 568351, GO_FIREWORK_SHOW_TYPE_2_WHITE, 16 },
    { 568351, GO_FIREWORK_SHOW_TYPE_1_BLUE, 8 },
    { 569565, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 36 },
    { 569565, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 13 },
    { 569565, GO_FIREWORK_SHOW_TYPE_1_GREEN, 39 },
    { 571596, GO_FIREWORK_SHOW_TYPE_2_RED, 56 },
    { 571596, GO_FIREWORK_SHOW_TYPE_2_BLUE, 54 },
    { 573222, GO_FIREWORK_SHOW_TYPE_2_BLUE, 50 },
    { 574435, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 52 },
    { 574435, GO_FIREWORK_SHOW_TYPE_1_WHITE, 34 },
    { 574435, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 32 },
    { 574435, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 23 },
    { 576468, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 43 },
    { 576468, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 33 },
    { 578095, GO_FIREWORK_SHOW_TYPE_2_BLUE, 2 },
    { 578095, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 24 },
    { 578095, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 0 },
    { 578095, GO_FIREWORK_SHOW_TYPE_2_BLUE, 37 },
    { 579307, GO_FIREWORK_SHOW_TYPE_2_WHITE, 12 },
    { 579307, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 7 },
    { 579307, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 6 },
    { 582967, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 14 },
    { 582967, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 21 },
    { 584179, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 35 },
    { 584179, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 49 },
    { 584179, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 29 },
    { 587831, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 46 },
    { 589054, GO_FIREWORK_SHOW_TYPE_1_BLUE, 39 },
    { 589054, GO_FIREWORK_SHOW_TYPE_2_WHITE, 51 },
    { 589054, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 28 },
    { 589054, GO_FIREWORK_SHOW_TYPE_1_WHITE, 25 },
    { 589054, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 3 },
    { 589054, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 20 },
    { 591084, GO_FIREWORK_SHOW_TYPE_2_GREEN, 8 },
    { 591084, GO_FIREWORK_SHOW_TYPE_2_WHITE, 17 },
    { 592721, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 5 },
    { 592721, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 36 },
    { 592721, GO_FIREWORK_SHOW_TYPE_2_BLUE, 4 },
    { 593933, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 9 },
    { 595960, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 30 },
    { 597586, GO_FIREWORK_SHOW_TYPE_2_WHITE, 10 },
    { 597586, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 53 },
    { 597586, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 12 },
    { 597586, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 55 },
    { 598811, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 33 },
    { 598811, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 41 },
    { 598811, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 34 },
    { 598811, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 15 },
    { 600833, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 16 },
    { 600833, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 29 },
    { 602447, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 45 },
    { 602447, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 23 },
    { 603672, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 14 },
    { 603672, GO_FIREWORK_SHOW_TYPE_1_BLUE, 54 },
    { 603672, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 1 },
    { 603672, GO_FIREWORK_SHOW_TYPE_1_GREEN, 50 },
    { 603672, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 25 },
    { 605693, GO_FIREWORK_SHOW_TYPE_2_WHITE, 3 },
    { 605693, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 27 },
    { 605693, GO_FIREWORK_SHOW_TYPE_1_WHITE, 18 },
    { 605693, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 7 },
    { 607311, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 56 },
    { 607311, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 20 },
    { 607311, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 26 },
    { 607311, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 37 },
    { 607311, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 52 },
    { 608535, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 43 },
    { 610562, GO_FIREWORK_SHOW_TYPE_1_RED, 9 },
    { 610562, GO_FIREWORK_SHOW_TYPE_2_BLUE, 0 },
    { 612187, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 8 },
    { 612187, GO_FIREWORK_SHOW_TYPE_1_BLUE, 40 },
    { 612187, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 49 },
    { 613403, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 15 },
    { 613403, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 44 },
    { 615434, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 21 },
    { 615434, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 16 },
    { 617050, GO_FIREWORK_SHOW_TYPE_2_WHITE, 25 },
    { 617050, GO_FIREWORK_SHOW_TYPE_2_WHITE, 12 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 23 },
    { 617050, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 47 },
    { 617050, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 46 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 1 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 5 },
    { 617050, GO_FIREWORK_SHOW_TYPE_2_RED, 28 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_WHITE, 18 },
    { 617050, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 27 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_BLUE, 24 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 6 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 29 },
    { 617050, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 45 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 17 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 32 },
    { 617050, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 11 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 13 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_GREEN, 38 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_GREEN, 30 },
    { 617050, GO_FIREWORK_SHOW_TYPE_2_GREEN, 54 },
    { 617050, GO_FIREWORK_SHOW_TYPE_2_GREEN, 7 },
    { 617050, GO_FIREWORK_SHOW_TYPE_1_RED, 19 },
    { 618274, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 42 },
    { 618274, GO_FIREWORK_SHOW_TYPE_2_WHITE, 3 },
    { 618274, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 50 },
    { 618274, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 2 },
    { 618274, GO_FIREWORK_SHOW_TYPE_1_BLUE, 39 },
    { 618274, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 14 },
    { 618274, GO_FIREWORK_SHOW_TYPE_2_BLUE, 55 },
    { 618274, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 34 },
    { 618274, GO_FIREWORK_SHOW_TYPE_1_RED, 36 },
    { 620301, GO_FIREWORK_SHOW_TYPE_1_WHITE, 20 },
    { 620301, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 10 },
    { 620301, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 4 },
    { 620301, GO_FIREWORK_SHOW_TYPE_1_BLUE, 31 },
    { 620301, GO_FIREWORK_SHOW_TYPE_2_BLUE, 37 },
    { 620301, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 56 },
    { 620301, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 41 },
    { 621914, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 26 },
    { 621914, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 52 },
    { 621914, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 35 },
    { 621914, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 43 },
    { 623135, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 53 },
    { 623135, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 51 },
    { 625162, GO_FIREWORK_SHOW_TYPE_1_BLUE, 40 },
    { 625162, GO_FIREWORK_SHOW_TYPE_1_GREEN, 48 },
    { 625162, GO_FIREWORK_SHOW_TYPE_2_RED, 33 },
    { 625162, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 49 },
    { 625162, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 9 },
    { 625162, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 44 },
    { 626790, GO_FIREWORK_SHOW_TYPE_1_BLUE, 0 },
    { 626790, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 8 },
    { 626790, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 22 },
    { 626790, GO_FIREWORK_SHOW_TYPE_2_WHITE, 15 },
    { 628011, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 38 },
    { 628011, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 45 },
    { 630037, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 36 },
    { 630037, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 19 },
    { 630037, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 14 },
    { 630037, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 5 },
    { 630037, GO_FIREWORK_SHOW_TYPE_1_RED, 1 },
    { 630037, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 11 },
    { 630037, GO_FIREWORK_SHOW_TYPE_2_WHITE, 25 },
    { 630037, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 54 },
    { 630037, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 55 },
    { 630037, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 17 },
    { 630037, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 42 },
    { 630037, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 2 },
    { 630037, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 24 },
    { 630037, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 32 },
    { 630037, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 16 },
    { 630037, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 12 },
    { 630037, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 18 },
    { 630037, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 21 },
    { 631651, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 28 },
    { 631651, GO_FIREWORK_SHOW_TYPE_2_GREEN, 30 },
    { 631651, GO_FIREWORK_SHOW_TYPE_1_RED, 47 },
    { 631651, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 31 },
    { 631651, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 27 },
    { 631651, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 23 },
    { 631651, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 46 },
    { 631651, GO_FIREWORK_SHOW_TYPE_1_BLUE, 7 },
    { 631651, GO_FIREWORK_SHOW_TYPE_1_BLUE, 39 },
    { 631651, GO_FIREWORK_SHOW_TYPE_2_RED, 29 },
    { 631651, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 34 },
    { 631651, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 3 },
    { 631651, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 6 },
    { 631651, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 13 },
    { 631651, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 50 },
    { 632869, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 37 },
    { 632869, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 43 },
    { 632869, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 41 },
    { 632869, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 56 },
    { 632869, GO_FIREWORK_SHOW_TYPE_1_RED, 52 },
    { 632869, GO_FIREWORK_SHOW_TYPE_2_RED, 26 },
    { 634893, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 4 },
    { 634893, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 10 },
    { 634893, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 20 },
    { 634893, GO_FIREWORK_SHOW_TYPE_2_RED, 35 },
    { 636529, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 51 },
    { 636529, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 9 },
    { 636529, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 33 },
    { 636529, GO_FIREWORK_SHOW_TYPE_2_GREEN, 40 },
    { 636529, GO_FIREWORK_SHOW_TYPE_1_RED, 53 },
    { 636529, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 44 },
    { 637740, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 49 },
    { 637740, GO_FIREWORK_SHOW_TYPE_1_BLUE, 48 },
    { 641403, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 23 },
    { 641403, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 55 },
    { 641403, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 25 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 2 },
    { 642616, GO_FIREWORK_SHOW_TYPE_2_BLUE, 54 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 17 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 18 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 21 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 3 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_GREEN, 27 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_GREEN, 38 },
    { 642616, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 6 },
    { 642616, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 19 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 50 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 30 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 39 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 46 },
    { 642616, GO_FIREWORK_SHOW_TYPE_2_WHITE, 15 },
    { 642616, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 5 },
    { 642616, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 13 },
    { 642616, GO_FIREWORK_SHOW_TYPE_2_RED, 36 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_WHITE, 16 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 34 },
    { 642616, GO_FIREWORK_SHOW_TYPE_1_WHITE, 45 },
    { 642616, GO_FIREWORK_SHOW_TYPE_2_WHITE, 42 },
    { 642616, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 24 },
    { 644645, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 29 },
    { 644645, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 4 },
    { 644645, GO_FIREWORK_SHOW_TYPE_1_RED, 1 },
    { 644645, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 11 },
    { 644645, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 8 },
    { 644645, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 47 },
    { 644645, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 14 },
    { 644645, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 22 },
    { 644645, GO_FIREWORK_SHOW_TYPE_2_WHITE, 32 },
    { 644645, GO_FIREWORK_SHOW_TYPE_1_BLUE, 31 },
    { 644645, GO_FIREWORK_SHOW_TYPE_2_RED, 28 },
    { 644645, GO_FIREWORK_SHOW_TYPE_1_WHITE, 12 },
    { 644645, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 0 },
    { 644645, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 7 },
    { 646265, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 26 },
    { 646265, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 10 },
    { 646265, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 35 },
    { 646265, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 52 },
    { 646265, GO_FIREWORK_SHOW_TYPE_2_WHITE, 41 },
    { 647477, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 56 },
    { 647477, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 43 },
    { 647477, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 37 },
    { 647477, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 20 },
    { 649507, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 49 },
    { 649507, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 53 },
    { 649507, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 9 },
    { 649507, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 33 },
    { 651132, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 40 },
    { 651132, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 48 },
    { 651132, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 51 },
    { 651132, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 44 },
    { 652357, GO_FIREWORK_SHOW_TYPE_1_RED, 46 },
    { 652357, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 13 },
    { 654383, GO_FIREWORK_SHOW_TYPE_1_GREEN, 55 },
    { 654383, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 36 },
    { 654383, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 50 },
    { 654383, GO_FIREWORK_SHOW_TYPE_2_WHITE, 3 },
    { 654383, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 27 },
    { 654383, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 54 },
    { 654383, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 2 },
    { 654383, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 6 },
    { 654383, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 17 },
    { 654383, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 5 },
    { 654383, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 25 },
    { 654383, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 21 },
    { 654383, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 18 },
    { 654383, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 39 },
    { 654383, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 15 },
    { 654383, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 34 },
    { 656007, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 19 },
    { 656007, GO_FIREWORK_SHOW_TYPE_1_WHITE, 10 },
    { 656007, GO_FIREWORK_SHOW_TYPE_2_GREEN, 30 },
    { 656007, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 38 },
    { 656007, GO_FIREWORK_SHOW_TYPE_1_BLUE, 23 },
    { 656007, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 24 },
    { 656007, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 45 },
    { 656007, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 16 },
    { 656007, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 42 },
    { 657219, GO_FIREWORK_SHOW_TYPE_1_WHITE, 12 },
    { 657219, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 52 },
    { 657219, GO_FIREWORK_SHOW_TYPE_1_WHITE, 41 },
    { 657219, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 35 },
    { 657219, GO_FIREWORK_SHOW_TYPE_2_GREEN, 0 },
    { 657219, GO_FIREWORK_SHOW_TYPE_1_RED, 47 },
    { 657219, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 11 },
    { 657219, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 29 },
    { 657219, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 22 },
    { 659250, GO_FIREWORK_SHOW_TYPE_2_BLUE, 7 },
    { 659250, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 32 },
    { 659250, GO_FIREWORK_SHOW_TYPE_1_GREEN, 8 },
    { 659250, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 1 },
    { 659250, GO_FIREWORK_SHOW_TYPE_2_GREEN, 4 },
    { 659250, GO_FIREWORK_SHOW_TYPE_1_RED, 28 },
    { 659250, GO_FIREWORK_SHOW_TYPE_1_BLUE, 31 },
    { 659250, GO_FIREWORK_SHOW_TYPE_2_RED, 26 },
    { 659250, GO_FIREWORK_SHOW_TYPE_2_RED, 14 },
    { 660861, GO_FIREWORK_SHOW_TYPE_2_GREEN, 37 },
    { 660861, GO_FIREWORK_SHOW_TYPE_2_RED, 33 },
    { 660861, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 20 },
    { 660861, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 49 },
    { 660861, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 56 },
    { 662075, GO_FIREWORK_SHOW_TYPE_1_RED, 53 },
    { 662075, GO_FIREWORK_SHOW_TYPE_2_RED, 9 },
    { 662075, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 43 },
    { 664107, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 54 },
    { 664107, GO_FIREWORK_SHOW_TYPE_2_WHITE, 25 },
    { 665721, GO_FIREWORK_SHOW_TYPE_2_BLUE, 27 },
    { 665721, GO_FIREWORK_SHOW_TYPE_2_BLUE, 50 },
    { 665721, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 46 },
    { 665721, GO_FIREWORK_SHOW_TYPE_2_GREEN, 40 },
    { 665721, GO_FIREWORK_SHOW_TYPE_2_GREEN, 55 },
    { 665721, GO_FIREWORK_SHOW_TYPE_2_WHITE, 34 },
    { 665721, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 36 },
    { 665721, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 15 },
    { 665721, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 13 },
    { 666937, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 18 },
    { 666937, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 6 },
    { 666937, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 5 },
    { 666937, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 17 },
    { 666937, GO_FIREWORK_SHOW_TYPE_2_WHITE, 3 },
    { 666937, GO_FIREWORK_SHOW_TYPE_2_RED, 44 },
    { 666937, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 51 },
    { 666937, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 48 },
    { 666937, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 2 },
    { 666937, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 39 },
    { 666937, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 21 },
    { 668963, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 1 },
    { 668963, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 12 },
    { 670575, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 28 },
    { 670575, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 47 },
    { 670575, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 29 },
    { 670575, GO_FIREWORK_SHOW_TYPE_1_BLUE, 0 },
    { 670575, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 42 },
    { 670575, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 26 },
    { 670575, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 16 },
    { 670575, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 45 },
    { 670575, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 41 },
    { 670575, GO_FIREWORK_SHOW_TYPE_2_BLUE, 24 },
    { 670575, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 10 },
    { 670575, GO_FIREWORK_SHOW_TYPE_1_GREEN, 30 },
    { 670575, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 52 },
    { 670575, GO_FIREWORK_SHOW_TYPE_2_GREEN, 23 },
    { 670575, GO_FIREWORK_SHOW_TYPE_2_GREEN, 11 },
    { 670575, GO_FIREWORK_SHOW_TYPE_2_GREEN, 38 },
    { 670575, GO_FIREWORK_SHOW_TYPE_1_RED, 19 },
    { 671797, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 14 },
    { 671797, GO_FIREWORK_SHOW_TYPE_2_RED, 35 },
    { 671797, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 31 },
    { 671797, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 4 },
    { 671797, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 8 },
    { 671797, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 32 },
    { 671797, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 22 },
    { 671797, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 7 },
    { 673821, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 56 },
    { 673821, GO_FIREWORK_SHOW_TYPE_1_WHITE, 57 },
    { 673821, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 9 },
    { 673821, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 43 },
    { 673821, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 49 },
    { 675438, GO_FIREWORK_SHOW_TYPE_2_WHITE, 20 },
    { 675438, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 53 },
    { 675438, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 33 },
    { 675438, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 37 },
    { 677460, GO_FIREWORK_SHOW_TYPE_1_BLUE, 7 },
    { 677460, GO_FIREWORK_SHOW_TYPE_2_BLUE, 40 },
    { 677865, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 38 },
    { 677865, GO_FIREWORK_SHOW_TYPE_2_GREEN, 30 },
    { 677865, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 1 },
    { 677865, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 51 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_BLUE, 0 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_BLUE, 48 },
    { 679088, GO_FIREWORK_SHOW_TYPE_2_RED, 36 },
    { 679088, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 34 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_WHITE, 42 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 23 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 39 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 17 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_GREEN, 31 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 15 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_GREEN, 50 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 13 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 28 },
    { 679088, GO_FIREWORK_SHOW_TYPE_2_GREEN, 27 },
    { 679088, GO_FIREWORK_SHOW_TYPE_2_GREEN, 54 },
    { 679088, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 47 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 18 },
    { 679088, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 46 },
    { 679088, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 19 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 10 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 4 },
    { 679088, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 32 },
    { 679088, GO_FIREWORK_SHOW_TYPE_2_WHITE, 25 },
    { 679088, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 12 },
    { 679088, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 26 },
    { 680301, GO_FIREWORK_SHOW_TYPE_2_BLUE, 2 },
    { 680301, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 11 },
    { 680301, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 24 },
    { 680301, GO_FIREWORK_SHOW_TYPE_2_GREEN, 55 },
    { 680301, GO_FIREWORK_SHOW_TYPE_2_GREEN, 8 },
    { 681116, GO_FIREWORK_SHOW_TYPE_2_RED, 29 },
    { 681116, GO_FIREWORK_SHOW_TYPE_1_WHITE, 45 },
    { 681116, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 21 },
    { 681116, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 3 },
    { 681116, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 35 },
    { 681116, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 6 },
    { 681116, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 44 },
    { 681116, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 5 },
    { 681116, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 52 },
    { 681116, GO_FIREWORK_SHOW_TYPE_2_WHITE, 41 },
    { 681116, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 22 },
    { 681116, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 14 },
    { 681116, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 16 },
};

// VerifiedBuild 50250
// timestamp[ms], firework gameobject ID, fireworkSpawnPositionIndex
FireworkShow fireworkShowStormwind =
{
    { 0, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 58 },
    { 2030, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 59 },
    { 3638, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 60 },
    { 6076, GO_FIREWORK_SHOW_TYPE_1_RED, 61 },
    { 6888, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 62 },
    { 6888, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 63 },
    { 6888, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 64 },
    { 6888, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 65 },
    { 7294, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 58 },
    { 8504, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 66 },
    { 8504, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 67 },
    { 9716, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 68 },
    { 9716, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 69 },
    { 10280, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 70 },
    { 10931, GO_FIREWORK_SHOW_TYPE_2_RED, 71 },
    { 11732, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 72 },
    { 11732, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 73 },
    { 11732, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 74 },
    { 12055, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 75 },
    { 13352, GO_FIREWORK_SHOW_TYPE_1_WHITE, 76 },
    { 14548, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 77 },
    { 14548, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 78 },
    { 14548, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 79 },
    { 14548, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 79 },
    { 15371, GO_FIREWORK_SHOW_TYPE_1_BLUE, 80 },
    { 17001, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 68 },
    { 17001, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 69 },
    { 17001, GO_FIREWORK_SHOW_TYPE_2_GREEN, 81 },
    { 18216, GO_FIREWORK_SHOW_TYPE_1_GREEN, 82 },
    { 18216, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 83 },
    { 18216, GO_FIREWORK_SHOW_TYPE_2_WHITE, 66 },
    { 18216, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 84 },
    { 19434, GO_FIREWORK_SHOW_TYPE_2_GREEN, 85 },
    { 19434, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 86 },
    { 19434, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 87 },
    { 20236, GO_FIREWORK_SHOW_TYPE_2_BLUE, 64 },
    { 20551, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 62 },
    { 21854, GO_FIREWORK_SHOW_TYPE_2_GREEN, 88 },
    { 21854, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 59 },
    { 21854, GO_FIREWORK_SHOW_TYPE_1_GREEN, 89 },
    { 22654, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 87 },
    { 23048, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 90 },
    { 23048, GO_FIREWORK_SHOW_TYPE_1_WHITE, 91 },
    { 24287, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 92 },
    { 24287, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 93 },
    { 25052, GO_FIREWORK_SHOW_TYPE_1_RED, 94 },
    { 25485, GO_FIREWORK_SHOW_TYPE_1_RED, 83 },
    { 26295, GO_FIREWORK_SHOW_TYPE_2_RED, 66 },
    { 26698, GO_FIREWORK_SHOW_TYPE_1_RED, 95 },
    { 26698, GO_FIREWORK_SHOW_TYPE_2_BLUE, 63 },
    { 27503, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 61 },
    { 27503, GO_FIREWORK_SHOW_TYPE_1_WHITE, 96 },
    { 27904, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 97 },
    { 27904, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 73 },
    { 27904, GO_FIREWORK_SHOW_TYPE_2_GREEN, 65 },
    { 27904, GO_FIREWORK_SHOW_TYPE_1_WHITE, 98 },
    { 29055, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 58 },
    { 29055, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 74 },
    { 29921, GO_FIREWORK_SHOW_TYPE_1_GREEN, 99 },
    { 30998, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 100 },
    { 30998, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 101 },
    { 31418, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 72 },
    { 31418, GO_FIREWORK_SHOW_TYPE_1_GREEN, 78 },
    { 33163, GO_FIREWORK_SHOW_TYPE_2_BLUE, 84 },
    { 33967, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 102 },
    { 33967, GO_FIREWORK_SHOW_TYPE_1_WHITE, 72 },
    { 34773, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 76 },
    { 38818, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 61 },
    { 38818, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 59 },
    { 38818, GO_FIREWORK_SHOW_TYPE_1_GREEN, 92 },
    { 38818, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 86 },
    { 38818, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 68 },
    { 39620, GO_FIREWORK_SHOW_TYPE_2_WHITE, 77 },
    { 39620, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 66 },
    { 40026, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 71 },
    { 40026, GO_FIREWORK_SHOW_TYPE_1_BLUE, 85 },
    { 40834, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 73 },
    { 41239, GO_FIREWORK_SHOW_TYPE_1_RED, 94 },
    { 41239, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 64 },
    { 43674, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 60 },
    { 43674, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 81 },
    { 44485, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 58 },
    { 44485, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 79 },
    { 45285, GO_FIREWORK_SHOW_TYPE_1_BLUE, 80 },
    { 45285, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 101 },
    { 45692, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 95 },
    { 45692, GO_FIREWORK_SHOW_TYPE_2_WHITE, 100 },
    { 46092, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 75 },
    { 46092, GO_FIREWORK_SHOW_TYPE_2_GREEN, 66 },
    { 46897, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 103 },
    { 46897, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 87 },
    { 46897, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 104 },
    { 48519, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 66 },
    { 48519, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 90 },
    { 48519, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 62 },
    { 50541, GO_FIREWORK_SHOW_TYPE_1_WHITE, 58 },
    { 50541, GO_FIREWORK_SHOW_TYPE_1_BLUE, 89 },
    { 50541, GO_FIREWORK_SHOW_TYPE_1_WHITE, 74 },
    { 50541, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 74 },
    { 50946, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 83 },
    { 51756, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 69 },
    { 52159, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 59 },
    { 52159, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 67 },
    { 53773, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 68 },
    { 53773, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 93 },
    { 53773, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 83 },
    { 54185, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 91 },
    { 54589, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 96 },
    { 55234, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 76 },
    { 55799, GO_FIREWORK_SHOW_TYPE_2_GREEN, 73 },
    { 56606, GO_FIREWORK_SHOW_TYPE_1_GREEN, 81 },
    { 57019, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 71 },
    { 57019, GO_FIREWORK_SHOW_TYPE_2_BLUE, 86 },
    { 57019, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 98 },
    { 58234, GO_FIREWORK_SHOW_TYPE_2_WHITE, 87 },
    { 59040, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 68 },
    { 59040, GO_FIREWORK_SHOW_TYPE_2_GREEN, 82 },
    { 59040, GO_FIREWORK_SHOW_TYPE_2_RED, 95 },
    { 59040, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 78 },
    { 59040, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 92 },
    { 60186, GO_FIREWORK_SHOW_TYPE_2_GREEN, 85 },
    { 61477, GO_FIREWORK_SHOW_TYPE_2_RED, 104 },
    { 61760, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 97 },
    { 62300, GO_FIREWORK_SHOW_TYPE_2_WHITE, 72 },
    { 62300, GO_FIREWORK_SHOW_TYPE_2_WHITE, 76 },
    { 63916, GO_FIREWORK_SHOW_TYPE_2_RED, 60 },
    { 65129, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 58 },
    { 65129, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 65 },
    { 65532, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 102 },
    { 66745, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 72 },
    { 66745, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 94 },
    { 66745, GO_FIREWORK_SHOW_TYPE_1_WHITE, 100 },
    { 67961, GO_FIREWORK_SHOW_TYPE_1_WHITE, 69 },
    { 68768, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 77 },
    { 68768, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 90 },
    { 69169, GO_FIREWORK_SHOW_TYPE_2_BLUE, 84 },
    { 69977, GO_FIREWORK_SHOW_TYPE_1_WHITE, 79 },
    { 70393, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 101 },
    { 70393, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 80 },
    { 71609, GO_FIREWORK_SHOW_TYPE_2_BLUE, 75 },
    { 72817, GO_FIREWORK_SHOW_TYPE_1_BLUE, 88 },
    { 73625, GO_FIREWORK_SHOW_TYPE_2_BLUE, 63 },
    { 74028, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 68 },
    { 74836, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 66 },
    { 75238, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 74 },
    { 75238, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 61 },
    { 75238, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 61 },
    { 77661, GO_FIREWORK_SHOW_TYPE_2_RED, 83 },
    { 78465, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 71 },
    { 78465, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 99 },
    { 78875, GO_FIREWORK_SHOW_TYPE_1_WHITE, 59 },
    { 80090, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 81 },
    { 80090, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 103 },
    { 80908, GO_FIREWORK_SHOW_TYPE_1_RED, 74 },
    { 81211, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 104 },
    { 81211, GO_FIREWORK_SHOW_TYPE_2_BLUE, 64 },
    { 81211, GO_FIREWORK_SHOW_TYPE_2_WHITE, 72 },
    { 81211, GO_FIREWORK_SHOW_TYPE_1_BLUE, 78 },
    { 81702, GO_FIREWORK_SHOW_TYPE_1_BLUE, 86 },
    { 82523, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 58 },
    { 82523, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 94 },
    { 83730, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 87 },
    { 84954, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 62 },
    { 86182, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 83 },
    { 86182, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 100 },
    { 86182, GO_FIREWORK_SHOW_TYPE_2_WHITE, 98 },
    { 86182, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 96 },
    { 86182, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 89 },
    { 86182, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 58 },
    { 86182, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 93 },
    { 88199, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 70 },
    { 89396, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 87 },
    { 89396, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 95 },
    { 89396, GO_FIREWORK_SHOW_TYPE_1_BLUE, 92 },
    { 89820, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 68 },
    { 89820, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 61 },
    { 89820, GO_FIREWORK_SHOW_TYPE_1_GREEN, 66 },
    { 89820, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 72 },
    { 91035, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 77 },
    { 91035, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 67 },
    { 91035, GO_FIREWORK_SHOW_TYPE_2_GREEN, 73 },
    { 92242, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 80 },
    { 92242, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 69 },
    { 92867, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 99 },
    { 92867, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 59 },
    { 92867, GO_FIREWORK_SHOW_TYPE_2_WHITE, 91 },
    { 92867, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 102 },
    { 92867, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 76 },
    { 95777, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 75 },
    { 95777, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 66 },
    { 97897, GO_FIREWORK_SHOW_TYPE_1_WHITE, 74 },
    { 97897, GO_FIREWORK_SHOW_TYPE_1_WHITE, 74 },
    { 98861, GO_FIREWORK_SHOW_TYPE_1_RED, 74 },
    { 98861, GO_FIREWORK_SHOW_TYPE_2_GREEN, 88 },
    { 99536, GO_FIREWORK_SHOW_TYPE_1_RED, 76 },
    { 100750, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 83 },
    { 100750, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 83 },
    { 100750, GO_FIREWORK_SHOW_TYPE_2_WHITE, 58 },
    { 101967, GO_FIREWORK_SHOW_TYPE_1_WHITE, 68 },
    { 101967, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 58 },
    { 103180, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 86 },
    { 103988, GO_FIREWORK_SHOW_TYPE_1_RED, 66 },
    { 105599, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 100 },
    { 105599, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 89 },
    { 105599, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 71 },
    { 105599, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 82 },
    { 105599, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 60 },
    { 106820, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 85 },
    { 108033, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 93 },
    { 108033, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 62 },
    { 108850, GO_FIREWORK_SHOW_TYPE_2_WHITE, 69 },
    { 108850, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 98 },
    { 109872, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 64 },
    { 110468, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 92 },
    { 110468, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 103 },
    { 110468, GO_FIREWORK_SHOW_TYPE_1_WHITE, 91 },
    { 110468, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 77 },
    { 111675, GO_FIREWORK_SHOW_TYPE_2_GREEN, 80 },
    { 111675, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 61 },
    { 111675, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 70 },
    { 111675, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 72 },
    { 112068, GO_FIREWORK_SHOW_TYPE_1_RED, 74 },
    { 112068, GO_FIREWORK_SHOW_TYPE_1_WHITE, 76 },
    { 112877, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 67 },
    { 112877, GO_FIREWORK_SHOW_TYPE_2_BLUE, 63 },
    { 113686, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 104 },
    { 115296, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 101 },
    { 115296, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 90 },
    { 116508, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 87 },
    { 117721, GO_FIREWORK_SHOW_TYPE_1_BLUE, 75 },
    { 117721, GO_FIREWORK_SHOW_TYPE_1_RED, 87 },
    { 118525, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 85 },
    { 118889, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 83 },
    { 118889, GO_FIREWORK_SHOW_TYPE_1_RED, 94 },
    { 119746, GO_FIREWORK_SHOW_TYPE_1_BLUE, 99 },
    { 119746, GO_FIREWORK_SHOW_TYPE_1_RED, 72 },
    { 121367, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 73 },
    { 122175, GO_FIREWORK_SHOW_TYPE_1_WHITE, 68 },
    { 123386, GO_FIREWORK_SHOW_TYPE_2_RED, 58 },
    { 123778, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 96 },
    { 123778, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 92 },
    { 123778, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 69 },
    { 124999, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 64 },
    { 124999, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 66 },
    { 124999, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 59 },
    { 126205, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 65 },
    { 126205, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 78 },
    { 126205, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 68 },
    { 127023, GO_FIREWORK_SHOW_TYPE_2_BLUE, 84 },
    { 127023, GO_FIREWORK_SHOW_TYPE_1_WHITE, 103 },
    { 127023, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 95 },
    { 128244, GO_FIREWORK_SHOW_TYPE_1_RED, 93 },
    { 128244, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 62 },
    { 128647, GO_FIREWORK_SHOW_TYPE_1_RED, 60 },
    { 128647, GO_FIREWORK_SHOW_TYPE_1_WHITE, 69 },
    { 129865, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 100 },
    { 129865, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 88 },
    { 129865, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 102 },
    { 131086, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 58 },
    { 131086, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 81 },
    { 133401, GO_FIREWORK_SHOW_TYPE_2_WHITE, 91 },
    { 133401, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 72 },
    { 134714, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 82 },
    { 134714, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 71 },
    { 134714, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 77 },
    { 135937, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 66 },
    { 137968, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 76 },
    { 137968, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 83 },
    { 138373, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 89 },
    { 138373, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 59 },
    { 139581, GO_FIREWORK_SHOW_TYPE_2_BLUE, 73 },
    { 139581, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 70 },
    { 139581, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 97 },
    { 141618, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 90 },
    { 141618, GO_FIREWORK_SHOW_TYPE_2_RED, 94 },
    { 142838, GO_FIREWORK_SHOW_TYPE_2_BLUE, 85 },
    { 143183, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 101 },
    { 144455, GO_FIREWORK_SHOW_TYPE_2_GREEN, 75 },
    { 144455, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 72 },
    { 144455, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 86 },
    { 144455, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 69 },
    { 144455, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 74 },
    { 145671, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 79 },
    { 145671, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 78 },
    { 146480, GO_FIREWORK_SHOW_TYPE_1_BLUE, 66 },
    { 146480, GO_FIREWORK_SHOW_TYPE_1_RED, 68 },
    { 146480, GO_FIREWORK_SHOW_TYPE_2_WHITE, 68 },
    { 148099, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 74 },
    { 149321, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 83 },
    { 149321, GO_FIREWORK_SHOW_TYPE_2_BLUE, 80 },
    { 150523, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 104 },
    { 150523, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 104 },
    { 151336, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 102 },
    { 151336, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 63 },
    { 151336, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 66 },
    { 151336, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 67 },
    { 152546, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 58 },
    { 152951, GO_FIREWORK_SHOW_TYPE_1_BLUE, 65 },
    { 152951, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 95 },
    { 152951, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 60 },
    { 154148, GO_FIREWORK_SHOW_TYPE_1_BLUE, 64 },
    { 154148, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 58 },
    { 154148, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 99 },
    { 154148, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 99 },
    { 155367, GO_FIREWORK_SHOW_TYPE_2_RED, 61 },
    { 156180, GO_FIREWORK_SHOW_TYPE_2_WHITE, 100 },
    { 156180, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 84 },
    { 157390, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 71 },
    { 157390, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 72 },
    { 157794, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 93 },
    { 157794, GO_FIREWORK_SHOW_TYPE_2_WHITE, 70 },
    { 159019, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 97 },
    { 159019, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 96 },
    { 161039, GO_FIREWORK_SHOW_TYPE_1_WHITE, 74 },
    { 161039, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 98 },
    { 161039, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 91 },
    { 161039, GO_FIREWORK_SHOW_TYPE_1_GREEN, 86 },
    { 162653, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 76 },
    { 163868, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 66 },
    { 165102, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 58 },
    { 165908, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 101 },
    { 165908, GO_FIREWORK_SHOW_TYPE_1_GREEN, 75 },
    { 165908, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 69 },
    { 165908, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 87 },
    { 165908, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 87 },
    { 167533, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 82 },
    { 167533, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 66 },
    { 168692, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 89 },
    { 169142, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 88 },
    { 169964, GO_FIREWORK_SHOW_TYPE_2_RED, 83 },
    { 170778, GO_FIREWORK_SHOW_TYPE_2_RED, 71 },
    { 170778, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 67 },
    { 170778, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 99 },
    { 170778, GO_FIREWORK_SHOW_TYPE_1_RED, 94 },
    { 172388, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 69 },
    { 174828, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 76 },
    { 175640, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 60 },
    { 175640, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 72 },
    { 175640, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 74 },
    { 175640, GO_FIREWORK_SHOW_TYPE_2_GREEN, 65 },
    { 175640, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 61 },
    { 175640, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 63 },
    { 175640, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 80 },
    { 176847, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 103 },
    { 176847, GO_FIREWORK_SHOW_TYPE_1_RED, 62 },
    { 177264, GO_FIREWORK_SHOW_TYPE_1_RED, 68 },
    { 177264, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 102 },
    { 177264, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 77 },
    { 177264, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 84 },
    { 178480, GO_FIREWORK_SHOW_TYPE_2_BLUE, 75 },
    { 178480, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 69 },
    { 178480, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 93 },
    { 178480, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 78 },
    { 178480, GO_FIREWORK_SHOW_TYPE_2_RED, 104 },
    { 179695, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 83 },
    { 179695, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 66 },
    { 180507, GO_FIREWORK_SHOW_TYPE_1_WHITE, 91 },
    { 182136, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 76 },
    { 182136, GO_FIREWORK_SHOW_TYPE_2_WHITE, 59 },
    { 182136, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 64 },
    { 182136, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 64 },
    { 183344, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 98 },
    { 183344, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 66 },
    { 183344, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 73 },
    { 183344, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 58 },
    { 185368, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 72 },
    { 185368, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 88 },
    { 186590, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 68 },
    { 186590, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 97 },
    { 187801, GO_FIREWORK_SHOW_TYPE_1_BLUE, 89 },
    { 188205, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 101 },
    { 189412, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 77 },
    { 189412, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 61 },
    { 190224, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 66 },
    { 190224, GO_FIREWORK_SHOW_TYPE_2_RED, 94 },
    { 190636, GO_FIREWORK_SHOW_TYPE_1_RED, 60 },
    { 190636, GO_FIREWORK_SHOW_TYPE_1_RED, 60 },
    { 191438, GO_FIREWORK_SHOW_TYPE_1_GREEN, 80 },
    { 191853, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 79 },
    { 191853, GO_FIREWORK_SHOW_TYPE_1_WHITE, 70 },
    { 192649, GO_FIREWORK_SHOW_TYPE_1_GREEN, 99 },
    { 193064, GO_FIREWORK_SHOW_TYPE_2_BLUE, 85 },
    { 193064, GO_FIREWORK_SHOW_TYPE_1_WHITE, 58 },
    { 194258, GO_FIREWORK_SHOW_TYPE_2_WHITE, 87 },
    { 194978, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 83 },
    { 194978, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 86 },
    { 194978, GO_FIREWORK_SHOW_TYPE_1_WHITE, 74 },
    { 194978, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 78 },
    { 195471, GO_FIREWORK_SHOW_TYPE_1_RED, 76 },
    { 197898, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 69 },
    { 197898, GO_FIREWORK_SHOW_TYPE_2_WHITE, 100 },
    { 197898, GO_FIREWORK_SHOW_TYPE_2_WHITE, 98 },
    { 197898, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 103 },
    { 197898, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 68 },
    { 199127, GO_FIREWORK_SHOW_TYPE_2_WHITE, 96 },
    { 199127, GO_FIREWORK_SHOW_TYPE_2_GREEN, 63 },
    { 199127, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 92 },
    { 199927, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 93 },
    { 199927, GO_FIREWORK_SHOW_TYPE_1_RED, 104 },
    { 201152, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 58 },
    { 201550, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 83 },
    { 201550, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 66 },
    { 201550, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 102 },
    { 201550, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 102 },
    { 202769, GO_FIREWORK_SHOW_TYPE_1_BLUE, 84 },
    { 202769, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 82 },
    { 202769, GO_FIREWORK_SHOW_TYPE_1_BLUE, 81 },
    { 202769, GO_FIREWORK_SHOW_TYPE_1_BLUE, 81 },
    { 203982, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 68 },
    { 203982, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 65 },
    { 203982, GO_FIREWORK_SHOW_TYPE_1_RED, 72 },
    { 203982, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 67 },
    { 206015, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 99 },
    { 206015, GO_FIREWORK_SHOW_TYPE_2_RED, 71 },
    { 207617, GO_FIREWORK_SHOW_TYPE_1_RED, 87 },
    { 207617, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 95 },
    { 207617, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 90 },
    { 208836, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 76 },
    { 208836, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 79 },
    { 209640, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 77 },
    { 210678, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 62 },
    { 210678, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 61 },
    { 211250, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 78 },
    { 211250, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 59 },
    { 211250, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 73 },
    { 211250, GO_FIREWORK_SHOW_TYPE_1_GREEN, 88 },
    { 212464, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 76 },
    { 212464, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 74 },
    { 212464, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 66 },
    { 214086, GO_FIREWORK_SHOW_TYPE_2_GREEN, 64 },
    { 215297, GO_FIREWORK_SHOW_TYPE_2_RED, 101 },
    { 215297, GO_FIREWORK_SHOW_TYPE_2_BLUE, 85 },
    { 217312, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 68 },
    { 217312, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 94 },
    { 217312, GO_FIREWORK_SHOW_TYPE_1_BLUE, 66 },
    { 217312, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 58 },
    { 218533, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 92 },
    { 218533, GO_FIREWORK_SHOW_TYPE_2_WHITE, 70 },
    { 218533, GO_FIREWORK_SHOW_TYPE_1_BLUE, 65 },
    { 218533, GO_FIREWORK_SHOW_TYPE_2_BLUE, 80 },
    { 219338, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 93 },
    { 220556, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 98 },
    { 220957, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 96 },
    { 222173, GO_FIREWORK_SHOW_TYPE_2_WHITE, 83 },
    { 222173, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 104 },
    { 222173, GO_FIREWORK_SHOW_TYPE_2_BLUE, 75 },
    { 223380, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 60 },
    { 223380, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 91 },
    { 224195, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 58 },
    { 224195, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 69 },
    { 224195, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 72 },
    { 225406, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 72 },
    { 225814, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 90 },
    { 225814, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 100 },
    { 225814, GO_FIREWORK_SHOW_TYPE_1_BLUE, 81 },
    { 225814, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 59 },
    { 225814, GO_FIREWORK_SHOW_TYPE_2_BLUE, 86 },
    { 229027, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 83 },
    { 230290, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 89 },
    { 230689, GO_FIREWORK_SHOW_TYPE_1_WHITE, 97 },
    { 231910, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 84 },
    { 231910, GO_FIREWORK_SHOW_TYPE_2_GREEN, 99 },
    { 231910, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 66 },
    { 231910, GO_FIREWORK_SHOW_TYPE_2_RED, 67 },
    { 233943, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 78 },
    { 233943, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 71 },
    { 233943, GO_FIREWORK_SHOW_TYPE_1_GREEN, 88 },
    { 235390, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 74 },
    { 235390, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 92 },
    { 236771, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 68 },
    { 236771, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 62 },
    { 236771, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 61 },
    { 236771, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 87 },
    { 236771, GO_FIREWORK_SHOW_TYPE_1_RED, 69 },
    { 237979, GO_FIREWORK_SHOW_TYPE_1_BLUE, 66 },
    { 237979, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 77 },
    { 237979, GO_FIREWORK_SHOW_TYPE_2_BLUE, 102 },
    { 238776, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 95 },
    { 240000, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 66 },
    { 240405, GO_FIREWORK_SHOW_TYPE_1_WHITE, 59 },
    { 240405, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 74 },
    { 241209, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 72 },
    { 241209, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 80 },
    { 241623, GO_FIREWORK_SHOW_TYPE_1_RED, 83 },
    { 241623, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 72 },
    { 241623, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 76 },
    { 242429, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 104 },
    { 243637, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 93 },
    { 243637, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 60 },
    { 244858, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 76 },
    { 245260, GO_FIREWORK_SHOW_TYPE_1_BLUE, 75 },
    { 245260, GO_FIREWORK_SHOW_TYPE_1_WHITE, 100 },
    { 245260, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 58 },
    { 246475, GO_FIREWORK_SHOW_TYPE_1_BLUE, 89 },
    { 246475, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 96 },
    { 246475, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 70 },
    { 246475, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 64 },
    { 246475, GO_FIREWORK_SHOW_TYPE_1_GREEN, 85 },
    { 248491, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 87 },
    { 248491, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 87 },
    { 248905, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 65 },
    { 249864, GO_FIREWORK_SHOW_TYPE_1_BLUE, 92 },
    { 249864, GO_FIREWORK_SHOW_TYPE_2_WHITE, 97 },
    { 251066, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 82 },
    { 251066, GO_FIREWORK_SHOW_TYPE_1_WHITE, 79 },
    { 251307, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 90 },
    { 253335, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 74 },
    { 253335, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 73 },
    { 253335, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 101 },
    { 254538, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 67 },
    { 254538, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 103 },
    { 254538, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 69 },
    { 254940, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 81 },
    { 254940, GO_FIREWORK_SHOW_TYPE_2_BLUE, 102 },
    { 254940, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 58 },
    { 256146, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 66 },
    { 256146, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 71 },
    { 257367, GO_FIREWORK_SHOW_TYPE_2_GREEN, 86 },
    { 258178, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 66 },
    { 259391, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 94 },
    { 259792, GO_FIREWORK_SHOW_TYPE_2_WHITE, 98 },
    { 259792, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 68 },
    { 259792, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 62 },
    { 261011, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 72 },
    { 261011, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 91 },
    { 261011, GO_FIREWORK_SHOW_TYPE_1_BLUE, 63 },
    { 263030, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 69 },
    { 263030, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 78 },
    { 263030, GO_FIREWORK_SHOW_TYPE_1_WHITE, 76 },
    { 263030, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 99 },
    { 264635, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 104 },
    { 264635, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 88 },
    { 264635, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 95 },
    { 265859, GO_FIREWORK_SHOW_TYPE_2_WHITE, 68 },
    { 265859, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 97 },
    { 267067, GO_FIREWORK_SHOW_TYPE_1_WHITE, 77 },
    { 267872, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 96 },
    { 267872, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 61 },
    { 267872, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 100 },
    { 269081, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 76 },
    { 269494, GO_FIREWORK_SHOW_TYPE_1_GREEN, 82 },
    { 269494, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 83 },
    { 269494, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 103 },
    { 269494, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 103 },
    { 272714, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 75 },
    { 272714, GO_FIREWORK_SHOW_TYPE_2_RED, 62 },
    { 274340, GO_FIREWORK_SHOW_TYPE_2_BLUE, 84 },
    { 274340, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 66 },
    { 274340, GO_FIREWORK_SHOW_TYPE_2_GREEN, 86 },
    { 274340, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 60 },
    { 275548, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 87 },
    { 275548, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 69 },
    { 277283, GO_FIREWORK_SHOW_TYPE_2_WHITE, 68 },
    { 277283, GO_FIREWORK_SHOW_TYPE_1_WHITE, 91 },
    { 277283, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 68 },
    { 277283, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 104 },
    { 277283, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 70 },
    { 278785, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 102 },
    { 279192, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 83 },
    { 279192, GO_FIREWORK_SHOW_TYPE_2_WHITE, 59 },
    { 280156, GO_FIREWORK_SHOW_TYPE_2_BLUE, 85 },
    { 280398, GO_FIREWORK_SHOW_TYPE_1_BLUE, 92 },
    { 280398, GO_FIREWORK_SHOW_TYPE_1_WHITE, 72 },
    { 280398, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 101 },
    { 282429, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 67 },
    { 282429, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 81 },
    { 282429, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 66 },
    { 282429, GO_FIREWORK_SHOW_TYPE_1_GREEN, 88 },
    { 282429, GO_FIREWORK_SHOW_TYPE_1_GREEN, 63 },
    { 284042, GO_FIREWORK_SHOW_TYPE_2_WHITE, 58 },
    { 285272, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 64 },
    { 285272, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 74 },
    { 285272, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 74 },
    { 285272, GO_FIREWORK_SHOW_TYPE_1_RED, 76 },
    { 287282, GO_FIREWORK_SHOW_TYPE_1_WHITE, 79 },
    { 287282, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 93 },
    { 287282, GO_FIREWORK_SHOW_TYPE_1_GREEN, 89 },
    { 288905, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 97 },
    { 288905, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 61 },
    { 288905, GO_FIREWORK_SHOW_TYPE_2_RED, 72 },
    { 288905, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 77 },
    { 290105, GO_FIREWORK_SHOW_TYPE_1_GREEN, 84 },
    { 290105, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 58 },
    { 292131, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 76 },
    { 292131, GO_FIREWORK_SHOW_TYPE_2_BLUE, 99 },
    { 293754, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 94 },
    { 293754, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 80 },
    { 293754, GO_FIREWORK_SHOW_TYPE_1_GREEN, 78 },
    { 294964, GO_FIREWORK_SHOW_TYPE_1_WHITE, 66 },
    { 294964, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 75 },
    { 296177, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 68 },
    { 296177, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 67 },
    { 296966, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 58 },
    { 296966, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 101 },
    { 296966, GO_FIREWORK_SHOW_TYPE_2_GREEN, 65 },
    { 296966, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 69 },
    { 298229, GO_FIREWORK_SHOW_TYPE_2_GREEN, 90 },
    { 298229, GO_FIREWORK_SHOW_TYPE_1_RED, 104 },
    { 298631, GO_FIREWORK_SHOW_TYPE_1_BLUE, 66 },
    { 299847, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 100 },
    { 299847, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 102 },
    { 299847, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 69 },
    { 299847, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 91 },
    { 301070, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 86 },
    { 301873, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 76 },
    { 301873, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 62 },
    { 303483, GO_FIREWORK_SHOW_TYPE_1_GREEN, 73 },
    { 303483, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 66 },
    { 304693, GO_FIREWORK_SHOW_TYPE_1_BLUE, 82 },
    { 304693, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 70 },
    { 304693, GO_FIREWORK_SHOW_TYPE_1_WHITE, 74 },
    { 305918, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 87 },
    { 306723, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 87 },
    { 306723, GO_FIREWORK_SHOW_TYPE_1_RED, 72 },
    { 306723, GO_FIREWORK_SHOW_TYPE_2_WHITE, 76 },
    { 306723, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 71 },
    { 307805, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 92 },
    { 308341, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 95 },
    { 308341, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 83 },
    { 309551, GO_FIREWORK_SHOW_TYPE_2_GREEN, 88 },
    { 309551, GO_FIREWORK_SHOW_TYPE_1_RED, 58 },
    { 309551, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 63 },
    { 309551, GO_FIREWORK_SHOW_TYPE_2_WHITE, 103 },
    { 309551, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 98 },
    { 309551, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 81 },
    { 309551, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 85 },
    { 309551, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 89 },
    { 309551, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 89 },
    { 311570, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 68 },
    { 311570, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 93 },
    { 313190, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 59 },
    { 314414, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 66 },
    { 314414, GO_FIREWORK_SHOW_TYPE_1_WHITE, 77 },
    { 314414, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 76 },
    { 314414, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 99 },
    { 316440, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 74 },
    { 316440, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 97 },
    { 316440, GO_FIREWORK_SHOW_TYPE_1_RED, 69 },
    { 316440, GO_FIREWORK_SHOW_TYPE_2_GREEN, 84 },
    { 316440, GO_FIREWORK_SHOW_TYPE_1_WHITE, 72 },
    { 316440, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 65 },
    { 318046, GO_FIREWORK_SHOW_TYPE_1_RED, 101 },
    { 319266, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 61 },
    { 319266, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 80 },
    { 321289, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 66 },
    { 321289, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 58 },
    { 321289, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 94 },
    { 321289, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 79 },
    { 322920, GO_FIREWORK_SHOW_TYPE_2_GREEN, 82 },
    { 324130, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 67 },
    { 326147, GO_FIREWORK_SHOW_TYPE_2_WHITE, 91 },
    { 326147, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 71 },
    { 326147, GO_FIREWORK_SHOW_TYPE_1_BLUE, 64 },
    { 326147, GO_FIREWORK_SHOW_TYPE_1_WHITE, 96 },
    { 327771, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 58 },
    { 327771, GO_FIREWORK_SHOW_TYPE_2_RED, 83 },
    { 327771, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 73 },
    { 327771, GO_FIREWORK_SHOW_TYPE_1_WHITE, 69 },
    { 327771, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 60 },
    { 328990, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 62 },
    { 328990, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 74 },
    { 328990, GO_FIREWORK_SHOW_TYPE_2_WHITE, 70 },
    { 328990, GO_FIREWORK_SHOW_TYPE_1_GREEN, 88 },
    { 331027, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 83 },
    { 331027, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 76 },
    { 331027, GO_FIREWORK_SHOW_TYPE_2_RED, 72 },
    { 331027, GO_FIREWORK_SHOW_TYPE_2_GREEN, 86 },
    { 331027, GO_FIREWORK_SHOW_TYPE_2_BLUE, 78 },
    { 331027, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 100 },
    { 331027, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 68 },
    { 332241, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 81 },
    { 332241, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 104 },
    { 332241, GO_FIREWORK_SHOW_TYPE_2_RED, 76 },
    { 332241, GO_FIREWORK_SHOW_TYPE_1_BLUE, 85 },
    { 334260, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 103 },
    { 335884, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 93 },
    { 335884, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 87 },
    { 335884, GO_FIREWORK_SHOW_TYPE_2_GREEN, 102 },
    { 335884, GO_FIREWORK_SHOW_TYPE_1_BLUE, 63 },
    { 337098, GO_FIREWORK_SHOW_TYPE_1_WHITE, 97 },
    { 337098, GO_FIREWORK_SHOW_TYPE_2_GREEN, 65 },
    { 337098, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 66 },
    { 337098, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 68 },
    { 337098, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 99 },
    { 338311, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 74 },
    { 339126, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 92 },
    { 339126, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 98 },
    { 340743, GO_FIREWORK_SHOW_TYPE_1_WHITE, 77 },
    { 340743, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 62 },
    { 341955, GO_FIREWORK_SHOW_TYPE_2_BLUE, 82 },
    { 341955, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 87 },
    { 341955, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 101 },
    { 343968, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 71 },
    { 345183, GO_FIREWORK_SHOW_TYPE_1_RED, 94 },
    { 345588, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 79 },
    { 345588, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 61 },
    { 345588, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 76 },
    { 345588, GO_FIREWORK_SHOW_TYPE_1_WHITE, 59 },
    { 346788, GO_FIREWORK_SHOW_TYPE_1_GREEN, 84 },
    { 346788, GO_FIREWORK_SHOW_TYPE_1_RED, 104 },
    { 346788, GO_FIREWORK_SHOW_TYPE_2_BLUE, 90 },
    { 346788, GO_FIREWORK_SHOW_TYPE_2_BLUE, 90 },
    { 346788, GO_FIREWORK_SHOW_TYPE_2_BLUE, 90 },
    { 348834, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 69 },
    { 348834, GO_FIREWORK_SHOW_TYPE_2_GREEN, 80 },
    { 348834, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 75 },
    { 348834, GO_FIREWORK_SHOW_TYPE_2_BLUE, 73 },
    { 350465, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 96 },
    { 350465, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 67 },
    { 350465, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 70 },
    { 350465, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 74 },
    { 350465, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 91 },
    { 351681, GO_FIREWORK_SHOW_TYPE_1_BLUE, 102 },
    { 351681, GO_FIREWORK_SHOW_TYPE_2_RED, 95 },
    { 351681, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 58 },
    { 351681, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 60 },
    { 351681, GO_FIREWORK_SHOW_TYPE_2_RED, 66 },
    { 351681, GO_FIREWORK_SHOW_TYPE_2_RED, 66 },
    { 353687, GO_FIREWORK_SHOW_TYPE_2_BLUE, 85 },
    { 353687, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 76 },
    { 353687, GO_FIREWORK_SHOW_TYPE_2_GREEN, 65 },
    { 353687, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 72 },
    { 355282, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 61 },
    { 355282, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 66 },
    { 355282, GO_FIREWORK_SHOW_TYPE_2_RED, 83 },
    { 356536, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 89 },
    { 358554, GO_FIREWORK_SHOW_TYPE_1_RED, 93 },
    { 358554, GO_FIREWORK_SHOW_TYPE_2_BLUE, 88 },
    { 358554, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 87 },
    { 360182, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 98 },
    { 360182, GO_FIREWORK_SHOW_TYPE_2_BLUE, 84 },
    { 361391, GO_FIREWORK_SHOW_TYPE_1_BLUE, 63 },
    { 361391, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 68 },
    { 361391, GO_FIREWORK_SHOW_TYPE_1_WHITE, 69 },
    { 363410, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 78 },
    { 363410, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 72 },
    { 363410, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 100 },
    { 365033, GO_FIREWORK_SHOW_TYPE_1_BLUE, 82 },
    { 365033, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 77 },
    { 365033, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 83 },
    { 365033, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 71 },
    { 365033, GO_FIREWORK_SHOW_TYPE_2_RED, 104 },
    { 366246, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 68 },
    { 366246, GO_FIREWORK_SHOW_TYPE_2_BLUE, 64 },
    { 368271, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 76 },
    { 368271, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 87 },
    { 369899, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 94 },
    { 369899, GO_FIREWORK_SHOW_TYPE_1_GREEN, 81 },
    { 371114, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 76 },
    { 371114, GO_FIREWORK_SHOW_TYPE_1_RED, 58 },
    { 371114, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 62 },
    { 371114, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 98 },
    { 371114, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 72 },
    { 371114, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 69 },
    { 371114, GO_FIREWORK_SHOW_TYPE_2_WHITE, 59 },
    { 373117, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 95 },
    { 373117, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 102 },
    { 373117, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 60 },
    { 373117, GO_FIREWORK_SHOW_TYPE_1_BLUE, 90 },
    { 373117, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 85 },
    { 374744, GO_FIREWORK_SHOW_TYPE_2_GREEN, 99 },
    { 374744, GO_FIREWORK_SHOW_TYPE_2_RED, 74 },
    { 374744, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 101 },
    { 375966, GO_FIREWORK_SHOW_TYPE_1_WHITE, 66 },
    { 375966, GO_FIREWORK_SHOW_TYPE_1_RED, 83 },
    { 377186, GO_FIREWORK_SHOW_TYPE_2_RED, 72 },
    { 377186, GO_FIREWORK_SHOW_TYPE_1_BLUE, 75 },
    { 379601, GO_FIREWORK_SHOW_TYPE_2_WHITE, 79 },
    { 379601, GO_FIREWORK_SHOW_TYPE_2_BLUE, 86 },
    { 379601, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 97 },
    { 379601, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 66 },
    { 379601, GO_FIREWORK_SHOW_TYPE_2_WHITE, 69 },
    { 380825, GO_FIREWORK_SHOW_TYPE_1_BLUE, 73 },
    { 382037, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 70 },
    { 382845, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 91 },
    { 384067, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 100 },
    { 385692, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 83 },
    { 385692, GO_FIREWORK_SHOW_TYPE_1_BLUE, 88 },
    { 385692, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 68 },
    { 385692, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 61 },
    { 385692, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 58 },
    { 387717, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 87 },
    { 387717, GO_FIREWORK_SHOW_TYPE_1_BLUE, 89 },
    { 387717, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 59 },
    { 387717, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 77 },
    { 387717, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 87 },
    { 388918, GO_FIREWORK_SHOW_TYPE_1_BLUE, 82 },
    { 389322, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 80 },
    { 389322, GO_FIREWORK_SHOW_TYPE_2_RED, 71 },
    { 391756, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 74 },
    { 392564, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 65 },
    { 392564, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 79 },
    { 392564, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 96 },
    { 392564, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 75 },
    { 392564, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 66 },
    { 394191, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 104 },
    { 394191, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 64 },
    { 394191, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 72 },
    { 394191, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 84 },
    { 395402, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 74 },
    { 395402, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 58 },
    { 397414, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 90 },
    { 397414, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 101 },
    { 397414, GO_FIREWORK_SHOW_TYPE_2_RED, 66 },
    { 397414, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 103 },
    { 399050, GO_FIREWORK_SHOW_TYPE_1_GREEN, 92 },
    { 399050, GO_FIREWORK_SHOW_TYPE_2_BLUE, 63 },
    { 399050, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 72 },
    { 399050, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 76 },
    { 399050, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 91 },
    { 399050, GO_FIREWORK_SHOW_TYPE_2_RED, 60 },
    { 400262, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 68 },
    { 400262, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 95 },
    { 400262, GO_FIREWORK_SHOW_TYPE_2_BLUE, 102 },
    { 402290, GO_FIREWORK_SHOW_TYPE_2_RED, 67 },
    { 402290, GO_FIREWORK_SHOW_TYPE_1_BLUE, 81 },
    { 402290, GO_FIREWORK_SHOW_TYPE_2_WHITE, 76 },
    { 402290, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 58 },
    { 403912, GO_FIREWORK_SHOW_TYPE_1_GREEN, 78 },
    { 403912, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 69 },
    { 405134, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 77 },
    { 405134, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 88 },
    { 405134, GO_FIREWORK_SHOW_TYPE_2_GREEN, 86 },
    { 405134, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 100 },
    { 407157, GO_FIREWORK_SHOW_TYPE_1_RED, 87 },
    { 407157, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 66 },
    { 410002, GO_FIREWORK_SHOW_TYPE_1_RED, 83 },
    { 410002, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 70 },
    { 412025, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 104 },
    { 413646, GO_FIREWORK_SHOW_TYPE_2_GREEN, 65 },
    { 413646, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 75 },
    { 414854, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 90 },
    { 414854, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 76 },
    { 414854, GO_FIREWORK_SHOW_TYPE_1_BLUE, 85 },
    { 414854, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 96 },
    { 414854, GO_FIREWORK_SHOW_TYPE_2_RED, 62 },
    { 414854, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 99 },
    { 414854, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 87 },
    { 416889, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 64 },
    { 416889, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 68 },
    { 417307, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 74 },
    { 418511, GO_FIREWORK_SHOW_TYPE_1_WHITE, 79 },
    { 418511, GO_FIREWORK_SHOW_TYPE_1_RED, 58 },
    { 418511, GO_FIREWORK_SHOW_TYPE_2_RED, 94 },
    { 418511, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 68 },
    { 418511, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 101 },
    { 419714, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 84 },
    { 419714, GO_FIREWORK_SHOW_TYPE_2_WHITE, 66 },
    { 421593, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 59 },
    { 421593, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 102 },
    { 421593, GO_FIREWORK_SHOW_TYPE_2_GREEN, 66 },
    { 422149, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 97 },
    { 423109, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 81 },
    { 423109, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 72 },
    { 423360, GO_FIREWORK_SHOW_TYPE_2_GREEN, 82 },
    { 424580, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 87 },
    { 424580, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 66 },
    { 424580, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 66 },
    { 424580, GO_FIREWORK_SHOW_TYPE_2_BLUE, 75 },
    { 426619, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 92 },
    { 426619, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 76 },
    { 426619, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 76 },
    { 426619, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 99 },
    { 427021, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 83 },
    { 428235, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 63 },
    { 428235, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 58 },
    { 428235, GO_FIREWORK_SHOW_TYPE_1_GREEN, 88 },
    { 429460, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 61 },
    { 429460, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 70 },
    { 429460, GO_FIREWORK_SHOW_TYPE_1_GREEN, 78 },
    { 429460, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 93 },
    { 429460, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 95 },
    { 429460, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 95 },
    { 431471, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 96 },
    { 431471, GO_FIREWORK_SHOW_TYPE_2_BLUE, 73 },
    { 431471, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 69 },
    { 433095, GO_FIREWORK_SHOW_TYPE_1_RED, 68 },
    { 433095, GO_FIREWORK_SHOW_TYPE_2_GREEN, 86 },
    { 433095, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 104 },
    { 433095, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 85 },
    { 434711, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 91 },
    { 434711, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 100 },
    { 434711, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 77 },
    { 434711, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 87 },
    { 436333, GO_FIREWORK_SHOW_TYPE_2_RED, 60 },
    { 436333, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 68 },
    { 437957, GO_FIREWORK_SHOW_TYPE_2_RED, 71 },
    { 437957, GO_FIREWORK_SHOW_TYPE_2_GREEN, 89 },
    { 437957, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 98 },
    { 439583, GO_FIREWORK_SHOW_TYPE_2_GREEN, 66 },
    { 439583, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 102 },
    { 439583, GO_FIREWORK_SHOW_TYPE_2_BLUE, 80 },
    { 441186, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 67 },
    { 441186, GO_FIREWORK_SHOW_TYPE_2_RED, 83 },
    { 441186, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 69 },
    { 441186, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 93 },
    { 441186, GO_FIREWORK_SHOW_TYPE_2_BLUE, 64 },
    { 441186, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 103 },
    { 444014, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 97 },
    { 444014, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 62 },
    { 446042, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 81 },
    { 446042, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 59 },
    { 447665, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 58 },
    { 448883, GO_FIREWORK_SHOW_TYPE_2_BLUE, 90 },
    { 448883, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 74 },
    { 448883, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 94 },
    { 448883, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 63 },
    { 450894, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 78 },
    { 450894, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 66 },
    { 450894, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 87 },
    { 450894, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 99 },
    { 450894, GO_FIREWORK_SHOW_TYPE_1_RED, 76 },
    { 452512, GO_FIREWORK_SHOW_TYPE_1_WHITE, 83 },
    { 452512, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 66 },
    { 453722, GO_FIREWORK_SHOW_TYPE_2_RED, 61 },
    { 453722, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 70 },
    { 453722, GO_FIREWORK_SHOW_TYPE_1_GREEN, 84 },
    { 455738, GO_FIREWORK_SHOW_TYPE_2_WHITE, 87 },
    { 455738, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 104 },
    { 455738, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 95 },
    { 457285, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 91 },
    { 457285, GO_FIREWORK_SHOW_TYPE_1_GREEN, 75 },
    { 457285, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 69 },
    { 458590, GO_FIREWORK_SHOW_TYPE_2_GREEN, 86 },
    { 458590, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 76 },
    { 461007, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 74 },
    { 462227, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 72 },
    { 462227, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 64 },
    { 462227, GO_FIREWORK_SHOW_TYPE_1_BLUE, 80 },
    { 462227, GO_FIREWORK_SHOW_TYPE_1_BLUE, 82 },
    { 462227, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 103 },
    { 463421, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 66 },
    { 463421, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 97 },
    { 463421, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 93 },
    { 464646, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 58 },
    { 465461, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 67 },
    { 465461, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 77 },
    { 465865, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 59 },
    { 467083, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 60 },
    { 467083, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 60 },
    { 467901, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 73 },
    { 467901, GO_FIREWORK_SHOW_TYPE_1_GREEN, 102 },
    { 467901, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 87 },
    { 468307, GO_FIREWORK_SHOW_TYPE_2_RED, 69 },
    { 469510, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 100 },
    { 469510, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 68 },
    { 470732, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 71 },
    { 471951, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 98 },
    { 473152, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 63 },
    { 473152, GO_FIREWORK_SHOW_TYPE_1_BLUE, 90 },
    { 473959, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 95 },
    { 474371, GO_FIREWORK_SHOW_TYPE_2_BLUE, 89 },
    { 474371, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 79 },
    { 476809, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 65 },
    { 476809, GO_FIREWORK_SHOW_TYPE_1_GREEN, 92 },
    { 477624, GO_FIREWORK_SHOW_TYPE_1_WHITE, 70 },
    { 478036, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 86 },
    { 479252, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 101 },
    { 479252, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 62 },
    { 480050, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 72 },
    { 480050, GO_FIREWORK_SHOW_TYPE_1_WHITE, 66 },
    { 480050, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 91 },
    { 480050, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 103 },
    { 480453, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 74 },
    { 480453, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 96 },
    { 481652, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 76 },
    { 481652, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 75 },
    { 481652, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 61 },
    { 481652, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 88 },
    { 481652, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 83 },
    { 481652, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 69 },
    { 482858, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 58 },
    { 482858, GO_FIREWORK_SHOW_TYPE_2_GREEN, 66 },
    { 482858, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 74 },
    { 484897, GO_FIREWORK_SHOW_TYPE_1_GREEN, 73 },
    { 484897, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 60 },
    { 484897, GO_FIREWORK_SHOW_TYPE_2_WHITE, 58 },
    { 484897, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 68 },
    { 487728, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 89 },
    { 487728, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 66 },
    { 487728, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 81 },
    { 487728, GO_FIREWORK_SHOW_TYPE_1_BLUE, 82 },
    { 487728, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 97 },
    { 489732, GO_FIREWORK_SHOW_TYPE_2_GREEN, 80 },
    { 489732, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 72 },
    { 489732, GO_FIREWORK_SHOW_TYPE_1_WHITE, 87 },
    { 491340, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 101 },
    { 492552, GO_FIREWORK_SHOW_TYPE_2_WHITE, 100 },
    { 492552, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 71 },
    { 492552, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 77 },
    { 494572, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 85 },
    { 494572, GO_FIREWORK_SHOW_TYPE_1_GREEN, 90 },
    { 494572, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 69 },
    { 494572, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 84 },
    { 494572, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 87 },
    { 495913, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 99 },
    { 495913, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 64 },
    { 495913, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 95 },
    { 497397, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 104 },
    { 497397, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 92 },
    { 499410, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 97 },
    { 499410, GO_FIREWORK_SHOW_TYPE_1_BLUE, 102 },
    { 501038, GO_FIREWORK_SHOW_TYPE_1_RED, 60 },
    { 501038, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 66 },
    { 501038, GO_FIREWORK_SHOW_TYPE_1_WHITE, 79 },
    { 501038, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 91 },
    { 501038, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 74 },
    { 502256, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 103 },
    { 502256, GO_FIREWORK_SHOW_TYPE_1_WHITE, 59 },
    { 503469, GO_FIREWORK_SHOW_TYPE_1_BLUE, 73 },
    { 504278, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 70 },
    { 504278, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 80 },
    { 504682, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 89 },
    { 504682, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 76 },
    { 505895, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 61 },
    { 507105, GO_FIREWORK_SHOW_TYPE_1_WHITE, 83 },
    { 507105, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 101 },
    { 509112, GO_FIREWORK_SHOW_TYPE_1_GREEN, 63 },
    { 509112, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 58 },
    { 509526, GO_FIREWORK_SHOW_TYPE_1_RED, 72 },
    { 509526, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 69 },
    { 510727, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 96 },
    { 510727, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 83 },
    { 510727, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 62 },
    { 511536, GO_FIREWORK_SHOW_TYPE_2_GREEN, 81 },
    { 511939, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 82 },
    { 511939, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 58 },
    { 511939, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 98 },
    { 513151, GO_FIREWORK_SHOW_TYPE_2_BLUE, 65 },
    { 513957, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 67 },
    { 513957, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 94 },
    { 515575, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 64 },
    { 515575, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 93 },
    { 515575, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 100 },
    { 515575, GO_FIREWORK_SHOW_TYPE_1_WHITE, 68 },
    { 516382, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 66 },
    { 516382, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 91 },
    { 516787, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 95 },
    { 516787, GO_FIREWORK_SHOW_TYPE_2_RED, 66 },
    { 518804, GO_FIREWORK_SHOW_TYPE_2_WHITE, 77 },
    { 519207, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 83 },
    { 519207, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 61 },
    { 519207, GO_FIREWORK_SHOW_TYPE_2_GREEN, 80 },
    { 520428, GO_FIREWORK_SHOW_TYPE_1_BLUE, 102 },
    { 521238, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 76 },
    { 521238, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 79 },
    { 521238, GO_FIREWORK_SHOW_TYPE_2_WHITE, 97 },
    { 521238, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 103 },
    { 521238, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 78 },
    { 521633, GO_FIREWORK_SHOW_TYPE_2_RED, 68 },
    { 521633, GO_FIREWORK_SHOW_TYPE_2_WHITE, 74 },
    { 521633, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 71 },
    { 522847, GO_FIREWORK_SHOW_TYPE_2_GREEN, 85 },
    { 524057, GO_FIREWORK_SHOW_TYPE_1_GREEN, 92 },
    { 525272, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 90 },
    { 525272, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 104 },
    { 525272, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 101 },
    { 525272, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 72 },
    { 525272, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 69 },
    { 525272, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 63 },
    { 526090, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 87 },
    { 526491, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 64 },
    { 526491, GO_FIREWORK_SHOW_TYPE_1_RED, 83 },
    { 526491, GO_FIREWORK_SHOW_TYPE_2_BLUE, 86 },
    { 527703, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 73 },
    { 528520, GO_FIREWORK_SHOW_TYPE_2_RED, 74 },
    { 528520, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 62 },
    { 530151, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 75 },
    { 530151, GO_FIREWORK_SHOW_TYPE_2_BLUE, 82 },
    { 531352, GO_FIREWORK_SHOW_TYPE_1_BLUE, 84 },
    { 531352, GO_FIREWORK_SHOW_TYPE_1_WHITE, 68 },
    { 532168, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 60 },
    { 535002, GO_FIREWORK_SHOW_TYPE_2_RED, 95 },
    { 535002, GO_FIREWORK_SHOW_TYPE_2_WHITE, 98 },
    { 535002, GO_FIREWORK_SHOW_TYPE_1_RED, 71 },
    { 535002, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 93 },
    { 536226, GO_FIREWORK_SHOW_TYPE_1_WHITE, 96 },
    { 536226, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 66 },
    { 536226, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 76 },
    { 536226, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 72 },
    { 536226, GO_FIREWORK_SHOW_TYPE_1_GREEN, 81 },
    { 538251, GO_FIREWORK_SHOW_TYPE_1_GREEN, 99 },
    { 538251, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 66 },
    { 538251, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 58 },
    { 538657, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 80 },
    { 539871, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 59 },
    { 539871, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 103 },
    { 539871, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 67 },
    { 539871, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 69 },
    { 539871, GO_FIREWORK_SHOW_TYPE_1_WHITE, 77 },
    { 540677, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 83 },
    { 541079, GO_FIREWORK_SHOW_TYPE_2_BLUE, 86 },
    { 541079, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 58 },
    { 541079, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 65 },
    { 541079, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 65 },
    { 543107, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 87 },
    { 543107, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 64 },
    { 543107, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 89 },
    { 543509, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 104 },
    { 543509, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 104 },
    { 545540, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 63 },
    { 545944, GO_FIREWORK_SHOW_TYPE_2_GREEN, 102 },
    { 548378, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 61 },
    { 548378, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 69 },
    { 548378, GO_FIREWORK_SHOW_TYPE_1_WHITE, 91 },
    { 548378, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 79 },
    { 549593, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 66 },
    { 549593, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 88 },
    { 549593, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 74 },
    { 549593, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 72 },
    { 549593, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 72 },
    { 550403, GO_FIREWORK_SHOW_TYPE_2_WHITE, 74 },
    { 550403, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 92 },
    { 550805, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 97 },
    { 552013, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 90 },
    { 552812, GO_FIREWORK_SHOW_TYPE_2_GREEN, 82 },
    { 552812, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 98 },
    { 552812, GO_FIREWORK_SHOW_TYPE_1_RED, 87 },
    { 553214, GO_FIREWORK_SHOW_TYPE_2_GREEN, 80 },
    { 553214, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 87 },
    { 554436, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 96 },
    { 554436, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 70 },
    { 555247, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 81 },
    { 555657, GO_FIREWORK_SHOW_TYPE_1_GREEN, 85 },
    { 555657, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 72 },
    { 557691, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 77 },
    { 557691, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 83 },
    { 558092, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 63 },
    { 558092, GO_FIREWORK_SHOW_TYPE_1_GREEN, 75 },
    { 559303, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 95 },
    { 560108, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 78 },
    { 560108, GO_FIREWORK_SHOW_TYPE_1_GREEN, 102 },
    { 561739, GO_FIREWORK_SHOW_TYPE_2_WHITE, 76 },
    { 561739, GO_FIREWORK_SHOW_TYPE_2_BLUE, 89 },
    { 562153, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 62 },
    { 562153, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 73 },
    { 562153, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 103 },
    { 562964, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 66 },
    { 562964, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 68 },
    { 564195, GO_FIREWORK_SHOW_TYPE_1_RED, 67 },
    { 564195, GO_FIREWORK_SHOW_TYPE_2_BLUE, 82 },
    { 564195, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 93 },
    { 565402, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 58 },
    { 565402, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 97 },
    { 565402, GO_FIREWORK_SHOW_TYPE_1_WHITE, 91 },
    { 565402, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 101 },
    { 565402, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 60 },
    { 566219, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 104 },
    { 566624, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 100 },
    { 566624, GO_FIREWORK_SHOW_TYPE_1_GREEN, 86 },
    { 568242, GO_FIREWORK_SHOW_TYPE_2_WHITE, 69 },
    { 568242, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 99 },
    { 568242, GO_FIREWORK_SHOW_TYPE_1_BLUE, 66 },
    { 569058, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 58 },
    { 570266, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 88 },
    { 571078, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 61 },
    { 571483, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 66 },
    { 572301, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 74 },
    { 572695, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 83 },
    { 572695, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 64 },
    { 573906, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 98 },
    { 573906, GO_FIREWORK_SHOW_TYPE_2_WHITE, 77 },
    { 573906, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 92 },
    { 575128, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 74 },
    { 575128, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 85 },
    { 575128, GO_FIREWORK_SHOW_TYPE_2_BLUE, 65 },
    { 575128, GO_FIREWORK_SHOW_TYPE_1_RED, 71 },
    { 577155, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 69 },
    { 577155, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 102 },
    { 577155, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 70 },
    { 577155, GO_FIREWORK_SHOW_TYPE_1_GREEN, 80 },
    { 578770, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 91 },
    { 579589, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 59 },
    { 579589, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 84 },
    { 579984, GO_FIREWORK_SHOW_TYPE_2_GREEN, 81 },
    { 579984, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 58 },
    { 579984, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 94 },
    { 581196, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 76 },
    { 582004, GO_FIREWORK_SHOW_TYPE_2_WHITE, 87 },
    { 582403, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 101 },
    { 583620, GO_FIREWORK_SHOW_TYPE_1_RED, 72 },
    { 583620, GO_FIREWORK_SHOW_TYPE_2_WHITE, 68 },
    { 583620, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 72 },
    { 583620, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 95 },
    { 584435, GO_FIREWORK_SHOW_TYPE_1_BLUE, 89 },
    { 584841, GO_FIREWORK_SHOW_TYPE_2_BLUE, 66 },
    { 584841, GO_FIREWORK_SHOW_TYPE_2_GREEN, 90 },
    { 584841, GO_FIREWORK_SHOW_TYPE_2_RED, 58 },
    { 586053, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 83 },
    { 586053, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 98 },
    { 586859, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 87 },
    { 586859, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 103 },
    { 586859, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 83 },
    { 587275, GO_FIREWORK_SHOW_TYPE_2_BLUE, 75 },
    { 588495, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 61 },
    { 589301, GO_FIREWORK_SHOW_TYPE_2_BLUE, 63 },
    { 589706, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 76 },
    { 590916, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 73 },
    { 591723, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 78 },
    { 591723, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 77 },
    { 593350, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 67 },
    { 593350, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 69 },
    { 594166, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 100 },
    { 594580, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 66 },
    { 594580, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 82 },
    { 594580, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 70 },
    { 595792, GO_FIREWORK_SHOW_TYPE_1_WHITE, 97 },
    { 595792, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 92 },
    { 597017, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 95 },
    { 597017, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 96 },
    { 598227, GO_FIREWORK_SHOW_TYPE_2_BLUE, 65 },
    { 599034, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 83 },
    { 600657, GO_FIREWORK_SHOW_TYPE_1_BLUE, 64 },
    { 601463, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 68 },
    { 601874, GO_FIREWORK_SHOW_TYPE_1_GREEN, 81 },
    { 601874, GO_FIREWORK_SHOW_TYPE_1_BLUE, 102 },
    { 601874, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 59 },
    { 601874, GO_FIREWORK_SHOW_TYPE_1_WHITE, 74 },
    { 603091, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 69 },
    { 603091, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 60 },
    { 603091, GO_FIREWORK_SHOW_TYPE_2_WHITE, 87 },
    { 603091, GO_FIREWORK_SHOW_TYPE_2_RED, 68 },
    { 603091, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 93 },
    { 603091, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 93 },
    { 603908, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 89 },
    { 603908, GO_FIREWORK_SHOW_TYPE_1_BLUE, 86 },
    { 605106, GO_FIREWORK_SHOW_TYPE_1_RED, 62 },
    { 605511, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 71 },
    { 605511, GO_FIREWORK_SHOW_TYPE_2_GREEN, 66 },
    { 605511, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 74 },
    { 606321, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 76 },
    { 606321, GO_FIREWORK_SHOW_TYPE_1_RED, 83 },
    { 606724, GO_FIREWORK_SHOW_TYPE_2_BLUE, 88 },
    { 606724, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 79 },
    { 606724, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 72 },
    { 607953, GO_FIREWORK_SHOW_TYPE_1_GREEN, 75 },
    { 608771, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 94 },
    { 609164, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 58 },
    { 609164, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 91 },
    { 611181, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 69 },
    { 611181, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 97 },
    { 611181, GO_FIREWORK_SHOW_TYPE_2_WHITE, 83 },
    { 611586, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 98 },
    { 612806, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 66 },
    { 612806, GO_FIREWORK_SHOW_TYPE_1_BLUE, 65 },
    { 612806, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 66 },
    { 612806, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 76 },
    { 612806, GO_FIREWORK_SHOW_TYPE_2_RED, 95 },
    { 612806, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 58 },
    { 614015, GO_FIREWORK_SHOW_TYPE_1_BLUE, 85 },
    { 614015, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 80 },
    { 614834, GO_FIREWORK_SHOW_TYPE_2_GREEN, 73 },
    { 616046, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 72 },
    { 616046, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 70 },
    { 617577, GO_FIREWORK_SHOW_TYPE_1_BLUE, 89 },
    { 617577, GO_FIREWORK_SHOW_TYPE_1_WHITE, 68 },
    { 617577, GO_FIREWORK_SHOW_TYPE_1_WHITE, 74 },
    { 617577, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 66 },
    { 617577, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 96 },
    { 617577, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 86 },
    { 617577, GO_FIREWORK_SHOW_TYPE_2_BLUE, 63 },
    { 617577, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 59 },
    { 617577, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 61 },
    { 617577, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 71 },
    { 617577, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 67 },
    { 617577, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 83 },
    { 617577, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 74 },
    { 617577, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 102 },
    { 617577, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 69 },
    { 617577, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 99 },
    { 617577, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 76 },
    { 617577, GO_FIREWORK_SHOW_TYPE_1_GREEN, 78 },
    { 618887, GO_FIREWORK_SHOW_TYPE_2_RED, 104 },
    { 618887, GO_FIREWORK_SHOW_TYPE_1_BLUE, 81 },
    { 618887, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 87 },
    { 618887, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 88 },
    { 618887, GO_FIREWORK_SHOW_TYPE_2_BLUE, 92 },
    { 618887, GO_FIREWORK_SHOW_TYPE_2_BLUE, 90 },
    { 618887, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 77 },
    { 618887, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 101 },
    { 618887, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 62 },
    { 618887, GO_FIREWORK_SHOW_TYPE_1_GREEN, 82 },
    { 618887, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 68 },
    { 618887, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 64 },
    { 618887, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 84 },
    { 620919, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 94 },
    { 620919, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 72 },
    { 620919, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 79 },
    { 620919, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 91 },
    { 620919, GO_FIREWORK_SHOW_TYPE_1_GREEN, 75 },
    { 622559, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 100 },
    { 622559, GO_FIREWORK_SHOW_TYPE_1_WHITE, 58 },
    { 623368, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 97 },
    { 623368, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 98 },
    { 623781, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 65 },
    { 623781, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 76 },
    { 623781, GO_FIREWORK_SHOW_TYPE_2_RED, 93 },
    { 623781, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 66 },
    { 623781, GO_FIREWORK_SHOW_TYPE_1_RED, 95 },
    { 623781, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 60 },
    { 623781, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 58 },
    { 624987, GO_FIREWORK_SHOW_TYPE_2_WHITE, 83 },
    { 624987, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 69 },
    { 625797, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 66 },
    { 626203, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 85 },
    { 627419, GO_FIREWORK_SHOW_TYPE_1_GREEN, 73 },
    { 628233, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 80 },
    { 628648, GO_FIREWORK_SHOW_TYPE_2_WHITE, 74 },
    { 628648, GO_FIREWORK_SHOW_TYPE_2_RED, 83 },
    { 628648, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 70 },
    { 629465, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 62 },
    { 630677, GO_FIREWORK_SHOW_TYPE_1_WHITE, 103 },
    { 630677, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 67 },
    { 630677, GO_FIREWORK_SHOW_TYPE_1_BLUE, 89 },
    { 630677, GO_FIREWORK_SHOW_TYPE_1_BLUE, 99 },
    { 630677, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 96 },
    { 630677, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 102 },
    { 630677, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 72 },
    { 630677, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 69 },
    { 630677, GO_FIREWORK_SHOW_TYPE_2_GREEN, 78 },
    { 630677, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 87 },
    { 631080, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 81 },
    { 631080, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 88 },
    { 631080, GO_FIREWORK_SHOW_TYPE_2_WHITE, 77 },
    { 631080, GO_FIREWORK_SHOW_TYPE_1_BLUE, 82 },
    { 631080, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 92 },
    { 631080, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 87 },
    { 631080, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 104 },
    { 632291, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 74 },
    { 632291, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 86 },
    { 632291, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 101 },
    { 632291, GO_FIREWORK_SHOW_TYPE_1_BLUE, 63 },
    { 632291, GO_FIREWORK_SHOW_TYPE_2_GREEN, 75 },
    { 632291, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 59 },
    { 632291, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 68 },
    { 632291, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 61 },
    { 632291, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 71 },
    { 632291, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 76 },
    { 632291, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 66 },
    { 633018, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 68 },
    { 633018, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 64 },
    { 633018, GO_FIREWORK_SHOW_TYPE_2_GREEN, 90 },
    { 633018, GO_FIREWORK_SHOW_TYPE_2_GREEN, 84 },
    { 633494, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 91 },
    { 633494, GO_FIREWORK_SHOW_TYPE_2_WHITE, 79 },
    { 633494, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 100 },
    { 633494, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 72 },
    { 635520, GO_FIREWORK_SHOW_TYPE_1_GREEN, 85 },
    { 635520, GO_FIREWORK_SHOW_TYPE_2_RED, 94 },
    { 635520, GO_FIREWORK_SHOW_TYPE_1_WHITE, 58 },
    { 635920, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 97 },
    { 635920, GO_FIREWORK_SHOW_TYPE_2_WHITE, 69 },
    { 635920, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 76 },
    { 635920, GO_FIREWORK_SHOW_TYPE_2_RED, 93 },
    { 635920, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 58 },
    { 637959, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 83 },
    { 637959, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 60 },
    { 637959, GO_FIREWORK_SHOW_TYPE_2_RED, 95 },
    { 637959, GO_FIREWORK_SHOW_TYPE_1_WHITE, 66 },
    { 637959, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 65 },
    { 637959, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 98 },
    { 638362, GO_FIREWORK_SHOW_TYPE_1_RED, 66 },
    { 638362, GO_FIREWORK_SHOW_TYPE_1_RED, 66 },
    { 639170, GO_FIREWORK_SHOW_TYPE_1_GREEN, 73 },
    { 640787, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 80 },
    { 642000, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 72 },
    { 642000, GO_FIREWORK_SHOW_TYPE_1_RED, 67 },
    { 642000, GO_FIREWORK_SHOW_TYPE_1_RED, 83 },
    { 642000, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 89 },
    { 642000, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 102 },
    { 642000, GO_FIREWORK_SHOW_TYPE_2_RED, 62 },
    { 642000, GO_FIREWORK_SHOW_TYPE_1_WHITE, 70 },
    { 642000, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 104 },
    { 642000, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 103 },
    { 642808, GO_FIREWORK_SHOW_TYPE_1_BLUE, 88 },
    { 643222, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 69 },
    { 643222, GO_FIREWORK_SHOW_TYPE_1_RED, 87 },
    { 643222, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 78 },
    { 643222, GO_FIREWORK_SHOW_TYPE_1_BLUE, 99 },
    { 643222, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 96 },
    { 643222, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 74 },
    { 643222, GO_FIREWORK_SHOW_TYPE_2_BLUE, 92 },
    { 644022, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 71 },
    { 644022, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 101 },
    { 644426, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 84 },
    { 644426, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 81 },
    { 644426, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 75 },
    { 644426, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 87 },
    { 644426, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 86 },
    { 644426, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 77 },
    { 645242, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 91 },
    { 645242, GO_FIREWORK_SHOW_TYPE_1_WHITE, 100 },
    { 645647, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 68 },
    { 645647, GO_FIREWORK_SHOW_TYPE_2_GREEN, 90 },
    { 645647, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 59 },
    { 645647, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 76 },
    { 645647, GO_FIREWORK_SHOW_TYPE_2_RED, 74 },
    { 645647, GO_FIREWORK_SHOW_TYPE_1_BLUE, 63 },
    { 645647, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 64 },
    { 645647, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 68 },
    { 645647, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 66 },
    { 645647, GO_FIREWORK_SHOW_TYPE_2_BLUE, 82 },
    { 645647, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 61 },
    { 646861, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 72 },
    { 646861, GO_FIREWORK_SHOW_TYPE_2_WHITE, 79 },
    { 647677, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 93 },
    { 647677, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 94 },
    { 647677, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 85 },
    { 647677, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 69 },
    { 649303, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 97 },
    { 649303, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 58 },
    { 649303, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 76 },
    { 649303, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 58 },
    { 650109, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 65 },
    { 650109, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 73 },
    { 650109, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 60 },
    { 650109, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 66 },
    { 650109, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 98 },
    { 650109, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 83 },
    { 650109, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 66 },
    { 651743, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 95 },
    { 654983, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 103 },
    { 654983, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 83 },
    { 654983, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 69 },
    { 655396, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 68 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_BLUE, 89 },
    { 656608, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 96 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 101 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 62 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 104 },
    { 656608, GO_FIREWORK_SHOW_TYPE_1_GREEN, 86 },
    { 656608, GO_FIREWORK_SHOW_TYPE_1_GREEN, 92 },
    { 656608, GO_FIREWORK_SHOW_TYPE_1_GREEN, 99 },
    { 656608, GO_FIREWORK_SHOW_TYPE_1_GREEN, 88 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_WHITE, 77 },
    { 656608, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 67 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 81 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 68 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_RED, 71 },
    { 656608, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 70 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 75 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 80 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 78 },
    { 656608, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 87 },
    { 657415, GO_FIREWORK_SHOW_TYPE_1_GREEN, 63 },
    { 657415, GO_FIREWORK_SHOW_TYPE_1_WHITE, 91 },
    { 657415, GO_FIREWORK_SHOW_TYPE_1_WHITE, 59 },
    { 657415, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 82 },
    { 657816, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 74 },
    { 657816, GO_FIREWORK_SHOW_TYPE_1_GREEN, 102 },
    { 657816, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 87 },
    { 657816, GO_FIREWORK_SHOW_TYPE_2_RED, 72 },
    { 657816, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 84 },
    { 658622, GO_FIREWORK_SHOW_TYPE_2_RED, 61 },
    { 659026, GO_FIREWORK_SHOW_TYPE_2_BLUE, 90 },
    { 659026, GO_FIREWORK_SHOW_TYPE_2_BLUE, 66 },
    { 659026, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 100 },
    { 659026, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 64 },
    { 659026, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 76 },
    { 659026, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 74 },
    { 659026, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 74 },
    { 659834, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 58 },
    { 659834, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 83 },
    { 659834, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 98 },
    { 660248, GO_FIREWORK_SHOW_TYPE_2_GREEN, 85 },
    { 660248, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 69 },
    { 660248, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 94 },
    { 660248, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 79 },
    { 660248, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 72 },
    { 660248, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 93 },
    { 661468, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 60 },
    { 661468, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 65 },
    { 661468, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 66 },
    { 662677, GO_FIREWORK_SHOW_TYPE_1_BLUE, 73 },
    { 662677, GO_FIREWORK_SHOW_TYPE_1_WHITE, 97 },
    { 662677, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 76 },
    { 662677, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 66 },
    { 662677, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 58 },
    { 663900, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 95 },
    { 664696, GO_FIREWORK_SHOW_TYPE_1_WHITE, 103 },
    { 666312, GO_FIREWORK_SHOW_TYPE_1_RED, 69 },
    { 666312, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 71 },
    { 667118, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 70 },
    { 667118, GO_FIREWORK_SHOW_TYPE_1_GREEN, 99 },
    { 667523, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 83 },
    { 668749, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 89 },
    { 668749, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 86 },
    { 668749, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 92 },
    { 668749, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 67 },
    { 668749, GO_FIREWORK_SHOW_TYPE_2_BLUE, 75 },
    { 668749, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 87 },
    { 668749, GO_FIREWORK_SHOW_TYPE_1_GREEN, 81 },
    { 669950, GO_FIREWORK_SHOW_TYPE_2_GREEN, 88 },
    { 669950, GO_FIREWORK_SHOW_TYPE_2_GREEN, 78 },
    { 669950, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 101 },
    { 669950, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 80 },
    { 669950, GO_FIREWORK_SHOW_TYPE_2_RED, 68 },
    { 669950, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 96 },
    { 669950, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 77 },
    { 669950, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 68 },
    { 669950, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 62 },
    { 669950, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 104 },
    { 669950, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 100 },
    { 671158, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 74 },
    { 671158, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 79 },
    { 671158, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 72 },
    { 671976, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 66 },
    { 671976, GO_FIREWORK_SHOW_TYPE_1_GREEN, 84 },
    { 671976, GO_FIREWORK_SHOW_TYPE_2_GREEN, 63 },
    { 671976, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 102 },
    { 671976, GO_FIREWORK_SHOW_TYPE_2_WHITE, 58 },
    { 671976, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 59 },
    { 671976, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 83 },
    { 671976, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 74 },
    { 671976, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 90 },
    { 671976, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 98 },
    { 672381, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 93 },
    { 672381, GO_FIREWORK_SHOW_TYPE_1_WHITE, 69 },
    { 672381, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 60 },
    { 672381, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 94 },
    { 672381, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 72 },
    { 672381, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 65 },
    { 673178, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 61 },
    { 673178, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 87 },
    { 673178, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 76 },
    { 673582, GO_FIREWORK_SHOW_TYPE_2_BLUE, 64 },
    { 673582, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 95 },
    { 673582, GO_FIREWORK_SHOW_TYPE_1_GREEN, 82 },
    { 673582, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 73 },
    { 673582, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 91 },
    { 674401, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 85 },
    { 674401, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 66 },
    { 674401, GO_FIREWORK_SHOW_TYPE_1_WHITE, 105 },
    { 674808, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 58 },
    { 674808, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 97 },
    { 674808, GO_FIREWORK_SHOW_TYPE_1_RED, 66 },
    { 676828, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 76 },
    { 677234, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 103 },
    { 678445, GO_FIREWORK_SHOW_TYPE_2_BLUE, 84 },
    { 678445, GO_FIREWORK_SHOW_TYPE_2_GREEN, 102 },
    { 678445, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 75 },
    { 678445, GO_FIREWORK_SHOW_TYPE_2_GREEN, 78 },
    { 678445, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 90 },
    { 678445, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 80 },
    { 678445, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 69 },
    { 679262, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 83 },
    { 679262, GO_FIREWORK_SHOW_TYPE_2_BLUE, 99 },
    { 679262, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 69 },
    { 679262, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 70 },
    { 679666, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 72 },
    { 679666, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 93 },
    { 679666, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 87 },
    { 679666, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 74 },
    { 679666, GO_FIREWORK_SHOW_TYPE_1_RED, 60 },
    { 679666, GO_FIREWORK_SHOW_TYPE_2_GREEN, 92 },
    { 679666, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 63 },
    { 679666, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 83 },
    { 679666, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 104 },
    { 679666, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 72 },
    { 679666, GO_FIREWORK_SHOW_TYPE_1_BLUE, 89 },
    { 679666, GO_FIREWORK_SHOW_TYPE_1_BLUE, 65 },
    { 679666, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 79 },
    { 679666, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 68 },
    { 679666, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 81 },
    { 680878, GO_FIREWORK_SHOW_TYPE_2_RED, 71 },
    { 680878, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 68 },
    { 680878, GO_FIREWORK_SHOW_TYPE_1_RED, 94 },
    { 680878, GO_FIREWORK_SHOW_TYPE_1_RED, 61 },
    { 680878, GO_FIREWORK_SHOW_TYPE_1_RED, 62 },
    { 680878, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 101 },
    { 680878, GO_FIREWORK_SHOW_TYPE_2_RED, 76 },
    { 680878, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 67 },
    { 681687, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 98 },
    { 681687, GO_FIREWORK_SHOW_TYPE_2_BLUE, 88 },
    { 681687, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 58 },
    { 681687, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 86 },
    { 681687, GO_FIREWORK_SHOW_TYPE_2_WHITE, 74 },
    { 681687, GO_FIREWORK_SHOW_TYPE_1_BLUE, 66 },
    { 681687, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 100 },
    { 681687, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 87 },
    { 681687, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 59 },
    { 681687, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 96 },
    { 681687, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 77 },
};

// <mapId, zoneId>, <fireworkShow pointer, fireworkShow count>
std::map<std::pair<uint32, uint32>, std::pair<FireworkShow*, uint32>> const FireworkShowStore = {
    // Teldrassil
    { { 1, 141 }, { &fireworkShowTeldrassil, fireworkShowTeldrassil.size() }},
    // Stormwind
    { { 0, 1519 }, { &fireworkShowStormwind, fireworkShowStormwind.size() }},
};

struct go_cheer_speaker : public GameObjectAI
{
    go_cheer_speaker(GameObject* go) : GameObjectAI(go)
    {
        _curIdx = 0;
        _curTS = 0;;
        _showRunning = false;
        _fireworkShow = nullptr;
        _maxCount = 0;

        initShow();
        stopShow();
        startShow();
    }

    void initShow()
    {
        _fireworkShow = nullptr;
        _maxCount = 0;

        auto itr = FireworkShowStore.find(std::make_pair(me->GetMapId(), me->GetZoneId()));
        if (itr != FireworkShowStore.end())
        {
            if (itr->second.first)
            {
                _fireworkShow = itr->second.first;
                _maxCount = itr->second.second;

                LOG_ERROR("scripts.midsummer", "initShow(): guid {} _maxcount {}", me->GetSpawnId(), _maxCount);
            }
        }
    }

    // TODO: provide start offset to handle a "late start"
    // e.g. if the gameobject is spawned later then the desired start time
    void startShow()
    {
        if (!_fireworkShow || !_maxCount)
            return;

        _curIdx = 0;
        _curTS = 0;
        _showRunning = true;
        _scheduler.CancelAll();

        me->setActive(true);

        _scheduler.Schedule(Milliseconds(_curTS), [this](TaskContext context)
            {
                int32 dt = 0;
                do {
                    dt = spawnNextFirework();
                } while (dt == 0);

                if (0 < dt)
                    context.Repeat(Milliseconds(dt));
                else
                {
                    stopShow();
                    LOG_ERROR("scripts.midsummer", "go_cheer_speaker: could not schedule next firework explosion in {} ms.", dt);
                }
            });

        LOG_ERROR("scripts.midsummer", "startShow()");
    }

    void stopShow()
    {
        _showRunning = false;
        _scheduler.CancelAll();

        me->setActive(false);

        LOG_ERROR("scripts.midsummer", "stopShow()");
    }

    int32 spawnNextFirework()
    {
        if (!_showRunning)
            return -1;

        if (!_fireworkShow || !_maxCount)
            return -2;

        if (_curIdx >= _maxCount)
            return -3;

        LOG_ERROR("scripts.midsummer", "spawnNextFirework() {}, {}, {}, {}", _curIdx, (*_fireworkShow)[_curIdx][1], (*_fireworkShow)[_curIdx][2], (*_fireworkShow)[_curIdx][3]);

        uint32 posIdx = (*_fireworkShow)[_curIdx][2];
        if (posIdx < COUNT_FIREWORK_SPAWN_POSITIONS)
        {
            me->SummonGameObject((*_fireworkShow)[_curIdx][1],
                fireworkSpawnPosition[posIdx][0],
                fireworkSpawnPosition[posIdx][1],
                fireworkSpawnPosition[posIdx][2],
                fireworkSpawnPosition[posIdx][3],
                fireworkSpawnPosition[posIdx][4],
                fireworkSpawnPosition[posIdx][5],
                fireworkSpawnPosition[posIdx][6],
                fireworkSpawnPosition[posIdx][7],
                0);
        }

        _curTS = (*_fireworkShow)[_curIdx][0];

        if (++_curIdx >= _maxCount)
            return -4;

        if ((*_fireworkShow)[_curIdx][0] < _curTS)
            return -5;

        return ((*_fireworkShow)[_curIdx][0] - _curTS);
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

private:
    TaskScheduler _scheduler;
    uint32_t _curIdx;
    uint32_t _curTS;
    bool _showRunning;
    FireworkShow* _fireworkShow;
    uint32 _maxCount;
};

void AddSC_event_midsummer_scripts()
{
    // Player
    new MidsummerPlayerScript();

    // NPCs
    RegisterCreatureAI(npc_midsummer_bonfire);
    RegisterCreatureAI(npc_midsummer_torch_target);
    RegisterCreatureAI(npc_midsummer_ribbon_pole_target);

    // Spells
    RegisterSpellScript(spell_fire_festival_fortitude);
    RegisterSpellScript(spell_bonfires_blessing);
    RegisterSpellScript(spell_gen_crab_disguise);
    RegisterSpellScript(spell_midsummer_ribbon_pole_firework);
    RegisterSpellScript(spell_midsummer_ribbon_pole);
    RegisterSpellScript(spell_midsummer_ribbon_pole_visual);
    RegisterSpellScript(spell_midsummer_torch_quest);
    RegisterSpellScript(spell_midsummer_fling_torch);
    RegisterSpellScript(spell_midsummer_juggling_torch);
    RegisterSpellScript(spell_midsummer_torch_catch);
    RegisterSpellScript(spell_midsummer_summon_ahune_lieutenant);

    // Gameobjects
    RegisterGameObjectAI(go_cheer_speaker);
}
