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

#include "CombatAI.h"
#include "CreatureScript.h"
#include "MoveSplineInit.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SmartScriptMgr.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"

// Ours
enum eBKG
{
    QUEST_BLACK_KNIGHT_CURSE            = 14016,

    NPC_CULT_ASSASSIN                   = 35127,
    NPC_CULT_SABOTEUR                   = 35116,
};

class npc_black_knight_graveyard : public CreatureScript
{
public:
    npc_black_knight_graveyard() : CreatureScript("npc_black_knight_graveyard") { }

    struct npc_black_knight_graveyardAI : public ScriptedAI
    {
        npc_black_knight_graveyardAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!who->IsPlayer() || me->GetDistance(who) > 8.0f || who->ToPlayer()->GetQuestStatus(QUEST_BLACK_KNIGHT_CURSE) != QUEST_STATUS_INCOMPLETE)
                return;

            if (me->FindNearestCreature(NPC_CULT_ASSASSIN, 30.0f))
                return;

            me->SummonCreature(NPC_CULT_ASSASSIN, 8452.50f, 459.08f, 596.08f, 0.93f, TEMPSUMMON_CORPSE_DESPAWN);
            me->SummonCreature(NPC_CULT_SABOTEUR, 8455.47f, 458.64f, 596.08f, 2.36f, TEMPSUMMON_CORPSE_DESPAWN);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_black_knight_graveyardAI(creature);
    }
};

enum valhalas
{
    QUEST_BFV_FALLEN_HEROES                     = 13214,
    QUEST_BFV_DARK_MASTER                       = 13215,
    QUEST_BFV_SIGRID                            = 13216,
    QUEST_BFV_CARNAGE                           = 13217,
    QUEST_BFV_THANE                             = 13218,
    QUEST_BFV_FINAL                             = 13219,

    EVENT_VALHALAS_FIRST                        = 1,
    EVENT_VALHALAS_SECOND                       = 2,
    EVENT_VALHALAS_THIRD                        = 3,
    EVENT_VALHALAS_CHECK_PLAYER                 = 4,

    // Fallen Heroes
    NPC_ELDRETH                                 = 31195,
    NPC_GENESS                                  = 31193,
    NPC_JHADRAS                                 = 31191,
    NPC_MASUD                                   = 31192,
    NPC_RITH                                    = 31196,
    NPC_TALLA                                   = 31194,

    NPC_DARK_MASTER                             = 31222,
    NPC_SIGRID                                  = 31242,
    NPC_CARNAGE                                 = 31271,
    NPC_THANE                                   = 31277,
    NPC_PRINCE                                  = 14688, // no mistake
};

class npc_battle_at_valhalas : public CreatureScript
{
public:
    npc_battle_at_valhalas() : CreatureScript("npc_battle_at_valhalas") { }

    struct npc_battle_at_valhalasAI : public ScriptedAI
    {
        npc_battle_at_valhalasAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
        }

        EventMap events;
        SummonList summons;
        ObjectGuid playerGUID;
        ObjectGuid playerGUID2;
        uint32 currentQuest;

        void Reset() override
        {
            ResetData();
        }

        void ResetData()
        {
            events.Reset();
            summons.DespawnAll();
            playerGUID.Clear();
            currentQuest = 0;
            me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
        }

        void JustSummoned(Creature* creature) override
        {
            summons.Summon(creature);
            if (creature->GetEntry() != NPC_PRINCE)
                if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                    creature->AI()->AttackStart(player);
        }

