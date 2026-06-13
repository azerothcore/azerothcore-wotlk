/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Config.h"
#include "MapBuilder.h"
#include "PathCommon.h"
#include "Timer.h"
#include "Util.h"
#include <boost/filesystem.hpp>

using namespace MMAP;

bool checkDirectories(const std::string &dataDirPath, bool debugOutput)
{
    std::vector<std::string> dirFiles;

    if (getDirContents(dirFiles, (std::filesystem::path(dataDirPath) / "maps").string()) == LISTFILE_DIRECTORY_NOT_FOUND || dirFiles.empty())
    {
        printf("'maps' directory is empty or does not exist\n");
        return false;
    }

    dirFiles.clear();
    if (getDirContents(dirFiles, (std::filesystem::path(dataDirPath) / "vmaps").string(), "*.vmtree") == LISTFILE_DIRECTORY_NOT_FOUND || dirFiles.empty())
    {
        printf("'vmaps' directory is empty or does not exist\n");
        return false;
    }

    dirFiles.clear();
    if (getDirContents(dirFiles, (std::filesystem::path(dataDirPath) / "mmaps").string()) == LISTFILE_DIRECTORY_NOT_FOUND)
    {
        return boost::filesystem::create_directory((std::filesystem::path(dataDirPath) / "mmaps").string());
    }

    dirFiles.clear();
    if (debugOutput && getDirContents(dirFiles, (std::filesystem::path(dataDirPath) / "meshes").string()) == LISTFILE_DIRECTORY_NOT_FOUND)
    {
        printf("'meshes' directory does not exist creating...\n");
        return boost::filesystem::create_directory((std::filesystem::path(dataDirPath) / "meshes").string());
    }

    return true;
}

bool handleArgs(int argc, char** argv,
                int& mapnum,
                int& tileX,
                int& tileY,
                std::string& configFilePath,
                bool& silent,
                char*& offMeshInputPath,
                char*& file,
                unsigned int& threads)
{
    bool hasCustomConfigPath = false;
    char* param = nullptr;
    for (int i = 1; i < argc; ++i)
    {
        if (strcmp(argv[i], "--config") == 0)
        {
            param = argv[++i];
            if (!param)
                return false;

            hasCustomConfigPath = true;
            configFilePath = param;
        }
        else if (strcmp(argv[i], "--threads") == 0)
        {
            param = argv[++i];
            if (!param)
                return false;
            threads = static_cast<unsigned int>(std::max(0, atoi(param)));
        }
        else if (strcmp(argv[i], "--file") == 0)
        {
            param = argv[++i];
            if (!param)
                return false;
            file = param;
        }
        else if (strcmp(argv[i], "--tile") == 0)
        {
            param = argv[++i];
            if (!param)
                return false;

            char* stileX = strtok(param, ",");
            char* stileY = strtok(nullptr, ",");
            int tilex = atoi(stileX);
            int tiley = atoi(stileY);

            if ((tilex > 0 && tilex < 64) || (tilex == 0 && strcmp(stileX, "0") == 0))
                tileX = tilex;
            if ((tiley > 0 && tiley < 64) || (tiley == 0 && strcmp(stileY, "0") == 0))
                tileY = tiley;

            if (tileX < 0 || tileY < 0)
            {
                printf("invalid tile coords.\n");
                return false;
            }
        }
        else if (strcmp(argv[i], "--silent") == 0)
        {
            silent = true;
        }
        else if (strcmp(argv[i], "--offMeshInput") == 0)
        {
            param = argv[++i];
            if (!param)
                return false;

            offMeshInputPath = param;
        }
        else
        {
            int map = atoi(argv[i]);
            if (map > 0 || (map == 0 && (strcmp(argv[i], "0") == 0)))
                mapnum = map;
            else
            {
                printf("invalid map id\n");
                return false;
            }
        }
    }

    if (!hasCustomConfigPath)
    {
        FILE* f = fopen(configFilePath.c_str(), "r");
        if (!f)
        {
            auto execRelPath = std::filesystem::path(executableDirectoryPath())/configFilePath;
            f = fopen(execRelPath.string().c_str(), "r");
            if (!f)
            {
                printf("Failed to load configuration. Ensure that 'mmaps-config.yaml' exists in the current directory or specify its path using the --config option.'\n");
                return false;
            }
            configFilePath = execRelPath.string();
        }
        fclose(f);
    }

    return true;
}

int finish(const char* message, int returnValue)
{
    printf("%s", message);
    getchar(); // Wait for user input
    return returnValue;
}

int main(int argc, char** argv)
{
    unsigned int threads = std::thread::hardware_concurrency();
    int mapnum = -1;
    int tileX = -1, tileY = -1;
    bool silent = false;
    char* offMeshInputPath = nullptr;
    char* file = nullptr;
    std::string configFilePath = "mmaps-config.yaml";
    bool validParam = handleArgs(argc, argv, mapnum,
                                 tileX, tileY, configFilePath, silent, offMeshInputPath, file, threads);

    if (!validParam)
        return silent ? -1 : finish("You have specified invalid parameters", -1);

    auto config = Config::FromFile(configFilePath);
    if (!config)
        return silent ? -1 : finish("Failed to load configuration. Ensure that 'mmaps-config.yaml' exists in the current directory or specify its path using the --config option.", -1);

    if (mapnum == -1 && config->IsDebugOutputEnabled())
    {
        if (silent)
            return -2;

        printf("You have specified debug output, but didn't specify a map to generate.\n");
        printf("This will generate debug output for ALL maps.\n");
        printf("Are you sure you want to continue? (y/n) ");
        if (getchar() != 'y')
            return 0;
    }

    if (!checkDirectories(config->DataDirPath(), config->IsDebugOutputEnabled()))
        return silent ? -3 : finish("Press ENTER to close...", -3);

    MapBuilder builder(&config.value(), mapnum, offMeshInputPath, threads);

    uint32 start = getMSTime();
    if (file)
        builder.buildMeshFromFile(file);
    else if (tileX > -1 && tileY > -1 && mapnum >= 0)
        builder.buildSingleTile(mapnum, tileX, tileY);
    else if (mapnum >= 0)
        builder.buildMaps(uint32(mapnum));
    else
        builder.buildMaps({});

    if (!silent)
        printf("Finished. MMAPS were built in %s\n", secsToTimeString(GetMSTimeDiffToNow(start) / 1000).c_str());
    return 0;
}
