# electrumx

Docker container for latest stable ElectrumX based on Debian Buster / Python 3.8 that pulls the current source from GitHub. ElectrumX has been in flux and the code changes frequently - If you want to pull a particular version uncomment and adjust the appropriate line in the Dockerfile. 

You must be running this container and bitcoind in another container on a user-defined Docker network (*not* the default bridge) so they can communicate or else have bitcoind running on a separate machine (different host IP) - this is a Docker DNS limitation.

A docker-compose.yml is included for a simple private server.

**Requirements for SSL:**

You must have SSL keys in the data directory (persistent volume). You can use your own keys or generate self-signed keys with the following command:

`openssl req -newkey rsa:2048 -sha256 -nodes -x509 -days 365 -subj "/O=ElectrumX" -keyout electrumx.key -out electrumx.crt`

Be sure to make backups of these keys - if you restart ElectrumX with different self-signed keys then clients who have already connected using previous keys will *not* be able to reconnect.

**Configuration notes:**

1. The environment variables should all point to 0.0.0.0, *not* localhost to work in a Docker container since the container IP is dynamic and localhost points to the host.
2. I have not been able to get websockets to work properly with Docker - use SSL/TCP 
3. See [ElectrumX environment variables](https://electrumx.readthedocs.io/en/latest/environment.html) for more options. 
