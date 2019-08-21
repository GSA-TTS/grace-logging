# GRACE Logging

## Description
The code provided within this subcomponent will create the AWS resources neccessary to configure and enable logging and log storage.  The subcomponent also provides a method for configuring a trust relationship with GSA/SecOps to allow for the retrieval and analysis of you CloudTrail log data using their ELK Stack. The GRACE Logging subcomponent relies on the use of the following AWS services and resources:

* [AWS IAM](https://aws.amazon.com/iam/)
* [Amazon S3](https://aws.amazon.com/s3/)
* [AWS CloudTrail](https://aws.amazon.com/cloudtrail/)
* [Amazon CloudWatch](https://aws.amazon.com/cloudwatch/)

## Diagram
![grace-logging layout](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.github.com/GSA/grace-logging/grace-logging-documentation/res/diagram.uml)

## Parameters
|      Parameters      	|  Type  	| Required 	|     Default Value     	|                  Description                  |
|:--------------------	|:------:	|:--------:	|:---------------------:	|:---------------------------------------------	|
| parameter_A           | string 	|    yes   	|        word       	    | The word used for X            	              |
| parameter_B           | num 	  |    yes   	|        123       	      | The numerical value used for Y                |

## Deployment Guide

* Dependencies

* Installation

* Usage

## Maintenance & Operations


## Security Compliance
**Subcomponent approval status:** in assessment



### Security Control Coverage & SSP Naratives

**Relevant controls:**

Control | CSP/AWS | HOST/OS | App/DB | % Covered | How is it implemented?
--- | :---: | :---: | :---: | :---: | ---
[AC-2(a)](https://nvd.nist.gov/800-53/Rev4/control/AC-2) | ╳ | | | | AWS accounts are created for tenants of the platform as member accounts in the AWS Organization.

## Repository contents


### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_logging\_bucket\_acl | \(optional\) The ACL applied to the access logging bucket | string | `"log-delivery-write"` | no |
| access\_logging\_bucket\_backup\_days | \(optional\) The age of an object in number of days before it can be archived to glacier | string | `"365"` | no |
| access\_logging\_bucket\_backup\_expiration\_days | \(optional\) The age of an object in number of days before it can be safely discarded | string | `"900"` | no |
| access\_logging\_bucket\_block\_public\_acls | \(optional\) The boolean value enabling \(true\) or disabling \(false\) the blocking of public ACL creation for the access logging bucket | string | `"true"` | no |
| access\_logging\_bucket\_block\_public\_policy | \(optional\) The boolean value enabling \(true\) or disabling \(false\) the blocking of public policy creation for the access logging bucket | string | `"true"` | no |
| access\_logging\_bucket\_enable\_backup | \(optional\) The boolean value enabling \(true\) or disabling \(false\) backups to glacier on the access logging bucket | string | `"true"` | no |
| access\_logging\_bucket\_enable\_versioning | \(optional\) The boolean value enabling \(true\) or disabling \(false\) versioning on the access logging bucket | string | `"true"` | no |
| access\_logging\_bucket\_ignore\_public\_acls | \(optional\) The boolean value enabling \(true\) or disabling \(false\) the ignoring of public ACLs created for the access logging bucket | string | `"true"` | no |
| access\_logging\_bucket\_name | \(optional\) The name given to the access logging bucket | string | `"grace-access-logging"` | no |
| access\_logging\_bucket\_restrict\_public\_buckets | \(optional\) The boolean value enabling \(true\) or disabling \(false\) the blocking of public and cross-account access with the public bucket policy for the access logging bucket | string | `"true"` | no |
| cloudtrail\_bucket\_prefix | \(optional\) The prefix used when storing CloudTrail logs in the logging bucket | string | `"grace-cloudtrail"` | no |
| cloudtrail\_enable\_log\_validation | \(optional\) The boolean value indicating whether this CloudTrail should perform log file integrity validation | string | `"true"` | no |
| cloudtrail\_include\_global\_service\_events | \(optional\) The boolean value indicating whether global services are sending events to this CloudTrail \(ie: IAM\) | string | `"true"` | no |
| cloudtrail\_log\_retention\_days | \(optional\) The number of days to retain logs in the CloudWatch log group | string | `"365"` | no |
| cloudtrail\_multi\_region | \(optional\) The boolean value indicating whether this CloudTrail is multi-region | string | `"true"` | no |
| cloudtrail\_name | \(optional\) The name given to the CloudTrail | string | `"grace-cloudtrail"` | no |
| flowlogs\_bucket\_prefix | \(optional\) The prefix used when storing Flow logs in the logging bucket | string | `"grace-flowlogs"` | no |
| logging\_access\_logging\_prefix | \(optional\) The prefix used when storing access logs for the logging bucket | string | `"grace-logging"` | no |
| logging\_bucket\_acl | \(optional\) The ACL applied to the primary logging bucket | string | `"log-delivery-write"` | no |
| logging\_bucket\_backup\_days | \(optional\) The age of an object in number of days before it can be archived to glacier | string | `"365"` | no |
| logging\_bucket\_backup\_expiration\_days | \(optional\) The age of an object in number of days before it can be safely discarded | string | `"900"` | no |
| logging\_bucket\_block\_public\_acls | \(optional\) The boolean value enabling \(true\) or disabling \(false\) the blocking of public ACL creation for the logging bucket | string | `"true"` | no |
| logging\_bucket\_block\_public\_policy | \(optional\) The boolean value enabling \(true\) or disabling \(false\) the blocking of public policy creation for the logging bucket | string | `"true"` | no |
| logging\_bucket\_enable\_backup | \(optional\) The boolean value enabling \(true\) or disabling \(false\) backups to glacier on the logging bucket | string | `"true"` | no |
| logging\_bucket\_enable\_versioning | \(optional\) The boolean value enabling \(true\) or disabling \(false\) versioning on the logging bucket | string | `"true"` | no |
| logging\_bucket\_ignore\_public\_acls | \(optional\) The boolean value enabling \(true\) or disabling \(false\) the ignoring of public ACLs created for the logging bucket | string | `"true"` | no |
| logging\_bucket\_name | \(optional\) The name given to the primary logging bucket | string | `"grace-logging"` | no |
| logging\_bucket\_restrict\_public\_buckets | \(optional\) The boolean value enabling \(true\) or disabling \(false\) the blocking of public and cross-account access with the public bucket policy for the logging bucket | string | `"true"` | no |
| secops\_accounts | \(optional\) A comma delimited string containing the Account IDs of accounts that should access to your log buckets, if empty no external accounts will be allowed to read the logs | string | `""` | no |
| secops\_role\_name | \(optional\) The name given to the SecOps read only access to the logging bucket | string | `"grace-secops-read"` | no |

### Outputs

| Name | Description |
|------|-------------|
| access\_bucket\_arn | The ARN of the access log bucket. |
| access\_bucket\_id | The name of the access log bucket. |
| cloudtrail\_arn | The Amazon Resource Name of the trail. |
| cloudtrail\_id | The name of the trail. |
| cloudtrail\_kms\_key\_arn | The Amazon Resource Name \(ARN\) of the CloudTrail KMS key. |
| cloudtrail\_kms\_key\_id | The globally unique identifier for the CloudTrail KMS key. |
| cloudtrail\_log\_group\_arn | The Amazon Resource Name \(ARN\) specifying the CloudTrail log group |
| cloudtrail\_policy\_id | The ID of the CloudTrail policy. |
| cloudtrail\_role\_arn | The Amazon Resource Name \(ARN\) specifying the CloudTrail role. |
| cloudtrail\_role\_id | The name of the CloudTrail role. |
| logging\_bucket\_arn | The ARN of the logging bucket. |
| logging\_bucket\_id | The name of the logging bucket. |
| secops\_policy\_id | The ID of the secops read only policy. |
| secops\_role\_arn | The Amazon Resource Name \(ARN\) specifying the secops read only role. |
| secops\_role\_id | The name of the secops read only role. |


## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
