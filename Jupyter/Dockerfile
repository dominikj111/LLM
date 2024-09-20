FROM debian:latest

ARG CENV
ARG CTZ
ARG CLOCALE
ARG GITEMAIL
ARG GITNAME

RUN apt-get update -y
RUN apt-get upgrade -y

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

RUN apt-get install -y neovim sudo curl wget git make coreutils unzip htop
RUN apt-get install -y python3 python3-pip python3-venv

RUN git config --global user.email "${GITEMAIL}"
RUN git config --global user.name "${GITNAME}"

###############
# APT CLEANUP #
###############

RUN if [ "$CENV" != "development" ]; then \
apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && apt-get purge -y; fi

##############
# ENTRYPOINT #
##############

ENTRYPOINT ["/root/install/entrypoint.sh"]
