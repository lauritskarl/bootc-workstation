FROM quay.io/fedora/fedora-bootc:latest
ADD etc etc
RUN dnf5 -y install 'dnf5-command(config-manager)'
RUN dnf -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
RUN dnf -y config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
RUN dnf -y config-manager addrepo --from-repofile=https://mise.jdx.dev/rpm/mise.repo
RUN dnf -y install \
  @workstation-product \
  @gnome-desktop \
  @hardware-support \
  @networkmanager-submodules \
  @printing \
  @container-management \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin \
  firewalld \
  tailscale \
  fish \
  mise \
  distrobox
RUN dnf clean all
RUN systemctl enable \
  tailscaled.service \
  docker.socket
RUN systemctl set-default graphical.target
RUN bootc container lint
