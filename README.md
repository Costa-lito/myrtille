# 🫐 Myrtille

**Myrtille** est un ensemble de classes LaTeX (`.cls`) modernes et épurées, conçues pour rédiger des documents techniques, des manuels ou tout autre type de documentation. Elle masque la complexité du préambule LaTeX pour offrir une expérience de rédaction fluide et centralisée.

---

## Fonctionnalités

- **Page de garde automatisée** — Couverture design avec fond vectoriel TikZ pur, générée via quelques variables (`\title`, `\subtitle`, `\version`, etc.)
- **Palette de couleurs native** — Dizaines de couleurs prédéfinies (thème, alertes, neutres) prêtes à l'emploi
- **Composants visuels** — Boîtes d'information (`infobox`), d'avertissement (`warnbox`) et notes de marge (`sidenote`)
- **Badges dynamiques** — Système de badges inline (`\badgeReq`, `\badgeOpt`, `\badgeStr`, etc.) pour qualifier rapidement les informations
- **Blocs de code avancés** — Environnements pré-configurés (Python, JSON, Shell, LaTeX) basés sur `tcolorbox` et `listings`, avec coloration syntaxique
- **Encadrés d'images** — Quatre environnements dédiés (`imgbox`, `imgfloat`, `imgsidenote`, `\myrfig`) pour intégrer des images de façon cohérente avec la charte
- **Environnements mathématiques** — Boîtes numérotées pour théorèmes (`myrthm`) et définitions (`myrdef`), avec références croisées natives
- **Typographie soignée** — Police sans-serif Inter, espacement de paragraphes optimisé, notes de bas de page symboliques

---

## Thèmes disponibles

Le projet inclut trois chartes graphiques prêtes à l'emploi, chacune nommée d'après une plante :

| Thème | Couleur principale | Ambiance |
|---|---|---|
| **Myrtille** | Bleu `#0D6EFD` | Sobre, technique, classique |
| **Acerola** | Rouge cerise `#E11D48` | Dynamique, moderne, expressif |
| **Pringlea** | Vert canard `#0D9488` | Sérieux, professionnel, naturel |

Chaque thème dispose de son propre sous-dossier (`myrtille/`, `acerola/`, `pringlea/`) contenant la classe `.cls`, le `main.tex` et le `content.tex` de démonstration.

Un guide complet se trouve dans `myrtille-guide.pdf`. Ce guide a été compilé à partir des fichiers sources présents dans ce dépôt.

---

## Créer un nouveau thème

Le script `convert.py` automatise la génération d'une nouvelle classe à partir de la classe source `myrtille.cls` et d'un fichier de palette.

### Structure du dépôt

```
myrtille-project/
├── myrtille/           ← Classe source de référence
├── palettes/           ← Un fichier .tex de couleurs par thème
├── acerola/            ← Thème rouge cerise
├── pringlea/           ← Thème vert canard
├── assets/
│   └── cover_bg.svg    ← Design source de la couverture (Inkscape)
└── convert.py          ← Script de génération des thèmes
```

### Ajouter une palette

Créez `palettes/mon-theme.tex` en définissant les variables de couleur attendues par la classe (voir `palettes/acerola.tex` pour la liste complète), puis lancez :

```bash
python convert.py
```

Un dossier `mon-theme/` contenant la classe `.cls` prête à l'emploi sera créé automatiquement.

---

## Design de la couverture

Le fond de la page de garde est entièrement vectoriel — dessiné en code TikZ pur lors de la compilation, sans aucune image externe. Le design source est disponible dans `assets/cover_bg.svg` et a été converti en LaTeX grâce à l'extension **[svg2tikz](https://github.com/xyz2tex/svg2tikz)**.

---

## Licences

### Code source

Les fichiers `.cls`, `.tex` et `.py` sont distribués sous licence **MIT**. Voir le fichier `LICENSE` à la racine.

### Assets visuels

| Fichier | Auteur | Licence |
|---|---|---|
| `myrtille.jpg` | Ryan Hodnett ([Source](https://commons.wikimedia.org/wiki/File:Common_Bilberry_(Vaccinium_myrtillus)_-_Bergen,_Norway_2021-07-31_(03).jpg)) | [CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/deed.fr) |
| `acerola.jpg` | Marcelo P. B. Silva ([Source](https://commons.wikimedia.org/wiki/File:Acerola_Malpighia_glabra.jpg)) | [CC0 — Domaine Public](https://creativecommons.org/publicdomain/zero/1.0/deed.fr) |
| `pringlea.jpg` | Bruno Navez ([Source](https://commons.wikimedia.org/wiki/File:Pringlea_antiscorbutica.JPG)) | [CC-BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/deed.fr) |

> Pour toute réutilisation, veillez à maintenir les crédits aux auteurs originaux conformément aux termes des licences mentionnées.
