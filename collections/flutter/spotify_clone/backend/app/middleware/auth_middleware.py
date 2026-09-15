from typing import Any

import jwt
from fastapi import Header, HTTPException, status

from app.config.settings import settings


def auth_middleware(x_auth_token=Header(default=None))->dict[str,Any]: # type:ignore
    try:
        verified_token = jwt.decode( # type:ignore
            jwt=x_auth_token, key=settings.jwt_private_key, algorithms=["HS256"]
        )  # type: ignore
        if not verified_token:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED, detail="Token Not Valid"
            )
        email_address = verified_token.get("email")
        return {"email": email_address,"token":verified_token}
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail=str(e)
        )
