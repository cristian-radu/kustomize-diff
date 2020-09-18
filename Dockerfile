FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt update && apt install -y curl gnupg software-properties-common git

RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash &&\
    mv kustomize /usr/local/bin

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64 &&\
    add-apt-repository ppa:rmescandon/yq &&\
    apt update && apt install yq -y

COPY kustomize-diff /usr/local/bin

ARG USER_ID
ARG GROUP_ID
ARG USER_NAME

RUN addgroup --gid $GROUP_ID ap253631
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER_NAME
USER $USER_NAME
WORKDIR /home/$USER_NAME

ENTRYPOINT ["kustomize-diff"]