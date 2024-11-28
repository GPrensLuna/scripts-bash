#!/bin/bash

# ------------------------------------------------------------------------------
#* 1. Función para verificar si el archivo .eslintrc.js ya existe
check_eslint_exists() {
# Lista de posibles archivos de configuración de ESLint
    local eslint_files=(".eslintrc" ".eslintrc.js" "eslint.config.js" ".eslintrc.json" ".eslintrc.yml" ".eslintrc.yaml")

    # Comprobar cada archivo de la lista
    for eslint_file in "${eslint_files[@]}"; do
        if [ -f "$eslint_file" ]; then
            read -p "$eslint_file ya existe. ¿Deseas reemplazarlo? (s/n): " respuesta
            if [[ "$respuesta" != "s" ]]; then
                echo "No se reemplazará $eslint_file."
            else
                echo "$eslint_file reemplazado."
            fi
        fi
    done
}

# ------------------------------------------------------------------------------
#* 2. Función para pedir al usuario el tipo de proyecto
ask_project_type() {
    read -p "¿Estás trabajando con NestJS o Next.js? (nest/next): " framework
    echo "$framework"
}

# ------------------------------------------------------------------------------
#* 3. Función para generar la configuración de eslint para Next.js
generate_next_eslint() {
    echo 'import { fixupPluginRules } from "@eslint/compat";
import eslintPluginNext from "@next/eslint-plugin-next";
import vercelStyleGuideNext from "@vercel/style-guide/eslint/next";
import vercelStyleGuideReact from "@vercel/style-guide/eslint/rules/react";
import vercelStyleGuideTypescript from "@vercel/style-guide/eslint/typescript";
import eslintPluginImport from "eslint-plugin-import";
import eslintPluginJsxA11y from "eslint-plugin-jsx-a11y";
import eslintPluginPrettier from "eslint-plugin-prettier/recommended";
import eslintPluginReact from "eslint-plugin-react";
import eslintPluginReactCompiler from "eslint-plugin-react-compiler";
import eslintPluginReactHooks from "eslint-plugin-react-hooks";
import eslintPluginUnusedImport from "eslint-plugin-unused-imports";
import globals from "globals";
import tseslint from "typescript-eslint";

export default [
  // Ignores configuration
  {
    ignores: [
      "node_modules",
      ".next",
      "out",
      "coverage",
      ".idea",
      "src/UI/components/ui/**.tsx",
      "**/*.test.js", // Ignorar archivos .test.js
      "**/*.test.ts", // Ignorar archivos .test.ts
      "**/*.test.jsx", // Ignorar archivos .test.jsx
      "**/*.test.tsx", // Ignorar archivos .test.tsx
      "**/*.spec.js", // Ignorar archivos .spec.js
      "**/*.spec.ts", // Ignorar archivos .spec.ts
      "**/*.spec.jsx", // Ignorar archivos .spec.jsx
      "**/*.spec.tsx", // Ignorar archivos .spec.tsx
    ],
  },
  // General configuration
  {
    rules: {
      "padding-line-between-statements": [
        "warn",
        { blankLine: "always", prev: "*", next: ["return", "export"] },
        {
          blankLine: "always",
          prev: ["const", "let", "var"],
          next: "*",
        },
        {
          blankLine: "any",
          prev: ["const", "let", "var"],
          next: ["const", "let", "var"],
        },
      ],
      "no-console": "warn",
      "no-alert": "warn", // Evita el uso de `alert`, `confirm`, etc.
      "no-debugger": "warn", // Evita el uso de `debugger`
      "no-empty-function": "off", //! Previene funciones vacías
      "prefer-const": "warn", // Asegura el uso de `const` cuando sea posible
      "consistent-return": "warn", // Asegura que las funciones tengan un `return` consistente
      eqeqeq: "warn", // Asegura el uso de `===` y `!==` en lugar de `==` y `!=`
      "lines-between-class-members": "warn", // Evita espacios en blanco entre clases
    },
  },
  // React configuration
  {
    plugins: {
      react: fixupPluginRules(eslintPluginReact),
      "react-hooks": fixupPluginRules(eslintPluginReactHooks),
      "react-compiler": fixupPluginRules(eslintPluginReactCompiler),
      "jsx-a11y": fixupPluginRules(eslintPluginJsxA11y),
    },
    languageOptions: {
      parserOptions: {
        ecmaFeatures: {
          jsx: true,
        },
      },
      globals: {
        ...globals.browser,
        ...globals.serviceworker,
      },
    },
    settings: {
      react: {
        version: "detect",
      },
    },
    rules: {
      ...eslintPluginReact.configs.recommended.rules,
      ...eslintPluginJsxA11y.configs.recommended.rules,
      ...eslintPluginReactHooks.configs.recommended.rules,
      ...vercelStyleGuideReact.rules,
      "react/prop-types": "off",
      "react/jsx-uses-react": "off",
      "react/react-in-jsx-scope": "off",
      "react/self-closing-comp": "warn",
      "react/jsx-sort-props": [
        "warn",
        {
          callbacksLast: true,
          shorthandFirst: true,
          noSortAlphabetically: false,
          reservedFirst: true,
        },
      ],
      "react/function-component-definition": [
        "warn",
        {
          namedComponents: "arrow-function",
          unnamedComponents: "arrow-function",
        },
      ],
      "react-compiler/react-compiler": "error",
      "react/jsx-no-leaked-render": "off",
      "jsx-a11y/no-static-element-interactions": "off",
      "jsx-a11y/click-events-have-key-events": "off",
      "jsx-a11y/anchor-is-valid": "warn", // Asegura que los enlaces sean válidos
      "jsx-a11y/label-has-associated-control": "warn", // Asegura que las etiquetas `<label>` tengan controles asociados
      "jsx-a11y/no-noninteractive-element-interactions": "warn", // Previene el uso de elementos no interactivos con interacciones
      "jsx-a11y/no-redundant-roles": "warn", // Evita roles redundantes en los elementos
      "jsx-a11y/accessible-emoji": "warn", // Asegura que los emojis sean accesibles
      "jsx-a11y/no-static-element-interactions": "warn", // Evita el uso de elementos estáticos con interacciones
      "jsx-a11y/click-events-have-key-events": "warn", // Asegura que los eventos de clic también tengan eventos de teclado
    },
  },
  // TypeScript configuration
  ...[
    ...tseslint.configs.recommended,
    {
      rules: {
        ...vercelStyleGuideTypescript.rules,
        "@typescript-eslint/no-unused-vars": "warn", // Evita el uso de variables no utilizadas
        "@typescript-eslint/no-non-null-assertion": "off", // Evita el uso de `!` en declaraciones de variables
        "@typescript-eslint/no-shadow": "off", // Evita el uso de `var` en declaraciones de variables
        "@typescript-eslint/explicit-function-return-type": "warn", // Evita el uso de `any` en declaraciones de funciones
        "@typescript-eslint/require-await": "off", // Evita el uso de promesas sin await en funciones
        "@typescript-eslint/no-floating-promises": "off", // Evita el uso de promesas sin await en funciones
        "@typescript-eslint/no-confusing-void-expression": "off", // Evita el uso de `void` en declaraciones de variables
        "@typescript-eslint/explicit-module-boundary-types": "error", // Requerir declaraciones de tipos de retorno en las funciones
        "@typescript-eslint/no-explicit-any": "error", // Requerir declaraciones de tipos de retorno en las funciones
        "@typescript-eslint/no-inferrable-types": "error", // Requerir declaraciones de tipos de retorno en las funciones
        "@typescript-eslint/explicit-function-return-type": "error", // Requerir declaraciones de tipos de retorno en las funciones
        "@typescript-eslint/no-empty-interface": "error", // Requerir declaraciones de tipos de retorno en las funciones
        "@typescript-eslint/ban-ts-comment": "error", // Evita los comentarios de `@ts-ignore` sin justificación

        "@typescript-eslint/consistent-type-definitions": ["error", "interface"], // Requerir declaraciones de tipos de retorno en las funciones
        "@typescript-eslint/member-ordering": "error", // Requerir declaraciones de tipos de retorno en las funciones
        // "@typescript-eslint/no-magic-numbers": ["error", { ignore: [0, 1] }], // Evita números mágicos
        "@typescript-eslint/no-this-alias": "error", // Evita el uso de `this` en declaraciones de variables
        "@typescript-eslint/adjacent-overload-signatures": "error", // Evita el uso de `=` en declaraciones de variables
        "@typescript-eslint/class-literal-property-style": "error",
        "@typescript-eslint/consistent-generic-constructors": "error",
        "@typescript-eslint/consistent-indexed-object-style": "error",
        "@typescript-eslint/consistent-type-assertions": "error",
        "@typescript-eslint/consistent-type-imports": "error",
        "@typescript-eslint/explicit-member-accessibility": "error",
        "@typescript-eslint/method-signature-style": "error",
        "@typescript-eslint/no-confusing-non-null-assertion": "error",
        "@typescript-eslint/no-duplicate-enum-values": "error",
        "@typescript-eslint/no-extra-non-null-assertion": "error",
        "@typescript-eslint/no-for-in-array": "error",
        "@typescript-eslint/no-import-type-side-effects": "error",
        "@typescript-eslint/no-require-imports": "error",
        "@typescript-eslint/no-unnecessary-type-assertion": "off",
        "@typescript-eslint/no-non-null-assertion": "error",
        "@typescript-eslint/unified-signatures": "off",
        "@typescript-eslint/no-unused-expressions": "off",
      },
    },
  ],
  // Prettier configuration
  ...[
    eslintPluginPrettier,
    {
      rules: {
        "prettier/prettier": [
          "warn",
          {
            semi: true,
            parser: "typescript",
            useTabs: false, // Cambiado a false para usar espacios
            tabWidth: 2,
            proseWrap: "preserve",
            endOfLine: "lf",
            printWidth: 90,
            quoteProps: "as-needed",
            rangeStart: 0,
            singleQuote: false,
            arrowParens: "always",
            insertPragma: false,
            trailingComma: "all",
            requirePragma: false,
            bracketSpacing: true,
            jsxSingleQuote: false,
            bracketSameLine: true,
            jsxBracketSameLine: true,
            singleAttributePerLine: false,
            htmlWhitespaceSensitivity: "css",
            embeddedLanguageFormatting: "auto",
            plugins: ["prettier-plugin-tailwindcss"],
            overrides: [
              {
                files: "*.{ts,tsx}",
                options: {
                  parser: "typescript",
                },
              },
              {
                files: "*.{js,jsx}",
                options: {
                  parser: "babel",
                },
              },
              {
                files: "*.vue",
                options: {
                  parser: "vue",
                },
              },
              {
                files: "*.css",
                options: {
                  parser: "css",
                },
              },
              {
                files: "*.scss",
                options: {
                  parser: "scss",
                },
              },
              {
                files: "*.less",
                options: {
                  parser: "less",
                },
              },
              {
                files: "*.json",
                options: {
                  parser: "json",
                },
              },
              {
                files: "*.md",
                options: {
                  parser: "markdown",
                },
              },
              {
                files: "*.yaml",
                options: {
                  parser: "yaml",
                },
              },
            ],
            importOrder: [
              "^react",
              "^next",
              "<THIRD_PARTY_MODULES>",
              "^@/(.*)$",
              "^[./]",
            ],
            importOrderSeparation: true,
            importOrderSortSpecifiers: true,
            importOrderGroupNamespaceSpecifiers: true,
            importOrderCaseInsensitive: true,
            xmlWhitespaceSensitivity: "strict",
            jsonRecursiveSort: true,
            astroAllowShorthand: false,
          },
        ],
      },
    },
  ],
  // Import configuration
  {
    plugins: {
      import: fixupPluginRules(eslintPluginImport),
    },
    rules: {
      "import/no-default-export": "off", // Evita exportaciones por defecto
      "import/first": "warn", // Asegura que las importaciones estén al principio del archivo
      "import/no-duplicates": "warn", // Evita importaciones duplicadas
      "import/order": [
        "warn",
        {
          groups: [
            "type",
            "builtin",
            "object",
            "external",
            "internal",
            "parent",
            "sibling",
            "index",
          ],
          pathGroups: [
            {
              pattern: "~/**",
              group: "external",
              position: "after",
            },
          ],
          "newlines-between": "always", // Determina si se usará una nueva línea entre importaciones
        },
      ],
    },
  },
  {
    plugins: {
      unused: fixupPluginRules(eslintPluginUnusedImport),
    },
    rules: {
      "unused/no-unused-imports": "warn",
      "unused/no-unused-vars": "warn",
    },
  },
  // Next configuration
  {
    plugins: {
      next: fixupPluginRules(eslintPluginNext),
    },
    languageOptions: {
      globals: {
        ...globals.node,
        ...globals.browser,
      },
    },
    rules: {
      ...vercelStyleGuideNext.rules,
      "next/no-img-element": "warn", // Evita el uso de `<img />` sin `next/image`
    },
  },
];
'
}



