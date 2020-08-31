/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "ulduar.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "PassiveAI.h"
#include "Player.h"

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

    SPELL_FROZEN_BLOWS_10               = 62478,
    SPELL_FROZEN_BLOWS_25               = 63512,

    // Helpers:
    SPELL_PRIEST_DISPELL_MAGIC          = 63499,
    SPELL_PRIEST_GREAT_HEAL             = 62809,
    SPELL_PRIEST_SMITE                  = 61923,

    SPELL_DRUID_WRATH                   = 62793,
    SPELL_DRUID_STARLIGHT_AREA_AURA     = 62807,

    SPELL_SHAMAN_LAVA_BURST             = 61924,
    SPELL_SHAMAN_STORM_CLOUD_10         = 65123,
    SPELL_SHAMAN_STORM_CLOUD_25         = 65133,
    SPELL_SHAMAN_STORM_POWER_10         = 63711,
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
};

enum HodirGOs
{
    GO_HODIR_SNOWDRIFT                  = 194173,
    // GO_HODIR_FROZEN_DOOR             = 194441,
    // GO_HODIR_DOOR                    = 194634,
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

#define SPELL_FROZEN_BLOWS              RAID_MODE(SPELL_FROZEN_BLOWS_10, SPELL_FROZEN_BLOWS_25)
#define SPELL_SHAMAN_STORM_CLOUD        RAID_MODE(SPELL_SHAMAN_STORM_CLOUD_10, SPELL_SHAMAN_STORM_CLOUD_25)

#define TEXT_HODIR_AGGRO                "You will suffer for this trespass!"
#define TEXTEMOTE_HODIR_FROZEN_BLOWS    "Hodir roars furious."
#define TEXT_HODIR_FLASH_FREEZE         "Winds of the north consume you!"
#define TEXTEMOTE_HODIR_HARD_MODE_MISSED "Hodir shatters the Rare Cache of Hodir!"
#define TEXT_HODIR_SLAIN_1              "Tragic. To come so far, only to fail."
#define TEXT_HODIR_SLAIN_2              "Welcome to the endless winter."
#define TEXT_HODIR_BERSERK              "Enough! This ends now!"
#define TEXT_HODIR_DEFEATED             "I... I am released from his grasp... at last."

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
    float x,y;
};
HodirHelperData hhd[4][4] = {
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_hodirAI (pCreature);
    }

    struct boss_hodirAI : public ScriptedAI
    {
        boss_hodirAI(Creature *pCreature) : ScriptedAI(pCreature), summons(me)
        {
            pInstance = pCreature->GetInstanceScript();
            if (!me->IsAlive())
                if (pInstance)
                    pInstance->SetData(TYPE_HODIR, DONE);
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        uint64 Helpers[8];
        bool berserk;
        bool hardmode;
        bool bAchievCheese;
        bool bAchievGettingCold;
        bool bAchievCoolestFriends;
        uint16 addSpawnTimer;

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            berserk = false;
            hardmode = true;
            bAchievCheese = true;
            bAchievGettingCold = true;
            bAchievCoolestFriends = true;
            addSpawnTimer = 5000;

            if (pInstance && pInstance->GetData(TYPE_HODIR) != DONE)
                pInstance->SetData(TYPE_HODIR, NOT_STARTED);
        }

        void EnterCombat(Unit*  /*pWho*/)
        {
            if (summons.size() != uint32(RAID_MODE(8, 16)))
            {
                EnterEvadeMode();
                return;
            }
            me->setActive(true);
            me->CastSpell(me, SPELL_BITING_COLD_BOSS_AURA, true);
            SmallIcicles(true);
            events.Reset();
            events.RescheduleEvent(EVENT_FLASH_FREEZE, 60000);
            events.RescheduleEvent(EVENT_FREEZE, 15000);
            events.RescheduleEvent(EVENT_BERSERK, 480000);
            events.RescheduleEvent(EVENT_HARD_MODE_MISSED, 180000);

            me->MonsterYell(TEXT_HODIR_AGGRO, LANG_UNIVERSAL, 0);
            me->PlayDirectSound(SOUND_HODIR_AGGRO, 0);

            if (pInstance && pInstance->GetData(TYPE_HODIR) != DONE)
                pInstance->SetData(TYPE_HODIR, IN_PROGRESS);
        }

        void JustReachedHome() { me->setActive(false); }

        void SmallIcicles(bool enable)
        {
            if( enable )
                me->CastSpell(me, SPELL_ICICLE_BOSS_AURA, true);
            else
                me->RemoveAura(SPELL_ICICLE_BOSS_AURA);
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spell)
        {
            switch( spell->Id )
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

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if (damage >= me->GetHealth() || me->GetHealth() < 150000)
            {
                damage = 0;
                me->SetReactState(REACT_PASSIVE);
                if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                {
                    if (pInstance)
                    {
                        pInstance->SetData(TYPE_HODIR, DONE);
                        me->CastSpell(me, 64899, true); // credit
                    }

                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->setFaction(35);
                    me->GetMotionMaster()->Clear();
                    me->AttackStop();
                    me->CombatStop();
                    me->InterruptNonMeleeSpells(true);
                    me->RemoveAllAuras();
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BITING_COLD_PLAYER_AURA);

                    events.Reset();
                    summons.DespawnAll();

                    if( GameObject* d = me->FindNearestGameObject(GO_HODIR_FROZEN_DOOR, 250.0f) )
                        if( d->GetGoState() != GO_STATE_ACTIVE )
                        {
                            d->SetLootState(GO_READY);
                            d->UseDoorOrButton(0, false);
                        }
                    if( GameObject* d = me->FindNearestGameObject(GO_HODIR_DOOR, 250.0f) )
                        if( d->GetGoState() != GO_STATE_ACTIVE )
                        {
                            d->SetLootState(GO_READY);
                            d->UseDoorOrButton(0, false);
                        }

                    me->MonsterYell(TEXT_HODIR_DEFEATED, LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(SOUND_HODIR_DEFEATED, 0);
                    me->DespawnOrUnsummon(10000);

                    // spawn appropriate chests
                    uint32 chestId = me->GetMap()->Is25ManRaid() ? GO_HODIR_CHEST_NORMAL_HERO : GO_HODIR_CHEST_NORMAL;
                    if( GameObject *go = me->SummonGameObject(chestId, 1969.115f, -212.94f, 432.687f, 3*M_PI/2, 0, 0, 0, 0, 0) )
                        go->SetUInt32Value(GAMEOBJECT_FLAGS, 0);
                    
                    if( hardmode )
                    {
                        uint32 chestId2 = me->GetMap()->Is25ManRaid() ? GO_HODIR_CHEST_HARD_HERO : GO_HODIR_CHEST_HARD;
                        if( GameObject *go = me->SummonGameObject(chestId2, 2031.207f, -213.236f, 432.687f, 3*M_PI/2, 0, 0, 0, 0, 0) )
                            go->SetUInt32Value(GAMEOBJECT_FLAGS, 0);
                    }
                }
            }
        }


        void UpdateAI(uint32 diff)
        {
            if (addSpawnTimer <= diff)
            {
                addSpawnTimer = 5000;
                if (!me->IsInCombat() && !summons.size() && !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                    if (SelectTargetFromPlayerList(135.0f))
                        SpawnHelpers();
            }
            else
                addSpawnTimer -= diff;

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

            if( !berserk && (me->GetPositionX() < 1940.0f || me->GetPositionX() > 2070.0f || me->GetPositionY() < -300.0f || me->GetPositionY() > -155.0f) )
                events.RescheduleEvent(EVENT_BERSERK, 1);

            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;
            
            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_BERSERK:
                    {
                        berserk = true;
                        me->CastSpell(me, SPELL_BERSERK, true);
                        me->MonsterYell(TEXT_HODIR_BERSERK, LANG_UNIVERSAL, 0);
                        me->PlayDirectSound(SOUND_HODIR_BERSERK, 0);
                        events.PopEvent();
                    }
                    break;
                case EVENT_HARD_MODE_MISSED:
                    {
                        hardmode = false;
                        me->MonsterTextEmote(TEXTEMOTE_HODIR_HARD_MODE_MISSED, 0);
                        events.PopEvent();
                    }
                    break;
                case EVENT_FLASH_FREEZE:
                    {
                        std::list<Unit*> targets;
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                            targets.push_back(itr->GetSource());
                        targets.remove_if(acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
                        targets.remove_if(acore::UnitAuraCheck(true, SPELL_FLASH_FREEZE_TRAPPED_PLAYER));
                        acore::Containers::RandomResizeList(targets, 2);
                        for (std::list<Unit*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
                        {
                            float prevZ = (*itr)->GetPositionZ();
                            (*itr)->m_positionZ = 432.7f;
                            (*itr)->CastSpell((*itr), SPELL_ICICLE_VISUAL_PACKED, true);
                            (*itr)->m_positionZ = prevZ;
                        }

                        me->CastSpell((Unit*)NULL, SPELL_FLASH_FREEZE_CAST, false);
                        me->MonsterTextEmote("Hodir begins to cast Flash Freeze!", 0, true);
                        me->MonsterYell(TEXT_HODIR_FLASH_FREEZE, LANG_UNIVERSAL, 0);
                        me->PlayDirectSound(SOUND_HODIR_FLASH_FREEZE, 0);
                        SmallIcicles(false);
                        events.RepeatEvent(55000 + urand(0,10000));
                        events.ScheduleEvent(EVENT_SMALL_ICICLES_ENABLE, Is25ManRaid() ? 12000 : 24000);
                        events.ScheduleEvent(EVENT_FROZEN_BLOWS, 15000);
                        events.RescheduleEvent(EVENT_FREEZE, 20000);
                    }
                    break;
                case EVENT_SMALL_ICICLES_ENABLE:
                    {
                        SmallIcicles(true);
                        events.PopEvent();
                    }
                    break;
                case EVENT_FROZEN_BLOWS:
                    {
                        me->MonsterTextEmote("Hodir gains Frozen Blows!", 0, true);
                        me->MonsterTextEmote(TEXTEMOTE_HODIR_FROZEN_BLOWS, 0);
                        me->PlayDirectSound(SOUND_HODIR_FROZEN_BLOWS, 0);
                        me->CastSpell(me, SPELL_FROZEN_BLOWS, true);
                        events.PopEvent();
                    }
                    break;
                case EVENT_FREEZE:
                    if (Player* plr = SelectTargetFromPlayerList(50.0f, SPELL_FLASH_FREEZE_TRAPPED_PLAYER))
                        me->CastSpell(plr, SPELL_FREEZE, false);
                    else if (Unit* plr = SelectTarget(SELECT_TARGET_RANDOM, 0, 50.0f, true))
                        me->CastSpell(plr, SPELL_FREEZE, false);
                    events.RepeatEvent(15000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        Creature* GetHelper(uint8 index)
        {
            return (Helpers[index] ? ObjectAccessor::GetCreature(*me, Helpers[index]) : nullptr);
        }

        void SpawnHelpers()
        {
            char faction = 'A';
            if( hhd[0][0].id )
            {
                Map::PlayerList const &cl = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = cl.begin(); itr != cl.end(); ++itr)
                    if (!itr->GetSource()->IsGameMaster())
                    {
                        faction = (itr->GetSource()->GetTeamId() == TEAM_ALLIANCE ? 'A' : 'H');
                        break;
                    }
            }

            uint8 cnt = 0;
            if( faction )
                for( uint8 k=0; k<4; ++k )
                {
                    if( (faction == 'A' && ( k>1 || (k==1 && RAID_MODE(1,0)) )) ||
                        (faction == 'H' && ( k<2 || (k==3 && RAID_MODE(1,0)) )) )
                        continue;

                    for( uint8 i=0; i<4; ++i )
                    {
                        if( !hhd[k][i].id )
                            continue;

                        if( Creature* h_p = me->SummonCreature(hhd[k][i].id, hhd[k][i].x, hhd[k][i].y, 432.69f, M_PI/2) )
                        {
                            h_p->setFaction(1665);
                            if( cnt < 8 )
                                Helpers[cnt++] = h_p->GetGUID();

                            if( Creature* c = h_p->SummonCreature(NPC_FLASH_FREEZE_NPC, h_p->GetPositionX(), h_p->GetPositionY(), h_p->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000) )
                            {
                                c->CastSpell(h_p, SPELL_FLASH_FREEZE_TRAPPED_NPC, true);
                                JustSummoned(c);
                            }
                        }
                    }
                }
        }

        void KilledUnit(Unit* who)
        {
            if( who->GetTypeId() == TYPEID_PLAYER )
            {
                if( urand(0,1) )
                {
                    me->MonsterYell(TEXT_HODIR_SLAIN_1, LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(SOUND_HODIR_SLAIN_1, 0);
                }
                else
                {
                    me->MonsterYell(TEXT_HODIR_SLAIN_2, LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(SOUND_HODIR_SLAIN_2, 0);
                }
            }
        }

        void JustSummoned(Creature* s)
        {
            summons.Summon(s);
        }

        void SummonedCreatureDespawn(Creature* s)
        {
            summons.Despawn(s);
        }

        bool CanAIAttack(const Unit* t) const
        {
            if (t->GetTypeId() == TYPEID_PLAYER)
                return !t->HasAura(SPELL_FLASH_FREEZE_TRAPPED_PLAYER);
            else if (t->GetTypeId() == TYPEID_UNIT)
                return !t->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC);

            return true;
        }

        void SetData(uint32 id, uint32 value)
        {
            if (value)
                switch (id)
                {
                    case 1: bAchievCheese = false; break;
                    case 2: bAchievGettingCold = false; break;
                    case 4: bAchievCoolestFriends = false; break;
                }
        }

        uint32 GetData(uint32 id) const
        {
            switch (id)
            {
                case 1: return (bAchievCheese ? 1 : 0);
                case 2: return (bAchievGettingCold ? 1 : 0);
                case 3: return (hardmode ? 1 : 0);
                case 4: return (bAchievCoolestFriends ? 1 : 0);
            }
            return 0;
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}
    };
};

class npc_ulduar_icicle : public CreatureScript
{
public:
    npc_ulduar_icicle() : CreatureScript("npc_ulduar_icicle") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_icicleAI (pCreature);
    }

    struct npc_ulduar_icicleAI : public NullCreatureAI
    {
        npc_ulduar_icicleAI(Creature *pCreature) : NullCreatureAI(pCreature)
        {
            timer1 = 2000;
            timer2 = 5000;
        }

        uint16 timer1;
        uint16 timer2;

        void UpdateAI(uint32 diff)
        {
            if( timer1 <= diff )
            {
                me->CastSpell(me, (me->GetEntry()==33169 ? SPELL_ICICLE_FALL_EFFECT_UNPACKED : SPELL_ICICLE_FALL_EFFECT_PACKED), true);
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_flash_freezeAI (pCreature);
    }

    struct npc_ulduar_flash_freezeAI : public NullCreatureAI
    {
        npc_ulduar_flash_freezeAI(Creature *pCreature) : NullCreatureAI(pCreature)
        {
            timer = 2500;
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        uint16 timer;

        void DamageTaken(Unit* doneBy, uint32 & /*damage*/, DamageEffectType, SpellSchoolMask)
        {
            if (pInstance && doneBy)
                if (pInstance->GetData(TYPE_HODIR) == NOT_STARTED)
                    if (Creature* hodir = ObjectAccessor::GetCreature(*me, pInstance->GetData64(TYPE_HODIR)))
                        hodir->AI()->AttackStart(doneBy);
        }

        void UpdateAI(uint32 diff)
        {
            if (timer <= diff)
            {
                timer = 2500;
                if (me->IsSummon()) {
                    if (Unit* s = me->ToTempSummon()->GetSummoner())
                    {
                        if ((s->GetTypeId() == TYPEID_PLAYER && !s->HasAura(SPELL_FLASH_FREEZE_TRAPPED_PLAYER)) || (s->GetTypeId() == TYPEID_UNIT && !s->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC)))
                            me->DespawnOrUnsummon(2000);
                        else if (s->GetTypeId() == TYPEID_PLAYER)
                            if (InstanceScript* pInstance = me->GetInstanceScript())
                                if (pInstance->GetData(TYPE_HODIR) == NOT_STARTED)
                                {
                                    s->CastSpell(s, SPELL_FLASH_FREEZE_INSTAKILL, true);
                                    me->DespawnOrUnsummon(2000);
                                }
                    }
                    else
                    {
                        me->DespawnOrUnsummon(2000);
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_toasty_fireAI (pCreature);
    }

    struct npc_ulduar_toasty_fireAI : public NullCreatureAI
    {
        npc_ulduar_toasty_fireAI(Creature *pCreature) : NullCreatureAI(pCreature)
        {
            me->CastSpell(me, SPELL_MAGE_TOASTY_FIRE_AURA, true);
        }

        void DoAction(int32 a)
        {
            if (a == 1)
            {
                if( GameObject* fire = me->FindNearestGameObject(194300, 1.0f) )
                {
                    fire->SetOwnerGUID(0);
                    fire->Delete();
                }
                me->DespawnOrUnsummon(); // this will remove DynObjects
            }
        }

        void SpellHit(Unit*  /*caster*/, const SpellInfo* spell)
        {
            switch( spell->Id )
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_hodir_priestAI (pCreature);
    }

    struct npc_ulduar_hodir_priestAI : public ScriptedAI
    {
        npc_ulduar_hodir_priestAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
        }

        EventMap events;
        InstanceScript* pInstance;

        void AttackStart(Unit* who)
        {
            AttackStartCaster(who, 17.0f);
        }

        void ScheduleAbilities()
        {
            events.ScheduleEvent(EVENT_PRIEST_DISPELL_MAGIC, 7000);
            events.ScheduleEvent(EVENT_PRIEST_GREAT_HEAL, urand(6000,7000));
            events.ScheduleEvent(EVENT_PRIEST_SMITE, 2100);
        }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell)
        {
            if(spell->Id == SPELL_FLASH_FREEZE_TRAPPED_NPC)
            {
                events.Reset();
                events.ScheduleEvent(EVENT_TRY_FREE_HELPER, 2000);
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_TRY_FREE_HELPER:
                    {
                        if( !me->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC) )
                            if( pInstance )
                                if( uint64 g = pInstance->GetData64(TYPE_HODIR) )
                                    if( Creature* hodir = ObjectAccessor::GetCreature(*me, g) )
                                    {
                                        AttackStart(hodir);
                                        events.PopEvent();
                                        ScheduleAbilities();
                                        break;
                                    }
                        events.RepeatEvent(2000);
                    }
                    break;
                case EVENT_PRIEST_DISPELL_MAGIC:
                    me->CastCustomSpell(SPELL_PRIEST_DISPELL_MAGIC, SPELLVALUE_MAX_TARGETS, 1, (Unit*)NULL, false);
                    events.RepeatEvent(7000);
                    break;
                case EVENT_PRIEST_GREAT_HEAL:
                    me->CastSpell(me, SPELL_PRIEST_GREAT_HEAL, false);
                    events.RepeatEvent(urand(6000,7000));
                    break;
                case EVENT_PRIEST_SMITE:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_PRIEST_SMITE, false);
                    events.RepeatEvent(2100);
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}
        void EnterEvadeMode() {}
        bool CanAIAttack(const Unit* t) const { return t->GetEntry() == NPC_HODIR; }

        void JustDied(Unit* /*killer*/)
        {
            if (pInstance)
                if (Creature* hodir = pInstance->instance->GetCreature(pInstance->GetData64(TYPE_HODIR)))
                    hodir->AI()->SetData(4, 1);
        }
    };
};

class npc_ulduar_hodir_druid : public CreatureScript
{
public:
    npc_ulduar_hodir_druid() : CreatureScript("npc_ulduar_hodir_druid") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_hodir_druidAI (pCreature);
    }

    struct npc_ulduar_hodir_druidAI : public ScriptedAI
    {
        npc_ulduar_hodir_druidAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
        }

        EventMap events;
        InstanceScript* pInstance;

        void AttackStart(Unit* who)
        {
            AttackStartCaster(who, 22.0f);
        }

        void ScheduleAbilities()
        {
            events.ScheduleEvent(EVENT_DRUID_WRATH, 1600);
            events.ScheduleEvent(EVENT_DRUID_STARLIGHT, 10000);
        }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell)
        {
            if(spell->Id == SPELL_FLASH_FREEZE_TRAPPED_NPC)
            {
                events.Reset();
                events.ScheduleEvent(EVENT_TRY_FREE_HELPER, 2000);
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_TRY_FREE_HELPER:
                    {
                        if( !me->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC) )
                            if( pInstance )
                                if( uint64 g = pInstance->GetData64(TYPE_HODIR) )
                                    if( Creature* hodir = ObjectAccessor::GetCreature(*me, g) )
                                    {
                                        AttackStart(hodir);
                                        events.PopEvent();
                                        ScheduleAbilities();
                                        break;
                                    }
                        events.RepeatEvent(2000);
                    }
                    break;
                case EVENT_DRUID_WRATH:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_DRUID_WRATH, false);
                    events.RepeatEvent(1600);
                    break;
                case EVENT_DRUID_STARLIGHT:
                    if (me->GetPositionZ() < 433.0f) // ensure npc is on the ground
                    {
                        me->CastSpell(me, SPELL_DRUID_STARLIGHT_AREA_AURA, false);
                        events.RepeatEvent(15000);
                        break;
                    }
                    events.RepeatEvent(3000);
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}
        void EnterEvadeMode() {}
        bool CanAIAttack(const Unit* t) const { return t->GetEntry() == NPC_HODIR; }

        void JustDied(Unit* /*killer*/)
        {
            if (pInstance)
                if (Creature* hodir = pInstance->instance->GetCreature(pInstance->GetData64(TYPE_HODIR)))
                    hodir->AI()->SetData(4, 1);
        }
    };
};

class npc_ulduar_hodir_shaman : public CreatureScript
{
public:
    npc_ulduar_hodir_shaman() : CreatureScript("npc_ulduar_hodir_shaman") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_hodir_shamanAI (pCreature);
    }

    struct npc_ulduar_hodir_shamanAI : public ScriptedAI
    {
        npc_ulduar_hodir_shamanAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
        }

        EventMap events;
        InstanceScript* pInstance;

        void AttackStart(Unit* who)
        {
            AttackStartCaster(who, 25.0f);
        }

        void ScheduleAbilities()
        {
            events.ScheduleEvent(EVENT_SHAMAN_LAVA_BURST, 2600);
            events.ScheduleEvent(EVENT_SHAMAN_STORM_CLOUD, 10000);
        }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell)
        {
            if(spell->Id == SPELL_FLASH_FREEZE_TRAPPED_NPC)
            {
                events.Reset();
                events.ScheduleEvent(EVENT_TRY_FREE_HELPER, 2000);
            }
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spell)
        {
            if (target && spell->Id == SPELL_SHAMAN_STORM_CLOUD)
                if (Aura* a = target->GetAura(SPELL_SHAMAN_STORM_CLOUD, me->GetGUID()))
                    a->SetStackAmount(spell->StackAmount);
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_TRY_FREE_HELPER:
                    {
                        if( !me->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC) )
                            if( pInstance )
                                if( uint64 g = pInstance->GetData64(TYPE_HODIR) )
                                    if( Creature* hodir = ObjectAccessor::GetCreature(*me, g) )
                                    {
                                        AttackStart(hodir);
                                        events.PopEvent();
                                        ScheduleAbilities();
                                        break;
                                    }
                        events.RepeatEvent(2000);
                    }
                    break;
                case EVENT_SHAMAN_LAVA_BURST:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_SHAMAN_LAVA_BURST, false);
                    events.RepeatEvent(2600);
                    break;
                case EVENT_SHAMAN_STORM_CLOUD:
                    if (Player* target = ScriptedAI::SelectTargetFromPlayerList(35.0f, SPELL_SHAMAN_STORM_CLOUD))
                        me->CastSpell(target, SPELL_SHAMAN_STORM_CLOUD, false);
                    events.RepeatEvent(30000);
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}
        void EnterEvadeMode() {}
        bool CanAIAttack(const Unit* t) const { return t->GetEntry() == NPC_HODIR; }

        void JustDied(Unit* /*killer*/)
        {
            if (pInstance)
                if (Creature* hodir = pInstance->instance->GetCreature(pInstance->GetData64(TYPE_HODIR)))
                    hodir->AI()->SetData(4, 1);
        }
    };
};

