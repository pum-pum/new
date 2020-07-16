#!/bin/bash

if [ -z "$2" ]
then
	echo 'pon imagen de entrada y nombre de imagen producto '
	exit
else
	echo	
fi
#variable=$1
val=$1
vol=$2

menu(){
printf '(1) convertir jpg a png\n'
printf '(2) redimesianar imagen\n'
printf '(3) covertir a blanco y negro\n'
printf '(4) convertir a monocromaticas\n'
printf '(5) convertir a escala de color\n'
printf '(6) efecto borroso\n'
printf '(7) efecto bosquejo\n'
printf '(8) efecto sombreado\n'
printf '(9) efecto carboncillo\n'
printf '(10) brillo\n'
printf '(11) efecto borde\n'
printf '(12) marco imagen\n'
printf '(13) saturacion\n'
printf '(14) efecto pintura\n'
printf '(15) solarize\n'
printf '(16) combinar imagenes a gif\n'
printf '(17) gif a imagnes estaticas\n'
printf '(18) viñetas\n'
printf '(19) crear imagen de color solido\n'
printf '(20) composicion de imagenes\n'
printf '(21) añadir texto\n'
printf '(22) cambiar gamma\n'
printf '(23) pixelar imagen\n'
printf '(24) pixelar imagen\n'
echo 
echo -n 'elige opcion: '
read opcion
}


proporcion(){
	echo -n 'elige proporcion de tamaño en tanto por ciento: '
	read tamano
	convert "$1" -resize $tamano% "$2"
}
hol(){
	echo -n 'tamaño en pixels de salida (ej: 64x64): '
	read tamano
	display -resize $tamano "$val" && echo -n 'aplicar? ' && read app
	if [ "$app" == "s" ]; then
		convert "$val" -resize $tamano $vol 
	else
		hol
	fi
}

negate(){
	display -negate "$val"  && echo -n 'aplicar? ' && read ng
	if [ "$ng" == "s" ]; then
		convert -negate "$val" "$vol"
	else
		negate
	fi
}


mono(){
	display -monochrome && echo -n 'proceder?: ' && read proc 
	if [ "$proc" == "s" ]; then
		convert -monochrome "$val" "$vol"
	else
		mono
	fi
}

colorspace(){
	echo -n 'elige color: '
	read color
	convert -colorspace $color "$val" "$vol"
}

blur(){
	display -blur 0x3 $1 $2
	echo -n 'aplicar cambiaos o volver a ajustar?: '
	read ajustar
	convert -blur 0x3  $imagen $producto
}

emboss(){
	convert -emboss 10  "$1" "$2"
}
shade(){
	convert -shade 120x45  "$1" "$2"
}

carbon(){
	echo -n 'elige valor de grosor: ' && read grosor && convert -charcoal $grosor $val $vol
}
modulate(){
	convert -modulate 200 "$1" "$2"
}
edge(){
	echo -n 'elige valor: ' && read valor && display -edge $valor $1 && convert -edge 5 "$1" "$2"
}
borde(){
	echo -n "elige color de marco: "
	read color
	echo -n "de que grosor quieres el borde? (especifica en pixeles, solo pon cifra): "
	read borde
	convert -bordercolor $color -border $borde $1 $2
}
modulateir(){
	convert -modulate 100,250 "$1" "$2"
}
pintura(){
	convert -paint 5 "$1" "$2"
}
sol(){
	convert -solarize 40% "$1" "$2"
}
convert(){
	convert $1 $2.gif
}
con(){
	convert "$1" "$2"
}
conv(){
	convert "$1" -background black -vignette 100x300 "$2"
}
co(){
	echo -n 'nombre de la imagen producto: '
	read producto
	convert -size 600x500 canvas:blue  $producto.png
}
sup(){
	echo -n 'imagen a superponer: '
	read imagen
	echo -n 'nombre de la imagen producto: '
	read producto
	convert -size 600x500 canvas:blue $imagen -composite $producto.png
}
gravity(){
	convert -size 165x70 xc:lightblue -font Bookman-DemiItalic  -pointsize 12 -fill blue -gravity center  -draw "text 0,0 'It is 28 degrees today'" image.png	
}
gamma(){
	echo -n 'elige valor: ' && read valor && display -gamma $valor $1 && 
	convert -scale 10% -scale 1000% $1 $2
}

scale(){
	echo -n 'elige geometria: ' && read geo && display -sample $geo $val && echo -n 'aplicar? ' && read app 
	if [ "$app" == "s" ]; then 
		convert -scale geo $val $vol
	else
		scale
	fi
}

menu

case $opcion in
	"1") proporcion;;
	"2") hol;;
	"3") negate;;
	"4") mono;;
	"5") colorspace;;
	"9") carbon;;
	"24") scale;;
	"22") gamma;;
esac

