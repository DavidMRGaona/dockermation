#!/usr/bin/env bash

##########################################################
#             Proceso de instalación v0.1.0              #
#     Autor: DavidMRGaona <DavidMRGaona[@]gmail.com>     #
##########################################################

function createBranch {
    read -p "¿Desea crear y cambiar de rama? (y/n): " option

    if [ "$option" = "y" ] || [ "$option" = "Y" ] || [ "$option" = "yes" ] || [ "$option" = "YES" ]; then
        read -p "¿Como desea llamar a la nueva rama?: " branch
        git checkout -b $branch
        read -p "¿Que rama remota desea trackear?: " remote
        git branch --set-upstream-to=origin/$remote
        echo
        echo "#######################################################"
        echo "#    ᕕ( ᐛ )ᕗ Actualizando repositorio... ᕕ( ᐛ )ᕗ    #"
        echo "#######################################################"
        git pull
    fi
}

function initGit {
    echo "###################################################################################"
    echo "#    ¯\_(ツ)_/¯ No se ha encontrado ningún repositorio de git local ¯\_(ツ)_/¯    #"
    echo "###################################################################################"
    sleep 1
    echo
    echo "#############################################"
    echo "#    ᕕ( ᐛ )ᕗ Iniciando git... ᕕ( ᐛ )ᕗ     #"
    echo "#############################################"
    sleep 1
    git init
    echo

    read -p "Indique el repositorio que desea clonar (debe tener los permisos necesarios): " repo
    git remote add origin $repo
    git fetch
    git checkout -t origin/master

    createBranch
}

function envGenerate {
    echo "#####################################################################"
    echo "#    ᕕ( ᐛ )ᕗ Generando archivo de variables de entorno ᕕ( ᐛ )ᕗ    #"
    echo "#####################################################################"
    echo ""

    read -p "Indique el nombre de su aplicación (si tiene varias palabras utilice commillas): " app_name
    read -p "Indique el entorno de despliegue (local/production/documentation): " app_env
    read -p "¿Desea activar el modo debug? (true/false): " app_debug
    read -p "Indique el nivel del log (debug/info/notice/warning/error/critical/alert/emergency): " app_log_level
    read -p "Indique la URL de la aplicación (e.j. http://localhost:8080): " app_url

    read -p "Indique el tipo de conexión con la base de datos (e.g. mysql): " db_connection
    read -p "Indique el host de la base de datos (e.g. localhost/mysql): " db_host
    read -p "Indique el puerto de la base de datos (e.g. 3306): " db_port
    read -p "Indique el nombre de la base de datos: " db_database
    read -p "Indique el nombre de usuario asignado a esa base de datos: " db_username

    while : ; do
        read -s -p "Indique la contraseña del usuario asignado: " db_password
        echo
        read -s -p "Vuelva a introducir la contraseña: " db_password_confirmation
        echo

        if [ "$db_password" == "$db_password_confirmation" ]; then
            break
        fi

        echo "Las contraseñas no coinciden, por favor intentelo de nuevo"
    done

    read -p "Indique el driver de broadcasting (log/redis/socket.io/...): " broadcast_driver
    read -p "Indique el driver de cache (file/redis): " cache_driver
    read -p "Indique el driver de sesión (file/redis/cookie/...): " session_driver
    read -p "Indique el driver para las colas de trabajo (database/file/sync): " queue_driver

    read -p "Indique el host de redis (e.g. localhost/redis): " redis_host
    read -p "Indique la contraseña de redis (e.g. null): " redis_password
    read -p "Indique el puerto de redis (e.g. 6379): " redis_port

    read -p "Indique el driver de correo (e.g. smtp): " mail_driver
    read -p "Indique el host de correo (e.g smtp.mailtrap.io): " mail_host
    read -p "Indique el puerto de correo (e.g. 25/465/2525/...): " mail_port
    read -p "Indique el nombre de usuario asociado al correo: " mail_username
    read -p "Indique la contraseña del usuario de correo: " mail_password
    read -p "Indique la encriptacion del corre (e.g null/tls): " mail_encryption

    read -p "Indique el ID de pusher (si no tiene deje el campo en blanco): " pusher_app_id
    read -p "Indique la clave de pusher (si no dispone de una clave deje el campo en blanco): " pusher_app_key
    read -p "Indique la clave secreta de pusher (puede dejar en blanco el campo): " pusher_app_secret

    echo "APP_NAME=$app_name" > .env
    echo "APP_ENV=$app_env" >> .env
    echo "APP_KEY=" >> .env
    echo "APP_DEBUG=$app_debug" >> .env
    echo "APP_LOG_LEVEL=$app_log_level" >> .env
    echo "APP_URL=$app_url" >> .env
    echo "" >> .env
    echo "DB_CONNECTION=$db_connection" >> .env
    echo "DB_HOST=$db_host" >> .env
    echo "DB_PORT=$db_port" >> .env
    echo "DB_DATABASE=$db_database" >> .env
    echo "DB_USERNAME=$db_username" >> .env
    echo "DB_PASSWORD=$db_password" >> .env
    echo "" >> .env
    echo "BROADCAST_DRIVER=$broadcast_driver" >> .env
    echo "CACHE_DRIVER=$cache_driver" >> .env
    echo "SESSION_DRIVER=$session_driver" >> .env
    echo "QUEUE_DRIVER=$queue_driver" >> .env
    echo "" >> .env
    echo "REDIS_HOST=$redis_host" >> .env
    echo "REDIS_PASSWORD=$redis_password" >> .env
    echo "REDIS_PORT=$redis_port" >> .env
    echo "" >> .env
    echo "MAIL_DRIVER=$mail_driver" >> .env
    echo "MAIL_HOST=$mail_host" >> .env
    echo "MAIL_PORT=$mail_port" >> .env
    echo "MAIL_USERNAME=$mail_username" >> .env
    echo "MAIL_PASSWORD=$mail_password" >> .env
    echo "MAIL_ENCRYPTION=$mail_encryption" >> .env
    echo "" >> .env
    echo "PUSHER_APP_ID=$pusher_app_id" >> .env
    echo "PUSHER_APP_KEY=$pusher_app_key" >> .env
    echo "PUSHER_APP_SECRET=$pusher_app_secret" >> .env
    echo "" >> .env
    echo "JWT_SECRET=AS0JYVUOQl5V3a6m6DSpFotyl73p3IbQ" >> .env
    echo "" >> .env
    echo "FCM_SERVER_KEY=AAAArashmZw:APA91bE-DUzYL9e380dL3t-UySVkHlLL2XrPdnOwi0VvTbXfmdW-nZCADYkywZphG-sdEJedaL1leh3xMR7yA6SChpwUJaQ6T2oZwOAL6A4m6-HNoDZcuJ0Sw-l0wxlXCf3G37XhslU0" >> .env
    echo "FCM_SENDER_ID=745900448156" >> .env
}

