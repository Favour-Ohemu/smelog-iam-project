# SME AWS IAM Access Demonstration

This project demonstrates AWS IAM users, groups, and roles with S3 buckets in a small business scenario.
It simulates how different users and roles can access or be denied access to resources based on
their IAM policies.

## Project Setup

### 1. IAM Users & Groups
I Created users and groups with personalized policies:
- **smeuser** (Admin)
 - Policy: Full access
 - Notes: Can read/write SME bucket  


- **Ben** (Finance)
 - Policy: 'FinanceReportReadOnlyPolicy'
 - Notes: can only read finance reports



### 2. IAM Role
A temporary developer role was created:

 **Role Name:** DeveloperTemporaryRole  
 **Policy Assigned:** DeveloperTemporaryPolicy  
 **Purpose:** Allows developer limited access to their own testing bucket while preventing access to SME or Finance buckets.  




### 3. S3 Buckets
Buckets created for the project:
- smelog-bucket
- finance-logs-bucket
- developer-demo-bucket123  


### 4. AWS CLI & jq Installation
- Installed **AWS CLI** to interact with AWS via terminal.  
- Installed **jq** to parse JSON outputs for script automation.  



### 5. Script
- `simulate-access.sh` simulates access by different users and roles.  
- Demonstrates:
  - `smeuser` reading/writing to `smelog-bucket`  
  - Ben being denied write access to `finance-logs-bucket`  
  - DeveloperTemporaryRole:
    - Can access `developer-demo-bucket123` for testing  
    - **Cannot read/write to smelog-bucket or finance-logs-bucket** (AccessDenied)  
- Outputs show **AccessAllowed vs AccessDenied** events.


### 6. Test File
- 'testfile.txt' is used as a placeholder for s3 uploads
- e.g This is a test file for SME IAM S3 demonstration
- place this file in the same folder as 'simulate-access.sh' before running the script.



## How to run
1. Create IAM users/groups and assign policies (AWS Console)
2. Create IAM role and assign role policy (AWS Console)
3. Create S3 buckets (AWS Console)
4. Make sure AWS CLI and jq are installed on your terminal.
5. Place 'testfile.txt' in the project folder
6. Create and save 'simulate-access.sh' (Terminal)
7. Ensure 'simulate-access.sh' is executable:
'''
Bash
Chmod +x simulate-access.sh
8. Run the script: ./simulate-access.sh
9. Observe the output showing which users/roles are allowed or denied access



## Expected Outcome
- SME user: Allowed to read/write on smelog-bucket
- Ben (Finance user): Can read finance-logs-bucket, but writing is denied
- DeveloperTemporaryRole: Can create/list objects in developer-demo-bucket123 only but cannot access SME or Finance buckets
  

*Terminal  output Screenshots:
### 1. SME User Upload Test
<p align="center">
<img src="images/SME User Upload Outcome.png"
width="800">
</p>

### 2. DeveloperTemporaryRole Access Test
<p align="center">
<img src="images/DeveloperTemporaryRole Access Outcome.png"
width="800">
</p>

### 3. Ben Denied Write Test
<p align="center">
<img src="images/Ben Denied Write Outcome.png"
width="800">
</p>



## Learning Outcome
Through this project, I gained hands-on experience in:
- IAM users, groups and roles
- S3 bucket permissions and least privilege
- Access simulation and automation
- Policy testing and troubleshooting

### Key takeaways for SMES
- Always configure IAM properly because misconfigured IAM can lead to unauthorized access and data breaches.
- Have the understanding that excessive permissions increases the risk of privilege escalation.
- Proper access control prevents financial and operational risks.

## Tools & Technologies
- AWS (S3, IAM)
- AWS CLI
- Bash
- jq
- Terminal
