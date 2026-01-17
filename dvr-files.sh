#!/opt/homebrew/opt/bash/bin/bash

SOURCE_PATH="$HOME/Downloads/dvr/"
DESTINATION_PATH="$HOME/Documents/Drone/Analog DVR"

LAST_FILE_NUMBER=$(ls -l "$DESTINATION_PATH" | awk 'END { print $9 }' | cut -c 5-8)

if [ -d "$SOURCE_PATH" ]; then
    if [ "$(ls -A "$SOURCE_PATH")" ]; then
        echo "Moving files from $SOURCE_PATH to $DESTINATION_PATH . . ."
    else
        echo "Warning: no files found in the $SOURCE_PATH"
        echo "Aborting . . ."
        exit 1
    fi
else
    echo "Error: $(basename "$SOURCE_PATH")/ folder not found in $(dirname "$SOURCE_PATH")."
    echo "Aborting . . ."
    exit 1
fi

TOTAL_FILES=0

for FILE_PATH in "$HOME/Downloads/dvr/"*; do
    TOTAL_FILES=$((10#$TOTAL_FILES + 1))

    FILE_NAME=$(basename "$FILE_PATH")

    PREFIX=${FILE_NAME%%[0-9]*}

    FILE_NUMBER=${FILE_NAME%.*}
    FILE_NUMBER=${FILE_NUMBER##*[!0-9]}

    EXTENSION=${FILE_NAME##*.}

    NEW_FILE_NUMBER=$((10#$LAST_FILE_NUMBER + 10#$FILE_NUMBER))
    PADDED_NEW_FILE_NUMBER=$(printf "%04d" $NEW_FILE_NUMBER)

    NEW_FILE_NAME="${PREFIX}${PADDED_NEW_FILE_NUMBER}.${EXTENSION}"

    mv "$FILE_PATH" "$DESTINATION_PATH/$NEW_FILE_NAME"
done

echo "Moved $TOTAL_FILES file(s) from $SOURCE_PATH to $DESTINATION_PATH"
