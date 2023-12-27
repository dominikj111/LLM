FROM debian:latest

ARG CENV
ARG CTZ
ARG CLOCALE
ARG GITEMAIL
ARG GITNAME

WORKDIR /root

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

# Miniconda 3 installation
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash ./Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3

# Miniconda 3 activation
RUN echo ". /opt/miniconda3/etc/profile.d/conda.sh" >> /root/.bashrc
RUN echo "conda activate base" >> /root/.bashrc

# Jupyter, JupyterLab installation
RUN /opt/miniconda3/bin/conda install -c conda-forge jupyter jupyterlab -y

# Initialize the stable-diffusion-webui
RUN apt-get install -y libgl1 libglib2.0-0 google-perftools
RUN useradd -s /bin/bash -d /home/sdwui/ -m -G sudo sdwui
RUN echo "sdwui:password" | chpasswd
RUN echo ". /opt/miniconda3/etc/profile.d/conda.sh" >> /home/sdwui/.bashrc

###############
# APT CLEANUP #
###############

RUN if [ "$CENV" != "development" ]; then \
apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && apt-get purge -y; fi

WORKDIR /home/sdwui
USER sdwui
ENTRYPOINT /bin/bash /home/sdwui/scripts/entrypoint.sh
