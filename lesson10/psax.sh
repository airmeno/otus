#!/usr/bin/env bash

# Функция перевода секунд из целых чисел в формат времени 
secconverttime() {
 ((m=(${1}%3600)/60))
 ((s=${1}%60))
 printf "%01d:%02d\n" $m $s
}

# Значение процессорного такта в машинных часах (интевалы в сек). Нужно для расчета процессорного времени на каждый процесс.
clk_tck=$(getconf CLK_TCK)

# Формируем вывод (заголовок)
echo "PID | TTY | STAT | TIME | COMMAND" | column -t  -s '|'

# из /proc забираем все папки с числами в имени (это наши PIDы) и сортируем по возрастанию
a=$(ls -l /proc | awk '{print $9}' | grep -s "^[0-9]*[0-9]$"| sort -n) 

# Перебираем по очереди выборку и формируем построчно столбцы согласно заголовку из файла stat, cmdline. Любые ошибки при выводе игнорируем.
for pid in $a;
do
tty=$(cat 2>/dev/null /proc/$pid/stat | awk '{print $7}')
stat=$(cat 2>/dev/null /proc/$pid/stat | awk '{print $3}')
utime=$(cat 2>/dev/null /proc/$pid/stat | awk '{print $14}')
stime=$(cat  2>/dev/null /proc/$pid/stat | awk '{print $15}')
cmd=$(cat 2>/dev/null /proc/$pid/stat | awk '{print $2}')
# вывод информации аргуметов запуска процесса
cmd_arg=$(cat 2>/dev/null /proc/$pid/cmdline | awk '{print $0}')

# определем терминал/псевдотерминал (tty_ | pts/_)
if [[ "$tty" -eq 0 ]]
then tty='?'
else tty=$(ls -la /proc/$pid/fd/ | grep -m 1 'pts\|tty' | awk '{print $11}' | sed 's/\/*dev\///')
fi

# Считаем процессорное время для столбка TIME
ttime=$(((utime + stime) / clk_tck)) 
ftime=$(secconverttime $ttime)

# вывод результатов
echo "$pid | $tty | $stat | $ftime | $cmd $cmd_arg" | column -t  -s '|'

done

