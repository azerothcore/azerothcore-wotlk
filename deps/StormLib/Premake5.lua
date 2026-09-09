
solution 'StormLib'
    location 'build'
    language 'C++'
    configurations { 'Debug', 'Release', }
    platforms { 'x32', 'x64' }

    targetdir 'bin'
    objdir 'bin'

    files {
        'src/**.h',
        'src/**.c',
        'src/**.cpp',
        'doc/*.txt',
    }

    removefiles {
        'src/adpcm/*_old.*',
        'src/huffman/*_old.*',
        'src/huffman/huff_patch.*',
        'src/pklib/crc32.c',
        'src/zlib/compress.c',
    }
	
    filter 'configurations:Debug*'
        flags { 'Symbols' }
        defines { '_DEBUG' }
        optimize 'Debug'

    filter 'configurations:Release*'
        defines { 'NDEBUG' }
        optimize 'Full'

    filter 'system:windows'
        links { 'wininet', }
        defines { 'WINDOWS', '_WINDOWS' }

    filter { 'system:windows', 'platforms:x32' }
        defines { 'WIN32', '_WIN32' }

    filter { 'system:windows', 'platforms:x64' }
        defines { 'WIN64', '_WIN64' }

    filter 'system:linux'
        defines { '_7ZIP_ST', 'BZ_STRICT_ANSI' }
        removefiles {
            'src/lzma/C/LzFindMt.*',
            'src/lzma/C/Threads.*',
        }

--------------------------------------------------------------------------------

project 'StormLib'
    kind 'StaticLib'

    removefiles 'src/SBaseDumpData.cpp'

    configurations {
        'DebugAD',      -- Debug Ansi Dynamic
        'DebugAS',      -- Debug Ansi Static
        'DebugUD',      -- Debug Unicode Dynamic
        'DebugUS',      -- Debug Unicode Static
        'ReleaseAD',    -- Release Ansi Dynamic
        'ReleaseAS',    -- Release Ansi Static
        'ReleaseUD',    -- Release Unicode Dynamic'
        'ReleaseUS',    -- Release Unicode Static
    }

    configmap {
        ['Debug']   = 'DebugUS',
        ['Release'] = 'ReleaseUS',
    }

    filter 'configurations:*S'
        flags { 'StaticRuntime' }

    filter { 'configurations:*U*', 'action:vs*' }
        flags { 'Unicode' }

    filter { 'configurations:*U*', 'not action:vs*' }
        defines { 'UNICODE', '_UNICODE' }

    filter 'DebugAD'
        targetsuffix 'DAD'
    filter 'ReleaseAD'
        targetsuffix 'RAD'
    filter 'DebugAS'
        targetsuffix 'DAS'
    filter 'ReleaseAS'
        targetsuffix 'RAS'
    filter 'DebugUD'
        targetsuffix 'DUD'
    filter 'ReleaseUD'
        targetsuffix 'RUD'
    filter 'DebugUS'
        targetsuffix 'DUS'
    filter 'ReleaseUS'
        targetsuffix 'RUS'

--------------------------------------------------------------------------------

project 'StormLib_dll'
    kind 'SharedLib'

    targetname 'Stormlib'

    files {
        'stormlib_dll/DllMain.c',
        'stormlib_dll/StormLib.def',
    }

    removefiles 'src/SBaseDumpData.cpp'

    filter { 'system:windows', 'action:gmake' }
        linkoptions {
            '-Xlinker --enable-stdcall-fixup',
            '../stormlib_dll/StormLib.def',
        }

    filter 'Debug'
        targetsuffix '_d'

--------------------------------------------------------------------------------

project 'StormLib_test'
    kind 'ConsoleApp'

    files {
        'test/StormTest.cpp',
    }

