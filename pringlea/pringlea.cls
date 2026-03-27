% This work is distributed under the MIT License.
% ============================================================
%  Pringlea — Charte Graphique — Style moderne
% ============================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pringlea}[2024/10/25 v1.0 Classe Myrtille]

% On passe toutes les options à la classe de base 'article'
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Chargement de la classe de base
\LoadClass[a4paper,10pt]{article}

% ── Encodage ─────────────────────────────────────────────────
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}

% ── Images ───────────────────────────────────────────────────
\RequirePackage{graphicx}

% ── Police sans-serif globale (Helvetica / Courier) ──────────
\RequirePackage[scaled=0.92]{inter}
\RequirePackage{courier}
\renewcommand{\familydefault}{\sfdefault}

% ── Mise en page ─────────────────────────────────────────────
\RequirePackage[a4paper,
            top=20mm, bottom=22mm,
            left=20mm, right=20mm,
            headheight=22pt]{geometry}
\RequirePackage{parskip}          % espacement entre paragraphes, pas d'indentation
\RequirePackage{setspace}
\RequirePackage{textcomp}
\setstretch{1.08}

% ── Mathématiques ────────────────────────────────────────────
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{amsthm}

% ── Couleurs ─────────────────────────────────────────────────
\RequirePackage{xcolor}

% --- BEGIN PALETTE ---
% --- Palette Principale Pringlea (Sérieux & Moderne) ---
\definecolor{accent}      {HTML}{0D9488} % Vert Canard / Teal (Sérieux, pro et moderne)
\definecolor{accentDark}  {HTML}{0F766E} % Sarcelle sombre (Pour titres et boutons)
\definecolor{accentPale}  {HTML}{F0FDFA} % Givre de mer très clair (Fonds de section)
\definecolor{dark}        {HTML}{0F172A} % Bleu-Ardoise très sombre (Texte principal ultra-net)
\definecolor{coverBg}     {HTML}{134E4A} % Vert forêt profond (Remplace le marine, très statutaire)
\definecolor{mid}         {HTML}{475569} % Gris acier (Texte secondaire)
\definecolor{light}       {HTML}{F8FAFC} % Blanc bleuté (Fond clean)
\definecolor{border}      {HTML}{E2E8F0} % Gris bordure pro
\definecolor{tableHdr}    {HTML}{F1F5F9} % Gris neutre (Entêtes)
\definecolor{sidebarBg}   {HTML}{F8FAFC} % Fond latéral
\definecolor{coverAccent}{HTML}{5EEAD4} % Aquamarine clair (Éclat sur fond sombre)
\definecolor{customPurple}{HTML}{6366F1} % Indigo (Pour le contraste ponctuel)

% --- Syntaxe & Code ---
\definecolor{codeBg}      {HTML}{F1F5F9} 
\definecolor{codeText}    {HTML}{1E293B} 
\definecolor{codeKw}      {HTML}{0D9488} % Keywords en Teal
\definecolor{codeStr}     {HTML}{0891B2} % Strings Cyan profond
\definecolor{codeCmt}     {HTML}{94A3B8} 
\definecolor{inlineCode}  {HTML}{0F766E} 
\definecolor{inlineBg}    {HTML}{E6FFFA} 

% --- Sémantique (Équilibrée) ---
\definecolor{success}     {HTML}{059669} % Vert standard succès
\definecolor{warn}        {HTML}{EA580C} % Orange brûlé (Plus sérieux que le jaune)
\definecolor{warnDark}    {HTML}{7C2D12} 
\definecolor{warnBg}      {HTML}{FFF7ED} 
\definecolor{infoGreen}   {HTML}{2563EB} % Bleu conservé pour l'INFO (Rappel de fiabilité)
\definecolor{infoBg}      {HTML}{EFF6FF}
% --- END PALETTE ---

% ── TikZ (décorations page de garde + badges) ────────────────
\RequirePackage{tikz}
\usetikzlibrary{calc,positioning,shapes.geometric}

