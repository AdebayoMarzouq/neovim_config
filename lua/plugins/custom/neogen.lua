local opts = {
  enabled = true,
  input_after_comment = true,
  snippet_engine = "luasnip",
  languages = {
    typescript = {
      template = {
        annotation_convention = "tsdoc",
        tsdoc = {
          -- Complex types and interfaces
          class_declaration = {
            ["default"] = {
              "/**",
              " * ${description}",
              " *",
              " * @interface ${interface_name}",
              " * @template T - Type parameter description",
              " * @property {type} propertyName - Property description",
              " */",
            },
          },
          -- API endpoints and methods
          function_declaration = {
            ["default"] = {
              "/**",
              " * ${description}",
              " *",
              " * @param {object} params - The parameters object",
              " * @param {string} params.id - The resource identifier",
              " * @throws {Error} When resource is not found",
              " * @returns {Promise<T>} The resource data",
              " */",
            },
          },
        },
      },
    },
    python = {
      template = {
        annotation_convention = "google_docstrings",
        -- REST API endpoints
        class_declaration = {
          ["default"] = {
            '"""${description}',
            "",
            "Attributes:",
            "    ${attribute_name} (${type}): ${description}",
            "",
            "Methods:",
            "    ${method_name}: ${description}",
            '"""',
          },
        },
        -- Data processing functions
        function_declaration = {
          ["default"] = {
            '"""${description}',
            "",
            "Args:",
            "    ${param} (${type}): ${description}",
            "",
            "Raises:",
            "    ${exception}: ${description}",
            "",
            "Returns:",
            "    ${type}: ${description}",
            '"""',
          },
        },
      },
    },
    go = {
      template = {
        annotation_convention = "godoc",
        -- Package documentation
        file_declaration = {
          ["default"] = {
            "// Package ${package_name} provides ${description}",
            "//",
            "// Usage:",
            "//     ${example_code}",
          },
        },
        -- Interface and struct documentation
        type_declaration = {
          ["default"] = {
            "// ${type_name} ${description}",
            "//",
            "// Fields:",
            "//     ${field_name}: ${description}",
          },
        },
      },
    },
    c = {
      template = {
        annotation_convention = "doxygen",
        -- Header file documentation
        file_declaration = {
          ["default"] = {
            "/**",
            " * @file ${filename}",
            " * @brief ${description}",
            " * @author ${author}",
            " */",
          },
        },
        -- Function documentation with error handling
        function_declaration = {
          ["default"] = {
            "/**",
            " * @brief ${description}",
            " *",
            " * @param ${param} ${description}",
            " * @return ${return_type} ${description}",
            " * @retval ${error_code} ${error_description}",
            " */",
          },
        },
      },
    },
  },
}

local n = require "neogen"
n.setup(opts)
