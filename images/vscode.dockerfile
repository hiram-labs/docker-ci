FROM rust:slim-buster as builder

FROM codercom/code-server:latest

USER root

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash - && apt-get install -y gcc g++ make iputils-ping httpie nodejs python3-pip
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get autoclean && apt-get clean && apt-get autoremove
RUN apt-get install -y yarn && apt-get upgrade -y

RUN code-server --disable-telemetry --install-extension ms-python.python rust-lang.rust dbaeumer.vscode-eslint redhat.vscode-yaml streetsidesoftware.code-spell-checker

COPY --from=builder /usr/local/rustup /home/coder/.rustup
COPY --from=builder /usr/local/cargo /home/coder/.cargo

RUN useradd appuser
USER appuser

ENV PATH="/home/coder/.cargo/bin:${PATH}"
WORKDIR /home/coder/project

ENV HASHED_PASSWORD=296aadcb309145f383be2be69a1f91b86ac4ea259365f60b168ce9ab82ec5a31
