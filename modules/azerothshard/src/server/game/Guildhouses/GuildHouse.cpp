/*
 * Copyright (C) 2009-2010 Trilogy <http://www.wowtrilogy.com/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/**
 *
 * @File : GuildHouse.cpp
 *
 * @Authors : Lazzalf
 *
 * @Date : 31/03/2010
 *
 * @Version : 0.1
 *
 **/

#include "GuildHouse.h"
#include "ObjectMgr.h"
#include "GuildMgr.h"
#include "Guild.h"
#include "ObjectAccessor.h"
#include "MapManager.h"

GuildHouseObject GHobj;

GuildHouseObject::GuildHouseObject()
{
    GH_map.clear();
    GH_AddHouse.clear();
    mGuildGuardID.clear();
}

bool GuildHouseObject::CheckGuildID(uint32 guild_id)
{
    if (!guild_id)
        return false;

    Guild* guild = sGuildMgr->GetGuildById(guild_id);  
    
    if (!guild_id)
    {
		sLog->outDebug(LOG_FILTER_GUILDHOUSE,"The guild %u not found", guild_id);
        return false;
    }
    return true;
}

bool GuildHouseObject::CheckGuildHouse(uint32 guild_id)
{
    GuildHouseMap::const_iterator itr = GH_map.find(guild_id);
    if (itr == GH_map.end()) 
        return false;
    return true;
}

bool GuildHouseObject::ChangeGuildHouse(uint32 guild_id, uint32 newid)
{
    if (newid == 0) // Vendi
    {        
        GuildHouseMap::iterator itr = GH_map.find(guild_id);
        if (itr == GH_map.end())
            return true;
        QueryResult result = WorldDatabase.PQuery("UPDATE `guildhouses` SET `guildId` = 0 WHERE `guildId` = %u", guild_id);
        RemoveGuildHouseAdd(itr->second.Id);
        GH_map.erase(guild_id);
    }
    else // Compra
    {
        QueryResult result;
        GuildHouseMap::iterator itr = GH_map.find(guild_id);
        
        result = WorldDatabase.PQuery("SELECT `x`, `y`, `z`, `map`, `minguildsize`, `price` FROM `guildhouses` WHERE `id` = %u", newid);
        if (!result)
            return false; // Id doesn't valid

        if (!(itr == GH_map.end()))
            ChangeGuildHouse(guild_id, 0); // remove old House        
        
        uint32 id = newid;
        Field *fields = result->Fetch();
        float x = fields[0].GetFloat();
        float y = fields[1].GetFloat();
        float z = fields[2].GetFloat();
        uint32 map = fields[3].GetUInt32();
        uint32 minguildsize = fields[4].GetUInt32();
        uint32 price = fields[5].GetUInt32();

        uint32 add = 1;

        result = CharacterDatabase.PQuery("SELECT `GuildHouse_Add` FROM `gh_guildadd` WHERE `guildId` = %u", guild_id);
        if (result)
        {
            Field *fields = result->Fetch();
            add = fields[0].GetUInt32();
        }
        else
        {
            CharacterDatabase.PQuery("INSERT INTO `gh_guildadd` (`guildId`,`GuildHouse_Add`) VALUES ( %u , 1 )", guild_id);
        }

        GuildHouse NewGH(guild_id, id, x, y, z, map, minguildsize, price, add);
        GH_map[guild_id] = NewGH;

        result = WorldDatabase.PQuery("UPDATE `guildhouses` SET `guildId` = %u WHERE `id` = %u", guild_id, newid);
        AddGuildHouseAdd(newid, add, guild_id);
    }
    return true;
}

bool GuildHouseObject::GetGuildHouseLocation(uint32 guild_id, float &x, float &y, float &z, float &o, uint32 &map)
{
    GuildHouseMap::const_iterator itr = GH_map.find(guild_id);
    if (itr == GH_map.end()) 
        return false;
    x = itr->second.m_X;
    y = itr->second.m_Y;
    z = itr->second.m_Z;
    o = itr->second.m_orient;
    map = itr->second.m_map;
    return true;
}

