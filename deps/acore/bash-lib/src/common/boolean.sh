function isTrue() {
  local val
  val=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  [[ "$val" == "1" || "$val" == "true" || "$val" == "yes" || "$val" == "on" ]]
}