/*
   Script by: r0m1ntik
   Date: 13.04.2018
*/

#include <cstring>
#include "Chat.h"
#include "Chat.h"
#include "Pet.h"
#include "Player.h"
#include "GossipDef.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "WorldSession.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "TrainerClass.h"

#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

using namespace std;

class npc_trainer : public CreatureScript
{
public:
    npc_trainer() : CreatureScript("npc_trainer") { }

    void static CreatePet(Player *player, Creature * creature, uint32 entry)
    {
        if (player->getClass() != CLASS_HUNTER)
        {
            player->PlayerTalkClass->SendCloseGossip();
            return;
        }

        if (player->GetPet())
        {
            ChatHandler(player->GetSession()).SendSysMessage(GetText(player, RU_player_learn_13, EN_player_learn_13));
            player->PlayerTalkClass->SendCloseGossip();
            return;
        }

        creature->CastSpell(player, entry);
        Pet* newpet = player->GetPet();
        if (newpet)
        {
            //because feed your pet is boring
            newpet->SetPower(POWER_HAPPINESS, 1048000);

            // prepare visual effect for levelup
            newpet->SetUInt32Value(UNIT_FIELD_LEVEL, player->getLevel() - 1);
            newpet->GetMap()->AddToMap(newpet->ToCreature());

            // visual effect for levelup
            newpet->SetUInt32Value(UNIT_FIELD_LEVEL, player->getLevel());
            newpet->SavePetToDB(PET_SAVE_AS_CURRENT);
            newpet->InitTalentForLevel();
        }
        player->PlayerTalkClass->SendCloseGossip();
    }

