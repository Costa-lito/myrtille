% ============================================================
%  Myrtille Book — Classe LaTeX — Variante longue-forme (book)
% ============================================================
%  Ce travail est distribué sous licence MIT.
%
%  Dérivée indépendamment de myrtille.cls (même logique que
%  myrtillecv.cls) : cette classe duplique le socle commun
%  (palette, badges, boîtes, blocs de code, environnements
%  mathématiques, encadrés d'images, page de garde...) plutôt que
%  de le partager avec myrtille.cls. Toute modification de ces
%  composants dans myrtille.cls doit donc être reportée ici
%  manuellement si elle doit s'appliquer aussi aux livres.
%
%  Différences structurelles avec myrtille.cls (article) :
%   - Chargée sur 'book' en twoside+openright : chaque \chapter
%     démarre sur une page impaire (recto), avec insertion
%     automatique d'une page blanche si besoin (comportement
%     natif de book.cls).
%   - Marges miroir (inner/outer) au lieu de gauche/droite fixes.
%   - En-têtes alternés : le numéro de page + le repère courant
%     (chapitre/section) se déplacent au coin extérieur de la
%     page (coin gauche en page paire, coin droit en page
%     impaire) ; le texte fixe \headerleft occupe le coin
%     intérieur (côté reliure) des deux côtés.
%   - \chapter a son propre habillage (titlesec, forme "display").
%   - myrthm/myrdef sont numérotés par chapitre, pas par section.
% ============================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myrtillebook}[2026/09/21 v1.0 Classe Myrtille Book]


% ============================================================
% 1. OPTIONS DE CLASSE
% ============================================================

% -- Gestion de l'option "theme=..." via kvoptions -----------
% Famille/préfixe distincts de myrtille.cls (myrtillebk@ et non
% myrtille@), par cohérence avec l'isolation déjà pratiquée par
% myrtillecv.cls (famille myrtillecvr@).
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=myrtillebk,
  prefix=myrtillebk@
}
\DeclareStringOption[myrtille]{theme}

% Toutes les autres options (ex : 12pt, oneside) sont transmises
% telles quelles à la classe de base 'book'.
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{book}}

% Traitement exclusif des options par kvoptions (pas de \ProcessOptions ici)
\ProcessKeyvalOptions*

% Chargement de la classe de base : twoside + openright pour que
% chaque \chapter démarre sur une page impaire (recto).
\LoadClass[a4paper,10pt,twoside,openright]{book}

% -- Vocabulaire en français pour \chapter / \appendix --------
\renewcommand{\chaptername}{Chapitre}
\renewcommand{\appendixname}{Annexe}


% ============================================================
% 2. ENCODAGE ET POLICES
% ============================================================

% -- Encodage des caractères ----------------------------------
\RequirePackage[T1]{fontenc}

% -- Gestion des images ----------------------------------------
\RequirePackage{graphicx}

% -- Police sans-serif globale (Inter en remplacement d'Helvetica,
%    Fira Mono pour le code à chasse fixe) ------------------------
\RequirePackage[scaled=0.92]{inter}
\RequirePackage[scaled=1.20]{FiraMono}
\renewcommand{\familydefault}{\sfdefault}

% -- Mise à l'échelle relative des tailles de police --------------
% Permet à \ci (code en ligne) de conserver sa taille *relative*
% (un cran en dessous du texte courant) même dans des blocs où la
% taille de base change (\footnotesize, \Large, notes, tableaux...),
% au lieu de rester figée en \small quel que soit le contexte.
\RequirePackage{relsize}

% -- Compensation dans les blocs de code --------------------------
% Le "scaled=1.20" ci-dessus (ajusté pour que \ci s'harmonise avec
% Inter dans le texte courant) agrandit FiraMono PARTOUT, y compris
% dans les lstlisting/tcblisting. On corrige donc localement, dans
% le style de code (section 14), avec un facteur inverse pour que
% le rendu des blocs de code reste identique à ce qu'il était avec
% scaled=0.92. Si le scale de FiraMono est encore modifié plus tard,
% recalculer ce facteur = (ancien scaled) / (nouveau scaled).
\def\myrtillecoderevert{0.7667} % = 0.92 / 1.20
% relsize refuse par défaut de descendre sous la plus petite taille
% standard de la classe (\tiny) ; on relève ce plancher pour que le
% facteur ci-dessus s'applique aussi correctement à numberstyle
% (qui part de \tiny pour les numéros de ligne).
\renewcommand{\RSsmallest}{2pt}


% ============================================================
% 3. TABLE DES MATIÈRES
% ============================================================
\RequirePackage{tocloft}
\renewcommand{\cftchapfont}{\sffamily\bfseries\large\color{accent}}
\renewcommand{\cftchappagefont}{\sffamily\bfseries\large\color{accent}}
\renewcommand{\cftchapdotsep}{\cftnodots}
\setlength{\cftbeforechapskip}{12pt}
\renewcommand{\cftsecfont}{\sffamily\bfseries\color{dark}}
\renewcommand{\cftsecpagefont}{\sffamily\bfseries\color{accent}}
\renewcommand{\cftsecdotsep}{\cftnodots}
\renewcommand{\cftsubsecfont}{\sffamily\color{mid}}
\renewcommand{\cftsubsecpagefont}{\sffamily\color{mid}}
\renewcommand{\cftsubsubsecfont}{\sffamily\small\color{mid}}
\setlength{\cftbeforesecskip}{6pt}
\setlength{\cftbeforesubsecskip}{2pt}
\renewcommand{\contentsname}{}

