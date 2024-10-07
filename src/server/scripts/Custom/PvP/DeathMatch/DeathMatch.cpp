#include "ScriptMgr.h"
#include "Language.h"
#include "World.h"
#include "WorldSession.h"
#include "DeathMatch.h"
#include "WorldPacket.h"
#include "Player.h"
#include "BattlegroundMgr.h"
#include "Translate.h"

#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

/* телепорт в рандом точку */
void DeathMatch::TeleportToRandomLocation(Player* player)
{
    if (!player)
        return;
    player->TeleportTo(13, float(irand(-145, 145)), float(irand(-145, 145)), -50.0f, float(urand(0,7)));
}

void DeathMatch::RevivePlayer(Player* player)
{
    if (!player)
        return;

    TeleportToRandomLocation(player);
    player->ResurrectPlayer(1.0f);
    /* выдаем фриз чтобы дамаг не залетал */
    if(Aura* aura = player->AddAura(9454, player))
        aura->SetDuration(3 * IN_MILLISECONDS); /* на 3 секунды */
    SetBuffForClassSpec(player);
    ResetHpMana(player);
}

void DeathMatch::ResetHpMana(Player* player)
{
    player->SetHealth(player->GetMaxHealth());
    player->CombatStop();
    if (player->getPowerType() == POWER_MANA)
        player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));
}

bool DeathMatch::CanOpenMenu(Player* player) {
    if (player->IsDeathMatch() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena()
        || player->HasStealthAura() || player->isDead() || (player->getClass() == CLASS_DEATH_KNIGHT && player->GetMapId() == 609 && !player->IsGameMaster() && !player->HasSpell(50977))) {
        ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, "Сейчас это невозможно.", "Now it is impossible"));
        return true;
    }
    return false;
}

void DeathMatch::AddPlayer(Player* player)
{
    if (DeathMatchMgr->CanOpenMenu(player))
        return;

    if (player->InBattlegroundQueue())
        return;

    if (!player->HasFreeBattlegroundQueueId())
        return;

    auto itr = _players.find(player->GetSession()->GetRemoteAddress());
    if (itr != _players.end() && itr->second != player->GetGUID()) {
        if (auto plr = ObjectAccessor::FindPlayer(itr->second)) {
            RemovePlayer(plr);
            ChatHandler(plr->GetSession()).PSendSysMessage(GetText(plr, RU_DEATHMATCH_FARM, EN_DEATHMATCH_FARM));
        }
        _players[player->GetSession()->GetRemoteAddress()] = player->GetGUID();
    }
    else if (itr == _players.end()) { /* если такого ип адресса нету в зоне */
        _players[player->GetSession()->GetRemoteAddress()] = player->GetGUID();
    }

	player->RemoveFromGroup(GROUP_REMOVEMETHOD_LEAVE);
	TeleportToRandomLocation(player);
    SetBuffForClassSpec(player);
    ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, RU_DEATHMATCH_JOIN, EN_DEATHMATCH_JOIN));
    // player->SetDeathMatchKill(0);
    player->SetDeathMatch(true);
}

void DeathMatch::RemovePlayer(Player* player)
{
    if(!player)
        return;

    /* удаляем игрока с зоны */
    for (auto itr = _players.begin(); itr != _players.end(); itr++)
    {
        if (itr->second == player->GetGUID())
        {
            _players.erase(itr);
            break;
        }
    }

    /* если игрок покидает запись в зоне и он находится в зоне то тпшим его домой */
    if(IsDeathMatchZone(player->GetZoneId()))
        player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY, player->m_homebindZ, player->GetOrientation());

    // uint32 totalkill = player->GetDeathMatchKill();
    // /* если вдруг игрок в зоне но каким то образом не записан там */
    // if(!player->IsDeathMatch())
    //     totalkill = 0;

    // player->SetDeathMatchKillTotal(player->GetDeathMatchKillTotal() + player->GetDeathMatchKill());
    // ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, RU_DEATHMATCH_EXIT, EN_DEATHMATCH_EXIT), player->GetDeathMatchKill());
    // player->SetDeathMatchKill(0); /* сброс убийст */
    player->SetDeathMatch(false);
}

uint32 DeathMatch::GetSpellFamily(const Player* player)
{
    if(!player)
        return 99;

    switch (player->getClass())
    {
    case CLASS_ROGUE:
        return SPELLFAMILY_ROGUE;
    case CLASS_DEATH_KNIGHT:
        return SPELLFAMILY_DEATHKNIGHT;
    case CLASS_WARRIOR:
        return SPELLFAMILY_WARRIOR;
    case CLASS_PRIEST:
        return SPELLFAMILY_PRIEST;
    case CLASS_MAGE:
        return SPELLFAMILY_MAGE;
    case CLASS_PALADIN:
        return SPELLFAMILY_PALADIN;
    case CLASS_HUNTER:
        return SPELLFAMILY_HUNTER;
    case CLASS_DRUID:
        return SPELLFAMILY_DRUID;
    case CLASS_SHAMAN:
        return SPELLFAMILY_SHAMAN;
    case CLASS_WARLOCK:
        return SPELLFAMILY_WARLOCK;
    default:
        return SPELLFAMILY_GENERIC;
    }
}

