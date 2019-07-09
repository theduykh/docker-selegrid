FROM ubuntu:18.04

WORKDIR /app

COPY . /app

EXPOSE 4444

RUN ["chmod", "+x", "gridStart.sh"]
RUN ["chmod", "+x", "nodeconfig.json"]

RUN  apt-get update
RUN  apt-get install -y wget
RUN  apt-get install -y unzip
RUN  apt-get install -y tar

# download Selenium standalone
RUN wget --timeout=600 https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar

# download chromedriver
RUN wget --timeout=600 https://chromedriver.storage.googleapis.com/74.0.3729.6/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip && rm chromedriver_linux64.zip

# download geckodriver
RUN wget --timeout=600 https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz
RUN tar xvzf geckodriver-v0.24.0-linux64.tar.gz && rm geckodriver-v0.24.0-linux64.tar.gz

# install java jre
RUN  apt-get install -y software-properties-common
RUN  add-apt-repository -y ppa:webupd8team/java
RUN  apt-get update
RUN  apt install -y openjdk-8-jre-headless

# install Firefox
RUN apt -y install firefox

# install Google Chrome
RUN wget --timeout=600 https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install
RUN rm google-chrome-stable_current_amd64.deb

# set Java home
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre/bin

CMD ["sh","gridStart.sh"]