class npc_ulduar_hodir_mage : public CreatureScript
{
public:
    npc_ulduar_hodir_mage() : CreatureScript("npc_ulduar_hodir_mage") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ulduar_hodir_mageAI (pCreature);
    }

    struct npc_ulduar_hodir_mageAI : public ScriptedAI
    {
        npc_ulduar_hodir_mageAI(Creature *pCreature) : ScriptedAI(pCreature)
        {
            pInstance = me->GetInstanceScript();
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
        }

        EventMap events;
        InstanceScript* pInstance;

        void AttackStart(Unit* who)
        {
            AttackStartCaster(who, 30.0f);
        }

        void ScheduleAbilities()
        {
            events.ScheduleEvent(EVENT_MAGE_FIREBALL, 3100);
            events.ScheduleEvent(EVENT_MAGE_TOASTY_FIRE, 6000);
            events.ScheduleEvent(EVENT_MAGE_MELT_ICE, 1000);
        }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell)
        {
            if(spell->Id == SPELL_FLASH_FREEZE_TRAPPED_NPC)
            {
                events.Reset();
                events.ScheduleEvent(EVENT_TRY_FREE_HELPER, 2000);
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            if( me->HasUnitState(UNIT_STATE_CASTING) )
                return;

            switch( events.GetEvent() )
            {
                case 0:
                    break;
                case EVENT_TRY_FREE_HELPER:
                    {
                        if( !me->HasAura(SPELL_FLASH_FREEZE_TRAPPED_NPC) )
                            if( pInstance )
                                if( uint64 g = pInstance->GetData64(TYPE_HODIR) )
                                    if( Creature* hodir = ObjectAccessor::GetCreature(*me, g) )
                                    {
                                        AttackStart(hodir);
                                        events.PopEvent();
                                        ScheduleAbilities();
                                        break;
                                    }
                        events.RepeatEvent(2000);
                    }
                    break;
                case EVENT_MAGE_FIREBALL:
                    if (Unit* victim = me->GetVictim())
                        me->CastSpell(victim, SPELL_MAGE_FIREBALL, false);
                    events.RepeatEvent(3100);
                    break;
                case EVENT_MAGE_TOASTY_FIRE:
                    me->CastSpell(me, SPELL_MAGE_CONJURE_TOASTY_FIRE, false);
                    events.RepeatEvent(10000);
                    break;
                case EVENT_MAGE_MELT_ICE:
                    {
                        std::list<Creature*> FB;
                        bool found = false;
                        me->GetCreaturesWithEntryInRange(FB, 150.0f, NPC_FLASH_FREEZE_NPC);
                        for( std::list<Creature*>::const_iterator itr = FB.begin(); itr != FB.end(); ++itr )
                            if( !((*itr)->HasAura(SPELL_MAGE_MELT_ICE)) )
                            {
                                me->CastSpell((*itr), SPELL_MAGE_MELT_ICE, false);
                                found = true;
                                break;
                            }

                        if( found )
                        {
                            events.DelayEvents(2000);
                            events.RepeatEvent(1999);
                            break;
                        }
                        events.RepeatEvent(5000);
                    }
                    break;
            }
        }

        void MoveInLineOfSight(Unit*  /*who*/) {}
        void EnterEvadeMode() {}
        bool CanAIAttack(const Unit* t) const { return t->GetEntry() == NPC_HODIR; }

        void JustDied(Unit* /*killer*/)
        {
            if (pInstance)
                if (Creature* hodir = pInstance->instance->GetCreature(pInstance->GetData64(TYPE_HODIR)))
                    hodir->AI()->SetData(4, 1);
        }
    };
};

