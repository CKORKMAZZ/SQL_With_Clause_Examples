WITH   
FUNCTION REVERSE_STRING(V_STR HR.EMPLOYEES.LAST_NAME%TYPE) RETURN VARCHAR2 IS  
    V_STR_REV VARCHAR2(20);   
   
BEGIN   
    FOR i IN 1..LENGTH(V_STR) LOOP  
        V_STR_REV := V_STR_REV||SUBSTR(V_STR,-i,1);   
    END LOOP;   
        RETURN V_STR_REV; 
    EXCEPTION 
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM); 
END REVERSE_STRING; 
     
SELECT   
    DEPT.DEPARTMENT_NAME AS "DEPTNAMES", 
    REVERSE_STRING(DEPARTMENT_NAME) AS "MODIFIED LETTER"   
FROM   
    HR.DEPARTMENTS DEPT,  
    HR.EMPLOYEES EMP  
WHERE  
    (EMP.DEPARTMENT_ID(+))=(DEPT.DEPARTMENT_ID)   
    AND (EMP.EMPLOYEE_ID IS NULL)    

--Without PL/SQL--

WITH DEPTNAMES AS
(

SELECT   
    DEPT.DEPARTMENT_NAME DEPTN
FROM   
    HR.DEPARTMENTS DEPT,  
    HR.EMPLOYEES EMP  
WHERE  
    (EMP.DEPARTMENT_ID(+))=(DEPT.DEPARTMENT_ID)   
    AND (EMP.EMPLOYEE_ID IS NULL) 

)

select DEPTN,
       replace(sys_connect_by_path(substr (DEPTN, level*-1, 1), '/'), '/') Reverse_String
       
from  DEPTNAMES
where  connect_by_isleaf = 1
connect by prior DEPTN = DEPTN          
           and prior sys_guid() is not null
           and level <= length(DEPTN);
