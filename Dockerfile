FROM ubuntu:14.04

#update OS
RUN sed -i 's/# \(.multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

#Install python
RUN apt-get install -y python-dev python-pip

RUN mkdir /webapp
ADD . /webapp
#Add requirements.txt
ADD requirements.txt /webapp

#Install uwsgi python web server
RUN pip install uwsgi


#Install app requirements
RUN pip install flask itsdangerous Jinja2 MarkupSafe Werkzeug

ENV HOME /webapp
WORKDIR /webapp


EXPOSE  8000


#execute app
ENTRYPOINT ["uwsgi", "--http", "0.0.0.0:8000", "--module", "app:app", "--processes", "1", "--threads", "8"]
