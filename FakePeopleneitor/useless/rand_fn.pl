#!/usr/bin/perl

$minimo=1951;

$a=int(rand(60)) + $minimo;
$mes=int(rand(11)) + 1;
$mes=$mes < 10?"0$mes":$mes;
$dia=int(rand(27)) + 1;
$dia=$dia < 10?"0$dia":$dia;

print "$dia/$mes/$a";
