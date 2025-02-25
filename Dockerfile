FROM ubuntu:18.04

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME
RUN useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
RUN cd ~ && mkdir workspace && cd workspace

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y gnupg
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
RUN chmod +x msfinstall
RUN ./msfinstall
RUN su user -c 'msfdb init'
RUN apt-get install -y autoconf
RUN apt-get install -y git
RUN apt-get install -y vim
RUN apt-get install -y htop
RUN apt-get install -y net-tools
RUN echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install wireshark
RUN apt-get install -y build-essential
RUN apt-get install -y libssh2-1-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y python3-pip
RUN apt-get install -y python3.6-venv
RUN apt-get install -y rust-all
RUN apt-get install -y automake
RUN apt-get install -y libtool
RUN apt-get install -y gettext
RUN apt-get install -y pkgconf
RUN apt-get install -y libpcre2-dev
RUN apt-get install -y unzip
RUN apt-get install -y wget
RUN apt-get install -y nmap
RUN apt-get install -y libproxychains4
RUN apt-get install -y proxychains4
RUN apt-get install -y nvidia-cuda-toolkit
RUN apt-get install -y nano
RUN apt-get install -y time
RUN apt-get install -y language-pack-en
RUN curl -o /usr/share/nmap/scripts/banner-plus.nse https://gist.githubusercontent.com/littleairmada/b04319742c29efe44d5662d842c20e1c/raw/c500449760e7a97f780d0b3627dac37823168a00/banner-plus.nse
RUN curl -o /usr/share/nmap/scripts/elasticsearch.nse https://raw.githubusercontent.com/theMiddleBlue/nmap-elasticsearch-nse/master/elasticsearch.nse
RUN cd ~/workspace && python3 -m pip install virtualenv
ADD deep_exploit deep_exploit
RUN cd deep_exploit && python3 -m venv virtualenv && . ./virtualenv/bin/activate && pip install setuptools-rust==1.1.2 wheel==0.37.1 && pip install -r requirements.txt
