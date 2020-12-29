# Change the cd to the root folder of Azerothcore, or any folder you want to run the whitespace remover in.
cd "E:\Azerothcore-wotlk" 

# Change '*.cpp' and '*.h' to the extension you want to remove whitespaces in.
find -name '*.cpp' -or -name '*.h' -print0 | xargs -r0 sed -e 's/[[:blank:]]\+$//' -i