class spell_hodir_biting_cold_main_aura : public SpellScriptLoader
{
public:
    spell_hodir_biting_cold_main_aura() : SpellScriptLoader("spell_hodir_biting_cold_main_aura") { }

    class spell_hodir_biting_cold_main_aura_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hodir_biting_cold_main_aura_AuraScript)

        void HandleEffectPeriodic(AuraEffect const * aurEff)
        {
            if ((aurEff->GetTickNumber()%4) == 0)
                if (Unit* target = GetTarget())
                    if (target->GetTypeId() == TYPEID_PLAYER && !target->isMoving() && !target->HasAura(SPELL_BITING_COLD_PLAYER_AURA))
                        target->CastSpell(target, SPELL_BITING_COLD_PLAYER_AURA, true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_hodir_biting_cold_main_aura_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_hodir_biting_cold_main_aura_AuraScript();
    }
};

class spell_hodir_biting_cold_player_aura : public SpellScriptLoader
{
public:
    spell_hodir_biting_cold_player_aura() : SpellScriptLoader("spell_hodir_biting_cold_player_aura") { }

    class spell_hodir_biting_cold_player_aura_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hodir_biting_cold_player_aura_AuraScript)

        uint8 counter;
        bool prev;

        bool Load()
        {
            counter = 0;
            prev = false;
            return true;
        }

        void HandleEffectPeriodic(AuraEffect const *  /*aurEff*/)
        {
            
            if (Unit* target = GetTarget())
            {
                if (target->GetMapId() == 603)
                    SetDuration(GetMaxDuration());
                if (target->HasAura(SPELL_FLASH_FREEZE_TRAPPED_PLAYER))
                    return;
                if (target->isMoving() || target->HasAura(SPELL_MAGE_TOASTY_FIRE_AURA))
                {
                    if (prev)
                    {
                        ModStackAmount(-1);
                        prev = false;
                    }
                    else
                        prev = true;

                    if (counter>=2)
                        counter -= 2;
                    else if (counter)
                        --counter;
                }
                else
                {
                    prev = false;
                    ++counter;
                    if (counter >= 4)
                    {
                        if (GetStackAmount() == 2) // increasing from 2 to 3 (not checking >= to improve performance)
                            if (InstanceScript* pInstance = target->GetInstanceScript())
                                if (Creature* hodir = pInstance->instance->GetCreature(pInstance->GetData64(TYPE_HODIR)))
                                    hodir->AI()->SetData(2, 1);
                        ModStackAmount(1);
                        counter = 0;
                    }
                }

                const int32 dmg = 200*pow(2.0f, GetStackAmount());
                target->CastCustomSpell(target, SPELL_BITING_COLD_DAMAGE, &dmg, 0, 0, true);
            }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_hodir_biting_cold_player_aura_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_hodir_biting_cold_player_aura_AuraScript();
    }
};

