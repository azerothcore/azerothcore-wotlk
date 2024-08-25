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
#include "CreatureTextMgr.h"
#include "Group.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_gen_".
 */

enum soulTrader
{
    SPELL_STEAL_ESSENCE_VISUAL          = 50101,
    SPELL_CREATE_TOKEN                  = 50063,
    SPELL_PROC_TRIGGER_ON_KILL_AURA     = 50051,
    SPELL_OWNER_KILLED_INFORM           = 50050,
    SPELL_EMOTE_STATE_SWIM_RUN          = 47127,

    EVENT_INITIAL_TALK                  = 1,
    EVENT_ADD_TOKEN                     = 2
};

struct npc_pet_gen_soul_trader_beacon : public ScriptedAI
{
    ObjectGuid ownerGUID;
    EventMap events;
    npc_pet_gen_soul_trader_beacon(Creature* c) : ScriptedAI(c)
    {
        events.Reset();
        events.ScheduleEvent(EVENT_INITIAL_TALK, 0);
        if (me->ToTempSummon())
            if (Unit* owner = me->ToTempSummon()->GetOwner())
            {
                owner->CastSpell(owner, SPELL_PROC_TRIGGER_ON_KILL_AURA, true);
                ownerGUID = owner->GetGUID();
            }
    }

    Player* GetOwner() const { return ObjectAccessor::GetPlayer(*me, ownerGUID); }

    void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_STEAL_ESSENCE_VISUAL && target == me)
        {
            Talk(1);
            events.ScheduleEvent(EVENT_ADD_TOKEN, 3000);
            me->CastSpell(me, SPELL_EMOTE_STATE_SWIM_RUN, true);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        switch (events.ExecuteEvent())
        {
            case EVENT_INITIAL_TALK:
                Talk(0);
                break;
            case EVENT_ADD_TOKEN:
                me->RemoveAurasDueToSpell(SPELL_EMOTE_STATE_SWIM_RUN);
                me->CastSpell(me, SPELL_CREATE_TOKEN, true);
                Talk(2);
                break;
        }
    }
};

enum eArgentPony
{
    ARGENT_PONY_STATE_NONE          = 0,
    ARGENT_PONY_STATE_ENCH          = 1,
    ARGENT_PONY_STATE_VENDOR        = 2,
    ARGENT_PONY_STATE_BANK          = 3,
    ARGENT_PONY_STATE_MAILBOX       = 4,

    SPELL_PONY_MOUNT                = 16083,

    SPELL_AURA_POSTMAN_S            = 67376,
    SPELL_AURA_SHOP_S               = 67377,
    SPELL_AURA_BANK_S               = 67368,
    SPELL_AURA_TIRED_S              = 67401,

    SPELL_AURA_BANK_G               = 68849,
    SPELL_AURA_POSTMAN_G            = 68850,
    SPELL_AURA_SHOP_G               = 68851,
    SPELL_AURA_TIRED_G              = 68852,

    ACHIEVEMENT_PONY_UP             = 3736,

    GOSSIP_ACTION_MAILBOX           = 1001,

    NPC_ARGENT_SQUIRE               = 33238,
    NPC_ARGENT_GRUNTLING            = 33239,
};

static uint32 argentPonyService[2][3] =
{
    {ARGENT_PONY_STATE_MAILBOX, ARGENT_PONY_STATE_VENDOR, ARGENT_PONY_STATE_BANK},
    {ARGENT_PONY_STATE_BANK, ARGENT_PONY_STATE_MAILBOX, ARGENT_PONY_STATE_VENDOR}
};

struct argentPonyBanner
{
    uint32 achievement;
    uint32 spell;
    const char* text;
};

static argentPonyBanner argentBanners[MAX_RACES] =
{
    {0, 0, ""},
    {2781, 62594, "Stormwind Champion's Pennant"},
    {2783, 63433, "Orgrimmar Champion's Pennant"},
    {2780, 63427, "Ironforge Champion's Pennant"},
    {2777, 63406, "Darnassus Champion's Pennant"},
    {2787, 63430, "Forsaken Champion's Pennant"},
    {2786, 63436, "Thunder Bluff Champion's Pennant"},
    {2779, 63396, "Gnomeregan Champion's Pennant"},
    {2784, 63399, "Darkspear Champion's Pennant"},
    {0, 0, ""},
    {2785, 63403, "Silvermoon Champion's Pennant"},
    {2778, 63423, "Exodar Champion's Pennant"}
};

