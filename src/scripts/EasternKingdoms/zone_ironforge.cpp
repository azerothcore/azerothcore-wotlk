/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */
 
 /* ScriptData
SDName: Ironforge
SD%Complete: 100
SDComment: Quest support: 25229, 25199, 25283, 25295
SDCategory: Ironforge
EndScriptData */

/* ContentData
npc_royal_historian_archesonus
npc_gnome_citizen
npc_steamcrank
npc_mekkatorque
npc_shoot_bunny
spell_motivate_a_tron
EndContentData */

#include "ScriptPCH.h"
#include "Vehicle.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"


/*######
## npc_gnome_citizen
## npc_steamcrank
## npc_mekkatorque
## npc_shoot_bunny
## spell_motivate_a_tron
######*/

enum Spells
{
    SPELL_CITIZEN_AURA                  = 74034,
    SPELL_PETACT_AURA                   = 74071,
    SPELL_QUEST_CREDIT                  = 73960,

    SPELL_MOTIVATE_1                    = 73943,
    SPELL_MOTIVATE_2                    = 74080,

    SPELL_TURNIN                        = 75078,
    SPELL_AOE_TURNIN                    = 73955,

    // Basic Orders
    SPELL_SALUTE_CREDIT                 = 73771,
    SPELL_DANCE_CREDIT                  = 73830,
    SPELL_ROAR_CREDIT                   = 73832,
    SPELL_CHEER_CREDIT                  = 73833,

    // Press Fire
    SPELL_SHOOT_CREDIT                  = 74184,
    SPELL_SHOOT_VISUAL                  = 74179,

    // Prepping the Speech
    SPELL_CREATE_TELEPORTER             = 74206,
    SPELL_CREDIT_OZZIE                  = 74154,
    SPELL_CREDIT_MILLI                  = 74155,
    SPELL_CREDIT_TOG                    = 74156,
};

enum Creatures
{
    NPC_SPARKNOZZLE                     = 39675,

    NPC_CITIZEN_1                       = 39253,
    NPC_CITIZEN_2                       = 39623,

    NPC_MOTIVATED_CITIZEN_1             = 39466,
    NPC_MOTIVATED_CITIZEN_2             = 39624,

    // Basic Orders
    NPC_TRAINEE                         = 39349,

    // Press Fire
    NPC_TARGET                          = 39711,

    // Prepping Speech
    NPC_OZZIE                           = 1268,
    NPC_MILLI                           = 7955,
    NPC_TOG                             = 6119,
    NPC_SUMMONING_PAD                   = 39817,
};

enum Points
{
    POINT_SPARKNOZZLE                   = 4026500,
};

enum Texts
{
    SAY_CITIZEN_START                   = 0,
    SAY_CITIZEN_END                     = 1,
};

class npc_gnome_citizen : public CreatureScript
{
    public:
        npc_gnome_citizen() : CreatureScript("npc_gnome_citizen") { }

        struct npc_gnome_citizenAI : public ScriptedAI
        {
            npc_gnome_citizenAI(Creature* creature) : ScriptedAI(creature)
            {
                Reset();
                Player* player = me->GetOwner()->ToPlayer();

                switch (urand(1, 4))
                {
                    case 1:
                        _mountModel = 6569;
                        break;
                    case 2:
                        _mountModel = 9473;
                        break;
                    case 3:
                        _mountModel = 9474;
                        break;
                    case 4:
                        _mountModel = 9475;
                        break;
                }
                if (player)
                    me->GetMotionMaster()->MoveFollow(player, 5.0f, float(rand_norm() + 1.0f) * M_PI / 3.0f * 4.0f);
            }

            void Reset()
            {
                _complete = false;
                me->AddAura(SPELL_CITIZEN_AURA, me);
                DoCast(me, SPELL_PETACT_AURA);
                me->SetReactState(REACT_PASSIVE);
                Talk(SAY_CITIZEN_START);
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE)
                    return;
                if (id == POINT_SPARKNOZZLE)
                    me->DespawnOrUnsummon();
            }

