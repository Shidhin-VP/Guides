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
      * $${\color{orange}HTTPException}$$ from the FastAPI help us to raise HTTPExceptions (An Error Response)
      * $${\color{orange}Request}$$ let us access the incoming HTTP request itself, it's headers, URL, client information, body and other request details. 
      * $${\color{orange}Status}$$ is a collection of named HTTP status-code constants.
      * $${\color{orange}RequestValidationError}$$ helps us to validate wrong inputs/types from the client side
      * $${\color{orange}JSONResponse}$$ helps us to return a custom and explicit JSON response from the FASTAPI api
      * $${\color{orange}StaticFiles}$$ helps us to serve static files such as Images, CSS Files, JavaScript Files, HTML Files etc. This can be mainly used to when we use Templates
      * $${\color{orange}Jinja2Templates}$$ is used to render HTML pages using Jinja2templates, this also takes $${\color{orange}Request}$$ as a required input because the template can access the request related information, including URL generation.
      * $${\color{orange}HTTPException \space from \space \color{gold}Starlette}$$ can be used to defined unmanaged exceptions
