from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env", env_file_encoding="utf-8", extra="ignore",
    )
    database_url: str
    jwt_private_key:str
    aws_access_key:str 
    aws_secret_key:str
    aws_region_name:str
    aws_bucket_name:str
    aws_public_bucket_url:str


settings = Settings()  # type:ignore
