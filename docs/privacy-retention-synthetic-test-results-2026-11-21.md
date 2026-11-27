# Synthetic PostgreSQL Retention Eligibility Tests — Nov 21, 2026

Status: **8/8 passed**, query-only. These are hypothetical fixture rows inside a single SELECT statement (CTE VALUES). This was executed against PostgreSQL with no CREATE/INSERT/UPDATE/DELETE or cron scheduling and without touching production member records.

| Fixture | Age | Report | Verified | Reviewed | Achievement-linked | Hold | Expected cleanup eligible | Result |
|---|---:|---|---|---|---|---|---|---|
| Old, clean | 220d | No | No | No | No | No | Yes | Pass |
| Recent, clean | 25d | No | No | No | No | No | No | Pass |
| Old pending report | 220d | Yes | No | No | No | No | No | Pass |
| Old verified | 220d | Yes | Yes | No | No | No | No | Pass |
| Old reviewed | 220d | Yes | No | Yes | No | No | No | Pass |
| Old achievement-linked | 220d | No | No | No | Yes | No | No | Pass |
| Old preservation hold | 220d | No | No | No | No | Yes | No | Pass |
| At the 180-day boundary | 180d | No | No | No | No | No | No | Pass |

## What this proves
The Boolean eligibility rule in the fixture properly rejects 7 excluded categories and approves 1 synthetic clean old selection. It does **not** prove the live database currently implements all those flags or that an actual deletion operation would be safe.

## Remaining release blockers
- The production schema does NOT currently have a verified per-selection legal-hold flag. A policy and a safe representation/lookup mechanism must be designed before cleanup.
- The production strict candidate-count query excludes any report/review/verification, but it does not yet verify absence of all relevant achievement dependencies. Those may be linked by user/week, not selection foreign keys.
- The real protection triggers actively reject deleting reviewed or verified mission selections and reports. Do not disable or work around them.
- No backup-recovery exercise, staging deletion implementation, audit-preservation design, provider retention review, or legal/policy approval has been completed.
- Do not publish the 90/180/365-day **targets** as operating deletion guarantees.

## Test artifact
`docs/privacy-retention-synthetic-tests.sql` contains the standalone test query. It has no writes and no user identifiers. Test results: 8 cases, 8 passed, 0 failed (Nov 21 2026). Future implementations require fresh validation and explicit deployment authorization.

Reference: [Supabase: Deleting data and dropping objects safely](https://supabase.com/docs/guides/database/postgres/data-deletion).
