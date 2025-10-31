for file in functions/*; do
    function=$(basename "$file" | sed 's/\.[^.]*$//')
    echo "=============================="
    echo "Uploading $function..."
    echo "=============================="
    scripts/upload.sh "$function"
    echo ""
done
