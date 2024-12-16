#!/bin/bash

# Создаем директорию terminal_task/results
mkdir -p terminal_task/results

# Переходим в директорию data и загружаем файл
mkdir -p data
cd data

echo "Загружаем файл аннотации генома человека..."
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_41/gencode.v41.basic.annotation.gff3.gz

echo "Распаковываем файл..."
gunzip gencode.v41.basic.annotation.gff3.gz

cd ..

# Определяем пути к входному и выходному файлам
INPUT_FILE="data/gencode.v41.basic.annotation.gff3"
OUTPUT_FILE="terminal_task/results/result.tsv"

echo "Обрабатываем файл аннотации..."

# Шаг 1: Отфильтровываем строки и оставляем нужные столбцы
awk '
BEGIN { FS="\t"; OFS="\t" }
# Пропускаем строки с комментариями
/^#/ { next }
# Оставляем строки, где в 3 колонке значение "gene"
$3 == "gene" {
    # Проверяем, содержит ли 9 колонка "gene_type=unprocessed_pseudogene"
    if ($9 ~ /gene_type=unprocessed_pseudogene/) {
        # Извлекаем gene_name из 9 колонки
        match($9, /gene_name=([^;]+)/, arr)
        gene_name = arr[1]
        # Выводим нужные столбцы: 1, 4, 5, 7 и gene_name
        print $1, $4, $5, $7, gene_name
    }
}
' "$INPUT_FILE" > "$OUTPUT_FILE.tmp"

# Шаг 2: Модифицируем координаты в зависимости от цепи
awk '
BEGIN { FS="\t"; OFS="\t" }
{
    chrom = $1
    start = $2
    end = $3
    strand = $4
    gene_name = $5

    if (strand == "+") {
        end = start + 1
    } else if (strand == "-") {
        start = end
        end = end + 1
    }

    print chrom, start, end, strand, gene_name
}
' "$OUTPUT_FILE.tmp" > "$OUTPUT_FILE"

# Удаляем временный файл
rm "$OUTPUT_FILE.tmp"

echo "Обработка завершена. Результат сохранен в $OUTPUT_FILE"
