#!/bin/bash

FILE="server.jar"
if [ ! -f "$FILE" ]; then
    echo "$FILE does not exist in, moving..."
    echo "eula=true" > ./eula.txt
    cp ../$FILE .
fi
exec java -Xmx6G -Xms6G -jar $FILE nogui
