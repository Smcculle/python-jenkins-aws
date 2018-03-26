FROM frolvlad/alpine-python2

ENV APP_DIR /opt/python-jenkins-aws
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR
COPY . $APP_DIR
RUN pip install --no-cache-dir -r requirements.txt
RUN pip list 
