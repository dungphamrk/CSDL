SELECT *
FROM students
WHERE student_id IN (
  SELECT student_id
  FROM Scores
  WHERE subject_id IN (
    SELECT subject_id
    FROM Scores
    WHERE student_id = 'A02'
  )
)
AND student_id NOT IN (
  SELECT student_id
  FROM Scores
  WHERE subject_id NOT IN (
    SELECT subject_id
    FROM Scores
    WHERE student_id = 'A02'
  )
);