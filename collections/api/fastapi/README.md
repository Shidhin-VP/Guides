#

## Youtube

## Python FastAPI Tutorial: Full Course for Beginners - Build a Full-Stack Web App (Corey Schafer)
* Link to the [Video](https://youtu.be/iukOehU5aF4?si=ZnDb1-RiGgDOexKf)
1. Till [1:38:41](https://youtu.be/iukOehU5aF4?si=_gbjBIUVwR-aaTs5&t=5921)
   * Learned about importation: 
     * ```
        from fastapi import FASTAPI, HTTPException, Request, status
        from fastapi.exception import RequestValidationError
        from fastapi.response import JSONResponse
        from fastapi.staticfiles import StaticFiles
        from fastapi.templating import Jinja2Templates
        from startlette.exceptions import HTTPException as StartletteHTTPException
        ```
    * What those importation does. 
      * We need FASTAPI to create the fastapi instance, and this is the foundation
      * HTTPException from the FastAPI help us to raise HTTPExceptions (An Error Response)
      * <font color='orange'>Request</font> let us access the incoming HTTP request itself, it's headers, URL, client information, body and other request details. 
      * Status 
