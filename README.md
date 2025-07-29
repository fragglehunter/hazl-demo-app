Here’s a clear and concise `README.md` you can include with your repo to explain how to use the contents:

---

# Multi-Zone Demo App Deployment

This repository provides a simple example of deploying a demo application across multiple Kubernetes zones. It uses template-based deployment manifests for a backend and frontend, scoped to specific zones via node affinity and naming conventions.

## Files Overview

* `backend-deployment-template.yaml` – Deployment template for the API backend (`bb`).
* `frontend-deployment-template.yaml` – Deployment template for the frontend load generator (`fortio`) and diagnostics pod (`netshoot`).
* `namespace.yaml` – Namespace manifest.
* `service.yaml` – `api-service` Service manifest.
* `zones.env` – Defines the zones to deploy into.
* `deploy-hazl-demo-app.sh` – Script to render and generate the manifests per zone.
* `manifest/` – Output directory where rendered manifests will be saved.

## Prerequisites

* A Kubernetes cluster with nodes labeled by zone:

  ```
  kubectl get nodes --show-labels | grep topology.kubernetes.io/zone
  ```
* `kubectl` configured to access the cluster.
* `sed`, `bash`, and GNU utils installed locally.

## Setup Steps

1. **Configure the desired zones**
   Edit the `zones.env` file to define the zones you want to deploy into:

   ```bash
   ZONE_LIST='zone-a zone-b zone-c'
   ```

2. **Render the manifests**
   Run the provided script to generate per-zone deployment YAMLs:

   ```bash
   ./deploy-hazl-demo-app.sh
   ```

   This will create:

   * `manifest/api-backend-zone-a.yaml`, `...-zone-b.yaml`, etc.
   * `manifest/frontend-zone-a.yaml`, `...-zone-b.yaml`, etc.

3. **Deploy the application**
   Uncomment and modify the script if you'd like it to also apply the resources automatically. Or deploy them manually:

   ```bash
   kubectl apply -f namespace.yaml
   kubectl apply -f service.yaml
   kubectl apply -f manifest/
   ```

## What This Does

* Each **backend** pod will:

  * Be pinned to a specific zone using node affinity.
  * Respond with "Hello from zone-X" where X is the zone.
* Each **frontend** pod will:

  * Continuously send HTTP load to the backend service.
  * Run a `netshoot` pod for diagnostics.

## Notes

* The namespace is automatically annotated for Linkerd injection.
* Make sure your Kubernetes nodes are correctly labeled with the appropriate zone values for scheduling to succeed.

---

Let me know if you want a version with usage screenshots, a diagram, or if you’d like to convert this into a slide or wiki page format.

