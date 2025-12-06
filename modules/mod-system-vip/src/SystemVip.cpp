#include "SystemVip.h"

SystemVip* SystemVip::instance()
{
    static SystemVip instance;
    return &instance;
}

void SystemVip::LoadConfig() {
    TimeVip = sConfigMgr->GetOption<uint32>("SystemVip.TimeVip", 7) * 86400;
    TokenEntry = sConfigMgr->GetOption<uint32>("SystemVip.Token", 123);
    TokenAmount = sConfigMgr->GetOption<uint32>("SystemVip.TokenAmount", 10);
    TokenIcon = sConfigMgr->GetOption<string>("SystemVip.TokenIcon", "|TInterface/ICONS/inv_misc_rune_05:28:28:-15:0|t ");

    loginAnnounce = sConfigMgr->GetOption<bool>("SystemVip.LoginAnnounce", false);
    loginMessage = sConfigMgr->GetOption<string>("SystemVip.LoginAnnounceMessage", "Player Vip: %s se conectou.");
    rateCustom = sConfigMgr->GetOption<bool>("SystemVip.EnableRateCustom", false);
    rateXp = sConfigMgr->GetOption<uint32>("SystemVip.RateXP", 1);
    professionRate = sConfigMgr->GetOption<uint32>("SystemVip.ProfessionRate", 1);
    goldRate = sConfigMgr->GetOption<uint32>("SystemVip.GoldRate", 1);
    honorRate = sConfigMgr->GetOption<uint32>("SystemVip.HonorRate", 1);
    ghostMount = sConfigMgr->GetOption<bool>("SystemVip.GhostMount", false);

    petEnable = sConfigMgr->GetOption<bool>("SystemVip.Pet", false);
    vipZone = sConfigMgr->GetOption<bool>("SystemVip.VipZone", false);
    vipZoneMapId = sConfigMgr->GetOption<uint32>("SystemVip.VipZoneMapId", 571);
    vipZonePosX = sConfigMgr->GetOption<float>("SystemVip.VipZonePosX", 5804.15);
    vipZonePosY = sConfigMgr->GetOption<float>("SystemVip.VipZonePosY", 624.771);
    vipZonePosZ = sConfigMgr->GetOption<float>("SystemVip.VipZonePosZ", 647.767);
    vipZoneO = sConfigMgr->GetOption<float>("SystemVip.VipZoneO", 1.64);
    armorRep = sConfigMgr->GetOption<bool>("SystemVip.ArmorRep", false);
    bankEnable = sConfigMgr->GetOption<bool>("SystemVip.Bank", false);
    mailEnable = sConfigMgr->GetOption<bool>("SystemVip.Mail", false);
    buffsEnable = sConfigMgr->GetOption<bool>("SystemVip.Buffs", false);

    string buffString = sConfigMgr->GetOption<string>("SystemVip.BuffIds", "25898,48469,42995,48169,48073,48161,53307,23735,23736,23737,23738,23766,23767,23768,23769");
    stringstream ss(buffString);
    buffIds.clear();
    while (ss.good()) {
        std::string substr;
        std::getline(ss, substr, ',');
        int num = std::stoi(substr);
        buffIds.push_back(num);
    }

    refreshEnable = sConfigMgr->GetOption<bool>("SystemVip.Refresh", false);
    sicknessEnbale = sConfigMgr->GetOption<bool>("SystemVip.Sickness", false);
    deserterEnable = sConfigMgr->GetOption<bool>("SystemVip.Deserter", false);
    resetInstance = sConfigMgr->GetOption<bool>("SystemVip.ResetInstance", false);
    saveTeleport = sConfigMgr->GetOption<bool>("SystemVip.SaveTeleport", false);
    saveTeleportAmount = sConfigMgr->GetOption<uint32>("SystemVip.SaveTeleportAmount", 5);
}

bool SystemVip::isVip(Player* player) {
    uint32 accountId = player->GetSession()->GetAccountId();

    if (vipMap.count(accountId) == 0)
        return false;

    return time(nullptr) < vipMap[accountId];
}

void SystemVip::addRemainingVipTime(Player* player) {
    uint32 accountId = player->GetSession()->GetAccountId();
    if (isVip(player)) {
        vipMap[accountId] += TimeVip;
        LoginDatabase.Execute("UPDATE account_vip SET subscription_date = {} WHERE id = {};", vipMap[accountId], accountId);
    }
    else {
        vipMap.erase(accountId);
        vipMap.emplace(accountId, time(nullptr) + TimeVip);
        LoginDatabase.Execute("REPLACE INTO account_vip (id, subscription_date) VALUES ({}, {});", accountId, vipMap[accountId]);
    }
}

uint32 SystemVip::getRemainingVipTime(Player* player) {
    uint32 accountId = player->GetSession()->GetAccountId();
    return time(nullptr) >= vipMap[accountId] ? 0 : vipMap[accountId] - time(nullptr);
}

