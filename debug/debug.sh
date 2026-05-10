#!/bin/bash
set -euo pipefail

docker run -it --rm \
	--network container:app_secure \
	--pid container:app_secure \
	--cap-add=NET_ADMIN \
	alpine sh
