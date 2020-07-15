#!/bin/bash

holita=$1
echo $1

nuevo(){
echo
printf "(1) unir audio con video\n"
printf "(2) reducir velocidad de video\n"
printf "(3) eliminar audio de video\n"
printf "(4) recortar video\n"
printf "(5) ajustar velocidad de video\n"
printf "(6) añadir foto a audio\n"
printf "(7) efecto sonoro\n"
printf "(8) convertir formato\n"
printf "(9) concatenar audio\n"
printf "(11) concatenar video\n"
printf "(10) extraer audio\n"
printf "(12) recortar video\n"
printf "(13) añadir fundido video\n"
printf "(14) cambiar saturacion\n"
printf "(15) comprimir nedia\n"
printf "(16) agudizar imagen\n"
printf "(17) equalizacion (contraste, brillo)\n"
printf "(18) equalizacion (contraste, brillo)\n"
printf "(19) equalizacion (contraste, brillo)\n"
printf "(20) equalizacion (contraste, brillo)\n"
printf "(22) mostrar visualizaciones\n"
printf "(21) equalizacion (contraste, brillo)\n"
printf "(23) añadir fundido de entrada/salida\n"
printf "(24) añadir fundido de entrada/salida\n"
printf "(25) añadir fundido de entrada/salida (combinacion)\n"
printf "(26) añadir fundido de entrada/salida audio(combinacion)\n"
printf "(27) concatenar sin reencodear\n"
printf "(28) filtro audio\n"
printf "(29) convertir formato (mp3 a mp4 por ejemplo)\n"
printf "(30) ripear cd\n"

echo
echo -n 'opcion: '
read opcion

}

nuevo




unir(){
	ffmpeg -i $1 -i $2 video_audio_mix.mp4

}

velocidad(){
	echo -n 'elige valor de velocidad (0.0-1.0): ' && read vel && ffplay $holita -vf "setpts=$vel*PTS" && echo -n 'aplicar?: ' && read app 
	if [ "$app" == "s" ]; then 
		ffmpeg -i $holita -vf "setpts=0.5*PTS" highspeed.mpg 
	else
		 velocidad
	fi
}

saturacion(){
	echo -n 'saturacion: ' && read hola && ffplay $holita -vf "eq=saturation=$hola" && echo -n 'aplicar?:(s/n) ' && read aplicar 
	if [ "$aplicar" == "s" ]; then
		ffmpeg -i $holita -vf "eq=saturation=$hola" nuevo.mpg
	else
		saturacion
	fi
}

gamma(){
	echo -n 'gamma: ' && read hola && ffplay $holita -vf "eq=gamma_r=$hola" && echo -n 'cambiar: (s/n) ' && read cambiar
	if  [ -n "$cambiar" ]; then
		ffmpeg -i $holita -vf "eq=gamma_r=$hola"  nuevo.mpg 
	else
		gamma
	fi
}

balance(){
	echo -n 'balance color: ' && read hola && ffplay $holita -vf "colorbalance=rs=0.3:bs=0.3:rh=0.1:bh=-0.1" && echo -n 'aplicar?: ' && read aplicar
	if [ "$aplicar" == "s" ]; then 
	ffmpeg -i $holita -vf "colorbalance=rs=0.3:bs=0.3:rh=0.1" nuevo.mpg 
	else
		 balance 
	fi
}

tono(){

	echo -n 'elige valor de 0-10: ' && read valor && ffplay $holita -hide_banner -vf hue=s=$valor && echo -n 'aplicar? ' && read app 
	if [  "$app" == "s" ]; then 
		ffmpeg -i $holita -vf hue=s=$valor nuevo.mpg 
	else tono 
	fi
}

fundido_video(){
	echo -n 'tiempo comienzo: ' && read comienzo && echo -n 'duracion: ' && read duracion && ffplay $holita -vf "fade=t=in:$comienzo:d=$duracion,fade=t=out:st=14:d=5" && echo -n 'aplicar?: ' && read app 
if [ "$app" == "s" ]; then
	ffmpeg -i $holita -vf "fade=t=in:$comienzo:d=$duracion,fade=t=out:st=14:d=5" nuevo.mpg
	else
		fundido_video
	fi
}

fundido_audio(){

	ffplay $holita -af "afade=t=in:st=10:d=10,afade=t=out:st=24:d=5" && echo -n 'aplicar: ' && read app 
	if [ "$app" == "s" ]; then
		ffmpeg -i $1 -vf 'fade=t=in:st=0:d=5' nuevo.mp3
	else
		fundido_audio
	fi
}