string SystemVip::getFormatedVipTime(Player* player) {
    uint32 time = getRemainingVipTime(player);
    int minutes = time / 60;
    int hours = minutes / 60;
    int days = hours / 24;

    hours = hours % 24;
    minutes = minutes % 60;
    // int seconds = time % 60;

    string result = to_string(days) + "dias " + to_string(hours) + "horas " + to_string(minutes) + "minutos.";
    return result;
}

string SystemVip::getItemLink(uint32 entry, Player* player) {
    const ItemTemplate* temp = sObjectMgr->GetItemTemplate(entry);
    int loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
    std::string name = temp->Name1;
    if (ItemLocale const* il = sObjectMgr->GetItemLocale(entry))
        ObjectMgr::GetLocaleString(il->Name, loc_idx, name);

    std::ostringstream oss;
    oss << "|c" << std::hex << ItemQualityColors[temp->Quality] << std::dec <<
        "|Hitem:" << entry << ":0:0:0:0:0:0:0:0:0|h[" << name << "]|h|r";

    return oss.str();
}

string SystemVip::getInformationVip(Player* player) {
    std::ostringstream text;
    std::string accName;
    if (AccountMgr::GetName(player->GetSession()->GetAccountId(), accName))
        text << "Tempo restante: |CFFFF0000" << getFormatedVipTime(player) << "|r\n";

    return text.str();
}

string SystemVip::getInformationAdavantages() {
    std::ostringstream text;
    text << "Benefícios:\n";
    text << "----------------------------------\n";
    if(loginAnnounce)
        text << "|TInterface/ICONS/inv_misc_grouplooking:22:22:-15:0|t Anúncio ao iniciar sessão." << "\n";
    if (rateCustom) {
        text << "|TInterface/ICONS/achievement_level_80:22:22:-15:0|t Rate XP           x " << rateXp << "\n";
        text <<  "|TInterface/ICONS/trade_tailoring:22:22:-15:0|t Rate profesion  x " << professionRate << "\n";
        text <<  "|TInterface/ICONS/inv_misc_coin_02:22:22:-15:0|t Rate de Gold       x " << goldRate << "\n";
        text <<  "|TInterface/ICONS/inv_misc_rune_07:22:22:-15::0|t Rate honor        x " << honorRate << "\n";
    }
    if(ghostMount)
        text <<  "|TInterface/ICONS/ability_vanish:22:22:-15::0|t Velocidade ao ser fantasma." << "\n";
    if (petEnable) {
        text <<  "|TInterface/ICONS/ability_hunter_beastcall:22:22:-15::0|t Pet VIP." << "\n";
        if(vipZone)
            text <<  "|TInterface/ICONS/achievement_zone_azshara_01:22:22:-15::0|t Zona Vip." << "\n";
        if(armorRep)
            text <<  "|TInterface/ICONS/INV_Hammer_20:22:22:-15::0|t Reparar Armaduras." << "\n";
        if(bankEnable)
            text <<  "|TInterface/ICONS/INV_Ingot_03:22:22:-15::0|t Banco ." << "\n";
        if(mailEnable)
            text <<  "|TInterface/ICONS/inv_letter_15:22:22:-15::0|t Email." << "\n";
        if(buffsEnable)
            text <<  "|TInterface/ICONS/Spell_Magic_GreaterBlessingofKings:22:22:-15::0|t Buffs VIP." << "\n";
        if(refreshEnable)
            text <<  "|TInterface/ICONS/Spell_Holy_LayOnHands:22:22:-15::0|t Restaurar hp/mana." << "\n";
        if(sicknessEnbale)
            text <<  "|TInterface/ICONS/spell_shadow_deathscream:22:22:-15::0|t Remover Sickness." << "\n";
        if(deserterEnable)
            text <<  "|TInterface/ICONS/ability_druid_cower:22:22:-15::0|t Remover Deserter." << "\n";
        if(resetInstance)
            text <<  "|TInterface/ICONS/spell_holy_borrowedtime:22:22:-15::0|t ResetInstance." << "\n";
        if(saveTeleport)
            text << "|TInterface/ICONS/Spell_Holy_LightsGrace:22:22:-15::0|t SaveTeleport." << "\n";
    }
    return text.str();
}

void SystemVip::sendGossipInformation(Player* player, bool advantages) {
    std::ostringstream text;
    std::string accName;
    if (AccountMgr::GetName(player->GetSession()->GetAccountId(), accName))
        text << "Usuario: |CFF33FFFF" << accName << "|r\n";

    if (isVip(player)) {
        text << "Tempo restante: |CFFFF0000" << getFormatedVipTime(player) << "|r\n\n";
        text << "Obrigado por comprar uma assinatura VIP.\n\n";
    }
    else {
        text << "Você não tem uma assinatura VIP disponível.\n";
        text << "Compre uma assinatura e aproveite todos os benefícios de ser VIP!\n";
    }

    if (advantages) {
        text << "Lembre-se de que ao comprar VIP você tem benefícios em todos os personagens da sua conta." << "\n";
        text << getInformationAdavantages();
    }

    WorldPacket data(384, 100);
    if(advantages)
        data << uint32_t(VENDOR_INFO); // id npc_text
    else
        data << uint32_t(PET_INFO); // id npc_text
    for (int i = 0; i < 10; ++i) {
        data << float(0.0f);
        data << std::string(text.str());
        data << std::string(text.str());
        data << uint32_t(0);
        data << uint32_t(0);
        data << uint32_t(0);
        data << uint32_t(0);
        data << uint32_t(0);
        data << uint32_t(0);
        data << uint32_t(0);
    }
    player->GetSession()->SendPacket(&data);
}

