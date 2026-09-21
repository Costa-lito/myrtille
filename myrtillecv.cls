% This work is distributed under the MIT License.
% ============================================================
%  Myrtille CV — académique — Classe LaTeX — Dérivée de myrtille.cls
%  CV sobre une colonne, esprit académique / recherche
% ============================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myrtillecv}[2026/09/18 v1.0 Classe Myrtille CV Recherche]

% ── Gestion des options de type "theme=..." ─────────────────
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=myrtillecvr,
  prefix=myrtillecvr@
}
\DeclareStringOption[myrtille]{theme}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions*

% Chargement de la classe de base
\LoadClass[a4paper,10pt]{article}

% ── Encodage & graphiques ─────────────────────────────────────
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
\RequirePackage{microtype}
\emergencystretch=2em

% ── Police sans-serif globale (Inter, avec repli automatique) ─
\IfFileExists{inter.sty}{%
  \RequirePackage[scaled=0.92]{inter}%
}{%
  \RequirePackage[scaled=0.92]{helvet}%
}
\RequirePackage[scaled=0.92]{FiraMono}
\renewcommand{\familydefault}{\sfdefault}

% ── Mise en page : classique, généreuse, une colonne ──────────
\RequirePackage[a4paper, top=11mm, bottom=10mm, left=19mm, right=19mm]{geometry}
\RequirePackage{parskip}
\setlength{\parskip}{0pt}
\RequirePackage{setspace}
\RequirePackage{textcomp}
\setstretch{1.0}
\pagestyle{empty}

% ── Couleurs ─────────────────────────────────────────────────
\RequirePackage{xcolor}
\RequirePackage{etoolbox}

% Normalisation du nom de thème (mêmes alias que myrtille.cls)
\ifdefstring{\myrtillecvr@theme}{green}{\def\myrtillecvr@theme{pringlea}}{}
\ifdefstring{\myrtillecvr@theme}{red}{\def\myrtillecvr@theme{acerola}}{}
\ifdefstring{\myrtillecvr@theme}{blue}{\def\myrtillecvr@theme{myrtille}}{}
\ifdefstring{\myrtillecvr@theme}{}{\def\myrtillecvr@theme{myrtille}}{}

% --- BEGIN PALETTE (réduite : uniquement les teintes utiles à un CV sobre) ---
\ifdefstring{\myrtillecvr@theme}{pringlea}{
    % --- Palette Pringlea (Vert) ---
    \definecolor{accent}      {HTML}{0D9488}
    \definecolor{accentDark}  {HTML}{0F766E}
    \definecolor{dark}        {HTML}{0F172A}
    \definecolor{mid}         {HTML}{475569}
    \definecolor{border}      {HTML}{CBD5E1}
}{
\ifdefstring{\myrtillecvr@theme}{acerola}{
    % --- Palette Acerola (Rouge) ---
    \definecolor{accent}      {HTML}{E11D48}
    \definecolor{accentDark}  {HTML}{9F1239}
    \definecolor{dark}        {HTML}{18181B}
    \definecolor{mid}         {HTML}{52525B}
    \definecolor{border}      {HTML}{D4D4D8}
}{
    % --- Palette Myrtille (Bleu, par défaut) ---
    \definecolor{accent}     {HTML}{0D6EFD}
    \definecolor{accentDark} {HTML}{0A4FA8}
    \definecolor{dark}       {HTML}{1A1D23}
    \definecolor{mid}        {HTML}{4A5060}
    \definecolor{border}     {HTML}{D0D6E0}
}
}
% --- END PALETTE ---

