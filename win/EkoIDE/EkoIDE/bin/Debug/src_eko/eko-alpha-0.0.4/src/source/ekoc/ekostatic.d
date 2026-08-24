module ekoc.ekostatic;

enum Ekoctype {
    keyword,
    name,
    op,
    valaue
}
struct EkocToken {
    string value;
    Ekoctype type;
}