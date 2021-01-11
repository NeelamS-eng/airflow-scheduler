FROM python:3.8

ARG AIRFLOW_VERSION=2.0.0

ENV AIRFLOW_HOME=/usr/local/airflow

ENV AIRFLOW__CORE__SQL_ALCHEMY_CONN=postgresql+psycopg2://airflow:airflow@postgresql:5432/airflow

ENV SLUGIFY_USES_TEXT_UNIDECODE=yes

ENV USER=airflow USER_ID=1001

RUN useradd -ms /bin/bash -d ${AIRFLOW_HOME} --uid ${USER_ID} airflow 

RUN pip install --no-cache-dir apache-airflow['crypto','kubernetes','postgres']==${AIRFLOW_VERSION}

COPY ./scripts/entrypoint.sh /entrypoint.sh

COPY ./dags /opt/airflow/dags

#RUN chown -R airflow: ${AIRFLOW_HOME}
RUN chmod -R 777 ${AIRFLOW_HOME}

USER ${USER_ID}
WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]
