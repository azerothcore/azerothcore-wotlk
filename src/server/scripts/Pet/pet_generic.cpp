/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_gen_".
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"
#include "Group.h"
#include "CreatureTextMgr.h"
#include "PetAI.h"
#include "PassiveAI.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellAuras.h"

enum Mojo
{
    SAY_MOJO                = 0,

    SPELL_FEELING_FROGGY    = 43906,
    SPELL_SEDUCTION_VISUAL  = 43919
};

class npc_pet_gen_mojo : public CreatureScript
{
    public:
        npc_pet_gen_mojo() : CreatureScript("npc_pet_gen_mojo") { }

        struct npc_pet_gen_mojoAI : public ScriptedAI
        {
            npc_pet_gen_mojoAI(Creature* creature) : ScriptedAI(creature) { }

            void Reset()
            {
                _victimGUID = 0;

                if (Unit* owner = me->GetOwner())
                    me->GetMotionMaster()->MoveFollow(owner, 0.0f, 0.0f);
            }

            void EnterCombat(Unit* /*who*/) { }
            void UpdateAI(uint32 /*diff*/) { }

            void ReceiveEmote(Player* player, uint32 emote)
            {
                me->HandleEmoteCommand(emote);
                Unit* owner = me->GetOwner();
                if (emote != TEXT_EMOTE_KISS || !owner || owner->GetTypeId() != TYPEID_PLAYER ||
                    owner->ToPlayer()->GetTeamId(true) != player->GetTeamId(true))
                {
                    return;
                }

                Talk(SAY_MOJO, player);

                if (_victimGUID)
                    if (Player* victim = ObjectAccessor::GetPlayer(*me, _victimGUID))
                        victim->RemoveAura(SPELL_FEELING_FROGGY);

                _victimGUID = player->GetGUID();

                DoCast(player, SPELL_FEELING_FROGGY, true);
                DoCast(me, SPELL_SEDUCTION_VISUAL, true);
                me->GetMotionMaster()->MoveFollow(player, 0.0f, 0.0f);
            }

        private:
            uint64 _victimGUID;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_pet_gen_mojoAI(creature);
        }
};

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

class npc_pet_gen_soul_trader_beacon : public CreatureScript
{
public:
    npc_pet_gen_soul_trader_beacon() : CreatureScript("npc_pet_gen_soul_trader_beacon") { }

    struct npc_pet_gen_soul_trader_beaconAI : public ScriptedAI
    {
        uint64 ownerGUID;
        EventMap events;
        npc_pet_gen_soul_trader_beaconAI(Creature *c) : ScriptedAI(c)
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

        void SpellHitTarget(Unit* target, const SpellInfo* spellInfo)
        {
            if (spellInfo->Id == SPELL_STEAL_ESSENCE_VISUAL && target == me)
            {
                Talk(1);
                events.ScheduleEvent(EVENT_ADD_TOKEN, 3000);
                me->CastSpell(me, SPELL_EMOTE_STATE_SWIM_RUN, true);
            }
        }

        void UpdateAI(uint32 diff)
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

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_pet_gen_soul_trader_beaconAI (creature);
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

class npc_pet_gen_argent_pony_bridle : public CreatureScript
{
public:
    npc_pet_gen_argent_pony_bridle() : CreatureScript("npc_pet_gen_argent_pony_bridle") { }

    struct npc_pet_gen_argent_pony_bridleAI : public ScriptedAI
    {
        npc_pet_gen_argent_pony_bridleAI(Creature *c) : ScriptedAI(c)
        {
            _state = ARGENT_PONY_STATE_NONE;
            _init = false;
            _mountTimer = 4000;
            _lastAura = 0;
            memset(_banners, 0, sizeof(_banners));
        }

        void EnterEvadeMode() override
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
            me->SetUInt32Value(UNIT_NPC_FLAGS, 0);

