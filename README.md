# GRACE Filter System - MATLAB Toolbox

A comprehensive MATLAB toolbox for filtering and processing GRACE (Gravity Recovery and Climate Experiment) spherical harmonic coefficients.

## 🚀 Overview

This toolbox provides a collection of spatial filters for GRACE data processing, including Gaussian filters, fan filters, DDK destriping filters, and reconstructed filters. The system is designed with an object-oriented architecture for easy extension and flexible usage.

## 📁 Project Structure

```
grace_filter_system/
├── base/                              # Base classes
│   └── BaseFilter.m                  # Filter base class (abstract)
├── filters/                           # Spatial filters
│   ├── GaussFilter.m                 # Gaussian filter (isotropic)
│   ├── FanFilter.m                   # Fan filter (anisotropic)
│   ├── FanR1R2Filter.m               # Dual-radius fan filter
│   ├── HanFilter.m                   # Han anisotropic filter
│   ├── DDKFilter.m                   # DDK destriping filter
│   ├── RecFilter.m                   # Reconstructed filter
│   └── demoFilter.m                  # Demonstration script
├── utils/                             # Utility functions
│   ├── get_en.m                      # Calculate coefficient count
│   ├── ddkModule/                    # DDK filter module
│   │   ├── gmt_destriping_ddk.m     # DDK filtering function
│   │   └── read_BIN.m               # Binary file reader
│   └── storage/                      # Storage format conversion
│       ├── storage_*.m              # Various conversion functions
│       └── test_*.m                 # Test scripts
```

## 🔧 Installation

### Method 1: Add to MATLAB Path
```matlab
% Add the main directory and all subdirectories
addpath(genpath('/path/to/grace_filter_system'));
```

### Method 2: Set Path via MATLAB Interface
1. Open MATLAB
2. Go to `Home` → `Set Path`
3. Click `Add with Subfolders`
4. Select the `grace_filter_system` folder

## 🎯 Quick Start

### Basic Usage
```matlab
% Load sample data
load('shccostgDegia.mat');  % Contains shccostg variable

% Create a Gaussian filter
gaussFilter = GaussFilter(90, 500);  % max degree=90, radius=500km

% Apply filter to spherical harmonic coefficients
filtered_shc = gaussFilter.applyTo(shccostg);
```

### Create and Apply Different Filters
```matlab
% 1. Fan filter
fanFilter = FanFilter(90, 300);
filtered1 = fanFilter.applyTo(shccostg);

% 2. Dual-radius fan filter
fanR1R2 = FanR1R2Filter(90, 300, 500);
filtered2 = fanR1R2.applyTo(shccostg);

% 3. DDK filter
ddkFilter = DDKFilter(90, 5);  % DDK5
filtered3 = ddkFilter.applyTo(shccostg);

% 4. Reconstructed filter
baseFilter = FanFilter(90, 300);
recFilter = RecFilter(baseFilter, 3, 1);  % 3 iterations, forward mode
filtered4 = recFilter.applyTo(shccostg);
```

## 📚 Filter Classes

### BaseFilter (Abstract Class)
**Location:** `base/BaseFilter.m`

Abstract base class for all filters. Defines the common interface and default implementation.

**Properties:**
- `maxn` - Maximum spherical harmonic degree (default: 60)
- `earth_radius` - Earth radius in km (default: 6371)
- `parameters` - Structure for additional parameters

**Abstract Methods:**
- `computeWeights()` - Calculate filter weights
- `applyTo()` - Apply filter to coefficients

### GaussFilter
**Location:** `filters/GaussFilter.m`

Isotropic Gaussian filter for spatial smoothing.

**Constructor:**
```matlab
filter = GaussFilter(maxn, radius)
```
**Parameters:**
- `maxn` - Maximum degree
- `radius` - Filter radius in km (default: 300)

**Example:**
```matlab
gauss = GaussFilter(60, 400);
weights = gauss.computeWeights();
filtered = gauss.applyTo(shc_data);
```

### FanFilter
**Location:** `filters/FanFilter.m`

Anisotropic fan filter with different smoothing in degree and order directions.

**Constructor:**
```matlab
filter = FanFilter(maxn, radius)
```

### FanR1R2Filter
**Location:** `filters/FanR1R2Filter.m`

