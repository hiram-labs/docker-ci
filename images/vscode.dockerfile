FROM rust:slim-buster as builder

FROM codercom/code-server:latest

ENV APP_ROOT_PATH="/home/coder"
ENV PATH="${APP_ROOT_PATH}/.cargo/bin:${PATH}"
ENV DISABLE_TELEMETRY=true
ENV HASHED_PASSWORD=296aadcb309145f383be2be69a1f91b86ac4ea259365f60b168ce9ab82ec5a31

USER root

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash - && apt-get install -y gcc g++ make iputils-ping httpie nodejs python3-pip
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get autoclean && apt-get clean && apt-get autoremove
RUN apt-get install -y yarn && apt-get upgrade -y

# TODO:
# preinstalling extensions not working

# RUN code-server --install-extension ms-python.python
# RUN code-server --install-extension rust-lang.rust
# RUN code-server --install-extension dbaeumer.vscode-eslint
# RUN code-server --install-extension redhat.vscode-yaml
# RUN code-server --install-extension streetsidesoftware.code-spell-checker

COPY --from=builder /usr/local/rustup ${APP_ROOT_PATH}/.rustup
COPY --from=builder /usr/local/cargo ${APP_ROOT_PATH}/.cargo

RUN useradd appuser
USER appuser

WORKDIR ${APP_ROOT_PATH}/project
