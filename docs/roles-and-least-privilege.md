# Roles and Least Privilege

This document describes the admin role assignment used in the lab.

## Objective

The objective is to demonstrate least privilege administration in Microsoft Entra ID.

Instead of assigning a broad role such as Global Administrator, a limited built-in role was used.

## Assigned Role

Charlie User was assigned:

- Groups Administrator

Scope:

- Directory

## Reasoning

The Groups Administrator role is enough for group management tasks.

It avoids granting unnecessary full tenant administration permissions.

## Security Principle

No lab user was assigned Global Administrator.

This follows the principle of least privilege:

- assign only the permissions required for the task
- avoid permanent excessive privileges
- separate normal users from administrative responsibilities
