#!/usr/bin/perl

@VOC=('a','e','i','o','u');
$AP="Esquivel";

$min=100;

foreach $v (@VOC){
    $p=rindex $AP,$v;
    if($p > 0){
    $min=$p < $min?$p:$min;
    }
}

print substr($AP,$min,1);
