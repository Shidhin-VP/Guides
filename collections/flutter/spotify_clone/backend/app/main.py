from fastapi import FastAPI #NOQA

from app.router import users
from app.router import song

from app.ini.database import Base, engine

Base.metadata.create_all(engine)

app=FastAPI()

app.include_router(router=users.router, prefix="/api/auth",tags=["users"])
app.include_router(router=song.router, prefix="/api/song",tags=["song"])

# app.include_router(router=database_api.router, prefix="/api/db", tags=["db"])