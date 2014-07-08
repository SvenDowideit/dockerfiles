#
# docker build -t xfce .

FROM xrdp

RUN apt-get install -yq xfdesktop4
RUN apt-get install -yq xfce4-panel
RUN apt-get install -yq xfwm4 thunar

ADD xsession /home/dockerx/.xsession