void DeathMatch::SetBuffForClassSpec(Player* player)
{
    if (!player)
        return;

    auto spellsForPlayersFamily = m_additionalSpells.find(GetSpellFamily(player));
    if (spellsForPlayersFamily != m_additionalSpells.end())
    {
        std::vector<AddSpell> additionalSpellsToTeach = spellsForPlayersFamily->second;
        for (auto const& spell : additionalSpellsToTeach) {
            if (!(player->HasAura(spell.spellId)) && (player->HasSpell(spell.spellId)) && (spell.spec == 0 || spell.spec == player->GetSpec(player->GetActiveSpec()))) {
                player->CastSpell(player, spell.spellId, true);
            }
        }
    }
}

bool DeathMatch::IsDeathMatchZone(uint32 zoneId) {
    return zoneId == 3817;
}

void DeathMatch::DeathMatchHead(Player* player, Creature* creature)
{
    if (!player || !creature)
        return;

    std::ostringstream femb;
    if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
    {
        femb << "Королевская Битва это зона каждый сам за себя.\n\n";
        femb << "При убийстве игрока у вас есть шанс 1 из 3 залутать сундук с подарком.\n";
        femb << "А также шанс получить дополнительный бафф который будет вас выделять от остальных !\n\n";
        femb << "В данный момент в зоне " << _players.size() << " игроков\n";
        // femb << "Вы уже убили " << player->GetDeathMatchKillTotal() << " игроков в этой зоне";
    }
    else
    {
        femb << "The Royale Battle is a zone every man for himself\n\n";
        femb << "When you kill a player, you have a 1 in 3 chance of looting a chest with a gift.\n";
        femb << "And also a chance to get an additional buff that will set you apart from the rest!\n\n";
        femb << "Currently in the zone " << _players.size() << " player(s).\n";
        // femb << "You have already killed " << player->GetDeathMatchKillTotal() << " player(s) in this zone";
    }
    player->PlayerTalkClass->SendGossipMenu(femb.str().c_str(), creature->GetGUID());
    return;
}

void DeathMatch::DeathMatchWelcome(Player* player, Creature* creature) 
{    
    if (!player || !creature)
        return;

    ClearGossipMenuFor(player);
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_DEATHMATCH_JOIN_NPC, EN_DEATHMATCH_JOIN_NPC), GOSSIP_SENDER_MAIN, 1, GetText(player, RU_DEATHMATCH_INFO_NPC, EN_DEATHMATCH_INFO_NPC), 0, false);
    DeathMatchHead(player, creature);
}

class npc_deathmatch : public CreatureScript
{
public:
    npc_deathmatch() : CreatureScript("npc_deathmatch") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        DeathMatchMgr->DeathMatchWelcome(player, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case 1: DeathMatchMgr->AddPlayer(player); break;
            default: break;
        }
        return true;
    }
};

class DeathMatchkill : public PlayerScript
{
public:
    DeathMatchkill() : PlayerScript("DeathMatchkill") { }

    void OnPVPKill(Player* killer, Player* killed) override
    {
        if (!killer || !killed)
            return;

        if (killer->GetGUID() == killed->GetGUID())
            return;

        if (killer->GetQuestStatus(26039) == QUEST_STATUS_INCOMPLETE)
            killer->KilledMonsterCredit(200004);         

        if(!killer->IsDeathMatch() || !killed->IsDeathMatch())
            return;

        if (killed->getLevel() < 80)
            return;

        // дроп сундука
        int win = urand(1, 3);
        if (win == 3) /* 33.334% */
            killer->AddItem(30806, 1);

        // кв на убийство
        Quest const* quest = sObjectMgr->GetQuestTemplate(26036);
        if (quest) {
            if(killer->GetQuestStatus(26036) == QUEST_STATUS_INCOMPLETE)
                killer->KilledMonsterCredit(200000);   
        }

        if (DeathMatchMgr->IsDeathMatchZone(killed->GetZoneId()))
            DeathMatchMgr->RevivePlayer(killed);
    }

    void OnUpdateZone(Player* player, uint32 newZone, uint32 /*newArea*/) override
    {
        if (!player || !newZone)
            return;

        if (DeathMatchMgr->IsDeathMatchZone(newZone) && !player->IsDeathMatch())
            DeathMatchMgr->AddPlayer(player);
        else if (player->IsDeathMatch() && !DeathMatchMgr->IsDeathMatchZone(newZone))
            DeathMatchMgr->RemovePlayer(player);
    }

    void OnLogin(Player* player) override
    {
        if (DeathMatchMgr->IsDeathMatchZone(player->GetZoneId()) && !player->IsDeathMatch())
            DeathMatchMgr->AddPlayer(player);
    }

    void OnLogout(Player* player) override
    {
        if (!player)
            return;

        if (DeathMatchMgr->IsDeathMatchZone(player->GetZoneId()))
            DeathMatchMgr->RemovePlayer(player);
        if (player->IsDeathMatch())
            DeathMatchMgr->RemovePlayer(player);   
    }
};

void AddSC_DeathMatchkill()
{
    new DeathMatchkill();
    new npc_deathmatch();
}