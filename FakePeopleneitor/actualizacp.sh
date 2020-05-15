 wget -O ./data/cp.txt https://www.correosdemexico.gob.mx/datosabiertos/cp/cpdescarga.txt
 sed '1,2d' ./data/cp.txt > tmpfile; mv tmpfile ./data/cp.txt
 iconv -f ISO-8859-1 -t UTF-8 ./data/cp.txt > ./data/cp1.txt; mv ./data/cp1.txt ./data/cp.txt