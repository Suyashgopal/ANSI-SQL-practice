/*tables:

Contests
Colleges
Challenges
View_Stats
Submission_Stats

Need for every contest:

total submissions
accepted submissions
total views
unique views

Remove contests where all totals are zero.

## Output:
contest_id, hacker_id, name, totals...*/

SELECT 
    c.contest_id,
    c.hacker_id,
    c.name,

    SUM(ss.total_submissions),
    SUM(ss.total_accepted_submissions),
    SUM(vs.total_views),
    SUM(vs.total_unique_views)

FROM Contests c

JOIN Colleges co
ON c.contest_id = co.contest_id

JOIN Challenges ch
ON co.college_id = ch.college_id


LEFT JOIN
(
    SELECT 
        challenge_id,
        SUM(total_submissions) total_submissions,
        SUM(total_accepted_submissions) total_accepted_submissions
    FROM Submission_Stats
    GROUP BY challenge_id
) ss

ON ch.challenge_id = ss.challenge_id


LEFT JOIN
(
    SELECT
        challenge_id,
        SUM(total_views) total_views,
        SUM(total_unique_views) total_unique_views
    FROM View_Stats
    GROUP BY challenge_id
) vs

ON ch.challenge_id = vs.challenge_id


GROUP BY 
    c.contest_id,
    c.hacker_id,
    c.name

HAVING
    SUM(ss.total_submissions) +
    SUM(ss.total_accepted_submissions) +
    SUM(vs.total_views) +
    SUM(vs.total_unique_views) > 0

ORDER BY c.contest_id;