    void learnSpellOnStart(Player* player)
    {
        switch (player->getClass())
        {
            case CLASS_WARRIOR:
            {
                for (const auto& i: WAR_SPELL) {
                    if (!player->HasSpell(i)) {
                        player->learnSpell(i);
                    }
                }

                /* exeptions */
                if (player->HasSpell(12294)) {
                    if (!player->HasSpell(47486))
                        player->learnSpell(47486);
                }
                if (player->HasSpell(20243)) {
                    if (!player->HasSpell(47498))
                        player->learnSpell(47498);
                }
                player->SaveToDB(false, false);
                break;
            }
            case CLASS_PALADIN:
            {
                for (const auto& i: PAL_SPELL) {
                    if (!player->HasSpell(i)) {
                        player->learnSpell(i);
                    }
                }

                if (player->HasSpell(20925)) {
                    if (!player->HasSpell(48952))
                        player->learnSpell(48952);
                }
                if (player->HasSpell(31935)) {
                    if (!player->HasSpell(48827))
                        player->learnSpell(48827);
                }
                if (player->HasSpell(20911)) {
                    if (!player->HasSpell(25899))
                        player->learnSpell(25899);
                }
                if (player->HasSpell(20473)) {
                    if (!player->HasSpell(48825))
                        player->learnSpell(48825);
                }

                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    if (!player->HasSpell(31801))
                        player->learnSpell(31801);
                    if (!player->HasSpell(13819))
                        player->learnSpell(13819);
                    if (!player->HasSpell(23214))
                        player->learnSpell(23214);
                }
                if (player->GetTeamId() == TEAM_HORDE)
                {
                    if (!player->HasSpell(53736))
                        player->learnSpell(53736);
                    if (!player->HasSpell(34769))
                        player->learnSpell(34769);
                    if (!player->HasSpell(34767))
                        player->learnSpell(34767);
                }
                player->SaveToDB(false, false);
                break;
            }
            case CLASS_HUNTER:
            {
                for (const auto& i: HUNT_SPELL) {
                    if (!player->HasSpell(i)) {
                        player->learnSpell(i);
                    }
                }

                if (player->HasSpell(19386))
                    if (!player->HasSpell(49012))
                        player->learnSpell(49012);
                if (player->HasSpell(53301))
                    if (!player->HasSpell(60053))
                        player->learnSpell(60053);
                if (player->HasSpell(19306))
                    if (!player->HasSpell(48999))
                        player->learnSpell(48999);
                if (player->HasSpell(19434))
                    if (!player->HasSpell(49050))
                        player->learnSpell(49050);
                player->SaveToDB(false, false);
                break;
            }
            case CLASS_MAGE:
            {
                for (const auto& i: MAGE_SPELL) {
                    if (!player->HasSpell(i)) {
                        player->learnSpell(i);
                    }
                }

                if (player->HasSpell(11366))
                    if (!player->HasSpell(42891))
                        player->learnSpell(42891);
                if (player->HasSpell(11426))
                    if (!player->HasSpell(43039))
                        player->learnSpell(43039);
                if (player->HasSpell(44457))
                    if (!player->HasSpell(55360))
                        player->learnSpell(55360);
                if (player->HasSpell(31661))
                    if (!player->HasSpell(42950))
                        player->learnSpell(42950);
                if (player->HasSpell(11113))
                    if (!player->HasSpell(42945))
                        player->learnSpell(42945);
                if (player->HasSpell(44425))
                    if (!player->HasSpell(44781))
                        player->learnSpell(44781);
                player->SaveToDB(false, false);
                break;
            }
            case CLASS_WARLOCK:
            {
                for (const auto& i: WARLOCK_SPELL) {
                    if (!player->HasSpell(i)) {
                        player->learnSpell(i);
                    }
                }

                if (player->HasSpell(17877))
                    if (!player->HasSpell(47827))
                        player->learnSpell(47827);
                if (player->HasSpell(30283))
                     if (!player->HasSpell(47847))
                        player->learnSpell(47847);
                if (player->HasSpell(30108))
                    if (!player->HasSpell(47843))
                        player->learnSpell(47843);
                if (player->HasSpell(50796))
                    if (!player->HasSpell(59172))
                        player->learnSpell(59172);
                if (player->HasSpell(48181))
                    if (!player->HasSpell(59164))
                        player->learnSpell(59164);
                if (player->HasSpell(18220))
                    if (!player->HasSpell(59092))
                        player->learnSpell(59092);
                player->SaveToDB(false, false);
                break;
            }
            case CLASS_ROGUE:
            {
                for (const auto& i: ROGUE_SPELL) {
                    if (!player->HasSpell(i)) {
                        player->learnSpell(i);
                    }
                }

                if (player->HasSpell(16511))
                    if (!player->HasSpell(48660))
                        player->learnSpell(48660);
                if (player->HasSpell(1329))
                    if (!player->HasSpell(48666))
                        player->learnSpell(48666);
                player->SaveToDB(false, false);
                break;
            }
            case CLASS_PRIEST:
            {
                for (const auto& i: PRIEST_SPELL) {
                    if (!player->HasSpell(i)) {
                        player->learnSpell(i);
                    }
                }

                if (player->HasSpell(34914))
                    if (!player->HasSpell(48160))
                        player->learnSpell(48160);
                if (player->HasSpell(47540))
                    if (!player->HasSpell(53007))
                        player->learnSpell(53007);
                if (player->HasSpell(724))
                    if (!player->HasSpell(48087))
                        player->learnSpell(48087);
                if (player->HasSpell(19236))
                    if (!player->HasSpell(48173))
                        player->learnSpell(48173);
                if (player->HasSpell(34861))
                    if (!player->HasSpell(48089))
                        player->learnSpell(48089);
                if (player->HasSpell(15407))
                    if (!player->HasSpell(48156))
                        player->learnSpell(48156);
                player->SaveToDB(false, false);
                break;
            }
            case CLASS_DEATH_KNIGHT:
            {
                for (const auto& i: DK_SPELL) {
                    if (!player->HasSpell(i)) {
                        player->learnSpell(i);
                    }
                }

                if (player->HasSpell(55050))
                    if (!player->HasSpell(55262))
                        player->learnSpell(55262);
                if (player->HasSpell(49143))
                    if (!player->HasSpell(55268))
                        player->learnSpell(55268);
                if (player->HasSpell(49184))
                    if (!player->HasSpell(51411))
                        player->learnSpell(51411);
                if (player->HasSpell(55090))
                    if (!player->HasSpell(55271))
                        player->learnSpell(55271);
                if (player->HasSpell(49158))
                    if (!player->HasSpell(51328))
                        player->learnSpell(51328);
                player->SaveToDB(false, false);
                break;
            }
            case CLASS_SHAMAN:
            {
                for (const auto& i: SHAMAN_SPELL) {
                    if (!player->HasSpell(i)) {
                        player->learnSpell(i);
                    }
                }

                if (player->GetTeamId() == TEAM_ALLIANCE)
                    if (!player->HasSpell(32182))
                        player->learnSpell(32182);
                if (player->GetTeamId() == TEAM_HORDE)
                    if (!player->HasSpell(2825))
                        player->learnSpell(2825);
                if (player->HasSpell(61295))
                    if (!player->HasSpell(61301))
                        player->learnSpell(61301);
                if (player->HasSpell(974))
                    if (!player->HasSpell(49284))
                        player->learnSpell(49284);
                if (player->HasSpell(30706))
                    if (!player->HasSpell(57722))
                        player->learnSpell(57722);
                if (player->HasSpell(51490))
                    if (!player->HasSpell(59159))
                        player->learnSpell(59159);
                player->SaveToDB(false, false);
                break;
            }
            case CLASS_DRUID:
            {
                for (const auto& i: DRUID_SPELL) {
                    if (!player->HasSpell(i)) {
                        player->learnSpell(i);
                    }
                }

                if (player->HasSpell(50516))
                    if (!player->HasSpell(61384))
                        player->learnSpell(61384);
                if (player->HasSpell(48505))
                    if (!player->HasSpell(53201))
                        player->learnSpell(53201);
                if (player->HasSpell(48438))
                    if (!player->HasSpell(53251))
                        player->learnSpell(53251);
                if (player->HasSpell(5570))
                    if (!player->HasSpell(48468))
                        player->learnSpell(48468);
                if (player->HasSpell(49377))
                {
                    if (!player->HasSpell(16979))
                        player->learnSpell(16979);
                    if (!player->HasSpell(49376))
                        player->learnSpell(49376);
                }
                if (player->HasSpell(33917))
                {
                    if (!player->HasSpell(48566))
                        player->learnSpell(48566);
                    if (!player->HasSpell(48564))
                        player->learnSpell(48564);
                }
                player->SaveToDB(false, false);
                break;
            }
        }
        return;
    }

    void DisplayExoticPetMenu(Player* player, Creature* creature)
    {
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_1, EN_player_learn_1), GOSSIP_SENDER_MAIN, 23);
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_2, EN_player_learn_2), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_CORE_HOUND);
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_3, EN_player_learn_3), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_DEVILSAUR);
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_4, EN_player_learn_4), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_RHINO);
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_5, EN_player_learn_5), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_SILITHID);
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_6, EN_player_learn_6), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_WORM);
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_7, EN_player_learn_7), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_SPIRIT_BEAST);
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        std::string name = player->GetName();
        std::ostringstream info;

        if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
            info << "Приветствую, " << name << "\n\nИзучение заклинаний происходит автоматически\nПосле прокачки талантов заклинание автоматически поднимается до |cff065961максимального уровня|r.";
        if (player->GetSession()->GetSessionDbLocaleIndex() != LOCALE_ruRU)
            info << "Greetings, " << name << "\n\nThe spellcasting takes place automatically\nAfter the talent is pumped, the spell automatically rises to the |cff065961maximum level|r";

        if (player->getClass() == CLASS_HUNTER)
        {
            player->PlayerTalkClass->ClearMenus();
            if (player->CanTameExoticPets())
                AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GetText(player, RU_player_learn_15, EN_player_learn_15), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NEWPET_EXOTIC);
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GetText(player, RU_player_learn_16, EN_player_learn_16), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NEWPET);
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GetText(player, RU_player_learn_17, EN_player_learn_17), GOSSIP_SENDER_MAIN, 7);
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GetText(player, RU_player_learn_18, EN_player_learn_18), GOSSIP_SENDER_MAIN, 8);
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GetText(player, RU_player_learn_19, EN_player_learn_19), GOSSIP_SENDER_MAIN, 9);
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GetText(player, RU_player_learn_20, EN_player_learn_20), GOSSIP_SENDER_MAIN, GOSSIP_RESET_TAL);
        }

        AddGossipItemFor(player, 4, GetText(player, RU_player_learn_12, EN_player_learn_12), GOSSIP_SENDER_MAIN, 1, GetText(player, "Вы уверены что хотите сбросить свои таланты ?", "Are you sure you want to reset your talents?"), 0, false);
        AddGossipItemFor(player, 4, GetText(player, RU_player_learn_49, EN_player_learn_49), GOSSIP_SENDER_MAIN, 10);
        AddGossipItemFor(player, 4, GetText(player, RU_player_learn_8, EN_player_learn_8), GOSSIP_SENDER_MAIN, 3);
        AddGossipItemFor(player, 4, GetText(player, RU_player_learnspell, EN_player_learnspell), GOSSIP_SENDER_MAIN, 2);
        player->PlayerTalkClass->SendGossipMenu(info.str().c_str(), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (sender == GOSSIP_SENDER_MAIN)
        {
            switch (action)
            {
                case GOSSIP_RESET_TAL:
                {
                    Pet* pet = player->GetPet();
                    pet->resetTalentsForAllPetsOf(player, pet);
                    if (pet)
                        player->SendTalentsInfoData(true);
                    player->PlayerTalkClass->SendCloseGossip();
                    break;
                }
                case 1:
                {
                    player->resetTalents(true);
                    player->SendTalentsInfoData(false);
                    ChatHandler(player->GetSession()).SendSysMessage(GetText(player, RU_player_learn_47, EN_player_learn_47));
                    player->PlayerTalkClass->SendCloseGossip();
                    break;
                }
                case 2:
                    OnGossipHello(player, creature);
                    break;
                case 3:
                {
                    switch(player->getClass())
                    {
                        case CLASS_PRIEST:
                             player->GetSession()->SendListInventory(creature->GetGUID(), 44042); // ok
                             break;
                         case CLASS_PALADIN:
                             player->GetSession()->SendListInventory(creature->GetGUID(), 44035); // ok
                             break;
                         case CLASS_WARRIOR:
                             player->GetSession()->SendListInventory(creature->GetGUID(), 44034); // ok
                             break;
                         case CLASS_MAGE:
                             player->GetSession()->SendListInventory(creature->GetGUID(), 44041); // ok
                             break;
                         case CLASS_WARLOCK:
                             player->GetSession()->SendListInventory(creature->GetGUID(), 44043); // ok
                             break;
                         case CLASS_SHAMAN:
                             player->GetSession()->SendListInventory(creature->GetGUID(), 44037); // ok
                             break;
                         case CLASS_DRUID:
                             player->GetSession()->SendListInventory(creature->GetGUID(), 44040); // ok
                             break;
                         case CLASS_HUNTER:
                             player->GetSession()->SendListInventory(creature->GetGUID(), 44036); // ok
                             break;
                         case CLASS_ROGUE:
                             player->GetSession()->SendListInventory(creature->GetGUID(), 44039); // ok
                             break;
                         case CLASS_DEATH_KNIGHT:
                             player->GetSession()->SendListInventory(creature->GetGUID(), 44038); // ok
                             break;
                        default:
                            break;
                    }
                } break;

                case GOSSIP_OPTION_NEWPET_EXOTIC:
                    DisplayExoticPetMenu(player, creature);
                    break;
                case 23:
                    CreatePet(player, creature, SPELL_PET_CHIMAERA);
                    break;
                case GOSSIP_OPTION_CORE_HOUND:
                    CreatePet(player, creature, SPELL_PET_CORE_HOUND);
                    break;
                case GOSSIP_OPTION_DEVILSAUR:
                    CreatePet(player, creature, SPELL_PET_DEVILSAUR);
                    break;
                case GOSSIP_OPTION_RHINO:
                    CreatePet(player, creature, SPELL_PET_RHINO);
                    break;
                case GOSSIP_OPTION_SILITHID:
                    CreatePet(player, creature, SPELL_PET_SILITHID);
                    break;
                case GOSSIP_OPTION_WORM:
                    CreatePet(player, creature, SPELL_PET_WORM);
                    break;
                case GOSSIP_OPTION_SPIRIT_BEAST:
                    CreatePet(player, creature, SPELL_PET_SPIRIT_BEAST);
                    break;
                case GOSSIP_OPTION_NEWPET:
                {
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_21, EN_player_learn_21), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_BAT);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_22, EN_player_learn_22), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_BOAR);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_23, EN_player_learn_23), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_BEAR);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_24, EN_player_learn_24), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_CAT);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_25, EN_player_learn_25), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_CARRION_BIRD);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_26, EN_player_learn_26), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_CROCOLISK);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_27, EN_player_learn_27), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_CRAB);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_28, EN_player_learn_28), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_DRAGONHAWK);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_29, EN_player_learn_29), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_GORILLA);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_30, EN_player_learn_30), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_HYENA);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_31, EN_player_learn_31), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_MOTH);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_32, EN_player_learn_32), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_NETHER_RAY);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_33, EN_player_learn_33), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_OWL);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_34, EN_player_learn_34), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_RAPTOR);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_35, EN_player_learn_35), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_RAVAGER);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_36, EN_player_learn_36), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_SCORPID);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_37, EN_player_learn_37), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_SERPENT);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_38, EN_player_learn_38), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_SPIDER);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_39, EN_player_learn_39), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_SPIDER);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_40, EN_player_learn_40), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_TALLSTRIDER);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_41, EN_player_learn_41), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_TURTLE);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_42, EN_player_learn_42), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_WARP_STALKER);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_43, EN_player_learn_43), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_WASP);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_44, EN_player_learn_44), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_WIND_SERPENT);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_player_learn_45, EN_player_learn_45), GOSSIP_SENDER_MAIN, GOSSIP_OPTION_WOLF);
                    SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
                    break;
                }
                case GOSSIP_OPTION_BAT:
                    CreatePet(player, creature, SPELL_PET_BAT);
                    break;
                case GOSSIP_OPTION_BOAR:
                    CreatePet(player, creature, SPELL_PET_BOAR);
                    break;
                case GOSSIP_OPTION_BEAR:
                    CreatePet(player, creature, SPELL_PET_BEAR);
                    break;
                case GOSSIP_OPTION_CAT:
                    CreatePet(player, creature, SPELL_PET_CAT);
                    break;
                case GOSSIP_OPTION_CARRION_BIRD:
                    CreatePet(player, creature, SPELL_PET_CARRION_BIRD);
                    break;
                case GOSSIP_OPTION_CROCOLISK:
                    CreatePet(player, creature, SPELL_PET_CROCOLISK);
                    break;
                case GOSSIP_OPTION_CRAB:
                    CreatePet(player, creature, SPELL_PET_CRAB);
                    break;
                case GOSSIP_OPTION_DRAGONHAWK:
                    CreatePet(player, creature, SPELL_PET_DRAGONHAWK);
                    break;
                case GOSSIP_OPTION_GORILLA:
                    CreatePet(player, creature, SPELL_PET_GORILLA);
                    break;
                case GOSSIP_OPTION_HOUND:
                    CreatePet(player, creature, SPELL_PET_HOUND);
                    break;
                case GOSSIP_OPTION_HYENA:
                    CreatePet(player, creature, SPELL_PET_HYENA);
                    break;
                case GOSSIP_OPTION_MOTH:
                    CreatePet(player, creature, SPELL_PET_MOTH);
                    break;
                case GOSSIP_OPTION_NETHER_RAY:
                    CreatePet(player, creature, SPELL_PET_NETHER_RAY);
                    break;
                case GOSSIP_OPTION_OWL:
                    CreatePet(player, creature, SPELL_PET_BIRD_OF_PREY);
                    break;
                case GOSSIP_OPTION_RAPTOR:
                    CreatePet(player, creature, SPELL_PET_RAPTOR);
                    break;
                case GOSSIP_OPTION_RAVAGER:
                    CreatePet(player, creature, SPELL_PET_RAVAGER);
                    break;
                case GOSSIP_OPTION_SCORPID:
                    CreatePet(player, creature, SPELL_PET_SCORPID);
                    break;
                case GOSSIP_OPTION_SERPENT:
                    CreatePet(player, creature, SPELL_PET_SERPENT);
                    break;
                case GOSSIP_OPTION_SPIDER:
                    CreatePet(player, creature, SPELL_PET_SPIDER);
                    break;
                case GOSSIP_OPTION_TURTLE:
                    CreatePet(player, creature, SPELL_PET_TURTLE);
                    break;
                case GOSSIP_OPTION_WASP:
                    CreatePet(player, creature, SPELL_PET_WASP);
                    break;
                case GOSSIP_OPTION_WIND_SERPENT:
                    CreatePet(player, creature, SPELL_PET_WIND_SERPENT);
                    break;
                case GOSSIP_OPTION_WOLF:
                    CreatePet(player, creature, SPELL_PET_WOLF);
                    break;
                case GOSSIP_OPTION_SPOREBAT:
                    CreatePet(player, creature, SPELL_PET_SPOREBAT);
                    break;
                case GOSSIP_OPTION_WARP_STALKER:
                    CreatePet(player, creature, SPELL_PET_WARP_STALKER);
                    break;
                case GOSSIP_OPTION_TALLSTRIDER:
                    CreatePet(player, creature, SPELL_PET_TALLSTRIDER);
                    break;
                case GOSSIP_OPTION_STABLEPET:
                    player->GetSession()->SendStablePet(creature->GetGUID());
                    break;
                case 7:
                    player->GetSession()->SendListInventory(creature->GetGUID(), 190013);
                    break;
                case 4: // сброс талантов пету (для хантов)
                {
                    Pet* pet = player->GetPet();
                    Pet::resetTalentsForAllPetsOf(player, pet);
                    if (pet)
                        player->SendTalentsInfoData(true);
                    ChatHandler(player->GetSession()).SendSysMessage(GetText(player, RU_player_learn_48, EN_player_learn_48));
                    player->PlayerTalkClass->SendCloseGossip();
                    break;
                }
                case 8: // стойло
                    player->CastSpell(player, 62757);
                    player->PlayerTalkClass->SendCloseGossip();
                    break;
                case 9: // переменовать
                    player->CastSpell(player, 59385);
                    player->PlayerTalkClass->SendCloseGossip();
                    break;
                case 10: // тренер
                    learnSpellOnStart(player);
                    if (!player->HasSpell(33388))
                        player->learnSpell(33388);
                    if (!player->HasSpell(33391))
                        player->learnSpell(33391);
                    if (!player->HasSpell(34090))
                        player->learnSpell(34090);
                    if (!player->HasSpell(34091))
                        player->learnSpell(34091);
                    if (!player->HasSpell(54197))
                        player->learnSpell(54197);

                    player->CastSpell(player, 63680);
                    player->CastSpell(player, 63624);
                    player->UpdateSkillsToMaxSkillsForLevel();
                    player->PlayerTalkClass->SendCloseGossip();
                    break;
                default:
                    break;
                }
        }
        return true;
    }
};

void AddSC_npc_trainer()
{
    new npc_trainer();
}