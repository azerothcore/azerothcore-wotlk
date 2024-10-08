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

    /* выдаем фриз чтобы дамаг не залетал */
    if (Aura* aura = player->AddAura(9454, player))
        aura->SetDuration(3 * IN_MILLISECONDS); /* на 3 секунды */

    TeleportToRandomLocation(player);
    player->ResurrectPlayer(1.0f);
    SetBuffForClassSpec(player);
    ResetHpMana(player);
}

void DeathMatch::ResetHpMana(Player* player)
{
    if (!player)
        return;

    player->SetHealth(player->GetMaxHealth());
    player->CombatStop();
    if (player->getPowerType() == POWER_MANA)
        player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));
}

bool DeathMatch::CanOpenMenu(Player* player) {

    if (!player)
        return true;

    if (player->IsDeathMatch() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena() || !DeathMatchMgr->CheckFullEquipAndTalents(player)
        || player->isDead() || (player->getClass() == CLASS_DEATH_KNIGHT && player->GetMapId() == 609 && !player->IsGameMaster() && !player->HasSpell(50977))) {
        ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, "Сейчас это невозможно.", "Now it is impossible"));
        return true;
    }
    return false;
}

bool DeathMatch::CheckFullEquipAndTalents(Player* player)
{
    if (!player)
        return false;

    std::stringstream err;

    if (player->GetFreeTalentPoints() > 0) {
        err << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933";
        if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
            err << "[Королевская Битва]: В данный момент у вас еще " << player->GetFreeTalentPoints() << " очков таланта. Прокачайте все таланты.\n";
        else
            err << "[Battle Royale]: At the moment you still have " << player->GetFreeTalentPoints() << " talent points. Pump all the talents.\n";
    }

    Item* newItem = NULL;
    for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        if (slot == EQUIPMENT_SLOT_OFFHAND || slot == EQUIPMENT_SLOT_RANGED || slot == EQUIPMENT_SLOT_TABARD || slot == EQUIPMENT_SLOT_BODY)
            continue;

        newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
        if (newItem == NULL)
        {
            err << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933";
            if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
                err << "[Королевская Битва]: Вы должны надеть фул экипировку.\n";
            else
                err << "[Battle Royale]: You must wear full equipment.\n";
            break;
        }
    }

    if (err.str().length() > 0)
    {
        ChatHandler(player->GetSession()).SendSysMessage(err.str().c_str());
        return false;
    }
    return true;
} 

void DeathMatch::AddPlayer(Player* player)
{
    if (!player)
        return;

    if (player->InBattlegroundQueue())
        return;

    if (!player->HasFreeBattlegroundQueueId())
        return;

    if (DeathMatchMgr->CanOpenMenu(player)) {
        if (IsDeathMatchZone(player->GetZoneId()))
            player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY, player->m_homebindZ, player->GetOrientation());
        return;
    }        

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

std::string DeathMatch::GetItemLink(uint32 entry, WorldSession* session) const
{
    const ItemTemplate* temp = sObjectMgr->GetItemTemplate(entry);
    int loc_idx = session->GetSessionDbLocaleIndex();
    std::string name = temp->Name1;
    if (ItemLocale const* il = sObjectMgr->GetItemLocale(entry))
        ObjectMgr::GetLocaleString(il->Name, loc_idx, name);

    std::ostringstream oss;
    oss << std::dec <<
        "|Hitem:" << entry << ":0:0:0:0:0:0:0:0:0|h[" << name << "]|h|r";

    return oss.str();
}

std::string DeathMatch::GetItemIcon(uint32 entry, uint32 width, uint32 height, int x, int y) const
{
    std::ostringstream ss;
    ss << "|TInterface";
    const ItemTemplate* temp = sObjectMgr->GetItemTemplate(entry);
    const ItemDisplayInfoEntry* dispInfo = NULL;
    if (temp)
    {
        dispInfo = sItemDisplayInfoStore.LookupEntry(temp->DisplayInfoID);
        if (dispInfo)
            ss << "/ICONS/" << dispInfo->inventoryIcon;
    }
    if (!dispInfo)
        ss << "/InventoryItems/WoWUnknownItem01";
    ss << ":" << width << ":" << height << ":" << x << ":" << y << "|t";
    return ss.str();
}

