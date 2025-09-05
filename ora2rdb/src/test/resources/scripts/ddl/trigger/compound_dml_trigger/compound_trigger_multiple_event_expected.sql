 /*CREATE TRIGGER compounder [-unconvertible RS-228297 FOR
   UPDATE OR INSERT OR DELETE
   ON incremented_values]
    SQL SECURITY DEFINER
AS
COMPOUND TRIGGER
     DECLARE v_global_var   NUMERIC(34, 8) = 1;
   BEFORE STATEMENT
   IS
   BEGIN
      v_global_var = :v_global_var + 1;
   END
   BEFORE STATEMENT;
   BEFORE EACH ROW
   IS
   BEGIN
      v_global_var = :v_global_var + 1;
   END
   BEFORE EACH ROW;
   AFTER EACH ROW
   IS
   BEGIN
      v_global_var = :v_global_var + 1;
   END
   AFTER EACH ROW;
   AFTER STATEMENT
   IS
   BEGIN
      v_global_var = :v_global_var + 1;
   END
   AFTER STATEMENT;
END;*/