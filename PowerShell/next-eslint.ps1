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
		ecmaVersion: 2020,
	},
	plugins: ['@typescript-eslint/eslint-plugin', 'unused-imports', 'import', 'react', 'react-hooks'],
	extends: [
		'eslint:recommended',
		'next/core-web-vitals',
		//import
		'plugin:import/errors',
		'plugin:import/warnings',
		'plugin:import/typescript',
		//react
		'plugin:react/recommended',
		'plugin:react/jsx-runtime',
		'plugin:react-hooks/recommended',
		//prettier
		'prettier',
		'plugin:prettier/recommended',
		//tailwindcss
		'plugin:tailwindcss/recommended',
		//typescript
		'plugin:@typescript-eslint/strict',
		'plugin:@typescript-eslint/recommended',
		'plugin:@typescript-eslint/recommended-requiring-type-checking',
	],
	root: true,
	env: {
		node: true,
		jest: true,
		browser: true,
	},
	ignorePatterns: [
		'.eslintrc.js',
		'global.d.ts',
		'jest.base.config.ts',
		'tsconfig.json',
		'node_modules',
		'build',
		'dist',
	],
	rules: {
		//prettier
		'prettier/prettier': [
			'error',
			{
				semi: false,
				parser: 'typescript',
				useTabs: true,
				tabWidth: 2,
				proseWrap: 'preserve',
				endOfLine: 'auto',
				printWidth: 100,
				quoteProps: 'as-needed',
				rangeStart: 0,
				singleQuote: true,
				arrowParens: 'always',
				insertPragma: false,
				trailingComma: 'all',
				requirePragma: false,
				bracketSpacing: true,
				jsxSingleQuote: false,
				bracketSameLine: false,
				jsxBracketSameLine: false,
				singleAttributePerLine: false,
				vueIndentScriptAndStyle: false,
				htmlWhitespaceSensitivity: 'ignore',
				embeddedLanguageFormatting: 'auto',
				plugins: ['prettier-plugin-tailwindcss', 'prettier-plugin-organize-imports'],
				fileInfoOptions: {
					withNodeModules: true,
					module: true,
					exclude: ['node_modules/**', '**/__tests__/**', '**/__mocks__/**'],
				},
				requireConfig: true,
			},
		],
		'padding-line-between-statements': [
			'error',
			{ blankLine: 'always', prev: 'block', next: 'return' },
			{ blankLine: 'always', prev: 'multiline-block-like', next: '*' },
		],
		'unused-imports/no-unused-imports': 'error',
		'@typescript-eslint/explicit-function-return-type': 'error',
		'@typescript-eslint/no-explicit-any': 'error',
		'@typescript-eslint/no-unused-vars': [
			'warn',
			{
				argsIgnorePattern: '^_',
				varsIgnorePattern: '^_',
				caughtErrorsIgnorePattern: '^_',
			},
		],
		'react/prop-types': 'off', // Si estás usando TypeScript, puedes desactivar esto
		'react/react-in-jsx-scope': 'off', // Para React 17+
		'react-hooks/rules-of-hooks': 'error',
		'react-hooks/exhaustive-deps': 'warn',
		'import/order': [
			'error',
			{
				groups: ['builtin', 'external', 'internal', 'parent', 'sibling', 'index', 'object', 'type'],
				'newlines-between': 'always',
				alphabetize: { order: 'asc', caseInsensitive: true },
			},
		],
		'@typescript-eslint/triple-slash-reference': 'off',
		'@typescript-eslint/interface-name-prefix': 'off',
		'@typescript-eslint/no-inferrable-types': 'error',
		'@typescript-eslint/ban-types': 'off',
		'@typescript-eslint/no-unsafe-assignment': 'error',
		'@typescript-eslint/no-unsafe-argument': 'error',
		'@typescript-eslint/no-unsafe-call': 'error',
		'@typescript-eslint/no-unsafe-member-access': 'error',
		'@typescript-eslint/adjacent-overload-signatures': 'error',
		'@typescript-eslint/await-thenable': 'error',
		'@typescript-eslint/ban-ts-comment': 'error',
		'@typescript-eslint/ban-tslint-comment': 'error',
		'@typescript-eslint/class-literal-property-style': 'error',
		'@typescript-eslint/consistent-generic-constructors': 'error',
		'@typescript-eslint/consistent-indexed-object-style': 'error',
		'@typescript-eslint/consistent-type-assertions': [
			'error',
			{
				assertionStyle: 'as',
			},
		],
		'@typescript-eslint/consistent-type-definitions': ['error', 'interface'],
		'@typescript-eslint/consistent-type-exports': 'error',
		'@typescript-eslint/consistent-type-imports': 'error',
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
		'@typescript-eslint/no-unnecessary-condition': 'off',
		'@typescript-eslint/no-unnecessary-type-assertion': 'off',
		'@typescript-eslint/no-non-null-assertion': 'off',
		'@typescript-eslint/prefer-reduce-type-parameter': 'error',
		'@typescript-eslint/prefer-string-starts-ends-with': 'error',
		'@typescript-eslint/prefer-readonly': 'error',
		'no-return-await': 'off',
		'@typescript-eslint/return-await': 'error',
		'@typescript-eslint/no-misused-promises': 'off',
		'@typescript-eslint/no-unbound-method': ['off', { 'ignore-static': true }],
		'@typescript-eslint/unbound-method': ['off'],
		'@typescript-eslint/no-floating-promises': 'off',
		eqeqeq: ['error', 'always'],
		'no-console': 'error',
		'@typescript-eslint/unified-signatures': 'off',
		'no-unused-vars': 'off',
		'@typescript-eslint/naming-convention': [
			'error',
			// Reglas para nombres de variables
			{
				selector: 'variable',
				format: ['camelCase'], // Permitir solo camelCase para variables
				leadingUnderscore: 'allow', // Permitir guiones bajos al principio (ej. _myVar)
				trailingUnderscore: 'forbid', // Prohibir guiones bajos al final (ej. myVar_)
			},
			{
				selector: 'variable',
				modifiers: ['const'], // Reglas para constantes
				format: ['camelCase'], // Permitir solo PascalCase para constantes
			},
			/*       {
        selector: 'variable',
        modifiers: ['readonly'], // Reglas para propiedades de solo lectura
        format: ['camelCase'], // Permitir solo camelCase
      }, */
			{
				selector: 'variable',
				format: null, // Permitir cualquier formato
				filter: {
					regex: '^(config|settings)$', // Permitir 'config' y 'settings' en cualquier formato
					match: true,
				},
			},
			// Reglas para nombres de funciones
			{
				selector: 'function',
				format: ['PascalCase'], // Permitir solo camelCase para funciones
			},
			{
				selector: 'function',
				format: null, // Permitir cualquier formato para funciones de callback
				filter: {
					regex: '^.*Callback$', // Permitir funciones que terminan en 'Callback'
					match: true,
				},
			},
			{
				selector: 'function',
				format: null, // Permitir cualquier formato para funciones que comienzan con "get"
				filter: {
					regex: '^get[A-Z]', // Permitir funciones que empiezan con 'get' seguido de una letra mayúscula
					match: true,
				},
			},
			{
				selector: 'function',
				format: null, // Permitir cualquier formato para funciones que comienzan con "set"
				filter: {
					regex: '^set[A-Z]', // Permitir funciones que empiezan con 'set' seguido de una letra mayúscula
					match: true,
				},
			},
			// Reglas para nombres de clases
			{
				selector: 'class',
				format: ['PascalCase'], // Permitir solo PascalCase para clases
			},
			{
				selector: 'class',
				modifiers: ['abstract'], // Aplicar solo a clases abstractas
				format: ['PascalCase'], // Permitir solo PascalCase
			},
			// Reglas para nombres de tipos (interfaces, tipos)
			{
				selector: 'typeLike',
				format: ['PascalCase'], // Permitir solo PascalCase para tipos
			},
			{
				selector: 'typeLike',
				format: null, // Permitir cualquier formato para interfaces que comienzan con 'I'
				filter: {
					regex: '^I[A-Z]', // Permitir tipos que empiezan con 'I' seguido de una letra mayúscula
					match: true,
				},
			},
			// Reglas para nombres de propiedades de objetos
			{
				selector: 'property',
				format: ['camelCase'], // Permitir solo camelCase para propiedades
			},
			{
				selector: 'property',
				format: null, // Permitir cualquier formato
				filter: {
					regex: '^__|Content-Type', // Permitido si empieza con dos guiones bajos
					match: true,
				},
			},
			{
				selector: 'variable',
				format: null, // Permitir cualquier formato
				filter: {
					regex: '^(foo|bar|baz|test|temp|Content-Type)$', // Permitir 'foo', 'bar', 'baz', 'test', y 'temp' en cualquier formato
					match: true,
				},
			},
			{
				selector: 'property',
				format: null, // Permitir cualquier formato para propiedades booleanas
				filter: {
					regex: '^(is|has|can)[A-Z]', // Permitir propiedades que comienzan con 'is', 'has' o 'can'
					match: true,
				},
			},
			{
				selector: 'variable',
				modifiers: ['const'], // Aplicar solo a constantes
				format: ['UPPER_CASE'], // Permitir solo UPPER_CASE para constantes
				prefix: ['DEFAULT_', 'MAX_', 'MIN_', 'API_', 'CONFIG_'], // Permitir prefijos específicos
			},
			{
				selector: 'variable',
				modifiers: ['const'], // Aplicar solo a constantes
				format: null, // Permitir cualquier formato
				filter: {
					regex: '^(DEFAULT_MAX_|MIN_|API_KEY_|CONFIG_VALUE_)', // Permitir constantes con estos prefijos
					match: true,
				},
			},
			{
				selector: 'parameter',
				format: ['camelCase'], // Permitir solo camelCase para parámetros
			},
			{
				selector: 'parameter',
				format: null, // Permitir cualquier formato para parámetros de opciones
				filter: {
					regex: '^options?$',
					match: true,
				},
			},
			{
				selector: 'enumMember', // Para miembros de enumeraciones
				format: ['UPPER_CASE'], // Permitir solo UPPER_CASE
			},
			{
				selector: 'enumMember',
				format: null, // Permitir cualquier formato
				filter: {
					regex: '^(IS_|HAS_|CAN_)[A-Z]', // Permitir miembros que empiezan con 'IS_', 'HAS_', 'CAN_'
					match: true,
				},
			},
			{
				selector: 'method', // Para métodos en clases
				format: ['camelCase'], // Permitir solo camelCase para métodos
			},
			{
				selector: 'method',
				format: null, // Permitir cualquier formato para estos métodos
				filter: {
					regex: '^handle[A-Z]', // Permitir métodos que empiezan con 'handle' seguido de una letra mayúscula
					match: true,
				},
			},
		],

		'no-magic-numbers': [
			'warn',
			{
				ignore: [0, 1], // Permitir 0 y 1
				ignoreArrayIndexes: true,
				enforceConst: true,
			},
		],
		'consistent-return': 'error', // Asegura que todas las funciones devuelvan un valor o no
		'no-multiple-empty-lines': ['error', { max: 1, maxEOF: 0 }], // Limitar líneas vacías
		'prefer-const': 'error', // Preferir const sobre let donde sea posible
		'react/jsx-boolean-value': ['error', 'never'], // No usar valor booleano en JSX
		'react/jsx-fragments': ['error', 'syntax'], // Usar fragmentos de JSX
		'react/jsx-no-bind': [
			'error',
			{
				allowFunctions: false,
				allowArrowFunctions: false,
				allowBind: false,
			},
		], // No usar .bind ni funciones en JSX
		'react/jsx-no-duplicate-props': ['error', { ignoreCase: false }], // No permitir propiedades duplicadas en JSX
		'react/jsx-no-undef': ['error'], // No permitir el uso de componentes no definidos

		'import/first': 'error', // Asegura que las importaciones estén al principio
		'import/newline-after-import': ['error', { count: 1 }], // Nueva línea después de las importaciones
		//'no-duplicate-imports': ['error'],
		// Otras reglas adicionales
		'no-debugger': 'error', // Prohibir el uso de debugger
		'array-callback-return': 'error', // Asegura que los callbacks de array devuelvan un valor
		'no-fallthrough': 'error', // Prohibir fallthrough en switch
		'default-case': 'error', // Asegura que todos los casos tengan un valor por defecto
		'max-len': [
			'warn',
			{
				code: 100, // Líneas de hasta 80 caracteres
				ignoreUrls: true,
				ignoreStrings: true,
				ignoreTemplateLiterals: true,
			},
		],
	},
	settings: {
		'import/resolver': {
			typescript: {}, // Permite la resolución de importaciones de TypeScript
		},
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

CreateEslintConfig
CreateEslintIgnore

# Instalar las dependencias con el empaquetador elegido
if ($packageManager -eq 'npm') {
    Write-Host "Instalando dependencias con npm..."
    npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-plugin-unused-imports eslint-plugin-import eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-tailwindcss eslint-config-prettier eslint-plugin-prettier prettier prettier-plugin-tailwindcss prettier-plugin-organize-imports
} elseif ($packageManager -eq 'yarn') {
    Write-Host "Instalando dependencias con yarn..."
    yarn add -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-plugin-unused-imports eslint-plugin-import eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-tailwindcss eslint-config-prettier eslint-plugin-prettier prettier prettier-plugin-tailwindcss prettier-plugin-organize-imports
} elseif ($packageManager -eq 'pnpm') {
    Write-Host "Instalando dependencias con pnpm..."
   pnpm i -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-plugin-unused-imports eslint-plugin-import eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-tailwindcss eslint-config-prettier eslint-plugin-prettier prettier prettier-plugin-tailwindcss prettier-plugin-organize-imports
} else {
    Write-Host "Empaquetador no reconocido. No se instalarán las dependencias."
}
