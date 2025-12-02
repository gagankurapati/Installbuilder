#!/bin/bash
#
# ADMORE InstallBuilder Build Script
# Product-specific build configuration
#

set -e  # Exit on error

# Get script and project locations
SCRIPTNAME=$(readlink -f "$0")
PRODUCT_DIR=$(dirname "${SCRIPTNAME}")
PROJECT_DIR=$(dirname "$(dirname "${SCRIPTNAME}")")
FORMAT_DATE=$(date +%Y-%m-%d-%H%M%S)

# Product Configuration
IBPROJECTVERSION=2024.0
PRODUCT_NAME="ADMORE"
PRODUCT_SHORT_NAME="ADM"

# Build Paths - UPDATE THESE FOR YOUR ENVIRONMENT
IBOUTPUTDIR=/nisprod/packaging/builds/ppg/IBRelease/${PRODUCT_NAME}
APROOTDIR=/nisprod/packaging/builds/ppg/IBAppPackages
APROOTNAME=ADMORE2024r0_Linux
COMMONROOT=/nisprod/packaging/builds/ppg/IBProjects/00_COMMON_FILES/Content
FLEXNETROOT=/nisprod/packaging/builds/ppg/IBProjects/00_COMMON_FILES/FLEXnet

# Log file
IBLOGFILE="${PRODUCT_DIR}/build_${FORMAT_DATE}.log"

# Build platform (linux-x64 or windows)
PLATFORM="${1:-linux-x64}"

echo "========================================"
echo "${PRODUCT_NAME} InstallBuilder Build"
echo "========================================"
echo "Project Version: ${IBPROJECTVERSION}"
echo "Platform:        ${PLATFORM}"
echo "Output Dir:      ${IBOUTPUTDIR}"
echo "Product Dir:     ${PRODUCT_DIR}"
echo "Project Dir:     ${PROJECT_DIR}"
echo "Log File:        ${IBLOGFILE}"
echo "========================================"
echo ""

# Check if builder command exists
if ! command -v builder &> /dev/null; then
    echo "ERROR: InstallBuilder 'builder' command not found"
    echo "Please ensure InstallBuilder is installed and in PATH"
    echo "Or run: module load installer/installbuilder"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "${IBOUTPUTDIR}"

# Build the installer
echo "Starting build..."
echo ""

cd "${PROJECT_DIR}"

builder build installer-template.xml \
    --verbose \
    --platform "${PLATFORM}" \
    --setvars project_directory="${PROJECT_DIR}" \
    --setvars variablesFile="${PRODUCT_DIR}/variables.xml" \
    --setvars clbuildspace="${APROOTDIR}" \
    --setvars clpackage="${APROOTNAME}" \
    --setvars clmasterpath="${COMMONROOT}" \
    --setvars clproductconfigpath="${PROJECT_DIR}" \
    --setvars clflexnetruntimepath="${FLEXNETROOT}" \
    2>&1 | tee -a "${IBLOGFILE}"

BUILD_STATUS=${PIPESTATUS[0]}

# Set permissions on generated installers
if [ ${BUILD_STATUS} -eq 0 ]; then
    echo ""
    echo "Build completed successfully!"
    echo ""

    # Find and set permissions on installers
    for installer in "${IBOUTPUTDIR}"/*.run "${IBOUTPUTDIR}"/*.exe; do
        if [ -f "${installer}" ]; then
            chmod g+w "${installer}" 2>/dev/null || true
            echo "Generated: ${installer}"
        fi
    done

    echo ""
    echo "Log saved to: ${IBLOGFILE}"
    exit 0
else
    echo ""
    echo "ERROR: Build failed with status ${BUILD_STATUS}"
    echo "Check log: ${IBLOGFILE}"
    exit ${BUILD_STATUS}
fi
