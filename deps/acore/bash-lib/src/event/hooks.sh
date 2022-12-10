# par 1: hook_name
function acore_event_runHooks() {
  hook_name="HOOKS_MAP_$1"
  read -r -a SRCS <<< ${!hook_name}
  echo "Running hooks: $hook_name"
  for i in "${SRCS[@]}"
  do
  	$i # run registered hook
  done
}

function acore_event_registerHooks() {
  hook_name="HOOKS_MAP_$1"
  hooks=${@:2}
  declare -g "$hook_name+=$hooks "
}