struct npc_pet_gen_argent_pony_bridle : public ScriptedAI
{
    npc_pet_gen_argent_pony_bridle(Creature* c) : ScriptedAI(c)
    {
        _state = ARGENT_PONY_STATE_NONE;
        _init = false;
        _mountTimer = 4000;
        _lastAura = 0;
        memset(_banners, 0, sizeof(_banners));
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        if (Unit* owner = me->GetCharmerOrOwner())
        {
            me->GetMotionMaster()->Clear(false);
            me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle(), MOTION_SLOT_ACTIVE);
        }
    }

    void Reset() override
    {
        if (_init)
            return;

        _init = true;
        uint32 duration = 0;
        uint32 aura = 0;
        me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);

        if (Unit* owner = me->GetCharmerOrOwner())
            if (Player* player = owner->ToPlayer())
                if (player->HasAchieved(ACHIEVEMENT_PONY_UP))
                {
                    _state = ARGENT_PONY_STATE_ENCH;

                    aura = (player->GetTeamId(true) == TEAM_ALLIANCE ? SPELL_AURA_TIRED_S : SPELL_AURA_TIRED_G);
                    duration = player->GetSpellCooldownDelay(aura);
                    me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP);

                    for (uint8 i = 0; i < 3; ++i)
                    {
                        if (player->GetTeamId(true) == TEAM_ALLIANCE)
                        {
                            if (uint32 cooldown = player->GetSpellCooldownDelay(SPELL_AURA_POSTMAN_S + i))
                            {
                                duration = cooldown;
                                aura = SPELL_AURA_POSTMAN_S + i;
                                _state = argentPonyService[TEAM_ALLIANCE][i];
                                me->ToTempSummon()->UnSummon(duration);
                                break;
                            }
                        }
                        else
                        {
                            if (uint32 cooldown = player->GetSpellCooldownDelay(SPELL_AURA_BANK_G + i))
                            {
                                duration = cooldown * IN_MILLISECONDS;
                                aura = SPELL_AURA_BANK_G + i;
                                _state = argentPonyService[TEAM_HORDE][i];
                                me->ToTempSummon()->UnSummon(duration);
                                break;
                            }
                        }
                    }

                    // Generate Banners
                    uint32 mask = player->GetTeamId(true) ? RACEMASK_HORDE : RACEMASK_ALLIANCE;
                    for (uint8 i = 1; i < MAX_RACES; ++i)
                        if (mask & (1 << (i - 1)) && player->HasAchieved(argentBanners[i].achievement))
                            _banners[i] = true;
                }

        if (duration && aura)
        {
            if (Aura* aur = me->AddAura(aura, me))
                aur->SetDuration(duration);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        _mountTimer += diff;
        if (_mountTimer > 5000)
        {
            _mountTimer = 0;
            if (_state == ARGENT_PONY_STATE_NONE)
                me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            else if (Unit* owner = me->GetCharmerOrOwner())
            {
                if (owner->IsMounted() && !me->IsMounted())
                    me->CastSpell(me, SPELL_PONY_MOUNT, false);
                else if (!owner->IsMounted() && me->IsMounted())
                    me->RemoveAurasDueToSpell(SPELL_PONY_MOUNT);
            }
        }
    }

    uint32 GetData(uint32 param) const override
    {
        if (param == 0)
            return _state;

        return _banners[param];
    }

    void DoAction(int32 param) override
    {
        if (param > 60000)
        {
            if (_lastAura)
                me->RemoveAurasDueToSpell(_lastAura);
            _lastAura = param;
            return;
        }

        _state = param;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetGUID() != creature->GetOwnerGUID())
            return true;

        if (!creature->HasAura(player->GetTeamId(true) ? SPELL_AURA_TIRED_G : SPELL_AURA_TIRED_S))
        {
            uint8 _state = creature->AI()->GetData(0 /*GET_DATA_STATE*/);
            if (_state == ARGENT_PONY_STATE_ENCH || _state == ARGENT_PONY_STATE_VENDOR)
                AddGossipItemFor(player, GOSSIP_ICON_VENDOR, "Visit a trader.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
            if (_state == ARGENT_PONY_STATE_ENCH || _state == ARGENT_PONY_STATE_BANK)
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "Visit a bank.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_BANK);
            if (_state == ARGENT_PONY_STATE_ENCH || _state == ARGENT_PONY_STATE_MAILBOX)
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Visit a mailbox.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_MAILBOX);
        }

        for (uint8 i = RACE_HUMAN; i < MAX_RACES; ++i)
            if (creature->AI()->GetData(i) == uint32(true))
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, argentBanners[i].text, GOSSIP_SENDER_MAIN, argentBanners[i].spell);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 action)
    {
        CloseGossipMenuFor(player);
        uint32 spellId = 0;
        switch (action)
        {
            case GOSSIP_ACTION_TRADE:
                creature->ReplaceAllNpcFlags(UNIT_NPC_FLAG_VENDOR);
                player->GetSession()->SendListInventory(creature->GetGUID());
                spellId = player->GetTeamId(true) ? SPELL_AURA_SHOP_G : SPELL_AURA_SHOP_S;
                creature->AI()->DoAction(ARGENT_PONY_STATE_VENDOR);
                break;
            case GOSSIP_ACTION_BANK:
                creature->ReplaceAllNpcFlags(UNIT_NPC_FLAG_BANKER);
                player->GetSession()->SendShowBank(player->GetGUID());
                spellId = player->GetTeamId(true) ? SPELL_AURA_BANK_G : SPELL_AURA_BANK_S;
                creature->AI()->DoAction(ARGENT_PONY_STATE_BANK);
                break;
            case GOSSIP_ACTION_MAILBOX:
                {
                    creature->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_MAILBOX);
                    player->GetSession()->SendShowMailBox(creature->GetGUID());
                    spellId = player->GetTeamId(true) ? SPELL_AURA_POSTMAN_G : SPELL_AURA_POSTMAN_S;
                    creature->AI()->DoAction(ARGENT_PONY_STATE_MAILBOX);
                    break;
                }
            default:
                if (action > 60000)
                {
                    creature->AI()->DoAction(action);
                    creature->CastSpell(creature, action, true);
                }
                return true;
        }

        if (spellId && !creature->HasAura(spellId))
        {
            creature->CastSpell(creature, spellId, true);
            player->AddSpellCooldown(spellId, 0, 3 * MINUTE * IN_MILLISECONDS);
            player->AddSpellCooldown(player->GetTeamId(true) ? SPELL_AURA_TIRED_G : SPELL_AURA_TIRED_S, 0, 3 * MINUTE * IN_MILLISECONDS + 4 * HOUR * IN_MILLISECONDS);
            creature->DespawnOrUnsummon(3 * MINUTE * IN_MILLISECONDS);
        }
        return true;
    }

