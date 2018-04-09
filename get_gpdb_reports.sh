#!/bin/bash
set -e
set -u
# Debugging
set -x

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
# Authenticate
curl --silent -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Token ${API_TOKEN}" -X GET "https://network.pivotal.io/api/v2/authentication" > ./authenticate.txt

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Token $API_TOKEN" -X GET https://network.pivotal.io/api/v2/authentication
if [ $(grep -c "HTTP/1.1 200 OK" ./authenticate.txt) -ne 1 ]
then
	echo "Authentication failed, please check your API Token and try again.  Exiting...\n"
  cat ./authenticate
	exit 1
fi

# wget -O "<filename>" --header="Authorization: Token <API Token>" https://network.pivotal.io/api/v2/products/<product-id>/releases/<release-id>/product_files/<product-file-id>/download
# Get products list
curl --silent -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Token ${API_TOKEN}" -X GET https://network.pivotal.io/reports/product_file_downloads?external_users=true&product=pivotal-gpdb  > gpdb.csv





# wget  --output-document=gemfire.csv --header="Authorization: Token token=$API_TOKEN"  https://network.pivotal.io/reports/product_file_downloads?external_users=true&product=pivotal-gemfire
