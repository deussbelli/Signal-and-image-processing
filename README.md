# Signal-and-image-processing
Solving signal and image processing problems

[![GitHub repo](https://img.shields.io/badge/GitHub-Signal%20and%20Image%20Processing-blue)](https://github.com/deussbelli/Signal-and-image-processing.git)

## Overview
This repository is dedicated to solving various problems related to **signal and image processing**. It contains a collection of laboratory work designed to explore digital signal processing (DSP) concepts, techniques, and their practical applications in image processing.

## Contents
1. **Purpose and Main Objectives of Laboratory Work**
2. **Laboratory Work #1: Discrete Fourier Transform (DFT)**
3. **Laboratory Work #2: Digital Filter Design**
4. **Laboratory Work #3: Digital Filter Design Using Filter Design and Analysis Tool (FDATool)**
5. **Laboratory Work #4: Signal Filtering**
6. **Laboratory Work #5: Image Processing**

## Laboratory Details

### Laboratory Work #1: Discrete Fourier Transform (DFT)
**Objective**: 
- Calculate and compare the spectra of analog and discrete signals.
- Investigate the discrete Fourier transform of a single impulse.

### Laboratory Work #2: Digital Filter Design
**Objective**:
- Familiarize with methods of digital filter construction.
- Compare different types of approximation for amplitude-frequency characteristics (AFC) and study the parameters of digital filters.

### Laboratory Work #3: Digital Filter Design Using Filter Design and Analysis Tool (FDATool)
**Objective**:
- Compare different methods of filter approximation.
- Learn how to use the Filter Design and Analysis Tool for digital filter creation.

### Laboratory Work #4: Signal Filtering
**Objective**:
- Investigate the impact of digital filters on signals in both time and frequency domains.

### Laboratory Work #5: Image Processing
**Objective**:
- Open an image with 24-bit color depth and review the histogram of the active image.
- Apply histogram equalization and analyze the changes to the image.
- Use mask filtering procedures with the following operators:
  - **Roberts Operator**
    ```
    h1 = [0 1; -1 0], h2 = [1 0; 0 -1]
    ```
  - **Prewitt Operator**
    ```
    h1 = [-1 -1 -1; 0 0 0; 1 1 1], h2 = [-1 0 1; -1 0 1; -1 0 1]
    ```
  - **Sobel Operator**
    ```
    h1 = [-1 -2 -1; 0 0 0; 1 2 1], h2 = [-1 0 1; -2 0 2; -1 0 1]
    ```

**Tasks**:
- Compare images before and after applying these filters.
- Write a report detailing the results and include images demonstrating the transformations.

## How to Use
1. Clone the repository:
   ```bash
   git clone https://github.com/deussbelli/Signal-and-image-processing.git