private:
    bool _init;
    uint8 _state;
    int32 _mountTimer;
    bool _banners[MAX_RACES];
    uint32 _lastAura;
};

enum eTargetFollowingBomb
{
    NPC_EXPLOSIVE_SHEEP             = 2675,
    SPELL_EXPLOSIVE_SHEEP           = 4050,

    NPC_GOBLIN_BOMB                 = 8937,
    SPELL_EXPLOSIVE_GOBLIN          = 13259,

    NPC_HIGH_EXPLOSIVE_SHEEP        = 24715,
    SPELL_HIGH_EXPLOSIVE_SHEEP      = 44279,
};

struct npc_pet_gen_target_following_bomb : public NullCreatureAI
{
    npc_pet_gen_target_following_bomb(Creature* c) : NullCreatureAI(c)
    {
        checkTimer = 0;
        bombSpellId = 0;

        switch (me->GetEntry())
        {
            case NPC_EXPLOSIVE_SHEEP:
                bombSpellId = SPELL_EXPLOSIVE_SHEEP;
                break;
            case NPC_GOBLIN_BOMB:
                bombSpellId = SPELL_EXPLOSIVE_GOBLIN;
                break;
            case NPC_HIGH_EXPLOSIVE_SHEEP:
                bombSpellId = SPELL_HIGH_EXPLOSIVE_SHEEP;
                break;
        }
    }

    uint32 bombSpellId;
    uint32 checkTimer;

