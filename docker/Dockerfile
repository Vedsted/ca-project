FROM ubuntu:18.04
RUN apt-get update -y --no-cache=true
RUN apt-get install python3.6 python-pip -y
RUN pip install -r requirements.txt
CMD python3.6 run.py