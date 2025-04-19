#!/bin/bash

# 🔧 Configuration
JMETER_VERSION="5.6.3"
JMETER_DIR="/opt/jmeter"
JMETER_TGZ="apache-jmeter-${JMETER_VERSION}.tgz"
JMETER_URL="https://downloads.apache.org//jmeter/binaries/${JMETER_TGZ}"

# 📁 Create directory if it doesn't exist
mkdir -p "$JMETER_DIR"
cd "$JMETER_DIR" || exit 1

# 🔽 Download JMeter
echo "Downloading JMeter ${JMETER_VERSION}..."
wget -q "$JMETER_URL"

# 📦 Extract JMeter
echo "Extracting JMeter..."
tar -xzf "$JMETER_TGZ"

# ✅ Set permissions (optional in Docker)
chmod -R 755 "$JMETER_DIR/apache-jmeter-${JMETER_VERSION}"

# 🧹 Cleanup
rm -f "$JMETER_TGZ"

# ✅ Done
echo "JMeter installed at $JMETER_DIR/apache-jmeter-${JMETER_VERSION}"
