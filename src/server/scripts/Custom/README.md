# Custom folder

Here you can create a CMakeLists.txt file where to add your custom scripts
They will be git-ignored 

Remember to use cmake macro inside your CMakeLists.txt to correctly 
add scripts to project solution.



/!\ BTW, **We strongly suggest you** to use our module system to create your custom 
powerful module instead of simple scripts.




-----------------
How to:

1) Create a CMakeLists.txt in this directory

Example (everything below is needed, just replace with your scripts' names):

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${AC_SCRIPTS_DIR}/Custom/your_script.cpp
  ${AC_SCRIPTS_DIR}/Custom/your_script.h
)

AC_ADD_SCRIPT_LOADER("Custom" "ScriptLoader.h")

message("  -> Prepared: My custom scripts")


2) Add them to ../ScriptLoader.cpp

Open the file and go at the end of the file to know what to edit.
