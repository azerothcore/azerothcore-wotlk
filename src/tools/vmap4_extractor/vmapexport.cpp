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

#define _CRT_SECURE_NO_DEPRECATE
#include <cerrno>
#include <cstdio>
#include <list>
#include <map>
#include <sys/stat.h>
#include <vector>

#ifdef WIN32
#include <Windows.h>
#include <direct.h>
#define mkdir _mkdir
#endif

#undef min
#undef max

//From Extractor
#include "vmapexport.h"
#include "adtfile.h"
#include "dbcfile.h"
#include "mpq_libmpq04.h"
#include "wdtfile.h"
#include "wmo.h"

//------------------------------------------------------------------------------
// Defines

#define MPQ_BLOCK_SIZE 0x1000

//-----------------------------------------------------------------------------

extern ArchiveSet gOpenArchives;

typedef struct
{
    char name[64];
    unsigned int id;
} map_id;

std::vector<map_id> map_ids;
uint32 map_count;
char output_path[128] = ".";
char input_path[1024] = ".";
bool hasInputPathParam = false;
bool preciseVectorData = false;
std::unordered_map<std::string, WMODoodadData> WmoDoodads;

// Constants

char const* szWorkDirWmo = "./Buildings";

std::map<std::pair<uint32, uint16>, uint32> uniqueObjectIds;

uint32 GenerateUniqueObjectId(uint32 clientId, uint16 clientDoodadId)
{
    return uniqueObjectIds.emplace(std::make_pair(clientId, clientDoodadId), uint32(uniqueObjectIds.size() + 1)).first->second;
}

// Local testing functions

bool FileExists(const char* file)
{
    if (FILE* n = fopen(file, "rb"))
    {
        fclose(n);
        return true;
    }
    return false;
}

void strToLower(char* str)
{
    while (*str)
    {
        *str = tolower(*str);
        ++str;
    }
}

bool ExtractSingleWmo(std::string& fname)
{
    // Copy files from archive
    std::string originalName = fname;

    char szLocalFile[1024];
    char* plain_name = GetPlainName(&fname[0]);
    fixnamen(plain_name, strlen(plain_name));
    fixname2(plain_name, strlen(plain_name));
    sprintf(szLocalFile, "%s/%s", szWorkDirWmo, plain_name);

    if (FileExists(szLocalFile))
        return true;

    int p = 0;
    // Select root wmo files
    char const* rchr = strrchr(plain_name, '_');
    if (rchr != nullptr)
    {
        char cpy[4];
        memcpy(cpy, rchr, 4);
        for (int m : cpy)
        {
            if (isdigit(m))
                p++;
        }
    }

    if (p == 3)
        return true;

    bool file_ok = true;
    printf("Extracting %s\n", originalName.c_str());
    WMORoot froot(originalName);
    if (!froot.open())
    {
        printf("Couldn't open RootWmo!!!\n");
        return false;
    }
    FILE* output = fopen(szLocalFile, "wb");
    if (!output)
    {
        printf("couldn't open %s for writing!\n", szLocalFile);
        return false;
    }
    froot.ConvertToVMAPRootWmo(output);
    WMODoodadData& doodads = WmoDoodads[plain_name];
    std::swap(doodads, froot.DoodadData);
    int Wmo_nVertices = 0;
    //printf("root has %d groups\n", froot->nGroups);
    if (froot.nGroups != 0)
    {
        for (uint32 i = 0; i < froot.nGroups; ++i)
        {
            char temp[1024];
            strncpy(temp, fname.c_str(), 1024);
            temp[fname.length() - 4] = 0;
            char groupFileName[1024];
            int ret = snprintf(groupFileName, 1024, "%s_%03u.wmo", temp, i);
            if (ret < 0)
            {
                printf("Error when formatting string");
                return false;
            }
            //printf("Trying to open groupfile %s\n",groupFileName);

            string s = groupFileName;
            WMOGroup fgroup(s);
            if (!fgroup.open(&froot))
            {
                printf("Could not open all Group file for: %s\n", plain_name);
                file_ok = false;
                break;
            }

            Wmo_nVertices += fgroup.ConvertToVMAPGroupWmo(output, preciseVectorData);
            for (uint16 groupReference : fgroup.DoodadReferences)
            {
                if (groupReference >= doodads.Spawns.size())
                    continue;

                uint32 doodadNameIndex = doodads.Spawns[groupReference].NameIndex;
                if (froot.ValidDoodadNames.find(doodadNameIndex) == froot.ValidDoodadNames.end())
                    continue;

                doodads.References.insert(groupReference);
            }
        }
    }

    fseek(output, 8, SEEK_SET); // store the correct no of vertices
    fwrite(&Wmo_nVertices, sizeof(int), 1, output);
    fclose(output);

    // Delete the extracted file in the case of an error
    if (!file_ok)
        remove(szLocalFile);
    return true;
}

