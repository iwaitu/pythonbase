FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    apt-utils \
    vim \
    git \
    xvfb \
    wget \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libgbm1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libu2f-udev \
    libvulkan1 \
    libxcomposite1 \
    libxdamage1 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils \
    curl \
    zip \
    gnupg

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV PATH="/root/miniconda3/bin:${PATH}"
RUN conda init && conda config --set always_yes yes --set changeps1 no
RUN conda --version


# RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
# RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
# RUN apt-get update && apt-get install -y chromium

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*
RUN apt-get install -f

# Download the latest version of ChromeDriver
RUN curl -SLO "https://chromedriver.storage.googleapis.com/`curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip"
# Unzip the ChromeDriver archive
RUN unzip chromedriver_linux64.zip -d /usr/local/bin
# Clean up the installation files
RUN rm chromedriver_linux64.zip
# Set the PATH environment variable so that the system can find the ChromeDriver executable
ENV PATH /usr/local/bin:$PATH
