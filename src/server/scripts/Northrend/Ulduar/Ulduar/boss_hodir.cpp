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

#include "AchievementCriteriaScript.h"
#include "AreaDefines.h"
#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

enum HodirSpellData
{
    SPELL_BERSERK                       = 26662,

    SPELL_BITING_COLD_BOSS_AURA         = 62038,
    SPELL_BITING_COLD_PLAYER_AURA       = 62039,
    SPELL_BITING_COLD_DAMAGE            = 62188,

    SPELL_FREEZE                        = 62469,

    SPELL_FLASH_FREEZE_CAST             = 61968,
    SPELL_FLASH_FREEZE_INSTAKILL        = 62226,
    SPELL_FLASH_FREEZE_TRAPPED_PLAYER   = 61969,
    SPELL_FLASH_FREEZE_TRAPPED_NPC      = 61990,
    SPELL_FLASH_FREEZE_VISUAL           = 62148,
    SPELL_SAFE_AREA                     = 65705,
    SPELL_SAFE_AREA_TRIGGERED           = 62464,
    SPELL_SHATTER_CHEST                 = 62501,

    SPELL_ICICLE_BOSS_AURA              = 62227,
    SPELL_ICICLE_TBBA                   = 63545,

    SPELL_ICICLE_VISUAL_UNPACKED        = 62234,
    SPELL_ICICLE_VISUAL_PACKED          = 62462,
    SPELL_ICICLE_VISUAL_FALLING         = 62453,
    SPELL_ICICLE_FALL_EFFECT_UNPACKED   = 62236,
    SPELL_ICICLE_FALL_EFFECT_PACKED     = 62460,
    SPELL_ICE_SHARDS_SMALL              = 62457,
    SPELL_ICE_SHARDS_BIG                = 65370,
    SPELL_SNOWDRIFT                     = 62463,

    SPELL_FROZEN_BLOWS                  = 62478,

    // Helpers:
    SPELL_PRIEST_DISPELL_MAGIC          = 63499,
    SPELL_PRIEST_GREAT_HEAL             = 62809,
    SPELL_PRIEST_SMITE                  = 61923,

    SPELL_DRUID_WRATH                   = 62793,
    SPELL_DRUID_STARLIGHT_AREA_AURA     = 62807,

    SPELL_SHAMAN_LAVA_BURST             = 61924,
    SPELL_SHAMAN_STORM_CLOUD            = 65123,
    SPELL_SHAMAN_STORM_POWER            = 63711,
    SPELL_SHAMAN_STORM_POWER_25         = 65134,

    SPELL_MAGE_FIREBALL                 = 61909,
    SPELL_MAGE_MELT_ICE                 = 64528,
    SPELL_MAGE_CONJURE_TOASTY_FIRE      = 62823,
    SPELL_MAGE_SUMMON_TOASTY_FIRE       = 62819,
    SPELL_MAGE_TOASTY_FIRE_AURA         = 62821,
    SPELL_SINGED                        = 65280,
};

enum HodirNPCs
{
    //NPC_HODIR                         = 32845,

    NPC_PAN_FIELD_MEDIC_PENNY           = 32897,
    NPC_DAN_ELLIE_NIGHTFEATHER          = 32901,
    NPC_SAN_ELEMENTALIST_AVUUN          = 32900,
    NPC_MAN_MISSY_FLAMECUFFS            = 32893,

    NPC_PAH_FIELD_MEDIC_JESSI           = 33326,
    NPC_DAH_EIVI_NIGHTFEATHER           = 33325,
    NPC_SAH_ELEMENTALIST_MAHFUUN        = 33328,
    NPC_MAH_SISSY_FLAMECUFFS            = 33327,

    NPC_PHN_BATTLEPRIEST_ELIZA          = 32948,
    NPC_DHN_TOR_GREYCLOUD               = 32941,
    NPC_SHN_SPIRITWALKER_YONA           = 32950,
    NPC_MHN_VEESHA_BLAZEWEAVER          = 32946,

    NPC_PHH_BATTLEPRIEST_GINA           = 33330,
    NPC_DHH_KAR_GREYCLOUD               = 33333,
    NPC_SHH_SPIRITWALKER_TARA           = 33332,
    NPC_MHH_AMIRA_BLAZEWEAVER           = 33331,

    NPC_FLASH_FREEZE_PLR                = 32926,
    NPC_FLASH_FREEZE_NPC                = 32938,
    NPC_ICICLE_UNPACKED                 = 33169,
    NPC_ICICLE_PACKED                   = 33173,
    NPC_TOASTY_FIRE                     = 33342,
    NPC_RARE_WINTER_CACHE_TRIGGER       = 88101,
};

enum HodirEvents
{
    // Hodir:
    EVENT_FLASH_FREEZE                  = 1,
    EVENT_FROZEN_BLOWS                  = 2,
    EVENT_BERSERK                       = 3,
    EVENT_FREEZE                        = 4,
    EVENT_SMALL_ICICLES_ENABLE          = 5,
    EVENT_HARD_MODE_MISSED              = 6,
    EVENT_DESPAWN_CHEST                 = 7,
    EVENT_FAIL_HM                       = 8,

    EVENT_TRY_FREE_HELPER               = 10,
    EVENT_PRIEST_DISPELL_MAGIC          = 11,
    EVENT_PRIEST_GREAT_HEAL             = 12,
    EVENT_PRIEST_SMITE                  = 13,
    EVENT_DRUID_WRATH                   = 14,
    EVENT_DRUID_STARLIGHT               = 15,
    EVENT_SHAMAN_LAVA_BURST             = 16,
    EVENT_SHAMAN_STORM_CLOUD            = 17,
    EVENT_MAGE_TOASTY_FIRE              = 18,
    EVENT_MAGE_FIREBALL                 = 19,
    EVENT_MAGE_MELT_ICE                 = 20,
};

