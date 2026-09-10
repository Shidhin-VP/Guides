from fastapi import FastAPI

from app.router import users

from app.database import Base, engine

Base.metadata.create_all(engine)

app=FastAPI()

app.include_router(router=users.router, prefix="/api/auth",tags=["users"])

# app.include_router(router=database_api.router, prefix="/api/db", tags=["db"])