class spell_hodir_periodic_icicle : public SpellScriptLoader
{
public:
    spell_hodir_periodic_icicle() : SpellScriptLoader("spell_hodir_periodic_icicle") { }

    class spell_hodir_periodic_icicle_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hodir_periodic_icicle_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            targets.remove_if(acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
            targets.remove_if(acore::UnitAuraCheck(true, SPELL_FLASH_FREEZE_TRAPPED_PLAYER));
            acore::Containers::RandomResizeList(targets, 1);
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hodir_periodic_icicle_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_hodir_periodic_icicle_SpellScript();
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

class spell_hodir_flash_freeze : public SpellScriptLoader
{
public:
    spell_hodir_flash_freeze() : SpellScriptLoader("spell_hodir_flash_freeze") { }

    class spell_hodir_flash_freeze_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_hodir_flash_freeze_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            targets.remove_if(FlashFreezeCheck());
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hodir_flash_freeze_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_hodir_flash_freeze_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    class spell_hodir_flash_freeze_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hodir_flash_freeze_AuraScript)

        void HandleEffectPeriodic(AuraEffect const * aurEff)
        {
            if (aurEff->GetTotalTicks() > 0 && aurEff->GetTickNumber() == uint32(aurEff->GetTotalTicks())-1)
            {
                Unit* target = GetTarget();
                Unit* caster = GetCaster();
                if (!target || !caster || caster->GetTypeId() != TYPEID_UNIT)
                    return;

                if (Aura* aur = target->GetAura(target->GetTypeId() == TYPEID_PLAYER ? SPELL_FLASH_FREEZE_TRAPPED_PLAYER : SPELL_FLASH_FREEZE_TRAPPED_NPC))
                {
                    if (Unit* caster = aur->GetCaster())
                        if (caster->GetTypeId() == TYPEID_UNIT)
                            caster->ToCreature()->DespawnOrUnsummon();
                    target->CastSpell(target, SPELL_FLASH_FREEZE_INSTAKILL, true);
                    return;
                }
                if (target->GetTypeId() == TYPEID_PLAYER)
                {
                    caster->ToCreature()->AI()->SetData(1, 1);
                    if( Creature* c = target->SummonCreature(NPC_FLASH_FREEZE_PLR, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 5*60*1000) )
                    {
                        c->CastSpell(target, SPELL_FLASH_FREEZE_TRAPPED_PLAYER, true);
                        caster->ToCreature()->AI()->JustSummoned(c);
                    }
                }
                else if (target->GetTypeId() == TYPEID_UNIT)
                {
                    if( Creature* c = target->SummonCreature(NPC_FLASH_FREEZE_NPC, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000) )
                    {
                        c->CastSpell(target, SPELL_FLASH_FREEZE_TRAPPED_NPC, true);
                        caster->ToCreature()->AI()->JustSummoned(c);
                    }
                }
            }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_hodir_flash_freeze_AuraScript::HandleEffectPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_hodir_flash_freeze_SpellScript();
    }

    AuraScript *GetAuraScript() const
    {
        return new spell_hodir_flash_freeze_AuraScript();
    }
};

class spell_hodir_storm_power : public SpellScriptLoader
{
public:
    spell_hodir_storm_power() : SpellScriptLoader("spell_hodir_storm_power") { }

