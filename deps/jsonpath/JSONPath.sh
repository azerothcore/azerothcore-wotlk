#!/bin/bash

# ---------------------------------------------------------------------------
# GLOBALS
# ---------------------------------------------------------------------------

DEBUG=0
INCLEMPTY=0
NOCASE=0
WHOLEWORD=0
FILE=
NO_HEAD=0
NORMALIZE_SOLIDUS=0
BRIEF=0
PASSTHROUGH=0
JSON=0
PRINT=1
MULTIPASS=0
FLATTEN=0
STDINFILE=/var/tmp/JSONPath.$$.stdin
STDINFILE2=/var/tmp/JSONPath.$$.stdin2
PASSFILE=/var/tmp/JSONPath.$$.pass1
declare -a INDEXMATCH_QUERY

# ---------------------------------------------------------------------------
main() {
# ---------------------------------------------------------------------------
# It all starts here

  parse_options "$@"

  trap cleanup EXIT

  if [[ $QUERY == *'?(@'* ]]; then
    # This will be a multipass query

    [[ -n $FILE ]] && STDINFILE=$FILE
    [[ -z $FILE ]] && cat >$STDINFILE

    while true; do
      tokenize_path
      create_filter

      cat "$STDINFILE" | tokenize | parse | filter | indexmatcher >$PASSFILE

      [[ $MULTIPASS -eq 1 ]] && {
        # replace filter expression with index sequence
        SET=$(sed -rn 's/.*,([0-9]+)[],].*/\1/p' $PASSFILE | tr '\n' ,)
        SET=${SET%,}
        QUERY=$(echo $QUERY | sed "s/?(@[^)]\+)/$SET/")
        [[ $DEBUG -eq 1 ]] && echo "QUERY=$QUERY"
        reset
        continue
      }

      cat $PASSFILE | flatten | json | brief

      break
    done

  else

    tokenize_path
    create_filter

    if [[ $PASSTHROUGH -eq 1 ]]; then
      JSON=1
      flatten | json
    elif [[ -z $FILE ]]; then
      tokenize | parse | filter | indexmatcher | flatten | json | brief
    else
      cat "$FILE" | tokenize | parse | filter | indexmatcher | flatten | \
        json | brief
    fi

  fi 
}

# ---------------------------------------------------------------------------
reset() {
# ---------------------------------------------------------------------------

  # Reset some vars
  declare -a INDEXMATCH_QUERY
  PATHTOKENS=
  FILTER=
  OPERATOR=
  RHS=
  MULTIPASS=0
}

# ---------------------------------------------------------------------------
cleanup() {
# ---------------------------------------------------------------------------

  [[ -e "$PASSFILE" ]] && rm -f "$PASSFILE"
  [[ -e "$STDINFILE2" ]] && rm -f "$STDINFILE2"
  [[ -z "$FILE" && -e "$STDINFILE" ]] && rm -f "$STDINFILE"
}

# ---------------------------------------------------------------------------
usage() {
# ---------------------------------------------------------------------------

  echo
  echo "Usage: JSONPath.sh [-b] [j] [-h] [-f FILE] [pattern]"
  echo
  echo "pattern - the JSONPath query. Defaults to '$.*' if not supplied."
  #echo "-s      - Remove escaping of the solidus symbol (straight slash)."
  echo "-b      - Brief. Only show values."
  echo "-j      - JSON ouput."
  echo "-u      - Strip unnecessary leading path elements."
  echo "-i      - Case insensitive."
  echo "-p      - Pass-through to the JSON parser."
  echo "-w      - Match whole words only (for filter script expression)."
  echo "-f FILE - Read a FILE instead of stdin."
  #echo "-n      - No-head. Do not show nodes that have no path (lines that start with [])."
  echo "-h      - This help text."
  echo
}