# ------------------------------------------------------------------------------
#* 4. Función para generar la configuración de eslint para Nest.js
generate_nest_eslint() {
    echo 'import { fixupPluginRules } from "@eslint/compat"
import tseslint from "typescript-eslint"
import globals from "globals"
import nestjsPlugin from "eslint-plugin-nestjs"
import eslintPluginImport from "eslint-plugin-import"
import eslintPluginUnusedImport from 'eslint-plugin-unused-imports'
import eslintPluginPrettier from "eslint-plugin-prettier/recommended"
import eslintPluginNode from "eslint-plugin-node"
import eslintPluginSecurity from "eslint-plugin-security"

export default [
  // Ignores configuration
  {
    ignores: [
      "node_modules",
      ".next",
      "out",
      "coverage",
      ".idea",
      "dist",
      "build",
      "*.log",
      "*.tmp",
      "*.json",
      "package-lock.json",
      "yarn.lock",
      "pnpm-lock.yaml",
      "tsconfig.json",
      "tsconfig.build.json",
      "webpack.config.js",
      "prettier.config.js",
      ".env",
      ".env.local",
      ".env.*.local",
      "db.sqlite",
      "*.sql",
      "*.db",
      "*.map",
      ".vscode",
      "tests",
      "test",
      "__tests__",
      "docs",
      "examples",
      "src/**/*.test.ts",
      "src/**/*.test.js",
      "src/**/*.spec.ts",
      "src/**/*.spec.js",
      "*.bak",
      "*.swp",
      "*.swo",
    ],
  },
  // General configuration
  {
    rules: {
      "padding-line-between-statements": [
        "warn",
        { blankLine: "always", prev: "*", next: ["return", "export"] },
        {
          blankLine: "always",
          prev: ["const", "let", "var"],
          next: "*",
        },
        {
          blankLine: "any",
          prev: ["const", "let", "var"],
          next: ["const", "let", "var"],
        },
      ],
      "no-console": "warn",
      "no-alert": "warn",
      "no-debugger": "warn",
      "no-unused-vars": "warn",
      "no-empty-function": "warn",
      "prefer-const": "warn",
      "consistent-return": "warn",
      eqeqeq: "warn",
    },
  },
  // TypeScript configuration
  ...[
    ...tseslint.configs.recommended,
    ...tseslint.configs.strict,
    {
      rules: {
        "@typescript-eslint/no-unsafe-call": "off",
        "@typescript-eslint/explicit-module-boundary-types": "error",
        "@typescript-eslint/no-explicit-any": "error",
        "@typescript-eslint/no-inferrable-types": "error",
        "@typescript-eslint/explicit-function-return-type": "error",
        "@typescript-eslint/no-empty-interface": "error",
        "@typescript-eslint/ban-ts-comment": "error",
        "@typescript-eslint/no-unused-vars": [
          "error",
          { argsIgnorePattern: "^_" },
        ],
        "@typescript-eslint/consistent-type-definitions": [
          "error",
          "interface",
        ],
        "@typescript-eslint/explicit-module-boundary-types": "error",
        "@typescript-eslint/member-ordering": "error",
        "@typescript-eslint/no-magic-numbers": "error",
        "@typescript-eslint/no-this-alias": "error",
        "@typescript-eslint/adjacent-overload-signatures": "error",
        "@typescript-eslint/class-literal-property-style": "error",
        "@typescript-eslint/consistent-generic-constructors": "error",
        "@typescript-eslint/consistent-indexed-object-style": "error",
        "@typescript-eslint/consistent-type-assertions": "error",
        "@typescript-eslint/consistent-type-imports": "error",
        "@typescript-eslint/explicit-member-accessibility": "error",
        "@typescript-eslint/method-signature-style": "error",
        "@typescript-eslint/no-confusing-non-null-assertion": "error",
        "@typescript-eslint/no-duplicate-enum-values": "error",
        "@typescript-eslint/no-extra-non-null-assertion": "error",
        "@typescript-eslint/no-for-in-array": "error",
        "@typescript-eslint/no-import-type-side-effects": "error",
        "@typescript-eslint/no-require-imports": "error",
        "@typescript-eslint/no-non-null-assertion": "error",
        "@typescript-eslint/ban-tslint-comment": "error",
        "@typescript-eslint/consistent-type-definitions": "error",
        "@typescript-eslint/no-misused-promises": "off",
        eqeqeq: ["error", "always"],
        "no-console": "error",
        "@typescript-eslint/unified-signatures": "off",
      },
    },
  ],
  // Prettier configuration
  ...[
    eslintPluginPrettier,
    {
      rules: {
        "prettier/prettier": [
          "warn",
          {
            experimentalTernaries: true,
            printWidth: 80,
            tabWidth: 2,
            useTabs: false,
            semi: false,
            singleQuote: true,
            quoteProps: "as-needed",
            trailingComma: "all",
            bracketSpacing: true,
            bracketSameLine: true,
            arrowParens: "always",
            parser: "typescript",
            requirePragma: false,
            insertPragma: false,
            proseWrap: "always",
            htmlWhitespaceSensitivity: "css",
            vueIndentScriptAndStyle: false,
            endOfLine: "lf",
            embeddedLanguageFormatting: "auto",
            singleAttributePerLine: false,
            requireConfig: true,
            fileInfoOptions: {
              withNodeModules: true,
              module: true,
            },
          },
        ],
      },
    },
  ],
  // Import configuration
  {
    plugins: {
      import: fixupPluginRules(eslintPluginImport),
    },
    rules: {
      "import/no-default-export": "off",
      "import/first": "warn",
    },
  },
  {
		plugins: {
			unused: fixupPluginRules(eslintPluginUnusedImport),
		},
		rules: {
			'unused/no-unused-imports': 'warn',
			'unused/no-unused-vars': 'warn',
		},
	},
  // NestJS configuration
  {
    plugins: {
      nestjs: nestjsPlugin,
    },
    languageOptions: {
      globals: {
        ...globals.node,
        ...globals.browser,
      },
    },
    rules: {},
  },
  // Node configuration
  {
    plugins: {
      node: eslintPluginNode,
    },
    rules: {
      "node/no-unsupported-features/es-syntax": "off",
      "node/no-extraneous-import": "warn",
    },
  },
  // Security configuration
  {
    plugins: {
      security: eslintPluginSecurity,
    },
    rules: {
      "security/detect-object-injection": "warn",
      "security/detect-non-literal-fs-filename": "warn",
    },
  },
  // TypeScript paths configuration
  {
    settings: {
      "import/resolver": {
        typescript: {
          project: "./tsconfig.json",
          alwaysTryTypes: true,
          extensions: [".ts", ".tsx", ".d.ts"],
        },
      },
    },
  },
]
'
}

