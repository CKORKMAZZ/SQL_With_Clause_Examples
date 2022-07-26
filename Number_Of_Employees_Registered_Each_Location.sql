WITH EMPLOYEE_LOCATION AS 
( 
SELECT 
    LOC.LOCATION_ID AS "LOCATIONS" 
FROM 
    HR.LOCATIONS LOC 
GROUP BY 
    LOC.LOCATION_ID 
) 
SELECT  
    EMP.LAST_NAME, 
    EMP.EMPLOYEE_ID 
FROM 
    HR.EMPLOYEES EMP, 
    HR.DEPARTMENTS DEPT, 
    HR.LOCATIONS LOC, 
    EMPLOYEE_LOCATION 
WHERE 
    (EMP.DEPARTMENT_ID)=(DEPT.DEPARTMENT_ID)  
    AND (DEPT.LOCATION_ID)=(LOC.LOCATION_ID) 
    AND (LOC.LOCATION_ID)=(LOCATIONS) 
