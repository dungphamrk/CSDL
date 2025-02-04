SELECT DISTINCT st.StudentID, st.StudentName, st.Department, sc.Score AS LiteratureScore
FROM Students st
JOIN Scores sc ON st.StudentID = sc.StudentID
WHERE sc.Subject = 'Literature'
  AND sc.Score > (
      SELECT MAX(sc2.Score)
      FROM Students st2
      JOIN Scores sc2 ON st2.StudentID = sc2.StudentID
      WHERE sc2.Subject = 'Literature'
  );