# ---------------------------------------------------------------------------
parse_options() {
# ---------------------------------------------------------------------------

  set -- "$@"
  local ARGN=$#
  while [ "$ARGN" -ne 0 ]
  do
    case $1 in
      -h) usage
          exit 0
      ;;
      -f) shift
          FILE=$1
      ;;
      -i) NOCASE=1
      ;;
      -j) JSON=1
      ;;
      -n) NO_HEAD=1
      ;;
      -b) BRIEF=1
      ;;
      -u) FLATTEN=1
      ;;
      -p) PASSTHROUGH=1
      ;;
      -w) WHOLEWORD=1
      ;;
      -s) NORMALIZE_SOLIDUS=1
      ;;
      ?*) QUERY=$1
      ;;
    esac
    shift 1
    ARGN=$((ARGN-1))
  done
  [[ -z $QUERY ]] && QUERY='$.*'
}

# ---------------------------------------------------------------------------
awk_egrep() {
# ---------------------------------------------------------------------------
  local pattern_string=$1

  gawk '{
    while ($0) {
      start=match($0, pattern);
      token=substr($0, start, RLENGTH);
      print token;
      $0=substr($0, start+RLENGTH);
    }
  }' pattern="$pattern_string"
}

# ---------------------------------------------------------------------------
tokenize() {
# ---------------------------------------------------------------------------
# json parsing

  local GREP
  local ESCAPE
  local CHAR

  if echo "test string" | egrep -ao --color=never "test" >/dev/null 2>&1
  then
    GREP='egrep -ao --color=never'
  else
    GREP='egrep -ao'
  fi

  if echo "test string" | egrep -o "test" >/dev/null 2>&1
  then
    ESCAPE='(\\[^u[:cntrl:]]|\\u[0-9a-fA-F]{4})'
    CHAR='[^[:cntrl:]"\\]'
  else
    GREP=awk_egrep
    ESCAPE='(\\\\[^u[:cntrl:]]|\\u[0-9a-fA-F]{4})'
    CHAR='[^[:cntrl:]"\\\\]'
  fi

  local STRING="\"$CHAR*($ESCAPE$CHAR*)*\""
  local NUMBER='-?(0|[1-9][0-9]*)([.][0-9]*)?([eE][+-]?[0-9]*)?'
  local KEYWORD='null|false|true'
  local SPACE='[[:space:]]+'

  # Force zsh to expand $A into multiple words
  local is_wordsplit_disabled=$(unsetopt 2>/dev/null | grep -c '^shwordsplit$')
  if [ $is_wordsplit_disabled != 0 ]; then setopt shwordsplit; fi
  $GREP "$STRING|$NUMBER|$KEYWORD|$SPACE|." | egrep -v "^$SPACE$"
  if [ $is_wordsplit_disabled != 0 ]; then unsetopt shwordsplit; fi
}

# ---------------------------------------------------------------------------
tokenize_path () {
# ---------------------------------------------------------------------------
  local GREP
  local ESCAPE
  local CHAR

  if echo "test string" | egrep -ao --color=never "test" >/dev/null 2>&1
  then
    GREP='egrep -ao --color=never'
  else
    GREP='egrep -ao'
  fi

  if echo "test string" | egrep -o "test" >/dev/null 2>&1
  then
    CHAR='[^[:cntrl:]"\\]'
  else
    GREP=awk_egrep
    #CHAR='[^[:cntrl:]"\\\\]'
  fi

  local WILDCARD='\*'
  local WORD='[ A-Za-z0-9_-]*'
  local INDEX="\\[$WORD(:$WORD){0,2}\\]"
  local INDEXALL="\\[\\*\\]"
  local STRING="[\\\"'][^[:cntrl:]\\\"']*[\\\"']"
  local SET="\\[($WORD|$STRING)(,($WORD|$STRING))*\\]"
  local FILTER='\?\(@[^)]+'
  local DEEPSCAN="\\.\\."
  local SPACE='[[:space:]]+'

  # Force zsh to expand $A into multiple words
  local is_wordsplit_disabled=$(unsetopt 2>/dev/null | grep -c '^shwordsplit$')
  if [ $is_wordsplit_disabled != 0 ]; then setopt shwordsplit; fi
  readarray -t PATHTOKENS < <( echo "$QUERY" | \
    $GREP "$INDEX|$STRING|$WORD|$WILDCARD|$FILTER|$DEEPSCAN|$SET|$INDEXALL|." | \
    egrep -v "^$SPACE$|^\\.$|^\[$|^\]$|^'$|^\\\$$|^\)$")
  [[ $DEBUG -eq 1 ]] && {
    echo "egrep -o '$INDEX|$STRING|$WORD|$WILDCARD|$FILTER|$DEEPSCAN|$SET|$INDEXALL|.'"
    echo -n "TOKENISED QUERY="; echo "$QUERY" | \
      $GREP "$INDEX|$STRING|$WORD|$WILDCARD|$FILTER|$DEEPSCAN|$SET|$INDEXALL|." | \
      egrep -v "^$SPACE$|^\\.$|^\[$|^\]$|^'$|^\\\$$|^\)$"
  }
  if [ $is_wordsplit_disabled != 0 ]; then unsetopt shwordsplit; fi
}

