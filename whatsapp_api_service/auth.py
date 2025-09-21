from fastapi import HTTPException, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
import os

security = HTTPBearer()

def verify_api_key(credentials: HTTPAuthorizationCredentials = Depends(security)):
    """API Key doğrulaması"""
    expected_api_key = os.getenv("API_KEY")
    
    if not expected_api_key:
        raise HTTPException(
            status_code=500,
            detail="API_KEY environment variable not configured"
        )
    
    if credentials.credentials != expected_api_key:
        raise HTTPException(
            status_code=401,
            detail="Invalid API key"
        )
    
    return credentials.credentials

# Alternative header-based authentication
from fastapi import Header

def verify_api_key_header(x_api_key: str = Header(...)):
    """X-API-Key header ile doğrulama"""
    expected_api_key = os.getenv("API_KEY")
    
    if not expected_api_key:
        raise HTTPException(
            status_code=500,
            detail="API_KEY environment variable not configured"
        )
    
    if x_api_key != expected_api_key:
        raise HTTPException(
            status_code=401,
            detail="Invalid API key"
        )
    
    return x_api_key