# VERSION CONTROL
FROM python:3.7.7-slim-stretch
ENV NODE_VERSION=14
ENV ANGULAR_VERSION=11
# TODO: Figure out how to pass in versions through the ARG command and docker-compose.yml 
#       used in conjunction.

# COPY APPLICATION REQUIREMENTS
WORKDIR /home/
RUN mkdir /app && mkdir /frontend && mkdir /scripts
COPY /app/requirements.txt /home/app/requirements.txt
COPY /frontend/package.json /home/frontend/package.json

# INSTALL DEPENDENCIES
RUN apt-get update -y && apt-get install -y curl wait-for-it
WORKDIR /home/app/
RUN pip install -r requirements.txt
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs
WORKDIR /home/frontend/
RUN npm install -g @angular/cli@${ANGULAR_VERSION}
RUN npm install

# BUILD FRONTEND
WORKDIR /home/frontend
COPY /frontend /home/frontend 
RUN ng config -g cli.warnings.versionMismatch false && ng build --prod --output-hashing none

# BUILD BACKEND 
COPY /app /home/app 
COPY /scripts /home/scripts
WORKDIR /home/app
RUN python debug.py
RUN python manage.py collectstatic --noinput

# BOOTSTRAP
EXPOSE 8000
WORKDIR /home/scripts/
CMD ["bash", "./bootstrap.sh", "container"]