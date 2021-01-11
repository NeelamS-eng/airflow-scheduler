from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta
from airflow.operators.http_operator import SimpleHttpOperator

# Default arguments that get included in all operators (see below)
default_args = {
    'owner': 'airflow',
    'retries': 3,
    'retry_delay': timedelta(seconds=30)
}

# DAG object: https://airflow.readthedocs.io/en/stable/_api/airflow/models/dag/index.html
dag = DAG(
    dag_id='my_dag',
    description='Just an example DAG',
    start_date=datetime(2021, 1, 8),
    schedule_interval='0/5 * * * *',
    catchup=False,
    default_args=default_args
)

# Operators: https://airflow.apache.org/docs/stable/_api/airflow/operators/index.html
task_1 = BashOperator(
    task_id='echo_task1',
    bash_command='echo "Hello from task_1"',
    dag=dag
)

task_2 = BashOperator(
    task_id='echo_task2',
    bash_command='echo "Hello from task_2"',
    dag=dag
)

task_1 >> task_2
