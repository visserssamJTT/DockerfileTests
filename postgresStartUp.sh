echo "sarting";
docker rm Iconoclastic_Logar;
docker run -it -p 5432:5432 -d -v Eternal_Crusade:/var/lib/postgresql --name Iconoclastic_Logar;
dicker ps;
