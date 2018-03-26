FROM frolvlad/alpine-python2
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