% ── Commande pour personnaliser la palette ───────────────────
\RequirePackage{pgfkeys}
\pgfkeys{
 /myrtillecvr/palette/.is family, /myrtillecvr/palette,
 accent/.code={\definecolor{accent}{HTML}{#1}},
 accentDark/.code={\definecolor{accentDark}{HTML}{#1}},
 dark/.code={\definecolor{dark}{HTML}{#1}},
 mid/.code={\definecolor{mid}{HTML}{#1}},
 border/.code={\definecolor{border}{HTML}{#1}}
}
\newcommand{\setmyrtillecvrpalette}[1]{\pgfkeys{/myrtillecvr/palette, #1}}

% ── Hyperref ─────────────────────────────────────────────────
\RequirePackage{hyperref}
\hypersetup{colorlinks=true, linkcolor=accentDark, urlcolor=accentDark, citecolor=accentDark,
  pdfstartview={XYZ null null 1}}

% ── Listes ───────────────────────────────────────────────────
\RequirePackage{enumitem}
\setlist[itemize]{leftmargin=1.15em, itemsep=1.5pt, topsep=2pt, parsep=0pt,
  label=\textcolor{accent}{\footnotesize\textbullet}}

% ── Utilitaires ────────────────────────────────────────────────
\RequirePackage{xifthen}
\RequirePackage{needspace}

% ── Ligne / filet fin pleine largeur ──────────────────────────
\newcommand{\cvrule}[1][border]{\par\noindent{\color{#1}\rule{\linewidth}{0.6pt}}\par}

% ============================================================
%  Pied de page discret (numéro de page, si CV > 1 page)
% ============================================================
\RequirePackage{fancyhdr}
\fancypagestyle{cvrstyle}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[C]{\sffamily\scriptsize\color{mid}\thepage}%
}
\pagestyle{cvrstyle}

% ============================================================
%  Identité (nom, accroche) — construction différée, dans
%  l'esprit de \title/\subtitle/\makecover de myrtille.cls
% ============================================================
\def\@cvfirstname{}\def\@cvlastname{}
\newcommand{\cvname}[2]{\def\@cvfirstname{#1}\def\@cvlastname{#2}}

\def\@cvheadline{}
\newcommand{\cvheadline}[1]{\def\@cvheadline{#1}}

% -- Contacts : chaque commande ajoute une ligne "Label : valeur" --
% Construites comme des lignes de tableau (largeur naturelle,
% alignées à gauche entre elles) pour pouvoir plaquer tout le bloc
% contre la marge de droite tout en gardant le texte aligné à gauche.
\def\@cvcontacts{}
\newcommand{\cvaddcontact}[2]{%
  \g@addto@macro\@cvcontacts{%
    {\sffamily\footnotesize\bfseries\color{dark}#1\ :}\ %
    {\sffamily\footnotesize\color{mid}#2}\\%
  }%
}
\newcommand{\cvlocation}[1]{\cvaddcontact{Localisation}{#1}}
\newcommand{\cvphonenumber}[1]{\cvaddcontact{Téléphone}{#1}}
\newcommand{\cvmail}[1]{\cvaddcontact{Email}{\href{mailto:#1}{#1}}}
\newcommand{\cvlinkedin}[2]{\cvaddcontact{LinkedIn}{\href{#1}{#2}}}
\newcommand{\cvwebsite}[2]{\cvaddcontact{Site}{\href{#1}{#2}}}

% En-tête : titre (prénom / NOM / accroche) à gauche, coordonnées
% plaquées à droite (mais alignées à gauche entre elles), les deux
% blocs alignés sur leur bas (comme un en-tête de courrier)
\newcommand{\makecvheader}{%
  \begingroup
  \parindent0pt
  \setlength{\parskip}{0pt}%
  \setstretch{1.0}%
  \noindent
  \begin{minipage}[b]{0.56\linewidth}
    \setlength{\parskip}{0pt}%
    \ifthenelse{\isempty{\@cvfirstname}}{}{%
      {\sffamily\bfseries\fontsize{22}{24}\selectfont\color{dark}\@cvfirstname}\par
      \vspace{0.6mm}
      {\sffamily\bfseries\fontsize{22}{24}\selectfont\color{dark}\MakeUppercase{\@cvlastname}}\par
      \vspace{0.8mm}
    }%
    \ifthenelse{\isempty{\@cvheadline}}{}{%
      {\sffamily\itshape\small\color{accent}\@cvheadline}\par
    }%
  \end{minipage}%
  \hfill
  \begin{tabular}[b]{@{}l@{}}
    \@cvcontacts
  \end{tabular}
  \par\vspace{4mm}
  \endgroup
}

% ============================================================
%  Titres de section — génériques, réutilisables pour n'importe
%  quelle rubrique (Profil, Formation, Expériences, Publications,
%  Communications, Distinctions, Centres d'intérêt, ...)
% ============================================================
\newcommand{\cvsection}[1]{%
  \par\vspace{4mm}\noindent
  {\sffamily\bfseries\large\color{accent}\MakeUppercase{#1}}\par
  \vspace{-1.5mm}
  \cvrule[border]
  \vspace{0.6mm}
}

% ============================================================
%  Profil / chapô
% ============================================================
\newcommand{\cvprofile}[1]{{\sffamily\small\color{dark}#1}\par}

% ============================================================
%  Entrée générique (formation / expérience / tout le reste)
% ============================================================
\newenvironment{cventry}[4]{%
  % #1 dates  #2 titre  #3 organisation  #4 lieu
  % On réserve assez d'espace pour le bloc d'en-tête (titre + dates,
  % organisation + lieu) et le début du contenu, afin d'éviter qu'une
  % coupure de page ne sépare le titre de ce qui le suit.
  \Needspace*{5\baselineskip}%
  \par\vspace{1.8mm}\noindent
  {\sffamily\bfseries\color{dark}\normalsize #2}\hfill%
  {\sffamily\footnotesize\color{accentDark}#1}\par\nobreak
  \noindent{\sffamily\footnotesize\itshape\color{mid}#3%
    \ifthenelse{\isempty{#4}}{}{\ \textcolor{border}{\textbar}\ \textnormal{\upshape#4}}}\par\nobreak
  \vspace{1mm}\nobreak
  \small
}{%
  \par
}

% ============================================================
%  Compétences / langues — étiquette + contenu, à placer dans
%  un itemize (ou seul), reste volontairement "naïf"
% ============================================================
\newcommand{\cvskill}[2]{%
  {\sffamily\bfseries\color{dark}#1}%
  \ifthenelse{\isempty{#2}}{}{{\sffamily\color{mid}\ : #2}}%
}

% ============================================================
%  Publication / communication — formatage bibliographique léger
%  (optionnel : à utiliser sous un \cvsection{Publications} par ex.)
% ============================================================
\newcommand{\cvpub}[4]{%
  % #1 auteurs  #2 année  #3 titre  #4 revue / conférence
  \par\noindent{\sffamily\footnotesize\color{dark}#1} %
  {\sffamily\footnotesize\color{accentDark}(#2).}\ %
  {\sffamily\footnotesize\itshape\color{dark}#3.}\ %
  \ifthenelse{\isempty{#4}}{}{{\sffamily\footnotesize\color{mid}#4.}}%
  \par\vspace{2.5mm}
}