bool GuildHouseObject::GetGuildHouseMap(uint32 guild_id, uint32 &map)
{
    GuildHouseMap::const_iterator itr = GH_map.find(guild_id);
    if (itr == GH_map.end()) 
        return false;
    map = itr->second.m_map;
    return true;
}

uint32 GuildHouseObject::GetGuildHouse_Add(uint32 guild_id)
{
    GuildHouseMap::const_iterator itr = GH_map.find(guild_id);
    if (itr == GH_map.end()) 
        return 0;
    return itr->second.GuildHouse_Add;
};

bool GuildHouseObject::Add_GuildhouseAdd(uint32 guild_id, uint32 add)
{
    GuildHouseMap::iterator itr = GH_map.find(guild_id);
    if (itr == GH_map.end()) 
        return false;  
    uint32 NewAdd = (uint32(1) << (add-1));
    itr->second.AddGuildHouse_Add(NewAdd);
    return true;
};

bool GuildHouseObject::RemoveGuildHouseAdd(uint32 id)
{
    for (uint32 i = 1; i < NPC_MAX; i++)
    {
        uint32 find = ((id << 16) | i);
        GH_Add::iterator itr = GH_AddHouse.find(find);
        if (itr == GH_AddHouse.end()) 
            continue;
        if (!(itr->second.spawned))  // Non despawnare se è già despawnato
                continue;
        gh_Item_Vector::iterator itr2 =  itr->second.AddCre.begin();
        for (; itr2 != itr->second.AddCre.end(); itr2++)
        {
            if (CreatureData const* data = sObjectMgr->GetCreatureData(*itr2))
            {
                sObjectMgr->RemoveCreatureFromGrid(*itr2, data);
                if(Creature* pCreature = sObjectAccessor->GetObjectInWorld(MAKE_NEW_GUID(*itr2, data->id, HIGHGUID_UNIT), (Creature*)NULL))
                    pCreature->AddObjectToRemoveList();
            }
        }
        itr2 =  itr->second.AddGO.begin();
        for (; itr2 != itr->second.AddGO.end(); itr2++)
        {
            if (GameObjectData const* data = sObjectMgr->GetGOData(*itr2))
            { 
                sObjectMgr->RemoveGameobjectFromGrid(*itr2, data);
                if (GameObject* pGameobject = sObjectAccessor->GetObjectInWorld(MAKE_NEW_GUID(*itr2, data->id, HIGHGUID_GAMEOBJECT), (GameObject*)NULL) )
                     pGameobject->AddObjectToRemoveList();
            }
        }               
        itr->second.spawned = false;
    }
    return true;
}

