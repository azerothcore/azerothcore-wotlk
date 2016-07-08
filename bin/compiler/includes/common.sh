source "./config.sh.dist" # "hack" to avoid missing conf variables

if [ -f "./config.sh"  ]; then
    source "./config.sh" # should overwrite previous
fi
