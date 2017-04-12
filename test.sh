
list_f(){
cd c:temp
ls -1 > /cygdrive/c/list_file.txt
}

remove_spaces(){
remove_spaces_string=$(echo $1 | sed 's/ /_/g')
}

rename_file(){
cd c:temp

mv $1 $(echo $2 | tr -d '\r').html

echo "Файл"  $1 "преименован в " $(echo $2 | tr -d '\r')".html"
echo ""
}
 
find_d(){
cd c:temp
tmpIFS=$IFS; IFS='\n'
find_string1=$(head "/cygdrive/c/1_string.txt" -n $1 | tail -n 1)
find_file1=$(pwd)/$(head "/cygdrive/c/list_file.txt" -n $2 | tail -n 1)

result_f=$(cat $find_file1  | sed -e :a -e 's/<[^>]*>//g;/</N;//ba' | grep "$find_string1" | sed 's/ИСПРАВЛЕНИЕ N - от -/ /g' |  tr -d '/' | sort -u)

#echo $result_f
IFS=$tmpIFS
}

funk1(){
cd c:temp
list_f
file_quantity=$(ls | wc -l)
#echo $file_quantity
while [ "$file_quantity" -ge 1 ] 
do
find_d $1 $file_quantity
remove_spaces "$result_f"

long_name_file=$(echo $remove_spaces_string | wc -m)
#echo $long_name_file

if [ $long_name_file -ge 2 ]
then
#if [ "$1" -eq 4 ] # залепить проверку варинта
#then
#echo $1 "поиск и переименование актов выполненных работ (оказанных услуг"
#fi
#cut -c -96
#rename_file "$find_file1" $remove_spaces_string
#echo $remove_spaces_string
fi

: $((file_quantity = $file_quantity-1))
done
 }

#find "string find" "file_find" 

#funk1 1 поиск и переименование счётов
#funk1 2 поиск и переименование счёт-фактур
#funk1 3 поиск и переименование Актов-сверки
#funk1 4 поиск и переименование актов выполненных работ (оказанных услуг)
#funk1 5 поиск и переименование Детализация МТР
#funk1 6 поиск и переименование Приложение к счету
#funk1 7 поиск и переименование СПУС исходящие соединения
funk1 4


exit 0