# ---------------------------------------------------------------------------
create_filter() {
# ---------------------------------------------------------------------------
# Creates the filter from the user's query.
# Filter works in a single pass through the data, unless a filter (script)
#  expression is used, in which case two passes are required (MULTIPASS=1).

  local len=${#PATHTOKENS[*]}

  local -i i=0
  local query="^\[" comma=
  while [[ i -lt len ]]; do
    case "${PATHTOKENS[i]}" in
      '"') :
      ;;
      '..') query+="$comma[^]]*"
            comma=
      ;;
      '[*]') query+="$comma[^,]*"
             comma=","
      ;;
      '*') query+="$comma(\"[^\"]*\"|[0-9]+[^],]*)"
           comma=","
      ;;
      '?(@'*) a=${PATHTOKENS[i]#?(@.}
               elem="${a%%[<>=!]*}"
               rhs="${a##*[<>=!]}"
               a="${a#$elem}"
               elem="${elem//./[\",.]+}" # Allows child node matching
               operator="${a%$rhs}"
               [[ -z $operator ]] && { operator="=="; rhs=; }
               if [[ $rhs == *'"'* || $rhs == *"'"* ]]; then
                 case $operator in
                   '=='|'=')  OPERATOR=
                          if [[ $elem == '?(@' ]]; then
                            # To allow search on @.property such as:
                            #   $..book[?(@.title==".*Book 1.*")]
                            query+="$comma[0-9]+[],][[:space:]\"]*${rhs//\"/}"
                          else
                            # To allow search on @ (this node) such as:
                            #   $..reviews[?(@==".*Fant.*")]
                            query+="$comma[0-9]+,\"$elem\"[],][[:space:]\"]*${rhs//\"/}"
                          fi
                          FILTER="$query"
                     ;;
                   '>='|'>')  OPERATOR=">"
                              RHS="$rhs"
                              query+="$comma[0-9]+,\"$elem\"[],][[:space:]\"]*"
                              FILTER="$query"
                     ;;
                   '<='|'<')  OPERATOR="<"
                              RHS="$rhs"
                              query+="$comma[0-9]+,\"$elem\"[],][[:space:]\"]*"
                              FILTER="$query"
                     ;;
                 esac
               else
                 case $operator in
                   '=='|'=')  OPERATOR=
                          query+="$comma[0-9]+,\"$elem\"[],][[:space:]\"]*$rhs"
                          FILTER="$query"
                     ;;
                   '>=')  OPERATOR="-ge"
                          RHS="$rhs"
                          query+="$comma[0-9]+,\"$elem\"[],][[:space:]\"]*"
                          FILTER="$query"
                     ;;
                   '>')   OPERATOR="-gt"
                          RHS="$rhs"
                          query+="$comma[0-9]+,\"$elem\"[],][[:space:]\"]*"
                          FILTER="$query"
                     ;;
                   '<=')  OPERATOR="-le"
                          RHS="$rhs"
                          query+="$comma[0-9]+,\"$elem\"[],][[:space:]\"]*"
                          FILTER="$query"
                     ;;
                   '<')   OPERATOR="-lt"
                          RHS="$rhs"
                          query+="$comma[0-9]+,\"$elem\"[],][[:space:]\"]*"
                          FILTER="$query"
                 esac
               fi
               MULTIPASS=1
      ;;
      "["*) if [[ ${PATHTOKENS[i]} =~ , ]]; then
              a=${PATHTOKENS[i]#[}
              a=${a%]}
              if [[ $a =~ [[:alpha:]] ]]; then
                # converts only one comma: s/("[^"]+),([^"]+")/\1`\2/g;s/"//g
                #a=$(echo $a | sed 's/\([[:alpha:]]*\)/"\1"/g')
                a=$(echo $a | sed -r "s/[\"']//g;s/([^,]*)/\"\1\"/g")
              fi
              query+="$comma(${a//,/|})"
            elif [[ ${PATHTOKENS[i]} =~ : ]]; then
              if ! [[ ${PATHTOKENS[i]} =~ [0-9][0-9] || ${PATHTOKENS[i]} =~ :] ]]
              then
                if [[ ${PATHTOKENS[i]#*:} =~ : ]]; then
                  INDEXMATCH_QUERY+=("${PATHTOKENS[i]}")
                  query+="$comma[^,]*"
                else
                  # Index in the range of 0-9 can be handled by regex
                  query+="${comma}$(echo ${PATHTOKENS[i]} | \
                  awk '/:/ { a=substr($0,0,index($0,":")-1);
                         b=substr($0,index($0,":")+1,index($0,"]")-index($0,":")-1);
                         if(b>0) { print a ":" b-1 "]" };
                         if(b<=0) { print a ":]" } }' | \
                  sed 's/\([0-9]\):\([0-9]\)/\1-\2/;
                       s/\[:\([0-9]\)/[0-\1/;
                       s/\([0-9]\):\]/\1-9999999]/')"
                fi
              else
                INDEXMATCH_QUERY+=("${PATHTOKENS[i]}")
                query+="$comma[^,]*"
              fi
            else
              a=${PATHTOKENS[i]#[}
              a=${a%]}
              if [[ $a =~ [[:alpha:]] ]]; then
                a=$(echo $a | sed -r "s/[\"']//g;s/([^,]*)/\"\1\"/g")
              else
                [[ $i -gt 0 ]] && comma=","
              fi
              #idx=$(echo "${PATHTOKENS[i]}" | tr -d "[]")
              query+="$comma$a"
            fi
            comma=","
      ;;
      *)    PATHTOKENS[i]=${PATHTOKENS[i]//\'/\"}
            query+="$comma\"${PATHTOKENS[i]//\"/}\""
            comma=","
      ;;
    esac
    i=i+1 
  done

  [[ -z $FILTER ]] && FILTER="$query[],]"
  [[ $DEBUG -eq 1 ]] && echo "FILTER=$FILTER"
}

# ---------------------------------------------------------------------------
parse_array () {
# ---------------------------------------------------------------------------
# json parsing

  local index=0
  local ary=''
  read -r token
  case "$token" in
    ']')
         ;;
    *)
      while :
      do
        parse_value "$1" "$index"
        index=$((index+1))
        ary="$ary""$value" 
        read -r token
        case "$token" in
          ']') break ;;
          ',') ary="$ary," ;;
          *) throw "EXPECTED , or ] GOT ${token:-EOF}" ;;
        esac
        read -r token
      done
      ;;
  esac
  value=
  :
}

