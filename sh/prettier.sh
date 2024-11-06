#!/bin/bash

# Función para crear la configuración de Prettier
create_prettier_config() {
    if [[ -f "prettier.config.js" ]]; then
        read -p "prettier.config.js ya existe. ¿Deseas reemplazarlo? (s/n): " respuesta
        if [[ "$respuesta" != "s" ]]; then
            echo "No se reemplazará prettier.config.js."
            return
        fi
        echo "Reemplazando prettier.config.js..."
    fi

    # Preguntar si es un proyecto de Nest o Next
    read -p "¿Es un proyecto de Nest o Next? (nest/next): " project_type
    case "$project_type" in
        nest)
            # Configuración de Prettier para Nest
            prettier_config='
            // Configuración de Prettier para formatear el código de manera consistente
module.exports = {
  experimentalTernaries: true, // Habilita la experimentación con ternarios más complejos
  printWidth: 80, // Ancho máximo de línea antes de que Prettier haga un salto de línea
  tabWidth: 2, // Número de espacios por tabulación
  useTabs: false, // Usa espacios en lugar de tabuladores
  semi: false, // No agregar punto y coma al final de las declaraciones
  singleQuote: true, // Usa comillas simples en lugar de comillas dobles
  quoteProps: as-needed, // Solo agregar comillas a las propiedades de los objetos cuando sea necesario
  jsxSingleQuote: false, // No usar comillas simples para JSX, usar comillas dobles
  trailingComma: all, // Agregar coma al final de los elementos (si hay varios) en arrays y objetos
  bracketSpacing: true, // Espacio entre los corchetes de objetos (ej: { key: value })
  bracketSameLine: true, // Los corchetes de los objetos no deben ir en la misma línea que la última propiedad
  arrowParens: always, // Siempre rodear los parámetros de las funciones con paréntesis
  parser: typescript, // El analizador que se utiliza para analizar el código. "babel" es una opción común para JavaScript y TypeScript.
  requirePragma: false, // No se requiere pragma (comentario de preprocesador como /* @jsx */)
  insertPragma: false, // No insertar automáticamente un pragma (comentario de preprocesador)
  proseWrap: always, // Ajuste de texto en archivos de formato largo, siempre que el texto se ajuste
  htmlWhitespaceSensitivity: css, // Sensibilidad al espacio en blanco dentro de archivos HTML (opciones: "css", "strict", "ignore")
  vueIndentScriptAndStyle: false, // No identar el código dentro de los `<script>` y `<style>` de archivos Vue
  endOfLine: lf, // Usar el salto de línea `LF` (de línea de texto) al final del archivo
  embeddedLanguageFormatting: auto, // Formatear el código incrustado (por ejemplo, código en HTML o Markdown)
  singleAttributePerLine: false, // No colocar un atributo de un solo valor en una línea separada (solo para HTML o JSX)
  requireConfig: true, // Requiere que haya una configuración de Prettier antes de formatear archivos
  fileInfoOptions: {
    // Opciones para el análisis de información de archivos
    withNodeModules: true, // Incluir módulos de node_modules en el análisis
    module: true, // Permite que el módulo de Prettier se incluya en la configuración
  },
}