enum HodirText
{
    TEXT_AGGRO          = 0,
    TEXT_SLAY           = 1,
    TEXT_FLASH_FREEZE   = 2,
    TEXT_STALACTITE     = 3,
    TEXT_DEATH          = 4,
    TEXT_BERSERK        = 5,
    TEXT_HM_MISS        = 6,
    TEXT_EMOTE_FREEZE   = 7,
    TEXT_EMOTE_BLOW     = 8,
};

enum HodirSounds
{
    SOUND_HODIR_AGGRO                   = 15552,
    SOUND_HODIR_SLAIN_1                 = 15553,
    SOUND_HODIR_SLAIN_2                 = 15554,
    SOUND_HODIR_FLASH_FREEZE            = 15555,
    SOUND_HODIR_FROZEN_BLOWS            = 15556,
    SOUND_HODIR_DEFEATED                = 15557,
    SOUND_HODIR_BERSERK                 = 15558,
};

struct HodirHelperData
{
    uint32 id;
    float x, y;
};
HodirHelperData hhd[4][4] =
{
    // Alliance:
    {
        {NPC_PAN_FIELD_MEDIC_PENNY, 2020.46f, -236.74f},
        {NPC_DAN_ELLIE_NIGHTFEATHER, 2007.21f, -241.57f},
        {NPC_SAN_ELEMENTALIST_AVUUN, 1999.14f, -230.69f},
        {NPC_MAN_MISSY_FLAMECUFFS, 1984.38f, -242.57f}
    },
    {
        {NPC_PAH_FIELD_MEDIC_JESSI, 2012.29f, -233.70f},
        {NPC_DAH_EIVI_NIGHTFEATHER, 1995.75f, -241.32f},
        {NPC_SAH_ELEMENTALIST_MAHFUUN, 1989.31f, -234.26f},
        {NPC_MAH_SISSY_FLAMECUFFS, 1977.87f, -233.99f}
    },
    // Horde:
    {
        {NPC_PHN_BATTLEPRIEST_ELIZA, 2020.46f, -236.74f},
        {NPC_DHN_TOR_GREYCLOUD, 2007.21f, -241.57f},
        {NPC_SHN_SPIRITWALKER_YONA, 1999.14f, -230.69f},
        {NPC_MHN_VEESHA_BLAZEWEAVER, 1984.38f, -242.57f}
    },
    {
        {NPC_PHH_BATTLEPRIEST_GINA, 2012.29f, -233.70f},
        {NPC_DHH_KAR_GREYCLOUD, 1995.75f, -241.32f},
        {NPC_SHH_SPIRITWALKER_TARA, 1989.31f, -234.6f},
        {NPC_MHH_AMIRA_BLAZEWEAVER, 1977.87f, -233.99f}
    }
};

