/* =========================================================
   Help-Seiten-Suche: Abschnitts-Navigation
   ========================================================= */

(() => {

    const input = document.getElementById("helpSearchInput");
    if (!input) return;

    /* -----------------------------------------------------
       Suchindex
       ----------------------------------------------------- */
    const helpIndex = [
        {
            id: "help-apikey",
            keywords: [
                "api", "api key", "apikey", "schlüssel",
                "llm", "modell", "provider", "gemini"
            ]
        },
        {
            id: "help-upload",
            keywords: [
                "upload", "pdf", "bericht hochladen",
                "esg bericht", "esrs bericht", "datei"
            ]
        },
        {
            id: "help-company",
            keywords: [
                "unternehmen", "firma", "company",
                "unternehmen hinzufügen", "firma anlegen"
            ]
        },
        {
            id: "help-sektors",
            keywords: [
                "sektor", "sektoren",
                "was ist ein sektor",
                "was macht ein sektor"
            ]
        },
        {
            id: "help-industries",
            keywords: [
                "industrie", "industrien",
                "branche", "branchen"
            ]
        },
        {
            id: "help-standards",
            keywords: [
                "standard", "standards", "esrs standard"
            ]
        },
        {
            id: "help-requirements",
            keywords: [
                "anforderung", "anforderungen",
                "requirement", "requirements"
            ]
        },
        {
            id: "help-pipeline",
            keywords: [
                "pipeline", "verarbeitung",
                "analyse", "automatische verarbeitung"
            ]
        },
        {
            id: "help-results",
            keywords: [
                "ergebnis", "ergebnisse",
                "auswertung", "resultate"
            ]
        }
    ];

    /* -----------------------------------------------------
       Event: Enter in Suchfeld
       ----------------------------------------------------- */
    input.addEventListener("keydown", (e) => {
        if (e.key === "Enter") {
            e.preventDefault();
            performSearch(input.value);
        }
    });

    /* -----------------------------------------------------
       Suche ausführen
       ----------------------------------------------------- */
    function performSearch(query) {
        if (!query) return;

        const normalizedQuery = query
            .toLowerCase()
            .trim()
            .replace(/[?!.]/g, "");

        for (const entry of helpIndex) {
            for (const keyword of entry.keywords) {
                if (normalizedQuery.includes(keyword)) {
                    scrollToSection(entry.id);
                    return;
                }
            }
        }

        alert("Kein passender Hilfebereich gefunden.");
    }

    /* -----------------------------------------------------
       Scroll + Highlight
       ----------------------------------------------------- */
    function scrollToSection(id) {
        const target = document.getElementById(id);
        if (!target) return;

        target.scrollIntoView({
            behavior: "smooth",
            block: "start"
        });

        // Highlight zurücksetzen (falls mehrfach gesucht wird)
        document
            .querySelectorAll(".help-highlight")
            .forEach(el => el.classList.remove("help-highlight"));

        target.classList.add("help-highlight");

        setTimeout(() => {
            target.classList.remove("help-highlight");
        }, 2000);
    }

})();
