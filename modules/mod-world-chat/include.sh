#!/usr/bin/env bash
	
	MOD_WORLD_CHAT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"
	
	source $MOD_WORLD_CHAT_ROOT"/conf/conf.sh.dist"
	
	if [ -f $MOD_WORLD_CHAT_ROOT"/conf/conf.sh" ]; then
	    source $MOD_WORLD_CHAT_ROOT"/conf/conf.sh"
	fi