class boss_hodir : public CreatureScript
{
public:
    boss_hodir() : CreatureScript("boss_hodir") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_hodirAI>(pCreature);
    }

    struct boss_hodirAI : public ScriptedAI
    {
        boss_hodirAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = pCreature->GetInstanceScript();
            if (!me->IsAlive())
                if (pInstance)
                    pInstance->SetData(TYPE_HODIR, DONE);
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        ObjectGuid Helpers[8];
        bool berserk{ false };
        bool bAchievCheese{ true };
        bool bAchievGettingCold{ true };
        bool bAchievCacheRare{ true };
        bool bAchievCoolestFriends{ true };
        uint16 addSpawnTimer{ 0 };

        // Used to make Hodir disengage whenever he leaves his room
        const Position ENTRANCE_DOOR{ 1999.160034f, -297.792999f, 431.960999f, 0 };
        const Position EXIT_DOOR{ 1999.709961f, -166.259003f, 432.822998f, 0 };

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
            berserk = false;
            bAchievCheese = true;
            bAchievGettingCold = true;
            bAchievCacheRare = true;
            bAchievCoolestFriends = true;
            me->SetSheath(SHEATH_STATE_MELEE);

            // Reset the spells cast after wipe
            me->RemoveAllAuras();
            pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BITING_COLD_PLAYER_AURA);

            if (pInstance && pInstance->GetData(TYPE_HODIR) != DONE)
            {
                pInstance->SetData(TYPE_HODIR, NOT_STARTED);
            }

            if (GameObject* go = me->FindNearestGameObject(GO_HODIR_FRONTDOOR, 900.0f))
            {
                go->SetGoState(GO_STATE_ACTIVE);
            }

            // Reset helpers
            if (!summons.size())
                SpawnHelpers();
        }

        void JustEngagedWith(Unit*  /*pWho*/) override
        {
            me->CastSpell(me, SPELL_BITING_COLD_BOSS_AURA, true);
            SmallIcicles(true);
            events.Reset();
            events.ScheduleEvent(EVENT_FLASH_FREEZE, 48s, 49s);
            events.ScheduleEvent(EVENT_FREEZE, 17s, 20s);
            events.ScheduleEvent(EVENT_BERSERK, 8min);
            events.ScheduleEvent(EVENT_HARD_MODE_MISSED, 3min);
            Talk(TEXT_AGGRO);

            if (pInstance && pInstance->GetData(TYPE_HODIR) != DONE)
            {
                pInstance->SetData(TYPE_HODIR, IN_PROGRESS);
            }

            if (GameObject* go = me->FindNearestGameObject(GO_HODIR_FRONTDOOR, 300.0f))
            {
                go->SetGoState(GO_STATE_READY);
            }
        }

        void DoAction(int action) override
        {
            if (action)
            {
                switch (action)
                {
                    case EVENT_FAIL_HM:
                        if (pInstance)
                        {
                            if (GameObject* go = pInstance->instance->GetGameObject(pInstance->GetGuidData(GO_HODIR_CHEST_HARD)))
                            {
                                go->SetGoState(GO_STATE_ACTIVE);
                                events.ScheduleEvent(EVENT_DESPAWN_CHEST, 3s);
                            }
                        }
                        break;
                }
            }
        }

        void SmallIcicles(bool enable)
        {
            if (enable)
                me->CastSpell(me, SPELL_ICICLE_BOSS_AURA, true);
            else
                me->RemoveAura(SPELL_ICICLE_BOSS_AURA);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            switch (spell->Id)
            {
                case SPELL_ICICLE_TBBA:
                    me->CastSpell(target, SPELL_ICICLE_VISUAL_UNPACKED, true);
                    break;
                case SPELL_FLASH_FREEZE_VISUAL:
                    {
                        std::list<Creature*> fires;
                        me->GetCreaturesWithEntryInRange(fires, 200.0f, NPC_TOASTY_FIRE);
                        for (std::list<Creature*>::iterator itr = fires.begin(); itr != fires.end(); ++itr)
                            (*itr)->AI()->DoAction(1); // remove it
                    }
                    break;
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth() || me->GetHealth() < 150000)
            {
                damage = 0;
                me->SetReactState(REACT_PASSIVE);
                if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                {
                    if (pInstance)
                    {
                        pInstance->SetData(TYPE_HODIR, DONE);
                        me->CastSpell(me, 64899, true); // credit
                        pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BITING_COLD_PLAYER_AURA);
                    }

                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetFaction(FACTION_FRIENDLY);
                    me->GetMotionMaster()->Clear();
                    me->AttackStop();
                    me->CombatStop();
                    me->InterruptNonMeleeSpells(true);
                    me->RemoveAllAuras();

                    events.Reset();
                    summons.DespawnAll();

                    if (GameObject* d = me->FindNearestGameObject(GO_HODIR_FROZEN_DOOR, 250.0f))
                    {
                        if (d->GetGoState() != GO_STATE_ACTIVE )
                        {
                            d->SetLootState(GO_READY);
                            d->UseDoorOrButton(0, false);
                        }
                    }
                    if (GameObject* d = me->FindNearestGameObject(GO_HODIR_DOOR, 250.0f))
                    {
                        if (d->GetGoState() != GO_STATE_ACTIVE )
                        {
                            d->SetLootState(GO_READY);
                            d->UseDoorOrButton(0, false);
                        }
                    }

                    if (GameObject* go = me->FindNearestGameObject(GO_HODIR_FRONTDOOR, 300.0f))
                    {
                        go->SetGoState(GO_STATE_ACTIVE);
                    }

                    Talk(TEXT_DEATH);
                    scheduler.Schedule(14s, [this](TaskContext /*context*/)
                    {
                        DoCastSelf(SPELL_TELEPORT);
                    });
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            scheduler.Update(diff);
            if (me->GetPositionY() <= ENTRANCE_DOOR.GetPositionY() || me->GetPositionY() >= EXIT_DOOR.GetPositionY())
            {
                boss_hodirAI::EnterEvadeMode();
                return;
            }

            if (!UpdateVictim())
            {
                if (me->IsInCombat())
                {
                    Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                        itr->GetSource()->CastSpell(itr->GetSource(), SPELL_FLASH_FREEZE_INSTAKILL, true);
                    EnterEvadeMode();
                }
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_BERSERK:
                    {
                        berserk = true;
                        me->CastSpell(me, SPELL_BERSERK, true);
                        Talk(TEXT_BERSERK);
                    }
                    break;
                case EVENT_HARD_MODE_MISSED:
                    {
                        Talk(TEXT_HM_MISS);
                        bAchievCacheRare = false;
                        if (pInstance)
                        {
                            if (GameObject* go = pInstance->instance->GetGameObject(pInstance->GetGuidData(GO_HODIR_CHEST_HARD)))
                            {
                                me->CastSpell(go, SPELL_SHATTER_CHEST, false);
                            }
                        }
                    }
                    break;
                case EVENT_DESPAWN_CHEST:
                    if (pInstance && pInstance->GetData(TYPE_HODIR) != DONE)
                        pInstance->SetData(TYPE_HODIR_HM_FAIL, 0);
                    break;
                case EVENT_FLASH_FREEZE:
                    {
                        std::list<Unit*> targets;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                            targets.push_back(itr->GetSource());
                        targets.remove_if(Acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
                        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_FLASH_FREEZE_TRAPPED_PLAYER));
                        Acore::Containers::RandomResize(targets, (RAID_MODE(2,3)));
                        for (std::list<Unit*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
                        {
                            float prevZ = (*itr)->GetPositionZ();
                            (*itr)->m_positionZ = 432.7f;
                            (*itr)->CastSpell((*itr), SPELL_ICICLE_VISUAL_PACKED, true);
                            (*itr)->m_positionZ = prevZ;
                        }

                        me->CastSpell((Unit*)nullptr, SPELL_FLASH_FREEZE_CAST, false);
                        me->PlayDirectSound(SOUND_HODIR_FLASH_FREEZE, 0);
                        Talk(TEXT_FLASH_FREEZE);
                        Talk(TEXT_EMOTE_FREEZE);
                        SmallIcicles(false);
                        events.ScheduleEvent(EVENT_FLASH_FREEZE, 48s, 49s);
                        events.ScheduleEvent(EVENT_SMALL_ICICLES_ENABLE, Is25ManRaid() ? 12s : 24s);
                        events.ScheduleEvent(EVENT_FROZEN_BLOWS, 15s);
                        events.RescheduleEvent(EVENT_FREEZE, 17s, 20s);
                    }
                    break;
                case EVENT_SMALL_ICICLES_ENABLE:
                    {
                        SmallIcicles(true);
                    }
                    break;
                case EVENT_FROZEN_BLOWS:
                    {
                        Talk(TEXT_EMOTE_BLOW);
                        Talk(TEXT_STALACTITE);
                        me->CastSpell(me, SPELL_FROZEN_BLOWS, true);
                    }
                    break;
                case EVENT_FREEZE:
                    if (Player* plr = SelectTargetFromPlayerList(50.0f, SPELL_FLASH_FREEZE_TRAPPED_PLAYER))
                    {
                        me->CastSpell(plr, SPELL_FREEZE, false);
                    }
                    else if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                    {
                        me->CastSpell(target, SPELL_FREEZE, false);
                    }
                    events.RescheduleEvent(EVENT_FREEZE, 17s, 20s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_TELEPORT)
            {
                me->DespawnOrUnsummon();
                pInstance->SetData(EVENT_KEEPER_TELEPORTED, DONE);
            }
        }

        Creature* GetHelper(uint8 index)
        {
            return Helpers[index] ? ObjectAccessor::GetCreature(*me, Helpers[index]) : nullptr;
        }

        void SpawnHelpers()
        {
            char faction = 'A';
            if (hhd[0][0].id)
            {
                Map::PlayerList const& cl = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = cl.begin(); itr != cl.end(); ++itr)
                    if (!itr->GetSource()->IsGameMaster())
                    {
                        faction = (itr->GetSource()->GetTeamId() == TEAM_ALLIANCE ? 'A' : 'H');
                        break;
                    }
            }

            uint8 cnt = 0;
            if (faction)
                for( uint8 k = 0; k < 4; ++k )
                {
                    if ((faction == 'A' && ( k > 1 || (k == 1 && RAID_MODE(1, 0)))) ||
                            (faction == 'H' && ( k < 2 || (k == 3 && RAID_MODE(1, 0)))))
                        continue;

                    for( uint8 i = 0; i < 4; ++i )
                    {
                        if (!hhd[k][i].id)
                            continue;

                        if (Creature* h_p = me->SummonCreature(hhd[k][i].id, hhd[k][i].x, hhd[k][i].y, 432.69f, M_PI / 2))
                        {
                            h_p->SetFaction(1665);
                            if (cnt < 8)
                                Helpers[cnt++] = h_p->GetGUID();

                            if (Creature* c = h_p->SummonCreature(NPC_FLASH_FREEZE_NPC, h_p->GetPositionX(), h_p->GetPositionY(), h_p->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000))
                            {
                                c->CastSpell(h_p, SPELL_FLASH_FREEZE_TRAPPED_NPC, true);
                                JustSummoned(c);
                            }
                        }
                    }
                }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                Talk(TEXT_SLAY);
        }

        void JustSummoned(Creature* s) override
        {
            summons.Summon(s);
        }

        void SummonedCreatureDespawn(Creature* s) override
        {
            summons.Despawn(s);
        }

        bool CanAIAttack(Unit const* t) const override
        {
            if (t->IsPlayer())
                return !t->HasAura(SPELL_FLASH_FREEZE_TRAPPED_PLAYER);
            else if (t->IsCreature())
                return !t->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC);

            return true;
        }

        void SetData(uint32 id, uint32 value) override
        {
            if (value)
                switch (id)
                {
                    case 1:
                        bAchievCheese = false;
                        break;
                    case 2:
                        bAchievGettingCold = false;
                        break;
                    case 4:
                        bAchievCoolestFriends = false;
                        break;
                }
        }

        uint32 GetData(uint32 id) const override
        {
            switch (id)
            {
                case 1:
                    return (bAchievCheese ? 1 : 0);
                case 2:
                    return (bAchievGettingCold ? 1 : 0);
                case 3:
                    return (bAchievCacheRare ? 1 : 0);
                case 4:
                    return (bAchievCoolestFriends ? 1 : 0);
            }
            return 0;
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}
    };
};

