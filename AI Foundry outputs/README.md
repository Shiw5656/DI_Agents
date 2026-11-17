# Data Vault – AI Agent Automation

## Project Overview
This project focuses on automating Data Vault review, business glossary generation, canonical data modeling, data mapping, and Microsoft Fabric model recommendations using Azure AI Foundry agents.

## AI Agents

**Agent 1 – Data Vault Model Reviewer**
- Reviews Data Vault DDL files.
- Identifies modeling issues and provides recommendations.

**Agent 2 – Glossary Builder**
- Generates business terms, definitions, and glossary documentation.

**Agent 3 – Canonical Model Recommender**
- Recommends canonical entities, attributes, and relationships.

**Agent 4 – Vault to Canonical Mapper**
- Generates mappings between Data Vault structures and canonical models.

**Agent 5 – Canonical to Fabric Model**
- Provides Microsoft Fabric target model recommendations.

## Technologies Used
- Microsoft Azure AI Foundry
- Python
- GPT-4o
- GitHub
- Microsoft Fabric

## Automation Workflow

1. Download input files from GitHub.
2. Connect Python to Azure AI Foundry.
3. Execute the five-agent workflow.
4. Retrieve the workflow response.
5. Save the results locally in VS Code.
6. Upload the generated workflow output to GitHub.

## Project Status

- GitHub input downloading: Completed
- Azure AI Foundry workflow execution: Completed
- Combined workflow output saving: Completed
- GitHub upload automation: Completed
- Separate output files for all five agents: In progress

## Future Enhancements

- Save each agent's output in its respective GitHub folder.
- Improve workflow execution logs and error handling.
- Validate agent outputs automatically.
- Migrate the workflow to Microsoft Agent Framework.
