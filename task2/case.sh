#!/bin/bash

if [ "$1" == "-u" ]; then
    echo "$2" | tr '[:lower:]' '[:upper:]'
elif [ "$1" == "-l" ]; then
    echo "$2" | tr '[:upper:]' '[:lower:]'
else
    echo "Ошибка: Используйте -u или -l."
fi
