#!/usr/bin/perl

#intentar deduplicar nombres como: Jose Luis Luis Alejandro D:


#$NOMBRE="Jose Luis Luis Alejandro";
$NOMBRE="Luis Alberto Luis Alejandro";

@NMB=split " ",$NOMBRE;

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
    $NOMBRE=~s/($_)(.*)($_)/\1\2/;
    $NOMBRE=~s/  / /;
}
print $NOMBRE;
