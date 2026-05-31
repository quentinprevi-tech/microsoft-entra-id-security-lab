# Security Defaults

This document describes the Security Defaults configuration in the lab tenant.

## Status

Security Defaults are enabled.

## Purpose

Security Defaults provide a baseline identity security configuration recommended by Microsoft.

They help protect the tenant by enforcing safer authentication defaults, including MFA registration and protection against common identity attacks.

## Why Security Defaults Were Used

This lab is intentionally simple and does not rely on advanced licensing.

Security Defaults are suitable for a small tenant baseline when Conditional Access is not being used.

## Future Improvement

If licensing allows, Conditional Access policies could be added later for more granular controls, such as:

- require MFA for administrators
- require MFA for selected groups
- block legacy authentication
- apply location-based access rules