void SystemVip::delExpireVip(Player* player) {
    uint32 accountId = player->GetSession()->GetAccountId();
    if (vipMap.count(accountId)) {
        if (getRemainingVipTime(player) == 0) {
            vipMap.erase(accountId);
        }
    }
}


string SystemVip::getLoginMessage(Player* player) {
    std::string nameColor = "|cFFFF0000" + player->GetName() + "|cff4CFF00"; // Nome em vermelho, volta ao verde
    std::string welcomeMessage = loginMessage;

    size_t pos = welcomeMessage.find("%s");
    if (pos != std::string::npos) {
        welcomeMessage.replace(pos, 2, nameColor);
    }

    return "|cff4CFF00" + welcomeMessage + "|r"; // Mensagem verde completa, com reset no final
}

void SystemVip::loadTeleportVip(Player* player) {
    uint32 accountId = player->GetSession()->GetAccountId();
    QueryResult result = LoginDatabase.Query("SELECT * FROM account_vip_teleport WHERE id = {};", accountId);
    if (result) {
        uint32 i = 1;
        do
        {
            Teleports teleport = { i, (*result)[1].Get<string>(), (*result)[2].Get<uint32>(), (*result)[3].Get<float>(), (*result)[4].Get<float>(), (*result)[5].Get<float>(), (*result)[6].Get<float>() };
            teleportMap[accountId].push_back(teleport);
            i++;
        } while (result->NextRow());
    }
}

void SystemVip::addTeleportVip(Player* player, string name) {
    uint32 accountId = player->GetSession()->GetAccountId();
    Teleports teleport = { 0, name, player->GetMapId(), player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetOrientation() };
    uint32 id = 1;
    if (teleportMap.count(accountId) > 0) {
        if (teleportMap[accountId].size() == saveTeleportAmount) {
            ChatHandler(player->GetSession()).PSendSysMessage("Você não pode mais salvar Teleports!");
            return;
        }

        for (size_t i = 0; i < teleportMap[accountId].size(); i++) {
            if (teleportMap[accountId][i].name == teleport.name) {
                ChatHandler(player->GetSession()).PSendSysMessage("Já existe um teleporte com o mesmo nome!");
                return;
            }
        }
        id = teleportMap[accountId].back().id + 1;
    }
    teleport.id = id;
    teleportMap[accountId].push_back(teleport);
    LoginDatabase.Execute("INSERT INTO account_vip_teleport VALUES ( {} , '{}', {}, {}, {}, {}, {} );", accountId, name, teleport.mapId, teleport.coord_x, teleport.coord_y, teleport.coord_z, teleport.orientation);
    ChatHandler(player->GetSession()).PSendSysMessage("Localização salva com sucesso.");
}

void SystemVip::delTeleportVip(Player* player, string name) {
    uint32 accountId = player->GetSession()->GetAccountId();
    for (size_t i = 0; i < teleportMap[accountId].size(); i++) {
        if (teleportMap[accountId][i].name == name) {
            teleportMap[accountId].erase(teleportMap[accountId].begin() + i);
            LoginDatabase.Execute("DELETE FROM account_vip_teleport WHERE id = {} AND name = '{}';", accountId, name);
            return;
        }
    }
    ChatHandler(player->GetSession()).PSendSysMessage("Nome incorreto.");
}

void SystemVip::getTeleports(Player* player) {
    uint32 accountId = player->GetSession()->GetAccountId();
    if( teleportMap.count(accountId) != 0){
        for (size_t i = 0; i < teleportMap[accountId].size(); i++) {
            AddGossipItemFor(player, 0, "|TInterface/CURSOR/Taxi:28:28:-15:0|t "+teleportMap[accountId][i].name, teleportMap[accountId][i].id, 12, "Você quer se teletransportar?", 0, false);
        }
    }
}

void SystemVip::teleportPlayer(Player* player, uint32 id) {
    uint32 accountId = player->GetSession()->GetAccountId();
    Teleports teleport;
    for (size_t i = 0; i < teleportMap[accountId].size(); i++) {
        if (teleportMap[accountId][i].id == id) {
            teleport = teleportMap[accountId][i];
            break;
        }
    }

    player->TeleportTo(teleport.mapId, teleport.coord_x, teleport.coord_y, teleport.coord_z, teleport.orientation);
}
