#!/bin/bash
###############################################################################
# MathLab AI Bootstrap Script
#
# Installs and configures Nginx.
# Website deployment will occur after the infrastructure is complete.
###############################################################################

set -euxo pipefail

dnf update -y
dnf install -y nginx git unzip

systemctl enable nginx
systemctl start nginx

mkdir -p /var/www/mathlab-ai

cat > /usr/share/nginx/html/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
<title>MathLab AI</title>
</head>
<body>
<h1>Infrastructure Successfully Deployed</h1>
<p>The production website will be deployed after the complete cloud architecture is provisioned.</p>
</body>
</html>
EOF