class npc_ulduar_icicle : public CreatureScript
{
public:
    npc_ulduar_icicle() : CreatureScript("npc_ulduar_icicle") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_icicleAI>(pCreature);
    }

    struct npc_ulduar_icicleAI : public NullCreatureAI
    {
        npc_ulduar_icicleAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            timer1 = 2000;
            timer2 = 5000;
        }

        uint16 timer1;
        uint16 timer2;

        void UpdateAI(uint32 diff) override
        {
            if (timer1 <= diff)
            {
                me->CastSpell(me, (me->GetEntry() == 33169 ? SPELL_ICICLE_FALL_EFFECT_UNPACKED : SPELL_ICICLE_FALL_EFFECT_PACKED), true);
                me->CastSpell(me, SPELL_ICICLE_VISUAL_FALLING, false);
                timer1 = 60000;
            }
            else
                timer1 -= diff;

            if (timer2 <= diff)
            {
                me->SetDisplayId(11686);
                timer2 = 60000;
            }
            else
                timer2 -= diff;
        }
    };
};

class npc_ulduar_flash_freeze : public CreatureScript
{
public:
    npc_ulduar_flash_freeze() : CreatureScript("npc_ulduar_flash_freeze") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_flash_freezeAI>(pCreature);
    }

    struct npc_ulduar_flash_freezeAI : public NullCreatureAI
    {
        npc_ulduar_flash_freezeAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            timer = 2500;
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        uint16 timer;

        void DamageTaken(Unit* doneBy, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (pInstance && doneBy)
                if (pInstance->GetData(TYPE_HODIR) == NOT_STARTED)
                    if (Creature* hodir = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(TYPE_HODIR)))
                        hodir->AI()->AttackStart(doneBy);
        }

        void UpdateAI(uint32 diff) override
        {
            if (timer <= diff)
            {
                timer = 2500;
                if (me->IsSummon())
                {
                    if (Unit* s = me->ToTempSummon()->GetSummonerUnit())
                    {
                        if ((s->IsPlayer() && !s->HasAura(SPELL_FLASH_FREEZE_TRAPPED_PLAYER)) || (s->IsCreature() && !s->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC)))
                            me->DespawnOrUnsummon(2s);
                        else if (s->IsPlayer())
                            if (InstanceScript* instanceScript = me->GetInstanceScript())
                                if (instanceScript->GetData(TYPE_HODIR) == NOT_STARTED)
                                {
                                    s->CastSpell(s, SPELL_FLASH_FREEZE_INSTAKILL, true);
                                    me->DespawnOrUnsummon(2s);
                                }
                    }
                    else
                    {
                        me->DespawnOrUnsummon(2s);
                    }
                }
            }
            else
                timer -= diff;
        }
    };
};

