#!/bin/bash
set -euo pipefail

docker run -it --rm --pid container:app_secure --privileged alpine sh
