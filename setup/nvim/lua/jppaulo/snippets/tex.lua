local ls = require("luasnip")
local s, t, i = ls.snippet, ls.text_node, ls.insert_node
return {
  s("sec", { t("\\section{"), i(1, "Title"), t({ "}", "\\label{sec:" }),
    i(2, "name"), t({ "}", "", "" }), i(0) }),
  s("cite", { t("\\cite{"), i(1, "key"), t("}"), i(0) }),
  s("ref", { t("\\ref{"), i(1, "label"), t("}"), i(0) }),
  s("fig", { t({ "\\begin{figure}[htbp]", "  \\centering",
    "  \\includegraphics[width=0.85\\textwidth]{" }), i(1, "filename"),
    t({ "}", "  \\caption{" }), i(2, "Caption"), t({ "}", "  \\label{fig:" }),
    i(3, "name"), t({ "}", "\\end{figure}", "" }), i(0) }),
  s("itemize", { t({ "\\begin{itemize}", "  \\item " }), i(1),
    t({ "", "\\end{itemize}", "" }), i(0) }),
}