    class spell_hodir_storm_power_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hodir_storm_power_AuraScript)

        void OnApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* caster = GetCaster())
                if (Aura* a = caster->GetAura(GetId() == SPELL_SHAMAN_STORM_POWER_10 ? SPELL_SHAMAN_STORM_CLOUD_10 : SPELL_SHAMAN_STORM_CLOUD_25))
                    a->ModStackAmount(-1);
        }

        void HandleAfterEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* target = GetTarget())
                if (target->GetTypeId() == TYPEID_PLAYER)
                    target->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2, GetId(), 0, GetCaster());
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_hodir_storm_power_AuraScript::OnApply, EFFECT_0, SPELL_AURA_MOD_CRIT_DAMAGE_BONUS, AURA_EFFECT_HANDLE_REAL);
            AfterEffectApply += AuraEffectApplyFn(spell_hodir_storm_power_AuraScript::HandleAfterEffectApply, EFFECT_0, SPELL_AURA_MOD_CRIT_DAMAGE_BONUS, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_hodir_storm_power_AuraScript();
    }
};

class spell_hodir_storm_cloud : public SpellScriptLoader
{
public:
    spell_hodir_storm_cloud() : SpellScriptLoader("spell_hodir_storm_cloud") { }

    class spell_hodir_storm_cloud_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hodir_storm_cloud_AuraScript)

        void HandleEffectPeriodic(AuraEffect const *  /*aurEff*/)
        {
            PreventDefaultAction();
            if (Unit* target = GetTarget())
                target->CastSpell((Unit*)NULL, (GetId() == SPELL_SHAMAN_STORM_CLOUD_10 ? SPELL_SHAMAN_STORM_POWER_10 : SPELL_SHAMAN_STORM_POWER_25), true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_hodir_storm_cloud_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_hodir_storm_cloud_AuraScript();
    }
};

