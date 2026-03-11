# ESG Report Extraction Platform

## Overview

This project is a prototype web application that enables users to extract structured information from ESG (Environmental, Social, Governance) reports.

The application provides a web interface built with **CodeIgniter 4**, which allows users to trigger a **Python-based processing pipeline** located in the backend directory. The pipeline processes ESG reports and extracts relevant information from the documents.

The repository therefore combines two main components:

- a **PHP web application** for interaction and orchestration
- a **Python processing pipeline** for document analysis

The Python backend and its internal architecture are documented separately in the `backend/README.md`.

This project was developed as part of a **university bachelor thesis** and represents a **prototype implementation**.

---

# Architecture

The system consists of two main layers.

## Web Application (Frontend / Control Layer)

The web application is implemented using **CodeIgniter 4** and provides the user interface and orchestration logic. Users can interact with the application through a browser and start the ESG processing pipeline.

The CodeIgniter application follows the standard MVC structure:

- Controllers handle user requests
- Models manage data logic
- Views provide the interface

## Python Processing Pipeline

The ESG report analysis is performed by a **Python pipeline** located in the `backend/` directory.

This pipeline:

- processes ESG reports
- extracts relevant information from documents
- returns structured output to the application

All details about the pipeline architecture, dependencies, and execution are documented in:

```
backend/README.md
```

---

# Technology Stack

## Web Application

- PHP
- CodeIgniter 4
- MVC architecture
- Local web hosting environment (e.g. Apache)

## Backend Processing

- Python
- Python libraries listed in `backend/requirements.txt`

---

# Project Structure

The repository extends the standard **CodeIgniter 4 project structure** with additional directories for backend processing and storage.

```
project-root
│
├── app/
│   ├── Controllers/
│   ├── Models/
│   ├── Views/
│   ├── Config/
│   └── Filters/
│
├── public/
│
├── writable/
│
├── backend/
│   ├── Python processing pipeline
│   ├── requirements.txt
│   └── backend README with detailed documentation
│
├── storage/
│   └── data and files used during processing
│
└── README.md
```

The `backend/` directory contains all components required for the Python-based ESG extraction pipeline.

The `storage/` directory is used for document storage and intermediate processing data.

---

# Installation

## Requirements

The project requires the following technologies to run locally:

- PHP
- CodeIgniter 4
- Python
- Python dependencies listed in `backend/requirements.txt`
- Local web server environment (e.g. Apache / local host setup)

---

# Running the Application

## Start the Web Application

The web application is designed to run on a local **Apache server environment**.  
During development the project was hosted using **MAMP**.

### Setup with MAMP

1. Install and start **MAMP**.
2. Place the project inside the MAMP `htdocs` directory.

Example:

```
/Applications/MAMP/htdocs/esg-report-platform
```

3. Start the Apache server via the MAMP control panel.
4. Open the application in your browser:

```
http://localhost/esg-report-platform/public
```

CodeIgniter uses the `public` directory as the web root, therefore requests should be directed to this folder.

## Run the Python Backend

The Python backend is executed through the pipeline environment located in the `backend` directory.

Install required dependencies:

```
pip install -r backend/requirements.txt
```

Further execution instructions and pipeline configuration are described in:

```
backend/README.md
```

---

# Configuration

Configuration of the web application follows the **standard CodeIgniter 4 configuration workflow**.

Relevant settings can be adjusted in the `app/Config` directory.

Backend configuration is documented separately inside the backend documentation.

---

# Disclaimer

This project represents a **prototype implementation** developed for academic purposes.

The system is provided **without guarantee of correctness or production readiness**.

---

# Project Context

This project was developed as part of a **university bachelor thesis**.

The goal of the project is to explore automated extraction of ESG-related information from sustainability reports using a combined **web application and document processing pipeline architecture**.