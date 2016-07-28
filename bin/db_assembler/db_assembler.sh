#!/bin/bash

SRCPATH=$(readlink -f "../../")

#
# You can pass latest version as first argument of this script
#
if [ -z "$1" ]; then
	read -p "Enter latest sql version ( leave blank to use : 0000_00_00_00 )" $version
	version=${version:-0000_00_00_00}
else
	version=$1
fi

source "./config.sh.dist" # "hack" to avoid missing conf variables

if [ -f "./config.sh"  ]; then
    source "./config.sh" # should overwrite previous
fi

echo "===== STARTING PROCESS ====="

gtversion=""

function assemble() {
	database=$1
	start_sql=$2

	var_base="DB_"$database"_PATHS"
	base=${!var_full}

	var_updates="DB_"$database"_UPDATE_PATHS"
	updates=${!var_updates}

	var_custom="DB_"$database"_CUSTOM_PATHS"
	custom=${!var_custom}


	suffix_base=""
	suffix_upd=""
	suffix_custom=""

	if (( $ALL_IN_ONE == 0 )); then
		suffix_base="_base"
	fi;

	echo "" > $OUTPUT_FOLDER$database$suffix_base".sql"


	if [ ! ${#base[@]} -eq 0 ]; then
		echo "Generating $OUTPUT_FOLDER$database$suffix_base ..."

		for d in "${base[@]}"
	 	do
			for entry in "$d"/*.sql "$d"/**/*.sql
			do
			  if [ ! -z $d ]; then
				  file=$(basename $entry)
				  if [[ "$file" > "$start_sql" ]]
				  then
					if [ -e $entry ]; then 
						if [[ "$gtversion" < "$file" ]]; then
							gtversion=$file
						fi

				  		cat "$entry" >> $OUTPUT_FOLDER$database$suffix_base".sql"
					fi
				  fi
			  fi
			done
		done
	fi

	if (( $ALL_IN_ONE == 0 )); then
		suffix_upd="_updates"

		echo "" > $OUTPUT_FOLDER$database$suffix_upd".sql"
	fi;

	if [ ! ${#updates[@]} -eq 0 ]; then
		echo "Generating $OUTPUT_FOLDER$database$suffix_upd ..."

		for d in "${updates[@]}"
	 	do
			for entry in "$d"/*.sql "$d"/**/*.sql
			do
			  if [ ! -z $d ]; then
				  file=$(basename $entry)
				  if [[ "$file" > "$start_sql" ]]
				  then
					if [ -e $entry ]; then 
						if [[ "$gtversion" < "$file" ]]; then
							gtversion=$file
						fi

				  		cat "$entry" >> $OUTPUT_FOLDER$database$suffix_upd".sql"
					fi
				  fi
			  fi
			done
		done
	fi

	if (( $ALL_IN_ONE == 0 )); then
		suffix_custom="_custom"

		echo "" > $OUTPUT_FOLDER$database$suffix_custom".sql"
	fi;

	

	if [ ! ${#custom[@]} -eq 0 ]; then
		echo "Generating $OUTPUT_FOLDER$database$suffix_custom ..."

		for d in "${custom[@]}"
	 	do
			if [ ! -z $d ]; then
				for entry in "$d"/*.sql "$d"/**/*.sql
				do
					if [ -e $entry ]; then 
			  			cat "$entry" >> $OUTPUT_FOLDER$database$suffix_custom".sql"
					fi
				done
			fi
		done
	fi
}

mkdir -p $OUTPUT_FOLDER

for db in ${DATABASES[@]}
do
	assemble "$db" $version".sql"
done

rm $OUTPUT_FOLDER"ZZZ_latest_version_"*
echo $gtversion > $OUTPUT_FOLDER"ZZZ_latest_version_"${gtversion%.*}

echo "===== DONE ====="