class achievement_cheese_the_freeze : public AchievementCriteriaScript
{
public:
    achievement_cheese_the_freeze() : AchievementCriteriaScript("achievement_cheese_the_freeze") {}

    bool OnCheck(Player*  /*player*/, Unit* target)
    {
        return target && target->GetEntry() == NPC_HODIR && target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->AI()->GetData(1);
    }
};

class achievement_getting_cold_in_here : public AchievementCriteriaScript
{
public:
    achievement_getting_cold_in_here() : AchievementCriteriaScript("achievement_getting_cold_in_here") {}

    bool OnCheck(Player*  /*player*/, Unit* target)
    {
        return target && target->GetEntry() == NPC_HODIR && target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->AI()->GetData(2);
    }
};

class achievement_i_could_say_that_this_cache_was_rare : public AchievementCriteriaScript
{
public:
    achievement_i_could_say_that_this_cache_was_rare() : AchievementCriteriaScript("achievement_i_could_say_that_this_cache_was_rare") {}

    bool OnCheck(Player*  /*player*/, Unit* target)
    {
        return target && target->GetEntry() == NPC_HODIR && target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->AI()->GetData(3);
    }
};

class achievement_i_have_the_coolest_friends : public AchievementCriteriaScript
{
public:
    achievement_i_have_the_coolest_friends() : AchievementCriteriaScript("achievement_i_have_the_coolest_friends") {}