            void SpellHit(Unit* caster, SpellInfo const* spell)
            {
                if (spell->Id == SPELL_AOE_TURNIN && caster->GetEntry() == NPC_SPARKNOZZLE && !_complete)
                {
                    _complete = true;    // Preventing from giving credit twice
                    DoCast(me, SPELL_TURNIN);
                    DoCast(me, SPELL_QUEST_CREDIT);
                    Talk(SAY_CITIZEN_END);
                    me->GetMotionMaster()->MovePoint(POINT_SPARKNOZZLE, caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ());
                }
            }

            void UpdateAI(uint32 diff)
            {
                Unit* owner = me->GetOwner();

                if (!owner)
                    return;

                if (owner->IsMounted() && !me->IsMounted())
                    me->Mount(_mountModel);
                else if (!owner->IsMounted() && me->IsMounted())
                    me->Dismount();

                me->SetSpeed(MOVE_RUN, owner->GetSpeedRate(MOVE_RUN));
                me->SetSpeed(MOVE_WALK, owner->GetSpeedRate(MOVE_WALK));
            }

        private:
            uint32 _mountModel;
            bool _complete;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_gnome_citizenAI(creature);
        }
};

class npc_captain_tread_sparknozzle : public CreatureScript
{
public:
    npc_captain_tread_sparknozzle() : CreatureScript("npc_captain_tread_sparknozzle") { }

    struct npc_captain_tread_sparknozzleAI : public ScriptedAI
    {
        npc_captain_tread_sparknozzleAI(Creature* creature) : ScriptedAI(creature) { }

