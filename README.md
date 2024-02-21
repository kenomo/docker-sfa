# NIST SFA in Docker

In a nutshell: brings the [NIST SFA](https://github.com/usnistgov/SFA) into a docker container.

## 🌟 Usage
- Get container `docker pull ghcr.io/kenomo/docker-sfa:5.06` from registry.
- Prepare a working folder:
```
├── data
│   ├── STEP-File-Analyzer-options.dat
│   ├── <file>.stp
```
- Run **sfa** on the data:
```
STEP_FILE=<file.stp>
docker run --rm \
    --mount type=bind,source=$(pwd)/data/,target=/root/data \
    ghcr.io/kenomo/docker-sfa:5.06 \
    bash -c "wine sfa-cl.exe /root/data/${STEP_FILE} csv noopen /root/data/STEP-File-Analyzer-options.dat"
```
- Artifacts will be in the mounted folder.

## 🏗 Build
> 🚨🚨🚨 Headless build is still WIP 🚨🚨🚨

- Build and run container for post-installation steps:
```
docker build -f sfa.Dockerfile --tag sfa .
docker run -p 8080:8080 --name sfa sfa:latest
```

- Connect via web browser to *novnc* `localhost:8080` and follow all graphical installation instructions.

- Copy `*.reg` files:
```
docker cp ./ifcsvr.CLSID.reg sfa:/root/
docker cp ./ifcsvr.Uninstall.reg sfa:/root/
```

- Get a `bash` in the container:
```
docker exec -it sfa bash
```
- Execute:
```
curl -O -L https://github.com/usnistgov/SFA/releases/download/v5.06/SFA-5.06.zip
unzip -o /root/SFA-5.06.zip
```

- Run once the sfa (follow the graphical installation instructions for the *IFCtoolkit*):
```
wine sfa-cl.exe nist_ctc_05.stp csv noopen
```

- Add additional registry keys for the ifc toolkit:
```
wine regedit /root/ifcsvr.Uninstall.reg
wine regedit /root/ifcsvr.CLSID.reg
```

- Close running shell, stop container, commit container, and push.