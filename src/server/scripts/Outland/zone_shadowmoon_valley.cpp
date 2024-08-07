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
#include "Group.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
/* ScriptData
SDName: Shadowmoon_Valley
SD%Complete: 100
SDComment: Quest support: 10519, 10583, 10601, 10804, 10854, 10458, 10481, 10480, 10781. Vendor Drake Dealer Hurlunk.
SDCategory: Shadowmoon Valley
EndScriptData */

/* ContentData
npc_mature_netherwing_drake
npc_enslaved_netherwing_drake
npc_drake_dealer_hurlunk
npcs_flanis_swiftwing_and_kagrosh
npc_karynaku
npc_oronok_tornheart
npc_torloth_the_magnificent
npc_illidari_spawn
npc_lord_illidan_stormrage
go_crystal_prison
npc_enraged_spirit
EndContentData */

// Ours
enum TheFelAndTheFurious
{
    SPELL_ROCKET_LAUNCHER = 38083
};

class spell_q10612_10613_the_fel_and_the_furious : public SpellScript
{
    PrepareSpellScript(spell_q10612_10613_the_fel_and_the_furious);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROCKET_LAUNCHER });
    }

    void HandleScriptEffect(SpellEffIndex  /*effIndex*/)
    {
        Player* charmer = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself();
        if (!charmer)
            return;

        std::list<GameObject*> gList;
        GetCaster()->GetGameObjectListWithEntryInGrid(gList, 184979, 30.0f);
        uint8 counter = 0;
        for (std::list<GameObject*>::const_iterator itr = gList.begin(); itr != gList.end(); ++itr, ++counter)
        {
            if (counter >= 10)
                break;
            GameObject* go = *itr;
            if (!go->isSpawned())
                continue;
            Creature* cr2 = go->SummonTrigger(go->GetPositionX(), go->GetPositionY(), go->GetPositionZ() + 2.0f, 0.0f, 100);
            if (cr2)
            {
                cr2->SetFaction(FACTION_MONSTER);
                cr2->ReplaceAllUnitFlags(UNIT_FLAG_NONE);
                GetCaster()->CastSpell(cr2, SPELL_ROCKET_LAUNCHER, true);
            }

            go->SetLootState(GO_JUST_DEACTIVATED);
            charmer->KilledMonsterCredit(21959);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q10612_10613_the_fel_and_the_furious::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_q10563_q10596_to_legion_hold_aura : public AuraScript
{
    PrepareAuraScript(spell_q10563_q10596_to_legion_hold_aura);

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Player* player = GetTarget()->ToPlayer())
        {
            player->KilledMonsterCredit(21502);
            player->SetControlled(false, UNIT_STATE_STUNNED);
        }
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Player* player = GetTarget()->ToPlayer())
        {
            player->SetControlled(true, UNIT_STATE_STUNNED);
            player->SummonCreature(21633, -3311.13f, 2946.15f, 171.1f, 4.86f, TEMPSUMMON_TIMED_DESPAWN, 64000);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_q10563_q10596_to_legion_hold_aura::HandleEffectApply, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_q10563_q10596_to_legion_hold_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_TRANSFORM, AURA_EFFECT_HANDLE_REAL);
    }
};

// Theirs
/*#####
# npc_invis_infernal_caster
#####*/

enum InvisInfernalCaster
{
    EVENT_CAST_SUMMON_INFERNAL = 1,
    NPC_INFERNAL_ATTACKER      = 21419,
    MODEL_INVISIBLE            = 20577,
    MODEL_INFERNAL             = 17312,
    SPELL_SUMMON_INFERNAL      = 37277,
    TYPE_INFERNAL              = 1,
    DATA_DIED                  = 1
};

class npc_invis_infernal_caster : public CreatureScript
{
public:
    npc_invis_infernal_caster() : CreatureScript("npc_invis_infernal_caster") { }

    struct npc_invis_infernal_casterAI : public ScriptedAI
    {
        npc_invis_infernal_casterAI(Creature* creature) : ScriptedAI(creature)
        {
            ground = 0.f;
        }

        void Reset() override
        {
            ground = me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
            SummonInfernal();
            events.ScheduleEvent(EVENT_CAST_SUMMON_INFERNAL, urand(1000, 3000));
        }

        void SetData(uint32 id, uint32 data) override
        {
            if (id == TYPE_INFERNAL && data == DATA_DIED)
                SummonInfernal();
        }

        void SummonInfernal()
        {
            Creature* infernal = me->SummonCreature(NPC_INFERNAL_ATTACKER, me->GetPositionX(), me->GetPositionY(), ground + 0.05f, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
            infernalGUID = infernal->GetGUID();
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CAST_SUMMON_INFERNAL:
                        {
                            if (Unit* infernal = ObjectAccessor::GetUnit(*me, infernalGUID))
                                if (infernal->GetDisplayId() == MODEL_INVISIBLE)
                                    me->CastSpell(infernal, SPELL_SUMMON_INFERNAL, true);
                            events.ScheduleEvent(EVENT_CAST_SUMMON_INFERNAL, 12000);
                            break;
                        }
                    default:
                        break;
                }
            }
        }

    private:
        EventMap events;
        ObjectGuid infernalGUID;
        float ground;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_invis_infernal_casterAI(creature);
    }
};

/*#####
# npc_infernal_attacker
#####*/

class npc_infernal_attacker : public CreatureScript
{
public:
    npc_infernal_attacker() : CreatureScript("npc_infernal_attacker") { }

    struct npc_infernal_attackerAI : public ScriptedAI
    {
        npc_infernal_attackerAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            me->SetDisplayId(MODEL_INVISIBLE);
            me->GetMotionMaster()->MoveRandom(5.0f);
        }

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner)
                return;

            if (summoner->ToCreature())
                casterGUID = summoner->ToCreature()->GetGUID();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Creature* caster = ObjectAccessor::GetCreature(*me, casterGUID))
                caster->AI()->SetData(TYPE_INFERNAL, DATA_DIED);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_SUMMON_INFERNAL)
            {
                me->RemoveUnitFlag(UNIT_FLAG_PACIFIED | UNIT_FLAG_NOT_SELECTABLE);
                me->SetImmuneToPC(false);
                me->SetDisplayId(MODEL_INFERNAL);
            }
        }

        void UpdateAI(uint32  /*diff*/) override
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

    private:
        ObjectGuid casterGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_infernal_attackerAI(creature);
    }
};

/*#####
# npc_mature_netherwing_drake
#####*/

enum MatureNetherwing
{
    SAY_JUST_EATEN              = 0,

    SPELL_PLACE_CARCASS         = 38439,
    SPELL_JUST_EATEN            = 38502,
    SPELL_NETHER_BREATH         = 38467,
    POINT_ID                    = 1,

    GO_CARCASS                  = 185155,

    QUEST_KINDNESS              = 10804,
    NPC_EVENT_PINGER            = 22131
};

