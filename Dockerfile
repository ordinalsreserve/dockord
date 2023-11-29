# Base image
FROM ubuntu:latest

ARG VERSION=0.12.0

# Create the user bitcoin and give it sudo capabilities
RUN apt update -y && apt install -y sudo software-properties-common curl tar git build-essential libtool autotools-dev autoconf libssl-dev libboost-all-dev

# Run the script to install 'ord' binary
RUN curl --proto '=https' --tlsv1.2 -fsLS https://ordinals.com/install.sh | bash -s

RUN mkdir /workdir

ENTRYPOINT /workdir

# REST interface
EXPOSE 8080

CMD ["ord", "--data-dir", "/index-data", "server", "--http-port=8080"]
