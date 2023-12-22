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
#include "GameObjectScript.h"
#include "GameTime.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include <random>

enum eBonfire
{
    GO_MIDSUMMER_BONFIRE                = 181288,

    SPELL_STAMP_OUT_BONFIRE             = 45437,
    SPELL_LIGHT_BONFIRE                 = 29831,
};

class go_midsummer_bonfire : public GameObjectScript
{
public:
    go_midsummer_bonfire() : GameObjectScript("go_midsummer_bonfire") { }

    bool OnGossipSelect(Player* player, GameObject*  /*go*/, uint32 /*sender*/, uint32  /*action*/) override
    {
        CloseGossipMenuFor(player);
        // we know that there is only one gossip.
        player->CastSpell(player, SPELL_STAMP_OUT_BONFIRE, true);
        return true;
    }
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

    SpellCastResult CheckCast()
    {
        GetCaster()->GetCreaturesWithEntryInRange(_crList, 100.0f, NPC_TORCH_TARGET);
        if (_crList.empty())
        {
            return SPELL_FAILED_NOT_HERE;
        }

        return SPELL_CAST_OK;
    }

    void ThrowNextTorch(Unit* caster)
    {
        uint8 rand = urand(0, _crList.size() - 1);
        Position pos;
        pos.Relocate(0.0f, 0.0f, 0.0f);
        for (std::list<Creature*>::const_iterator itr = _crList.begin(); itr != _crList.end(); ++itr, --rand)
        {
            if (caster->GetDistance(*itr) < 5)
            {
                if (!rand)
                    rand++;
                continue;
            }

            if (!rand)
            {
                pos.Relocate(*itr);
                break;
            }
        }

        // we have any pos
        if (pos.GetPositionX())
        {
            caster->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_FLING_TORCH, true);
            caster->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_TORCH_SHADOW, true);
        }
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
        OnCheckCast += SpellCheckCastFn(spell_midsummer_fling_torch::CheckCast);
        if (m_scriptSpellId == SPELL_JUGGLE_TORCH)
        {
            OnEffectHitTarget += SpellEffectFn(spell_midsummer_fling_torch::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    }

private:
    std::list<Creature*> _crList;
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

void AddSC_event_midsummer_scripts()
{
    // NPCs
    new go_midsummer_bonfire();
    RegisterCreatureAI(npc_midsummer_torch_target);
    RegisterCreatureAI(npc_midsummer_ribbon_pole_target);

    // Spells
    RegisterSpellScript(spell_gen_crab_disguise);
    RegisterSpellScript(spell_midsummer_ribbon_pole_firework);
    RegisterSpellScript(spell_midsummer_ribbon_pole);
    RegisterSpellScript(spell_midsummer_ribbon_pole_visual);
    RegisterSpellScript(spell_midsummer_torch_quest);
    RegisterSpellScript(spell_midsummer_fling_torch);
    RegisterSpellScript(spell_midsummer_juggling_torch);
    RegisterSpellScript(spell_midsummer_torch_catch);
}

