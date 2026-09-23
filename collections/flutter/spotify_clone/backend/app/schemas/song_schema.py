from pydantic import BaseModel, Field
from uuid import UUID


class SongBase(BaseModel):
    # song_url: str = Field(min_length=1)
    artist: str = Field(min_length=1)
    song_name: str = Field(min_length=1)
    color: str 


class SaveSong(SongBase):
    pass

class SongReturn(SongBase): 
     pass

class LibraryReturn(BaseModel): 
        user_id:UUID
        song_url:str
        artist_name:str
        color:str
        song_name:str 
        id: UUID
        thumbnail_url:str
