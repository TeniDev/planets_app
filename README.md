# Planets App - v1.0.0

_Proyecto realizado en Flutter para prueba tecnica para Tres Astronautas_

## Comenzando 🚀

_Estas instrucciones te permitirán obtener una copia del proyecto en funcionamiento en tu máquina local para propósitos de desarrollo y pruebas._

### Pre-requisitos 📋

_Para reproducir este proyecto en su maquina local es necesario instalar los items listados a continuación:_

* Flutter: Para instalar flutter puedes seguir los pasos que se encuentran en la pagina principal ([Flutter.dev](https://docs.flutter.dev/get-started/install?gclid=Cj0KCQjwi46iBhDyARIsAE3nVrahrFDcU8hIEgOrbstxdPPcB8TXpiSOonfZ3dAY7MD39wg70t6KK1QaAgtXEALw_wcB&gclsrc=aw.ds)) o puede seguir un video tutorial de como instalarlo ([Tutorial](https://www.youtube.com/watch?v=W9clR_Wg3ho&list=PLCKuOXG0bPi3xBRYOmcfoqrchgRJOafo9)) esta lista contiene ambas instalaciones (Windos y MacOS). Es necesario tener version de flutter 3.24.3.

### Instalación 🔧

* Clonar el repositorio:

    ```
    git clone https://github.com/TeniDev/planets_app.git
    ```

  - _Recuerda tener a la mano el archivo .env y el archivo Makefile para ejecutar los comandos de instalación._
  
* Abrir el proyecto en tu editor de texto: (VS Code, Android Studio, etc...)

  - _Puedes ejecutar los siguientes comandos desde la misma terminal para abrirlo_

    ```
    cd {PROJECT-PATH}
    ```
    ```
    code .
    ```
* Agregar el archivo .env con las variables necesarias (ver ejemplo en .env.example), este se debe agregar en la raiz del proyecto.

* Ahora bien, debemos ejecutar los comandos de los generadores de código, para esto ejecutamos los siguientes comandos:

    ```
    make fix_gen

    make gen

    make gen_l10n
    ```

* Esto debera generar una copia de los archivos necesarios para correr el proyecto, si no se generan los archivos correctamente, en caso de que los comandos make no funcionen, puedes ejecutar los comando de forma manual.

_Finalmente puedes presionar F5 para correr el proyecto en modo debug_

## Construido con 🛠️

_Herramientas usadas en el proyecto_

* [Flutter](https://docs.flutter.dev/) - El framework **multiplataforma** usado.
* [Riverpod](https://riverpod.dev/es/) - Manejador de estado reactivo.
* [GoRouter](https://pub.dev/packages/go_router) - Paquete manejador de rutas declarativo.
* [Hive](https://docs.hivedb.dev/#/) - Base de datos local, NoSQL.

## Versionado 📌

Se usa [SemVer](http://semver.org/) para el versionado.

## Enlaces de interes 🎁

_Los siguientes son unos enlaces de interes para entender mas acerca de flutter web y las herramientas usadas:_

* [Flutter for Web](https://javascript.plainenglish.io/flutter-for-web-an-ultimate-guide-to-flutter-web-development-650549055ccd)
* [Flutter Offline Storage Using HIVE database](https://techmusings.optisolbusiness.com/flutter-offline-storage-using-hive-database-a22cdfaa259e)
* [GoRouter](https://docs.page/bizz84/go_router_archived/getting-started)
* [Flutter go_router: The Essential Guide](https://medium.com/@antonio.tioypedro1234/flutter-go-router-the-essential-guide-349ef39ec5b3)
* [Flutter Riverpod 2.0: The Ultimate Guide](https://codewithandrea.com/articles/flutter-state-management-riverpod/)