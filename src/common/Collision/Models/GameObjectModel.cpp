/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "VMapFactory.h"
#include "VMapManager2.h"
#include "VMapDefinitions.h"
#include "WorldModel.h"

#include "GameObjectModel.h"
#include "Log.h"
#include "GameObject.h"
#include "Creature.h"
#include "TemporarySummon.h"
#include "Object.h"
#include "DBCStores.h"
#include "World.h"

using G3D::Vector3;
using G3D::Ray;
using G3D::AABox;

struct GameobjectModelData
{
    GameobjectModelData(char const* name_, uint32 nameLength, Vector3 const& lowBound, Vector3 const& highBound, bool isWmo_) :
        bound(lowBound, highBound), name(name_, nameLength), isWmo(isWmo_) { }

    AABox bound;
    std::string name;
    bool isWmo;
};

typedef std::unordered_map<uint32, GameobjectModelData> ModelList;
ModelList model_list;

void LoadGameObjectModelList()
{
    //#ifndef NO_CORE_FUNCS
    uint32 oldMSTime = getMSTime();
    //#endif

    FILE* model_list_file = fopen((sWorld->GetDataPath() + "vmaps/" + VMAP::GAMEOBJECT_MODELS).c_str(), "rb");
    if (!model_list_file)
    {
        sLog->outError("Unable to open '%s' file.", VMAP::GAMEOBJECT_MODELS);
        return;
    }

    char magic[8];
    if (fread(magic, 1, 8, model_list_file) != 8 || memcmp(magic, VMAP::VMAP_MAGIC, 8) != 0)
    {
        sLog->outError("File '%s' has wrong header, expected %s.", VMAP::GAMEOBJECT_MODELS, VMAP::VMAP_MAGIC);
        return;
    }

    uint32 name_length, displayId;
    uint8 isWmo;
    char buff[500];
    while (true)
    {
        Vector3 v1, v2;
        if (fread(&displayId, sizeof(uint32), 1, model_list_file) != 1)
            if (feof(model_list_file))  // EOF flag is only set after failed reading attempt
                break;

        if (fread(&isWmo, sizeof(uint8), 1, model_list_file) != 1
            || fread(&name_length, sizeof(uint32), 1, model_list_file) != 1
            || name_length >= sizeof(buff)
            || fread(&buff, sizeof(char), name_length, model_list_file) != name_length
            || fread(&v1, sizeof(Vector3), 1, model_list_file) != 1
            || fread(&v2, sizeof(Vector3), 1, model_list_file) != 1)
        {
            sLog->outError("File '%s' seems to be corrupted!", VMAP::GAMEOBJECT_MODELS);
            break;
        }

        if (v1.isNaN() || v2.isNaN())
        {
            sLog->outError("File '%s' Model '%s' has invalid v1%s v2%s values!",
                VMAP::GAMEOBJECT_MODELS, std::string(buff, name_length).c_str(), v1.toString().c_str(), v2.toString().c_str());
            continue;
        }

        model_list.emplace(std::piecewise_construct, std::forward_as_tuple(displayId), std::forward_as_tuple(&buff[0], name_length, v1, v2, isWmo != 0));
    }

    fclose(model_list_file);
    sLog->outString(">> Loaded %u GameObject models in %u ms", uint32(model_list.size()), GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

GameObjectModel::~GameObjectModel()
{
    if (iModel)
        ((VMAP::VMapManager2*)VMAP::VMapFactory::createOrGetVMapManager())->releaseModelInstance(name);
}

bool GameObjectModel::initialize(const GameObject& go, const GameObjectDisplayInfoEntry& info)
{
    ModelList::const_iterator it = model_list.find(info.Displayid);
    if (it == model_list.end())
        return false;

    G3D::AABox mdl_box(it->second.bound);
    // ignore models with no bounds
    if (mdl_box == G3D::AABox::zero())
    {
        sLog->outError("GameObject model %s has zero bounds, loading skipped", it->second.name.c_str());
        return false;
    }

    iModel = ((VMAP::VMapManager2*)VMAP::VMapFactory::createOrGetVMapManager())->acquireModelInstance(sWorld->GetDataPath() + "vmaps/", it->second.name);

    if (!iModel)
        return false;

    name = it->second.name;
    //flags = VMAP::MOD_M2;
    //adtId = 0;
    //ID = 0;
    iPos = Vector3(go.GetPositionX(), go.GetPositionY(), go.GetPositionZ());

    // pussywizard:
    phasemask = (go.GetGoState() == GO_STATE_READY || go.IsTransport()) ? go.GetPhaseMask() : 0;

    iScale = go.GetFloatValue(OBJECT_FIELD_SCALE_X);
    iInvScale = 1.f / iScale;

    G3D::Matrix3 iRotation = G3D::Matrix3::fromEulerAnglesZYX(go.GetOrientation(), 0, 0);
    iInvRot = iRotation.inverse();
    // transform bounding box:
    mdl_box = AABox(mdl_box.low() * iScale, mdl_box.high() * iScale);
    AABox rotated_bounds;
    for (int i = 0; i < 8; ++i)
        rotated_bounds.merge(iRotation * mdl_box.corner(i));

    iBound = rotated_bounds + iPos;
#ifdef SPAWN_CORNERS
    // test:
    for (int i = 0; i < 8; ++i)
    {
        Vector3 pos(iBound.corner(i));
        const_cast<GameObject&>(go).SummonCreature(1, pos.x, pos.y, pos.z, 0, TEMPSUMMON_MANUAL_DESPAWN);
    }
#endif

    owner = &go;
    return true;
}

GameObjectModel* GameObjectModel::Create(const GameObject& go)
{
    const GameObjectDisplayInfoEntry* info = sGameObjectDisplayInfoStore.LookupEntry(go.GetDisplayId());
    if (!info)
        return nullptr;

    GameObjectModel* mdl = new GameObjectModel();
    if (!mdl->initialize(go, *info))
    {
        delete mdl;
        return nullptr;
    }

    return mdl;
}

bool GameObjectModel::intersectRay(const G3D::Ray& ray, float& MaxDist, bool StopAtFirstHit, uint32 ph_mask) const
{
    if (!(phasemask & ph_mask) || !owner->isSpawned())
        return false;

    float time = ray.intersectionTime(iBound);
    if (time == G3D::inf())
        return false;

    // child bounds are defined in object space:
    Vector3 p = iInvRot * (ray.origin() - iPos) * iInvScale;
    Ray modRay(p, iInvRot * ray.direction());
    float distance = MaxDist * iInvScale;
    bool hit = iModel->IntersectRay(modRay, distance, StopAtFirstHit);
    if (hit)
    {
        distance *= iScale;
        MaxDist = distance;
    }
    return hit;
}

bool GameObjectModel::UpdatePosition()
{
    if (!iModel)
        return false;

    ModelList::const_iterator it = model_list.find(owner->GetDisplayId());
    if (it == model_list.end())
        return false;

    G3D::AABox mdl_box(it->second.bound);
    // ignore models with no bounds
    if (mdl_box == G3D::AABox::zero())
    {
        //VMAP_ERROR_LOG("misc", "GameObject model %s has zero bounds, loading skipped", it->second.name.c_str());
        return false;
    }

    iPos = Vector3(owner->GetPositionX(), owner->GetPositionY(), owner->GetPositionZ());
    G3D::Matrix3 iRotation = G3D::Matrix3::fromEulerAnglesZYX(owner->GetOrientation(), 0, 0);
    iInvRot = iRotation.inverse();
    // transform bounding box:
    mdl_box = AABox(mdl_box.low() * iScale, mdl_box.high() * iScale);
    AABox rotated_bounds;
    for (int i = 0; i < 8; ++i)
        rotated_bounds.merge(iRotation * mdl_box.corner(i));

    iBound = rotated_bounds + iPos;
#ifdef SPAWN_CORNERS
    // test:
    for (int i = 0; i < 8; ++i)
    {
        Vector3 pos(iBound.corner(i));
        owner->SummonCreature(1, pos.x, pos.y, pos.z, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 10000);
    }
#endif

    return true;
}
