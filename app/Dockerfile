# Use a lightweight Python image as the container base
FROM python:3.13-slim

# Set the working directory in the container
WORKDIR /app

# Copy the dependancy list into the container
COPY requirements.txt .

# Install the Python packages needed by the application
RUN pip install --no-cache-dir -r requirements.txt

#Copy the FastAPI application code into the container
COPY main.py .
#Because WORKDIR /app is already set, this copies your local app/main.py into /app/main.py inside the container

#Document the port the FastAPI application listens on
EXPOSE 8000

#Start Uvicorn when the container runs
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]