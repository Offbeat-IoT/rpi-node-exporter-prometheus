# C4 model fragment - Offbeat-IoT/rpi-node-exporter-prometheus
# Consumed by Offbeat-IoT/information/scripts/c4/build.py.

rpi_node_exporter_prometheus = softwareSystem "Raspberry Pi Metrics Exporters" "Exposes Raspberry Pi host and container metrics in Prometheus format. Its Jenkins pipeline starts the compose stack on every built-in, production, observability and build node." {
  tags "tooling"

  node_exporter = container "Node exporter" "Exposes host CPU, memory, filesystem, disk and network metrics read from /proc, /sys and the root filesystem on :9100." "Prometheus node-exporter"
  cadvisor = container "cAdvisor" "Exposes per-container resource usage and Docker labels from the local Docker daemon, published on :9200 as the cadvisor scrape job." "cAdvisor"
}