class npc_ulduar_toasty_fire : public CreatureScript
{
public:
    npc_ulduar_toasty_fire() : CreatureScript("npc_ulduar_toasty_fire") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_toasty_fireAI>(pCreature);
    }

    struct npc_ulduar_toasty_fireAI : public NullCreatureAI
    {
        npc_ulduar_toasty_fireAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            me->CastSpell(me, SPELL_MAGE_TOASTY_FIRE_AURA, true);
        }

        void DoAction(int32 a) override
        {
            if (a == 1)
            {
                if (GameObject* fire = me->FindNearestGameObject(194300, 1.0f))
                {
                    fire->SetOwnerGUID(ObjectGuid::Empty);
                    fire->Delete();
                }
                me->DespawnOrUnsummon(); // this will remove DynObjects
            }
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spell) override
        {
            switch (spell->Id)
            {
                case SPELL_ICE_SHARDS_SMALL:
                case SPELL_ICE_SHARDS_BIG:
                    DoAction(1);
                    break;
            }
        }
    };
};

class npc_ulduar_hodir_priest : public CreatureScript
{
public:
    npc_ulduar_hodir_priest() : CreatureScript("npc_ulduar_hodir_priest") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_hodir_priestAI>(pCreature);
    }

    struct npc_ulduar_hodir_priestAI : public ScriptedAI
    {
        npc_ulduar_hodir_priestAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
        }

        EventMap events;
        InstanceScript* pInstance;

        void AttackStart(Unit* who) override
        {
            AttackStartCaster(who, 17.0f);
        }

        void ScheduleAbilities()
        {
            events.ScheduleEvent(EVENT_PRIEST_DISPELL_MAGIC, 7s);
            events.ScheduleEvent(EVENT_PRIEST_GREAT_HEAL, 6s, 7s);
            events.ScheduleEvent(EVENT_PRIEST_SMITE, 2100ms);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_FLASH_FREEZE_TRAPPED_NPC)
            {
                events.Reset();
                events.ScheduleEvent(EVENT_TRY_FREE_HELPER, 2s);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_TRY_FREE_HELPER:
                    {
                        if (!me->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC))
                            if (pInstance)
                                if (ObjectGuid g = pInstance->GetGuidData(TYPE_HODIR))
                                    if (Creature* hodir = ObjectAccessor::GetCreature(*me, g))
                                    {
                                        AttackStart(hodir);
                                        ScheduleAbilities();
                                        break;
                                    }
                        events.Repeat(2s);
                    }
                    break;
                case EVENT_PRIEST_DISPELL_MAGIC:
                    me->CastCustomSpell(SPELL_PRIEST_DISPELL_MAGIC, SPELLVALUE_MAX_TARGETS, 1, (Unit*)nullptr, false);
                    events.Repeat(7s);
                    break;
                case EVENT_PRIEST_GREAT_HEAL:
                    me->CastSpell(me, SPELL_PRIEST_GREAT_HEAL, false);
                    events.Repeat(6s, 7s);
                    break;
                case EVENT_PRIEST_SMITE:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_PRIEST_SMITE, false);
                    events.Repeat(2100ms);
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}

        void EnterEvadeMode(EvadeReason /*why*/) override {}
        bool CanAIAttack(Unit const* t) const override { return t->GetEntry() == NPC_HODIR; }

        void JustDied(Unit* /*killer*/) override
        {
            if (pInstance)
                if (Creature* hodir = pInstance->instance->GetCreature(pInstance->GetGuidData(TYPE_HODIR)))
                    hodir->AI()->SetData(4, 1);
        }
    };
};

class npc_ulduar_hodir_druid : public CreatureScript
{
public:
    npc_ulduar_hodir_druid() : CreatureScript("npc_ulduar_hodir_druid") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_hodir_druidAI>(pCreature);
    }

    struct npc_ulduar_hodir_druidAI : public ScriptedAI
    {
        npc_ulduar_hodir_druidAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
        }

        EventMap events;
        InstanceScript* pInstance;

        void AttackStart(Unit* who) override
        {
            AttackStartCaster(who, 22.0f);
        }

        void ScheduleAbilities()
        {
            events.ScheduleEvent(EVENT_DRUID_WRATH, 1600ms);
            events.ScheduleEvent(EVENT_DRUID_STARLIGHT, 10s);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_FLASH_FREEZE_TRAPPED_NPC)
            {
                events.Reset();
                events.ScheduleEvent(EVENT_TRY_FREE_HELPER, 2s);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_TRY_FREE_HELPER:
                    {
                        if (!me->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC))
                            if (pInstance)
                                if (ObjectGuid g = pInstance->GetGuidData(TYPE_HODIR))
                                    if (Creature* hodir = ObjectAccessor::GetCreature(*me, g))
                                    {
                                        AttackStart(hodir);
                                        ScheduleAbilities();
                                        break;
                                    }
                        events.Repeat(2s);
                    }
                    break;
                case EVENT_DRUID_WRATH:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_DRUID_WRATH, false);
                    events.Repeat(1600ms);
                    break;
                case EVENT_DRUID_STARLIGHT:
                    if (me->GetPositionZ() < 433.0f) // ensure npc is on the ground
                    {
                        me->CastSpell(me, SPELL_DRUID_STARLIGHT_AREA_AURA, false);
                        events.Repeat(15s);
                        break;
                    }
                    events.Repeat(3s);
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}

        void EnterEvadeMode(EvadeReason /*why*/) override {}
        bool CanAIAttack(Unit const* t) const override { return t->GetEntry() == NPC_HODIR; }

        void JustDied(Unit* /*killer*/) override
        {
            if (pInstance)
                if (Creature* hodir = pInstance->instance->GetCreature(pInstance->GetGuidData(TYPE_HODIR)))
                    hodir->AI()->SetData(4, 1);
        }
    };
};

