SELECT DISTINCT s1.student_id
FROM Scores s1
WHERE s1.subject = 'csdl'
  AND s1.exam_round = 2
  AND s1.score > ALL (
      SELECT s2.score
      FROM Scores s2
      WHERE s2.subject = 'csdl'
        AND s2.exam_round = 1
        AND s2.student_id != s1.student_id
  );