    void UpdateAI(uint32 diff) override
    {
        checkTimer += diff;
        if (checkTimer >= 1000)
        {
            checkTimer = 0;
            if (Unit* target = me->SelectNearestTarget(30.0f))
            {
                me->GetMotionMaster()->MoveFollow(target, 0.f, 0.f);
                if (me->GetDistance(target) < 3.0f)
                {
                    me->CastSpell(me, bombSpellId, false);
                    me->DespawnOrUnsummon(500);
                }
            }
            else if (!me->HasUnitState(UNIT_STATE_FOLLOW))
            {
                if (Unit* owner = me->GetCharmerOrOwner())
                {
                    me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                }
            }
        }
    }
};

struct npc_pet_gen_gnomish_flame_turret : public ScriptedAI
{
    npc_pet_gen_gnomish_flame_turret(Creature* c) : ScriptedAI(c)
    {
        checkTimer = 0;
    }

    uint32 checkTimer;

    void Reset() override
    {
        me->GetMotionMaster()->Clear(false);
    }

    void AttackStart(Unit* who) override
    {
        if (!who)
            return;

        if (me->Attack(who, false))
            DoStartNoMovement(who);
    }

    void UpdateAI(uint32  /*diff*/) override
    {
        if (!me->GetVictim())
            return;

        if (Unit* target = me->SelectVictim())
        {
            AttackStart(target);
            DoSpellAttackIfReady(me->m_spells[0]);
        }
    }
};

struct npc_pet_gen_valkyr_guardian : public ScriptedAI
{
    npc_pet_gen_valkyr_guardian(Creature* c) : ScriptedAI(c)
    {
        me->SetReactState(REACT_DEFENSIVE);
        me->SetDisableGravity(true);
        me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
        targetCheck = 0;
    }

    uint32 targetCheck;

    void InitializeAI() override
    {
        if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
            if (Unit* target = owner->GetSelectedUnit())
                if (!owner->IsFriendlyTo(target))
                    AttackStart(target);
    }

    void OwnerAttacked(Unit* target) override
    {
        if (!target || (me->GetVictim() && me->GetVictim()->IsAlive() && !me->GetVictim()->HasBreakableByDamageCrowdControlAura()))
            return;

        AttackStart(target);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            targetCheck += diff;
            if (targetCheck > 1000)
            {
                targetCheck = 0;
                if (Unit* owner = me->GetCharmerOrOwner())
                    if (Unit* ownerVictim = owner->GetVictim())
                        if (!ownerVictim->HasBreakableByDamageCrowdControlAura())
                            AttackStart(ownerVictim);
            }
            return;
        }

        if (me->isAttackReady() && !me->GetVictim()->HasBreakableByDamageCrowdControlAura())
            DoSpellAttackIfReady(me->GetCreatureTemplate()->spells[0]);
    }
};

class spell_pet_gen_valkyr_guardian_smite : public SpellScript
{
    PrepareSpellScript(spell_pet_gen_valkyr_guardian_smite);

    void RecalculateDamage()
    {
        if (GetHitUnit() != GetCaster())
        {
            std::list<TargetInfo>* targetsInfo = GetSpell()->GetUniqueTargetInfo();
            for (std::list<TargetInfo>::iterator ihit = targetsInfo->begin(); ihit != targetsInfo->end(); ++ihit)
                if (ihit->targetGUID == GetCaster()->GetGUID())
                    ihit->damage = -int32(GetHitDamage() * 0.25f);
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_pet_gen_valkyr_guardian_smite::RecalculateDamage);
    }
};

struct npc_pet_gen_imp_in_a_bottle : public NullCreatureAI
{
    npc_pet_gen_imp_in_a_bottle(Creature* c) : NullCreatureAI(c)
    {
        _talkTimer = 0;
        _ownerGUID.Clear();
        _hasParty = false;
    }

    WorldPacket _data;
    uint32 _talkTimer;
    ObjectGuid _ownerGUID;
    bool _hasParty;

