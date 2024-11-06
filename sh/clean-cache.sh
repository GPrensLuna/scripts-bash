#!/bin/bash

# Función para limpiar caché de npm
clean_npm() {
  echo "Limpiando caché de npm..."
  npm cache clean --force

  echo "Eliminando node_modules..."
  rm -rf node_modules

  echo "Eliminando la carpeta dist (si existe)..."
  rm -rf dist

  echo "Eliminando la carpeta .next (si existe)..."
  rm -rf .next

  echo "Eliminando el archivo package-lock.json (si lo deseas)..."
  rm -f package-lock.json

  echo "Limpiando caché global de npm..."
  npm cache verify
}

# Función para limpiar caché de pnpm
clean_pnpm() {
  echo "Limpiando caché de pnpm..."
  pnpm store prune

  echo "Eliminando node_modules..."
  rm -rf node_modules

  echo "Eliminando la carpeta dist (si existe)..."
  rm -rf dist

  echo "Eliminando la carpeta .next (si existe)..."
  rm -rf .next

  echo "Eliminando el archivo pnpm-lock.yaml (si lo deseas)..."
  rm -f pnpm-lock.yaml
}

# Función para limpiar caché de yarn
clean_yarn() {
  echo "Limpiando caché de yarn..."
  yarn cache clean

  echo "Eliminando node_modules..."
  rm -rf node_modules

  echo "Eliminando la carpeta dist (si existe)..."
  rm -rf dist

  echo "Eliminando la carpeta .next (si existe)..."
  rm -rf .next

  echo "Eliminando el archivo yarn.lock (si lo deseas)..."
  rm -f yarn.lock
}

# Preguntar al usuario qué empaquetador usar
echo "¿Qué empaquetador prefieres usar? (npm/pnpm/yarn): "
read package_manager

# Ejecutar el comando correspondiente según la opción seleccionada
case $package_manager in
  npm)
    clean_npm
    ;;
  pnpm)
    clean_pnpm
    ;;
  yarn)
    clean_yarn
    ;;
  *)
    echo "Opción no válida. Por favor elige entre npm, pnpm o yarn."
    ;;
esac

echo "¡Caché limpiada con éxito!"
