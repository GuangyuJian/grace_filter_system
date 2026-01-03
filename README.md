grace_filter_system/
├── README.md                          # Documentation
├── main_example.m                     # Main example
├── base/                              # Base classes
│   ├── BaseFilter.m                  # Filter base class
│   ├── BaseDestriper.m               # Destriping base class
│   └── ProcessingNode.m              # Processing node base class
├── filters/                           # Spatial filters
│   ├── GaussFilter.m                 # Gaussian filter
│   ├── FanFilter.m                   # Fan filter
│   ├── FanR1R2Filter.m               # Dual-radius fan filter
│   ├── HanFilter.m                   # Han filter
│   └── ReconstructedFilter.m             # Reconstructed filter
├── destripers/                        # Destriping methods
│   ├── DDKDestriper.m                # DDK destriping
│   ├── PnMlDestriper.m               # PnMl destriping
│   ├── SwensonDestriper.m            # Swenson destriping
│   ├── ChambersDestriper.m           # Chambers destriping
│   └── ChenDestriper.m               # Chen destriping
├── processing/                        # Processing chain
│   ├── FilterNode.m                  # Filter node
│   ├── DestripeNode.m                # Destriping node
│   ├── ProcessingChain.m             # Processing chain
│   └── ChainManager.m                # Chain manager
├── factory/                           # Factory classes
│   └── GraceFilterFactory.m          # Filter factory
├── utils/                             # Utility functions
│   ├── get_en.m                      # Calculate coefficient count
│   ├── storage_*.m                   # Storage format conversion
│   └── weight_utils.m                # Weight calculation utilities
├── visualization/                     # Visualization
│   ├── plot_weights.m                # Plot weights
│   └── compare_results.m             # Compare results
└── examples/                          # Examples
    ├── example_simple.m              # Simple example
    ├── example_chain.m               # Chain example
    ├── example_batch.m               # Batch processing example
    └── example_interactive.m         # Interactive example