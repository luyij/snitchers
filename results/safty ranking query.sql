USE seattle_crime
GO
SELECT neighborhood, family_severity, RANK() OVER(ORDER BY family_severity) AS safety_rank
FROM
(SELECT _neighborhood_ AS neighborhood, SUM(_occurrence_ * _family_with_kids_severity__) as family_severity
FROM dbo.overViewWithWeight
WHERE _family_with_kids_severity__ != 'NA'
GROUP BY _neighborhood_) temp;
GO
SELECT neighborhood, elderly_severity, RANK() OVER(ORDER BY elderly_severity) AS safety_rank
FROM
(SELECT _neighborhood_ AS neighborhood, SUM(_occurrence_ * _elderly_severity__) as elderly_severity
FROM dbo.overViewWithWeight
WHERE _elderly_severity__ != 'NA'
GROUP BY _neighborhood_) temp;
GO
SELECT neighborhood, student_severity, RANK() OVER(ORDER BY student_severity) AS safety_rank
FROM
(SELECT _neighborhood_ AS neighborhood, SUM(_occurrence_ * _Student_severity__) as student_severity
FROM dbo.overViewWithWeight
WHERE _family_with_kids_severity__ != 'NA'
GROUP BY _neighborhood_) temp;