            if (Unit* owner = me->GetCharmerOrOwner())
                if (Player* player = owner->ToPlayer())
                    if (player->HasAchieved(ACHIEVEMENT_PONY_UP))
                    {
                        _state = ARGENT_PONY_STATE_ENCH;

                        aura = (player->GetTeamId(true) == TEAM_ALLIANCE ? SPELL_AURA_TIRED_S : SPELL_AURA_TIRED_G);
                        duration = player->GetSpellCooldownDelay(aura);
                        me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

                        for (uint8 i = 0; i < 3; ++i)
                        {
                            if (player->GetTeamId(true) == TEAM_ALLIANCE)
                            {
                                if (uint32 cooldown = player->GetSpellCooldownDelay(SPELL_AURA_POSTMAN_S+i))
                                {
                                    duration = cooldown;
                                    aura = SPELL_AURA_POSTMAN_S+i;
                                    _state = argentPonyService[TEAM_ALLIANCE][i];
                                    me->ToTempSummon()->UnSummon(duration);
                                    break;
                                }
                            }
                            else
                            {
                                if (uint32 cooldown = player->GetSpellCooldownDelay(SPELL_AURA_BANK_G+i))
                                {
                                    duration = cooldown*IN_MILLISECONDS;
                                    aura = SPELL_AURA_BANK_G+i;
                                    _state = argentPonyService[TEAM_HORDE][i];
                                    me->ToTempSummon()->UnSummon(duration);
                                    break;
                                }
                            }
                        }

                        // Generate Banners
                        uint32 mask = player->GetTeamId(true) ? RACEMASK_HORDE : RACEMASK_ALLIANCE;
                        for (uint8 i = 1; i < MAX_RACES; ++i)
                            if (mask & (1 << (i-1)) && player->HasAchieved(argentBanners[i].achievement))
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
                    me->SetUInt32Value(UNIT_NPC_FLAGS, 0);
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

        private:
            bool _init;
            uint8 _state;
            int32 _mountTimer;
            bool _banners[MAX_RACES];
            uint32 _lastAura;
    };

    bool OnGossipHello(Player* player, Creature* creature) override
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

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 action) override
    {
        CloseGossipMenuFor(player);
        uint32 spellId = 0;
        switch (action)
        {
            case GOSSIP_ACTION_TRADE:
                creature->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_VENDOR);
                player->GetSession()->SendListInventory(creature->GetGUID());
                spellId = player->GetTeamId(true) ? SPELL_AURA_SHOP_G : SPELL_AURA_SHOP_S;
                creature->AI()->DoAction(ARGENT_PONY_STATE_VENDOR);
                break;
            case GOSSIP_ACTION_BANK:
                creature->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_BANKER);
                player->GetSession()->SendShowBank(player->GetGUID());
                spellId = player->GetTeamId(true) ? SPELL_AURA_BANK_G : SPELL_AURA_BANK_S;
                creature->AI()->DoAction(ARGENT_PONY_STATE_BANK);
                break;
            case GOSSIP_ACTION_MAILBOX:
            {
                creature->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP|UNIT_NPC_FLAG_MAILBOX);
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
            player->AddSpellCooldown(spellId, 0, 3*MINUTE*IN_MILLISECONDS);
            player->AddSpellCooldown(player->GetTeamId(true) ? SPELL_AURA_TIRED_G : SPELL_AURA_TIRED_S, 0, 3*MINUTE*IN_MILLISECONDS + 4*HOUR*IN_MILLISECONDS);
            creature->DespawnOrUnsummon(3*MINUTE*IN_MILLISECONDS);
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_pet_gen_argent_pony_bridleAI (creature);
    }
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

class npc_pet_gen_target_following_bomb : public CreatureScript
{
public:
    npc_pet_gen_target_following_bomb() : CreatureScript("npc_pet_gen_target_following_bomb") { }

    struct npc_pet_gen_target_following_bombAI : public NullCreatureAI
    {
        npc_pet_gen_target_following_bombAI(Creature *c) : NullCreatureAI(c)
        {
            checkTimer = 0;
            bombSpellId = 0;

            switch (me->GetEntry())
            {
                case NPC_EXPLOSIVE_SHEEP:       bombSpellId = SPELL_EXPLOSIVE_SHEEP;  break;
                case NPC_GOBLIN_BOMB:           bombSpellId = SPELL_EXPLOSIVE_GOBLIN; break;
                case NPC_HIGH_EXPLOSIVE_SHEEP:  bombSpellId = SPELL_HIGH_EXPLOSIVE_SHEEP; break;
            }
        }

        uint32 bombSpellId;
        uint32 checkTimer;

