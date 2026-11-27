-- The Lioness Den retention eligibility audit (READ ONLY)
-- Planning target: Nov 21, 2026. This is NOT a deletion or retention job.
-- No ALTER, UPDATE, DELETE, TRUNCATE, DDL, or cron.schedule commands.
-- Read-only aggregate statistics only; no member identifiers leave the database.
-- Execute only on authorized project using approved read-only access.

-- Survey candidate count for future 90-day policy
SELECT count(*)::int AS total_survey_responses,
       count(*) FILTER (WHERE submitted_on < current_date - 90)::int AS survey_older_than_90_days
FROM public.welcome_discovery_responses;

-- Mission-selection candidates for 180-day review.
-- Conservative: exclude ANY report, any verification, any admin review.
-- Even candidate rows must NOT be deleted until explicit approval, safe tests,
-- and a complete retention policy for linked records are in place.
WITH selections AS (
  SELECT s.id, s.selected_at,
    EXISTS (SELECT 1 FROM public.mission_reports r
            WHERE r.selection_id = s.id) AS has_report,
    EXISTS (SELECT 1 FROM public.mission_progress p
            WHERE p.selection_id = s.id) AS has_verification,
    EXISTS (SELECT 1
            FROM public.mission_reports r
            JOIN mission_internal.review_log l ON l.report_id = r.id
            WHERE r.selection_id = s.id) AS has_admin_review
  FROM public.weekly_selections s
)
SELECT count(*)::int AS all_selections,
       count(*) FILTER (WHERE selected_at < now() - interval '180 days')::int AS older_than_180d,
       count(*) FILTER (
          WHERE selected_at < now() - interval '180 days'
            AND NOT has_report
            AND NOT has_verification
            AND NOT has_admin_review
       )::int AS conservative_candidates,
       count(*) FILTER (WHERE has_verification OR has_admin_review)::int AS protected_selections,
       count(*) FILTER (WHERE has_report AND NOT has_verification AND NOT has_admin_review)::int AS selections_with_unreviewed_reports
FROM selections;

-- Achievements: count only; long-term retention remains a proposed target.
SELECT count(*)::int AS achievements_total,
       count(*) FILTER (WHERE earned_at < now() - interval '365 days')::int AS older_than_365d
FROM public.achievements;

-- Survey and mission history must NOT be interpreted as fully purged when
-- these counts decrease. Backups, downstream audit logs and auth data are separate.
