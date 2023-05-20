# Use the official CUDA and Python base image
FROM nvidia/cuda:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file
COPY requirements.txt .

# Install the required dependencies
RUN apt-get update && \
    apt-get install -y python3.10 python3.10-dev python3.10-distutils && \
    ln -s /usr/bin/python3.10 /usr/local/bin/python

# Install pip for Python 3.10
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application files to the container
COPY . .

# Expose the port used by the Flask application
EXPOSE 5000

# Start the Flask application with gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