# ------------------------------------------------------------------------------
#* 5. Función para manejar el gestor de paquetes (npm, yarn, pnpm)
ask_for_package_manager() {
    read -p "¿Qué gestor de paquetes estás utilizando? (npm/yarn/pnpm): " package_manager
    if [[ "$package_manager" == "npm" || "$package_manager" == "yarn" || "$package_manager" == "pnpm" ]]; then
        echo "$package_manager"
    else
        echo "Respuesta no válida. Debes ingresar 'npm', 'yarn' o 'pnpm'."
        ask_for_package_manager  # Llamada recursiva
    fi
}



# ------------------------------------------------------------------------------
#* 8. Función para crear o reemplazar un archivo tyscript.jsom
check_tsconfig_exists() {

       # Comprobar si ya existe un archivo tsconfig.json
  if [ -f "tsconfig.json" ]; then
        read -p "tsconfig.json ya existe. ¿Deseas reemplazarlo? (s/n): " respuesta
        if [[ "$respuesta" != "s" ]]; then
            echo "No se reemplazará tsconfig.json."
            return 1  # Retorna 1 si no se reemplaza
        fi
    fi
}
generate_nest_tsconfig() {
    echo '{
  "compilerOptions": {
    "allowUnreachableCode": false,
    "allowUnusedLabels": false,
    "alwaysStrict": true,
    "exactOptionalPropertyTypes": true,
    "noFallthroughCasesInSwitch": true,
    "noImplicitAny": true,
    "noImplicitOverride": true,
    "noImplicitReturns": true,
    "noImplicitThis": true,
    "noPropertyAccessFromIndexSignature": true,
    "noUncheckedIndexedAccess": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "strict": true,
    "strictBindCallApply": true,
    "strictBuiltinIteratorReturn": true,
    "strictFunctionTypes": true,
    "strictNullChecks": true,
    "strictPropertyInitialization": true,
    "useUnknownInCatchVariables": true,
    "baseUrl": "./",
    "module": "commonjs",
    "target": "ESNext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "declaration": true,
    "sourceMap": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "resolveJsonModule": true,
    "typeRoots": ["./node_modules/@types", "./src/@types"],
    "lib": ["ES2021", "DOM"],
    "incremental": true,
    "noEmitOnError": true,
    "allowSyntheticDefaultImports": true,
    "forceConsistentCasingInFileNames": true,
    "allowJs": false,
    "useDefineForClassFields": true,
    "suppressImplicitAnyIndexErrors": false,
    "disableSizeLimit": true,
    "removeComments": true
  },
  "include": ["src/**/*.ts", "src/@types/**/*.d.ts", "prettier.config.js", "package.json"],
  "exclude": ["node_modules", "dist", "package.json"]
}'
}

