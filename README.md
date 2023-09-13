# Backup Script
A bash script to enable you backup files and folders from your terminal to your S3 bucket

## Prerequisites
- Create an S3 bucket on AWS
- Create an IAM user with access to the bucket
- Enable ACLs for the bucket

## Setup
- Download the **backup-files-s3.sh** file from this repository
- Move it to your preferred folder and open the file location in a terminal (preferably bash)
- Enter the command below to make it executable
  ```bash
  chmod u+x backup-files-s3.sh
  ```
- Start the script with the command
  ```bash
  bash backup-files-s3.sh
  ```
