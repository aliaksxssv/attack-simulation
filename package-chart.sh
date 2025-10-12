#!/bin/bash

# Script to package and publish Helm chart to GitHub Pages
set -e

CHART_NAME="attack-simulation"
CHART_VERSION=$(grep '^version:' helm/Chart.yaml | awk '{print $2}')
PACKAGE_NAME="${CHART_NAME}-${CHART_VERSION}.tgz"

echo "📦 Packaging Helm chart: ${PACKAGE_NAME}"

# Package the chart
helm package helm/

echo "📋 Updating Helm repository index"

# Update the index.yaml for GitHub Pages
helm repo index . --url https://aliaksxssv.github.io/attack-simulation/

echo "✅ Chart packaged successfully!"
echo "📁 Files created:"
echo "   - ${PACKAGE_NAME}"
echo "   - index.yaml"

echo ""
echo "🚀 To publish to GitHub Pages:"
echo "   1. Copy ${PACKAGE_NAME} and index.yaml to gh-pages branch"
echo "   2. Push the changes"
echo ""
echo "📖 Users can then install with:"
echo "   helm repo add aliaksxssv https://aliaksxssv.github.io/attack-simulation/"
echo "   helm repo update"
echo "   helm install attack-simulation aliaksxssv/attack-simulation"
