# Local Container Test

## Test Objective

- Verify that the FastAPI application can run locally inside a Docker container, respond correctly to HTTP requests, expose a working health endpoint, and accept configuration through environment variables

## Components Tested

- FastAPI application
- Uvicorn web server
- Docker image build
- Docker container runtime
- Port mapping from host port 8000 to container port 8000
- `/` API endpoint
- `/health` API endpoint
- `APP_ENV` environment variable

## Test Commands

- `uvicorn app.main:app --reload`
- `docker build -t aws-eks-platform-app:local .\app`
- `docker run --rm -p 8000:8000 --name aws-eks-platform-app aws-eks-platform-app:local`
- `Invoke-RestMethod http://127.0.0.1:8000/health`
- `docker run --rm -p 8000:8000 -e APP_ENV=container --name aws-eks-platform-app aws-eks-platform-app:local`
- `Invoke-RestMethod http://127.0.0.1:8000/`

## Expected Results

- FastAPI starts successfully with Uvicorn
- Docker image builds without errors
- Docker container starts successfully
- Host port 8000 reaches container port 8000
- `/health` returns `{"status":"healthy"}`
- `/` returns the application message
- `APP_ENV=container` overrides the default `local` value

## Actual Results

- FastAPI started successfully with Uvicorn
- Docker image built successfully after correcting the `--no-cache-dir` option
- Docker container started successfully
- Host port 8000 successfully reached container port 8000
- `/health` returned `healthy`
- `/` returned the expected application message
- `APP_ENV=container` successfully replaced the default `local` value

## Issues Found

- Docker image build initially failed because `pip install` used `-no-cache-dir` instead of the correct `--no-cache-dir`
- Local API test initially used `127.0.0.0` instead of the correct loopback address `127.0.0.1`

## Resolution

- Corrected the Dockerfile to use `pip install --no-cache-dir -r requirements.txt`
- Rebuilt the Docker image successfully
- Corrected the local test address from `127.0.0.0` to `127.0.0.1`
- Re-ran the health and root endpoint tests successfully

## Final Status

PASS — The FastAPI application successfully runs inside a Docker container, responds on `/` and `/health`, and accepts external configuration through the `APP_ENV` environment variable.