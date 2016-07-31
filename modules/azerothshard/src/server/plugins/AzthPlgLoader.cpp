#include "AzthPlgLoader.h"
#include "AnticheatMgr.h"
#include "Log.h"

#ifndef SCRIPTLOADER_CPP
#define	SCRIPTLOADER_CPP

/* This is where custom AzerothShard function scripts declarations should be added. */
void AddSC_azth_commandscript();
void AddSC_CrossFactionGroups();
void AddSC_azth_player_plg();
void AddSC_Custom_Rates();
// void AddSC_PWS_Transmogrification();
// void AddSC_CS_Transmogrification();
void AddSC_npc_1v1arena();
//void AddSC_anticheat_commandscript();
void AddSC_guildhouse_npcs();
void AddSC_npc_transmogrifier();
void AddSC_npc_transmogrifier();
void AddSC_hearthstone();
void AddSC_azth_group_plg();
void AddSC_AzthWorldScript();


void AddAzthScripts()
{
    sLog->outString("Loading AzerothShard Plugins...");
    /* This is where custom AzerothShard scripts should be added. */
    AddSC_azth_commandscript();
    AddSC_CrossFactionGroups();
    AddSC_azth_player_plg();
    AddSC_Custom_Rates();
    AddSC_npc_1v1arena();
    //AddSC_anticheat_commandscript();
    AddSC_guildhouse_npcs();
    AddSC_npc_transmogrifier();
    //sAnticheatMgr->StartScripts(); //[AZTH] Anticheat
    AddSC_hearthstone();
    AddSC_azth_group_plg();
    AddSC_AzthWorldScript();
}


#endif	/* SCRIPTLOADER_CPP */

