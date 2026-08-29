#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

SHELLS_DIR="$HOME/nixconf/shells"

if [ ! -d "$SHELLS_DIR" ]; then
    echo "No se encontró el directorio de templates: $SHELLS_DIR" >&2
    exit 1
fi

options=()
for dir in "$SHELLS_DIR"/*/; do
    [ -d "$dir" ] || continue
    options+=("$(basename "$dir")")
done

if [ "${#options[@]}" -eq 0 ]; then
    echo "No hay templates disponibles en $SHELLS_DIR" >&2
    exit 1
fi

PS3="Elige un template: "
select choice in "${options[@]}"; do
    if [ -n "${choice:-}" ]; then
        break
    fi
    echo "Opción inválida, inténtalo de nuevo."
done

cp -r "$SHELLS_DIR/$choice/." ./
echo "Template '$choice' copiado en $(pwd)"