        void UpdateAI(uint32 diff)
        {
            checkTimer += diff;
            if (checkTimer >= 1000)
            {
                checkTimer = 0;
                if (Unit* target = me->SelectNearestTarget(30.0f))
                {
                    me->GetMotionMaster()->MoveChase(target);
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_pet_gen_target_following_bombAI (pCreature);
    }
};

class npc_pet_gen_gnomish_flame_turret : public CreatureScript
{
public:
    npc_pet_gen_gnomish_flame_turret() : CreatureScript("npc_pet_gen_gnomish_flame_turret") { }

    struct npc_pet_gen_gnomish_flame_turretAI : public ScriptedAI
    {
        npc_pet_gen_gnomish_flame_turretAI(Creature *c) : ScriptedAI(c)
        {
            checkTimer = 0;
        }

        uint32 checkTimer;

        void Reset()
        {
            me->GetMotionMaster()->Clear(false);
        }

        void AttackStart(Unit* who)
        {
            if (!who)
                return;

            if (me->Attack(who, false))
                DoStartNoMovement(who);
        }

        void UpdateAI(uint32  /*diff*/)
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

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_pet_gen_gnomish_flame_turretAI (creature);
    }
};

class npc_pet_gen_valkyr_guardian : public CreatureScript
{
public:
    npc_pet_gen_valkyr_guardian() : CreatureScript("npc_pet_gen_valkyr_guardian") { }

    struct npc_pet_gen_valkyr_guardianAI : public ScriptedAI
    {
        npc_pet_gen_valkyr_guardianAI(Creature *c) : ScriptedAI(c)
        {
            me->SetReactState(REACT_DEFENSIVE);
            me->SetDisableGravity(true);
            me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
            targetCheck = 0;
        }

        uint32 targetCheck;

        void InitializeAI()
        {
            if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                if (Unit* target = owner->GetSelectedUnit())
                    if (!owner->IsFriendlyTo(target))
                        AttackStart(target);
        }

        void OwnerAttacked(Unit* target)
        {
            if (!target || (me->GetVictim() && me->GetVictim()->IsAlive() && !me->GetVictim()->HasBreakableByDamageCrowdControlAura()))
                return;

            AttackStart(target);
        }

        void UpdateAI(uint32 diff)
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_pet_gen_valkyr_guardianAI (pCreature);
    }
};

class spell_pet_gen_valkyr_guardian_smite : public SpellScriptLoader
{
    public:
        spell_pet_gen_valkyr_guardian_smite() : SpellScriptLoader("spell_pet_gen_valkyr_guardian_smite") { }

        class spell_pet_gen_valkyr_guardian_smite_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_pet_gen_valkyr_guardian_smite_SpellScript);

            void RecalculateDamage()
            {
                if (GetHitUnit() != GetCaster())
                {
                    std::list<Spell::TargetInfo>* targetsInfo = GetSpell()->GetUniqueTargetInfo();
                    for (std::list<Spell::TargetInfo>::iterator ihit = targetsInfo->begin(); ihit != targetsInfo->end(); ++ihit)
                        if (ihit->targetGUID == GetCaster()->GetGUID())
                            ihit->damage = -int32(GetHitDamage()*0.25f);
                }
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_pet_gen_valkyr_guardian_smite_SpellScript::RecalculateDamage);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_pet_gen_valkyr_guardian_smite_SpellScript();
        }
};

class npc_pet_gen_imp_in_a_bottle : public CreatureScript
{
public:
    npc_pet_gen_imp_in_a_bottle() : CreatureScript("npc_pet_gen_imp_in_a_bottle") { }

    struct npc_pet_gen_imp_in_a_bottleAI : public NullCreatureAI
    {
        npc_pet_gen_imp_in_a_bottleAI(Creature *c) : NullCreatureAI(c)
        {
            _talkTimer = 0;
            _ownerGUID = 0;
            _hasParty = false;
        }

        WorldPacket _data;
        uint32 _talkTimer;
        uint64 _ownerGUID;
        bool _hasParty;

        void InitializeAI()
        {
            NullCreatureAI::InitializeAI();

            if (TempSummon* summon = me->ToTempSummon())
                if (Unit* owner = summon->GetSummoner())
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
                            _data << uint64(me->GetGUID());
                            _data << uint32(0);
                            _data << uint32(me->GetName().size() + 1);
                            _data << me->GetName();
                            _data << uint64(0);
                            _data << uint32(text.size()+1);
                            _data << text.c_str();
                            _data << uint8(0);
                        }
                    }
        }

        void UpdateAI(uint32 diff)
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
                        for (GroupReference* itr = player->GetGroup()->GetFirstMember(); itr != NULL && limit < 4; itr = itr->next(), ++limit)
                            if (Player* groupPlayer = itr->GetSource())
                                if (groupPlayer != player)
                                    groupPlayer->GetSession()->SendPacket(&_data);

                    player->GetSession()->SendPacket(&_data);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_pet_gen_imp_in_a_bottleAI (pCreature);
    }
};

class npc_pet_gen_wind_rider_cub : public CreatureScript
{
public:
    npc_pet_gen_wind_rider_cub() : CreatureScript("npc_pet_gen_wind_rider_cub") { }

    struct npc_pet_gen_wind_rider_cubAI : public NullCreatureAI
    {
        npc_pet_gen_wind_rider_cubAI(Creature *c) : NullCreatureAI(c)
        {
            isFlying = true;
            checkTimer = 0;
            checkTimer2 = 2000;
            me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
        }

        bool isFlying;
        uint32 checkTimer;
        uint32 checkTimer2;

