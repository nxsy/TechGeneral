FROM ubuntu:14.04

# Update packages
RUN apt-get update -y

# Install Python Setuptools
RUN apt-get install -y git nginx python

ADD . /src

# Expose
EXPOSE 80

# Run
CMD ["/src/scripts/elastic-beanstalk/once-off.sh", "/usr/share/nginx/html"]
