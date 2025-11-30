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

// Progressive Systems Custom Scripts
void AddSC_progressive_npcs();
void AddSC_progressive_bosses();
void AddSC_progressive_items();
void AddSC_progressive_spells();
void AddSC_progressive_dungeons();
void AddSC_progressive_commands();
void AddSC_custom_stats_system();
void AddSC_paragon_system();

// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddCustomScripts()
{
    // Progressive Systems Scripts
    AddSC_progressive_npcs();
    AddSC_progressive_bosses();
    AddSC_progressive_items();
    AddSC_progressive_spells();
    AddSC_progressive_dungeons();
    AddSC_progressive_commands();
    AddSC_custom_stats_system();
    AddSC_paragon_system();
}
