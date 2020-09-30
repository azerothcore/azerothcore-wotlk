/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DBC_H
#define DBC_H
#include <vector>
#include <string>
#include "Define.h"
#include "Stream.h"

class Record;

class DBC
{
    public:
        DBC(Stream* stream);
        ~DBC();
    
        std::string GetStringByOffset(int offset) const;
    
        Record const* GetRecordById(int id) const;
    
        std::string Name;
        std::vector<Record*> Records;
        int RecordCount;
        int Fields;
        int RecordSize;
        uint8* StringBlock;
        uint32 StringBlockSize;
        bool IsFaulty;
};

class Record
{
    public:
        Record(DBC* dbc) : Source(dbc) {}
    
        DBC* Source;
        std::vector<int> Values;
    
        int operator[](int index) const
        {
            return Values[index];
        }
    
        template <typename T>
        T GetValue(int index) const
        {
            return *(T*)(&Values[index]);
        }
    
        const std::string GetString(int index) const
        {
            return Source->GetStringByOffset(Values[index]);
        }
};

#endif