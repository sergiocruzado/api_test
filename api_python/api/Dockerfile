FROM python:3.8-slim-buster

EXPOSE 5000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
ADD requirements.txt .
RUN python -m pip install -r requirements.txt


WORKDIR /api
ADD ./rest /api/rest
ADD ./requirements.txt /api
ADD ./Makefile /api

# Switching to a non-root user
RUN apt-get update && apt-get install make && useradd appuser && chown -R appuser /api && mkdir /var/log/api && chown -R appuser /var/log/api
USER appuser

CMD ["run"]
ENTRYPOINT [ "make" ]