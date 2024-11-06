function CreateEslintConfig {
    if (Test-Path ".eslintrc.js") {
        $respuesta = Read-Host ".eslintrc.js ya existe. ¿Deseas reemplazarlo? (s/n)"
        if ($respuesta -eq 's') {
            Write-Host "Reemplazando .eslintrc.js..."
        } else {
            Write-Host "No se reemplazará .eslintrc.js."
            return
        }
    }
    $eslintConfig = @"
module.exports = {
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: 'tsconfig.json',
    tsconfigRootDir: __dirname,
    sourceType: 'module',
  },
  plugins: [
    '@typescript-eslint/eslint-plugin',
    'unused-imports',
    'node',
    'import',
    'security',
  ],
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:prettier/recommended',
    'plugin:@typescript-eslint/recommended-requiring-type-checking',
    'plugin:@typescript-eslint/strict',
  ],
  root: true,
  env: {
    node: true,
    jest: true,
  },
  ignorePatterns: ['.eslintrc.js', 'global.d.ts'],
  rules: {
    'unused-imports/no-unused-imports': 'error',
    'prettier/prettier': [
      'error',
      {
        endOfLine: 'auto',
        semi: false,
        singleQuote: true,
        printWidth: 80,
        tabWidth: 2,
        jsxSingleQuote: false,
        trailingComma: 'all',
        bracketSpacing: true,
        bracketSameLine: true,
        proseWrap: 'always',
        useTabs: false,
        parser: 'typescript',
        jsxBracketSameLine: false,
        arrowParens: 'always',
        quoteProps: 'as-needed',
        fileInfoOptions: {
          withNodeModules: true,
          module: true,
          exclude: ['node_modules/**', '**/__tests__/**', '**/__mocks__/**'],
        },
        htmlWhitespaceSensitivity: 'ignore',
        embeddedLanguageFormatting: 'auto',
        requireConfig: true,
        singleAttributePerLine: false,
      },
    ],
    '@typescript-eslint/triple-slash-reference': 'off',
    '@typescript-eslint/interface-name-prefix': 'off',
    '@typescript-eslint/no-explicit-any': 'error',
    '@typescript-eslint/no-inferrable-types': 'off',
    '@typescript-eslint/ban-types': 'off',
    '@typescript-eslint/no-unsafe-assignment': 'off',
    '@typescript-eslint/adjacent-overload-signatures': 'error',
    '@typescript-eslint/await-thenable': 'error',
    '@typescript-eslint/ban-ts-comment': 'error',
    '@typescript-eslint/ban-tslint-comment': 'error',
    '@typescript-eslint/class-literal-property-style': 'error',
    '@typescript-eslint/consistent-generic-constructors': 'error',
    '@typescript-eslint/consistent-indexed-object-style': 'error',
    '@typescript-eslint/consistent-type-assertions': 'error',
    '@typescript-eslint/consistent-type-definitions': 'error',
    '@typescript-eslint/consistent-type-exports': 'error',
    '@typescript-eslint/consistent-type-imports': 'error',
    '@typescript-eslint/explicit-function-return-type': 'error',
    '@typescript-eslint/explicit-member-accessibility': 'error',
    '@typescript-eslint/explicit-module-boundary-types': 'error',
    '@typescript-eslint/method-signature-style': 'error',
    '@typescript-eslint/no-confusing-non-null-assertion': 'error',
    '@typescript-eslint/no-duplicate-enum-values': 'error',
    '@typescript-eslint/no-duplicate-type-constituents': 'error',
    '@typescript-eslint/no-extra-non-null-assertion': 'error',
    '@typescript-eslint/no-extraneous-class': 'off',
    '@typescript-eslint/no-for-in-array': 'error',
    '@typescript-eslint/no-import-type-side-effects': 'error',
    '@typescript-eslint/no-require-imports': 'error',
    '@typescript-eslint/no-unnecessary-boolean-literal-compare': 'error',
    '@typescript-eslint/no-unnecessary-condition': 'error',
    '@typescript-eslint/no-unnecessary-type-assertion': 'off',
    '@typescript-eslint/no-unsafe-call': 'off',
    '@typescript-eslint/no-unsafe-member-access': 'off',
    '@typescript-eslint/no-non-null-assertion': 'off',
    '@typescript-eslint/prefer-reduce-type-parameter': 'error',
    '@typescript-eslint/prefer-string-starts-ends-with': 'error',
    '@typescript-eslint/restrict-template-expressions': 'off',
    '@typescript-eslint/prefer-readonly': 'error',
    'no-return-await': 'off',
    '@typescript-eslint/return-await': 'error',
    '@typescript-eslint/no-misused-promises': 'off',
    eqeqeq: ['error', 'always'],
    'no-console': 'error',
    '@typescript-eslint/unified-signatures': 'off',
    '@typescript-eslint/naming-convention': [
      'error',
      {
        selector: 'default',
        format: ['camelCase'],
      },
      {
        selector: 'variable',
        format: ['camelCase', 'UPPER_CASE', 'PascalCase'],
        leadingUnderscore: 'allow',
      },
      {
        selector: 'parameter',
        format: ['camelCase'],
        leadingUnderscore: 'allow',
      },
      {
        selector: 'memberLike',
        modifiers: ['private'],
        format: ['camelCase', 'UPPER_CASE', 'snake_case'],
        leadingUnderscore: 'allow',
      },
      {
        selector: 'memberLike',
        modifiers: ['public'],
        format: ['camelCase', 'UPPER_CASE', 'snake_case', 'PascalCase'],
      },
      {
        selector: 'typeLike',
        format: ['PascalCase'],
      },
      {
        selector: 'enumMember',
        format: ['UPPER_CASE'],
      },
      {
        selector: 'objectLiteralMethod',
        format: ['camelCase', 'PascalCase'],
      },
      {
        selector: 'objectLiteralProperty',
        format: ['camelCase', 'UPPER_CASE', 'PascalCase', 'snake_case'],
      },
    ],

    // Reglas de Node.js
    'node/no-unsupported-features/es-syntax': ['error', { version: '>=12.0.0', ignores: [] }],
    'node/no-missing-require': 'error',
    'node/no-unpublished-require': 'error',
    'node/exports-style': ['error', 'module.exports'],
    'node/no-deprecated-api': 'warn',

    // Reglas de importación
    'import/named': 'error',
    'import/default': 'error',
    'import/namespace': 'error',
    'import/no-unresolved': 'error',
    'import/export': 'error',
    'import/order': ['error', { groups: ['builtin', 'external', 'internal', 'parent', 'sibling', 'index'], 'newlines-between': 'always' }],

    // Reglas de seguridad
    'security/detect-non-literal-fs-filename': 'warn',
    'security/detect-eval-with-expression': 'error',
    'security/detect-new-buffer': 'error',
  },
}
"@

    Set-Content -Path ".eslintrc.js" -Value $eslintConfig -Force
    Write-Host ".eslintrc.js creado exitosamente."
}

