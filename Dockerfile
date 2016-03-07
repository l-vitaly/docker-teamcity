FROM ubuntu:15.10

MAINTAINER Vitaly Lobchuk <vn.lobchuk@gmail.com>

RUN apt-get update
RUN apt-get install -y --no-install-recommends openjdk-7-jre-headless wget

# TeamCity data is stored in a volume to facilitate container upgrade
VOLUME  ["/data/teamcity"]

ENV TEAMCITY_DATA_PATH /data/teamcity

# Download and install TeamCity to /opt
ENV TEAMCITY_PACKAGE TeamCity-9.1.6.tar.gz
ENV TEAMCITY_DOWNLOAD http://download.jetbrains.com/teamcity
RUN wget $TEAMCITY_DOWNLOAD/$TEAMCITY_PACKAGE && \
    tar zxf $TEAMCITY_PACKAGE -C /opt && \
    rm -rf $TEAMCITY_PACKAGE

EXPOSE 8111

CMD ["/opt/TeamCity/bin/teamcity-server.sh", "run"]