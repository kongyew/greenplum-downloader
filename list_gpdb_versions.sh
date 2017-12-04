#!/bin/bash
set -e
set -u
# Debugging
#set -x

parse_yaml() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}
###############################################################################################
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"

    # Default configuration file if it exists
    if [ -f ~/.pivnetrc ]; then 
    	echo "The ~/.pivnetrc file exists"
    	# Ex
    	# profiles:
		#- name: default
  		#  api_token: sdfafsdw343242
  		#  host: https://network.pivotal.io

		# read yaml file
		eval $(parse_yaml ~/.pivnetrc "config_")
		# access yaml content
		echo $config_profiles_api_token
	    export API_TOKEN=$config_profiles_api_token
    fi

else
	export API_TOKEN=$1
fi


: ${API_TOKEN?"Need to set API_TOKEN"}

pivnet login --api-token=$API_TOKEN


#pivnet releases -p pivotal-gpdb --format json | python -m json.tool | jq  .[].id

echo "List of pivotal-gpdb versions:"
pivnet releases -p pivotal-gpdb --format table


pivnet r -p pivotal-gpdb -r 4.3.17.0 --format json | jq '{"id": .id, "release_date": .release_date, "release_type": .release_type}'

#pivnet releases -p pivotal-gpdb --format json | python -m json.tool | jq '{"version": .[].version}'
#'{"id": .id, "version": .version, "release_date": .release_date, "release_type": .release_type}'






