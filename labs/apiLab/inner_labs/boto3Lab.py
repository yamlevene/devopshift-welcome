from inner_labs.boto3LabUtils import *


def manage_s3_pipeline():
    back = False
    while not back:
        print_s3_menu()
        user_bucket_choice = input("your choice: ")
        if user_bucket_choice == BACK_TO_MAIN_MENU:
            back = True
        else:
            result = perform_buckets_operation(user_bucket_choice)
            if result == INVALID:
                print("invalid bucket operation")
    return VALID

def manage_ec2_pipeline():
    back = False
    while (not back):
        print_ec2_menu()
        user_ec2_choice = input("your choice: ")
        if user_ec2_choice == BACK_TO_MAIN_MENU:
            back = True
        else:
            result = perform_ec2_operation(user_ec2_choice)
            if result == INVALID:
                print("invalid ec2 operation")
    return VALID


def exit_pipeline():
    print("see you")
    return EXIT

pipelines = {MANAGE_BUCKET: manage_s3_pipeline,
             MANAGE_EC2: manage_ec2_pipeline,
             EXIT: exit_pipeline}


if __name__ == '__main__':

    while True:

        print_menu()
        user_choice = input("your choice: ")

        operation_output = None
        try:
            operation_output = pipelines[user_choice]()
        except KeyError as key_err:
            print("invalid operation, choose again")

        if operation_output == EXIT:
            break
