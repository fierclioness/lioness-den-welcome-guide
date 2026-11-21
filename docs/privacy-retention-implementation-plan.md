# Retention Implementation & Safety Gate — Draft Design
**November 21, 2026 — NOT deployed. No data modification authorized.**

## Scope
Design a privacy-respecting lifecycle for the existing Welcome Guide survey and Den Missions records. This is a planning document on an unpublished PR branch. It does **not** enable automatic deletion or authorize changes to production data, triggers, functions, cron schedules or auth identities.

## Approved planning targets (not active policy)
- Welcome Guide responses: 90 days.
- Unreviewed mission selections: 180 days, only where records are not linked to a report, verification or admin review.
- Completion reports and verified missions: separate review; do not blindly delete at 180 days.
- Achievements, award attempts, and admin review audit: 12-month planning target; assess legal/technical need and any pending disputes.
- Supabase Auth, Discord IDs and service-provider backups: case-specific handling and verified privacy-request process; not yet assigned an automatic purge rule.

## Findings from verified system behavior
- Production table `weekly_selections` includes `selected_at`, `week_start`, `discord_user_id`, and `mission_id`.
- `mission_reports` and `mission_progress` reference selection rows with ON DELETE CASCADE, **but** protection triggers intentionally reject deleting reviewed or verified records.
- `public.protect_reviewed_mission_records` and `public.protect_reviewed_mission_reports` preserve reviewed/verified evidence.
- Current production schedules run mission verification and Royal Achiever awards every five minutes; no retention job is verified.
- Conservative read-only aggregate at audit time: 12 selections, 5 with review or verification protection, 0 selections older than 180 days, 0 conservative deletion candidates. Survey 0 and achievement 0.
- A 90-day survey policy cannot be described as active until cleanup is actually implemented and verified.
- Privacy requests must respect authentication, reviewed evidence, audit obligations and provider backup limits. Unreviewed selection deletion is *not* the same as verified account erasure.

## Development plan
1. Policy/legal review: confirm need and defensibility of each proposed duration, response process and provider backup caveat.
2. Determine an alternate authenticated privacy-contact/verification path that doesn't require an existing Discord membership.
3. Produce disposable PostgreSQL fixtures representing: unreported selection, pending report, reviewed report, verified progress, earned achievement, and multiple-week history.
4. Validate read-only eligibility queries and ensure no protected or pending item appears as eligible.
5. **Separate approval gate:** design/implement a bounded cleanup transaction in staging, with dry-run and hard-delete disabled by default; ensure restore/backups and authorization.
6. Test trigger protection, audit linkage, role award validity, idempotence, rollback semantics, and partial failures before any live deployment.
7. **Separate approval gate:** review and enable production cleanup only with explicit consent and a verified safe migration/operation plan.
8. Update and publish the public policy only to describe **observed active behavior**. Include effective date and links from Google Sites, Welcome Guide and Den Missions after review.

## Reference SQL
`docs/privacy-retention-readonly-audit.sql` contains only SELECT-based aggregate candidate checks. Do not turn it into a scheduled deletion job.

## Fail-closed criteria
- If the member record is reviewed, verified, pending, achievement-linked or cannot be confidently classified, exclude it from deletion.
- If retention metadata is missing or ambiguous, do not guess.
- Never weaken protection triggers or store service credentials in public GitHub Pages.
- Do not run automated hard deletes in production while the user-visible site describes the process as unimplemented.
