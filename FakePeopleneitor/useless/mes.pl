#!/usr/bin/perl

#cuantos dias para el rand del mes...

$mes=10;

if( $mes < 8 ){
    $dias=$mes % 2 != 0?31:30;
    $dias=$mes == 2?28:$dias;#foquinfebrero
}else{
    $dias=$mes % 2 != 0?30:31;
}
print "Dias:$dias\n";
