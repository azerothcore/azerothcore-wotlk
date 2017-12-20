# Custom folder

Here you can create a CMakeLists.txt file where to add your custom scripts
They will be git-ignored 

Remember to use cmake macro inside your CMakeLists.txt to correctly 
add scripts to project solution.

BTW, **We strongly suggest you** to use our module system to create your custom 
powerful module instead of simple scripts.




-----------------
CMakeLists.txt example:

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${AC_SCRIPTS_DIR}/Custom/your_script.cpp
  ${AC_SCRIPTS_DIR}/Custom/your_script.h
)

AC_ADD_SCRIPT_LOADER("Custom" "ScriptLoader.h")

message("  -> Prepared: My custom scripts")