Fan filter with different radii for degree and order smoothing.

**Constructor:**
```matlab
filter = FanR1R2Filter(maxn, radius_degree, radius_order)
```

### HanFilter
**Location:** `filters/HanFilter.m`

Han anisotropic filter with radius varying with order.

**Constructor:**
```matlab
filter = HanFilter(maxn, r0, r1, m1)
```

### DDKFilter
**Location:** `filters/DDKFilter.m`

DDK (De-correlation and De-striping) filter for GRACE data.

**Constructor:**
```matlab
filter = DDKFilter(maxn, ddkType)
```
**Parameters:**
- `ddkType` - DDK type (1-8, where 1=strongest, 8=weakest smoothing)

**DDK Types:**
- 1: Strongest smoothing (DDK1)
- 2: Strong smoothing (DDK2)
- 3: Moderate smoothing (DDK3)
- 4: Light smoothing (DDK4)
- 5: Lightest smoothing (DDK5) - **Default**
- 6-8: Progressive weaker smoothing

### RecFilter (Reconstructed Filter)
**Location:** `filters/RecFilter.m`

Applies reconstruction to a base filter for enhanced signal processing.

**Mathematical Formulas:**
- Forward reconstruction (s=1): \( W_1^N = 1 - (1-W)^N \)
- Backward reconstruction (s=0): \( W_0^N = W^N \)

Where:
- \( W \) is the base filter weight matrix
- \( N \) is the number of iterations

**Constructor:**
```matlab
filter = RecFilter(baseFilter, iterations, mode)
```

**Parameters:**
- `baseFilter` - Base filter object
- `iterations` - Number of iterations (default: 3)
- `mode` - 0: backward, 1: forward (default: 1)

**Example:**
```matlab
% Create base filter
baseFilter = FanFilter(60, 300);

% Forward reconstruction with 3 iterations
forwardFilter = RecFilter(baseFilter, 3, 1);

% Backward reconstruction with 5 iterations  
backwardFilter = RecFilter(baseFilter, 5, 0);
```

## 🔄 Storage Format Conversion

The `utils/storage/` directory contains functions for converting between different spherical harmonic coefficient formats:

### Common Functions:
- `storage_shc2ddk()` - Convert to DDK format
- `storage_ddk2shct()` - Convert from DDK format
- `storage_shc2sc()` - Convert to SC format
- `storage_sc2cs()` - Convert SC to CS format
- `storage_cs2vec()` - Convert CS to vector format

### Usage:
```matlab
% Convert to DDK format for DDK filtering
shc_ddk = storage_shct2ddk(shc_data, maxn);

% Apply DDK filter
filtered_ddk = gmt_destriping_ddk(5, shc_ddk);

% Convert back to standard format
shc_filtered = storage_ddk2shct(filtered_ddk);
```


### Common Issues:

1. **"Invalid input" error**
   ```matlab
   % Ensure input is either a structure array or sol_shc object
   if isa(shc_in, 'sol_shc')
       % Handle sol_shc object
   elseif isstruct(shc_in)
       % Handle structure array
   else
       error('Invalid input type');
   end
   ```

2. **DDK filter file not found**
   - Ensure the DDK coefficient files are in the correct path
   - Check `utils/ddkModule/` for required files

3. **Memory issues with large datasets**
   - Process time steps sequentially
   - Use `shc.extra()` to work with subsets

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Submit a pull request

## 📄 License

This toolbox is based on algorithms from multiple sources including:
- GRACE-filter by Roelof Rietbroek (MIT license)
- DDK filtering by FENG Wei

Please cite relevant papers when using these filters in publications.

## 📚 References

1. Wahr, J., Molenaar, M., & Bryan, F. (1998). Time variability of the Earth's gravity field
2. Swenson, S., & Wahr, J. (2006). Post-processing removal of correlated errors in GRACE data
3. Kusche, J. (2007). Approximate decorrelation and non-isotropic smoothing of time-variable GRACE-type gravity field models

## 📧 Support

For questions or issues, please check:
1. The demonstration script `demoFilter.m`
2. The test scripts in `utils/storage/`
3. MATLAB documentation for object-oriented programming

---
*Last Updated: January 2025*  
*Toolbox Version: 1.0*