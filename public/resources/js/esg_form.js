    //Form Selects
    document.addEventListener("DOMContentLoaded", function () {
        const $standard = $("#standardSelect");
        const $requirement = $("#requirementSelect");

        const allRequirementOptions = $requirement.find("option").clone();

        function filterRequirements() {
            const standardId = $standard.val();

            $requirement.empty();

            $requirement.append(
                `<option value="" disabled selected>ESRS-Anforderung auswählen</option>`
            );

            if (!standardId) {
                $requirement.trigger("change");
                return;
            }

            allRequirementOptions.each(function () {
                const value = $(this).val();
                const reqStandardId = $(this).data("standard-id");

                // Sonderfall: "Alle Anforderungen"
                if (value === 'ALL') {
                    $requirement.append($(this).clone());
                    return;
                }

                // Normale Requirements nach Standard filtern
                if (reqStandardId == standardId) {
                    $requirement.append($(this).clone());
                }
            });

            $requirement.trigger("change");
        }

        $standard.on("change", filterRequirements);

        filterRequirements();
    });

    // PDF Drag & Drop
    document.addEventListener("DOMContentLoaded", function () {

        const dropZone   = document.getElementById("pdf-drop-zone");
        const fileInput  = document.getElementById("pdf-input");
        const browseBtn  = document.getElementById("pdf-browse-btn");
        const fileListEl = document.getElementById("pdf-file-list");

        function setFile(file) {
            if (!file) return;

            const isPdf =
                file.type === "application/pdf" ||
                file.name.toLowerCase().endsWith(".pdf");

            if (!isPdf) {
                fileInput.value = "";
                fileListEl.textContent = "Bitte eine gültige PDF-Datei auswählen.";
                return;
            }

            // WICHTIG: Datei ins Input schreiben
            const dataTransfer = new DataTransfer();
            dataTransfer.items.add(file);
            fileInput.files = dataTransfer.files;

            fileListEl.innerHTML =
                `• ${file.name} (${Math.round(file.size / 1024)} KB)`;
        }

        dropZone.addEventListener("click", () => fileInput.click());

        browseBtn.addEventListener("click", (e) => {
            e.stopPropagation();
            fileInput.click();
        });

        fileInput.addEventListener("change", (e) => {
            setFile(e.target.files?.[0]);
        });

        dropZone.addEventListener("dragover", (e) => {
            e.preventDefault();
            dropZone.classList.add("dragover");
        });

        dropZone.addEventListener("dragleave", () => {
            dropZone.classList.remove("dragover");
        });

        dropZone.addEventListener("drop", (e) => {
            e.preventDefault();
            dropZone.classList.remove("dragover");
            setFile(e.dataTransfer.files?.[0]);
        });
    });

    //Validatin
    (() => {
        'use strict';

        const form = document.getElementById('createReportForm');

        form.addEventListener('submit', event => {
            const fileInput = document.getElementById("pdf-input");

            // Wenn vorher schon verhindert wurde (Relevant Pages), abbrechen
            if (event.defaultPrevented) return;

            if (!form.checkValidity() || fileInput.files.length === 0) {
                event.preventDefault();
                event.stopPropagation();

                if (fileInput.files.length === 0) {
                    document.getElementById("pdf-error").style.display = "block";
                    document.getElementById("pdf-drop-zone").classList.add("is-invalid");
                }
            }

            form.classList.add('was-validated');
        }, false);
    })();


    // Form Relevant Pages Validation
    const check = document.getElementById("relevantPagesCheck");
    const container = document.getElementById("relevantPagesContainer");
    const addBtn = document.getElementById("addRangeBtn");
    const enabledInput = document.getElementById("relevantPagesEnabled");
    const errorBox = document.getElementById("relevantPagesError");

    let rangeIndex = 1;

    check.addEventListener("change", function () {
        if (this.checked) {
            container.classList.remove("d-none");
            enabledInput.value = "1";
        } else {
            container.classList.add("d-none");
            enabledInput.value = "0";
            container.querySelectorAll("input").forEach(i => i.value = "");
            errorBox.classList.add("d-none");
        }
    });

    addBtn.addEventListener("click", function () {
        const row = document.createElement("div");
        row.className = "range-row d-flex gap-2 mb-2";

        row.innerHTML = `
        <input type="number" min="1" class="form-control" name="relevant_pages[${rangeIndex}][start]" placeholder="Start">
        <input type="number" min="1" class="form-control" name="relevant_pages[${rangeIndex}][end]" placeholder="Ende">
    `;

        container.insertBefore(row, addBtn);
        rangeIndex++;
    });

    document.querySelector("#createReportForm").addEventListener("submit", function (e) {
        if (!check.checked) return; // Checkbox aus = OK

        const rows = container.querySelectorAll(".range-row");
        let validPairs = 0;

        rows.forEach(row => {
            const start = row.querySelector("input[name*='start']").value;
            const end   = row.querySelector("input[name*='end']").value;

            if (start !== "" && end !== "" && parseInt(start) <= parseInt(end)) {
                validPairs++;
            }
        });

        if (validPairs === 0) {
            e.preventDefault();
            errorBox.classList.remove("d-none");
        } else {
            errorBox.classList.add("d-none");
        }
    });
