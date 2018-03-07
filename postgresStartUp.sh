echo "sarting";
docker rm Iconoclastic_Logar;
docker run -i -t -p 5432:5432 -d -v Eternal_Crusade:/var/lib/postgresql/ --name Iconoclastic_Logar dummyapp/rubytest;
docker ps;