        void UpdateAI(uint32 diff)
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_pet_gen_wind_rider_cubAI (pCreature);
    }
};

enum turkey
{
    GO_BASIC_CAMPFIRE           = 29784,
    SPELL_TURKEY_STARTS_TO_BURN = 61768,
};

class npc_pet_gen_plump_turkey : public CreatureScript
{
public:
    npc_pet_gen_plump_turkey() : CreatureScript("npc_pet_gen_plump_turkey") { }

    struct npc_pet_gen_plump_turkeyAI : public PassiveAI
    {
        npc_pet_gen_plump_turkeyAI(Creature *c) : PassiveAI(c)
        {
            goGUID = 0;
            jumpTimer = 0;
            checkTimer = 0;
            jumping = false;
        }

        uint64 goGUID;
        uint32 jumpTimer;
        uint32 checkTimer;
        bool jumping;

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == EFFECT_MOTION_TYPE && id == 1)
            {
                Unit::Kill(me, me);
                me->AddAura(SPELL_TURKEY_STARTS_TO_BURN, me);
            }
        }

        void UpdateAI(uint32 diff)
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_pet_gen_plump_turkeyAI (pCreature);
    }
};

class npc_pet_gen_toxic_wasteling : public CreatureScript
{
public:
    npc_pet_gen_toxic_wasteling() : CreatureScript("npc_pet_gen_toxic_wasteling") { }

    struct npc_pet_gen_toxic_wastelingAI : public PassiveAI
    {
        npc_pet_gen_toxic_wastelingAI(Creature *c) : PassiveAI(c)
        {
        }

        uint32 checkTimer;

        void Reset() { checkTimer = 3000; }

        void EnterEvadeMode()
        {
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == EFFECT_MOTION_TYPE && id == 1)
                checkTimer = 1;
        }

        void UpdateAI(uint32 diff)
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_pet_gen_toxic_wastelingAI (pCreature);
    }
};

class npc_pet_gen_fetch_ball : public CreatureScript
{
public:
    npc_pet_gen_fetch_ball() : CreatureScript("npc_pet_gen_fetch_ball") { }

    struct npc_pet_gen_fetch_ballAI : public NullCreatureAI
    {
        npc_pet_gen_fetch_ballAI(Creature *c) : NullCreatureAI(c)
        {
        }

        uint32 checkTimer;
        uint64 targetGUID;

        void IsSummonedBy(Unit* summoner)
        {
            if (!summoner)
                return;

            me->SetOwnerGUID(summoner->GetGUID());
            checkTimer = 0;
            targetGUID = 0;
            me->CastSpell(me, 48649 /*SPELL_PET_TOY_FETCH_BALL_COME_HERE*/, true);
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spellInfo)
        {
            if (spellInfo->Id == 48649 /*SPELL_PET_TOY_FETCH_BALL_COME_HERE*/)
            {
                target->GetMotionMaster()->MovePoint(50, me->GetHomePosition());
                targetGUID = target->GetGUID();
            }
        }

        void UpdateAI(uint32 diff)
        {
            checkTimer += diff;
            if (checkTimer >= 1000)
            {
                checkTimer = 0;
                if (Creature* target = ObjectAccessor::GetCreature(*me, targetGUID))
                    if (me->GetDistance2d(target) < 2.0f)
                    {
                        target->AI()->EnterEvadeMode();
                        target->CastSpell(target, 48708 /*SPELL_PET_TOY_FETCH_BALL_HAS_BALL*/, true);
                        me->DespawnOrUnsummon(1);
                    }
            }
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_pet_gen_fetch_ballAI (pCreature);
    }
};

class npc_pet_gen_moth : public CreatureScript
{
public:
    npc_pet_gen_moth() : CreatureScript("npc_pet_gen_moth") { }

    struct npc_pet_gen_mothAI : public NullCreatureAI
    {
        npc_pet_gen_mothAI(Creature *c) : NullCreatureAI(c)
        {
            me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
            me->SetCanFly(true);
            me->SetDisableGravity(true);
        }
    };

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_pet_gen_mothAI (pCreature);
    }
};

void AddSC_generic_pet_scripts()
{
    new npc_pet_gen_mojo();
    new npc_pet_gen_soul_trader_beacon();
    new npc_pet_gen_argent_pony_bridle();
    new npc_pet_gen_target_following_bomb();
    new npc_pet_gen_gnomish_flame_turret();
    new npc_pet_gen_valkyr_guardian();
    new spell_pet_gen_valkyr_guardian_smite();
    new npc_pet_gen_imp_in_a_bottle();
    new npc_pet_gen_wind_rider_cub();
    new npc_pet_gen_plump_turkey();
    new npc_pet_gen_toxic_wasteling();
    new npc_pet_gen_fetch_ball();
    new npc_pet_gen_moth();
}
