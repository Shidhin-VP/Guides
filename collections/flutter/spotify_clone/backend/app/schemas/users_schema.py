from pydantic import BaseModel, computed_field, Field  # type:ignore
import jwt

from app.config.settings import settings


class UserBase(BaseModel):
    email: str = Field(min_length=1, max_length=250)


class UserCreate(UserBase):
    name: str = Field(min_length=1, max_length=50)
    password: str = Field(min_length=1)


class UserSignUpResponse(UserBase):
    name: str = Field(min_length=1, max_length=50)

    @computed_field
    def _final_message(self) -> str:
        return f"Welcome {self.name}!"


class UserLogin(UserBase):
    password: str


class UserLoginResponse(UserBase):
    name: str = Field(min_length=1, max_length=50)
    id: str = Field(min_length=1, max_length=80)

    # @property # Needs to be first even before computed_field
    @computed_field
    def _final_message(self) -> str:
        return f"Welcome Again {self.name}"

    @computed_field
    def jwt_token(self) -> str:
        return jwt.encode(payload={"id": self.id}, key=settings.jwt_private_key)  # type:ignore


class ValidateToken(BaseModel):
    token: str
