#!/usr/bin/env python3
"""Build dist/: one ZIP with everything, plus one ZIP per skill (for claude.ai upload). Reproducible timestamps."""
import os, zipfile, glob, shutil
here = os.path.dirname(os.path.abspath(__file__))
dist = os.path.join(here, "dist")
shutil.rmtree(dist, ignore_errors=True); os.makedirs(dist)
FIXED = (2026, 10, 17, 0, 0, 0)

def add(z, path, arc):
    info = zipfile.ZipInfo(arc, FIXED)
    info.compress_type = zipfile.ZIP_DEFLATED
    mode = os.stat(path).st_mode & 0o777
    info.external_attr = (mode | 0o100000) << 16
    with open(path, "rb") as fh:
        z.writestr(info, fh.read())

def files_under(base):
    for dp, dns, fns in os.walk(base):
        dns[:] = sorted(d for d in dns if d not in ("__pycache__",))
        for fn in sorted(fns):
            if fn.endswith(".pyc"): continue
            yield os.path.join(dp, fn)

with zipfile.ZipFile(os.path.join(dist, "agentkit-dev-skills-v1.0.zip"), "w") as z:
    for top in ("README.md", "LICENSE", "install.sh", "build_dist.py"):
        add(z, os.path.join(here, top), "agentkit-dev-skills/" + top)
    for f in files_under(os.path.join(here, "skills")):
        add(z, f, "agentkit-dev-skills/" + os.path.relpath(f, here))
for sk in sorted(glob.glob(os.path.join(here, "skills", "*"))):
    name = os.path.basename(sk)
    with zipfile.ZipFile(os.path.join(dist, name + ".zip"), "w") as z:
        for f in files_under(sk):
            add(z, f, name + "/" + os.path.relpath(f, sk))
print(sorted(os.listdir(dist)))
