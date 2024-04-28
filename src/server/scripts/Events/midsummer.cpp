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

    COUNT_FIREWORK_SPAWN_POSITIONS      = 240,
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
    // Shattrath
    { -1953.7327f, 5493.0854f, 65.47611f, 0.03490625f, 0.0f, 0.0f, 0.01745224f, 0.9998477f }, /* 106 */
    { -1925.1945f, 5513.9263f, 50.570976f, 0.9773831f, 0.0f, 0.0f, 0.46947098f, 0.8829479f }, /* 107 */
    { -1890.7327f, 5518.5312f, 124.16628f, 0.13962449f, 0.0f, 0.0f, 0.069755554f, 0.99756414f }, /* 108 */
    { -1901.4132f, 5520.513f, 49.452927f, 4.7647495f, 0.0f, 0.0f, -0.6883545f, 0.72537446f }, /* 109 */
    { -1957.8995f, 5489.778f, 53.008453f, 3.7524624f, 0.0f, 0.0f, -0.9537163f, 0.3007079f }, /* 110 */
    { -1893.9121f, 5524.327f, 127.38159f, 4.729844f, 0.0f, 0.0f, -0.70090866f, 0.71325105f }, /* 111 */
    { -1892.115f, 5518.125f, 127.38158f, 3.47321f, 0.0f, 0.0f, -0.9862852f, 0.1650499f }, /* 112 */
    { -1932.2552f, 5515.8423f, 47.793182f, 0.9773831f, 0.0f, 0.0f, 0.46947098f, 0.8829479f }, /* 113 */
    { -1951.3529f, 5488.6636f, 62.32209f, 5.4803343f, 0.0f, 0.0f, -0.39073086f, 0.920505f }, /* 114 */
    { -1920.8403f, 5522.2603f, 56.411167f, 2.1991146f, 0.0f, 0.0f, 0.89100647f, 0.45399064f }, /* 115 */
    { -1911.6111f, 5528.2065f, 131.02745f, 0.13962449f, 0.0f, 0.0f, 0.069755554f, 0.99756414f }, /* 116 */
    { -1920.283f, 5522.5444f, 55.668182f, 2.1991146f, 0.0f, 0.0f, 0.89100647f, 0.45399064f }, /* 117 */
    { -1894.2687f, 5526.773f, 134.72224f, 1.5358895f, 0.0f, 0.0f, 0.6946583f, 0.71933985f }, /* 118 */
    { -1894.4896f, 5520.2163f, 126.29128f, 4.729844f, 0.0f, 0.0f, -0.70090866f, 0.71325105f }, /* 119 */
    { -1926.6498f, 5516.6147f, 60.574078f, 2.1467528f, 0.0f, 0.0f, 0.8788166f, 0.4771597f }, /* 120 */
    { -1938.8976f, 5500.0713f, 59.633465f, 4.7647495f, 0.0f, 0.0f, -0.6883545f, 0.72537446f }, /* 121 */
    { -1928.8563f, 5506.3696f, 65.78674f, 4.537859f, 0.0f, 0.0f, -0.76604366f, 0.6427886f }, /* 122 */
    { -1926.5973f, 5500.993f, 51.154263f, 5.8992143f, 0.0f, 0.0f, -0.1908083f, 0.9816273f }, /* 123 */
    { -1884.4916f, 5525.4595f, 138.67068f, 2.4609127f, 0.0f, 0.0f, 0.94264126f, 0.33380756f }, /* 124 */
    { -1922.3055f, 5516.318f, 51.251526f, 3.6826503f, 0.0f, 0.0f, -0.9636297f, 0.267241f }, /* 125 */
    { -1959.0267f, 5502.022f, 72.39326f, 5.5676007f, 0.0f, 0.0f, -0.35020733f, 0.9366722f }, /* 126 */
    { -1925.2096f, 5527.5083f, 64.94045f, 2.9146895f, 0.0f, 0.0f, 0.9935713f, 0.11320835f }, /* 127 */
    { -1902.9427f, 5512.882f, 129.11076f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 128 */
    { -1863.6598f, 5516.5005f, 152.0342f, 0.4886912f, 0.0f, 0.0f, 0.24192142f, 0.97029585f }, /* 129 */
    { -1913.8385f, 5512.8994f, 134.36772f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 130 */
    { -1905.2344f, 5517.9863f, 122.62465f, 3.7001047f, 0.0f, 0.0f, -0.9612608f, 0.2756405f }, /* 131 */
    { -1887.1146f, 5524.0845f, 128.63852f, 3.6302915f, 0.0f, 0.0f, -0.97029495f, 0.241925f }, /* 132 */
    { -1888.3021f, 5533.991f, 119.28162f, 4.886924f, 0.0f, 0.0f, -0.642787f, 0.766045f }, /* 133 */
    { -1908.4219f, 5533.026f, 55.564014f, 5.8468537f, 0.0f, 0.0f, -0.21643925f, 0.97629607f }, /* 134 */
    { -1896.1656f, 5528.8193f, 127.38157f, 3.6302915f, 0.0f, 0.0f, -0.97029495f, 0.241925f }, /* 135 */
    { -1934.4219f, 5507.1616f, 55.737637f, 5.8468537f, 0.0f, 0.0f, -0.21643925f, 0.97629607f }, /* 136 */
    { -1921.7656f, 5527.318f, 48.591785f, 5.8992143f, 0.0f, 0.0f, -0.1908083f, 0.9816273f }, /* 137 */
    { -1906.5729f, 5526.3716f, 124.31909f, 3.6302915f, 0.0f, 0.0f, -0.97029495f, 0.241925f }, /* 138 */
    { -1906.8822f, 5542.9033f, 139.3677f, 4.1364326f, 0.0f, 0.0f, -0.8788166f, 0.4771597f }, /* 139 */
    { -1892.4219f, 5536.0522f, 115.1312f, 3.7001047f, 0.0f, 0.0f, -0.9612608f, 0.2756405f }, /* 140 */
    { -1920.9653f, 5506.6274f, 54.654297f, 0.9773831f, 0.0f, 0.0f, 0.46947098f, 0.8829479f }, /* 141 */
    { -1927.9028f, 5511.308f, 53.307064f, 5.8992143f, 0.0f, 0.0f, -0.1908083f, 0.9816273f }, /* 142 */
    { -1926.5677f, 5508.0435f, 56.098743f, 2.1991146f, 0.0f, 0.0f, 0.89100647f, 0.45399064f }, /* 143 */
    { -1892.4381f, 5525.5137f, 140.31435f, 1.780234f, 0.0f, 0.0f, 0.7771454f, 0.6293211f }, /* 144 */
    { -1888.0764f, 5530.5376f, 138.77809f, 3.33359f, 0.0f, 0.0f, -0.99539566f, 0.095851235f }, /* 145 */
    { -1947.4833f, 5494.596f, 56.27001f, 3.33359f, 0.0f, 0.0f, -0.99539566f, 0.095851235f }, /* 146 */
    { -1933.2687f, 5489.0522f, 60.515415f, 4.590216f, 0.0f, 0.0f, -0.7489557f, 0.66262007f }, /* 147 */
    { -1938.7075f, 5501.201f, 70.25938f, 4.0666203f, 0.0f, 0.0f, -0.8949337f, 0.44619918f }, /* 148 */
    { -1897.6248f, 5513.669f, 112.59742f, 3.47321f, 0.0f, 0.0f, -0.9862852f, 0.1650499f }, /* 149 */
    { -1917.481f, 5527.0957f, 129.31909f, 0.13962449f, 0.0f, 0.0f, 0.069755554f, 0.99756414f }, /* 150 */
    { -1966.3066f, 5482.5117f, 63.678352f, 5.8992143f, 0.0f, 0.0f, -0.1908083f, 0.9816273f }, /* 151 */
    { -1903.9028f, 5531.2603f, 128.15936f, 3.47321f, 0.0f, 0.0f, -0.9862852f, 0.1650499f }, /* 152 */
    { -1929.7622f, 5529.528f, 58.62648f, 4.7647495f, 0.0f, 0.0f, -0.6883545f, 0.72537446f }, /* 153 */
    { -1936.6094f, 5498.205f, 54.378967f, 3.6826503f, 0.0f, 0.0f, -0.9636297f, 0.267241f }, /* 154 */
    { -1958.4102f, 5485.815f, 69.48078f, 2.2514734f, 0.0f, 0.0f, 0.902585f, 0.43051165f }, /* 155 */
    { -1887.118f, 5520.624f, 138.5246f, 4.729844f, 0.0f, 0.0f, -0.70090866f, 0.71325105f }, /* 156 */
    { -1900.724f, 5536.972f, 55.341816f, 5.8468537f, 0.0f, 0.0f, -0.21643925f, 0.97629607f }, /* 157 */
    { -1879.592f, 5519.54f, 130.4302f, 3.7001047f, 0.0f, 0.0f, -0.9612608f, 0.2756405f }, /* 158 */
    { -1917.2743f, 5508.244f, 124.72183f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 159 */
    { -1861.6823f, 5535.5913f, 132.30049f, 0.5235979f, 0.0f, 0.0f, 0.25881863f, 0.96592593f }, /* 160 */
    { -1886.2535f, 5525.5894f, 124.86077f, 4.886924f, 0.0f, 0.0f, -0.642787f, 0.766045f }, /* 161 */
    { -1897.4305f, 5521.8247f, 130.36078f, 4.886924f, 0.0f, 0.0f, -0.642787f, 0.766045f }, /* 162 */
    { -1909.7212f, 5527.297f, 151.74026f, 5.811947f, 0.0f, 0.0f, -0.23344517f, 0.97236997f }, /* 163 */
    { -1925.7966f, 5527.573f, 146.0328f, 2.3910985f, 0.0f, 0.0f, 0.93041706f, 0.3665025f }, /* 164 */
    { -1919.0087f, 5510.279f, 56.334854f, 3.6826503f, 0.0f, 0.0f, -0.9636297f, 0.267241f }, /* 165 */
    { -1906.9908f, 5541.2056f, 127.38161f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 166 */
    { -1893.8922f, 5529.355f, 71.766685f, 2.5481794f, 0.0f, 0.0f, 0.95630455f, 0.29237235f }, /* 167 */
    { -1915.4688f, 5510.3853f, 72.85928f, 2.1118479f, 0.0f, 0.0f, 0.8703556f, 0.4924237f }, /* 168 */
    { -1898.0729f, 5527.328f, 86.45237f, 4.66003f, 0.0f, 0.0f, -0.7253742f, 0.68835473f }, /* 169 */
    { -1916.401f, 5528.683f, 82.81958f, 6.073746f, 0.0f, 0.0f, -0.10452843f, 0.9945219f }, /* 170 */
    { -1924.0139f, 5521.0884f, 68.06493f, 6.073746f, 0.0f, 0.0f, -0.10452843f, 0.9945219f }, /* 171 */
    { -1909.4584f, 5526.4985f, 80.81576f, 2.5481794f, 0.0f, 0.0f, 0.95630455f, 0.29237235f }, /* 172 */
    // Silvermoon
    { 9411.597f, -7266.4204f, 102.0371f, 3.2637722f, 0.0f, 0.0f, -0.9981346f, 0.061051756f }, /* 173 */
    { 9399.398f, -7323.894f, 106.23338f, 2.6179893f, 0.0f, 0.0f, 0.9659252f, 0.2588213f }, /* 174 */
    { 9402.48f, -7333.2017f, 107.0458f, 2.4609127f, 0.0f, 0.0f, 0.94264126f, 0.33380756f }, /* 175 */
    { 9399.23f, -7310.8926f, 80.780266f, 2.879789f, 0.0f, 0.0f, 0.9914446f, 0.13052827f }, /* 176 */
    { 9464.217f, -7350.079f, 131.76024f, 0.5759573f, 0.0f, 0.0f, 0.2840147f, 0.9588199f }, /* 177 */
    { 9408.553f, -7254.359f, 103.79341f, 3.4557557f, 0.0f, 0.0f, -0.98768806f, 0.15643623f }, /* 178 */
    { 9473.886f, -7256.8867f, 108.98985f, 5.8294005f, 0.0f, 0.0f, -0.22495079f, 0.9743701f }, /* 179 */
    { 9474.942f, -7260.8457f, 125.85116f, 5.969027f, 0.0f, 0.0f, -0.15643406f, 0.98768836f }, /* 180 */
    { 9404.366f, -7275.1904f, 144.47037f, 3.0717661f, 0.0f, 0.0f, 0.9993906f, 0.034906134f }, /* 181 */
    { 9410.978f, -7300.815f, 109.29227f, 2.5830808f, 0.0f, 0.0f, 0.9612608f, 0.2756405f }, /* 182 */
    { 9482.511f, -7119.089f, 95.79392f, 6.021387f, 0.0f, 0.0f, -0.13052559f, 0.99144495f }, /* 183 */
    { 9430.171f, -7231.7056f, 114.68742f, 3.42085f, 0.0f, 0.0f, -0.99026775f, 0.13917536f }, /* 184 */
    { 9395.489f, -7278.119f, 77.25965f, 3.1066523f, 0.0f, 0.0f, 0.9998474f, 0.017469281f }, /* 185 */
    { 9411.504f, -7288.2017f, 112.26644f, 2.8448827f, 0.0f, 0.0f, 0.9890156f, 0.14781137f }, /* 186 */
    { 9412.064f, -7278.4927f, 116.04593f, 3.1066523f, 0.0f, 0.0f, 0.9998474f, 0.017469281f }, /* 187 */
    { 9431.971f, -7222.5015f, 95.89851f, 3.4557557f, 0.0f, 0.0f, -0.98768806f, 0.15643623f }, /* 188 */
    { 9484.801f, -7131.789f, 81.00427f, 6.1610126f, 0.0f, 0.0f, -0.061048508f, 0.9981348f }, /* 189 */
    { 9491.937f, -7154.4775f, 97.61007f, 0.052358884f, 0.0f, 0.0f, 0.026176453f, 0.99965733f }, /* 190 */
    { 9404.987f, -7279.1733f, 133.35152f, 2.9495955f, 0.0f, 0.0f, 0.99539566f, 0.095851235f }, /* 191 */
    { 9487.643f, -7155.1665f, 124.43807f, 0.12217299f, 0.0f, 0.0f, 0.061048508f, 0.9981348f }, /* 192 */
    { 9404.565f, -7330.9062f, 90.92167f, 2.740162f, 0.0f, 0.0f, 0.9799242f, 0.19937038f }, /* 193 */
    { 9403.582f, -7255.257f, 107.51928f, 3.2986872f, 0.0f, 0.0f, -0.9969168f, 0.07846643f }, /* 194 */
    { 9411.466f, -7252.6855f, 113.98392f, 3.33359f, 0.0f, 0.0f, -0.99539566f, 0.095851235f }, /* 195 */
    { 9416.494f, -7325.862f, 113.11375f, 2.652894f, 0.0f, 0.0f, 0.97029495f, 0.241925f }, /* 196 */
    { 9470.827f, -7304.2446f, 135.31717f, 6.2657332f, 0.0f, 0.0f, -0.00872612f, 0.9999619f }, /* 197 */
    { 9406.013f, -7302.038f, 109.12913f, 2.740162f, 0.0f, 0.0f, 0.9799242f, 0.19937038f }, /* 198 */
    { 9412.869f, -7276.2173f, 100.73974f, 3.1765332f, 0.0f, 0.0f, -0.9998474f, 0.017469281f }, /* 199 */
    { 9466.583f, -7307.3257f, 107.83662f, 0.104719326f, 0.0f, 0.0f, 0.05233574f, 0.99862957f }, /* 200 */
    { 9426.45f, -7221.809f, 95.899f, 3.6128378f, 0.0f, 0.0f, -0.9723692f, 0.23344836f }, /* 201 */
    { 9403.106f, -7309.0537f, 103.70203f, 2.9844983f, 0.0f, 0.0f, 0.9969168f, 0.07846643f }, /* 202 */
    { 9481.0625f, -7136.337f, 101.36688f, 0.017452462f, 0.0f, 0.0f, 0.00872612f, 0.9999619f }, /* 203 */
    { 9472.38f, -7267.314f, 140.30562f, 5.93412f, 0.0f, 0.0f, -0.17364788f, 0.9848078f }, /* 204 */
    { 9411.794f, -7285.174f, 101.23573f, 3.0891833f, 0.0f, 0.0f, 0.9996567f, 0.026201647f }, /* 205 */
    { 9405.042f, -7301.033f, 124.49238f, 2.967041f, 0.0f, 0.0f, 0.9961939f, 0.08716504f }, /* 206 */
    { 9403.265f, -7283.608f, 108.6991f, 3.1066523f, 0.0f, 0.0f, 0.9998474f, 0.017469281f }, /* 207 */
    { 9407.579f, -7277.173f, 145.9511f, 3.1590624f, 0.0f, 0.0f, -0.99996185f, 0.008734641f }, /* 208 */
    { 9472.98f, -7276.879f, 111.87194f, 6.056293f, 0.0f, 0.0f, -0.11320305f, 0.9935719f }, /* 209 */
    { 9399.838f, -7268.3696f, 72.05019f, 3.2114193f, 0.0f, 0.0f, -0.9993906f, 0.034906134f }, /* 210 */
    { 9456.133f, -7348.0244f, 104.9382f, 0.383971f, 0.0f, 0.0f, 0.1908083f, 0.9816273f }, /* 211 */
    { 9412.958f, -7276.9307f, 107.81713f, 3.1415927f, 0.0f, 0.0f, -1.0f, 0.0f }, /* 212 */
    { 9465.259f, -7310.388f, 113.23526f, 0.6283169f, 0.0f, 0.0f, 0.30901623f, 0.9510568f }, /* 213 */
    { 9465.2f, -7313.238f, 124.90273f, 0.22689247f, 0.0f, 0.0f, 0.11320305f, 0.9935719f }, /* 214 */
    { 9411.616f, -7322.223f, 79.953995f, 2.7227128f, 0.0f, 0.0f, 0.9781475f, 0.20791209f }, /* 215 */
    { 9480.151f, -7135.2544f, 120.9287f, 6.1959195f, 0.0f, 0.0f, -0.043619156f, 0.99904823f }, /* 216 */
    { 9398.232f, -7329.835f, 85.746056f, 2.7750685f, 0.0f, 0.0f, 0.98325443f, 0.18223801f }, /* 217 */
    { 9465.064f, -7316.58f, 144.71631f, 0.2967052f, 0.0f, 0.0f, 0.14780903f, 0.98901594f }, /* 218 */
    { 9393.978f, -7278.1685f, 71.72367f, 3.124123f, 0.0f, 0.0f, 0.99996185f, 0.008734641f }, /* 219 */
    { 9400.401f, -7268.281f, 114.68399f, 3.228859f, 0.0f, 0.0f, -0.99904823f, 0.04361926f }, /* 220 */
    { 9470.456f, -7300.8047f, 107.30139f, 0.087266f, 0.0f, 0.0f, 0.043619156f, 0.99904823f }, /* 221 */
    { 9478.615f, -7259.1426f, 109.0896f, 5.777041f, 0.0f, 0.0f, -0.25037956f, 0.96814775f }, /* 222 */
    { 9434.106f, -7236.9053f, 133.18169f, 3.368496f, 0.0f, 0.0f, -0.9935713f, 0.11320835f }, /* 223 */
    { 9409.207f, -7241.0938f, 85.7521f, 3.368496f, 0.0f, 0.0f, -0.9935713f, 0.11320835f }, /* 224 */
    { 9478.836f, -7127.272f, 95.90057f, 6.143561f, 0.0f, 0.0f, -0.069755554f, 0.99756414f }, /* 225 */
    { 9476.116f, -7270.055f, 105.02333f, 6.003934f, 0.0f, 0.0f, -0.13917255f, 0.9902682f }, /* 226 */
    { 9398.225f, -7284.489f, 81.34821f, 3.0194132f, 0.0f, 0.0f, 0.9981346f, 0.061051756f }, /* 227 */
    { 9485.356f, -7110.3726f, 104.19723f, 6.03884f, 0.0f, 0.0f, -0.12186909f, 0.9925462f }, /* 228 */
    { 9410.442f, -7283.999f, 113.04888f, 3.1066523f, 0.0f, 0.0f, 0.9998474f, 0.017469281f }, /* 229 */
    { 9472.535f, -7267.201f, 112.17079f, 6.03884f, 0.0f, 0.0f, -0.12186909f, 0.9925462f }, /* 230 */
    { 9410.102f, -7295.561f, 143.46808f, 3.0194132f, 0.0f, 0.0f, 0.9981346f, 0.061051756f }, /* 231 */
    { 9411.763f, -7266.338f, 107.3137f, 3.1066523f, 0.0f, 0.0f, 0.9998474f, 0.017469281f }, /* 232 */
    { 9407.703f, -7330.9297f, 97.46037f, 2.5656319f, 0.0f, 0.0f, 0.9588194f, 0.28401646f }, /* 233 */
    { 9487.966f, -7268.014f, 119.88787f, 5.8294005f, 0.0f, 0.0f, -0.22495079f, 0.9743701f }, /* 234 */
    { 9407.249f, -7253.171f, 115.69591f, 3.3161445f, 0.0f, 0.0f, -0.9961939f, 0.08716504f }, /* 235 */
    { 9480.074f, -7163.523f, 113.2669f, 0.13962449f, 0.0f, 0.0f, 0.069755554f, 0.99756414f }, /* 236 */
    { 9475.1045f, -7306.7275f, 116.25413f, 0.17453213f, 0.0f, 0.0f, 0.08715534f, 0.9961947f }, /* 237 */
    { 9464.988f, -7319.2954f, 101.16375f, 0.26179817f, 0.0f, 0.0f, 0.13052559f, 0.99144495f }, /* 238 */
    { 9369.768f, -7276.374f, 14.240263f, 6.0912004f, 0.0f, 0.0f, -0.09584522f, 0.99539626f }, /* 239 */
};

// timestamp[ms], firework gameobject ID, fireworkSpawnPositionIndex
typedef std::vector<std::array<uint32, 3>> const FireworkShow;

// VerifiedBuild 50250
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

// VerifiedBuild 50250
FireworkShow fireworkShowShattrath =
{
    { 0, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 106 },
    { 816, GO_FIREWORK_SHOW_TYPE_2_BLUE, 107 },
    { 816, GO_FIREWORK_SHOW_TYPE_1_GREEN, 108 },
    { 2832, GO_FIREWORK_SHOW_TYPE_2_RED, 109 },
    { 4868, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 110 },
    { 5269, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 111 },
    { 6085, GO_FIREWORK_SHOW_TYPE_2_BLUE, 112 },
    { 7716, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 113 },
    { 7716, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 114 },
    { 7716, GO_FIREWORK_SHOW_TYPE_1_WHITE, 115 },
    { 7716, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 116 },
    { 8935, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 117 },
    { 8935, GO_FIREWORK_SHOW_TYPE_2_WHITE, 118 },
    { 8935, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 119 },
    { 8935, GO_FIREWORK_SHOW_TYPE_2_RED, 120 },
    { 10975, GO_FIREWORK_SHOW_TYPE_1_GREEN, 121 },
    { 10975, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 122 },
    { 10975, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 123 },
    { 12583, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 124 },
    { 12583, GO_FIREWORK_SHOW_TYPE_1_RED, 125 },
    { 12583, GO_FIREWORK_SHOW_TYPE_2_WHITE, 126 },
    { 13810, GO_FIREWORK_SHOW_TYPE_1_WHITE, 127 },
    { 13810, GO_FIREWORK_SHOW_TYPE_2_BLUE, 128 },
    { 14616, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 129 },
    { 15835, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 130 },
    { 15835, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 131 },
    { 17459, GO_FIREWORK_SHOW_TYPE_2_BLUE, 132 },
    { 17459, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 133 },
    { 17459, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 134 },
    { 17459, GO_FIREWORK_SHOW_TYPE_1_WHITE, 135 },
    { 18682, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 136 },
    { 20709, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 137 },
    { 20709, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 138 },
    { 20709, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 139 },
    { 20709, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 140 },
    { 22317, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 141 },
    { 22317, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 142 },
    { 22317, GO_FIREWORK_SHOW_TYPE_1_GREEN, 143 },
    { 23544, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 144 },
    { 25571, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 115 },
    { 25571, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 109 },
    { 25571, GO_FIREWORK_SHOW_TYPE_2_BLUE, 145 },
    { 27104, GO_FIREWORK_SHOW_TYPE_1_WHITE, 146 },
    { 27104, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 119 },
    { 27104, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 110 },
    { 28408, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 147 },
    { 28408, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 147 },
    { 30443, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 148 },
    { 32056, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 149 },
    { 32056, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 116 },
    { 32056, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 123 },
    { 33266, GO_FIREWORK_SHOW_TYPE_2_RED, 150 },
    { 33266, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 151 },
    { 33266, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 132 },
    { 36928, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 152 },
    { 36928, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 140 },
    { 38136, GO_FIREWORK_SHOW_TYPE_2_BLUE, 114 },
    { 38136, GO_FIREWORK_SHOW_TYPE_2_BLUE, 114 },
    { 41800, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 124 },
    { 41800, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 124 },
    { 44231, GO_FIREWORK_SHOW_TYPE_2_GREEN, 143 },
    { 45051, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 107 },
    { 45051, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 123 },
    { 46256, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 112 },
    { 46685, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 131 },
    { 46685, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 122 },
    { 47885, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 153 },
    { 47885, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 109 },
    { 49915, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 113 },
    { 51104, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 118 },
    { 51547, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 154 },
    { 51547, GO_FIREWORK_SHOW_TYPE_2_GREEN, 155 },
    { 51547, GO_FIREWORK_SHOW_TYPE_2_WHITE, 156 },
    { 51547, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 129 },
    { 51547, GO_FIREWORK_SHOW_TYPE_2_WHITE, 157 },
    { 52766, GO_FIREWORK_SHOW_TYPE_2_RED, 150 },
    { 52766, GO_FIREWORK_SHOW_TYPE_1_GREEN, 158 },
    { 52766, GO_FIREWORK_SHOW_TYPE_1_GREEN, 147 },
    { 52766, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 106 },
    { 52766, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 137 },
    { 52766, GO_FIREWORK_SHOW_TYPE_2_WHITE, 126 },
    { 53973, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 128 },
    { 54751, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 110 },
    { 54751, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 117 },
    { 54751, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 130 },
    { 54751, GO_FIREWORK_SHOW_TYPE_2_GREEN, 144 },
    { 54751, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 111 },
    { 54751, GO_FIREWORK_SHOW_TYPE_2_RED, 125 },
    { 56419, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 108 },
    { 56419, GO_FIREWORK_SHOW_TYPE_2_WHITE, 159 },
    { 56419, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 160 },
    { 57628, GO_FIREWORK_SHOW_TYPE_2_BLUE, 121 },
    { 57628, GO_FIREWORK_SHOW_TYPE_2_BLUE, 121 },
    { 59654, GO_FIREWORK_SHOW_TYPE_2_GREEN, 142 },
    { 59654, GO_FIREWORK_SHOW_TYPE_2_BLUE, 161 },
    { 60858, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 138 },
    { 61287, GO_FIREWORK_SHOW_TYPE_2_RED, 124 },
    { 61287, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 148 },
    { 62418, GO_FIREWORK_SHOW_TYPE_1_RED, 151 },
    { 62418, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 139 },
    { 62418, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 139 },
    { 64518, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 127 },
    { 64518, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 106 },
    { 66107, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 131 },
    { 66107, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 123 },
    { 69402, GO_FIREWORK_SHOW_TYPE_1_GREEN, 112 },
    { 69402, GO_FIREWORK_SHOW_TYPE_1_RED, 162 },
    { 69402, GO_FIREWORK_SHOW_TYPE_2_GREEN, 122 },
    { 72250, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 109 },
    { 72250, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 117 },
    { 72250, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 117 },
    { 74284, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 120 },
    { 74284, GO_FIREWORK_SHOW_TYPE_1_BLUE, 163 },
    { 74284, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 133 },
    { 74284, GO_FIREWORK_SHOW_TYPE_2_BLUE, 144 },
    { 75506, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 132 },
    { 75506, GO_FIREWORK_SHOW_TYPE_2_BLUE, 108 },
    { 75506, GO_FIREWORK_SHOW_TYPE_2_BLUE, 108 },
    { 75908, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 164 },
    { 77128, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 137 },
    { 77128, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 137 },
    { 77128, GO_FIREWORK_SHOW_TYPE_1_BLUE, 136 },
    { 77128, GO_FIREWORK_SHOW_TYPE_1_BLUE, 136 },
    { 79152, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 153 },
    { 79152, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 110 },
    { 80369, GO_FIREWORK_SHOW_TYPE_1_GREEN, 121 },
    { 80787, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 149 },
    { 80787, GO_FIREWORK_SHOW_TYPE_2_GREEN, 161 },
    { 84022, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 154 },
    { 84022, GO_FIREWORK_SHOW_TYPE_1_WHITE, 123 },
    { 84022, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 134 },
    { 85634, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 119 },
    { 85634, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 126 },
    { 86764, GO_FIREWORK_SHOW_TYPE_2_RED, 160 },
    { 86764, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 150 },
    { 86764, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 140 },
    { 86764, GO_FIREWORK_SHOW_TYPE_1_WHITE, 133 },
    { 86764, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 129 },
    { 86764, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 129 },
    { 90098, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 141 },
    { 90098, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 165 },
    { 90506, GO_FIREWORK_SHOW_TYPE_2_BLUE, 147 },
    { 90506, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 113 },
    { 90506, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 117 },
    { 90506, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 117 },
    { 90506, GO_FIREWORK_SHOW_TYPE_2_WHITE, 156 },
    { 90506, GO_FIREWORK_SHOW_TYPE_2_WHITE, 156 },
    { 91716, GO_FIREWORK_SHOW_TYPE_1_WHITE, 127 },
    { 91716, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 114 },
    { 91716, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 146 },
    { 91716, GO_FIREWORK_SHOW_TYPE_2_BLUE, 108 },
    { 93764, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 111 },
    { 93764, GO_FIREWORK_SHOW_TYPE_2_GREEN, 128 },
    { 93764, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 157 },
    { 95398, GO_FIREWORK_SHOW_TYPE_1_GREEN, 143 },
    { 95398, GO_FIREWORK_SHOW_TYPE_2_BLUE, 144 },
    { 96599, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 106 },
    { 96599, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 106 },
    { 98219, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 115 },
    { 98219, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 115 },
    { 99843, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 149 },
    { 100251, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 163 },
    { 100251, GO_FIREWORK_SHOW_TYPE_2_BLUE, 155 },
    { 100251, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 130 },
    { 101460, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 148 },
    { 101460, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 142 },
    { 101460, GO_FIREWORK_SHOW_TYPE_1_GREEN, 119 },
    { 101460, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 151 },
    { 101460, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 151 },
    { 102266, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 147 },
    { 102266, GO_FIREWORK_SHOW_TYPE_1_WHITE, 153 },
    { 102676, GO_FIREWORK_SHOW_TYPE_1_GREEN, 121 },
    { 102676, GO_FIREWORK_SHOW_TYPE_1_GREEN, 121 },
    { 105111, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 139 },
    { 105111, GO_FIREWORK_SHOW_TYPE_2_RED, 150 },
    { 105111, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 117 },
    { 105111, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 117 },
    { 106326, GO_FIREWORK_SHOW_TYPE_1_WHITE, 154 },
    { 106326, GO_FIREWORK_SHOW_TYPE_1_GREEN, 161 },
    { 106326, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 131 },
    { 106326, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 131 },
    { 107144, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 156 },
    { 107144, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 156 },
    { 108352, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 145 },
    { 108352, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 116 },
    { 108352, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 110 },
    { 109991, GO_FIREWORK_SHOW_TYPE_2_RED, 138 },
    { 109991, GO_FIREWORK_SHOW_TYPE_2_RED, 138 },
    { 111210, GO_FIREWORK_SHOW_TYPE_2_GREEN, 165 },
    { 112019, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 124 },
    { 112019, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 124 },
    { 112019, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 124 },
    { 113240, GO_FIREWORK_SHOW_TYPE_1_BLUE, 114 },
    { 113240, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 132 },
    { 116083, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 160 },
    { 116083, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 107 },
    { 116083, GO_FIREWORK_SHOW_TYPE_2_WHITE, 129 },
    { 116083, GO_FIREWORK_SHOW_TYPE_2_WHITE, 129 },
    { 116894, GO_FIREWORK_SHOW_TYPE_2_WHITE, 133 },
    { 116894, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 113 },
    { 118513, GO_FIREWORK_SHOW_TYPE_2_BLUE, 155 },
    { 119337, GO_FIREWORK_SHOW_TYPE_2_GREEN, 112 },
    { 119738, GO_FIREWORK_SHOW_TYPE_1_GREEN, 158 },
    { 121753, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 141 },
    { 121753, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 149 },
    { 121753, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 122 },
    { 121753, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 122 },
    { 122974, GO_FIREWORK_SHOW_TYPE_2_GREEN, 136 },
    { 123387, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 135 },
    { 124605, GO_FIREWORK_SHOW_TYPE_1_RED, 131 },
    { 125816, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 142 },
    { 125816, GO_FIREWORK_SHOW_TYPE_1_BLUE, 128 },
    { 128250, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 130 },
    { 128250, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 146 },
    { 129469, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 120 },
    { 129469, GO_FIREWORK_SHOW_TYPE_2_BLUE, 121 },
    { 129469, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 111 },
    { 129469, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 150 },
    { 129469, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 144 },
    { 130695, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 151 },
    { 130695, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 107 },
    { 132729, GO_FIREWORK_SHOW_TYPE_1_GREEN, 161 },
    { 132729, GO_FIREWORK_SHOW_TYPE_1_BLUE, 147 },
    { 134346, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 127 },
    { 136382, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 115 },
    { 137589, GO_FIREWORK_SHOW_TYPE_1_RED, 162 },
    { 137589, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 145 },
    { 137993, GO_FIREWORK_SHOW_TYPE_2_BLUE, 132 },
    { 139220, GO_FIREWORK_SHOW_TYPE_2_WHITE, 123 },
    { 139220, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 157 },
    { 139220, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 157 },
    { 141246, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 106 },
    { 142458, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 131 },
    { 142861, GO_FIREWORK_SHOW_TYPE_2_BLUE, 165 },
    { 142861, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 125 },
    { 142861, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 125 },
    { 144088, GO_FIREWORK_SHOW_TYPE_1_WHITE, 156 },
    { 144088, GO_FIREWORK_SHOW_TYPE_1_GREEN, 108 },
    { 144088, GO_FIREWORK_SHOW_TYPE_1_BLUE, 122 },
    { 144088, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 126 },
    { 144088, GO_FIREWORK_SHOW_TYPE_1_RED, 148 },
    { 144088, GO_FIREWORK_SHOW_TYPE_1_RED, 138 },
    { 145306, GO_FIREWORK_SHOW_TYPE_1_RED, 152 },
    { 145306, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 143 },
    { 145306, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 143 },
    { 147741, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 129 },
    { 148958, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 141 },
    { 148958, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 163 },
    { 148958, GO_FIREWORK_SHOW_TYPE_1_GREEN, 144 },
    { 148958, GO_FIREWORK_SHOW_TYPE_2_BLUE, 112 },
    { 148958, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 151 },
    { 150180, GO_FIREWORK_SHOW_TYPE_2_BLUE, 161 },
    { 150180, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 159 },
    { 150180, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 140 },
    { 150994, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 113 },
    { 150994, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 115 },
    { 150994, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 120 },
    { 152213, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 155 },
    { 152616, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 164 },
    { 152616, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 153 },
    { 152616, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 110 },
    { 152616, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 160 },
    { 155055, GO_FIREWORK_SHOW_TYPE_1_GREEN, 165 },
    { 155055, GO_FIREWORK_SHOW_TYPE_1_GREEN, 165 },
    { 157085, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 124 },
    { 157459, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 127 },
    { 158717, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 158 },
    { 158717, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 119 },
    { 158717, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 109 },
    { 158717, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 118 },
    { 159925, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 132 },
    { 159925, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 162 },
    { 160750, GO_FIREWORK_SHOW_TYPE_1_RED, 111 },
    { 161959, GO_FIREWORK_SHOW_TYPE_2_GREEN, 163 },
    { 162374, GO_FIREWORK_SHOW_TYPE_1_GREEN, 121 },
    { 163578, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 147 },
    { 163578, GO_FIREWORK_SHOW_TYPE_1_BLUE, 142 },
    { 164797, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 150 },
    { 164797, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 136 },
    { 164797, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 107 },
    { 166825, GO_FIREWORK_SHOW_TYPE_2_WHITE, 116 },
    { 168448, GO_FIREWORK_SHOW_TYPE_1_RED, 137 },
    { 168448, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 143 },
    { 169675, GO_FIREWORK_SHOW_TYPE_1_WHITE, 135 },
    { 169675, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 123 },
    { 171699, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 152 },
    { 171699, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 131 },
    { 173318, GO_FIREWORK_SHOW_TYPE_1_WHITE, 149 },
    { 173318, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 108 },
    { 173318, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 159 },
    { 174546, GO_FIREWORK_SHOW_TYPE_2_WHITE, 156 },
    { 174546, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 138 },
    { 174546, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 151 },
    { 174546, GO_FIREWORK_SHOW_TYPE_1_RED, 125 },
    { 176560, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 155 },
    { 178191, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 133 },
    { 178191, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 120 },
    { 181434, GO_FIREWORK_SHOW_TYPE_1_WHITE, 140 },
    { 181434, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 126 },
    { 181434, GO_FIREWORK_SHOW_TYPE_1_RED, 162 },
    { 181845, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 127 },
    { 183063, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 157 },
    { 184284, GO_FIREWORK_SHOW_TYPE_1_RED, 141 },
    { 184284, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 116 },
    { 184284, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 109 },
    { 184284, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 109 },
    { 185096, GO_FIREWORK_SHOW_TYPE_2_WHITE, 129 },
    { 186325, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 145 },
    { 187937, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 160 },
    { 187937, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 164 },
    { 189107, GO_FIREWORK_SHOW_TYPE_1_GREEN, 165 },
    { 189107, GO_FIREWORK_SHOW_TYPE_1_GREEN, 165 },
    { 191190, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 115 },
    { 191190, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 132 },
    { 191594, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 122 },
    { 194035, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 161 },
    { 194035, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 161 },
    { 194832, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 135 },
    { 194832, GO_FIREWORK_SHOW_TYPE_1_RED, 137 },
    { 194832, GO_FIREWORK_SHOW_TYPE_2_GREEN, 108 },
    { 194832, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 118 },
    { 194832, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 110 },
    { 194832, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 110 },
    { 196452, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 147 },
    { 197679, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 154 },
    { 197679, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 119 },
    { 198890, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 152 },
    { 199697, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 120 },
    { 199697, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 125 },
    { 200923, GO_FIREWORK_SHOW_TYPE_2_RED, 111 },
    { 201325, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 146 },
    { 201325, GO_FIREWORK_SHOW_TYPE_2_BLUE, 143 },
    { 202460, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 139 },
    { 203760, GO_FIREWORK_SHOW_TYPE_2_BLUE, 107 },
    { 203760, GO_FIREWORK_SHOW_TYPE_1_GREEN, 136 },
    { 203760, GO_FIREWORK_SHOW_TYPE_2_GREEN, 114 },
    { 203760, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 112 },
    { 203760, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 133 },
    { 204572, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 130 },
    { 205782, GO_FIREWORK_SHOW_TYPE_2_RED, 150 },
    { 207005, GO_FIREWORK_SHOW_TYPE_1_RED, 117 },
    { 208625, GO_FIREWORK_SHOW_TYPE_1_GREEN, 142 },
    { 208625, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 131 },
    { 208625, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 151 },
    { 208625, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 151 },
    { 209443, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 157 },
    { 210661, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 164 },
    { 210661, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 124 },
    { 211077, GO_FIREWORK_SHOW_TYPE_2_WHITE, 140 },
    { 212286, GO_FIREWORK_SHOW_TYPE_2_GREEN, 108 },
    { 213505, GO_FIREWORK_SHOW_TYPE_2_RED, 162 },
    { 213505, GO_FIREWORK_SHOW_TYPE_2_RED, 162 },
    { 217153, GO_FIREWORK_SHOW_TYPE_2_RED, 134 },
    { 217153, GO_FIREWORK_SHOW_TYPE_2_RED, 134 },
    { 217153, GO_FIREWORK_SHOW_TYPE_2_GREEN, 128 },
    { 217153, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 106 },
    { 219109, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 143 },
    { 219589, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 158 },
    { 220401, GO_FIREWORK_SHOW_TYPE_2_GREEN, 147 },
    { 220401, GO_FIREWORK_SHOW_TYPE_1_RED, 160 },
    { 222037, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 129 },
    { 222037, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 159 },
    { 222037, GO_FIREWORK_SHOW_TYPE_2_GREEN, 121 },
    { 222037, GO_FIREWORK_SHOW_TYPE_1_BLUE, 119 },
    { 223641, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 124 },
    { 223641, GO_FIREWORK_SHOW_TYPE_1_WHITE, 116 },
    { 224051, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 149 },
    { 224051, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 135 },
    { 224051, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 135 },
    { 224051, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 135 },
    { 224051, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 135 },
    { 225269, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 125 },
    { 225671, GO_FIREWORK_SHOW_TYPE_2_WHITE, 146 },
    { 225671, GO_FIREWORK_SHOW_TYPE_2_WHITE, 146 },
    { 226892, GO_FIREWORK_SHOW_TYPE_1_WHITE, 156 },
    { 226892, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 111 },
    { 226892, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 154 },
    { 228106, GO_FIREWORK_SHOW_TYPE_2_WHITE, 113 },
    { 228106, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 132 },
    { 228106, GO_FIREWORK_SHOW_TYPE_2_RED, 109 },
    { 228920, GO_FIREWORK_SHOW_TYPE_2_RED, 139 },
    { 230126, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 117 },
    { 230126, GO_FIREWORK_SHOW_TYPE_2_GREEN, 142 },
    { 230471, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 137 },
    { 233786, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 151 },
    { 233786, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 110 },
    { 235406, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 155 },
    { 235406, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 155 },
    { 236625, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 126 },
    { 238649, GO_FIREWORK_SHOW_TYPE_1_WHITE, 159 },
    { 239777, GO_FIREWORK_SHOW_TYPE_1_GREEN, 112 },
    { 239777, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 152 },
    { 240286, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 141 },
    { 241462, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 115 },
    { 242716, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 107 },
    { 242716, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 107 },
    { 244748, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 121 },
    { 244748, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 121 },
    { 245157, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 139 },
    { 246373, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 131 },
    { 246373, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 119 },
    { 246373, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 162 },
    { 246373, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 135 },
    { 247590, GO_FIREWORK_SHOW_TYPE_2_BLUE, 163 },
    { 247590, GO_FIREWORK_SHOW_TYPE_1_GREEN, 143 },
    { 247590, GO_FIREWORK_SHOW_TYPE_1_BLUE, 128 },
    { 247590, GO_FIREWORK_SHOW_TYPE_2_RED, 134 },
    { 249618, GO_FIREWORK_SHOW_TYPE_2_GREEN, 147 },
    { 250033, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 150 },
    { 250033, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 150 },
    { 251254, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 154 },
    { 251254, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 118 },
    { 251254, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 118 },
    { 251254, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 118 },
    { 252480, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 132 },
    { 252480, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 142 },
    { 252480, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 142 },
    { 253291, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 145 },
    { 253291, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 129 },
    { 253291, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 123 },
    { 254513, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 133 },
    { 254513, GO_FIREWORK_SHOW_TYPE_1_BLUE, 108 },
    { 254917, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 138 },
    { 254917, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 138 },
    { 256139, GO_FIREWORK_SHOW_TYPE_1_GREEN, 158 },
    { 256139, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 141 },
    { 256139, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 116 },
    { 257356, GO_FIREWORK_SHOW_TYPE_2_WHITE, 156 },
    { 257356, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 136 },
    { 257356, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 159 },
    { 259382, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 157 },
    { 259382, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 153 },
    { 259382, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 144 },
    { 261004, GO_FIREWORK_SHOW_TYPE_1_RED, 117 },
    { 261004, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 130 },
    { 262223, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 120 },
    { 262223, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 155 },
    { 262223, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 114 },
    { 264260, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 137 },
    { 264260, GO_FIREWORK_SHOW_TYPE_1_RED, 151 },
    { 265891, GO_FIREWORK_SHOW_TYPE_1_RED, 111 },
    { 265891, GO_FIREWORK_SHOW_TYPE_1_RED, 111 },
    { 269141, GO_FIREWORK_SHOW_TYPE_2_BLUE, 107 },
    { 269141, GO_FIREWORK_SHOW_TYPE_1_WHITE, 113 },
    { 269141, GO_FIREWORK_SHOW_TYPE_1_WHITE, 113 },
    { 270755, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 131 },
    { 270755, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 126 },
    { 271987, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 119 },
    { 271987, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 127 },
    { 273994, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 128 },
    { 273994, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 139 },
    { 273994, GO_FIREWORK_SHOW_TYPE_2_BLUE, 112 },
    { 273994, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 140 },
    { 273994, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 140 },
    { 273994, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 140 },
    { 276849, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 149 },
    { 276849, GO_FIREWORK_SHOW_TYPE_1_BLUE, 145 },
    { 276849, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 157 },
    { 278861, GO_FIREWORK_SHOW_TYPE_1_WHITE, 115 },
    { 278861, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 154 },
    { 278861, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 163 },
    { 278861, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 120 },
    { 278861, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 110 },
    { 278861, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 150 },
    { 280473, GO_FIREWORK_SHOW_TYPE_2_RED, 109 },
    { 280473, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 124 },
    { 280473, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 133 },
    { 283737, GO_FIREWORK_SHOW_TYPE_2_WHITE, 159 },
    { 283737, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 153 },
    { 285372, GO_FIREWORK_SHOW_TYPE_1_WHITE, 135 },
    { 286592, GO_FIREWORK_SHOW_TYPE_1_WHITE, 164 },
    { 286592, GO_FIREWORK_SHOW_TYPE_2_BLUE, 142 },
    { 288623, GO_FIREWORK_SHOW_TYPE_2_BLUE, 165 },
    { 290239, GO_FIREWORK_SHOW_TYPE_1_BLUE, 144 },
    { 290239, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 117 },
    { 291453, GO_FIREWORK_SHOW_TYPE_2_RED, 130 },
    { 291453, GO_FIREWORK_SHOW_TYPE_2_RED, 106 },
    { 291453, GO_FIREWORK_SHOW_TYPE_1_GREEN, 114 },
    { 293488, GO_FIREWORK_SHOW_TYPE_1_RED, 152 },
    { 293488, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 111 },
    { 296329, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 140 },
    { 296329, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 108 },
    { 296329, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 108 },
    { 297107, GO_FIREWORK_SHOW_TYPE_2_WHITE, 157 },
    { 298366, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 148 },
    { 298366, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 154 },
    { 298366, GO_FIREWORK_SHOW_TYPE_1_GREEN, 132 },
    { 298366, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 156 },
    { 299999, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 146 },
    { 299999, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 129 },
    { 299999, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 139 },
    { 301228, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 143 },
    { 301228, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 163 },
    { 303241, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 151 },
    { 303241, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 122 },
    { 304873, GO_FIREWORK_SHOW_TYPE_1_GREEN, 128 },
    { 304873, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 153 },
    { 304873, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 162 },
    { 304873, GO_FIREWORK_SHOW_TYPE_1_RED, 160 },
    { 306089, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 107 },
    { 306089, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 147 },
    { 306089, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 134 },
    { 308115, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 150 },
    { 308115, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 126 },
    { 309742, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 112 },
    { 309742, GO_FIREWORK_SHOW_TYPE_1_WHITE, 110 },
    { 310967, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 138 },
    { 310967, GO_FIREWORK_SHOW_TYPE_2_WHITE, 159 },
    { 310967, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 142 },
    { 313402, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 164 },
    { 313402, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 124 },
    { 313402, GO_FIREWORK_SHOW_TYPE_2_GREEN, 155 },
    { 313402, GO_FIREWORK_SHOW_TYPE_2_GREEN, 155 },
    { 314612, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 144 },
    { 314612, GO_FIREWORK_SHOW_TYPE_2_WHITE, 118 },
    { 315830, GO_FIREWORK_SHOW_TYPE_2_RED, 111 },
    { 315830, GO_FIREWORK_SHOW_TYPE_2_RED, 111 },
    { 319466, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 109 },
    { 320726, GO_FIREWORK_SHOW_TYPE_1_BLUE, 145 },
    { 320726, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 156 },
    { 320726, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 141 },
    { 320726, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 141 },
    { 320726, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 141 },
    { 321514, GO_FIREWORK_SHOW_TYPE_2_RED, 106 },
    { 321514, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 140 },
    { 322753, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 154 },
    { 322753, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 152 },
    { 322753, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 152 },
    { 322753, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 133 },
    { 323142, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 148 },
    { 324368, GO_FIREWORK_SHOW_TYPE_2_RED, 117 },
    { 324368, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 127 },
    { 325587, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 158 },
    { 325587, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 116 },
    { 326393, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 130 },
    { 326393, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 130 },
    { 327624, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 110 },
    { 327624, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 151 },
    { 327624, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 119 },
    { 327624, GO_FIREWORK_SHOW_TYPE_2_BLUE, 122 },
    { 329240, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 161 },
    { 329240, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 120 },
    { 330473, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 153 },
    { 331283, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 149 },
    { 332496, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 125 },
    { 333716, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 107 },
    { 334121, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 129 },
    { 334121, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 111 },
    { 334121, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 133 },
    { 334121, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 126 },
    { 334121, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 138 },
    { 334121, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 163 },
    { 335350, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 134 },
    { 336112, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 132 },
    { 337377, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 123 },
    { 338999, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 144 },
    { 338999, GO_FIREWORK_SHOW_TYPE_1_BLUE, 145 },
    { 338999, GO_FIREWORK_SHOW_TYPE_2_BLUE, 142 },
    { 340217, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 155 },
    { 340217, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 155 },
    { 340948, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 115 },
    { 341422, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 121 },
    { 342247, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 148 },
    { 342247, GO_FIREWORK_SHOW_TYPE_2_RED, 152 },
    { 342551, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 139 },
    { 343876, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 159 },
    { 343876, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 122 },
    { 345034, GO_FIREWORK_SHOW_TYPE_1_GREEN, 158 },
    { 345034, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 137 },
    { 345034, GO_FIREWORK_SHOW_TYPE_2_GREEN, 119 },
    { 345034, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 118 },
    { 345034, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 128 },
    { 345034, GO_FIREWORK_SHOW_TYPE_1_RED, 106 },
    { 345034, GO_FIREWORK_SHOW_TYPE_1_RED, 106 },
    { 347133, GO_FIREWORK_SHOW_TYPE_2_RED, 162 },
    { 347133, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 113 },
    { 348757, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 141 },
    { 349976, GO_FIREWORK_SHOW_TYPE_2_WHITE, 116 },
    { 352022, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 157 },
    { 352022, GO_FIREWORK_SHOW_TYPE_2_WHITE, 110 },
    { 352022, GO_FIREWORK_SHOW_TYPE_2_WHITE, 123 },
    { 352022, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 140 },
    { 352022, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 144 },
    { 353648, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 117 },
    { 353648, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 108 },
    { 354865, GO_FIREWORK_SHOW_TYPE_1_RED, 134 },
    { 354865, GO_FIREWORK_SHOW_TYPE_1_RED, 134 },
    { 359727, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 131 },
    { 359727, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 161 },
    { 359727, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 163 },
    { 361775, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 149 },
    { 361775, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 114 },
    { 363388, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 125 },
    { 363388, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 126 },
    { 364602, GO_FIREWORK_SHOW_TYPE_2_WHITE, 135 },
    { 364602, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 120 },
    { 364602, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 120 },
    { 364602, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 151 },
    { 366635, GO_FIREWORK_SHOW_TYPE_2_GREEN, 132 },
    { 366635, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 139 },
    { 367048, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 110 },
    { 367048, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 147 },
    { 368267, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 140 },
    { 368267, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 124 },
    { 369485, GO_FIREWORK_SHOW_TYPE_2_BLUE, 165 },
    { 369485, GO_FIREWORK_SHOW_TYPE_1_BLUE, 143 },
    { 369485, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 115 },
    { 369485, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 115 },
    { 371514, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 106 },
    { 371514, GO_FIREWORK_SHOW_TYPE_2_WHITE, 153 },
    { 371514, GO_FIREWORK_SHOW_TYPE_2_WHITE, 133 },
    { 371514, GO_FIREWORK_SHOW_TYPE_2_WHITE, 146 },
    { 371514, GO_FIREWORK_SHOW_TYPE_1_RED, 137 },
    { 373145, GO_FIREWORK_SHOW_TYPE_1_RED, 150 },
    { 375098, GO_FIREWORK_SHOW_TYPE_1_RED, 162 },
    { 376379, GO_FIREWORK_SHOW_TYPE_2_BLUE, 121 },
    { 376379, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 109 },
    { 376379, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 126 },
    { 377968, GO_FIREWORK_SHOW_TYPE_1_RED, 111 },
    { 377968, GO_FIREWORK_SHOW_TYPE_1_BLUE, 145 },
    { 379218, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 129 },
    { 381322, GO_FIREWORK_SHOW_TYPE_2_BLUE, 128 },
    { 382472, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 113 },
    { 382876, GO_FIREWORK_SHOW_TYPE_2_RED, 151 },
    { 382876, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 157 },
    { 382876, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 118 },
    { 382876, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 127 },
    { 382876, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 134 },
    { 384104, GO_FIREWORK_SHOW_TYPE_1_BLUE, 142 },
    { 384104, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 156 },
    { 384104, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 112 },
    { 384104, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 144 },
    { 384104, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 123 },
    { 384104, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 116 },
    { 384104, GO_FIREWORK_SHOW_TYPE_2_WHITE, 153 },
    { 386137, GO_FIREWORK_SHOW_TYPE_1_RED, 124 },
    { 387766, GO_FIREWORK_SHOW_TYPE_2_WHITE, 140 },
    { 387766, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 158 },
    { 387766, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 154 },
    { 387766, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 148 },
    { 387766, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 117 },
    { 391010, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 161 },
    { 391010, GO_FIREWORK_SHOW_TYPE_2_BLUE, 163 },
    { 391010, GO_FIREWORK_SHOW_TYPE_1_GREEN, 119 },
    { 392631, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 164 },
    { 392631, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 135 },
    { 393840, GO_FIREWORK_SHOW_TYPE_1_GREEN, 107 },
    { 393840, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 130 },
    { 393840, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 108 },
    { 395876, GO_FIREWORK_SHOW_TYPE_2_RED, 141 },
    { 395876, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 115 },
    { 395876, GO_FIREWORK_SHOW_TYPE_1_BLUE, 114 },
    { 395876, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 159 },
    { 400758, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 139 },
    { 403592, GO_FIREWORK_SHOW_TYPE_1_GREEN, 145 },
    { 403592, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 155 },
    { 403592, GO_FIREWORK_SHOW_TYPE_2_RED, 134 },
    { 403592, GO_FIREWORK_SHOW_TYPE_1_WHITE, 118 },
    { 404813, GO_FIREWORK_SHOW_TYPE_2_GREEN, 136 },
    { 405624, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 143 },
    { 405624, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 123 },
    { 406840, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 152 },
    { 407253, GO_FIREWORK_SHOW_TYPE_1_RED, 131 },
    { 407253, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 119 },
    { 408470, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 142 },
    { 408470, GO_FIREWORK_SHOW_TYPE_1_GREEN, 112 },
    { 408470, GO_FIREWORK_SHOW_TYPE_2_RED, 148 },
    { 408470, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 158 },
    { 408470, GO_FIREWORK_SHOW_TYPE_1_RED, 117 },
    { 408470, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 154 },
    { 408470, GO_FIREWORK_SHOW_TYPE_2_BLUE, 147 },
    { 409278, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 151 },
    { 410496, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 121 },
    { 410496, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 106 },
    { 412118, GO_FIREWORK_SHOW_TYPE_2_RED, 141 },
    { 412118, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 122 },
    { 412118, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 150 },
    { 413336, GO_FIREWORK_SHOW_TYPE_2_RED, 130 },
    { 413336, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 110 },
    { 413336, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 126 },
    { 415368, GO_FIREWORK_SHOW_TYPE_2_RED, 139 },
    { 415368, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 124 },
    { 415368, GO_FIREWORK_SHOW_TYPE_2_WHITE, 133 },
    { 416992, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 164 },
    { 416992, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 114 },
    { 416992, GO_FIREWORK_SHOW_TYPE_1_GREEN, 107 },
    { 416992, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 160 },
    { 416992, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 120 },
    { 418211, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 113 },
    { 418211, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 137 },
    { 420241, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 156 },
    { 420241, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 152 },
    { 420241, GO_FIREWORK_SHOW_TYPE_2_WHITE, 135 },
    { 421872, GO_FIREWORK_SHOW_TYPE_1_WHITE, 146 },
    { 421872, GO_FIREWORK_SHOW_TYPE_2_BLUE, 108 },
    { 421872, GO_FIREWORK_SHOW_TYPE_2_BLUE, 108 },
    { 423086, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 125 },
    { 426731, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 129 },
    { 426731, GO_FIREWORK_SHOW_TYPE_1_WHITE, 149 },
    { 426731, GO_FIREWORK_SHOW_TYPE_1_BLUE, 143 },
    { 426731, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 159 },
    { 427952, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 140 },
    { 427952, GO_FIREWORK_SHOW_TYPE_1_WHITE, 115 },
    { 427952, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 126 },
    { 427952, GO_FIREWORK_SHOW_TYPE_1_GREEN, 163 },
    { 427952, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 136 },
    { 429977, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 153 },
    { 430387, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 133 },
    { 430387, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 110 },
    { 431591, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 157 },
    { 431591, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 150 },
    { 432816, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 165 },
    { 432816, GO_FIREWORK_SHOW_TYPE_1_GREEN, 132 },
    { 436468, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 116 },
    { 436468, GO_FIREWORK_SHOW_TYPE_2_GREEN, 121 },
    { 437690, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 158 },
    { 437690, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 135 },
    { 439723, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 115 },
    { 439723, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 125 },
    { 439723, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 119 },
    { 441346, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 120 },
    { 442575, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 147 },
    { 443380, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 129 },
    { 443380, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 129 },
    { 444597, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 117 },
    { 444597, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 151 },
    { 444597, GO_FIREWORK_SHOW_TYPE_2_GREEN, 163 },
    { 446239, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 108 },
    { 446239, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 134 },
    { 447451, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 138 },
    { 447451, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 159 },
    { 447451, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 128 },
    { 447451, GO_FIREWORK_SHOW_TYPE_1_BLUE, 145 },
    { 447451, GO_FIREWORK_SHOW_TYPE_1_RED, 139 },
    { 447451, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 146 },
    { 449470, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 140 },
    { 451093, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 148 },
    { 452315, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 150 },
    { 453099, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 133 },
    { 453099, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 133 },
    { 455959, GO_FIREWORK_SHOW_TYPE_2_RED, 111 },
    { 457177, GO_FIREWORK_SHOW_TYPE_1_GREEN, 122 },
    { 457177, GO_FIREWORK_SHOW_TYPE_1_BLUE, 112 },
    { 457996, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 160 },
    { 457996, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 115 },
    { 459614, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 120 },
    { 459614, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 123 },
    { 462050, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 130 },
    { 462050, GO_FIREWORK_SHOW_TYPE_2_BLUE, 158 },
    { 462050, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 136 },
    { 462050, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 132 },
    { 462050, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 132 },
    { 462859, GO_FIREWORK_SHOW_TYPE_2_WHITE, 127 },
    { 464066, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 157 },
    { 464066, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 117 },
    { 464066, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 152 },
    { 465681, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 126 },
    { 465681, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 128 },
    { 465681, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 139 },
    { 465681, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 125 },
    { 466902, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 113 },
    { 467716, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 144 },
    { 469344, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 135 },
    { 470564, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 140 },
    { 471789, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 165 },
    { 471789, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 116 },
    { 471789, GO_FIREWORK_SHOW_TYPE_2_GREEN, 108 },
    { 471789, GO_FIREWORK_SHOW_TYPE_1_GREEN, 119 },
    { 472633, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 163 },
    { 473827, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 159 },
    { 473827, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 154 },
    { 475444, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 156 },
    { 475444, GO_FIREWORK_SHOW_TYPE_2_BLUE, 161 },
    { 477381, GO_FIREWORK_SHOW_TYPE_1_WHITE, 164 },
    { 477874, GO_FIREWORK_SHOW_TYPE_2_BLUE, 136 },
    { 479095, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 149 },
    { 479095, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 131 },
    { 479095, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 131 },
    { 479095, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 131 },
    { 480322, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 160 },
    { 480322, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 124 },
    { 480322, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 124 },
    { 481526, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 152 },
    { 481526, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 155 },
    { 482736, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 137 },
    { 483552, GO_FIREWORK_SHOW_TYPE_1_RED, 111 },
    { 483552, GO_FIREWORK_SHOW_TYPE_1_WHITE, 123 },
    { 484763, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 158 },
    { 485581, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 145 },
    { 486383, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 162 },
    { 487197, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 126 },
    { 487197, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 126 },
    { 488414, GO_FIREWORK_SHOW_TYPE_1_RED, 138 },
    { 488414, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 163 },
    { 488839, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 151 },
    { 489636, GO_FIREWORK_SHOW_TYPE_1_GREEN, 107 },
    { 489636, GO_FIREWORK_SHOW_TYPE_1_BLUE, 122 },
    { 489636, GO_FIREWORK_SHOW_TYPE_1_BLUE, 122 },
    { 489636, GO_FIREWORK_SHOW_TYPE_1_RED, 139 },
    { 490039, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 127 },
    { 490039, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 127 },
    { 491250, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 118 },
    { 491250, GO_FIREWORK_SHOW_TYPE_1_GREEN, 165 },
    { 492068, GO_FIREWORK_SHOW_TYPE_1_BLUE, 128 },
    { 492068, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 140 },
    { 493285, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 153 },
    { 493285, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 106 },
    { 493696, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 135 },
    { 494912, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 141 },
    { 494912, GO_FIREWORK_SHOW_TYPE_1_WHITE, 116 },
    { 494912, GO_FIREWORK_SHOW_TYPE_1_GREEN, 136 },
    { 496133, GO_FIREWORK_SHOW_TYPE_1_RED, 120 },
    { 496133, GO_FIREWORK_SHOW_TYPE_1_RED, 120 },
    { 496941, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 143 },
    { 497757, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 112 },
    { 497757, GO_FIREWORK_SHOW_TYPE_1_WHITE, 156 },
    { 497757, GO_FIREWORK_SHOW_TYPE_1_GREEN, 142 },
    { 499768, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 114 },
    { 499768, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 161 },
    { 499768, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 111 },
    { 499768, GO_FIREWORK_SHOW_TYPE_2_WHITE, 133 },
    { 499768, GO_FIREWORK_SHOW_TYPE_2_RED, 125 },
    { 500981, GO_FIREWORK_SHOW_TYPE_2_RED, 148 },
    { 500981, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 119 },
    { 503006, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 157 },
    { 503006, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 150 },
    { 504219, GO_FIREWORK_SHOW_TYPE_2_BLUE, 121 },
    { 505593, GO_FIREWORK_SHOW_TYPE_1_RED, 117 },
    { 506262, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 139 },
    { 508285, GO_FIREWORK_SHOW_TYPE_1_RED, 160 },
    { 509506, GO_FIREWORK_SHOW_TYPE_1_BLUE, 108 },
    { 510637, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 149 },
    { 510637, GO_FIREWORK_SHOW_TYPE_2_BLUE, 132 },
    { 510637, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 130 },
    { 511526, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 124 },
    { 511526, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 118 },
    { 511935, GO_FIREWORK_SHOW_TYPE_2_GREEN, 155 },
    { 511935, GO_FIREWORK_SHOW_TYPE_2_GREEN, 155 },
    { 512766, GO_FIREWORK_SHOW_TYPE_1_GREEN, 122 },
    { 512766, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 161 },
    { 512766, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 158 },
    { 514376, GO_FIREWORK_SHOW_TYPE_1_WHITE, 164 },
    { 514376, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 153 },
    { 516399, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 134 },
    { 516399, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 137 },
    { 516399, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 110 },
    { 516399, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 110 },
    { 517621, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 107 },
    { 517621, GO_FIREWORK_SHOW_TYPE_2_WHITE, 133 },
    { 519236, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 139 },
    { 519236, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 126 },
    { 520467, GO_FIREWORK_SHOW_TYPE_2_RED, 162 },
    { 522486, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 123 },
    { 522486, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 116 },
    { 522899, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 125 },
    { 524107, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 121 },
    { 524107, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 136 },
    { 524107, GO_FIREWORK_SHOW_TYPE_2_BLUE, 142 },
    { 524107, GO_FIREWORK_SHOW_TYPE_2_WHITE, 127 },
    { 524107, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 154 },
    { 525326, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 165 },
    { 525326, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 106 },
    { 527366, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 122 },
    { 527366, GO_FIREWORK_SHOW_TYPE_2_RED, 138 },
    { 528989, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 108 },
    { 528989, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 159 },
    { 530222, GO_FIREWORK_SHOW_TYPE_2_WHITE, 140 },
    { 530222, GO_FIREWORK_SHOW_TYPE_2_WHITE, 140 },
    { 532255, GO_FIREWORK_SHOW_TYPE_1_RED, 162 },
    { 533875, GO_FIREWORK_SHOW_TYPE_1_WHITE, 115 },
    { 537106, GO_FIREWORK_SHOW_TYPE_2_RED, 160 },
    { 537106, GO_FIREWORK_SHOW_TYPE_1_RED, 141 },
    { 537106, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 147 },
    { 538285, GO_FIREWORK_SHOW_TYPE_1_GREEN, 112 },
    { 538285, GO_FIREWORK_SHOW_TYPE_1_GREEN, 112 },
    { 538762, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 135 },
    { 538762, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 118 },
    { 538762, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 148 },
    { 539966, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 153 },
    { 539966, GO_FIREWORK_SHOW_TYPE_2_BLUE, 143 },
    { 539966, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 113 },
    { 540790, GO_FIREWORK_SHOW_TYPE_1_WHITE, 110 },
    { 542003, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 117 },
    { 542003, GO_FIREWORK_SHOW_TYPE_1_BLUE, 142 },
    { 544843, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 145 },
    { 546879, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 165 },
    { 546879, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 149 },
    { 546879, GO_FIREWORK_SHOW_TYPE_1_WHITE, 164 },
    { 546879, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 130 },
    { 546879, GO_FIREWORK_SHOW_TYPE_2_RED, 111 },
    { 548499, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 120 },
    { 548499, GO_FIREWORK_SHOW_TYPE_2_WHITE, 123 },
    { 548499, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 127 },
    { 548499, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 127 },
    { 550444, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 125 },
    { 550444, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 136 },
    { 550444, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 150 },
    { 551749, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 109 },
    { 553377, GO_FIREWORK_SHOW_TYPE_2_WHITE, 154 },
    { 553377, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 132 },
    { 554908, GO_FIREWORK_SHOW_TYPE_1_WHITE, 118 },
    { 554908, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 162 },
    { 554908, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 139 },
    { 554908, GO_FIREWORK_SHOW_TYPE_2_WHITE, 157 },
    { 557039, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 126 },
    { 558239, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 137 },
    { 558239, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 134 },
    { 558239, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 116 },
    { 558239, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 135 },
    { 558239, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 135 },
    { 560286, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 138 },
    { 561500, GO_FIREWORK_SHOW_TYPE_2_BLUE, 165 },
    { 561500, GO_FIREWORK_SHOW_TYPE_1_GREEN, 108 },
    { 561500, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 148 },
    { 561500, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 161 },
    { 563125, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 146 },
    { 563125, GO_FIREWORK_SHOW_TYPE_2_WHITE, 133 },
    { 563125, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 158 },
    { 563125, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 158 },
    { 564343, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 127 },
    { 564343, GO_FIREWORK_SHOW_TYPE_1_GREEN, 155 },
    { 564343, GO_FIREWORK_SHOW_TYPE_2_RED, 151 },
    { 565568, GO_FIREWORK_SHOW_TYPE_1_BLUE, 107 },
    { 566376, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 119 },
    { 566376, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 142 },
    { 566376, GO_FIREWORK_SHOW_TYPE_2_GREEN, 147 },
    { 566376, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 154 },
    { 566376, GO_FIREWORK_SHOW_TYPE_1_BLUE, 114 },
    { 566376, GO_FIREWORK_SHOW_TYPE_2_RED, 117 },
    { 567501, GO_FIREWORK_SHOW_TYPE_2_BLUE, 143 },
    { 567641, GO_FIREWORK_SHOW_TYPE_2_WHITE, 159 },
    { 567641, GO_FIREWORK_SHOW_TYPE_2_GREEN, 122 },
    { 569215, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 157 },
    { 569215, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 157 },
    { 571243, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 113 },
    { 571243, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 106 },
    { 572868, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 131 },
    { 572868, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 111 },
    { 574074, GO_FIREWORK_SHOW_TYPE_1_RED, 130 },
    { 575287, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 112 },
    { 576103, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 141 },
    { 576103, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 150 },
    { 577313, GO_FIREWORK_SHOW_TYPE_2_GREEN, 136 },
    { 578952, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 120 },
    { 578952, GO_FIREWORK_SHOW_TYPE_1_WHITE, 135 },
    { 578952, GO_FIREWORK_SHOW_TYPE_1_WHITE, 135 },
    { 580179, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 140 },
    { 580179, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 134 },
    { 580579, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 160 },
    { 582110, GO_FIREWORK_SHOW_TYPE_2_BLUE, 119 },
    { 582110, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 109 },
    { 582110, GO_FIREWORK_SHOW_TYPE_1_RED, 137 },
    { 582110, GO_FIREWORK_SHOW_TYPE_1_RED, 137 },
    { 582609, GO_FIREWORK_SHOW_TYPE_2_GREEN, 145 },
    { 585453, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 139 },
    { 585453, GO_FIREWORK_SHOW_TYPE_2_BLUE, 165 },
    { 585453, GO_FIREWORK_SHOW_TYPE_1_WHITE, 133 },
    { 587053, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 118 },
    { 587053, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 118 },
    { 588266, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 157 },
    { 588266, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 125 },
    { 589071, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 147 },
    { 590684, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 129 },
    { 590684, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 156 },
    { 591901, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 138 },
    { 593120, GO_FIREWORK_SHOW_TYPE_2_BLUE, 114 },
    { 593120, GO_FIREWORK_SHOW_TYPE_2_GREEN, 155 },
    { 593120, GO_FIREWORK_SHOW_TYPE_2_GREEN, 155 },
    { 593929, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 151 },
    { 595146, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 108 },
    { 595551, GO_FIREWORK_SHOW_TYPE_1_RED, 106 },
    { 595551, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 150 },
    { 598723, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 146 },
    { 598723, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 164 },
    { 600028, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 116 },
    { 600028, GO_FIREWORK_SHOW_TYPE_1_WHITE, 149 },
    { 600028, GO_FIREWORK_SHOW_TYPE_1_WHITE, 149 },
    { 600427, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 115 },
    { 601642, GO_FIREWORK_SHOW_TYPE_2_WHITE, 159 },
    { 601642, GO_FIREWORK_SHOW_TYPE_2_RED, 131 },
    { 602852, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 141 },
    { 602852, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 141 },
    { 603605, GO_FIREWORK_SHOW_TYPE_1_WHITE, 127 },
    { 603605, GO_FIREWORK_SHOW_TYPE_1_WHITE, 127 },
    { 606531, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 147 },
    { 606531, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 134 },
    { 606531, GO_FIREWORK_SHOW_TYPE_2_BLUE, 142 },
    { 606531, GO_FIREWORK_SHOW_TYPE_2_BLUE, 142 },
    { 607746, GO_FIREWORK_SHOW_TYPE_2_BLUE, 158 },
    { 607746, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 140 },
    { 608558, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 135 },
    { 610175, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 123 },
    { 610175, GO_FIREWORK_SHOW_TYPE_2_GREEN, 136 },
    { 611403, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 125 },
    { 611403, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 117 },
    { 611403, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 162 },
    { 611403, GO_FIREWORK_SHOW_TYPE_2_RED, 120 },
    { 613411, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 157 },
    { 613411, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 124 },
    { 615027, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 128 },
    { 615027, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 128 },
    { 616157, GO_FIREWORK_SHOW_TYPE_1_BLUE, 112 },
    { 616629, GO_FIREWORK_SHOW_TYPE_1_BLUE, 145 },
    { 616629, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 154 },
    { 616629, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 165 },
    { 618262, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 150 },
    { 618262, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 111 },
    { 618262, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 111 },
    { 619891, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 163 },
    { 619891, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 106 },
    { 619891, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 106 },
    { 621105, GO_FIREWORK_SHOW_TYPE_1_BLUE, 107 },
    { 621105, GO_FIREWORK_SHOW_TYPE_1_BLUE, 144 },
    { 621105, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 160 },
    { 622313, GO_FIREWORK_SHOW_TYPE_2_BLUE, 161 },
    { 622313, GO_FIREWORK_SHOW_TYPE_2_BLUE, 161 },
    { 622313, GO_FIREWORK_SHOW_TYPE_2_BLUE, 161 },
    { 623047, GO_FIREWORK_SHOW_TYPE_2_GREEN, 132 },
    { 623047, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 116 },
    { 624729, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 156 },
    { 627975, GO_FIREWORK_SHOW_TYPE_2_WHITE, 149 },
    { 629591, GO_FIREWORK_SHOW_TYPE_1_RED, 124 },
    { 629591, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 127 },
    { 629591, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 153 },
    { 629591, GO_FIREWORK_SHOW_TYPE_2_BLUE, 122 },
    { 629591, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 125 },
    { 629591, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 155 },
    { 629591, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 136 },
    { 629591, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 114 },
    { 629591, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 146 },
    { 630809, GO_FIREWORK_SHOW_TYPE_1_WHITE, 164 },
    { 630809, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 152 },
    { 630809, GO_FIREWORK_SHOW_TYPE_2_RED, 137 },
    { 630809, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 131 },
    { 632827, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 110 },
    { 635673, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 154 },
    { 635673, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 140 },
    { 636872, GO_FIREWORK_SHOW_TYPE_2_BLUE, 119 },
    { 637468, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 115 },
    { 639306, GO_FIREWORK_SHOW_TYPE_2_WHITE, 129 },
    { 640525, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 162 },
    { 640525, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 126 },
    { 641742, GO_FIREWORK_SHOW_TYPE_2_BLUE, 143 },
    { 642563, GO_FIREWORK_SHOW_TYPE_1_GREEN, 147 },
    { 642563, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 151 },
    { 642563, GO_FIREWORK_SHOW_TYPE_1_RED, 130 },
    { 643753, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 109 },
    { 644166, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 148 },
    { 644166, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 160 },
    { 644166, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 120 },
    { 644166, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 116 },
    { 645374, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 141 },
    { 645374, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 125 },
    { 646585, GO_FIREWORK_SHOW_TYPE_2_BLUE, 142 },
    { 647393, GO_FIREWORK_SHOW_TYPE_2_WHITE, 156 },
    { 647393, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 112 },
    { 648621, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 134 },
    { 649023, GO_FIREWORK_SHOW_TYPE_2_WHITE, 159 },
    { 649023, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 135 },
    { 650244, GO_FIREWORK_SHOW_TYPE_2_GREEN, 136 },
    { 650244, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 114 },
    { 650244, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 122 },
    { 650244, GO_FIREWORK_SHOW_TYPE_2_GREEN, 165 },
    { 650244, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 138 },
    { 650244, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 138 },
    { 651456, GO_FIREWORK_SHOW_TYPE_1_GREEN, 121 },
    { 652273, GO_FIREWORK_SHOW_TYPE_1_GREEN, 158 },
    { 653488, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 107 },
    { 653488, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 123 },
    { 653898, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 117 },
    { 653898, GO_FIREWORK_SHOW_TYPE_1_GREEN, 144 },
    { 653898, GO_FIREWORK_SHOW_TYPE_2_BLUE, 108 },
    { 655109, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 137 },
    { 655109, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 163 },
    { 655109, GO_FIREWORK_SHOW_TYPE_1_WHITE, 129 },
    { 655109, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 124 },
    { 656322, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 161 },
    { 657128, GO_FIREWORK_SHOW_TYPE_1_RED, 148 },
    { 658351, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 131 },
    { 658351, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 131 },
    { 658775, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 157 },
    { 658775, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 153 },
    { 658775, GO_FIREWORK_SHOW_TYPE_1_WHITE, 127 },
    { 658775, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 152 },
    { 659991, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 155 },
    { 659991, GO_FIREWORK_SHOW_TYPE_1_RED, 125 },
    { 659991, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 164 },
    { 659991, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 164 },
    { 661206, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 149 },
    { 663231, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 128 },
    { 663651, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 106 },
    { 664682, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 141 },
    { 665265, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 123 },
    { 666080, GO_FIREWORK_SHOW_TYPE_1_WHITE, 166 },
    { 666080, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 113 },
    { 666080, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 110 },
    { 668106, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 143 },
    { 668106, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 162 },
    { 668106, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 126 },
    { 668106, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 133 },
    { 668106, GO_FIREWORK_SHOW_TYPE_2_RED, 150 },
    { 668511, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 140 },
    { 668511, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 167 },
    { 668511, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 159 },
    { 668511, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 164 },
    { 668511, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 134 },
    { 668511, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 109 },
    { 668511, GO_FIREWORK_SHOW_TYPE_1_GREEN, 147 },
    { 668511, GO_FIREWORK_SHOW_TYPE_2_GREEN, 144 },
    { 668511, GO_FIREWORK_SHOW_TYPE_2_WHITE, 135 },
    { 668511, GO_FIREWORK_SHOW_TYPE_2_WHITE, 118 },
    { 668511, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 108 },
    { 668511, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 152 },
    { 668511, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 157 },
    { 668511, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 121 },
    { 668511, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 127 },
    { 668511, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 161 },
    { 668511, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 111 },
    { 668511, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 132 },
    { 669725, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 130 },
    { 669725, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 117 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 168 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 153 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 116 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 114 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_BLUE, 169 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_BLUE, 155 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_BLUE, 122 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_GREEN, 112 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 141 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 125 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 131 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_GREEN, 165 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 106 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_GREEN, 170 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_WHITE, 123 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 124 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 139 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_RED, 171 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 115 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_BLUE, 163 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_RED, 160 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 137 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 120 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 129 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 142 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 107 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 128 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 158 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 172 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 148 },
    { 670428, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 154 },
    { 670428, GO_FIREWORK_SHOW_TYPE_1_WHITE, 149 },
    { 671782, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 151 },
    { 673386, GO_FIREWORK_SHOW_TYPE_2_WHITE, 146 },
    { 674607, GO_FIREWORK_SHOW_TYPE_2_WHITE, 156 },
    { 675827, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 136 },
    { 675827, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 136 },
    { 677866, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 145 },
    { 677866, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 119 },
    { 677866, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 119 },
    { 679186, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 138 },
};

// VerifiedBuild 50250
FireworkShow fireworkShowSilvermoon =
{
    { 0, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 173 },
    { 0, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 174 },
    { 0, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 175 },
    { 1447, GO_FIREWORK_SHOW_TYPE_1_GREEN, 176 },
    { 1447, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 177 },
    { 2498, GO_FIREWORK_SHOW_TYPE_2_RED, 178 },
    { 2498, GO_FIREWORK_SHOW_TYPE_1_WHITE, 179 },
    { 3896, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 180 },
    { 4870, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 181 },
    { 4870, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 182 },
    { 4870, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 183 },
    { 4870, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 184 },
    { 4870, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 185 },
    { 7124, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 186 },
    { 7124, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 187 },
    { 8339, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 188 },
    { 8339, GO_FIREWORK_SHOW_TYPE_2_WHITE, 189 },
    { 10757, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 190 },
    { 10757, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 191 },
    { 10757, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 192 },
    { 11970, GO_FIREWORK_SHOW_TYPE_2_BLUE, 193 },
    { 12994, GO_FIREWORK_SHOW_TYPE_1_BLUE, 194 },
    { 12994, GO_FIREWORK_SHOW_TYPE_1_WHITE, 195 },
    { 15203, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 196 },
    { 15203, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 197 },
    { 15203, GO_FIREWORK_SHOW_TYPE_1_WHITE, 198 },
    { 16399, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 199 },
    { 16399, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 200 },
    { 16399, GO_FIREWORK_SHOW_TYPE_2_RED, 201 },
    { 17617, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 202 },
    { 18827, GO_FIREWORK_SHOW_TYPE_1_GREEN, 203 },
    { 20041, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 204 },
    { 21251, GO_FIREWORK_SHOW_TYPE_2_BLUE, 205 },
    { 22326, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 206 },
    { 23677, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 207 },
    { 23677, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 208 },
    { 23677, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 209 },
    { 24862, GO_FIREWORK_SHOW_TYPE_2_BLUE, 210 },
    { 24862, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 184 },
    { 25948, GO_FIREWORK_SHOW_TYPE_2_BLUE, 211 },
    { 25948, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 212 },
    { 25948, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 213 },
    { 25948, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 214 },
    { 27190, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 185 },
    { 28360, GO_FIREWORK_SHOW_TYPE_1_WHITE, 187 },
    { 28360, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 215 },
    { 28360, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 216 },
    { 28360, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 217 },
    { 28360, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 218 },
    { 28360, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 177 },
    { 30882, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 219 },
    { 30882, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 181 },
    { 30882, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 220 },
    { 33148, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 221 },
    { 33148, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 222 },
    { 33148, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 179 },
    { 34122, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 200 },
    { 34122, GO_FIREWORK_SHOW_TYPE_1_GREEN, 199 },
    { 34122, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 175 },
    { 35753, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 223 },
    { 36184, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 223 },
    { 36957, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 224 },
    { 37363, GO_FIREWORK_SHOW_TYPE_1_BLUE, 188 },
    { 37363, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 224 },
    { 37363, GO_FIREWORK_SHOW_TYPE_2_BLUE, 225 },
    { 38978, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 195 },
    { 38978, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 226 },
    { 39826, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 226 },
    { 39826, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 195 },
    { 42208, GO_FIREWORK_SHOW_TYPE_2_WHITE, 196 },
    { 43835, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 203 },
    { 43835, GO_FIREWORK_SHOW_TYPE_1_WHITE, 189 },
    { 44662, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 193 },
    { 44662, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 203 },
    { 44662, GO_FIREWORK_SHOW_TYPE_1_WHITE, 189 },
    { 45441, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 211 },
    { 45441, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 227 },
    { 45441, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 190 },
    { 45847, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 227 },
    { 45847, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 190 },
    { 45847, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 211 },
    { 49510, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 228 },
    { 49510, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 221 },
    { 50725, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 229 },
    { 50725, GO_FIREWORK_SHOW_TYPE_2_BLUE, 205 },
    { 50725, GO_FIREWORK_SHOW_TYPE_2_WHITE, 191 },
    { 50725, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 219 },
    { 50725, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 214 },
    { 53150, GO_FIREWORK_SHOW_TYPE_2_BLUE, 192 },
    { 53150, GO_FIREWORK_SHOW_TYPE_1_GREEN, 173 },
    { 53150, GO_FIREWORK_SHOW_TYPE_1_RED, 216 },
    { 53150, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 180 },
    { 54401, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 220 },
    { 55595, GO_FIREWORK_SHOW_TYPE_1_WHITE, 230 },
    { 55595, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 198 },
    { 55595, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 231 },
    { 55595, GO_FIREWORK_SHOW_TYPE_2_BLUE, 177 },
    { 55595, GO_FIREWORK_SHOW_TYPE_1_RED, 222 },
    { 56803, GO_FIREWORK_SHOW_TYPE_2_BLUE, 193 },
    { 58011, GO_FIREWORK_SHOW_TYPE_2_RED, 215 },
    { 58011, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 199 },
    { 59229, GO_FIREWORK_SHOW_TYPE_1_WHITE, 218 },
    { 59229, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 202 },
    { 60441, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 195 },
    { 60441, GO_FIREWORK_SHOW_TYPE_2_RED, 185 },
    { 60441, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 174 },
    { 60441, GO_FIREWORK_SHOW_TYPE_1_WHITE, 186 },
    { 61634, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 176 },
    { 61634, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 204 },
    { 61634, GO_FIREWORK_SHOW_TYPE_1_GREEN, 206 },
    { 61634, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 232 },
    { 61634, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 200 },
    { 62866, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 187 },
    { 62866, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 184 },
    { 63881, GO_FIREWORK_SHOW_TYPE_2_BLUE, 213 },
    { 63881, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 201 },
    { 63881, GO_FIREWORK_SHOW_TYPE_1_BLUE, 194 },
    { 64892, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 223 },
    { 64892, GO_FIREWORK_SHOW_TYPE_1_GREEN, 197 },
    { 64892, GO_FIREWORK_SHOW_TYPE_2_RED, 208 },
    { 64892, GO_FIREWORK_SHOW_TYPE_2_GREEN, 210 },
    { 67298, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 181 },
    { 67298, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 207 },
    { 68523, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 229 },
    { 68523, GO_FIREWORK_SHOW_TYPE_1_GREEN, 203 },
    { 69731, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 224 },
    { 69731, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 179 },
    { 69731, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 219 },
    { 69731, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 220 },
    { 69731, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 196 },
    { 69731, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 211 },
    { 72155, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 178 },
    { 72155, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 199 },
    { 73364, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 233 },
    { 73364, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 192 },
    { 73364, GO_FIREWORK_SHOW_TYPE_2_BLUE, 234 },
    { 73364, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 216 },
    { 73364, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 221 },
    { 74565, GO_FIREWORK_SHOW_TYPE_1_BLUE, 214 },
    { 74565, GO_FIREWORK_SHOW_TYPE_2_BLUE, 177 },
    { 75961, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 185 },
    { 75961, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 200 },
    { 75961, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 235 },
    { 76991, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 205 },
    { 76991, GO_FIREWORK_SHOW_TYPE_2_RED, 209 },
    { 76991, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 226 },
    { 76991, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 186 },
    { 76991, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 236 },
    { 78197, GO_FIREWORK_SHOW_TYPE_2_RED, 183 },
    { 78197, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 230 },
    { 81487, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 201 },
    { 81487, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 190 },
    { 81487, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 225 },
    { 83700, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 184 },
    { 83700, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 231 },
    { 85082, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 222 },
    { 85082, GO_FIREWORK_SHOW_TYPE_1_GREEN, 224 },
    { 85082, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 180 },
    { 86296, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 215 },
    { 86296, GO_FIREWORK_SHOW_TYPE_1_RED, 212 },
    { 86296, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 181 },
    { 87506, GO_FIREWORK_SHOW_TYPE_2_BLUE, 213 },
    { 88730, GO_FIREWORK_SHOW_TYPE_2_WHITE, 186 },
    { 89949, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 228 },
    { 92377, GO_FIREWORK_SHOW_TYPE_1_BLUE, 188 },
    { 93391, GO_FIREWORK_SHOW_TYPE_2_WHITE, 195 },
    { 93391, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 187 },
    { 93391, GO_FIREWORK_SHOW_TYPE_2_WHITE, 218 },
    { 94631, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 200 },
    { 94631, GO_FIREWORK_SHOW_TYPE_1_RED, 237 },
    { 94631, GO_FIREWORK_SHOW_TYPE_1_RED, 238 },
    { 94631, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 214 },
    { 94631, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 204 },
    { 95585, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 208 },
    { 96798, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 229 },
    { 96798, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 209 },
    { 96798, GO_FIREWORK_SHOW_TYPE_1_WHITE, 223 },
    { 98022, GO_FIREWORK_SHOW_TYPE_1_WHITE, 179 },
    { 98022, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 216 },
    { 98022, GO_FIREWORK_SHOW_TYPE_2_GREEN, 199 },
    { 98022, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 182 },
    { 99174, GO_FIREWORK_SHOW_TYPE_2_GREEN, 177 },
    { 99174, GO_FIREWORK_SHOW_TYPE_1_WHITE, 196 },
    { 101486, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 207 },
    { 101486, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 190 },
    { 101486, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 183 },
    { 101486, GO_FIREWORK_SHOW_TYPE_2_GREEN, 203 },
    { 102878, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 226 },
    { 102878, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 189 },
    { 102878, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 178 },
    { 103877, GO_FIREWORK_SHOW_TYPE_2_RED, 220 },
    { 103877, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 234 },
    { 104906, GO_FIREWORK_SHOW_TYPE_2_RED, 220 },
    { 104906, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 234 },
    { 106104, GO_FIREWORK_SHOW_TYPE_1_GREEN, 192 },
    { 106104, GO_FIREWORK_SHOW_TYPE_1_BLUE, 219 },
    { 106104, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 180 },
    { 107329, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 186 },
    { 109583, GO_FIREWORK_SHOW_TYPE_2_WHITE, 184 },
    { 109583, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 206 },
    { 110595, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 175 },
    { 110595, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 222 },
    { 111731, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 193 },
    { 111731, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 238 },
    { 115406, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 226 },
    { 115406, GO_FIREWORK_SHOW_TYPE_2_RED, 233 },
    { 115406, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 211 },
    { 117834, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 223 },
    { 119041, GO_FIREWORK_SHOW_TYPE_1_WHITE, 187 },
    { 119041, GO_FIREWORK_SHOW_TYPE_2_BLUE, 199 },
    { 119041, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 201 },
    { 120279, GO_FIREWORK_SHOW_TYPE_1_GREEN, 197 },
    { 120279, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 224 },
    { 120279, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 228 },
    { 120279, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 204 },
    { 121289, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 215 },
    { 122286, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 198 },
    { 123495, GO_FIREWORK_SHOW_TYPE_1_RED, 182 },
    { 123495, GO_FIREWORK_SHOW_TYPE_2_RED, 185 },
    { 123495, GO_FIREWORK_SHOW_TYPE_1_WHITE, 195 },
    { 124709, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 217 },
    { 125761, GO_FIREWORK_SHOW_TYPE_2_WHITE, 218 },
    { 125761, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 184 },
    { 127132, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 190 },
    { 127132, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 212 },
    { 127132, GO_FIREWORK_SHOW_TYPE_1_GREEN, 219 },
    { 127132, GO_FIREWORK_SHOW_TYPE_2_GREEN, 202 },
    { 128336, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 229 },
    { 128336, GO_FIREWORK_SHOW_TYPE_2_RED, 183 },
    { 128336, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 174 },
    { 128336, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 225 },
    { 128336, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 230 },
    { 128336, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 200 },
    { 128336, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 213 },
    { 129420, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 214 },
    { 130772, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 214 },
    { 131984, GO_FIREWORK_SHOW_TYPE_2_WHITE, 196 },
    { 131984, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 232 },
    { 131984, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 232 },
    { 133204, GO_FIREWORK_SHOW_TYPE_1_WHITE, 231 },
    { 133204, GO_FIREWORK_SHOW_TYPE_1_BLUE, 188 },
    { 133204, GO_FIREWORK_SHOW_TYPE_1_GREEN, 192 },
    { 135635, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 236 },
    { 138042, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 189 },
    { 138042, GO_FIREWORK_SHOW_TYPE_1_BLUE, 193 },
    { 138042, GO_FIREWORK_SHOW_TYPE_2_GREEN, 211 },
    { 139242, GO_FIREWORK_SHOW_TYPE_1_GREEN, 210 },
    { 140450, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 186 },
    { 140450, GO_FIREWORK_SHOW_TYPE_2_BLUE, 203 },
    { 140450, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 179 },
    { 141666, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 218 },
    { 142785, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 224 },
    { 142785, GO_FIREWORK_SHOW_TYPE_1_GREEN, 219 },
    { 142785, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 183 },
    { 142785, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 201 },
    { 142785, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 222 },
    { 144014, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 194 },
    { 145074, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 228 },
    { 145074, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 223 },
    { 145074, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 209 },
    { 146053, GO_FIREWORK_SHOW_TYPE_1_RED, 204 },
    { 146053, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 181 },
    { 146053, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 206 },
    { 146053, GO_FIREWORK_SHOW_TYPE_1_BLUE, 225 },
    { 147282, GO_FIREWORK_SHOW_TYPE_1_RED, 215 },
    { 147282, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 208 },
    { 147282, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 177 },
    { 148426, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 221 },
    { 149742, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 175 },
    { 149742, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 213 },
    { 149742, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 214 },
    { 149742, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 197 },
    { 150911, GO_FIREWORK_SHOW_TYPE_2_RED, 237 },
    { 153391, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 200 },
    { 153391, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 212 },
    { 154615, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 191 },
    { 154615, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 185 },
    { 155774, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 202 },
    { 158135, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 226 },
    { 158135, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 190 },
    { 159022, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 227 },
    { 159022, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 189 },
    { 159258, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 189 },
    { 159258, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 227 },
    { 162265, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 194 },
    { 162265, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 174 },
    { 162628, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 194 },
    { 162628, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 174 },
    { 165511, GO_FIREWORK_SHOW_TYPE_2_RED, 233 },
    { 165511, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 176 },
    { 165511, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 199 },
    { 165511, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 196 },
    { 165511, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 216 },
    { 166325, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 216 },
    { 166325, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 196 },
    { 166325, GO_FIREWORK_SHOW_TYPE_2_RED, 233 },
    { 166325, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 176 },
    { 166325, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 199 },
    { 166720, GO_FIREWORK_SHOW_TYPE_2_RED, 237 },
    { 167541, GO_FIREWORK_SHOW_TYPE_2_RED, 237 },
    { 170356, GO_FIREWORK_SHOW_TYPE_1_GREEN, 177 },
    { 171163, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 214 },
    { 171163, GO_FIREWORK_SHOW_TYPE_1_GREEN, 177 },
    { 172328, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 223 },
    { 172328, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 187 },
    { 172328, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 226 },
    { 173565, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 179 },
    { 174774, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 238 },
    { 174774, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 208 },
    { 176018, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 182 },
    { 176018, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 198 },
    { 176018, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 191 },
    { 176018, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 200 },
    { 176018, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 235 },
    { 177228, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 231 },
    { 178313, GO_FIREWORK_SHOW_TYPE_2_GREEN, 197 },
    { 179589, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 175 },
    { 180864, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 190 },
    { 180864, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 230 },
    { 182019, GO_FIREWORK_SHOW_TYPE_2_WHITE, 186 },
    { 182019, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 178 },
    { 182019, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 222 },
    { 182019, GO_FIREWORK_SHOW_TYPE_2_WHITE, 184 },
    { 182019, GO_FIREWORK_SHOW_TYPE_1_GREEN, 213 },
    { 182019, GO_FIREWORK_SHOW_TYPE_1_GREEN, 225 },
    { 185706, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 204 },
    { 185706, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 216 },
    { 185706, GO_FIREWORK_SHOW_TYPE_1_BLUE, 192 },
    { 185706, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 208 },
    { 186923, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 185 },
    { 186923, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 209 },
    { 186923, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 206 },
    { 190568, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 173 },
    { 191779, GO_FIREWORK_SHOW_TYPE_1_BLUE, 224 },
    { 191779, GO_FIREWORK_SHOW_TYPE_1_RED, 201 },
    { 191779, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 203 },
    { 191779, GO_FIREWORK_SHOW_TYPE_1_RED, 233 },
    { 192787, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 194 },
    { 192787, GO_FIREWORK_SHOW_TYPE_2_BLUE, 214 },
    { 193817, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 212 },
    { 193817, GO_FIREWORK_SHOW_TYPE_2_WHITE, 180 },
    { 193817, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 226 },
    { 193817, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 234 },
    { 195019, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 228 },
    { 195019, GO_FIREWORK_SHOW_TYPE_1_GREEN, 202 },
    { 196226, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 188 },
    { 196226, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 205 },
    { 196226, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 205 },
    { 197440, GO_FIREWORK_SHOW_TYPE_1_RED, 183 },
    { 198650, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 238 },
    { 198650, GO_FIREWORK_SHOW_TYPE_1_BLUE, 211 },
    { 199849, GO_FIREWORK_SHOW_TYPE_1_WHITE, 230 },
    { 199849, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 181 },
    { 199849, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 181 },
    { 199849, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 181 },
    { 201074, GO_FIREWORK_SHOW_TYPE_1_BLUE, 193 },
    { 202284, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 207 },
    { 202284, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 220 },
    { 202284, GO_FIREWORK_SHOW_TYPE_2_RED, 182 },
    { 202284, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 237 },
    { 203504, GO_FIREWORK_SHOW_TYPE_2_GREEN, 219 },
    { 203504, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 175 },
    { 203504, GO_FIREWORK_SHOW_TYPE_1_WHITE, 186 },
    { 203504, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 179 },
    { 204713, GO_FIREWORK_SHOW_TYPE_2_GREEN, 199 },
    { 204713, GO_FIREWORK_SHOW_TYPE_1_WHITE, 195 },
    { 204713, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 217 },
    { 207147, GO_FIREWORK_SHOW_TYPE_1_GREEN, 192 },
    { 207147, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 225 },
    { 208359, GO_FIREWORK_SHOW_TYPE_2_BLUE, 173 },
    { 208359, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 227 },
    { 209562, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 208 },
    { 209562, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 200 },
    { 209562, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 174 },
    { 209562, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 191 },
    { 210773, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 214 },
    { 211976, GO_FIREWORK_SHOW_TYPE_2_WHITE, 235 },
    { 211976, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 189 },
    { 211976, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 215 },
    { 213189, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 209 },
    { 213189, GO_FIREWORK_SHOW_TYPE_1_GREEN, 188 },
    { 214411, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 232 },
    { 214411, GO_FIREWORK_SHOW_TYPE_2_BLUE, 205 },
    { 216835, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 222 },
    { 217861, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 231 },
    { 217861, GO_FIREWORK_SHOW_TYPE_2_WHITE, 187 },
    { 219958, GO_FIREWORK_SHOW_TYPE_2_BLUE, 194 },
    { 219958, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 229 },
    { 221038, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 185 },
    { 221038, GO_FIREWORK_SHOW_TYPE_1_GREEN, 197 },
    { 223283, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 223 },
    { 224507, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 217 },
    { 224507, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 181 },
    { 224507, GO_FIREWORK_SHOW_TYPE_1_GREEN, 177 },
    { 225728, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 214 },
    { 225728, GO_FIREWORK_SHOW_TYPE_2_RED, 220 },
    { 226939, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 238 },
    { 226939, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 224 },
    { 228147, GO_FIREWORK_SHOW_TYPE_1_GREEN, 192 },
    { 229350, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 204 },
    { 229350, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 180 },
    { 229350, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 228 },
    { 229350, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 237 },
    { 230374, GO_FIREWORK_SHOW_TYPE_2_RED, 227 },
    { 230374, GO_FIREWORK_SHOW_TYPE_2_WHITE, 191 },
    { 231371, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 236 },
    { 232577, GO_FIREWORK_SHOW_TYPE_1_WHITE, 179 },
    { 232577, GO_FIREWORK_SHOW_TYPE_2_RED, 182 },
    { 233783, GO_FIREWORK_SHOW_TYPE_2_GREEN, 176 },
    { 234996, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 188 },
    { 236197, GO_FIREWORK_SHOW_TYPE_2_GREEN, 177 },
    { 236197, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 230 },
    { 236197, GO_FIREWORK_SHOW_TYPE_1_WHITE, 196 },
    { 236197, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 190 },
    { 237411, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 219 },
    { 237411, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 173 },
    { 237411, GO_FIREWORK_SHOW_TYPE_1_GREEN, 225 },
    { 237411, GO_FIREWORK_SHOW_TYPE_2_WHITE, 232 },
    { 238481, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 189 },
    { 238481, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 218 },
    { 238481, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 183 },
    { 238481, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 175 },
    { 239803, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 181 },
    { 241051, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 201 },
    { 242268, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 235 },
    { 242268, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 215 },
    { 242268, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 193 },
    { 243449, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 185 },
    { 243449, GO_FIREWORK_SHOW_TYPE_2_GREEN, 211 },
    { 243449, GO_FIREWORK_SHOW_TYPE_1_RED, 229 },
    { 245903, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 202 },
    { 245903, GO_FIREWORK_SHOW_TYPE_2_WHITE, 195 },
    { 245903, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 209 },
    { 247106, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 216 },
    { 247106, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 186 },
    { 247106, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 184 },
    { 248146, GO_FIREWORK_SHOW_TYPE_1_BLUE, 205 },
    { 250338, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 223 },
    { 250338, GO_FIREWORK_SHOW_TYPE_1_GREEN, 206 },
    { 250338, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 234 },
    { 250338, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 199 },
    { 250338, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 221 },
    { 251478, GO_FIREWORK_SHOW_TYPE_2_GREEN, 203 },
    { 253895, GO_FIREWORK_SHOW_TYPE_2_RED, 222 },
    { 255216, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 174 },
    { 255216, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 182 },
    { 255216, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 182 },
    { 255946, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 178 },
    { 256386, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 178 },
    { 256386, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 204 },
    { 257574, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 204 },
    { 257574, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 204 },
    { 257574, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 197 },
    { 257574, GO_FIREWORK_SHOW_TYPE_1_GREEN, 194 },
    { 257574, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 216 },
    { 257968, GO_FIREWORK_SHOW_TYPE_1_WHITE, 187 },
    { 257968, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 207 },
    { 258937, GO_FIREWORK_SHOW_TYPE_1_GREEN, 194 },
    { 258937, GO_FIREWORK_SHOW_TYPE_1_WHITE, 187 },
    { 258937, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 207 },
    { 258937, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 197 },
    { 258937, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 216 },
    { 259166, GO_FIREWORK_SHOW_TYPE_1_GREEN, 224 },
    { 259166, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 217 },
    { 259166, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 238 },
    { 259570, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 225 },
    { 259570, GO_FIREWORK_SHOW_TYPE_2_WHITE, 191 },
    { 259983, GO_FIREWORK_SHOW_TYPE_1_GREEN, 224 },
    { 259983, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 217 },
    { 259983, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 238 },
    { 259983, GO_FIREWORK_SHOW_TYPE_2_WHITE, 191 },
    { 259983, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 225 },
    { 261246, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 175 },
    { 262377, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 175 },
    { 262377, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 175 },
    { 262377, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 210 },
    { 262377, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 211 },
    { 263650, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 211 },
    { 263650, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 210 },
    { 263650, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 181 },
    { 264734, GO_FIREWORK_SHOW_TYPE_1_RED, 183 },
    { 264734, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 213 },
    { 266082, GO_FIREWORK_SHOW_TYPE_2_WHITE, 179 },
    { 266082, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 219 },
    { 266082, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 227 },
    { 267666, GO_FIREWORK_SHOW_TYPE_1_WHITE, 190 },
    { 267666, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 184 },
    { 268517, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 184 },
    { 268517, GO_FIREWORK_SHOW_TYPE_1_WHITE, 190 },
    { 268517, GO_FIREWORK_SHOW_TYPE_1_WHITE, 190 },
    { 268517, GO_FIREWORK_SHOW_TYPE_1_WHITE, 190 },
    { 268517, GO_FIREWORK_SHOW_TYPE_1_WHITE, 190 },
    { 269514, GO_FIREWORK_SHOW_TYPE_1_RED, 233 },
    { 269514, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 231 },
    { 271742, GO_FIREWORK_SHOW_TYPE_1_RED, 215 },
    { 272949, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 198 },
    { 272949, GO_FIREWORK_SHOW_TYPE_2_BLUE, 202 },
    { 272949, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 185 },
    { 274162, GO_FIREWORK_SHOW_TYPE_2_RED, 209 },
    { 274162, GO_FIREWORK_SHOW_TYPE_1_BLUE, 217 },
    { 274162, GO_FIREWORK_SHOW_TYPE_1_BLUE, 234 },
    { 274162, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 206 },
    { 274162, GO_FIREWORK_SHOW_TYPE_2_GREEN, 176 },
    { 274162, GO_FIREWORK_SHOW_TYPE_2_GREEN, 176 },
    { 276583, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 220 },
    { 276583, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 186 },
    { 276583, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 237 },
    { 277694, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 205 },
    { 277694, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 196 },
    { 277694, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 208 },
    { 279006, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 178 },
    { 279006, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 201 },
    { 280198, GO_FIREWORK_SHOW_TYPE_1_WHITE, 195 },
    { 281430, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 189 },
    { 281430, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 177 },
    { 281430, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 199 },
    { 282659, GO_FIREWORK_SHOW_TYPE_1_RED, 204 },
    { 282659, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 232 },
    { 283848, GO_FIREWORK_SHOW_TYPE_1_GREEN, 224 },
    { 283848, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 212 },
    { 284900, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 216 },
    { 286257, GO_FIREWORK_SHOW_TYPE_2_GREEN, 210 },
    { 286257, GO_FIREWORK_SHOW_TYPE_1_WHITE, 223 },
    { 286257, GO_FIREWORK_SHOW_TYPE_1_RED, 182 },
    { 286257, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 188 },
    { 286257, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 235 },
    { 286257, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 235 },
    { 286257, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 235 },
    { 287484, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 187 },
    { 287484, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 174 },
    { 287484, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 230 },
    { 288562, GO_FIREWORK_SHOW_TYPE_2_WHITE, 218 },
    { 288562, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 181 },
    { 288562, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 181 },
    { 290931, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 190 },
    { 290931, GO_FIREWORK_SHOW_TYPE_2_WHITE, 191 },
    { 292249, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 238 },
    { 292249, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 207 },
    { 294692, GO_FIREWORK_SHOW_TYPE_2_GREEN, 193 },
    { 294692, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 180 },
    { 294692, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 180 },
    { 294692, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 180 },
    { 295940, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 225 },
    { 295940, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 229 },
    { 297173, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 235 },
    { 298389, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 184 },
    { 298389, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 179 },
    { 299582, GO_FIREWORK_SHOW_TYPE_1_BLUE, 173 },
    { 299582, GO_FIREWORK_SHOW_TYPE_1_RED, 215 },
    { 300764, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 216 },
    { 303236, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 231 },
    { 304431, GO_FIREWORK_SHOW_TYPE_2_BLUE, 219 },
    { 305568, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 178 },
    { 306865, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 226 },
    { 306865, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 188 },
    { 306865, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 200 },
    { 306865, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 220 },
    { 308074, GO_FIREWORK_SHOW_TYPE_1_BLUE, 224 },
    { 308074, GO_FIREWORK_SHOW_TYPE_1_BLUE, 213 },
    { 308074, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 222 },
    { 309232, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 197 },
    { 310441, GO_FIREWORK_SHOW_TYPE_1_RED, 204 },
    { 310441, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 194 },
    { 310441, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 232 },
    { 310441, GO_FIREWORK_SHOW_TYPE_1_WHITE, 191 },
    { 310441, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 221 },
    { 311662, GO_FIREWORK_SHOW_TYPE_2_GREEN, 217 },
    { 311662, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 177 },
    { 311662, GO_FIREWORK_SHOW_TYPE_2_BLUE, 206 },
    { 314114, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 183 },
    { 314114, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 181 },
    { 315336, GO_FIREWORK_SHOW_TYPE_1_RED, 227 },
    { 315336, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 234 },
    { 315336, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 234 },
    { 317695, GO_FIREWORK_SHOW_TYPE_2_GREEN, 202 },
    { 317695, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 199 },
    { 317695, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 230 },
    { 317695, GO_FIREWORK_SHOW_TYPE_1_RED, 216 },
    { 320207, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 238 },
    { 320207, GO_FIREWORK_SHOW_TYPE_2_RED, 233 },
    { 320207, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 208 },
    { 320207, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 175 },
    { 321420, GO_FIREWORK_SHOW_TYPE_1_WHITE, 223 },
    { 322632, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 205 },
    { 322632, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 213 },
    { 322632, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 200 },
    { 322632, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 209 },
    { 323843, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 225 },
    { 323843, GO_FIREWORK_SHOW_TYPE_2_WHITE, 195 },
    { 325057, GO_FIREWORK_SHOW_TYPE_1_WHITE, 235 },
    { 325057, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 190 },
    { 325057, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 219 },
    { 325057, GO_FIREWORK_SHOW_TYPE_2_RED, 212 },
    { 325057, GO_FIREWORK_SHOW_TYPE_2_BLUE, 192 },
    { 326265, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 236 },
    { 326265, GO_FIREWORK_SHOW_TYPE_2_WHITE, 189 },
    { 326265, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 187 },
    { 326265, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 180 },
    { 327481, GO_FIREWORK_SHOW_TYPE_1_BLUE, 193 },
    { 328702, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 179 },
    { 329923, GO_FIREWORK_SHOW_TYPE_1_GREEN, 234 },
    { 329923, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 231 },
    { 329923, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 210 },
    { 331140, GO_FIREWORK_SHOW_TYPE_2_BLUE, 177 },
    { 331140, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 204 },
    { 332363, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 178 },
    { 333575, GO_FIREWORK_SHOW_TYPE_1_WHITE, 184 },
    { 334786, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 196 },
    { 334786, GO_FIREWORK_SHOW_TYPE_1_BLUE, 188 },
    { 334786, GO_FIREWORK_SHOW_TYPE_2_RED, 207 },
    { 335995, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 176 },
    { 337135, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 198 },
    { 337135, GO_FIREWORK_SHOW_TYPE_2_RED, 237 },
    { 338368, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 200 },
    { 338368, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 232 },
    { 339641, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 223 },
    { 339641, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 194 },
    { 339641, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 229 },
    { 339641, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 174 },
    { 340800, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 186 },
    { 340800, GO_FIREWORK_SHOW_TYPE_2_GREEN, 206 },
    { 340800, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 215 },
    { 343275, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 230 },
    { 343275, GO_FIREWORK_SHOW_TYPE_1_GREEN, 205 },
    { 343275, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 201 },
    { 343637, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 181 },
    { 344042, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 214 },
    { 344487, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 214 },
    { 344487, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 181 },
    { 345645, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 224 },
    { 345645, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 191 },
    { 347285, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 179 },
    { 347988, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 179 },
    { 348624, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 227 },
    { 348904, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 216 },
    { 348904, GO_FIREWORK_SHOW_TYPE_2_BLUE, 213 },
    { 349201, GO_FIREWORK_SHOW_TYPE_2_BLUE, 213 },
    { 349201, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 216 },
    { 349201, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 227 },
    { 350160, GO_FIREWORK_SHOW_TYPE_2_GREEN, 210 },
    { 350528, GO_FIREWORK_SHOW_TYPE_2_GREEN, 210 },
    { 350528, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 203 },
    { 350528, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 238 },
    { 351749, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 238 },
    { 351749, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 203 },
    { 351749, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 221 },
    { 352976, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 221 },
    { 352976, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 185 },
    { 352976, GO_FIREWORK_SHOW_TYPE_2_GREEN, 219 },
    { 354059, GO_FIREWORK_SHOW_TYPE_1_WHITE, 190 },
    { 354059, GO_FIREWORK_SHOW_TYPE_2_GREEN, 193 },
    { 355409, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 175 },
    { 355409, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 197 },
    { 356428, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 192 },
    { 356428, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 200 },
    { 356428, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 215 },
    { 356428, GO_FIREWORK_SHOW_TYPE_1_BLUE, 176 },
    { 357837, GO_FIREWORK_SHOW_TYPE_1_WHITE, 235 },
    { 357837, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 173 },
    { 358231, GO_FIREWORK_SHOW_TYPE_1_WHITE, 180 },
    { 359041, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 174 },
    { 359041, GO_FIREWORK_SHOW_TYPE_1_WHITE, 180 },
    { 360237, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 199 },
    { 360237, GO_FIREWORK_SHOW_TYPE_1_RED, 222 },
    { 361449, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 179 },
    { 362665, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 217 },
    { 362665, GO_FIREWORK_SHOW_TYPE_2_WHITE, 226 },
    { 363881, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 208 },
    { 363881, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 202 },
    { 363881, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 211 },
    { 365898, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 191 },
    { 367070, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 196 },
    { 369542, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 181 },
    { 369542, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 223 },
    { 369542, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 232 },
    { 369542, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 187 },
    { 369542, GO_FIREWORK_SHOW_TYPE_2_RED, 212 },
    { 369542, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 188 },
    { 370581, GO_FIREWORK_SHOW_TYPE_2_RED, 207 },
    { 370581, GO_FIREWORK_SHOW_TYPE_1_BLUE, 219 },
    { 371958, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 186 },
    { 371958, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 179 },
    { 371958, GO_FIREWORK_SHOW_TYPE_2_GREEN, 177 },
    { 371958, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 209 },
    { 371958, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 227 },
    { 372885, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 182 },
    { 372885, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 194 },
    { 373978, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 204 },
    { 375180, GO_FIREWORK_SHOW_TYPE_2_RED, 178 },
    { 378805, GO_FIREWORK_SHOW_TYPE_2_BLUE, 205 },
    { 380013, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 238 },
    { 380013, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 237 },
    { 380013, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 195 },
    { 380013, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 234 },
    { 380013, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 206 },
    { 380013, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 233 },
    { 380013, GO_FIREWORK_SHOW_TYPE_2_WHITE, 230 },
    { 381198, GO_FIREWORK_SHOW_TYPE_1_RED, 229 },
    { 382447, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 222 },
    { 382447, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 221 },
    { 382447, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 228 },
    { 383655, GO_FIREWORK_SHOW_TYPE_1_GREEN, 173 },
    { 383655, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 203 },
    { 383655, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 211 },
    { 384881, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 201 },
    { 384881, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 183 },
    { 384881, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 216 },
    { 384881, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 218 },
    { 387296, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 199 },
    { 388492, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 235 },
    { 388492, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 214 },
    { 389494, GO_FIREWORK_SHOW_TYPE_1_GREEN, 219 },
    { 389494, GO_FIREWORK_SHOW_TYPE_2_RED, 220 },
    { 389494, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 202 },
    { 390886, GO_FIREWORK_SHOW_TYPE_1_BLUE, 176 },
    { 392142, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 198 },
    { 393354, GO_FIREWORK_SHOW_TYPE_2_BLUE, 197 },
    { 394576, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 203 },
    { 395792, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 185 },
    { 398207, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 227 },
    { 398207, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 208 },
    { 398207, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 238 },
    { 398207, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 196 },
    { 399415, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 209 },
    { 399415, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 189 },
    { 399415, GO_FIREWORK_SHOW_TYPE_2_RED, 174 },
    { 400622, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 223 },
    { 401831, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 200 },
    { 401831, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 204 },
    { 401831, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 181 },
    { 404092, GO_FIREWORK_SHOW_TYPE_2_GREEN, 194 },
    { 404092, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 217 },
    { 404092, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 191 },
    { 404092, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 187 },
    { 407897, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 192 },
    { 407897, GO_FIREWORK_SHOW_TYPE_1_RED, 178 },
    { 407897, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 193 },
    { 407897, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 224 },
    { 407897, GO_FIREWORK_SHOW_TYPE_1_WHITE, 180 },
    { 407897, GO_FIREWORK_SHOW_TYPE_2_WHITE, 175 },
    { 407897, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 235 },
    { 407897, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 219 },
    { 407897, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 219 },
    { 407897, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 219 },
    { 409067, GO_FIREWORK_SHOW_TYPE_1_WHITE, 221 },
    { 409067, GO_FIREWORK_SHOW_TYPE_1_RED, 220 },
    { 409067, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 184 },
    { 410321, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 207 },
    { 412758, GO_FIREWORK_SHOW_TYPE_1_GREEN, 188 },
    { 412758, GO_FIREWORK_SHOW_TYPE_2_GREEN, 206 },
    { 412758, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 186 },
    { 415963, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 179 },
    { 417175, GO_FIREWORK_SHOW_TYPE_1_WHITE, 195 },
    { 417175, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 232 },
    { 417175, GO_FIREWORK_SHOW_TYPE_2_GREEN, 199 },
    { 417175, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 176 },
    { 417175, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 229 },
    { 418399, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 213 },
    { 419612, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 190 },
    { 420826, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 216 },
    { 420826, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 202 },
    { 420826, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 215 },
    { 422041, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 234 },
    { 422041, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 226 },
    { 422041, GO_FIREWORK_SHOW_TYPE_1_BLUE, 211 },
    { 422041, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 225 },
    { 425275, GO_FIREWORK_SHOW_TYPE_2_RED, 236 },
    { 426490, GO_FIREWORK_SHOW_TYPE_2_BLUE, 206 },
    { 426490, GO_FIREWORK_SHOW_TYPE_2_RED, 220 },
    { 426490, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 194 },
    { 426490, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 210 },
    { 427641, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 198 },
    { 427641, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 203 },
    { 427641, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 221 },
    { 428692, GO_FIREWORK_SHOW_TYPE_1_WHITE, 196 },
    { 428692, GO_FIREWORK_SHOW_TYPE_1_WHITE, 223 },
    { 428692, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 178 },
    { 428692, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 209 },
    { 429726, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 177 },
    { 430938, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 180 },
    { 432147, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 217 },
    { 432147, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 187 },
    { 432147, GO_FIREWORK_SHOW_TYPE_1_RED, 229 },
    { 432147, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 218 },
    { 432147, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 181 },
    { 432147, GO_FIREWORK_SHOW_TYPE_2_RED, 233 },
    { 432147, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 182 },
    { 432147, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 204 },
    { 432147, GO_FIREWORK_SHOW_TYPE_1_RED, 237 },
    { 433364, GO_FIREWORK_SHOW_TYPE_1_GREEN, 197 },
    { 434585, GO_FIREWORK_SHOW_TYPE_2_BLUE, 214 },
    { 434585, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 184 },
    { 435794, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 235 },
    { 438233, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 228 },
    { 438233, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 230 },
    { 438233, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 212 },
    { 439448, GO_FIREWORK_SHOW_TYPE_2_BLUE, 219 },
    { 439448, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 227 },
    { 441870, GO_FIREWORK_SHOW_TYPE_1_BLUE, 225 },
    { 441870, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 205 },
    { 444293, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 193 },
    { 444293, GO_FIREWORK_SHOW_TYPE_1_GREEN, 188 },
    { 444293, GO_FIREWORK_SHOW_TYPE_2_WHITE, 191 },
    { 445499, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 224 },
    { 445499, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 201 },
    { 446707, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 179 },
    { 446707, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 174 },
    { 447930, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 176 },
    { 449146, GO_FIREWORK_SHOW_TYPE_2_GREEN, 202 },
    { 450374, GO_FIREWORK_SHOW_TYPE_1_RED, 183 },
    { 450374, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 175 },
    { 451580, GO_FIREWORK_SHOW_TYPE_1_GREEN, 192 },
    { 451580, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 209 },
    { 451580, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 213 },
    { 452800, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 178 },
    { 454006, GO_FIREWORK_SHOW_TYPE_2_RED, 185 },
    { 455215, GO_FIREWORK_SHOW_TYPE_2_WHITE, 195 },
    { 455215, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 218 },
    { 456425, GO_FIREWORK_SHOW_TYPE_1_GREEN, 214 },
    { 456425, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 221 },
    { 457644, GO_FIREWORK_SHOW_TYPE_1_WHITE, 223 },
    { 457644, GO_FIREWORK_SHOW_TYPE_1_RED, 236 },
    { 457644, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 180 },
    { 461278, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 184 },
    { 461278, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 211 },
    { 462492, GO_FIREWORK_SHOW_TYPE_2_BLUE, 224 },
    { 462492, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 212 },
    { 462492, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 204 },
    { 463760, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 208 },
    { 464850, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 174 },
    { 464850, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 187 },
    { 464850, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 226 },
    { 464850, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 231 },
    { 464850, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 186 },
    { 466144, GO_FIREWORK_SHOW_TYPE_1_GREEN, 194 },
    { 467344, GO_FIREWORK_SHOW_TYPE_1_WHITE, 175 },
    { 467344, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 220 },
    { 467344, GO_FIREWORK_SHOW_TYPE_1_RED, 200 },
    { 467344, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 185 },
    { 469769, GO_FIREWORK_SHOW_TYPE_2_RED, 201 },
    { 469769, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 188 },
    { 470981, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 199 },
    { 470981, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 237 },
    { 470981, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 197 },
    { 470981, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 203 },
    { 472191, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 183 },
    { 472191, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 195 },
    { 472191, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 202 },
    { 472191, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 217 },
    { 475850, GO_FIREWORK_SHOW_TYPE_2_GREEN, 192 },
    { 475850, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 179 },
    { 475850, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 206 },
    { 475850, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 225 },
    { 477072, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 191 },
    { 477072, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 176 },
    { 479333, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 222 },
    { 479333, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 207 },
    { 480566, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 175 },
    { 480566, GO_FIREWORK_SHOW_TYPE_2_GREEN, 214 },
    { 480566, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 224 },
    { 481735, GO_FIREWORK_SHOW_TYPE_1_WHITE, 218 },
    { 481735, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 193 },
    { 482752, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 233 },
    { 482752, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 227 },
    { 482752, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 216 },
    { 483962, GO_FIREWORK_SHOW_TYPE_1_GREEN, 173 },
    { 483962, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 198 },
    { 485164, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 204 },
    { 485164, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 204 },
    { 486405, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 205 },
    { 486405, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 215 },
    { 486405, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 212 },
    { 487605, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 223 },
    { 489619, GO_FIREWORK_SHOW_TYPE_2_RED, 178 },
    { 492074, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 196 },
    { 492074, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 180 },
    { 492074, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 230 },
    { 492074, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 187 },
    { 494481, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 209 },
    { 495531, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 238 },
    { 498132, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 217 },
    { 498132, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 183 },
    { 499237, GO_FIREWORK_SHOW_TYPE_1_RED, 201 },
    { 500858, GO_FIREWORK_SHOW_TYPE_1_RED, 185 },
    { 501665, GO_FIREWORK_SHOW_TYPE_1_RED, 185 },
    { 502876, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 216 },
    { 502876, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 187 },
    { 504102, GO_FIREWORK_SHOW_TYPE_1_BLUE, 188 },
    { 505395, GO_FIREWORK_SHOW_TYPE_1_GREEN, 203 },
    { 505395, GO_FIREWORK_SHOW_TYPE_1_GREEN, 203 },
    { 506604, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 179 },
    { 507739, GO_FIREWORK_SHOW_TYPE_2_WHITE, 191 },
    { 508947, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 207 },
    { 508947, GO_FIREWORK_SHOW_TYPE_2_RED, 237 },
    { 511444, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 236 },
    { 511444, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 220 },
    { 511444, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 225 },
    { 512459, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 210 },
    { 512459, GO_FIREWORK_SHOW_TYPE_2_WHITE, 223 },
    { 512459, GO_FIREWORK_SHOW_TYPE_1_BLUE, 219 },
    { 512459, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 197 },
    { 513567, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 190 },
    { 514216, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 198 },
    { 514216, GO_FIREWORK_SHOW_TYPE_2_WHITE, 218 },
    { 514647, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 198 },
    { 514647, GO_FIREWORK_SHOW_TYPE_2_WHITE, 218 },
    { 515429, GO_FIREWORK_SHOW_TYPE_1_RED, 233 },
    { 515715, GO_FIREWORK_SHOW_TYPE_1_RED, 233 },
    { 516884, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 238 },
    { 517873, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 208 },
    { 517873, GO_FIREWORK_SHOW_TYPE_1_RED, 229 },
    { 517873, GO_FIREWORK_SHOW_TYPE_1_WHITE, 235 },
    { 518868, GO_FIREWORK_SHOW_TYPE_1_RED, 174 },
    { 518868, GO_FIREWORK_SHOW_TYPE_2_BLUE, 213 },
    { 520089, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 227 },
    { 520089, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 175 },
    { 521136, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 230 },
    { 521136, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 209 },
    { 522182, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 214 },
    { 523190, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 200 },
    { 523190, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 180 },
    { 523190, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 231 },
    { 524206, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 195 },
    { 524206, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 217 },
    { 525467, GO_FIREWORK_SHOW_TYPE_2_BLUE, 202 },
    { 526535, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 226 },
    { 527607, GO_FIREWORK_SHOW_TYPE_1_BLUE, 206 },
    { 527607, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 181 },
    { 530058, GO_FIREWORK_SHOW_TYPE_2_WHITE, 221 },
    { 530058, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 222 },
    { 531271, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 225 },
    { 532409, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 177 },
    { 532409, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 189 },
    { 532409, GO_FIREWORK_SHOW_TYPE_1_GREEN, 234 },
    { 532409, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 223 },
    { 533601, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 182 },
    { 533601, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 216 },
    { 536091, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 191 },
    { 536091, GO_FIREWORK_SHOW_TYPE_2_GREEN, 188 },
    { 536091, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 237 },
    { 537241, GO_FIREWORK_SHOW_TYPE_1_BLUE, 211 },
    { 537241, GO_FIREWORK_SHOW_TYPE_2_BLUE, 219 },
    { 537241, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 184 },
    { 537241, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 193 },
    { 537241, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 213 },
    { 538465, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 228 },
    { 538465, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 186 },
    { 538465, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 227 },
    { 538465, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 176 },
    { 539697, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 215 },
    { 541317, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 220 },
    { 541317, GO_FIREWORK_SHOW_TYPE_1_GREEN, 173 },
    { 541317, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 199 },
    { 542161, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 183 },
    { 542161, GO_FIREWORK_SHOW_TYPE_1_GREEN, 173 },
    { 542161, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 220 },
    { 542161, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 199 },
    { 542161, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 229 },
    { 542161, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 175 },
    { 543174, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 224 },
    { 544972, GO_FIREWORK_SHOW_TYPE_1_WHITE, 221 },
    { 545396, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 202 },
    { 545396, GO_FIREWORK_SHOW_TYPE_1_WHITE, 221 },
    { 546455, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 217 },
    { 546647, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 209 },
    { 547695, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 209 },
    { 548940, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 201 },
    { 548940, GO_FIREWORK_SHOW_TYPE_1_GREEN, 210 },
    { 548940, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 177 },
    { 548940, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 218 },
    { 548940, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 195 },
    { 548940, GO_FIREWORK_SHOW_TYPE_1_RED, 200 },
    { 548940, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 187 },
    { 548940, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 197 },
    { 550252, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 180 },
    { 550252, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 192 },
    { 550252, GO_FIREWORK_SHOW_TYPE_2_GREEN, 225 },
    { 551053, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 207 },
    { 551053, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 232 },
    { 551467, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 207 },
    { 551467, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 232 },
    { 553802, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 189 },
    { 553802, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 233 },
    { 553802, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 206 },
    { 553802, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 198 },
    { 554904, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 223 },
    { 557398, GO_FIREWORK_SHOW_TYPE_1_WHITE, 231 },
    { 557398, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 237 },
    { 557398, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 227 },
    { 558745, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 204 },
    { 558745, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 182 },
    { 558745, GO_FIREWORK_SHOW_TYPE_1_BLUE, 211 },
    { 558745, GO_FIREWORK_SHOW_TYPE_2_RED, 178 },
    { 559543, GO_FIREWORK_SHOW_TYPE_2_WHITE, 226 },
    { 559543, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 216 },
    { 559925, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 216 },
    { 559925, GO_FIREWORK_SHOW_TYPE_2_WHITE, 226 },
    { 561161, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 185 },
    { 562368, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 173 },
    { 562368, GO_FIREWORK_SHOW_TYPE_1_BLUE, 225 },
    { 562368, GO_FIREWORK_SHOW_TYPE_1_WHITE, 230 },
    { 563583, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 174 },
    { 564810, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 234 },
    { 566022, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 193 },
    { 566022, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 219 },
    { 567225, GO_FIREWORK_SHOW_TYPE_2_WHITE, 184 },
    { 568294, GO_FIREWORK_SHOW_TYPE_1_BLUE, 192 },
    { 568294, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 206 },
    { 569652, GO_FIREWORK_SHOW_TYPE_1_WHITE, 190 },
    { 569652, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 195 },
    { 569652, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 196 },
    { 569652, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 176 },
    { 570874, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 209 },
    { 570874, GO_FIREWORK_SHOW_TYPE_2_BLUE, 199 },
    { 572082, GO_FIREWORK_SHOW_TYPE_2_WHITE, 189 },
    { 572082, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 180 },
    { 572503, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 218 },
    { 572503, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 175 },
    { 573140, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 218 },
    { 573140, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 175 },
    { 574494, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 213 },
    { 574494, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 214 },
    { 575707, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 191 },
    { 575707, GO_FIREWORK_SHOW_TYPE_2_WHITE, 221 },
    { 575707, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 194 },
    { 575707, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 210 },
    { 575707, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 208 },
    { 576949, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 212 },
    { 576949, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 207 },
    { 576949, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 215 },
    { 576949, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 186 },
    { 577947, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 235 },
    { 577947, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 184 },
    { 578943, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 220 },
    { 578943, GO_FIREWORK_SHOW_TYPE_1_GREEN, 234 },
    { 578943, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 238 },
    { 578943, GO_FIREWORK_SHOW_TYPE_2_GREEN, 197 },
    { 578943, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 227 },
    { 578943, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 200 },
    { 578943, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 222 },
    { 578943, GO_FIREWORK_SHOW_TYPE_2_RED, 233 },
    { 578943, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 178 },
    { 578943, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 237 },
    { 578943, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 224 },
    { 578943, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 173 },
    { 578943, GO_FIREWORK_SHOW_TYPE_1_RED, 201 },
    { 579960, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 183 },
    { 579960, GO_FIREWORK_SHOW_TYPE_2_WHITE, 187 },
    { 579960, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 216 },
    { 579960, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 198 },
    { 579960, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 226 },
    { 579960, GO_FIREWORK_SHOW_TYPE_1_RED, 236 },
    { 580961, GO_FIREWORK_SHOW_TYPE_1_WHITE, 230 },
    { 580961, GO_FIREWORK_SHOW_TYPE_1_WHITE, 231 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_BLUE, 188 },
    { 580961, GO_FIREWORK_SHOW_TYPE_1_GREEN, 193 },
    { 580961, GO_FIREWORK_SHOW_TYPE_1_GREEN, 225 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 182 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 185 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_GREEN, 206 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_GREEN, 219 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_GREEN, 211 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_WHITE, 228 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 174 },
    { 580961, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 229 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 205 },
    { 580961, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 217 },
    { 580961, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 177 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 181 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 232 },
    { 580961, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 179 },
    { 580961, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 204 },
    { 582166, GO_FIREWORK_SHOW_TYPE_1_GREEN, 199 },
    { 583408, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 189 },
    { 583408, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 190 },
    { 584621, GO_FIREWORK_SHOW_TYPE_1_BLUE, 192 },
    { 584621, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 209 },
    { 584621, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 196 },
    { 584621, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 180 },
    { 584621, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 195 },
    { 584621, GO_FIREWORK_SHOW_TYPE_2_BLUE, 176 },
    { 585834, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 203 },
    { 587042, GO_FIREWORK_SHOW_TYPE_2_BLUE, 213 },
    { 587042, GO_FIREWORK_SHOW_TYPE_1_GREEN, 214 },
    { 587042, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 202 },
    { 588264, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 218 },
    { 589467, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 175 },
    { 589467, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 223 },
    { 590691, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 198 },
    { 590691, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 237 },
    { 590691, GO_FIREWORK_SHOW_TYPE_2_BLUE, 205 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 207 },
    { 591867, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 234 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 210 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 185 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_GREEN, 177 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 212 },
    { 591867, GO_FIREWORK_SHOW_TYPE_1_GREEN, 219 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 233 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 201 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 174 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_RED, 227 },
    { 591867, GO_FIREWORK_SHOW_TYPE_1_GREEN, 224 },
    { 591867, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 178 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 173 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 215 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 222 },
    { 591867, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 193 },
    { 591867, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 194 },
    { 591867, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 217 },
    { 591867, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 204 },
    { 591867, GO_FIREWORK_SHOW_TYPE_1_RED, 229 },
    { 591867, GO_FIREWORK_SHOW_TYPE_1_RED, 220 },
    { 593117, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 221 },
    { 593117, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 236 },
    { 593117, GO_FIREWORK_SHOW_TYPE_1_WHITE, 186 },
    { 593117, GO_FIREWORK_SHOW_TYPE_1_WHITE, 230 },
    { 593117, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 232 },
    { 593117, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 191 },
    { 593117, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 226 },
    { 593117, GO_FIREWORK_SHOW_TYPE_2_RED, 216 },
    { 593117, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 179 },
    { 593117, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 187 },
    { 593117, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 228 },
    { 594337, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 206 },
    { 594337, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 188 },
    { 594337, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 183 },
    { 594337, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 184 },
    { 594337, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 182 },
    { 594337, GO_FIREWORK_SHOW_TYPE_2_GREEN, 211 },
    { 594337, GO_FIREWORK_SHOW_TYPE_2_GREEN, 225 },
    { 594337, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 208 },
    { 594337, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 238 },
    { 594337, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 181 },
    { 594337, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 197 },
    { 594337, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 235 },
    { 594337, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 200 },
    { 594337, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 231 },
    { 595544, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 196 },
    { 595544, GO_FIREWORK_SHOW_TYPE_2_WHITE, 189 },
    { 595544, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 180 },
    { 595544, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 199 },
    { 595544, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 190 },
    { 595544, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 192 },
    { 595544, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 195 },
    { 596755, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 209 },
    { 596755, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 176 },
    { 600385, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 223 },
    { 600385, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 218 },
    { 600385, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 218 },
    { 601459, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 203 },
    { 601459, GO_FIREWORK_SHOW_TYPE_1_WHITE, 175 },
    { 601459, GO_FIREWORK_SHOW_TYPE_2_BLUE, 214 },
    { 601459, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 202 },
    { 601459, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 213 },
    { 603581, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 216 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_RED, 212 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_RED, 208 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 186 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_WHITE, 181 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_WHITE, 228 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_BLUE, 206 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_BLUE, 197 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_BLUE, 205 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_BLUE, 173 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 238 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 226 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 178 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 179 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 201 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 237 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 231 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 222 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 200 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_GREEN, 188 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_WHITE, 235 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 207 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 183 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_RED, 185 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_RED, 215 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_RED, 204 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 193 },
    { 605987, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 232 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 194 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 177 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 211 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 234 },
    { 605987, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 225 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_RED, 220 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 195 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_GREEN, 176 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_WHITE, 191 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_WHITE, 187 },
    { 607199, GO_FIREWORK_SHOW_TYPE_2_GREEN, 199 },
    { 607199, GO_FIREWORK_SHOW_TYPE_2_BLUE, 217 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 198 },
    { 607199, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 227 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_GREEN, 210 },
    { 607199, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 182 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_BLUE, 224 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 221 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 233 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 229 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 174 },
    { 607199, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 196 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 236 },
    { 607199, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 230 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 219 },
    { 607199, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 184 },
    { 608354, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 209 },
    { 608354, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 189 },
    { 608354, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 192 },
    { 608354, GO_FIREWORK_SHOW_TYPE_1_WHITE, 180 },
    { 610902, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 190 },
    { 611004, GO_FIREWORK_SHOW_TYPE_2_WHITE, 223 },
    { 611004, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 218 },
    { 612081, GO_FIREWORK_SHOW_TYPE_2_WHITE, 223 },
    { 612081, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 218 },
    { 615340, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 232 },
    { 615340, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 226 },
    { 615340, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 235 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 181 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_GREEN, 214 },
    { 616481, GO_FIREWORK_SHOW_TYPE_2_GREEN, 188 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_BLUE, 206 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 202 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 186 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_RED, 238 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_RED, 216 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 177 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 211 },
    { 616481, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 234 },
    { 616481, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 205 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 208 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 203 },
    { 616481, GO_FIREWORK_SHOW_TYPE_1_WHITE, 228 },
    { 618986, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 179 },
    { 618986, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 204 },
    { 618986, GO_FIREWORK_SHOW_TYPE_1_GREEN, 197 },
    { 618986, GO_FIREWORK_SHOW_TYPE_1_GREEN, 173 },
    { 618986, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 185 },
    { 618986, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 178 },
    { 618986, GO_FIREWORK_SHOW_TYPE_2_GREEN, 213 },
    { 618986, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 207 },
    { 618986, GO_FIREWORK_SHOW_TYPE_2_RED, 201 },
    { 618986, GO_FIREWORK_SHOW_TYPE_2_RED, 215 },
    { 618986, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 183 },
    { 618986, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 225 },
    { 618986, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 193 },
    { 618986, GO_FIREWORK_SHOW_TYPE_1_RED, 212 },
    { 618986, GO_FIREWORK_SHOW_TYPE_1_RED, 237 },
    { 618986, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 194 },
    { 618986, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 222 },
    { 618986, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 200 },
    { 618986, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 175 },
    { 618986, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 231 },
    { 620016, GO_FIREWORK_SHOW_TYPE_2_BLUE, 176 },
    { 620016, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 182 },
    { 620016, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 191 },
    { 620016, GO_FIREWORK_SHOW_TYPE_1_RED, 229 },
    { 621372, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 233 },
    { 621372, GO_FIREWORK_SHOW_TYPE_1_WHITE, 184 },
    { 621372, GO_FIREWORK_SHOW_TYPE_1_WHITE, 180 },
    { 621372, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 227 },
    { 621372, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 174 },
    { 621372, GO_FIREWORK_SHOW_TYPE_2_WHITE, 190 },
    { 621372, GO_FIREWORK_SHOW_TYPE_2_WHITE, 189 },
    { 621372, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 209 },
    { 621372, GO_FIREWORK_SHOW_TYPE_1_BLUE, 224 },
    { 621372, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 187 },
    { 621372, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 221 },
    { 621372, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 219 },
    { 621372, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 217 },
    { 621372, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 192 },
    { 623775, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 196 },
    { 623775, GO_FIREWORK_SHOW_TYPE_1_GREEN, 199 },
    { 623775, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 220 },
    { 623775, GO_FIREWORK_SHOW_TYPE_2_WHITE, 230 },
    { 623775, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 236 },
    { 623775, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 198 },
    { 623775, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 195 },
    { 623775, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 210 },
    { 625058, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 218 },
    { 625058, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 223 },
    { 628245, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 207 },
    { 628245, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 225 },
    { 628563, GO_FIREWORK_SHOW_TYPE_2_RED, 182 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 208 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 235 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 175 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_BLUE, 234 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 178 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 201 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 222 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 204 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_GREEN, 206 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 237 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 238 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 202 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 205 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 193 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 173 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 181 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 231 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 226 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_RED, 212 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_RED, 200 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 188 },
    { 629515, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 213 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 177 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 197 },
    { 629515, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 203 },
    { 630729, GO_FIREWORK_SHOW_TYPE_2_GREEN, 194 },
    { 630729, GO_FIREWORK_SHOW_TYPE_2_GREEN, 214 },
    { 630729, GO_FIREWORK_SHOW_TYPE_2_RED, 185 },
    { 630729, GO_FIREWORK_SHOW_TYPE_1_BLUE, 211 },
    { 630729, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 215 },
    { 631937, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 216 },
    { 631937, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 228 },
    { 631937, GO_FIREWORK_SHOW_TYPE_2_WHITE, 186 },
    { 631937, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 183 },
    { 631937, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 232 },
    { 631937, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 179 },
    { 633162, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 227 },
    { 633162, GO_FIREWORK_SHOW_TYPE_1_WHITE, 196 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 180 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 189 },
    { 634255, GO_FIREWORK_SHOW_TYPE_1_WHITE, 190 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 230 },
    { 634255, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 221 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 233 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 236 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 174 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_WHITE, 195 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_RED, 182 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_RED, 229 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 219 },
    { 634255, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 187 },
    { 635437, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 199 },
    { 635437, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 198 },
    { 635437, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 176 },
    { 635437, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 224 },
    { 635437, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 220 },
    { 635437, GO_FIREWORK_SHOW_TYPE_2_BLUE, 210 },
    { 635437, GO_FIREWORK_SHOW_TYPE_1_GREEN, 192 },
    { 635437, GO_FIREWORK_SHOW_TYPE_2_WHITE, 191 },
    { 635437, GO_FIREWORK_SHOW_TYPE_1_WHITE, 239 },
    { 635437, GO_FIREWORK_SHOW_TYPE_2_RED, 209 },
    { 635437, GO_FIREWORK_SHOW_TYPE_2_BLUE_BIG, 217 },
    { 635437, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 184 },
    { 638539, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 218 },
    { 638539, GO_FIREWORK_SHOW_TYPE_1_WHITE, 223 },
    { 639634, GO_FIREWORK_SHOW_TYPE_2_BLUE, 219 },
    { 639634, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 231 },
    { 639634, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 175 },
    { 639634, GO_FIREWORK_SHOW_TYPE_1_RED, 227 },
    { 639634, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 202 },
    { 639634, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 211 },
    { 639634, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 234 },
    { 639634, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 181 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_BLUE, 213 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_BLUE, 203 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_GREEN, 194 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 182 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 212 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 201 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 200 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 236 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_RED, 207 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_WHITE, 187 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 233 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 229 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_RED, 208 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 178 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_RED_BIG, 204 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 189 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_WHITE_BIG, 230 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_RED, 185 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_RED, 237 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_RED, 183 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_GREEN_BIG, 214 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_PURPLE_BIG, 216 },
    { 640848, GO_FIREWORK_SHOW_TYPE_1_BLUE, 225 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 232 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 235 },
    { 640848, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 226 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_BLUE, 206 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_BLUE, 177 },
    { 643167, GO_FIREWORK_SHOW_TYPE_1_YELLOW_BIG, 196 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_RED_BIG, 222 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 238 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_PURPLE, 174 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_GREEN, 188 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_PURPLE_BIG, 215 },
    { 643167, GO_FIREWORK_SHOW_TYPE_1_BLUE, 205 },
    { 643167, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 180 },
    { 643167, GO_FIREWORK_SHOW_TYPE_1_YELLOW, 195 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_YELLOW_BIG, 190 },
    { 643167, GO_FIREWORK_SHOW_TYPE_1_GREEN_BIG, 173 },
    { 643167, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 193 },
    { 643167, GO_FIREWORK_SHOW_TYPE_1_BLUE_BIG, 197 },
    { 643167, GO_FIREWORK_SHOW_TYPE_1_WHITE, 186 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 221 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_YELLOW, 228 },
    { 643167, GO_FIREWORK_SHOW_TYPE_2_WHITE_BIG, 179 },
};

// <mapId, zoneId>, <fireworkShow pointer, fireworkShow count>
std::map<std::pair<uint32, uint32>, std::pair<FireworkShow*, uint32>> const FireworkShowStore = {
    // Teldrassil
    { { 1, 141 }, { &fireworkShowTeldrassil, fireworkShowTeldrassil.size() } },
    // Stormwind
    { { 0, 1519 }, { &fireworkShowStormwind, fireworkShowStormwind.size() } },
    // Shattrath
    { { 530, 3703 } , { &fireworkShowShattrath, fireworkShowShattrath.size() } },
    // Silvermoon
    { { 530, 3430 } , { &fireworkShowSilvermoon, fireworkShowSilvermoon.size() } },
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