class npc_ulduar_hodir_shaman : public CreatureScript
{
public:
    npc_ulduar_hodir_shaman() : CreatureScript("npc_ulduar_hodir_shaman") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_hodir_shamanAI>(pCreature);
    }

    struct npc_ulduar_hodir_shamanAI : public ScriptedAI
    {
        npc_ulduar_hodir_shamanAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
        }

        EventMap events;
        InstanceScript* pInstance;

        void AttackStart(Unit* who) override
        {
            AttackStartCaster(who, 25.0f);
        }

        void ScheduleAbilities()
        {
            events.ScheduleEvent(EVENT_SHAMAN_LAVA_BURST, 2600ms);
            events.ScheduleEvent(EVENT_SHAMAN_STORM_CLOUD, 10s);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_FLASH_FREEZE_TRAPPED_NPC)
            {
                events.Reset();
                events.ScheduleEvent(EVENT_TRY_FREE_HELPER, 2s);
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            uint32 spellid = sSpellMgr->GetSpellIdForDifficulty(SPELL_SHAMAN_STORM_CLOUD, me);
            if (target && spell->Id == spellid)
                if (Aura* a = target->GetAura(spellid, me->GetGUID()))
                    a->SetStackAmount(spell->StackAmount);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_TRY_FREE_HELPER:
                    {
                        if (!me->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC))
                            if (pInstance)
                                if (ObjectGuid g = pInstance->GetGuidData(TYPE_HODIR))
                                    if (Creature* hodir = ObjectAccessor::GetCreature(*me, g))
                                    {
                                        AttackStart(hodir);
                                        ScheduleAbilities();
                                        break;
                                    }
                        events.Repeat(2s);
                    }
                    break;
                case EVENT_SHAMAN_LAVA_BURST:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_SHAMAN_LAVA_BURST, false);
                    events.Repeat(2600ms);
                    break;
                case EVENT_SHAMAN_STORM_CLOUD:
                    {
                        uint32 spellid = sSpellMgr->GetSpellIdForDifficulty(SPELL_SHAMAN_STORM_CLOUD, me);
                        if (Player* target = ScriptedAI::SelectTargetFromPlayerList(35.0f, spellid))
                            me->CastSpell(target, spellid, false);
                        events.Repeat(30s);
                        break;
                    }
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}

        void EnterEvadeMode(EvadeReason /*why*/) override {}
        bool CanAIAttack(Unit const* t) const override { return t->GetEntry() == NPC_HODIR; }

        void JustDied(Unit* /*killer*/) override
        {
            if (pInstance)
                if (Creature* hodir = pInstance->instance->GetCreature(pInstance->GetGuidData(TYPE_HODIR)))
                    hodir->AI()->SetData(4, 1);
        }
    };
};

class npc_ulduar_hodir_mage : public CreatureScript
{
public:
    npc_ulduar_hodir_mage() : CreatureScript("npc_ulduar_hodir_mage") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_ulduar_hodir_mageAI>(pCreature);
    }

    struct npc_ulduar_hodir_mageAI : public ScriptedAI
    {
        npc_ulduar_hodir_mageAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
        }

        EventMap events;
        InstanceScript* pInstance;

        void AttackStart(Unit* who) override
        {
            AttackStartCaster(who, 30.0f);
        }

        void ScheduleAbilities()
        {
            events.ScheduleEvent(EVENT_MAGE_FIREBALL, 3100ms);
            events.ScheduleEvent(EVENT_MAGE_TOASTY_FIRE, 6s);
            events.ScheduleEvent(EVENT_MAGE_MELT_ICE, 1s);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_FLASH_FREEZE_TRAPPED_NPC)
            {
                events.Reset();
                events.ScheduleEvent(EVENT_TRY_FREE_HELPER, 2s);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_TRY_FREE_HELPER:
                    {
                        if (!me->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC))
                            if (pInstance)
                                if (ObjectGuid g = pInstance->GetGuidData(TYPE_HODIR))
                                    if (Creature* hodir = ObjectAccessor::GetCreature(*me, g))
                                    {
                                        AttackStart(hodir);
                                        ScheduleAbilities();
                                        break;
                                    }
                        events.Repeat(2s);
                    }
                    break;
                case EVENT_MAGE_FIREBALL:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_MAGE_FIREBALL, false);
                    events.Repeat(3100ms);
                    break;
                case EVENT_MAGE_TOASTY_FIRE:
                    me->CastSpell(me, SPELL_MAGE_CONJURE_TOASTY_FIRE, false);
                    events.Repeat(10s);
                    break;
                case EVENT_MAGE_MELT_ICE:
                    {
                        std::list<Creature*> FB;
                        bool found = false;
                        me->GetCreaturesWithEntryInRange(FB, 150.0f, NPC_FLASH_FREEZE_NPC);
                        for( std::list<Creature*>::const_iterator itr = FB.begin(); itr != FB.end(); ++itr )
                            if (!((*itr)->HasAura(SPELL_MAGE_MELT_ICE)))
                            {
                                me->CastSpell((*itr), SPELL_MAGE_MELT_ICE, false);
                                found = true;
                                break;
                            }

                        if (found)
                        {
                            events.DelayEvents(2s);
                            events.Repeat(2s);
                            break;
                        }
                        events.Repeat(5s);
                    }
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}

        void EnterEvadeMode(EvadeReason /*why*/) override {}
        bool CanAIAttack(Unit const* t) const override { return t->GetEntry() == NPC_HODIR; }

        void JustDied(Unit* /*killer*/) override
        {
            if (pInstance)
                if (Creature* hodir = pInstance->instance->GetCreature(pInstance->GetGuidData(TYPE_HODIR)))
                    hodir->AI()->SetData(4, 1);
        }
    };
};

