import boto3  # noqa: I001 #type:ignore
from app.config.settings import settings

client = boto3.client(  # type:ignore
    "s3",
    aws_access_key_id=settings.aws_access_key,
    aws_secret_access_key=settings.aws_secret_key,
    region_name=settings.aws_region_name,
)

def get_aws():  # type:ignore
    return client  # type:ignore
