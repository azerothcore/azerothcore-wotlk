/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2020 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DBCSTORE_H
#define DBCSTORE_H

#include "Common.h"
#include "DBCStorageIterator.h"
#include "Errors.h"
#include <G3D/AABox.h>
#include <G3D/Vector3.h>
#include <cstring>
#include <vector>

 // Structures for M4 file. Source: https://wowdev.wiki
template<typename T>
struct M2SplineKey
{
    T p0;
    T p1;
    T p2;
};

struct M2Header
{
    char   Magic[4];               // "MD20"
    uint32 Version;                // The version of the format.
    uint32 lName;                  // Length of the model's name including the trailing \0
    uint32 ofsName;                // Offset to the name, it seems like models can get reloaded by this name.should be unique, i guess.
    uint32 GlobalModelFlags;       // 0x0001: tilt x, 0x0002: tilt y, 0x0008: add 2 fields in header, 0x0020: load .phys data (MoP+), 0x0080: has _lod .skin files (MoP?+), 0x0100: is camera related.
    uint32 nGlobalSequences;
    uint32 ofsGlobalSequences;     // A list of timestamps.
    uint32 nAnimations;
    uint32 ofsAnimations;          // Information about the animations in the model.
    uint32 nAnimationLookup;
    uint32 ofsAnimationLookup;     // Mapping of global IDs to the entries in the Animation sequences block.
    uint32 nBones;                 // MAX_BONES = 0x100
    uint32 ofsBones;               // Information about the bones in this model.
    uint32 nKeyBoneLookup;
    uint32 ofsKeyBoneLookup;       // Lookup table for key skeletal bones.
    uint32 nVertices;
    uint32 ofsVertices;            // Vertices of the model.
    uint32 nViews;                 // Views (LOD) are now in .skins.
    uint32 nSubmeshAnimations;
    uint32 ofsSubmeshAnimations;   // Submesh color and alpha animations definitions.
    uint32 nTextures;
    uint32 ofsTextures;            // Textures of this model.
    uint32 nTransparency;
    uint32 ofsTransparency;        // Transparency of textures.
    uint32 nUVAnimation;
    uint32 ofsUVAnimation;
    uint32 nTexReplace;
    uint32 ofsTexReplace;          // Replaceable Textures.
    uint32 nRenderFlags;
    uint32 ofsRenderFlags;         // Blending modes / render flags.
    uint32 nBoneLookupTable;
    uint32 ofsBoneLookupTable;     // A bone lookup table.
    uint32 nTexLookup;
    uint32 ofsTexLookup;           // The same for textures.
    uint32 nTexUnits;              // possibly removed with cata?!
    uint32 ofsTexUnits;            // And texture units. Somewhere they have to be too.
    uint32 nTransLookup;
    uint32 ofsTransLookup;         // Everything needs its lookup. Here are the transparencies.
    uint32 nUVAnimLookup;
    uint32 ofsUVAnimLookup;
    G3D::AABox BoundingBox;            // min/max( [1].z, 2.0277779f ) - 0.16f seems to be the maximum camera height
    float  BoundingSphereRadius;
    G3D::AABox CollisionBox;
    float  CollisionSphereRadius;
    uint32 nBoundingTriangles;
    uint32 ofsBoundingTriangles;   // Our bounding volumes. Similar structure like in the old ofsViews.
    uint32 nBoundingVertices;
    uint32 ofsBoundingVertices;
    uint32 nBoundingNormals;
    uint32 ofsBoundingNormals;
    uint32 nAttachments;
    uint32 ofsAttachments;         // Attachments are for weapons etc.
    uint32 nAttachLookup;
    uint32 ofsAttachLookup;        // Of course with a lookup.
    uint32 nEvents;
    uint32 ofsEvents;              // Used for playing sounds when dying and a lot else.
    uint32 nLights;
    uint32 ofsLights;              // Lights are mainly used in loginscreens but in wands and some doodads too.
    uint32 nCameras;               // Format of Cameras changed with version 271!
    uint32 ofsCameras;             // The cameras are present in most models for having a model in the Character-Tab.
    uint32 nCameraLookup;
    uint32 ofsCameraLookup;        // And lookup-time again.
    uint32 nRibbonEmitters;
    uint32 ofsRibbonEmitters;      // Things swirling around. See the CoT-entrance for light-trails.
    uint32 nParticleEmitters;
    uint32 ofsParticleEmitters;    // Spells and weapons, doodads and loginscreens use them. Blood dripping of a blade? Particles.
    uint32 nBlendMaps;             // This has to deal with blending. Exists IFF (flags & 0x8) != 0. When set, textures blending is overriden by the associated array. See M2/WotLK#Blend_mode_overrides
    uint32 ofsBlendMaps;           // Same as above. Points to an array of uint16 of nBlendMaps entries -- From WoD information.};
};

