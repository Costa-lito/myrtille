use File::Basename;
use Cwd 'getcwd';

# ATTENTION : latexmk ne charge PAS les fichiers -r via `do`/`require`,
# il lit leur contenu et fait `eval $code`. __FILE__ ne vaut donc jamais
# le chemin de ce .latexmkrc (il vaut "(eval N)"), et dirname(__FILE__)
# (même combiné à abs_path) se réduit silencieusement au répertoire
# courant au moment de l'exécution -- quel que soit le chemin passé à
# -r (relatif ou absolu). On ne peut donc pas se fier à __FILE__ ici.
#
# À la place, on retrouve la racine du projet en remontant depuis le
# répertoire courant jusqu'à trouver myrtille.cls. Ça marche quel que
# soit le fichier .tex compilé dans Exemples/source, et que latexmk
# soit lancé depuis la racine du projet ou depuis Exemples/source
# (ce que fait LaTeX Workshop).
my $root = getcwd();
my $marker = 'myrtille.cls';
while ( ! -e "$root/$marker" ) {
    my $parent = dirname($root);
    die "latexmkrc: impossible de localiser $marker en remontant depuis ",
        getcwd(), "\n" if $parent eq $root;
    $root = $parent;
}

# Racine ajoutée à TEXINPUTS pour trouver myrtille.cls
$ENV{'TEXINPUTS'} = $root . ($^O eq 'MSWin32' ? ';' : ':') . ($ENV{'TEXINPUTS'} // '');

$aux_dir = "$root/Exemples/source/build";
$out_dir = "$root/Exemples";
$pdf_mode = 1;
ensure_path('aux_dir');