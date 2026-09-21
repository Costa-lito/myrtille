# 🫐 Myrtille

**Myrtille** est une classe LaTeX (`.cls`) moderne et épurée, conçue pour rédiger des documents techniques, des manuels ou tout autre type de documentation. Elle masque la complexité du préambule LaTeX pour offrir une expérience de rédaction fluide et centralisée.

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
- **Classe CV dédiée (`myrtillecv.cls`)** — Variante dérivée de `myrtille.cls`, pensée pour un CV sobre en une colonne (esprit académique / recherche), avec ses propres macros (`\cvname`, `\cvheadline`, `\cvlocation`, `\makecvheader`...) et compatible avec les mêmes thèmes de couleur

---

## Thèmes disponibles

Contrairement à une architecture à une classe par thème, **`myrtille.cls` est un fichier unique** : le thème se choisit via l'option `theme=` à l'appel de la classe.

```latex
\documentclass[theme=pringlea]{myrtille}
```

| Thème | Option `theme=` | Couleur principale | Ambiance |
|---|---|---|---|
| **Myrtille** *(défaut)* | `myrtille` (alias `blue`) | Bleu `#0D6EFD` | Sobre, technique, classique |
| **Pringlea** | `pringlea` (alias `green`) | Vert canard `#0D9488` | Sérieux, professionnel, naturel |
| **Acerola** | `acerola` (alias `red`) | Rouge cerise `#E11D48` | Dynamique, moderne, expressif |
| **Betula** | `betula` (alias `bw`, `noir`, `print`, `grayscale`) | Niveaux de gris `#2B2B2B` | Impression noir et blanc |

`myrtillecv.cls` accepte la même option `theme=` pour les CV.

---

## Exemples fournis

Le dossier `Exemples/source/` contient un document de démonstration par thème, ainsi que deux cas d'usage concrets :

| Fichier | Démontre |
|---|---|
| `myrtille.tex` | Thème Myrtille (bleu, défaut) — guide complet des composants de la classe |
| `pringlea.tex` | Thème Pringlea (vert canard) |
| `acerola.tex` | Thème Acerola (rouge cerise) |
| `betula.tex` | Thème Betula (niveaux de gris, impression N&B) |
| `cours_pringlea.tex` | Polycopié de cours rédigé avec `myrtille.cls` (thème Pringlea) |
| `cv_pringlea.tex` | CV rédigé avec `myrtillecv.cls` (thème Pringlea) |

---

## Compiler les exemples

Le projet est préconfiguré (`.latexmkrc` + `.vscode/settings.json`) pour séparer proprement les sorties de compilation :
- le **PDF final** est généré dans `Exemples/`
- les **fichiers auxiliaires** (`.aux`, `.log`, `.toc`, `.fls`, `.fdb_latexmk`, `.synctex.gz`...) sont générés dans `Exemples/source/build/`

### Avec VS Code (recommandé)

1. Installez l'extension **LaTeX Workshop**.
2. Ouvrez le dossier racine du projet — la configuration est déjà prête, rien à modifier.
3. Ouvrez un fichier `.tex` dans `Exemples/source/` et lancez la compilation (flèche verte).

### En ligne de commande

```bash
latexmk -r .latexmkrc -synctex=1 -interaction=nonstopmode -file-line-error -pdf Exemples/source/pringlea.tex
```

---

## Structure du dépôt

```
myrtille_V2/
├── myrtille.cls           ← Classe principale (documents), thèmes via theme=...
├── myrtillecv.cls          ← Classe dérivée pour CV, mêmes thèmes
├── .latexmkrc               ← Config latexmk (aux_dir / out_dir / TEXINPUTS)
├── .vscode/
│   └── settings.json        ← Config LaTeX Workshop (recette latexmk -r .latexmkrc)
└── Exemples/
    ├── *.pdf                ← PDF compilés (versionnés, aperçu du rendu)
    └── source/
        ├── betula.tex
        ├── pringlea.tex
        ├── acerola.tex
        ├── myrtille.tex
        ├── cours_pringlea.tex
        ├── cv_pringlea.tex
        ├── pictures/         ← Images utilisées par les exemples
        └── build/            ← Fichiers auxiliaires (générés, non versionnés)
```

---

## Ajouter un nouveau thème

Les palettes ne sont pas générées par un script externe : elles sont regroupées directement dans `myrtille.cls`, sous forme de blocs conditionnels (section « Palette de couleurs ») :

```latex
\ifdefstring{\myrtille@theme}{betula}{
    % ... couleurs du thème betula ...
}{
\ifdefstring{\myrtille@theme}{pringlea}{
    % ... couleurs du thème pringlea ...
}{
    % ...
}}
```

Pour ajouter un thème :

1. Dupliquez un bloc `\ifdefstring{\myrtille@theme}{...}{...}` existant dans `myrtille.cls` et définissez vos propres couleurs (`accent`, `accentDark`, `accentPale`, `dark`, `coverBg`, couleurs de code, couleurs sémantiques...).
2. Ajoutez, si besoin, un alias court dans le bloc de normalisation juste au-dessus (ex. `\ifdefstring{\myrtille@theme}{violet}{\def\myrtille@theme{montheme}}{}`).
3. Utilisez `\documentclass[theme=montheme]{myrtille}` dans un nouveau document.

---

## Design de la couverture

Le fond de la page de garde (`\makecover`) est entièrement vectoriel : dessiné directement en TikZ dans `myrtille.cls`, sans aucune image externe. Le PDF final ne dépend donc d'aucun asset graphique pour son habillage de couverture.

---

## Licences

### Code source

Les fichiers `.cls` et `.tex` sont distribués sous licence **MIT** (voir l'en-tête de chaque fichier).

### Assets visuels

| Fichier | Auteur | Licence |
|---|---|---|
| `myrtille.jpg` | Ryan Hodnett ([Source](https://commons.wikimedia.org/wiki/File:Common_Bilberry_(Vaccinium_myrtillus)_-_Bergen,_Norway_2021-07-31_(03).jpg)) | [CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/deed.fr) |
| `pringlea.jpg` | Bruno Navez ([Source](https://commons.wikimedia.org/wiki/File:Pringlea_antiscorbutica.JPG)) | [CC-BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/deed.fr) |
| `acerola.jpg` | Marcelo P. B. Silva ([Source](https://commons.wikimedia.org/wiki/File:Acerola_Malpighia_glabra.jpg)) | [CC0 — Domaine Public](https://creativecommons.org/publicdomain/zero/1.0/deed.fr) |
| `birch.jpg` *(thème Betula)* | joeldinda, « Birches » ([Source](https://www.flickr.com/photos/96739609@N00/9516542874)) | [CC-BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/) |

> Pour toute réutilisation, veillez à maintenir les crédits aux auteurs originaux conformément aux termes des licences mentionnées. `birch.jpg` étant sous licence *NonCommercial*, l'exemple compilé `betula.pdf` est distribué sous [CC-BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fr) plutôt que CC-BY-SA 4.0.
