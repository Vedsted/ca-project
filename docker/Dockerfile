FROM ubuntu:18.04
RUN apt-get update -y
RUN apt-get install python3.6 python-pip -y
ADD requirements.txt application/requirements.txt
RUN pip install -r application/requirements.txt
CMD python3.6 run.py