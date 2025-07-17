UPDATE raises
SET emp_id = 100, sal = 8001
    LOG ERRORS INTO errlog ('my_bad') REJECT LIMIT 10;