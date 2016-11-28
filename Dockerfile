FROM alpine

#Set up basic flask environment
RUN apk add --no-cache bash uwsgi uwsgi-python py-pip \
	&& pip install --upgrade pip 

# application folder
ENV APP_DIR /webapp

ADD . /webapp

#Add requirements.txt
ADD requirements.txt /webapp

WORKDIR /webapp
#Install app requirements
RUN pip install -r requirements.txt

ENV HOME /webapp

EXPOSE  8000


#execute app
ENTRYPOINT ["uwsgi", "--http", "0.0.0.0:8000", "--module", "app:simpleapp", "--processes", "1", "--threads", "8"]