class npc_mature_netherwing_drake : public CreatureScript
{
public:
    npc_mature_netherwing_drake() : CreatureScript("npc_mature_netherwing_drake") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_mature_netherwing_drakeAI(creature);
    }

    struct npc_mature_netherwing_drakeAI : public ScriptedAI
    {
        npc_mature_netherwing_drakeAI(Creature* creature) : ScriptedAI(creature) { }

        ObjectGuid uiPlayerGUID;

        bool bCanEat;
        bool bIsEating;

        uint32 EatTimer;
        uint32 CastTimer;

        void Reset() override
        {
            uiPlayerGUID.Clear();

            bCanEat = false;
            bIsEating = false;

            EatTimer = 5000;
            CastTimer = 5000;
        }

        void SpellHit(Unit* pCaster, SpellInfo const* spell) override
        {
            if (bCanEat || bIsEating)
                return;

            if (pCaster->GetTypeId() == TYPEID_PLAYER && spell->Id == SPELL_PLACE_CARCASS && !me->HasAura(SPELL_JUST_EATEN))
            {
                uiPlayerGUID = pCaster->GetGUID();
                bCanEat = true;
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == POINT_ID)
            {
                bIsEating = true;
                EatTimer = 7000;
                me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
            }
        }

        void JustReachedHome() override
        {
            me->GetMotionMaster()->InitDefault();
        }

        void UpdateAI(uint32 diff) override
        {
            if (bCanEat || bIsEating)
            {
                if (EatTimer <= diff)
                {
                    if (bCanEat && !bIsEating)
                    {
                        if (Unit* unit = ObjectAccessor::GetUnit(*me, uiPlayerGUID))
                        {
                            if (GameObject* go = unit->FindNearestGameObject(GO_CARCASS, 10))
                            {
                                if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == WAYPOINT_MOTION_TYPE)
                                    me->GetMotionMaster()->MovementExpired();

                                me->GetMotionMaster()->MoveIdle();
                                me->StopMoving();

                                me->GetMotionMaster()->MovePoint(POINT_ID, go->GetPositionX(), go->GetPositionY(), go->GetPositionZ());
                            }
                        }
                        bCanEat = false;
                    }
                    else if (bIsEating)
                    {
                        DoCast(me, SPELL_JUST_EATEN);
                        Talk(SAY_JUST_EATEN);

                        if (Player* player = ObjectAccessor::GetPlayer(*me, uiPlayerGUID))
                        {
                            player->KilledMonsterCredit(NPC_EVENT_PINGER);

                            if (GameObject* go = player->FindNearestGameObject(GO_CARCASS, 10))
                                go->Delete();
                        }

                        Reset();
                        me->GetMotionMaster()->MoveTargetedHome();
                    }
                }
                else
                    EatTimer -= diff;

                return;
            }

            if (!UpdateVictim())
                return;

            if (CastTimer <= diff)
            {
                DoCastVictim(SPELL_NETHER_BREATH);
                CastTimer = 5000;
            }
            else CastTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

/*###
# npc_enslaved_netherwing_drake
####*/

enum EnshlavedNetherwingDrake
{
    // Quest
    QUEST_THE_FORCE_OF_NELTHARAKU   = 10854,

    // Spells
    SPELL_HIT_FORCE_OF_NELTHARAKU   = 38762,
    SPELL_FORCE_OF_NELTHARAKU       = 38775,

    // Creatures
    NPC_DRAGONMAW_SUBJUGATOR        = 21718,
    NPC_DRAGONMAW_WRANGLER          = 21717,
    NPC_ESCAPE_DUMMY                = 22317,

    // Point
    POINT_DESPAWN                   = 1
};

struct npc_enslaved_netherwing_drake : public ScriptedAI
{
public:
    npc_enslaved_netherwing_drake(Creature* creature) : ScriptedAI(creature)
    {
        _tapped = false;
        Reset();
    }

    void Reset() override
    {
        scheduler.CancelAll();
        if (!_tapped)
        {
            me->RestoreFaction();
            me->SetReactState(REACT_AGGRESSIVE);
        }

        me->SetDisableGravity(false);
        me->SetVisible(true);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _tapped = false;
        me->RestoreFaction();
    }

    void SpellHit(Unit* caster, SpellInfo const* spell) override
    {
        Player* playerCaster = caster->ToPlayer();
        if (!playerCaster)
            return;

        if (spell->Id == SPELL_HIT_FORCE_OF_NELTHARAKU && !_tapped &&
            playerCaster->GetQuestStatus(QUEST_THE_FORCE_OF_NELTHARAKU) == QUEST_STATUS_INCOMPLETE)
        {
            _tapped = true;
            _playerGUID = caster->GetGUID();

            scheduler.Schedule(2s, [this](TaskContext)
            {
                me->SetFaction(FACTION_FLAYER_HUNTER); // Not sure if this is correct, it was taken off of Mordenai.

                if (Unit* dragonmaw = me->FindNearestCreature(NPC_DRAGONMAW_SUBJUGATOR, 25.0f))
                    AttackStart(dragonmaw);
                else if (Unit* dragonmaw = me->FindNearestCreature(NPC_DRAGONMAW_WRANGLER, 25.0f))
                    AttackStart(dragonmaw);
                scheduler.Schedule(2s, [this](TaskContext)
                {
                    _tapped = false;
                    Position pos;
                    if (Unit* escapeDummy = me->FindNearestCreature(NPC_ESCAPE_DUMMY, 30.0f))
                        pos = escapeDummy->GetPosition();
                    else
                    {
                        pos = me->GetRandomNearPosition(20.0f);
                        pos.m_positionZ += 25.0f;
                    }

                    me->SetDisableGravity(true);
                    me->GetMotionMaster()->MovePoint(POINT_DESPAWN, pos);
                    me->SetReactState(REACT_PASSIVE);
                    scheduler.Schedule(100ms, [this](TaskContext)
                    {
                        if (Player* player = _GetPlayer())
                        {
                            DoCast(player, SPELL_FORCE_OF_NELTHARAKU, true);
                        }
                        me->DespawnOrUnsummon(3s, 0s);
                    });
                });
            });
        }
    }

    void MovementInform(uint32 type, uint32 data) override
    {
        if (type == POINT_MOTION_TYPE && data == POINT_DESPAWN)
        {
            me->SetVisible(false);
            me->SetDisableGravity(false);
            me->DespawnOrUnsummon();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!UpdateVictim())
            return;

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
private:
    bool _tapped;
    ObjectGuid _playerGUID;

    Player* _GetPlayer() { return ObjectAccessor::GetPlayer(*me, _playerGUID); }
};

/*#####
# npc_dragonmaw_peon
#####*/
enum DragonmawPeon
{
    SAY_1                      = 0,
    SAY_POISONED_1             = 1,

    SPELL_POISON               = 40468,
    SPELL_KICK                 = 15610,
    SPELL_SUNDER               = 15572,
    SPELL_VOMIT                = 43327,

    EVENT_KICK                 = 1,
    EVENT_SUNDER               = 2,
    EVENT_CHECK_POISON         = 3,
    EVENT_WALK_TO_MUTTON       = 4,
    EVENT_POISONED             = 5,
    EVENT_KILL                 = 6,

    DELICIOUS_MUTTON           = 185893,
    QUEST_A_SLOW_DEATH         = 11020,
    DRAGONMAW_PEON_KILL_CREDIT = 23209
};

class npc_dragonmaw_peon : public CreatureScript
{
public:
    npc_dragonmaw_peon() : CreatureScript("npc_dragonmaw_peon") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_dragonmaw_peonAI(creature);
    }

    struct npc_dragonmaw_peonAI : public ScriptedAI
    {
        npc_dragonmaw_peonAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;
        ObjectGuid PlayerGUID;
        bool Tapped;

        void Reset() override
        {
            events.Reset();
            PlayerGUID.Clear();
            Tapped = false;
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_KICK, urand(5000, 10000));
            events.ScheduleEvent(EVENT_SUNDER, urand(5000, 10000));
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (!caster)
                return;

            PlayerGUID = caster->GetGUID();

            if (caster->GetTypeId() == TYPEID_PLAYER && spell->Id == SPELL_POISON && !Tapped)
            {
                Tapped = true;
                caster->GetClosePoint(x, y, z, me->GetObjectSize());
                Talk(SAY_1);
                events.ScheduleEvent(EVENT_WALK_TO_MUTTON, 0);
            }
        }

        void MovementInform(uint32 /*type*/, uint32 id) override
        {
            if (id == 1)
            {
                if (GameObject* food = me->FindNearestGameObject(DELICIOUS_MUTTON, 5.0f))
                    me->SetFacingToObject(food);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EAT);
                events.ScheduleEvent(EVENT_POISONED, 5000);
            }
        }

        void CreditPlayer()
        {
            if (PlayerGUID)
            {
                Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID);
                if (player && player->GetQuestStatus(QUEST_A_SLOW_DEATH) == QUEST_STATUS_INCOMPLETE)
                    player->KilledMonsterCredit(DRAGONMAW_PEON_KILL_CREDIT);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (!UpdateVictim())
            {
                switch (events.ExecuteEvent())
                {
                    case EVENT_WALK_TO_MUTTON:
                        me->SetWalk(true);
                        me->GetMotionMaster()->MovePoint(1, x, y, z, true);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
                        break;
                    case EVENT_POISONED:
                        if (GameObject* food = me->FindNearestGameObject(DELICIOUS_MUTTON, 5.0f))
                            food->RemoveFromWorld();
                        if (roll_chance_i(20))
                            Talk(SAY_POISONED_1);
                        CreditPlayer();
                        me->CastSpell(me, SPELL_VOMIT);
                        events.ScheduleEvent(EVENT_KILL, 5000);
                        break;
                    case EVENT_KILL:
                        Unit::DealDamage(me, me, me->GetHealth(), nullptr, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, nullptr, false);
                        break;
                }
                return;
            }

            switch (events.ExecuteEvent())
            {
                case EVENT_KICK:
                    if (me->GetVictim()->HasUnitState(SPELL_STATE_CASTING))
                        DoCastVictim(SPELL_KICK);
                    events.RepeatEvent(urand(5000, 10000));
                    break;
                case EVENT_SUNDER:
                    DoCastVictim(SPELL_SUNDER);
                    events.RepeatEvent(urand(5000, 10000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    private:
        float x, y, z;
    };
};

/*######
## npc_drake_dealer_hurlunk
######*/

class npc_drake_dealer_hurlunk : public CreatureScript
{
public:
    npc_drake_dealer_hurlunk() : CreatureScript("npc_drake_dealer_hurlunk") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsVendor() && player->GetReputationRank(1015) == REP_EXALTED)
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

/*######
## npc_flanis_swiftwing_and_kagrosh
######*/

enum Flanis : uint32
{
    QUEST_THE_FATE_OF_FLANIS    = 10583,
    ITEM_FLAUNISS_PACK          = 30658,
    GOSSIP_MENU_FLANIS          = 8356,
};

enum Kagrosh : uint32
{
    QUEST_THE_FATE_OF_KAGROSH   = 10601,
    ITEM_KAGROSHS_PACK          = 30659,
    GOSSIP_MENU_KAGROSH         = 8371,
};

class npcs_flanis_swiftwing_and_kagrosh : public CreatureScript
{
public:
    npcs_flanis_swiftwing_and_kagrosh() : CreatureScript("npcs_flanis_swiftwing_and_kagrosh") { }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            ItemPosCountVec dest;
            uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, ITEM_FLAUNISS_PACK, 1, nullptr);
            if (msg == EQUIP_ERR_OK)
            {
                player->StoreNewItem(dest, ITEM_FLAUNISS_PACK, true);
            }
        }
        if (action == GOSSIP_ACTION_INFO_DEF + 2)
        {
            ItemPosCountVec dest;
            uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, ITEM_KAGROSHS_PACK, 1, nullptr);
            if (msg == EQUIP_ERR_OK)
            {
                player->StoreNewItem(dest, ITEM_KAGROSHS_PACK, true);
            }
        }

        CloseGossipMenuFor(player);

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_THE_FATE_OF_FLANIS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(ITEM_FLAUNISS_PACK, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_FLANIS, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        if (player->GetQuestStatus(QUEST_THE_FATE_OF_KAGROSH) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(ITEM_KAGROSHS_PACK, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_KAGROSH, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

/*####
# npc_karynaku
####*/

enum Karynaku
{
    QUEST_ALLY_OF_NETHER    = 10870,
    QUEST_ZUHULED_THE_WACK  = 10866,

    NPC_ZUHULED_THE_WACKED  = 11980,

    TAXI_PATH_ID            = 649,
};

class npc_karynaku : public CreatureScript
{
public:
    npc_karynaku() : CreatureScript("npc_karynaku") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_ALLY_OF_NETHER)
            player->ActivateTaxiPathTo(TAXI_PATH_ID);

        if (quest->GetQuestId() == QUEST_ZUHULED_THE_WACK)
            creature->SummonCreature(NPC_ZUHULED_THE_WACKED, -4204.94f, 316.397f, 122.508f, 1.309f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000);

        return true;
    }
};

/*#####
# Quest: Battle of the crimson watch
#####*/

/* ContentData
Battle of the crimson watch - creatures, gameobjects and defines
npc_illidari_spawn : Adds that are summoned in the Crimson Watch battle.
npc_torloth_the_magnificent : Final Creature that players have to face before quest is completed
npc_lord_illidan_stormrage : Creature that controls the event.
go_crystal_prison : GameObject that begins the event and hands out quest
EndContentData */

#define QUEST_BATTLE_OF_THE_CRIMSON_WATCH 10781
#define EVENT_AREA_RADIUS 65 //65yds
#define EVENT_COOLDOWN 30000 //in ms. appear after event completed or failed (should be = Adds despawn time)

struct TorlothCinematic
{
    uint32 creature, Timer;
};

// Creature 0 - Torloth, 1 - Illidan
static TorlothCinematic TorlothAnim[] =
{
    {0, 2000},
    {1, 7000},
    {0, 3000},
    {0, 2000}, // Torloth stand
    {0, 1000},
    {0, 3000},
    {0, 0}
};

struct Location
{
    float x, y, z, o;
};

//Cordinates for Spawns
static Location SpawnLocation[] =
{
    //Cords used for:
    {-4615.8556f, 1342.2532f, 139.9f, 1.612f}, //Illidari Soldier
    {-4598.9365f, 1377.3182f, 139.9f, 3.917f}, //Illidari Soldier
    {-4598.4697f, 1360.8999f, 139.9f, 2.427f}, //Illidari Soldier
    {-4589.3599f, 1369.1061f, 139.9f, 3.165f}, //Illidari Soldier
    {-4608.3477f, 1386.0076f, 139.9f, 4.108f}, //Illidari Soldier
    {-4633.1889f, 1359.8033f, 139.9f, 0.949f}, //Illidari Soldier
    {-4623.5791f, 1351.4574f, 139.9f, 0.971f}, //Illidari Soldier
    {-4607.2988f, 1351.6099f, 139.9f, 2.416f}, //Illidari Soldier
    {-4633.7764f, 1376.0417f, 139.9f, 5.608f}, //Illidari Soldier
    {-4600.2461f, 1369.1240f, 139.9f, 3.056f}, //Illidari Mind Breaker
    {-4631.7808f, 1367.9459f, 139.9f, 0.020f}, //Illidari Mind Breaker
    {-4600.2461f, 1369.1240f, 139.9f, 3.056f}, //Illidari Highlord
    {-4631.7808f, 1367.9459f, 139.9f, 0.020f}, //Illidari Highlord
    {-4615.5586f, 1353.0031f, 139.9f, 1.540f}, //Illidari Highlord
    {-4616.4736f, 1384.2170f, 139.9f, 4.971f}, //Illidari Highlord
    {-4627.1240f, 1378.8752f, 139.9f, 2.544f} //Torloth The Magnificent
};

struct WaveDataCreature
{
    uint8 SpawnCount, UsedSpawnPoint;
    uint32 CreatureId, SpawnTimer, YellTimer;
};

static WaveDataCreature WavesInfo[] =
{
    {9, 0, 22075, 10000, 7000},   //Illidari Soldier
    {2, 9, 22074, 10000, 7000},   //Illidari Mind Breaker
    {4, 11, 19797, 10000, 7000},  //Illidari Highlord
    {1, 15, 22076, 10000, 7000}   //Torloth The Magnificent
};

struct SpawnSpells
{
    uint32 Timer1, Timer2, SpellId;
};

static SpawnSpells SpawnCast[] =
{
    {10000, 15000, 35871},  // Illidari Soldier Cast - Spellbreaker
    {10000, 10000, 38985},  // Illidari Mind Breake Cast - Focused Bursts
    {35000, 35000, 22884},  // Illidari Mind Breake Cast - Psychic Scream
    {20000, 20000, 17194},  // Illidari Mind Breake Cast - Mind Blast
    {8000, 15000, 38010},   // Illidari Highlord Cast - Curse of Flames
    {12000, 20000, 16102},  // Illidari Highlord Cast - Flamestrike
    {10000, 15000, 15284},  // Torloth the Magnificent Cast - Cleave
    {18000, 20000, 39082},  // Torloth the Magnificent Cast - Shadowfury
    {25000, 28000, 33961}   // Torloth the Magnificent Cast - Spell Reflection
};

/*######
# npc_torloth_the_magnificent
#####*/

class npc_torloth_the_magnificent : public CreatureScript
{
public:
    npc_torloth_the_magnificent() : CreatureScript("npc_torloth_the_magnificent") { }

    CreatureAI* GetAI(Creature* c) const override
    {
        return new npc_torloth_the_magnificentAI(c);
    }

    struct npc_torloth_the_magnificentAI : public ScriptedAI
    {
        npc_torloth_the_magnificentAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 AnimationTimer, SpellTimer1, SpellTimer2, SpellTimer3;

        uint8 AnimationCount;

        ObjectGuid LordIllidanGUID;
        ObjectGuid AggroTargetGUID;

        bool Timers;

        void Reset() override
        {
            AnimationTimer = 4000;
            AnimationCount = 0;
            LordIllidanGUID.Clear();
            AggroTargetGUID.Clear();
            Timers = false;

            me->AddUnitState(UNIT_STATE_ROOT);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetTarget();
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void HandleAnimation()
        {
            Creature* creature = me;

            if (TorlothAnim[AnimationCount].creature == 1)
            {
                creature = (ObjectAccessor::GetCreature(*me, LordIllidanGUID));

                if (!creature)
                    return;
            }

            AnimationTimer = TorlothAnim[AnimationCount].Timer;

            switch (AnimationCount)
            {
                case 0:
                    me->SetUInt32Value(UNIT_FIELD_BYTES_1, 8);
                    break;
                case 3:
                    me->RemoveFlag(UNIT_FIELD_BYTES_1, 8);
                    break;
                case 5:
                    if (Player* AggroTarget = ObjectAccessor::GetPlayer(*me, AggroTargetGUID))
                    {
                        me->SetTarget(AggroTarget->GetGUID());
                        me->AddThreat(AggroTarget, 1);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                    }
                    break;
                case 6:
                    if (Player* AggroTarget = ObjectAccessor::GetPlayer(*me, AggroTargetGUID))
                    {
                        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                        me->ClearUnitState(UNIT_STATE_ROOT);

                        float x, y, z;
                        AggroTarget->GetPosition(x, y, z);
                        me->GetMotionMaster()->MovePoint(0, x, y, z);
                    }
                    break;
            }
            ++AnimationCount;
        }

        void UpdateAI(uint32 diff) override
        {
            if (AnimationTimer)
            {
                if (AnimationTimer <= diff)
                {
                    HandleAnimation();
                }
                else AnimationTimer -= diff;
            }

            if (AnimationCount < 6)
            {
                me->CombatStop();
            }
            else if (!Timers)
            {
                SpellTimer1 = SpawnCast[6].Timer1;
                SpellTimer2 = SpawnCast[7].Timer1;
                SpellTimer3 = SpawnCast[8].Timer1;
                Timers = true;
            }

            if (Timers)
            {
                if (SpellTimer1 <= diff)
                {
                    DoCastVictim(SpawnCast[6].SpellId);//Cleave
                    SpellTimer1 = SpawnCast[6].Timer2 + (rand() % 10 * 1000);
                }
                else SpellTimer1 -= diff;

                if (SpellTimer2 <= diff)
                {
                    DoCastVictim(SpawnCast[7].SpellId);//Shadowfury
                    SpellTimer2 = SpawnCast[7].Timer2 + (rand() % 5 * 1000);
                }
                else SpellTimer2 -= diff;

                if (SpellTimer3 <= diff)
                {
                    DoCast(me, SpawnCast[8].SpellId);
                    SpellTimer3 = SpawnCast[8].Timer2 + (rand() % 7 * 1000); //Spell Reflection
                }
                else SpellTimer3 -= diff;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* killer) override
        {
            switch (killer->GetTypeId())
            {
                case TYPEID_UNIT:
                    if (Unit* owner = killer->GetOwner())
                        if (Player* player = owner->ToPlayer())
                            player->GroupEventHappens(QUEST_BATTLE_OF_THE_CRIMSON_WATCH, me);
                    break;
                case TYPEID_PLAYER:
                    if (Player* player = killer->ToPlayer())
                        player->GroupEventHappens(QUEST_BATTLE_OF_THE_CRIMSON_WATCH, me);
                    break;
                default:
                    break;
            }

            if (Creature* LordIllidan = (ObjectAccessor::GetCreature(*me, LordIllidanGUID)))
                LordIllidan->AI()->EnterEvadeMode();
        }
    };
};

/*#####
# npc_lord_illidan_stormrage
#####*/

class npc_lord_illidan_stormrage : public CreatureScript
{
public:
    npc_lord_illidan_stormrage() : CreatureScript("npc_lord_illidan_stormrage") { }

    CreatureAI* GetAI(Creature* c) const override
    {
        return new npc_lord_illidan_stormrageAI(c);
    }

    struct npc_lord_illidan_stormrageAI : public ScriptedAI
    {
        npc_lord_illidan_stormrageAI(Creature* creature) : ScriptedAI(creature) { }

        ObjectGuid PlayerGUID;

        uint32 WaveTimer;
        uint32 AnnounceTimer;

        int8 LiveCount;
        uint8 WaveCount;

        bool EventStarted;
        bool Announced;
        bool Failed;

        void Reset() override
        {
            PlayerGUID.Clear();

            WaveTimer = 10000;
            AnnounceTimer = 7000;
            LiveCount = 0;
            WaveCount = 0;

            EventStarted = false;
            Announced = false;
            Failed = false;

            me->SetVisible(false);
        }

        void JustEngagedWith(Unit* /*who*/) override { }
        void MoveInLineOfSight(Unit* /*who*/) override { }

        void AttackStart(Unit* /*who*/) override { }

        void SummonNextWave();

        void CheckEventFail()
        {
            Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID);
            if (!player)
            {
                Failed = true;
                return;
            }

            if (Group* EventGroup = player->GetGroup())
            {
                uint8 GroupMemberCount = 0;
                uint8 DeadMemberCount = 0;
                uint8 FailedMemberCount = 0;

                Group::MemberSlotList const& members = EventGroup->GetMemberSlots();

                for (Group::member_citerator itr = members.begin(); itr != members.end(); ++itr)
                {
                    Player* GroupMember = ObjectAccessor::GetPlayer(*me, itr->guid);
                    if (!GroupMember)
                        continue;
                    if (!GroupMember->IsWithinDistInMap(me, EVENT_AREA_RADIUS) && GroupMember->GetQuestStatus(QUEST_BATTLE_OF_THE_CRIMSON_WATCH) == QUEST_STATUS_INCOMPLETE)
                    {
                        GroupMember->FailQuest(QUEST_BATTLE_OF_THE_CRIMSON_WATCH);
                        ++FailedMemberCount;
                    }
                    ++GroupMemberCount;

                    if (GroupMember->isDead())
                        ++DeadMemberCount;
                }

                if (GroupMemberCount == FailedMemberCount)
                {
                    Failed = true;
                }

                if (GroupMemberCount == DeadMemberCount)
                {
                    for (Group::member_citerator itr = members.begin(); itr != members.end(); ++itr)
                    {
                        if (Player* groupMember = ObjectAccessor::GetPlayer(*me, itr->guid))
                            if (groupMember->GetQuestStatus(QUEST_BATTLE_OF_THE_CRIMSON_WATCH) == QUEST_STATUS_INCOMPLETE)
                                groupMember->FailQuest(QUEST_BATTLE_OF_THE_CRIMSON_WATCH);
                    }
                    Failed = true;
                }
            }
            else if (player->isDead() || !player->IsWithinDistInMap(me, EVENT_AREA_RADIUS))
            {
                player->FailQuest(QUEST_BATTLE_OF_THE_CRIMSON_WATCH);
                Failed = true;
            }
        }

        void LiveCounter()
        {
            --LiveCount;
            if (!LiveCount)
                Announced = false;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!PlayerGUID || !EventStarted)
                return;

            if (!LiveCount && WaveCount < 4)
            {
                if (!Announced && AnnounceTimer <= diff)
                {
                    Announced = true;
                }
                else
                    AnnounceTimer -= diff;

                if (WaveTimer <= diff)
                {
                    SummonNextWave();
                }
                else
                    WaveTimer -= diff;
            }
            CheckEventFail();

            if (Failed)
                EnterEvadeMode();
        }
    };
};

/*######
# npc_illidari_spawn
######*/

class npc_illidari_spawn : public CreatureScript
{
public:
    npc_illidari_spawn() : CreatureScript("npc_illidari_spawn") { }

    CreatureAI* GetAI(Creature* c) const override
    {
        return new npc_illidari_spawnAI(c);
    }

    struct npc_illidari_spawnAI : public ScriptedAI
    {
        npc_illidari_spawnAI(Creature* creature) : ScriptedAI(creature) { }

        ObjectGuid LordIllidanGUID;
        uint32 SpellTimer1, SpellTimer2, SpellTimer3;
        bool Timers;

        void Reset() override
        {
            LordIllidanGUID.Clear();
            Timers = false;
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void JustDied(Unit* /*killer*/) override
        {
            me->RemoveCorpse();
            if (Creature* LordIllidan = (ObjectAccessor::GetCreature(*me, LordIllidanGUID)))
                if (LordIllidan)
                    CAST_AI(npc_lord_illidan_stormrage::npc_lord_illidan_stormrageAI, LordIllidan->AI())->LiveCounter();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (!Timers)
            {
                if (me->GetEntry() == 22075)//Illidari Soldier
                {
                    SpellTimer1 = SpawnCast[0].Timer1 + (rand() % 4 * 1000);
                }
                if (me->GetEntry() == 22074)//Illidari Mind Breaker
                {
                    SpellTimer1 = SpawnCast[1].Timer1 + (rand() % 10 * 1000);
                    SpellTimer2 = SpawnCast[2].Timer1 + (rand() % 4 * 1000);
                    SpellTimer3 = SpawnCast[3].Timer1 + (rand() % 4 * 1000);
                }
                if (me->GetEntry() == 19797)// Illidari Highlord
                {
                    SpellTimer1 = SpawnCast[4].Timer1 + (rand() % 4 * 1000);
                    SpellTimer2 = SpawnCast[5].Timer1 + (rand() % 4 * 1000);
                }
                Timers = true;
            }
            //Illidari Soldier
            if (me->GetEntry() == 22075)
            {
                if (SpellTimer1 <= diff)
                {
                    DoCastVictim(SpawnCast[0].SpellId);//Spellbreaker
                    SpellTimer1 = SpawnCast[0].Timer2 + (rand() % 5 * 1000);
                }
                else SpellTimer1 -= diff;
            }
            //Illidari Mind Breaker
            if (me->GetEntry() == 22074)
            {
                if (SpellTimer1 <= diff)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    {
                        if (target->GetTypeId() == TYPEID_PLAYER)
                        {
                            DoCast(target, SpawnCast[1].SpellId); //Focused Bursts
                            SpellTimer1 = SpawnCast[1].Timer2 + (rand() % 5 * 1000);
                        }
                        else SpellTimer1 = 2000;
                    }
                }
                else SpellTimer1 -= diff;

                if (SpellTimer2 <= diff)
                {
                    DoCastVictim(SpawnCast[2].SpellId);//Psychic Scream
                    SpellTimer2 = SpawnCast[2].Timer2 + (rand() % 13 * 1000);
                }
                else SpellTimer2 -= diff;

                if (SpellTimer3 <= diff)
                {
                    DoCastVictim(SpawnCast[3].SpellId);//Mind Blast
                    SpellTimer3 = SpawnCast[3].Timer2 + (rand() % 8 * 1000);
                }
                else SpellTimer3 -= diff;
            }
            //Illidari Highlord
            if (me->GetEntry() == 19797)
            {
                if (SpellTimer1 <= diff)
                {
                    DoCastVictim(SpawnCast[4].SpellId);//Curse Of Flames
                    SpellTimer1 = SpawnCast[4].Timer2 + (rand() % 10 * 1000);
                }
                else SpellTimer1 -= diff;

                if (SpellTimer2 <= diff)
                {
                    DoCastVictim(SpawnCast[5].SpellId);//Flamestrike
                    SpellTimer2 = SpawnCast[5].Timer2 + (rand() % 7 * 13000);
                }
                else SpellTimer2 -= diff;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void npc_lord_illidan_stormrage::npc_lord_illidan_stormrageAI::SummonNextWave()
{
    uint8 count = WavesInfo[WaveCount].SpawnCount;
    uint8 locIndex = WavesInfo[WaveCount].UsedSpawnPoint;
    uint8 FelguardCount = 0;
    uint8 DreadlordCount = 0;

    for (uint8 i = 0; i < count; ++i)
    {
        Creature* Spawn = nullptr;
        float X = SpawnLocation[locIndex + i].x;
        float Y = SpawnLocation[locIndex + i].y;
        float Z = SpawnLocation[locIndex + i].z;
        float O = SpawnLocation[locIndex + i].o;
        Spawn = me->SummonCreature(WavesInfo[WaveCount].CreatureId, X, Y, Z, O, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 60000);
        ++LiveCount;

        if (Spawn)
        {
            if (WaveCount == 0)//1 Wave
            {
                if (rand() % 3 == 1 && FelguardCount < 2)
                {
                    Spawn->SetDisplayId(18654);
                    ++FelguardCount;
                }
                else if (DreadlordCount < 3)
                {
                    Spawn->SetDisplayId(19991);
                    ++DreadlordCount;
                }
                else if (FelguardCount < 2)
                {
                    Spawn->SetDisplayId(18654);
                    ++FelguardCount;
                }
            }

            if (WaveCount < 3)//1-3 Wave
            {
                if (PlayerGUID)
                {
                    if (Player* target = ObjectAccessor::GetPlayer(*me, PlayerGUID))
                    {
                        float x, y, z;
                        target->GetPosition(x, y, z);
                        Spawn->GetMotionMaster()->MovePoint(0, x, y, z);
                    }
                }
                CAST_AI(npc_illidari_spawn::npc_illidari_spawnAI, Spawn->AI())->LordIllidanGUID = me->GetGUID();
            }

            if (WavesInfo[WaveCount].CreatureId == 22076) // Torloth
            {
                CAST_AI(npc_torloth_the_magnificent::npc_torloth_the_magnificentAI, Spawn->AI())->LordIllidanGUID = me->GetGUID();
                if (PlayerGUID)
                    CAST_AI(npc_torloth_the_magnificent::npc_torloth_the_magnificentAI, Spawn->AI())->AggroTargetGUID = PlayerGUID;
            }
        }
    }
    ++WaveCount;
    WaveTimer = WavesInfo[WaveCount].SpawnTimer;
    AnnounceTimer = WavesInfo[WaveCount].YellTimer;
}

/*#####
# go_crystal_prison
######*/

class go_crystal_prison : public GameObjectScript
{
public:
    go_crystal_prison() : GameObjectScript("go_crystal_prison") { }

    bool OnQuestAccept(Player* player, GameObject* /*go*/, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_BATTLE_OF_THE_CRIMSON_WATCH)
        {
            Creature* Illidan = player->FindNearestCreature(22083, 50);

            if (Illidan && !CAST_AI(npc_lord_illidan_stormrage::npc_lord_illidan_stormrageAI, Illidan->AI())->EventStarted)
            {
                CAST_AI(npc_lord_illidan_stormrage::npc_lord_illidan_stormrageAI, Illidan->AI())->PlayerGUID = player->GetGUID();
                CAST_AI(npc_lord_illidan_stormrage::npc_lord_illidan_stormrageAI, Illidan->AI())->LiveCount = 0;
                CAST_AI(npc_lord_illidan_stormrage::npc_lord_illidan_stormrageAI, Illidan->AI())->EventStarted = true;
            }
        }
        return true;
    }
};

/*####
# npc_enraged_spirits
####*/

enum Enraged_Dpirits
{
    // QUESTS
    QUEST_ENRAGED_SPIRITS_FIRE_EARTH        = 10458,
    QUEST_ENRAGED_SPIRITS_AIR               = 10481,
    QUEST_ENRAGED_SPIRITS_WATER             = 10480,

    // Totem
    ENTRY_TOTEM_OF_SPIRITS                  = 21071,
    RADIUS_TOTEM_OF_SPIRITS                 = 15,

    // SPIRITS
    NPC_ENRAGED_EARTH_SPIRIT                = 21050,
    NPC_ENRAGED_FIRE_SPIRIT                 = 21061,
    NPC_ENRAGED_AIR_SPIRIT                  = 21060,
    NPC_ENRAGED_WATER_SPIRIT                = 21059,

    // ENRAGED WATER SPIRIT SPELLS
    SPELL_STORMBOLT                         = 38032,

    // ENRAGED AIR SPIRIT SPELLS
    SPELL_AIR_SPIRIT_CHAIN_LIGHTNING        = 12058,
    SPELL_HURRICANE                         = 32717,
    SPELL_ENRAGE                            = 8599,

    // ENRAGED FIRE SPIRIT SPELLS - Will be using the enrage spell from Air Spirit
    SPELL_FEL_FIREBALL                      = 36247,
    SPELL_FEL_FIRE_AURA                     = 36006, // Earth spirit uses this one

    // ENRAGED EARTH SPIRIT SPELLS
    SPELL_FIERY_BOULDER                     = 38498,
    SPELL_SUMMON_ENRAGED_EARTH_SHARD        = 38365,

    // SOULS
    NPC_EARTHEN_SOUL                        = 21073,
    NPC_FIERY_SOUL                          = 21097,
    NPC_ENRAGED_AIRY_SOUL                   = 21116,
    NPC_ENRAGED_WATERY_SOUL                 = 21109, // wrong model

    // SPELL KILLCREDIT - not working!?! - using KilledMonsterCredit
    SPELL_EARTHEN_SOUL_CAPTURED_CREDIT      = 36108,
    SPELL_FIERY_SOUL_CAPTURED_CREDIT        = 36117,
    SPELL_AIRY_SOUL_CAPTURED_CREDIT         = 36182,
    SPELL_WATERY_SOUL_CAPTURED_CREDIT       = 36171,

    // KilledMonsterCredit Workaround
    NPC_CREDIT_FIRE                         = 21094,
    NPC_CREDIT_WATER                        = 21095,
    NPC_CREDIT_AIR                          = 21096,
    NPC_CREDIT_EARTH                        = 21092,

    // Captured Spell / Buff
    SPELL_SOUL_CAPTURED                     = 36115
};

class npc_enraged_spirit : public CreatureScript
{
public:
    npc_enraged_spirit() : CreatureScript("npc_enraged_spirit") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_enraged_spiritAI(creature);
    }

    struct npc_enraged_spiritAI : public ScriptedAI
    {
        npc_enraged_spiritAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override { }

        void JustEngagedWith(Unit* /*who*/) override
        {
            switch (me->GetEntry())
            {
                case NPC_ENRAGED_WATER_SPIRIT:
                    _scheduler.Schedule(0s, 1s, [this](TaskContext context)
                    {
                        if (UpdateVictim())
                        {
                            DoCastVictim(SPELL_STORMBOLT);
                        }
                        context.Repeat(17s, 23s);
                    });
                    break;
                case NPC_ENRAGED_FIRE_SPIRIT:
                    if (!me->GetAura(SPELL_FEL_FIRE_AURA))
                    {
                        DoCastSelf(SPELL_FEL_FIRE_AURA);
                    }
                    _scheduler.Schedule(2s, 10s, [this](TaskContext context)
                    {
                        if (UpdateVictim())
                        {
                            DoCastVictim(SPELL_FEL_FIREBALL);
                        }
                        context.Repeat(6s, 12s);
                    });
                    break;
                case NPC_ENRAGED_EARTH_SPIRIT:
                    if (!me->GetAura(SPELL_FEL_FIRE_AURA))
                    {
                        DoCastSelf(SPELL_FEL_FIRE_AURA);
                    }
                    _scheduler.Schedule(3s, 4s, [this](TaskContext context)
                    {
                        if (UpdateVictim())
                        {
                            DoCastVictim(SPELL_FIERY_BOULDER);
                        }
                        context.Repeat(6s, 9s);
                    });
                    break;
                case NPC_ENRAGED_AIR_SPIRIT:
                    _scheduler.Schedule(10s, [this](TaskContext context)
                    {
                        if (UpdateVictim())
                        {
                            DoCastVictim(SPELL_AIR_SPIRIT_CHAIN_LIGHTNING);
                        }
                        _scheduler.Schedule(3s, 5s, [this](TaskContext /*context*/)
                        {
                            if (UpdateVictim())
                            {
                                DoCastVictim(SPELL_HURRICANE);
                            }
                        });
                        context.Repeat(12s, 15s);
                    });
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _scheduler.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (me->GetEntry() == NPC_ENRAGED_FIRE_SPIRIT || me->GetEntry() == NPC_ENRAGED_AIR_SPIRIT)
            {
                if (HealthBelowPct(35) && !me->GetAura(SPELL_ENRAGE))
                {
                    DoCastSelf(SPELL_ENRAGE);
                }
            }
            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            // always spawn spirit on death
            // if totem around
            // move spirit to totem and cast kill count
            uint32 entry = 0;
            uint32 credit = 0;

            switch (me->GetEntry())
            {
                case NPC_ENRAGED_FIRE_SPIRIT:
                    entry  = NPC_FIERY_SOUL;
                    //credit = SPELL_FIERY_SOUL_CAPTURED_CREDIT;
                    credit = NPC_CREDIT_FIRE;
                    break;
                case NPC_ENRAGED_EARTH_SPIRIT:
                    entry  = NPC_EARTHEN_SOUL;
                    //credit = SPELL_EARTHEN_SOUL_CAPTURED_CREDIT;
                    credit = NPC_CREDIT_EARTH;
                    DoCastSelf(SPELL_SUMMON_ENRAGED_EARTH_SHARD);
                    break;
                case NPC_ENRAGED_AIR_SPIRIT:
                    entry  = NPC_ENRAGED_AIRY_SOUL;
                    //credit = SPELL_AIRY_SOUL_CAPTURED_CREDIT;
                    credit = NPC_CREDIT_AIR;
                    break;
                case NPC_ENRAGED_WATER_SPIRIT:
                    entry  = NPC_ENRAGED_WATERY_SOUL;
                    //credit = SPELL_WATERY_SOUL_CAPTURED_CREDIT;
                    credit = NPC_CREDIT_WATER;
                    break;
                default:
                    break;
            }

            // Spawn Soul on Kill ALWAYS!
            Creature* Summoned = nullptr;
            Unit* totemOspirits = nullptr;

            if (entry != 0)
                Summoned = DoSpawnCreature(entry, 0, 0, 1, 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 5000);

            // FIND TOTEM, PROCESS QUEST
            if (Summoned)
            {
                totemOspirits = me->FindNearestCreature(ENTRY_TOTEM_OF_SPIRITS, RADIUS_TOTEM_OF_SPIRITS);
                if (totemOspirits)
                {
                    Summoned->SetFaction(FACTION_FRIENDLY);
                    Summoned->GetMotionMaster()->MovePoint(0, totemOspirits->GetPositionX(), totemOspirits->GetPositionY(), Summoned->GetPositionZ());

                    if (Unit* owner = totemOspirits->GetOwner())
                        if (Player* player = owner->ToPlayer())
                            player->KilledMonsterCredit(credit);
                    DoCast(totemOspirits, SPELL_SOUL_CAPTURED);
                }
            }
        }
    private:
        TaskScheduler _scheduler;
    };
};

enum ShadowMoonTuberEnum
{
    SPELL_WHISTLE               = 36652,
    SPELL_SHADOWMOON_TUBER      = 36462,

    NPC_BOAR_ENTRY              = 21195,
    GO_SHADOWMOON_TUBER_MOUND   = 184701,

    POINT_TUBER                 = 1,
    TYPE_BOAR                   = 1,
    DATA_BOAR                   = 1
};

class npc_shadowmoon_tuber_node : public CreatureScript
{
public:
    npc_shadowmoon_tuber_node() : CreatureScript("npc_shadowmoon_tuber_node") { }

    struct npc_shadowmoon_tuber_nodeAI : public ScriptedAI
    {
        npc_shadowmoon_tuber_nodeAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            tapped = false;
            tuberGUID.Clear();
            resetTimer = 60000;
        }

        void SetData(uint32 id, uint32 data) override
        {
            if (id == TYPE_BOAR && data == DATA_BOAR)
            {
                // Spawn chest GO
                DoCast(SPELL_SHADOWMOON_TUBER);

                // Despawn the tuber
                if (GameObject* tuber = me->FindNearestGameObject(GO_SHADOWMOON_TUBER_MOUND, 5.0f))
                {
                    tuberGUID = tuber->GetGUID();
                    // @Workaround: find how to properly despawn the GO
                    tuber->SetPhaseMask(2, true);
                }
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (!tapped && spell->Id == SPELL_WHISTLE)
            {
                if (Creature* boar = me->FindNearestCreature(NPC_BOAR_ENTRY, 30.0f))
                {
                    // Disable trigger and force nearest boar to walk to him
                    tapped = true;
                    boar->SetWalk(false);
                    boar->GetMotionMaster()->MovePoint(POINT_TUBER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (tapped)
            {
                if (resetTimer <= diff)
                {
                    // Respawn the tuber
                    if (tuberGUID)
                        if (GameObject* tuber = ObjectAccessor::GetGameObject(*me, tuberGUID))
                            // @Workaround: find how to properly respawn the GO
                            tuber->SetPhaseMask(1, true);

                    Reset();
                }
                else
                    resetTimer -= diff;
            }
        }
    private:
        bool tapped;
        ObjectGuid tuberGUID;
        uint32 resetTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_shadowmoon_tuber_nodeAI(creature);
    }
};

enum KorWild
{
    SAY_LAND    = 0,
    POINT_LAND  = 1
};

class npc_korkron_or_wildhammer : public ScriptedAI
{
public:
    npc_korkron_or_wildhammer(Creature* creature) : ScriptedAI(creature)
    {
        creature->SetDisableGravity(true);
        creature->SetHover(true);
    }

    void Reset() override
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->DespawnOrUnsummon(3s, 0s);
    }

    void IsSummonedBy(WorldObject* summoner) override
    {
        _playerGUID = summoner->GetGUID();
        me->SetFacingToObject(summoner);
        Position pos = summoner->GetPosition();
        me->GetMotionMaster()->MovePoint(POINT_LAND, pos);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == POINT_LAND)
        {
            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                Talk(SAY_LAND, player);

            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }
    }
private:
    ObjectGuid _playerGUID;
};

class spell_calling_korkron_or_wildhammer : public SpellScript
{
    PrepareSpellScript(spell_calling_korkron_or_wildhammer);

    void SetDest(SpellDestination& dest)
    {
        // Adjust effect summon position
        Position const offset = { -14.0f, -14.0f, 16.0f, 0.0f };
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_calling_korkron_or_wildhammer::SetDest, EFFECT_0, TARGET_DEST_CASTER);
    }
};

enum InfernalOversoul
{
    NPC_INFERNAL_OVERSOUL             = 21735,
    SPELL_DISRUPT_SUMMONING_RITUAL    = 37285
};

class spell_disrupt_summoning_ritual : public SpellScript
{
public:
    PrepareSpellScript(spell_disrupt_summoning_ritual);

    SpellCastResult CheckRequirement()
    {
        if (Unit* caster = GetCaster())
            if (Creature* infernal = caster->FindNearestCreature(NPC_INFERNAL_OVERSOUL, 100.0f))
                if (!infernal->HasAura(SPELL_DISRUPT_SUMMONING_RITUAL))
                    return SPELL_FAILED_CASTER_AURASTATE;
        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_disrupt_summoning_ritual::CheckRequirement);
    }
};

/*
######
# Dragonmaw Races
######
*/

enum DragonmawRaces
{
    QUEST_MUCKJAW           = 11064,
    QUEST_TROPE             = 11067,
    QUEST_CORLOK            = 11068,
    QUEST_ICHMAN            = 11069,
    QUEST_MULVERICK         = 11070,
    QUEST_SKYSHATTER        = 11071,

    NPC_MUCKJAW             = 23340,
    NPC_TROPE               = 23342,
    NPC_CORLOK              = 23344,
    NPC_ICHMAN              = 23345,
    NPC_MULVERICK           = 23346,
    NPC_SKYSHATTER          = 23348,

    PATH_MUCKJAW            = 233401,
    PATH_TROPE              = 233421,
    PATH_CORLOK             = 233441,
    PATH_ICHMAN             = 233451,
    PATH_MULVERICK          = 233461,
    PATH_SKYSHATTER         = 233481,

    NPC_TARGET_MUCKJAW      = 23356,
    NPC_TARGET_TROPE        = 23357,
    NPC_TARGET_CORLOK       = 23358,
    NPC_TARGET_ICHMAN       = 23359,
    NPC_TARGET_MULVERICK    = 23360,
    NPC_TARGET_SKYSHATTER   = 23361,

    SAY_START               = 0,
    SAY_COMPLETE            = 1,
    SAY_SKYSHATTER_SPECIAL  = 2,
};

struct dragonmaw_race_npc : public ScriptedAI
{
    dragonmaw_race_npc(Creature* creature) : ScriptedAI(creature)
    {
        _player = nullptr;
    }

    void Reset() override
    {
        scheduler.CancelAll();
        me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
        me->SetWalk(true);
        me->SetDisableGravity(false);
        me->GetMotionMaster()->MoveIdle();
    }

    void sQuestAccept(Player* player, Quest const* /*quest*/) override
    {
        _player = player;
        me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
        if (_player)
            Talk(SAY_START, _player);

        switch (me->GetEntry())
        {
        case NPC_MUCKJAW:
            me->GetMotionMaster()->MovePath(PATH_MUCKJAW, false);
            break;
        case NPC_TROPE:
            me->GetMotionMaster()->MovePath(PATH_TROPE, false);
            break;
        case NPC_CORLOK:
            me->GetMotionMaster()->MovePath(PATH_CORLOK, false);
            break;
        case NPC_ICHMAN:
            me->GetMotionMaster()->MovePath(PATH_ICHMAN, false);
            break;
        case NPC_MULVERICK:
            me->GetMotionMaster()->MovePath(PATH_MULVERICK, false);
            break;
        case NPC_SKYSHATTER:
            me->GetMotionMaster()->MovePath(PATH_SKYSHATTER, false);
            break;
        default:
            break;
        }
    }

    void TakeOff()
    {
        me->SetDisableGravity(true);
    }

    void StartRace()
    {
        me->SetWalk(false);
        ScheduleTimedEvent(5s, [&]
        {
            if (!_player)
                FailQuest();
            else if (!me->IsWithinDist(_player, 100.f))
                FailQuest();
        }, 5s);
    }

    void FailQuest()
    {
        if (_player)
        {
            switch (me->GetEntry())
            {
            case NPC_MUCKJAW:
                _player->FailQuest(QUEST_MUCKJAW);
                break;
            case NPC_TROPE:
                _player->FailQuest(QUEST_TROPE);
                break;
            case NPC_CORLOK:
                _player->FailQuest(QUEST_CORLOK);
                break;
            case NPC_ICHMAN:
                _player->FailQuest(QUEST_ICHMAN);
                break;
            case NPC_MULVERICK:
                _player->FailQuest(QUEST_MULVERICK);
                break;
            case NPC_SKYSHATTER:
                _player->FailQuest(QUEST_SKYSHATTER);
                break;
            default:
                break;
            }
        }
        scheduler.CancelAll();
        me->DespawnOnEvade();
    }

    void StartRaceAttacks()
    {
        /*
        * Timers are placeholders
        * After spawned, the rest is done via SmartAI
        */
        if (!_player)
            return;

        switch (me->GetEntry())
        {
        case NPC_MUCKJAW:
            ScheduleTimedEvent(4s, [&]
            {
                if (_player)
                {
                    Position summonPos;
                    summonPos = me->GetRandomPoint(_player->GetPosition(), 15.f);
                    summonPos.m_positionZ = _player->GetPositionZ();  // So they don't spawn at ground height
                    me->SummonCreature(NPC_TARGET_MUCKJAW, summonPos, TEMPSUMMON_TIMED_DESPAWN, 10000);
                }
                else
                    return;
            }, 4s, 8s);
            break;
        case NPC_TROPE:
            ScheduleTimedEvent(4s, [&]
            {
                    if (_player)
                    {
                        Position summonPos;
                        summonPos = me->GetRandomPoint(_player->GetPosition(), 10.f);
                        summonPos.m_positionZ = _player->GetPositionZ();
                        me->SummonCreature(NPC_TARGET_TROPE, summonPos, TEMPSUMMON_TIMED_DESPAWN, 10000);
                    }
                    else
                        return;
            }, 1s, 3s);
            break;
        case NPC_CORLOK:
            ScheduleTimedEvent(4s, [&]
            {
                    if (_player)
                    {
                        Position summonPos;
                        summonPos = me->GetRandomPoint(_player->GetPosition(), 10.f);
                        summonPos.m_positionZ = _player->GetPositionZ();
                        me->SummonCreature(NPC_TARGET_CORLOK, summonPos, TEMPSUMMON_TIMED_DESPAWN, 10000);
                    }
                    else
                        return;
            }, 1s, 3s);
            break;
        case NPC_ICHMAN:
            ScheduleTimedEvent(4s, [&]
            {
                    if (_player)
                    {
                        Position summonPos;
                        summonPos = me->GetRandomPoint(_player->GetPosition(), 10.f);
                        summonPos.m_positionZ = _player->GetPositionZ();
                        me->SummonCreature(NPC_TARGET_ICHMAN, summonPos, TEMPSUMMON_TIMED_DESPAWN, 10000);
                    }
                    else
                        return;
            }, 1s, 3s);
            break;
        case NPC_MULVERICK:
            ScheduleTimedEvent(4s, [&]
            {
                    if (_player)
                    {
                        Position summonPos;
                        summonPos = me->GetRandomPoint(_player->GetPosition(), 10.f);
                        summonPos.m_positionZ = _player->GetPositionZ();
                        me->SummonCreature(NPC_TARGET_MULVERICK, summonPos, TEMPSUMMON_TIMED_DESPAWN, 10000);
                    }
                    else
                        return;
            }, 1s, 3s);
            break;
        case NPC_SKYSHATTER:
            ScheduleTimedEvent(4s, [&]
            {
                    if (_player)
                    {
                        Position summonPos;
                        summonPos = me->GetRandomPoint(_player->GetPosition(), 7.f);
                        summonPos.m_positionZ = _player->GetPositionZ();  // So they don't spawn at ground height
                        me->SummonCreature(NPC_TARGET_SKYSHATTER, summonPos, TEMPSUMMON_TIMED_DESPAWN, 10000);
                    }
                    else
                        return;
            }, 1s, 3s);
            break;
        default:
            break;
        }
    }

    void FinishRace()
    {
        scheduler.CancelAll();
        me->SetHover(false);
        me->SetDisableGravity(false);
        me->SetWalk(true);

        if (_player)
        {
            Talk(SAY_COMPLETE, _player);
            switch (me->GetEntry())
            {
            case NPC_MUCKJAW:
                _player->AreaExploredOrEventHappens(QUEST_MUCKJAW);
                break;
            case NPC_TROPE:
                _player->AreaExploredOrEventHappens(QUEST_TROPE);
                break;
            case NPC_CORLOK:
                _player->AreaExploredOrEventHappens(QUEST_CORLOK);
                break;
            case NPC_ICHMAN:
                _player->AreaExploredOrEventHappens(QUEST_ICHMAN);
                break;
            case NPC_MULVERICK:
                _player->AreaExploredOrEventHappens(QUEST_MULVERICK);
                break;
            case NPC_SKYSHATTER:
                _player->AreaExploredOrEventHappens(QUEST_SKYSHATTER);
                break;
            default:
                break;
            }
        }
    }

    void MovementInform(uint32 /*type*/, uint32 id) override
    {
        switch (me->GetEntry())
        {
        case NPC_MUCKJAW:
            switch (id)
            {
            case 4:
                TakeOff();
                break;
            case 7:
                StartRace();
                break;
            case 9:
                StartRaceAttacks();
                break;
            case 35:
                FinishRace();
                break;
            case 37:
                Reset();
                break;
            }
            break;
        case NPC_TROPE:
            switch (id)
            {
            case 5:
                TakeOff();
                break;
            case 7:
                StartRace();
                break;
            case 10:
                StartRaceAttacks();
                break;
            case 53:
                FinishRace();
                break;
            case 60:
                Reset();
                break;
            }
            break;
        case NPC_CORLOK:
            switch (id)
            {
            case 6:
                TakeOff();
                break;
            case 9:
                StartRace();
                break;
            case 12:
                StartRaceAttacks();
                break;
            case 79:
                FinishRace();
                break;
            case 89:
                Reset();
                break;
            }
            break;
        case NPC_ICHMAN:
            switch (id)
            {
            case 4:
                TakeOff();
                StartRace();
                break;
            case 12:
                StartRaceAttacks();
                break;
            case 107:
                FinishRace();
                break;
            case 111:
                Reset();
                break;
            }
            break;
        case NPC_MULVERICK:
            switch (id)
            {
            case 5:
                TakeOff();
                break;
            case 9:
                StartRace();
                break;
            case 12:
                StartRaceAttacks();
                break;
            case 166:
                FinishRace();
                break;
            case 172:
                Reset();
                break;
            }
            break;
        case NPC_SKYSHATTER:
            switch (id)
            {
            case 3:
                TakeOff();
                break;
            case 7:
                StartRace();
                if (_player)
                    Talk(SAY_SKYSHATTER_SPECIAL, _player);
                break;
            case 10:
                StartRaceAttacks();
                break;
            case 140:
                FinishRace();
                break;
            case 145:
                Reset();
                break;
            }
            break;
        default:
            break;
        }
    }

    void PathEndReached(uint32 /*pathId*/) override
    {
        Reset();
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

    private:
        Player* _player;
};

void AddSC_shadowmoon_valley()
{
    // Ours
    RegisterSpellScript(spell_q10612_10613_the_fel_and_the_furious);
    RegisterSpellScript(spell_q10563_q10596_to_legion_hold_aura);

    // Theirs
    RegisterCreatureAI(dragonmaw_race_npc);
    new npc_invis_infernal_caster();
    new npc_infernal_attacker();
    new npc_mature_netherwing_drake();
    RegisterCreatureAI(npc_enslaved_netherwing_drake);
    new npc_dragonmaw_peon();
    new npc_drake_dealer_hurlunk();
    new npcs_flanis_swiftwing_and_kagrosh();
    new npc_karynaku();
    new npc_lord_illidan_stormrage();
    new go_crystal_prison();
    new npc_illidari_spawn();
    new npc_torloth_the_magnificent();
    new npc_enraged_spirit();
    new npc_shadowmoon_tuber_node();
    RegisterCreatureAI(npc_korkron_or_wildhammer);
    RegisterSpellScript(spell_calling_korkron_or_wildhammer);
    RegisterSpellScript(spell_disrupt_summoning_ritual);
}
