# lightweight python instance
FROM frolvlad/alpine-python2

# set up environment
ENV APP_DIR /opt/python-jenkins-aws
ENV REP_DIR $APP_DIR/test-reports
RUN mkdir -p $REP_DIR
WORKDIR $APP_DIR
COPY . $APP_DIR

# Dependencies 
RUN pip install --no-cache-dir -r requirements.txt
RUN pip list 
