FROM public.ecr.aws/lambda/python:3.13

COPY requirements.txt ${LAMBDA_TASK_ROOT}
RUN pip install -r requirements.txt

ARG FUNCTION

COPY functions/${FUNCTION}.py ${LAMBDA_TASK_ROOT}/app.py
COPY common ${LAMBDA_TASK_ROOT}/common

CMD ["app.handler"]
