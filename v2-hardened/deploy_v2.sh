#!/bin/bash
set -euo pipefail
docker run -d \
	--name app_secure \
	--read-only \
	--cap-drop=ALL \
	--security-opt=no-new-privileges \
	--memory="128m" \
	--cpus=".5" \
	--tmpfs /app/logs:uid=65532,gid=65532,mode=1777 \
	-p 3000:3000 \
	app-v2
