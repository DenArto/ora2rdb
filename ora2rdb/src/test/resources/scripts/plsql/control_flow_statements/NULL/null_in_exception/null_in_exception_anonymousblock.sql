BEGIN
  raise_application_error(-20134, 'Invalid number');
EXCEPTION
  WHEN OTHERS THEN NULL;
END;