# ---------------------------------------------------------------------------
parse_object () {
# ---------------------------------------------------------------------------
# json parsing

  local key
  local obj=''
  read -r token
  case "$token" in
    '}') 
         ;;
    *)
      while :
      do
        case "$token" in
          '"'*'"') key=$token ;;
          *) throw "EXPECTED string GOT ${token:-EOF}" ;;
        esac
        read -r token
        case "$token" in
          ':') ;;
          *) throw "EXPECTED : GOT ${token:-EOF}" ;;
        esac
        read -r token
        parse_value "$1" "$key"
        obj="$obj$key:$value"        
        read -r token
        case "$token" in
          '}') break ;;
          ',') obj="$obj," ;;
          *) throw "EXPECTED , or } GOT ${token:-EOF}" ;;
        esac
        read -r token
      done
    ;;
  esac
  value=
  :
}

# ---------------------------------------------------------------------------
parse_value () {
# ---------------------------------------------------------------------------
# json parsing

  local jpath="${1:+$1,}$2" isleaf=0 isempty=0 print=0
  case "$token" in
    '{') parse_object "$jpath" ;;
    '[') parse_array  "$jpath" ;;
    # At this point, the only valid single-character tokens are digits.
    ''|[!0-9]) throw "EXPECTED value GOT ${token:-EOF}" ;;
    *) value=$token
       # if asked, replace solidus ("\/") in json strings with normalized value: "/"
       [ "$NORMALIZE_SOLIDUS" -eq 1 ] && value=$(echo "$value" | sed 's#\\/#/#g')
       isleaf=1
       [ "$value" = '""' ] && isempty=1
       ;;
  esac
  [[ -z INCLEMPTY ]] && [ "$value" = '' ] && return
  [ "$NO_HEAD" -eq 1 ] && [ -z "$jpath" ] && return

  [ "$isleaf" -eq 1 ] && [ $isempty -eq 0 ] && print=1
  [ "$print" -eq 1 ] && printf "[%s]\t%s\n" "$jpath" "$value"
  :
}

