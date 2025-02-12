import boto3
from botocore.exceptions import ClientError


INVALID, VALID = -1, 1
MANAGE_BUCKET, MANAGE_EC2, EXIT = '1', '2', '3'
LIST_BUCKETS, CREATE_BUCKET, DELETE_BUCKET = '1', '2', '3'
LIST_EC2, START_EC2, STOP_EC2, TERMINATE_EC2 = '1', '2', '3', '4'
BACK_TO_MAIN_MENU = '0'


# creating an s3 client
s3_client = boto3.client("s3")

# create an ec2 resource
ec2_client = boto3.client("ec2")


def hash_print(print_msg):
    print("#########################")
    print(print_msg)
    print("#########################")


def print_menu():
    print("choose between:")
    print("1. manage S3 buckets")
    print("2. manage EC2 instances")
    print("3. exit")


def print_s3_menu():
    print("What do you want to do?")
    print("0. back to main menu")
    print("1. display buckets")
    print("2. create a bucket")
    print("3. delete a bucket")


def perform_buckets_operation(bucket_operation):

    if bucket_operation == LIST_BUCKETS:
        buckets_list = s3_client.list_buckets()
        for bucket in buckets_list["Buckets"]:
            print(f"- {bucket['Name']}")
            return VALID

    elif bucket_operation == CREATE_BUCKET:
        bucket_name = input("choose a name for bucket: ")
        try:
            response = s3_client.create_bucket(Bucket=bucket_name)
        except ClientError as client_err:
            hash_print(client_err)
        return VALID

    elif bucket_operation == DELETE_BUCKET:
        bucket_name = input("name of bucket to delete: ")
        try:
            response = s3_client.delete_bucket(Bucket=bucket_name)
        except ClientError as client_err:
            hash_print(client_err)
        return VALID
    else:
        return INVALID


def print_ec2_menu():
    print("What do you want to do?")
    print("0. back to main menu")
    print("1. display ec2 instances")
    print("2. start an ec2 instance")
    print("3. stop an ec2 instance")
    print("4. terminate an ec2 instance")


def perform_ec2_operation(ec2_operation: str) -> int:

    if ec2_operation == LIST_EC2:
        try:
            print(ec2_client.describe_instances())
        except ClientError as client_err:
            hash_print(client_err)
        return VALID

    elif ec2_operation == START_EC2:
        instance_id = input("instance id: ")
        try:
            ec2_client.start_instances(InstanceIds=[instance_id])
        except ClientError as client_err:
            hash_print(client_err)
        return VALID

    elif ec2_operation == STOP_EC2:
        instance_id = input("instance id: ")
        try:
            ec2_client.stop_instances(InstanceIds=[instance_id])
        except ClientError as client_err:
            hash_print(client_err)
        return VALID

    elif ec2_operation == TERMINATE_EC2:
        instance_id = input("instance id: ")
        try:
            ec2_client.terminate_instances(InstanceIds=[instance_id])
        except ClientError as client_err:
            hash_print(client_err)
        return VALID

    else:
        return INVALID