generate_next_tsconfig() {
    echo '{
  "compilerOptions": {
    // Activa siempre el modo estricto (equivalente a `use strict` en JavaScript).
    "alwaysStrict": true,

    // Asegura que los tipos opcionales sean tratados de manera exacta (sin asumir que son `undefined`).
    "exactOptionalPropertyTypes": true,

    // Impide que haya "fallthrough" (caídas) en los `switch` sin un `break` o `return`.
    "noFallthroughCasesInSwitch": true,

    // Fuerza la declaración explícita de los tipos de las variables, evitando el tipo `any` implícito.
    "noImplicitAny": true,

    // Requiere que todos los métodos que sobrescriben un método de una clase base tengan la palabra clave `override`.
    "noImplicitOverride": true,

    // Requiere que todas las funciones tengan un valor de retorno explícito.
    "noImplicitReturns": true,

    // Impide que el valor de `this` se asuma de manera implícita (debe ser explícito).
    "noImplicitThis": true,

    // Desactiva variables locales no usadas.
    "noUnusedLocals": true,

    // Desactiva parámetros no usados en las funciones.
    "noUnusedParameters": true,

    // Activa todas las verificaciones estrictas en TypeScript.
    "strict": true,

    // Asegura que los tipos de funciones de llamada (como `bind`, `call`, y `apply`) sean estrictos.
    "strictBindCallApply": true,

    // Establece que los tipos de funciones sean estrictos (por ejemplo, comparación de tipos en función).
    "strictFunctionTypes": true,

    // Establece que `null` y `undefined` son diferentes de cualquier otro tipo (comprobación estricta).
    "strictNullChecks": true,

    // Requiere que todas las propiedades de clase sean inicializadas en el constructor o estén explícitamente declaradas como `undefined`.
    "strictPropertyInitialization": true,

    // Utiliza `unknown` para las variables capturadas en un bloque `catch`, en lugar de `any`.
    "useUnknownInCatchVariables": true,

    // Permite JSX con la configuración `react` (requiere `react` como dependencia).
    "jsx": "react-jsx",

    // Activa la verificación de los módulos `esnext` en tiempo de compilación.
    "module": "ESNext",

    // Usa la resolución de módulos de Node.js.
    "moduleResolution": "node",

    // Configura la versión de ECMAScript a `ESNext`.
    "target": "ESNext",

    // Habilita la generación de archivos `.d.ts` (declaraciones de tipos).
    "declaration": true,

    // Genera un archivo `.map` para facilitar la depuración.
    "sourceMap": true,

    // Permite la importación de módulos ES6 por defecto.
    "esModuleInterop": true,

    // Permite la resolución de módulos JSON.
    "resolveJsonModule": true,

    // Activa la generación de metadatos para decoradores (útil con TypeORM o similar).
    "emitDecoratorMetadata": true,

    // Permite el uso de decoradores (requiere que `experimentalDecorators` esté activado).
    "experimentalDecorators": true,

    // Omite la comprobación de tipos de las dependencias de las librerías.
    "skipLibCheck": true,

    // Especifica las ubicaciones de los tipos de definición.
    "typeRoots": ["./node_modules/@types", "./src/@types/**/*.d.ts"],

    // Especifica las bibliotecas de tipos a incluir (en este caso, ES2021 y DOM).
    "lib": ["ESNext", "DOM"],

    // Activa la compilación incremental para mejorar el rendimiento en compilaciones posteriores.
    "incremental": true,

    // Evita la generación de archivos si hay errores de compilación.
    "noEmitOnError": true,

    // Permite la importación de módulos con `default` aunque no tenga un `export default`.
    "allowSyntheticDefaultImports": true,

    // Fuerza el uso consistente de mayúsculas y minúsculas en los nombres de archivos.
    "forceConsistentCasingInFileNames": true,

    // Permite usar archivos `.js` en un proyecto de TypeScript.
    "allowJs": true,

    // Usa las propiedades de clase estándar de ES6.
    "useDefineForClassFields": true,

    // Desactiva el límite de tamaño de los archivos de salida en compilación.
    "disableSizeLimit": true,

    // Elimina los comentarios del código de salida.
    "removeComments": true,
    "noEmit": true,
    "isolatedModules": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
// Archivos y carpetas a incluir en la compilación.
"include": [
  "src/**/*.ts",
  "src/**/*.tsx", // Soporta archivos .tsx de React
  "next-env.d.ts", // Archivos específicos de Next.js (auto-generados)
  "prettier.config.js",
  "package.json"
],

// Archivos y carpetas a excluir de la compilación.
"exclude": [
  "node_modules",
  "dist",
  ".next", // Excluye la carpeta de Next.js
  "package.json"
]
}'
}
#! 9. Función para crear o reemplazar un archivo tyscript.jsom
check_prettier_exists() {

   local prettier_files=("prettier.config.js , .prettierrc , prettier.jsom")

    # Comprobar cada archivo de la lista
    for prettier_file in "${prettier_files[@]}"; do
        if [ -f "$prettier_file" ]; then
        read -p "prettier.config.js ya existe. ¿Deseas reemplazarlo? (s/n): " respuesta
        if [[ "$respuesta" != "s" ]]; then
            echo "No se reemplazará prettier.config.js."
            return
        fi
        echo "Reemplazando prettier.config.js..."
    fi
  done
}


