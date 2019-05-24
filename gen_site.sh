#!/bin/bash

ROOT=$(pwd)
SITE="${ROOT}/index.html"

function write {
	printf '%s\n' "$1" >> $SITE
}

function link_pdfs {
	for file in $(ls -1 *.pdf); do
		write "<p><a href=\"${1}/${file}\">${file}</a></p>"
	done
}

function start_html {
	write "<!DOCTYPE html>"
	write "<html>"
}

function end_html {
	write "</html>"
}

function head {
	content=''
	content+="<head>"
	content+="    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
	content+="    <meta charset=\"UTF-8\">"
	content+="</head>"
	write "${content}"
}

function start_body {
	write "<body>"
}

function end_body {
	write "</body>"
}

function sec_oti {
	write "<h1>Olimpiada Națională de Tehnologia Informației</h1>"
	write "<h2>$1 $2</h2>"
	write "<br>"
}

function sec_oficial {
	cd oficial
		write "<h2 class=\"section\">Oficial</h2>"
		link_pdfs oficial
	cd ..
}

function sec_subiecte {
	cd subiecte
		write "<h2 class=\"section\">Subiecte</h2>"
		link_pdfs subiecte
	cd ..
}

function sec_barem {
	cd barem
		write "<h2 class=\"section\">Barem</h2>"
		link_pdfs barem
	cd ..
}

function sec_rezultate {
	cd rezultate
		write "<h2 class=\"section\">Rezultate</h2>"
		cd premii
			write "<h3>Premii</h3>"
			link_pdfs "rezultate/premii"
		cd ..
		cd finale
			write "<h3>Rezultate finale (după contestații)</h3>"
			link_pdfs "rezultate/finale"
		cd ..
		cd initiale
			write "<h3>Rezultate inițiale</h3>"
			link_pdfs "rezultate/initiale"
		cd ..
	cd ..
}

function sec_liste {
	cd liste
		write "<h2 class=\"section\">Liste</h2>"
		link_pdfs liste
	cd ..
}

function sec_repartizare {
	cd repartizare
		write "<h2 class=\"section\">Repartizare</h2>"
		link_pdfs repartizare
	cd ..
}

function sec_site_info {
	info="<br>
<hr>
<footer>
	<p>Arhivă a documentelor legate de Olimpiada Națională de Tehnologia Informației creată de Sergiu Marton.</p>
</footer>"

	write "$info"
}

if [ $# -ne 1 -a $# -ne 2 ]; then
	printf '%s\n' "Utilizare: ./gen_site.sh <oras> <an>"
	exit 1
fi

if [ "$1" = "help" -o "$1" = "ajutor" ]; then
	printf '%s\n' "Utilizare: ./gen_site.sh <oras> <an>"
	exit 0
fi

: > index.html

start_html
head
start_body

sec_oti "$1" "$2"
sec_oficial
sec_subiecte
sec_barem
sec_rezultate
sec_liste
sec_repartizare
sec_site_info

end_body
end_html

