# Metal Prices Data Import

This directory contains metal price data and scripts to import it into the database.

## Directory Structure
```
data/
├── metal_prices/
│   ├── current_prices.json    # Place new price data here
│   └── archive/              # Processed files are moved here
└── README.md                 # This file
```

## Import Process

1. Place your metal prices JSON file in `data/metal_prices/current_prices.json`

2. Run the import task:
```bash
rails metal_prices:import
```

3. The file will automatically be archived with a timestamp after successful import.

## Additional Commands

Clean up old archived files (older than 30 days):
```bash
rails metal_prices:cleanup
```

## Notes
- The importer expects JSON data in the format provided by the metals API
- Successfully processed files are moved to the archive directory
- Archives are automatically cleaned up after 30 days
- Check Rails logs for any import errors or issues 