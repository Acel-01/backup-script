#!/bin/bash

echo "Hello there!"
echo "This is a script to enable you backup files in any local directory(folder) to your S3 bucket"
echo ""

echo "Enter a route to the directory"
read -p "(Enter a full stop if this script is in the folder you want to back up): " file_path

# get file path and make sure it 
# ends with a forward slash
cd "$file_path" || exit 1
if [[ "${file_path: -1}" != "/" ]]; then
	file_path="$file_path/"
fi

# install aws cli
echo ""
if ! command -v aws &> /dev/null
then
	echo "Installing AWS CLI"
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
else
	echo "AWS CLI already installed"
fi


# configure aws cli with your credentials
echo ""
echo "Configure AWS CLI with your credentials"
aws configure

echo ""
read -p "Enter the S3 bucket name: " S3_BUCKET_NAME
read -p "Optional: Enter a folder name: " FOLDER_NAME

# loop each file in the directory and upload them to
# S3 bucket with the given credentials
for file in *; do
	if [[ "$file" == 'aws' || "$file" == "awscliv2.zip" || "$file" == "backup-files-s3.sh" ]]; then
		continue
	fi

	echo "uploading $file_path$file"	
	aws s3 cp "$file_path$file" s3://"$S3_BUCKET_NAME"/"$FOLDER_NAME"/ --acl public-read
done