function CreateEslintIgnore {
    if (Test-Path ".eslintignore") {
        $respuesta = Read-Host ".eslintignore ya existe. ¿Deseas reemplazarlo? (s/n)"
        if ($respuesta -eq 's') {
            Write-Host "Reemplazando .eslintignore..."
        } else {
            Write-Host "No se reemplazará .eslintignore."
            return
        }
    }
    $eslintIgnoreContent = @"
node_modules/
dist/
build/
coverage/
*.log
.DS_Store
# See https://help.github.com/articles/ignoring-files/ for more about ignoring files.

# dependencies
/node_modules
/.pnp
.pnp.js
.yarn/install-state.gz

# testing
/coverage

# next.js
/.next/
/out/

# production
/build

# misc
.DS_Store
*.pem

# debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# local env files
.env*.local

# vercel
.vercel

# typescript
*.tsbuildinfo
next-env.d.ts
pnpm-lock.yaml
"@

    Set-Content -Path ".eslintignore" -Value $eslintIgnoreContent -Force
    Write-Host ".eslintignore creado exitosamente."
}

# Preguntar al usuario qué empaquetador usar
$packageManager = Read-Host "¿Qué empaquetador deseas usar para instalar las dependencias? (npm/yarn/pnpm)"

# Ejecutar la creación de archivos y la instalación
CreateEslintConfig
CreateEslintIgnore

# Instalar las dependencias con el empaquetador elegido
if ($packageManager -eq 'npm') {
    Write-Host "Instalando dependencias con npm..."
    npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin unused-imports node import security prettier
} elseif ($packageManager -eq 'yarn') {
    Write-Host "Instalando dependencias con yarn..."
    yarn add --dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin unused-imports node import security prettier
} elseif ($packageManager -eq 'pnpm') {
    Write-Host "Instalando dependencias con pnpm..."
    pnpm i -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin unused-imports node import security prettier
} else {
    Write-Host "Empaquetador no reconocido. No se instalarán las dependencias."
}
