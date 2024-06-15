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
void AddSC_event_brewfest_scripts();
void AddSC_event_hallows_end_scripts();
void AddSC_event_pilgrims_end_scripts();
void AddSC_event_winter_veil_scripts();
void AddSC_event_love_in_the_air();
void AddSC_event_midsummer_scripts();
void AddSC_event_childrens_week();
void AddSC_event_firework_show_scripts();

// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddEventsScripts()
{
    AddSC_event_brewfest_scripts();
    AddSC_event_hallows_end_scripts();
    AddSC_event_pilgrims_end_scripts();
    AddSC_event_winter_veil_scripts();
    AddSC_event_love_in_the_air();
    AddSC_event_midsummer_scripts();
    AddSC_event_childrens_week();
    AddSC_event_firework_show_scripts();
}
