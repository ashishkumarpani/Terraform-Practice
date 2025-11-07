import boto3

def lambda_handler(event, context):
    s3 = boto3.client('s3')

    # List all S3 buckets in your account
    response = s3.list_buckets()
    bucket_names = [bucket['Name'] for bucket in response['Buckets']]

    print("S3 Buckets:", bucket_names)
    return {
        'statusCode': 200,
        'body': f"S3 Buckets: {bucket_names}"
    }