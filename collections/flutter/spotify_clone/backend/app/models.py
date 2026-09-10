import uuid

from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy import String, LargeBinary
from sqlalchemy.dialects.postgresql import UUID

from app.database import Base


class User(Base):  # Creating User Table
    __tablename__ = "users"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True),default= uuid.uuid4, primary_key=True) # Mapped help us to make sure SQLAlchemy know that the id needs to be a column in the database
    name: Mapped[str] = mapped_column(String(100), nullable=False) # mapped_column help us to customize the column
    email: Mapped[str] = mapped_column(String(250), unique=True, nullable=False)
    password: Mapped[bytes] = mapped_column(LargeBinary, nullable=False)


# Base.metadata.create_all(engine) # Will Create all the Required Tables only creates if table is not present
