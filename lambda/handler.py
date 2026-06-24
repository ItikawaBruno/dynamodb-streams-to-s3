import json
import boto3
import os

s3 = boto3.client('s3')

BUCKET = os.environ['BUCKET_NAME']

def lambda_handler(event, context):
    
    for record in event['Records']:
        
        item = record['dynamodb']['NewImage']
        
        arquivo = json.dumps(item)
        
        s3.put_object(
            Bucket = BUCKET,
            Key = f"eventos/{record['eventID']}.json",
            Body = arquivo
        )
        print("Teste")
        print(f"Arquivo {record['eventID']}.json enviado para o bucket {BUCKET}")
        return {
            "statusCode": 200
        }
