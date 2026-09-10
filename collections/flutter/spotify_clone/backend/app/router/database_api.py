from typing import Annotated

from fastapi import APIRouter, status, Depends
from fastapi.responses import JSONResponse
from sqlalchemy import delete
from sqlalchemy.orm import Session

from app.database import get_db
from app.models import User


router: APIRouter = APIRouter()


@router.delete(path="/remove_all_data", status_code=status.HTTP_204_NO_CONTENT)
def delete_all_data(db: Annotated[Session, Depends(get_db)]):
    db.execute(delete(User))
    db.commit()
    return JSONResponse(content="All data have been deleted from User's table")
