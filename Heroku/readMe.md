# Instructions to Follow

## Login to Heroku
```
heroku login
```

## Create a new Heroku App
```
heroku create app-name
```

## Set environment variables (if needed)
```
heroku config:set Key=Value
```

## Organize
1. Procfile
2. requirements.txt
3. runtime.txt(optional)

## Example Procfile
```
web: uvicorn folder.main:app --host 0.0.0.0 --port $PORT
                        or 
web: uvicorn main:app --host 0.0.0.0 --port $PORT
```

## Commit Changes
```
git add .
git commit -m "Ready for Deploy"
```

## Deploy to Heroku
```
git push heroku main
```

## Open Live App
```
heroku open
```

## View logs for Debugging
```
heroku logs --tail
```

## Redeploy after Changes
```
git add . 
git commit -m "Updated Code"
git push heroku main
```

## Push to Github (Optional)
```
git push main 
    or
git push origin main
```