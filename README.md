# rpi-node-exporter-prometheus
exposes raspberry pi metrics in prometheus format

## CI pipeline

This repository keeps a repository-local `Jenkinsfile` on purpose. Its job is a
compose fan-out across every Jenkins node, not a single stack target, so it does
not fit `stackRepoCiPipeline` (one stack, one target host). Moving it to the
shared flow would require a multi-host compose entry point.