class spell_hodir_shatter_chest : public SpellScript
{
    PrepareSpellScript(spell_hodir_shatter_chest);

    void DestroyWinterCache(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Unit* hodir = GetCaster())
            hodir->GetAI()->DoAction(EVENT_FAIL_HM);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_hodir_shatter_chest::DestroyWinterCache, EFFECT_0, SPELL_EFFECT_TRIGGER_MISSILE);
    };
};

class spell_hodir_biting_cold_main_aura : public AuraScript
{
    PrepareAuraScript(spell_hodir_biting_cold_main_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BITING_COLD_PLAYER_AURA, SPELL_MAGE_TOASTY_FIRE_AURA });
    }

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        if ((aurEff->GetTickNumber() % 4) == 0)
            if (Unit* target = GetTarget())
                if (target->IsPlayer()
                    && !target->isMoving()
                    && !target->HasAura(SPELL_BITING_COLD_PLAYER_AURA)
                    && !target->HasAura(SPELL_MAGE_TOASTY_FIRE_AURA))
                    target->CastSpell(target, SPELL_BITING_COLD_PLAYER_AURA, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_hodir_biting_cold_main_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_hodir_biting_cold_player_aura : public AuraScript
{
    PrepareAuraScript(spell_hodir_biting_cold_player_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FLASH_FREEZE_TRAPPED_PLAYER, SPELL_MAGE_TOASTY_FIRE_AURA, SPELL_BITING_COLD_DAMAGE });
    }

    bool Load() override
    {
        _counter = 0;
        _prev = false;
        return true;
    }

    void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
    {
        if (Unit* target = GetTarget())
        {
            if (target->GetMapId() == MAP_ULDUAR)
                SetDuration(GetMaxDuration());
            if (target->HasAura(SPELL_FLASH_FREEZE_TRAPPED_PLAYER))
                return;
            if (target->isMoving() || target->HasAura(SPELL_MAGE_TOASTY_FIRE_AURA))
            {
                if (_prev)
                {
                    ModStackAmount(-1);
                    _prev = false;
                }
                else
                    _prev = true;

                if (_counter >= 2)
                    _counter -= 2;
                else if (_counter)
                    --_counter;
            }
            else
            {
                _prev = false;
                ++_counter;
                if (_counter >= 4)
                {
                    if (GetStackAmount() == 2) // increasing from 2 to 3 (not checking >= to improve performance)
                        if (InstanceScript* pInstance = target->GetInstanceScript())
                            if (Creature* hodir = pInstance->instance->GetCreature(pInstance->GetGuidData(TYPE_HODIR)))
                                hodir->AI()->SetData(2, 1);
                    ModStackAmount(1);
                    _counter = 0;
                }
            }

            const int32 dmg = 200 * pow(2.0f, GetStackAmount());
            target->CastCustomSpell(target, SPELL_BITING_COLD_DAMAGE, &dmg, 0, 0, true);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_hodir_biting_cold_player_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }

private:
    uint8 _counter;
    bool _prev;
};

class spell_hodir_periodic_icicle : public SpellScript
{
    PrepareSpellScript(spell_hodir_periodic_icicle);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_FLASH_FREEZE_TRAPPED_PLAYER));
        Acore::Containers::RandomResize(targets, 1);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hodir_periodic_icicle::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class FlashFreezeCheck
{
public:
    FlashFreezeCheck() { }

    bool operator()(WorldObject* target) const
    {
        if (Unit* unit = target->ToUnit())
            return unit->HasAura(SPELL_SAFE_AREA_TRIGGERED) || unit->IsPet();
        return true;
    }
};

class spell_hodir_flash_freeze : public SpellScript
{
    PrepareSpellScript(spell_hodir_flash_freeze);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(FlashFreezeCheck());
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hodir_flash_freeze::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hodir_flash_freeze::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_hodir_flash_freeze_aura : public AuraScript
{
    PrepareAuraScript(spell_hodir_flash_freeze_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FLASH_FREEZE_INSTAKILL, SPELL_FLASH_FREEZE_TRAPPED_PLAYER, SPELL_FLASH_FREEZE_TRAPPED_NPC });
    }

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        if (aurEff->GetTotalTicks() > 0 && aurEff->GetTickNumber() == uint32(aurEff->GetTotalTicks()) - 1)
        {
            Unit* target = GetTarget();
            Unit* caster = GetCaster();
            if (!target || !caster || !caster->IsCreature())
                return;

            if (Aura* aur = target->GetAura(target->IsPlayer() ? SPELL_FLASH_FREEZE_TRAPPED_PLAYER : SPELL_FLASH_FREEZE_TRAPPED_NPC))
            {
                if (Unit* caster2 = aur->GetCaster())
                {
                    if (caster2->IsCreature())
                    {
                        caster2->ToCreature()->DespawnOrUnsummon();
                    }
                }
                target->CastSpell(target, SPELL_FLASH_FREEZE_INSTAKILL, true);
                return;
            }
            if (target->IsPlayer())
            {
                caster->ToCreature()->AI()->SetData(1, 1);
                if (Creature* c = target->SummonCreature(NPC_FLASH_FREEZE_PLR, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 5 * 60 * 1000))
                {
                    c->CastSpell(target, SPELL_FLASH_FREEZE_TRAPPED_PLAYER, true);
                    caster->ToCreature()->AI()->JustSummoned(c);
                }
            }
            else if (target->IsCreature())
            {
                if (Creature* c = target->SummonCreature(NPC_FLASH_FREEZE_NPC, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000))
                {
                    c->CastSpell(target, SPELL_FLASH_FREEZE_TRAPPED_NPC, true);
                    caster->ToCreature()->AI()->JustSummoned(c);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_hodir_flash_freeze_aura::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_hodir_storm_power_aura : public AuraScript
{
    PrepareAuraScript(spell_hodir_storm_power_aura);

    void OnApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            if (Aura* a = caster->GetAura(sSpellMgr->GetSpellIdForDifficulty(SPELL_SHAMAN_STORM_CLOUD, caster)))
                a->ModStackAmount(-1);
    }

    void HandleAfterEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
            if (target->IsPlayer())
                target->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2, GetId(), 0, GetCaster());
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_hodir_storm_power_aura::OnApply, EFFECT_0, SPELL_AURA_MOD_CRIT_DAMAGE_BONUS, AURA_EFFECT_HANDLE_REAL);
        AfterEffectApply += AuraEffectApplyFn(spell_hodir_storm_power_aura::HandleAfterEffectApply, EFFECT_0, SPELL_AURA_MOD_CRIT_DAMAGE_BONUS, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK);
    }
};

