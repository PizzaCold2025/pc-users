#!/usr/bin/env bash
set -euo pipefail

if [ $# -eq 0 ]; then
    functions=$(find functions -maxdepth 1 -mindepth 1 -exec basename {} \; \
        | sed 's/\.[^.]*$//' \
        | paste -sd ',' - \
        | sed 's/,/, /')

    echo "No function name given."
    echo "Available functions: $functions"
    exit 1
fi

BUILD_DIR="build"
bucket="$AWS_LAMBDA_ARTIFACTS_BUCKET"

function="$1"
out_zip="$function.zip"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo "Copying files..."
cp -r common "$BUILD_DIR"
cp "functions/$function.py"  "$BUILD_DIR/handler.py"

pip install -r requirements.txt -t "$BUILD_DIR"

echo "Zipping function..."
cd "$BUILD_DIR"
zip -r "$out_zip" . -x '*.pyc' -x '*__pycache__*'

echo ""
echo "Uploading to S3..."
aws s3 cp "$out_zip" "s3://$bucket/lambdas/users/$function.zip"
