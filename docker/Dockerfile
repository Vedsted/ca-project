FROM ubuntu:18.04
RUN apt-get update -y
RUN apt-get install python -y
RUN apt-get install python-pip -y
RUN pip install requests
ADD requirements.txt /application/requirements.txt
RUN pip install -r /application/requirements.txt
CMD python /application/run.py