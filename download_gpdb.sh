.#!/bin/bash
set -e
set -u
set -x

export DOWNLOAD_FOLDER_PREFIX="DOWNLOAD_"

###############################################################################################
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
downloadGPDBSelected(){
  pivnet accept-eula -r $PRODUCT_RELEASE -p pivotal-gpdb

  files='files.txt'
  productfiles="pivnet_productfiles.txt"

  if [ -f $files ]; then
    # Control will enter here if $PRODUCT_RELEASE directory exists.
     rm -f $files
     touch -a $files
  fi

  if [ -f $productfiles ]; then
    # Control will enter here if $PRODUCT_RELEASE directory exists.
     rm -f $productfiles
     touch -a $productfiles
  fi



pivnet file-groups -p pivotal-gpdb --format=json -r $PRODUCT_RELEASE |  jq .  >> $productfiles

# Add selected files by defining the filter names
jq -rc ' .[] | select(.name=="Greenplum Spark Connector") | .product_files[] | {key: .aws_object_key , href: ._links.download.href } '   $productfiles >> $files
jq -rc ' .[] | select(.name=="Greenplum Database Server") | .product_files[] | {key: .aws_object_key , href: ._links.download.href } '   $productfiles >> $files


# Download files
pushd `pwd`
cd $DOWNLOAD_FOLDER_PREFIX$PRODUCT_RELEASE

jq -s '.[] | .key + "," + .href' ../$files  |
while read -r line; do
     line=$(echo "$line"  | sed s'/.$//')
     NAME=$(echo "$line" | cut -d',' -f1)
     HREF=$(echo "$line" | cut -d',' -f2)

     FILEPATH=$(echo $NAME | sed -ne "s/^\"product_files\///p" | sed -ne "s/^Pivotal-Greenplum\///p")
    wget --post-data="" --header="Authorization: Token $API_TOKEN" "$HREF" -O "$FILEPATH" --show-progress

done

# go back to the original directory
popd

}

###############################################################################################
downloadAllGPDB(){

  files='files.out'
  productfiles="pivnet_productfiles.out"

  if [ -f $files ]; then
    # Control will enter here if $PRODUCT_RELEASE directory exists.
     rm -f $files
     touch -a $files
  fi

  if [ -f $productfiles ]; then
    # Control will enter here if $PRODUCT_RELEASE directory exists.
     rm -f $productfiles
     touch -a $productfiles
  fi



pivnet file-groups -p pivotal-gpdb --format=json -r $PRODUCT_RELEASE  accept-eula |  jq .  >> $productfiles
jq -rc '.[]  | .product_files[] | {key: .aws_object_key , href: ._links.download.href } '   $productfiles >> $files


# Download files
pushd `pwd`
cd $DOWNLOAD_FOLDER_PREFIX$PRODUCT_RELEASE

jq -s '.[] | .key + "," + .href' ../$files  |
while read -r line; do
     line=$(echo "$line"  | sed s'/.$//')
     NAME=$(echo "$line" | cut -d',' -f1)
     HREF=$(echo "$line" | cut -d',' -f2)

     FILEPATH=$(echo $NAME | sed -ne "s/^\"product_files\///p" | sed -ne "s/^Pivotal-Greenplum\///p")

     ACCEPTANCEPATH=$(echo $HREF  | sed -e  "s/product_files.*/eula_acceptance/g")

     # Create acceptance request - https://network.pivotal.io/docs/file_download_api#public/docs/api/v2/release_eula_acceptance.md
    wget --post-data="" --header="Authorization: Token $API_TOKEN" "$ACCEPTANCEPATH"  --show-progress

  # Download file
    wget --post-data="" --header="Authorization: Token $API_TOKEN" "$HREF" -O "$FILEPATH" --show-progress

done

# go back to the original directory
popd

}

###############################################################################################
# Use this parameter to download a particular release.
#PRODUCT_RELEASE="4.3.17.0"
# Change the variable below to download a particular version
PRODUCT_RELEASE="5.3.0"

DEBUG=false
if [ $# -eq 0 ]
then
    echo "No arguments supplied"
    echo "$0 %pivnet-api-token% %product-release"

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

: ${PRODUCT_RELEASE?"Need to set PRODUCT_RELEASE"}
: ${API_TOKEN?"Need to set API_TOKEN"}

pivnet login --api-token=$API_TOKEN


if [ -d "$DOWNLOAD_FOLDER_PREFIX$PRODUCT_RELEASE" ]; then
  # Control will enter here if $PRODUCT_RELEASE directory exists.
    echo "$DOWNLOAD_FOLDER_PREFIX$PRODUCT_RELEASE directory exists"
else
  echo "Create download directory: $DOWNLOAD_FOLDER_PREFIX$PRODUCT_RELEASE"
	mkdir $DOWNLOAD_FOLDER_PREFIX$PRODUCT_RELEASE
fi

# List of product files
#pivnet product-files -p pivotal-gpdb -r 5.0.0 --format json | python -m json.tool
#pivnet product-files -p pivotal-gpdb -r 5.0.0 --format json  | jq '.'
#pivnet r -p pivotal-gpdb -r 5.0.0 --format json  | jq '{"id": .id, "release_date": .release_date, "release_type": .release_type}'
#pivnet file-groups -p pivotal-gpdb -r "5.0.0"  --format json |  python -m json.tool

#downloadGPDBSelected
downloadAllGPDB
###############################################################################################
