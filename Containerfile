FROM quay.io/fedora/fedora-bootc:latest
ADD etc etc
RUN dnf5 install -y 'dnf5-command(config-manager)'
RUN dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
RUN dnf config-manager addrepo --from-repofile=https://mise.jdx.dev/rpm/mise.repo
RUN dnf install -y \
  @workstation-product \
  @gnome-desktop \
  @hardware-support \
  @networkmanager-submodules \
  @printing \
  @development-tools \
  @container-management \
  firewalld \
  tailscale \
  fish \
  mise \
  distrobox && \
  dnf clean all
RUN systemctl enable tailscaled.service
RUN systemctl set-default graphical.target
RUN bootc container lint