struct M2Array
{
    uint32_t number;
    uint32 offset_elements;
};
struct M2Track
{
    uint16_t interpolation_type;
    uint16_t global_sequence;
    M2Array timestamps;
    M2Array values;
};

struct M2Camera
{
    uint32_t type; // 0: portrait, 1: characterinfo; -1: else (flyby etc.); referenced backwards in the lookup table.
    float fov; // No radians, no degrees. Multiply by 35 to get degrees.
    float far_clip;
    float near_clip;
    M2Track positions; // How the camera's position moves. Should be 3*3 floats.
    G3D::Vector3 position_base;
    M2Track target_positions; // How the target moves. Should be 3*3 floats.
    G3D::Vector3 target_position_base;
    M2Track rolldata; // The camera can have some roll-effect. Its 0 to 2*Pi.
};

struct FlyByCamera
{
    uint32 timeStamp;
    G3D::Vector4 locations;
};

/// Interface class for common access
class DBCStorageBase
{
public:
    DBCStorageBase(char const* fmt);
    virtual ~DBCStorageBase();

    [[nodiscard]] char const* GetFormat() const { return _fileFormat; }
    [[nodiscard]] uint32 GetFieldCount() const { return _fieldCount; }

    virtual bool Load(char const* path) = 0;
    virtual bool LoadStringsFrom(char const* path) = 0;
    virtual void LoadFromDB(char const* table, char const* format) = 0;

protected:
    bool Load(char const* path, char**& indexTable);
    bool LoadStringsFrom(char const* path, char** indexTable);
    void LoadFromDB(char const* table, char const* format, char**& indexTable);

    uint32 _fieldCount;
    char const* _fileFormat;
    char* _dataTable;
    std::vector<char*> _stringPool;
    uint32 _indexTableSize;
};

template <class T>
class DBCStorage : public DBCStorageBase
{
public:
    typedef DBCStorageIterator<T> iterator;

    explicit DBCStorage(char const* fmt) : DBCStorageBase(fmt)
    {
        _indexTable.AsT = nullptr;
    }

    ~DBCStorage() override
    {
        delete[] reinterpret_cast<char*>(_indexTable.AsT);
    }

    [[nodiscard]] T const* LookupEntry(uint32 id) const { return (id >= _indexTableSize) ? nullptr : _indexTable.AsT[id]; }
    [[nodiscard]] T const* AssertEntry(uint32 id) const { return ASSERT_NOTNULL(LookupEntry(id)); }

#ifdef ELUNA
    void SetEntry(uint32 id, T* t)
    {
        if (id >= _indexTableSize)
        {
            // Resize
            typedef char* ptr;
            size_t newSize = id + 1;
            ptr* newArr = new ptr[newSize];
            memset(newArr, 0, newSize * sizeof(ptr));
            memcpy(newArr, _indexTable.AsChar, _indexTableSize * sizeof(ptr));
            delete[] reinterpret_cast<char*>(_indexTable.AsT);
            _indexTable.AsChar = newArr;
            _indexTableSize = newSize;
        }

        delete _indexTable.AsT[id];
        _indexTable.AsT[id] = t;
    }
#endif

    [[nodiscard]] uint32 GetNumRows() const { return _indexTableSize; }

    bool Load(char const* path) override
    {
        return DBCStorageBase::Load(path, _indexTable.AsChar);
    }

    bool LoadStringsFrom(char const* path) override
    {
        return DBCStorageBase::LoadStringsFrom(path, _indexTable.AsChar);
    }

    void LoadFromDB(char const* table, char const* format) override
    {
        DBCStorageBase::LoadFromDB(table, format, _indexTable.AsChar);
    }

    iterator begin() { return iterator(_indexTable.AsT, _indexTableSize); }
    iterator end() { return iterator(_indexTable.AsT, _indexTableSize, _indexTableSize); }

private:
    union
    {
        T** AsT;
        char** AsChar;
    }
    _indexTable;

    DBCStorage(DBCStorage const& right) = delete;
    DBCStorage& operator=(DBCStorage const& right) = delete;
};

#endif
