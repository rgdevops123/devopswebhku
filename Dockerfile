# Get the latest OS image.
FROM rgdevops123/rgcentos7.6

# Set the working directory.
ARG APPDIR="/devopswebhku/"
WORKDIR ${APPDIR}

# Set the FLASK_APP environment variable.
ENV FLASK_APP devopswebhku.py

# Copy over the application files.
COPY config.py devopswebhku.py requirements.txt .env ${APPDIR}
COPY app app
COPY migrations migrations
COPY tests_pytests tests_pytests
COPY tests_unittests tests_unittests

# Install dependencies.
RUN pip3 install --no-cache-dir -q -r requirements.txt

# Run the image as a non-root user.
RUN groupadd -g 1000 appuser && \
    useradd -r -u 1000 -g appuser appuser
RUN chown -R appuser:appuser ${APPDIR}
USER appuser

# Expose is NOT supported by Heroku
# EXPOSE 5000 

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
CMD gunicorn --bind 0.0.0.0:$PORT devopswebhku:app
