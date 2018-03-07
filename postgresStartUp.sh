#remove the container so that it can be started with out error
docker rm Iconoclastic_Logar;
#starting the container on port 5432 a volume with the folder containing the databse folder 
docker run -i -t -p 5432:5432 -d -v Eternal_Crusade:/var/lib/postgresql/ --name Iconoclastic_Logar dummyapp/rubytest;
#listing the running containers to make sure the container started
docker ps;