void ParsMapFiles()
{
    char fn[512];
    //char id_filename[64];
    for (unsigned int i = 0; i < map_count; ++i)
    {
        sprintf(fn,"World\\Maps\\%s\\%s.wdt", map_ids[i].name, map_ids[i].name);
        WDTFile WDT(fn,map_ids[i].name);
        if (WDT.init(map_ids[i].id))
        {
            printf("Processing Map %u\n[", map_ids[i].id);
            for (int x = 0; x < 64; ++x)
            {
                for (int y = 0; y < 64; ++y)
                {
                    if (ADTFile* ADT = WDT.GetMap(x, y))
                    {
                        //sprintf(id_filename,"%02u %02u %03u",x,y,map_ids[i].id);//!!!!!!!!!
                        ADT->init(map_ids[i].id, x, y);
                        delete ADT;
                    }
                }
                printf("#");
                fflush(stdout);
            }
            printf("]\n");
        }
    }
}

void getGamePath()
{
#ifdef _WIN32
    strcpy(input_path, "Data\\");
#else
    strcpy(input_path, "Data/");
#endif
}

bool scan_patches(char* scanmatch, std::vector<std::string>& pArchiveNames)
{
    int i;
    char path[512];

    for (i = 1; i <= 99; i++)
    {
        if (i != 1)
        {
            sprintf(path, "%s-%d.MPQ", scanmatch, i);
        }
        else
        {
            sprintf(path, "%s.MPQ", scanmatch);
        }
#ifdef __linux__
        if (FILE* h = fopen64(path, "rb"))
#else
        if (FILE* h = fopen(path, "rb"))
#endif
        {
            fclose(h);
            //matches.push_back(path);
            pArchiveNames.emplace_back(path);
        }
    }

    return (true);
}

bool fillArchiveNameVector(std::vector<std::string>& pArchiveNames)
{
    if (!hasInputPathParam)
        getGamePath();

    printf("\nGame path: %s\n", input_path);

    char path[512];
    string in_path(input_path);
    std::vector<std::string> locales, searchLocales;

    searchLocales.emplace_back("enGB");
    searchLocales.emplace_back("enUS");
    searchLocales.emplace_back("deDE");
    searchLocales.emplace_back("esES");
    searchLocales.emplace_back("frFR");
    searchLocales.emplace_back("koKR");
    searchLocales.emplace_back("zhCN");
    searchLocales.emplace_back("zhTW");
    searchLocales.emplace_back("enCN");
    searchLocales.emplace_back("enTW");
    searchLocales.emplace_back("esMX");
    searchLocales.emplace_back("ruRU");

    for (auto & searchLocale : searchLocales)
    {
        std::string localePath = in_path + searchLocale;
        // check if locale exists:
        struct stat status;
        if (stat(localePath.c_str(), &status))
            continue;
        if ((status.st_mode & S_IFDIR) == 0)
            continue;
        printf("Found locale '%s'\n", searchLocale.c_str());
        locales.push_back(searchLocale);
    }
    printf("\n");

    // open locale expansion and common files
    printf("Adding data files from locale directories.\n");
    for (auto & locale : locales)
    {
        pArchiveNames.push_back(in_path + locale + "/locale-" + locale + ".MPQ");
        pArchiveNames.push_back(in_path + locale + "/expansion-locale-" + locale + ".MPQ");
        pArchiveNames.push_back(in_path + locale + "/lichking-locale-" + locale + ".MPQ");
    }

    // open expansion and common files
    pArchiveNames.push_back(input_path + string("common.MPQ"));
    pArchiveNames.push_back(input_path + string("common-2.MPQ"));
    pArchiveNames.push_back(input_path + string("expansion.MPQ"));
    pArchiveNames.push_back(input_path + string("lichking.MPQ"));

    // now, scan for the patch levels in the core dir
    printf("Scanning patch levels from data directory.\n");
    int ret = snprintf(path, 512, "%spatch", input_path);
    if (ret < 0)
    {
        printf("Error when formatting string");
        return false;
    }
    if (!scan_patches(path, pArchiveNames))
        return (false);

    // now, scan for the patch levels in locale dirs
    printf("Scanning patch levels from locale directories.\n");
    bool foundOne = false;
    for (auto & locale : locales)
    {
        printf("Locale: %s\n", locale.c_str());
        int ret2 = snprintf(path, 512, "%s%s/patch-%s", input_path, locale.c_str(), locale.c_str());
        if (ret2 < 0)
        {
            printf("Error when formatting string");
            return false;
        }
        if (scan_patches(path, pArchiveNames))
            foundOne = true;
    }

    printf("\n");

    if (!foundOne)
    {
        printf("no locale found\n");
        return false;
    }

    return true;
}

