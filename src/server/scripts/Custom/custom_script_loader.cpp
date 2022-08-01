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

// This is where scripts' loading functions should be declared:
// void MyExampleScript()
void AddSC_npc_premium_master();
void AddSC_premium_commandscript();
void AddSC_npc_title();
void AddSC_npc_bonus_buff();
void AddSC_CloseZone();
//void AddSC_SpecialCode();
void AddSC_NPC_Dismount();
void AddSC_Exchanger_NPC();
void AddSC_New_Character();
void AddSC_announce_login();
void AddSC_gm_login();
void AddSC_buff();
// void AddSC_PlayedRewards();
void AddSC_Donate_Alert_System();
void AddSC_worldboss_killanons();
void AddSC_boss_commandscript();
void AddSC_GoldOnKill();
void AddSC_pvp_token_rew();

// WorldBoss
void AddSC_Arzhara_Fun_boss_1();
void AddSC_Arzhara_Fun_boss_2();
void AddSC_boss_Custom_5(); // Mir3
void AddSC_Arzhara_Fun_boss_4();
void AddSC_boss_two(); // Mir5
void AddSC_Arzhara_Fun_boss_6();
void AddSC_Arzhara_Fun_boss_7();

// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddCustomScripts()
{
    AddSC_npc_premium_master();
    AddSC_premium_commandscript();
    AddSC_npc_title();
    AddSC_npc_bonus_buff();
    AddSC_CloseZone();
   // AddSC_SpecialCode();
    AddSC_NPC_Dismount();
    AddSC_Exchanger_NPC();
    AddSC_New_Character();
    AddSC_announce_login();
    AddSC_gm_login();
    AddSC_buff();
   // AddSC_PlayedRewards();
    AddSC_Donate_Alert_System();
    AddSC_worldboss_killanons();
    AddSC_Arzhara_Fun_boss_1();
    AddSC_Arzhara_Fun_boss_2();
    AddSC_boss_Custom_5(); 
    AddSC_Arzhara_Fun_boss_4();
    AddSC_boss_two(); 
    AddSC_Arzhara_Fun_boss_6();
    AddSC_Arzhara_Fun_boss_7();
    AddSC_boss_commandscript();
    AddSC_GoldOnKill();
    AddSC_pvp_token_rew();
}
