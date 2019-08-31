# Get the latest OS image.
FROM alpine:latest

# Set Maintainer.
LABEL maintainer "rgdevops123@gmail.com"

# Install python and pip
RUN apk add --no-cache --update python3 py3-pip bash

# Set the working directory.
ARG APPDIR="/devopswebhku/"
WORKDIR ${APPDIR}

# Set the FLASK_APP environment variable.
ENV FLASK_APP devopswebhku.py

# Copy over the application files.
COPY config.py devopswebhku.py requirements.txt ${APPDIR}
COPY app app
COPY migrations migrations
COPY tests_pytests tests_pytests
COPY tests_unittests tests_unittests

# Install dependencies.
RUN pip3 install --no-cache-dir -q -r requirements.txt

# Run the image as a non-root user.
RUN adduser -D appuser
RUN chown -R appuser:appuser ${APPDIR}
USER appuser

# Expose is NOT supported by Heroku
# EXPOSE 5000   

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku                        
CMD gunicorn --bind 0.0.0.0:$PORT devopswebhku:app
