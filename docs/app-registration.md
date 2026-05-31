# App Registration

This document describes the internal application registration created in the lab.

## Application

Application name:

- app-lab-inventory-reader

Supported account type:

- single tenant
- accounts in this organizational directory only

## Microsoft Graph Permissions

The following Microsoft Graph permissions were configured:

- User.Read.All
- Group.Read.All
- User.Read

The main permissions are read-only.

## Admin Consent

Admin consent was granted for the configured permissions.

## Security Reasoning

The application was designed as a read-only inventory reader.

It can read users and groups, but it does not have write permissions.

No high-risk write permissions were granted, such as:

- User.ReadWrite.All
- Group.ReadWrite.All
- Directory.ReadWrite.All

This follows least privilege for application permissions.
