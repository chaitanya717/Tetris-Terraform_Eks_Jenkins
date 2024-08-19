
# Installing Docker 
#!/bin/bash
sudo apt update
sudo apt install docker.io -y
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
sudo chmod 777 /var/run/docker.sock

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt install unzip -y

unzip awscliv2.zip

sudo ./aws/install

# !/bin/bash
# Check if the correct number of arguments is provided
# if [ "$#" -ne 2 ]; then
#     echo "Usage: $0 <AWS_ACCESS_KEY_ID> <AWS_SECRET_ACCESS_KEY>"
#     exit 1
# fi

# # Get the AWS credentials from the arguments
# AWS_ACCESS_KEY_ID="$1"
# AWS_SECRET_ACCESS_KEY="$2"

# # Optionally, you can hardcode or set the AWS region as a variable
# AWS_REGION="us-east-1"

# # Configure AWS CLI with the provided credentials
# aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
# aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
# aws configure set region "$AWS_REGION"

# # Verify the credentials by listing S3 buckets (as an example)
# echo "Verifying credentials by listing S3 buckets..."
# aws s3 ls

# # Check if the aws s3 ls command was successful
# if [ $? -eq 0 ]; then
#     echo "Successfully signed in to AWS!"
# else
#     echo "Failed to sign in to AWS. Please check your credentials."
# fi

# Installing Kubectl
#!/bin/bash
sudo apt update
sudo apt install curl -y
sudo curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client
