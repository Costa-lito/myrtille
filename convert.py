# This work is distributed under the MIT License.
import os
import re

# ============================================================
#  Chemins hardcodés (structure du dépôt)
# ============================================================
SOURCE_CLS   = os.path.join("myrtille", "myrtille.cls")
PALETTES_DIR = "palettes"

# Balises délimitant le bloc palette dans le .cls source
PALETTE_BEGIN = "% --- BEGIN PALETTE ---"
PALETTE_END   = "% --- END PALETTE ---"

PATTERN = re.compile(
    r"(% --- BEGIN PALETTE ---).*?(% --- END PALETTE ---)",
    re.DOTALL
)


def patch_classes():
    # ── 1. Lecture du fichier source ─────────────────────────
    with open(SOURCE_CLS, "r", encoding="utf-8") as f:
        core_content = f.read()

    if not re.search(PATTERN, core_content):
        print(f"Erreur : balises BEGIN/END PALETTE introuvables dans '{SOURCE_CLS}'.")
        return

    # ── 2. Parcours des palettes ─────────────────────────────
    palette_files = [p for p in os.listdir(PALETTES_DIR) if p.endswith(".tex")]

    if not palette_files:
        print(f"Aucune palette .tex trouvée dans '{PALETTES_DIR}/'.")
        return

    for palette_file in sorted(palette_files):
        theme_name = palette_file.removesuffix(".tex")   # ex: "acerola"

        # ── 3. Lecture de la palette ─────────────────────────
        palette_path = os.path.join(PALETTES_DIR, palette_file)
        with open(palette_path, "r", encoding="utf-8") as f:
            new_palette = f.read().strip()

        # ── 4. Injection de la palette ───────────────────────
        # On utilise un callable pour éviter que re.sub interprète
        # les backslashes LaTeX (\definecolor, \d, etc.) comme des
        # séquences d'échappement dans la chaîne de remplacement.
        replacement_str = f"{PALETTE_BEGIN}\n{new_palette}\n{PALETTE_END}"
        patched = PATTERN.sub(lambda _: replacement_str, core_content)

        # ── 5. Mise à jour du nom de classe ──────────────────
        #   \ProvidesClass{myrtille} → \ProvidesClass{acerola}
        patched = patched.replace(
            r"\ProvidesClass{myrtille}",
            rf"\ProvidesClass{{{theme_name}}}"
        )

        # ── 6. Écriture dans le sous-dossier dédié ───────────
        output_dir = theme_name                          # ex: "acerola/"
        output_cls = os.path.join(output_dir, f"{theme_name}.cls")

        os.makedirs(output_dir, exist_ok=True)

        with open(output_cls, "w", encoding="utf-8") as f:
            f.write(patched)

        print(f"✅  {output_cls}")


if __name__ == "__main__":
    patch_classes()
