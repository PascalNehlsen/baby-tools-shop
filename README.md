# Baby Tools Shop

Welcome to the **Baby Tools Shop** project! This repository contains a **Django** application designed for managing a baby tools e-commerce store. The project uses **Docker** to containerize the application and deploy it to a virtual machine (VM).

## Table of Contents

1. [Project Overview](#project-overview)
2. [Quickstart](#quickstart)
3. [Configuration](#configuration)
4. [Deploying with Docker](#deploying-with-docker)
5. [Hints](#hints)
6. [Contact](#contact)

## Project Overview

The **Baby Tools Shop** project is a Django-based web application that allows users to browse and purchase baby tools. The application is built with **Python** and **Django** and is designed to be easily containerized and deployed using **Docker**.

## Quickstart

To get started with the Baby Tools Shop, follow these steps:

1. **Set up your Python environment:**

   ```
   python -m venv your_environment_name
   ```

   - Creates a virtual environment: This command sets up an isolated Python environment in a folder named your_environment_name.
   - Prevents conflicts: It keeps your project dependencies separate from the global Python installation.
   - Allows easy package management: Each environment can have its own dependencies without affecting other projects.

2. **Activate the virtual environment:**

   ```
   your_environment_name\Scripts\activate
   ```

   - Activates the virtual environment: This command enables the virtual environment by switching the current shell to use its Python interpreter.
   - Prepares environment: It ensures any Python commands (e.g., installing packages) will be executed within the virtual environment, not in the global Python environment.
   - Windows-specific: This command is used for activating the virtual environment on Windows systems.

3. **Navigate to the project directory:**

   ```
   cd babyshop_app
   ```

   - Change directory: This command navigates into the babyshop_app folder.
   - Access project files: Moves to the directory where the project code, such as Django settings and app files, is located.

4. **Install Django:**

   ```
   python -m pip install Django
   ```

   - Installs Django: This command uses pip (Python's package manager) to download and install the Django framework.
   - Ensures Django is available: Makes Django available within the virtual environment for your project.
   - Fetches dependencies: Automatically installs any required dependencies for Django.

5. **Create a requirements.txt file:**

   ```
    pip freeze > requirements.txt
   ```

   - Generate requirements file: This command captures all the installed Python packages in your environment.
   - Creates requirements.txt: Saves the current package versions and dependencies into a requirements.txt file.
   - Facilitates future installations: Allows others (or you) to recreate the same environment by installing the exact dependencies listed.

6. **Apply migrations:**

   ```
    python manage.py migrate
   ```

   - Applies database migrations: This command updates the database schema based on your Django models.
   - Executes pending migrations: It applies any changes or new migrations that haven't been run yet.
   - Ensures database consistency: Syncs the database structure with the defined models in your Django application.

7. **Create a superuser:**

   ```
    python manage.py createsuperuser
   ```

   - Creates a superuser account: This command sets up an administrative user with full access to the Django admin panel.
   - Prompts for credentials: You will be asked to provide a username, email, and password for the superuser.
   - Grants admin privileges: The superuser can manage the entire application, including creating, updating, and deleting data.

8. **Run the development server:**

   ```
    python manage.py runserver
   ```

   - Starts the development server: This command launches Django’s built-in web server for local testing.
   - You can access the admin panel at http://<your_ip>:8000/admin
   - Enables live development: Allows you to make and test changes in real-time as you develop your application.

- Create products in the admin panel

## Configuration

1.  **Configure your environment:**
    Modify the **ALLOWED_HOSTS** setting in **settings.py** to include the domain names or IP addresses that will be used to access the application.

    ```
    ALLOWED_HOSTS = ['your_domain_or_ip']
    ```

    - Configures allowed hosts: This setting specifies which domain names or IP addresses are permitted to access your Django application.
    - Enhances security: It prevents HTTP Host header attacks by only allowing requests from specified hosts.
    - Set for production: Replace 'your_domain_or_ip' with your actual domain or server IP to make your site accessible.

2.  **Create Dockerfile:**

    ```
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
    ```

## Deploying with Docker

1.  **Copy the Project Folder to your VM**
2.  **Build the Docker image:**

    ```
    docker build -t app_name .
    ```

    - Builds a Docker image: This command creates a Docker image from the Dockerfile in the current directory.
    - Tags the image: -t app_name assigns the tag app_name to the image, which can be used for easy reference.
    - Prepares for deployment: The image contains the application and its dependencies, ready for running in a container.

3.  **Create Docker volumes:**

    ```
    docker volume create babyshop_db
    docker volume create babyshop_media
    docker volume create babyshop_static
    ```

    - Create Docker volumes: These commands create named volumes that can be used to persist data across Docker container restarts and re-creations.
    - babyshop_db: Volume for storing database data.
    - babyshop_media: Volume for storing user-uploaded media files.
    - babyshop_static: Volume for storing static files like CSS and JS.
    - Ensures data persistence: Keeps your application data safe and accessible even if containers are removed or recreated.

4.  **Run the Docker container:**

    ```
    docker run -d --name babyshop_app_container \
    -p 8025:8025 \
    -v babyshop_db:/app/babyshop_app/db \
    -v babyshop_media:/app/babyshop_app/media \
    -v babyshop_static:/app/babyshop_app/static \
    --restart on-failure \
    app_name
    ```

    - Run a Docker container: This command starts a new container from the Docker image named app_name.
    - Detach mode (-d): Runs the container in the background.
    - Name the container (--name babyshop_app_container): Assigns the name babyshop_app_container to the running container for easier management.
    - Port mapping (-p 8025:8025): Maps port 8025 on the host to port 8025 in the container, making the app accessible via port 8025.
    - Mount volumes (-v):

      - babyshop_db:/app/babyshop_app/db: Maps the babyshop_db volume to the container’s database directory.
      - babyshop_media:/app/babyshop_app/media: Maps the babyshop_media volume to the container’s media directory.
      - babyshop_static:/app/babyshop_app/static: Maps the babyshop_static volume to the container’s static files directory.

    - Restart policy (--restart on-failure): Automatically restarts the container if it fails, but not if stopped manually.

    - You can access your app at http://<vm_ip>:8025/
    - You can access your app at http://<vm_ip>:8025/admin

## Hints

This section will cover some hot tips when trying to interacting with this repository:

- Settings & Configuration for Django can be found in `babyshop_app/babyshop/settings.py`
- Routing: Routing information, such as available routes can be found from any `urls.py` file in `babyshop_app` and corresponding subdirectories

## Photos

##### Home Page with login

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080815407.jpg"></img>

##### Home Page with filter

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080840305.jpg"></img>

##### Product Detail Page

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080934541.jpg"></img>

##### Home Page with no login

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080953570.jpg"></img>

##### Register Page

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081016022.jpg"></img>

##### Login Page

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081044867.jpg"></img>

## Contact

- Pascal Nehlsen - [LinkedIn](https://www.linkedin.com/in/pascal-nehlsen) - [mail@pascal-nehlsen.de](mailto:mail@pascal-nehlsen.de)
- Project Link: [https://github.com/PascalNehlsen/baby-tools-shop](https://github.com/PascalNehlsen/baby-tools-shop)