    void InitializeAI() override
    {
        NullCreatureAI::InitializeAI();

        if (TempSummon* summon = me->ToTempSummon())
            if (Unit* owner = summon->GetSummonerUnit())
                if (owner->GetTypeId() == TYPEID_PLAYER)
                {
                    _ownerGUID = owner->GetGUID();
                    if (owner->ToPlayer()->GetGroup())
                    {
                        _hasParty = true;
                        std::string const& text = sCreatureTextMgr->GetLocalizedChatString(me->GetEntry(), 0, 0 /*text group*/, urand(0, 60) /*text id*/, LOCALE_enUS);

                        _data.Initialize(SMSG_MESSAGECHAT, 200);                // guess size
                        _data << uint8(CHAT_MSG_MONSTER_PARTY);
                        _data << uint32(LANG_UNIVERSAL);
                        _data << me->GetGUID();
                        _data << uint32(0);
                        _data << uint32(me->GetName().size() + 1);
                        _data << me->GetName();
                        _data << uint64(0);
                        _data << uint32(text.size() + 1);
                        _data << text.c_str();
                        _data << uint8(0);
                    }
                }
    }

    void UpdateAI(uint32 diff) override
    {
        _talkTimer += diff;
        if (_talkTimer >= 5000)
        {
            _talkTimer = 0;
            me->DespawnOrUnsummon(1);
            if (!_hasParty)
                Talk(0, ObjectAccessor::GetPlayer(*me, _ownerGUID));
            else if (Player* player = ObjectAccessor::GetPlayer(*me, _ownerGUID))
            {
                uint8 limit = 0;
                if (player->GetGroup())
                    for (GroupReference* itr = player->GetGroup()->GetFirstMember(); itr != nullptr && limit < 4; itr = itr->next(), ++limit)
                        if (Player* groupPlayer = itr->GetSource())
                            if (groupPlayer != player)
                                groupPlayer->GetSession()->SendPacket(&_data);

                player->GetSession()->SendPacket(&_data);
            }
        }
    }
};

struct npc_pet_gen_wind_rider_cub : public NullCreatureAI
{
    npc_pet_gen_wind_rider_cub(Creature* c) : NullCreatureAI(c)
    {
        isFlying = true;
        checkTimer = 0;
        checkTimer2 = 2000;
        me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
    }

    bool isFlying;
    uint32 checkTimer;
    uint32 checkTimer2;

    void UpdateAI(uint32 diff) override
    {
        checkTimer2 += diff;
        if (checkTimer2 > 2000)
        {
            checkTimer2 = 0;
            if (Unit* owner = me->GetOwner())
            {
                if (owner->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) || owner->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED))
                {
                    isFlying = true;
                    me->SetCanFly(true);
                    me->SetDisableGravity(true);
                }
                else if (isFlying)
                {
                    isFlying = false;
                    me->SetCanFly(false);
                    me->SetDisableGravity(false);
                    me->GetMotionMaster()->MoveFall();
                }
            }
        }
    }
};

enum turkey
{
    GO_BASIC_CAMPFIRE           = 29784,
    SPELL_TURKEY_STARTS_TO_BURN = 61768,
};

struct npc_pet_gen_plump_turkey : public PassiveAI
{
    npc_pet_gen_plump_turkey(Creature* c) : PassiveAI(c)
    {
        goGUID.Clear();
        jumpTimer = 0;
        checkTimer = 0;
        jumping = false;
    }

    ObjectGuid goGUID;
    uint32 jumpTimer;
    uint32 checkTimer;
    bool jumping;

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == EFFECT_MOTION_TYPE && id == 1)
        {
            me->KillSelf();
            me->AddAura(SPELL_TURKEY_STARTS_TO_BURN, me);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (jumping)
            return;

        if (jumpTimer)
        {
            jumpTimer += diff;
            if (jumpTimer >= 2000)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(goGUID))
                    me->GetMotionMaster()->MoveJump(*go, 5.0f, 10.0f, 1);
                jumping = true;
            }
            return;
        }

        checkTimer += diff;
        if (checkTimer > 3000)
        {
            checkTimer = 0;
            if (GameObject* go = me->FindNearestGameObject(GO_BASIC_CAMPFIRE, 7.0f))
            {
                goGUID = go->GetGUID();
                me->StopMoving();
                me->GetMotionMaster()->Clear(false);
                me->SetFacingTo(me->GetAngle(go));
                Talk(0);
                jumpTimer = 1;
            }
        }
    }
};

struct npc_pet_gen_toxic_wasteling : public PassiveAI
{
    npc_pet_gen_toxic_wasteling(Creature* c) : PassiveAI(c)
    {
    }

    uint32 checkTimer;

    void Reset() override { checkTimer = 3000; }

