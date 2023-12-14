FROM debian:latest

ARG CENV
ARG CTZ
ARG CLOCALE
ARG GITEMAIL
ARG GITNAME

WORKDIR /root

RUN apt-get -y update

##################################
# LOCALES/TIMEZONE CONFIGURATION #
##################################

RUN apt-get install -y locales

ENV TZ=${CTZ}
RUN ln -snf /usr/share/zoneinfo/${CTZ} /etc/localtime && echo ${CTZ} > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

ENV LC_ALL=${CLOCALE}
ENV LANG=${CLOCALE}
ENV LANGUAGE=${CLOCALE}
RUN sed -i "/${CLOCALE}/s/^#\s//g" /etc/locale.gen
RUN locale-gen
RUN update-locale

#################################
# DEV TOOLCHAIN & CONFIGURATION #
#################################

RUN apt-get install -y vim sudo curl git make coreutils unzip

RUN git config --global user.email "${GITEMAIL}"
RUN git config --global user.name "${GITNAME}"

#####################
# UPGRADE & CLEANUP #
#####################

RUN if [ "${CENV}" != "development" ] ; then apt-get upgrade -y; fi
RUN if [ "${CENV}" != "development" ] ; then apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*; fi