# ---------------------------------------------------------------------------
flatten() {
# ---------------------------------------------------------------------------
# Take out

  local path a prevpath pathlen

  if [[ $FLATTEN -eq 1 ]]; then
    cat >"$STDINFILE2"
    
    highest=9999

    while read line; do
      a=${line#[};a=${a%%]*}
      readarray -t path < <(grep -o "[^,]*"<<<"$a")
      [[ -z $prevpath ]] && {
        prevpath=("${path[@]}")
        highest=$((${#path[*]}-1))
        continue
      }

      pathlen=$((${#path[*]}-1))

      for i in `seq 0 $pathlen`; do
        [[ ${path[i]} != ${prevpath[i]} ]] && {
          high=$i
          break
        }
      done

      [[ $high -lt $highest ]] && highest=$high

      prevpath=("${path[@]}")
    done <"$STDINFILE2"
    
    if [[ $highest -gt 0 ]]; then
      sed -r 's/\[(([0-9]+|"[^"]+")[],]){'$((highest))'}(.*)/[\3/' \
        "$STDINFILE2"
    else 
      cat "$STDINFILE2"
    fi
  else
    cat
  fi
}

# ---------------------------------------------------------------------------
indexmatcher() {
# ---------------------------------------------------------------------------
# For double digit or greater indexes match each line individually
# Single digit indexes are handled more efficiently by regex

  local a b

  [[ $DEBUG -eq 1 ]] && {
    for i in `seq 0 $((${#INDEXMATCH_QUERY[*]}-1))`; do
      echo "INDEXMATCH_QUERY[$i]=${INDEXMATCH_QUERY[i]}"
    done
  }

  matched=1

  step=
  if [[ ${#INDEXMATCH_QUERY[*]} -gt 0 ]]; then
    while read -r line; do
      for i in `seq 0 $((${#INDEXMATCH_QUERY[*]}-1))`; do
        [[ ${INDEXMATCH_QUERY[i]#*:} =~ : ]] && {
          step=${INDEXMATCH_QUERY[i]##*:}
          step=${step%]}
          INDEXMATCH_QUERY[i]="${INDEXMATCH_QUERY[i]%:*}]"
        }
        q=${INDEXMATCH_QUERY[i]:1:-1} # <- strip '[' and ']'
        a=${q%:*}                     # <- number before ':'
        b=${q#*:}                     # <- number after ':'
        [[ -z $b ]] && b=99999999999
        readarray -t num < <( (grep -Eo ',[0-9]+[],]' | tr -d ,])<<<$line )
        if [[ ${num[i]} -ge $a && ${num[i]} -lt $b && matched -eq 1 ]]; then
          matched=1
          [[ $i -eq $((${#INDEXMATCH_QUERY[*]}-1)) ]] && {
            if [[ $step -gt 1 ]]; then
              [[ $(((num[i]-a)%step)) -eq 0 ]] && {
                [[ $DEBUG -eq 1 ]] && echo -n "($a,$b,${num[i]}) "
                echo "$line"
              }
            else
              [[ $DEBUG -eq 1 ]] && echo -n "($a,$b,${num[i]}) "
              echo "$line"
            fi
          }
        else
          matched=0
          continue
        fi
      done
      matched=1
    done
  else
    cat -
  fi
}

# ---------------------------------------------------------------------------
brief() {
# ---------------------------------------------------------------------------
# Only show the value

    if [[ $BRIEF -eq 1 ]]; then
      sed 's/^[^\t]*\t//;s/^"//;s/"$//;'
    else
      cat
    fi
}

# ---------------------------------------------------------------------------
json() {
# ---------------------------------------------------------------------------
# Turn output into JSON

  local a tab=$(echo -e "\t")
  local UP=1 DOWN=2 SAME=3
  local prevpathlen=-1 prevpath=() path a
  declare -a closers

  if [[ $JSON -eq 0 ]]; then
    cat -
  else
    while read -r line; do
      a=${line#[};a=${a%%]*}
      readarray -t path < <(grep -o "[^,]*"<<<"$a")
      value=${line#*$tab}

      # Not including the object itself (last item)
      pathlen=$((${#path[*]}-1))

      # General direction

      direction=$SAME
      [[ $pathlen -gt $prevpathlen ]] && direction=$DOWN
      [[ $pathlen -lt $prevpathlen ]] && direction=$UP

      # Handle jumps UP the tree (close previous paths)

      [[ $prevpathlen != -1 ]] && {
        for i in `seq 0 $((pathlen-1))`; do
          [[ ${prevpath[i]} == ${path[i]} ]] && continue
          [[ ${path[i]} != '"'* ]] && {
            a=(${!arrays[*]})
            [[ -n $a ]] && {
              for k in `seq $((i+1)) ${a[-1]}`; do
                arrays[k]=
              done
            }
            a=(${!comma[*]})
            [[ -n $a ]] && {
              for k in `seq $((i+1)) ${a[-1]}`; do
                comma[k]=
              done
            }
            for j in `seq $((prevpathlen)) -1 $((i+2))`
            do
              arrays[j]=
              [[ -n ${closers[j]} ]] && {
                let indent=j*4
                printf "\n%0${indent}s${closers[j]}" ""
                unset closers[j]
                comma[j]=
              }
            done
            direction=$DOWN
            break
          }
          direction=$DOWN
          for j in `seq $((prevpathlen)) -1 $((i+1))`
          do
            arrays[j]=
            [[ -n ${closers[j]} ]] && {
              let indent=j*4
              printf "\n%0${indent}s${closers[j]}" ""
              unset closers[j]
              comma[j]=
            }
          done
          a=(${!arrays[*]})
          [[ -n $a ]] && {
            for k in `seq $i ${a[-1]}`; do
              arrays[k]=
            done
          }
          break
        done
      }

      [[ $direction -eq $UP ]] && {
        [[ $prevpathlen != -1 ]] && comma[prevpathlen]=
        for i in `seq $((prevpathlen+1)) -1 $((pathlen+1))`
        do
          arrays[i]=
          [[ -n ${closers[i]} ]] && {
            let indent=i*4
            printf "\n%0${indent}s${closers[i]}" ""
            unset closers[i]
            comma[i]=
          }
        done
        a=(${!arrays[*]})
        [[ -n $a ]] && {
          for k in `seq $i ${a[-1]}`; do
            arrays[k]=
          done
        }
      }

      # Opening braces (the path leading up to the key)

      broken=
      for i in `seq 0 $((pathlen-1))`; do
        [[ -z $broken && ${prevpath[i]} == ${path[i]} ]] && continue
        [[ -z $broken ]] && {
          broken=$i
          [[ $prevpathlen -ne -1 ]] && broken=$((i+1))
        }
        if [[ ${path[i]} == '"'* ]]; then
          # Object
          [[ $i -ge $broken ]] && {
            let indent=i*4
            printf "${comma[i]}%0${indent}s{\n" ""
            closers[i]='}'
            comma[i]=
          }
          let indent=(i+1)*4
          printf "${comma[i]}%0${indent}s${path[i]}:\n" ""
          comma[i]=",\n"
        else
          # Array
          if [[ ${arrays[i]} != 1 ]]; then
            let indent=i*4
            printf "%0${indent}s" ""
            echo "["
            closers[i]=']'
            arrays[i]=1
            comma[i]=
          else
            let indent=(i+1)*4
            printf "\n%0${indent}s${closers[i-1]}" ""
            direction=$DOWN
            comma[i+1]=",\n"
          fi
        fi
      done

      # keys & values

      if [[ ${path[-1]} == '"'* ]]; then
        # Object
        [[ $direction -eq $DOWN ]] && {
          let indent=pathlen*4
          printf "${comma[pathlen]}%0${indent}s{\n" ""
          closers[pathlen]='}'
          comma[pathlen]=
        }
        let indent=(pathlen+1)*4
        printf "${comma[pathlen]}%0${indent}s" ""
        echo -n "${path[-1]}:$value"
        comma[pathlen]=",\n"
      else
        # Array
        [[ ${arrays[i]} != 1 ]] && {
          let indent=(pathlen-0)*4
          printf "%0${indent}s[\n" ""
          closers[pathlen]=']'
          comma[pathlen]=
          arrays[i]=1
        }
        let indent=(pathlen+1)*4
        printf "${comma[pathlen]}%0${indent}s" ""
        echo -n "$value"
        comma[pathlen]=",\n"
      fi

      prevpath=("${path[@]}")
      prevpathlen=$pathlen
    done

    # closing braces

    for i in `seq $((pathlen)) -1 0`
    do
      let indent=i*4
      printf "\n%0${indent}s${closers[i]}" ""
    done
    echo
  fi
}

# ---------------------------------------------------------------------------
filter() {
# ---------------------------------------------------------------------------
# Apply the query filter

  local a tab=$(echo -e "\t") v

  [[ $NOCASE -eq 1 ]] && opts+="-i"
  [[ $WHOLEWORD -eq 1 ]] && opts+=" -w"
  if [[ -z $OPERATOR ]]; then
    egrep $opts "$FILTER"
  else
    egrep $opts "$FILTER" | \
      while read line; do
        v=${line#*$tab}
        case $OPERATOR in
          '-ge') if awk '{exit !($1>=$2)}'<<<"$v $RHS";then echo "$line"; fi
            ;;
          '-gt') if awk '{exit !($1>$2) }'<<<"$v $RHS";then echo "$line"; fi
            ;;
          '-le') if awk '{exit !($1<=$2) }'<<<"$v $RHS";then echo "$line"; fi
            ;;
          '-lt') if awk '{exit !($1<$2) }'<<<"$v $RHS";then echo "$line"; fi
            ;;
          '>') v=${v#\"};v=${v%\"}
               RHS=${RHS#\"};RHS=${RHS%\"}
               [[ "$v" > "$RHS" ]] && echo "$line"
            ;;
          '<') v=${v#\"};v=${v%\"}
               RHS=${RHS#\"};RHS=${RHS%\"}
               [[ "$v" < "$RHS" ]] && echo "$line"
            ;;
        esac
      done #< <(egrep $opts "$FILTER")
  fi
}

# ---------------------------------------------------------------------------
parse () {
# ---------------------------------------------------------------------------
# Parses json

  read -r token
  parse_value
  read -r token
  case "$token" in
    '') ;;
    *) throw "EXPECTED EOF GOT $token"
       exit 1;;
  esac
}

# ---------------------------------------------------------------------------
throw() {
# ---------------------------------------------------------------------------
  echo "$*" >&2
  exit 1
}

if ([ "$0" = "$BASH_SOURCE" ] || ! [ -n "$BASH_SOURCE" ]);
then
  main "$@"
fi

# vi: expandtab sw=2 ts=2