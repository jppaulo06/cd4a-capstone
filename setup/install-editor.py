#!/usr/bin/env python3
"""Install the reviewed Neovim additions with timestamped backups."""
from datetime import datetime
from pathlib import Path
import shutil

root = Path(__file__).resolve().parent
config = Path.home() / ".config/nvim"
backup = config.parent / ("nvim-backup-monografia-" + datetime.now().strftime("%Y%m%d-%H%M%S"))
shutil.copytree(config, backup)
for source in (root / "nvim").rglob("*.lua"):
    target = config / source.relative_to(root / "nvim")
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, target)

# Keep the explicit import list understandable, even though lazy.nvim can also
# discover sibling modules automatically.
imports = config / "lua/jppaulo/plugins/init.lua"
text = imports.read_text()
if '"jppaulo.plugins.writing"' not in text:
    text = text.replace("return {", 'return {\n  { import = "jppaulo.plugins.writing" },', 1)
    imports.write_text(text)

dictionary = Path("/tmp/monografia-setup/pt.utf-8.spl")
if dictionary.is_file() and dictionary.read_bytes().startswith(b"VIMspell"):
    spell = config / "spell"
    spell.mkdir(exist_ok=True)
    shutil.copy2(dictionary, spell / dictionary.name)
print(f"Neovim additions installed. Full previous configuration: {backup}")
