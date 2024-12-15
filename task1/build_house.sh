#!/bin/bash

# Создаем директорию "House"
mkdir House

# Создаем первый этаж с двумя комнатами
mkdir House/Floor1
mkdir House/Floor1/Kitchen
mkdir House/Floor1/LivingRoom

# Добавляем мебель в кухню
mkdir House/Floor1/Kitchen/Fridge
echo -e "Milk\nBread\nEggs" > House/Floor1/Kitchen/Fridge/grocery_list.txt

# Добавляем мебель в гостиную
touch House/Floor1/LivingRoom/Sofa
touch House/Floor1/LivingRoom/Television

# Создаем второй этаж с одной комнатой
mkdir House/Floor2
mkdir House/Floor2/Bedroom

# Добавляем мебель в спальню
touch House/Floor2/Bedroom/Bed
touch House/Floor2/Bedroom/Wardrobe
