# Privacy Retention Decision Matrix — Review Draft
Date: 2026-11-21. **NOT an implemented retention policy.** No existing records or services were changed.

| Data category | Verified collected or stored | Verified purge schedule | Proposed decision to approve |
|---|---|---|---|
| Welcome Guide source choice + submitted date + day-specific HMAC | Yes, Supabase `welcome_discovery_responses` | None verified | Decide analytics need and a defined expiry; implement deletion and confirm independently |
| Browser survey answer flag | Yes, localStorage `lionessDiscoveryAnswered` | No scheduled expiration in current client code | Explain visitor can clear site storage; consider time-limited flag in future design |
| Manual Squad Finder preferences | Generated locally; no site database write in current implementation | Not applicable to the manual form | Explain that sharing the output in Discord is separate |
| Supabase Auth and Discord account identity | Den Missions Discord OAuth; auth/session and provider metadata | Provider lifetime and backups not verified | Confirm account-deletion options and member request process |
| Weekly mission selections | Supabase `weekly_selections`, Discord account identifier, week, mission, timestamps | None verified | Decide retention based on disputes, achievements and member needs; implement approved routine |
| Completion reports and verified progress | Supabase `mission_reports`, `mission_progress` | None verified | Keep consistent with selection/verification retention; preserve only legitimately necessary audit |
| Achievements and role-award status | Supabase `achievements` | None verified | Determine long-term achievement history policy |
| Admin review and award-attempt logs | Private `mission_internal` tables | None verified | Decide restricted access and retention for accountability and security |
| Platform/hosting logs and backups | May be collected by Google Sites, GitHub Pages, Supabase, Discord | Not verified | Check each platform's current practices; avoid blanket "no logs" claims |
| Den Matchmaker isolated staging data | Test-only, not a launched member feature | Separate staging policies | Keep out of public-member description until actual launch; do not mix with production |

## Safe implementation sequence (future work, separate approval)
1. Establish accountable privacy contact (ticket process plus a durable email or form accessible without Discord membership).
2. Approve appropriate time periods for each category with any needed legal review.
3. Build retention actions as new, reviewed migration/function code with strict tests in a non-production environment.
4. Review referential integrity, protected report triggers, existing records, backup behavior and recovery needs.
5. Require explicit approval for any production delete/cleanup. Never backfill deletion purely from a draft policy.
6. Verify behavior and update the published policy only after real implementation.

## Why this document matters
Current production cron jobs checked: `smart-verification-check` and `royal-achiever-check`, each every 5 minutes. Neither is a database retention job. No active routine deletion has been established by this audit.

**Outstanding:** policy owner approval, privacy contact confirmation, exact retention periods, platform-specific logging and final publication review.
