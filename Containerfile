FROM quay.io/fedora/fedora-bootc:latest
ADD etc etc
RUN dnf5 -y install 'dnf5-command(config-manager)'
RUN dnf -y config-manager addrepo --from-repofile='https://pkgs.tailscale.com/stable/fedora/tailscale.repo'
RUN dnf -y config-manager addrepo --from-repofile='https://mise.jdx.dev/rpm/mise.repo'
RUN dnf -y install \
  @workstation-product \
  @gnome-desktop \
  @hardware-support \
  @networkmanager-submodules \
  @printing \
  @container-management \
  podman-docker \
  firewalld \
  fish \
  tailscale \
  mise
RUN dnf clean all
RUN systemctl enable tailscaled.service
RUN systemctl set-default graphical.target
RUN bootc container lint
