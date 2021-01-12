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
ADD . /api

# Switching to a non-root user
RUN useradd appuser && chown -R appuser /api
USER appuser

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "rest.main:api"]