brillo(){
	echo -n 'brillo: ' && read hola && ffplay $holita -vf "eq=brightness=$hola" && echo -n 'aplicar?: ' && read app
	if [ "$app" == "s" ]; then
		ffmpeg -i $holita -vf "eq=brightness=$hola" nuevo.mpg
	else
		brillo
	fi
}



contraste(){
	echo -n 'contraste: ' && read hola && ffplay $holita -vf "eq=contrast=$hola" && echo -n 'aplicar?: ' && read app
	if [ "$app" == "s" ]; then
		ffmpeg -i $holita -vf "eq=contrast=$hola" nuevo.mpg
	else
		contraste
	fi
}

recortar_video(){
	echo -n 'elige tiempo de comienzo: ' && read com && echo -n 'tiempo de duracion: ' && read dura && ffplay $holita -ss $com -t $dura && echo -n 'aplicar?: ' && read app
	if [ "$app" == "s" ]; then
		 ffmpeg -i $holita -ss 00:12 -t 5 -c copy nuevo.mpg
	else
		recortar_video
	fi
}

crop(){
	echo -n 'elige posicion (formato w:h:x:y): ' && read pos && ffplay $holita -vf "crop=$pos" && echo -n 'aplicar?: ' && read app
	if [ "$app" == "s" ]; then
		ffmpeg -i $holita -filter:v "crop=$pos" nuevo.mpg
	else
		crop
	fi
}


flanger(){
	echo -n 'elige valor: ' && read val && ffplay $holita -af flanger=depth=$val && echo -n 'aplicar?: ' && read app
	if [ "$app" == "s" ]; then
		ffmpeg -i $holita -vf 'fade=t=in:st=0:d=5' nuevo.mp4
	else
		flanger
	fi
}
	
unsharp(){
	echo -n 'elige valor: ' && read val && ffplay $holita -vf "unsharp=lx=3:ly=3" && echo -n 'aplicar?: ' && read app
	if [ "$app" == "s" ]; then
		ffmpeg -i $holita -vf "unsharp=lx=3:ly=3"
	else
		unsharp
	fi
}

case $opcion in
	"1") ffmpeg -i $1 -i $2 video_audio_mix.mp4;;
	#"2") ffmpeg -i video.mpg -vf "setpts=4.0*PTS" lowerspeed.mpg -hide_banner;;
	"3") ffmpeg -i input.mp4 -an output.mp4;;
	"4") crop;;
	"5") velocidad;;
	"6") ffmpeg -loop 1 -i image.jpg -i Bryan\ Adams\ -\ Heaven.mp3 -c:v libx264 -c:a aac -strict experimental -b:a 192k -shortest output.mp4;;
	"7") ffmpeg -i "$1" -filter_complex "[0:a]showwaves=s=1280x720:mode=line,format=yuv420p[v]" -map "[v]" -map 0:a -c:v libx264 -c:a copy output.mkv;;
	"8") echo -n 'archivo a convertir: ' && read archivo && echo -n 'convertir a: ' && read convertir &&  ffmpeg -i  $archivo $archivo.$convertir;;
	"9") echo -n 'archivo primero a unir: ' && read audio && echo -n 'segundo archivo: ' && read archivo && sox $audio $archivo $audio$archivo;;
	"10") echo -n 'video a extraer: ' && read archivo && ffmpeg -i $archivo $archivo.mp3;;
	"12") recortar_video;;
	"13") ;;
	"14") tono;;
	"15") echo -n 'elige valor: ' && read valor && ffplay $1 -hide_banner -vf ;;
	"16") unsharp;;
	"17") contraste;;
	"18") brillo;;
	#"19") echo -n 'saturacion: ' && read hola && ffplay $1 -vf "eq=saturation=$hola";;
	"19") saturacion;;
	"20") gamma;;
	"21") balance;;
	"22") echo -n 'balance color: ' && read hola && ffplay $1 -vf "waveform";;
	"23")  ;;#ffmpeg -i $1 -vf 'fade=t=in:st=0:d=5' $2
	"24")  ;;#ffmpeg -i $1 -vf 'fade=t=in:st=0:d=5' $2
	"25") fundido_video;;
	"26") fundido_audio;;
	"27") ffmpeg -i "$1" -i "$2" -filter_complex "[0:v][0:v] concat=n=2:v1:a=1"-c copy $2.p;; #ffmpeg -i $1 -vf 'fade=t=in:st=0:d=5' $2
	"28") flanger;;
	"29") ffmpeg -i $1 $2;; #detecta extensiones
	"30") echo 'elige formato: ' && read formato && abcde -o $formato;; #detecta extensiones
esac

nuevo

