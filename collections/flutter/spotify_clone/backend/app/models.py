import uuid #noqa

from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy import String, LargeBinary, ForeignKey
from sqlalchemy.dialects.postgresql import UUID

from app.ini.database import Base


class User(Base):  # Creating User Table
    __tablename__ = "users"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), default=uuid.uuid4, primary_key=True, unique=True
    )  # Mapped help us to make sure SQLAlchemy know that the id needs to be a column in the database
    name: Mapped[str] = mapped_column(
        String(100), nullable=False
    )  # mapped_column help us to customize the column
    email: Mapped[str] = mapped_column(String(250), unique=True, nullable=False)
    password: Mapped[bytes] = mapped_column(LargeBinary, nullable=False)
    songs: Mapped[list[Song]] = relationship(
        back_populates="user"
    )


class Song(Base):
    __tablename__ = "songs"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        default=uuid.uuid4,
        unique=True,
        primary_key=True,
    )
    user_id:Mapped[uuid.UUID]=mapped_column(
        ForeignKey("users.id")
    )
    song_url:Mapped[str]
    song_name:Mapped[str]
    artist_name:Mapped[str]
    thumbnail_url:Mapped[str]
    color:Mapped[str]
    user:Mapped[User]=relationship(
        back_populates="songs"
    )




# Base.metadata.create_all(engine) # Will Create all the Required Tables only creates if table is not present
