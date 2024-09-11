# Use an official Python image as the base
FROM python:3.12.5

# Set the working directory inside the container
WORKDIR /app

# Copy only the requirements file and install dependencies
COPY requirements.txt /app/
RUN python -m pip install --no-cache-dir -r requirements.txt

# Now copy the rest of the app
COPY . /app

# Change to the app directory and run database migrations
WORKDIR /app/babyshop_app
RUN python manage.py migrate

EXPOSE 8025

# This is the command that will be executed on container launch
ENTRYPOINT ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8025"]
