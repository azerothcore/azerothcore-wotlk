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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    SPELL_MENDING_BUFF                  = 2147,

    SPELL_KNOCK_BUFF                    = 21737,
    SPELL_KNOCK                         = 25778,
    SPELL_MANAB_BUFF                    = 812,
    SPELL_MANAB                         = 25779,

    SPELL_REFLECTAF_BUFF                = 13022,
    SPELL_REFLECTSFr_BUFF               = 19595,
    SPELL_THORNS_BUFF                   = 25777,

    SPELL_THUNDER_BUFF                  = 2834,
    SPELL_THUNDER                       = 8732,

    SPELL_MSTRIKE_BUFF                  = 9347,
    SPELL_MSTRIKE                       = 24573,

    SPELL_STORM_BUFF                    = 2148,
    SPELL_STORM                         = 26546,

    SPELL_SUMMON_SMALL_OBSIDIAN_CHUNK   = 27627, // Server-side

    SPELL_TRANSFER_POWER                = 2400,
    SPELL_HEAL_BRETHEN                  = 26565,
    SPELL_ENRAGE                        = 8599,

    TALK_ENRAGE                         = 0
};

class npc_anubisath_sentinel : public CreatureScript
{
public:
    npc_anubisath_sentinel() : CreatureScript("npc_anubisath_sentinel") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new aqsentinelAI(creature);
    }

    struct aqsentinelAI : public ScriptedAI
    {
        uint32 ability;
        int abselected;

        void selectAbility(int asel)
        {
            switch (asel)
            {
                case 0:
                    ability = SPELL_MENDING_BUFF;
                    break;
                case 1:
                    ability = SPELL_KNOCK_BUFF;
                    break;
                case 2:
                    ability = SPELL_MANAB_BUFF;
                    break;
                case 3:
                    ability = SPELL_REFLECTAF_BUFF;
                    break;
                case 4:
                    ability = SPELL_REFLECTSFr_BUFF;
                    break;
                case 5:
                    ability = SPELL_THORNS_BUFF;
                    break;
                case 6:
                    ability = SPELL_THUNDER_BUFF;
                    break;
                case 7:
                    ability = SPELL_MSTRIKE_BUFF;
                    break;
                case 8:
                    ability = SPELL_STORM_BUFF;
                    break;
            }
        }

        aqsentinelAI(Creature* creature) : ScriptedAI(creature)
        {
            ClearBuddyList();
            abselected = 0;                                     // just initialization of variable
        }

        ObjectGuid NearbyGUID[3];

        void ClearBuddyList()
        {
            for (uint8 i = 0; i < 3; ++i)
                NearbyGUID[i].Clear();
        }

        void AddBuddyToList(ObjectGuid CreatureGUID)
        {
            if (CreatureGUID == me->GetGUID())
                return;

            for (int i = 0; i < 3; ++i)
            {
                if (NearbyGUID[i] == CreatureGUID)
                    return;
                if (!NearbyGUID[i])
                {
                    NearbyGUID[i] = CreatureGUID;
                    return;
                }
            }
        }

        void GiveBuddyMyList(Creature* c)
        {
            aqsentinelAI* cai = CAST_AI(aqsentinelAI, (c)->AI());
            for (int i = 0; i < 3; ++i)
                if (NearbyGUID[i] && NearbyGUID[i] != c->GetGUID())
                    cai->AddBuddyToList(NearbyGUID[i]);
            cai->AddBuddyToList(me->GetGUID());
        }

        void SendMyListToBuddies()
        {
            for (int i = 0; i < 3; ++i)
                if (Creature* pNearby = ObjectAccessor::GetCreature(*me, NearbyGUID[i]))
                    GiveBuddyMyList(pNearby);
        }

        void CallBuddiesToAttack(Unit* who)
        {
            for (int i = 0; i < 3; ++i)
            {
                Creature* c = ObjectAccessor::GetCreature(*me, NearbyGUID[i]);
                if (c)
                {
                    if (!c->IsInCombat())
                    {
                        c->SetNoCallAssistance(true);
                        if (c->AI())
                            c->AI()->AttackStart(who);
                    }
                }
            }
        }

        void AddSentinelsNear(Unit* /*nears*/)
        {
            std::list<Creature*> assistList;
            me->GetCreatureListWithEntryInGrid(assistList, 15264, 100.0f);

            if (assistList.empty())
                return;

            for (std::list<Creature*>::const_iterator iter = assistList.begin(); iter != assistList.end(); ++iter)
                AddBuddyToList((*iter)->GetGUID());
        }

        int pickAbilityRandom(bool* chosenAbilities)
        {
            for (int t = 0; t < 2; ++t)
            {
                for (int i = !t ? (rand() % 9) : 0; i < 9; ++i)
                {
                    if (!chosenAbilities[i])
                    {
                        chosenAbilities[i] = true;
                        return i;
                    }
                }
            }
            return 0;                                           // should never happen
        }

        void GetOtherSentinels(Unit* who)
        {
            bool* chosenAbilities = new bool[9];
            memset(chosenAbilities, 0, 9 * sizeof(bool));
            selectAbility(pickAbilityRandom(chosenAbilities));

            ClearBuddyList();
            AddSentinelsNear(me);
            int bli;
            for (bli = 0; bli < 3; ++bli)
            {
                if (!NearbyGUID[bli])
                    break;

                Creature* pNearby = ObjectAccessor::GetCreature(*me, NearbyGUID[bli]);
                if (!pNearby)
                    break;

                AddSentinelsNear(pNearby);
                CAST_AI(aqsentinelAI, pNearby->AI())->gatherOthersWhenAggro = false;
                CAST_AI(aqsentinelAI, pNearby->AI())->selectAbility(pickAbilityRandom(chosenAbilities));
            }
            /*if (bli < 3)
                DoYell("I dont have enough buddies.", LANG_NEUTRAL, 0);*/
            SendMyListToBuddies();
            CallBuddiesToAttack(who);

            delete[] chosenAbilities;
        }

        bool gatherOthersWhenAggro;

        void Reset() override
        {
            if (!me->isDead())
            {
                for (int i = 0; i < 3; ++i)
                {
                    if (!NearbyGUID[i])
                        continue;
                    if (Creature* pNearby = ObjectAccessor::GetCreature(*me, NearbyGUID[i]))
                    {
                        if (pNearby->isDead())
                            pNearby->Respawn();
                    }
                }
            }
            ClearBuddyList();
            gatherOthersWhenAggro = true;
            _enraged = false;
        }

        void GainSentinelAbility(uint32 id)
        {
            me->AddAura(id, me);
        }

        void EnterCombat(Unit* who) override
        {
            if (gatherOthersWhenAggro)
                GetOtherSentinels(who);

            GainSentinelAbility(ability);
            DoZoneInCombat();
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_TRANSFER_POWER)
            {
                if (Creature* sentinel = target->ToCreature())
                {
                    if (sentinel->IsAIEnabled)
                    {
                        CAST_AI(aqsentinelAI, sentinel->AI())->GainSentinelAbility(ability);
                    }
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            for (int ni = 0; ni < 3; ++ni)
            {
                Creature* sent = ObjectAccessor::GetCreature(*me, NearbyGUID[ni]);
                if (!sent)
                    continue;
                if (sent->isDead())
                    continue;
                DoCast(sent, SPELL_HEAL_BRETHEN, true);
                DoCast(sent, SPELL_TRANSFER_POWER, true);
            }

            DoCastSelf(SPELL_SUMMON_SMALL_OBSIDIAN_CHUNK, true);
        }

        void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            if (!_enraged && me->HealthBelowPctDamaged(50, damage))
            {
                _enraged = true;
                damage = 0;
                DoCastSelf(SPELL_ENRAGE, true);
                Talk(TALK_ENRAGE);
            }
        }

    private:
        bool _enraged;
    };
};

// 9347: Mortal Strike
class spell_anubisath_mortal_strike : public AuraScript
{
    PrepareAuraScript(spell_anubisath_mortal_strike);

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();

        if (Unit* target = GetUnitOwner()->GetVictim())
            if (target->IsWithinDist(GetUnitOwner(), 5.f))
                GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_anubisath_mortal_strike::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 26626 (Server-side): Mana Burn Area
class spell_mana_burn_area : public SpellScript
{
    PrepareSpellScript(spell_mana_burn_area);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_MANAB, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_mana_burn_area::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_npc_anubisath_sentinel()
{
    new npc_anubisath_sentinel();
    RegisterSpellScript(spell_anubisath_mortal_strike);
    RegisterSpellScript(spell_mana_burn_area);
}