function initDocker {
    echo
    printf "\xF0\x9F\x90\xB3 Iniciando Docker... \xF0\x9F\x90\xB3 \n"
    sleep 1
    echo
    echo "########################################################"
    echo "#      ᕕ( ᐛ )ᕗ Construyendo las imágenes ᕕ( ᐛ )ᕗ     #"
    echo "########################################################"
    sleep 1
    echo
    echo "########################################################"
    echo "#    ¯\_(ツ)_/¯ Puedes ir a tomar un café ¯\_(ツ)_/¯    #"
    echo "########################################################"
    echo
    cd docker && cp env-example .env && docker-compose build --no-cache
    echo
    sleep 1
    echo
    echo "########################################################"
    echo "#    ᕕ( ᐛ )ᕗ Inicializando los contenedores ᕕ( ᐛ )ᕗ  #"
    echo "########################################################"
    echo
    docker-compose up -d nginx mysql php-worker phpmyadmin workspace
}

function initLaravel {
    echo "########################################################"
    echo "#        ᕕ( ᐛ )ᕗ Parametrizando Laravel ᕕ( ᐛ )ᕗ        #"
    echo "########################################################"
    sleep 1
    echo
    echo "########################################################"
    echo "#    ¯\_(ツ)_/¯ Igual te apetece otro café ¯\_(ツ)_/¯  #"
    echo "########################################################"

    docker-compose exec -u cryptos workspace composer install
    docker-compose exec -u cryptos workspace php artisan migrate --seed
    docker-compose exec -u cryptos workspace php artisan storage:link
    docker-compose exec -u cryptos workspace php artisan key:generate
}

clear

if [ ! -d "./.git" ]; then
    initGit
fi

if [ ! -f "./.env" ]; then
    envGenerate
fi

initDocker
initLaravel

