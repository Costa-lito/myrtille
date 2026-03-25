# 🫐 Myrtille

**Myrtille** est une classe LaTeX (`.cls`) moderne, épurée et prête à l'emploi, conçue pour rédiger des documents techniques, des manuels ou d'autres types de documents. Elle masque toute la complexité du préambule LaTeX pour offrir à l'utilisateur une expérience de rédaction fluide et centralisée. 

## Fonctionnalités Principales

* **Page de garde automatisée :** Génération d'une couverture design avec fond vectoriel intégré via de simples variables (`\title`, `\subtitle`, `\version`, etc.).
* **Palette de couleurs native :** Des dizaines de couleurs prédéfinies (thème, alertes, neutres) prêtes à être utilisées.
* **Composants visuels :** Boîtes d'information (`infobox`), boîtes d'avertissement (`warnbox`), et notes de marge (`sidenote`).
* **Badges dynamiques :** Un système de badges en ligne (`\badgeReq`, `\badgeOpt`, etc.) pour qualifier rapidement des informations.
* **Blocs de code avancés :** Environnements de code pré-configurés (Python, JSON, Shell, LaTeX) basés sur `tcolorbox` et `listings`, avec coloration syntaxique et bordures stylisées.
* **Typographie soignée :** Utilisation de la police sans-serif Inter pour un rendu contemporain, avec des espacements de paragraphes optimisés pour la lecture.

## Comment l'utiliser ?

1. Téléchargez le fichier `myrtille.cls`
2. Placer ce fichier dans le même répertoire que votre `main.tex`
3. Configurez votre `main.tex` pour utiliser les commandes définie dans la classe (Nous vous conseillons d'utiliser le `main.tex` de ce dépôt comme template)
4. Compilez avec `pdflatex` (ou votre moteur préféré).

Un guide complet se trouve dans `myrtille-guide.pdf`. Ce guide a été compilé à partir des fichiers sources présents dans ce dépôt.

## Ajouter de nouveaux langages de code

La classe intègre une puissante macro abstraite pour générer de nouveaux blocs de code avec barre latérale colorée en une seule ligne. Dans votre préambule, ajoutez simplement :

```latex
% Syntaxe : \newmyrtilleblock[Options]{nom_env}{Langage_listings}{Couleur_barre}
\newmyrtilleblock{jsblock}{JavaScript}{success}
```

## Crédits & Technique

La classe `myrtille.cls` est conçue pour être **100 % autonome**. 

Le fond d'écran de la page de garde n'est pas une image externe, mais du code vectoriel TikZ pur dessiné directement au moment de la compilation. Le design original a été réalisé au format SVG (disponible dans le dossier `assets/`), puis converti de manière transparente en code LaTeX grâce à l'extension Inkscape **[svg2tikz](https://github.com/xyz2tex/svg2tikz)**.