bool GuildHouseObject::AddGuildHouseAdd(uint32 id, uint32 add, uint32 guild)
{
    for (uint8 i = 1; i < NPC_MAX; i++)
    {
        if (((uint32)1 << (i-1)) & add)
        {
            uint32 find = ((id << 16) | i);
            GH_Add::iterator itr = GH_AddHouse.find(find);
            if (itr == GH_AddHouse.end())
                continue;
            if (itr->second.spawned) //Non rispawnare se è già spawnato
                continue;
            gh_Item_Vector::iterator itr2 =  itr->second.AddGO.begin();
            for (; itr2 != itr->second.AddGO.end(); itr2++)
            {
                if (GameObjectData const* data = sObjectMgr->GetGOData(*itr2))
                {
                    sObjectMgr->AddGameobjectToGrid(*itr2, data);

                    Map* map = const_cast<Map*>(sMapMgr->CreateBaseMap(data->mapid));

                    if (!map->Instanceable() && map->IsGridLoaded(data->posX, data->posY))
                    {
                        GameObject* pGameobject = new GameObject;
                        //sLog->outDebug("Spawning gameobject %u", itr2->first);
                        if (!pGameobject->LoadFromDB(*itr2, map))
                            delete pGameobject;
                        else
                        {
                            if (pGameobject->isSpawnedByDefault())
                                map->AddToMap(pGameobject);
                        }
                    }                       
                }
            }
            itr2 =  itr->second.AddCre.begin();
            for (; itr2 != itr->second.AddCre.end(); itr2++)
            {                
                if (CreatureData const* data = sObjectMgr->GetCreatureData(*itr2))
                {
                    sObjectMgr->AddCreatureToGrid(*itr2, data);
                                           
                    if (i == 2) //Guard
                    {
                        UpdateGuardMap(*itr2, guild);
                        sLog->outDebug(LOG_FILTER_GUILDHOUSE, "GuildHouse: insert guard with GUID: %u,Guild: %u", *itr2, guild);
                    }

                    Map* map = const_cast<Map*>(sMapMgr->CreateBaseMap(data->mapid));
                    
                    if (!map->Instanceable() && map->IsGridLoaded(data->posX, data->posY))
                    {
                        Creature* pCreature = new Creature;
                        //sLog->outDebug("Spawning creature %u",itr2->first);
                        if (!pCreature->LoadFromDB(*itr2, map))
                            delete pCreature;
                        else
                        {
                            map->AddToMap(pCreature);
                        }
                    }                           
                }
                
            }
            itr->second.spawned = true;
        }
    }
    return true;
}        

void GuildHouseObject::LoadGuildHouse()
{
    GH_map.clear();
    QueryResult result = WorldDatabase.Query("SELECT `id`,`guildId`,`x`,`y`,`z`,`map`,`minguildsize`,`price` FROM guildhouses ORDER BY guildId ASC");

    if (!result)
    {
        sLog->outError("Loaded 0 Guildhouses - NO RESULT FROM QUERY");
        return;
    }

    do
    {
        Field *fields = result->Fetch();

        uint32 id = fields[0].GetUInt32();
        uint32 guildID = fields[1].GetUInt32();
        float x   = fields[2].GetFloat();
        float y   = fields[3].GetFloat();
        float z   = fields[4].GetFloat();
        uint32 map = fields[5].GetUInt32();
        uint32 min_member = fields[6].GetUInt32();
        uint32 cost = fields[7].GetUInt32();
        uint32 add = 1;

        if(guildID)
        {
			if (!CheckGuildID(guildID))
			{
                sLog->outError("Guild %u does not exist - guildhouse not loaded", guildID);
				continue;
			}
                

            QueryResult result2 = CharacterDatabase.PQuery("SELECT `GuildHouse_Add` FROM `gh_guildadd` WHERE `guildId` = %u", guildID);
            if (result2)
            {
                sLog->outError("Loaded guildadd information for guild %u", guildID);
                Field *fields2 = result2->Fetch();
                add = fields2[0].GetUInt32();
            }

            GuildHouse NewGH(guildID, id, x, y, z, map, min_member, cost, add);
            GH_map[guildID] = NewGH;

            RemoveGuildHouseAdd(id);
            AddGuildHouseAdd(id, add, guildID);
        }
		else
        {
            sLog->outError("Loading GH for guild %u failed - NOT VALID", guildID);
			RemoveGuildHouseAdd(id);
		}
    } 
    while (result->NextRow());


    sLog->outError("Loaded  %u Guildhouses", GH_map.size());
}

