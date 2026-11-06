ERROR: Missing required input(s): Fabric model standards.

Validation Report:
- Vault-to-Canonical Mapper output: NOT AVAILABLE as a canonical mapping document. The available input is a Data Vault DDL file (`IB_datavault 2.sql`), not Agent 4 canonical mapping output.
- Fabric model standards: NOT AVAILABLE.

Assessment:
- Required canonical mapping input is missing.
- Required Fabric standards input is missing.
- Per instructions, processing is halted and no synthetic canonical-to-Fabric DDL has been generated.

Available Source Reviewed:
- /app/e3a0720a-e7d7-4a26-944e-a7eff5d4fcab/all-files/IB_datavault 2.sql

Reason for Halt:
- Cannot reliably convert to Microsoft Fabric canonical DDL without:
  1. Canonical table/column mappings from Agent 4.
  2. Fabric DDL standards covering target syntax, type mappings, naming conventions, schema conventions, and constraint handling.

Required Next Inputs:
- Agent 4 canonical mapping output.
- Fabric model standards document.