% -- Correctif \tableofcontents (piège tocloft + book.cls) --------
% tocloft redéfinit lui-même \tableofcontents, mais SANS passer par
% \chapter* : il imprime juste le titre en ligne (\@cftmaketoctitle)
% puis \@starttoc{toc}, sans le moindre saut de page. Résultat : la
% table des matières se retrouve collée à la suite du texte qui la
% précède au lieu de démarrer sur sa propre page comme un vrai
% chapitre. On la redéfinit donc pour repasser explicitement par
% \chapter* (qui gère correctement page/style/titre), puis \@starttoc
% pour la liste elle-même (sans repasser par \chapter*, qui ne
% l'attend pas).
%
% tocloft ne fait sa propre redéfinition qu'au \AtBeginDocument (pour
% capturer les réglages finaux de l'utilisateur), donc si on redéfinit
% \tableofcontents ici directement, tocloft l'écraserait silencieuse-
% ment ensuite. On passe donc nous aussi par \AtBeginDocument : comme
% tocloft est chargé plus haut (donc son propre \AtBeginDocument est
% enregistré avant le nôtre), le nôtre s'exécute après et a le
% dernier mot.
\AtBeginDocument{%
  \renewcommand{\tableofcontents}{%
    \chapter*{\contentsname}%
    \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
    \@starttoc{toc}%
  }%
}


% ============================================================
% 4. MISE EN PAGE GÉNÉRALE
% ============================================================
% Marges miroir (inner/outer) plutôt que gauche/droite fixes :
% la marge intérieure (reliure) est plus généreuse que l'extérieure.
\RequirePackage[a4paper, twoside,
            top=20mm, bottom=22mm,
            inner=26mm, outer=18mm,
            headheight=22pt]{geometry}
\RequirePackage{parskip}          % Espacement entre paragraphes, sans indentation
\RequirePackage{setspace}
\RequirePackage{textcomp}
\setstretch{1.08}


% ============================================================
% 5. MATHÉMATIQUES
% ============================================================
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{amsthm}


% ============================================================
% 6. PALETTE DE COULEURS
% ============================================================
\RequirePackage{xcolor}
\RequirePackage{etoolbox}

% -- Normalisation du nom de thème ------------------------------
% Permet d'utiliser des alias courts (green/red/blue) en plus
% des noms de palette natifs (pringlea/acerola/myrtille).
\ifdefstring{\myrtillebk@theme}{green}{\def\myrtillebk@theme{pringlea}}{}
\ifdefstring{\myrtillebk@theme}{red}{\def\myrtillebk@theme{acerola}}{}
\ifdefstring{\myrtillebk@theme}{blue}{\def\myrtillebk@theme{myrtille}}{}
\ifdefstring{\myrtillebk@theme}{bw}{\def\myrtillebk@theme{betula}}{}
\ifdefstring{\myrtillebk@theme}{noir}{\def\myrtillebk@theme{betula}}{}
\ifdefstring{\myrtillebk@theme}{print}{\def\myrtillebk@theme{betula}}{}
\ifdefstring{\myrtillebk@theme}{grayscale}{\def\myrtillebk@theme{betula}}{}
\ifdefstring{\myrtillebk@theme}{}{\def\myrtillebk@theme{myrtille}}{}

% --- BEGIN PALETTE ---
\ifdefstring{\myrtillebk@theme}{betula}{
    % ---------------------------------------------------------
    % Palette Grayscale (Noir & Blanc, pensée pour l'impression)
    % ---------------------------------------------------------
    \definecolor{accent}      {HTML}{2B2B2B}
    \definecolor{accentDark}  {HTML}{000000}
    \definecolor{accentPale}  {HTML}{EDEDED}
    \definecolor{dark}        {HTML}{1A1A1A}
    \definecolor{coverBg}     {HTML}{F5F5F5}
    \definecolor{mid}         {HTML}{595959}
    \definecolor{light}       {HTML}{F2F2F2}
    \definecolor{border}      {HTML}{CCCCCC}
    \definecolor{tableHdr}    {HTML}{EDEDED}
    \definecolor{sidebarBg}   {HTML}{F5F5F5}
    \definecolor{coverAccent}{HTML}{CCCCCC}
    \definecolor{customPurple}{HTML}{4D4D4D}
    \colorlet{coverMuted}{mid}
    % -- Syntaxe & code --
    \definecolor{codeBg}      {HTML}{F5F5F5}
    \definecolor{codeText}    {HTML}{1A1A1A}
    \definecolor{codeKw}      {HTML}{000000}
    \definecolor{codeStr}     {HTML}{4D4D4D}
    \definecolor{codeCmt}     {HTML}{999999}
    \definecolor{inlineCode}  {HTML}{1A1A1A}
    \definecolor{inlineBg}    {HTML}{F0F0F0}
    % -- Sémantique --
    \definecolor{success}     {HTML}{404040}
    \definecolor{warn}        {HTML}{737373}
    \definecolor{warnDark}    {HTML}{262626}
    \definecolor{warnBg}      {HTML}{F2F2F2}
    \definecolor{infoGreen}   {HTML}{333333}
    \definecolor{infoBg}      {HTML}{F5F5F5}
}{
\ifdefstring{\myrtillebk@theme}{pringlea}{
    % ---------------------------------------------------------
    % Palette Pringlea (Vert)
    % ---------------------------------------------------------
    \definecolor{accent}      {HTML}{0D9488}
    \definecolor{accentDark}  {HTML}{0F766E}
    \definecolor{accentPale}  {HTML}{F0FDFA}
    \definecolor{dark}        {HTML}{0F172A}
    \definecolor{coverBg}     {HTML}{134E4A}
    \definecolor{mid}         {HTML}{475569}
    \definecolor{light}       {HTML}{F8FAFC}
    \definecolor{border}      {HTML}{E2E8F0}
    \definecolor{tableHdr}    {HTML}{F1F5F9}
    \definecolor{sidebarBg}   {HTML}{F8FAFC}
    \definecolor{coverAccent}{HTML}{5EEAD4}
    \definecolor{customPurple}{HTML}{6366F1}
    \colorlet{coverMuted}{white!50}
    % -- Syntaxe & code --
    \definecolor{codeBg}      {HTML}{F1F5F9}
    \definecolor{codeText}    {HTML}{1E293B}
    \definecolor{codeKw}      {HTML}{0D9488}
    \definecolor{codeStr}     {HTML}{0891B2}
    \definecolor{codeCmt}     {HTML}{94A3B8}
    \definecolor{inlineCode}  {HTML}{0F766E}
    \definecolor{inlineBg}    {HTML}{E6FFFA}
    % -- Sémantique --
    \definecolor{success}     {HTML}{059669}
    \definecolor{warn}        {HTML}{EA580C}
    \definecolor{warnDark}    {HTML}{7C2D12}
    \definecolor{warnBg}      {HTML}{FFF7ED}
    \definecolor{infoGreen}   {HTML}{2563EB}
    \definecolor{infoBg}      {HTML}{EFF6FF}
}{
\ifdefstring{\myrtillebk@theme}{acerola}{
    % ---------------------------------------------------------
    % Palette Acerola (Rouge)
    % ---------------------------------------------------------
    \definecolor{accent}      {HTML}{E11D48}
    \definecolor{accentDark}  {HTML}{9F1239}
    \definecolor{accentPale}  {HTML}{FFF1F2}
    \definecolor{dark}        {HTML}{18181B}
    \definecolor{coverBg}     {HTML}{4C0519}
    \definecolor{mid}         {HTML}{52525B}
    \definecolor{light}       {HTML}{FAFAFA}
    \definecolor{border}      {HTML}{E4E4E7}
    \definecolor{tableHdr}    {HTML}{FFF1F2}
    \definecolor{sidebarBg}   {HTML}{F4F4F5}
    \definecolor{coverAccent}{HTML}{FDA4AF}
    \definecolor{customPurple}{HTML}{7C3AED}
    \colorlet{coverMuted}{white!50}
    % -- Syntaxe & code --
    \definecolor{codeBg}      {HTML}{F8FAFC}
    \definecolor{codeText}    {HTML}{0F172A}
    \definecolor{codeKw}      {HTML}{BE123C}
    \definecolor{codeStr}     {HTML}{059669}
    \definecolor{codeCmt}     {HTML}{71717A}
    \definecolor{inlineCode}  {HTML}{E11D48}
    \definecolor{inlineBg}    {HTML}{FFE4E6}
    % -- Sémantique --
    \definecolor{success}     {HTML}{10B981}
    \definecolor{warn}        {HTML}{F59E0B}
    \definecolor{warnDark}    {HTML}{78350F}
    \definecolor{warnBg}      {HTML}{FEF3C7}
    \definecolor{infoGreen}   {HTML}{0EA5E9}
    \definecolor{infoBg}      {HTML}{F0F9FF}
}{
    % ---------------------------------------------------------
    % Palette Myrtille (Bleu, thème par défaut)
    % ---------------------------------------------------------
    \definecolor{accent}    {HTML}{0D6EFD}
    \definecolor{accentDark}{HTML}{0A4FA8}
    \definecolor{accentPale}{HTML}{E8F1FF}
    \definecolor{dark}      {HTML}{1A1D23}
    \definecolor{coverBg}   {HTML}{0F2A4A}
    \definecolor{mid}       {HTML}{4A5060}
    \definecolor{light}     {HTML}{F0F2F5}
    \definecolor{border}    {HTML}{D0D6E0}
    \definecolor{codeBg}    {HTML}{F1F4F9}
    \definecolor{codeText}  {HTML}{1A2540}
    \definecolor{codeKw}    {HTML}{0550AE}
    \definecolor{codeStr}   {HTML}{1A7F37}
    \definecolor{codeCmt}   {HTML}{7A8599}
    \definecolor{inlineCode}{HTML}{0D6EFD}
    \definecolor{inlineBg}  {HTML}{EEF3FF}
    \definecolor{success}   {HTML}{198754}
    \definecolor{warn}      {HTML}{FFC107}
    \definecolor{warnDark}  {HTML}{664D03}
    \definecolor{warnBg}    {HTML}{FFF8E1}
    \definecolor{infoGreen} {HTML}{0F5132}
    \definecolor{infoBg}    {HTML}{D1E7DD}
    \definecolor{tableHdr}  {HTML}{E8F1FF}
    \definecolor{sidebarBg} {HTML}{F6F8FC}
    \definecolor{coverAccent}{HTML}{6C95CB}
    \definecolor{customPurple}{HTML}{8E44AD}
    \colorlet{coverMuted}{white!50}
}
}
}
% --- END PALETTE ---

% -- Commande pour personnaliser la palette (surcharge manuelle) --
% Usage : \setmyrtillebookpalette{accent=FF0000, dark=222222, ...}
\RequirePackage{pgfkeys}
\pgfkeys{
 /myrtillebook/palette/.is family, /myrtillebook/palette,
 accent/.code={\definecolor{accent}{HTML}{#1}},
 accentDark/.code={\definecolor{accentDark}{HTML}{#1}},
 accentPale/.code={\definecolor{accentPale}{HTML}{#1}},
 dark/.code={\definecolor{dark}{HTML}{#1}},
 coverBg/.code={\definecolor{coverBg}{HTML}{#1}},
 mid/.code={\definecolor{mid}{HTML}{#1}},
 light/.code={\definecolor{light}{HTML}{#1}},
 border/.code={\definecolor{border}{HTML}{#1}},
 tableHdr/.code={\definecolor{tableHdr}{HTML}{#1}},
 sidebarBg/.code={\definecolor{sidebarBg}{HTML}{#1}},
 coverAccent/.code={\definecolor{coverAccent}{HTML}{#1}},
 coverMuted/.code={\definecolor{coverMuted}{HTML}{#1}},
 customPurple/.code={\definecolor{customPurple}{HTML}{#1}},
 codeBg/.code={\definecolor{codeBg}{HTML}{#1}},
 codeText/.code={\definecolor{codeText}{HTML}{#1}},
 codeKw/.code={\definecolor{codeKw}{HTML}{#1}},
 codeStr/.code={\definecolor{codeStr}{HTML}{#1}},
 codeCmt/.code={\definecolor{codeCmt}{HTML}{#1}},
 inlineCode/.code={\definecolor{inlineCode}{HTML}{#1}},
 inlineBg/.code={\definecolor{inlineBg}{HTML}{#1}},
 success/.code={\definecolor{success}{HTML}{#1}},
 warn/.code={\definecolor{warn}{HTML}{#1}},
 warnDark/.code={\definecolor{warnDark}{HTML}{#1}},
 warnBg/.code={\definecolor{warnBg}{HTML}{#1}},
 infoGreen/.code={\definecolor{infoGreen}{HTML}{#1}},
 infoBg/.code={\definecolor{infoBg}{HTML}{#1}}
}

\newcommand{\setmyrtillebookpalette}[1]{%
  \pgfkeys{/myrtillebook/palette, #1}%
}


% ============================================================
% 7. TIKZ (décorations page de garde + badges)
% ============================================================
\RequirePackage{tikz}
\usetikzlibrary{calc,positioning,shapes.geometric}

% -- Échantillon de couleur avec son code HTML affiché dessous --
\newcommand{\colorswatch}[1]{%
  \extractcolorspecs{#1}{\modele}{\valeur}%
  \convertcolorspec{\modele}{\valeur}{HTML}{\codeHex}%
  \begin{tikzpicture}
    \fill[#1, rounded corners=3pt] (0,0) rectangle (2.2,1.2);
    \node[below, font=\sffamily\scriptsize, text=mid, align=center] at (1.1,0) {\textbf{#1}\\\codeHex};
  \end{tikzpicture}\hspace{10pt}
}


% ============================================================
% 8. EN-TÊTES ET PIEDS DE PAGE (recto/verso alternés)
% ============================================================
% emptypage corrige un piège classique de LaTeX : par défaut,
% \cleardoublepage (utilisé par \chapter en mode openright) insère
% une page blanche pour forcer le chapitre suivant sur une page
% impaire, mais laisse le style de page courant (donc l'en-tête)
% actif sur cette page pourtant censée être vide. emptypage la
% force en \thispagestyle{empty} (aucun en-tête ni pied de page).
\RequirePackage{emptypage}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{1.2pt}
\renewcommand{\headrule}{%
  \vspace{2pt}%                    % Espace entre le texte et le liseré
  {\color{accent}\rule{\linewidth}{\headrulewidth}}%
}

% -- Repères courants : \leftmark = chapitre, \rightmark = section --
% (Pas de MAJUSCULES ni de "Chapitre N." forcé : on garde l'esthétique
%  sobre du reste de la charte.)
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}}

% -- Coin extérieur de la page : numéro + repère courant, qui
%    alternent de côté selon la parité (convention livre classique :
%    à gauche en page paire, à droite en page impaire). --
\fancyhead[LE]{\color{mid}\small\sffamily\thepage\quad\leftmark}
\fancyhead[RO]{\color{mid}\small\sffamily\rightmark\quad\thepage}

% -- Coin intérieur (côté reliure) : texte fixe piloté par \headerleft --
\fancyhead[RE]{\color{mid}\small\sffamily\@headerleft}
\fancyhead[LO]{\color{mid}\small\sffamily\@headerleft}

% -- Style "plain" : pages d'ouverture de chapitre (appliqué
%    automatiquement par \chapter). Pas de repère courant ni de
%    filet, seul le numéro de page reste, centré en pied de page. --
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\color{mid}\small\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
}


% ============================================================
% 9. NOTES DE BAS DE PAGE (symboliques)
% ============================================================
\RequirePackage[bottom, hang, flushmargin]{footmisc}
\setlength{\footnotemargin}{0.8em}

% -- Passage aux symboles (*, †, ‡, etc.) au lieu des chiffres --
\renewcommand{\thefootnote}{\fnsymbol{footnote}}

% -- Typographie des notes (méthode officielle footmisc) --------
\renewcommand{\footnotelayout}{\sffamily\color{mid}}

% -- Ligne de séparation personnalisée (sécurisée avec \kern/\hrule) --
\renewcommand{\footnoterule}{%
  \kern 6pt
  {\color{border}\hrule width 0.25\textwidth height 0.5pt}%
  \kern 4pt
}


% ============================================================
% 10. TITRES DE CHAPITRES ET DE SECTIONS
% ============================================================
\RequirePackage{titlesec}

% -- Chapitres numérotés : forme "display", libellé en accent au-
%    dessus du titre, filet de clôture en dessous. --
\titleformat{\chapter}[display]
  {\normalfont}
  {\sffamily\color{accent}\large\bfseries\MakeUppercase{\@chapapp}~\thechapter}
  {6pt}
  {\sffamily\color{dark}\huge\bfseries}
  [\vspace{6pt}{\color{border}\rule{\linewidth}{0.8pt}}\vspace{20pt}]
\titlespacing*{\chapter}{0pt}{0pt}{0pt}

% -- Chapitres non numérotés (\chapter*) : même gabarit, sans libellé --
\titleformat{name=\chapter,numberless}[display]
  {\normalfont}
  {}
  {0pt}
  {\sffamily\color{dark}\huge\bfseries}
  [\vspace{6pt}{\color{border}\rule{\linewidth}{0.8pt}}\vspace{20pt}]

% -- Sections numérotées : numéro dans une pastille colorée --
\titleformat{\section}{}{}{0pt}{%
  \normalfont\sffamily\Large\bfseries\color{dark}%
  \begin{tikzpicture}[baseline=0pt]
    \node[fill=accent, text=white, rounded corners=3pt,
      inner xsep=9pt, inner ysep=4pt, font=\normalsize\bfseries,
      anchor=base, yshift=1.5pt] {\thesection};
  \end{tikzpicture}\hspace{10pt}%
}
% -- Sections non numérotées (\section*) : titre simple --
\titleformat{name=\section,numberless}{}{}{0pt}{%
  \normalfont\sffamily\Large\bfseries\color{dark}%
}
\titlespacing*{\section}{0pt}{22pt}{8pt}

\titleformat{\subsection}{\sffamily\large\bfseries\color{accentDark}}{%
  \color{accentDark}\thesubsection}{8pt}{}
\titlespacing*{\subsection}{0pt}{14pt}{4pt}

\titleformat{\subsubsection}{\sffamily\normalsize\bfseries\color{mid}}{%
  \color{mid}\thesubsubsection}{8pt}{}
\titlespacing*{\subsubsection}{0pt}{10pt}{2pt}


% ============================================================
% 11. HYPERREF
% ============================================================
\RequirePackage{hyperref}
\hypersetup{colorlinks=true, linkcolor=accent, urlcolor=accent, citecolor=accent}


% ============================================================
% 12. LISTES
% ============================================================
\RequirePackage{enumitem}
\setlist[itemize]{leftmargin=1.4em, itemsep=3pt, topsep=4pt, label=\textcolor{accent}{\textbullet}}
\setlist[enumerate]{leftmargin=1.6em, itemsep=3pt, topsep=4pt, label=\textcolor{accent}{\arabic*.}}
\setlist[itemize,2]{label=\textcolor{mid}{--}}


% ============================================================
% 13. TABLEAUX
% ============================================================
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{colortbl}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\renewcommand{\arraystretch}{1.4}
\setlength{\arrayrulewidth}{0.4pt}


% ============================================================
% 14. BLOCS DE CODE (listings + tcolorbox)
% ============================================================
\RequirePackage{listings}

% -- Style de base commun à tous les langages --------------------
\lstdefinestyle{myrtillebase}{
  backgroundcolor = \color{codeBg},
  basicstyle = \linespread{1.18}\ttfamily\fontsize{7.6pt}{9pt}\selectfont\color{codeText},
  keywordstyle = \color{codeKw}\bfseries,
  stringstyle = \color{codeStr},
  commentstyle = \color{codeCmt}\itshape,
  numberstyle = \fontsize{6pt}{8pt}\selectfont\color{codeCmt},  numbers = left,
  numbersep = 10pt,
  breaklines = true,
  showstringspaces = false,
  frame = none,
  xleftmargin = 16pt,
  xrightmargin = 6pt,
  literate =
    {é}{{\symbol{233}}}1
    {è}{{\symbol{232}}}1
    {ê}{{\symbol{234}}}1
    {ë}{{\symbol{235}}}1
    {à}{{\symbol{224}}}1
    {â}{{\symbol{226}}}1
    {ç}{{\symbol{231}}}1
    {ô}{{\symbol{244}}}1
    {î}{{\symbol{238}}}1
    {ï}{{\symbol{239}}}1
    {û}{{\symbol{251}}}1
    {ù}{{\symbol{249}}}1
    {ü}{{\symbol{252}}}1
    {œ}{{\oe}}1
    {’}{{'}}1 % Gestion des apostrophes typographiques
    {µ}{{\ensuremath{\mu}}}1
    {ο}{{\symbol{111}}}1
}
\lstset{style=myrtillebase}

\RequirePackage{tcolorbox}
\tcbuselibrary{breakable, skins, listings, theorems}

% -- Macro génératrice de blocs de code (ultra générique) --------
% Usage : \newmyrtilleblock[options lstset]{nom}{langage}{couleur}
\newcommand{\newmyrtilleblock}[4][]{%
  \lstdefinestyle{#2_style}{
    style = myrtillebase,
    language = {#3},
    #1
  }
  \newtcblisting{#2}{
    breakable, listing only, listing style = #2_style, colback = codeBg, colframe = #4,
    arc = 4pt, leftrule = 3pt, rightrule = 0.4pt, toprule = 0.4pt, bottomrule = 0.4pt,
    top = 2pt, bottom = 2pt, left = 0pt, right = 4pt, before skip = 8pt, after skip = 8pt,
  }
}

% -- Environnements de code fournis par défaut --------------------
\newmyrtilleblock{pyblock}{Python}{accent}
\newmyrtilleblock[{morestring=[b]"}]{jsonblock}{}{mid}
\newmyrtilleblock[numbers=none, xleftmargin=12pt]{shblock}{}{codeCmt}

% Le bloc texblock permet d'échapper vers LaTeX avec |...|
\newmyrtilleblock[{escapeinside={||}}]{texblock}{[LaTeX]TeX}{accentDark}


% ============================================================
% 15. BOÎTES INFO / ATTENTION
% ============================================================
\newtcolorbox{infobox}[1][]{
  breakable, colback = accentPale, colframe = accent, arc = 3pt,
  leftrule = 4pt, rightrule = 0.4pt, toprule = 0.4pt, bottomrule = 0.4pt,
  left = 8pt, right = 8pt, top = 6pt, bottom = 6pt, before skip = 8pt, after skip = 8pt,
  fontupper = \sffamily\small\color{accentDark}, #1
}
\newtcolorbox{warnbox}[1][]{
  breakable, colback = warnBg, colframe = warn, arc = 3pt,
  leftrule = 4pt, rightrule = 0.4pt, toprule = 0.4pt, bottomrule = 0.4pt,
  left = 8pt, right = 8pt, top = 6pt, bottom = 6pt, before skip = 8pt, after skip = 8pt,
  fontupper = \sffamily\small\color{warnDark}, #1
}


% ============================================================
% 16. ENVIRONNEMENTS MATHÉMATIQUES (Théorèmes, Définitions)
% ============================================================
% Numérotés par CHAPITRE (et non par section comme dans myrtille.cls)
% : convention livre habituelle (ex. "Théorème 3.2" pour le 2e
% théorème du chapitre 3).

% -- Boîte pour les Théorèmes / Propriétés (couleur accent) -------
\newtcbtheorem[number within=chapter]{myrthm}{Théorème}%
{
  enhanced, breakable,
  colback = accentPale,
  colframe = accent,
  arc = 3pt,
  leftrule = 4pt, rightrule = 0.4pt, toprule = 0.4pt, bottomrule = 0.4pt,
  coltitle = accentDark,
  fonttitle = \sffamily\bfseries,
  description font = \sffamily\color{mid},
  separator sign = {\textbf{ -- }},
  attach title to upper,              % Fusionne le titre avec le corps
  after title = {\par\vspace{4pt}},   % Saut de ligne après le titre
  % -- Style du corps --
  left = 8pt, right = 8pt, top = 8pt, bottom = 8pt,
  before skip = 14pt, after skip = 14pt,
}{thm}

% -- Boîte pour les Définitions (couleur accentDark) ---------------
\newtcbtheorem[number within=chapter]{myrdef}{Définition}%
{
  enhanced, breakable,
  colback = light,
  colframe = accentDark,
  arc = 3pt,
  leftrule = 4pt, rightrule = 0.4pt, toprule = 0.4pt, bottomrule = 0.4pt,
  coltitle = accentDark!60!black,
  fonttitle = \sffamily\bfseries,
  description font = \sffamily\color{mid},
  separator sign = {\textbf{ -- }},
  attach title to upper,              % Fusionne le titre avec le corps
  after title = {\par\vspace{4pt}},   % Saut de ligne après le titre
  % -- Style du corps --
  left = 8pt, right = 8pt, top = 8pt, bottom = 8pt,
  before skip = 14pt, after skip = 14pt,
}{def}


% ============================================================
% 17. BADGES / TAGS INLINE
% ============================================================
\newcommand{\ci}[1]{\texttt{\smaller\color{inlineCode}#1}}
\newcommand{\badge}[2][accent]{%
  \tikz[baseline=-2.5pt]{\node[fill=#1!15, draw=#1!40, text=#1, rounded corners=2pt,
    inner xsep=4pt, inner ysep=1.5pt, font=\ttfamily\tiny\bfseries] {#2};}%
}
\newcommand{\badgeReq}{\badge[success]{Requis}}
\newcommand{\badgeOpt}{\badge[mid]{Optionnel}}
\newcommand{\badgeInt}{\badge[accent]{int}}
\newcommand{\badgeFloat}{\badge[accent]{float}}
\newcommand{\badgeStr}{\badge[accent]{str}}
\newcommand{\badgeMat}{\badge[accentDark]{mat}}
\newcommand{\badgePolar}{\badge[accentDark]{polar}}
\newcommand{\badgeNouveau}{\badge[infoGreen]{Nouveau}}
\newcommand{\badgePerso}{\badge[customPurple]{Spécial}}


% ============================================================
% 18. LIGNE DE SÉPARATION
% ============================================================
\newcommand{\hrulefull}{\vspace{2pt}\noindent\textcolor{border}{\rule{\linewidth}{0.5pt}}\vspace{6pt}}


% ============================================================
% 19. NOTE DE MARGE LATÉRALE SIMULÉE
% ============================================================
\newcommand{\sidenote}[1]{%
  \begin{tcolorbox}[colback=sidebarBg, colframe=border, arc=3pt, left=8pt, right=8pt, top=5pt, bottom=5pt,
    before skip=6pt, after skip=6pt, fontupper=\sffamily\footnotesize\color{mid}]#1\end{tcolorbox}%
}


% ============================================================
% 20. ENCADRÉS D'IMAGES
% ============================================================

% -- imgbox : carte image moderne ---------------------------------
% Usage :
%   \begin{imgbox}[largeur]{Légende}{chemin/image}
%     Texte optionnel sous l'image
%   \end{imgbox}
%
% (Note : la signature réelle est \begin{imgbox}[#1 largeur]{#2 légende}{#3 chemin},
%  voir la définition ci-dessous.)

% -- Variables utilisées pour mesurer l'image --
\newsavebox{\myrtilleimgbox}
\newlength{\myrtilleimgwidth}

\newenvironment{imgbox}[3][]{%
  \vspace{10pt}\noindent\centering

  % 1. Mesure et ajustement de l'image
  \sbox{\myrtilleimgbox}{%
    \def\tempwidth{#2}%
    \ifx\tempwidth\empty
      \includegraphics{#3}%
    \else
      \includegraphics[width=#2]{#3}%
    \fi
  }%
  \setlength{\myrtilleimgwidth}{\wd\myrtilleimgbox}%

  % 2. Sécurité : l'image ne doit jamais dépasser la largeur de la page
  \ifdim\dimexpr\myrtilleimgwidth+3pt\relax>\linewidth
    \setlength{\myrtilleimgwidth}{\dimexpr\linewidth-3pt\relax}%
    \sbox{\myrtilleimgbox}{\includegraphics[width=\myrtilleimgwidth]{#3}}%
  \fi

  % 3. Boîte externe : fin contour tout autour + liseré épais à gauche
  \begin{tcolorbox}[
    enhanced, colback=white, colframe=accent,
    boxrule=0.4pt, % Fin contour bleu sur tout le pourtour
    leftrule=3pt,  % Liseré épais à gauche
    arc=6pt,
    shadow={0pt}{-2pt}{6pt}{black!8},
    left=0pt, right=0pt, top=0pt, bottom=0pt, boxsep=0pt,
    width=\dimexpr\myrtilleimgwidth+3pt\relax,
    center,
    clip upper % Coupe le coin haut-gauche de l'image pour épouser la bordure arrondie
  ]
    \usebox{\myrtilleimgbox}%
    \par\noindent

    % 4. Boîte interne (légende)
    \begin{tcolorbox}[
      enhanced, colback=accentPale,
      frame hidden, boxrule=0pt,
      arc=4pt, sharp corners=north, % S'imbrique parfaitement dans l'arrondi du bas
      left=8pt, right=8pt, top=6pt, bottom=6pt,
      before skip=0pt, after skip=0pt,
      fontupper=\sffamily\small\color{dark},
      width=\myrtilleimgwidth
    ]
      \def\tempcaption{#1}%
      \ifx\tempcaption\empty\else
        {\bfseries\color{accentDark}#1}\par\vspace{2pt}%
      \fi
}{%
    \end{tcolorbox}
  \end{tcolorbox}
  \vspace{10pt}
}

% -- imgfloat : image + texte côte à côte -------------------------
% Usage :
%   \begin{imgfloat}{chemin/image}
%     Texte descriptif à droite de l'image
%   \end{imgfloat}
\newtcolorbox{imgfloat@inner}[1][]{
  breakable, colback = accentPale, colframe = accentDark, arc = 4pt,
  leftrule = 3pt, rightrule = 0.4pt, toprule = 0.4pt, bottomrule = 0.4pt,
  left = 0pt, right = 8pt, top = 8pt, bottom = 8pt,
  before skip = 10pt, after skip = 10pt,
  sidebyside, sidebyside align = top,
  lefthand width = 0.38\linewidth,
  fontupper = \sffamily\small\color{dark},
  fontlower = \sffamily\small\color{dark},
  #1
}
\newenvironment{imgfloat}[1]{
  \begin{imgfloat@inner}
    \centering
    \includegraphics[width=\linewidth, keepaspectratio]{#1}
    \tcblower
}{%
  \end{imgfloat@inner}
}

% -- imgsidenote : miniature dans une note latérale -----------------
% Usage : \imgsidenote{chemin/image}{Texte de la note}
\newcommand{\imgsidenote}[2]{%
  \begin{tcolorbox}[colback=sidebarBg, colframe=border, arc=3pt,
    left=6pt, right=6pt, top=6pt, bottom=6pt,
    before skip=6pt, after skip=6pt,
    sidebyside, sidebyside align=center,
    lefthand width=0.22\linewidth,
    fontupper=\sffamily\footnotesize\color{mid},
    fontlower=\sffamily\footnotesize\color{mid}]
    \includegraphics[width=\linewidth, keepaspectratio]{#1}
    \tcblower
    #2
  \end{tcolorbox}%
}

% -- \myrfig : figure numérotée rapide Myrtille --------------------
% Usage : \myrfig[width=0.6\linewidth]{chemin/image}{Légende}
% (Numérotée "chapitre.figure" automatiquement, book.cls réinitialise
%  le compteur \figure à chaque \chapter.)
\newcommand{\myrfig}[3][width=0.7\linewidth]{%
  \begin{figure}[htbp]
    \centering
    % 1. Mesure de l'image (réutilise les variables de imgbox)
    \sbox{\myrtilleimgbox}{%
      \includegraphics[#1]{#2}%
    }%
    \setlength{\myrtilleimgwidth}{\wd\myrtilleimgbox}%

    % 2. Sécurité : ajustement si l'image est plus large que la page
    \ifdim\dimexpr\myrtilleimgwidth+3.4pt\relax>\linewidth
      \setlength{\myrtilleimgwidth}{\dimexpr\linewidth-3.4pt\relax}%
      \sbox{\myrtilleimgbox}{\includegraphics[width=\myrtilleimgwidth]{#2}}%
    \fi

    % 3. Conteneur principal unifié
    \begin{tcolorbox}[
      enhanced,
      width=\dimexpr\myrtilleimgwidth+3.4pt\relax, % Image + bordures (3pt gauche, 0.4pt droite)
      center,
      colback=white,
      colframe=accentDark,
      boxrule=0.4pt,
      leftrule=3pt,
      arc=4pt,
      shadow={0pt}{-2pt}{6pt}{black!8},
      left=0pt, right=0pt, top=0pt, bottom=0pt, boxsep=0pt,
      clip upper % Coupe les coins de l'image pour épouser la bordure
    ]
      \usebox{\myrtilleimgbox}%
      \par\nointerlineskip\noindent % Supprime l'espace parasite sous l'image

      % 4. Bande de légende imbriquée
      \begin{tcolorbox}[
        enhanced,
        colback=light,
        frame hidden,
        boxrule=0pt,
        arc=4pt,
        sharp corners=north, % S'emboîte parfaitement sous l'image
        left=8pt, right=8pt, top=5pt, bottom=5pt,
        before skip=0pt, after skip=0pt,
        width=\myrtilleimgwidth,
        fontupper=\sffamily\footnotesize\raggedright
      ]
        \refstepcounter{figure}% Incrémentation native pour compatibilité avec \label
        \textbf{\color{accentDark}Figure~\thefigure}\enspace{\color{dark}#3}
      \end{tcolorbox}
    \end{tcolorbox}
  \end{figure}
}


% ============================================================
% 21. PAGE DE GARDE
% ============================================================

% -- Variables de la page de garde --------------------------------
\def\@doctype{DOCUMENTATION}
\newcommand{\doctype}[1]{\def\@doctype{#1}}

\def\@title{Titre du document}
\renewcommand{\title}[1]{\def\@title{#1}}

\def\@subtitle{Sous-titre}
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}

\def\@coverfeatures{}
\newcommand{\coverfeatures}[1]{\def\@coverfeatures{#1}}

\def\@coverfooter{}
\newcommand{\coverfooter}[1]{\def\@coverfooter{#1}}

\def\@headerleft{}
\newcommand{\headerleft}[1]{\def\@headerleft{#1}}

% Interrupteur pour afficher le badge de version (désactivé par défaut)
\newif\ifshowversion
\showversionfalse

\def\@version{}
% Si l'utilisateur définit une version, l'affichage du badge
% est automatiquement activé.
\newcommand{\version}[1]{%
  \def\@version{#1}%
  \showversiontrue
}

% -- Commande de page de garde -------------------------------------
% Deux variantes selon le thème : la variante couleur (fond plein
% page) pour myrtille/pringlea/acerola, et une variante allégée pour
% le thème betula, pensée pour l'impression (fond blanc, cadre
% fin, pas d'aplat foncé sur toute la page).
%
% Après \makecover, le compteur de page est remis à 1 : dans un
% livre on enchaîne typiquement avec \frontmatter (numérotation
% romaine) puis \mainmatter (remet à 1 en chiffres arabes), qui
% écraseront ce \setcounter à leur tour -- c'est sans effet de bord.
\ifdefstring{\myrtillebk@theme}{betula}{
  \newcommand{\makecover}{%
    \hypersetup{pageanchor=false} % Désactive l'ancrage PDF pour la page de garde
    \begin{titlepage}
    \thispagestyle{empty}
    \begin{tikzpicture}[remember picture, overlay]
      \begin{scope}[shift={(current page.south west)}]
        % 1. Cadre fin tout autour de la page (très peu d'encre, pas de bavure)
        \path[draw=dark, line width=0.8pt] (0.6, 0.6) rectangle (20.4, 29.1);

        % 2. Cercle décoratif en simple contour (pas de remplissage)
        \path[draw=border, line width=0.6pt] (18.0, 4.0) circle (6.0cm);
      \end{scope}
      % Le badge de version ne s'affiche que si \showversiontrue
      \ifshowversion
        \node[fill=accent!12, draw=accent!45, text=accentDark,
              rounded corners=3pt, font=\sffamily\small\bfseries,
              inner xsep=8pt, inner ysep=4pt]
          at ($(current page.north east)+(-3cm,-1.8cm)$) {\@version};
      \fi
    \end{tikzpicture}

    \vspace*{4.5cm}
    \hspace*{1cm}%
    \begin{minipage}{0.85\textwidth}
      {\color{accent}\sffamily\footnotesize\bfseries\MakeUppercase{\@doctype}}
      \vspace{0.3cm}\\
      {\color{dark}\fontsize{46}{52}\selectfont\sffamily\bfseries \@title}
      \vspace{0.5cm}\\
      {\color{mid}\large\sffamily \@subtitle}
      \vspace{1.4cm}\\
      \@coverfeatures
      \vspace{0.5cm}\\
      {\color{mid}\sffamily\footnotesize \@coverfooter}
    \end{minipage}
    \end{titlepage}
    \hypersetup{pageanchor=true} % Réactive l'ancrage PDF pour la suite du document
    \setcounter{page}{1}
  }
}{
  \newcommand{\makecover}{%
    \hypersetup{pageanchor=false} % Désactive l'ancrage PDF pour la page de garde
    \begin{titlepage}
    \thispagestyle{empty}
    \begin{tikzpicture}[remember picture, overlay]
      \begin{scope}[shift={(current page.south west)}]
        % 1. Fond plein (couvre toute la page A4)
        \path[fill=coverBg] (0.0, 29.7) rectangle (21.0, 0.0);

        % 2. Liseré vif à gauche
        \path[fill=accent] (0.0, 29.7) rectangle (0.2, 0.0);

        % 3. Grand cercle décoratif
        \path[fill=coverAccent, opacity=0.2] (18.0, 4.0) circle (6.0cm);

        % 4. Petit cercle décoratif
        \path[fill=accent, opacity=0.1] (20.0, 7.0) circle (4.0cm);
      \end{scope}
      % Le badge de version ne s'affiche que si \showversiontrue
      \ifshowversion
        \node[fill=accent!20, draw=accent!50, text=accent!80,
              rounded corners=3pt, font=\sffamily\small\bfseries,
              inner xsep=8pt, inner ysep=4pt]
          at ($(current page.north east)+(-3cm,-1.8cm)$) {\@version};
      \fi
    \end{tikzpicture}

    \vspace*{4.5cm}
    \hspace*{1cm}%
    \begin{minipage}{0.85\textwidth}
      {\color{accent}\sffamily\footnotesize\bfseries\MakeUppercase{\@doctype}}
      \vspace{0.3cm}\\
      {\color{white}\fontsize{46}{52}\selectfont\sffamily\bfseries \@title}
      \vspace{0.5cm}\\
      {\color{white!70}\large\sffamily \@subtitle}
      \vspace{1.4cm}\\
      \@coverfeatures
      \vspace{0.5cm}\\
      {\color{white!35}\sffamily\footnotesize \@coverfooter}
    \end{minipage}
    \end{titlepage}
    \hypersetup{pageanchor=true} % Réactive l'ancrage PDF pour la suite du document
    \setcounter{page}{1}
  }
}

% ============================================================
% 22. TITRE COMPACT (alternative légère à la page de garde)
% ============================================================
% \makecoversimple réutilise les mêmes variables que \makecover
% (\doctype, \title, \subtitle, \version, \coverfooter) mais les
% affiche en un simple bandeau en haut de la première page, sans
% consommer une page entière. Comme pour myrtille.cls, pensé pour
% un usage ponctuel (rapport, avant-propos) plutôt que pour chaque
% chapitre d'un livre.
%
% Usage : appeler \makecoversimple juste après \begin{document},
% à la place de \makecover. Le contenu du document (TOC, sections...)
% s'enchaîne normalement juste en dessous, sur la même page.
\fancypagestyle{myrtillesimpletitle}{%
  \fancyhf{}%
  \fancyfoot[C]{\color{mid}\small\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
}
\newcommand{\makecoversimple}{%
  \thispagestyle{myrtillesimpletitle}%
  \noindent{\color{accent}\rule{\linewidth}{2.5pt}}\par
  \vspace{12pt}
  \noindent{\color{accent}\sffamily\footnotesize\bfseries\MakeUppercase{\@doctype}}%
  \ifshowversion\hfill{\tikz[baseline=-3pt]{\node[fill=accent!15, draw=accent!40, text=accent, rounded corners=3pt, inner xsep=7pt, inner ysep=3pt, font=\sffamily\small\bfseries] {\@version};}}\fi\par
  \vspace{4pt}
  \noindent{\color{dark}\fontsize{28}{32}\selectfont\sffamily\bfseries \@title}\par
  \def\tempsubtitle{\@subtitle}%
  \ifx\tempsubtitle\@empty\else
    \vspace{5pt}
    \noindent{\color{mid}\large\sffamily \@subtitle}\par
  \fi
  \def\tempfooter{\@coverfooter}%
  \ifx\tempfooter\@empty\else
    \vspace{9pt}
    \noindent{\color{mid}\footnotesize\sffamily \@coverfooter}\par
  \fi
  \vspace{10pt}
}
