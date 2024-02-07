FROM --platform=linux/amd64 cm2network/steamcmd:root

LABEL Author="NewittAll - https://github.com/NewittAll"
LABEL Version="1.0"
LABEL Description="A modded PalWorld server using Proton based on peeopturtle's upload https://github.com/peepoturtle/palworld-docker-proton-server"

# Install required programs
RUN apt-get update && apt-get install -y procps xdg-user-dirs wget unzip sed python3 libfreetype6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install supercronic 
RUN wget https://github.com/aptible/supercronic/releases/download/v0.2.29/supercronic-linux-amd64 \
    && echo "cd48d45c4b10f3f0bfdd3a57d054cd05ac96812b  supercronic-linux-amd64" | sha1sum -c - \
    && chmod +x supercronic-linux-amd64 \
    && mv supercronic-linux-amd64 "/usr/local/bin/supercronic-linux-amd64" \
    && ln -s "/usr/local/bin/supercronic-linux-amd64" /usr/local/bin/supercronic

# Install RCON
RUN wget https://github.com/gorcon/rcon-cli/releases/download/v0.10.3/rcon-0.10.3-amd64_linux.tar.gz \
    && echo "8601c70dcab2f90cd842c127f700e398 rcon-0.10.3-amd64_linux.tar.gz" | md5sum -c - \
    && tar xfz rcon-0.10.3-amd64_linux.tar.gz \
    && chmod +x "rcon-0.10.3-amd64_linux/rcon" \
    && mv "rcon-0.10.3-amd64_linux/rcon" "/usr/local/bin/rcon" \
    && ln -s "/usr/local/bin/rcon" /usr/local/bin/rconcli \
    && rm -Rf rcon-0.10.3-amd64_linux rcon-0.10.3-amd64_linux.tar.gz

# Install Proton
RUN mkdir -p /home/steam/.steam/steam/compatibilitytools.d/
RUN wget -O - https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton8-28/GE-Proton8-28.tar.gz \
    | tar -xz -C /home/steam/.steam/steam/compatibilitytools.d/
RUN mkdir -p /home/steam/.steam/steam/steamapps/compatdata/2394010 
RUN cp -r /home/steam/.steam/steam/compatibilitytools.d/GE-Proton8-28/files/share/default_pfx /home/steam/.steam/steam/steamapps/compatdata/2394010
RUN chown -R steam:steam /home/steam



# Setup directories
RUN mkdir -p /palworld/Scripts /palworld/Downloads /palworld/Backups \
    && chown -R steam:steam /palworld
# Declare enviorment variables
ENV STEAMCMD=/home/steam/steamcmd/steamcmd.sh \
    STEAM_COMPAT_DATA_PATH=/home/steam/.steam/steam/steamapps/compatdata/2394010 \
    PROTON=/home/steam/.steam/steam/compatibilitytools.d/GE-Proton8-28/proton \
    PUID=1000 \
    PGID=1000
VOLUME ["/palworld"]
USER steam
EXPOSE 8211/udp 25575/tcp

# Copy files over
COPY --chown=steam:steam --chmod=755 ./scripts/*.sh /palworld/Scripts
COPY --chown=steam:steam --chmod=755 /init.sh /
COPY --chown=steam:steam --chmod=440 rcon.yaml ./rcon.yaml
ADD --chown=steam:steam mods /palworld/Downloads
ADD --chown=steam:steam signatures /palworld/Downloads

ENTRYPOINT ["/palworld/Scripts/start.sh"]