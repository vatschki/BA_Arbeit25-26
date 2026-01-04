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

    document.getElementById('createReportForm').addEventListener('submit', async function (e) {
        e.preventDefault();

        const form = e.target;
        const formData = new FormData(form);

        const resultBox = document.getElementById('pdf-file-list');
        resultBox.innerHTML = '<div class="text-muted mt-3">Pipeline wird gestartet …</div>';

        try {
            const response = await fetch("/esg-reports/process", {
                method: "POST",
                body: formData
            });

            const data = await response.json();

            if (data.status === 'success') {
                showPipelineSuccess(data.job_id);
            } else {
                showPipelineError(data);
            }

        } catch (err) {
            showPipelineError({
                pipeline_error: {
                    error: 'NETWORK_ERROR',
                    message: err.message
                }
            });
        }
    });

    function showPipelineSuccess(jobId) {
        const el = document.getElementById('pdf-file-list');
        el.innerHTML = `
        <div class="alert alert-success mt-3">
            <strong>Pipeline gestartet</strong><br>
            Job-ID: <code>${jobId}</code>
        </div>
    `;
    }

    function showPipelineError(data) {
        const el = document.getElementById('pdf-file-list');
        el.innerHTML = `
        <div class="alert alert-danger mt-3">
            <strong>
                Fehler beim Starten der Pipeline
            </strong>
            <pre style="white-space: pre-wrap; font-size: .85rem;">
                ${JSON.stringify(data.pipeline_error ?? data, null, 2)}
            </pre>
        </div>
    `;
    }