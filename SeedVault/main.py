from fastapi import FastAPI, Request, HTTPException
import json
app = FastAPI()
# uvicorn main:app --reload
authkey = "Pc5yM5ebmfs3Cv7" # Temp Auth Key

@app.get("/register/{user}/{hostname}/{key}")
def read_root(key: str,hostname: str,user: str, request: Request):
    client_host = request.client.host
    if key != authkey: 
        raise HTTPException(status_code=404, detail="Invalid key.")
    else: 
        return {"client_host": client_host, "hostname": hostname, "user": user, "key": key}

@app.get("/destroy/{user}/{hostname}/{key}")
def read_root(key: str,hostname: str,user: str, request: Request):
    client_host = request.client.host
    if key != authkey: 
        raise HTTPException(status_code=404, detail="Invalid key.")
    else: 
        return {"client_host": client_host, "hostname": hostname, "user": user, "key": key}
