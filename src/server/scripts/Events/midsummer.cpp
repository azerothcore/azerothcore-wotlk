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

#include "GameTime.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellScript.h"

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

struct npc_midsummer_bonfire : public ScriptedAI
{
    npc_midsummer_bonfire(Creature* creature) : ScriptedAI(creature)
    {
        me->IsAIEnabled = true;
        goGUID.Clear();
        if (GameObject* go = me->SummonGameObject(GO_MIDSUMMER_BONFIRE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 0))
        {
            goGUID = go->GetGUID();
            me->RemoveGameObject(go, false);
        }
    }

    ObjectGuid goGUID;

    void SpellHit(Unit*, SpellInfo const* spellInfo) override
    {
        if (!goGUID)
            return;

        // Extinguish fire
        if (spellInfo->Id == SPELL_STAMP_OUT_BONFIRE)
        {
            if (GameObject* go = ObjectAccessor::GetGameObject(*me, goGUID))
                go->SetPhaseMask(2, true);
        }
        else if (spellInfo->Id == SPELL_LIGHT_BONFIRE)
        {
            if (GameObject* go = ObjectAccessor::GetGameObject(*me, goGUID))
            {
                go->SetPhaseMask(1, true);
                go->SendCustomAnim(1);
            }
        }
    }
};

struct npc_midsummer_torch_target : public ScriptedAI
{
    npc_midsummer_torch_target(Creature* creature) : ScriptedAI(creature)
    {
        teleTimer = 0;
        startTimer = 1;
        posVec.clear();
        playerGUID.Clear();
        me->CastSpell(me, 43313, true);
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
        if (spellInfo->Id == 46054 && caster->GetTypeId() == TYPEID_PLAYER)
        {
            me->CastSpell(me, 45724, true); // hit visual anim
            if (++counter >= maxCount)
            {
                caster->CastSpell(caster, (caster->ToPlayer()->GetTeamId() ? 46651 : 45719), true); // quest complete spell
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
        me->GetGameObjectListWithEntryInGrid(gobjList, 187708 /*TORCH_GO*/, 30.0f);
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
        return ValidateSpellInfo({ SPELL_CRAB_DISGUISE });
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
        AfterEffectApply += AuraEffectRemoveFn(spell_gen_crab_disguise::OnApply, EFFECT_0, SPELL_AURA_FORCE_REACTION, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_gen_crab_disguise::OnRemove, EFFECT_0, SPELL_AURA_FORCE_REACTION, AURA_EFFECT_HANDLE_REAL);
    }
};

enum RibbonPole
{
    SPELL_RIBBON_POLE_CHANNEL_VISUAL    = 29172,
    SPELL_RIBBON_POLE_XP                = 29175,
    SPELL_RIBBON_POLE_FIREWORKS         = 46971,

    NPC_RIBBON_POLE_DEBUG_TARGET        = 17066,
};

class spell_midsummer_ribbon_pole : public AuraScript
{
    PrepareAuraScript(spell_midsummer_ribbon_pole)

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* target = GetTarget())
        {
            Creature* cr = target->FindNearestCreature(NPC_RIBBON_POLE_DEBUG_TARGET, 10.0f);
            if (!cr)
            {
                target->RemoveAura(SPELL_RIBBON_POLE_CHANNEL_VISUAL);
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
        ar->CastSpell(ar, SPELL_RIBBON_POLE_CHANNEL_VISUAL, true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_midsummer_ribbon_pole::HandleEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_midsummer_ribbon_pole::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
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
        if (Creature* cr = ar->SummonCreature(25535, ar->GetPositionX(), ar->GetPositionY(), ar->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 90000))
        {
            torchGUID = cr->GetGUID();
            CAST_AI(npc_midsummer_torch_target, cr->AI())->SetPlayerGUID(ar->GetGUID(), (GetId() == 45716 ? 8 : 20));
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
};

class spell_midsummer_fling_torch : public SpellScript
{
    PrepareSpellScript(spell_midsummer_fling_torch);

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
            caster->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_FLING_TORCH, true);
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
                if (target->GetQuestStatus(target->GetTeamId() ? 11925 : 11924) == QUEST_STATUS_INCOMPLETE) // More Torch Catching quests
                    count = 10;

                if (aur->GetStackAmount() >= count)
                {
                    //target->CastSpell(target, 46711, true); // Set Flag: all torch returning quests are complete
                    target->CastSpell(target, (target->GetTeamId() ? 46654 : 46081), true); // Quest completion
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
        if (m_scriptSpellId == 45671)
        {
            OnCheckCast += SpellCheckCastFn(spell_midsummer_fling_torch::CheckCast);
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
    QUEST_CHECK                 = 11937,
};

class spell_midsummer_juggling_torch : public SpellScript
{
    PrepareSpellScript(spell_midsummer_juggling_torch);

    bool handled;
    bool Load() override { handled = false; return true; }
    void HandleFinish()
    {
        Unit* caster = GetCaster();
        if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
            return;

        if (const WorldLocation* loc = GetExplTargetDest())
        {
            if (loc->GetExactDist(caster) < 3.0f)
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_JUGGLE_SELF, true);
            else if (loc->GetExactDist(caster) < 10.0f)
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_JUGGLE_SLOW, true);
            else if (loc->GetExactDist(caster) < 25.0f)
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_JUGGLE_MED, true);
            else
                caster->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), SPELL_JUGGLE_FAST, true);
        }
        else
            caster->CastSpell(caster, SPELL_JUGGLE_SELF, true);
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* caster = GetCaster();
        if (!caster || caster->GetTypeId() != TYPEID_PLAYER)
            return;

        if (Player* target = GetHitPlayer())
            if (!handled && target->GetQuestRewardStatus(target->GetTeamId() == TEAM_ALLIANCE ? 11657 : 11923))
            {
                handled = true;
                caster->CastSpell(target, SPELL_GIVE_TORCH, true);
            }
    }

    void Register() override
    {
        if (m_scriptSpellId == SPELL_TORCH_CHECK)
            OnEffectHitTarget += SpellEffectFn(spell_midsummer_juggling_torch::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        else
            AfterCast += SpellCastFn(spell_midsummer_juggling_torch::HandleFinish);
    }
};

void AddSC_event_midsummer_scripts()
{
    // NPCs
    new go_midsummer_bonfire();
    RegisterCreatureAI(npc_midsummer_bonfire);
    RegisterCreatureAI(npc_midsummer_torch_target);

    // Spells
    RegisterSpellScript(spell_gen_crab_disguise);
    RegisterSpellScript(spell_midsummer_ribbon_pole);
    RegisterSpellScript(spell_midsummer_torch_quest);
    RegisterSpellScript(spell_midsummer_fling_torch);
    RegisterSpellScript(spell_midsummer_juggling_torch);
}