    bool OnCheck(Player*  /*player*/, Unit* target)
    {
        return target && target->GetEntry() == NPC_HODIR && target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->AI()->GetData(4);
    }
};

class achievement_staying_buffed_all_winter_10 : public AchievementCriteriaScript
{
public:
    achievement_staying_buffed_all_winter_10() : AchievementCriteriaScript("achievement_staying_buffed_all_winter_10") {}

    bool OnCheck(Player* player, Unit*  /*target*/)
    {
        return player && player->HasAura(SPELL_MAGE_TOASTY_FIRE_AURA) && player->HasAura(SPELL_DRUID_STARLIGHT_AREA_AURA) && player->HasAura(SPELL_SHAMAN_STORM_POWER_10);
    }
};

class achievement_staying_buffed_all_winter_25 : public AchievementCriteriaScript
{
public:
    achievement_staying_buffed_all_winter_25() : AchievementCriteriaScript("achievement_staying_buffed_all_winter_25") {}

    bool OnCheck(Player* player, Unit*  /*target*/)
    {
        return player && player->HasAura(SPELL_MAGE_TOASTY_FIRE_AURA) && player->HasAura(SPELL_DRUID_STARLIGHT_AREA_AURA) && player->HasAura(SPELL_SHAMAN_STORM_POWER_25);
    }
};

