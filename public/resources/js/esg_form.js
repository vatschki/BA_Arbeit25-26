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
                const reqStandardId = $(this).data("standard-id");

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