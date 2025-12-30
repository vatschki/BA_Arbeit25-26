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

        let selectedFile = null;

        function setFile(file) {
            if (!file) return;

            const isPdf = file.type === "application/pdf" || file.name.toLowerCase().endsWith(".pdf");
            if (!isPdf) {
                selectedFile = null;
                window.selectedPdfFile = null
                fileListEl.textContent = "Bitte eine gültige PDF-Datei auswählen.";
                return;
            }

            selectedFile = file;
            window.selectedPdfFile = selectedFile;
            fileListEl.innerHTML = `• ${file.name} (${Math.round(file.size / 1024)} KB)`;
        }

        dropZone.addEventListener("click", () => fileInput.click());
        browseBtn.addEventListener("click", (e) => {
            e.stopPropagation();
            fileInput.click();
        });

        // File input
        fileInput.addEventListener("change", (e) => setFile(e.target.files?.[0]));

        // Drag Events
        dropZone.addEventListener("dragover", (e) => {
            e.preventDefault();
            dropZone.classList.add("dragover");
        });

        dropZone.addEventListener("dragleave", (e) => {
            e.preventDefault();
            dropZone.classList.remove("dragover");
        });

        dropZone.addEventListener("drop", (e) => {
            e.preventDefault();
            dropZone.classList.remove("dragover");
            setFile(e.dataTransfer.files?.[0]);
        });

        window.selectedPdfFile = selectedFile;
    });

    // Save Button - Pipeline starten
    document.addEventListener("DOMContentLoaded", function () {

        const saveBtn = document.getElementById("createSaveBtn");

        saveBtn.addEventListener("click", async () => {

            const file = window.selectedPdfFile;
            if (!file) {
                alert("Bitte eine PDF auswählen.");
                return;
            }

            const modal = document.getElementById("createReportModal");
            const companyId     = modal.querySelector('select[name="company_id"]').value;
            const year          = modal.querySelector('select[name="year"]').value;
            const standardId    = modal.querySelector('select[name="standard_id"]').value;
            const requirementId = modal.querySelector('select[name="requirement_id"]').value;

            const formData = new FormData();
            formData.append("report", file);
            formData.append("company_id", companyId);
            formData.append("year", year);
            formData.append("standard_id", standardId);
            formData.append("requirement_id", requirementId);

            saveBtn.disabled = true;
            saveBtn.textContent = "Wird gespeichert...";

            const res = await fetch("/esg-reports/process", {
                method: "POST",
                body: formData
            });

            const data = await res.json();

            saveBtn.disabled = false;
            saveBtn.textContent = "Speichern";

            if (!res.ok) {
                alert(data?.message ?? "Fehler beim Upload.");
                return;
            }

            alert("OK. Job-ID: " + data.job_id);
        });
    });