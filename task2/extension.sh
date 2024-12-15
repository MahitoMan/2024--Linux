#!/bin/bash

SUPPORTED_FORMATS=("txt" "pdf" "doc")

# Проверка количества аргументов
if [ $# -ne 3 ]; then
    echo "Ошибка: требуется 3 аргумента."
    echo "Использование: $0 путь_до_файла актуальное_расширение желаемое_расширение"
    exit 1
fi

FILE_PATH=$1
CURRENT_EXT=$2
DESIRED_EXT=$3

# Проверка поддерживаемых форматов
if [[ ! " ${SUPPORTED_FORMATS[@]} " =~ " $CURRENT_EXT " ]] || [[ ! " ${SUPPORTED_FORMATS[@]} " =~ " $DESIRED_EXT " ]]; then
    echo "Ошибка: неподдерживаемый формат."
    echo "Поддерживаемые форматы: ${SUPPORTED_FORMATS[@]}"
    exit 1
fi

# Проверка существования файла
if [ ! -f "$FILE_PATH" ]; then
    echo "Ошибка: файл не найден."
    exit 1
fi

# Проверка соответствия текущего расширения
EXTENSION="${FILE_PATH##*.}"
if [ "$EXTENSION" != "$CURRENT_EXT" ]; then
    echo "Ошибка: расширение файла не соответствует указанному текущему расширению."
    exit 1
fi

# Изменение расширения
NEW_FILE_PATH="${FILE_PATH%.*}.$DESIRED_EXT"
mv "$FILE_PATH" "$NEW_FILE_PATH"
echo "Расширение файла успешно изменено на .$DESIRED_EXT"