'
            ;;
        next)
            # Configuración de Prettier para Next
            prettier_config='{
  "semi": false,
  "parser": "typescript",
  "useTabs": true,
  "tabWidth": 2,
  "proseWrap": "preserve",
  "endOfLine": "lf",
  "printWidth": 100,
  "quoteProps": "as-needed",
  "rangeStart": 0,
  "singleQuote": true,
  "arrowParens": "always",
  "insertPragma": false,
  "trailingComma": "all",
  "requirePragma": false,
  "bracketSpacing": true,
  "jsxSingleQuote": false,
  "bracketSameLine": false,
  "jsxBracketSameLine": false,
  "singleAttributePerLine": false,
  "vueIndentScriptAndStyle": false,
  "htmlWhitespaceSensitivity": "css",
  "embeddedLanguageFormatting": "auto",
  "plugins": [
    "prettier-plugin-tailwindcss",
    "prettier-plugin-organize-imports"
  ],
  "overrides": [
    {
      "files": "*.{ts,tsx}",
      "options": {
        "parser": "typescript"
      }
    },
    {
      "files": "*.{js,jsx}",
      "options": {
        "parser": "babel"
      }
    },
    {
      "files": "*.vue",
      "options": {
        "parser": "vue"
      }
    },
    {
      "files": "*.css",
      "options": {
        "parser": "css"
      }
    },
    {
      "files": "*.scss",
      "options": {
        "parser": "scss"
      }
    },
    {
      "files": "*.less",
      "options": {
        "parser": "less"
      }
    },
    {
      "files": "*.json",
      "options": {
        "parser": "json"
      }
    },
    {
      "files": "*.md",
      "options": {
        "parser": "markdown"
      }
    },
    {
      "files": "*.yaml",
      "options": {
        "parser": "yaml"
      }
    }
  ],
  "importOrder": [
    "^react",
    "^next",
    "<THIRD_PARTY_MODULES>",
    "^@/(.*)$",
    "^[./]"
  ],
  "importOrderSeparation": true,
  "importOrderSortSpecifiers": true,
  "importOrderGroupNamespaceSpecifiers": true,
  "importOrderCaseInsensitive": true,
  "xmlWhitespaceSensitivity": "strict",
  "jsonRecursiveSort": true,
  "astroAllowShorthand": false
}'
            ;;
        *)
            echo "Opción no válida. Se usará configuración por defecto."
            prettier_config='{
  "semi": false,
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2
}'
            ;;
    esac

    # Crear el archivo prettier.config.js con la configuración correspondiente
    echo "$prettier_config" > prettier.config.js
    echo "prettier.config.js creado exitosamente."
}

# Función para crear .prettierignore
create_prettier_ignore() {
    prettier_ignore_content='node_modules
generated/i18n.generated.ts
dist
.next
'

    echo "$prettier_ignore_content" > .prettierignore
    echo ".prettierignore creado exitosamente."
}

# Crear el archivo prettier.config.js y .prettierignore
create_prettier_config
create_prettier_ignore

# Preguntar por el gestor de paquetes y ajustar la instalación según el tipo de proyecto
read -p "¿Qué gestor de paquetes usas? (npm/yarn/pnpm): " package_manager

read -p "¿Es un proyecto de Nest o Next? (nest/next): " project_type

case "$package_manager" in
    npm)
        if [[ "$project_type" == "nest" ]]; then
            echo "Instalando dependencias para Nest con npm..."
            npm install --save-dev prettier eslint-config-prettier
        elif [[ "$project_type" == "next" ]]; then
            echo "Instalando dependencias para Next con npm..."
            npm install --save-dev prettier prettier-plugin-tailwindcss prettier-plugin-organize-imports
        else
            echo "Tipo de proyecto no válido para npm."
        fi
        ;;
    yarn)
        if [[ "$project_type" == "nest" ]]; then
            echo "Instalando dependencias para Nest con yarn..."
            yarn add --dev prettier eslint-config-prettier
        elif [[ "$project_type" == "next" ]]; then
            echo "Instalando dependencias para Next con yarn..."
            yarn add --dev prettier prettier-plugin-tailwindcss prettier-plugin-organize-imports
        else
            echo "Tipo de proyecto no válido para yarn."
        fi
        ;;
    pnpm)
        if [[ "$project_type" == "nest" ]]; then
            echo "Instalando dependencias para Nest con pnpm..."
            pnpm i -D prettier eslint-config-prettier
        elif [[ "$project_type" == "next" ]]; then
            echo "Instalando dependencias para Next con pnpm..."
            pnpm i -D prettier prettier-plugin-tailwindcss prettier-plugin-organize-imports
        else
            echo "Tipo de proyecto no válido para pnpm."
        fi
        ;;
    *)
        echo "Empaquetador no reconocido. No se instalarán las dependencias."
        ;;
esac
