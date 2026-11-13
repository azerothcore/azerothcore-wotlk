# CREATE A NEW AZEROTHCORE MODULE

1) Read this page first:

http://www.azerothcore.org/wiki/Create-a-Module


2) Run the script `create_module.sh`:
- If you're on windows, execute it with Git Bash (right click on it and choose Git bash) if you have installed Git extensions
- If you're on linux, just run it with bash or with ./create_module.sh

This script will create the base of your module, with a clean history and add a git configuration option to this repository only (local config).


NOTE: You can also clone our skeleton-module manually, clean the history, and configure but you should use the script instead https://github.com/azerothcore/skeleton-module/


3) Share it with the community!

Join us on our discord, share it there, then we might fork it officially and it will appear in the module catalogue.

Note: For Advanced CMake implementations a <ModuleName>.cmake file in your module folder will be included in the config of Modules if it exists. See: ./CMakeList.txt around line #290

## Voiceserver code

A module can extend the voiceserver as well. Code in `src/voiceserver/` is left out of the worldserver build and
linked into the voiceserver instead:

- create scripts deriving from `VoiceScript` (see `src/server/services/voice/Scripting/VoiceScript.h`) from
  `void Add<module>VoiceScripts()`, where `<module>` is the module folder name with `-` replaced by `_`
- headers directly in `src/` are visible to both the worldserver and the voiceserver part
- voiceserver configs go in `conf/voiceserver/*.conf.dist` and are installed to `configs/modules/` with the
  worldserver configs, so their names must differ from every worldserver config of the modules

See `VoiceModules.cmake` for details.
