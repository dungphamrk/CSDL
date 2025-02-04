SELECT 
    s.subject_id,
    st.student_name,
    s.score
FROM 
    scores s
JOIN 
    students st ON s.student_id = st.student_id
WHERE 
    s.score = (
        SELECT MAX(score)
        FROM scores
        WHERE subject_id = s.subject_id
    );
