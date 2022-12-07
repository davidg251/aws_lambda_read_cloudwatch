import boto3

client = boto3.client('logs')

def lambda_handler(event, context):
    response = client.get_log_events(
      logGroupName='TargetLogGroup',
      logStreamName='TargetStream',
    )
    return response['events']