void DeathMatch::DeathMatchHead(Player* player, Creature* creature)
{
    if (!player || !creature)
        return;

    WorldSession* session = player->GetSession();
    if (!session)
        return;

    std::ostringstream femb;
    if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
    {
        femb << "Королевская Битва это зона каждый сам за себя.\n";
        femb << "При убийстве игрока у вас есть шанс 1 из 3 залутать сундук с подарком и золотом:\n\n";
        femb << DeathMatchMgr->GetItemIcon(1042, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(1042, session) << "     шанс 50%\n";
        femb << DeathMatchMgr->GetItemIcon(1043, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(1043, session) << "   шанс 10.3%\n";
        femb << DeathMatchMgr->GetItemIcon(11663, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(11663, session) << "  шанс 10%\n";
        femb << DeathMatchMgr->GetItemIcon(43589, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(43589, session) << " шанс 7%\n";
        femb << DeathMatchMgr->GetItemIcon(1044, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(1044, session) << " шанс 5%\n";
        femb << DeathMatchMgr->GetItemIcon(18942, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(18942, session) << " шанс 5%\n";
        femb << DeathMatchMgr->GetItemIcon(44115, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(44115, session) << " шанс 5%\n";
        femb << DeathMatchMgr->GetItemIcon(38570, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(38570, session) << " шанс 3%\n";
        femb << DeathMatchMgr->GetItemIcon(45280, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(45280, session) << " шанс 3%\n";
        femb << DeathMatchMgr->GetItemIcon(35778, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(35778, session) << " шанс 1.5%\n";
        femb << DeathMatchMgr->GetItemIcon(842, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(842, session) << " шанс 0.2%\n";
        femb << "В данный момент в зоне " << _players.size() << " игроков\n";
    }
    else
    {
        femb << "The Royale Battle is a zone every man for himself.\n";
        femb << "When you kill a player, you have a 1 in 3 chance of looting a chest with a gift and gold:\n";
        femb << DeathMatchMgr->GetItemIcon(1042, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(1042, session) << "     chance 50%\n";
        femb << DeathMatchMgr->GetItemIcon(1043, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(1043, session) << "   chance 10.3%\n";
        femb << DeathMatchMgr->GetItemIcon(1044, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(11663, session) << "  chance 10%\n";
        femb << DeathMatchMgr->GetItemIcon(43589, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(43589, session) << " chance 7%\n";
        femb << DeathMatchMgr->GetItemIcon(1044, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(1044, session) << " chance 5%\n";
        femb << DeathMatchMgr->GetItemIcon(18942, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(18942, session) << " chance 5%\n";
        femb << DeathMatchMgr->GetItemIcon(44115, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(44115, session) << " chance 5%\n";
        femb << DeathMatchMgr->GetItemIcon(38570, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(38570, session) << " chance 3%\n";
        femb << DeathMatchMgr->GetItemIcon(45280, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(45280, session) << " chance 3%\n";
        femb << DeathMatchMgr->GetItemIcon(35778, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(35778, session) << " chance 1.5%\n";
        femb << DeathMatchMgr->GetItemIcon(842, 12, 12, 0, -2) << " " << DeathMatchMgr->GetItemLink(842, session) << " chance 0.2%\n";
        femb << "Currently in the zone " << _players.size() << " player(s).\n";
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
        if (!player || !creature)
            return true;

        DeathMatchMgr->DeathMatchWelcome(player, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        if (!player || !action)
            return true;

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

        if(!killer->IsDeathMatch() || !killed->IsDeathMatch())
            return;

        if (killed->getLevel() < 80)
            return;

        // кв на убийство игроков 150
        if (sWorld->getBoolConfig(CONFIG_RANK_SYSTEM_WIN_ENABLE)) {
            if ((int16)killed->GetAverageItemLevel() >= 265) {
                killer->RewardRankPoints(sWorld->getIntConfig(CONFIG_RANK_SYSTEM_KILL_RATE_BG), 5);
                killer->RewardRankMoney(6/*килл*/, sWorld->getIntConfig(CONFIG_RANK_SYSTEM_KILL_RATE_BG));
                if (killer->GetQuestStatus(26039) == QUEST_STATUS_INCOMPLETE)
                    killer->KilledMonsterCredit(200004);
                // кв на убийство игрока для зоны
                if (killer->GetQuestStatus(26036) == QUEST_STATUS_INCOMPLETE)
                    killer->KilledMonsterCredit(200000);

                std::ostringstream ss;
                ss << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Королевская Битва]: Игрок |cffffff4d";
                ss << killer->GetName() << "|r|cffff9933 убил игрока |cffffff4d" << killed->GetName() << "|r|cffff9933.";
                sWorld->SendZoneText(3817, ss.str().c_str());
            } else {
                ChatHandler(killer->GetSession()).PSendSysMessage(GetText(killer, RU_FARM_ATTEMPT, EN_FARM_ATTEMPT));
                return;
            }
        }

        // дроп сундука
        int win = urand(1, 3);
        if (win == 3) /* 33.334% */
            killer->AddItem(30806, 1);

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
        if (!player)
            return;

        if (DeathMatchMgr->IsDeathMatchZone(player->GetZoneId())) {
            if (!player->IsDeathMatch())
                DeathMatchMgr->AddPlayer(player);
        }
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