# Privacy Retention Decision Matrix — Review Draft

## November 21 technical retention risk — confirmed from production trigger definitions

Read-only inspection of `public.protect_reviewed_mission_records()` and `public.protect_reviewed_mission_reports()` found that **deleting a reviewed or verified mission selection or completion report currently raises an exception**. The weekly selection protection checks for linked `mission_internal.review_log` or `mission_progress`, and report protection checks for review entries or linked progress. Additionally, `mission_progress` and `mission_reports` foreign keys reference weekly selections with ON DELETE CASCADE, but the protection triggers intentionally block deletion of protected records.

**Implication:** A blanket "delete all weekly mission records after 180 days" policy is not currently implementable without redesign. Do **not** disable/bypass these triggers, delete audit data prematurely, or promise automatic deletion in a published notice.

**Recommended staged approach:**
1. Approve the *principle* of minimizing retention, but treat the draft 90/180/365-day numbers as targets until legal and functional review.
2. Permit cleanup of genuinely unreviewed/unverified, non-achievement-linked selections only after a tested eligibility query and staging run; never delete related reports without validating their status.
3. Separately design and review a preservation/anonymization policy for reviewed or verified mission evidence and achievements. Confirm whether account identifiers can be minimized while retaining necessary dispute and audit integrity.
4. Create retention tests in a disposable database; verify role awards, reviews, weekly rollover, and deletion-denial paths before considering any change.
5. Require explicit approval for all production cleanup or schema/trigger changes. Final public wording should describe *current* handling accurately, not future aspirations.

No data was read at member level or mutated during this check.

---
## Candidate retention schedule — pending explicit approval and implementation (Nov 21, 2026)

**These durations are proposals and are NOT implemented. They must not be stated in the public privacy notice as active policy.**

| Information | Proposed time | Trigger / notes |
|---|---:|---|
| Welcome Guide referral survey source, submitted_on, day-HMAC | 90 days | From submission date; source-only aggregates could be computed separately without person-level identifiers after deletion |
| Weekly mission selections | 180 days | From community week end; verify dependency/cascade and protect reviewed submissions before implementation |
| Mission completion reports / progress evidence | 180 days minimum | Coordinate with selection lifecycle; review whether reviewed records require separate narrower retained audit details |
| Achievements and role award records | 12 months | From final achievement event or last needed dispute date; preserve current member's active role and documented appeal decisions |
| Private administrator review and award-attempt logs | 12 months | From event date, subject to incidents, disputes, legal holds, and least-privilege access |
| Discord/Supabase Auth identity and active session | While necessary for member's use | Verified account deletion workflow needed; account deletion is separate from Discord data and provider backups |
| External provider logs, backups, and security metadata | Provider-dependent | Verify actual retention independently; do not claim backend purges can instantly clear backups |

**Implementation safeguards:** Determine legal applicability, specify event timestamps accurately, test deletion candidate selection against a read-only snapshot, use a tested staging migration/function, preserve audit integrity, get explicit approval for destructive production cleanup, log only aggregate outcomes (not personal identifiers), and re-audit provider logs and backup limitations.

**Read-only aggregate snapshot, Nov 21, 2026:** survey 0; weekly selections 12; completion reports 3; achievements 0; private review log 3; award attempts 0. This is a point-in-time snapshot, not a promise about future counts.

**Basis:** Actual Den Missions table/trigger/foreign-key and cron metadata; FTC data minimization guidance; Supabase backup documentation. Durations are voluntary design recommendations, **not** statutory requirements.

---

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