        void PrepareSummons()
        {
            switch (currentQuest)
            {
                case QUEST_BFV_FALLEN_HEROES:
                    me->SummonCreature(NPC_ELDRETH, 8245.5f, 3522.7f, 627.67f, 3.11f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    me->SummonCreature(NPC_GENESS, 8217.45f, 3546.0f, 628.20f, 4.41f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    me->SummonCreature(NPC_JHADRAS, 8179.99f, 3523.72f, 628.1f, 5.95f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    me->SummonCreature(NPC_MASUD, 8184.97f, 3491.2f, 625.33f, 0.6f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    me->SummonCreature(NPC_RITH, 8213.5f, 3478.5f, 626.79f, 1.56f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    me->SummonCreature(NPC_TALLA, 8238.30f, 3485.5f, 628.5f, 2.157f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    break;
                case QUEST_BFV_DARK_MASTER:
                    me->SummonCreature(NPC_DARK_MASTER, 8184.97f, 3491.2f, 625.33f, 0.6f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    break;
                case QUEST_BFV_SIGRID:
                    me->SummonCreature(NPC_SIGRID, 8238.30f, 3485.5f, 628.5f, 2.157f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    break;
                case QUEST_BFV_CARNAGE:
                    me->SummonCreature(NPC_CARNAGE, 8179.99f, 3523.72f, 628.1f, 5.95f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    break;
                case QUEST_BFV_THANE:
                    me->SummonCreature(NPC_THANE, 8217.45f, 3546.0f, 628.20f, 4.41f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    break;
                case QUEST_BFV_FINAL:
                    me->SummonCreature(NPC_PRINCE, 8245.5f, 3522.7f, 627.67f, 3.11f, TEMPSUMMON_MANUAL_DESPAWN, 30000);
                    break;
            }
        }

        void StartBattle(ObjectGuid guid, uint32 questId)
        {
            events.ScheduleEvent(EVENT_VALHALAS_FIRST, 6s);
            events.ScheduleEvent(EVENT_VALHALAS_CHECK_PLAYER, 30s);
            currentQuest = questId;
            playerGUID = guid;
        }

        void CheckSummons()
        {
            bool allow = true;
            for (ObjectGuid const& guid : summons)
                if (Creature* cr = ObjectAccessor::GetCreature(*me, guid))
                    if (cr->IsAlive())
                        allow = false;

            if (allow)
            {
                uint32 quest = currentQuest;
                if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                {
                    switch (quest)
                    {
                        case QUEST_BFV_FALLEN_HEROES:
                            me->Yell("$N has defeated the fallen heroes of Valhalas battles past. This is only a beginning, but it will suffice.", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                            break;
                        case QUEST_BFV_DARK_MASTER:
                            me->Yell("Khit'rix the Dark Master has been defeated by $N and his band of companions. Let the next challenge be issued!", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                            break;
                        case QUEST_BFV_SIGRID:
                            me->Yell("$N has defeated Sigrid Iceborn for a second time. Well, this time he did it with the help of his friends, but a win is a win!", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                            break;
                        case QUEST_BFV_CARNAGE:
                            me->Yell("The horror known as Carnage is no more. Could it be that $N is truly worthy of battle in Valhalas? We shall see.", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                            break;
                        case QUEST_BFV_THANE:
                            me->Yell("Thane Banahogg the Deathblow has fallen to $N and his fighting companions. He has but one challenge ahead of him. Who will it be?", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                            break;
                        case QUEST_BFV_FINAL:
                            me->Yell("The unthinkable has happened... $N has slain Prince Sandoval!", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                            break;
                    }
                    player->GroupEventHappens(quest, player);
                }
                playerGUID2 = playerGUID;
                EnterEvadeMode();
                if (quest == QUEST_BFV_FINAL)
                    events.ScheduleEvent(EVENT_VALHALAS_THIRD, 7s);
            }
            else
            {
                uint32 quest = currentQuest;
                if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                {
                    if (!player->HasQuest(quest))
                    {
                        ResetData();
                        return;
                    }
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_VALHALAS_FIRST:
                    {
                        switch (currentQuest)
                        {
                            case QUEST_BFV_FALLEN_HEROES:
                                events.ScheduleEvent(EVENT_VALHALAS_SECOND, 8s);
                                me->Yell("$N and comrades in arms have chosen to accept honorable combat within the sacred confines of Valhalas.", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                                break;
                            case QUEST_BFV_DARK_MASTER:
                                events.ScheduleEvent(EVENT_VALHALAS_SECOND, 8s);
                                me->Yell("$N has accepted the challenge of Khit'rix the Dark Master. May the gods show mercy upon him for Khit'rix surely will not.", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                                break;
                            case QUEST_BFV_SIGRID:
                                PrepareSummons();
                                me->TextEmote("Circling Valhalas, Sigrid Iceborn approaches to seek her revenge!", nullptr, true);
                                break;
                            case QUEST_BFV_CARNAGE:
                                events.ScheduleEvent(EVENT_VALHALAS_SECOND, 8s);
                                me->Yell("From the bowels of the Underhalls comes Carnage. Brave and foolish $N has accepted the challenge. $N and his group stand ready to face the monstrosity.", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                                break;
                            case QUEST_BFV_THANE:
                                events.ScheduleEvent(EVENT_VALHALAS_SECOND, 8s);
                                me->Yell("Thane Banahogg returns to Valhalas for the first time in ages to prove that the vrykul are the only beings worthy to fight within its sacred ring. Will $N prove him wrong?", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                                break;
                            case QUEST_BFV_FINAL:
                                events.ScheduleEvent(EVENT_VALHALAS_SECOND, 8s);
                                me->Yell("From the depths of Icecrown Citadel, one of the Lich King's chosen comes to put an end to the existence of $N and his friends.", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                                break;
                        }

                        me->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 20.0f);
                        me->SetPosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 20.0f, me->GetOrientation());
                        break;
                    }
                case EVENT_VALHALAS_SECOND:
                    {
                        switch (currentQuest)
                        {
                            case QUEST_BFV_FALLEN_HEROES:
                                me->Yell("There can only be one outcome to such a battle: death for one side or the other. Let $n prove himself upon the bones of these outsiders who have fallen before!", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                                me->TextEmote("The fallen heroes of Valhalas emerge from the ground to do battle once more!", nullptr, true);
                                break;
                            case QUEST_BFV_DARK_MASTER:
                                me->TextEmote("Khit'rix the Dark Master skitters into Valhalas from the southeast!", nullptr, true);
                                break;
                            case QUEST_BFV_CARNAGE:
                                me->TextEmote("Lumbering in from the south, the smell of Carnage precedes him!", nullptr, true);
                                break;
                            case QUEST_BFV_THANE:
                                me->TextEmote("Thane Banahogg appears upon the overlook to the southeast!", nullptr, true);
                                break;
                            case QUEST_BFV_FINAL:
                                me->Yell("Warriors of Jotunheim, I present to you, Blood Prince Sandoval!", LANG_UNIVERSAL);
                                me->TextEmote("Without warning, Prince Sandoval magically appears within Valhalas!", nullptr, true);
                                break;
                        }

                        PrepareSummons();
                        break;
                    }
                case EVENT_VALHALAS_THIRD:
                    {
                        me->Yell("In defeating him, he and his fighting companions have proven themselves worthy of battle in this most sacred place of vrykul honor.", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID));
                        events.ScheduleEvent(EVENT_VALHALAS_THIRD + 2, 7s);
                        break;
                    }
                case EVENT_VALHALAS_THIRD+2:
                    {
                        me->Yell("ALL HAIL $N, CHAMPION OF VALHALAS! ", LANG_UNIVERSAL, ObjectAccessor::GetPlayer(*me, playerGUID2));
                        break;
                    }
                case EVENT_VALHALAS_CHECK_PLAYER:
                    {
                        bool fail = true;
                        if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                            if (me->GetDistance(player) < 100.0f)
                            {
                                fail = false;
                                CheckSummons();
                            }

                        if (fail)
                            EnterEvadeMode();

                        events.Repeat(5s);
                        break;
                    }
            }
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        npc_battle_at_valhalasAI* vAI = CAST_AI(npc_battle_at_valhalas::npc_battle_at_valhalasAI, creature->AI());
        vAI->ResetData();

        creature->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
        if (vAI)
            vAI->StartBattle(player->GetGUID(), quest->GetQuestId());

        switch (quest->GetQuestId())
        {
            case QUEST_BFV_FALLEN_HEROES:
                creature->Say("Valhalas is yours to win or die in, $N. But whatever you do, stay within the bounds of the arena. To flee is to lose and be dishonored.", LANG_UNIVERSAL, player);
                break;
            case QUEST_BFV_DARK_MASTER:
                creature->Say("Prepare yourself. Khit'rix will be entering Valhalas from the southeast. Remember, do not leave the ring or you will lose the battle.", LANG_UNIVERSAL, player);
                break;
            case QUEST_BFV_SIGRID:
                creature->Yell("Sigrid Iceborn has returned to the heights of Jotunheim to prove herself against $N. When last they met, $N bester her in personal combat. Let us see the outcome of this match.", LANG_UNIVERSAL, player);
                break;
            case QUEST_BFV_CARNAGE:
                creature->Say("Carnage is coming! Remember, no matter what you do, do NOT leave the battle ring or I will disqualify you and your group.", LANG_UNIVERSAL);
                break;
            case QUEST_BFV_THANE:
                creature->Say("Look to the southeast and you will see the thane upon the platform near Gjonner the Merciless when he shows himself. Let him come down. Stay within the ring of Valhalas.", LANG_UNIVERSAL);
                break;
            case QUEST_BFV_FINAL:
                creature->Say("It's too late to run now. Do not leave the ring. Die bravely, $N!", LANG_UNIVERSAL);
                break;
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_battle_at_valhalasAI(creature);
    }
};

class npc_llod_generic : public CreatureScript
{
public:
    npc_llod_generic() : CreatureScript("npc_llod_generic") { }

    struct npc_llod_genericAI : public CombatAI
    {
        npc_llod_genericAI(Creature* pCreature) : CombatAI(pCreature) { attackTimer = 0; summonTimer = 1; }

        uint32 attackTimer;
        uint32 summonTimer;

        void Reset() override
        {
            summonTimer = 1;
            CombatAI::Reset();
        }

        void UpdateAI(uint32 diff) override
        {
            attackTimer += diff;
            if (attackTimer >= 1500)
            {
                if (!me->IsInCombat())
                    if (Unit* target = me->SelectNearbyTarget(nullptr, 20.0f))
                        AttackStart(target);
                attackTimer = 0;
            }

            if (summonTimer)
            {
                summonTimer += diff;
                if (summonTimer >= 8000)
                {
                    for (uint8 i = 0; i < 3; ++i)
                        me->SummonCreature(30593, me->GetPositionX() + irand(-5, 5), me->GetPositionY() + irand(-5, 5), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                    if (roll_chance_i(10))
                        me->SummonCreature(30575, me->GetPositionX() + irand(-5, 5), me->GetPositionY() + irand(-5, 5), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                    summonTimer = 0;
                }
            }

            CombatAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_llod_genericAI(creature);
    }
};

enum eLordArete
{
    SPELL_SOUL_WRACK                = 27765,
    SPELL_SOUL_COAX                 = 22966,
    SPELL_SUMMON_LANDGREN_SOUL      = 12600,
    SPELL_TELEPORT_EFFECT           = 52096,

    NPC_LANDGREN                    = 29542,
    NPC_LANDGREN_SOUL               = 29572,

    EVENT_START                     = 1,
    EVENT_SOUL_COAX                 = 2,
    EVENT_SUMMON_SOUL               = 3,
    EVENT_SOUL_FLY                  = 4,
    EVENT_SCENE_1                   = 5,
    EVENT_SCENE_2                   = 6,
    EVENT_SCENE_3                   = 7,
    EVENT_SCENE_4                   = 8,
    EVENT_SCENE_5                   = 9,
    EVENT_SCENE_6                   = 10,
    EVENT_SCENE_7                   = 11,
    EVENT_SCENE_8                   = 12,
    EVENT_SCENE_9                   = 13,
    EVENT_SCENE_10                  = 14,

    SAY_ARETE_0                     = 0,
    SAY_ARETE_1                     = 1,
    SAY_ARETE_2                     = 2,
    SAY_ARETE_3                     = 3,
    SAY_ARETE_4                     = 4,
    SAY_ARETE_5                     = 5,
    SAY_ARETE_6                     = 6,

    SAY_SOUL_0                      = 0,
    SAY_SOUL_1                      = 1,
    SAY_SOUL_2                      = 2,
    SAY_SOUL_3                      = 3,
    SAY_SOUL_4                      = 4,
};

class npc_lord_arete : public CreatureScript
{
public:
    npc_lord_arete(): CreatureScript("npc_lord_arete") {}

    struct npc_lord_areteAI : ScriptedAI
    {
        npc_lord_areteAI(Creature* creature) : ScriptedAI(creature) {}

        EventMap events;
        ObjectGuid _landgrenGUID;
        ObjectGuid _landgrenSoulGUID;

        void InitializeAI() override
        {
            _landgrenGUID.Clear();
            _landgrenSoulGUID.Clear();

            events.Reset();
            events.RescheduleEvent(EVENT_START, 1s);
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            me->SetWalk(true);
            me->SetImmuneToAll(true);
            me->setActive(true);
            me->SetReactState(REACT_PASSIVE);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_START:
                    Talk(SAY_ARETE_0);
                    me->CastSpell(me, SPELL_TELEPORT_EFFECT, true);
                    if (Creature* cr = me->FindNearestCreature(NPC_LANDGREN, 100.0f, false))
                    {
                        _landgrenGUID = cr->GetGUID();

                        float o = cr->GetAngle(me);
                        me->GetMotionMaster()->MovePoint(1, cr->GetPositionX() + cos(o) * 3, cr->GetPositionY() + std::sin(o) * 3, cr->GetPositionZ());
                        events.RescheduleEvent(EVENT_SOUL_COAX, 5s);
                    }
                    else
                        me->DespawnOrUnsummon(1);
                    break;
                case EVENT_SOUL_COAX:
                    Talk(SAY_ARETE_1);
                    me->CastSpell(me, SPELL_SOUL_COAX, false);
                    events.ScheduleEvent(EVENT_SUMMON_SOUL, 8s);
                    break;
                case EVENT_SUMMON_SOUL:
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, _landgrenGUID))
                        cr->CastSpell(cr, SPELL_SUMMON_LANDGREN_SOUL, true);
                    if (Creature* soul = me->FindNearestCreature(NPC_LANDGREN_SOUL, 100.0f))
                    {
                        _landgrenSoulGUID = soul->GetGUID();
                        soul->SetVisible(false);
                    }
                    events.ScheduleEvent(EVENT_SOUL_FLY, 3s);
                    break;
                case EVENT_SOUL_FLY:
                    if (Creature* soul = ObjectAccessor::GetCreature(*me, _landgrenSoulGUID))
                    {
                        soul->SetCanFly(true);
                        soul->SetVisible(true);
                        Movement::MoveSplineInit init(soul);
                        init.MoveTo(soul->GetPositionX(), soul->GetPositionY(), soul->GetPositionZ() + 5.0f);
                        init.SetVelocity(1.0f);
                        init.Launch();
                        soul->CastSpell(soul, 64462, true); // Drown
                    }
                    events.ScheduleEvent(EVENT_SCENE_1, 6s);
                    break;
                case EVENT_SCENE_1:
                    if (Creature* soul = ObjectAccessor::GetCreature(*me, _landgrenSoulGUID))
                    {
                        soul->SetPosition(soul->GetPositionX(), soul->GetPositionY(), soul->GetPositionZ() + 5.0f, soul->GetOrientation());
                        soul->CastSpell(soul, 64462, true); // Drown
                        soul->AI()->Talk(SAY_SOUL_0);
                    }
                    events.ScheduleEvent(EVENT_SCENE_2, 5s);
                    break;
                case EVENT_SCENE_2:
                    Talk(SAY_ARETE_2);
                    events.ScheduleEvent(EVENT_SCENE_3, 5s);
                    break;
                case EVENT_SCENE_3:
                    if (Creature* soul = ObjectAccessor::GetCreature(*me, _landgrenSoulGUID))
                        soul->AI()->Talk(SAY_SOUL_1);
                    events.ScheduleEvent(EVENT_SCENE_4, 3s);
                    break;
                case EVENT_SCENE_4:
                    if (Creature* soul = ObjectAccessor::GetCreature(*me, _landgrenSoulGUID))
                        me->CastSpell(soul, SPELL_SOUL_WRACK, false);
                    Talk(SAY_ARETE_3);
                    events.ScheduleEvent(EVENT_SCENE_5, 6s);
                    break;
                case EVENT_SCENE_5:
                    if (Creature* soul = ObjectAccessor::GetCreature(*me, _landgrenSoulGUID))
                        soul->AI()->Talk(SAY_SOUL_2);
                    me->InterruptNonMeleeSpells(false);
                    events.ScheduleEvent(EVENT_SCENE_6, 4s);
                    break;
                case EVENT_SCENE_6:
                    Talk(SAY_ARETE_4);
                    events.ScheduleEvent(EVENT_SCENE_7, 4s);
                    break;
                case EVENT_SCENE_7:
                    if (Creature* soul = ObjectAccessor::GetCreature(*me, _landgrenSoulGUID))
                        soul->AI()->Talk(SAY_SOUL_3);
                    events.ScheduleEvent(EVENT_SCENE_8, 8s);
                    break;
                case EVENT_SCENE_8:
                    if (Creature* soul = ObjectAccessor::GetCreature(*me, _landgrenSoulGUID))
                        me->CastSpell(soul, SPELL_SOUL_WRACK, false);
                    Talk(SAY_ARETE_5);
                    events.ScheduleEvent(EVENT_SCENE_9, 6s);
                    break;
                case EVENT_SCENE_9:
                    if (Creature* soul = ObjectAccessor::GetCreature(*me, _landgrenSoulGUID))
                    {
                        soul->AI()->Talk(SAY_SOUL_4);
                        soul->DespawnOrUnsummon(2000);
                    }
                    events.ScheduleEvent(EVENT_SCENE_10, 3s);
                    break;
                case EVENT_SCENE_10:
                    me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_QUESTGIVER);
                    Talk(SAY_ARETE_6);
                    me->DespawnOrUnsummon(60000);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_lord_areteAI(creature);
    }
};

class npc_boneguard_footman : public CreatureScript
{
public:
    npc_boneguard_footman(): CreatureScript("npc_boneguard_footman") {}

    struct npc_boneguard_footmanAI : ScriptedAI
    {
        npc_boneguard_footmanAI(Creature* creature) : ScriptedAI(creature)
        {
            checkTimer = 0;
        }

        uint32 checkTimer;

        void UpdateAI(uint32 diff) override
        {
            if (!me->IsInCombat())
                return;

            checkTimer += diff;
            if (checkTimer >= 500)
            {
                checkTimer = 0;
                if (Unit* victim = me->GetVictim())
                {
                    if (victim->GetEntry() == 33531 /*NPC_CAMPAIGN_WARHORSE*/ && me->GetDistance2d(victim) < 3.0f && victim->isMoving())
                    {
                        me->LowerPlayerDamageReq(me->GetMaxHealth());
                        Unit::Kill(victim, me);
                        return;
                    }
                }
            }

            ScriptedAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_boneguard_footmanAI(creature);
    }
};

enum tirionsGambit
{
    ACTION_START_EVENT          = 1,
    ACTION_SUMMON_MOVE_STRAIGHT = 2,
    ACTION_SUMMON_EMOTE         = 3,
    ACTION_SUMMON_DESPAWN       = 4,
    ACTION_SUMMON_ORIENTATION   = 5,
    ACTION_SUMMON_TALK          = 6,
    ACTION_SUMMON_STAND_STATE   = 7,

    EVENT_START_SCENE           = 1,
    EVENT_SCENE_0               = 2,

    NPC_DISGUISED_CRUSADER      = 32241,
    NPC_GAMBIT_TIRION_FORDRING  = 32239,
    NPC_INVOKER_BASALEPH        = 32272,
    NPC_CHOSEN_ZEALOT           = 32175,
    NPC_TIRION_LICH_KING        = 32184,
    NPC_TIRION_EBON_KNIGHT      = 32309,
    NPC_TIRION_THASSARIAN       = 32310,
    NPC_TIRION_KOLTIRA          = 32311,
    NPC_TIRION_MOGRAINE         = 32312,

    GO_FROZEN_HEART             = 193794,
    GO_ESCAPE_PORTAL            = 193941,

    SPELL_TIRION_SMASH_HEART    = 60456,
    SPELL_HEART_EXPLOSION       = 60484,
    SPELL_HEART_EXPLOSION_EFF   = 60532,
    SPELL_LICH_KINGS_FURY       = 60536,
    SPELL_TIRIONS_GAMBIT_CREDIT = 61487,
};

class npc_tirions_gambit_tirion : public CreatureScript
{
public:
    npc_tirions_gambit_tirion(): CreatureScript("npc_tirions_gambit_tirion") {}

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32  /*action*/) override
    {
        CloseGossipMenuFor(player);
        creature->AI()->DoAction(ACTION_START_EVENT);
        return true;
    }

    struct npc_tirions_gambit_tirionAI : npc_escortAI
    {
        npc_tirions_gambit_tirionAI(Creature* creature) : npc_escortAI(creature), summons(me)
        {
        }

        EventMap events;
        SummonList summons;

        void Reset() override
        {
            me->setActive(false);
            me->SetStandState(UNIT_STAND_STATE_STAND);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == 1 && data == 1)
                events.ScheduleEvent(EVENT_SCENE_0 + 30, 10s);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_START_EVENT)
            {
                me->setActive(true);

                Talk(0);
                events.Reset();
                summons.DespawnAll();
                Start(false, false);

                int8 i = -1;
                std::list<Creature*> cList;
                GetCreatureListWithEntryInGrid(cList, me, NPC_DISGUISED_CRUSADER, 15.0f);
                for (std::list<Creature*>::const_iterator itr = cList.begin(); itr != cList.end(); ++itr, ++i)
                {
                    (*itr)->SetWalk(true);
                    (*itr)->GetMotionMaster()->MoveFollow(me, 1.0f, Position::NormalizeOrientation(M_PI * i / 2.0f));
                    summons.Summon(*itr);
                }
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            if (summon->GetEntry() == NPC_CHOSEN_ZEALOT || summon->GetEntry() == NPC_TIRION_LICH_KING)
                summon->SetWalk(true);
            else if (summon->GetEntry() != NPC_INVOKER_BASALEPH)
            {
                summon->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                summon->SetImmuneToAll(true);
                summon->GetMotionMaster()->MovePoint(4, 6135.97f, 2753.84f, 573.92f);
            }
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            summons.Despawn(summon);
        }

        void WaypointReached(uint32 pointId) override
        {
            switch (pointId)
            {
                case 6:
                    me->SummonCreature(NPC_INVOKER_BASALEPH, 6130.26f, 2764.83f, 573.92f, 5.19f, TEMPSUMMON_TIMED_DESPAWN, 10 * MINUTE * IN_MILLISECONDS);
                    Talk(1);
                    break;
                case 15:
                    {
                        uint8 i = 1;
                        for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr, ++i)
                            if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                                if (summon->GetEntry() == NPC_DISGUISED_CRUSADER)
                                {
                                    summon->GetMotionMaster()->Clear(false);
                                    summon->GetMotionMaster()->MovePoint(1, 6165.3f + 3 * i, 2759.85f + 1.5f * i, 573.914f);
                                }
                        break;
                    }
                case 17:
                    SetEscortPaused(true);
                    events.ScheduleEvent(EVENT_START_SCENE, 7s);
                    break;
                case 19:
                    SetEscortPaused(true);
                    events.ScheduleEvent(EVENT_SCENE_0 + 8, 5s);
                    break;
            }
        }

        void DoSummonAction(uint32 entry, uint8 id, int32 param = 0)
        {
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                    if (summon->GetEntry() == entry)
                    {
                        switch (id)
                        {
                            case ACTION_SUMMON_MOVE_STRAIGHT:
                                summon->GetMotionMaster()->MovePoint(1, summon->GetPositionX() - param, summon->GetPositionY() + param * 2 + 3, summon->GetPositionZ());
                                break;
                            case ACTION_SUMMON_EMOTE:
                                summon->SetUInt32Value(UNIT_NPC_EMOTESTATE, param);
                                break;
                            case ACTION_SUMMON_DESPAWN:
                                summon->DespawnOrUnsummon(param);
                                break;
                            case ACTION_SUMMON_ORIENTATION:
                                summon->SetFacingTo(param / 100.0f);
                                break;
                            case ACTION_SUMMON_TALK:
                                summon->AI()->Talk(param);
                                break;
                            case ACTION_SUMMON_STAND_STATE:
                                summon->SetStandState(param);
                                break;
                        }
                    }
        }

        void UpdateEscortAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_START_SCENE:
                    Talk(2);
                    DoSummonAction(NPC_DISGUISED_CRUSADER, ACTION_SUMMON_ORIENTATION, 200);

                    me->SummonCreature(NPC_CHOSEN_ZEALOT, 6160.74f, 2695.90f, 573.92f, 2.04f, TEMPSUMMON_TIMED_DESPAWN, 5 * MINUTE * IN_MILLISECONDS);
                    me->SummonCreature(NPC_CHOSEN_ZEALOT, 6164.98f, 2697.90f, 573.92f, 2.04f, TEMPSUMMON_TIMED_DESPAWN, 5 * MINUTE * IN_MILLISECONDS);
                    me->SummonCreature(NPC_CHOSEN_ZEALOT, 6161.26f, 2700.05f, 573.92f, 2.04f, TEMPSUMMON_TIMED_DESPAWN, 5 * MINUTE * IN_MILLISECONDS);

                    DoSummonAction(NPC_CHOSEN_ZEALOT, ACTION_SUMMON_MOVE_STRAIGHT, 27);
                    events.ScheduleEvent(EVENT_SCENE_0, 30s);
                    break;
                case EVENT_SCENE_0:
                    DoSummonAction(NPC_CHOSEN_ZEALOT, ACTION_SUMMON_STAND_STATE, UNIT_STAND_STATE_KNEEL);
                    me->SummonGameObject(GO_FROZEN_HEART, 6132.38f, 2760.76f, 574.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 180);
                    events.ScheduleEvent(EVENT_SCENE_0 + 1, 10s);
                    break;
                case EVENT_SCENE_0+1:
                    DoSummonAction(NPC_CHOSEN_ZEALOT, ACTION_SUMMON_STAND_STATE, UNIT_STAND_STATE_STAND);
                    events.ScheduleEvent(EVENT_SCENE_0 + 2, 2s);
                    break;
                case EVENT_SCENE_0+2:
                    DoSummonAction(NPC_CHOSEN_ZEALOT, ACTION_SUMMON_MOVE_STRAIGHT, -27);
                    DoSummonAction(NPC_CHOSEN_ZEALOT, ACTION_SUMMON_DESPAWN, 20000);
                    events.ScheduleEvent(EVENT_SCENE_0 + 3, 2s);
                    break;
                case EVENT_SCENE_0+3:
                    Talk(3);
                    if (Creature* cr = me->SummonCreature(NPC_TIRION_LICH_KING, 6161.26f, 2700.05f, 573.92f, 2.04f, TEMPSUMMON_TIMED_DESPAWN, 5 * MINUTE * IN_MILLISECONDS))
                        cr->GetMotionMaster()->MovePoint(2, 6131.93f, 2756.84f, 573.92f);
                    events.ScheduleEvent(EVENT_SCENE_0 + 4, 4s);
                    break;
                case EVENT_SCENE_0+4:
                    Talk(4);
                    me->SetFacingTo(4.42f);
                    events.ScheduleEvent(EVENT_SCENE_0 + 5, 25s);
                    break;
                case EVENT_SCENE_0+5:
                    DoSummonAction(NPC_TIRION_LICH_KING, ACTION_SUMMON_ORIENTATION, 11);
                    events.ScheduleEvent(EVENT_SCENE_0 + 6, 4s);
                    break;
                case EVENT_SCENE_0+6:
                    DoSummonAction(NPC_TIRION_LICH_KING, ACTION_SUMMON_TALK, 0);
                    me->LoadEquipment(2, true);
                    SetEscortPaused(false);
                    events.ScheduleEvent(EVENT_SCENE_0 + 7, 6s);
                    break;
                case EVENT_SCENE_0+7:
                    DoSummonAction(NPC_TIRION_LICH_KING, ACTION_SUMMON_TALK, 1);
                    break;
                case EVENT_SCENE_0+8:
                    Talk(5);
                    events.ScheduleEvent(EVENT_SCENE_0 + 9, 5s);
                    break;
                case EVENT_SCENE_0+9:
                    DoSummonAction(NPC_TIRION_LICH_KING, ACTION_SUMMON_TALK, 2);
                    events.ScheduleEvent(EVENT_SCENE_0 + 10, 11s);
                    break;
                case EVENT_SCENE_0+10:
                    Talk(6);
                    events.ScheduleEvent(EVENT_SCENE_0 + 11, 6s);
                    break;
                case EVENT_SCENE_0+11:
                    DoSummonAction(NPC_TIRION_LICH_KING, ACTION_SUMMON_TALK, 3);
                    events.ScheduleEvent(EVENT_SCENE_0 + 12, 7s);
                    break;
                case EVENT_SCENE_0+12:
                    DoSummonAction(NPC_TIRION_LICH_KING, ACTION_SUMMON_TALK, 4);
                    events.ScheduleEvent(EVENT_SCENE_0 + 13, 5s);
                    break;
                case EVENT_SCENE_0+13:
                    Talk(7);
                    events.ScheduleEvent(EVENT_SCENE_0 + 14, 14s);
                    break;
                case EVENT_SCENE_0+14:
                    Talk(8);
                    events.ScheduleEvent(EVENT_SCENE_0 + 15, 3s);
                    break;
                case EVENT_SCENE_0+15:
                    {
                        me->CastSpell(me, SPELL_TIRION_SMASH_HEART, true);
                        events.ScheduleEvent(EVENT_SCENE_0 + 16, 1200ms);
                        uint8 i = 0;
                        for (SummonList::iterator itr = summons.begin(); itr != summons.end(); ++itr, ++i)
                            if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                                if (summon->GetEntry() == NPC_DISGUISED_CRUSADER)
                                {
                                    summon->SetWalk(false);
                                    summon->GetMotionMaster()->MovePoint(2, 6132.38f + 4 * cos(2 * M_PI * (i / 3.0)), 2760.76f + 4 * std::sin(2 * M_PI * (i / 3.0)), me->GetPositionZ());
                                }
                        break;
                    }
                case EVENT_SCENE_0+16:
                    me->CastSpell(me, SPELL_HEART_EXPLOSION, true);
                    me->CastSpell(me, SPELL_HEART_EXPLOSION_EFF, true);
                    me->SetStandState(UNIT_STAND_STATE_DEAD);
                    DoSummonAction(NPC_TIRION_LICH_KING, ACTION_SUMMON_TALK, 5);
                    if (GameObject* go = me->FindNearestGameObject(GO_FROZEN_HEART, 20.0f))
                        go->Delete();
                    events.ScheduleEvent(EVENT_SCENE_0 + 17, 2s);
                    break;
                case EVENT_SCENE_0+17:
                    DoSummonAction(NPC_TIRION_LICH_KING, ACTION_SUMMON_STAND_STATE, UNIT_STAND_STATE_KNEEL);
                    events.ScheduleEvent(EVENT_SCENE_0 + 170, 3s);
                    break;
                case EVENT_SCENE_0+170:
                    DoSummonAction(NPC_DISGUISED_CRUSADER, ACTION_SUMMON_ORIENTATION, 500);
                    DoSummonAction(NPC_DISGUISED_CRUSADER, ACTION_SUMMON_EMOTE, EMOTE_STATE_READY2H);
                    if (Creature* cr = me->FindNearestCreature(NPC_DISGUISED_CRUSADER, 10.0f))
                        cr->AI()->Talk(0);
                    events.ScheduleEvent(EVENT_SCENE_0 + 18, 1s);
                    break;
                case EVENT_SCENE_0+18:
                    {
                        DoSummonAction(NPC_TIRION_LICH_KING, ACTION_SUMMON_TALK, 6);

                        std::list<Creature*> zealotList;
                        Position pos1 = {6160.0f, 2765.0f, 573.92f, 0.0f};
                        Position pos2 = {6115.0f, 2742.0f, 573.92f, 0.0f};
                        me->GetCreaturesWithEntryInRange(zealotList, 100.0f, NPC_CHOSEN_ZEALOT);
                        for (std::list<Creature*>::const_iterator itr = zealotList.begin(); itr != zealotList.end(); ++itr)
                        {
                            (*itr)->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY_UNARMED);
                            if ((*itr)->GetPositionX() > 6150.0f)
                            {
                                Position tpos = pos1;
                                (*itr)->MovePosition(tpos, frand(1.0f, 14.0f), frand(3.14f, 4.14f));
                                (*itr)->GetMotionMaster()->MovePoint(3, tpos.GetPositionX(), tpos.GetPositionY(), tpos.GetPositionZ());
                            }
                            else
                            {
                                Position tpos = pos2;
                                (*itr)->MovePosition(tpos, frand(1.0f, 14.0f), frand(0.0f, 1.0f));
                                (*itr)->GetMotionMaster()->MovePoint(3, tpos.GetPositionX(), tpos.GetPositionY(), tpos.GetPositionZ());
                            }
                        }

                        events.ScheduleEvent(EVENT_SCENE_0 + 19, 3s);
                        break;
                    }
                case EVENT_SCENE_0+19:
                    me->SummonCreatureGroup(1);
                    events.ScheduleEvent(EVENT_SCENE_0 + 20, 3700ms);
                    break;
                case EVENT_SCENE_0+20:
                    {
                        for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                            if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                            {
                                summon->SetImmuneToAll(false);
                                if (summon->GetEntry() >= NPC_TIRION_EBON_KNIGHT && summon->GetEntry() <= NPC_TIRION_MOGRAINE)
                                {
                                    if (summon->GetEntry() == NPC_TIRION_MOGRAINE)
                                        summon->SetHomePosition(6135.97f, 2753.84f, 573.92f, 3.70f);
                                    else
                                        summon->SetHomePosition(6138.36f + frand(-2.0f, 2.0f), 2749.25f + frand(-2.0f, 2.0f), 573.92f, 2.03f);
                                }
                            }
                        DoSummonAction(NPC_TIRION_THASSARIAN, ACTION_SUMMON_TALK, 0);
                        std::list<Creature*> zealotList;
                        me->GetCreaturesWithEntryInRange(zealotList, 100.0f, NPC_CHOSEN_ZEALOT);
                        Unit* target = me->FindNearestCreature(NPC_TIRION_MOGRAINE, 100.0f);
                        for (std::list<Creature*>::const_iterator itr = zealotList.begin(); itr != zealotList.end(); ++itr)
                        {
                            if (!target)
                                target = (*itr)->SelectNearestTarget(40.0f);
                            if (target)
                                (*itr)->AI()->AttackStart(target);
                        }

                        break;
                    }
                case EVENT_SCENE_0+30:
                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                            if (summon->GetEntry() >= NPC_TIRION_EBON_KNIGHT && summon->GetEntry() <= NPC_TIRION_MOGRAINE)
                            {
                                if (summon->GetEntry() == NPC_TIRION_MOGRAINE)
                                    summon->GetMotionMaster()->MovePoint(6, 6135.97f, 2753.84f, 573.92f);
                                else
                                    summon->GetMotionMaster()->MovePoint(6, 6138.36f + frand(-2.0f, 2.0f), 2749.25f + frand(-2.0f, 2.0f), 573.92f);
                            }

                    events.ScheduleEvent(EVENT_SCENE_0 + 310, 4s);
                    break;
                case EVENT_SCENE_0+310:
                    DoSummonAction(NPC_TIRION_MOGRAINE, ACTION_SUMMON_TALK, 0);
                    DoSummonAction(NPC_TIRION_LICH_KING, ACTION_SUMMON_STAND_STATE, UNIT_STAND_STATE_STAND);
                    me->SummonGameObject(GO_ESCAPE_PORTAL, 6133.83f, 2757.24f, 573.914f, 1.97f, 0.0f, 0.0f, 0.0f, 0.0f, 60);
                    me->CastSpell(me, SPELL_TIRIONS_GAMBIT_CREDIT, true);
                    events.ScheduleEvent(EVENT_SCENE_0 + 31, 6s);
                    DoSummonAction(NPC_DISGUISED_CRUSADER, ACTION_SUMMON_EMOTE, EMOTE_ONESHOT_NONE);
                    break;
                case EVENT_SCENE_0+31:
                    DoSummonAction(NPC_TIRION_THASSARIAN, ACTION_SUMMON_TALK, 1);
                    events.ScheduleEvent(EVENT_SCENE_0 + 32, 7s);
                    break;
                case EVENT_SCENE_0+32:
                    DoSummonAction(NPC_TIRION_MOGRAINE, ACTION_SUMMON_TALK, 1);
                    events.ScheduleEvent(EVENT_SCENE_0 + 33, 7s);
                    break;
                case EVENT_SCENE_0+33:
                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                        {
                            if (summon->GetEntry() == NPC_TIRION_LICH_KING)
                                summon->CastSpell(summon, SPELL_LICH_KINGS_FURY, false);
                            summon->DespawnOrUnsummon(summon->GetEntry() == NPC_TIRION_LICH_KING ? 10000 : 4000);
                        }
                    me->DespawnOrUnsummon(10000);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_tirions_gambit_tirionAI(creature);
    }
};

enum infraGreenBomberQuests
{
    SPELL_ENGINEERING           = 59193,
    SPELL_BOMBER_BAY            = 59194,
    SPELL_ANTI_AIR_TURRET       = 59196,

    SPELL_CHARGE_SHIELD         = 59061,
    SPELL_INFRA_GREEN_SHIELD    = 59288,

    SPELL_BURNING               = 61171,
    SPELL_COSMETIC_FIRE         = 51195,
    SPELL_EXTINGUISH_FIRE       = 61172,

    SPELL_WAITING_FOR_A_BOMBER  = 59563,
    SPELL_FLIGHT_ORDERS         = 61281,

    EVENT_TAKE_PASSENGER        = 1,
    EVENT_START_FLIGHT          = 2,
    EVENT_CHECK_PATH_REGEN_HEALTH_BURN_DAMAGE           = 3,
    EVENT_SYNCHRONIZE_SHIELDS   = 4,
    EVENT_SPREAD_FIRE           = 5,

    SEAT_BOMBER                 = 0,
    SEAT_TURRET                 = 1,
    SEAT_ENGINEERING            = 2
};

class spell_switch_infragreen_bomber_station : public SpellScript
{
    PrepareSpellScript(spell_switch_infragreen_bomber_station);

    uint8 GetSeatNumber(uint32 spellId)
    {
        if (spellId == SPELL_ENGINEERING)
            return 2;
        else if (spellId == SPELL_ANTI_AIR_TURRET)
            return 1;
        else
            return 0;
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Vehicle* kit = GetCaster()->GetVehicle();
        Unit* charmer = GetCaster()->GetCharmer(); // Player controlling station
        if (!kit || !charmer)
            return;

        uint8 seatNumber = GetSeatNumber(GetSpellInfo()->Id);
        SeatMap::iterator itr = kit->GetSeatIteratorForPassenger(GetCaster());
        if (itr == kit->Seats.end())
            return;

        // Xinef: Same seat, no change required
        if (seatNumber == itr->first)
            return;

        if (Unit* station = kit->GetPassenger(seatNumber))
            station->HandleSpellClick(charmer, 0);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_switch_infragreen_bomber_station::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_charge_shield_bomber : public SpellScript
{
    PrepareSpellScript(spell_charge_shield_bomber);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_INFRA_GREEN_SHIELD });
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* ship = GetCaster()->GetVehicleBase();
        if (!ship)
            return;

        ship->CastSpell(ship, SPELL_INFRA_GREEN_SHIELD, true);
        Aura* aura = ship->GetAura(SPELL_INFRA_GREEN_SHIELD);
        if (!aura)
            return;

        aura->ModStackAmount(GetEffectValue() - 1);
    }

    void Register() override
    {
        if (m_scriptSpellId == SPELL_CHARGE_SHIELD)
        OnEffectHitTarget += SpellEffectFn(spell_charge_shield_bomber::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_charge_shield_bomber_aura : public AuraScript
{
    PrepareAuraScript(spell_charge_shield_bomber_aura);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // Set absorbtion amount to unlimited
        amount = -1;
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        uint32 absorbPct = GetStackAmount() / 2;
        absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
        ModStackAmount(-1);
    }

    void Register() override
    {
        if (m_scriptSpellId == SPELL_INFRA_GREEN_SHIELD)
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_charge_shield_bomber_aura::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
            OnEffectAbsorb += AuraEffectAbsorbFn(spell_charge_shield_bomber_aura::Absorb, EFFECT_0);
        }
    }
};

class spell_fight_fire_bomber : public SpellScript
{
    PrepareSpellScript(spell_fight_fire_bomber);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_COSMETIC_FIRE, SPELL_EXTINGUISH_FIRE, SPELL_BURNING });
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Vehicle* kit = GetCaster()->GetVehicle();
        if (!kit)
            return;

        bool extinguished = false;
        uint8 fireCount = 0;
        for (uint8 seat = 3; seat <= 5; ++seat)
            if (Unit* banner = kit->GetPassenger(seat))
                if (banner->HasAura(SPELL_COSMETIC_FIRE))
                {
                    if (!extinguished)
                    {
                        GetCaster()->CastSpell(banner, SPELL_EXTINGUISH_FIRE, true);
                        extinguished = true;
                        if (urand(0, 2))
                        {
                            banner->RemoveAurasDueToSpell(SPELL_COSMETIC_FIRE);
                            continue;
                        }
                    }
                    fireCount++;
                }

        if (fireCount == 0)
            GetCaster()->RemoveAurasDueToSpell(SPELL_BURNING);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_fight_fire_bomber::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_anti_air_rocket_bomber : public SpellScript
{
    PrepareSpellScript(spell_anti_air_rocket_bomber);

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        const WorldLocation* loc = GetExplTargetDest();
        GetCaster()->CastSpell(loc->GetPositionX(), loc->GetPositionY(), loc->GetPositionZ(), GetSpellInfo()->Effects[effIndex].CalcValue(), true);
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_anti_air_rocket_bomber::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class npc_infra_green_bomber_generic : public CreatureScript
{
public:
    npc_infra_green_bomber_generic(): CreatureScript("npc_infra_green_bomber_generic") {}

    struct npc_infra_green_bomber_genericAI : NullCreatureAI
    {
        npc_infra_green_bomber_genericAI(Creature* creature) : NullCreatureAI(creature)
        {
            events.Reset();
        }

        Unit* GetSummoner()
        {
            if (TempSummon* tempSummon = me->ToTempSummon())
                return tempSummon->GetSummonerUnit();
            return nullptr;
        }

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner)
                return;

            if (!summoner->IsPlayer())
                return;

            Player* player = summoner->ToPlayer();
            if (!player)
                return;

            player->CastSpell(player, SPELL_WAITING_FOR_A_BOMBER, true);
            player->CastSpell(player, SPELL_FLIGHT_ORDERS, true);
            events.ScheduleEvent(EVENT_START_FLIGHT, 0);
            events.ScheduleEvent(EVENT_TAKE_PASSENGER, 3000);
            me->SetCanFly(true);
            me->AddUnitMovementFlag(MOVEMENTFLAG_FLYING);
            me->SetSpeed(MOVE_FLIGHT, 0.1f);
            me->SetFaction(player->GetFaction());
        }

        void DamageTaken(Unit* who, uint32&, DamageEffectType, SpellSchoolMask) override
        {
            if (who != me)
                if (me->HealthBelowPct(80) && urand(0, 1))
                    SpreadFire(true);
        }

        void SpreadFire(bool init)
        {
            Vehicle* kit = me->GetVehicleKit();
            if (!kit)
                return;

            if (Unit* passenger = kit->GetPassenger(SEAT_ENGINEERING))
                if (init && !passenger->HasAura(SPELL_BURNING))
                {
                    me->TextEmote("Your Vehicle is burning!", GetSummoner(), true);
                    passenger->AddAura(SPELL_BURNING, passenger);
                }

            for (uint8 seat = 3; seat <= 5; ++seat)
                if (Unit* banner = kit->GetPassenger(seat))
                    if (!banner->HasAura(SPELL_COSMETIC_FIRE))
                    {
                        banner->AddAura(SPELL_COSMETIC_FIRE, banner);
                        break;
                    }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            uint32 eventId = events.ExecuteEvent();
            switch (eventId)
            {
                case EVENT_TAKE_PASSENGER:
                    if (Unit* owner = GetSummoner())
                        if (Vehicle* kit = me->GetVehicleKit())
                            if (Unit* turret = kit->GetPassenger(SEAT_TURRET))
                            {
                                me->SetSpeed(MOVE_FLIGHT, 1.2f);
                                owner->RemoveAurasDueToSpell(SPELL_WAITING_FOR_A_BOMBER);
                                turret->HandleSpellClick(owner, 0);
                                return;
                            }
                    me->DespawnOrUnsummon(1);
                    break;
                case EVENT_START_FLIGHT:
                    {
                        WPPath* path = sSmartWaypointMgr->GetPath(me->GetEntry());
                        if (!path || path->empty())
                        {
                            me->DespawnOrUnsummon(1);
                            return;
                        }

                        Movement::PointsArray pathPoints;
                        pathPoints.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));

                        uint32 wpCounter = 1;
                        WPPath::const_iterator itr;
                        while ((itr = path->find(wpCounter++)) != path->end())
                        {
                            WayPoint* wp = itr->second;
                            pathPoints.push_back(G3D::Vector3(wp->x, wp->y, wp->z));
                        }

                        me->GetMotionMaster()->MoveSplinePath(&pathPoints);
                        events.ScheduleEvent(EVENT_CHECK_PATH_REGEN_HEALTH_BURN_DAMAGE, 1min);
                        events.ScheduleEvent(EVENT_SYNCHRONIZE_SHIELDS, 5s);
                        break;
                    }
                case EVENT_CHECK_PATH_REGEN_HEALTH_BURN_DAMAGE:
                    {
                        // Check if path is finished
                        if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != ESCORT_MOTION_TYPE)
                        {
                            me->DespawnOrUnsummon(1);
                            return;
                        }

                        // Check fire count
                        uint8 fireCount = 0;
                        if (Vehicle* kit = me->GetVehicleKit())
                            for (uint8 seat = 3; seat <= 5; ++seat)
                                if (Unit* banner = kit->GetPassenger(seat))
                                    if (banner->HasAura(SPELL_COSMETIC_FIRE))
                                        fireCount++;

                        if (fireCount)
                            Unit::DealDamage(me, me, 3000 * fireCount, nullptr, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_FIRE);
                        else // Heal
                            me->ModifyHealth(2000);

                        events.ScheduleEvent(EVENT_CHECK_PATH_REGEN_HEALTH_BURN_DAMAGE, 4s);
                        break;
                    }
                case EVENT_SYNCHRONIZE_SHIELDS:
                    if (Vehicle* kit = me->GetVehicleKit())
                    {
                        // Xinef: check if we have player on any of the stations
                        bool playerPresent = false;
                        uint32 stackAmount = me->GetAuraCount(SPELL_INFRA_GREEN_SHIELD);
                        for (uint8 i = SEAT_BOMBER; i <= SEAT_ENGINEERING; ++i)
                            if (Unit* station = kit->GetPassenger(i))
                            {
                                if (Vehicle* stationKit = station->GetVehicleKit())
                                    if (stationKit->GetPassenger(0))
                                        playerPresent = true;

                                if (stackAmount)
                                    station->SetAuraStack(SPELL_INFRA_GREEN_SHIELD, station, stackAmount);
                                else
                                    station->RemoveAurasDueToSpell(SPELL_INFRA_GREEN_SHIELD);
                            }
                        if (!playerPresent)
                            me->DespawnOrUnsummon(1);
                    }
                    events.ScheduleEvent(EVENT_SYNCHRONIZE_SHIELDS, 1s);
                    break;
                case EVENT_SPREAD_FIRE:
                    break;
            }
        }

    private:
        EventMap events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_infra_green_bomber_genericAI(creature);
    }
};

class spell_onslaught_or_call_bone_gryphon : public SpellScript
{
    PrepareSpellScript(spell_onslaught_or_call_bone_gryphon);

    void ChangeSummonPos(SpellEffIndex /*effIndex*/)
    {
        WorldLocation summonPos = *GetExplTargetDest();
        Position offset = { 0.0f, 0.0f, 3.0f, 0.0f };
        summonPos.RelocateOffset(offset);
        SetExplTargetDest(summonPos);
        GetHitDest()->RelocateOffset(offset);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_onslaught_or_call_bone_gryphon::ChangeSummonPos, EFFECT_0, SPELL_EFFECT_SUMMON);
    }
};

enum OnslaughtGryphon
{
    SPELL_DELIVER_GRYPHON            = 54420,
    SPELL_ONSLAUGHT_GRYPHON          = 49641,

    NPC_CAPTURED_ONSLAUGHT_GRYPHON   = 29415,

    SEAT_PLAYER                      = 0
};

class spell_deliver_gryphon : public SpellScript
{
    PrepareSpellScript(spell_deliver_gryphon);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DELIVER_GRYPHON, SPELL_ONSLAUGHT_GRYPHON });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Vehicle* gryphon = caster->GetVehicleKit())
            {
                if (Unit* player = gryphon->GetPassenger(SEAT_PLAYER))
                {
                    player->ExitVehicle();
                    player->RemoveAurasDueToSpell(VEHICLE_SPELL_PARACHUTE);
                    player->RemoveAurasDueToSpell(SPELL_ONSLAUGHT_GRYPHON);
                    player->SummonCreature(NPC_CAPTURED_ONSLAUGHT_GRYPHON, 7434.7f, 4213.3f, 316.52f, 3.88f, TEMPSUMMON_TIMED_DESPAWN, 1 * MINUTE * IN_MILLISECONDS);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_deliver_gryphon::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// Theirs
/*######
## npc_guardian_pavilion
######*/

enum GuardianPavilion
{
    SPELL_TRESPASSER_H                            = 63987,
    AREA_SUNREAVER_PAVILION                       = 4676,

    AREA_SILVER_COVENANT_PAVILION                 = 4677,
    SPELL_TRESPASSER_A                            = 63986,
};

class npc_guardian_pavilion : public CreatureScript
{
public:
    npc_guardian_pavilion() : CreatureScript("npc_guardian_pavilion") { }

    struct npc_guardian_pavilionAI : public ScriptedAI
    {
        npc_guardian_pavilionAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetCombatMovement(false);
        }

        void MoveInLineOfSight(Unit* who) override

        {
            if (me->GetAreaId() != AREA_SUNREAVER_PAVILION && me->GetAreaId() != AREA_SILVER_COVENANT_PAVILION)
                return;

            if (!who || !who->IsPlayer() || !me->IsHostileTo(who) || !me->isInBackInMap(who, 5.0f))
                return;

            if (who->HasAura(SPELL_TRESPASSER_H) || who->HasAura(SPELL_TRESPASSER_A))
                return;

            if (who->ToPlayer()->GetTeamId() == TEAM_ALLIANCE)
                who->CastSpell(who, SPELL_TRESPASSER_H, true);
            else
                who->CastSpell(who, SPELL_TRESPASSER_A, true);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_guardian_pavilionAI(creature);
    }
};

/*######
* npc_tournament_training_dummy
######*/
enum TournamentDummy
{
    NPC_CHARGE_TARGET         = 33272,
    NPC_MELEE_TARGET          = 33229,
    NPC_RANGED_TARGET         = 33243,

    SPELL_CHARGE_CREDIT       = 62658,
    SPELL_MELEE_CREDIT        = 62672,
    SPELL_RANGED_CREDIT       = 62673,

    SPELL_PLAYER_THRUST       = 62544,
    SPELL_PLAYER_BREAK_SHIELD = 62626,
    SPELL_PLAYER_CHARGE       = 62874,

    SPELL_RANGED_DEFEND       = 62719,
    SPELL_CHARGE_DEFEND       = 64100,
    SPELL_VULNERABLE          = 62665,

    SPELL_COUNTERATTACK       = 62709,

    EVENT_DUMMY_RECAST_DEFEND = 1,
    EVENT_DUMMY_RESET         = 2,
};

class npc_tournament_training_dummy : public CreatureScript
{
public:
    npc_tournament_training_dummy(): CreatureScript("npc_tournament_training_dummy") { }

    struct npc_tournament_training_dummyAI : ScriptedAI
    {
        npc_tournament_training_dummyAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetCombatMovement(false);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
        }

        EventMap events;
        bool isVulnerable;

        void Reset() override
        {
            me->SetControlled(true, UNIT_STATE_STUNNED);
            isVulnerable = false;

            // Cast Defend spells to max stack size
            switch (me->GetEntry())
            {
                case NPC_CHARGE_TARGET:
                    DoCast(SPELL_CHARGE_DEFEND);
                    break;
                case NPC_RANGED_TARGET:
                    me->CastCustomSpell(SPELL_RANGED_DEFEND, SPELLVALUE_AURA_STACK, 3, me);
                    break;
            }

            events.Reset();
            events.ScheduleEvent(EVENT_DUMMY_RECAST_DEFEND, 5s);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (!_EnterEvadeMode(why))
                return;

            Reset();
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            damage = 0;
            events.RescheduleEvent(EVENT_DUMMY_RESET, 10s);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            switch (me->GetEntry())
            {
                case NPC_CHARGE_TARGET:
                    if (spell->Id == SPELL_PLAYER_CHARGE)
                        if (isVulnerable)
                            DoCast(caster, SPELL_CHARGE_CREDIT, true);
                    break;
                case NPC_MELEE_TARGET:
                    if (spell->Id == SPELL_PLAYER_THRUST)
                    {
                        DoCast(caster, SPELL_MELEE_CREDIT, true);

                        if (Unit* target = caster->GetVehicleBase())
                            DoCast(target, SPELL_COUNTERATTACK, true);
                    }
                    break;
                case NPC_RANGED_TARGET:
                    if (spell->Id == SPELL_PLAYER_BREAK_SHIELD)
                        if (isVulnerable)
                            DoCast(caster, SPELL_RANGED_CREDIT, true);
                    break;
            }

            if (spell->Id == SPELL_PLAYER_BREAK_SHIELD)
                if (!me->HasAura(SPELL_CHARGE_DEFEND) && !me->HasAura(SPELL_RANGED_DEFEND))
                    isVulnerable = true;
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_DUMMY_RECAST_DEFEND:
                    switch (me->GetEntry())
                    {
                        case NPC_CHARGE_TARGET:
                            {
                                if (!me->HasAura(SPELL_CHARGE_DEFEND))
                                    DoCast(SPELL_CHARGE_DEFEND);
                                break;
                            }
                        case NPC_RANGED_TARGET:
                            {
                                Aura* defend = me->GetAura(SPELL_RANGED_DEFEND);
                                if (!defend || defend->GetStackAmount() < 3 || defend->GetDuration() <= 8000)
                                    DoCast(SPELL_RANGED_DEFEND);
                                break;
                            }
                    }
                    isVulnerable = false;
                    events.ScheduleEvent(EVENT_DUMMY_RECAST_DEFEND, 5s);
                    break;
                case EVENT_DUMMY_RESET:
                    if (UpdateVictim())
                    {
                        EnterEvadeMode(EVADE_REASON_OTHER);
                        events.ScheduleEvent(EVENT_DUMMY_RESET, 10s);
                    }
                    break;
            }

            if (!UpdateVictim())
                return;

            if (!me->HasUnitState(UNIT_STATE_STUNNED))
                me->SetControlled(true, UNIT_STATE_STUNNED);
        }

        void MoveInLineOfSight(Unit* /*who*/) override { }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_tournament_training_dummyAI(creature);
    }
};

// Battle for Crusaders' Pinnacle
enum BlessedBanner
{
    SPELL_BLESSING_OF_THE_CRUSADE       = 58026,
    SPELL_THREAT_PULSE                  = 58113,
    SPELL_CRUSADERS_SPIRE_VICTORY       = 58084,
    SPELL_TORCH                         = 58121,

    NPC_BLESSED_BANNER                  = 30891,
    NPC_CRUSADER_LORD_DALFORS           = 31003,
    NPC_ARGENT_BATTLE_PRIEST            = 30919,
    NPC_ARGENT_MASON                    = 30900,
    NPC_REANIMATED_CAPTAIN              = 30986,
    NPC_SCOURGE_DRUDGE                  = 30984,
    NPC_HIDEOUS_PLAGEBRINGER            = 30987,
    NPC_HALOF_THE_DEATHBRINGER          = 30989,
    NPC_LK                              = 31013,

    BANNER_SAY                          = 0, // "The Blessed Banner of the Crusade has been planted.\n Defend the banner from all attackers!"
    DALFORS_SAY_PRE_1                   = 0, // "BY THE LIGHT! Those damned monsters! Look at what they've done to our people!"
    DALFORS_SAY_PRE_2                   = 1, // "Burn it down, boys. Burn it all down."
    DALFORS_SAY_START                   = 2, // "Let 'em come. They'll pay for what they've done!"
    DALFORS_YELL_FINISHED               = 3, // "We've done it, lads! We've taken the pinnacle from the Scourge! Report to Father Gustav at once and tell him the good news! We're gonna get to buildin' and settin' up! Go!"
    LK_TALK_1                           = 0, // "Leave no survivors!"
    LK_TALK_2                           = 1, // "Cower before my terrible creations!"
    LK_TALK_3                           = 2, // "Feast my children! Feast upon the flesh of the living!"
    LK_TALK_4                           = 3, // "Lay down your arms and surrender your souls!"

    EVENT_SPAWN                         = 1,
    EVENT_INTRO_1                       = 2,
    EVENT_INTRO_2                       = 3,
    EVENT_INTRO_3                       = 4,
    EVENT_MASON_ACTION                  = 5,
    EVENT_START_FIGHT                   = 6,
    EVENT_WAVE_SPAWN                    = 7,
    EVENT_HALOF                         = 8,
    EVENT_ENDED                         = 9,
};

Position const DalforsPos[3] =
{
    {6458.703f, 403.858f, 490.498f, 3.1205f}, // Dalfors spawn point
    {6422.950f, 423.335f, 510.451f, 0.0f}, // Dalfors intro pos
    {6426.343f, 420.515f, 508.650f, 0.0f}, // Dalfors fight pos
};

Position const Priest1Pos[2] =
{
    {6462.025f, 403.681f, 489.721f, 3.1007f}, // priest1 spawn point
    {6421.480f, 423.576f, 510.781f, 5.7421f}, // priest1 intro pos
};

Position const Priest2Pos[2] =
{
    {6463.969f, 407.198f, 489.240f, 2.2689f}, // priest2 spawn point
    {6419.778f, 421.404f, 510.972f, 5.7421f}, // priest2 intro pos
};

Position const Priest3Pos[2] =
{
    {6464.371f, 400.944f, 489.186f, 6.1610f}, // priest3 spawn point
    {6423.516f, 425.782f, 510.774f, 5.7421f}, // priest3 intro pos
};

Position const Mason1Pos[3] =
{
    {6462.929f, 409.826f, 489.392f, 3.0968f}, // mason1 spawn point
    {6428.163f, 421.960f, 508.297f, 0.0f}, // mason1 intro pos
    {6414.335f, 454.904f, 511.395f, 2.8972f}, // mason1 action pos
};

Position const Mason2Pos[3] =
{
    {6462.650f, 405.670f, 489.576f, 2.9414f}, // mason2 spawn point
    {6426.250f, 419.194f, 508.219f, 0.0f}, // mason2 intro pos
    {6415.014f, 446.849f, 511.395f, 3.1241f}, // mason2 action pos
};

Position const Mason3Pos[3] =
{
    {6462.646f, 401.218f, 489.601f, 2.7864f}, // mason3 spawn point
    {6423.855f, 416.598f, 508.305f, 0.0f}, // mason3 intro pos
    {6417.070f, 438.824f, 511.395f, 3.6651f}, // mason3 action pos
};

class npc_blessed_banner : public CreatureScript
{
public:
    npc_blessed_banner() : CreatureScript("npc_blessed_banner") { }

    struct npc_blessed_bannerAI : public ScriptedAI
    {
        npc_blessed_bannerAI(Creature* creature) : ScriptedAI(creature), Summons(me)
        {
            HalofSpawned = false;
            PhaseCount = 0;
            Summons.DespawnAll();

            me->SetCombatMovement(false);
        }

        EventMap events;

        bool HalofSpawned;

        uint32 PhaseCount;

        SummonList Summons;

        ObjectGuid guidDalfors;
        ObjectGuid guidPriest[3];
        ObjectGuid guidMason[3];
        ObjectGuid guidHalof;

        void Reset() override
        {
            me->SetRegeneratingHealth(false);
            DoCast(SPELL_THREAT_PULSE);
            Talk(BANNER_SAY);
            events.ScheduleEvent(EVENT_SPAWN, 3s);
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void MoveInLineOfSight(Unit* /*who*/) override { }

        void JustSummoned(Creature* Summoned) override
        {
            Summons.Summon(Summoned);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Summons.DespawnAll();
            me->DespawnOrUnsummon();
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_SPAWN:
                    {
                        if (Creature* Dalfors = DoSummon(NPC_CRUSADER_LORD_DALFORS, DalforsPos[0]))
                        {
                            guidDalfors = Dalfors->GetGUID();
                            Dalfors->GetMotionMaster()->MovePoint(0, DalforsPos[1]);
                        }
                        if (Creature* Priest1 = DoSummon(NPC_ARGENT_BATTLE_PRIEST, Priest1Pos[0]))
                        {
                            guidPriest[0] = Priest1->GetGUID();
                            Priest1->GetMotionMaster()->MovePoint(0, Priest1Pos[1]);
                        }
                        if (Creature* Priest2 = DoSummon(NPC_ARGENT_BATTLE_PRIEST, Priest2Pos[0]))
                        {
                            guidPriest[1] = Priest2->GetGUID();
                            Priest2->GetMotionMaster()->MovePoint(0, Priest2Pos[1]);
                        }
                        if (Creature* Priest3 = DoSummon(NPC_ARGENT_BATTLE_PRIEST, Priest3Pos[0]))
                        {
                            guidPriest[2] = Priest3->GetGUID();
                            Priest3->GetMotionMaster()->MovePoint(0, Priest3Pos[1]);
                        }
                        if (Creature* Mason1 = DoSummon(NPC_ARGENT_MASON, Mason1Pos[0]))
                        {
                            guidMason[0] = Mason1->GetGUID();
                            Mason1->GetMotionMaster()->MovePoint(0, Mason1Pos[1]);
                        }
                        if (Creature* Mason2 = DoSummon(NPC_ARGENT_MASON, Mason2Pos[0]))
                        {
                            guidMason[1] = Mason2->GetGUID();
                            Mason2->GetMotionMaster()->MovePoint(0, Mason2Pos[1]);
                        }
                        if (Creature* Mason3 = DoSummon(NPC_ARGENT_MASON, Mason3Pos[0]))
                        {
                            guidMason[2] = Mason3->GetGUID();
                            Mason3->GetMotionMaster()->MovePoint(0, Mason3Pos[1]);
                        }
                        events.ScheduleEvent(EVENT_INTRO_1, 15s);
                    }
                    break;
                case EVENT_INTRO_1:
                    {
                        if (Creature* Dalfors = ObjectAccessor::GetCreature(*me, guidDalfors))
                            Dalfors->AI()->Talk(DALFORS_SAY_PRE_1);
                        events.ScheduleEvent(EVENT_INTRO_2, 5s);
                    }
                    break;
                case EVENT_INTRO_2:
                    {
                        if (Creature* Dalfors = ObjectAccessor::GetCreature(*me, guidDalfors))
                        {
                            Dalfors->SetFacingTo(6.215f);
                            Dalfors->AI()->Talk(DALFORS_SAY_PRE_2);
                        }
                        events.ScheduleEvent(EVENT_INTRO_3, 5s);
                    }
                    break;
                case EVENT_INTRO_3:
                    {
                        if (Creature* Dalfors = ObjectAccessor::GetCreature(*me, guidDalfors))
                        {
                            Dalfors->GetMotionMaster()->MovePoint(0, DalforsPos[2]);
                            Dalfors->SetHomePosition(DalforsPos[2]);
                        }
                        if (Creature* Priest1 = ObjectAccessor::GetCreature(*me, guidPriest[0]))
                        {
                            Priest1->SetFacingTo(5.7421f);
                            Priest1->SetHomePosition(Priest1Pos[1]);
                        }
                        if (Creature* Priest2 = ObjectAccessor::GetCreature(*me, guidPriest[1]))
                        {
                            Priest2->SetFacingTo(5.7421f);
                            Priest2->SetHomePosition(Priest2Pos[1]);
                        }
                        if (Creature* Priest3 = ObjectAccessor::GetCreature(*me, guidPriest[2]))
                        {
                            Priest3->SetFacingTo(5.7421f);
                            Priest3->SetHomePosition(Priest3Pos[1]);
                        }
                        if (Creature* Mason1 = ObjectAccessor::GetCreature(*me, guidMason[0]))
                        {
                            Mason1->GetMotionMaster()->MovePoint(0, Mason1Pos[2]);
                            Mason1->SetHomePosition(Mason1Pos[2]);
                        }
                        if (Creature* Mason2 = ObjectAccessor::GetCreature(*me, guidMason[1]))
                        {
                            Mason2->GetMotionMaster()->MovePoint(0, Mason2Pos[2]);
                            Mason2->SetHomePosition(Mason2Pos[2]);
                        }
                        if (Creature* Mason3 = ObjectAccessor::GetCreature(*me, guidMason[2]))
                        {
                            Mason3->GetMotionMaster()->MovePoint(0, Mason3Pos[2]);
                            Mason3->SetHomePosition(Mason3Pos[2]);
                        }
                        events.ScheduleEvent(EVENT_START_FIGHT, 5s);
                        events.ScheduleEvent(EVENT_MASON_ACTION, 15s);
                    }
                    break;
                case EVENT_MASON_ACTION:
                    {
                        if (Creature* Mason1 = ObjectAccessor::GetCreature(*me, guidMason[0]))
                        {
                            Mason1->SetFacingTo(2.8972f);
                            Mason1->AI()->SetData(1, 1); // triggers SAI actions on npc
                        }
                        if (Creature* Mason2 = ObjectAccessor::GetCreature(*me, guidMason[1]))
                        {
                            Mason2->SetFacingTo(3.1241f);
                            Mason2->AI()->SetData(1, 1); // triggers SAI actions on npc
                        }
                        if (Creature* Mason3 = ObjectAccessor::GetCreature(*me, guidMason[2]))
                        {
                            Mason3->SetFacingTo(3.6651f);
                            Mason3->AI()->SetData(1, 1); // triggers SAI actions on npc
                        }
                    }
                    break;
                case EVENT_START_FIGHT:
                    {
                        if (Creature* LK = GetClosestCreatureWithEntry(me, NPC_LK, 100))
                            LK->AI()->Talk(LK_TALK_1);
                        if (Creature* Dalfors = ObjectAccessor::GetCreature(*me, guidDalfors))
                            Dalfors->AI()->Talk(DALFORS_SAY_START);
                        events.ScheduleEvent(EVENT_WAVE_SPAWN, 1s);
                    }
                    break;
                case EVENT_WAVE_SPAWN:
                    {
                        if (PhaseCount == 3)
                        {
                            if (Creature* LK = GetClosestCreatureWithEntry(me, NPC_LK, 100))
                                LK->AI()->Talk(LK_TALK_2);
                        }
                        else if (PhaseCount == 6)
                        {
                            if (Creature* LK = GetClosestCreatureWithEntry(me, NPC_LK, 100))
                                LK->AI()->Talk(LK_TALK_3);
                        }
                        if (Creature* tempsum = DoSummon(NPC_SCOURGE_DRUDGE, Mason3Pos[0]))
                        {
                            tempsum->SetHomePosition(DalforsPos[2]);
                            tempsum->AI()->AttackStart(GetClosestCreatureWithEntry(me, NPC_BLESSED_BANNER, 100));
                        }
                        if (urand(0, 1) == 0)
                        {
                            if (Creature* tempsum = DoSummon(NPC_HIDEOUS_PLAGEBRINGER, Mason1Pos[0]))
                            {
                                tempsum->SetHomePosition(DalforsPos[2]);
                                tempsum->AI()->AttackStart(GetClosestCreatureWithEntry(me, NPC_BLESSED_BANNER, 100));
                            }
                            if (Creature* tempsum = DoSummon(NPC_HIDEOUS_PLAGEBRINGER, Mason2Pos[0]))
                            {
                                tempsum->SetHomePosition(DalforsPos[2]);
                                tempsum->AI()->AttackStart(GetClosestCreatureWithEntry(me, NPC_BLESSED_BANNER, 100));
                            }
                        }
                        else
                        {
                            if (Creature* tempsum = DoSummon(NPC_REANIMATED_CAPTAIN, Mason1Pos[0]))
                            {
                                tempsum->SetHomePosition(DalforsPos[2]);
                                tempsum->AI()->AttackStart(GetClosestCreatureWithEntry(me, NPC_BLESSED_BANNER, 100));
                            }
                            if (Creature* tempsum = DoSummon(NPC_REANIMATED_CAPTAIN, Mason2Pos[0]))
                            {
                                tempsum->SetHomePosition(DalforsPos[2]);
                                tempsum->AI()->AttackStart(GetClosestCreatureWithEntry(me, NPC_BLESSED_BANNER, 100));
                            }
                        }

                        PhaseCount++;

                        if (PhaseCount < 8)
                            events.ScheduleEvent(EVENT_WAVE_SPAWN, 10s, 20s);
                        else
                            events.ScheduleEvent(EVENT_HALOF, 10s, 20s);
                    }
                    break;
                case EVENT_HALOF:
                    {
                        if (Creature* LK = GetClosestCreatureWithEntry(me, NPC_LK, 100))
                            LK->AI()->Talk(LK_TALK_4);
                        if (Creature* tempsum = DoSummon(NPC_SCOURGE_DRUDGE, Mason1Pos[0]))
                        {
                            tempsum->SetHomePosition(DalforsPos[2]);
                            tempsum->AI()->AttackStart(GetClosestCreatureWithEntry(me, NPC_BLESSED_BANNER, 100));
                        }
                        if (Creature* tempsum = DoSummon(NPC_SCOURGE_DRUDGE, Mason2Pos[0]))
                        {
                            tempsum->SetHomePosition(DalforsPos[2]);
                            tempsum->AI()->AttackStart(GetClosestCreatureWithEntry(me, NPC_BLESSED_BANNER, 100));
                        }
                        if (Creature* tempsum = DoSummon(NPC_HALOF_THE_DEATHBRINGER, DalforsPos[0]))
                        {
                            HalofSpawned = true;
                            guidHalof = tempsum->GetGUID();
                            tempsum->SetHomePosition(DalforsPos[2]);
                            tempsum->AI()->AttackStart(GetClosestCreatureWithEntry(me, NPC_BLESSED_BANNER, 100));
                        }
                    }
                    break;
                case EVENT_ENDED:
                    {
                        Summons.DespawnAll();
                        me->DespawnOrUnsummon();
                    }
                    break;
            }

            if (PhaseCount == 8)
                if (Creature* Halof = ObjectAccessor::GetCreature(*me, guidHalof))
                    if (Halof->isDead())
                    {
                        DoCast(me, SPELL_CRUSADERS_SPIRE_VICTORY, true);
                        Summons.DespawnEntry(NPC_HIDEOUS_PLAGEBRINGER);
                        Summons.DespawnEntry(NPC_REANIMATED_CAPTAIN);
                        Summons.DespawnEntry(NPC_SCOURGE_DRUDGE);
                        Summons.DespawnEntry(NPC_HALOF_THE_DEATHBRINGER);
                        if (Creature* Dalfors = ObjectAccessor::GetCreature(*me, guidDalfors))
                            Dalfors->AI()->Talk(DALFORS_YELL_FINISHED);
                        events.ScheduleEvent(EVENT_ENDED, 10s);
                    }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_blessed_bannerAI(creature);
    }
};

/*######
## Borrowed Technology - Id: 13291, The Solution Solution (daily) - Id: 13292, Volatility - Id: 13239, Volatiliy - Id: 13261 (daily)
######*/

enum BorrowedTechnologyAndVolatility
{
    // Spells
    SPELL_GRAB             = 59318,
    SPELL_PING_BUNNY       = 59375,
    SPELL_IMMOLATION       = 54690,
    SPELL_EXPLOSION        = 59335,
    SPELL_RIDE             = 56687,

    // Points
    POINT_GRAB_DECOY       = 1,
    POINT_FLY_AWAY         = 2,

    // Events
    EVENT_FLY_AWAY         = 1
};

class npc_frostbrood_skytalon : public CreatureScript
{
public:
    npc_frostbrood_skytalon() : CreatureScript("npc_frostbrood_skytalon") { }

    struct npc_frostbrood_skytalonAI : public VehicleAI
    {
        npc_frostbrood_skytalonAI(Creature* creature) : VehicleAI(creature) { }

        EventMap events;

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner)
                return;

            me->GetMotionMaster()->MovePoint(POINT_GRAB_DECOY, summoner->GetPositionX(), summoner->GetPositionY(), summoner->GetPositionZ() + 3.0f);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == POINT_GRAB_DECOY)
                if (TempSummon* summon = me->ToTempSummon())
                    if (Unit* summoner = summon->GetSummonerUnit())
                        DoCast(summoner, SPELL_GRAB);
        }

        void UpdateAI(uint32 diff) override
        {
            VehicleAI::UpdateAI(diff);
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                if (eventId == EVENT_FLY_AWAY)
                {
                    Position randomPosOnRadius;
                    randomPosOnRadius.m_positionZ = (me->GetPositionZ() + 40.0f);
                    me->GetNearPoint2D(randomPosOnRadius.m_positionX, randomPosOnRadius.m_positionY, 40.0f, me->GetAngle(me));
                    me->GetMotionMaster()->MovePoint(POINT_FLY_AWAY, randomPosOnRadius);
                }
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            switch (spell->Id)
            {
                case SPELL_EXPLOSION:
                    DoCast(me, SPELL_IMMOLATION);
                    break;
                case SPELL_RIDE:
                    DoCastAOE(SPELL_PING_BUNNY);
                    events.ScheduleEvent(EVENT_FLY_AWAY, 100ms);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_frostbrood_skytalonAI(creature);
    }
};

void AddSC_icecrown()
{
    // Ours
    new npc_black_knight_graveyard();
    new npc_battle_at_valhalas();
    new npc_llod_generic();
    new npc_lord_arete();
    new npc_boneguard_footman();
    new npc_tirions_gambit_tirion();
    RegisterSpellScript(spell_switch_infragreen_bomber_station);
    RegisterSpellAndAuraScriptPair(spell_charge_shield_bomber, spell_charge_shield_bomber_aura);
    RegisterSpellScript(spell_fight_fire_bomber);
    RegisterSpellScript(spell_anti_air_rocket_bomber);
    new npc_infra_green_bomber_generic();
    RegisterSpellScript(spell_onslaught_or_call_bone_gryphon);
    RegisterSpellScript(spell_deliver_gryphon);

    // Theirs
    new npc_guardian_pavilion();
    new npc_tournament_training_dummy();
    new npc_blessed_banner();
    new npc_frostbrood_skytalon();
}
