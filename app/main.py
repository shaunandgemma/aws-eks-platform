#Import the FastAPI framework
from fastapi import FastAPI
# Import os so the app can read environment variables
import os


# Read APP_ENV from outside the app; use "local" if nothing is supplied
APP_ENV = os.getenv("APP_ENV", "local")

# Create the FastAPI web application object
app = FastAPI()  # This is the main application that Uvicorn will run and that our API routes attach to

# Return a simple response from the application root
#@app.get("/") tells FastAPI to run read_root() whenever someone sends an HTTP GET request to /
@app.get("/")  # API endpoint (route) for GET requests to /
def read_root():  # Function that runs when the / endpoint is requested
    return {
        "message": "AWS EKS Platform API is running",
        "environment": APP_ENV
    }

# Provide a simple health check for Kubernetes and load balancers
@app.get("/health") # API endpoint (or routes)
def health_check(): # This is the function that runs when the endpoint is requested
    return {"status": "healthy"} # Sends a small JSON response back to whoever called /health

