grace_filter_system/
├── README.md                          # Documentation
├── base/                              # Base classes
│   ├── BaseFilter.m                  # Filter base class
├── filters/                           # Spatial filters
│   ├── GaussFilter.m                 # Gaussian filter
│   ├── FanFilter.m                   # Fan filter
│   ├── FanR1R2Filter.m               # Dual-radius fan filter
│   ├── HanFilter.m                   # Han filter
│   └── ReconstructedFilter.m             # Reconstructed filter
├── utils/                             # Utility functions
│   ├── get_en.m                      # Calculate coefficient count
│   ├── storage_*.m                   # Storage format conversion
