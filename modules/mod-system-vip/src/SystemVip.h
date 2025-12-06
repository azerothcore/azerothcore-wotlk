#ifndef SYSTEM_VIP_H
#define SYSTEM_VIP_H

#include "Player.h"
#include "Config.h"
#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "DatabaseEnv.h"
#include "Chat.h"

using namespace std;

//#define NPC_TEXT 250000

enum NPCTEXTS {
    VENDOR_INFO = 250000,
    PET_INFO
};

struct Teleports {
    uint32 id;
    string name;
    uint32 mapId;
    float coord_x;
    float coord_y;
    float coord_z;
    float orientation;
};

class SystemVip {
public:
    static SystemVip* instance();

    unordered_map<uint32, uint32> vipMap;
    unordered_map<uint32, vector<Teleports>> teleportMap;

    uint32 TokenEntry;
    uint32 TokenAmount;
    uint32 TimeVip;
    string TokenIcon;

    bool loginAnnounce;
    string loginMessage;
    bool rateCustom;
    uint32 rateXp;
    uint32 professionRate;
    uint32 goldRate;
    uint32 honorRate;
    bool ghostMount;

    bool petEnable;
    bool vipZone;
    float vipZoneMapId;
    float vipZonePosX;
    float vipZonePosY;
    float vipZonePosZ;
    float vipZoneO;
    bool armorRep;
    bool bankEnable;
    bool mailEnable;
    bool buffsEnable;
    
    vector<uint32> buffIds;
    
    bool refreshEnable;
    bool sicknessEnbale;
    bool deserterEnable;
    bool resetInstance;
    bool saveTeleport;
    uint32 saveTeleportAmount;


    bool isVip(Player* player);
    void addRemainingVipTime(Player* player);
    uint32 getRemainingVipTime(Player* player);
    string getFormatedVipTime(Player* player);
    string getItemLink(uint32 entry, Player* player);
    void delExpireVip(Player* player);
    void LoadConfig();
    void sendGossipInformation(Player* player, bool advantages);
    string getInformationVip(Player* player);
    string getInformationAdavantages();
    string getLoginMessage(Player* player);

    void loadTeleportVip(Player* player);
    void addTeleportVip(Player* player, string name);
    void delTeleportVip(Player* player, string name);
    void getTeleports(Player* player);
    void teleportPlayer(Player* player, uint32 id);
};

#define sSystemVip SystemVip::instance()

#endif //SYSTEM_VIP_H
