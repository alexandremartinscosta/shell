dialog --yesno 'Quer ver as horas?' 0 0

if [ $? = 0 ]; then
	echo "Agora são: $( date )"
else
	echo 'Ok, não vou mostrar as horas.'
fi
