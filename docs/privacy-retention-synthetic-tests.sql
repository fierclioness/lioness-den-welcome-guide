-- The Lioness Den privacy retention — synthetic, read-only eligibility tests
-- 2026-11-21: validated 8/8 on hosted Postgres using CTE VALUES, no writes.
-- This file is not a migration, cleanup function or scheduled job.
-- No user-identifiable data. It tests proposed eligibility policy ONLY.
WITH fixtures(case_name,age_days,has_report,has_verification,has_review,has_achievement,has_hold,expected) AS (
VALUES
('old_clean',220,false,false,false,false,false,true),
('young_clean',25,false,false,false,false,false,false),
('old_pending_report',220,true,false,false,false,false,false),
('old_verified',220,true,true,false,false,false,false),
('old_reviewed',220,true,false,true,false,false,false),
('old_achievement_linked',220,false,false,false,true,false,false),
('old_legal_hold',220,false,false,false,false,true,false),
('exact_boundary',180,false,false,false,false,false,false)
),
decisions AS (
SELECT case_name,expected,
 (age_days > 180 AND NOT has_report AND NOT has_verification
  AND NOT has_review AND NOT has_achievement AND NOT has_hold) AS eligible
FROM fixtures
)
SELECT count(*) AS test_cases,
 count(*) FILTER (WHERE eligible=expected) AS passed,
 count(*) FILTER (WHERE eligible<>expected) AS failed,
 json_agg(case_name) FILTER (WHERE eligible<>expected) AS unexpected_cases
FROM decisions;

-- Critical caveat: 'has_hold' and 'has_achievement' are fixture flags,
-- NOT verified columns or an implemented per-selection eligibility check.
-- Existing production dry-run SQL excludes any report, review and progress,
-- but doesn't currently prove legal-hold/achievement exclusions. Implement
-- and verify those checks before using a future DELETE workflow.
