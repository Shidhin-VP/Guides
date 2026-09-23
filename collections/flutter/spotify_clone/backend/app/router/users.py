from typing import Annotated, Any #noqa

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.orm import Session
import bcrypt

from app.schemas.users_schema import (
    UserCreate,
    UserSignUpResponse,
    UserLogin,
    UserLoginResponse,
)
from app.ini.database import get_db

from app.middleware.auth_middleware import auth_middleware
from app import models

router = APIRouter()


@router.post(
    "/signup", response_model=UserSignUpResponse, status_code=status.HTTP_201_CREATED
)
def create_user(user: UserCreate, db: Annotated[Session, Depends(get_db)]):
    user_result = db.execute(select(models.User).where(models.User.name == user.name))
    if user_result.scalars().first():
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, detail="User Name Already Exist"
        )
    email_result = db.execute(
        select(models.User).where(models.User.email == user.email)
    )
    if email_result.scalars().first():
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email Already Exist, Please Login",
        )

    hashed_pw = bcrypt.hashpw(user.password.encode(), salt=bcrypt.gensalt())
    new_user = models.User(name=user.name, email=user.email, password=hashed_pw)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user


@router.post(
    path="/signin", response_model=UserLoginResponse, status_code=status.HTTP_200_OK
)
def login_user(user: UserLogin, db: Annotated[Session, Depends(get_db)]):
    user_result = db.execute(select(models.User).where(models.User.email == user.email))
    user_db = user_result.scalars().first()
    if not user_db:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Email or Password Not Correct",
        )
    check_password = bcrypt.checkpw(
        user.password.encode(), hashed_password=user_db.password
    )
    if check_password is not True:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Password or Email Not Correct",
        )
    return UserLoginResponse(email=user.email, name=user_db.name, id=str(user_db.id))


@router.get(
    path="/",
    # response_model=UserLoginResponse,
    status_code=status.HTTP_200_OK,
)
def get_user_data(
    db: Annotated[Session, Depends(get_db)],
    auth_mw: Annotated[dict[str, Any], Depends(auth_middleware)],
):
    id: str = auth_mw["id"]
    # token:str=auth_mw['token']
    user = db.execute(select(models.User).where(models.User.id == id))
    validate_id = user.scalars().first()
    if not validate_id:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail="No User Found"
        )
    return UserLoginResponse(
        email=validate_id.email, name=validate_id.name, id=str(validate_id.id)
    )
