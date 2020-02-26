# TP - Introduction au CI/CD 2019/2020



## Objectifs du Travail Pratique

Le but de cet exercice pratique est d’évaluer l’étudiant sur la mise en oeuvre des connaissances (théoriques ET pratiques) acquises lors des 2 jours d’introduction au CI/CD.

Pour la mise en place du pipeline, j'ai utilisé le service Travis CI sur un projet GitHub dropwizard (projet OpenSource) . Ci-dessous les explications en détail de mon fichier .travis.yml me permettant d'exécuter mon pipeline.

Vous trouverez l'exécution du fichier Travis à l'url suivant : https://travis-ci.com/FionaPrudhomme/ProjectTPCI


## Explication pipeline (.travis.yml)

| dist: xenial                 |
| ---------------------------- |
| début du fichier .travis.yml |

| language: java   |
| ---------------- |
| language du code |

| script:                    |
| -------------------------- |
| Initialisation des scripts |

| before_install:                                              |
| ------------------------------------------------------------ |
| Avant de démarrer chaque étape du pipeline, ces lignes sont exécutés |

| - mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V |
| ------------------------------------------------------------ |
| mvn install avant de faire mvn package                       |

| - mvn test -B      |
| ------------------ |
| test avant package |

| - export DISPLAY=:99.0 |
| ---------------------- |
| Pour le site statique  |

| - sleep 3             |
| --------------------- |
| Pour le site statique |

| - rm ~/.m2/settings.xml \|\| true |
| --------------------------------- |
| remise à zéro des paramètres      |

| - ulimit -c unlimited -S |
| ------------------------ |
|                          |

| jobs:             |
| ----------------- |
| Début du pipeline |

| include: |
| -------- |
| Pipeline |

| - stage: build + test |
| --------------------- |
| Etape Build et Test   |

| name: "Java 8"                                               |
| ------------------------------------------------------------ |
| Nom de la sous étape (les sous étapes sont faites en parallèles) |

| os: linux |
| --------- |
| os        |

| jdk: openjdk8                |
| ---------------------------- |
| Test et Build fait en Java 8 |

| script: mvn package           |
| ----------------------------- |
| Exécution du script en java 8 |

| - script: mvn package          |
| ------------------------------ |
| Exécution du script en java 11 |

| name: "Java 11"               |
| ----------------------------- |
| nom de la deuxième sous étape |

| os: linux |
| --------- |
| os        |

| jdk: openjdk11        |
| --------------------- |
| sous etape en java 11 |

| - script: mvn site-deploy -Dport=8081                        |
| ------------------------------------------------------------ |
| création et déploiment du site statique sur le port 8081  (au cas ou le 8080 est utilisé) |

| name: "maven site"             |
| ------------------------------ |
| nom de la troisième sous étape |

| - stage: deploy      |
| -------------------- |
| étape 2, déploiement |

| name: "deploy" |
| -------------- |
| sous étpae 1   |

| script: mvn deploy |
| ------------------ |
| déploiement        |

| - script: mvn site:run -Dport=8081 &                   |
| ------------------------------------------------------ |
| mise en place du site statique maven sous le port 8081 |

| name: "maven site" |
| ------------------ |
| sous étape 2       |

| env:                                        |
| ------------------------------------------- |
| Clé de sécurité pour déployer l'application |

