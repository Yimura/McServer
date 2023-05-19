#!/bin/bash

FILE="/opt/mc/server.jar"
exec java "-Xmx$MEM_ALLOCATION" "-Xms$MEM_ALLOCATION" -jar $FILE nogui
