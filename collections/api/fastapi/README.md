#

## Youtube

## Python FastAPI Tutorial: Full Course for Beginners - Build a Full-Stack Web App (Corey Schafer)

* Link to the [Video](https://youtu.be/iukOehU5aF4?si=ZnDb1-RiGgDOexKf)

1. Till [1:38:41](https://youtu.be/iukOehU5aF4?si=_gbjBIUVwR-aaTs5&t=5921)
   * Learned about importation:

     * ```python
        from typing import Annotated
        from fastapi import FASTAPI, HTTPException, Request, status, Depends
        from fastapi.exception import RequestValidationError
        from fastapi.response import JSONResponse # Can be removed after instalking request_validation_exception_handler
        from fastapi.staticfiles import StaticFiles
        from fastapi.templating import Jinja2Templates
        from startlette.exceptions import HTTPException as StartletteHTTPException
        from sqlalchemy import select 
        from sqlalchemy import Session # For type hints   

        # Sync Vs Async 
        from cotextlib import asynccontextmanager
        from fastapi.exception_handlers import http_exception_handler, reqeust_validation_exception_handler

        
        # File Importations
        import models
        from database import Base, engine, get_db
        from schemas import PostCreate, PostResponse
        ```

    * What those importation does.
      * We need FASTAPI to create the fastapi instance, and this is the foundation
      * $${\color{orange}HTTPException}$$ from the FastAPI help us to raise HTTPExceptions (An Error Response)
      * $${\color{orange}Request}$$ let us access the incoming HTTP request itself, it's headers, URL, client information, body and other request details.
      * $${\color{orange}Status}$$ is a collection of named HTTP status-code constants.
      * $${\color{orange}RequestValidationError}$$ helps us to validate wrong inputs/types from the client side
      * $${\color{orange}JSONResponse}$$ helps us to return a custom and explicit JSON response from the FASTAPI api
      * $${\color{orange}StaticFiles}$$ helps us to serve static files such as Images, CSS Files, JavaScript Files, HTML Files etc. This can be mainly used to when we use Templates
      * $${\color{orange}Jinja2Templates}$$ is used to render HTML pages using Jinja2templates, this also takes $${\color{orange}Request}$$ as a required input because the template can access the request related information, including URL generation.
      * $${\color{orange}HTTPException \space from \space \color{gold}Starlette}$$ can be used to defined unmanaged exceptions
2. [From 1:40:32](https://youtu.be/iukOehU5aF4?si=W1OwsbzNCo-6u6Tp)

   ### How to run FastAPI

   1. ```uv run fastapi dev main.py``` (This is just for reference)
   2. ```uv add aiosqlite```
   3. uv add pysocpg? for postgressql (Need to verify)

   ### Initializing FASTAPI

   4. app=FASTAPI()
   5. app.mount("/static",StaticFiles(directory="static"),name="static)
   6. templates=Jinja2Templates(directory="templates")#The Folder name where the templates are saved.
   7. Base.metadata.create_all(bind=engine) # Create tables if not exist, happens on app startup
   8. @asynccontextmanager
       ```python
       async def lifespan(_app:FASTAPI): 
        async with engine.begin() as conn: 
          await conn.run_sync(BAse.metadata.create_all)
        yield
        await engine.dispose()
        ```
   9. app=FastAPI(lifespan=lifespan)
   9.  app.mount("/media",StaticFiles(directory="media"),name="media")

   ### Role of Pydantic in FastAPI

   * Can help us to document the request and response properly and also have run time validation
   * Creating  `Schemas.py`
   *

    ```
     from pydantic import BaseModel, ConfigDict, Field, EmailStr
     ```

   * $${\color{orange}BaseModel}$$ Base class that all the pydantic model inherit from
   * $${\color{orange}Field}$$ lets us add constraints like min and max length
   * $${\color{orange}ConfigDict}$$ is the modern pydantic version to way to config models
   * a

    ```python
    class PostBase(BaseModel): 
      title:str=Field(min_length=1, max_length=100)
      content:str=Field(min_length=1)
      author:str=Field(min_length=1,max_length=50)
    ```

    ```python
    class PostCreate(PostBase): # Will contain everything from PostBase
      pass

    class PostUpdate(BaseModel): 
      title:str|None=Field(default=None, min_length=1,max_length=100)
    ```

    ```python
    class PostResponse(PostBase): 
      model_config=ConfigDict(from_attributes=True)# TElls pydantic Version2 it can read data from object with attributes and not just dict
      id:int
      date_posted:str # can change to DateTime later (Only for references)
    ```

  ### EndPoint Config

    ```python
    1. app=FASTAPI()
    2. @app.get("/api/posts")
    3. @app.get("/api/posts" , response_model=list[PostResponse])
    4. @app.get("/api/posts/{id}",response_model=PostResponse)
    5. @app.get("/post",include_in_schema=False)
    6. @app.post("/api/posts",response_model=PostResponse,status_code=status.HTTP_201_CREATED)
    7. @app.exception_handler(StarletteHTTPException)
    8. @app.excpetion_handler(RequestValidationError)
    9. @app.get("/",include_in_schema=False, name="home")
    10. @app.post("/api/users",response_model=UserResponse,status_code=status.HTTP_201_CREATED)    
        * 
        def create_user(user:UserCreate, db:Annotated[Session, Depends(get_db)]):
          result=db.execute(select(models.User).where(models.user==user.username))
          users=result.scalars().first()
          if users: 
            return HTTPException(
              status_code=status.HTTP_400_bla_bla, detail="User Already Exist" 
            )
        
    11. @app.put("/api/posts/{post_id}",response_model=UpdatePost)
    12. @app.patch("/api/post/{post_id}",response_model=PatchPost)
    13. @app.delete("/api/post/{post_id}",status_code=status.HTTP_204_NO_CONTENT) # as of now anyone can delete
    14. async def -> Fastapi runs it directly with main event loop (More efficient, but must wait for I/O Operation, if we do blocking I/O without await then we block the Entire event loop)
    15. 
    ```  

1. [From 1:59:57 Adding Database Models and Relationships](https://youtu.be/iukOehU5aF4?si=e1q5iR8FRH8Esh1f&t=7192)

   ### SQLAlcamy in FastAPI

   * Create a different model/seperation approach.
   * ```uv add sqlalchemy```
   * ```database.py``` file, hold all db setup code and imported by main.py and models.py
  
   ### Database.py

   *

   ```python
   from sqlalchemy import create_engine
   from sqlalchemy.orm import DeclarativeBase, sessionmaker
   SQLALCHEMY_DATABASE_URL="sqllite:///./blog.db"
   engine=create_engine(
    SQLALCHEMY_DATABASE_URL,
    connect_args={"check_same_thread":False}, #Sql lite specific, SQL lite only allow 1 thread, but fastapi handles mutiple request accross threads
   )
   session_local=sessionmaker(autocommit=False,autoflush=False,bind=engine) #factory that creates db session, a session is a transaction with db.

   class Base(DeclarativeBase): 
    pass 
    
   def get_db():
    with session_local() as db:
      yield db
   ```

   * Create ```models.py```

    ```python
    from __future__ import annotations
    from datetime import UTC, datetime 
    from sqlalchemy import DateTime, ForeignKey, Integer, String, Text
    from sqlalchemy.orm import Mapped, mapped_column, relationship
    from database import Base

    class User(Base): 
      __tablename__="users"
      id:Mapped[int]=mapped_column(Integer, primary_key=True, index=True)
      username:Mapped[str]=mapped_column(String(50),unique=True, nullable=False)
      email:Mapped[str]=mapped_column(String(120),unique=True, nullable=False)
      image_file:Mapped[str|None]=mapped_column(
        String(200), nullable=True, default=None
      )
      posts:Mapped[list[Post]]=relationship(back_populates="author")

      @property
      def image_path(self)->str: 
        if self.image_file: 
          return f"/media/profile_pics/{self.image_file}"
        return "/static/profile_pics/default.jpg"
      
    class Post(Base):
      __tablename__="posts"
      id:Mapped[int]=mapped_column(Integer, primary_key=True, index=True)
      title:Mapped[str]=mapped_column(String(100),nullable=False)
      content:Mapped[str]=mapped_column(Text,nullable=False)
      user_id:Mapped[int]=mapped_column(ForeignKey("users.id"),nullable=False,index=True,)
      date_posted:Mapped[datetime]=mapped_column(DateTime(timezone=True),default=lambda:datetime.now(UTC),)
      author:Mapped[User]=relationship(back_populates="posts")
    ```

2. [3:37:35 SYNC Vs ASYNC](https://youtu.be/iukOehU5aF4?si=kqF2ADLc0TTHsSGL&t=13055)
   * Async -> Allows to handle multiple task concurrently (MC) I/O bound task
   * Sync -> Finish full first then move (Subway)
   * 