    void EnterEvadeMode(EvadeReason /*why*/) override {}

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == EFFECT_MOTION_TYPE && id == 1)
            checkTimer = 1;
    }

    void UpdateAI(uint32 diff) override
    {
        if (checkTimer)
        {
            if (checkTimer == 1)
                me->GetMotionMaster()->MovementExpired(false);
            checkTimer += diff;
            if (checkTimer >= 3000)
            {
                if (Unit* owner = me->GetCharmerOrOwner())
                {
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle(), MOTION_SLOT_ACTIVE);
                }
                me->AddAura(71854, me); // Growth
                checkTimer = 0;
            }
        }
    }
};

enum FetchBall
{
    SPELL_PET_TOY_FETCH_BALL_COME_HERE = 48649,
    SPELL_PET_TOY_FETCH_BALL_HAS_BALL  = 48708
};

struct npc_pet_gen_fetch_ball : public NullCreatureAI
{
    npc_pet_gen_fetch_ball(Creature* c) : NullCreatureAI(c) { }

    uint32 checkTimer;
    ObjectGuid targetGUID;

    void IsSummonedBy(WorldObject* summoner) override
    {
        if (!summoner)
            return;

        me->SetOwnerGUID(summoner->GetGUID());
        checkTimer = 0;
        targetGUID.Clear();
        me->CastSpell(me, SPELL_PET_TOY_FETCH_BALL_COME_HERE, true);
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_PET_TOY_FETCH_BALL_COME_HERE)
        {
            target->GetMotionMaster()->MovePoint(50, me->GetHomePosition());
            targetGUID = target->GetGUID();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        checkTimer += diff;
        if (checkTimer >= 1000)
        {
            checkTimer = 0;
            if (Creature* target = ObjectAccessor::GetCreature(*me, targetGUID))
                if (me->GetDistance2d(target) < 2.0f)
                {
                    target->AI()->EnterEvadeMode();
                    target->CastSpell(target, SPELL_PET_TOY_FETCH_BALL_HAS_BALL, true);
                    me->DespawnOrUnsummon();
                }
        }
    }
};

struct npc_pet_gen_moth : public NullCreatureAI
{
    npc_pet_gen_moth(Creature* c) : NullCreatureAI(c)
    {
        me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
        me->SetCanFly(true);
        me->SetDisableGravity(true);
    }
};

// Darting Hatchling
enum Darting
{
    SPELL_DARTING_ON_SPAWN      = 62586, // Applied on spawn via creature_template_addon
    SPELL_DARTING_FEAR          = 62585, // Applied every 20s from SPELL_DARTING_ON_SPAWN
};

struct npc_pet_darting_hatchling : public NullCreatureAI
{
    npc_pet_darting_hatchling(Creature* c) : NullCreatureAI(c)
    {
        goFast = false;
        checkTimer = 0;
    }

    bool goFast;
    uint32 checkTimer;

    void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_DARTING_FEAR)
        {
            goFast = true;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!goFast)
        {
            return;
        }

        checkTimer += diff;
        if (checkTimer >= 2000)
        {
            me->RemoveAurasDueToSpell(SPELL_DARTING_FEAR);
            checkTimer = 0;
            goFast = false;
        }
    }
};

void AddSC_generic_pet_scripts()
{
    RegisterCreatureAI(npc_pet_gen_soul_trader_beacon);
    RegisterCreatureAI(npc_pet_gen_argent_pony_bridle);
    RegisterCreatureAI(npc_pet_gen_target_following_bomb);
    RegisterCreatureAI(npc_pet_gen_gnomish_flame_turret);
    RegisterCreatureAI(npc_pet_gen_valkyr_guardian);
    RegisterSpellScript(spell_pet_gen_valkyr_guardian_smite);
    RegisterCreatureAI(npc_pet_gen_imp_in_a_bottle);
    RegisterCreatureAI(npc_pet_gen_wind_rider_cub);
    RegisterCreatureAI(npc_pet_gen_plump_turkey);
    RegisterCreatureAI(npc_pet_gen_toxic_wasteling);
    RegisterCreatureAI(npc_pet_gen_fetch_ball);
    RegisterCreatureAI(npc_pet_gen_moth);
    RegisterCreatureAI(npc_pet_darting_hatchling);
}
