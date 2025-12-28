#!/bin/bash

# Script: RESPALDO COMPLETO CON EXCLUSIONES
# Autor: Javier Esquivel
# Fecha_ diciembre 2025

SSH_HOST="usuario@192.168.100.10"                       <--CAMBIAR
ORIGEN="/home/usaurio/carpeta"                          <--CAMBIAR
DESTINO_REMOTO="/home/usuarios_remoto/carpeta_remota"   <--CAMBIAR

# Carpetas a EXCLUIR (rutas relativas a $ORIGEN)
EXCLUIR=(
  "carpeta_a_excluir/"
  "archivo_a_excluir.*"
)

echo "✅ Sincronización completa de $ORIGEN → $SSH_HOST:$DESTINO_REMOTO"
echo "🚫 Excluyendo: ${EXCLUIR[*]}"

# 1. Validar SSH + rsync en el servidor
echo "📡 Validando SSH..."
if ssh -o ConnectTimeout=5 "$SSH_HOST" "echo 'SSH OK' && command -v rsync >/dev/null"; then
  echo "✅ SSH + RSYNC listos"
else
  echo "❌ Conexión SSH falló o falta rsync en el remoto"
  exit 1
fi

# 2. Verificar carpeta origen
if [ ! -d "$ORIGEN" ]; then
  echo "❌ No existe carpeta origen: $ORIGEN"
  exit 1
fi

# 3. Construir opciones de rsync (incluye exclusiones)
RSYNC_OPTS="-avz --delete --timeout=30 --human-readable"
for exclusion in "${EXCLUIR[@]}"; do
  RSYNC_OPTS="$RSYNC_OPTS --exclude=$exclusion"
done

#4. Ejecusión copia rsync, considerando exclusiones
echo "🚀 Ejecutando COPIA..."
if rsync $RSYNC_OPTS "$ORIGEN/" "$SSH_HOST:$DESTINO_REMOTO/"; then
   echo "✅ Respaldo COMPLETO ejecutado correctamente"
else
   echo "❌ Error durante la sincronización real"
   exit 1
fi

echo "⏰ $(date)"
