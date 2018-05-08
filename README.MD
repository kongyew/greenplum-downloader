# Download Greenplum

This page describes how to automatically download Greenplum release files from [Pivotal Network](https://network.pivotal.io/).  It assumes you have the [Pivnet account](https://login.run.pivotal.io/create_account?client_id=pivnet-production&redirect_uri=https://network.pivotal.io/login) with the appropriate permissions.

[![Build Status](https://travis-ci.org/kongyew/greenplum-downloader.svg?branch=master)](https://travis-ci.org/kongyew/greenplum-downloader)

## Getting Started

These instructions help to download Greenplum releases from Pivotal Network.

### Prerequisites
- [jq](https://stedolan.github.io/jq/download/)
- [PivNet-cli](https://github.com/pivotal-cf/pivnet-cli)
- Pivotal Network account with [API Token](https://network.pivotal.io/users/dashboard/edit-profile)

### Installing

A step by step instructions that helps you to get started

1. Clone this repository by using git clone <repo>
2. Install jq and Pivnet cli
Install these binaries by following these commands below or run ./setup.sh
```
brew install jq
brew install pivotal/tap/pivnet-cli
```
3. Configure (Pivnet CLI)[https://github.com/pivotal-cf/pivnet-cli]
```
$pivnet login --api-token='my-api-token'
$Logged-in successfully
$ pivnet products
+-----+--------------------------------------------+--------------------------------+
| ID  |                    SLUG                    |              NAME              |
+-----+--------------------------------------------+--------------------------------+
|  19 | pivotal-gpdb                               | Pivotal Greenplum              |
|  57 | p-gemfire                                  | GemFire for PCF                |
...
+-----+--------------------------------------------+--------------------------------+
```
4. Run this script to verify GPDB versions
```
$ ./list_gpdb_versions.sh
No arguments supplied
The ~/.pivnetrc file exists
H9sn5XbmcKWySySPhNxv
Logged-in successfully
List of pivotal-gpdb versions:
+------+--------------------------+--------------------------------+--------------------------+
|  ID  |         VERSION          |          DESCRIPTION           |        UPDATED AT        |
+------+--------------------------+--------------------------------+--------------------------+
| 8538 | 4.3.18.0                 |                                | 2017-11-30T22:07:36.504Z |
| 8496 | 5.2.0                    |                                | 2017-11-18T21:27:37.905Z |
| 7459 | 5.1.0                    |                                | 2017-11-09T21:55:50.394Z |
| 7400 | 4.3.17.1                 |                                | 2017-10-27T23:29:26.439Z |
| 6929 | 5.0.0                    |                                | 2017-11-09T21:44:55.148Z |
| 7106 | 4.3.17.0                 |                                | 2017-10-27T23:20:29.983Z |
|...   |   |   |   |
+------+--------------------------+--------------------------------+--------------------------+
{
  "id": 7106,
  "release_date": "2017-09-22",
  "release_type": "Minor Release"
}
```
5. Change PRODUCT_RELEASE variable in this file "greenplum/download_gpdb.sh"
Optionally, you can change this DOWNLOAD_FOLDER_PREFIX variable to configure the target download directory.
```
PRODUCT_RELEASE="5.2.0"
```
6. Run this file "greenplum/download_gpdb.sh" to start downloading process

7. Verify the Greenplum files are downloaded in "DOWNLOAD_5.2.0"

## Authors

* **Kong Yew** - *Initial work* - [kongyew](https://github.com/kongyew)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
