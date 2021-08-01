/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "model.h"
#include "dbcfile.h"
#include "adtfile.h"
#include "vmapexport.h"
#include <algorithm>
#include <cstdio>

bool ExtractSingleModel(std::string& fname)
{
    if (fname.length() < 4)
        return false;

    std::string extension = fname.substr(fname.length() - 4, 4);
    if (extension == ".mdx" || extension == ".MDX" || extension == ".mdl" || extension == ".MDL")
    {
        // replace .mdx -> .m2
        fname.erase(fname.length() - 2, 2);
        fname.append("2");
    }
    // >= 3.1.0 ADT MMDX section store filename.m2 filenames for corresponded .m2 file
    // nothing do

    std::string originalName = fname;

    char* name = GetPlainName((char*)fname.c_str());
    fixnamen(name, strlen(name));
    fixname2(name, strlen(name));

    std::string output(szWorkDirWmo);
    output += "/";
    output += name;

    if (FileExists(output.c_str()))
        return true;

    Model mdl(originalName);
    if (!mdl.open())
        return false;

    return mdl.ConvertToVMAPModel(output.c_str());
}

void ExtractGameobjectModels()
{
    printf("Extracting GameObject models...");
    DBCFile dbc("DBFilesClient\\GameObjectDisplayInfo.dbc");
    if (!dbc.open())
    {
        printf("Fatal error: Invalid GameObjectDisplayInfo.dbc file format!\n");
        exit(1);
    }

    std::string basepath = szWorkDirWmo;
    basepath += "/";
    std::string path;

    std::string modelListPath = basepath + "temp_gameobject_models";
    FILE* model_list = fopen(modelListPath.c_str(), "wb");
    if (!model_list)
    {
        printf("Fatal error: Could not open file %s\n", modelListPath.c_str());
        return;
    }

    fwrite(VMAP::RAW_VMAP_MAGIC, 1, 8, model_list);

    for (const auto & it : dbc)
    {
        path = it.getString(1);

        if (path.length() < 4)
            continue;

        fixnamen((char*)path.c_str(), path.size());
        char* name = GetPlainName((char*)path.c_str());
        fixname2(name, strlen(name));

        char* ch_ext = GetExtension(name);
        if (!ch_ext)
            continue;

        strToLower(ch_ext);

        bool result = false;
        uint8 isWmo = 0;
        if (!strcmp(ch_ext, ".wmo"))
        {
            isWmo = 1;
            result = ExtractSingleWmo(path);
        }
        else if (!strcmp(ch_ext, ".mdl"))
        {
            // TODO: extract .mdl files, if needed
            continue;
        }
        else //if (!strcmp(ch_ext, ".mdx") || !strcmp(ch_ext, ".m2"))
        {
            result = ExtractSingleModel(path);
        }

        if (result)
        {
            uint32 displayId = it.getUInt(0);
            uint32 path_length = strlen(name);
            fwrite(&displayId, sizeof(uint32), 1, model_list);
            fwrite(&isWmo, sizeof(uint8), 1, model_list);
            fwrite(&path_length, sizeof(uint32), 1, model_list);
            fwrite(name, sizeof(char), path_length, model_list);
        }
    }

    fclose(model_list);

    printf("Done!\n");
}
