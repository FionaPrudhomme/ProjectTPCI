# TP - Introduction au CI/CD 2019/2020



## Objectifs du Travail Pratique

Le but de cet exercice pratique est d’évaluer l’étudiant sur la mise en oeuvre des connaissances (théoriques ET pratiques) acquises lors des 2 jours d’introduction au CI/CD.

Pour la mise en place du pipeline, j'ai utilisé le service Travis CI sur un projet GitHub dropwizard (projet OpenSource) . Ci-dessous les explications en détail de mon fichier .travis.yml me permettant d'exécuter mon pipeline.

L'étape Deploy ne fonctionne pas, c'est du aux paramètre dans pom.xml qui 'skip' maven deploy. Je n'ai pas trouvé de solution pour faire fonctionner le déploiement, notemment car Travis lance le pipeline dans une machine virtuelle et non en local.

Le deploiement de la documentation ne fonctionne pas. J'ai laissé en commentaire l'étape que je voulais faire... Il y a un problème avec la clé sécure que j'ai généré ou bien il en manque une je pense. 
Si la documentation avait été générée comme voulu, elle l'aurait été sur: https://fionaprudhomme.github.io/ProjetTPCI/master/

Execution du pipeline : 
https://travis-ci.com/FionaPrudhomme/ProjectTPCI

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

| jobs:             |
| ----------------- |
| Début du pipeline |

| include: |
| -------- |
| Pipeline |

| **- stage: build** |
| ------------------ |
| Etape Build        |

| name: build      |
| ---------------- |
| nom sous etape 1 |

| script: mvn package |
| ------------------- |
| Build               |

| - script: mvn site  |
| ------------------- |
| creation maven site |

| name: generate maven site |
| ------------------------- |
| nom sous etape 2          |

| - script: mvn post-site |
| ----------------------- |
| execute maven site      |

| - stage: Test |
| ------------- |
| Etape Test    |

| name: "Java 8"                                               |
| ------------------------------------------------------------ |
| Nom de la sous étape (les sous étapes sont faites en parallèles) |

| os: linux |
| --------- |
| os        |

| jdk: openjdk8                |
| ---------------------------- |
| Test et Build fait en Java 8 |

| script: mvn test              |
| ----------------------------- |
| Exécution du script en java 8 |

| - script: mvn test             |
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

| - stage: deploy      |
| -------------------- |
| étape 2, déploiement |

| name: "deploy" |
| -------------- |
| sous étpae 1   |

| script: mvn deploy |
| ------------------ |
| déploiement        |

| - script: ./gendoc.sh     |
| ------------------------- |
| git doc deploiement       |

| name:  deploy documentation |
| ------------------------    |
| sous étape 2                |

| env:                                        |
| ------------------------------------------- |
| Clé de sécurité pour déployer l'application |

