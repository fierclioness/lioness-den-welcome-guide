# The Lioness Den — Privacy Request Handling Procedure (DRAFT)
**Internal operating guidance — November 21, 2026.** Not legal advice; not a published promise. No member data was accessed or changed in preparing this procedure.

## Objective
Respond consistently to requests about information controlled by FiercLioness and The Lioness Den without exposing private Discord or Supabase data, and without deleting audit history before confirming obligations.

## Intake
1. Member may email the official FiercLioness account **fiercelioness43@gmail.com** or, if still in the Discord server, start an existing **#support** ticket in The Lioness Den. This address is approved only for the policy draft at this stage, not yet published as a public contact.
2. Accept requests such as: access/explanation, correction, deletion, account disconnect, objection or concern, and security incident report.
3. Ask for only the minimum information needed to identify the relevant service and account. Do **not** request a password, Discord login code, access token, private messages, government ID, or unrelated health/financial data in the ticket.
4. Keep the ticket restricted to authorized staff. Do not publish an account's request or use the member's identity as an example.

## Identity and scope
- For Den Missions account-linked records, first determine the account's Discord identity using a safe, current authenticated channel or existing administrative process; do not accept a pasted arbitrary Discord ID alone as proof of ownership.
- For the **anonymous optional discovery survey**, explain that individual responses are not linked to Discord accounts and cannot reliably be looked up from a member username. Do not attempt to reverse the day-specific hash to identify an individual.
- For Discord messages, membership, tickets, and moderation logs, distinguish records maintained by Discord from records maintained by our Supabase-backed websites; Discord's own tools and policies may apply.
- Keep Den Matchmaker staging and any other unreleased prototypes separate from current public-member data.

## Triage and response
1. Record request date, scope, and administrator handling it in a restricted ticket or approved private log.
2. Inspect only the minimum relevant records using approved read-only administrative access. Do not put member identifiers, token values, or sensitive screenshots into public GitHub issues, Canva designs, or ChatGPT.
3. Identify records and dependencies: Supabase Auth identity, weekly_selections, mission_reports, mission_progress, achievements, mission_internal.review_log, mission_internal.award_attempts, and any provider-held logs/backups. This is an inventory, not a deletion command.
4. Review retention, legal obligations, security needs, dispute history, and impacts of foreign keys/triggers before proposing alteration. Some reviewed records have protection triggers; do not bypass them.
5. Respond through the restricted ticket with what can be done, any limitation and an appropriate next step. Escalate uncertain legal or technical requests rather than promising immediate deletion.
6. Perform irreversible removal or database mutation **only after explicit administrator authorization**, an approved deletion procedure, and a validated backup/recovery plan if applicable. Never do a production bulk deletion to satisfy an unverified request.
7. Document completion or a reasoned limitation without disclosing more member data than necessary.

## Suggested acknowledgment text
“Thanks for reaching out to The Lioness Den support team. We can review privacy questions about the community tools we operate. Please tell us which feature you mean (for example, Den Missions, the Welcome Guide survey, or a Discord message). Please don't share passwords, login codes or sensitive personal information here. We'll review what information we control and explain the next steps.”

## Publication gates
- Official branded Gmail account identified and dedicated **Privacy Requests** Gmail label created (Nov 21). Before publication, confirm the owner accepts its public exposure, mailbox access and monitoring routine, and test reception and handling. #support tickets may be inaccessible to people who leave the server.
- Choose actual record-retention schedules for survey responses, Den Missions activity/audit records, and any backup data; implement and verify those schedules before claiming them.
- Verify Google Sites homepage embedded services and analytics behavior.
- Conduct legal/policy review appropriate to community reach and applicable jurisdictions.
- Only after approval, publish the policy and link it from Google Sites and the GitHub-hosted Welcome Guide and Den Missions pages.

## Source grounding
Current GitHub main code for the Welcome Guide, manual Squad Finder and Den Missions; production Den Missions Supabase schema, trigger/foreign-key metadata, and scheduled jobs; Lurkr/Discord project configuration previously checked with the user. No production data changes.
