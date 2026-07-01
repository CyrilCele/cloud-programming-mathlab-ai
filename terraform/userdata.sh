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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MathLab AI - AWS Deployment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #0f172a;
            color: white;
            text-align: center;
            padding-top: 80px;
        }
        .card {
            background: #1e293b;
            padding: 40px;
            margin: auto;
            width: 60%;
            border-radius: 12px;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>🚀 MathLab AI Deployed on AWS</h1>
        <p>Cloud Infrastructure Sprint 3 Complete</p>
        <p>Hosted on EC2 + Nginx</p>
    </div>
</body>
</html>
EOF