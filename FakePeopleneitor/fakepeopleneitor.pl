#!/usr/bin/perl

#Crear nombres falsos para bases de datos de prueba...
#
#David 2008

#Cuantos registros falsos.
if ( $ARGV[0] =~ m/^\d+$/ ){
   $CUANTOS=$ARGV[0]; 
   $ra=1;
}

if($ra != 1){
    #DEFAULT
    $CUANTOS=100;
}

open FNH,"data/h.txt" or die "$!";
open FNM,"data/m.txt" or die "$!";
open FA,"data/a.txt" or die "$!";
open FE,"data/e.txt" or die "$!";
open CP,"data/cp.txt" or die "$!";

@MUJERES=<FNM>;
$CM=$#MUJERES;
@HOMBRES=<FNH>;
$CH=$#HOMBRES;
@APELLIDOS=<FA>;
$CA=$#APELLIDOS;
@ESTADOS=<FE>;
$CE=$#ESTADOS;
@CODPOSTAL=<CP>;
$CP=$#CODPOSTAL;

sub fecha_rand{
    $minimo=1951;
    $a=int(rand(60)) + $minimo;
    $mes=int(rand(11)) + 1;
    $mes=$mes < 10?"0$mes":$mes;
    if( $mes < 8 ){
        $dias=$mes % 2 != 0?31:30;
        $dias=$mes == 2?28:$dias;#foquinfebrero
    }else{
        $dias=$mes % 2 != 0?30:31;
    }
    $dia=int(rand($dias)) + 1;
    $dia=$dia < 10?"0$dia":$dia;
    return "$dia/$mes/$a";
}

sub dedup{
    $NINI=$_[0];
    #print "==== DEDUP INI: $NINI\n";
    @NMB=split " ",$NINI;
    @NMB=sort @NMB;
    $ant="";
    @repetidos=();
    foreach (@NMB){
        if ($ant eq $_){
            push(@repetidos,$_);
        }
        $ant=$_;
    }
    foreach (@repetidos){
    #    print "===REPETIDO $NINT $_\n";
        $NINI=~s/($_)(.*)($_)/\1\2/;;
    }
    $NINI=~s/  / /;
    $NINI=~s/^ //;
    $NINI=~s/ $//;
    return $NINI;
}

sub f_name{
        #DETECTAR DOBLE NOMBRE EN INPUT
        $CHECK=index($_[1]," ");
        if($CHECK != -1 ){
                if( (length($_[1]) + rand(10))%2 == 0 ){
                    #SI LA SUERTE LO QUIERE ASI, CREAR TRIPLE  O CUADRUPLE NOMBRE ;)
                    $pass=1;
                }else{
                    $pass=0;
                }
        }
                                               #SOLO SE CREA NOMBRE MULTIPLE SI PASS
        if(int(rand($CUANTOS)) > $CUANTOS/2 && $pass == 1 ){
            if($_[0] == 0){
                $NOMBRE2=$HOMBRES[int(rand($CH + 1))];
            }else{
                $NOMBRE2=$MUJERES[int(rand($CH + 1))];
            }
            chop $NOMBRE2;
            $NOMBREFT="$_[1] $NOMBRE2";
            $NOMBREF=dedup("$NOMBREFT");
                        
        }else{
            $NOMBREF=$_[1];
        }
    return $NOMBREF;
}

sub get_rfc{
    #ES la forma q mas eficiente q se me ocurrio, solo 5 ciclos sin importar la longitud del apellido :S
    @VOC=('a','e','i','o','u');
    $min=100;
    foreach $v (@VOC){
        $p=index $_[1],$v;
        #print "$v $p\n";
        if($p > 0){
            #El menor gana el lugar :D
            $min=$p < $min?$p:$min;
        }
    }
   $C1=substr($_[1],0,1);
   $C2=substr($_[1],$min,1); #<-' GANA ESTO
   $C3=substr($_[2],0,1);
   $C4=substr($_[0],0,1);
   $C7=substr($_[3],0,2);
   $C6=substr($_[3],3,2);
   $C5=substr($_[3],8,2);
   $CS=uc("$C1$C2$C3$C4");
   return "$CS$C5$C6$C7";
}

$i=1;

while($i <= $CUANTOS){
    if($i % 2 == 0){
        $NT=$HOMBRES[int(rand($CH + 1))];
        chop $NT;
        $K=0;
    }else{
        $NT=$MUJERES[int(rand($CM + 1))];
        chop $NT;
        $K=1;
    }
    $NOMBRE=f_name($K,"$NT");
    $APELLIDOP=$APELLIDOS[int(rand($CA + 1))];
    chop $APELLIDOP;
    $APELLIDOM=$APELLIDOS[int(rand($CA + 1))];
    chop $APELLIDOM;
    $EDO=$ESTADOS[int(rand($CE + 1))];
    chop $EDO;
    $CODIGOPOSTAL=$CODPOSTAL[int(rand($CP+1))];
    my @arrayCP=split(/\|/, $CODIGOPOSTAL);
    $CODIGOPOSTAL=$arrayCP[0].",".$arrayCP[1].",".$arrayCP[3].",".$arrayCP[4]." ";
    chop $CODIGOPOSTAL;
    $FECHA=fecha_rand();
    $RFC=get_rfc("$NOMBRE","$APELLIDOP","$APELLIDOM","$FECHA");
    print "$NOMBRE,$APELLIDOP,$APELLIDOM,$FECHA,$RFC,$CODIGOPOSTAL\n";
    $i++;

    #print $i . time . "$NOMBRE" . "$FECHA RAND\n";
#    srand($i . "$NOMBRE" . "$FECHA" . "$EDO");
    $NOMBRE="";
}
