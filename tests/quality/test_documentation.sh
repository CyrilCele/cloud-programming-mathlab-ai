for file in "${PROJECT_ROOT}/README.md" "${PROJECT_ROOT}/docs/ARCHITECTURE.md" "${PROJECT_ROOT}/docs/DEPLOYMENT.md"; do
  if [ -s "$file" ]; then
    echo "PASS: $file exists and is not empty."
  else
    echo "FAIL: $file is missing or empty!"
    exit 1
  fi
done