class spell_hodir_storm_cloud_aura : public AuraScript
{
    PrepareAuraScript(spell_hodir_storm_cloud_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHAMAN_STORM_POWER });
    }

    void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* target = GetTarget())
            target->CastSpell((Unit*)nullptr, (sSpellMgr->GetSpellIdForDifficulty(SPELL_SHAMAN_STORM_POWER, GetCaster())), true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_hodir_storm_cloud_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_hodir_toasty_fire_aura : public AuraScript
{
    PrepareAuraScript(spell_hodir_toasty_fire_aura);

    void HandleAfterEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
            if (target->IsPlayer())
                target->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2, SPELL_MAGE_TOASTY_FIRE_AURA, 0, GetCaster());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_hodir_toasty_fire_aura::HandleAfterEffectApply, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK);
    }
};

class spell_hodir_starlight_aura : public AuraScript
{
    PrepareAuraScript(spell_hodir_starlight_aura);

    void HandleAfterEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* target = GetTarget())
            if (target->IsPlayer())
                target->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2, SPELL_DRUID_STARLIGHT_AREA_AURA, 0, GetCaster());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_hodir_starlight_aura::HandleAfterEffectApply, EFFECT_0, SPELL_AURA_MELEE_SLOW, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK);
    }
};

class achievement_cheese_the_freeze : public AchievementCriteriaScript
{
public:
    achievement_cheese_the_freeze() : AchievementCriteriaScript("achievement_cheese_the_freeze") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_HODIR && target->IsCreature() && target->ToCreature()->AI()->GetData(1);
    }
};

class achievement_getting_cold_in_here : public AchievementCriteriaScript
{
public:
    achievement_getting_cold_in_here() : AchievementCriteriaScript("achievement_getting_cold_in_here") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_HODIR && target->IsCreature() && target->ToCreature()->AI()->GetData(2);
    }
};

class achievement_i_could_say_that_this_cache_was_rare : public AchievementCriteriaScript
{
public:
    achievement_i_could_say_that_this_cache_was_rare() : AchievementCriteriaScript("achievement_i_could_say_that_this_cache_was_rare") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_HODIR && target->IsCreature() && target->ToCreature()->AI()->GetData(3);
    }
};

class achievement_i_have_the_coolest_friends : public AchievementCriteriaScript
{
public:
    achievement_i_have_the_coolest_friends() : AchievementCriteriaScript("achievement_i_have_the_coolest_friends") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_HODIR && target->IsCreature() && target->ToCreature()->AI()->GetData(4);
    }
};

class achievement_staying_buffed_all_winter_10 : public AchievementCriteriaScript
{
public:
    achievement_staying_buffed_all_winter_10() : AchievementCriteriaScript("achievement_staying_buffed_all_winter_10") {}

    bool OnCheck(Player* player, Unit*  /*target*/, uint32 /*criteria_id*/) override
    {
        return player && player->HasAllAuras(SPELL_MAGE_TOASTY_FIRE_AURA, SPELL_DRUID_STARLIGHT_AREA_AURA, SPELL_SHAMAN_STORM_POWER);
    }
};

class achievement_staying_buffed_all_winter_25 : public AchievementCriteriaScript
{
public:
    achievement_staying_buffed_all_winter_25() : AchievementCriteriaScript("achievement_staying_buffed_all_winter_25") {}

    bool OnCheck(Player* player, Unit*  /*target*/, uint32 /*criteria_id*/) override
    {
        return player && player->HasAllAuras(SPELL_MAGE_TOASTY_FIRE_AURA, SPELL_DRUID_STARLIGHT_AREA_AURA, SPELL_SHAMAN_STORM_POWER_25);
    }
};

void AddSC_boss_hodir()
{
    new boss_hodir();
    new npc_ulduar_icicle();
    new npc_ulduar_flash_freeze();
    new npc_ulduar_toasty_fire();

    new npc_ulduar_hodir_priest();
    new npc_ulduar_hodir_druid();
    new npc_ulduar_hodir_shaman();
    new npc_ulduar_hodir_mage();

    RegisterSpellScript(spell_hodir_shatter_chest);
    RegisterSpellScript(spell_hodir_biting_cold_main_aura);
    RegisterSpellScript(spell_hodir_biting_cold_player_aura);
    RegisterSpellScript(spell_hodir_periodic_icicle);
    RegisterSpellAndAuraScriptPair(spell_hodir_flash_freeze, spell_hodir_flash_freeze_aura);
    RegisterSpellScript(spell_hodir_storm_power_aura);
    RegisterSpellScript(spell_hodir_storm_cloud_aura);
    RegisterSpellScript(spell_hodir_toasty_fire_aura);
    RegisterSpellScript(spell_hodir_starlight_aura);

    new achievement_cheese_the_freeze();
    new achievement_getting_cold_in_here();
    new achievement_i_could_say_that_this_cache_was_rare();
    new achievement_i_have_the_coolest_friends();
    new achievement_staying_buffed_all_winter_10();
    new achievement_staying_buffed_all_winter_25();
}
