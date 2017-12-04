# Download Greenplum

This page describes how to automatically download Greenplum release files from [Pivotal Network](https://network.pivotal.io/).  It assumes you have the [Pivnet account](https://login.run.pivotal.io/create_account?client_id=pivnet-production&redirect_uri=https://network.pivotal.io/login) with the appropriate permissions.

## Getting Started

These instructions helps to download Greenplum releases from Pivotal Network.

### Prerequisites

- [PivNet-cli](https://github.com/pivotal-cf/pivnet-cli)
- Pivotal Network account with [API Token](https://network.pivotal.io/users/dashboard/edit-profile)

### Installing

A step by step series of examples that tell you have to get started

1. Clone this repository by using git clone <repo>
2. Configure (Pivnet CLI)[https://github.com/pivotal-cf/pivnet-cli]
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
3. Run this script to verify GPDB versions
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
| 6680 | 4.3.16.1                 |                                | 2017-09-21T09:22:27.118Z |
| 6342 | 4.3.16.0                 |                                | 2017-09-22T20:28:46.227Z |
| 6120 | 4.3.15.0                 |                                | 2017-09-22T20:28:46.217Z |
| 5973 | 4.3.14.1                 |                                | 2017-09-22T20:28:46.208Z |
| 5642 | 4.3.14.0                 |                                | 2017-09-22T20:28:46.198Z |
| 5226 | 4.3.13.0                 |                                | 2017-09-22T20:28:46.188Z |
| 4540 | 4.3.12.0                 |                                | 2017-09-22T20:28:46.177Z |
| 3936 | 4.3.11.3                 |                                | 2017-09-22T20:28:46.167Z |
| 3930 | 4.3.11.2                 |                                | 2017-09-22T20:28:46.155Z |
| 3710 | 4.3.11.1                 |                                | 2017-09-22T20:28:46.140Z |
| 3401 | 4.3.11.0                 |                                | 2017-09-22T20:28:46.129Z |
| 2684 | 4.3.10.0                 |                                | 2017-09-22T20:28:46.119Z |
| 2146 | 4.3.9.1                  |                                | 2017-09-22T20:31:32.094Z |
| 2059 | 4.3.9.0                  |                                | 2017-09-22T20:31:32.084Z |
| 5789 | 5.0.0-alpha.8            |                                | 2017-09-22T20:31:32.074Z |
| 6876 | 5.0.0-beta.10            |                                | 2017-10-12T23:09:09.128Z |
| 6437 | 5.0.0-beta.6             |                                | 2017-09-25T17:40:08.957Z |
| 6810 | 5.0.0-beta.9             |                                | 2017-10-12T23:09:09.128Z |
| 6247 | 5.0.0-beta.4             |                                | 2017-09-22T20:31:32.036Z |
| 5958 | 5.0.0-beta.2             |                                | 2017-09-22T20:31:32.026Z |
| 5857 | 5.0.0-beta.1             |                                | 2017-09-22T20:31:32.017Z |
| 6065 | 5.0.0-beta.3             |                                | 2017-09-22T20:31:32.007Z |
| 6345 | 5.0.0-beta.5             |                                | 2017-09-22T20:31:31.997Z |
| 6694 | 5.0.0-beta.8             |                                | 2017-09-25T17:40:19.862Z |
| 5709 | 5.0.0-alpha.7            |                                | 2017-09-22T20:31:31.975Z |
| 5640 | 5.0.0-alpha.6            |                                | 2017-09-22T20:31:31.965Z |
| 5556 | 5.0.0-alpha.5            |                                | 2017-09-22T20:31:31.954Z |
| 5428 | 5.0.0-alpha.4            |                                | 2017-09-22T20:31:31.944Z |
| 5361 | 5.0.0-alpha.3            |                                | 2017-09-22T20:31:31.932Z |
| 6899 | MS 5.0.0-beta.10         |                                | 2017-09-22T20:31:31.920Z |
| 5290 | 5.0.0-alpha.2            |                                | 2017-09-22T20:31:31.910Z |
| 4990 | 5.0.0-alpha.1            | WARNING: Pivotal Greenplum 5   | 2017-09-22T20:31:31.900Z |
|      |                          | is NOT YET supported on EMC    |                          |
|      |                          | DCA platforms                  |                          |
| 3929 | 4.3.9.1CCB3              | Private hotfix for CCB         | 2017-09-22T20:31:31.889Z |
| 2000 | 4.3.8.2.GE2              |                                | 2017-05-15T16:21:22.557Z |
| 1927 | 4.3.8.2.GE1              |                                | 2017-05-15T16:21:22.516Z |
| 1748 | 4.3.8.2                  |                                | 2017-08-29T21:06:00.507Z |
| 5432 | 4.3.8.1IRS2              |                                | 2017-05-15T16:21:22.446Z |
| 5323 | 4.3.8.1IRS1              | Hotfix Patch Release for the   | 2017-05-15T05:49:07.707Z |
|      |                          | IRS                            |                          |
| 1683 | 4.3.8.1                  |                                | 2017-09-21T09:22:27.118Z |
| 1678 | Pivotal Greenplum Text   | GPText 1.3.0.3 Release and     | 2017-03-23T20:59:15.031Z |
|      |                          | GPText 2.0 Beta Releases       |                          |
| 1624 | 4.3.8.0                  |                                | 2017-09-21T09:22:27.118Z |
| 1533 | 4.3.7.3                  |                                | 2017-09-21T09:22:27.118Z |
| 1502 | 4.3.7.2                  |                                | 2017-09-21T09:22:27.118Z |
| 1377 | 4.3.7.1                  |                                | 2017-09-21T09:22:27.118Z |
| 1318 | 4.3.7.0                  |                                | 2017-09-21T09:22:27.118Z |
|  669 | 4.3.6.2                  |                                | 2017-09-21T09:22:27.118Z |
|  567 | 4.3.6.1                  |                                | 2017-09-21T09:22:27.118Z |
|  539 | 4.3.6.0                  |                                | 2017-08-29T21:06:00.507Z |
|  497 | 4.3.5.4                  |                                | 2017-09-21T09:22:27.118Z |
|  472 | 4.3.5.3                  |                                | 2017-09-21T09:22:27.118Z |
|  273 | 4.3.5.2                  |                                | 2017-09-21T09:22:27.118Z |
|  249 | 4.3.5.1                  |                                | 2017-09-21T09:22:27.118Z |
|  240 | GP Workload Manager Beta | Greenplum Workload Manager     | 2017-03-23T21:13:21.233Z |
|      |                          | Beta Release                   |                          |
|  210 | 4.3.5.0                  | Introducing the General        | 2017-09-21T09:22:27.118Z |
|      |                          | Availability of the Pivotal    |                          |
|      |                          | Query Optimizer                |                          |
|  199 | 4.3.4.2                  |                                | 2017-08-29T22:31:26.755Z |
|  178 | 4.3.4.1                  |                                | 2017-08-29T22:31:26.755Z |
|  120 | 4.3.4.0                  |                                | 2017-08-29T22:31:26.755Z |
|  151 | 4.3.3.1                  |                                | 2017-08-29T22:31:26.755Z |
|  119 | 4.3.3.0                  |                                | 2017-08-29T22:31:26.755Z |
|  150 | 4.3.2.1                  |                                | 2017-08-29T22:31:26.755Z |
|  118 | 4.3.2.0                  |                                | 2017-08-29T22:31:26.755Z |
|  117 | 4.3.1.0                  |                                | 2017-08-29T22:31:26.755Z |
|  116 | 4.3.0.0                  |                                | 2017-08-29T22:31:26.755Z |
|  316 | 4.2.8.5                  |                                | 2017-08-08T19:38:18.902Z |
|  209 | 4.2.8.4                  |                                | 2017-08-08T19:38:18.902Z |
|  152 | 4.2.8.3                  |                                | 2017-08-08T19:38:18.902Z |
|  154 | 4.2.8.2                  |                                | 2017-08-08T19:38:18.902Z |
|  155 | 4.2.8.1                  |                                | 2017-08-08T19:38:18.902Z |
|  156 | 4.2.8.0                  |                                | 2017-08-08T19:38:18.902Z |
+------+--------------------------+--------------------------------+--------------------------+
{
  "id": 7106,
  "release_date": "2017-09-22",
  "release_type": "Minor Release"
}
```
4.


## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning



## Authors

* **Kong Yew** - *Initial work* - [kongyew](https://github.com/kongyew)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