        void MoveInLineOfSight(Unit* who)
        {
            ScriptedAI::MoveInLineOfSight(who);

            if(who->GetTypeId() == TYPEID_PLAYER)
            {
                if(((Player*)who)->GetQuestStatus(25229) == QUEST_STATUS_INCOMPLETE)
                {
                    std::list<Creature*> GnomeList;
                    me->GetCreatureListWithEntryInGrid(GnomeList, 39624, 7.5f);
                    if(!GnomeList.empty())
                    {
                        for(std::list<Creature*>::const_iterator itr = GnomeList.begin(); itr != GnomeList.end(); ++itr)
                        {
                            if(Creature* creature = *itr)
                            {
                                creature->DespawnOrUnsummon();
                                ((Player*)who)->KilledMonsterCredit(39624, 0);
                            }
                        }
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_captain_tread_sparknozzleAI(creature);
    }
};

#define STEAM_0 "Well, a bunch of useless gears, let's get to work!"
#define STEAM_1 "I will teach you everything you must know how to be a real soldier!"
#define STEAM_2 "First of all, you need to go drill."
#define STEAM_3 "At the signal, show me how to welcome the commander for the charter!"
#define STEAM_4 "So recruits saluted his commander!"
#define STEAM_5 "Great job!"
#define STEAM_6 "On the battlefield, it is important to intimidate the enemy furious battle roar!"
#define STEAM_7 "As soon as I give the signal, show me what real fury!"
#define STEAM_8 "Show me now furious!"
#define STEAM_9 "Wow, nice!"
#define STEAM_10 "Remember that the most important factor in any battle - is the spirit!"
#define STEAM_11 "Get ready to show me how the soldiers should be happy to win!"
#define STEAM_12 "Let's! Express your enthusiasm!"
#define STEAM_13 "Terrific!"
#define STEAM_14 "However, the most important in the battle - to be able to correctly mark earned sweat and blood of victory!"
#define STEAM_15 "Execute me your best victory dance! Start the alarm!"
#define STEAM_16 "And now - dance!"
#define STEAM_17 "Great!"
#define STEAM_18 "You - are the best squad of recruits that I have ever seen Let's repeat everything!"

class npc_steamcrank : public CreatureScript
{
    public:
        npc_steamcrank() : CreatureScript("npc_steamcrank") { }

        struct npc_steamcrankAI : public ScriptedAI
        {
            npc_steamcrankAI(Creature* creature) : ScriptedAI(creature) { }

            void Reset()
            {
            }

            void JumpToNextStep(uint32 uiTimer)
            {
                _stepTimer = uiTimer;
                ++_step;
                if (_step > 26)
                {
                    _step = 0;
                    _stepTimer = 2000;
                }
            }

            void ReceiveEmote(Player* pPlayer, uint32 uiTextEmote)
            {
                switch(uiTextEmote)
                {
                    case TEXT_EMOTE_SALUTE:
                        if (_step >= 5 && _step < 8)
                            me->CastSpell(pPlayer, SPELL_SALUTE_CREDIT, true);
                        break;
                    case TEXT_EMOTE_ROAR:
                        if (_step >= 11 && _step < 14)
                            me->CastSpell(pPlayer, SPELL_ROAR_CREDIT, true);
                        break;
                    case TEXT_EMOTE_CHEER:
                        if (_step >= 17 && _step < 20)
                            me->CastSpell(pPlayer, SPELL_CHEER_CREDIT, true);
                        break;
                    case TEXT_EMOTE_DANCE:
                        if (_step >= 23 && _step < 26)
                            me->CastSpell(pPlayer, SPELL_DANCE_CREDIT, true);
                        break;
                }
            }

            void ForceEmote(uint32 uiEmote)
            {
                std::list<Creature*> Trainees;
                GetCreatureListWithEntryInGrid(Trainees, me, NPC_TRAINEE, 15.0f);
                if (!Trainees.empty())
                {
                    for (std::list<Creature*>::iterator itr = Trainees.begin(); itr != Trainees.end(); ++itr)
                        (*itr)->SetUInt32Value(UNIT_NPC_EMOTESTATE, uiEmote);
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (_stepTimer <= diff)
                {
                    switch (_step)
                    {
                        case 0:
                            me->MonsterSay(STEAM_0, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 1:
                            me->MonsterSay(STEAM_1, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 2:
                            me->MonsterSay(STEAM_2, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 3:
                            me->MonsterSay(STEAM_3, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 4:
                            me->MonsterSay(STEAM_4, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(1000);
                            break;
                        case 5:
                            ForceEmote(EMOTE_ONESHOT_SALUTE);
                            JumpToNextStep(1500);
                            break;
                        case 6:
                            ForceEmote(EMOTE_ONESHOT_NONE);
                            JumpToNextStep(3000);
                        case 7:
                            me->MonsterSay(STEAM_5, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 8:
                            me->MonsterSay(STEAM_6, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 9:
                            me->MonsterSay(STEAM_7, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 10:
                            me->MonsterSay(STEAM_8, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(1000);
                            break;
                        case 11:
                            ForceEmote(EMOTE_ONESHOT_ROAR);
                            JumpToNextStep(2000);
                            break;
                        case 12:
                            ForceEmote(EMOTE_ONESHOT_NONE);
                            JumpToNextStep(3000);
                            break;
                        case 13:
                            me->MonsterSay(STEAM_9, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 14:
                            me->MonsterSay(STEAM_10, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 15:
                            me->MonsterSay(STEAM_11, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 16:
                            me->MonsterSay(STEAM_12, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(1000);
                            break;
                        case 17:
                            ForceEmote(EMOTE_ONESHOT_CHEER);
                            JumpToNextStep(1500);
                            break;
                        case 18:
                            ForceEmote(EMOTE_ONESHOT_NONE);
                            JumpToNextStep(3000);
                            break;
                        case 19:
                            me->MonsterSay(STEAM_13, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 20:
                            me->MonsterSay(STEAM_14, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 21:
                            me->MonsterSay(STEAM_15, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 22:
                            me->MonsterSay(STEAM_16, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(1000);
                            break;
                        case 23:
                            ForceEmote(EMOTE_ONESHOT_DANCE);
                            JumpToNextStep(2500);
                            break;
                        case 24:
                            ForceEmote(EMOTE_ONESHOT_NONE);
                            JumpToNextStep(3000);
                            break;
                        case 25:
                            me->MonsterSay(STEAM_17, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                        case 26:
                            me->MonsterSay(STEAM_18, LANG_UNIVERSAL, NULL);
                            JumpToNextStep(5000);
                            break;
                    }
                }
                else
                    _stepTimer -= diff;
            }

        private:
            uint32 _step;
            uint32 _stepTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_steamcrankAI(creature);
        }
};

#define MEK_1_0 "Let them take away our lives, but they will never take ..."
#define MEK_1_1 "... our ingenuity!"
#define LIS_1_0 "What? I have no idea what he was saying! It uzhastno!"
#define MEK_2_0 "We will not let themselves be destroyed! We will not surrender without a fight!"
#define MEK_2_1 "We will live! We will continue to live! Today we celebrate ..."
#define MEK_2_2 "... our Independence Day!"
#define LIS_2_0 "Nightmare! Although ... maybe nothing, if a little clean up."
#define MEK_3_0 "You must carefully search every gas station, all the houses, warehouses, farms, kennels and toilets in the area."
#define MEK_3_1 "fugitive Name - Mekgineer Thermaplugg."
#define MEK_3_2 "Go and hold it."
#define LIS_3_0 "Perhaps it should work. Though something it is clearly not enough."

class npc_mekkatorque : public CreatureScript
{
    public:
        npc_mekkatorque() : CreatureScript("npc_mekkatorque") { }

        struct npc_mekkatorqueAI : public ScriptedAI
        {
            npc_mekkatorqueAI(Creature* creature) : ScriptedAI(creature)
            {
                if (Creature* ozzie = me->FindNearestCreature(NPC_OZZIE, 15.0f, true))
                    _listener = ozzie;
                else if (Creature* milli = me->FindNearestCreature(NPC_MILLI, 15.0f, true))
                    _listener = milli;
                else if(Creature* tog = me->FindNearestCreature(NPC_TOG, 15.0f, true))
                    _listener = tog;
                else
                {
                    me->DespawnOrUnsummon();
                    return;
                }
                _variation = urand (1,3);
                me->CastSpell(me, SPELL_CREATE_TELEPORTER, true);
            }

            void Reset()
            {
            }

            void JumpToNextStep(uint32 uiTimer)
            {
                _stepTimer = uiTimer;
                ++_step;
            }

            void CastCredit()
            {
                Unit* owner = me->GetOwner();
                switch (_listener->GetEntry())
                {
                    case NPC_OZZIE:
                        me->CastSpell(owner, SPELL_CREDIT_OZZIE, true);
                        break;
                    case NPC_MILLI:
                        me->CastSpell(owner, SPELL_CREDIT_MILLI, true);
                        break;
                    case NPC_TOG:
                        me->CastSpell(owner, SPELL_CREDIT_TOG, true);
                        break;
                }
                me->DespawnOrUnsummon();
            }

            void UpdateAI(uint32 diff)
            {
                if (_stepTimer <= diff)
                {
                    switch (_variation)
                    {
                        case 1:
                            switch (_step)
                            {
                                case 0:
                                    me->MonsterSay(MEK_1_0, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(5000);
                                    break;
                                case 1:
                                    me->MonsterSay(MEK_1_1, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(5000);
                                    break;
                                case 2:
                                    _listener->MonsterSay(LIS_1_0, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(3000);
                                    break;
                                case 3:
                                    if (Creature* Pad = me->FindNearestCreature(NPC_SUMMONING_PAD, 1.0f, true))
                                        Pad->DespawnOrUnsummon();
                                    CastCredit();
                                    break;
                            }
                            break;
                        case 2:
                            switch (_step)
                            {
                                case 0:
                                    me->MonsterSay(MEK_2_0, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(5000);
                                    break;
                                case 1:
                                    me->MonsterSay(MEK_2_1, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(5000);
                                    break;
                                case 2:
                                    me->MonsterSay(MEK_2_2, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(5000);
                                    break;
                                case 3:
                                    _listener->MonsterSay(LIS_2_0, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(3000);
                                    break;
                                case 4:
                                    if (Creature* Pad = me->FindNearestCreature(NPC_SUMMONING_PAD, 1.0f, true))
                                        Pad->DespawnOrUnsummon();
                                    CastCredit();
                                    break;
                            }
                            break;
                        case 3:
                            switch (_step)
                            {
                                case 0:
                                    me->MonsterSay(MEK_3_0, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(7000);
                                    break;
                                case 1:
                                    me->MonsterSay(MEK_3_1, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(3000);
                                    break;
                                case 2:
                                    me->MonsterSay(MEK_3_2, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(3000);
                                    break;
                                case 3:
                                    _listener->MonsterSay(LIS_3_0, LANG_UNIVERSAL, NULL);
                                    JumpToNextStep(3000);
                                    break;
                                case 4:
                                    if (Creature* Pad = me->FindNearestCreature(NPC_SUMMONING_PAD, 1.0f, true))
                                        Pad->DespawnOrUnsummon();
                                    CastCredit();
                                    break;
                            }
                            break;
                    }
                }
                else
                    _stepTimer -= diff;
            }

        private:
            uint32 _step;
            uint32 _stepTimer;
            uint32 _variation;
            Creature* _listener;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_mekkatorqueAI(creature);
        }
};

class npc_shoot_bunny : public CreatureScript
{
    public:
        npc_shoot_bunny() : CreatureScript("npc_shoot_bunny") { }

        struct npc_shoot_bunnyAI : public ScriptedAI
        {
            npc_shoot_bunnyAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset()
            {
                if (me->FindNearestCreature(NPC_TARGET, 3.0f, true))
                    if (Unit* vehSummoner = me->ToTempSummon()->GetSummoner())
                        if (Vehicle* vehicle = vehSummoner->GetVehicleKit())
                            if (Unit* driver = vehicle->GetPassenger(0))
                                driver->CastSpell(driver, SPELL_SHOOT_CREDIT, true);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_shoot_bunnyAI(creature);
        }
};

class spell_motivate_a_tron : public SpellScriptLoader
{
    public:
        spell_motivate_a_tron() : SpellScriptLoader("spell_motivate_a_tron") {}

        class spell_motivate_a_tron_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_motivate_a_tron_SpellScript)
            bool Validate(SpellInfo const* /*spellEntry*/)
            {
                if (!sSpellStore.LookupEntry(SPELL_MOTIVATE_1))
                    return false;
                if (!sSpellStore.LookupEntry(SPELL_MOTIVATE_2))
                    return false;
               return true;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Unit* caster = GetCaster();
                if (Unit* target = GetHitUnit())
                {
                    uint32 motivate = 0;
                    if (target->GetEntry() == NPC_CITIZEN_1)
                        motivate = SPELL_MOTIVATE_1;
                    else if (target->GetEntry() == NPC_CITIZEN_2)
                        motivate = SPELL_MOTIVATE_2;
                    if (motivate)
                        caster->CastSpell(target, motivate, true, NULL, NULL, caster->GetGUID());
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_motivate_a_tron_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_motivate_a_tron_SpellScript();
        }
};

void AddSC_ironforge()
{
    new npc_gnome_citizen();
    new npc_captain_tread_sparknozzle();
    new npc_steamcrank();
    new npc_mekkatorque();
    new npc_shoot_bunny();
    new spell_motivate_a_tron();
}