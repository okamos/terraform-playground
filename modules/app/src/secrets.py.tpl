import boto3
import os

def lambda_handler(event, context):
    secret_name = os.getenv("SECRET_NAME", "okamos-playground-sdlc-secret")
    region_name = "ap-northeast-1"

    # Secrets Manager クライアント作成
    client = boto3.client("secretsmanager", region_name=region_name)

    try:
        # シークレット取得
        response = client.get_secret_value(SecretId=secret_name)
        secret = response["SecretString"]

        return {
            "statusCode": 200,
            "body": f"Retrieved secret: {secret}"
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": f"Failed to retrieve secret: {str(e)}"
        }