check_prettierignore_exists() {

       # Comprobar si ya existe un archivo .prettierignore
    if [ -f ".prettierignore" ]; then
        read -p ".prettierignore ya existe. ¿Deseas reemplazarlo? (s/n): " respuesta
        if [[ "$respuesta" != "s" ]]; then
            echo "No se reemplazará .prettierignore."
            return 1  # No reemplazar
        fi
    fi
}


#! 11. Función para crear o reemplazar un archivo .gitignore


check_gitignore_exists() {

       # Comprobar si ya existe un archivo .gitignore
    if [ -f ".gitignore" ]; then
        read -p ".gitignore ya existe. ¿Deseas reemplazarlo? (s/n): " respuesta
        if [[ "$respuesta" != "s" ]]; then
            echo "No se reemplazará .gitignore."
            return 1  # No reemplazar
        fi
    fi
}

create_gitignore() {
    echo '
# Node.js
node_modules/
npm-debug.log
package-lock.json
yarn-error.log
.next
pnpm-lock.yaml

# Python
__pycache__/
*.py[cod]
*.pyo
*.pyd
env/
venv/
*.egg-info/

# Java
*.class
*.jar
*.war
*.ear
target/
*.log
.idea/
*.iml

# Ruby
*.gem
*.rbc
.bundle/
vendor/
log/

# PHP
/vendor/
*.log
.env

# Go
/bin/
*.exe
*.test

# C/C++
*.o
*.out
*.exe
*.class
*.dSYM/

# Visual Studio
.vs/
*.suo
*.user
*.userprefs
*.sln.ide

# macOS
.DS_Store
.AppleDouble
.LSOverride
Icon?

# Windows
Thumbs.db
Desktop.ini
$RECYCLE.BIN/

# IDEs
.idea/
*.sublime-workspace
*.sublime-project
*.vscode/

# Other
*.log
*.tmp
*.bak
*.swp
*.swm
*.swo

# Environment variables
.env
*.local

# Build directories
build/
dist/
out/

# Documentation
*.pdf
*.doc
*.docx
*.ppt
*.pptx

# Coverage
coverage/
*.cover
*.lcov

# Test files
test-results/
*.test.js
*.spec.js

# Git
*.orig
*.patch
'
}

