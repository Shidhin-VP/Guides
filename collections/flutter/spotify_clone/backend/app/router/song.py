from typing import Annotated, Any  # noqa: I001 #No Quality Assurance

from fastapi import APIRouter, status, HTTPException, UploadFile, File, Form, Depends
from sqlalchemy.orm import Session
from sqlalchemy import select

from app.models import Song
from app.schemas.song_schema import SongReturn, LibraryReturn
from app.ini.database import get_db
from app.config.settings import settings
from app.ini.aws_config import get_aws
from app.middleware.auth_middleware import auth_middleware

router = APIRouter()
# KEY_STRUCTURE=f"/songs/{id}/{song.filename}"


@router.post(path="/save_song", status_code=status.HTTP_201_CREATED)
async def save_song(
    song: Annotated[UploadFile, File(...)],
    thumbnail: Annotated[UploadFile, File(...)],
    artist: Annotated[str, Form(...)],
    song_name: Annotated[str, Form(...)],
    hex_code: Annotated[str, Form(...)],
    id_token: Annotated[dict[str, Any], Depends(auth_middleware)],
    db: Annotated[Session, Depends(get_db)],
    s3: Annotated[Any, Depends(get_aws)],  # Type:ignore
):
    try:
        await song.seek(0)
        await thumbnail.seek(0)
        print(id_token)
        id: str = id_token["id"]
        song_url: str = f"/{id}/songs/{song.filename}"
        thumbnail_url: str = f"/{id}/images/{thumbnail.filename}"
        newSogn: Song = Song(
            user_id=id,
            song_url=song_url,
            thumbnail_url=f"{settings.aws_public_bucket_url}{thumbnail_url}",
            artist_name=artist,
            song_name=song_name,
            color=hex_code,
        )
        s3.upload_fileobj(
            song.file,
            Bucket=settings.aws_bucket_name,
            Key=song_url,
        )
        s3.upload_fileobj(
            thumbnail.file, Bucket=settings.aws_bucket_name, Key=thumbnail_url
        )
        db.add(newSogn)
        db.commit()
        db.refresh(newSogn)
        return SongReturn(
            song_name=newSogn.song_name, artist=newSogn.artist_name, color=newSogn.color
        )
    except Exception as e:
        print("Error: ", e)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Unknown Error: {e}",
        )


@router.get("/library",response_model=list[LibraryReturn], status_code=status.HTTP_200_OK)
def get_library(
    db: Annotated[Session, Depends(get_db)],
    mw: Annotated[Any, Depends(auth_middleware)],
):
    # id: str = mw["id"]
    res = db.execute(select(Song).limit(10))
    res=res.scalars().all()
    return res