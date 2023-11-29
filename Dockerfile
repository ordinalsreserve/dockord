# Base image
FROM ubuntu:latest

ARG VERSION=0.12.0

# Create the user bitcoin and give it sudo capabilities
RUN apt update -y && apt install -y sudo software-properties-common curl tar git build-essential libtool autotools-dev autoconf libssl-dev libboost-all-dev

# Run the script to install 'ord' binary
RUN curl --proto '=https' --tlsv1.2 -fsLS https://ordinals.com/install.sh | bash -s

# Create a new user
RUN adduser --disabled-password --gecos '' myuser

# Create a new directory
RUN mkdir /workdir

# Change ownership to the new user
RUN chown me:me /workdir

# Change permissions
RUN chmod 700 /workdir

# REST interface
EXPOSE 8080

CMD ["ord", "--data-dir", "/index-data", "server", "--http-port=8080"]
