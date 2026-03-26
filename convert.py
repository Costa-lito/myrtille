import os
import re

# Configuration
MAIN_CLS = "myrtille.cls"
PALETTES_DIR = "palettes"

def patch_classes():
    # 1. Lire le fichier principal
    with open(MAIN_CLS, "r", encoding="utf-8") as f:
        core_content = f.read()

    # 2. Expression régulière pour cibler tout ce qui est entre les deux balises
    pattern = re.compile(r"(% --- BEGIN PALETTE ---).*?(% --- END PALETTE ---)", re.DOTALL)

    # 3. Parcourir les palettes alternatives
    if not os.path.exists(PALETTES_DIR):
        print(f"Erreur : Le dossier '{PALETTES_DIR}' n'existe pas.")
        return

    for palette_file in os.listdir(PALETTES_DIR):
        if not palette_file.endswith(".tex"):
            continue
            
        theme_name = palette_file.replace(".tex", "")
        
        # Lire les nouvelles couleurs
        with open(os.path.join(PALETTES_DIR, palette_file), "r", encoding="utf-8") as f:
            new_palette = f.read()
            
        # 4. Remplacer la palette dans le code source
        # On garde les balises BEGIN et END pour que les fichiers générés soient propres
        patched_content = pattern.sub(lambda m: f"{m.group(1)}\n{new_palette}\n{m.group(2)}", core_content)
        
        # 5. Mettre à jour le nom de la classe
        # Change \ProvidesClass{myrtille} en \ProvidesClass{pringlea} par exemple
        patched_content = patched_content.replace(
            r"\ProvidesClass{myrtille}", 
            f"\\ProvidesClass{{{theme_name}}}"
        )
        
        # 6. Sauvegarder la nouvelle classe
        output_file = f"{theme_name}.cls"
        with open(output_file, "w", encoding="utf-8") as f:
            f.write(patched_content)
            
        print(f"✅ Variété générée avec succès : {output_file}")

if __name__ == "__main__":
    patch_classes()