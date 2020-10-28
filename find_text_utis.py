"""Script to find all utis & sub-utis conforming to public.text ."""
import os
from itertools import groupby

LSREGISTER = "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Versions/Current/Support/lsregister"
SEPARATOR = (
    "--------------------------------------------------------------------------------"
)
EXCEPTIONS = [
    "com.apple.mach-o-binary",
    "com.apple.structured-text",
    "public.3d-content",
    "public.calendar-event",
    "public.contact",
    "public.html",
    "public.image",
    "public.movie",
    "public.playlist",
]


def add_keys_recursively(dict, list, key):
    """Add values & sub-values from dict of lists, recursively."""
    if key in dict:
        for val in dict[key]:
            list.append(val)
            add_keys_recursively(dict, list, val)


os.system(LSREGISTER + " -dump > /tmp/out.txt")
with open("/tmp/out.txt") as f:
    dump = list(
        list(g) for _, g in groupby(f.read().splitlines(), key=SEPARATOR.__ne__)
    )[::2]

entities = []
for lines in dump[1:]:
    entity = {}
    last = None
    for line in lines:
        data = line.split(":", 1)
        if len(data) == 1:
            entity[last] += data[0]
        else:
            entity[data[0]] = data[1]
            last = data[0]
    if "uti" in entity and "conforms to" in entity:
        name = entity["uti"].strip()
        type = [x.strip() for x in entity["conforms to"].split(",")]
        if name in EXCEPTIONS or any(x in type for x in EXCEPTIONS):
            continue
        entities.append({"name": name, "type": type})

conformed_by = {}
for entity in entities:
    for item in entity["type"]:
        if item not in conformed_by:
            conformed_by[item] = set()
        conformed_by[item].add(entity["name"])

utis = [
    "public.content",
    "public.data",
    "public.text",
    "public.unix-executable",
]
add_keys_recursively(conformed_by, utis, "public.text")
add_keys_recursively(conformed_by, utis, "public.unix-executable")

for uti in sorted(set(utis)):
    print("\t\t\t\t<string>" + uti + "</string>")
print(len(utis))