bool processArgv(int argc, char** argv, const char* versionString)
{
    bool result = true;
    hasInputPathParam = false;
    preciseVectorData = false;

    for (int i = 1; i < argc; ++i)
    {
        if (strcmp("-s", argv[i]) == 0)
        {
            preciseVectorData = false;
        }
        else if (strcmp("-d", argv[i]) == 0)
        {
            if ((i + 1) < argc)
            {
                hasInputPathParam = true;
                strcpy(input_path, argv[i + 1]);
                if (input_path[strlen(input_path) - 1] != '\\' && input_path[strlen(input_path) - 1] != '/')
                    strcat(input_path, "/");
                ++i;
            }
            else
            {
                result = false;
            }
        }
        else if (strcmp("-?", argv[1]) == 0)
        {
            result = false;
        }
        else if (strcmp("-l", argv[i]) == 0)
        {
            preciseVectorData = true;
        }
        else
        {
            result = false;
            break;
        }
    }
    if (!result)
    {
        printf("Extract %s.\n", versionString);
        printf("%s [-?][-s][-l][-d <path>]\n", argv[0]);
        printf("   -s : (default) small size (data size optimization), ~500MB less vmap data.\n");
        printf("   -l : large size, ~500MB more vmap data. (might contain more details)\n");
        printf("   -d <path>: Path to the vector data source folder.\n");
        printf("   -? : This message.\n");
    }
    return result;
}

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// Main
//
// The program must be run with two command line arguments
//
// Arg1 - The source MPQ name (for testing reading and file find)
// Arg2 - Listfile name
//

int main(int argc, char** argv)
{
    bool success = true;
    const char* versionString = "V4.00 2012_02";

    // Use command line arguments, when some
    if (!processArgv(argc, argv, versionString))
        return 1;

    // some simple check if working dir is dirty
    else
    {
        std::string sdir = std::string(szWorkDirWmo) + "/dir";
        std::string sdir_bin = std::string(szWorkDirWmo) + "/dir_bin";
        struct stat status;
        if (!stat(sdir.c_str(), &status) || !stat(sdir_bin.c_str(), &status))
        {
            printf("Your output directory seems to be polluted, please use an empty directory!\n");
            printf("<press return to exit>");
            char garbage[2];
            return scanf("%c", garbage);
        }
    }

    printf("Extract %s. Beginning work ....\n", versionString);
    //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    // Create the working directory
    if (mkdir(szWorkDirWmo
#if defined(__linux__) || defined(__APPLE__)
              , 0711
#endif
             ))
        success = (errno == EEXIST);

    // prepare archive name list
    std::vector<std::string> archiveNames;
    fillArchiveNameVector(archiveNames);
    for (auto & archiveName : archiveNames)
    {
        MPQArchive* archive = new MPQArchive(archiveName.c_str());
        if (gOpenArchives.empty() || gOpenArchives.front() != archive)
            delete archive;
    }

    if (gOpenArchives.empty())
    {
        printf("FATAL ERROR: None MPQ archive found by path '%s'. Use -d option with proper path.\n", input_path);
        return 1;
    }

    //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    //map.dbc
    if (success)
    {
        DBCFile* dbc = new DBCFile("DBFilesClient\\Map.dbc");
        if (!dbc->open())
        {
            delete dbc;
            printf("FATAL ERROR: Map.dbc not found in data file.\n");
            return 1;
        }
        map_count = dbc->getRecordCount();
        map_ids.resize(map_count);
        for (unsigned int x = 0; x < map_count; ++x)
        {
            map_ids[x].id = dbc->getRecord(x).getUInt(0);

            char const* map_name = dbc->getRecord(x).getString(1);
            size_t max_map_name_length = sizeof(map_ids[x].name);
            if (strlen(map_name) >= max_map_name_length)
            {
                delete dbc;
                printf("FATAL ERROR: Map name too long.\n");
                return 1;
            }

            strncpy(map_ids[x].name, map_name, max_map_name_length);
            map_ids[x].name[max_map_name_length - 1] = '\0';
            printf("Map - %s\n", map_ids[x].name);
        }

        delete dbc;
        ParsMapFiles();
        //nError = ERROR_SUCCESS;
        // Extract models, listed in DameObjectDisplayInfo.dbc
        ExtractGameobjectModels();
    }

    printf("\n");
    if (!success)
    {
        printf("ERROR: Extract %s. Work NOT complete.\n   Precise vector data=%d.\nPress any key.\n", versionString, preciseVectorData);
        getchar();
    }

    printf("Extract %s. Work complete. No errors.\n", versionString);
    return 0;
}
