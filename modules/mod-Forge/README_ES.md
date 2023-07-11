 [English](README.md) | [Español](README_ES.md)

# PARTE 1 - Cómo crear su propio módulo

Puede utilizar estos scripts para iniciar su proyecto:

[Ejemplos de scripts](https://github.com/azerothcore/azerothcore-boilerplates)

### ¿Cómo probar su módulo?

Desactivar PCH (cabeceras pre-compiladas) e intentar compilar. Si ha olvidado algunas cabeceras, es hora de añadirlas. Para desactivar PCH, siga este [link](https://github.com/azerothcore/azerothcore-wotlk/wiki/CMake-options) y ponga `USE_COREPCH ` a 0 con Cmake.

-------------------------------------------------------

# PARTE 2 - EJEMPLO DE UN README.md
Recuerde que el README.md le explica al resto de las personas que es lo que hace su módulo. Recomendamos escribirlo en ingles quizás, aunque puede ser traducido luego a otros idiomas.

# MI NUEVO MÓDULO (título)

## Descripción

Este módulo permite hacer esto y esto.
(Debe explicar para que se va a utilizar el modulo, cuál es su utilidad)

## Cómo utilizar

Haz esto y aquello.

Puedes agregar una carpeta de pantalla:

[screenshot](/screenshots/my_module.png?raw=true "screenshot")

O incluso un video donde expliques su uso:

[Youtube](https://www.youtube.com/watch?v=T6UEX47mPeE)


## Requisitos

Se debe especificar que versión de azerothcore requiere, porque podría ser incompatible con alguna más adelante. Entonces aclarar por las dudas su compatibilidad no está de más.

Mi nuevo módulo requiere:

- AzerothCore v4.0.0+


## Instalación

```
1) Simplemente coloque el módulo dentro del directorio `modules` de AzerothCore (repositorio), no la compilación.
2) Importe el SQL manualmente a la base de datos correcta (auth, mundo o caracteres) o con el `db_assembler.sh` (si se proporciona `include.sh`).
3) Vuelva a ejecutar el Cmake y genere la compilación necesaria. (Revise la guía)
```

## Editar la configuración del módulo (opcional)

Si necesita cambiar la configuración del módulo, vaya a la carpeta de configuración de su servidor (donde está su `worldserver` o `worldserver.exe`), copie `my_module.conf.dist` a `my_module.conf` y edite ese nuevo archivo.


## Créditos

* [Yo](https://github.com/YOUR_GITHUB_NAME) (autor del módulo) Edite el enlace para que apunte a su github si lo desea.
* [BarbzYHOOL](https://github.com/barbzyhool) <!-- Puedes eliminar estas líneas, pero al crear un nuevo modulo, es notificado a estas personas, por lo que está bueno que eso ocurra. -->
* [Talamortis](https://github.com/talamortis)<!-- Puedes eliminar estas líneas, pero al crear un nuevo modulo, es notificado a estas personas, por lo que está bueno que eso ocurra. -->

AzerothCore: [repository](https://github.com/azerothcore) - [website](http://azerothcore.org/) - [discord chat community](https://discord.gg/PaqQRkd)