class spell_hodir_toasty_fire : public SpellScriptLoader
{
public:
    spell_hodir_toasty_fire() : SpellScriptLoader("spell_hodir_toasty_fire") { }

    class spell_hodir_toasty_fire_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hodir_toasty_fire_AuraScript);

        void HandleAfterEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* target = GetTarget())
                if (target->GetTypeId() == TYPEID_PLAYER)
                    target->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2, SPELL_MAGE_TOASTY_FIRE_AURA, 0, GetCaster());
        }

        void Register()
        {
            AfterEffectApply += AuraEffectApplyFn(spell_hodir_toasty_fire_AuraScript::HandleAfterEffectApply, EFFECT_0, SPELL_AURA_MOD_STAT, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_hodir_toasty_fire_AuraScript();
    }
};

class spell_hodir_starlight : public SpellScriptLoader
{
public:
    spell_hodir_starlight() : SpellScriptLoader("spell_hodir_starlight") { }

    class spell_hodir_starlight_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hodir_starlight_AuraScript);

        void HandleAfterEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* target = GetTarget())
                if (target->GetTypeId() == TYPEID_PLAYER)
                    target->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2, SPELL_DRUID_STARLIGHT_AREA_AURA, 0, GetCaster());
        }

        void Register()
        {
            AfterEffectApply += AuraEffectApplyFn(spell_hodir_starlight_AuraScript::HandleAfterEffectApply, EFFECT_0, SPELL_AURA_MELEE_SLOW, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT_MASK);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_hodir_starlight_AuraScript();
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

    new spell_hodir_biting_cold_main_aura();
    new spell_hodir_biting_cold_player_aura();
    new spell_hodir_periodic_icicle();
    new spell_hodir_flash_freeze();
    new spell_hodir_storm_power();
    new spell_hodir_storm_cloud();

    new achievement_cheese_the_freeze();
    new achievement_getting_cold_in_here();
    new achievement_i_could_say_that_this_cache_was_rare();
    new achievement_i_have_the_coolest_friends();
    new achievement_staying_buffed_all_winter_10();
    new achievement_staying_buffed_all_winter_25();
    new spell_hodir_toasty_fire();
    new spell_hodir_starlight();
}
