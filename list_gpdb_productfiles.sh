#!/bin/bash
set -e
set -u
# Debugging
#set -x
# CHANGE ME if you want to use another version
PRODUCT_RELEASE=4.3.18.0

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

elif [ $# -eq 1 ]
then
	export API_TOKEN=$1
else
	export API_TOKEN=$1
	export PRODUCT_RELEASE=$2
fi

: ${API_TOKEN?"Need to set API_TOKEN"}

pivnet login --api-token=$API_TOKEN


#pivnet releases -p pivotal-gpdb --format json | python -m json.tool | jq  .[].id

echo "List of pivotal-gpdb - product files:"
#pivnet releases -p pivotal-gpdb --format table
#pivnet file-groups -p pivotal-gpdb --format=json -r 4.3.17.0 |  python -m json.tool  | jq  .[].id
#pivnet file-groups -p pivotal-gpdb --format=json -r 4.3.17.0 |  python -m json.tool  | jq '{"id": .[].product_files.[].id, "name": .[].name, "file_version": .[].file_version}'
# pivnet file-groups -p pivotal-gpdb --format=json -r 4.3.17.0 |  python -m json.tool | jq  .[].product_files[].id

echo "List for PRODUCT_RELEASE: $PRODUCT_RELEASE"
pivnet file-groups -p pivotal-gpdb --format=table -r $PRODUCT_RELEASE
