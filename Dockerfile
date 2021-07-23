# Define this base image
FROM python:stretch

# Copy files we want to run to the file system of the image
COPY . /app
WORKDIR /app

# Install pip and needed Python packages from requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# When the container starts it will run the app using Gunicorn as WSGI server
# Root directory contains a main.py who's WSGI function/callable/object is 'APP'
ENTRYPOINT ["gunicorn", "-b", ":8080", "main:APP"]