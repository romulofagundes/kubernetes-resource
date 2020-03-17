FROM gliderlabs/alpine:3.7

WORKDIR /tmp

RUN apk add --no-cache curl bash jq python py-pip \
 && pip install awscli \
 && curl -sL https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && curl -sL https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator -o /usr/local/bin/aws-iam-authenticator \
 && chmod +x /usr/local/bin/aws-iam-authenticator

COPY ./assets/check /opt/resource/check
COPY ./assets/in    /opt/resource/in
COPY ./assets/out   /opt/resource/out

RUN chmod +x /opt/resource/out /opt/resource/in /opt/resource/check
