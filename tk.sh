#!/bin/bash
# delete file with name accounts_new.csv
mv ./accounts_new.csv ./accounts_new.csv.bkp
touch ./accounts_new.csv
#echo "id,locetion_id,name,title,email,department" >> ./accounts_new.csv
# read file 
while IFS="," read -r id locetion_id name title  email department;
do
        title1=$(echo $email | grep "@")
        if [[ -z "$title1" ]] && [[ -n $email ]]; 
        then
                title=$title","$email
        fi
        # if [[ $title =~ "title" ]];
        # then
        #         title="title"
        # fi
        # find name
        name11=$(echo $name | cut -d " " -f 1)
        # make name lowercase
        name1=${name11,,}
        # find surname
        surname1=$(echo $name | cut -d " " -f 2)
        # make surname lowercase
        surname=${surname1,,}
        # if  [[ $name =~ "name" ]];
        # then
        #         name_surname="name"
        # else
        #         name_surname="${name1^} ${surname^}"
        # fi
        name_surname="${name1^} ${surname^}"
        # make imales
        email1=$(echo $name1 | cut -c 1)
        #email1=${email11,,}
        email=$(echo $email1$surname"@abc.com")
        email_changed=$(cat ./accounts.csv | grep -iF  "$name" | wc -l)
        # conect locetion_id with email
        if [[ $email_changed -eq "1" ]];
        then
                email=$email
        else
                email=$(echo $email1$surname$locetion_id"@abc.com")
        fi
        # if [[ $email =~ "nname@abc.com" ]];
        # then 
        #         email=email
        # fi
        if [[ $id =~ "id" ]];
        then
                id=$(cat $1 | head -1 | cut -d "," -f 1)
                locetion_id=$(cat $1 | head -1 | cut -d "," -f 2)
                name_surname=$(cat $1 | head -1 | cut -d "," -f 3)
                title=$(cat $1 | head -1 | cut -d "," -f 4)
                email=$(cat $1 | head -1 | cut -d "," -f 5)
                department=$(cat $1 | head -1 | cut -d "," -f 6)
	fi
        echo $id","$locetion_id","$name_surname","$title","$email","$department >> ./accounts_new.csv
done < $1
