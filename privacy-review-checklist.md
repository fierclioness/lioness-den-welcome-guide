# Privacy policy evidence and publication checklist (November 21, 2026)

STATUS: DRAFT / INTERNAL REVIEW. This does not authorize publication or data changes.

## Verified in current project source
- Welcome Guide's optional referral survey sends a selected source to Supabase Edge Function `welcome-discovery`; uses browser localStorage to avoid asking again on that browser.
- The live Edge Function processes an IP address transiently to produce a day-specific keyed HMAC; database columns are `source`, `submitted_on`, `visitor_day_hash`, `created_at`, and a row ID. No raw-IP column in this survey table. Do not claim upstream infrastructure never logs IPs.
- The existing manual Squad Finder composes a shareable Discord message in the browser and copies it locally; it does not transmit user-entered squad preferences to the site's backend.
- Den Missions uses Discord OAuth via Supabase Auth, with persistent browser session. Tables contain Discord user ID, weekly selection and dates, reports, verification outcomes/evidence, achievements and role-award timestamps. Separate internal tables contain admin audit records and award attempts.
- Current production cron jobs: `smart-verification-check` and `royal-achiever-check`, both every five minutes. No scheduled purge job was found. This does NOT prove that all external backups/logs are retained forever; deletion/retention policy is still unverified.
- `mission_progress.selection_id` and `mission_reports.selection_id` foreign keys cascade on deletion of associated weekly selections, but other triggers may block removal of reviewed records. No deletion procedure was tested.
- Den Matchmaker staging is unpublished to members and should not be represented as an active public tool.

## Must confirm before release
1. Who is responsible for privacy requests and what usable contact method should appear in the policy? Proposal: private Discord #support tickets, plus a durable email if established.
2. Policy for deletion, retention, backups, admin verification logs, and survey responses. Do not promise a duration not yet enforced.
3. Google Sites homepage: any forms, embedded services, visitor analytics, or other linked tools not covered in GitHub source.
4. Applicable regulatory/jurisdiction requirements and whether legal review is needed.
5. Review Google Sites hosting, GitHub Pages and Supabase server/network logs. Avoid statements such as "no IP addresses are ever collected".
6. Decide what personal data is necessary for Den Missions and what a deletion request can actually remove without undermining audit history.
7. Add policy links to the website, Welcome Guide and Den Missions only after approvals. Do not merge the draft or publish from GitHub before approval.
8. Set an actual effective date only at publication.

## Sources checked
- GitHub repositories: `fierclioness/lioness-den-welcome-guide`, `lioness-den-squad-finder`, `den-missions`, main branch source (Nov 21).
- Supabase project `Den Missions 2.0`: metadata from `information_schema`, foreign-key metadata, trigger metadata, `cron.job`, and deployed `welcome-discovery` source (read-only).
- Supabase Auth documentation: user sessions and user-data management (November 2026).
- Google Sites Help: Add, delete and organize pages, including footer.

No passwords, keys, raw user identifiers, or member records are included in this review note.
