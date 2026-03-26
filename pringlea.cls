% ============================================================
%  Myrtille — Charte Graphique — Style moderne
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
\fancyhead[L]{\color{mid}\small\sffamily Myrtille \textbf{·} Charte Graphique}
\fancyhead[R]{\color{mid}\small\sffamily\leftmark}
\fancyfoot[C]{\color{mid}\small\thepage}

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
  % Utilisation des codes T1 pour éviter les crashs avec les caractères actifs
  literate = {é}{{\symbol{233}}}1 {è}{{\symbol{232}}}1 {ê}{{\symbol{234}}}1 {à}{{\symbol{224}}}1 {â}{{\symbol{226}}}1 {ç}{{\symbol{231}}}1 {µ}{{\ensuremath{\mu}}}1 {ο}{{\symbol{111}}}1
}
\lstset{style=myrtillebase}

\RequirePackage{tcolorbox}
\tcbuselibrary{breakable, skins, listings}

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