\newcommand{\colorswatch}[2]{%
  \begin{tikzpicture}
    \fill[#1, rounded corners=3pt] (0,0) rectangle (2.2,1.2);
    \node[below, font=\sffamily\scriptsize, text=mid, align=center] at (1.1,0) {\textbf{#1}\\#2};
  \end{tikzpicture}\hspace{10pt}
}

% ── En-têtes / pieds ─────────────────────────────────────────
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{1.2pt}
\renewcommand{\headrule}{%
  \vspace{2pt}%                    % espace entre texte et liseré
  {\color{accent}\rule{\linewidth}{\headrulewidth}}%
}
% On remplace le texte codé en dur par la variable \@headerleft
\fancyhead[L]{\color{mid}\small\sffamily\@headerleft}
\fancyhead[R]{\color{mid}\small\sffamily\leftmark}
\fancyfoot[C]{\color{mid}\small\thepage}

% ── Notes de bas de page (Symboliques) ───────────────────────
\RequirePackage[bottom, hang, flushmargin]{footmisc}
\setlength{\footnotemargin}{0.8em}

% Passage aux symboles (*, †, ‡, etc.) au lieu des chiffres
\renewcommand{\thefootnote}{\fnsymbol{footnote}}

% Application de la typographie Myrtille (Méthode officielle footmisc)
\renewcommand{\footnotelayout}{\sffamily\color{mid}}

% Ligne de séparation personnalisée (Sécurisée avec \kern et \hrule)
\renewcommand{\footnoterule}{%
  \kern 6pt
  {\color{border}\hrule width 0.25\textwidth height 0.5pt}%
  \kern 4pt
}

% ── Titres de sections ───────────────────────────────────────
\RequirePackage{titlesec}
\titleformat{\section}{}{}{0pt}{%
  \normalfont\sffamily\Large\bfseries\color{dark}%
  \begin{tikzpicture}[baseline=0pt] 
    \node[fill=accent, text=white, rounded corners=3pt,
      inner xsep=9pt, inner ysep=4pt, font=\normalsize\bfseries,
      anchor=base, yshift=1.5pt] {\thesection};
  \end{tikzpicture}\hspace{10pt}%
}
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

% ── Hyperref ─────────────────────────────────────────────────
\RequirePackage{hyperref}
\hypersetup{colorlinks=true, linkcolor=accent, urlcolor=accent, citecolor=accent}

% ── Table des matières ───────────────────────────────────────
\RequirePackage{tocloft}
\renewcommand{\cftsecfont}{\sffamily\bfseries\color{dark}}
\renewcommand{\cftsecpagefont}{\sffamily\bfseries\color{accent}}
\renewcommand{\cftsecdotsep}{\cftnodots}
\renewcommand{\cftsubsecfont}{\sffamily\color{mid}}
\renewcommand{\cftsubsecpagefont}{\sffamily\color{mid}}
\renewcommand{\cftsubsubsecfont}{\sffamily\small\color{mid}}
\setlength{\cftbeforesecskip}{6pt}
\setlength{\cftbeforesubsecskip}{2pt}
\renewcommand{\contentsname}{}   

% ── Listes ───────────────────────────────────────────────────
\RequirePackage{enumitem}
\setlist[itemize]{leftmargin=1.4em, itemsep=3pt, topsep=4pt, label=\textcolor{accent}{\textbullet}}
\setlist[enumerate]{leftmargin=1.6em, itemsep=3pt, topsep=4pt, label=\textcolor{accent}{\arabic*.}}
\setlist[itemize,2]{label=\textcolor{mid}{--}}

% ── Tableaux ─────────────────────────────────────────────────
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{colortbl}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\renewcommand{\arraystretch}{1.4}
\setlength{\arrayrulewidth}{0.4pt}

\RequirePackage{listings}

% ── Style de base commun à tous les langages ─────────────────
\RequirePackage{listings}

% ── Style de base commun à tous les langages ─────────────────
\lstdefinestyle{myrtillebase}{
  backgroundcolor = \color{codeBg},
  basicstyle = \ttfamily\footnotesize\color{codeText},
  keywordstyle = \color{codeKw}\bfseries,
  stringstyle = \color{codeStr},
  commentstyle = \color{codeCmt}\itshape,
  numberstyle = \tiny\color{codeCmt},
  numbers = left,
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

% ── Macro génératrice de blocs de code (Ultra générique) ─────
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

% ── Création de vos environnements par défaut ────────────────
\newmyrtilleblock{pyblock}{Python}{accent}
\newmyrtilleblock[{morestring=[b]"}]{jsonblock}{}{mid}
\newmyrtilleblock[numbers=none, xleftmargin=12pt]{shblock}{}{codeCmt}

% Le bloc texblock avec le caractère '!' qui agit comme un faux antislash
\newmyrtilleblock{texblock}{[LaTeX]TeX}{accentDark}

% ── Boîtes Info / Attention ───────────────────────────────────
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

% ── Environnements Mathématiques (Théorèmes, Définitions) ────

% Boîte pour les Théorèmes / Propriétés (Bleu Myrtille)
\newtcbtheorem[number within=section]{myrthm}{Théorème}%
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
  attach title to upper,              % <-- Fusionne le titre avec le corps
  after title = {\par\vspace{4pt}},   % <-- Saut de ligne après le titre
  % --- STYLE DU CORPS ---
  left = 8pt, right = 8pt, top = 8pt, bottom = 8pt,
  before skip = 14pt, after skip = 14pt,
}{thm}

% Boîte pour les Définitions (Vert Info)
\newtcbtheorem[number within=section]{myrdef}{Définition}%
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
  attach title to upper,              % <-- Fusionne le titre avec le corps
  after title = {\par\vspace{4pt}},   % <-- Saut de ligne après le titre
  % --- STYLE DU CORPS ---
  left = 8pt, right = 8pt, top = 8pt, bottom = 8pt,
  before skip = 14pt, after skip = 14pt,
}{def}

% ── Badge / Tag inline ────────────────────────────────────────
\newcommand{\ci}[1]{\texttt{\small\color{inlineCode}#1}}
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

% ── Ligne de séparation ───────────────────────────────────────
\newcommand{\hrulefull}{\vspace{2pt}\noindent\textcolor{border}{\rule{\linewidth}{0.5pt}}\vspace{6pt}}

% ── Note de marge latérale simulée ───────────────────────────
\newcommand{\sidenote}[1]{%
  \begin{tcolorbox}[colback=sidebarBg, colframe=border, arc=3pt, left=8pt, right=8pt, top=5pt, bottom=5pt,
    before skip=6pt, after skip=6pt, fontupper=\sffamily\footnotesize\color{mid}]#1\end{tcolorbox}%
}

% ── Encadrés d'images ────────────────────────────────────────

% --- imgbox : carte image moderne ---
% Usage : \begin{imgbox}[Légende]{chemin/image}
%   Texte optionnel sous l'image
% \end{imgbox}
% ── Initialisation des variables pour la mesure de l'image ──
\newsavebox{\myrtilleimgbox}
\newlength{\myrtilleimgwidth}
% ── Environnement imgbox ─────────────────────────────────────

\newenvironment{imgbox}[3][]{%
  \vspace{10pt}\noindent\centering
  
  % 1. Mesure et ajustement de l'image (identique)
  \sbox{\myrtilleimgbox}{%
    \def\tempwidth{#2}%
    \ifx\tempwidth\empty
      \includegraphics{#3}%
    \else
      \includegraphics[width=#2]{#3}%
    \fi
  }%
  \setlength{\myrtilleimgwidth}{\wd\myrtilleimgbox}%
  
  % 2. Sécurité (identique)
  \ifdim\dimexpr\myrtilleimgwidth+3pt\relax>\linewidth
    \setlength{\myrtilleimgwidth}{\dimexpr\linewidth-3pt\relax}%
    \sbox{\myrtilleimgbox}{\includegraphics[width=\myrtilleimgwidth]{#3}}%
  \fi
  
  % 3. Boîte externe : AJOUT DE LA BORDURE FINE TOUT AUTOUR
  \begin{tcolorbox}[
    enhanced, colback=white, colframe=accent,
    boxrule=0.4pt, % <-- NOUVEAU : Fin contour bleu sur tout le pourtour
    leftrule=3pt,  % <-- CONSERVÉ : Liseré épais à gauche
    arc=6pt,
    shadow={0pt}{-2pt}{6pt}{black!8},
    left=0pt, right=0pt, top=0pt, bottom=0pt, boxsep=0pt,
    width=\dimexpr\myrtilleimgwidth+3pt\relax,
    center,
    clip upper % Coupe le coin haut-gauche de l'image pour épouser la bordure arrondie
  ]
    \usebox{\myrtilleimgbox}%
    \par\noindent
    
    % 4. Boîte interne (légende) : (identique)
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
% --- imgfloat : image + texte côte à côte ---
% Usage : \begin{imgfloat}{chemin/image}
%   Texte descriptif à droite de l'image
% \end{imgfloat}
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

% --- imgsidenote : miniature dans une note latérale ---
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

% --- \myrfig : figure numérotée rapide Myrtille (Nouvelle version) ---
% Usage : \myrfig[width=0.6\linewidth]{chemin/image}{Légende}
\newcommand{\myrfig}[3][width=0.7\linewidth]{%
  \begin{figure}[htbp]
    \centering
    % 1. Mesure de l'image (réutilise les variables de imgbox)
    \sbox{\myrtilleimgbox}{%
      \includegraphics[#1]{#2}%
    }%
    \setlength{\myrtilleimgwidth}{\wd\myrtilleimgbox}%
    
    % 2. Sécurité : Ajustement si l'image est plus large que la page
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

% ── Variables de la page de garde ────────────────────────────
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

% Interrupteur pour afficher la version (désactivé par défaut)
\newif\ifshowversion
\showversionfalse 

\def\@version{}
% Si l'utilisateur définit une version, on active automatiquement l'affichage
\newcommand{\version}[1]{%
  \def\@version{#1}%
  \showversiontrue 
}

% ── Commande de page de garde ────────────────────────────────
\newcommand{\makecover}{%
  \begin{titlepage}
  \thispagestyle{empty}
  \begin{tikzpicture}[remember picture, overlay]
    \begin{scope}[shift={(current page.south west)}]
      % 1. Fond bleu marine (couvre toute la page A4)
      \path[fill=coverBg] (0.0, 29.7) rectangle (21.0, 0.0);

      % 2. Liseré bleu vif à gauche
      \path[fill=accent] (0.0, 29.7) rectangle (0.2, 0.0);

      % 3. Grand cercle décoratif
      \path[fill=coverAccent, opacity=0.2] (18.0, 4.0) circle (6.0cm);

      % 4. Petit cercle décoratif
      \path[fill=accent, opacity=0.1] (20.0, 7.0) circle (4.0cm);
    \end{scope}
    % Condition : le badge ne s'affiche que si \showversiontrue
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
  \setcounter{page}{1}
}