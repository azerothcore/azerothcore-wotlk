FROM ubuntu:20.04

LABEL description="AC Worldserver Debug Container for use with Visual Studio"

# set timezone environment variable
ENV TZ=Etc/UTC

# set noninteractive mode so tzdata doesn't ask to set timezone on install
ENV DEBIAN_FRONTEND=noninteractive

# install the required dependencies to run the worldserver
RUN apt update && apt install -y libmysqlclient-dev libssl-dev libace-6.4.5 libace-dev libreadline-dev net-tools tzdata;

# install build dependencies to debug
RUN apt-get install -y gdb gdbserver openssh-server

# change timezone in container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# configure SSH for communication with Visual Studio
RUN mkdir -p /var/run/sshd

RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    passwd -d root && \
    echo "ssh" >> /etc/securetty

RUN mkdir -p /azerothcore
WORKDIR /azerothcore

CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22