check_editorconfig_exists() {

       # Comprobar si ya existe un archivo .editorconfig
    if [ -f ".editorconfig" ]; then
        read -p ".editorconfig ya existe. ¿Deseas reemplazarlo? (s/n): " respuesta
        if [[ "$respuesta" != "s" ]]; then
            echo "No se reemplazará .editorconfig."
            return 1  # No reemplazar
        fi
    fi
}

create_editorconfig() {
    echo '
root = true

[*]
max_line_length = 90
# General settings
indent_size = 2
indent_style = space       # Usa espacios en lugar de tabuladores
end_of_line = lf           # Usar LF como final de línea
charset = utf-8            # Codificación de caracteres

'
}
# ------------------------------------------------------------------------------
#* 6. Función para instalar TypeScript
install_required_packages() {
    package_manager=$(ask_for_package_manager)
    framework=$(ask_project_type)

   case "$package_manager" in
    npm)
        echo "Instalando dependencias con npm..."
        if [[ "$framework" == "nest" ]]; then
            npm install --save-dev eslint
        elif [[ "$framework" == "next" ]]; then
            npm install --save-dev eslint
        fi
        ;;
    yarn)
        echo "Instalando dependencias con yarn..."
        if [[ "$framework" == "nest" ]]; then
            yarn add --dev eslint
        elif [[ "$framework" == "next" ]]; then
            yarn add --dev eslint
        fi
        ;;
    pnpm)
        echo "Instalando dependencias con pnpm..."
        if [[ "$framework" == "nest" ]]; then
           pnpm i -D @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint eslint-config-prettier eslint-plugin-import eslint-plugin-nestjs eslint-plugin-node eslint-plugin-prettier eslint-plugin-security globals prettier-eslint prettier typescript-eslint typescript husky lint-staged eslint-plugin-unused-imports
        elif [[ "$framework" == "next" ]]; then
             pnpm i -D  @eslint/compat @next/eslint-plugin-next babel-plugin-react-compiler eslint eslint-config-next eslint-config-prettier eslint-plugin-import eslint-plugin-jsx  eslint-plugin-prettier eslint-plugin-react-compiler globals prettier prettier-plugin-tailwindcss typescript typescript-eslint @vercel/style-guide husky lint-staged eslint-plugin-unused-imports
        fi
        ;;
    *)
        echo "Empaquetador no reconocido. No se instalarán las dependencias."
        ;;
