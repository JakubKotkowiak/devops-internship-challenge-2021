#Builder
FROM python:3.8.5-alpine3.12 as builder
RUN mkdir /requirements
WORKDIR /usr/src/app

COPY /app/requirements.txt .

RUN pip install --prefix=/requirements -r requirements.txt


#Final version
FROM python:3.8.5-alpine3.12

ENV FLASK_APP=/project/flask-app.py

WORKDIR /project

COPY --from=builder /requirements /usr/local
ADD /app /project

EXPOSE 5001

ENTRYPOINT ["python"]

CMD ["flask-app.py"]