void GuildHouseObject::LoadGuildHouseAdd()
{
    GH_AddHouse.clear();
    mGuildGuardID.clear();


    sLog->outError("Loading GuildHouse npcs - objects...");

    QueryResult result = WorldDatabase.Query("SELECT `guid`,`type`,`id`,`add_type` FROM guildhouses_add ORDER BY Id ASC");

    if (!result)
    {

        sLog->outError("Loaded 0 guildhouse npcs - objects");
        return;
    }

    do
    {
        Field *fields = result->Fetch();

        uint32 guid         = fields[0].GetUInt32();
        uint16 type         = fields[1].GetUInt16();
        uint16 id           = fields[2].GetUInt16();
        uint16 add_type     = fields[3].GetUInt16();

        uint32 find = 0;
        find = ( (uint32)id << 16 ) | (uint32)add_type;
        if (type == CREATURE)
        {
            if (!sObjectMgr->GetCreatureData(guid))                
            {                
                sLog->outError("Data for creature %u not present", guid);
                continue;
            }
            GH_AddHouse[find].AddCre.push_back(guid);
        }
        else if (type == OBJECT)
        {
            if (!sObjectMgr->GetGOData(guid))
            {                
                sLog->outError("Data for gameobject %u not present", guid);
                continue;
            }
            GH_AddHouse[find].AddGO.push_back(guid);
        }
    } 
    while (result->NextRow());

    sLog->outError("Loaded  %u Guildhouse objects", GH_AddHouse.size());
}

uint32 GuildHouseObject::GetGuildByGuardID(uint32 guid)
{
    GuildGuardID::const_iterator itr = mGuildGuardID.find(guid);
    if (itr == mGuildGuardID.end()) 
        return 0;
    return itr->second;
}

uint32 GuildHouseObject::GetGuildByGuardID(Creature* guardia)
{
    //override della funzione presunta causa del bug delle guardie
	uint32 guid = guardia->GetDBTableGUIDLow();
	GuildGuardID::const_iterator i = mGuildGuardID.begin();
    for (; i != mGuildGuardID.end(); ++i)
    {
		if((*i).first == guid)
			return (*i).second;
	}
	return 0;
}

void GuildHouseObject::UpdateGuardMap(uint32 guid, uint32 guild)
{
    GuildGuardID::iterator itr = mGuildGuardID.find(guid);
    if (itr == mGuildGuardID.end()) 
        mGuildGuardID[guid] = guild;
    else
        itr->second = guild;
}

GuildHouse::GuildHouse(uint32 guild_id, uint32 guild_add)
{
    GuildId = guild_id;    
    GuildHouse_Add = guild_add;
    Id = 0;
    m_X = 0;
    m_Y = 0;  
    m_Z = 0;
    m_orient = 0;
    m_map = 0;
    min_member = 0;
    price = 0;
}

GuildHouse::GuildHouse(uint32 newGuildId, uint32 newId, float x, float y, float z, uint32 map, uint32 member, uint32 cost, uint32 add)
{
    GuildId = newGuildId;
    Id = newId;
    m_X = x;
    m_Y = y;  
    m_Z = z;
    m_map = map;
    min_member = member;
    price = cost;
    m_orient = 0;
    GuildHouse_Add = add;
}

void GuildHouse::AddGuildHouse_Add(uint32 NewAdd)
{
    GuildHouse_Add |= NewAdd;
    QueryResult result = CharacterDatabase.PQuery("UPDATE `gh_guildadd` SET `GuildHouse_Add` = %u WHERE `guildId` = %u", GuildHouse_Add, GuildId);
    GHobj.AddGuildHouseAdd(Id, NewAdd, GuildId);
}

void GuildHouseObject::LoadGuildHouseSystem()
{
    GHobj.LoadGuildHouseAdd();
    GHobj.LoadGuildHouse();
}

void GuildHouseObject::ControlGuildHouse()
{
    for (GuildHouseMap::iterator itr = GH_map.begin(); itr != GH_map.end(); itr++)
    {
        if (Guild* pGuild = sGuildMgr->GetGuildById((*itr).first))
            if (pGuild->GetMemberSize() < (*itr).second.min_member)
            {                    
                GHobj.ChangeGuildHouse((*itr).first, 0);
                SQLTransaction trans = CharacterDatabase.BeginTransaction();
                pGuild->ModifyBankMoney(trans, (*itr).second.price * 75000, true);
                CharacterDatabase.CommitTransaction(trans);
            }           
    }
}