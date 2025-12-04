#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>

#include "tree-sitter/json/tree_sitter/parser.h"
extern const TSLanguage *tree_sitter_json(void);

static const TSLanguage *json_lang = NULL;

SEXP ts_language_jsonc() {
  if (json_lang == NULL) {
    json_lang = tree_sitter_json();
  }
  SEXP res = Rf_protect(
    R_MakeExternalPtr((void *)json_lang, R_NilValue, R_NilValue)
  );
  SEXP cls = Rf_protect(Rf_allocVector(STRSXP, 2));
  SET_STRING_ELT(cls, 0, Rf_mkChar("ts_language_jsonc"));
  SET_STRING_ELT(cls, 1, Rf_mkChar("ts_language"));
  Rf_setAttrib(res, R_ClassSymbol, cls);
  Rf_unprotect(2);
  return res;
}

static const R_CallMethodDef callMethods[]  = {
  { "ts_language_jsonc", (DL_FUNC) &ts_language_jsonc, 0 },
  { NULL, NULL, 0 }
};

void R_init_tsjsonc(DllInfo *dll) {
  R_registerRoutines(dll, NULL, callMethods, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
  R_forceSymbols(dll, TRUE);
}
