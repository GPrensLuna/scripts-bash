
function CreatePrettierConfig {
      if (Test-Path ".prettierrc") {
        $respuesta = Read-Host ".prettierrc ya existe. ¿Deseas reemplazarlo? (s/n)"
        if ($respuesta -eq 's') {
            Write-Host "Reemplazando .prettierrc..."
        } else {
            Write-Host "No se reemplazará .prettierrc."
            return
        }
    }
    $prettierConfig = @"
{
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
}
"@

    Set-Content -Path ".prettierrc" -Value $prettierConfig -Force
    Write-Host ".prettierrc creado exitosamente."
}

function CreatePrettierIgnore {
    $prettierIgnoreContent = @"
node_modules
generated/i18n.generated.ts
dist
.next
"@

    Set-Content -Path ".prettierignore" -Value $prettierIgnoreContent -Force
    Write-Host ".prettierignore creado exitosamente."
}

CreatePrettierConfig
CreatePrettierIgnore

# Instalar las dependencias con el empaquetador elegido
if ($packageManager -eq 'npm') {
    Write-Host "Instalando dependencias con npm..."
    npm install --save-dev prettier prettier-plugin-tailwindcss prettier-plugin-organize-imports
} elseif ($packageManager -eq 'yarn') {
    Write-Host "Instalando dependencias con yarn..."
    yarn add --dev prettier prettier-plugin-tailwindcss prettier-plugin-organize-imports
} elseif ($packageManager -eq 'pnpm') {
    Write-Host "Instalando dependencias con pnpm..."
  pnpm i -D prettier prettier-plugin-tailwindcss prettier-plugin-organize-imports
    Write-Host "Empaquetador no reconocido. No se instalarán las dependencias."
}