esac
}

generate_husky() {
    echo '
    #!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged

# "prepare": "husky install" package.json
'
}
generate_lintstagedrc() {
    echo '
{
  "**/{src,test}/**/*.{ts,tsx}": [
    "eslint --fix",
    "prettier --write"
  ],
  "**/*.{ts,tsx}": "bash -c tsc -p tsconfig.json --noEmit"
}

'
}

# ------------------------------------------------------------------------------
# Función principal que organiza el flujo del script
main() {
    # Verificar si .eslintrc.js existe y preguntar si se desea reemplazar
    check_eslint_exists || return  # Si no se desea reemplazar, detener la ejecución
    check_tsconfig_exists || return  # Si no se desea reemplazar, detener la ejecución
    check_prettier_exists || return
    check_gitignore_exists || return
    check_editorconfig_exists || return

    # Pedir el tipo de proyecto
    project_type=$(ask_project_type)
    husky=$(generate_husky)
    lintstagedrc=$(generate_lintstagedrc)

    # Generar la configuración de eslint según el tipo de proyecto
    case "$project_type" in
        next)
            eslintrc=$(generate_next_eslint)
            tsconfig=$(generate_next_tsconfig)
            ;;
        nest)
            eslintrc=$(generate_nest_eslint)
            tsconfig=$(generate_nest_tsconfig)
            ;;
        *)
            echo "Tipo de proyecto no válido. Debes ingresar 'next' o 'nest'."
            return
            ;;
    esac

    # Crear el archivo .lintstagedrc
    echo "$lintstagedrc" > .lintstagedrc
    echo ".lintstagedrc creado/reemplazado exitosamente."

    # Crear el archivo .eslintrc.js o eslint.config.mjs según se desee
    echo "$eslintrc" > eslint.config.mjs  # Asegúrate de que sea .eslintrc.js si ese es tu objetivo
    echo "eslint.config.mjs creado/reemplazado exitosamente."

    # Crear el archivo tsconfig.json
    echo "$tsconfig" > tsconfig.json
    echo "tsconfig.json creado/reemplazado exitosamente."

    # Crear la carpeta /.husky y el archivo pre-commit dentro de ella
    mkdir -p .husky
    echo "$husky" > .husky/pre-commit
    echo "Archivo .husky/pre-commit creado/reemplazado exitosamente."

    # Crear el archivo .gitignore
    create_gitignore > .gitignore
    echo ".gitignore creado/reemplazado exitosamente."

    # Crear el archivo .editorconfig
    create_editorconfig > .editorconfig
    echo ".editorconfig creado/reemplazado exitosamente."

    # Instalar paquetes requeridos
    install_required_packages
}

# Llamada a la función principal para ejecutar el script
main
